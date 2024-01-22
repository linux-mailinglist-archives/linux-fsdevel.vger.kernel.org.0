Return-Path: <linux-fsdevel+bounces-8455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51680836CD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0897D28A017
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6EA4EB39;
	Mon, 22 Jan 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bAHg37/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A173A8C3;
	Mon, 22 Jan 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939808; cv=none; b=sCnU0hu0YzI5piapY1+1+EYz/OI+diyCuP+dXrSgwPExLmSzKRYzmIqV14xIeQR2GEkUmdoVM5Am2sVAzZn1jEPVpB/vf2YJaldmdq3Irm2xpzrmlR0PSnlAilNuMNOup5pPjj//9GXrRp7v5rJ3lfnpphbmaCwDJEax4JmLRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939808; c=relaxed/simple;
	bh=GyxujeA6VefOMTAZlZZ4BZpsYAB+TEiG+zBG1fVfzQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuM7dLkrnFnBzxNXXdh6WvbyU91Np8WwVFGJQ0Kt39wbxU2ZWqUKA7Ik1s9SITbSSMzlP6kjq28oEDaeyThsWVgEq59AgYcsAUB881Upb3zFwboUixMrPyQnJBGYlqVzQKqNOHR5I0y6ia7ewBDkNzT/8acnrByZ8O5j+ksmQj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bAHg37/D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NGNHyrHMg5T+Qh7WpIiamACVfA9Z4Rcr6JKQhuA9VEY=; b=bAHg37/DgOA2D7Nup2N9IoSCUf
	RYBdsFsEU0xkski0IK2yvU1A2OMrf/qhwna0hlIEwWl69adYPIHIu53ORHNeF2VBh5Hg6YqXlDLij
	QgT/abpxa9Ic03QJaHTpi1JbsPKKSfAD09GSoo5WzRD6w09XhsCKb33KdFEtAaiQroP+/MBSczuBJ
	PUqlXM14wca8GyUxdWtL6h281dGgW485gjFNKwYDyeOQmtaqKuC5cFXaOk2jp+fQu2XsCOZRo+WJs
	UhFEoChHuXUqVFkeJ67BcBHkeCQZslkJMYJKeIyQiOigfY3G+09Cq0PK3aHfIXU01a0Vs85+b2vdc
	ADEmH24g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rRws8-00000000Mhy-0VRc;
	Mon, 22 Jan 2024 16:10:04 +0000
Date: Mon, 22 Jan 2024 16:10:04 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>, netfs@lists.linux.dev,
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: Re: [PATCH 01/10] netfs: Don't use certain internal folio_*()
 functions
Message-ID: <Za6TXMHlu1eATvLg@casper.infradead.org>
References: <20240122123845.3822570-1-dhowells@redhat.com>
 <20240122123845.3822570-2-dhowells@redhat.com>
 <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9091df8de30a2c79364698b72e67834d0ac87c7.camel@kernel.org>

On Mon, Jan 22, 2024 at 10:38:58AM -0500, Jeff Layton wrote:
> On Mon, 2024-01-22 at 12:38 +0000, David Howells wrote:
> > Filesystems should not be using folio->index not folio_index(folio) and
> 
> I think you mean "should be" here.

Also these are not internal functions!  They're just functions that
filesystems shouldn't be using because filesystems are only exposed to
their own folios.  The erofs patch used the word "unnecessary", which I
like better (2b872b0f466d).


