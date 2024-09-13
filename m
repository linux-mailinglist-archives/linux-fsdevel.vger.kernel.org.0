Return-Path: <linux-fsdevel+bounces-29308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD01B977EE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 13:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D924F1C213E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 11:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F091A1D88BD;
	Fri, 13 Sep 2024 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpbFr/zD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE36BFB0;
	Fri, 13 Sep 2024 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228328; cv=none; b=t0CIXWQ4wk66XFZ9LOnkru8p8Vl2KBS38d4seNOp8SztqNJJHzVnkXlb910IeMAT9/lzHi7tQ3+iK7E218xFgXFGRlNXTIEa+2n42UawqQzGCRD8l4Qxu03vl1evJu8Culv74tvmN65O7zZNw7O0M6zZ5zFoFpUmBoVTB57wwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228328; c=relaxed/simple;
	bh=pH0uD+7HBwOh5eTZMe03O5cArkFkAGPctGU8f8vBBhM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=VFVo1xEsGCCXOUuqZQz5o0rJuaQeWhZN/UqqxpwFdktPIpF+ym4xkuYu61aFrwZtbhfVLwwJmC5e+KTIVxtECXVxpu//gmHw9Dw0Ebau3MDb95lcF/gYQaNGRPZ59LAG/Gd2nIX1ipcEoCxyii3r8xrC1/sP6y55THOi0OkRMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpbFr/zD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-206bd1c6ccdso7087875ad.3;
        Fri, 13 Sep 2024 04:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726228326; x=1726833126; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sob8ZyAlLc2TmYyT6x2UMmPapayvFYWFwxr8aqRvkfQ=;
        b=CpbFr/zDBIqhFWW7Z69VbOnEDnRFe2+78fiqRSP2gv3kNWvCJOKvn29JTy8qzliru0
         o2DoILRHqc13YdPT8i3Me1D4bEV4gEVT5z3cSPF5tLoYlbMOuDFFA+HUYY30fM6Rtfbt
         B7F0vNkEE6/M0tzvXI4qckT2G7AiFiBMRCECbf8dLD4XRVM1Hu3OzTtWQi0UUq8Kabog
         iaA2bv+GfcyvasNHN7JekbS4eW62p0KYHxz4487IMW2tUA+Yaz/aphS5t/fETlrkJKZw
         03kHsCooce0CnwzOBpeoM9dWlABGsCW/MpPnvvB2wUBQtEE6sig5A0c27wl1flYuFDmx
         KmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726228326; x=1726833126;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sob8ZyAlLc2TmYyT6x2UMmPapayvFYWFwxr8aqRvkfQ=;
        b=W15odQXizajxhv8bPlFWyhZPCqs56jYGIm6pXj2He2kUwRdNB3UAASndsF83SzqGKz
         i1jDv6doT4Az76AtE6OfSWiCnBpsjvazILHZRV7afFz6m93ARMf9LN5VaImoUSE9dDyz
         hsETVEb2j0JYZbIqlAjv3q+YpLqreZQMS6X/LQoyTaziQ0q8jY2BGdhpr+MKi5pJS6Tc
         kLnA1MuCEcLrupUx+DFSxLtA24KiMIQTdcp6/gHRAkC6afHTrBye9xUmTluCQ1NYfK4p
         AKlXc2LTXjVTnESwTtb+iBTIbBix5ljg93ihW8qoz4koi2OtZX4rhevEraSBAYgUL6rJ
         td7A==
X-Forwarded-Encrypted: i=1; AJvYcCWC23InmBofxakQITIoO6qQs8pPmaKyHjFt54itosXpimbe4gHuHonogr+z9PDzwIxE8Rv5ndxZaf1b@vger.kernel.org, AJvYcCWnRCyvEON4HIDQZksJb4Wz2puw8PIqCeMXB01icXvPfAp4tyReg/Fr2bvCHBnPI6UN88PT3ttAW6FANRPaMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzndiC/0p/M5mwYMQP7Hv7enYsdXdhboFAJlA+4be6m+aiJ7yEL
	LpxFelwmt87ypvv3he7CwMxUgqvtqFhG2XbB3EWVihJocmAMn3m2
X-Google-Smtp-Source: AGHT+IGwW7sNMJVsWGV4dapgZjjufbM3MBNUZH0nhhhQfOc2PmMt+rBVTvHvJd2K2ej4n0mMIetItQ==
X-Received: by 2002:a17:903:2291:b0:207:14a3:602c with SMTP id d9443c01a7336-20781d5f60bmr36570615ad.19.1726228325722;
        Fri, 13 Sep 2024 04:52:05 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af4739asm26977815ad.66.2024.09.13.04.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:52:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
