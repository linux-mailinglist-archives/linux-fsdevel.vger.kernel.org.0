Return-Path: <linux-fsdevel+bounces-38899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A80A098E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AD71889170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F0B213E7B;
	Fri, 10 Jan 2025 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOlYs1LA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212F6214212
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531358; cv=none; b=nh16DybN3rk8O5ZCB27OEtJFxtihyAe8GmB4AiuqI7FENgPKqcNl+QUhI0VtM7AttD3s/F1V7YVbalmbwr4ECMXPEdhu4/pJBrAmRLV4oYt22FARuAghy4KqVXxoCVV7vd98QUm599OfM9UYAg82kk6em+NXilznJ1WLs53jDZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531358; c=relaxed/simple;
	bh=clUVcotYiys8hPm6lsgfnK6ugzToYmep5mt13KXfGEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIQ4HLtzE4IPjWWvgcZX6/0o7KEQkO+LwtKl05NP1BuKAAKi7F2JOrhwYpkec3xzMuggy3ojriRd5c6cnvB/iJN8g2JoqkFcUEO4NysIL9hZdh/OZI6Pv6yBuuNNjXAlZXzb++SIURmhs8WCXWrgWuPg/b0/Fd6IWWeR01AU8W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOlYs1LA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736531355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AmTC5bacod4P1SYPlw6KCII1FFu38/8xcWMX5LBYrV4=;
	b=BOlYs1LAAT1qAklN79FDvNSYof68dIkBKl/RpRsnW4xPu8LBE/XiEBfjHPCie7pxAfu6hn
	j7u5yWhOopaqlWtx/2BVa2J7LOrn2Mh+fi8KNK6DSy3LPHBKyoRZZ+usl60AyuB8YR9RuW
	qoLa0ux/Zn42l9d9XGobArfVtQVycdQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-DQ8CyvQ2N2CYSGP_0zJ2LQ-1; Fri,
 10 Jan 2025 12:49:10 -0500
X-MC-Unique: DQ8CyvQ2N2CYSGP_0zJ2LQ-1
X-Mimecast-MFC-AGG-ID: DQ8CyvQ2N2CYSGP_0zJ2LQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3C5419560BB;
	Fri, 10 Jan 2025 17:49:09 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09A2219560AB;
	Fri, 10 Jan 2025 17:49:08 +0000 (UTC)
Date: Fri, 10 Jan 2025 12:51:15 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/6] iomap: advance the iter directly on buffered writes
Message-ID: <Z4FeE4F4Hp_PznnV@bfoster>
References: <20241213143610.1002526-1-bfoster@redhat.com>
 <20241213143610.1002526-5-bfoster@redhat.com>
 <Z392eER1_ceFfMJe@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z392eER1_ceFfMJe@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Jan 08, 2025 at 11:10:48PM -0800, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 09:36:08AM -0500, Brian Foster wrote:
> > +		loff_t pos = iter->pos;
> > +		loff_t length = iomap_length(iter);
> 
> AFAICS we could just do away with these local variables as they should
> never get out of sync with the values in the iter.  If so I'd love to see
> that one.  If they can get out of sync and we actually need them, that
> would warrant a comment.
> 
> Otherwise this looks good to me, and the same applies to the next two
> patches.
> 

Hmm.. they should not get out of sync, but that wasn't necessarily the
point here. For one, this is trying to be incremental and highlight the
actual logic changes, but also I didn't want to just go and replace
every usage of pos with iter->pos when it only needs to be read at a
certain point.

This might be a little more clear after the (non-squashed) fbatch
patches which move where pos is sampled (to handle that it can change at
that point) and drop some of the pos function params, but if we still
want to clean that up at the end I'd rather do it as a standalone patch
at that point.

All that said, length is only used for the bytes check so I can probably
kill that one off here.

Brian


