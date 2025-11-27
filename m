Return-Path: <linux-fsdevel+bounces-70002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17468C8DE73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85E1A34DF8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385032B9AA;
	Thu, 27 Nov 2025 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dndfktD0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113E329C55
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241830; cv=none; b=X9GpQrVUhQfQnBAyfxAG0C+i4aHFfb+MdBO8UmVvSkUWEFibBTTpsIw9JpWbXJRI+aBxcmedBRIJiNtB4kMFtO+frOsorz94kgxk1ux5edwkUYEXMm3o9XSO3LXE1BZT3cvRbb80AG2ytci+/3f+KiGeMLAbdpZv4DmZAhhZ8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241830; c=relaxed/simple;
	bh=y4a2I4Asls0V9y33/YDlhw5wal7CqcPiuWRASl3utIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oc6t/3YDCHpNL5vATWnb5OeA+k3OjD0a7w1uvZJNg4kKW2tBPu4M2ZMCyTsFZIzezGGARRJIIXaSCnD+lZKSMEGRwT/K5NG5DzrDIwGKfOGZ+zhJ/FxF+GpM1TXbK1GuBtcgQjKZXPRyFPOedLAk4IirkZjmxOHosG+A2iZYaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dndfktD0; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso1451586a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764241826; x=1764846626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFxn24gkO39SfCgvHXYIB2F/64JmObgcxBGM7j95c2o=;
        b=dndfktD0ouKvoLttq8UIwlvEf/h8geNsATJUI3ehHaeQub5P0IWmh9XZnljwVXnXSK
         RMGgE+l+beHW4uAdKyf/Dmyg0E/U2igSj/sw8HuMfnjc+RqwXB1dVQlEXlhuY5Movzqm
         Dgz5cNcMmJMYjaKVKezMh//Z+e1YqBIgKtVQB408ZWesnhWODGEsjUCcaI870kFrMvOw
         5dgBpCu0mnZ+ebvgQA496kaLTYs2IZgzR19EA2pkTHhWwBZGsf77D89t87jiG4rqq+tU
         HTtzRyBkolxJ8CvCbhIo5XtCqEz6eStmyRB+XGJkjqzaKCCZGDKPdEaj9zhRqmo7+nbp
         mL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764241826; x=1764846626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFxn24gkO39SfCgvHXYIB2F/64JmObgcxBGM7j95c2o=;
        b=CSmsYVNQJ8zY0FRCUov0W9AxrNWtRVFKTg+sR4DWFzKMqGx/TcyE9JBHGtRbAKUzw6
         YTL96hKGrwMrmq7nmDYbnNX+nlhvMH1P1qNg1WRMKNN9T6TMrmmd+izTpS2/fhO/6k/4
         Mlf31qjyPSDCxKluHfuLlZwkEzj/BEG6BYBhvRaUgwLViGFW+shrbZTFCQDpi4Atx4ZD
         /5LwAaQz6p0Qw0kHYI6H/UbgNJnQJ578IZyZh1aoW9zTm7RBHceXdNzcgBPGyzmysnzZ
         SIsPKzErthpVO+YXVtacQx39MtU0uPqZ46PMlDSd28sQg0+EOHA4NR3HO1om4vam3zgn
         ycuA==
X-Forwarded-Encrypted: i=1; AJvYcCWAuEeMWRZzc5TiDqKR0Rae+48LFo3geb26u4AfiWt4eLQ4oFvrT04XBXuWQK0HGUykbFEWqtjuO4lSj+Wi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7iNvgraztNAP1GMZoIhn9ooMp7AFWX+0v919tpFTtkE57aza
	ECm7ckQXfhnOGiFKH4p98sX637MocjbiEsTWsX/uN6j0kgm6FPdnmlBUz25kHzMGm9oCpDrUddT
	ek7XKukSsIo+LR2QlWorVTt5DmL3DzZA=
