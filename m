Return-Path: <linux-fsdevel+bounces-26466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF68C959C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5DA1F21932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700218C929;
	Wed, 21 Aug 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NW1OhIAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F321F18C91C
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243859; cv=none; b=lbsrSb5w+oaaVK/61Bd2mDbXcX31fJ0oqWy8nnak5Kx1w1qeAN8cmrXHFm4u4ZCpH5hQ29WHF9zIkmlHFZFJj8dz90qGXyKRKR1cdwqzWgTZgpPwio8pYtt1i5pCngQbYX5kHsinTZrti7UL2MMbnsA4y2+0HGT3iBIrfflPnhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243859; c=relaxed/simple;
	bh=cqHbvDNnsxpI9BHWwBAJNie9btQX4n/yLciWKQH2MGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJz8ADooh3xk3SvEgT2OGstOorMBDa658x9rJNjWTvjHWrYrH5Atn81tIqWtHTJiZE//5IsrKOkbUwXb4f/iN0RW+BrhG2UCulCKX5R8gS/58aRR9bDoa1qhLpT6TnEWqUX07d71S/JnaB8XQDZp5FNyIcE4qylZKD4iGHwQq3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NW1OhIAg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8677ae5a35so72259766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724243854; x=1724848654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+z0tkmKXFuor3PJd/fzSsG2T/EzZytsYDXe7BHDYMiI=;
        b=NW1OhIAg7yeR+qKZYAKlg+epjZzqCn0q7Cgmo69O3Zj9DVx5eRJrgJ7C007lfQggUf
         kSpzw5iNFo1TPlOi5AwI9hihJG7J4fdj5Q6QlwqxywfF9z0WyW7uQFtdGi75Tf+35ZFq
         KUzizVSFBZVJ1cU5Tpoptxwou03YmGwqq9fNWXbxvGyw9vbaK9xs0caBE1koRP994AKl
         5iyt8zbfD/9NgKY9SnZ4DsO3dSSzwMFQ8N1lBcSw/+8a83x7ZKA8L9tpDkS/NjOelrQv
         5cNK6j1x9+5gPFXbsMjFxCd4Inqmp29rm5K04U12Dm/6qrBINPz0hmwBwbyMarz9PHL1
         Th5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243854; x=1724848654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+z0tkmKXFuor3PJd/fzSsG2T/EzZytsYDXe7BHDYMiI=;
        b=wmYiVnyQaSQZ56NUL+gLxp9S6WjMELJybdvt6yhrlspMiXrVZwb/lSrzx7Clf0shf/
         HlOzPlOzDX2+aYI0PyAde22vjkubDQz2MEEVPJmVc0KroBoHELq6U5uRQm+oIqAwOmHA
         5satD587RozA45xSbEAL9My0praUcjKmiaC+UMhS8q+edwLgxy7PaXz4xlTELeLGcQRX
         F5rnNX/AiawayxxM17Y4nx+y8quqOIDd56jdw9iwtGtdcc8xOhlMTTgyaZCgfAP/0wB7
         gwFzrotdY4lVVg66G3eFvsQaUemIaW1eySzSfQAdaJSV18svKbAhakknMsj+i6hnV7TA
         Th+A==
X-Forwarded-Encrypted: i=1; AJvYcCWsDpW6exXvPliqUxzGSDXBAw3+kGcXeCmXp7xQncnFG5/dMd0+2Xm9x18uwYeSJi01cRXUijEJJ3laIc9t@vger.kernel.org
X-Gm-Message-State: AOJu0YyKkeNkasTGtyzOJ9hHjtl4woCTdqgzFXvPN+9Azy0HfTBD7Hdr
	iW/qQv/wTx0J+SL1vynpLvQpYftG6y1zk3U2PuR/m7f6m0TE62br6xIdYmOaKhQ=
X-Google-Smtp-Source: AGHT+IFet+ZD+ZG5UYlF6HZaloNtjZmJNvxbYWC/Q0UrbM+pJa4I2BB6pLCsLtQOrrm0QxUkoBAEZw==
X-Received: by 2002:a17:907:9483:b0:a7a:8e98:890d with SMTP id a640c23a62f3a-a866f2fe311mr183761166b.16.1724243853995;
        Wed, 21 Aug 2024 05:37:33 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8681c106aasm27698966b.216.2024.08.21.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:37:33 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:37:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <ZsXfjQTEel3GyjJc@tiehlicka>
References: <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
 <ZsXTA_dOKxmLcOev@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsXTA_dOKxmLcOev@infradead.org>

On Wed 21-08-24 04:44:03, Christoph Hellwig wrote:
> On Fri, Aug 16, 2024 at 10:54:37AM +0200, Michal Hocko wrote:
> > Yes, I think we should kill it before it spreads even more but I would
> > not like to make the existing user just broken. I have zero visibility
> > and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> > it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> > directly. >
> 
> I don't understand that sentence.  You're adding the gfp_t argument to
> it, which to mean counts as pushing it there directly.

Sorry, what I meant to say is that pushing GFP_NOWAIT directly seem fine
unless I have missed some hidden corners down the call path which would
require a scope flag to override a hardcoded gfp flag.
 
> > It would require inode_init_always_gfp variant as well (to not
> > touch all existing callers that do not have any locking requirements but
> > I do not see any other nested allocations.
> 
> inode_init_always only has 4 callers, so I'd just add the gfp_t
> argument.  Otherwise this looks good modulo the fix your posted:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

Thanks. I will wait for more review and post this as a real patch. I
would really appreciate any help with actual testing.

-- 
Michal Hocko
SUSE Labs

