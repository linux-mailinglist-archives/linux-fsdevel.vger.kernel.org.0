Return-Path: <linux-fsdevel+bounces-56555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 970AAB192E0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 07:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2777D3BBE06
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 05:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741F225417;
	Sun,  3 Aug 2025 05:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKAbUNQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE441917FB;
	Sun,  3 Aug 2025 05:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754199538; cv=none; b=SREXuX/VkHN9S/6hglw2OYrLuNjL/GMJ4Oe0AP7a+b9nSVuYvrjGp7cNYHutIupicyngUXbydvGkBfoSVs20G7pKVNafTlzubXewV+923Luu6sz1mQS7TTVJDeWFDc+eTy/hkOqXcHvoJ0nmKPXppTZgAApqmufpNlD/bPLkH0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754199538; c=relaxed/simple;
	bh=W9TTyWGs1q2BZhLwkdfFdq0dLqTBJ9IqGNsWQ4BNynk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Qm06dvv4+BBOd6tvJHaDnamRUy/kMUqRuhREoCH+Yy8E3h96UB9LFnQJciAuLCGISya7wqs54zCTaKWCKyXpK4/He5o5Zphs8xqHU4RKyice0VNTNkU4dQQoBiDjre+/VcfmPNbBRiHFNAvkPlwZdQLO4UsDM1ejoRCKXz2Dr+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKAbUNQL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76aea119891so4023708b3a.1;
        Sat, 02 Aug 2025 22:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754199536; x=1754804336; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NVpBhuZ96L+Fro8BPUL7qY4FAsCSj97IVu5e+UaR5SI=;
        b=GKAbUNQLn9IqyuLadRWgM1lOiIPQIZJavEoL5EOFm6JDaDA19SiUQX5NA63Jn/fKNG
         9M77V6a53Qr1nkxUcHqug52uaKdFM3WxtT3XpXvCKIeErVRj5OW3WxjtT0KzxLrDk/sz
         nYrnOysAXszBfJncoAGbF92Egnuv70zodzQ8n+M5EH7MHuW+LjxCTGGfaPybZu7s7GyD
         Hl/nP+bnohHzi7uIYM3bucIiwPrVSZFUIkSy68afddFYiFungle8AH5g4k9LqMog7ygd
         W7LNOiOTNPkkSv5a+Yx7V95SKGMxTCZcsZ+zOevuO1GVa631sOBaPJD05+h5xUmX5q30
         UJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754199536; x=1754804336;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVpBhuZ96L+Fro8BPUL7qY4FAsCSj97IVu5e+UaR5SI=;
        b=Nc8Lq4ccR+jj9H7+7HyGbuCiq2bRR34MFCS36XwBWZR0ECvHciDugfP79/QMsfoT3f
         svrpkCVzNp5fs/IzmwhpzNknOQdpHmXVdtPDP6R0OVwwEC3qjVBUgE6/NdBGs5jEMqv2
         n4zBpmpRfimNZaRokvzXbq7homCrX/olYj9o/vyQIckCUUhxbY4GkWbzDAJLBdWt9DNO
         YwPpCktghgAQ9Uga+pqrVNIo+fyPmr2xq847zZ4Qb1Jz7hPQL43vi0h/ALI3pEBgAkW8
         0xoEKYidP1WWy/FmzCYFlT7noGhnVneYmUDBZPtqKvFtCpBCuV63vdJPcTP8VUEDCB3a
         6T+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXifDbb4XgbfHrI6vtpsFC6NviJvc9izt1rclpzKMpgMgteZzpT5axTtdGWFW4BIMHfsUW5kDy8FCsRfZXI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9M4l0X/aNXbLzuOuFqv+TOFebZfs6YR990tGzlKmVwhZj2H5Z
	gDrlDD8YDv9RCI6GTWHRNKfydpzzJ/kT4goD2VsAt50/9C6I4JM0tpXw
