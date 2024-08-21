Return-Path: <linux-fsdevel+bounces-26453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C7095961A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B42CC1C208F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F8D1885BF;
	Wed, 21 Aug 2024 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QOnj8T++"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0349622
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225422; cv=none; b=V50DfNnBx9MbsRD7axvufAKFto0dCTRyNWaWDZjUInjC6YiPBSjsE3vbxeRQ2bP1ie1/9DXL9+cVkpWKG2d/qfiL0gh/9PGe0Hh70XMi7c47GEDrvMShba1ApBveokfadE0J+o+vTbaHA/ingCaQc0u2foP9vi20nI89HezRcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225422; c=relaxed/simple;
	bh=fq3/kpxOdlcWu8B7yUW1yNgSnQJtx8OoKfKJj4z298U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYxNrVzki8DZH9bOhVr8X5xuNhLtc9u74GJwsz9478Xh1MqA/c32WYlN5DjhSX1nuL52kWXAl8bzku/WtDSsv+NDyoRWLZmhO5Uq5zLLm0jG6M9NTUy5daKf0+WPO4a6P4OCpSkQkKXwS4VBALx7p+ZMzYwQ4a28S+RUP0rNRvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QOnj8T++; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f3cb747ed7so46773321fa.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 00:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724225418; x=1724830218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkjSIXnXtgFJ5Vpt49bRajJOonIJmCNaAY4mnHQbAN0=;
        b=QOnj8T++hSGNIqMFeOs+6oSqF5KL56UIbONgLGnwPY7aH+iRnkmYSTz/yhackoInpc
         ENLVIcb72l3irjp+VHVpKUVdr1zj1LOPmfvXgEFX+T0fAaLXuYA5tro1F6QA6BdRpzYx
         VhvRAmhBrhIAVKvLCUhZzxiivvvrp3HAuiAZ73oZ1OGIAApUSt47D8SdOSMw0cpxeTfP
         r5Nffxj79zFSUB0NrTh0e4WXpCV7f4bKxA8xHbeF8GkVqsNzghMPoAwra4hMwV/cUmIn
         yrQehrESyIr6p4VNoKS5dudtUG7dPgISNzSeWaxeo5YfOYp6wpOJMqj89nUpplWnEPwY
         REvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724225418; x=1724830218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkjSIXnXtgFJ5Vpt49bRajJOonIJmCNaAY4mnHQbAN0=;
        b=CXHfB/u4M5O0+CNR14AKatLESv7uyRc5z7Ui8GdU0GiQYxwbpLqrWnNwfVtlz+3Wyt
         cywsg8dPYaTUZyef8GNwk6YNeq7PyuiVN2NL0OEcEwuhxDTz1I45oandw9wQQdnGk6jH
         gfPgbWuo0nwBTmWwvNSExJO8CPBj+U2vYf0sb04eORuhkUovSgN24dmuMuZRPNmaCM+V
         h/7UtDGwz/tuihe4pLqUrLIAkEX5P0Ceqfhvqt+ViWJjAQc9FQ0TcxcLlP18U5iMCKIV
         bpb5PXCd4o0caYIH8MqStcsNBoJhX79UgAMgjjIAVfh7tlORPDjI3P2ZDPthBm9jsiL1
         h0vA==
X-Forwarded-Encrypted: i=1; AJvYcCVKrsk368squGVJQiGf11nYl0xvYg3zJ5/scFXulgcpCJFBDvOLVHAuZD1ySDjD9nCJtvx0JIuZ80Su1N6k@vger.kernel.org
X-Gm-Message-State: AOJu0YxUU+tyF3rrV48I52mfjOBaHMWdVmzBNNOKbluvxTKs/0lbKBql
	1+wQZoElaNrdvpBADANEq/EG2vokEn67Q6HcZWzCfsGtSB6Njpd7ixMt9IJ5Mjw=
X-Google-Smtp-Source: AGHT+IH1zI5K65gpP7pOOlrjWT48Ape2eUE5F7BRxsAQJNNQtQ5Jv0CbUEjX4fxYtHwdiouTWu2zgg==
X-Received: by 2002:a2e:460a:0:b0:2f1:922f:8758 with SMTP id 38308e7fff4ca-2f3f88277c1mr9148781fa.4.1724225418154;
        Wed, 21 Aug 2024 00:30:18 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081c59sm7819112a12.85.2024.08.21.00.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:30:17 -0700 (PDT)
Date: Wed, 21 Aug 2024 09:30:17 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <ZsWXiexfzcz98pbG@tiehlicka>
References: <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
 <Zr8MTWiz6ULsZ-tD@infradead.org>
 <Zr8TzTJc-0lDOIWF@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8TzTJc-0lDOIWF@tiehlicka>

On Fri 16-08-24 10:54:39, Michal Hocko wrote:
> On Fri 16-08-24 01:22:37, Christoph Hellwig wrote:
> > On Fri, Aug 16, 2024 at 10:17:54AM +0200, Michal Hocko wrote:
> > > Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
> > > be removed from the tree altogether please? For the full context the 
> > > email thread starts here: https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u
> > 
> > I don't think that's enough.  We just need to kill it given that it was
> > added without ACKs and despite explicit earlier objections to the API.
> 
> Yes, I think we should kill it before it spreads even more but I would
> not like to make the existing user just broken. I have zero visibility
> and understanding of the bcachefs code but from a quick look at __bch2_new_inode
> it shouldn't be really terribly hard to push GFP_NOWAIT flag there
> directly. It would require inode_init_always_gfp variant as well (to not
> touch all existing callers that do not have any locking requirements but
> I do not see any other nested allocations.
> 
> So a very quick and untested change would look as follows:

Anybody managed to give it a more detailed look? I have a fixup for 
[...]
> diff --git a/security/security.c b/security/security.c
> index 8cee5b6c6e6d..8634d3bee56f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -660,14 +660,14 @@ static int lsm_file_alloc(struct file *file)
>   *
>   * Returns 0, or -ENOMEM if memory can't be allocated.
>   */
> -int lsm_inode_alloc(struct inode *inode)
> +int lsm_inode_alloc(struct inode *inode, gfp)

this

>  {
>  	if (!lsm_inode_cache) {
>  		inode->i_security = NULL;
>  		return 0;
>  	}
>  
> -	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, GFP_NOFS);
> +	inode->i_security = kmem_cache_zalloc(lsm_inode_cache, gfp);
>  	if (inode->i_security == NULL)
>  		return -ENOMEM;
>  	return 0;

-- 
Michal Hocko
SUSE Labs

