Return-Path: <linux-fsdevel+bounces-27513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EB4961D9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD94D1C22850
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A7B145FFF;
	Wed, 28 Aug 2024 04:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="JpRRRx5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD613D50C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 04:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724819280; cv=none; b=GxnFxaNdHWZZFMv05sWFCSgEEDYyyLrUEunZ51KnGbfF9HkAgXKGLgsqZgXPX5w1foT2vYn9OOziYNd3S0sfI7lBFMjQ2zLKbsF60x4/xHYotUer2E7wvYIxxhbGxLcEG9CcUjaASP7wW+hqh2UjUN8nGFedUlCnfiUePcBCxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724819280; c=relaxed/simple;
	bh=ZlMPopBn96w/wp5PbfqgFb+71Z0K3fsuwD0T/IVa/dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBeYTzbivFelDgRmY3ZhV43LjIgvJcg50yI279uM4gn9QckTmsRH2tyCXShOttVNUpROuV3LLkssvMOGkLo9GbtrJq3FlWQ9bBjynEbEJoOuEo/9NzXWyD/aH6gi0kjpwojyGxI6T1qg25YN5AQUJ/GWTy1n8VRZo8RIWYsSXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=JpRRRx5g; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3c396787cso5155944a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 21:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724819277; x=1725424077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLKoOoZWQgRDxe64D4pf1IqVkTX7eHcZrMx3Ug8cC6Q=;
        b=JpRRRx5g8vSG59bMgJ4mGDXeMZitcUwBZWvB1l3NDpPuQiktdM7AsVtpzQto7+9Utt
         +3MQXRDIbUcK62u/2WZxK+WQCFF7KAeicFrt6vTJPBofb+wulTyr1WMC7J77+T7stfU9
         rzGhHduaRZPigEAOShpGhUOfYm/1zyP3fvFzOFCCfzbYup5/9bLPYCBMVrQX9xDdhOO+
         MpCozZqkN0XIvXlcB1v+VGbWZB9nHg/lWGRP20dQyyPijNMvwm0+RKK3xfCjM4n4Al8y
         xF51hmIjxX66DdadStbF50XfcJdqgWx6GCMfLGfHRONqt8g7d3wBld+HIRA+CQxTaMF1
         N3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724819277; x=1725424077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLKoOoZWQgRDxe64D4pf1IqVkTX7eHcZrMx3Ug8cC6Q=;
        b=HoUJh7Ru1mfQgJonB8k+ET5X3ObSl8ZC+377DPYOj5PpxHZq5XwAffyl4A7H85BKBc
         26tNUHvlfbAEtcOhWzpJidWxY0qzLiZJIT6GaevNzuatL5DQtAWnhVvFr0XbgWcNnT2q
         Kqz4UFcz5kbWGlFE3Q00JJek9xGxss8eTIS0kY4k9sKiSz3Bjo9kkM7SoNPXRhEHRe9H
         uZf7N9jo4h7DVPq3xCQLe/TcNooFyFi2F++35RsLTvLyd0K8Fz2PzQvXB+fFPhCChQX2
         RTDdVkdxyXP6ZOeaw2XbGaImehHJt0iNRgGKbmFtQvWkhIi7Cn1R6TfhPkkNkalGx1MC
         w2cg==
X-Forwarded-Encrypted: i=1; AJvYcCVfOhusS0+ja8JPSxIIh6vCkfy2v/5CtgVYsRKy87AmhWIQZGCE7BJzY7uA+lnltoSX43+dUh3SIAJ+Yl05@vger.kernel.org
X-Gm-Message-State: AOJu0YwUlhhVyHMQ/7T2f9A5dh8/aCf2/mxXiCWV+JPE7jirNRR3bbg7
	a0DtuAWx2LAr4lNm+s5QVYujLvOy0Uzblf+U/WIlgYFfjnT5bMRX6DMmsy1lwXE=
X-Google-Smtp-Source: AGHT+IG5A/pCpM7IMY/kGxijzm+NVIWr1BVWJeft0Hf7TZAyR5DmmphX2dEVoYsNjBgMuW+9RUOLcQ==
X-Received: by 2002:a17:90a:cc14:b0:2cd:40ef:4763 with SMTP id 98e67ed59e1d1-2d646bcc060mr16030603a91.15.1724819277264;
        Tue, 27 Aug 2024 21:27:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445d8afdsm469664a91.2.2024.08.27.21.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 21:27:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjAHh-00FKuw-36;
	Wed, 28 Aug 2024 14:27:53 +1000
Date: Wed, 28 Aug 2024 14:27:53 +1000
From: Dave Chinner <david@fromorbit.com>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk,
	gnoack@google.com, mic@digikod.net, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs
 directly
Message-ID: <Zs6nSe1cwmoWu5RD@dread.disaster.area>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827014108.222719-1-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 01:41:08AM +0000, Hongbo Li wrote:
> Many mainstream file systems already support the GETVERSION ioctl,
> and their implementations are completely the same, essentially
> just obtain the value of i_generation. We think this ioctl can be
> implemented at the VFS layer, so the file systems do not need to
> implement it individually.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Nope. No. Definitely not.

I definitely do not want unprivileged users to be able to construct
arbitrary file handles in userspace.....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

