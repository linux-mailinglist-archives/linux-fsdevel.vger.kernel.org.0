Return-Path: <linux-fsdevel+bounces-46307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C856DA8680A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 23:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992CE9A17CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323629615F;
	Fri, 11 Apr 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3cEqeT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0F29614A;
	Fri, 11 Apr 2025 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406124; cv=none; b=icFLBNSs9fPtrSIoU071R2mrXkvGaCDGDyhPuXxx96FgifomVeYjU5NMua2qPBo/Aw6dPg8o4C9ZS4OvnW885FcUszL+jBx9k/nc5J3SbreqM60hrf3mlPzIsolnfoDx81pJ9I6G7SBXz1tul7TzJlZIKt5jU+M3eVv1K1L2avs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406124; c=relaxed/simple;
	bh=zUAbfaDi+mFMIZ9/oYPb7idFOR0R4eD4ad4u+ZuUC9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOkpXyK/BKgDDEd6b9cZKdXzxJLGJYiiO2T7406c/k7yu78MJS3FVOknw8++AxImnRr8+7hRbf2plHC0uUjgCS6tLA8kz2TUhN+hmnE425d6aJWa8T/6h8BCskkhePc/WjzuCSlQUpxHFdDFeYRxtx7DQtWKvEgECM+1J/4B+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3cEqeT4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf848528aso19244535e9.2;
        Fri, 11 Apr 2025 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744406121; x=1745010921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPK+H6sOhTLm30dsqOJGvaQCZuKrA5gTcKcyNfzVAVg=;
        b=E3cEqeT4gXKXaZjMbwDlPAGeTzICVOyGvCiqN0dzJWLFZ4goiEIf5vCqahBuL3EzXs
         Z3pBIbD6M47jq4mhPlF+Q7gOWlF4y9PEzFBp2egR8QQKuEa0lY6Cy0D2gFVRX9cd9sDc
         RAIsNQV6RiAatISbeU1CMjMdZcO6yTHJqDpQieVoz8Qx5/wX75v+9K7ya4c06Hhxb1uB
         zzm5dIWZOMJxlzpCj8io4L1uPB5rWH/VudiWXxh40YGQLx2bKplr2HJCqMYhQwfRsfH+
         VXAz4u1KlJsY3gPQE8zMWMuiyiyIeBAw9B5J/NqQo4k7btkFObDuVOfbGj3vFJtAlZcQ
         SW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744406121; x=1745010921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPK+H6sOhTLm30dsqOJGvaQCZuKrA5gTcKcyNfzVAVg=;
        b=jalcGZ+qmmM9nSqfKuVUoXaCu8vh8X03GX9Ea2KdSt6EZMbG1vhsuanonBn/NS9rFl
         1Z1Y8hZlXysMZgqjSLARE0eZ5vhDSq8YsAmxFMbzb8YWtD8meETe1oFtO+Yb4d1+LoqG
         8fUGfsUHKxhYIwQBLb1b6jAVa2jwc3CO6ws7pfXsmejdBTl3gbycwS7suJMZz4ullXcS
         gPurfy7Ofk2ScNmMg0TVNFXUeEE39fC02739h1DaHhaZiK7C/eXepB1rv+MScqki4rxb
         7XAmhJU77I/pTjXm0I35IVlS0cmLJYOnudKp7GKFg6WRLKSbd0xKXIh6f4YJlbMbp4sf
         i26Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXC+l6I/AjMxsfWEC1owRy4DYWxvhJtwkhS4zP159hoA3ehh3offh8YZbz+z8jaw+9Bw9nUcooav7aWP1E@vger.kernel.org, AJvYcCXj215fnAo3IgOpQXeCjxySxeA8NLMtttvLk+/SgOJrZD/8MWPHnGK4AK60dhsWhKtdxWjTqNtsP5jIrHk3@vger.kernel.org
X-Gm-Message-State: AOJu0YwZApHzMcnyJDs1r9Nch3BtyizgDVE9Ocav3mBNvAxRONH3dJ73
	sSlzKTenNJpdU7ponQbBQVMNYVKyEbI3rpAq2688fAaifEpVHATA
X-Gm-Gg: ASbGncu8LaLhEWmQXeyAnq4dohPTFfAYoZLSOmAu0EWwtUGeIP1wMUy06IAe9BdwhEO
	bqB5HDKpp2KFI8H8X4vfTTcsM5T33h+DD4ZAMbn3M24wQNez/Jc/Kk/MKo6fbTpWZiqCTe0xI/0
	asb0FDLwLAtGbisdLhBd5FpEtEskYkHgTY07bdPF77HJ/Z0nmats/5JTl0gVkX+XyAPC4HMIoqb
	zO8gxEDYi/hAKHXBxG4iWHPxBLtV6D15+W8LtqWacHz9jfIbS1j8PIEDWJ6zHgSlcDsiVbEjGw3
	TOdalNx2T6m5LhJ692S9ddNEGUGtJZQR8K3kP7H1WameKPV4FXToIUshBJrFJlU5
X-Google-Smtp-Source: AGHT+IEgeIHzXRmIqmpC5LyYH+Jtr/lT2cTeX/UOjaeIsufaoxo9zBEh6F6AvgV6eCmVOW+48CAP6Q==
X-Received: by 2002:a05:600c:46d1:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43f3a93cc34mr43776805e9.10.1744406120863;
        Fri, 11 Apr 2025 14:15:20 -0700 (PDT)
Received: from f (cst-prg-90-20.cust.vodafone.cz. [46.135.90.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43cd17sm3157603f8f.78.2025.04.11.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 14:15:20 -0700 (PDT)
Date: Fri, 11 Apr 2025 23:15:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: lirongqing <lirongqing@baidu.com>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Make file-nr output the total allocated file handles
Message-ID: <p6rnvi5kvu7zwk6ypui2gwezvg3onqeqajwtw6uksv4jagannh@q2mx54icpmig>
References: <20250410112117.2851-1-lirongqing@baidu.com>
 <20250411-gejagt-gelistet-88c56be455d1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250411-gejagt-gelistet-88c56be455d1@brauner>

On Fri, Apr 11, 2025 at 04:16:08PM +0200, Christian Brauner wrote:
> On Thu, Apr 10, 2025 at 07:21:17PM +0800, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Make file-nr output the total allocated file handles, not per-cpu
> > cache number, it's more precise, and not in hot path
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> 
> That means grabbing a lock suddenly. Is there an actual use-case
> behind this?
> 

The centralized value can be really grossly inaccurate as CPU count increases.

There is some talks about fixing that, see:
https://lore.kernel.org/linux-mm/20250410175149.1206995-1-mathieu.desnoyers@efficios.com/

In the meantime, given that this is only accessed when reading the /proc
file, this should be fine?

Note it still wont delay bumps/decs as long as they fit the batch (which
is the common case).

