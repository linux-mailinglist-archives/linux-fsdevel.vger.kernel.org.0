Return-Path: <linux-fsdevel+bounces-47030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B9EA97E05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2FA189C787
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E934266581;
	Wed, 23 Apr 2025 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGdGVkrC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324EA95E;
	Wed, 23 Apr 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745385523; cv=none; b=HJTX8r5N2ubWvtVRG7tbfOInMjB3tBFlb+VB3saJef1FZTtb3GJVXzE/NEjzMn+9JA5UfmZq0lhxmRcQBOE1fh2UVje19elr2csmj+DDSFXLu3FDE0dPAERrdxZIvOuswAQczX3RuivUcG7+mp8udZ/fZy7wEkBLUOkey+2HmXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745385523; c=relaxed/simple;
	bh=rg4MqTe0LYLHT84qw4MF59gwYThCwYUSpTGxLQGysXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGT6ADtFLbhxXhfaxLQsUcCO8QEIP1Qf2QrvdilQLi6G2J/5Jb00UyuP0vOvX3OM5qsZ7RSJtm4+CD6ySa/D38SVvmYrAzpwX7RUDUsLUGtvWSQTlReuieFTT4xtaguTSBuTXzIXnyJ2rxKu9w9mr9bj8bi+b6lGMEvo6QY4FoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGdGVkrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99613C4CEE2;
	Wed, 23 Apr 2025 05:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745385521;
	bh=rg4MqTe0LYLHT84qw4MF59gwYThCwYUSpTGxLQGysXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGdGVkrCs92SpdAAX5OrMJ82y8MGPQRRPHycSeZ+GZBMF6W5yuWeInTnLwykLX5Je
	 4zs0FOwfMZcaZyylw238WSdwm3H2NWSrUkyfM3dIdcna7It1W2pcTlx0DFigLr4Mjk
	 asGxWFuTjgFNTYA1qWzQhqWsXzCmxuXni8lx0GxgnwNt0NGckX4N/jxAMs0d8xaUWZ
	 GbRBlqzdN6G+/dTeBDSooCYzOXfCRS1VzZW/SOy4xkTJLwzWAaZhn8Coj8fkEo8C81
	 dpV1iFi1mkM3DnL+T6edOmrj+6TIid8dMk+XruSWXcNRepqVqnDnpoHY6bY5U3OMSt
	 lNAXt9DkpHPAg==
Date: Tue, 22 Apr 2025 22:18:39 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org, djwong@kernel.org, hch@lst.de,
	viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
	linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, catherine.hoang@oracle.com,
	linux-api@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
Message-ID: <aAh4L9crlnEf3uuJ@bombadil.infradead.org>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
 <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>

On Tue, Apr 22, 2025 at 07:08:32AM +0100, John Garry wrote:
> On 21/04/2025 22:18, Luis Chamberlain wrote:
> > > /*
> > > +	 * The retry mechanism is based on the ->iomap_begin method returning
> > > +	 * -ENOPROTOOPT, which would be when the REQ_ATOMIC-based write is not
> > > +	 * possible. The REQ_ATOMIC-based method typically not be possible if
> > > +	 * the write spans multiple extents or the disk blocks are misaligned.
> > > +	 */
> > > +	if (ret == -ENOPROTOOPT && dops == &xfs_direct_write_iomap_ops) {
> > Based on feedback from LSFMM, due to the performance variaibility this
> > can introduce, it sounded like some folks would like to opt-in to not
> > have a software fallback and just require an error out.
> > > Could an option be added to not allow the software fallback?
> 
> I still don't see the use in this.

Its not the use, its the concern for underdeterminism in performance.

> So consider userspace wants to write something atomically and we fail as a
> HW-based atomic write is not possible.

Sounds like a terrible predicant for those that want hw atomics and
reliability for it.

> What is userspace going to do next?

It would seem that would depend on their analysis on the number of
software fallbacks where a software atomic based solution is used and
the impact on performance.

> I heard something like "if HW-based atomics are not possible, then something
> has not been configured properly for the FS" - that something would be
> extent granularity and alignment, but we don't have a method to ensure this.
> That is the whole point of having a FS fallback.

We do with LBS. Its perfectly deterministic to be aligned with a sector
size matching the block size, even for metadata writes.

> > If so, then I think the next patch would also need updating.
> > 
> > Or are you suggesting that without the software fallback atomic writes
> > greater than fs block size are not possible?
> 
> Yes, as XFS has no method to guarantee extent granularity and alignment.

Ah, I think the documentation for this featuer should make this clear,
it was not clear up to this point in patch review.

  Luis

