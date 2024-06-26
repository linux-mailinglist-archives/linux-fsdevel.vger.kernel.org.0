Return-Path: <linux-fsdevel+bounces-22512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CA91822D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18021C233E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91021186E39;
	Wed, 26 Jun 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fl3agbKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3A71862BB;
	Wed, 26 Jun 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407791; cv=none; b=OXiUizLINbLU21K4j9mXzvNWWfZnYeaieQjQPc0rGfF7CsOeWYFmOSVTbJtF+DdJBaVNoW7m0qIXEC6egqBD3pHmeyZJjONzemaXNDpvx3AM/rpjO3jVxQuSEbU7RhVIk1AQlrX439EoAYuXASweri6YEA05VuEZADAZqi6IfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407791; c=relaxed/simple;
	bh=atkpYglgRpg19Eiw/3VSBe0DTTAk3D2dF51fgCmxR04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrFb5kwTBfH6PrssWGwy25lfRrF0J1OLA+KcZCtWtGPErdwVyGym5L2Eh4cSn7OklpWV9au/axLBe8QJOmOuQUWcd5vfTjyvVdQmVDEfVn+PMn3w+1EVBNrt5+QoUUbOxyhNY56sglp8vLBR7NwMKTBHNFlEul8yGt+NZQ5iAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fl3agbKg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=n8inThiMQEz9yjJS5aRivSJNY95ObkUqVgdsqaqITkY=; b=fl3agbKgUPaKUcciG3cBHn0gXs
	owQBxjR+f/GVXap2MsWCUxXAkC/EKXRhoi8rQ8sSFdHAA8DjbkYioT0VDaFMzsIp24h8Y314aQ7Ni
	F0M4HAqsmgz9DhvcujLUYS6KOV1qtLRbwGFDcZIyV+aOh+rdK5MWYRr6mgHSOZHh2gEpZEZIjehvD
	fsEmoQrHfbopHyngwWLzqwLVCDtjOituJap6rTKAuVBzNYnCum99ESXYhTdwfHqey2XHOj9taU8A1
	QvVLpYwKgn2+rw3oeLxNSiy383OvZxg0Xz2wTVgupcTklTq6M/+v2BxjETptkTzM7b+3qbDshBqTl
	kgM0bhGw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMSVe-0000000CLp8-3XHe;
	Wed, 26 Jun 2024 13:16:26 +0000
Date: Wed, 26 Jun 2024 14:16:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 2/5] rosebush: Add new data structure
Message-ID: <ZnwUqpHXGpzK2dEV@casper.infradead.org>
References: <20240625211803.2750563-1-willy@infradead.org>
 <20240625211803.2750563-3-willy@infradead.org>
 <ZntUZjXKBVDuAufy@gallifrey>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZntUZjXKBVDuAufy@gallifrey>

On Tue, Jun 25, 2024 at 11:36:06PM +0000, Dr. David Alan Gilbert wrote:
> > +Overview
> > +========
> > +
> > +Rosebush is a hashtable, different from the rhashtable.  It is scalable
> > +(one spinlock per bucket), resizing in two dimensions (number and size
> > +of buckets),
> 
> Is that old - I thought the cover letter said v2 had fixed size buckets?

Thanks.

 Rosebush is a hashtable, different from the rhashtable.  It is scalable
-(one spinlock per bucket), resizing in two dimensions (number and size
-of buckets), and concurrent (can be iterated under the RCU read lock).
-It is designed to minimise dependent cache misses, which can stall a
-modern CPU for thousands of instructions.
+(one spinlock per bucket), resizing (number of buckets), and concurrent
+(can be iterated under the RCU read lock).  It is designed to minimise
+dependent cache misses, which can stall a modern CPU for thousands
+of instructions.



