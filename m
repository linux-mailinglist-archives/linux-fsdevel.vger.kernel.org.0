Return-Path: <linux-fsdevel+bounces-29045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 951CD973F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 19:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 237EDB270FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47E61A2C37;
	Tue, 10 Sep 2024 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lesOn8KR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11591A00DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 17:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988611; cv=none; b=haEqLgbobOFp4J+m3q0tNAJSykwxNnpBGhpNQs73SnjOXL2jknwij47HXKRfBuW9KGOO7exklchoC9sQx//F2YINnzJIVmujBHMgLKpmf7b1FcMqGSTFgguUusXmoI+QuuJwjbBeRro4wB8v6v0eMubXIxNJJO+NEji8SOH38gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988611; c=relaxed/simple;
	bh=sLy+B+WMURPRvXqJVYK3f4B+xyenn+DyYyOsjKofjpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOopyuK0U6OwSy1FknqKcQHoR9OqlxNwl4JOKWBH01cj5UVMdnA8YlIUmiSby+xk3G8cPYrIiKUcsa6FpdWo3iNwTEledd0kvbMLGIQsADGZzzNes3NtpiytEmxnfbG64TS/eTJaED27sG2K+TNOF7Iu7/GlOWGxinCsSgozyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lesOn8KR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ypQI38tKCJ96oR/BcAhUbtCip3sUC08/sU6YoysRrE=; b=lesOn8KRsGe8pWxrmriVlPVYaS
	m2MvRIUUqD57AtrEIdw1f7D6s97QrJtxC0tlwSC4Z8oocAynx8qMz3V5nxEYCIoBIzxoTblfsvjDI
	HZp5LKaaroKJm8qpKLycRISEfmf7rwHpxu77h3Gk5ZG+wTaambdHjeBa+oJBb+qG+1GiW7x1gZ9d7
	gOIK5MpdAT+a/ipx9TsoL+EbzOHMQDT5xOOcz90hINEZ+vwsUa69FpM5QEy88S86LoO78D4EHclrp
	Tm5JlKVjS6Rl5buUwKwwIQdsb5gr33kyzI4/gR1a5Zr7TR3TpeSQSwfpX62orL+/DajcW6bd3EvxN
	NVEryZyg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1so4Tu-0000000DDqy-0zoG;
	Tue, 10 Sep 2024 17:16:46 +0000
Date: Tue, 10 Sep 2024 18:16:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] uidgid: make sure we fit into one cacheline
Message-ID: <ZuB-_q_rlAy8KkeQ@casper.infradead.org>
References: <20240910-work-uid_gid_map-v1-1-e6bc761363ed@kernel.org>
 <80c0e982a5a55f6c0a0eeb4e717b9fc32d93de3f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80c0e982a5a55f6c0a0eeb4e717b9fc32d93de3f.camel@kernel.org>

On Tue, Sep 10, 2024 at 09:51:37AM -0400, Jeff Layton wrote:
> > Before:
> > 
> > struct uid_gid_map {
> >         u32                        nr_extents;           /*     0     4 */
> > 
> >         /* XXX 4 bytes hole, try to pack */
> > 
> >         union {
> >                 struct uid_gid_extent extent[5];         /*     8    60 */
> >                 struct {
> >                         struct uid_gid_extent * forward; /*     8     8 */
> >                         struct uid_gid_extent * reverse; /*    16     8 */
> >                 };                                       /*     8    16 */
> >         };                                               /*     8    64 */
> > 
> >         /* size: 72, cachelines: 2, members: 2 */
> >         /* sum members: 68, holes: 1, sum holes: 4 */
> >         /* last cacheline: 8 bytes */
> > };
> > 
> > After:
> > 
> > struct uid_gid_map {
> >         union {
> >                 struct {
> >                         struct uid_gid_extent extent[5]; /*     0    60 */
> >                         u32        nr_extents;           /*    60     4 */
> >                 };                                       /*     0    64 */
> >                 struct {
> >                         struct uid_gid_extent * forward; /*     0     8 */
> >                         struct uid_gid_extent * reverse; /*     8     8 */
> >                 };                                       /*     0    16 */
> >         };                                               /*     0    64 */
> > 
> >         /* size: 64, cachelines: 1, members: 1 */
> > };
> 
> Is this any different from just moving nr_extents to the end of
> struct_uid_gid_map? I don't quite get how moving it into the union
> improves things.

It's an alignment question.  Look more carefully at the pahole output.
The array of uid_gid_extent is 4-byte aligned and 60 bytes in size,
but the two pointers must be eight bytes aligned.  That forces the
compiler to make the whole union 8-byte aligned.  If the nr_extents is
within the union, then it can pack with the array of extents.  If not,
it has to leave a 4-byte gap.