X-Gm-Gg: ASbGncvNqYaiE9ZFpXStKG2e2md73gs0zShzST8G0IyGlS1dD2/gbuhkouS6jdNNOND
	2XODiOxe5KqDhNkl3gkTFDesDTUP+jFIv+JmJcIfFR77W6ZzeaItFkrKfMXCctIt6ZWjFdgbplP
	eSs3xIGul2l0o4ubkY17gbSDn4xg/EJ3T4yMbUzOe4A6VgI7DQ1I7AJn4qmX8szMyE3yKXO5Vy5
	eQVZzdXGM9kIB4PUJ9bCk2G+qRV7X3l3vC6zyObUowiobkACYrAzlsSmlBX0tNWQpfO/2uR7lDz
	dVeH3hA+YBanAO8ckCJVgGjpm1D7NRl6vbaUIvTKzPNDxf8hbPreFuqkDtl2I5YqmbBFQ/kkgKS
	F0pTk8QQ+4+4L2OmzzLPAk6TxjQ==
X-Google-Smtp-Source: AGHT+IGMrCXQA4XQIYqdtJ3XkKjlUl1VECW3D92BcLK0+Fy/6NdSANbtW+bkEpp810mWlK5oXAXXRw==
X-Received: by 2002:a05:6a20:958f:b0:234:4f73:e657 with SMTP id adf61e73a8af0-23dd7929619mr21536940637.0.1754199536418;
        Sat, 02 Aug 2025 22:38:56 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bac16c9sm6654608a12.36.2025.08.02.22.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 22:38:55 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/2] generic: Add integrity tests for O_DSYNC and RWF_DSYNC writes
In-Reply-To: <20250802081719.qrmme5jvwliwlgcg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Sun, 03 Aug 2025 10:53:27 +0530
Message-ID: <87o6sxq8q8.fsf@gmail.com>
References: <28abb8a0c4031ce07b475bf9026eedc23892868b.1753964363.git.ritesh.list@gmail.com> <9b2427b42e8716c359a36624fd6363f71583941b.1753964363.git.ritesh.list@gmail.com> <20250801201805.6h7sa2oyrvhnalph@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com> <87plderdk1.fsf@gmail.com> <20250802081719.qrmme5jvwliwlgcg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Zorro Lang <zlang@redhat.com> writes:

> On Sat, Aug 02, 2025 at 01:59:18AM +0530, Ritesh Harjani wrote:
>> Zorro Lang <zlang@redhat.com> writes:
>> 
>> > On Thu, Jul 31, 2025 at 06:05:55PM +0530, Ritesh Harjani (IBM) wrote:
>> >> This test verifies the data & required metadata (e.g. inode i_size for extending
>> >> writes) integrity when using O_DSYNC and RWF_DSYNC during writes operations,
>> >> across buffered-io, aio-dio and dio, in the event of a sudden filesystem
>> >> shutdown after write completion.
>> >> 
>> >> Man page of open says that -
>> >> O_DSYNC provides synchronized I/O data integrity completion, meaning
>> >> write operations will flush data to the underlying hardware, but will
>> >> only flush metadata updates that are required to allow a subsequent read
>> >> operation to complete successfully.
>> >> 
>> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> >> ---
>> >>  tests/generic/737     | 30 +++++++++++++++++++++++++++++-
>> >>  tests/generic/737.out | 21 +++++++++++++++++++++
>
> BTW, as you change a testcase with known case number, your subject can be
> "generic/737: ..." (instead of "generic: ...").
>

Make sense. I will fix in v2.

