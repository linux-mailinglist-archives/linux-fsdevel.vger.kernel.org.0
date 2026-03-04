Return-Path: <linux-fsdevel+bounces-79402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAG7EApDqGlOrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:34:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D097F201998
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6E5D302F438
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40843A4527;
	Wed,  4 Mar 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KUWIVh/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317A83537F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634859; cv=none; b=lo4Ir4bL22FKuCWrUawqJHXkE3/2razJphIf2wagW9LNUjc3aELhuIxxqS27BpGID7GDKZ0uaKi6fHYUGNoPVckPuImkda85/9px1Cbj1OggzqOWSsgJMGyB+Y80VFIROjHmuclAwkwnQ/Pr7XzBZgfjI2NyvDdf++cXWL2VD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634859; c=relaxed/simple;
	bh=bpuGRVu4Y18L5xc3H1PJ2lREyhify4Ay9P9h5KY76nk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=CA37slJhjkHNMICRlHSuIk7BuXn/INAbGxFPrUBfHvwud8soe7szBbeuSB3CSv1X8w11PZTgMm1S1acLrsqW/JwyPZC4RXFG9jbmhBF+ZWsJ7vC9L4z6LRmfP0Z2KxUF+blbhzUrMSihtyPwdNRB/i2VUl24jazlrKiXefHK4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KUWIVh/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772634857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLC9JL4iyVNeLfPEDV0W2Yxh7iNZYOFRw/HOSKzzhuk=;
	b=KUWIVh/PnnuW5acGd6H4m0jPVVT87CVUZKp7Xi+/HUe81BDLZTe2ykJNg8lbZpnbmXh23Z
	ws7zOIOXAzU2fPyNTR6wkeggV9HvtRTCnKARB/ZmgsfisDumXSEiqKvOWgXmWHg54HFHL5
	3j8SXGZChnDArJpu5fDljGsOWmk6kXA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-S9NpySwlNAOll3R8_b-uzg-1; Wed,
 04 Mar 2026 09:34:14 -0500
X-MC-Unique: S9NpySwlNAOll3R8_b-uzg-1
X-Mimecast-MFC-AGG-ID: S9NpySwlNAOll3R8_b-uzg_1772634851
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E89519560B0;
	Wed,  4 Mar 2026 14:34:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40E33300019F;
	Wed,  4 Mar 2026 14:34:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aahA7rQVf5liFYMv@infradead.org>
References: <aahA7rQVf5liFYMv@infradead.org> <aag8fPUDCY_g-_LY@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-3-dhowells@redhat.com> <114166.1772634114@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Jens Axboe <axboe@kernel.dk>, Leon Romanovsky <leon@kernel.org>,
    Christian Brauner <christian@brauner.io>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>,
    Steve French <sfrench@samba.org>,
    Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
    Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH 02/17] vfs: Implement a FIEMAP callback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <156718.1772634844.1@warthog.procyon.org.uk>
Date: Wed, 04 Mar 2026 14:34:04 +0000
Message-ID: <156719.1772634844@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: D097F201998
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79402-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,warthog.procyon.org.uk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christoph Hellwig <hch@infradead.org> wrote:

> > So I have to stick with SEEK_DATA/SEEK_HOLE for this?
> 
> Yes.  Why do you even want to move away from that?  It's the far
> better API.  Of course like all other reporting APIs it still is
> racy, but has far less problems than fiemap.

To find the next two extents of data, say, I have to make four calls into the
backing filesystem rather than one - with all the context set up and locking
those might incur.

Granted, the vast majority of files aren't sparse, so one pair of
SEEK_DATA/SEEK_HOLE should be able to establish that.

David


