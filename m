Return-Path: <linux-fsdevel+bounces-36154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C19DE89B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 15:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E547F163AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3224613957C;
	Fri, 29 Nov 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7Y65b9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FF428EC;
	Fri, 29 Nov 2024 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732890895; cv=none; b=m2i9ReuLWJ5ZTJEmiVK/SzAhYDF0Mae91BueFADfQ0Udkmtg/+pN6UUWQiybLRPu2mMcEr5AIsWgMaTfIUFpMorWb5hrxRAtYTju0U0VchhW5ttoFdGzaa/B2pAav/+pHrr0b+hytxhCiXuPTfEfDs3Ro5souLJka5BxoNXPQTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732890895; c=relaxed/simple;
	bh=G7glBFGXkb9AyLaluXKWALwClBK8DK2gdMoaU5DSx3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSaAniSwO/9l3eEVL445tHRBAf5RodZeam8NW4mp0x4+zM0OAwlJ68bysjGGvHQgF+EwdD3bHrLLiBV9lSiNuHR1AS3qRn14IKia/z067zwGQB+XDAEMiMnRnybyg58O1/rUpvqHW5RxhSHfSa45um8z/3XA1JJAbIgPGKswz84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7Y65b9g; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa51d32fa69so278768866b.2;
        Fri, 29 Nov 2024 06:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732890892; x=1733495692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EW0JawT1PO10Kg8thaG7n+twU1CCeYAzaZkbbW//NM=;
        b=F7Y65b9gyTSIe6opJWkjuWBskPXWXal6d/fl5LWWrN9q5xhWHOdEvEBUkVbS0iuQtP
         aJcg038jKk18Wm6qo3ENjtEO4N5XuzU1Od8ybknkRk62kZuo8kv6RTt05AaN8pak4C7q
         s55tpT4jfW/ysnaU7AwmVbdk5rSl/EI5KyHbjZX1kjclWEImLG0TKET/3a6o3lq8chH7
         i4QdUnHdKLDbdK8gSSqr+7sZuflFTlcpWs83R9UtBPAXrxGhyKOd7+d14R3qmTGIyoeG
         aJEsrMzApQg3rJbgCrM083D0pkzmWNmxP3xK8zlEQUXAcYK+gFmXCWs578ynWFsfB4rw
         ZgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732890892; x=1733495692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EW0JawT1PO10Kg8thaG7n+twU1CCeYAzaZkbbW//NM=;
        b=T9ZeoFiY1Y5tUIAMQ0cls8bAX41KwlG1I1Oj0i6ncphN4Em9Evj0gEFzoiN/tS/d0c
         oaQTImYdDDeEd2wnQnbsTmeJVT/gqQw4xUyiWxBgEJSsJv2MnWqeBmBZ/I22qzl3ou7y
         E/ZnTi2tl2XF95klX2JruQxMDpEJ+abV1a2AmBquiPB7mFhTp9bvBBw/3Kq6NMJN2Zy+
         VYaBMR4X6cU4t/n0g4N+4HdX2zPej2cEi2zH9AKzch3xIY2mnuBov84jKhoIQwmDeHFY
         JoaRBrJEg+9p80eVcTgGSKEMUyCXFQrFklXYlsS3Ysq7iRIHmSTSgUtwW8T5SFY/Jt8x
         Gp8A==
X-Forwarded-Encrypted: i=1; AJvYcCUyE7rxd6bVfZUh/yTewYBs6UO/WA+vYOfmLJuUuoB8KTBWWSSUzmtqL6ZGn3SEbwA4oruQ4NjYKJSI1c7u@vger.kernel.org, AJvYcCVHcU2c4+HtPnObnzwV9GaRjycQSBxqS4DbHtFAbQ4ZExX3KByv6ks0jPIL7HFWOf+LGlAjyiLYi/eTfCfZ@vger.kernel.org, AJvYcCVRIkJxxE22zCN/T6rLT2aBlJefn1he8FLlKReq8Yj/SjxbGFJVYGRHnp2CpyFVydxI6E61XNFGAtoz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZGIAh6ytuAwlCg8sXHleewOyQuLhaEWPJDoTKIIqnd8wcsa0
	lwwEwLnnNw7pflvg3W24wQ12NT/jSb22ePala1GUX/fCYAnSldzSTpAYRY6bcOQ031DkXhbI+/u
	gRne1CGv+2df57kChOWhzUeVh6L4=
