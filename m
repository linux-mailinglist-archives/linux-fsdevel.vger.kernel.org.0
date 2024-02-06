Return-Path: <linux-fsdevel+bounces-10421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498BB84AE82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 07:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBF11C22D2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 06:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCB12836D;
	Tue,  6 Feb 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtwDD669"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E114265
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707202437; cv=none; b=icwpAImGawYuJkeDq2YmiXq/jL7GOJP//oq0J1qKAdXH5JU5V6cD+jHhkfupqpU07BE0kKQQnaDpS710awhClxM0th2eLbx67DBGlu8mvM1ae5smi0giG18P6nglJYaxad9O53deP7miowI7r+hhKUVeDCdT9Y2tYVPH54RGWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707202437; c=relaxed/simple;
	bh=rdR8R71pDgVEZQzEuDgbnTw/6VKE3RihAqe3+4MCsA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otX+D+7w9FaeOe4/yEBuTBZ/eLL5Lm3CI9bZzIGcRj/JEckuK1q45zbxG6WTWZpDkBTWqnpuaU4+s2QEWs6r58Gn61EyEyyS6oc/rWxjccQ6awADGyy4qKJG8fMUFQlQMxr2pusOLjbXFwDSckfyTTJD6mVQQ5Yml6J8/5BMiSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtwDD669; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4c021a73febso722175e0c.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 22:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707202435; x=1707807235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnX4/wqzzb9H1MkxxO9CoNN3vGpwZNhmqAjLBpWJm4A=;
        b=RtwDD669OGFkIClVWSeKKbU7PvieeEvCBaXpqxn7UeEzdMVSbe5FzUTMhDJdTEKv9H
         OBrEU3zAgZLZXiOWLCBk2J5OdgzgI6zK4coL1eibYkGTrscyY4Exm7SoDQsXzmlcCoi1
         TjUtXhD1K7k7AStcRuIut9xTop0iGaUmWqq78Dm33tPUKyedZACby5SzFw9CGq+wR9vh
         ZsB6lxnnozMioBaPCQLfG+12sJ+rf3gmu0L7lG278arivgGz8UbpcL3u0uoqUFRUV2MJ
         5I8ZayGZRy1lhO8FiEUVG52muj+pfC6exyEVFaZz8PsjKAbTV0bwoLGciT93doDgEgix
         rWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707202435; x=1707807235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnX4/wqzzb9H1MkxxO9CoNN3vGpwZNhmqAjLBpWJm4A=;
        b=kek/r2kIq/5dvHjpTihq+c9ScPDEpkXK5h+rk4GfyLbF5uCLNUpoeYGJjWI6W7SfG8
         7if3UJEOr/xzIpDCpckNxBbKUH2NcUa/38/JuZC9b8WhQxsFbmJx2hvUlj+HMyHmOOKG
         JvYyS4xOaLUIdNQZqanA6bB5KFkeunI/iXmfBaEZBlP21ACMus+2iIUBeOwZmEasTS2j
         Uo9TZZvgxG1crSw+3LJwX8asTd2+WRucL6T3RwCW8fZ+UzgMdeFYYOSOQU5YuFUjg9Vh
         2fA5q+TFOyrbD1n/d8VJr98oE/qAz5/+ks0VNd99ENPerQQJSG6FlimjJ+ZckfGE8nDJ
         Kdfw==
X-Gm-Message-State: AOJu0Yy0OckCG2EMTbSMPnIiPnQa2h9r043w862dYW38qn/WXezK0ZLF
	GHzu8pIy36FS5r/V+RcB+svoRIr62qCni7QG0XydB6VQcjckGO2dlxG+fjkQ59M9UpB/4Gv7/SR
	w4iZB/N67iXhc6VZAJj4XEhiDVa0=
