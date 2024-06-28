Return-Path: <linux-fsdevel+bounces-22798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CB91C556
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 20:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D06E1C2347C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0993FBA5;
	Fri, 28 Jun 2024 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vszuAW3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEB529CE8
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597790; cv=none; b=iyGdg8fB6IYIrFuRfb9t3RXwow9LR2rqk1RiINvdO/mW5U+FOGRwG1IyOcWReYZz94bMU5824Zl7jOPO2/1woYGnP6T7YkbuWvoP4nOq6lH+QaBpNIfpByTI/Ez/u6WNGnBmEjizczNXDYb1Ld0WdwCR7R1T/QjUmQ2jCZca3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597790; c=relaxed/simple;
	bh=2nmDhTEXBlBqysNn6CJRmhA1goRfAzUK4E0uW20iD1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWaL6Q57Vh6GXv4ll/ZuJk36fzhn1tCG9+UKXzH1iD4PjQYYxbmyHQp7J5N+k8kUuQmxoTUNzSNl0wVOJA/4ksTB09YhpLn4PdPmqY38HZaG1XAJ4HT6bICjNFPoSFNyRsPDEakHM3sII07xybTty2yVFXaHfIIuJp8XiKRZ6+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vszuAW3y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44636bd6e22so6632761cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719597787; x=1720202587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RyJKu3yykbyCChe58O+TS4lDJ+LY6NpOBcK6m4zrWew=;
        b=vszuAW3yfXHGtQEekDl+Cq9se3Os99Nc2hURlrpT/pB2e+Ys4qtjezI5M1zy6x+A2u
         m4nNsvZYvNT/ibogGmzM40aEoa/h67RExvsC8mvE1LfujmKlE4mwXn5pSVWthOTec0fx
         S1uzXsPiBmBjSERmanyJafQfMrC4qZY53NjGKQWwYvgoA1xz1u9MH5d+ARf/FMfewDgP
         SDtI0lyvQaD3wNRUKLnMY5JI4RjxdvrViULiSgBPARgAq18PFXVxs2UwciqWAoQuGr4u
         covQ2dgmJ4bB1JTCdNiOh4r8pYH+hhxHd9u6zqZyYHeQbOodNKv0TXs09R+0hOp6nvAO
         jpwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719597787; x=1720202587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyJKu3yykbyCChe58O+TS4lDJ+LY6NpOBcK6m4zrWew=;
        b=ka6MjVkglS9Z36liCrVkz2YBV0eezHl/5UhTM2ViZ02NYhJExg6eAJiaO0rd0pQzuE
         cVquPSxiTPGiI3qLVuHHHpl7QLz9RB1EzoxEfWlX02SQ1J/WMxTofSabssKqdLnjCNFX
         4307kK68C7QrzVn1YIWC9Y7f1tl6NWkFS3CSEo+c3OAkUS++lFzgm0vM22BVeBfk0fqk
         cVuVfOntpDNlmfNaIJtESWdALVhmSUGwAQ5wAhErlNJIWjIOMRB3qU+wXxbDSaJ+T4C2
         9a7/+ldvzpQdBGPHrI5zPdn9vBRwYabhMFG7XfvQAcfkJ4Be4jeBFl91QFE6Mx4CCGay
         gXpg==
X-Forwarded-Encrypted: i=1; AJvYcCXmq75xqpaYOYGq1Sm3bE2dh08AHap0O7vNdzX0lFpHCEZw8IFVY5lSI6lh3zuIuKYerWtGBGHKO1J6wQOgoim+XOWdJPlB7xnH3Bv5YA==
X-Gm-Message-State: AOJu0YwdN8yQfdwkEZq+M4IqIQyEixYUVTM/nU5ZAyXE/kIfCxxNxZcY
	OojAdvWM7yHhpgGLsfWya/0qOMRK46S9iKqjZJUexd+rb0yNEgHWgC4WSNhQhLQ=
X-Google-Smtp-Source: AGHT+IH/ES6pbyl5KE3HBQZZ+Id28eqCG0vMNKC8kDxcYaYIdWpWsHGf5+MD/UZ7EpOVTceKSbRS/A==
X-Received: by 2002:a05:622a:1904:b0:43f:a025:d275 with SMTP id d75a77b69052e-444d393abbbmr217791781cf.9.1719597787110;
        Fri, 28 Jun 2024 11:03:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651408b32sm9101691cf.23.2024.06.28.11.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:03:06 -0700 (PDT)
Date: Fri, 28 Jun 2024 14:03:05 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@osandov.com,
	laoji.jx@alibaba-inc.com, kernel-team@meta.com
Subject: Re: [PATCH] fuse: Enable dynamic configuration of FUSE_MAX_MAX_PAGES
Message-ID: <20240628180305.GA413049@perftesting>
References: <20240628001355.243805-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628001355.243805-1-joannelkoong@gmail.com>

On Thu, Jun 27, 2024 at 05:13:55PM -0700, Joanne Koong wrote:
> Introduce the capability to dynamically configure the FUSE_MAX_MAX_PAGES
> limit through a sysctl. This enhancement allows system administrators to
> adjust the value based on system-specific requirements.
> 
> This removes the previous static limit of 256 max pages, which limits
> the max write size of a request to 1 MiB (on 4096 pagesize systems).
> Having the ability to up the max write size beyond 1 MiB allows for the
> perf improvements detailed in this thread [1].
> 
> $ sysctl -a | grep fuse_max_max_pages
> fs.fuse.fuse_max_max_pages = 256
> 
> $ sysctl -n fs.fuse.fuse_max_max_pages
> 256
> 
> $ echo 1024 | sudo tee /proc/sys/fs/fuse/fuse_max_max_pages
> 1024
> 
> $ sysctl -n fs.fuse.fuse_max_max_pages
> 1024
> 
> [1] https://lore.kernel.org/linux-fsdevel/20240124070512.52207-1-jefflexu@linux.alibaba.com/T/#u
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Overall the change is great, and I see why you named it the way you did, but I
think may be 'fuse_max_pages_limit' may be a better name?  The original constant
name wasn't great, but it was fine in its context.  I think having it as an
interface we should name it something less silly.

I'm not married to this thought, what do the rest of you think?  Whatever name
we settle on is fine, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

once we settle on the right name for this.  Thanks,

Josef

