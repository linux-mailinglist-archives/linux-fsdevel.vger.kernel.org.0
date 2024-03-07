Return-Path: <linux-fsdevel+bounces-13901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C552875445
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2B21F22124
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321B512FB26;
	Thu,  7 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vCzgPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83012F393;
	Thu,  7 Mar 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829448; cv=none; b=hmvvDPyC5ndn5yftEZ+Uy+gAbd6ke+L/KRzzxAZMSGvTtMy1v/9x2jZh0yiHm7VtF5+Nyg92BJt75ajSywa7YocnkPUa0xH370gERYKnblke0DBmFPcbrTeKyLt/sf220khyuIIE9kBkbklnZo/KJOylv85wpIkYYq6nksfdO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829448; c=relaxed/simple;
	bh=OHQtAzNP7NN1/bEJi+HrwemW4ZPqPBMods+fMhleOq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEl311TGeUZj8fHwGHsmMf+TrPsIzwc6aEsxoZXfEpi6VvUbI2uS2PXi1z1QVmV1FTTj5vv/QFwMiv9lgXOekQr60b1lguvWjVBwKQp9+lR47dCm8aSV98U7AX8Grd19hCL6+tK8TB4sLAqTYSCCZdXFb7AId08ck35CHXfHpJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6vCzgPE; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d33986dbc0so11699801fa.2;
        Thu, 07 Mar 2024 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709829445; x=1710434245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wa8nE8b8SqGhZ4QI7aILjtKTfQn19EOeWHCgUsOwbGw=;
        b=A6vCzgPEFgtJbEu9oBAVmPj/pT0CSLWmaZFKqjLyFJpML2SxRbMCtHL/hztyK+YMSH
         2vK7VLcfiEV/g13+6M1aUyOqbsXns+KbkF0ZfNjrE9p3itu1s+1Mr2DWg+OABWxoK63U
         7IHax2jHzkmxak8YJLIuR7c+SuKHv3Oq4kPNfAJDKRoNi4dcjz5TR+A9BRp2sXHoO7hL
         hwslRuE8BVe4t5Lh04lJKqNF/gRrLN0+6sFLI1VGIuYBySXeZYxfg5AlBDCw+7FzUvoz
         8ciZUEtnwgj2a8sIzaUM3/K+BR0ZcZaDZsfVGQU6hoG+VTwECo+Sdw/Xx+oePbclJa+1
         aCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709829445; x=1710434245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wa8nE8b8SqGhZ4QI7aILjtKTfQn19EOeWHCgUsOwbGw=;
        b=WG0x6d/kMDdtufe5Tj46FLsQXzXt2fPFh9ZNJ9Zw3i9ONk9xw7BBXrQlrG3TO5h+2E
         Au5UW/+DC6NsxutgrWnz3cJ9Rwxdd1u5ti62helOU16hqleeUwmhujO/2KZ7aonUpxuo
         yfOxu4pBsbd+C+SVDj1O0CVm5IgSJ7p828QLmjtCyNw7/2xM0NfFHalPC1Yf43aYQROD
         E+vXmyQuEqCssdVwZNfJ9l3rRpCvz56wkfQkEf9hRjbHPRd4svssaSZinH4b5TzssrYZ
         I1qBqSf69aGZB5UWym3hr9MLZ/qzcVTmX6LuiW2wCJz06oEV48ReEjT/SPRsKbFBrX4e
         9uCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvrtXx+WKeZTC1ojRczNxroPzoKu9hHpAXqaWjRPFiDTvY/6jjVt524nj1p72fXeHXCq5Vu0PDUOp4gb1Yfvs471IIbbVz302mrvmLU33wt4FBDAybn7VyfMJHsFMJ0N/VKlDI9QxFU7U=
X-Gm-Message-State: AOJu0YzQMUH0t7mSiwW4CW/kWDwIR/gR6NsW8xRMzGQRInlPehE54JHW
	xGIC8DA9jeY3wrS6LFSRn/UnP9/0lGNFd4z3p2wQ3WGiNHwV8JclXuTLzAJSA8c4L9wj02gUFrB
	RbEI9BJ3GE0pejIy9CCS/Usn/8wk=
