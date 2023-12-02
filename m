Return-Path: <linux-fsdevel+bounces-4675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1CE801B7F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E73A1C2092D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75612B84
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 08:30:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90FE5116;
	Sat,  2 Dec 2023 00:02:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A0281FB;
	Sat,  2 Dec 2023 00:02:52 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96FA23F6C4;
	Sat,  2 Dec 2023 00:02:02 -0800 (PST)
Message-ID: <69a197cf-1e2c-4f6e-b0ca-7cbb154c044b@arm.com>
Date: Sat, 2 Dec 2023 08:02:01 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-GB
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com,
 peterx@redhat.com, david@redhat.com, hughd@google.com, mhocko@suse.com,
 axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
 Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
 bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
 jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com
References: <20231121171643.3719880-1-surenb@google.com>
 <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
 <CAJuCfpH8-jsxBRiLeLGWOFYnFE2iuSPfsveZkRf=MYZ6d=G7QA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAJuCfpH8-jsxBRiLeLGWOFYnFE2iuSPfsveZkRf=MYZ6d=G7QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/12/2023 16:26, Suren Baghdasaryan wrote:
> On Fri, Dec 1, 2023 at 1:29 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
>>> Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
>>> into destination buffer while checking the contents of both after
>>> the move. After the operation the content of the destination buffer
>>> should match the original source buffer's content while the source
>>> buffer should be zeroed. Separate tests are designed for PMD aligned and
>>> unaligned cases because they utilize different code paths in the kernel.
>>>
>>> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>>> ---
>>>  tools/testing/selftests/mm/uffd-common.c     |  24 +++
>>>  tools/testing/selftests/mm/uffd-common.h     |   1 +
>>>  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
>>>  3 files changed, 214 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
>>> index fb3bbc77fd00..b0ac0ec2356d 100644
>>> --- a/tools/testing/selftests/mm/uffd-common.c
>>> +++ b/tools/testing/selftests/mm/uffd-common.c
>>> @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
>>>       return __copy_page(ufd, offset, false, wp);
>>>  }
>>>
>>> +int move_page(int ufd, unsigned long offset, unsigned long len)
>>> +{
>>> +     struct uffdio_move uffdio_move;
>>> +
>>> +     if (offset + len > nr_pages * page_size)
>>> +             err("unexpected offset %lu and length %lu\n", offset, len);
>>> +     uffdio_move.dst = (unsigned long) area_dst + offset;
>>> +     uffdio_move.src = (unsigned long) area_src + offset;
>>> +     uffdio_move.len = len;
>>> +     uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>>> +     uffdio_move.move = 0;
>>> +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>>> +             /* real retval in uffdio_move.move */
>>> +             if (uffdio_move.move != -EEXIST)
>>> +                     err("UFFDIO_MOVE error: %"PRId64,
>>> +                         (int64_t)uffdio_move.move);
>>
>> Hi Suren,
>>
>> FYI this error is triggering in mm-unstable (715b67adf4c8):
>>
>> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=16,
>> @uffd-common.c:648)
>>
>> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, but
>> happy to go deeper if you can direct.
> 
> Hi Ryan,
> Thanks for reporting! Could you please share your kernel config file?

It's arm64 defconfig (so 4K base pages) plus:

# Squashfs for snaps, xfs for large file folios.
./scripts/config --enable CONFIG_SQUASHFS_LZ4
./scripts/config --enable CONFIG_SQUASHFS_LZO
./scripts/config --enable CONFIG_SQUASHFS_XZ
./scripts/config --enable CONFIG_SQUASHFS_ZSTD
./scripts/config --enable CONFIG_XFS_FS

# Useful trace features (on for Ubuntu configs).
./scripts/config --enable CONFIG_FTRACE
./scripts/config --enable CONFIG_FUNCTION_TRACER
./scripts/config --enable CONFIG_KPROBES
./scripts/config --enable CONFIG_HIST_TRIGGERS
./scripts/config --enable CONFIG_FTRACE_SYSCALLS

# For general mm debug.
./scripts/config --enable CONFIG_DEBUG_VM
./scripts/config --enable CONFIG_DEBUG_VM_MAPLE_TREE
./scripts/config --enable CONFIG_DEBUG_VM_RB
./scripts/config --enable CONFIG_DEBUG_VM_PGFLAGS
./scripts/config --enable CONFIG_DEBUG_VM_PGTABLE
./scripts/config --enable CONFIG_PAGE_TABLE_CHECK

# For mm selftests.
./scripts/config --enable CONFIG_USERFAULTFD
./scripts/config --enable CONFIG_TEST_VMALLOC
./scripts/config --enable CONFIG_GUP_TEST

This is the config I always use when running mm selftests. I'll send you the
config file separately.

Then I'm running in a QEMU VM with 12G RAM, equally split across 2 (emulated)
numa nodes. I have these pertinent kernel command line args (intended to ensure
all the mm selftests can run):

transparent_hugepage=madvise secretmem.enable hugepagesz=1G hugepages=0:2,1:2
hugepagesz=32M hugepages=0:2,1:2 default_hugepagesz=2M hugepages=0:64,1:64
hugepagesz=64K hugepages=0:2,1:2


> 
> There are several places UFFDIO_MOVE returns EBUSY: 4 places in
> move_pages_huge_pmd(), 2 places in move_present_pte(), 2 places in
> move_pages_pte() and once in move_swap_pte(). While I'm trying to
> reproduce, it would be useful if you could check which place is
> triggering the error.

Happy to, but will have to wait for Monday. I should say, the test fails
consistently for me. But sometimes the failure is EAGAIN (11). Most of the time
it is EBUSY though and I haven't figured out what causes the difference.

> Thanks,
> Suren.
> 
>>
>> Thanks,
>> Ryan
>>
>>
>>> +             wake_range(ufd, uffdio_move.dst, len);
>>> +     } else if (uffdio_move.move != len) {
>>> +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
>>> +     } else
>>> +             return 1;
>>> +     return 0;
>>> +}
>>
>> --
>> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>>


