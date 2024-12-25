Return-Path: <linux-fsdevel+bounces-38123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A559FC5FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA1C1882DC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198717B50F;
	Wed, 25 Dec 2024 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+CXviSv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15EBC133;
	Wed, 25 Dec 2024 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735142703; cv=none; b=njPXnzT06nNt2XtTcJyBbwSibrz1mM7yP523sofJE3au/aklNN1vZvpMB1VxiPsKbclxT/pgJAem4AzAvmW41rHn2kjJuFs3ix/MVhQbEVJN4MIvJ0pChpvbPGGxLAj51XxO+RcchNYpIZP5YSWqJmw0TT54JtOO/ZCat4R/tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735142703; c=relaxed/simple;
	bh=AMXfZt0Pt5NoFdjWvNFBMLosuhnnEAypOCkh2BLPVWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4YEJBb5pXCSCfB2LyGsgg33mdE84n8mLjLAWkFricUGSYHkGd/BDcyFT1ROg8dnRmRxfKWY0oaSuV1rRVaUpKJNdXtyhNIP+dA6scHFl0ESwjrbSCCAFxAw15G/UGdIkRiKWWkOGuZD8HZv8obZD5COgnx0UNQSwnpZmlCvvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+CXviSv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aab925654d9so1062251266b.2;
        Wed, 25 Dec 2024 08:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735142700; x=1735747500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ER+s7JBiAMsNiH63puVZlnAS3pWud1FMajpGFbkmero=;
        b=C+CXviSvMB6lj8txGk2bHx5vQzix5JKtSe/kuX6K6uoAgrK3t3PTWtQS/hTq3V66mz
         2q0H1Wrm7f9ACBd3W1GGVeRC4hqs+svi5nbO+G02HY7auO5TzCgVu43ObbW5EO3vZr3d
         EXW3O78EzvHLVmM62gXNu/qDGlnHNWmGYj4lJKQPsTOel2CYg6pIuCFAO4TDsU++s4Js
         Rx8+XhjVM84jJxvTSaIPDkhg7AAKdY7Pzgx2Diliz6oeka7tKhgPK04mNdVQ7CXD8kkz
         1G9ydi/1rlqIt/x9pRLm8VbgZyHBSSPh4SIuOzC8HSRfBoUp5Jw1pRzXd6HqEnAAFUgu
         Gu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735142700; x=1735747500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ER+s7JBiAMsNiH63puVZlnAS3pWud1FMajpGFbkmero=;
        b=U1d0i4yEPvGz2WKz7Lt8E7blyJNz4Uxkoobnu4a24AT1qJ8nZbfs5d5LvYudUFfUiA
         fgY1mVoNF+BSgLzqPpffboZp9NBqBrleVStnuYFf+O7RDMyL9ZBL0MVJr8bnjEtW3VKx
         9Gh0FpAd+CYNDteXKDqoVoXcnN3RRlWIJi0YbLt0w/zd3Z2KAxcWR4ODRdsWqcC0yIme
         t99OfwlnB1PVjJxlO1Zxj32/1/Rn1uf0R3jAqT2cQ65XX4YciiDY4rUf8i1rEMe8i+d5
         Qa1MfWw7Kcd7FhExn8ZIv7JkpoWxNUaTl9KjHsIWiumXQoqcs0XMxl30SLMnbDh76fx8
         NlPg==
X-Forwarded-Encrypted: i=1; AJvYcCUp0pJfYCg1kzw5IIf8VZ478PX/bP5W7/1gnau/arDLxEwUFjAjQazkRAYpbkv7H7Y3Du2rK+cAoqJATLiO@vger.kernel.org, AJvYcCVBQsezyq+7HejQDDvZtTcFqYNRLxM/uaxkMrsExVVVQbHdZz8uQzXS3VZVr+tci6K/4awRnOFBRWzgrAlw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo7mH/JrJFUPjoJ4xzdSztVcqnkRlnTcG/hvTqdYdPNs2iFV8k
	FAniPEYw+g48Yko5wB95xBvAs/1SkluTbpGUw4+ziEDrzIm/sRZB
