Return-Path: <linux-fsdevel+bounces-76619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNnsICcqhmm1KAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:51:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53010178F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 18:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEF9C3074E10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 17:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037E5423175;
	Fri,  6 Feb 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rox/Bk3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B833AA197;
	Fri,  6 Feb 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400063; cv=none; b=jy8HUmEoP33PHoFbV5dpYiJV5Tb8u4PNA0vEQXB5ESmtXSaCP2MYq9CqvRr09Bt0mU78nu7+wmF6pxRMGXGk81gT8dDqGUwIhYvsMweQz9cxsHwk4uYAnBAPkuaNHNjidhHp4kmSxN4KY5swGkD+1kikPtiwQ2sTga4MYH/66KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400063; c=relaxed/simple;
	bh=kOL+j4+zx7f0TOuz3cPe4St/xipPB6PPaEm+JbHG7FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdATFbzhphxbZSWdKxO7lbNuGdruLMmsWrScBXF8voKZJ56XVd51FQF1jPMkZ69NjbH5hA6kLiZ3wOzUC+M7rF3rkeFGG5M9Hr7lyAVia6NZuY3Zr/X+v1DvHD+/shDcHD6NCwyohhewoAsE4Gjk54LzscA2pMJI8CVIv10I94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rox/Bk3F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6281EC116C6;
	Fri,  6 Feb 2026 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770400063;
	bh=kOL+j4+zx7f0TOuz3cPe4St/xipPB6PPaEm+JbHG7FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rox/Bk3FQbe3agyq22fZGgS6NCqZchtkf6ubet36qlKGMM0x7I/B8ws1YMiZx78AA
	 khWz1cjkUksfh5zuGZXUXgc7fwFHXDxhJtRATyoBJzAkCbk3JCBBh3dEj08SqDizWY
	 Ta1ovHE/9LqWzzhTucZwklzeAPasd62E3BOs72wZLn7EqU7e+Ao/TWIS7w/v/aC+Wf
	 JoWI934lfJJDe8xFDQeajzkqPC1sRr+Iyq+0nmeh0h3pMCHE0IWl9FDtNFGEHfZ82F
	 BLVZ3uV55P2kBg4RwInvxOFffKj2RQRDov/RRSkclxr2TGKGpXcdtFCqxTXZKCbOOg
	 vXqCUiF7LZxpA==
Date: Fri, 6 Feb 2026 09:47:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260206174742.GI7693@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
 <tq3nyswm72gackesz6v476qqvin5eaa67f4hf6lg52exzv7k7p@tczjh5n777tc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tq3nyswm72gackesz6v476qqvin5eaa67f4hf6lg52exzv7k7p@tczjh5n777tc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76619-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DD53010178F
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:07:56PM +0100, Pankaj Raghav (Samsung) wrote:
> > +static DEFINE_SPINLOCK(xfs_healthmon_lock);
> > +
> > +/* Grab a reference to the healthmon object for a given mount, if any. */
> > +static struct xfs_healthmon *
> > +xfs_healthmon_get(
> > +	struct xfs_mount		*mp)
> > +{
> > +	struct xfs_healthmon		*hm;
> > +
> > +	rcu_read_lock();
> > +	hm = mp->m_healthmon;
> 
> Nit: Should we do a READ_ONCE(mp->m_healthmon) here to avoid any
> compiler tricks that can result in an undefined behaviour? I am not sure
> if I am being paranoid here.

Compiler tricks?  We've taken the rcu read lock, which adds an
optimization barrier so that the mp->m_healthmon access can't be
reordered before the rcu_read_lock.  I'm not sure if that answers your
question.

<confused>

--D

> > +	if (hm && !refcount_inc_not_zero(&hm->ref))
> > +		hm = NULL;
> > +	rcu_read_unlock();
> > +
> > +	return hm;
> > +}
> > +
> > +/*
> -- 
> Pankaj
> 

