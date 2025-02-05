Return-Path: <linux-fsdevel+bounces-40896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52817A28368
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 05:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF3A3A64EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 04:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C69217F23;
	Wed,  5 Feb 2025 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="XjS4l1k0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E4620FAA0
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 04:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738730308; cv=none; b=nvExgtNDUcY8g1V+opmu5tNYVaCdO3aPiYhTYfBoNvwFxGYqUTN1geQw3QqAzuHjsnjoYFLUNLkenpm/jWPMEnzpYA7iQfXGU8nPJgZrHNAS/h2ZAqaBq2+P1XnVjh019wTlY1Bhw1h/o6x56dyNSz9sVl0jSaFxsnzEu9tYiXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738730308; c=relaxed/simple;
	bh=J7U2Q/UxdnHHNREZ5MpzRT5mff3m+IhHG6gScBDsO94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g73Zin758VZ05foul9TZwGFZn4P1yGSm3gfVnKiZC+4l0k6Rw/Zo/rvi0vma8YCkK4d+o46210PEzOY4gw0mU7tBDJMcHH9uMRug2LVDsPsdujy7tFyRCK6IeAjxZjId7P4pSssWAMyD0GcSlIwxuI6+9eiIOwmBac7FwayWtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=XjS4l1k0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso107815815ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 20:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738730305; x=1739335105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjMGzE6Go39mYVCkZlTE/VL5/mlgb5Sxp+Q2hiLCC9U=;
        b=XjS4l1k0PBZAs4pNw2Qb8LhRy6ZNmuC29rpvzTtR0YwuDLNI9ib8IM2ftPgIN3TBTi
         VLClLf0YFte/Ss9yKRslTH07tP2poMsUZaKqQ8wtAK9N//hWGrmXt6s8NG63pqd/henD
         /VZqw/srMloBaY/cYKOlxZ5d+wHqkKv++DjSPhoiRfZ/Fa1jZM6GluoQLoXqFCxfRkuu
         YGiEQ+RrNPOFnG7cjQbMWPH5k/K9zFq1zL810KfiDF8O7AMfHa13vhJHzbE3FixCMa45
         bagRDLkDvQS+1gwfm4uaHwt/DV2lxksLTA00ZccqVJPRJT06LzBGWZfTspwB+pp8SMIV
         wXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738730305; x=1739335105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjMGzE6Go39mYVCkZlTE/VL5/mlgb5Sxp+Q2hiLCC9U=;
        b=SXwMZOeockpaIrh0EkZQ/2zm1SOZ+X8s66QJVUzyiB+tk5JD3e34Z+GqROgWno+uDa
         RD60uwzeg97dV7E3yrgd+qQl/Hpksg7DqlgHCkiK3j4Udpb+/bz0Df1wAjetVHL/tM2y
         pIQ404yyK4XtUpvb8yujkZr4Q7H47A6Q75OaSSl1WNKt3FZb224CByZr7tMJeODxSYru
         w2AwbsRq8tn9oCVXWkcAoAUOLQ/Z6f265+gC55emyC95PBp72WrmFH04K2zP/ujI9EyA
         kgKZPVWm7jUTX0NAp8Vn/PdYo4+49JcZV/prJ7fbNn+APBjM0E8M5+Po3AOtpdtQ7BdC
         v54Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgkVlkI9P1dJcYbfJroWtN4cb3JOEUZt3kO5gag/AI3eFJCCvI8joqVNggjjmLcP8Rnx12FOQY+5vdqe8q@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0p+YfHlZYT76l+0JJenB1B2G/t5XFlx9nomq7MXVpbdu67ixo
	pS+WKzlFYPAB1lP2BGoomB7aYXNvtoJKs8LbsYfKA4wsqjR2zcvuRnSj3+JP54E=
