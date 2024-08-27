Return-Path: <linux-fsdevel+bounces-27353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DA96081A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 13:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F8A1F2389A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE7B19DF97;
	Tue, 27 Aug 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IgFW6yYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B61158D9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756618; cv=none; b=LiJugynI0izeAxm/dBDkD15/1U7FAQQBYPoJqusN+mrZkonItZf5rk36cg1Fa0OCv923EIeM0r2QBoihhHNQY77P+1PgZK8yxzxdUUoLDcX1gRnuaF0xwenbRKWQ5TWdQpRXOmij3wIP+dNddq1tU9AyNoScKfYVM3AH0xLRSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756618; c=relaxed/simple;
	bh=xvZII4caJcgeweZF6xeJaPYQ9qDMCjswfFfgR+4FA88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwUo4+YSNzeLhPxYWv6LBM7XznOFUKbya1ihNZElJlQrab2/R5WpfEjh6/di0+OBkOZwYyIvawQ/yub0/7FRIKljhat3YHr276sMT7ScLp8J4dE1CrjzRQuQOPUQulSv/jU2Y72nNf+WY1SIiOT0Krtar9WKgRmjvCQv7Ws/rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=IgFW6yYU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70942ebcc29so4913063a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724756616; x=1725361416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=IgFW6yYU0rLSLhTJEYPvVYLGL+RDHctUtvoojqVr3vAZZ4f0+he45o/A3Dq5CaRUEM
         4upYWOse2jKVQtcrTlnhFRR5qjluZ4Hkh8bwB/eY6C5m2IZ4TMbNp6FZxKTbTHDEWqlq
         GRj40FTUhxlsEOK/WvrdXwjuv/ajBUnyFvaFzrnCPi5117nJozJdzN74VkZ0jm8YA19y
         pOAHS1IdiAXvuHGG5dWES4+M5P/sO7aaWLLhCub2KPWtnFd5+e4A6hhNk3EOyKN30IJH
         3NYylReh60wvPNLscGqLS25dFhENj/WpMcmmqA2IZzd/m+GuJfAZz8TYuqIw10w7InG6
         SU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756616; x=1725361416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=BhAK7HLLRGGmVU0tntACpCkVYyVEyMpR2hvwD8Bk2lIdZzog2xj8Bp1RQQiauQBOa6
         dMeY+lrfDOMBpPrJNLtsUZY/GpaYCn0AmgalV4EdjhpxKsZNEo2DZ2ZorlzeIhV3WY1k
         KdOJC+M8uKkRTus8Xs2VeGuTooM7+XZ6DZxJgewERw1mjx/+aCfPjiVsxC+tVTzqnaEl
         aTI20mqZ02pqgIqqL8QZr8RVYOjB9HrHozPMwj2iHZZxLc+U0Nyvr90Ah7Z/0oq3o2oP
         DZlSfdcA+4GcPeAwNAAC81ib45Jtu+I+KWyi7IX/Es2QYxOVOeODPkjHf1ZGdV3n3Vis
         1YQw==
X-Gm-Message-State: AOJu0YyGrbzJrAo8e2obXWCeP+sjZ9haWw9REZ6XCsdY3MH0ZSbZWWe7
	XE0nlAvi08n+3azcygTULFJ9cMPNPS7+7gb5uG8lnia4LA4Lpu77v255Sf2GPiAS4O6vUBSTy9H
	W
X-Google-Smtp-Source: AGHT+IF4qNHXWkmCySjIoxZw6q+2LEaErol9CphZ5YD0qyPKn6n7vFU0PYNhP5cbC3GrrXP25hlwYw==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id 46e09a7af769-70e0eb37e5bmr16117729a34.16.1724756615938;
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d21710sm55059366d6.11.2024.08.27.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:03:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org,
	dlemoal@kernel.org, djwong@kernel.org, brauner@kernel.org
Subject: Re: [PATCH][RFC] iomap: add a private argument for
 iomap_file_buffered_write
Message-ID: <20240827110334.GC2466167@perftesting>
References: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
 <Zs2wl4u72hxRq_VU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2wl4u72hxRq_VU@infradead.org>

On Tue, Aug 27, 2024 at 03:55:19AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 06:51:36AM -0400, Josef Bacik wrote:
> > In order to switch fuse over to using iomap for buffered writes we need
> > to be able to have the struct file for the original write, in case we
> > have to read in the page to make it uptodate.  Handle this by using the
> > existing private field in the iomap_iter, and add the argument to
> > iomap_file_buffered_write.  This will allow us to pass the file in
> > through the iomap buffered write path, and is flexible for any other
> > file systems needs.
> 
> No, we need my version of this :)
> 
> http://git.infradead.org/?p=users/hch/xfs.git;a=commitdiff;h=84e044c2d18b2ba8ca6b8001d7cec54d3c972e89
> 

Hooray I'm not an idiot!  Thanks,

Josef

