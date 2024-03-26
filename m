Return-Path: <linux-fsdevel+bounces-15310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8088C044
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 12:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0D01C37C51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 11:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3434DA19;
	Tue, 26 Mar 2024 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq+o2SXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10009101CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451461; cv=none; b=mmwRYUpMHSrTY0LTV55/iO8VPN3oK1r26o2dlxmR5sLSNVGyJNADeblMNja41nmpsJ6n1VKFgQgWGj0YKA1tUDCXNR5oxeTh5zx6HmaHBYzeeXPfyrCVHp67UCnUdijZVv6xrbNKf4I3F9aUv4xA/uuj+nO8FkCCHhKqt5w6RfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451461; c=relaxed/simple;
	bh=ZNlc6iwTMDpsWEIajjXXFDjw0xGuywBaMiUawDZAAKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGf2ppVepLMMyAc5uA2u0nXlX7J2HN31GI80SFJQBWf5TH8Vd1JlGDDod30mgnOnQHyv7v56duZX/qy66aokd2j9t4ca+PkeRjwb1oq/MpSq6DTsbWuZ0rpDjcBkQgdVUBn5qEV+yH+9Bw+KNrluB/y6jDz2uWnWvS1JUe3x4kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gq+o2SXU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711451459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbsHhas6jTeFr1bUoMM9qLqBau4rUwN1X9Qk7ysHbwM=;
	b=gq+o2SXUWoYGoLAwn1IHmTG/SwTiU4Fvf8xPg0V7omGde8AvEm1LRSVIQfnovuMc6Q6ZuC
	2CxYEr5qEcDOVJCzA/g9VtE3H5J0RBkCurwnT0BQFBlbQl65EykAk2ELvb+lBvCE9fjoJC
	xuzCgx7BC8QhYa1cKebl0IC7dO5kG+c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-OnJmmKHFN7qPhCIGdasu4w-1; Tue, 26 Mar 2024 07:10:57 -0400
X-MC-Unique: OnJmmKHFN7qPhCIGdasu4w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c82d12b5so25085291fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Mar 2024 04:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711451456; x=1712056256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbsHhas6jTeFr1bUoMM9qLqBau4rUwN1X9Qk7ysHbwM=;
        b=cwqEzLj7YHfPThFmU8YMPW0C/VP19mB5o9EjOzZKIUmuSVxZZbxXEXlTSwA+pXRvl6
         APWjZFAJ5qxBYBHFPtNvPLxuv3Mfufa7j+103mJIYKLodxHn8yOhNYyGuxdWScR6qFdx
         S8W9rLxdyThVrU/2ziHAQzG7VOuEU+SbgyM6TmB1EVjFhUssCcUCwza/k7UfrywD+Vw+
         MCkYdGwnYh2KWtdY6OL2q+hIuP8pWP8+mNlenNxKq3VEnMPs0hFaiZgId9iLD6wbJFSa
         BNgVInyIqQHPKHBfTOhz2tX+TAukB/6jpXOvqoj5Am3K59r2SIFRcTOV+bjtLbcT16eF
         Mg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXGEdiXt3qqf1KnExV17Js0nj2+nJju8aW1k2mfVj30yccjtvg89ojAsRCKAf5rJ/cU790JKL3pyms8ryKtLr+IH2lHnA05eQzQqUXLg==
X-Gm-Message-State: AOJu0YyYS1H+QZeSXhfl86JAb8G3lbkoMjWqF/vPXpmyurksBIKTHsgP
	A4RPOcorgENjHMYdgZZE224gFaGhHamVA2ciijPFJm7fYd4QWWa0ziFTs6POvCCONMWK5tp+zWz
	QqqglZC6vCpTYZ6TcEqC/txPRloXozFxJIKTRX3hyEHJgpnnJ9W81K9s6WoBzVw==
X-Received: by 2002:ac2:5586:0:b0:513:d94a:670f with SMTP id v6-20020ac25586000000b00513d94a670fmr5483736lfg.31.1711451455757;
        Tue, 26 Mar 2024 04:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLRJmAdOSxox5WJ9aC3aI3Jpy8Tl/zo3xe9o/9ZidMyqz4v5ZPYZY7290reSnFNHS49zajZQ==
X-Received: by 2002:ac2:5586:0:b0:513:d94a:670f with SMTP id v6-20020ac25586000000b00513d94a670fmr5483708lfg.31.1711451455028;
        Tue, 26 Mar 2024 04:10:55 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id i10-20020a0564020f0a00b0056c09a0ed79sm2740503eda.11.2024.03.26.04.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 04:10:54 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:10:53 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, mark.tinguely@oracle.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to f2e812c1522d
Message-ID: <wdc2qsq3pzo6pxsvjptbmfre7firhgomac7lxu72qe6ard54ax@fmg5qinif62f>
References: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jcte2jm.fsf@debian-BULLSEYE-live-builder-AMD64>

On 2024-03-26 15:28:01, Chandan Babu R wrote:
> Hi folks,
> 
> The for-next branch of the xfs-linux repository at:
> 
> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> 
> has just been updated.
> 
> Patches often get missed, so please check if your outstanding patches
> were in this update. If they have not been in this update, please
> resubmit them to linux-xfs@vger.kernel.org so they can be picked up in
> the next update.
> 
> The new head of the for-next branch is commit:
> 
> f2e812c1522d xfs: don't use current->journal_info
> 
> 2 new commits:
> 
> Dave Chinner (2):
>       [15922f5dbf51] xfs: allow sunit mount option to repair bad primary sb stripe values
>       [f2e812c1522d] xfs: don't use current->journal_info
> 
> Code Diffstat:
> 
>  fs/xfs/libxfs/xfs_sb.c | 40 +++++++++++++++++++++++++++--------
>  fs/xfs/libxfs/xfs_sb.h |  5 +++--
>  fs/xfs/scrub/common.c  |  4 +---
>  fs/xfs/xfs_aops.c      |  7 ------
>  fs/xfs/xfs_icache.c    |  8 ++++---
>  fs/xfs/xfs_trans.h     |  9 +-------
>  6 files changed, 41 insertions(+), 32 deletions(-)
> 

I think [1] is missing

[1]: https://lore.kernel.org/linux-xfs/20240314170700.352845-3-aalbersh@redhat.com/

-- 
- Andrey


