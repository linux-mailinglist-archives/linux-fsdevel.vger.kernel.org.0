Return-Path: <linux-fsdevel+bounces-68177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED9C55DEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 06:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AEA38348499
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 05:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A83081D2;
	Thu, 13 Nov 2025 05:58:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98222F5463;
	Thu, 13 Nov 2025 05:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013488; cv=none; b=V1I3pk7UMmTxyWy3C6r0xC3emrhd0hVc7PlGlAM9wnxk5i4u1YVBRPhsWMG9PaFlOzfTzjByqgk4s+koWwvdXPCUJm97GxF9HLLDUc4bEuBJAIIooF6HwFX0KBjXTA/dEJmPP8RC6as9+ty1tm5Sntl2HR5+/TYO49bF8j8QxQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013488; c=relaxed/simple;
	bh=JKWBAyeIxHlTSXPkW7ON9aStxpB/OdKegHS47MxZbSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETlh0drEWGgSDN5XN0sr+jjYodY5B4/pWjWBlkoNs9e6Q79r18VdJjOc2jxwF4PX24iywsuyUJrCuQ3MVYUfn1lwXkhKMGXy5EkqTBE/kR3/+6fxDeuumlLoGkGIfO+2fYX+ir0b7t3CIvBxECaMCyqbN1OSot+Rpl9hV1XRViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAF406732A; Thu, 13 Nov 2025 06:57:58 +0100 (CET)
Date: Thu, 13 Nov 2025 06:57:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	nilay@linux.ibm.com, martin.petersen@oracle.com,
	rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <20251113055758.GA29014@lst.de>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <aRUCqA_UpRftbgce@dread.disaster.area> <20251113052337.GA28533@lst.de> <87frai8p46.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frai8p46.ritesh.list@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> Postgres folks looking for this, since PostgreSQL databases uses
> buffered I/O for their database writes.

Honestly, a database stubbornly using the wrong I/O path should not be
a reaѕon for adding this complexity.


