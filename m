Return-Path: <linux-fsdevel+bounces-76874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PjkKqmDi2l4VAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:14:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27E11E8E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EC273017DDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 19:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D238F228;
	Tue, 10 Feb 2026 19:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gr1JVJDo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215A38B7BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770750886; cv=none; b=UAsjGQ8WfgnJD56uZGjDQMeT0Dv6HC4gR2YJdsj614Mm1IjXS1AhHL3X3jsCnEI7UZ6zebiuaE4yz6Mb3dXOcAE2vEX+fP7RYB2FPTqQEm7sLEffm1zPhXc4zp3rnR7RoriB7YoNf1swKBOhuODiw2wftbSdgxxjMschfHjCF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770750886; c=relaxed/simple;
	bh=mWaFp93K8/ZvcY/Z/ljKL0SWyHpGMPfT+pm4V9Q7NeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mG1AS6u3V8MSBVkKQKIh5oD3boxcS2lUjHcN77uiCJvAZGpNKeBVIA22u5Zbo5+xvGAfeNd5wmcRlmPi7NoqZs+TsTyYTfWOM67mcDjW9rABGG+lt8yS6z/Bv+CM2MjCFHEt1LsgPGEo9CLRL2Z0poW08WyvRy0KPqdNX0eX5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gr1JVJDo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770750884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jidVcSiNZX3lY53glJyY+yFsNcC2P4TE33tkCiOaUXM=;
	b=gr1JVJDoCqgwYkF4SFirYbhh3ylxISwZ4/4wtiYodk6dOjeHzGVwo/t1OuSQ8ZYeO+jYUK
	AGlUbLeaGKkLy6SOG78TNbUtPZe+uItuJeyZBZvezKRK3IK2dCIgaPzm4KTHMvqTkeSByB
	0dPPDX8FcNu7GBRVFyl3DplRXuh2tP4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-_fRs7qcSPlWR7acFKV7_0g-1; Tue,
 10 Feb 2026 14:14:40 -0500
X-MC-Unique: _fRs7qcSPlWR7acFKV7_0g-1
X-Mimecast-MFC-AGG-ID: _fRs7qcSPlWR7acFKV7_0g_1770750879
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90B141956094;
	Tue, 10 Feb 2026 19:14:39 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8315180066D;
	Tue, 10 Feb 2026 19:14:38 +0000 (UTC)
Date: Tue, 10 Feb 2026 14:14:36 -0500
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/5] xfs: flush eof folio before insert range size
 update
Message-ID: <aYuDnLj6pg8IF8KQ@bfoster>
References: <20260129155028.141110-1-bfoster@redhat.com>
 <20260129155028.141110-3-bfoster@redhat.com>
 <aYtZ8OSBCU2EtRQU@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtZ8OSBCU2EtRQU@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76874-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bfoster@redhat.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C27E11E8E6
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 08:16:48AM -0800, Christoph Hellwig wrote:
> On Thu, Jan 29, 2026 at 10:50:25AM -0500, Brian Foster wrote:
> > The flush in xfs_buffered_write_iomap_begin() for zero range over a
> > data fork hole fronted by COW fork prealloc is primarily designed to
> > provide correct zeroing behavior in particular pagecache conditions.
> > As it turns out, this also partially masks some odd behavior in
> > insert range (via zero range via setattr).
> > 
> > Insert range bumps i_size the length of the new range, flushes,
> > unmaps pagecache and cancels COW prealloc, and then right shifts
> > extents from the end of the file back to the target offset of the
> > insert. Since the i_size update occurs before the pagecache flush,
> > this creates a transient situation where writeback around EOF can
> > behave differently.
> 
> Eww.
> 

Yes. I'd still like to have something better here. I just don't know
what that is. I'm hoping that more eyes on this little quirk will
eventually lead to some better ideas on the insert range side.

Thanks for the review.

Brian

> > To avoid this quirk, flush the EOF folio before the i_size update
> > during insert range. The entire range will be flushed, unmapped and
> > invalidated anyways, so this should be relatively unnoticeable.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 


