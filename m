Return-Path: <linux-fsdevel+bounces-44809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB03A6CC8A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 21:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4043ABFDB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Mar 2025 20:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2B82356A2;
	Sat, 22 Mar 2025 20:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="roVYuGKG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A564522A;
	Sat, 22 Mar 2025 20:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742676575; cv=none; b=WlZof364K6pLsR76MKkyRhFK3iKLJKtRB1777SRQvOel1ViyVMsFCeehJejxFRWa0NEM68sw8+PtuWGsODPCUO55y8eXIP+s4/aGI+enpdyGkescutqGFkAS9/+GkFpP9GyLSAxEN2Sxx82vXZAW9tEgxIiZrEUaAC1DRdp3FVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742676575; c=relaxed/simple;
	bh=Dpt+Qi5HL/LChEojVIg8fKxr9rwU5ToF2s3T9oZbW4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8nOtC1MNWNusQ2hSTy0D1KkXDUjmOhMfZ4R8k7TC78Tc85xVryFNmxN+h6pNJ3LIpPEKspRI1bXT/oSR0NklEYycXgEy9Zy+AJI28oBzCi9gPAu+YZUun5H6CayQaq3nead41ua+1hJL6dS66gXay5EPqlNpP4uhLLmaHhiw4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=roVYuGKG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=49++YOCyQWNmUfGfaJCXgmwoTlehQ0ChbOtbRtnavLU=; b=roVYuGKGAaveFhl9FahKGqzjb5
	h0kjrdCPRxnKe3RFeqW97s5/xsj85NS93PYA+escS/2VOUFpxsw7VQEL0zYFjOKerpijkbt11CoF1
	JREIwNfyfObEovtcRhtzVBWf0ft4BpGT7xJ+PpAeyCvrOXfjfh4d8B0ryDsmIM5r0y1d86tNKNfH5
	h1qQm3LKwYrsoQtJ4bc6aR5yn7YSSK0bSQtAJ4p5AfWL9Spq996yI74QVuMPM+yLbvhT+/LF8ilGV
	qKpse/gjnUMhbFO3p/sePHkonIS7aAxQv57XJysvbu0xbR/5ynGsyQlWNM2230XeECLg2Km4VTjTV
	TuQe/M5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tw5mV-00000005pJc-2fN2;
	Sat, 22 Mar 2025 20:49:23 +0000
Date: Sat, 22 Mar 2025 20:49:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linuxfoundation.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z98iU2mcZhuV_1Cv@casper.infradead.org>
References: <Z4pwZkf3px21OVJm@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>

I've had a quick look around the hotel.

All four conference rooms we're using are on the Mezzanine level.  You can
take the elevator to that floor, or if you're coming in from the outside,
there's a staircase to get to the mezzanine.  The doors that lead from
City Councillors St to the mezzanine level were locked when I tried to
open them today, but maybe they'll be open on Monday.  Also the courtyard
door from Sherbrooke is locked.

Concerto (the MM track room) is separate from all the others.  It's a
little hidden; you start going towards the Milton brasserie, and then
turn right just before you enter it.  It was set up with dining today,
so maybe we get special MM snacks?  ;-)

The Opus, Tchaikovsky and Beethoven rooms are all near each other towards
the north end of the hotel.  If you take the elevator, turn right towards
these three rooms (and left to go to Concerto).  There's also a Vivaldi
room that I don't think we're using.