X-Gm-Gg: ASbGncszxQLAbiUTXRmfr60Epf1aXayQgm3PHDrQhjT7dsKuROJxjHHjPqEs8Yqt3ik
	zY4TG9tekN1m4invAvxDP/wzLOxuZmQB94rFApBy4ZvF6m2fVxqt6bfjVbYu3+0HRVHics3SS2o
	+ikcyC1XV1oH/8PylTpcHb66FlmvQBroxjeiMY9q1KjKwc6ZaMN1t/vjMtEtpnwnlnCjBgX2XN8
	whpBQ2GePELFt2mCte80YrL7K2HG/2av4sNMAI15MsctH5/81UllWxq4RgT5ozNZXQdF9WyT6Qv
	7Vb7ARMeHdMQJKU1V5IaLRFLI0BwDKZXSCmVhi+NQLvXlPFXgAiovlF1iMFxcQ06NHs=
X-Google-Smtp-Source: AGHT+IHUTmKZUJrzMrzM29CM6VbmyHZh7hqbxkE4J/yHe016DAdnZ14+dj5tyyT4ltJpUkS6+ua0QQ==
X-Received: by 2002:a17:903:41cf:b0:211:e812:3948 with SMTP id d9443c01a7336-21f17d44565mr30305685ad.0.1738730305398;
        Tue, 04 Feb 2025 20:38:25 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32eb995sm104003945ad.148.2025.02.04.20.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 20:38:24 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tfXB7-0000000Enq7-3xDE;
	Wed, 05 Feb 2025 15:38:21 +1100
Date: Wed, 5 Feb 2025 15:38:21 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Boris Burkov <boris@bur.io>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Long Duration Stress Testing Filesystems
Message-ID: <Z6LrPWauFln6kUcJ@dread.disaster.area>
References: <20250203185519.GA2888598@zen.localdomain>
 <20250203195343.GA134490@frogsfrogsfrogs>
 <20250204193845.GA3657803@zen.localdomain>
 <20250204220939.GB21791@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204220939.GB21791@frogsfrogsfrogs>

On Tue, Feb 04, 2025 at 02:09:39PM -0800, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 11:38:45AM -0800, Boris Burkov wrote:
> > On Mon, Feb 03, 2025 at 11:53:43AM -0800, Darrick J. Wong wrote:
> > > On Mon, Feb 03, 2025 at 10:55:19AM -0800, Boris Burkov wrote:
> > Which kind of gets back to what I was getting at in the first place. I
> > don't know enough about xfs to fully grok what the various
> > configurations do to the test (I imagine they enable various features
> > you want to validate under the soak), but I imagine there are still more
> > nasty things to do to the system in parallel.
> 
> Probably, but we've never really dug into that.  Dave might get there
> with check-parallel but I don't have 64p systems to spare right now.
> 
> As for configurations -- yeah, that's how we deal with the combinatoric
> explosion of mkfs options.  Run a lot of different weird configs in
> parallel with a fleet of VMs.  It's too bad that sort of implies that we
> all have to work for cloud vendors.

Well, that's one of the issues I'm addressing with check-parallel.

When a full auto run takes 10 minutes, a single developer can
iterate a significant chunk of the configuration matrix on a single
machine in a few hours with a single check-parallel command.

The functionality is already there to do this - if we define all
the configs that are to be tested via config section definitions,
check-parallel will iterate them all in one go.

That's the way I want to run testing - testing mkfs defaults with
the auto group is a ten minute smoke test that will catch most
regressions in new code. That "full auto" smoke test is now faster
than my typical think-code-build-deploy cycle time. Perfect.

Now running half a dozen common configs (e.g. each of the LTS-kernel
related mkfs defaults) for better coverage becomes a "run it while
I'm at lunch/in a meeting" exercise. IT can be done multiple times a
day, and interrupting it to start again with a new build is no
longer a big deal.

End-of-day/overnight testing has a long enough duration (12+ hours)
to exercise /several dozen/ fs configs. That's more than enough
testing to drown a typical developer in things that need analysis
and/or fixing.

All on one local machine built using cheap commodity parts.

The cloud is a lie.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

