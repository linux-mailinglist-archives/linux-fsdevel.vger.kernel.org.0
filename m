Return-Path: <linux-fsdevel+bounces-48679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3278AAB278B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 11:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A220D169FEA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 May 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD21C84C9;
	Sun, 11 May 2025 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="f0rnALs5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB483259C;
	Sun, 11 May 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746957385; cv=none; b=LO4bNnSiyrYdGpzFmyv+iPWjq2a9lemeppu0v7/IVBg0VYgCt5yBWADheGntDzCdX/vCRTgsCq0D/PrkiPYNC5JyYCTv7F6Cep5ysWP8tVvr0Snzh48Kj7whY8gkp/q4036G0tqUrUQzjYoZNqjBopBf5CkbYNWNL+qLLGbMhhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746957385; c=relaxed/simple;
	bh=EcBmzsM7eA7xMZYYigJuzVHeIpJyY81far1nUncUJBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxE5B/oRR6ZsCptcfb5vjTy6Fv3FsGftnT7fSyAaVXzC9+jFdpD+NHp3Lss82WaVf64O7yhUi1eafrRRhf9P5Jvs3i49xEbFUYbgYXxCHak40AULztvxWcoM8Yns47rCh0H3tEMRmtciARDZe16xyIwi66/UI5LDIzsJ4QA0jKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=f0rnALs5; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746957368;
	bh=Q4WxYauR8AdJ2g/bxgK0OnCSDtGUKaZ3FXBv5zWSQ3o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=f0rnALs5oYBMFRrdF1RW73vlsLnna6oGrnfoA34TNgOWbS86QPxuwpyQ8fn7Xfe9h
	 RdWyOlrraNRSI8Odt7xHAsSLlvAUx/ZqSh9E0GSD/ACDZ56bNYOFUloBcMxB0WVuDt
	 Exg8rkVTvENt4TGsdwjdd3xT9q3Ips6ktO23FTRQ=
