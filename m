Return-Path: <linux-fsdevel+bounces-19919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD408CB2A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EFB1F22319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0310E147C92;
	Tue, 21 May 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJOKO7VQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6222F11
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311633; cv=none; b=CGah7uGb+t2YpxVvY3hlOcyGFW6RE/4ugLnMgKXxPGevurbctM4pDYFHYh1z5X4oz7Lk8KICfdDDUZXZbHUpkjPa7MY/aq+ygSJijKTDuTfLOLvJkqnss/+WYj69hqprJqEf3+FwLd8fLgk7plWHF2g04Z4ZfEocHQbAl+9Cn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311633; c=relaxed/simple;
	bh=LTei1xRiOIrGUhM85y803C1hkU3GWm0jPUP+UP9q2cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LwargNp3BKWnqGrgu7EcHjoS941bdjrpyioaPRHIUDR/ys/Ib5zBmxAZIRD0hgzC5/gaURTSno8HyJ0GhGyWsiaTSBdOS65zkeRRVJaZ2cRLa56OtdTnX6HlunZ6EeZCYvJRg9CC464Rd0sT+CcvJJzbzDmlTlIugzdJxrduUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJOKO7VQ; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c99257e0cbso2260307b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716311631; x=1716916431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTei1xRiOIrGUhM85y803C1hkU3GWm0jPUP+UP9q2cg=;
        b=iJOKO7VQ/bFg8RtzFo65SpcrNCgGmUepYsugtQKtyej8CKjTlt8E/xIhQP/OGSS6Vn
         y6c2cx9Y8m3KtVCDnukwVvhgPR2IMTm52t9TeCLXaFd0/eU7uQ9pUynLw7zy7YKZRXzQ
         63HCu+n2ofPJkxGY6MkJI3I2t2fFbQdxDtcQp0S1IJObeoEI27qyPY+g3HEYwRyq9o/f
         3CydmPDDfjm/8Yz40EiMMYeFr/C2zGklIFqgddctSfRwg7v/58q2/THSuaUpEHjJ2ZlQ
         jf86LffEL6EZEqySP9DzDwK0Rf0GI8Z9FbscRDvtgJLk0iKWMAL5o59keouAp8m14+jA
         FZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716311631; x=1716916431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTei1xRiOIrGUhM85y803C1hkU3GWm0jPUP+UP9q2cg=;
        b=pzzRXHny8N+B4QSq6HZFjc2rdQ/XGajulzof9R7KBebX72+19G5iVe4g2+iCiybhuL
         7wErMCpldd3jn1oNvP6J+2F+M2ztoGioSSzezKKp0QP+BVTmB1wX0Z581mecMUYsqHDx
         sZEwXd7RhCFSf3eHO5G4f0lOHccNffenExtVEJGPeR/rOMAYg/GLCmiSinDK/lNGk9p0
         LjLl38GWofCeWdonKl3Xzbc2M1utXdLm/MvxQVBy0Hvjndt5/LWqxfXbfP7cBgJQzdDp
         x+UgUbrEAgaBHNUtd7AJUZEb15KwKIPutnK137JAW06FRoA1OmxCghYxBl4Iv6Y/HveB
         92Rg==
X-Gm-Message-State: AOJu0Ywmns3dL6DVY57x0UrKqGPBs3e2aplOBzVY/Bu2EedmlHiH4JIs
	na58P711Gy/aeuzGsB+A3PYkcbMC0cTu+fPP1MiVl51RTbmBCpaIEKi4m2TNdIHwfxTZNk8KsMd
	cj4GC/hcmb6yGYVnlNr/ieMzuCNA=
X-Google-Smtp-Source: AGHT+IHsZPT5MCF4axhsrLNAPvn8uRmFw9ORzbBtw2LGAA/N/TbzY9Vnzmb1Bhb5TraalC7rCJSXiGBdMIpgzUDgW+0=
X-Received: by 2002:a05:6808:1922:b0:3c8:6416:f408 with SMTP id
 5614622812f47-3c997072494mr41535882b6e.30.1716311630027; Tue, 21 May 2024
 10:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
 <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com> <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com>
