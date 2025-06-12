Return-Path: <linux-fsdevel+bounces-51492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43642AD7376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840FE189305F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2A248898;
	Thu, 12 Jun 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMYgYEiO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A232472B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749737450; cv=none; b=dnkUg/sUFlxfXYaR2uU86PUkrZLz7av0ZuIxi6219iDibfTt6eR0LviA+rNgaMoS7v6DKi0k2YXLy2tjOVpa6QIdKvQljsSMc5XTMQQU1tcCjL43lfrsmhfhLj8skRbbnqkGddMYIBRVRfn8nSrF9GX/xf9xii12q00QCoF9yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749737450; c=relaxed/simple;
	bh=rx2127rFnhUhdp1EywtDCGhrT9qHfuVS0rW2DH6MNzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1LWSkCry3aPSJ/r9g1ciQz1zN3VjdohCBsv8VA/a41EKXWDmlQK1AINrC3ngJ0M9xq1GWH40+q4HAkK2TyLK/ehFkj+RrEQqGUpb5xgOjJjpzaUCPPPJfXQzx2EB8Ye2btO5ex9CJmRgbQIDfZYjuo/BaEUSP42PdjwmoSwEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMYgYEiO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749737447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P1JMQZmzbIb6utls8iGRZ0NkyFLiqg1p9Vq7xmlV1lU=;
	b=XMYgYEiOgofvQth9mG7fUHVnh+6lkjNiMUywObXPMfGqY+LrBOGndgHpPfudlRborNJ8j4
	xRCNhhs+ORSFQ+QC2xNDPpdp+RrIgjI67uk8Fsw3Pw6fGz/p9/Y93+e8UkUOSzok30zwRL
	OltKlDEsq8j0N8XQrTeMHN+GFubA2Ng=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-ubVQ-dTQNmGrfAFCq5kbsw-1; Thu,
 12 Jun 2025 10:10:44 -0400
X-MC-Unique: ubVQ-dTQNmGrfAFCq5kbsw-1
X-Mimecast-MFC-AGG-ID: ubVQ-dTQNmGrfAFCq5kbsw_1749737441
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F7DE1955F42;
	Thu, 12 Jun 2025 14:10:41 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A98121956050;
	Thu, 12 Jun 2025 14:10:36 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
 Steve French <sfrench@samba.org>, Chuck Lever <chuck.lever@oracle.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Paulo Alcantara <pc@manguebit.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Jeffrey Altman <jaltman@auristor.com>, hch@infradead.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Keyrings: How to make them more useful
Date: Thu, 12 Jun 2025 10:10:34 -0400
Message-ID: <D33BA76E-E2D3-42C8-A983-A733ECD71CCE@redhat.com>
In-Reply-To: <462886.1749731810@warthog.procyon.org.uk>
References: <462886.1749731810@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 12 Jun 2025, at 8:36, David Howells wrote:

> Hi Jarkko, Steve, Chuck, Mimi, et al.,
>
> I think work needs to be done on the keyrings subsystem to make them more
> useful for network filesystems and other kernel services such as TLS and
> crypto.
>
> There are a number of issues that I think need addressing:
>
>  (1) One of the flaws in the initial design is that whilst keys have a type
>      (which is necessary), this has to be specified as part of the lookup or
>      the search, which is overly restrictive.
>
>      It probably would have been better to search by description alone and
>      then, if a key is found, have any type of key with that description
>      returned and let the app/service investigate the key to find the type.
>
>      Now, this is still possible to implement on top of the existing API: just
>      allow a NULL type to be passed in - but we might need some way to
>      enumerate all the keys with that description, but of different types.
>      Possibly, the search function should return all the matching keys.
>
>      Possibly, within the kernel, for each keyring, all the keys of the same
>      description can be stored within a group structure, and the search
>      returns the group.  This could also have the added benefit of maybe
>      making it easier to handle updates.
>
>  (2) For certain applications, keys need versioning - and we need to be able
>      to get access to older versions (at least to some extent) of the keys.
>      An example of this is cifs where (if I understand it correctly) the key
>      version gets cranked, but not all servers may have caught up yet, so we
>      need to be able to try the keys in descending order of version.
>
>      This could also work within the group idea mentioned above.
>
>  (3) For certain applications, such as AFS and AF_RXRPC, we may need to be
>      able to keep a number of keys around that have the same description
>      (e.g. cell name) and basic type (e.g. rxrpc) and version, but that have
>      different crypto types (e.g. Rx security classes and Kerberos types, such
>      as RxGK+aes256-cts-hmac-sha1-96, RxGK+aes128-cts-hmac-sha256-128 or
>      RxKAD) as different servers in the same cell might not support all or we
>      might be implementing a server that is offering multiple crypto types.
>
>      So we might need a "subtype" as well as a version.
>
>  (4) I think the keyring ACLs idea need to be revived.  We have a whole bunch
>      of different keyrings, each with a specific 'domain' of usage for the
>      keys contained therein for checking signatures on things.  Can we reduce
>      this to one keyring and use ACLs to declare the specific purposes for
>      which a key may be used or the specific tasks that may use it?  Use
>      special subject IDs (ie. not simply UIDs/GIDs) to mark this.
>
>  (5) Replace the upcall mechanism with a listenable service channel, so that a
>      userspace service (possibly part of systemd or driven from systemd) can
>      listen on it and perform key creation/maintenance services.

>      From previous discussions with the systemd maintainer, it would be a lot
>      easier for them to manage if the key is attached to a file descriptor -
>      at least for the duration of the maintenance operation.
>
>      Further, this needs to be containerised in some way so that requests from
>      different containers can be handled separately - and can be
>      distinguished.

Indeed one challenge on this front is configuring how to stitch together the
various callers and recievers especially when one wants an upcall from one
set of namespaces to be serviced within another.

I had previously posted some work in this area that fleshes out the idea of
a "key agent" which is a userspace process that can receive a notification
to instantiate a key.  The nice part (IMO) of this idea is that the keyagent
is represented by a key itself, so the channel is available to any process
that has the keyagent key in their keyrings.

This allows a system to have a single keyagent for all processes/namespaces
for a particular key type, or to build a more granular configuration where
agents are confined within the same (or different) namespaces as the calling
process.

I'd be happy to continue work on this front, since long-term it would allow
us to convert various NFS upcall mechanisms such that NFS access within a
container wouldn't require duplicated gssd/svcgssd/idmapper userspace
processes in every container if all the system needed was to use a single
global instance.  It would also allow the partitioning of secure
cryptographic material (like keytabs and certificate secrets) from
containers that might still want to use NFS, but not divulge those secrets
to the processes in that container.

Ben


