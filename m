Return-Path: <linux-fsdevel+bounces-77570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAwNMru0lWkGUQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:46:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74019156684
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740003017C12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E131AA87;
	Wed, 18 Feb 2026 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="iWrr6L3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA842FC011;
	Wed, 18 Feb 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.157.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771418797; cv=none; b=j3espNnlZborDc6/svPQeM9Qff4tj4CXWywcq9y1tvqSOw0TiY6p4U8kvx+V5QurTJQap9Vlgaqy/ZDFf6B34Q938zMyQbTFAcLriA3tmQg6jGtK+JaTPEt1P58PE/Whnta7ma5aEIofRk8eOOYzcHVd8ks/cHEnky9WgGqYXqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771418797; c=relaxed/simple;
	bh=Pf0ky7VJtmQgZG9U5wyhRHyMbdOaayrlkz5iGRqtdbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sA9Dt8QWVdYivIcQ52tZJzMs1XGblHyZDP11mKCXrr7kwNsvJ1K5CtlvGPuXuBuQ4XrnYWNHGI8upxSjG1TRidYuTq9JeM6kznnB7rSaOViER5d85comlZ9nP0zGRgdMXkyx+NF5xntyHkp+I+DoXvWE/nCJrftgoTSJjZUWPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com; spf=pass smtp.mailfrom=crudebyte.com; dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b=iWrr6L3R; arc=none smtp.client-ip=5.189.157.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crudebyte.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Content-ID:Content-Description;
	bh=QBMk+4Q4w2PDFULpcFzorTKdWNEp9yy900J7ZQr3JJs=; b=iWrr6L3R2Mp5doFoXOPkHEfABt
	/29i3itGwrrDO2QTX3QvN0nQUHU7lEWnYZFZ0vwTYa65i+aYbKqSN+UkQOnzgIzWcv0/esf5OClna
	kQe/sxVHdVgblD1TYdzlFYKUliKoBTMDY4y8EN0KdZTTr6zhhNFNXjnnsGuX4FNpp8NrP/GSlsapo
	/986DrP+ftmsZsj4Qe+ATZUQQmFyDJPihnER7yaycqAZWNNSNgg6s3W+jqs/GwFilujyUOKWyQi8R
	HXb+dkk81xaeS5jBkoTIjZHY21RHIL8MFwj9YYJuGzBfB74PYQYTbEnBOfAP0SSSseDIYOgYzLJln
	XSroXZgD0pqPaI+TdkRp3s2GjDVOJFcMNaTg8ihMeuf2IhFYwLFovu22HeiMIac5F8D6sLJ2ytsd2
	1GyYIRy5QPiEcZEQqB7zyN9ZGfkM87goh5qc+shQnn21VtixQWa6FRjxB+wTy1Emz/CZFg9gMrocD
	nXBFoQDybSUmJ4VlAYFS2isNANwTJOhDdOTGGWJNgbarZRvqeMgT/ROE9piYRQemaSrNu2sa8xQKq
	7YIPvkQ05O/MdSpyZgkbDHSX0tG8JLv0rPjxRvQVmyNbBu7F5mnbSJCO6RTl3Agvk3FfqotZ+Vo7c
	Nwo1ZVAVzSyHuq6RFs4Hop9bE5Bdhkn9hVJI4IWak=;
From: Christian Schoenebeck <linux_oss@crudebyte.com>
To: Remi Pommarel <repk@triplefau.lt>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH v2 1/3] 9p: Cache negative dentries for lookup performance
Date: Wed, 18 Feb 2026 13:46:26 +0100
Message-ID: <4714422.LvFx2qVVIh@weasel>
In-Reply-To: <aY2aXG4ljulj1QRh@pilgrim>
References:
 <cover.1769013622.git.repk@triplefau.lt> <10801068.nUPlyArG6x@weasel>
 <aY2aXG4ljulj1QRh@pilgrim>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[crudebyte.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[crudebyte.com:s=kylie];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77570-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux_oss@crudebyte.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[crudebyte.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[crudebyte.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74019156684
X-Rspamd-Action: no action

On Thursday, 12 February 2026 10:16:12 CET Remi Pommarel wrote:
> On Wed, Feb 11, 2026 at 04:49:19PM +0100, Christian Schoenebeck wrote:
> > On Wednesday, 21 January 2026 20:56:08 CET Remi Pommarel wrote:
[...]
> > > diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> > > index c5bf74d547e8..90291cf0a34b 100644
> > > --- a/fs/9p/vfs_dentry.c
> > > +++ b/fs/9p/vfs_dentry.c
> > > @@ -23,6 +23,46 @@
> > > 
> > >  #include "v9fs_vfs.h"
> > >  #include "fid.h"
> > > 
> > > +/**
> > > + * v9fs_dentry_is_expired - Check if dentry lookup has expired
> > > + *
> > > + * This should be called to know if a negative dentry should be removed
> > > from + * cache.
> > > + *
> > > + * @dentry: dentry in question
> > > + *
> > > + */
> > > +static bool v9fs_dentry_is_expired(struct dentry const *dentry)
> > > +{
> > > +	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
> > > +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> > > +
> > > +	if (v9ses->ndentry_timeout == -1)
> > > +		return false;
> > > +
> > > +	return time_before_eq64(v9fs_dentry->expire_time, get_jiffies_64());
> > > +}
> > 
> > v9fs_negative_dentry_is_expired() ?
> > 
> > Or is there a plan to use this for regular dentries, say with cache=loose
> > in future?
> 
> Yes I wanted to let the possibility for dentry cache expiration open,
> maybe this could be a nice thing to have ?

Fine either way, I leave it up to you.

> > > +
> > > +/**
> > > + * v9fs_dentry_refresh - Refresh dentry lookup cache timeout
> > > + *
> > > + * This should be called when a look up yields a negative entry.
> > > + *
> > > + * @dentry: dentry in question
> > > + *
> > > + */
> > > +void v9fs_dentry_refresh(struct dentry *dentry)
> > > +{
> > > +	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
> > > +	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
> > > +
> > > +	if (v9ses->ndentry_timeout == -1)
> > > +		return;
> > > +
> > > +	v9fs_dentry->expire_time = get_jiffies_64() +
> > > +				   msecs_to_jiffies(v9ses->ndentry_timeout);
> > > +}
> > 
> > v9fs_negative_dentry_refresh_timeout() ?

Nevertheless I would rename this function to something that at least contains
"timeout" in its name, as v9fs_dentry_refresh() is somewhat too generic IMO.

> > 
> > > +
> > > 
> > >  /**
> > >  
> > >   * v9fs_cached_dentry_delete - called when dentry refcount equals 0
> > >   * @dentry:  dentry in question
> > > 
> > > @@ -33,20 +73,15 @@ static int v9fs_cached_dentry_delete(const struct
> > > dentry *dentry) p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
> > > 
> > >  		 dentry, dentry);
> > > 
> > > -	/* Don't cache negative dentries */
> > > -	if (d_really_is_negative(dentry))
> > > -		return 1;
> > > -	return 0;
> > > -}
> > > +	if (!d_really_is_negative(dentry))
> > > +		return 0;
> > 
> > Is it worth a check for v9ses->ndentry_timeout != 0 here?
> 
> The check will be done in v9fs_dentry_is_expired() not sure this is
> worth the optimization here ?

Right, that's OK.

Overall I think it makes sense to bring this series forward. The improvement
is really impressive.

Thanks!

/Christian



