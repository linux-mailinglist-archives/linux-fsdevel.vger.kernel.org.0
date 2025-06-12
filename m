Return-Path: <linux-fsdevel+bounces-51456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 036DEAD7097
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB9C3B21E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481E22FDEC;
	Thu, 12 Jun 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO2YlzXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ED117BED0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731827; cv=none; b=MtCPwxPPBTKSsdEQ9rMbkluG0GbEsAdro0OWRyJUWKmlJJd8WzJ5LmFWo91F/LrCGb0+xOWVQdGHuWZeYDJOqc+ofPrRv2CmhoFVahMvy9K45ytc2TK/PNjUJ0RYPuoG5OKmvyAv2MvMD8LT1+3SdQqZ3qgC/necGe6GKGTOwIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731827; c=relaxed/simple;
	bh=8AFhk+xM+ccWdq6s7fDK5DBd/Hbfx8V0/cEk4s6If3s=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=GZ+LWs8NjMg8ZQtKVpIzrKjJ4v2n5cjSS8CAevioyAmVtZxW7wDxTOWhiID0rr48nQGVi+5eYUb9DJMgmWp34OzZ9NNKij/YSINps+s4jYdjKlhIWQ2AfP3qhVoVYUhbmW7/zAMw6O3XerUk0FfcoIhPapaO6BxFpIIJmCCO80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO2YlzXw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749731824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Yn83hBseogD5ikMpjR5nAA28nJER1I8C3igW2mcZWe8=;
	b=YO2YlzXwmykucz8AQLzrOhaIeRry6bWtgW3Hj0b6TaNrhMbZjhabVOecHy6My8uZlpeOyX
	9lv2sn8D2JD6kwIqvF1PSTQZy1YKHO33UN1vdGAcRRRP1F96MBaznTmSrvLjs323yVq21t
	OGw4ixkLJryKMsp5OhgUF2SbrFxgZsQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-iUrsCtDSOweJCslnb-BYaQ-1; Thu,
 12 Jun 2025 08:36:59 -0400
X-MC-Unique: iUrsCtDSOweJCslnb-BYaQ-1
X-Mimecast-MFC-AGG-ID: iUrsCtDSOweJCslnb-BYaQ_1749731816
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 320BD18011CD;
	Thu, 12 Jun 2025 12:36:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4236E195609D;
	Thu, 12 Jun 2025 12:36:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
    Steve French <sfrench@samba.org>,
    Chuck Lever <chuck.lever@oracle.com>,
    Mimi Zohar <zohar@linux.ibm.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Jeffrey Altman <jaltman@auristor.com>, hch@infradead.org,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Keyrings: How to make them more useful
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <462885.1749731810.1@warthog.procyon.org.uk>
Date: Thu, 12 Jun 2025 13:36:50 +0100
Message-ID: <462886.1749731810@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jarkko, Steve, Chuck, Mimi, et al.,

I think work needs to be done on the keyrings subsystem to make them more
useful for network filesystems and other kernel services such as TLS and
crypto.

There are a number of issues that I think need addressing:

 (1) One of the flaws in the initial design is that whilst keys have a type
     (which is necessary), this has to be specified as part of the lookup or
     the search, which is overly restrictive.

     It probably would have been better to search by description alone and
     then, if a key is found, have any type of key with that description
     returned and let the app/service investigate the key to find the type.

     Now, this is still possible to implement on top of the existing API: just
     allow a NULL type to be passed in - but we might need some way to
     enumerate all the keys with that description, but of different types.
     Possibly, the search function should return all the matching keys.

     Possibly, within the kernel, for each keyring, all the keys of the same
     description can be stored within a group structure, and the search
     returns the group.  This could also have the added benefit of maybe
     making it easier to handle updates.

 (2) For certain applications, keys need versioning - and we need to be able
     to get access to older versions (at least to some extent) of the keys.
     An example of this is cifs where (if I understand it correctly) the key
     version gets cranked, but not all servers may have caught up yet, so we
     need to be able to try the keys in descending order of version.

     This could also work within the group idea mentioned above.

 (3) For certain applications, such as AFS and AF_RXRPC, we may need to be
     able to keep a number of keys around that have the same description
     (e.g. cell name) and basic type (e.g. rxrpc) and version, but that have
     different crypto types (e.g. Rx security classes and Kerberos types, such
     as RxGK+aes256-cts-hmac-sha1-96, RxGK+aes128-cts-hmac-sha256-128 or
     RxKAD) as different servers in the same cell might not support all or we
     might be implementing a server that is offering multiple crypto types.

     So we might need a "subtype" as well as a version.

 (4) I think the keyring ACLs idea need to be revived.  We have a whole bunch
     of different keyrings, each with a specific 'domain' of usage for the
     keys contained therein for checking signatures on things.  Can we reduce
     this to one keyring and use ACLs to declare the specific purposes for
     which a key may be used or the specific tasks that may use it?  Use
     special subject IDs (ie. not simply UIDs/GIDs) to mark this.

 (5) Replace the upcall mechanism with a listenable service channel, so that a
     userspace service (possibly part of systemd or driven from systemd) can
     listen on it and perform key creation/maintenance services.

     From previous discussions with the systemd maintainer, it would be a lot
     easier for them to manage if the key is attached to a file descriptor -
     at least for the duration of the maintenance operation.

     Further, this needs to be containerised in some way so that requests from
     different containers can be handled separately - and can be
     distinguished.

 (6) Move away from keeping DNS records in a keyring, but rather keep them in
     some sort of shrinkable list.  They could still be looked up over a
     secure channel.

To aid with at least (1), (2) and (3) and possibly (4), I think it might be
worth adding an extended add_key() system call that takes an additional
parameter string:

	key_serial_t add_key2(const char *type,
			      const char *description,
			      const char *parameters,
			      const void payload, size_t plen,
			      key_serial_t keyring);

The parameters would get passed to the key type driver for it to extract
things like version number and subtype from without the need to try and fold
it into the payload (which may, for example, be a binary ticket obtained from
kerberos).  Though possibly that is a bad example as the kerberos ticket may
contain multiple keys.

Also, maybe add a multi-key adding syscall for when the payload may contain
multiple keys, each to be added separately:

	int add_keys(const char *type,
		     const char *description,
		     const char *parameters,
		     const void payload, size_t plen,
		     key_serial_t keyring);

When it comes to keyrings, I'm thinking that the keyring needs to change such
that the index holds CoW groups of keys of the same description, but of
different type, version and subtype, e.g.:

	struct key_group {
		struct rcu_head		rcu;
		struct key_group	*replacement;
		char			*description;
		unsigned int		seq;
		refcount_t		ref;
		int			nr_keys;
		struct {
			unsigned long	version;
			struct key __rcu *key;
		} key_list[];
	};

and that these groups should be made available to kernel services upon
searching.  I'm tempted to put the version as part of the group as a whole,
making it easier to ditch a set of the same version, but that could make RCU
CoW-ness tricky.

I could then add two new keyctls, one to unlink all the keys in a keyring that
match description and, optionally, type and parameters (e.g. of a particular
version):

	int keyctl_scrub(const char *type, /* can be NULL */
			 const char *description,
			 const char *parameters, /* can be NULL */
			 key_serial_t keyring);

and one to list all the keys matching a description and, optionally, type and
parameters:

	int list_keys(const char *type, /* can be NULL */
		      const char *description,
		      const char *parameters, /* can be NULL */
		      key_serial_t keyring,
		      key_serial_t *list,
		      size_t list_size);

Thoughts?

Thanks,
David


