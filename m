Return-Path: <linux-fsdevel+bounces-27200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4695F728
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2FA1C2126E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 16:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC29191F78;
	Mon, 26 Aug 2024 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ReH+1kMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37B143C7D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724691119; cv=none; b=eNnIkSYV+QdGD+YNYoK2q5SXCbJpNnr7tt6UeyAna7gYlRw8pA0MKULZ0dOuslH7WkBPN3LMYnv06msiDnKchBTPCSiZr0GVS+fJZx+QIyPMW/kiDpPvARtpKD16f0RnN5mtzNpGlKcmByJ0mP4kBntF0J09MRm6If4eA926JWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724691119; c=relaxed/simple;
	bh=+L4oNHMCNWpuHYOaMMKItyPNozrAbfcW8AOsRv3DNvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV4/whpW5als9i5qjxpc8aAp8gH95FjBCqvq0YWoOaX7Bzn4Bv74ChbtmizfR6QtutXss42ZaYfI5d/WLTG+zOvzwtc0iFr1zf/sKf6ni/QYkXiX275kblvMFYTZVDfb9Qzr3hUWH+i2zCOEOMqlBV2Zp1sxvyIGkwJ3sVa5qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ReH+1kMB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso5400563a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724691116; x=1725295916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGTcWYcxKa7/MM+pYx91vIxpflLbKrK+tQNtIyIYCsw=;
        b=ReH+1kMBGLMwUaoYhCeOJgw9epKNiCjltcpXXw4YFoRGCyoXPe87LnlUvuFS19U7BW
         VQTcHLfvymEygRRjLKV2VzZexMfBCOzQMoUw1eP+HT8nYcJJU9KaINjH/4NlNL3kHNrn
         hVnQ6A0IJZ3BXm3dq4Z0ztImV6BGgXIuZNz2QbVhfxf28TwjwHjyxPVIuNME3cuqIDwm
         S5cZR2KXKeq868JZc62wVVnZ0xdaSpsKWdm8YIEAOyoy1Rtm3eu2qm3Cx794v/Ka+bvt
         8CziOvolrHjMqZ0/F5udWbz8HqS5TmXuw+9LPkutjVYkmMD6wRrzUIYfLl77fnUGbxH+
         61Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724691116; x=1725295916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGTcWYcxKa7/MM+pYx91vIxpflLbKrK+tQNtIyIYCsw=;
        b=eShlYQUP8L+eOlCYE/5ZHj6RtIodKHaOzKxG+3s/5WvZa4iSxKZNwXy/FGH0GVGPsG
         wkYnDJzFcAtVQkvNEP16/aF5yMiWhEayX9C+kjBBRb6GEUujb1EenklBxMh/Mzzy5chW
         tthsdcPdy+nH1yfjUVZya+B263C9+yUZMIY0UB3G4lA1/tfKlxrPKaZGPoDIZfP7JuOm
         HW2JZR5n6tXl1xhqWFCZlYUyJlRjgARQ/jDyDJVFyI8TXPJv3MwKJAJ580oJZG6B3E+X
         LH4Px4BiN6935gxwNSSI0YToG7VAbJQmXucIgp2mSeKL00CmifcYyA2KLXK5K3pHANz8
         ukCw==
X-Forwarded-Encrypted: i=1; AJvYcCXvaSx9BsYiyNwhGmMyqm3+s1GIardGcGpL6IM0qJy4UcOydCybfjxYyJihg5xWCIPkdDg/IKLtm23J8vIu@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZfm6ZSY58eRTVUN94JctZLfIhDB6uqLKBHIIiJ//g+uAp2jz
	L0tyt12kIQeQCbGDfu8YzXm0BjAkFODvtD9CEoCB/7cV6038SjwGMPWRB8Wt0Ok=
X-Google-Smtp-Source: AGHT+IGad1dbexVhTpYCO13uCMg2SLCPwC55Yto2UhY1VO9tgHVcIhFpdgXzbXOnyKLfVkpECVPV8Q==
X-Received: by 2002:a05:6402:1e89:b0:5be:db8a:7f5e with SMTP id 4fb4d7f45d1cf-5c0891abb09mr7263514a12.37.1724691116442;
        Mon, 26 Aug 2024 09:51:56 -0700 (PDT)
Received: from localhost (109-81-92-122.rct.o2.cz. [109.81.92.122])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb04csm5819961a12.31.2024.08.26.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 09:51:56 -0700 (PDT)
Date: Mon, 26 Aug 2024 18:51:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZsyyqxSv3-IbaAAO@tiehlicka>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyKQSesqc5rDFmg@casper.infradead.org>

On Mon 26-08-24 14:59:29, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 10:47:13AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > There is no existing user of the flag and the flag is dangerous because
> > a nested allocation context can use GFP_NOFAIL which could cause
> > unexpected failure. Such a code would be hard to maintain because it
> > could be deeper in the call chain.
> > 
> > PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> > that such a allocation contex is inherently unsafe if the context
> > doesn't fully control all allocations called from this context.
> 
> Wouldn't a straight-up revert of eab0af905bfc be cleaner?  Or is there
> a reason to keep PF_MEMALLOC_NOWARN?

I wanted to make it PF_MEMALLOC_NORECLAIM specific. I do not have a
strong case against PF_MEMALLOC_NOWARN TBH. It is a hack because the
scope is claiming something about all allocations within the scope
without necessarily knowing all of them (including potential future
changes). But NOWARN is not really harmful so I do not care strongly.

If a plan revert is preferably, I will go with it.
-- 
Michal Hocko
SUSE Labs

