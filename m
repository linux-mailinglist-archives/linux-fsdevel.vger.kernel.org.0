Return-Path: <linux-fsdevel+bounces-20245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD2D8D05EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E261F22BA3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194F17E8EF;
	Mon, 27 May 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OAXObq4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7417E8E1
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822978; cv=none; b=Wc63YDXykO2ANDPBxrufQYqw6s3KSaIm84hnAo1HTpoYQ7oSMdfn1Gx8xgFmekx8ZJOJeHq75dm8GT/v37zElGq5nsfE1EvLFhCBLQxbdcvbeZq4C4vej8jHpkdPYzvIvdov4jQCKRzWNUYrKXQCJxIeojwquxdDHmIhUeDrnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822978; c=relaxed/simple;
	bh=Mfab1wlTcrfHOq4QzyYKutCzme+N546cG/tVBwzXKqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/5ZHpuUczhuylAA14AS8/+FhSoqxk9ZNrQSIFmVEXgHpV59Ny/240hmBPXpcUreVqQLEOdayAkqB5OOiatRvfgngPYVgdYVXrJbor04ovn2lJO4OWyD0UablPgrIh9fMF0upiZlfbMbYxsQ4RW3F5bmBpCd4GBxiiL6esUup1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OAXObq4y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59a609dd3fso952849366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716822975; x=1717427775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BvC1zfg/fxrPixz1lr0GqEGtLQO3D5juXBD24V7rLZE=;
        b=OAXObq4yMeP/YlzcAXdA7AcoASOTWQFhSq57tLua6Qbcl+NH8o6OG286T/27/O9ll3
         OHd0cKDTZ4SBl02JqndcSpv/L6C2oeoVvwuwf46EQzyE1h5qUH3Lnkg76dcA+5PLaJCB
         WSPL1uEzMNPDqVHGHTQlneisY6vsJJmn68/AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716822975; x=1717427775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvC1zfg/fxrPixz1lr0GqEGtLQO3D5juXBD24V7rLZE=;
        b=GSA4veDAZw0Gr/x1E9TZ8M6xxV8CLNaY3Huooao5Vl/IilY6sekME/T9PqANpBJ+0C
         dmoLhC/5ua+kEJu3IMMQ7SakNgzMy6DaPgGnaYL4Q1DCKMiPRWCrK4z+ksR8xWUSCBJn
         IJU3/fh6AyYtl8usc/5mLlZs8AZZdKeQyOm3ZVRjZ2+ZNPsoI7J6okNVLP/dpMGygrbq
         AiQlpt3XHK9xRBJ42lLdRyDJDS8uOjqEVpR6GU/6gEzBWoX2KYQYAdgnVJzl6ortu3oh
         i4uBLyx1WegOEuv8pFvAzD57PwHShVEt2N5KxwzaR15eU3pjCnVjUOZOaTrlzx71M/8R
         YUjw==
X-Gm-Message-State: AOJu0YyQnCnTRevRtKlYll6CV1BE8VVjw84e/W23xXQnlgoDiiDO/yI7
	/BBtf86whLZoM6wvy/XKknVPiCN2PnuIiVojIMmGoL6qwx/XMfV35Hc0QZwhYaha+mXmyzXyDVW
	WZc1a8LgBNnWS9yQO4RwbNxDShLPNedsP0qIRpw==
X-Google-Smtp-Source: AGHT+IGgODC8mk6Jfe7HWAhEsx6JCqwEkT7y/qw9TTzaX7m6hiD0fbq7AAPet1JF1Iesky9CRfTe08RoJsHUtxihnhs=
X-Received: by 2002:a17:906:2342:b0:a5a:7a1:5da3 with SMTP id
 a640c23a62f3a-a62608a271bmr867614966b.0.1716822975029; Mon, 27 May 2024
 08:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20240524064030.4944-1-jefflexu@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 27 May 2024 17:16:03 +0200
Message-ID: <CAJfpeguS3PBi-rNtnR2KH1ZS1t4s2HnB_pt4UvnN1orvkhpMew@mail.gmail.com>
Subject: Re: [RFC 0/2] fuse: introduce fuse server recovery mechanism
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	winters.zc@antgroup.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 08:40, Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> 3. I don't know if a kernel based recovery mechanism is welcome on the
> community side.  Any comment is welcome.  Thanks!

I'd prefer something external to fuse.

Maybe a kernel based fdstore (lifetime connected to that of the
container) would a useful service more generally?

Thanks,
Miklos

