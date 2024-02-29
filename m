Return-Path: <linux-fsdevel+bounces-13153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DF86BFCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B70B1C2249B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B363770D;
	Thu, 29 Feb 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQ8JifZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10A2381D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180269; cv=none; b=A9HdOeBEz5TfRXUVzVsvLB2z5VYYXfzUxaIALMwCtB6WIUyUUNPbcdvsbR6pm4vvLSPguWXRDblMcu66QpSp3UaPIRFfGQJMT6psZVnzCQhnoWt/NUh2b8YPH5Ed9rlFOxP+bglHU7Tv1MSY/2jthQe00wYhErjMcYX9PVMhS4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180269; c=relaxed/simple;
	bh=Thu2WdaqrHHq2TzKZmVUTIy0+2Oi2gsjXhReSUO1VlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTHx3Zb7A1wYWVgCak5hYO25pmJCTh7GVgQPdKm4akyUiui2L3RtRCshbH4aX0a+uqM4sL0N6IX5xykszLxn8bqPvUY7+M937Xj/rIcDuhn9S0Zw53UgvEq95q06r5PbQUe1FwyY5ttzoZNDUSfEai4fxn77Y97dCCwYf0lkNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQ8JifZn; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 23:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709180265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QA4CV5QoL6O9v4dQZqOYVzw93Y6Q2RCbxUs9bIOyLPU=;
	b=JQ8JifZn9UJ5+zA311sYIq3hXQ7chHBT+DVKuDVIK0fmxKbOs6HRnAC9I2qhJ0TpVAckaZ
	Ha2BSUa2G71KfUeMPs+gmtau3SuCRHjTiKGPYs6QXDJEX0JcPt2qUjpk0F8bIRRaTlO3Pt
	L1h13oaQD9gCo8DiD9yH0oxWssO3ZKM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <sd7cximu7qzguhtstpc4xhgwwvfjg3zttwhy7oz7gzrgrmov6t@gjy2wplad6vy>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd-LljY351NCrrCP@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 07:37:58PM +0000, Matthew Wilcox wrote:
> On Tue, Feb 27, 2024 at 09:19:47PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 27, 2024 at 8:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > Hello!
> > >
> > > Recent discussions [1] suggest that greater mutual understanding between
> > > memory reclaim on the one hand and RCU on the other might be in order.
> > >
> > > One possibility would be an open discussion.  If it would help, I would
> > > be happy to describe how RCU reacts and responds to heavy load, along with
> > > some ways that RCU's reactions and responses could be enhanced if needed.
> > >
> > 
> > Adding fsdevel as this should probably be a cross track session.
> 
> Perhaps broaden this slightly.  On the THP Cabal call we just had a
> conversation about the requirements on filesystems in the writeback
> path.  We currently tell filesystem authors that the entire writeback
> path must avoid allocating memory in order to prevent deadlock (or use
> GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> writing pagecache back will not allocate memory in, eg, the network stack,
> the device driver, and any other layers the write must traverse.

Why would you not simply mark the writeback path with
memalloc_nofs_save()?

