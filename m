Return-Path: <linux-fsdevel+bounces-67576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B7C43A76
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 10:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57A3D4E33FE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 09:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC6B2C21F3;
	Sun,  9 Nov 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqdlEX1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0D34D3AA
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679573; cv=none; b=aE8kqba+WaBknLaE0qhC0k3H5B1jPGnBxwWbHzsWa50xLzO825BwCPPxAI9eD06IaJsxocgZBUtyVZjwpde7jwNramVlpnPSEM/aTu1QJfM+SpwoeO4t0/NRPqsgU9GtT4U5zqXjk8zoeYUKV1qxRHXfIV0YGGDLIZEiHi9Gp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679573; c=relaxed/simple;
	bh=QWCG0a2nFdyU8oWHn8UZqoMClk6kw+Cva9o5LsOIgi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivlfMsR5h/D45E5HrD1fEYl8nAZtxtTl+3Qz0K9046Ou6bMmcTJf3i6u4TxM5t/DL7SiCCoE8t+41FlREUF50t0XYvSnv9KAlQzu1bzsxhQeWu1b7ZjW5QBByyAw3ph8+YbFKlZsyAxwv/p/R6HXiKT4rgEfA7H4WMMrKPpYAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqdlEX1v; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787e11ecc61so4332957b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 01:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679571; x=1763284371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QWCG0a2nFdyU8oWHn8UZqoMClk6kw+Cva9o5LsOIgi8=;
        b=WqdlEX1vmvoQ0PVje5fKw1/l+zMVcWl2YXKTYlKOtcRoHqng2iLVPVsaZ7qse3lMHn
         rcR0ZaFw94eSgR/ciwyN/hYomURPgWoj2iNAx3g1uT3wrqVb3OX/eGJX1yTMC7Zta36d
         Pndi4rL/05IZacucHxVkkxl1wv2KU/u8QXlhvWrYPE5EJF1UvhAlr6fSyRf47fyY/+QG
         7auZfpXnA8tdL+fM18oUthE8/U0qHOKDipKXydxFVHDQbRMS0SBpLn39Wy/JMVfrUpX/
         z/IbGVPTP4VHqMSIXyX2dtOQvl4iIzfip8UpjhrnbySeQNB852pD1OP8TsHi0r4Wg4VA
         j67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679571; x=1763284371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWCG0a2nFdyU8oWHn8UZqoMClk6kw+Cva9o5LsOIgi8=;
        b=nNOvzqaltppLKwUAPr22knm2idlFl6RBqiwaNzUVMSh8+QBGBXMIUfhWSN1a5Vpene
         fspmC9OGyUbTERiuh50+10n6YCPKbxEXWDBdDBJSYQzT4OAIxoRdZ9LkEwF8ukoZ660q
         mbAMbx3kF5BFDzweCh+VT55g4kbDHhQ25CbWFqm6k9+AEDOKXsWEG709Kb4YEPq3yZSs
         m1p0QOc5MYHr+DyZIzyA/IXiXvBNTKIve60Q31iCgl4V4kEZgYy2gQFCLLPnRz2llWoc
         C3m1u6p/JSqhzJniVHwN83ZuVHiJ2Y47rxVJknddS1MpoKAlbFK99SIhtndM3ckFvNKt
         B6Qw==
X-Gm-Message-State: AOJu0YzsfsGIbz3bsjpAH5TVALzmi5+UuMQukQgr21dSibtjLQK5xPsm
	oc3KB/ON8oj+xYlnd5bb9EhMAm1KLNf7eb40lUqsT4r7nOV84DsqaahP6zhmWapbLl3yBltGAcM
	uiMzX3I67FY6fYKyyEemcNEeR8gx4Ue0=
X-Gm-Gg: ASbGncsfVUNecpniydJHSpXgKq0rc5ZwyTgBNg7MJJxwuGoibuZlStkbzTEv/s3vILy
	os2IZGqajD0OQWmcePHzXHGB2q1Su3jlWj5F/2gV4qzodiSehQNPHn7FdAv2xogJDi4BP5r8GW0
	OhIUmpvdAS0MLM6ZuzDNnLxOZtoigqI30Wicu5LTCyovxuov/Ksx416MRe/G0uXaPQVx4irdzWI
	EiDRvOIxVe2zJIyX9uQPWydgENQPJkLdETpLMbere+W2H/WpxY9zeqS3B2BWrufbku+ySR8LSmR
	qvTkvaM9S/7vQIoYWwsM52Vh47iO
X-Google-Smtp-Source: AGHT+IGaT5rF2+SipEaF29l6VmCe5k9FUVsdHjbzW+b4OeRMuHc707wmmO2eKS984myzgELMqlCT+JueWyMT2WD0Cx0=
X-Received: by 2002:a05:690e:2458:b0:63f:c019:23bc with SMTP id
 956f58d0204a3-640c9d92a89mr4548475d50.27.1762679570931; Sun, 09 Nov 2025
 01:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251108002658.44272-1-kartikey406@gmail.com>
In-Reply-To: <20251108002658.44272-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 9 Nov 2025 14:42:39 +0530
X-Gm-Features: AWmQ_bmY5EpY_HKdye3B2_DTVHj3n_hWATsiGaGyhS8Ng-AiHROmfF28xg8_L6Q
Message-ID: <CADhLXY6y_kqW3kEbWiBncVv7v+7TgTKaGrBm08HiSQjfUuJGKg@mail.gmail.com>
Subject: Re: [PATCH] fs/nsfs: skip dropping active refs on initial namespaces
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+0b2e79f91ff6579bfa5b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm sending a v2 of this patch with the following changes:

Changes in v2:
- Extended fix to nsproxy_ns_active_get() for consistency
- Added fix for nsfs_evict() to handle initial namespaces
- Updated commit message to reflect all three fixes

After analyzing the code further, I realized that nsproxy_ns_active_get()
has the same issue as nsproxy_ns_active_put() - both will trigger warnings
when operating on initial namespaces. The nsfs_evict() function also needs
the same check.

The v1 patch only fixed nsproxy_ns_active_put(), but for consistency and
completeness, all three functions should skip active reference counting
for initial namespaces.

Thanks,
Deepanshu

