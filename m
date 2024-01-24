Return-Path: <linux-fsdevel+bounces-8809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 522FB83B28C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852E91C22C3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A6133428;
	Wed, 24 Jan 2024 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J4Diar6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60810131E38
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125912; cv=none; b=OJtoOl8W/40qj2kr0nbsEraNKKHw1QRAKDslCj6FL7bpdCbM6jN+3BHNq+qRZqSLt+Mxip1qBlVYEFeJ622Qm6HYL+YUuSnjpDKsd2ADHy9XPAbZzrg/QCSzxJgyedmDr2LZhzbgcMks/RpssWr1mmWBZNlzsCdaUj4H5gCxGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125912; c=relaxed/simple;
	bh=+IYqSxEQ9oBa5c9r8B0bfIvQXLqXBMpi4Ryc4G+HXuE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK1FPxvKu3E8+ZHFOrR5WPQFH2NP7sTB8NJyUs/OMjDYibFgn5l11uLXAWdZXWvnkND3paulq2YFDcxA/wzNLBNrDCHD4LzdPiJjiWulQQDU2kDf7x9Pgnd+le8KWul3X4QRg4wkECvB9LgRgsaQc3kujvjEH7PgSIgJm+MKYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J4Diar6n; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d750660a0aso19969825ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706125911; x=1706730711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=J4Diar6nU/37c0/UwBQQFu7zCFodAGZNbMK8zK5T4ksD60wf29XsDjczDxsZMoOkG8
         VWNui00mTtdF2GLDTKMEYsm80XO6z1961TZkKiOaKfAmeJPEEG9nw+44TX83kwwOMNbj
         w/zguEDg41/bg68FDXI9OEyyVi7Lkay37ry3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125911; x=1706730711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kA0mFxG1k0QSiOKDeUD/WDcdNFn8yF9DrGJFsA48PEc=;
        b=etWE7tLRNzjJ5Rwi6njjVS67bG03whKgooUSRIunC/O9fo4BIoXk6jRmyq6nnlqW6x
         BLW6bAZ2sPq4hwwW24/nMZctfxZ2//daF5Ww/Vus0GiCd33oiEoKQuLPqDfmVCUQsGRY
         k42C1dkfj7ScoXnFQuGZ9WeQSUtIi5c/2OhtE8LLwLtn4iJvPnYRqBN0AMW50nUzla5z
         OFEsToBSPWhKw/m5vgGbMWhaRp/OM29T6Cp9o4Qu59rXoGrsFaaxNHzX8sFosWt92xo+
         KVGTcvgXcbE2WlHs4ylJyC8YE+1CecPdNMWYMYmPW+FgSeGeYZlANZaHFDluw77VH8Qi
         q/aQ==
X-Gm-Message-State: AOJu0Yx7iURrqOE/7dZBLZXYYsA7Z86ib7aAH3omWL1u+aHEUf08oPYK
	BYOl8yg/TH9AiY4TXa/YL+y/ktFG7TaV9T8DaRp1GkBQ4Ge7n8f9Z0ypE3vH3w==
X-Google-Smtp-Source: AGHT+IHOo2S4XZPrJkJAVWNIUu5O2sihiMmNygdfJCCs51/i38ljraqICbhZ/brbhlRxs5RoeWJoDA==
X-Received: by 2002:a17:902:8685:b0:1d7:70d7:c05a with SMTP id g5-20020a170902868500b001d770d7c05amr1210754plo.98.1706125910737;
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902c18900b001d707163122sm10456896pld.7.2024.01.24.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:51:50 -0800 (PST)
Date: Wed, 24 Jan 2024 11:51:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Kevin Locke <kevin@kevinlocke.name>,
	Josh Triplett <josh@joshtriplett.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Message-ID: <202401241151.25D468FE@keescook>
References: <20240124192228.work.788-kees@kernel.org>
 <ZbFneq3URF5lLAT7@kevinlocke.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbFneq3URF5lLAT7@kevinlocke.name>

On Wed, Jan 24, 2024 at 12:39:38PM -0700, Kevin Locke wrote:
> On Wed, 2024-01-24 at 11:22 -0800, Kees Cook wrote:
> > After commit 978ffcbf00d8 ("execve: open the executable file before
> > doing anything else"), current->in_execve was no longer in sync with the
> > open(). This broke AppArmor and TOMOYO which depend on this flag to
> > distinguish "open" operations from being "exec" operations.
> > 
> > Instead of moving around in_execve, switch to using __FMODE_EXEC, which
> > is where the "is this an exec?" intent is stored. Note that TOMOYO still
> > uses in_execve around cred handling.
> 
> It solves the AppArmor issue I was experiencing and I don't notice any
> other issues.
> 
> Tested-by: Kevin Locke <kevin@kevinlocke.name>

Thanks!

Sounds like Linus has taken the patch directly, and I'll send a follow-up
PR with other clean-ups.

-Kees

-- 
Kees Cook