X-Gm-Gg: ASbGnct7UqdQKuuRuocHHVjqOSPKwWFK6zaULMVUdT4dogcsSix2BzfnQ58akpiGr1S
	Nm+WjqSA/sAIRWdIcFhOqsr5cKhZWvLWXccffE+OJb7jUhXS9tfyO+G/HjYogf0OS8y+aInD+7V
	EqTyuX9bMmFzhW8uO5YlVSw2qgmZmaZquz52XU8YSmuM3pAjRTze31J5w/mb+09N1oPVeNAsH2d
	WFhWkgaOpusTyol73pIN4Kgb7YLY4gZKTQZaMD01JWLZuF6rLAZb4vqEyCIhdiToB4BzFT2
X-Google-Smtp-Source: AGHT+IH8G/1QG1RTofv9OnjP8M48sIAYyeGbwXs/8wkRYSNOwZx1V/YWYRBBrk7BkGlaGg8MMvfITw==
X-Received: by 2002:a17:907:7dab:b0:aa6:98c9:aadc with SMTP id a640c23a62f3a-aac2d45fb01mr1887821766b.31.1735142699864;
        Wed, 25 Dec 2024 08:04:59 -0800 (PST)
Received: from f (cst-prg-15-174.cust.vodafone.cz. [46.135.15.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f012229sm812610766b.133.2024.12.25.08.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 08:04:59 -0800 (PST)
Date: Wed, 25 Dec 2024 17:04:46 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	WangYuli <wangyuli@uniontech.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, yushengjin@uniontech.com, 
	zhangdandan@uniontech.com, guanwentao@uniontech.com, zhanjun@uniontech.com, 
	oliver.sang@intel.com, ebiederm@xmission.com, colin.king@canonical.com, 
	josh@joshtriplett.org, penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu, 
	jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org, 
	jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de, oliver@neukum.name, 
	dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de, nickpiggin@yahoo.com.au, 
	dhowells@redhat.com, nathans@sgi.com, rolandd@cisco.com, tytso@mit.edu, 
	bunk@stusta.de, pbadari@us.ibm.com, ak@linux.intel.com, ak@suse.de, 
	davem@davemloft.net, jsipek@cs.sunysb.edu
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
Message-ID: <4tee2rwpqjmx7jj5poxxelv4sp2jyw6nuhpiwrlpv2lurgvpmz@3paxwuit47i6>
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <am7mlhd67ymicifo6qi56pw4e34cj3623drir3rvtisezpl4eu@e5zpca7g5ayy>

On Wed, Dec 25, 2024 at 08:53:05AM -0500, Kent Overstreet wrote:
> On Wed, Dec 25, 2024 at 03:30:05PM +0200, Andy Shevchenko wrote:
> > Don't you think the Cc list is a bit overloaded?
> 
> Indeed, my mail server doesn't let me reply-all.
> 
> > On Wed, Dec 25, 2024 at 05:42:02PM +0800, WangYuli wrote:
> > > +config PIPE_SKIP_SLEEPER
> > > +	bool "Skip sleeping processes during pipe read/write"
> > > +	default n
> > 
> > 'n' is the default 'default', no need to have this line.
> 
> Actually, I'd say to skip the kconfig option for this. Kconfig options
> that affect the behaviour of core code increase our testing burden, and
> are another variable to account for when chasing down bugs, and the
> potential overhead looks negligable.
> 

I agree the behavior should not be guarded by an option. However,
because of how wq_has_sleeper is implemented (see below) I would argue
this needs to show how often locking can be avoided in real workloads.

The commit message does state this comes with a slowdown for cases which
can't avoid wakeups, but as is I thought the submitter just meant an
extra branch.

> Also, did you look at adding this optimization to wake_up()? No-op
> wakeups are very common, I think this has wider applicability.

I was going to suggest it myself, but then:

static inline bool wq_has_sleeper(struct wait_queue_head *wq_head)
{
        /*
         * We need to be sure we are in sync with the
         * add_wait_queue modifications to the wait queue.
         *
         * This memory barrier should be paired with one on the
         * waiting side.
         */
        smp_mb();
        return waitqueue_active(wq_head);
}

Which means this is in fact quite expensive.

Since wakeup is a lock + an interrupt trip, it would still be
cheaper single-threaded to "merely" suffer a full fence and for cases
where the queue is empty often enough this is definitely the right thing
to do.

On the other hand this executing when the queue is mostly *not* empty
would combat the point.

So unfortunately embedding this in wake_up is a no-go.

