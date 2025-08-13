Return-Path: <linux-fsdevel+bounces-57631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007ACB24008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 07:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40535847FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6842BE635;
	Wed, 13 Aug 2025 05:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="un83pMT3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F513A1D2;
	Wed, 13 Aug 2025 05:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755061650; cv=none; b=hPTLbHo48C8WgKX0TlwlgHf/e2+v34N2UXAnSwH0Vp+X7Stqx37fwxTUV6ZXboQeB8XfiDopqD77Th6q95x0+T8Iz9kTGY50qq1zT0nFh7UFnUsDuZGlqq/fYZP6uw9JO4APdkEQ1lyWEGrCPEXQ2xEU0sVbRDj5F4u7/mdYFOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755061650; c=relaxed/simple;
	bh=JKTQA9qH82HV2H1Eq1113FuCQKbjc3L96FALVs8Fb0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdbma1CS1Fe5XFSpWy4Z4jzWNAQOxHawTTyks6BuAfW1caQ+Ddt1T9EWN58lJRFLo48Ns9iS4fVViVNWznbrbptVNl8myrGvhT1Chdn/UhZoFMwawCiaXYkhmkH0s3q1o9bc1e7WS0fGC+PTrYdFZVLjo52G/gRdLOjFgjtbgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=un83pMT3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e5U3Jru4QvSh+gZ04F1oAlS7nb9ho9LY7nJhfMe2Y4U=; b=un83pMT3ThYrtWrTPu0bibcpbE
	BhUC6V5s+qnM99OgBU47KW2hMWIdhipx/U9SZn/PdD5iZY3ahTAcXwq0aIxkt/cJakChWWNFTKPg4
	KUV08pYtA3kYj7Qi54yRbxc1ShhWm0mwXMUg8spwnTkBA2O2czkBvvncj4SlMtbpXBh8ZbIJnzhaV
	t3TqAeoDG9jd597x8lKORHvF0/SM6VIUE3IYa0LtNhsmUiE7+0UUNaiBptlPyw+SYYRdhm7rHe2x4
	clE/Z7F1jUQIcL3U0LQCMV7ZGPCCaw1nVh4wbA+er1lwdT2MMj5YKE8J7LmoK82NbdHuiQOaxtcEk
	RoN1I42w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um3hl-00000005txc-0wPb;
	Wed, 13 Aug 2025 05:07:17 +0000
Date: Wed, 13 Aug 2025 06:07:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org, netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org, ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] VFS: allow d_splice_alias() and d_add() to work on
 hashed dentries.
Message-ID: <20250813050717.GD222315@ZenIV>
References: <20250812235228.3072318-1-neil@brown.name>
 <20250812235228.3072318-9-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812235228.3072318-9-neil@brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 12, 2025 at 12:25:11PM +1000, NeilBrown wrote:
> Proposed locking changes will require a dentry to remain hashed during
> all directory operations which are currently protected by i_rwsem, or
> for there to be a controlled transition from one hashed dentry to
> another which maintains the lock - which will then be on the dentry.
> 
> The current practice of dropping (unhashing) a dentry before calling
> d_splice_alias() and d_add() defeats this need.
> 
> This patch changes d_splice_alias() and d_add() to accept a hashed
> dentry and to only drop it when necessary immediately before an
> alternate dentry is hashed.  These functions will, in a subsequent patch,
> transfer the dentry locking across so that the name remains locked in
> the directory.

The problem I have with that is the loss of information.  That is to
say, "is it hashed here" is hard to deduce from code.  I would rather
add d_splice_alias_hashed() and d_add_hashed(), and then see what's
going on in specific callers.  

And yes, it requires analysis of places where we have d_drop()+d_add() -
better have it done upfront than repeat it on every code audit *for*
*each* *single* *call* *of* d_add(), including the ones that are currently
obviously meant to be called for unhashed dentries.

I realize that it's no fun at all - in particular, I'd never been able
to get ceph folks to explain what is and what is not possible there.

I would really hate to have that expand by order of magnitude - in
effect, you make *all* calls of d_splice_alias() and d_add() similar
mysteries.

