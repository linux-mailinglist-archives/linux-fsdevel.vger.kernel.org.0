Return-Path: <linux-fsdevel+bounces-27614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06496962D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D17B222A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706741A3BC2;
	Wed, 28 Aug 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvAg5w+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84E44C68;
	Wed, 28 Aug 2024 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861903; cv=none; b=FJYu0uajvEvqOAK8sAZufF0l47ZwZepEartYS2q3KlIxL0ZVwaoIBEaVeL7KfWVw22qYi67w0TYZMQNXwWNa6WMW/YBgftOUlDFby/e+H/1XXzDDOP4d70z0Mr4JpcaUnQGUGpxifsBsI366Dvkhi0fwGLFQOowTp5lBogm7S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861903; c=relaxed/simple;
	bh=1oA0WZAqA9YscwAkJujhTv2VIqsbmaLV67gV0Tf2r6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgHhgwwKiA5JfNQSyvVgjuh3MA09H681+Xd5RjbTzxiyInvKDmUNrmuRXR4t9uBW6Hc8qdSzO+sbAzvL+sAuAiLsZ1zBeuxOHWqf9dEVxB+6w4C7quhCObMTmxdgv8xluMUZSH2v8EBYszXI955i7GLJViwg75KmcOl32u68Mns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvAg5w+0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64011C55DE6;
	Wed, 28 Aug 2024 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724861903;
	bh=1oA0WZAqA9YscwAkJujhTv2VIqsbmaLV67gV0Tf2r6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvAg5w+08WIVzsIKeMLgTnL4++whZnSXQNJwjulBPPzoPnoITpfIR1+I5kLJIw8XV
	 cXUQkoYHR3+I/f9sIlgx/UetX1F05Qi4hWwWsB99b4GUMeAnyNScZpzK6zBpPvmlAe
	 vg4eMvaQzh+0WzSi/ngt06LWx02NWv7EtP7qctVyOLbn0v0r7uGu50yJ5p1qzL7z0R
	 0V3OKo9XI1uEUsg5if1BEMQQeBgdAI1QOEjN8F7ExTrf940aZNTfJH5jFgMoo4fkCc
	 XncV/Ek/ZlpzbaWbTV0qrSkIGWzM0rcF38Oal0NxIe2Ou48N85GiXV8JtVM0MKMkf/
	 HgBmdfOzgQJIQ==
Date: Wed, 28 Aug 2024 09:18:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] iomap: remove the
 iomap_file_buffered_write_punch_delalloc return value
Message-ID: <20240828161822.GJ1977952@frogsfrogsfrogs>
References: <20240827051028.1751933-1-hch@lst.de>
 <20240827051028.1751933-7-hch@lst.de>
 <20240827163613.GA865349@frogsfrogsfrogs>
 <20240828045252.GD31463@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828045252.GD31463@lst.de>

On Wed, Aug 28, 2024 at 06:52:52AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 09:36:13AM -0700, Darrick J. Wong wrote:
> > > 
> > > As the only instance of ->punch never returns an error, an such an error
> > > would be fatal anyway remove the entire error propagation and don't
> > > return an error code from iomap_file_buffered_write_punch_delalloc.
> > 
> > Not sure I like this one -- if the ->iomap_begin method returns some
> > weird error to iomap_seek_{data,hole}, then I think we'd at least want
> > to complain about that?
> 
> iomap_file_buffered_write_punch_delalloc never calls into
> iomap_seek_{data,hole} and thus ->iomap_begin.  It just uses the lower
> level mapping_seek_hole_data that checks dirty state, and that always
> returns either an offset or -ENXIO, which is a special signal and not
> an error.
> 
> > Though I guess we're punching delalloc mappings for a failed pagecache
> > write, so we've already got ourselves a juicy EIO to throw up to the
> > application so maybe it's fine not to bother with the error recovery
> > erroring out.  Right?
> 
> But that is true as well.

Ok, I'm satisfied,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D