X-Gm-Gg: ASbGncvC+/A3FiLqjEgZEp5wRvAUJgt112lK6FhJHO+swNzawphlYwYFkfOc1g3pD+8
	O2KU3E8TrLsLuFYQcUq7jQOiP9BofVeHEXjHokK4GMF4d/JGeRP5DrQdLePJ0b0SbxlNjY4oOu6
	1F32FdThhS60LzSRyqhiD0tyMEpWpJ7B8SSrdmMr+KzKEPiTEqqpmYW0e9M5YGyd0xNforPRUf1
	4rq9fHG0J08AWHQFIrt9DR6cQil2Ue16Bw+4KbyB+W1h+AsAzUXuVlDJ/Ryg1Aom245QKQ7LD7h
	jrrj2kQwS8TBxXB41PB81RMSRtY=
X-Google-Smtp-Source: AGHT+IGuOSRJg0VB/RtGq39lNvHUjllcomg1MIcWrYoVHuV+4IVKBuMbsJ1ZDSLkSazoS56IJyrKmLaRFTcch7peGH0=
X-Received: by 2002:a05:6402:8c8:b0:640:998e:4471 with SMTP id
 4fb4d7f45d1cf-645396394e4mr19360281a12.5.1764241826056; Thu, 27 Nov 2025
 03:10:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org>
In-Reply-To: <20251127045944.26009-1-linkinjeon@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Nov 2025 12:10:14 +0100
X-Gm-Features: AWmQ_blB8-IWiEGVlJsbNF8pYkDp381UlRkI3jzMMuo5ZNrYw5GTPGvXnpuNrhg
Message-ID: <CAOQ4uxhfxeUJnatFJxuXgSdqkMykOw+q7KZTpWXb8K2tNZCPGg@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 6:00=E2=80=AFAM Namjae Jeon <linkinjeon@kernel.org>=
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

May I suggest that you add a patch to your series to add a deprecation
message to ntfs3?

See for example eb103a51640ee ("reiserfs: Deprecate reiserfs")

>
>
> What is ntfsplus?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The remade ntfs called ntfsplus is an implementation that supports write
> and the essential requirements(iomap, no buffer-head, utilities, xfstests
> test result) based on read-only classic NTFS.
> The old read-only ntfs code is much cleaner, with extensive comments,
> offers readability that makes understanding NTFS easier. This is why
> ntfsplus was developed on old read-only NTFS base.
> The target is to provide current trends(iomap, no buffer head, folio),
> enhanced performance, stable maintenance, utility support including fsck.
>

You are bringing back the old ntfs driver code from the dead, preserving th=
e
code and Copyrights and everything to bring it up to speed with modern vfs
API and to add super nice features. Right?

Apart from its history, the new refurbished ntfs driver is also fully backw=
ard
compact to the old read-only driver. Right?

Why is the rebranding to ntfsplus useful then?

I can understand that you want a new name for a new ntfsprogs-plus project
which is a fork of ntfs-3g, but I don't think that the new name for the ker=
nel
driver is useful or welcome.

Do you have any objections to leaving its original ntfs name?

You can also do:
MODULE_ALIAS_FS("ntfs");
MODULE_ALIAS_FS("ntfsplus");

If that is useful for ntfsprogs-plus somehow.