Cc: linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, dchinner@redhat.com, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
In-Reply-To: <5831e24d-dd96-4bad-815f-b79da73f7634@oracle.com>
Date: Fri, 13 Sep 2024 16:24:52 +0530
Message-ID: <87h6aj4ydf.fsf@gmail.com>
References: <cover.1726034272.git.ojaswin@linux.ibm.com> <5831e24d-dd96-4bad-815f-b79da73f7634@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 11/09/2024 10:01, Ojaswin Mujoo wrote:
>> This patchset implements extsize hint feature for ext4. Posting this RFC to get
>> some early review comments on the design and implementation bits. This feature
>> is similar to what we have in XFS too with some differences.
>> 
>> extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
>> handling layer to do aligned allocations. We use allocation criteria 0
>> (CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
>> we try to align the logical start (m_lblk) and length(m_len) of the allocation
>> to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
>> sure that we get the aligned physical start (m_pblk) as well. So in this way
>> extsize can make sure that lblk, len and pblk all are aligned for the allocated
>> extent w.r.t extsize.
>> 
>> Note that extsize feature is just a hinting mechanism to ext4 multi-block
>> allocator. That means that if we are unable to get an aligned allocation for
>> some reason, than we drop this flag and continue with unaligned allocation to
>> serve the request. However when we will add atomic/untorn writes support, then
>> we will enforce the aligned allocation and can return -ENOSPC if aligned
>> allocation was not successful.
>
> A few questions/confirmations:
> - You have no intention of adding an equivalent of forcealign, right?

extsize is just a hinting mechanism that too only for __allocation__
path. But for atomic writes we do require some form of forcealign (like
how we have in XFS). So we could either call this directly as atomic
write feature or can may as well call this forcealign feature and make
atomic writes depend upon it, like how XFS is doing it.

I still haven't understood if there is/will be a user specifically for
forcealign other than atomic writes.

Since you asked, I am more curious to know if there is some more context
to your question?

>
> - Would you also plan on using FS_IOC_FS(GET/SET)XATTR interface for 
> enabling atomic writes on a per-inode basis?

Yes, that interface should indeed be kept same for EXT4 too.

>
> - Can extsize be set at mkfs time?

Good point. For now in this series, extsize can only be set using the
same ioctl on a per inode basis.

IIUC, XFS supports doing both right. We can do this on a per-inode basis
during ioctl or it also supports setting this during mkfs.xfs time.
(maybe xfsprogs only allows setting this at mkfs time for rtvolumes for now)

So if this is set during mkfs.xfs time and then by default all inodes will
have this extsize attribute value set right?

BTW, this brings me to another question that I had asked here too [1].
1. For XFS, atomic writes can only be enabled with a fresh mkfs.xfs -d
atomic-writes=1 right? 
2. For atomic writes to be enabled, we need all 3 features to be
enabled during mkfs.xfs time itself right?
i.e. 
"mkfs.xfs -i forcealign=1 -d extsize=16384 -d atomic-writes=1"

[1]: https://lore.kernel.org/linux-xfs/20240817094800.776408-1-john.g.garry@oracle.com/

>
> - Is there any userspace support for this series available?

Make sense to maybe provide a userspace support link too.
For now, a quick hack would be to just allow setting extsize hint for
other fileystems as well in xfs_io.

diff --git a/io/open.c b/io/open.c
index 15850b55..6407b7e8 100644
--- a/io/open.c
+++ b/io/open.c
@@ -980,7 +980,7 @@ open_init(void)
        extsize_cmd.args = _("[-D | -R] [extsize]");
        extsize_cmd.argmin = 0;
        extsize_cmd.argmax = -1;
-       extsize_cmd.flags = CMD_NOMAP_OK;
+       extsize_cmd.flags = CMD_NOMAP_OK | CMD_FOREIGN_OK;
        extsize_cmd.oneline =
                _("get/set preferred extent size (in bytes) for the open file");
        extsize_cmd.help = extsize_help;

<e.g>
/dev/loop6 on /mnt1/test type ext4 (rw,relatime)

root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -fc "extsize" /mnt1/test/f1
[0] /mnt1/test/f1
root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -c "extsize 16384" /mnt1/test/f1
root@qemu:~/xt/xfsprogs-dev# ./io/xfs_io -c "extsize" /mnt1/test/f1
[16384] /mnt1/test/f1


>
> - how would/could extsize interact with bigalloc?
>

As of now it is kept disabled with bigalloc.

+	if (sbi->s_cluster_ratio > 1) {
+		msg = "Can't use extsize hint with bigalloc";
+		err = -EINVAL;
+		goto error;
+	}


>> 
>> Comparison with XFS extsize feature -
>> =====================================
>> 1. extsize in XFS is a hint for aligning only the logical start and the lengh
>>     of the allocation v/s extsize on ext4 make sure the physical start of the
>>     extent gets aligned as well.
>
> note that forcealign with extsize aligns AG block also

Can you expand that on a bit. You mean during mkfs.xfs time we ensure
agblock boundaries are extsize aligned?

>
> only for atomic writes do we enforce the AG block is aligned to physical 
> block
>

If you could expand that a bit please? You meant during mkfs.xfs
time for atomic writes we ensure ag block start bounaries are extsize aligned?


>> 
>> 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
>>     hint. That means on XFS for eof allocations (with extsize hint) only logical
>>     start gets aligned. However extsize hint in ext4 for eof allocation is not
>>     supported in this version of the series.
>> 
>> 3. XFS allows extsize to be set on file with no extents but delayed data.
>>     However, ext4 don't allow that for simplicity. The user is expected to set
>>     it on a file before changing it's i_size.
>> 
>> 4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
>>     primarily would like to support atomic writes with extsize.
>> 
>> 5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
>>     inode field as it was simple and most flexible, since there might be more
>>     features like atomic/untorn writes coming in future.
>> 
>> 6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
>>     The same has been kept for EXT4 as well.
>> 
>> Some TODOs:
>> ===========
>> 1. EOF allocations support can be added and can be kept similar to XFS
>
> Note that EOF alignment for forcealign may change - it needs to be 
> discussed further.

Sure, thanks for pointing that out.
I guess you are referring to mainly the truncate related EOF alignment change
required with forcealign for XFS.

-ritesh

