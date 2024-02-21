Return-Path: <linux-fsdevel+bounces-12200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E10985CD62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 02:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8842847BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8F4468D;
	Wed, 21 Feb 2024 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYw++rJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A11FBF;
	Wed, 21 Feb 2024 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478581; cv=none; b=nss9/AhKtmOxZE0GKf7ItbslhgRIY60quZlhP/R020er0ngvv38JiRyn75BvWxjQlW/vfKBqHXLiQjCJWA7+8kjsk89Ot3nR6c/+BT+FC9jkhejbhKUe2xH/sieAKn9kKrNXpp7PonbSivo4AYJG7KAieEf8k2WLoBuKI8O/Vlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478581; c=relaxed/simple;
	bh=7yS5lMeSRHcZCY+R3rXcc46JX8Us1L4l71PPlss2OYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG56CmzuOrzXv3CZnAjnVtvXmD4IF6Xj+SmUXFOxa7YIOXwiODjvDCoWnSlxO7zw9UvRXRc/93VMjMD8qRBEiRhRHFOxVuBz/sPYlfX/NrzNG7f+O2/FIOPQF9cAML7crfRW3e3DAyN4jDZo21z7KxVkXxrhdoHlxD6qW1ruN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kYw++rJW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ocYsSgxQit1IpReHX6MZ9VRl0UEjxazch658LWW9u80=; b=kYw++rJWJg6b/DYb1+XV0p9E4B
	Wej+4M6foMiwDRQ8sFttmmpagkp7awqT8qvexCdHte80cTqN0jQT7NUbL5f1uI4rCi23GO3ZBd8Yn
	WvAyLs7XKHS/i43VzPHlbmr/v7GBiMI4zXSiKHQuj5KgNRBW4Kz5GvySy/0zpcPdTzw9I+q1LVBpG
	gzJiy7ezViF4W3/Yl8IFP0rbnDHzT4/Ah0QqwNpERofZf5olICUE0JMznZurRpTUAwSjdPFYiGHgq
	hRjLO2eJEk5l8cnlo1UtWOPuAl/YJ/N/itAlHSxQvCyNLa3j1rnLbDCxIozO4dsxI2cG4vRp8B1vx
	E4OTVBoA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcbK3-0000000H35s-2TNo;
	Wed, 21 Feb 2024 01:22:55 +0000
Date: Wed, 21 Feb 2024 01:22:55 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	lsf-pc@lists.linux-foundation.org,
	Christian Brauner <christian@brauner.io>,
	=?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>
Subject: Re: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <ZdVQb9KoVqKJlsbD@casper.infradead.org>
References: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
 <141b4c7ecda2a8c064586d064b8d1476d8de3617.camel@HansenPartnership.com>
 <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qlmv2hjwzgnkmtvjpyn6zdnnmja3a35tx4nh6ldl23tkzh5reb@r3dseusgs3x6>

On Tue, Feb 20, 2024 at 07:25:58PM -0500, Kent Overstreet wrote:
> But there's real advantages to getting rid of the string <-> integer
> identifier mapping and plumbing strings all the way through:
> 
>  - creating a new sub-user can be done with nothing more than the new
>    username version of setuid(); IOW, we can start a new named subuser
>    for e.g. firefox without mucking with _any_ system state or tables
> 
>  - sharing filesystems between machines is always a pita because
>    usernames might be the same but uids never are - let's kill that off,
>    please

I feel like we need a bit of a survey of filesystems to see what is
already supported and what are desirable properties.  Block filesystems
are one thing, but network filesystems have been dealing with crap like
this for decades.  I don't have a good handle on who supports what at
this point.

As far as usernames being the same ... well, maybe.  I've been willy,
mrw103, wilma (twice!), mawilc01 and probably a bunch of others I don't
remember.  I don't think we'll ever get away from having a mapping
between different naming authorities.

