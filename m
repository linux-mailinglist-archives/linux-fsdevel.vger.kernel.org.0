Return-Path: <linux-fsdevel+bounces-51520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F676AD7C86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 22:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8383A4CA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 20:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42E2D876C;
	Thu, 12 Jun 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rg5WjKI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E532D6605
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760601; cv=none; b=luTB7IlsFcXqlenNwS4COGd4A5VpN/BHdcCFXTNlVvakqGrtKAoIcPMnq6VheZbXXUIQVP489wYyLmsias45iH8c390c5WT7fmGVghaycY4VWQXdVk0hJMfwbLuOjUw+v4ozlb6zq8vtDR92fPK/PvRYeznI639GlIi9UM1uaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760601; c=relaxed/simple;
	bh=SAU5o2DQ0CfgLin1S8tnE5huEGqu4f6AQhBXhQIQYLU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=hNvBRBI9sNJgqem0seb7iHL/sU2FnHarNH3KY8wQ01ML5oshEooH6e1/KDaCz/gkHTPfgNaysYZVe3Mkl8wk3dBJSkF/IlOdr++C+TuVTB4o3BQkceCvmo28Ual776mBS/XIqY0F4axibHtIsNgIa63dJUsHW+Ch29n4ZSNsoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rg5WjKI4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749760598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gj8SQGLLh0rljui6jnNkQMA92RjfoZpiblWpalJC6vA=;
	b=Rg5WjKI4qZC5T1frLTsrPAXilqvmhnWHGInmK+jk7DVIBEPEWlyhn82KH6ntZ/nR7aqb5Q
	53hOh3+3Qf+ejGayyQx4bNReLdgDPFD1YebdPlDmloho/gShufugWCE0dXjNHjN6Wl3tHo
	smG72wIlombDgjdTW6pVA/gL5yljs2Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-yC1TTY1fOoaf_k-updd0AA-1; Thu,
 12 Jun 2025 16:36:35 -0400
X-MC-Unique: yC1TTY1fOoaf_k-updd0AA-1
X-Mimecast-MFC-AGG-ID: yC1TTY1fOoaf_k-updd0AA_1749760593
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E95CE180AB15;
	Thu, 12 Jun 2025 20:36:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84881195E340;
	Thu, 12 Jun 2025 20:36:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2dc7318d6c74b27a49b4c64b513f3da13d980473.camel@HansenPartnership.com>
References: <2dc7318d6c74b27a49b4c64b513f3da13d980473.camel@HansenPartnership.com> <462886.1749731810@warthog.procyon.org.uk>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org,
    Jarkko Sakkinen <jarkko@kernel.org>,
    Steve French <sfrench@samba.org>,
    Chuck Lever <chuck.lever@oracle.com>,
    Mimi Zohar <zohar@linux.ibm.com>, Paulo Alcantara <pc@manguebit.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Jeffrey Altman <jaltman@auristor.com>, hch@infradead.org,
    linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
    linux-cifs@vger.kernel.org, linux-security-module@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Keyrings: How to make them more useful
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <473710.1749760578.1@warthog.procyon.org.uk>
Date: Thu, 12 Jun 2025 21:36:18 +0100
Message-ID: <473711.1749760578@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> One of the problems I keep tripping over is different special casing
> for user keyrings (which are real struct key structures) and system
> keyrings which are special values of the pointer in struct key *.

It's meant to be like that.  The trusted system keyrings are static within
system_keyring.c and not so easily accessible by kernel modules for
direct modification, bypassing the security checks.

Obviously this is merely a bit of obscurity and enforcement isn't possible
against kernel code that is determined to modify those keyrings or otherwise
interfere in the verification process.

> For examples of what this special handling does, just look at things
> like bpf_trace.c:bpf_lookup_{user|system}_key
> 
> Since the serial allocation code has a hard coded not less than 3
> (which looks for all the world like it was designed to mean the two
> system keyring id's were never used as user serial numbers)

That's just a coincidence.  The <3 thing predates the advent of those system
keyring magic pointers.

> I think we could simply allow the two system keyring ids to be passed into
> lookup_user_key() (which now might be a bit misnamed) and special case not
> freeing it in put_key().

If you want to make lookup_user_key() provide access to specific keyrings like
this, just use the next negative numbers - it's not like we're likely to run
out soon.

But I'd rather not let lookup_user_key() return pointers to these keyrings...

David


