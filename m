Return-Path: <linux-fsdevel+bounces-20508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE88D47F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 11:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177B2287F25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 09:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA55167DA4;
	Thu, 30 May 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ku/nivDl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7F1442F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059654; cv=none; b=iXP/zNgK7rxPPTTMvyq0GvqSs76o96wxhEqrwKkIGsjq9WmH0howYeconqIpQ1F2bMAuiyPGhJYibbp9qoNOgHFgj2Otp4/I51LtkJbHG1x+mlTROita1RitMbffEBQhKE24P6hQJYOmTGz1QewhuKHsqPVfzpwPeUST+6oYTHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059654; c=relaxed/simple;
	bh=Nc9zAcTlcbtJtu0DNDX60ybeN7et864qLxahu1oi48w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jff2PH5wUkvgfUcbIX4IHbB1/Nt4Vjk46ScCvXVr4hvJNUStccryiqElbhKlL8qUEBiOIajyI/67Z101228wginmsEk2TvxJRiCwgnkMM73bvjsgtBjAFTNZpHKShetHel0hik9BlvcwcFE1X5q+D6j9VSfN1peKNkih2LULR4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ku/nivDl; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5785f861868so707159a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1717059650; x=1717664450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMESdbBicm8rFV5b2/qnQO1Ucemsh+RYgjEutwtyOXs=;
        b=ku/nivDlu0Og5pnie8hB4IrGCqhqDmSGHrzZiJP+po+7aNmEk0oaE+iWhAFot9kBr5
         jMPfAS/c3roD3UXeWzSaye3lxwqclUU9lalGF6d0JuG3J9cES2gDaphAiRFTmMCMUhpV
         mMS1Zux/g+I7hjC4jTw7HMLZdzYY0c1Avle8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717059650; x=1717664450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMESdbBicm8rFV5b2/qnQO1Ucemsh+RYgjEutwtyOXs=;
        b=RPNsnh2p5/MxAsps3Gh+Red/36AZzzxK7Ip1//s1JJeb751uf1BU+e7T4Db9y3qs9a
         nbvPZ3WTU6O14gAO4xthv+VE9aBYbyrtMpMeym1+SALsNPnxoqgd4GTiiT8kKgQVsch0
         XyGYK7bLVNrvi232K4dEZOFLdzTMQh6wAcCOc/WZutnC4eS42KYrQ6oOMIrqKbQ5ebL8
         WmkzM98vp6FcB3paAru1/wcnO47jTCfh1pxwUPUvo3gNgulihpoIZYpJ0RKkNH9T8F0I
         21IPIkpqKMWupauPdiLuh2tcvkL9dg1Uggqt6f0Fe1UplxMH/L29E5YcNH6eXqb8cdQv
         hEkw==
X-Forwarded-Encrypted: i=1; AJvYcCVuPFr79Xu9uC+rNG2x5fp6ORspnu7KIIwWtSSGqiW1CrAlIIvXXG/nilC3H3FFTHr7Gv7F9h3TeTEX20znDrELpf+e6J+8tR7kysRAGw==
X-Gm-Message-State: AOJu0YyXKxIHvCexjFtnbuiKGZWf0FNBAuFwiLmLsWzz2XGVL65IfH3a
	gqLChgISTt5JElU6dEycwy1BOu0GBRawjFTS4ejNdrbUMrNEOm67z4Ui1w33ijTKiEC5118Dy7O
	ai0KLI3K4NFrwFvEAR7vDZgzGBL2EbmWFWiVgAw==
X-Google-Smtp-Source: AGHT+IGi/38kJyGwLfutSxTPJr6k/n9FLOIsFidAs8BpEQDzj/X8jLb5SPS563Jljd25/lDgCZl8A5d3U9QBJ6sO07I=
X-Received: by 2002:a17:906:2411:b0:a5a:5496:3c76 with SMTP id
 a640c23a62f3a-a65e8d125admr119879566b.6.1717059650551; Thu, 30 May 2024
 02:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
In-Reply-To: <af09b5d3-940f-491d-97ba-bd3bf19b750a@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 30 May 2024 11:00:39 +0200
Message-ID: <CAJfpeguV0dNiyR5jzQH7H4x0vOzFTcBgnnLDHBPU9fH23A0kng@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 05:20, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> > +             if (test_bit(FR_FINISHED, &req->flags)) {
> > +                     list_del_init(&req->intr_entry);
> > +                     spin_unlock(&fiq->lock                  ^
>                 missing "return" here?

Well spotted.  Thanks.

> > -             err = -ENODEV;
> > -             spin_unlock(&fiq->lock);
> > -             fuse_put_request(req);
> > -     }
> > +     fuse_send_one(fiq, req);
> >
> > -     return err;
> > +     return 0;
> >  }
>
> There's a minor changed behavior visible to users.  Prior to the patch,
> the FUSE_NOTIFY_RETRIEVE will returns -ENODEV when the connection is
> aborted, but now it returns 0.
>
> It seems only example/notify_store_retrieve.c has used
> FUSE_NOTIFY_RETRIEVE in libfuse.  I'm not sure if this change really
> matters.

It will return -ENOTCONN from  fuse_simple_notify_reply() ->
fuse_get_req().  The -ENODEV would be a very short transient error
during the abort, so it doesn't matter.

Thanks,
Miklos