X-Google-Smtp-Source: AGHT+IGChbG8WDH3ROu1lP75cLMGJAdQRaMtrbj1S7g2uLtE3K9eqcbijKKsh6dMO665q8TGUYeJqCT81zpCFtKP9Hg=
X-Received: by 2002:a05:6122:200d:b0:4c0:1f44:6707 with SMTP id
 l13-20020a056122200d00b004c01f446707mr1016312vkd.11.1707202434680; Mon, 05
 Feb 2024 22:53:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
In-Reply-To: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 6 Feb 2024 08:53:43 +0200
Message-ID: <CAOQ4uxhek5ytdN8Yz2tNEOg5ea4NkBb4nk0FGPjPk_9nz-VG3g@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: fuse-devel <fuse-devel@lists.sourceforge.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 4:52=E2=80=AFAM Antonio SJ Musumeci <trapexit@spawn.=
link> wrote:
>
> Hi,
>
> Anyone have users exporting a FUSE filesystem over NFS? Particularly
> from Proxmox (recent release, kernel 6.5.11)? I've gotten a number of
> reports recently from individuals who have such a setup and after some
> time (not easily reproducible, seems usually after software like Plex or
> Jellyfin do a scan of media or a backup process) starts returning EIO
> errors. Not just from NFS but also when trying to access the FUSE mount
> as well. One person noted that they had moved from Ubuntu 18.04 (kernel
> 4.15.0) to Proxmox and on Ubuntu had no problems with otherwise the same
> settings.
>
> I've not yet been able to reproduced this issue myself but wanted to see
> if anyone else has run into this. As far as I can tell from what users
> have reported the FUSE server is still running but isn't receiving most
> requests. I do see evidence of statfs calls coming through but nothing
> else. Though the straces I've received typically are after the issues sta=
rt.
>
> In an effort to rule out the FUSE server... is there anything the server
> could do to cause the kernel to return EIO and not forward anything but
> statfs? Doesn't seem to matter if direct_io is enabled or attr/entry
> caching is used.
>

This could be the outcome of commit 15db16837a35 ("fuse: fix illegal
access to inode with reused nodeid") in kernel v5.14.

It is not an unintended regression - this behavior replaces what would
have been a potentially severe security violation with an EIO error.

As the commit says:
"...With current code, this situation will not be detected and an old fuse
    dentry that used to point to an older generation real inode, can be use=
d to
    access a completely new inode, which should be accessed only via the ne=
w
    dentry."

I have made this fix after seeing users get the content of another
file from the one that they opened in NFS!

libfuse commit 10ecd4f ("test/test_syscalls.c: check unlinked testfiles
at the end of the test") reproduces this problem in a test.
This test does not involve NFS export, but NFS export has higher
likelihood of exposing this issue.

I wonder if the FUSE filesystems that report the errors have
FUSE_EXPORT_SUPPORT capability?
Not that this capability guarantees anything wrt to this issue.

IMO, the root of all evil wrt NFS+FUSE is that LOOKUP is by ino
without generation with FUSE_EXPORT_SUPPORT, but worse
is that FUSE does not even require FUSE_EXPORT_SUPPORT
capability to export to NFS, but this is legacy FUSE behavior and
I am sure that many people export FUSE filesystems, as your
report proves.

There is now a proposal for opt-out of NFS export:
https://lore.kernel.org/linux-fsdevel/20240126072120.71867-1-jefflexu@linux=
.alibaba.com/
so there will be a way for a FUSE filesystem to prevent misuse.

Some practical suggestions for users running existing FUSE filesystems:

- Never export a FUSE filesystem with a fixed fsid
- Everytime one wants to export a FUSE filesystem generate
  a oneshot fsid/uuid to use in exportfs
- Then restarting/re-exporting the FUSE filesystem will result in
  ESTALE errors on NFS client, but not security violations and not EIO
  errors
- This does not give full guarantee, unlinked inodes could still result
  in EIO errors, as the libfuse test demonstrates
- The situation with NFSv4 is slightly better than with NFSv3, because
   with NFSv3, an open file in the client does not keep the FUSE file
   open and increases the chance of evicted FUSE inode for an open
   NFS file

Thanks,
Amir.

