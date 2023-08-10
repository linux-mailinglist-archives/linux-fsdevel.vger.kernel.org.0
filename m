Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE1777CC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Aug 2023 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjHJPxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbjHJPxl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:53:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5573A1994;
        Thu, 10 Aug 2023 08:53:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F86D75;
        Thu, 10 Aug 2023 08:54:22 -0700 (PDT)
Received: from [10.1.27.169] (XHFQ2J9959.cambridge.arm.com [10.1.27.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A0653F6C4;
        Thu, 10 Aug 2023 08:53:35 -0700 (PDT)
Message-ID: <8fbb5965-28f7-4e9a-ac04-1406ed8fc2d4@arm.com>
Date:   Thu, 10 Aug 2023 16:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable fix] mm: userfaultfd: check for start + len
 overflow in validate_range: fix
Content-Language: en-GB
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Yu Zhao <yuzhao@google.com>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
References: <20230714182932.2608735-1-axelrasmussen@google.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230714182932.2608735-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14/07/2023 19:29, Axel Rasmussen wrote:
> This commit removed an extra check for zero-length ranges, and folded it
> into the common validate_range() helper used by all UFFD ioctls.
> 
> It failed to notice though that UFFDIO_COPY *only* called validate_range
> on the dst range, not the src range. So removing this check actually let
> us proceed with zero-length source ranges, eventually hitting a BUG
> further down in the call stack.
> 
> The correct fix seems clear: call validate_range() on the src range too.
> 
> Other ioctls are not affected by this, as they only have one range, not
> two (src + dst).
> 
> Reported-by: syzbot+42309678e0bc7b32f8e9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=42309678e0bc7b32f8e9
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 53a7220c4679..36d233759233 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1759,6 +1759,9 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
>  			   sizeof(uffdio_copy)-sizeof(__s64)))
>  		goto out;
>  
> +	ret = validate_range(ctx->mm, uffdio_copy.src, uffdio_copy.len);
> +	if (ret)
> +		goto out;
>  	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
>  	if (ret)
>  		goto out;


Hi Axel,

I've just noticed that this patch, now in mm-unstable, regresses the mkdirty mm
selftest:

# [INFO] detected THP size: 2048 KiB
TAP version 13
1..6
# [INFO] PTRACE write access
ok 1 SIGSEGV generated, page not modified
# [INFO] PTRACE write access to THP
ok 2 SIGSEGV generated, page not modified
# [INFO] Page migration
ok 3 SIGSEGV generated, page not modified
# [INFO] Page migration of THP
ok 4 SIGSEGV generated, page not modified
# [INFO] PTE-mapping a THP
ok 5 SIGSEGV generated, page not modified
# [INFO] UFFDIO_COPY
not ok 6 UFFDIO_COPY failed
Bail out! 1 out of 6 tests failed
# Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0

Whereas all 6 tests pass against v6.5-rc4.

I'm afraid I don't know the test well and haven't looked at what the issue might
be, but noticed and thought I should point it out.

bisect log:

git bisect start
# bad: [ad3232df3e410acc2229c9195479c5596c1d1f96] mm/memory_hotplug: embed
vmem_altmap details in memory block
git bisect bad ad3232df3e410acc2229c9195479c5596c1d1f96
# good: [5d0c230f1de8c7515b6567d9afba1f196fb4e2f4] Linux 6.5-rc4
git bisect good 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
# bad: [aa5712770e3f0edb31ae879cd6452d5c2111d4fb] mm: fix obsolete function name
above debug_pagealloc_enabled_static()
git bisect bad aa5712770e3f0edb31ae879cd6452d5c2111d4fb
# bad: [bef1ff8723df303a06cdaffe64d95db2f7e7d4f6] mm: userfaultfd: support
UFFDIO_POISON for hugetlbfs
git bisect bad bef1ff8723df303a06cdaffe64d95db2f7e7d4f6
# good: [4f4469463e8571012d2602b39f14ed3e3dbd972a] selftests/mm: add gup test
matrix in run_vmtests.sh
git bisect good 4f4469463e8571012d2602b39f14ed3e3dbd972a
# good: [5c0d69839ef4f560679919f3483a592741df74f8] memcg: drop kmem.limit_in_bytes
git bisect good 5c0d69839ef4f560679919f3483a592741df74f8
# good: [b75f155a299729dc62de0ce6a9400d076298aa4c] mm: compaction: skip the
memory hole rapidly when isolating free pages
git bisect good b75f155a299729dc62de0ce6a9400d076298aa4c
# good: [12b13121d9f4487301dd9fb765265b642b2f6d5d] mm/memcg: minor cleanup for
MEM_CGROUP_ID_MAX
git bisect good 12b13121d9f4487301dd9fb765265b642b2f6d5d
# bad: [c9c368e75919c105aae072896e58d0ad4639e505] mm: userfaultfd: check for
start + len overflow in validate_range: fix
git bisect bad c9c368e75919c105aae072896e58d0ad4639e505
# good: [9e707995021bbdfc67ad83a985f7796bba580bed]
mm-make-pte_marker_swapin_error-more-general-fix
git bisect good 9e707995021bbdfc67ad83a985f7796bba580bed
# good: [46b66377b696c43c89ed4b1cb3f56b64e8fd475b] mm: userfaultfd: check for
start + len overflow in validate_range
git bisect good 46b66377b696c43c89ed4b1cb3f56b64e8fd475b
# first bad commit: [c9c368e75919c105aae072896e58d0ad4639e505] mm: userfaultfd:
check for start + len overflow in validate_range: fix

Thanks,
Ryan

