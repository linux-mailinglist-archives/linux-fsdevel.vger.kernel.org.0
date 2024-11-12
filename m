Return-Path: <linux-fsdevel+bounces-34441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C269C57A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B81C1F2234E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A0E1F7795;
	Tue, 12 Nov 2024 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="S6vJXNmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C521CD218
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414311; cv=none; b=exotkUlZkMByRMBE3XocIP9tozaHBgQwI2Rwyzu2T1aUyh4YtNXf5Fv0x1CBdy18HUpJNXuu1L4EGdw87xHXuz1FvERerITxxfYh4Ov5UKjzW8i4fWk6CCAy1XpHk8jVlUWiNkdniw1SRyd8xhtkIR3tgue2tmOuV2/iEBab814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414311; c=relaxed/simple;
	bh=ASY4bPB4Px7WeCr2Y7OxTi1Nmqlpm6jnNhyzgm+Og9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8V7s31aaVoTz7vJvLhsKOWOqXrMjagPIQgSYEZqdNFjTyex8kSgw4pKiK8UOz/qV4cdEVIBQD8nZUlcVaOprILf+z1WFUWjZAZ+cdicp0u5G9psPLgj7keEn6kbktbMHwFs8LjN2Db0/mXiqWMUhp2yxw758utlArjvWCBUqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=S6vJXNmo; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6eca7391be2so6177727b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 04:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731414308; x=1732019108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SV8KkwWhcMq8zPlEHm22sSb2CDAzVzMGoMg1i907Q58=;
        b=S6vJXNmo2QSresLGrx78Xm8LfsEpbNiQeqom4R18ko8FTAY6a0j3wAX210HvJCF+i0
         6gnkNJZ0ifYeheTGxiafcmObZbkbvegHfE2nsDarTgtx4W4Tdwx/Zwrcchca9g9OW/we
         xHxh2vq66KkPxqj0xs9vTPiEV0T7j+4ubKzfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731414308; x=1732019108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SV8KkwWhcMq8zPlEHm22sSb2CDAzVzMGoMg1i907Q58=;
        b=gUklyBsS6J4ASNol9RVOI6b+BHYMT7bvwjZ4KSnoe61j/wkFiLzFZLTaeViQQBtN6e
         lJls92YMNRUSh/Bg9pIV9VgA2XTN1tPChLaXNA+p8LzmEPnynVfUViXIV4zGnck2rY6h
         BkZ/i78Bb7aKnWu+OFYJSFE9Pk5SSUN0nJCG3LZa0qQ6EX9Egl80hMLiwgGVXRoeyeoP
         PZDGwr8PYPY10mErKj1ylZdj7A8xnJP0Hp8rTbm2uBGYEPVR4dF7DFqSG2Cjxjs25JcQ
         osjKHZhjVacg10XtF+NyzdNNX9mJpgHl0msvAfIP5nOZVUONkBqQPN5iJSIySAFj5zqU
         O/ig==
X-Forwarded-Encrypted: i=1; AJvYcCW8AEMG3u6NtrXYyr98DmEZibsxGztuPNT8/WtEYZZWPg84ZYSKGH/ROXWV0HG9V9hyWW4qRWFFHkr74Td0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/YycVI+NpYiPAND2MqI2VtjygXGAcDI7VaBw/NGY6rscuTXRl
	RGWjmTehtrwK5CVpoS7aqy1HoPkUFgHk+xTDNIwtbU6fCZabTDRkK/YNDmvJfrs6BFabNbwE2/Q
	FNriKmr7Nn7Jmow2V/FtRJO3AERav2g4MFtCELA==
X-Google-Smtp-Source: AGHT+IH91Dxxf/wxCv1pPjNNDhur8wmwHI+0WV4WNH/+V3HOygot9pF0w2WhVaMIfGLaYWXy7ScCadmt9eCymc58cPs=
X-Received: by 2002:a05:690c:4d89:b0:6ea:4d3f:df9d with SMTP id
 00721157ae682-6eaddd71c30mr157563907b3.4.1731414308586; Tue, 12 Nov 2024
 04:25:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101006.30715-1-mszeredi@redhat.com> <2faa89f0ad18d8f8015f65b202f8ddc64a810a71.camel@kernel.org>
In-Reply-To: <2faa89f0ad18d8f8015f65b202f8ddc64a810a71.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Nov 2024 13:24:57 +0100
Message-ID: <CAJfpegso0Rd8DK0BYAPgSCHKJgbYX2iO7d4qMqGifBuGFaoE9A@mail.gmail.com>
Subject: Re: [PATCH] statmount: add flag to retrieve unescaped options
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <christian@brauner.io>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 13:20, Jeff Layton <jlayton@kernel.org> wrote:

> If the options are separated by NULs, how does userland know where to
> stop?

The number of options is returned in st->opt_num.  I find that clearer
than returning the end offset.

Thanks,
Miklos