X-Gm-Gg: ASbGncuydZwTSDZDKFIGV14fCbfYu2ekIchAgS2r5ze3EFv4ENiUvwDI9D7dFNoPSW1
	8KZEvLje7X/QnIU1IFH1EsO+z460ac5Y=
X-Google-Smtp-Source: AGHT+IGTp1x5hC1l96OlJsKaXiA4Oe7Dso8Ablax6bwVAMKteoI2Yz37r80Tz5wedAvjNweA28pN3NSZsyt616Pic9I=
X-Received: by 2002:a17:906:3145:b0:aa5:1d08:dad7 with SMTP id
 a640c23a62f3a-aa580ed0a63mr813721966b.9.1732890891699; Fri, 29 Nov 2024
 06:34:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129-work-pidfs-v2-0-61043d66fbce@kernel.org> <5ff149339540d3bccb09eb30544fab35ea29a53f.camel@kernel.org>
In-Reply-To: <5ff149339540d3bccb09eb30544fab35ea29a53f.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Nov 2024 15:34:40 +0100
Message-ID: <CAOQ4uxg5aKctWOC1Vo=dMGhSowGFDSzVq-Fvdxp5LeNOkaTPKw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/3] pidfs: file handle preliminaries
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Erin Shepherd <erin.shepherd@e43.eu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 3:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2024-11-29 at 14:02 +0100, Christian Brauner wrote:
> > Hey,
> >
> > This reworks the inode number allocation for pidfs in order to support
> > file handles properly.
> >
> > Recently we received a patchset that aims to enable file handle encodin=
g
> > and decoding via name_to_handle_at(2) and open_by_handle_at(2).
> >
> > A crucical step in the patch series is how to go from inode number to
> > struct pid without leaking information into unprivileged contexts. The
> > issue is that in order to find a struct pid the pid number in the
> > initial pid namespace must be encoded into the file handle via
> > name_to_handle_at(2). This can be used by containers using a separate
> > pid namespace to learn what the pid number of a given process in the
> > initial pid namespace is. While this is a weak information leak it coul=
d
> > be used in various exploits and in general is an ugly wart in the
> > design.
> >
> > To solve this problem a new way is needed to lookup a struct pid based
> > on the inode number allocated for that struct pid. The other part is to
> > remove the custom inode number allocation on 32bit systems that is also
> > an ugly wart that should go away.
> >
> > So, a new scheme is used that I was discusssing with Tejun some time
> > back. A cyclic ida is used for the lower 32 bits and a the high 32 bits
> > are used for the generation number. This gives a 64 bit inode number
> > that is unique on both 32 bit and 64 bit. The lower 32 bit number is
> > recycled slowly and can be used to lookup struct pids.
> >
> > Thanks!
> > Christian
> >
> > ---
> > Changes in v2:
> > - Remove __maybe_unused pidfd_ino_get_pid() function that was only ther=
e
> >   for initial illustration purposes.
> > - Link to v1: https://lore.kernel.org/r/20241128-work-pidfs-v1-0-80f267=
639d98@kernel.org
> >
> > ---
> > Christian Brauner (3):
> >       pidfs: rework inode number allocation
> >       pidfs: remove 32bit inode number handling
> >       pidfs: support FS_IOC_GETVERSION
> >
> >  fs/pidfs.c            | 118 ++++++++++++++++++++++++++++++++----------=
--------
> >  include/linux/pidfs.h |   2 +
> >  kernel/pid.c          |  14 +++---
> >  3 files changed, 86 insertions(+), 48 deletions(-)
> > ---
> > base-commit: b86545e02e8c22fb89218f29d381fa8e8b91d815
> > change-id: 20241128-work-pidfs-2bd42c7ea772
> >
> >
>
> This seems like a good stopgap fix until we can sort out how to get to
> 64-bit inode numbers internally everywhere.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Yep. look good

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

