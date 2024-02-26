Return-Path: <linux-fsdevel+bounces-12833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2327867B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3111C2A36E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3812CDB9;
	Mon, 26 Feb 2024 16:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdXL7ZpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5E12CDA2;
	Mon, 26 Feb 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963948; cv=none; b=Aniutkgnj/Pfv6bUFo7JPEtvQENQ4kOvgrGC9Iqff0w1URJD8i8ttOleHoyNy3ejaRXC7dht39THyHmwlUz1N5ItFx1mFVmdGSKU1ym35/N57NRr2hP/FXzL8K2XEe8P2FRUAOiFCEKyx2FtEdzXjp667gKrNAU5Xiv2K2IulcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963948; c=relaxed/simple;
	bh=tQNiq/mgSFz2PUfr0gE59I6IY0MHAe5YR/fIFXdocZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvCgcKrvgZ0y0xd+FrFdwkJGx9LVZgNfTybn+ZK4xNIr32ZnjyHw1k9gNgJrkROrRgu6YtUxg1i6m8STu1fHwhi5Rng/H7msuVoNdsQxzQGRzNXNwI5p+eNWptor/wB3gCFoZAK7poLIK+XIan6XiG3EUwgXT6H3HXdlUSKXlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdXL7ZpN; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21fed501addso1102786fac.2;
        Mon, 26 Feb 2024 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708963946; x=1709568746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3G9TdB9RDZyiGXRBXvJ+nwad2XnEGLHfMJJdqndI5mg=;
        b=NdXL7ZpNfZwNgvOZRMYu0juBam/1KL5TWe637tCz2P2ZyVtCPAPZTRtRHHBfrXKMRU
         TZPzYjLJxox2wSzXRbQRSnbpqgT3pf6WzzRbXHcw8yR+mYD4diIifaFFL1y7++UkeAxv
         dg1x7hFPYhqCE/Kgp49HJdRzO1SZo58EqHf8xDuYS617NekBgWSWfb0xdPFJ6AyNArTh
         +QTv18RJgzFKePj7r6qsyfDFo0WC+r2UTNcxMtOOtIyjBmW28apJsVkbYTN8tEvW9N1M
         Cl/TDi9Ej7LE0qYZHkCBg+ek/WRwjYn/Ng2/n4NfoOphmQJHItSYOIrQ4JiWsfGcYAew
         YQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708963946; x=1709568746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G9TdB9RDZyiGXRBXvJ+nwad2XnEGLHfMJJdqndI5mg=;
        b=kIXnTe8ynV5uWzGaC4kto+643SOiFTy9vJg861ZBmNzDFbQwCSj34cRmu0nUUl0+V+
         JBetcDUP81hUM/B72KQ6E1uJwc6qShoUSC9JsZgeb+Za17Sny5+eq1R+0rbdz4s58p8N
         1pEZvHilq4euqa8DB1A3vKpBtZGgNa5qSKtLfpoapRA5lFejTAngzt8hVsmovqdnnBuY
         rMZp2ANNflD52gS+b/tfhCP5eUcAfWNcCSeIgQ2Xu6FCkm/mu+1f1hMRpBEAp98NLpR/
         u263+s43zE1oFn/r78vpFM+q27/y4h9ZSK8DG1gFLcAGSGGtBWSYol8jXn791eb5W6sT
         Px1A==
X-Forwarded-Encrypted: i=1; AJvYcCXTguJdLjT1x7SNWAnR4TgR35ZTM9//KMRPktKSD1+IPKKDa+EClvBQtz3+UfkX6wWQFJMHorJ0Fxre7nPqONMS6tgc13en2hv2Mz2GSRiRasbDCdoklfxvNiA8T4RJDfYBrWunwlDyRc/EQxahxFv3phXyB7mUwS5oE/KH9+mLKh1U6BkJ+302xzJriS7YhP1FZiHyXq2xWd53lSWPISuVRQ==
X-Gm-Message-State: AOJu0YxC1fq81hXL1Nbgqz8fIiAWCjjFkSzlDla6ubOWL9b3/PkQClaX
	Fp+omQgAQ0MSulCtgEvmeysyWKfJZTEZRrIAzWgzT9KiP8c4tTlGhMclqVg3XPs=
X-Google-Smtp-Source: AGHT+IF7XFSvjH18bFGEx9CdpnvASYnU/JfYs8/rfFLnUGwRoKon7Rt5YnfmRZ/vr9pQMg4VgCwROQ==
X-Received: by 2002:a05:6870:e413:b0:21f:ca80:52c5 with SMTP id n19-20020a056870e41300b0021fca8052c5mr7306817oag.4.1708963946299;
        Mon, 26 Feb 2024 08:12:26 -0800 (PST)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id xd12-20020a056870ce4c00b0021f86169b99sm1583576oab.43.2024.02.26.08.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 08:12:25 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 26 Feb 2024 10:12:23 -0600
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, 
	dave.hansen@linux.intel.com, gregory.price@memverge.com
Subject: Re: [RFC PATCH 06/20] dev_dax_iomap: Add CONFIG_DEV_DAX_IOMAP kernel
 build parameter
Message-ID: <52dovqfrfdvtwa2l5oiujxoe2e7asbz2qpslq7fb3axf5hdoem@m4j32p6ttrrf>
References: <cover.1708709155.git.john@groves.net>
 <13365680ad42ba718c36b90165c56c3db43e8fdf.1708709155.git.john@groves.net>
 <20240226123416.0000200f@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226123416.0000200f@Huawei.com>

On 24/02/26 12:34PM, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 11:41:50 -0600
> John Groves <John@Groves.net> wrote:
> 
> > Add the CONFIG_DEV_DAX_IOMAP kernel config parameter to control building
> > of the iomap functionality to support fsdax on devdax.
> 
> I would squash with previous patch.
> 
> Only reason I ever see for separate Kconfig patches is when there is something
> complex in the dependencies and you want to talk about it in depth in the
> patch description. That's not true here so no need for separate patch.

Done

Thanks,
John


