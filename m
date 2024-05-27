Return-Path: <linux-fsdevel+bounces-20254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BFA8D086B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91741F22965
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70847346F;
	Mon, 27 May 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TnKVm2Q4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01CB79E1;
	Mon, 27 May 2024 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826726; cv=none; b=XyfOCCa00izn5O0Oe7AHx8Z/3JshK70GZQ0UkUbUpAyK8p+DqA1KvNB/bMqCq6WMefHdhviIy5BfLRPMu3cxbmmMnFhCcBIIaOk1j8WWEFmyCghqw2lFtzBxgFDBrDvENGDYWBeobyeWgSDQzFtG+jJ+ctbh1fDTrQVU0Trb0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826726; c=relaxed/simple;
	bh=ZEnmDGmMJqj7KEk0ie3CBFZIM36XwTtC+ckNMpV5JfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI81Dklr9ayYOSBUhw5NQ8K+CxXlS4N0huhVBmh1bAT1iNthFAu023hz1k3qwlUobrKlThpeH7BRgR4/LB5jOZSAeTZFf0Pu0P2p6CyYTsP1OKTV61V1F0N0Qty6sg5rmE8uDRk6OVlRBfAxKxv4sNzVLyRkvdC3Fog5Zeb3sAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TnKVm2Q4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JyExT2QPBjjTN261WejZJyr+bksuXTqgMx7dvL3bvtY=; b=TnKVm2Q4KZu7XfdiuIjFl8l2SP
	q7qPLdiljlgYB7E80/3wwB3hzjoz3kAqSxx2hfBsNzff2Lvan1MOekSO5SbiDDoh4RU36nCdPD9FP
	fBj1/3DjSR8cTMl++NeR/r5vIY5T5Qhr96JWh/5ZyoPM1eBqqBFVmtHHbxIXsVmUa5U7ObrLoeXW5
	cigut4X1NasDd1Nq8xyrek6PMBJnN8DXY0Tim68pOSDiKhc169bghhuL9IHyvXuK4Ll8b5x5XbJEf
	LBsX2ObopJrIbe6ZmfSqeZJZdZd6qa+UusBavEKyszCWBGYJ/pIZYHpObtGlpSjiYcC1+5ZWHtj5Q
	7TpxP1QQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBd3Y-0000000FoRe-3veR;
	Mon, 27 May 2024 16:18:40 +0000
Date: Mon, 27 May 2024 09:18:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlSyYDiCafvQheah@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527-hagel-thunfisch-75781b0cf75d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527-hagel-thunfisch-75781b0cf75d@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 02:29:02PM +0200, Christian Brauner wrote:
> I see not inherent problem with exposing the 64 bit mount id through
> name_to_handle_at() as we already to expose the old one anyway.

That's one way to frame it.  The other is that exposing the different
mount ID also doesn't substantially fix the problem, so it's not
worth the churn.

