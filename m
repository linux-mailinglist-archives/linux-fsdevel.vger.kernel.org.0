Return-Path: <linux-fsdevel+bounces-31159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E03992957
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 12:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239FD1C22AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 10:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875121C0DED;
	Mon,  7 Oct 2024 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EOy9DKHT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E118B476
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297486; cv=none; b=EEpMJQbpJw6rFs0J14Jinub7KVjl8GImwz59rZ5mwGDdz5CsjS6SL/wZIIa6xk+JmHnepwArFpCRw/B6Ztf3LXJo1ZJKtltJeAmwUvk2s6ZYyBiry6FssOG7jO68//mmuBYD7Olc7eeYxaJk1slicAKiAAkz1mmU8AhnB0KPd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297486; c=relaxed/simple;
	bh=KcBXz/uybt/pMRpBba6VfSlLw6yHjpbs/Xqzmttq3To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhpFfjugnSy7xAlXEqMVN3GLHkAnSLPCkuZ3za5XMMaWW664Xf0yo3QLIwGxhjxaW5nawUiTFe4K7wMhXjgG/qMho+cDQwsPoi+zH6NaWUlhPifk2zqx7lGsCDxheo02mKwVAtXGZAlBkv3tUftBrgqsE4DJX9Nyz8XbV65JqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EOy9DKHT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso5440866a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1728297483; x=1728902283; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KcBXz/uybt/pMRpBba6VfSlLw6yHjpbs/Xqzmttq3To=;
        b=EOy9DKHTxwnf4N3MAUqJH7OWBYtjjVi9VgV+eAqTkjRY7AiyREDxuAcg5C2Wf5z6h4
         duBEjooGLAiRp7F9dRin+u0KgCnGJ/TeMm3sTDWm6mvbtPyp2OTUsIEPnZRjYJU/T4G3
         qjqykztqUS2iZXsVPkTrO+hKd6va5MlUi0ZqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728297483; x=1728902283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcBXz/uybt/pMRpBba6VfSlLw6yHjpbs/Xqzmttq3To=;
        b=FHUbMICXLS0UEJqh5w6P4EYFnaEBwa+thLgyT3dGjvKQt13ZL2+cDkN75F89dZm2VL
         dB4lm8xZlhoHU+rjcJea4fVvFicS56jRfTsocXII5ebpAZvMm8CbvIDEQxy2sF+gK+Lb
         /SAdmVv0DyaOELsP5SfFVU94OM0nK4uQsITAuYwlgih+y2SLpZ2XOTz/yPId6AnJfHhL
         +k5ZQI9ryhRc2ZaimvSsH4G3FpCaBRTneZTem0k5JVA+rRU9i/MnTC69LnfVNlX0xhPb
         OAFx4JtasvoZ8GcTTRCmEb5he3I/0DN5fXHwhU0t7LKQb5UtOTUdCB++g2AUuAYBVBzX
         XMZg==
X-Forwarded-Encrypted: i=1; AJvYcCVeLnCBJ5gpd2/2KpO0pO4UX29qxECaW5CalhV6v5QAKJRBIQaEbYVm3vru2PMXEmQX+vLf4+zvB+Ho3UDW@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq87elZxB8N46lm5daMmxbbpigQ12/x6gVToD1LjsB0iUP4bIu
	bjwRTeS44Y3/mAnrjUpwJZk+dqpn1brzUkozXXNCj3x9wa13eX33i2rlVS1n5bNDkrBcGanGGNn
	RtfLQ2WsvAB2zAMJHzilf2TthuEQjfgQUb2dN2pAlPXbURZ0g
X-Google-Smtp-Source: AGHT+IGpyxoLXtigYDI7xrLRQKKXT426ZiVy9y7DfppHasg9YE7THH+uCYZsoPmIVI7wzdg224iFIcDIVEtyX2QLWQ0=
X-Received: by 2002:a17:907:8694:b0:a99:3802:1c37 with SMTP id
 a640c23a62f3a-a99380220f6mr785842366b.20.1728297482810; Mon, 07 Oct 2024
 03:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006082359.263755-1-amir73il@gmail.com> <CAJfpegsrwq8GCACdqCG3jx5zBVWC4DRp4+uvQjYAsttr5SuqQw@mail.gmail.com>
 <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjxLRuVEXhY1z_7x-u=Yui4sC8m0NU83e0dLggRLSXHRA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 7 Oct 2024 12:37:51 +0200
Message-ID: <CAJfpegvbAsRu-ncwZcr-FTpst4Qq_ygrp3L7T5X4a2YiODZ4yg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Stash overlay real upper file in backing_file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 12:22, Amir Goldstein <amir73il@gmail.com> wrote:

> Maybe it is more straightforward, I can go with that, but it
> feels like a waste not to use the space in backing_file,
> so let me first try to convince you otherwise.

Is it not a much bigger waste to allocate backing_file with kmalloc()
instead of kmem_cache_alloc()?

> IMO, this is not a layer violation at all.
> The way I perceive struct backing_file is as an inheritance from struct file,
> similar to the way that ovl_inode is an inheritance from vfs_inode.

That sounds about right.

> You can say that backing_file_user_path() is the layer violation, having
> the vfs peek into the ovl layer above it, but backing_file_private_ptr()
> is the opposite - it is used only by the layer that allocated backing_file,
> so it is just like saying that a struct file has a single private_data, while
> the inherited generic backing_file can store two private_data pointers.
>
> What's wrong with that?

It feels wrong to me, because lowerfile's backing_file is just a
convenient place to stash a completely unrelated pointer into.

Furthermore private_data pointers lack type safety with all the
problems that entails.

Thanks,
Miklos

