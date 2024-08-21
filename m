Return-Path: <linux-fsdevel+bounces-26533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976795A52B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C142830D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43B157A4D;
	Wed, 21 Aug 2024 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YOurX9ri"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE123A31
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267736; cv=none; b=qs6vNlGXV57SBIUDMzuMw7b2hFYttgDD5SD8lmA55PMDFGJ1/edjgTU/h1gCJuPvCf55/D695hUXuo6J1KE73vCaL5tN9yVDVNurCUPifSYv1CS2jMU3AKRS82iKk+9RZ8cXg9WTA7wkuHgx3JckFk5UoVr4IEqgkz7KwJ5Ggeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267736; c=relaxed/simple;
	bh=PxTe27JE+FYaihJtRHGvpde9wJQt1ER1jrP7iHSJXxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkPriNKLjZ8pLZqIBS5WoD0qpldxOHM77u7FmNukBwYRvYi0i3kkNEDilc65vYZ2T6f4WhWivi+YhDPgfdy6s+DRnJNd08JLK65UGDB5+1zMnISE1eP5/h2vVDnyYJK2/aReDgOxJeb8e6qR/9Gay4fLe4OFdKJfBCkgtxQxQcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YOurX9ri; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e115eb44752so97338276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724267734; x=1724872534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p2PBgehBoEdSNfyG1k90YKnC+vOI2d8jNmmyfOGuvuQ=;
        b=YOurX9rifn4Yc1X3sM0Oby/IFezFG/bWDT0kF9REcfMgT5WpAtONZbOBKmXvJ8VXOD
         qc7kjyFmJ1q2tmZUG3uh3WovXNkj0NmU6ms0150fdKT1FdVADBWQtkXU/lMSQCqxPhuH
         J6TsSwqxz5B2xBTayIAG8bAJBEuSCCXPnBeoDM8NLyIrA0t1s4qyc3XGzS0/tpjO0luh
         cEGKpNx6C/Q12SS/veOn6lolWuyhwNmC5UJketK3LtIlDOVkG3x0M2rBdnTPWvSsIziK
         7lua8LLNLBYuVSIBNKdlQf66r1k6opD//c+lPtp4DpU0h7bzH3HfP9aeWnYx1XcBse51
         y2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267734; x=1724872534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2PBgehBoEdSNfyG1k90YKnC+vOI2d8jNmmyfOGuvuQ=;
        b=OZETJaAsRQmDIyF5bgX4M6JowGlNzzTDcLQyyz/PK/CoMyRQFWIF0LpaqmX5o6PM9t
         o40RkmFbA6Dy69f33gvt8ulAVNI3QlpqU2KWnZf/fUclyOh+S42/ppPJLvDX69Y7Fnl7
         N2FmeyxrE6cRaJmwzkSnMIOIGvtNf0bi4HT5/58SsyHs3t9o4wlCuw5qEMJx4K/uv6zk
         WtrmTgBRUd8JfYBVlFwITq+JsRnH6uxh9Tl9rQKzM6crMoMus6cwOaWv9CeX+LEd1UJJ
         QTt1tXEHW5R0yS1ehXG55ZYXdkXDoKoHPyCQB3ujrlmcFIkX5ojku/2o9kf6fRgaqXoj
         vs0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4hijKLQotm2++A6XrGjsGPAWz8tqmZTjPncBuunVm77ENfI0GBAICLEQHAjpxmq1VyLioDoZaz37ILaVF@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkl2ajN/BC0ZmPllPy5lCcPIVDLu+jSmP/MZAtI5dSBnWZErkl
	U/1NH8TcMAy4ixCLwEekIGI7XWdfGJculGxQSDFvbISMQxvUB6MSQ7NNYAysQ46jaXZZA5t5gRN
	q
X-Google-Smtp-Source: AGHT+IEsLZMaQfTemKkQxwuDjmbkCHmX8aQUCLPigwu1KWQfEyXF4G759Q3obRRuxFux2dABBj+h+w==
X-Received: by 2002:a05:6902:e07:b0:e13:c3b2:379f with SMTP id 3f1490d57ef6-e166549c3e5mr4244478276.33.1724267733900;
        Wed, 21 Aug 2024 12:15:33 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1171e3d834sm3113628276.22.2024.08.21.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 12:15:33 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:15:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v2 0/6] inode: turn i_state into u32
Message-ID: <20240821191532.GH1998418@perftesting>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>

On Wed, Aug 21, 2024 at 05:47:30PM +0200, Christian Brauner wrote:
> Hey,
> 
> So first time I managed to send out my personal wip branch.
> So for the record: The intention is to send what's in work.i_state on
> vfs/vfs.git.
> 
> ---
> I've recently looked for some free space in struct inode again because
> of some exec kerfuffle we recently had and while my idea didn't turn
> into anything I noticed that we often waste bytes when using wait bit
> operations. So I set out to switch that to another mechanism that would
> allow us to free up bytes. So this is an attempt to turn i_state from
> an unsigned long into an u32 using the individual bytes of i_state as
> addresses for the wait var event mechanism (Thanks to Linus for that idea.).
> 
> This survives LTP, xfstests on various filesystems, and will-it-scale.
> 
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> ---
> Changes in v2:
> - Actually send out the correct branch.
> - Link to v1: https://lore.kernel.org/r/20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org
> 

You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

to the series, thanks,

Josef

