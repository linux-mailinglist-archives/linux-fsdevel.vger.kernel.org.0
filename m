Return-Path: <linux-fsdevel+bounces-16570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4012989F89B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32441F318C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB3E15FA6E;
	Wed, 10 Apr 2024 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6YEhFGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFAD15FA62
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756337; cv=none; b=ANzTiHHlWsAjzpI8j+1X+g2GtPqnhDUwkID0NRQXDCSTONpQD+ZDrAVo5+VqV5F2JeS2XuYszKAu2MfXjiTzuot88i8gDgvYYl9VEfwTiNoLMQ9HvL6SOhrPmBhVnlZh0unkG7rq0qlQIWNQoRB+EtUCCG/nJmkUeZn23BQFv4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756337; c=relaxed/simple;
	bh=NtQJYPG8PGe+F2JtayYYNTLWNG6MzMRYwtFOCgnrG7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc365tb2wJcUaH+nrJmnTYoNjXgokPnxtc0kEQbAHyRFGUBQ17heqQQ5E0aUiZA4U+eD8WfvXR7TOLYN5TngBvfanW/TtkgLeRCE50GHX/wqKHLk4l/vyWDXkq2eAmfnTndLbCz3bvpowdETUGtahTt9z9YSA8v+v+S/7sT3nLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6YEhFGM; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ea2f917c02so391353a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 06:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712756334; x=1713361134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/zFrjm9t8xgCC5pg3svGCPHHB87uoPXjvKSBy+e5eA=;
        b=W6YEhFGMQHsY+WHLdsWra5gKZF5rL7XmTuV9GE89c1geOYFZ/Oq5Ae6XK5U6sOvRCi
         vb9Oa1Mc9Q1u28LWMLmf9qx05yJ0xJnze968D3lbtk5s0Vq9UVXAc5/RwZRj2RiVhSlC
         V02yHHYjGVPa6G+HFK3PNChrChO3yCe+GsaNxyAKw7iHFQY1OPH80SZSNz3/i9qqYLrj
         dcfgsfbqS2l7rPH4adMnH2KptWumLWIjph0fvsdnSD4DYXZr+ZICtHlQVqr8JfLO8opA
         EQZ71RhesqVvVJmmK9ySQU1ckaLv2TP1pIHKAuS4HiMhynZNh3Pg/s07DaF/pQZOxZX4
         NzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756334; x=1713361134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/zFrjm9t8xgCC5pg3svGCPHHB87uoPXjvKSBy+e5eA=;
        b=iPI4X/vLj9FdnhxmPBlAP8DRL7FVpngzxrpVG9nJWnL2I4/XzrEt/4CuU+SCZmPtaV
         VtZeBlGd71u8QqVFWHF39hO0UpiSQDqf46Rh1IyrQuqjFLR4luyRpLVJEXqTcaFSdby2
         wl/k7geKzDnQH/bttuujdgBhbGOfxKJYcWSAOgc5hkl6ZCd9B0JJ8cpvfwFLxtblaY/T
         yuPk4ZWPgmOSglccQIswJKXFT5grEIYzs7LjjRm4jfx1f+ZTJe9/+JFNP+1VzNq6hBQz
         30yLAfLQvy43lgSF9sEhOZG2C+Z2wNdV3LB+gK5izIJluIfTYXr71eAQKvNUJ+DtaDhA
         oCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNXp7W3BA/gcX1BFF/nMyEpFNg3drUw/+l1e+C15Z5a5IHfVulI/dRlJr3VeM0nZ8YuI4ZtecCuOhPJ82b1NDft6k+3zH70ux49UCUHw==
X-Gm-Message-State: AOJu0Yzg1Ohlpfvcmh78jAUh46xalTMr3GS2bKgK7XzV7OacV8/V/Qyt
	tsReEzHWOvw8U35g3nNLVBu4FPe/M/d+yimCNkEcHG6sZ1xgRU1V
X-Google-Smtp-Source: AGHT+IGGv4rxOH4MsZqTVjE0iNMg2rhojhyRNmgxxiL3kpPmbpKGnrVtuJ0+ZKzbOMEgCoeNhajXVw==
X-Received: by 2002:a05:6830:1d49:b0:6ea:f75:f178 with SMTP id p9-20020a0568301d4900b006ea0f75f178mr3326131oth.18.1712756333897;
        Wed, 10 Apr 2024 06:38:53 -0700 (PDT)
Received: from Borg-9.local (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id t6-20020a0568301e2600b006ea26f39e75sm605226otr.76.2024.04.10.06.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:38:53 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 10 Apr 2024 08:38:52 -0500
From: John Groves <John@groves.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, John Groves <jgroves@micron.com>, john@jagalactic.com
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <6i3kr6pyyvbrcnp6pwbltn4xam6eirydficleubd4bhdlsx3uu@kh6t7zai4pai>
References: <cover.1712704849.git.john@groves.net>
 <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
 <20240410-mitnahm-loyal-151d4312b017@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-mitnahm-loyal-151d4312b017@brauner>

On 24/04/10 12:16PM, Christian Brauner wrote:
> On Tue, Apr 09, 2024 at 06:31:44PM -0500, John Groves wrote:
> > The ref vs. value logic used by sget_dev() was ungood, storing the
> > stack address of the key (dev_t) rather than the value of the key.
> > This straightens that out.
> > 
> > In the sget_dev() path, the (void *)data passed to the test and set
> > helpers should be the value of the dev_t, not its address.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> 
> Afaict there's nothing wrong with the current logic so I'm missing your
> point here. It's casting to a dev_t and then dereferencing it. So I
> don't think this patch makes sense.

Hi Christian,

Apologies, I got confused myself and fubar'd this.

But I believe there is at least one actual problem; please correct
me if I'm wrong, and thanks for your patience if so.

In sget_dev() - original here:

	struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
	{
		fc->sget_key = &dev;
		return sget_fc(fc, super_s_dev_test, super_s_dev_set);
	}

I don't think &dev makes sense here - it was passed by value so its
address won't make sense outside the current context, right?. It seems
like it should be:

	fc->sget_key = (void *)dev;

But that assumes we're using the value of sget_key rather than what
it points to, which I now see is not the case - super_s_dev_test()
is testing for (s->s_dev == *(dev_t *)fc->sget_key), so that wants
sget_key to be a pointer to a dev_t.

But I don't see anywhere that sget_key points to something that was
allocated; the dev_t for sget_dev() appears to be the only user and it's
not something whose address can validly be stored in and dereferenced
from a pointer later (am I wrong?!).

I looked at this because I tried to use sget_dev() in famfs, for which 
it seems to do the right thing (although the dev_t is character in 
the famfs case). But it never found the existing superblock even when 
I knew it existed - so I dug myself a little hole ;)

Although my hacks went off the rails, I was sort-of trying to make
sget_key a value rather than a pointer, because the pointer thing 
didn't make sense to me (at least for the dev_t case). It seems like 
that should be a value unless you have other uses in mind that need 
it to actually point somewhere.

I can try again with this additional clarity, but the "key" question
is whether sget_key really needs to be a pointer - which depends on
what else you want to use it for. Type checking would certainly be
easier if it wasn't a void *...

Thank you,
John