Thanks,
Amir.

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
>    - ntfsplus vs. ntfs3:
>
>      * Performance was benchmarked using iozone with various chunk size.
>         - In single-thread(1T) write tests, ntfsplus show approximately
>           3~5% better performance.
>         - In multi-thread(4T) write tests, ntfsplus show approximately
>           35~110% better performance.
>         - Read throughput is identical for both ntfs implementations.
>
>      1GB file      size:4096           size:16384           size:65536
>      MB/sec   ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
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
>      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
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
>      Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
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
>    The following are the reasons why ntfsplus performance is higher
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
>       ntfsplus passed 287 tests, significantly higher than ntfs3's 218.
>       ntfsplus implement fallocate, idmapped mount and permission, etc,
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
>       ntfsplus implement leaf chain traversal in readdir to avoid entry s=
kip
>       on deletion.
>
> - Journaling support:
>    ntfs3 does not provide full journaling support. It only implement jour=
nal
>    replay[4], which in our testing did not function correctly. My next ta=
sk
>    after upstreaming will be to add full journal support to ntfsplus.
>
>
> The feature comparison summary
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Feature                               ntfsplus   ntfs3
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
>
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://en.wikipedia.org/wiki/NTFS
> [2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
> [3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4WwT=
y3Qe4Bqm6V0g@mail.gmail.com/
> [4] https://marc.info/?l=3Dlinux-fsdevel&m=3D161738417018673&q=3Dmbox
>
>
> Available in the Git repository at:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git ntfs-ne=
xt
>
>
> v2:
>  - Add ntfs3-compatible mount options(sys_immutable, nohidden,
>    hide_dot_files, nocase, acl, windows_names, disable_sparse, discard).
>  - Add iocharset mount option.
>  - Add ntfs3-compatible dos attribute and ntfs attribute load/store
>    in setxattr/getattr().
>  - Add support for FS_IOC_{GET,SET}FSLABEL ioctl.
>  - Add support for FITRIM ioctl.
>  - Fix the warnings(duplicate symbol, __divdi3, etc) from kernel test rob=
ot.
>  - Prefix pr_xxx() with ntfsplus.
>  - Add support for $MFT File extension.
>  - Add Documentation/filesystems/ntfsplus.rst.
>  - Mark experimental.
>  - Remove BUG traps warnings from checkpatch.pl.
>
> Namjae Jeon (11):
>   ntfsplus: in-memory, on-disk structures and headers
>   ntfsplus: add super block operations
>   ntfsplus: add inode operations
>   ntfsplus: add directory operations
>   ntfsplus: add file operations
>   ntfsplus: add iomap and address space operations
>   ntfsplus: add attrib operatrions
>   ntfsplus: add runlist handling and cluster allocator
>   ntfsplus: add reparse and ea operations
>   ntfsplus: add misc operations
>   ntfsplus: add Kconfig and Makefile
>
>  Documentation/filesystems/index.rst    |    1 +
>  Documentation/filesystems/ntfsplus.rst |  199 +
>  fs/Kconfig                             |    1 +
>  fs/Makefile                            |    1 +
>  fs/ntfsplus/Kconfig                    |   45 +
>  fs/ntfsplus/Makefile                   |   18 +
>  fs/ntfsplus/aops.c                     |  617 +++
>  fs/ntfsplus/aops.h                     |   92 +
>  fs/ntfsplus/attrib.c                   | 5377 ++++++++++++++++++++++++
>  fs/ntfsplus/attrib.h                   |  159 +
>  fs/ntfsplus/attrlist.c                 |  285 ++
>  fs/ntfsplus/attrlist.h                 |   21 +
>  fs/ntfsplus/bitmap.c                   |  290 ++
>  fs/ntfsplus/bitmap.h                   |   93 +
>  fs/ntfsplus/collate.c                  |  178 +
>  fs/ntfsplus/collate.h                  |   37 +
>  fs/ntfsplus/compress.c                 | 1564 +++++++
>  fs/ntfsplus/dir.c                      | 1230 ++++++
>  fs/ntfsplus/dir.h                      |   33 +
>  fs/ntfsplus/ea.c                       |  931 ++++
>  fs/ntfsplus/ea.h                       |   25 +
>  fs/ntfsplus/file.c                     | 1142 +++++
>  fs/ntfsplus/index.c                    | 2112 ++++++++++
>  fs/ntfsplus/index.h                    |  127 +
>  fs/ntfsplus/inode.c                    | 3729 ++++++++++++++++
>  fs/ntfsplus/inode.h                    |  353 ++
>  fs/ntfsplus/layout.h                   | 2288 ++++++++++
>  fs/ntfsplus/lcnalloc.c                 | 1012 +++++
>  fs/ntfsplus/lcnalloc.h                 |  127 +
>  fs/ntfsplus/logfile.c                  |  770 ++++
>  fs/ntfsplus/logfile.h                  |  316 ++
>  fs/ntfsplus/mft.c                      | 2698 ++++++++++++
>  fs/ntfsplus/mft.h                      |   92 +
>  fs/ntfsplus/misc.c                     |  213 +
>  fs/ntfsplus/misc.h                     |  218 +
>  fs/ntfsplus/mst.c                      |  195 +
>  fs/ntfsplus/namei.c                    | 1677 ++++++++
>  fs/ntfsplus/ntfs.h                     |  180 +
>  fs/ntfsplus/ntfs_iomap.c               |  700 +++
>  fs/ntfsplus/ntfs_iomap.h               |   22 +
>  fs/ntfsplus/reparse.c                  |  550 +++
>  fs/ntfsplus/reparse.h                  |   15 +
>  fs/ntfsplus/runlist.c                  | 1983 +++++++++
>  fs/ntfsplus/runlist.h                  |   91 +
>  fs/ntfsplus/super.c                    | 2865 +++++++++++++
>  fs/ntfsplus/unistr.c                   |  473 +++
>  fs/ntfsplus/upcase.c                   |   73 +
>  fs/ntfsplus/volume.h                   |  254 ++
>  include/uapi/linux/ntfs.h              |   23 +
>  49 files changed, 35495 insertions(+)
>  create mode 100644 Documentation/filesystems/ntfsplus.rst
>  create mode 100644 fs/ntfsplus/Kconfig
>  create mode 100644 fs/ntfsplus/Makefile
>  create mode 100644 fs/ntfsplus/aops.c
>  create mode 100644 fs/ntfsplus/aops.h
>  create mode 100644 fs/ntfsplus/attrib.c
>  create mode 100644 fs/ntfsplus/attrib.h
>  create mode 100644 fs/ntfsplus/attrlist.c
>  create mode 100644 fs/ntfsplus/attrlist.h
>  create mode 100644 fs/ntfsplus/bitmap.c
>  create mode 100644 fs/ntfsplus/bitmap.h
>  create mode 100644 fs/ntfsplus/collate.c
>  create mode 100644 fs/ntfsplus/collate.h
>  create mode 100644 fs/ntfsplus/compress.c
>  create mode 100644 fs/ntfsplus/dir.c
>  create mode 100644 fs/ntfsplus/dir.h
>  create mode 100644 fs/ntfsplus/ea.c
>  create mode 100644 fs/ntfsplus/ea.h
>  create mode 100644 fs/ntfsplus/file.c
>  create mode 100644 fs/ntfsplus/index.c
>  create mode 100644 fs/ntfsplus/index.h
>  create mode 100644 fs/ntfsplus/inode.c
>  create mode 100644 fs/ntfsplus/inode.h
>  create mode 100644 fs/ntfsplus/layout.h
>  create mode 100644 fs/ntfsplus/lcnalloc.c
>  create mode 100644 fs/ntfsplus/lcnalloc.h
>  create mode 100644 fs/ntfsplus/logfile.c
>  create mode 100644 fs/ntfsplus/logfile.h
>  create mode 100644 fs/ntfsplus/mft.c
>  create mode 100644 fs/ntfsplus/mft.h
>  create mode 100644 fs/ntfsplus/misc.c
>  create mode 100644 fs/ntfsplus/misc.h
>  create mode 100644 fs/ntfsplus/mst.c
>  create mode 100644 fs/ntfsplus/namei.c
>  create mode 100644 fs/ntfsplus/ntfs.h
>  create mode 100644 fs/ntfsplus/ntfs_iomap.c
>  create mode 100644 fs/ntfsplus/ntfs_iomap.h
>  create mode 100644 fs/ntfsplus/reparse.c
>  create mode 100644 fs/ntfsplus/reparse.h
>  create mode 100644 fs/ntfsplus/runlist.c
>  create mode 100644 fs/ntfsplus/runlist.h
>  create mode 100644 fs/ntfsplus/super.c
>  create mode 100644 fs/ntfsplus/unistr.c
>  create mode 100644 fs/ntfsplus/upcase.c
>  create mode 100644 fs/ntfsplus/volume.h
>  create mode 100644 include/uapi/linux/ntfs.h
>
> --
> 2.25.1
>

