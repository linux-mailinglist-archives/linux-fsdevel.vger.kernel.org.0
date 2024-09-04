Return-Path: <linux-fsdevel+bounces-28603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41896C552
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33EA0B221A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A075D1E2028;
	Wed,  4 Sep 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wXFDADOv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB331E2002
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470503; cv=none; b=JcbiT2fpLJWNawjgXruGCF5/5M3Yyj7Yrh8g+GZfvnD6OTbiR1sF3E+8yymcUCRpwIx3o3v2XjheonMzVj3FlWdyq1Bsv2SO5spCHuDM5JwcfC80WU0nMW3WSvHnCdvpfoLSc7ncSEQchQaE34LeaBe0MTFd1+24wm13a9SPoag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470503; c=relaxed/simple;
	bh=M2wB6IuvX8Y3eYg4jvbIwCg44+OrIM0CKpCAgRrEEqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REk/xLiglPTxa6/G/Qo23CUFGc5R2BlST5EMfYZkuLVxFW6Yy1RUjZwS+kpDcS1bq2NOG2UwEO2X4mwBpeaRrG60RNZ2aIEa3aE5x/1M8Ei90vgHRQ1vOE4elrzfkUS2R8f+yXRSbjSeJTSK64URtP+cWn54rbWp8abQ2eU3YRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wXFDADOv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73A023F6B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725470491;
	bh=wECau4XEvTpGUX9ygNuwXmdCAyJqRIkDAdJm3PygI1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=wXFDADOvYBVJ4s3hS/UKFEtfRAn7eL0wIeo7kFJGGZV2DwnmeDPdeg1xqD00dtejC
	 dc3KcsbY6fPvy32hodykqqghcRl3x7WITDrZmD9OzYK4bJxm52/6aogfUCl0xdofwm
	 Nxp0UZa92RpAcz2bHY+RXYgWbtq7ahlC7V4jBvAkFnhnfYDTrvrehoTo6NrniEy37j
	 fYJ4wtlGMQd394naBHU3aXgwEoW49J8q2Mtb3pNK9b0fSsX0NrsNbzxukLUaWUIE08
	 oG82wgd1RNZoJ4zNAcdeC+GrqVnTORzCDDpT+mG1WF1dGc6TowL1I2O10b3GDfjQCt
	 qXr8R2e/N1KBA==
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-49bc26f7cd5so254734137.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Sep 2024 10:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725470490; x=1726075290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wECau4XEvTpGUX9ygNuwXmdCAyJqRIkDAdJm3PygI1A=;
        b=tmR5TlPI8SSDv1LWSzu/+lysdZOeLlh9crVYwymqjstp+OVz8NyeCvZwzamOTXTG6u
         CM3vUSQBGbABQgXDmnpHRz2QgilvW8N2rfgQ5FhXVk/4avTHG159Y0I+BYHN4pk4r11m
         BqZGEwm2i/MPvuTVTcz9hPcz+1addVul2V+tU9+fjaA/TPKvSFdFaksnWP5Han/DTFuS
         7uBrhIytw9pDx0d7AbtwDc3TzIEimQSdIvTAYpjjs2yaDqZjxbA2QUr1sNHne/wb971Y
         igpeWSjKuy/ycCbuXArpbdZ3Nr/+FTv4QE6PUmz1UfVVpLkDFxe4l/3Tm+VE1ZwpWy2M
         sTww==
X-Forwarded-Encrypted: i=1; AJvYcCXDqaOD5CUsi3rsf4CVar+sjbyhGuZzfF6ka/OMfNOEGVtt2Vm+RUzALmH6Y1kRaSVm+kmprIedHUgWE6Us@vger.kernel.org
X-Gm-Message-State: AOJu0YwekT3tsDo2igePAiZGeGzSWXcO3dbmSaab9TzOgdH/1vhyIn8P
	5n+Lbg9Ou/hjwmSRgqqLm9O9gz2vTk4QYzTWXdTZB3PlIE+jT/5Bc9h441kr0F/IRJDZQgQxOQs
	ez1EwHdnCc5kL0JI132kK2YiMmW1Jj+j76wbYSpQMCeo3p89aHttR5RXiRFNkWMKKWsQMQ4hIHg
	/YpeAs61kbYL5WjatvtsS1ZwvzlmpbZ3ZuFXhTFvQ44fDGtYNwI3IvUA==
X-Received: by 2002:a05:6102:3050:b0:498:d1a3:dea8 with SMTP id ada2fe7eead31-49a779a3da4mr16706762137.21.1725470490501;
        Wed, 04 Sep 2024 10:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETzX+nFescGy2Zlco4qcQYsWpSk6E5c5aiLLKtyFJ1NSlxblwNbkR3Sjk+l2aNraVwhztjq+ZJDZMm27Zjjog=
X-Received: by 2002:a05:6102:3050:b0:498:d1a3:dea8 with SMTP id
 ada2fe7eead31-49a779a3da4mr16706742137.21.1725470490181; Wed, 04 Sep 2024
 10:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903151626.264609-1-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegsouKySsJpYHetSPj2G5oca8Ujxuv+7jpvmF57zYztbZw@mail.gmail.com>
 <20240904-kehren-umzug-4dbff956b47e@brauner> <CAJfpegsJ5XFrBK_NatMJ-V9yv_CJZX_Xd+ZAhCQzRGSE=k01mg@mail.gmail.com>
In-Reply-To: <CAJfpegsJ5XFrBK_NatMJ-V9yv_CJZX_Xd+ZAhCQzRGSE=k01mg@mail.gmail.com>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 4 Sep 2024 19:21:19 +0200
Message-ID: <CAEivzxds=dcwr5TzVdToDwWNnUGRUVi9hLsg4bJX0OMigxvPMw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] fuse: basic support for idmapped mounts
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Vivek Goyal <vgoyal@redhat.com>, German Maglione <gmaglione@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 7:00=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> w=
rote:
>
> On Wed, 4 Sept 2024 at 17:29, Christian Brauner <brauner@kernel.org> wrot=
e:
> >
> > On Wed, Sep 04, 2024 at 05:15:40PM GMT, Miklos Szeredi wrote:
> > > On Tue, 3 Sept 2024 at 17:16, Alexander Mikhalitsyn
> > > <aleksandr.mikhalitsyn@canonical.com> wrote:
> > > >
> > > > Dear friends,
> > > >
> > > > This patch series aimed to provide support for idmapped mounts
> > > > for fuse & virtiofs. We already have idmapped mounts support for al=
most all
> > > > widely-used filesystems:
> > > > * local (ext4, btrfs, xfs, fat, vfat, ntfs3, squashfs, f2fs, erofs,=
 ZFS (out-of-tree))
> > > > * network (ceph)
> > >
> > > Looks good.
> > >
> > > Applied with some tweaks and pushed.
> >
> > Ah, I didn't see your reply. Fwiw, if you agree with my suggestion then
> > Alex can just put that patch on top of the series or do it after we
> > landed it. I just think passing NULL 38 times is a bit ugly.
>
> Yes, I agree with this comment.   I'm fine with either a redone series
> or an incremental patch.

Dear Christian,
Dear Miklos,

I'm happy to send a patch/patches on top to refactor that.

Kind regards,
Alex

>
> Thanks,
> Miklos

