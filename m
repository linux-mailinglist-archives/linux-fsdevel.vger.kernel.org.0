Return-Path: <linux-fsdevel+bounces-7759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2088682A540
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 01:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F8C1F240FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 00:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BE97EA;
	Thu, 11 Jan 2024 00:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+IF8RrF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F405392
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d3e05abcaeso32039945ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 16:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704933563; x=1705538363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2tzVam0hFnVO15kFt069Z14hbEubNMkoHdOSTm/yrjg=;
        b=N+IF8RrFbG8TDazBj+H0IBGAaIyLPOMCtAR5xyiFOEAnOSUEiXMCngtgOlTvg4+PcD
         EIEUoPQ5hOGxrq/ZoUBGMTKFzvlCKmB7skeoH6eZH/VNCKBJrZLo4N+qIK7WtiahZEpm
         0URGVuh7RRDe8k1BepQPuchj3XSGfxBtLN8PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933563; x=1705538363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tzVam0hFnVO15kFt069Z14hbEubNMkoHdOSTm/yrjg=;
        b=onSMosIiLUNr/2rfirWoish6lLO9jQPUedsE1m0K5KpVj3Ss+Lo5ecmgCYF2Nyssqm
         DnDP9swONXGl+F68MylejY9uKbdnfdKG2Oke2B2o9u2XigEAWXts4x/iXw7T6m+8lZVN
         eqknhG+MgrgLbsSYy/svtikdGgGfsoMXAnSROtLUcPpnwSAMekIZ2I4g52Xvrbx+1Or7
         Or+iJ0y7uWt7jB4ecBNe6z7UIYtKqsv4Eq2PndGTKrGslivqyQGc4j9EEsNkSYr9i7ox
         04rE/C+3nwwnetjkjboyaN3x+62tos7LUa1nYYhpO12UG54n9yDGxY+VBn7xBkc3jxdj
         eEyA==
X-Gm-Message-State: AOJu0Ywp+tZ68PuUs4kqUnywO0WTP3PuFucVQ1TeUZPXg1vYs3TM5eW0
	9gQT0VUT+Xaby8vGLhVs+gfRPaWH0cO0
X-Google-Smtp-Source: AGHT+IECP2Bnyo5GM1JeB3lzEBvXWpVakVzi6DxHRYvR9KdZ0qjFnMRCoI+Gv8jwwvmVX7sWsHD30Q==
X-Received: by 2002:a17:902:da84:b0:1d4:60b1:27af with SMTP id j4-20020a170902da8400b001d460b127afmr396174plx.97.1704933563663;
        Wed, 10 Jan 2024 16:39:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709029a0300b001d4c316e3a4sm4210089plp.189.2024.01.10.16.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:39:23 -0800 (PST)
Date: Wed, 10 Jan 2024 16:39:22 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs updates for 6.8
Message-ID: <202401101625.3664EA5B@keescook>
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook>
 <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>

On Wed, Jan 10, 2024 at 07:04:47PM -0500, Kent Overstreet wrote:
> On Wed, Jan 10, 2024 at 03:48:43PM -0800, Kees Cook wrote:
> > On Wed, Jan 10, 2024 at 02:36:30PM -0500, Kent Overstreet wrote:
> > > [...]
> > >       bcachefs: %pg is banished
> > 
> > Hi!
> > 
> > Not a PR blocker, but this patch re-introduces users of strlcpy() which
> > has been otherwise removed this cycle. I'll send a patch to replace
> > these new uses, but process-wise, I'd like check on how bcachefs patches
> > are reviewed.
> 
> I'm happy to fix it. Perhaps the declaration could get a depracated
> warning, though?

That's one of checkpatch.pl's purposes, seeing as how deprecation warnings
are ... deprecated. :P
https://docs.kernel.org/process/deprecated.html#id1
This has made treewide changes like this more difficult, but these are
the Rules From Linus. ;)

> > Normally I'd go find the original email that posted the patch and reply
> > there, but I couldn't find a development list where this patch was
> > posted. Where is this happening? (Being posted somewhere is supposed
> > to be a prerequisite for living in -next. E.g. quoting from the -next
> > inclusion boiler-plate: "* posted to the relevant mailing list,") It
> > looks like it was authored 5 days ago, which is cutting it awfully close
> > to the merge window opening:
> > 
> > 	AuthorDate: Fri Jan 5 11:58:50 2024 -0500
> 
> I'm confident in my testing; if it was a patch that needed more soak
> time it would have waited.
> 
> > Actually, it looks like you rebased onto v6.7-rc7? This is normally
> > strongly discouraged. The common merge base is -rc2.
> 
> Is there something special about rc2?

It's what sfr suggested as it's when many subsystem maintainers merge
to when opening their trees for development. Usually it's a good tree
state: after stabilization fixes from any rc1 rough edges.

> I reorder patches fairly often just in the normal course of backporting
> fixes, and if I have to rebase everything for a backport I'll often
> rebase onto a newer kernel so that the people who are running my tree
> are testing something more stable - it does come up.

Okay, gotcha. I personally don't care how maintainers handle rebasing; I
was just confused about the timing and why I couldn't find the original
patch on any lists. :) And to potentially warn about Linus possibly not
liking the rebase too.

> 
> > It also seems it didn't get a run through scripts/checkpatch.pl, which
> > shows 4 warnings, 2 or which point out the strlcpy deprecation:
> > 
> > WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> > #123: FILE: fs/bcachefs/super.c:1389:
> > +               strlcpy(c->name, name.buf, sizeof(c->name));
> > 
> > WARNING: Prefer strscpy over strlcpy - see: https://github.com/KSPP/linux/issues/89
> > #124: FILE: fs/bcachefs/super.c:1390:
> > +       strlcpy(ca->name, name.buf, sizeof(ca->name));
> > 
> > Please make sure you're running checkpatch.pl -- it'll make integration,
> > technical debt reduction, and coding style adjustments much easier. :)
> 
> Well, we do have rather a lot of linters these days.
> 
> That's actually something I've been meaning to raise - perhaps we could
> start thinking about some pluggable way of running linters so that
> they're all run as part of a normal kernel build (and something that
> would be easy to drop new linters in to; I'd like to write some bcachefs
> specific ones).

With no central CI, the best we've got is everyone running the same
"minimum set" of checks. I'm most familiar with netdev's CI which has
such things (and checkpatch.pl is included). For example see:
https://patchwork.kernel.org/project/netdevbpf/patch/20240110110451.5473-3-ptikhomirov@virtuozzo.com/

> The current model of "I have to remember to run these 5 things, and then
> I'm going to get email nags for 3 more that I can't run" is not terribly
> scalable :)

Oh, I hear you. It's positively agonizing for those of us doing treewide
changes. I've got at least 4 CIs I check (in addition to my own) just to
check everyone's various coverage tools.

At the very least, checkpatch.pl is the common denominator:
https://docs.kernel.org/process/submitting-patches.html#style-check-your-changes

-Kees

-- 
Kees Cook

