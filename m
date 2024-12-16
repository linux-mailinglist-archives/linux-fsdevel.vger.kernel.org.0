Return-Path: <linux-fsdevel+bounces-37468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F49F292E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 05:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5448F7A29F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 04:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9AA157E6B;
	Mon, 16 Dec 2024 04:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jc+ebSvS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99D72AD18
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 04:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322310; cv=none; b=Iq/Hs9Z37+eimzV58ENxP6cR+5lP6KaCMTlxx8GljcuZELicc1aXi8/XU3/flr69Uqgp1G/k2Egby+ftX5j7OZAO4XwvLionvYYCQEvF34hSDuAvBcH6g3UhcKMzkr9zra70e4jhLPROxGeH6OkfNEdyJlV4iVHfW2j55IVkm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322310; c=relaxed/simple;
	bh=817W1J+trW7y2RIxiYa/6yvBeL/d/IwrF2iuDDQBAhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4929HLBU1AjKokwLMKQpdaAfcB8amdKaG8WJ/ypljJYhliwEiJz4kgj1fcT0JtCYUhPUOed2feFJAvhY+/hQ50Z+VJVs+Gswvi9x2FqPqyycUjBGfacSH8zIhNxT1fVG1eejmE0AMvzTetar1TAraZB+Kd7Vt8CF0Uwi0Ub5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jc+ebSvS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-728ec840a8aso3878778b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Dec 2024 20:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734322308; x=1734927108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g9j8xePoFA0cWecwo6FAQns9ChTIOVNiCYY8Dpa6BrA=;
        b=jc+ebSvSLkpmfKppOpsie0tPnzHTx9Ju4+mR/gqmawTtw2qiAXQ5uLyzfCLG50BuvL
         lz/bVrF6/I364bSApcZ31kUqg3c4GB0DpQzA4Iddi2g2n3E5W9fGhsbAj/L0Y030dcw0
         Nj2RKDBk+lpe1KsfjRLPzQNgy+/HuF+NpyV+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322308; x=1734927108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9j8xePoFA0cWecwo6FAQns9ChTIOVNiCYY8Dpa6BrA=;
        b=daBFf+nL41Bc8nLCu0jU7cgt7sirmRDaghzJGen0ido+lf4nysD5wK4ltr6JmM4Prv
         saPCtRHEkYyH867cSaKk1fwsQTUaPJlOu223k9C2a9EhRSUOEPCOO6Gh6f77EPT+5HYD
         Dn/rqD5a+2DV3GlRZHcArVJ8ersxB5ddFUf5ixPucsoQPN6+z+Kw67MP0r7cKoNvkDik
         FNescxRZsYOAPXuaBLu3c4HFc5ZtiSvS5aRGtx5Z7vJMu4QpP5coOoyqXv1a0qzhKgft
         kS8p9XT82Fa0XAzXTt7sonQA5mx/YD4eww6BLIr2/fweGbFapTItN7+mi6iaLNEr8adI
         lJ2w==
X-Forwarded-Encrypted: i=1; AJvYcCVQ5HTmP8QSTjWfXnf1AMiUJMwHH6udEZqDHXv6E+l5rj99vRq0um3mAC9vdo5r/SfxtrONcdZoQAsYXJFm@vger.kernel.org
X-Gm-Message-State: AOJu0YzeIiyVJkLbiROSbj0ASW+qpppwjgHFyH8coxWXVWHLHNx2IvwH
	nu0U8mI+l/pzDlxiGJoGLFPMtAPXwFWVdsQxzwrQzgGKY5eU/bnUWZlGjlRND/kYDYNEVKkfYsI
	=
X-Gm-Gg: ASbGncs5DxxZzG1/UGhA5L3xNPHwZZoZwP+ZEOePFD3a0Yk8V2QcHDHXxFUJUCki+/G
	g1bkRjay3hARKsghkrv0B3x+sNnnYrkrMFbev7sXhtQ/sVdkBmq9Sq1GOUQnUHYHalBkQoAPxRC
	ZmCNkeTI8h13RPmlJ/JBSmPBpvFBb3CgkCRcFYJFZziGmf5CMs2dRg2jpDetc26Gc+qMeyqNzb9
	xm8g+0/aw7d+rTAV8Jrrdujy3YaAZo31IvXvl8QM7Qug0knIrfKaaLn2RZw
X-Google-Smtp-Source: AGHT+IFkPPeh4FoSDoFqOvDgTwX1dpwAkBsnRlNpymzFR+6AVB6hloZ+fL9bPRcyuXu2tWp6Dr91/A==
X-Received: by 2002:a05:6a20:cfa7:b0:1e0:cadd:f670 with SMTP id adf61e73a8af0-1e1dfc18904mr15246263637.5.1734322308186;
        Sun, 15 Dec 2024 20:11:48 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:395f:9357:736d:a429])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5c3297asm3259076a12.70.2024.12.15.20.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:11:47 -0800 (PST)
Date: Mon, 16 Dec 2024 13:11:42 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Etienne Martineau <etmartin4313@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, tfiga@chromium.org, bgeffon@google.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v10 1/2] fuse: add kernel-enforced timeout option for
 requests
Message-ID: <k42hcuuchfbz6h5klsizkqx6e2lvyg743sccywbjxqgl2jwunh@trgvdu7cjkjo>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
 <20241214022827.1773071-2-joannelkoong@gmail.com>
 <8d0e50812e0141e24855f99b63c3e6d7cb57e7f8.camel@kernel.org>
 <rw7ictyycbqrxuosmr2irzqgtxyfv2pprgvps6tjihbypnxcyc@qqkpoiq65ly3>
 <b282ea2126d9349ffcbf0682d71684f000fbc091.camel@kernel.org>
 <CAMHPp_RjXKsPmKqYOA+ZAFwyora9FebaqYGWa3y68oYgkv259A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMHPp_RjXKsPmKqYOA+ZAFwyora9FebaqYGWa3y68oYgkv259A@mail.gmail.com>

On (24/12/15 21:16), Etienne Martineau wrote:
> > >       void fuse_abort_conn()
> > >       {
> > >               cancel_delayed_work_sync()
> > >               __fuse_abort_conn();
> > >       }
> >
> > That seems like a reasonable solution. It already doesn't requeue the
> > job when calling fuse_abort_conn(), so that should work.
> > --
> > Jeff Layton <jlayton@kernel.org>
> 
> I'm not sure this is going to work either.
> What happens if say fuse_check_timeout() is running and is about to
> requeue the work and
> at the same time umount->fuse_abort_conn->cancel_delayed_work_sync() comes.

Good point.  Perhaps a flag to make en-queueing conditional then, which
will be set/cleared before cancel_delayed_work_sync()?