>> >>  2 files changed, 50 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/tests/generic/737 b/tests/generic/737
>> >> index 99ca1f39..0f27c82b 100755
>> >> --- a/tests/generic/737
>> >> +++ b/tests/generic/737
>> >> @@ -4,7 +4,8 @@
>> >>  #
>> >>  # FS QA Test No. 737
>> >>  #
>> >> -# Integrity test for O_SYNC with buff-io, dio, aio-dio with sudden shutdown.
>> >> +# Integrity test for O_[D]SYNC and/or RWF_DSYNC with buff-io, dio, aio-dio with
>> >> +# sudden shutdown.
>> >>  # Based on a testcase reported by Gao Xiang <hsiangkao@linux.alibaba.com>
>> >>  #
>> >> 
>> >> @@ -21,6 +22,15 @@ _require_aiodio aio-dio-write-verify
>> >>  _scratch_mkfs > $seqres.full 2>&1
>> >>  _scratch_mount
>> >> 
>> >> +echo "T-0: Create a 1M file using buff-io & RWF_DSYNC"
>> >> +$XFS_IO_PROG -f -c "pwrite -V 1 -D -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>> >> +echo "T-0: Shutdown the fs suddenly"
>> >> +_scratch_shutdown
>> >> +echo "T-0: Cycle mount"
>> >> +_scratch_cycle_mount
>> >> +echo "T-0: File contents after cycle mount"
>> >> +_hexdump $SCRATCH_MNT/testfile.t1
>> >> +
>> >>  echo "T-1: Create a 1M file using buff-io & O_SYNC"
>> >>  $XFS_IO_PROG -fs -c "pwrite -S 0x5a 0 1M" $SCRATCH_MNT/testfile.t1 > /dev/null 2>&1
>> >>  echo "T-1: Shutdown the fs suddenly"
>> >> @@ -48,5 +58,23 @@ _scratch_cycle_mount
>> >>  echo "T-3: File contents after cycle mount"
>> >>  _hexdump $SCRATCH_MNT/testfile.t3
>> >> 
>> >> +echo "T-4: Create a 1M file using DIO & RWF_DSYNC"
>> >> +$XFS_IO_PROG -fdc "pwrite -V 1 -S 0x5a -D 0 1M" $SCRATCH_MNT/testfile.t4 > /dev/null 2>&1
>> >> +echo "T-4: Shutdown the fs suddenly"
>> >> +_scratch_shutdown
>> >> +echo "T-4: Cycle mount"
>> >> +_scratch_cycle_mount
>> >> +echo "T-4: File contents after cycle mount"
>> >> +_hexdump $SCRATCH_MNT/testfile.t4
>> >> +
>> >> +echo "T-5: Create a 1M file using AIO-DIO & O_DSYNC"
>> >> +$AIO_TEST -a size=1048576 -D -N $SCRATCH_MNT/testfile.t5 > /dev/null 2>&1
>> >> +echo "T-5: Shutdown the fs suddenly"
>> >> +_scratch_shutdown
>> >> +echo "T-5: Cycle mount"
>> >> +_scratch_cycle_mount
>> >> +echo "T-5: File contents after cycle mount"
>> >> +_hexdump $SCRATCH_MNT/testfile.t5
>> >
>> > I always hit "No such file or directory" [1], is this an expected test failure
>> > which you hope to uncover?
>> 
>> Yes, we will need this fix [1] from Jan. Sorry I missed to add that in the commit
>> message. Could you please give it a try with the fix maybe?
>
> Sure, with this patch, this test passed on my side:
>   FSTYP         -- xfs (debug)
>   PLATFORM      -- Linux/x86_64 dell-per750-41 6.16.0-mainline+ #9 SMP PREEMPT_DYNAMIC Sat Aug  2 16:01:22 CST 2025
>   MKFS_OPTIONS  -- -f /dev/mapper/testvg-scratch--devA
>   MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/mapper/testvg-scratch--devA /mnt/scratch
>
>   generic/737 4s ...  9s
>   Ran: generic/737
>   Passed all 1 tests
>
> So this "No such file or directory" failure is a known bug, and this patch trys to
> uncover it. You didn't metion that, so I thought you just try to write a
> new integrity test (rather than a regression test) :-D

Your understanding is correct. Sorry, I missed to add the fix details.
I posted the test before the fix got merged. But yes, I will add the
necessary details in v2.

> If this change uncover a known fix, please feel free to add _fixed_by_kernel_commit.

The commit isn't yet showing up in the VFS tree. Once it gets in I will
share the v2 with the following changes.

diff --git a/tests/generic/737 b/tests/generic/737
index 0f27c82b..a51e9623 100755
--- a/tests/generic/737
+++ b/tests/generic/737
@@ -18,6 +18,9 @@ _require_aiodio aio-dio-write-verify

 [[ "$FSTYP" =~ ext[0-9]+ ]] && _fixed_by_kernel_commit 91562895f803 \
        "ext4: properly sync file size update after O_SYNC direct IO"
+# which is further fixed by
+_fixed_by_kernel_commit 16f206eebbf8 \
+       "iomap: Fix broken data integrity guarantees for O_SYNC writes"

 _scratch_mkfs > $seqres.full 2>&1
 _scratch_mount


> BTW, I saw you mark this patchset with "RFC", do you need to change it more?
> Generally I won't merge RFC patches directly, although this patch looks good to
> me. So when you think you've gotten enough review points, please feel free to
> remove the "RFC" label and resend it :) Then ...
>

Right. I will drop RFC and will resend it with above mentioned points
(once the fix appears in VFS tree).

> Reviewed-by: Zorro Lang <zlang@redhat.com>
>

Thanks!

-ritesh

> Thanks,
> Zorro
>

