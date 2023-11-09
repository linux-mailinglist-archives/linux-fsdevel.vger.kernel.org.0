Return-Path: <linux-fsdevel+bounces-2612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4F17E7073
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3971C20B37
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F25241EF;
	Thu,  9 Nov 2023 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DblzGIoM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC9E225D7
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 17:39:30 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D333D58
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 09:39:29 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9db6cf8309cso195518466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 09:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699551567; x=1700156367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHsMBWvJaFMu3UyYKs9v6HLN1W8UaRCCbIY128ntnHg=;
        b=DblzGIoMn0xu2I6TKHcTKIx/Zpa/Lt5oDAzlrtwvRcs0a7bkUdfggyfxGqmGXoRsR5
         DFjXRA+naCYiI4EAPDT0B0+gI8heqjfqXG2D7We334OBI3+XfA566lwcyudFE4LBy+8i
         ByyngfgIWNi7srIAbjY+o1gdgE//5edzo1ehk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551567; x=1700156367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHsMBWvJaFMu3UyYKs9v6HLN1W8UaRCCbIY128ntnHg=;
        b=HstQ1FNCGbgWh4JFpvSpbM8cAY8gnz0Tz01G3NXF8wRxMmLLOCaTfZDLVW1PUlveon
         QiN/nP8PgZYrWJnDtjT0VqfQMoTd4HCKo/GrzWIAER+r2WS2umHmmBRX/EButVewUkTn
         2v4pT5jHpEcL3YCZhBunZ3IrudZlUZtcFTB1wAClYJW5v7lxrESAWk8gJe1rZ/HsKXHL
         9wb0xzzWUHe4/YpmXnPherNkI1EyeiS7AQf0Zqza2yjY1Lng+d3QUgXKs5CPDXJvlb0+
         vmhbltl9Y2A6fcXHDx2nEbxh6sdKNO79gkcHSw4zcGJEXrxjK0fv+uFlz83bqiPLZUsN
         qOKA==
X-Gm-Message-State: AOJu0YyXUCTGo1mnq1ClhHjU3H7lwu+J2y0we5hXZRH/t2be0B7yuGOb
	WpzlpUB4SHgJtkTCCuPnNtF80I8bPpXY7uEf9Kc6ww==
X-Google-Smtp-Source: AGHT+IFGJw4YPwW3PV7z9MFxqOpVAmSL0odGMgecRScHy8m0TEUPehOPSvIipZL7q2ylXOVRlcO7zA==
X-Received: by 2002:a17:906:794a:b0:9c3:b609:7211 with SMTP id l10-20020a170906794a00b009c3b6097211mr5070360ejo.1.1699551567477;
        Thu, 09 Nov 2023 09:39:27 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id kj3-20020a170907764300b009bf7a4d591csm2877687ejc.11.2023.11.09.09.39.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 09:39:26 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9db6cf8309cso195514266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 09:39:26 -0800 (PST)
X-Received: by 2002:a17:907:2cc7:b0:9ae:6a60:81a2 with SMTP id
 hg7-20020a1709072cc700b009ae6a6081a2mr4670918ejc.25.1699551566581; Thu, 09
 Nov 2023 09:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109061932.GA3181489@ZenIV> <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
In-Reply-To: <20231109062056.3181775-17-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 9 Nov 2023 09:39:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
Message-ID: <CAHk-=wgapOW-HfnpE-UEfROxMB6ec84bDUDHcKWxyxp1v1o2Uw@mail.gmail.com>
Subject: Re: [PATCH 17/22] don't try to cut corners in shrink_lock_dentry()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Nov 2023 at 22:23, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  static struct dentry *__lock_parent(struct dentry *dentry)
>  {
>         struct dentry *parent;
> -       rcu_read_lock();
> -       spin_unlock(&dentry->d_lock);
>  again:
>         parent = READ_ONCE(dentry->d_parent);
>         spin_lock(&parent->d_lock);

Can we rename this while at it?

That name *used* to make sense, in that the function was entered with
the dentry lock held, and then it returned with the dentry lock *and*
the parent lock held.

But now you've changed the rules so that the dentry lock is *not* held
at entry, so now the semantics of that function is essentially "lock
dentry and parent". Which I think means that the name should change to
reflect that.

Finally: it does look like most callers actually did hold the dentry
lock, and that you just moved the

        spin_unlock(&dentry->d_lock);

from inside that function to the caller. I don't hate that, but now
that I look at it, I get the feeling that what we *should* have done
is

  static struct dentry *__lock_parent(struct dentry *dentry)
  {
        struct dentry *parent = dentry->d_parent;
        if (try_spin_lock(&parent->d_lock))
                return parent;
        /* Uhhuh - need to get the parent lock first */
        .. old code goes here ..

but that won't work with the new world order.

So I get the feeling that maybe instead of renaming it for the new
semantics, maybe the old semantics of "called with the dentry lock
held" were simply better"

                  Linus

