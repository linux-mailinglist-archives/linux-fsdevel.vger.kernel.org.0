Return-Path: <linux-fsdevel+bounces-46573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C18A907DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A65A135C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7B2080F6;
	Wed, 16 Apr 2025 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xr/Cm04c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685241FBEB3
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817828; cv=none; b=j02hxd3Fdrf8WGWoMaPYkalWgPzXAS45k7d18wX21p3V1KwLl5zA2QTj0gfb57u29t1S7AGnOkEE+rpgN2DJ+oX/dZgZuYhj8Dekgsm+VXeYKgsypMdFzUM4P1hIq439NBhTtpN8rN4Tpaqs1HGM4YRpDug1QE0wR5T5weubkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817828; c=relaxed/simple;
	bh=Y+Bde6Tf+AfDzNz0SalmJwl1n5GyUo1e0ccjHhe58Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3I+9ZEHwg/X8Y5+dsobBbHQlg6laQcJl514RzakMwUhI6w/6HHp/iFk8OqPm5CXa4gR3XqyAL3sj+C7EfXzJ3lORz0AW+3p+Vjbz3hcBOBdTaIWfXpGK7v8eQ2aYkoSdoCzuQqsImQ3Fdyh1iQmszhs8ctKGdFC36QzjGfnpd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xr/Cm04c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mp0UORuR0fAkxj1gf8ikh00eD9f/BuhpGG8rX4uhTs0=; b=Xr/Cm04cNHUPbQ2RTN2hhMa0CI
	Npa6ZGBaYDOVetRZpTzEsMMg9d/BWHahmZz/juAjnSa5QAApVnjy0/9IcbPLuInAG85kkte0jb5+8
	NLmDVyQ67c5t9gCPqsJt7JKTa0+cN3GTtL8S/MRbfduojMNIszNtECAS2Q8M77mLIaPOlDaZaNBfD
	AMk/7ElLICtO1LCIMYOmi8LodfMVDJq/20vR3jMwqnuPqA94sfYkA5zmmpwqjHTubWwtuak6FES3t
	pAqniR2ahkpLcAPqRxnbWL+20w0HnFKkZP320gwexrexT0v+jOpENa6bD0QHysrvVr5UA6Aw+5wuB
	JQnB1L6g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u54oy-0000000AGkB-2YjS;
	Wed, 16 Apr 2025 15:37:04 +0000
Date: Wed, 16 Apr 2025 16:37:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Andreas Dilger <adilger@dilger.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <Z__OoG1cE_f7Z64_@casper.infradead.org>
References: <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org>
 <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
 <Z_00ahyvcMpbKXoj@casper.infradead.org>
 <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
 <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
 <CAJfpegtchAYvz8vLzrAkVy5WmV-Zc1PLbXUuwzxpiBCPOhK5Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtchAYvz8vLzrAkVy5WmV-Zc1PLbXUuwzxpiBCPOhK5Rg@mail.gmail.com>

On Wed, Apr 16, 2025 at 05:18:17PM +0200, Miklos Szeredi wrote:
> Lack of memory pressure should mean that nobody else needs that
> memory, so it should make no difference if it's used up in negative
> dentries instead of being free memory.  Maybe I'm missing something
> fundamental?

You're missing two things:

 - The dentry hash table is a fixed size.  Long chains give poor
   performance, so polluting the hash table with unused entries
   has a cost.
 - Eventually, we do trigger reclaim.  And then we wait for hours while
   the reclaiming process tries to shrink billions of entries.  I think
   we had a report on one machine of it taking more than 24 hours ("more
   than" because the customer decided enough was enough and rebooted the
   machine).

