Return-Path: <linux-fsdevel+bounces-9881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AFD845AA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F79B1F26CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08505F490;
	Thu,  1 Feb 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hssiVzYO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1462140
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799157; cv=none; b=fMXnuiTy4IojunocrCwk2ArQYYsLvU3k463FbGOtDzXk86n8/SBti7sb6MVQHUIgXXEcDqawTnvfTX4ZLIZmYLd7BbMlQktbYg0a27qf+aqjhnRVQ2RMBee5Ze0xudZNYNoeyMYATt+tGQbY1nrKkCo7B8nlRntfRoKcF5betuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799157; c=relaxed/simple;
	bh=O4h+Jn6sJzjeF2vG9Ot1XZ7TUjQrpxCbljd6UrGSKDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e8oCLPA5JkryNB5JKoUAUYZbyccp7ugYLa09r+Zqoo112d3QbzONFATNlwko6CfVfNXzDjbJU8TUjbVBk49qPewHOwsxGOBX+8Q4+rJpfCx2zmruDu7W3E+Lok5KekpwY0pVVt4lJQZWWz17txczuQKGVS/8No1kgnDnQezgQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hssiVzYO; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5111ef545bfso1612493e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706799153; x=1707403953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqq7AynvFExiikMOI4vWow6H5+tuB5BH/mOX0WPpBRE=;
        b=hssiVzYOTjqOHUkjCUjoNWzNTvM0MBDxgfiPKF5RsiznxlaywYEYGpBifxSrvFKR+f
         +W75Ka8Lcoik0QZa4P/aeEAXlb+JtiWQxmvR+5arZq+a2tWf00z5eVrIAf/G3D5l/cZG
         JqxRHEblIiKyMCMDeYo8cOiwFdDptA7drGcDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799153; x=1707403953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nqq7AynvFExiikMOI4vWow6H5+tuB5BH/mOX0WPpBRE=;
        b=OvTKh/FHT/LForp3zhmbwjpxBOLFeSMu7m8SReg8dvjne2gfwQ/ng15bM4jnCK4QrZ
         nsMYXPuwu4fCQSbUz214UlmLwGjLHfTQ4cWnDRlTgy8IMPnxF8WBZXH7lUZeKNIC3+dA
         3VRC8IZOW5JowqSOjCYFO2xr8CTKA4yteegBCj/e8KbGgpwRZglaj56FAAuEihvH6iK8
         ncKdirl2NiCvWxic5AvqSGe/pp7GnTZm+GynVlHLgVqtd/bPV+8yhLz9MN6UDxaASHOo
         vx/yjetC8LoZehmDVnbdvYHqjiZRykbIGZ4CM5o8rxkS8uYm6BDxU1u92YERHdmsjn3U
         O26A==
X-Gm-Message-State: AOJu0YxHwCcptU/EnTXGpWD0sjUW6CRhUDQSaVGRzbVLZH7jL+xx4v75
	TvCA1KI1i2FI5OwUvsrThVEMLQ0cdB2BzdFadt1kurV5SKRRAgwl8ndKYvR0VqrhHLdZaMsrzPN
	NzE2vNX1SecagPB5Vqb4ONa8YBDneGBdBgAbkfQ==
X-Google-Smtp-Source: AGHT+IF65tglr0Em2QTI2iAwltrHqiFhAM9jxnp/3mTb29z/jRIjOXzVvJRehyPAFRixCI18AJvuXes2i00GbAHR+a0=
X-Received: by 2002:a19:650f:0:b0:50e:587f:b21e with SMTP id
 z15-20020a19650f000000b0050e587fb21emr2313629lfb.14.1706799153202; Thu, 01
 Feb 2024 06:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230827.207552-1-bschubert@ddn.com> <20240131230827.207552-2-bschubert@ddn.com>
 <CAJfpegsU25pNx9KA0+9HiVLzd2NeSLvzfbXjcFNxT9gpfogjjg@mail.gmail.com> <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
In-Reply-To: <0d74c391-895c-4481-8f95-8411c706be83@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 1 Feb 2024 15:52:21 +0100
Message-ID: <CAJfpegvRcpJCqMXpqdW5FtAtgO0_YTgbEkYYRHwSfH+7MxpmJA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, dsingh@ddn.com, 
	Hao Xu <howeyxu@tencent.com>, stable@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 15:36, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 2/1/24 09:45, Miklos Szeredi wrote:
> > On Thu, 1 Feb 2024 at 00:09, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> There were multiple issues with direct_io_allow_mmap:
> >> - fuse_link_write_file() was missing, resulting in warnings in
> >>    fuse_write_file_get() and EIO from msync()
> >> - "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
> >>    fuse_page_mkwrite is needed.
> >>
> >> The semantics of invalidate_inode_pages2() is so far not clearly defined
> >> in fuse_file_mmap. It dates back to
> >> commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
> >> Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
> >> only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
> >> and writes out dirty pages, it should be safe to call
> >> invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.
> >
> > Did you test with fsx (various versions can be found in LTP/xfstests)?
> >   It's very good at finding  mapped vs. non-mapped bugs.
>
> I tested with xfstest, but not with fsx yet. I can look into that. Do
> you have by any chance an exact command I should run?

Just specifying a filename should be good.  Make sure you test with
various open modes.

Thanks,
Miklos

