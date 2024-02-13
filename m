Return-Path: <linux-fsdevel+bounces-11331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2758A852BFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68891F221E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4951BDC2;
	Tue, 13 Feb 2024 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE/eMZ9m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF251B971;
	Tue, 13 Feb 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815438; cv=none; b=F+FHarnfoGV56G2GWhT184FCgCSJishodlyTooGzEjaCBDPdD73BhqGLZNXirU3xurGf4pl3eigyvNeuZvL0JKrA1L6oR65+VnyzgJAbI6AAsJE1xms8hr6Pb5PN6rHWvNjl3HRgpbUTVUUebdOPCqgmZpYJuSBqOtiDcvycsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815438; c=relaxed/simple;
	bh=tU1izEN1R300M3GRjsbx3Ptb75JlUiW5CWuiqarnev0=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=CmgZ/5dOvzkxlS7PdjMeU7rnMozBIANxJy8ASCcbqbewvOvOxBmBxIo+eNzR1CwFlD3nLutF9BkqHYg60xATxXkCIL5RKEYuJyr+IZ91oA1pELzOEriKOZuW4v4GhLGgD/PaLMCxOiC6K59QLyVD1vhv6+PW/Jbu3mY1fWihLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE/eMZ9m; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso2492439b3a.1;
        Tue, 13 Feb 2024 01:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707815436; x=1708420236; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W1/O2QjCeIjREkCInLlmtuYFHINhFGizDhhNZ+7JUBQ=;
        b=TE/eMZ9mWVsdNEIq4TZcvdNMTVbB8yVs98qgNZWR9TUt624gh0idYSINbZZ1PQtPMW
         aAGfhowUanziPAdm189ryz6kE4wfTi5p6JD8H7XZela7nc+fKK6QWvw64DP3VcnDTolr
         Kv6sOVJFGf/TVeNk2hn9lBiIu3BdW5ocplk2oQGIpWrehSpCzKKyD7MeEKbj2xwcS9Xn
         y3Ze7Bf8NzE1uWN8NVkA+w95rfj2nVnDfuMzSZDRJv0Kgj0ScR8mB30o8cCgbOQoBiW9
         i9ISFxM7sJJBoWN7Cj97Skw66aVMEmB9GWKIYQn0EebODhFCjow6Cq3mbN6Ljln4On68
         NVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815436; x=1708420236;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1/O2QjCeIjREkCInLlmtuYFHINhFGizDhhNZ+7JUBQ=;
        b=H5CNacFj+tdAw3PlkznCgSR1L6Mo/7sTyLv8eaxrzeMKBpmCZ88HTm1roaWY5i3HCM
         t5yVeCzChe2Gk0twoNa7jw2NhbTQJVRJpHH6Wb1tuoTa79uAcpD/cT0CRW+W/3347awu
         F87GYewD6lMk+Qwo7yuXDw1cg3A3xNbRLnIhv/UW8p3lH3s28S/u50yzH5EsKsS8nOgm
         l38NW+9sEQW8Dva+6r89osaAj3jAz3/CNCT1eKlG3oQabgG75Xk0kfqf03COUqvf1IVk
         VpDAduFbzSPQAjYLPSteFYcP1r56D9Jz1W/PkANtu42/Alhyp2BcdGnqm+ZGQ/QeeyNJ
         DWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5FnKcaBPIcmLayf7N39FxPuMs6f2W4VPbLNqYUthcMkajyaNn7uR3Hr8AiyhS77hEu80FmZfCEd5Wu4t01hgc7vCHViaRnda/IDBfAL+5hz0gNFNplZtx8M4GNQ5jPB4qrJYExi7m/7m+MX2g2zICqXy8W2lnzeemTmb3WBT+CDto5Z0J+A==
X-Gm-Message-State: AOJu0YztV6lleTHVwM0Cj+HsGSr5L5dsQrWoQBDGcHQq8r7Ap5yZRg6x
	UbHcbn25IO1gVEzh38IrfXCFI5qePfqZmJcRSkW166hmjjBaKabw
