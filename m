Return-Path: <linux-fsdevel+bounces-41174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E42EA2BFBB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3867A624E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 09:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E30233D90;
	Fri,  7 Feb 2025 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZXDaVjrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49F41DE2CD;
	Fri,  7 Feb 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921334; cv=none; b=BIRGhLVOeyjPGUS7iXKOfULlTWGCLKTeKA+HXshPh9dekyIQa3zZsmdOXAWYw9ksD1KBrmR79x4C3TfUxfQ13bDaECr5aZ4NHch9HG5k3NaArAcB+7EgfGv0U2FEFWkp8f1KqOYY9h0V49ELDMTNF3v3pFmFY0K3/+iu8rVdBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921334; c=relaxed/simple;
	bh=EewjN7nUhhtBPJOdfrZj64y7+JiFITVsxY5wBikw+WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaroOi9OJkcqxJ9pYjTXQxe+jCnMiVL5EaSqPN+qPZmqjpyqzyHTLW5qPZ2Qgg6qBgPXC+8QhWtvu+1i9KvhTRsMLH+7y/KCHmDQDp0DpIduj6eMAMiROjfeh8UZwp+VotxJumfMdG+Vopzp1DpRq6TuRtRxp24wPLu+OWvjadw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZXDaVjrD; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MhA1jDIfQ8iLGh9WfIUR3+LgFXMnqWm6EVDsj31vync=; b=ZXDaVjrDmJbS9jssNlbQ3D9Elb
	r5Xsr+O3eH47BnThcCfwS3N8+p4zkexJmJG/747y6dDuOu7tkQkOCvKJ/GIuRunQjUD6KD25n0+X3
	kcG1BAZ7Itvv9TbLunVGLSNIL1mtgJ3nUXgMX0L0AqAZcAaGEdBVjoDUsKQTUOzpRXN09nHvpZUNL
	gxmLUvE2bu1GrU38+PRWbHHxCXP/OkHk9Ra1tn1ik0thv5vZatZna2CGm8jwG8HBcv9Yy+l75vUsS
	o1ViSi5mUUyx6WHm0LR1XrsNS8UhS0DYuuJvLTJx0/gsGGdfUYRudFcqYM/d22WAdImA1rarkFFsF
	lnfvqmgw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tgJwx-00FpRv-2r;
	Fri, 07 Feb 2025 16:56:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Feb 2025 16:56:20 +0800
Date: Fri, 7 Feb 2025 16:56:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <Z6XKtPKryJsRfYvK@gondor.apana.org.au>
References: <20250203142343.248839-1-dhowells@redhat.com>
 <20250203142343.248839-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203142343.248839-4-dhowells@redhat.com>

On Mon, Feb 03, 2025 at 02:23:19PM +0000, David Howells wrote:
>
> [!] Note that the net/sunrpc/auth_gss/ implementation gets a pair of
> ciphers, one non-CTS and one CTS, using the former to do all the aligned
> blocks and the latter to do the last two blocks if they aren't also
> aligned.  It may be necessary to do this here too for performance reasons -
> but there are considerations both ways:

The CTS template will take any hardware accelerated CBC implementation
and turn it into CTS.

So there is no reason to do the CTS/CBC thing by hand at all.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

