Return-Path: <linux-fsdevel+bounces-79499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNQbL7KcqWnGAwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:09:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 213F921434C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 16:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 781803050A12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA43BD63E;
	Thu,  5 Mar 2026 15:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJ1EpdYb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2D23BA259
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723208; cv=none; b=eS1nRuZldy+TsLCZMJhW4Cfhhj6UM5Of2jscsF5mEMtwQS2Fs3wH6FP4n3RPqpMhyI+6PTOj08L6GfH841DKLv6dHPBHJ7ye6fXW/3J3jYBdQykSxAMJf+sXbhEla7E2C00hWcL68zhhnVDuGydI8cXQ9kT6gcgtMTtL2ajiXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723208; c=relaxed/simple;
	bh=gBKW/SjArm8OI64gCkOV8ulWTcxoo8IoUyQkqOHdzpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3qKYJES3XLinWhVOcLOUIwHESnaDMC4bbw9onCbDz0ohuqS0wFXJ8Rtjfx4hHi+FUls5VGNmHVo5fHtQFXXK7dftdvRiuNrjUpEW+crG2lkozwnFjjdG3ZB1yUZft1AhCsF0w3vPD1IOYlanfXhlcDnXpfgOJv89fekz3dWHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJ1EpdYb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772723203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QCzDSxbURvoDB/9BEgMytBCLNQre5XUKKfayKWK2Z4o=;
	b=gJ1EpdYbzr9Hk4heUXQTSbkKPtRk1WLjkOqZiI3qKZTLtE5C6A12XGa4b/Ag+ZVxHSjKQv
	o25r3/7pTe3asyVsc1RcKC55Q5KWi2pnUff+wZLQk3JE4Ee+TsSx7BiSVNEVdHwY40Cr6F
	ZwaW4fIHSDzXjPoYMvwL02ef9dY9jcY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-3kykvpSIMdOTVHek5dHrGQ-1; Thu,
 05 Mar 2026 10:06:40 -0500
X-MC-Unique: 3kykvpSIMdOTVHek5dHrGQ-1
X-Mimecast-MFC-AGG-ID: 3kykvpSIMdOTVHek5dHrGQ_1772723199
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F5C61955F2D;
	Thu,  5 Mar 2026 15:06:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.115])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B36481956095;
	Thu,  5 Mar 2026 15:06:37 +0000 (UTC)
Date: Thu, 5 Mar 2026 10:06:35 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iomap, xfs: lift zero range hole mapping flush
 into xfs
Message-ID: <aamb-zfiAd0xYqQP@bfoster>
References: <aY9hY7TwgMXJNzkI@bfoster>
 <aaXesgEmu46X7OwD@bfoster>
 <aabyFY0l7GTEHnoQ@infradead.org>
 <aacv39AZ5P9ubOZ5@bfoster>
 <aagv8y96vGHvbOdX@infradead.org>
 <aag-_c8G_L5MQ42m@bfoster>
 <aahEk4yNqd15BIt7@infradead.org>
 <aahJcVkrkLRtsJO9@bfoster>
 <aahmBCz1xJBCPcZ-@bfoster>
 <aamPDBAAuK8vvYDw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamPDBAAuK8vvYDw@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 213F921434C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79499-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 06:11:24AM -0800, Christoph Hellwig wrote:
> On Wed, Mar 04, 2026 at 12:04:04PM -0500, Brian Foster wrote:
> > This patch seems to work on a quick test. It's basically the two patches
> > squashed together (I'd post them as independent patches), so nothing too
> > different, but if we fix up the zero logic first that helps clean up the
> > indentation as a bonus.
> 
> Cool, thanks a lot for putting in this extra effort!
> 
> Cosmetic comment on the comment:
> 
> > +	/*
> > +	 * We don't allocate blocks for zeroing a hole, but we only report a
> > +	 * hole in zoned mode if one exists in both the COW and data forks.
> 
> I'd reword this a bit as:
> 
> 	/*
> 	 * When zeroing, don't allocate blocks for holes as they already
> 	 * zeroes, but we need to ensure that no extents exist in both
> 	 * the data and COW fork to ensure this really is a hole.
> > +	 *
> > +	 * There is currently a corner case where writeback removes the COW fork
> > +	 * mapping and unlocks the inode, leaving a transient state where a hole
> > +	 * exists in both forks until write completion maps blocks into the data
> > +	 * fork. Until we can avoid this transient hole state, detect and avoid
> > +	 * this with a flush of any such range that appears dirty in pagecache.
> > +	 */
> 
> 

Sure. I had reworked the latter part of the comment as well. With both
the changes it currently looks like:

        /*
         * When zeroing, don't allocate blocks for holes as they are already
         * zeroes, but we need to ensure that no extents exist in both the data
         * and COW fork to ensure this really is a hole.
         *
         * A window exists where we might observe a hole in both forks with
         * valid data in cache. Writeback removes the COW fork blocks on
         * submission but doesn't remap into the data fork until completion. If
         * the data fork was previously a hole, we'll fail to zero. Until we
         * find a way to avoid this transient state, check for dirty pagecache
         * and flush to wait on blocks to land in the data fork.
         */

Brian