In-Reply-To: <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 May 2024 20:13:38 +0300
Message-ID: <CAOQ4uxhM-KTafejKZOFmE9+REpYXqVcv_72d67qL-j6yHUriEw@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: Jonathan Gilbert <logic@deltaq.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 7:04=E2=80=AFPM Jonathan Gilbert <logic@deltaq.org>=
 wrote:
>
> Hmm, okay. In earlier testing, I must have had a bug because I wasn't
> seeing filenames for FAN_MOVE or FAN_DELETE. But, my code is more
> robust now, and when I switch it to those events I do see filenames --
> but not paths. Looks like I can do the open_by_handle_at trick on the
> fd in the main FAN_MOVED_FROM, FAN_MOVED_TO and FAN_DELETE event and
> that'll give me the directory path and then I can combine it with the
> file name in the info structure?
>

Yes. That's the idea.
open_by_handle_at() with the parent's file handle is guaranteed to return
a fd with "connected" path (i.e. known path), unless that directory was del=
eted.

Note that you will be combining the *current* directory path with the *past=
*
filename, so you may get a path that never existed in reality, but as you w=
rote
fanotify is not meant for keeping historical records of the filesystem
namespace.

> Are FAN_MOVED_FROM and FAN_MOVED_TO guaranteed to be emitted
> atomically, or is there a possibility they could be split up by other
> events? If so, could there be multiple overlapping
> FAN_MOVED_FROM/FAN_MOVED_TO pairs under the right circumstances??

You are looking for FAN_RENAME, the new event that combines
information from FAN_MOVED_FROM/FAN_MOVED_TO.

Unlike FAN_MOVED_FROM/FAN_MOVED_TO, FAN_RENAME cannot
be merged with other events like FAN_CREATE/FAN_DELETE because
it does not carry the same type of information.

>
> One other thing I'm seeing is that in enumerating the mount table in
> order to mark things, I find multiple entries with the same fsid.
> These seem to be cases where an item _inside another mount_ has been
> used as the device for a mount. One example is /boot/grub, which is
> mounted from /boot/efi/grub, where /boot/efi is itself mounted from a
> physical device.

Yes, this is called a bind mount, which can be generated using
mount --bind /boot/efi/grub /boot/grub

> When enumerating the mounts, both of these return the
> same fsid from fstatfs. There is at least one other with such a
> collision, though it does not appear in fstab. Both the root
> filesystem / and a filesystem mounted at
> /var/snap/firefox/common/host-unspell return the same fsid. Does this
> mean that there is simply a category of event that cannot be
> guaranteed to return the correct path, because the only identifying
> information, the fsid, isn't guaranteed to be unique? Or is there a
> way to resolve this?

That depends on how you are setting up your watches.
Are you setting up FAN_MARK_FILESYSTEM watches on all
mounted filesystem?

Note that not all filesystems support NFS export file handles,
so not all filesystem support being watched with FAN_REPORT_FID and
FAN_MARK_FILESYSTEM.

If, for example you care about reconstructing changing over certain
paths (e.g. /home), you can keep an open mount_fd of that path when you
start watching it and keep it in a hash table with fsid as the key
(that is how fsnotifywatch does it [1]) and then use that mount_fd whenever
you want to decode the path from a parent file handle.

If /home is a bind mount from, say, /data/home/ and you are watching
both /home and /data, you will need to figure out that they are the same
underlying fs and use a mount_fd of /data.

Then, when you get a file handles of, say, /home/docs, it will be resolved
to path /data/home/docs.

If you try to resolve a file handle of /data/archive using mount_fd that
was opened from /home, the path you will observe is "/", so this will
not be useful to constructing history.

So the answer really depends on what exactly are the requirements
of your tool.

Thanks,
Amir.

[1] https://github.com/inotify-tools/inotify-tools/blob/master/libinotifyto=
ols/src/inotifytools.cpp#L1343

