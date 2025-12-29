Return-Path: <linux-fsdevel+bounces-72189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3055CCE71A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 15:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13F23051EA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4309B321442;
	Mon, 29 Dec 2025 14:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly7H3S/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96AC1624C6
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767018864; cv=none; b=HyPIqd5TXPHiOIQze47tlTnXZqbqxvJ6yAGzABT61T2omt6GYrewvYJkJeEzzEOuJ+pQMY8LRaS9x0anggFqj6pQ9L+1pcuxaYNziNKLOFvc+hSSv2h92VDspexYIV3k2hEjz0CjDljjygGIeuAwfEM7hMgdgs8KnPthA2tP2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767018864; c=relaxed/simple;
	bh=dA8Hg9GblVRXBX7B1PHpAdr8ny3+vnqsd5VBChSuqog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTHlZy6nbEpEJbw7eoygqp7pPCf8IPuG4JgRVbSSBIIX76zmOkkzDlVI8uKYq3wBzuVFRQfmZlWFOjtoocOTGide0ETVLPnqFwVpx33HdTZ9u8WX5Wy7q0yjoDgi7r7gnuuLZeSXP/vFqMqMpceygNmBN9ZaprachsEdbOcYppM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly7H3S/Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64baaa754c6so9697831a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 06:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767018861; x=1767623661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OVfnZ6hclQ5OPvGA4jCZCMMxlNl/05g1VRvSIxd9aA=;
        b=Ly7H3S/ZPPY4fqFMoljLjZEXILQvF2PfBN61V833xy/HPNMXnKReEEGHhfu2Tr4r98
         z+5OPUhMCmsTkSfLu4a1JeRIYx6jg51uqEWdLhgSGKi4i+PBfg9dzgP04G7X87k3KFRE
         nzKrVwq13SVRyDVYT9EL7hi2SPzuvV8lIaQ6D1cvYAd0GzvJpG+AGnG4a6m0OGTgeIFv
         ji2JgarO1wU+7tB87YpqbPqV/b30goTCjWMtI8YIQuQ8HzjFH3aCBlMwS4Q9gkx1UrDN
         CWlP3kUQwsRqaWH4f+cMHNDA59NAUEELc5R05WdrwDjDH3yHD6J0DflvvraVVCLw85O2
         j2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767018861; x=1767623661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1OVfnZ6hclQ5OPvGA4jCZCMMxlNl/05g1VRvSIxd9aA=;
        b=FVrMxuW4N7iER+tGQZDhidYGIInASv3XiK2SAgR2wOgAdahaV3kyh+i9N3UOf1TphR
         OErb9zUdpohgZatOVLQnC5NUFBazC5cHIekxC0XGn1enH/Bm4F1aCQ6t47f1fmmtt3vT
         Yu5PdkYk8gdmyA2IBYwXaK199HXutnfaSjDcG3OLegfXwmv4qWehZQKwLmBlGtxlpKH5
         o+xWwXZdHgcfKoMfCdBltHBfkH/+bkaU/2Cpt5I+B3fScH1wFjD6hQkdjZbfsld8PPD5
         OXA+znlXIqttDH/OxTVvfxMb+5Rs3WoY5Dc4lBC/A5rSqteBCPziw7G3mEFPOheQREGG
         IzHA==
X-Forwarded-Encrypted: i=1; AJvYcCXnnxXhf5RZxtiHqpbHrVR0RPEIXbdJcRnj50Y72l++Bajkv6YeK0EHrTebUxhlPQXxFjEwOCr27P9dQLxX@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRahixPyjLahMD1R7+w7p3e62ZbKSn1FbhtruD6JwaxnjT3x8
	j0agBe0HBIGugMQvIlX7HeuBuoFRlYtLoftxkLvKJ6I6Qitjyh74BY/swyLTjjuVqUDGm0tMDcZ
	PkomLSSQikcvy3ACvpTVIE9YSnUqYrmQ=
X-Gm-Gg: AY/fxX5K7okjpzEfrFecrjp09PAi+WMPEJmE5DqU6zj5P5GjFIKvUVXjhJgi9cFfBuX
	JOomwEC+ipBC5Di2ftKM4LJDlSzM0TOwCvMjzSXIWIOn0QejOp7ISEhyTJHg1d73N1wSZMjyYkT
	MbXWzO52tmUyS3TmKqUDgFP6YvTpwPFDlfrw5rL3LqhlQRiMwYtovwuMvisyUgrfQ7bAEBJKWgL
	xL2/x5bYzlyT1EhDSNJd1ieQWj6sR7lcvExWOQ6oWu6Ij81HJo8grtllSZtnpbo2i8JUQONAW1N
	5CYrzJZhTunlqVhV76D6C4FRApZN7A==
X-Google-Smtp-Source: AGHT+IE4B772OE6WLCksyuHZsqkBv1jiwJvQCseppQGOxL5wZVA8BRVOKWLTKKqgFDtp7VnmWY2f3fA1akt/L+T+c0M=
X-Received: by 2002:a17:907:94cf:b0:b7d:1a23:81a0 with SMTP id
 a640c23a62f3a-b8037297276mr2862652966b.63.1767018860657; Mon, 29 Dec 2025
 06:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org>