X-QQ-mid: esmtpgz16t1746957366t3978378b
X-QQ-Originating-IP: idxpsimLGU0hGHoiytzFM6c0lvSOxOI2RwYkgO90RQg=
Received: from mail-yw1-f171.google.com ( [209.85.128.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 11 May 2025 17:56:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 268385335283760362
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7080dd5fe92so30443597b3.3;
        Sun, 11 May 2025 02:56:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVA4PjaHvjSu+FrYhd3Xjz0sgFUYH295+Y5N1BYdUc9hTjoYCvijf1NjPxjUM7DNXONXj7VXTKo20QcSKBR@vger.kernel.org, AJvYcCVJr0iSoJFP9dE40Pl5596RDv1DlAkJOQ9LcFSoF8+m0S0qKhh5TWBViEKooQdcnt5xMtdV/SbAr163e7+V@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwNE1i1+HZh/Foko786pz7p9+yWEREKyH5vyEKSpkLzOc1YYI
	1L/TWINq7DNIYFjyPhlqlNk13ZmNgrH9tG+JwJib1k5jUO8ExvCx95nV9EtN2m0jVls7KYAMDBv
	S3HXUGmL5rwxNLgddI8b665ComTw=
X-Google-Smtp-Source: AGHT+IFqLuDae5TrF5IJo/7IWt5v5Ao8J2mX0Tw9OQ+ugBMU8waXlOuwwp+zL8mDO91ahsSldM64QRb3cm2hmqEcuR0=
X-Received: by 2002:a05:690c:6a12:b0:708:bc6e:f48c with SMTP id
 00721157ae682-70a3f871939mr119947467b3.0.1746957363719; Sun, 11 May 2025
 02:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com> <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
In-Reply-To: <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Sun, 11 May 2025 17:55:52 +0800
X-Gmail-Original-Message-ID: <63311AB69C79877E+CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
X-Gm-Features: AX0GCFtK-hImNBOzxFlHZ0vKLUrnxwuWZbKGGsFDBefNUE-06UaT5YtTpY95gd8
Message-ID: <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M5WiB9omAJaF9DHc4yLBEuj8uN1xheSWhMmEP+Ro2wxHA43u/0331fWs
	tRaB1zM2nLcU5rXC9pE0YjDS18B9IlIs3LOM3SNkiWXTI7uQdcRDB0x8PnGV3H+cBob8xEz
	OmYFfniXxKxxzdEKsot6rwPsui9NFu3klfyevGMzq83M1VnKfqjtGzF56Q4SMYusM079GOV
	Hnhk4hqQTwUmI9VOs4Z7CemEg5IT7nXXXAw6JlosAbx6M2flZt62jZXDzxxT9gbUsr2Z+yn
	l3Vj9DWrRAl/E9Xd4CaFgLGemcdx9IhRVSMV38toKtoBKgonSf0qtK/e0bXg1x7hlYUqIsk
	ae84TI8U63wwmYcu4HKepAsWIUc7ezNlBY4wPBTttRH5NBbksT9y5odzp2R5Lt907lLYcs/
	pt86DFweBYgY6qb9h3f8xjPdifmO8LWLunMAzHA8Q/ksO8LkWlBocRFPkBeQshELs6g35/A
	gxWJYX1tXU4nyMt/74qhaq6uolc92wnLodigfiNXh4mP/WKS542sLSUFp6z2/IJQZV9axEH
	VA4uCzZEY6faLaAMsLhNPJxEwQeDhbxXNftxGRHzj5zaOey/12xCAviFFD5JYVADIkVmrVp
	0LSKMrmHYytyq1WnkomZdjjyUUvByyx/oDxaYwb+7+8z8QrS4d+Z4VhTknOGUM0QySZHyc1
	bcQyOCgTTjhrcCVuhBdXHlmUYh4qK5z8CJFcowVQ8eLlzdC10o6/eL/hsllPGb01fyBtpUh
	VpMpc7yaGiKkyXBHan4ArZs6Dkgmhb+69vwnexEBfPLrrlKddT3xNqdCf244kXoFjcq2cw1
	IHE9lm9a0vR5KW8VWP76nLhMQJ2DBcfelgY6g2MZ/pbP5XZL+vRuN3UzZYwb4PPktqZ1N+J
	goZqdxBOaGSjad+QHrMLmezGtihkzyK2sY44bLembKbc43ipEovdrPJIm5WF/xfKuLwyFx2
	Q10nHyNkvz1URJ1x4fGMscxyITsmjfrR0QoWSibaSlQbnla7HPXTB0aCo8SJONsJmFnvj0U
	gYQmQ7ZKFt0BVrsqfz8wdr0Wz2Hw944gD9W2548HUnS+p0ld00F9jZwtFuUryPVCyx6a/aT
	RLgQ+PFayT0x0NLcaPLVOv7KA9WWz7xwU4EAHkgd/cD
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Fri, May 9, 2025 at 10:59=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:

> Right.  But I'm not asking you to implement this, just thinking about
> an interface that is generic enough to cover past and possible future
> cases.

I am not very familiar with the existing features in the kernel and
their development directions.
For example, I do know about the SCM_RIGHTS functionality,
but if you hadn't mentioned it here,
I wouldn't have realized that they are essentially addressing the same
kind of problem.

I don't think I currently have enough expertise to design an interface
that could even account for future cases, but I will give it a try.

I noticed that the current extended attribute names already use the
namespace.value format.
Perhaps we could reuse this naming scheme and extend it to support
features like nested namespaces.

For instance, in a situation like this:

A fixed file 0 in an io_uring is a FUSE fd.
This FUSE fd belongs to FUSE connection 64.
This FUSE fd has a backing file.
This backing file is actually provided by mnt_id=3D36.

Running getfattr -m '-' /proc/path/to/the/io_uring/fd could return
something like:

io_uring.fixed_files.0.fuse.conn=3D"64"
io_uring.fixed_files.0.fuse.backing_file.mnt_id=3D"36"
io_uring.fixed_files.0.fuse.backing_file.path=3D"/path/to/real/file"

Here, the mnt_id is included because I believe
resolving /path/to/real/file in user space might be a relatively complex ta=
sk.
Providing this attribute could make it easier for tools like lsof to work w=
ith.

Additionally, the reason I am working on this is that
I want to make FUSE's passthrough functionality work for non-privileged use=
rs.

Someone on the mailing list asked why passthrough requires privileges befor=
e:
https://lore.kernel.org/all/CAOYeF9V_FM+0iZcsvi22XvHJuXLXP6wUYPwRYfwVFThajw=
w9YA@mail.gmail.com/#t
In response, I submitted a patch that includes documentation explaining thi=
s:
https://lore.kernel.org/all/20250507-fuse-passthrough-doc-v2-0-ae7c0dd8bba6=
@uniontech.com/

Perhaps we could start by discussing that patch.