X-Google-Smtp-Source: AGHT+IGMWmggy9gl2hWKPZoIZmBitATbdUkOinib/daRk5QHwjzoxyiLosZnb+VyP2uYgps7e3EIF0J+yGEpNOc2u4k=
X-Received: by 2002:a05:651c:1049:b0:2d2:4474:2e69 with SMTP id
 x9-20020a05651c104900b002d244742e69mr1874237ljm.9.1709829444350; Thu, 07 Mar
 2024 08:37:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
 <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
In-Reply-To: <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Thu, 7 Mar 2024 10:37:13 -0600
Message-ID: <CAH2r5msvgB19yQsxJtTCeZN+1np3TGkSPnQvgu_C=VyyhT=_6Q@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] statx attributes
To: Amir Goldstein <amir73il@gmail.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Which API is used in other OS to query the offline bit?
> Do they use SMB specific API, as Windows does?

No it is not smb specific - a local fs can also report this.  It is
included in the attribute bits for files and directories, it also
includes a few additional bits that are used by HSM software on local
drives (e.g. FILE_ATTRIBUTE_PINNED when the file may not be taken
offline by HSM software)
ATTRIBUTE_HIDDEN
ATTRIBUTE_SYSTEM
ATTRIBUTE_DIRECTORY
ATTRIGBUTE_ARCHIVE
ATTRIBUTE_TEMPORARY
ATTRIBUTE_SPARSE_FILE
ATTRIBUTE_REPARE_POINT
ATTRIBUTE_COMPRESSED
ATTRIBUTE_NOT_CONTENT_INDEXED
ATTRIBUTE_ENCRYPTED
ATTRIBUTE_OFFLINE

On Thu, Mar 7, 2024 at 2:54=E2=80=AFAM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Mar 7, 2024 at 7:36=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
> >
> > Following up on a discussion a few years ago about missing STATX
> > attributes, I noticed a case recently where some tools on other OS
> > have an option to skip offline files (e.g. the Windows equivalent of
> > grep, "findstr", and some Mac tools also seem to do this).
> >
>
> Which API is used in other OS to query the offline bit?
> Do they use SMB specific API, as Windows does?
>
> > This reminded me that there are a few additional STATX attribute flags
> > that could be helpful beyond the 8 that are currently defined (e.g.
> > STATX_ATTR_COMPRESSED, STATX_ATTR_ENCRYPTED, STATX_ATTR_NO_DUMP,
> > STATX_ATTR_VERITY) and that it be worthwhile revisiting which
> > additional STATX attribute flags would be most useful.
>
> I agree that it would be interesting to talk about new STATX_ attributes,
> but it should already be covered by this talk:
> https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu2g3padagae=
qcbiavjyiis6prl@yjm725bizncq/
>
> We have a recent example of what I see as a good process of
> introducing new STATX_ attributes:
> https://lore.kernel.org/linux-fsdevel/20240302220203.623614-1-kent.overst=
reet@linux.dev/
> 1. Kent needed stx_subvol_id for bcachefs, so he proposed a patch
> 2. The minimum required bikeshedding on the name ;)
> 3. Buy in by at least one other filesystem (btrfs)
>
> w.r.t attributes that only serve one filesystem, certainly a requirement =
from
> general purpose userspace tools will go a long way to help when introduci=
ng
> new attributes such as STATX_ATTR_OFFLINE, so if you get userspace
> projects to request this functionality I think you should be good to go.
>
> >
> > "offline" could be helpful for fuse and cifs.ko and probably multiple
> > fs to be able to report,
>
> I am not sure why you think that "offline" will be useful to fuse?
> Is there any other network fs that already has the concept of "offline"
> attribute?
>
> > but there are likely other examples that could help various filesystems=
.
>
> Maybe interesting for network fs that are integrated with fscache/netfs?
> It may be useful for netfs to be able to raise the STATX_ATTR_OFFLINE
> attribute for a certain cached file in some scenarios?
>
> As a developer of HSM API [1], where files on any fs could have an
> "offline" status,
> STATX_ATTR_OFFLINE is interesting to me, but only if local disk fs
> will map it to
> persistent inode flags.
>
> When I get to it, I may pick a victim local fs and write a patch for it.
>
> Thanks,
> Amir.
>
> [1] https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-=
Management-API



--=20
Thanks,

Steve