X-Google-Smtp-Source: AGHT+IGat9zcEfbh7wFP8V0eWZQEkCCMSR9MkFJn/3a4Dii6KmWVG5zgviI+hT2Whj4qR1SjogI/Eg==
X-Received: by 2002:a05:6a21:3a87:b0:19e:9da4:1a10 with SMTP id zv7-20020a056a213a8700b0019e9da41a10mr2970622pzb.21.1707815436247;
        Tue, 13 Feb 2024 01:10:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXLgSrCUNLapaSsvzyiglcq5q2LrPXePcu8HJTHizask0YkkN964YKPndHwH/K0nGCRz4THtIq0YTf/2AE+KIxHKMlIyzrAZmMiPyMmILGMvqliGbLyrof8cAEdc/5eqR9ZAvOZJVZVfF2NsLvd0K5m2v1R5EKv/plf4sBosbfxZHs/kZsXO/8rAyxFYv9vIjGv8paofCTlbAKPKxC+u1Fo0t0limMLh35I0LXpEoPnrX+N4ydDNrAiocFzgjER198Q7V7aPZhsHnW0Yl/zQ1Qk2dmxSfFcUCU1NloKjUJPDYW+ju3Mwrd/Y4qI6X5h53P0UpgvVEjcYi0kp36Xl1/I67/zd2ydzfiWB0bPn2tNnTk+GHBIUMUE9M7GzCd74/BdMOjcBhueMXUe1mfHFsOPaRDxl28phiPJY0AHI38aKGvDiEesn1Rb
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id lm17-20020a056a003c9100b006e080d792acsm6797067pfb.184.2024.02.13.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:10:35 -0800 (PST)
Date: Tue, 13 Feb 2024 14:40:29 +0530
Message-Id: <87a5o4viey.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 0/6] block atomic writes for XFS
In-Reply-To: <875feb7e-7e2e-4f91-9b9b-ce4f74854648@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 13/02/2024 07:45, Ritesh Harjani (IBM) wrote:
>> John Garry <john.g.garry@oracle.com> writes:
>> 
>>> This series expands atomic write support to filesystems, specifically
>>> XFS. Since XFS rtvol supports extent alignment already, support will
>>> initially be added there. When XFS forcealign feature is merged, then we
>>> can similarly support atomic writes for a non-rtvol filesystem.
>>>
>>> Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.
>>>
>>> For XFS rtvol, support can be enabled through xfs_io command:
>>> $xfs_io -c "chattr +W" filename
>>> $xfs_io -c "lsattr -v" filename
>>> [realtime, atomic-writes] filename
>> 
>> Hi John,
>> 
>> I first took your block atomic write patch series [1] and then applied this
>> series on top. I also compiled xfsprogs with chattr atomic write support from [2].
>> 
>> [1]: https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/#m4ad28b480a8e12eb51467e17208d98ca50041ff2
>> [2]: https://github.com/johnpgarry/xfsprogs-dev/commits/atomicwrites/
>> 
>> 
>> But while setting +W attr, I see an Invalid argument error. Is there
>> anything I need to do first?
>> 
>> root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "chattr +W" /mnt1/test/f1
>> xfs_io: cannot set flags on /mnt1/test/f1: Invalid argument
>> 
>> root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "lsattr -v" /mnt1/test/f1
>> [realtime] /mnt1/test/f1
>
> Can you provide your full steps?
>
> I'm doing something like:
>
> # /mkfs.xfs -r rtdev=/dev/sdb,extsize=16k -d rtinherit=1 /dev/sda
> meta-data=/dev/sda               isize=512    agcount=4, agsize=22400 blks
>           =                       sectsz=512   attr=2, projid32bit=1
>           =                       crc=1        finobt=1, sparse=1, rmapbt=0
>           =                       reflink=0    bigtime=1 inobtcount=1 
> nrext64=0
> data     =                       bsize=4096   blocks=89600, imaxpct=25
>           =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =internal log           bsize=4096   blocks=16384, version=2
>           =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =/dev/sdb               extsz=16384  blocks=89600, rtextents=22400
> # mount /dev/sda mnt -o rtdev=/dev/sdb
> [    5.553482] XFS (sda): EXPERIMENTAL atomic writes feature in use. Use 
> at your own risk!

My bad, I missed to see your xfsprogs change involve setting this
feature flag as well during mkfs time itself. I wasn't using the right
mkfs utility.


> [    5.556752] XFS (sda): Mounting V5 Filesystem 
> 6e0820e6-4d44-4c3e-89f2-21b4d4480f88
> [    5.602315] XFS (sda): Ending clean mount
> #
> # touch mnt/file
> # /xfs_io -c "lsattr -v" mnt/file
> [realtime] mnt/file
> #
> #
> # /xfs_io -c "chattr +W" mnt/file
> # /xfs_io -c "lsattr -v" mnt/file
> [realtime, atomic-writes] mnt/file
>

Yup, this seems to work fine. Thanks!

> And then we can check limits:
>
> # /test-statx -a /root/mnt/file
> dump_statx results=9fff
>    Size: 0               Blocks: 0          IO Block: 16384   regular file
> Device: 08:00           Inode: 131         Links: 1
> Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
> Access: 2024-02-13 08:31:51.962900974+0000
> Modify: 2024-02-13 08:31:51.962900974+0000
> Change: 2024-02-13 08:31:51.969900974+0000
>   Birth: 2024-02-13 08:31:51.962900974+0000
> stx_attributes_mask=0x603070
>          STATX_ATTR_WRITE_ATOMIC set
>          unit min: 4096
>          unit max: 16384
>          segments max: 1
> Attributes: 0000000000400000 (........ ........ ........ ........ 
> ........ .?-..... ..--.... .---....)
> #
> #
>
> Does xfs_io have a statx function? If so, I can add support for atomic 
> writes for statx there. In the meantime, that test-statx code is also on 
> my branch, and can be run on the block device file (to sanity check that 
> the rtvol device supports atomic writes).
>
> Thanks,
> John

