Return-Path: <linux-fsdevel+bounces-22972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C386F9246B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8087E284915
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0371C0076;
	Tue,  2 Jul 2024 17:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSQlf2bz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86563D978
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942899; cv=none; b=MMRNtMGh+LwUbCR2//ih4GaEKnn6+u1huaSJUTcp/X5kV5o9jhJe6fsh7MFdomMMRYdi08oqTEXZ2g6sxpdCuzJu9xp8O4bM+4AuXd23wAICECbNdL4imw9CgBZVSLFnI+mtWIkGV4KOkV/WWsmcD8QPM9oNv+N0v6vuxTZtFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942899; c=relaxed/simple;
	bh=bLkZrlMgyVEpjA1YrE3kjikw1KS9StmiUIegCeHlHmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWfzqU8VceqNB+27EtEVLeLUEUdfrS/rP39z/CwQ2eRQXwrezY6EtaBRV0zwLjt6kuH8Ukljy0vkDUn+S6yxCBTI7G1NmAHJYhzw/VyvgwOT+qpKPOKjkicJNquUjPzJSeHAh5NzLHJ2DXzgTD4TImk3nQQZxdeJj5LAqXotZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GSQlf2bz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719942896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n09y5a5T+fZg7bwAtcTC5FrNJzRWTsWmxSkbo4B6iM4=;
	b=GSQlf2bzlLOBZAQeHoq+qJBhDBEXKAG/RDZ7u06um4N3S/AuUIask9w7Frtf83V6fXwzbD
	8DVW9QkHPCDRSw3Z/BJqJFe22OXDVk2W0fYWJascDHOmpV4pCg6bpRngkyexqgpLkUnTF5
	tThcKkZ7IdLo6yytAUIumhlMazwn+H0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-WR4gbyhQPtWdi0P2wwcV1A-1; Tue,
 02 Jul 2024 13:54:55 -0400
X-MC-Unique: WR4gbyhQPtWdi0P2wwcV1A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4943719560A6;
	Tue,  2 Jul 2024 17:54:54 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 671731956052;
	Tue,  2 Jul 2024 17:54:53 +0000 (UTC)
Date: Tue, 2 Jul 2024 13:55:25 -0400
From: Brian Foster <bfoster@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org, Ian Kent <ikent@redhat.com>
Subject: Re: [PATCH] vfs: don't mod negative dentry count when on shrinker
 list
Message-ID: <ZoQ_DeXWaXgHXzy3@bfoster>
References: <20240702170757.232130-1-bfoster@redhat.com>
 <20240702173106.GB574686@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702173106.GB574686@perftesting>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jul 02, 2024 at 01:31:06PM -0400, Josef Bacik wrote:
> On Tue, Jul 02, 2024 at 01:07:57PM -0400, Brian Foster wrote:
> > The nr_dentry_negative counter is intended to only account negative
> > dentries that are present on the superblock LRU. Therefore, the LRU
> > add, remove and isolate helpers modify the counter based on whether
> > the dentry is negative, but the shrinker list related helpers do not
> > modify the counter, and the paths that change a dentry between
> > positive and negative only do so if DCACHE_LRU_LIST is set.
> > 
> > The problem with this is that a dentry on a shrinker list still has
> > DCACHE_LRU_LIST set to indicate ->d_lru is in use. The additional
> > DCACHE_SHRINK_LIST flag denotes whether the dentry is on LRU or a
> > shrink related list. Therefore if a relevant operation (i.e. unlink)
> > occurs while a dentry is present on a shrinker list, and the
> > associated codepath only checks for DCACHE_LRU_LIST, then it is
> > technically possible to modify the negative dentry count for a
> > dentry that is off the LRU. Since the shrinker list related helpers
> > do not modify the negative dentry count (because non-LRU dentries
> > should not be included in the count) when the dentry is ultimately
> > removed from the shrinker list, this can cause the negative dentry
> > count to become permanently inaccurate.
> > 
> > This problem can be reproduced via a heavy file create/unlink vs.
> > drop_caches workload. On an 80xcpu system, I start 80 tasks each
> > running a 1k file create/delete loop, and one task spinning on
> > drop_caches. After 10 minutes or so of runtime, the idle/clean cache
> > negative dentry count increases from somewhere in the range of 5-10
> > entries to several hundred (and increasingly grows beyond
> > nr_dentry_unused).
> > 
> > Tweak the logic in the paths that turn a dentry negative or positive
> > to filter out the case where the dentry is present on a shrink
> > related list. This allows the above workload to maintain an accurate
> > negative dentry count.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> 
> This is sort of a subtle interaction, it took me a bit to piece it together,
> could you add a comment to the sections indicating the purpose of the extra
> check?  Thanks,
> 

Sure.. I briefly considered whether something like a d_is_lru() or some
such helper might be more useful and/or descriptive, but I didn't think
too hard on it. That would also leave one place to add a comment instead
of two, but that's not a big deal either.

I'll wait a bit for any additional feedback and send a v2 with that
tweak. Thanks for the review.

Brian

> Josef
> 


