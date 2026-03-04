Return-Path: <linux-fsdevel+bounces-79400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDgHNxdAqGl6rQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:22:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC26201435
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 15:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0634303A3D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE22773F0;
	Wed,  4 Mar 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N92S0M4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6161C84DC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634129; cv=none; b=DD1oEtWq2Jr3T/7NI9ToLeH1Xgu4d9UanRPEsZ5K98KDFGrfXrHBV8zJi/DB9NamdpEm4XNh0OL+zXKvsmFonk4hGl0wGBhmhDUOPjClvA+VO3oJxqJqJhbZW50khTAc7KTWOADYLwEhjn96SfLSDKSZPWCkZr3cGwB0JSXEl0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634129; c=relaxed/simple;
	bh=sLMatqRTz5IwZh2UV4N6XY96dPJOvgLZIoTqJhjuy5o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=susk1jZdo5hxlUT4MebDiwEjHbkuvITnAcEXP5G8ZE9kDuux1yKEF60M34CTsWfnl39psYthJzOveSJ4SoVIv3z+j7INTTF6EzX+SSB54w+WlKwaihTdme/u76j3ADeJiD72Ln2y9YzsCjDhTFudfneaYDtBu+Tkawj4O4sqAgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N92S0M4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772634127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS194M8/hP3yO+8wnnkGW3joc3YD+fF2p3HAB/aV4GM=;
	b=N92S0M4eFrJAtVWTmbptM0dDXxJAHXaEFHp4d1Nd3BX9jp0EFdNwy9SKPIC/ju89EOwyRC
	+PBTX1DstNdO1nH4T/UKmQVJ3cIsyMlf6kMoEUSlwlEXBPMY5d8Om0lSpKGP0KVKuEY+cq
	Or7XxkJ1xZjrC/PoO1BWqseR1UcRQjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-mIEEh07FNsmkxpV8oYyAkQ-1; Wed,
 04 Mar 2026 09:22:03 -0500
X-MC-Unique: mIEEh07FNsmkxpV8oYyAkQ-1
X-Mimecast-MFC-AGG-ID: mIEEh07FNsmkxpV8oYyAkQ_1772634121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 934FB180035C;
	Wed,  4 Mar 2026 14:22:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.194])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2858430001A1;
	Wed,  4 Mar 2026 14:21:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aag8fPUDCY_g-_LY@infradead.org>
References: <aag8fPUDCY_g-_LY@infradead.org> <20260304140328.112636-1-dhowells@redhat.com> <20260304140328.112636-3-dhowells@redhat.com>
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
Content-ID: <114165.1772634114.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Mar 2026 14:21:54 +0000
Message-ID: <114166.1772634114@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 6AC26201435
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79400-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[warthog.procyon.org.uk:mid,infradead.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Mar 04, 2026 at 02:03:09PM +0000, David Howells wrote:
> > Implement a callback in the internal kernel FIEMAP API so that kernel =
users
> > can make use of it as the filler function expects to write to userspac=
e.
> > This allows the FIEMAP data to be captured and parsed.  This is useful=
 for
> > cachefiles and also potentially for knfsd and ksmbd to implement their
> > equivalents of FIEMAP remotely rather than using SEEK_DATA/SEEK_HOLE.
> =

> Hell no.  FIEMAP is purely a debugging toool and must not get anywhere
> near a data path.  NAK to all of this.

So I have to stick with SEEK_DATA/SEEK_HOLE for this?

(Before you ask, yes, I do want to keep track of this myself, but working =
out
the best way to do that without reinventing the filesystem is the issue -
well, that and finding time to do it).

David


