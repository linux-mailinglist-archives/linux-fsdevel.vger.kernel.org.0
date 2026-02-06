Return-Path: <linux-fsdevel+bounces-76648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN9pAiFShmnQLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:42:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3DC1032F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 21:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B4C0302AD24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27630F7F1;
	Fri,  6 Feb 2026 20:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqiSDIJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6E2EC0A7;
	Fri,  6 Feb 2026 20:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770410496; cv=none; b=IduDynUgbCds8Sj7hlEFtWHeKaiwiSmZcaRRbU1cT8KL0oIrRCpqh5hJEBA+MV64WVZ3nxeL/weWYqO7mjlU/CplyMcQ/Dhvz/vZmY2oDNNLGTiJjn1AxqN0ok9WKimjCvZOjo9g7rvqxst5Uo+Jw9RCzC8zKUFkJfOaPzcDq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770410496; c=relaxed/simple;
	bh=xcipb4hEl7i+Dk2sGfZ5nhdstt2EB2FqZtfmna+o7j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkIpGUfNb1RAENxcdOEWCb6xWnAYaF3tIzu3U+2wYRtqsSYmJz6KhLAg0yMDFTn03r4HvNaYVGYzKlFb7UGBmORSKIJyhIEV+zVDrFW4W1GrtbI1U7NiNVW1NKdekSWXyAYUKkdqFneSMIonL88S8kbsKf3YCbecZznQGGItsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqiSDIJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10771C116C6;
	Fri,  6 Feb 2026 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770410496;
	bh=xcipb4hEl7i+Dk2sGfZ5nhdstt2EB2FqZtfmna+o7j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqiSDIJtxkN+60JOGBDsRcWp+U9VUHoTMcDdPSJtdyfhDrQ8fBumAZaAcXAUxaWhL
	 pVm0aMB5uPwSTQAJZPtShlhG4eVF+322+RbY6QF+oHR3dIBCP0OyhNa7Ga0Ikc+A7k
	 nCjwaMAKcK+Z4tlfl9emMpZQEmGww+xNTfQg2Vdu0yR7ELQEzmSk1m5UI70d+fJpbL
	 h9j4X+tTGdqNazKbdLjDZjQEngPsK1cIU5RoTpgEExc6UplpLugyKemDrNnhA61Tg7
	 3pqyFBJsxJxF9ST/q1yE6wFryMRQLPp24tvZ90+k2b93v90kW2NHKPq6wlIS/ISHEU
	 WHQ/yjwsJeK/A==
Date: Fri, 6 Feb 2026 12:41:35 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Pankaj Raghav <pankaj.raghav@linux.dev>
Cc: cem@kernel.org, hch@lst.de, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, p.raghav@samsung.com
Subject: Re: [PATCH 02/11] xfs: start creating infrastructure for health
 monitoring
Message-ID: <20260206204135.GA7712@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588582.2137143.1283636639551788931.stgit@frogsfrogsfrogs>
 <tq3nyswm72gackesz6v476qqvin5eaa67f4hf6lg52exzv7k7p@tczjh5n777tc>
 <20260206174742.GI7693@frogsfrogsfrogs>
 <37e584d1-1256-46ad-9ddf-0c4b8186db08@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37e584d1-1256-46ad-9ddf-0c4b8186db08@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76648-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B3DC1032F1
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 07:54:51PM +0100, Pankaj Raghav wrote:
> 
> 
> On 2/6/26 18:47, Darrick J. Wong wrote:
> > On Fri, Feb 06, 2026 at 02:07:56PM +0100, Pankaj Raghav (Samsung) wrote:
> >>> +static DEFINE_SPINLOCK(xfs_healthmon_lock);
> >>> +
> >>> +/* Grab a reference to the healthmon object for a given mount, if any. */
> >>> +static struct xfs_healthmon *
> >>> +xfs_healthmon_get(
> >>> +	struct xfs_mount		*mp)
> >>> +{
> >>> +	struct xfs_healthmon		*hm;
> >>> +
> >>> +	rcu_read_lock();
> >>> +	hm = mp->m_healthmon;
> >>
> >> Nit: Should we do a READ_ONCE(mp->m_healthmon) here to avoid any
> >> compiler tricks that can result in an undefined behaviour? I am not sure
> >> if I am being paranoid here.
> > 
> > Compiler tricks?  We've taken the rcu read lock, which adds an
> > optimization barrier so that the mp->m_healthmon access can't be
> > reordered before the rcu_read_lock.  I'm not sure if that answers your
> > question.
> > 
> 
> This answers. So this is my understanding: RCU guarantees that we get
> a valid object (actual data of m_healthmon) but does not guarantee the
> compiler will not reread the pointer between checking if hm is !NULL
> and accessing the pointer as we are doing it lockless.

Oh, now I see what you're concerned about.  You're worried that the
compiler could turn this:

	if (hm && !refcount_inc_not_zero(&hm->ref))

into this:

	if (mp->m_healthmon && !refcount_inc_not_zero(&mp->m_healthmon->ref))

which then gives xfs_healthmon_detach the opening it needs to slip in
between the two dereferences of mp and turn m_healthmon into NULL,
leading the "mp->m_healthmon->ref" expression to become a NULL pointer
dereference.

> So just a barrier() call in rcu_read_lock is enough to make sure this
> doesn't happen and probably adding a READ_ONCE() is not needed?

Nope.  You're right, we do need READ_ONCE here.

--D