In-Reply-To: <20251229105932.11360-1-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 29 Dec 2025 15:34:09 +0100
X-Gm-Features: AQt7F2pqHxpeITEEQtZLOdG6gapi_u83gbesMmtnYOVfS2kGvQNnt410AC_i_2M
Message-ID: <CAOQ4uxgSJXrQ5YEzEZrP5yFobzcHBShwSUX9DvHsmex0w-d5uQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] ntfs filesystem remake
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 2:45=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.org>=
 wrote:
>
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The NTFS filesystem[1] still remains the default filesystem for Windows
> and The well-maintained NTFS driver in the Linux kernel enhances
> interoperability with Windows devices, making it easier for Linux users
> to work with NTFS-formatted drives. Currently, ntfs support in Linux was
> the long-neglected NTFS Classic (read-only), which has been removed from
> the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
> many problems and is poorly maintained, so users and distributions are
> still using the old legacy ntfs-3g.
>
> The remade ntfs is an implementation that supports write and the essentia=
l
> requirements(iomap, no buffer-head, utilities, xfstests test result) base=
d
> on read-only classic NTFS.
> The old read-only ntfs code is much cleaner, with extensive comments,
> offers readability that makes understanding NTFS easier. This is why
> new ntfs was developed on old read-only NTFS base.
> The target is to provide current trends(iomap, no buffer head, folio),
> enhanced performance, stable maintenance, utility support including fsck.
>
>
> Key Features
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - Write support:
>    Implement write support on classic read-only NTFS. Additionally,
>    integrate delayed allocation to enhance write performance through
>    multi-cluster allocation and minimized fragmentation of cluster bitmap=
.
>
> - Switch to using iomap:
>    Use iomap for buffered IO writes, reads, direct IO, file extent mappin=
g,
>    readpages, writepages operations.
>
> - Stop using the buffer head:
>    The use of buffer head in old ntfs and switched to use folio instead.
>    As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig al=
so.
>
> - Public utilities include fsck[2]:
>    While ntfs-3g includes ntfsprogs as a component, it notably lacks
>    the fsck implementation. So we have launched a new ntfs utilitiies
>    project called ntfsprogs-plus by forking from ntfs-3g after removing
>    unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
>    testing with xfstests as well as for recovering corrupted NTFS device.
>
> - Performance Enhancements:
>
>    - ntfs vs. ntfs3:
>
>      * Performance was benchmarked using iozone with various chunk size.
>         - In single-thread(1T) write tests, ntfs show approximately
>           3~5% better performance.
>         - In multi-thread(4T) write tests, ntfs show approximately
>           35~110% better performance.
>         - Read throughput is identical for both ntfs implementations.
>
>      1GB file      size:4096           size:16384           size:65536
>      MB/sec       ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      read          399 | 399           426 | 424           429 | 430
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      write(1T)     291 | 276           325 | 305           333 | 317
>      write(4T)     105 | 50            113 | 78            114 | 99.6
>
>
>      * File list browsing performance. (about 12~14% faster)
>
>                   files:100000        files:200000        files:400000
>      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86
>
>
>      * mount time.
>
>              parti_size:1TB      parti_size:2TB      parti_size:4TB
>      Sec          ntfs | ntfs3        ntfs | ntfs3        ntfs | ntfs3
>      =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
>      mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51
>
>    The following are the reasons why ntfs performance is higher
>     compared to ntfs3:
>      - Use iomap aops.
>      - Delayed allocation support.
>      - Optimize zero out for newly allocated clusters.
>      - Optimize runlist merge overhead with small chunck size.
>      - pre-load mft(inode) blocks and index(dentry) blocks to improve
>        readdir + stat performance.
>      - Load lcn bitmap on background.
>
> - Stability improvement:
>    a. Pass more xfstests tests:
>       ntfs passed 287 tests, significantly higher than ntfs3's 218.
>       ntfs implement fallocate, idmapped mount and permission, etc,
>       resulting in a significantly high number of xfstests passing compar=
ed
>       to ntfs3.
>    b. Bonnie++ issue[3]:
>       The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
>       error during file deletion. ntfs3 currently iterates directory
>       entries by reading index blocks one by one. When entries are delete=
d
>       concurrently, index block merging or entry relocation can cause
>       readdir() to skip some entries, leaving files undeleted in
>       workloads(bonnie++) that mix unlink and directory scans.
>       ntfs implement leaf chain traversal in readdir to avoid entry skip
>       on deletion.
>
> - Journaling support:
>    ntfs3 does not provide full journaling support. It only implement jour=
nal
>    replay[4], which in our testing did not function correctly. My next ta=
sk
>    after upstreaming will be to add full journal support to ntfs.
>
>
> The feature comparison summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Feature                               ntfs       ntfs3
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> Write support                         Yes        Yes
> iomap support                         Yes        No
> No buffer head                        Yes        No
> Public utilities(mkfs, fsck, etc.)    Yes        No
> xfstests passed                       287        218
> Idmapped mount                        Yes        No
> Delayed allocation                    Yes        No
> Bonnie++                              Pass       Fail
> Journaling                            Planned    Inoperative
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

For completion of this report, are the 287 passed xfstests a super set
of the 218
passed xfstest for ntfs3?
IOW, are there any known functional regressions from ntfs3 to ntfs?

Thanks,
Amir.

