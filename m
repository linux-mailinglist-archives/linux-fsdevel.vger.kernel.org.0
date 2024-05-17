Return-Path: <linux-fsdevel+bounces-19685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445B8C8949
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69801F230A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B712D212;
	Fri, 17 May 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OPGnQRbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B334EB36
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715959451; cv=none; b=ADfiae9nMcrzdQLwfW0s7fXfl4apzi1fU6fDOdRCNLrz8OLdOG6Wiba8N3EtZj7Bys8bsFbBocZxYxug9aDW/9ILly+UgvlCPAgL8BhNnXlPHZhL3OUDEAmG2Yvw38ELdp/32QyORUJ8bo6lRWHY0JekWYsuJAlApzQs3DFNgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715959451; c=relaxed/simple;
	bh=QXdfDXnhNP+XPVRy8IxZ7g7dZ6J4mPy+Da5kke7S0oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tvzzf2gJE0FyFbeWeAjWSyjCgvxj4YPhyGOB9zo7/K+CVtgIUS+YGY1rfppXY302Mq67imnw9LBJF6z2P24EHPCPK3Y4QqORCFzuzefRXGDRsKlYKg4vvWHgK2VBJvl3jgsAWnZ/6Bgx/aM2spL4hklg3R2AZx9m5H27qLIikM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OPGnQRbz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-572e48f91e9so5490569a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 May 2024 08:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715959448; x=1716564248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CchMDZ298/IGI6kE9eLIhV6PqN0AhAFW2cfstX4Dhf0=;
        b=OPGnQRbzHLytCqVvmwp4DGYAWhMcQagGHAn1CLe7oZfPCz3/jXnAbbgtiflL7fT8w4
         q0fkXQ6ph4SDdb7+HY6Ilr9/YD6zjr1I2w5pbVP+/yRS0VAp0fPMTMm2DvGGYuDxVq5Y
         ggLvFjDBep1N2SSVaVF9Hwx/yqIhK+VpYrM9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715959448; x=1716564248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CchMDZ298/IGI6kE9eLIhV6PqN0AhAFW2cfstX4Dhf0=;
        b=Km8vcu001p5Uo14wy0szmfcZz2Hbg/pcWyVBDsWfnqjkv7+V8OvpP2IcSpKbVmCZ9W
         nBpKoMNN8IJCX8QQZQNo0LQr39FQbm2ie16vFk6CpIeezhtRRMhQehJEbD1aMDOIhXvs
         EG0t/YutgIKA2cfgBCUEXIgQnOQYxS1izMyGOghSyhEfNrFwdSAlCNivdnd8Jsb9r6VV
         wCQOXQnSNXUWYx0GbqxtTdAgXBHFabSLClkpYF0qIsBmdUTjVmx2CRZOTtwFA9pYddlj
         quEuuocALwCgzS3rVdq1LCYRoG851jBBrvJnEF3GsNutqLJOQRc5uGYyFnAljUj3u3yf
         lUCw==
X-Forwarded-Encrypted: i=1; AJvYcCV9ve5nTUS83jRTwXCoWMIUQdIltc7Isj68yCoPeZNJlU1huDiXji2GLUOQyxaFt1Yco2ST6mwgZlIhTA0yyD9UM9IvkZylIuWnaxni9A==
X-Gm-Message-State: AOJu0Yyp5muqf+oOlsyNP7puptAv767LPt1Raieekynj3TdV6WwkdeGW
	lwHnkMwIfZPdYYMCbJBeUbjeGVqJ4EhD5/0cp0e6SeI4MciKYSl5rq7rsN1FWyMA252nCW7yogW
	BIUQTNnOV4i1r8svK2Eq6ZXBLbTM+3Bo3RJyfVg==
X-Google-Smtp-Source: AGHT+IFiAkBo67FgjDFTRG6mQd98TKYWCrHgCGz/lmkQLZy75bavfdElw4HfutKdjY2fPP553NTo7I8eOEq/o0H1GVQ=
X-Received: by 2002:a17:906:da8b:b0:a59:bdb7:73f8 with SMTP id
 a640c23a62f3a-a5a2d66a3b4mr1968036666b.47.1715959448089; Fri, 17 May 2024
 08:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509125716.1268016-1-leitao@debian.org> <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>
 <ZkIKfFs-0lfflzV-@gmail.com>
In-Reply-To: <ZkIKfFs-0lfflzV-@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 17 May 2024 17:23:56 +0200
Message-ID: <CAJfpegvr9Ufqg4oe7BnL2Kjsa6M_A-LTyZ9LdvbjnG0GVN_jdw@mail.gmail.com>
Subject: Re: [PATCH] fuse: annotate potential data-race in num_background
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 14:41, Breno Leitao <leitao@debian.org> wrote:

> That said, if the reader (fuse_readahead()) can handle possible
> corrupted data, we can mark is with data_race() annotation. Then I
> understand we don't need to mark the write with WRITE_ONCE().

Adding Willy, since the readahead code in fuse is fairly special.

I don't think it actually matters if  "fc->num_background >=
fc->congestion_threshold" returns false positive or false negative,
but I don't have a full understanding of how readahead works.

Willy, can you please look at fuse_readahead() to confirm that
breaking out of the loop is okay if (rac->ra->async_size >=
readahead_count(rac)) no mater what?

Thanks,
Miklos

