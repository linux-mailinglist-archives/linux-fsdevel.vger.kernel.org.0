Return-Path: <linux-fsdevel+bounces-44581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED00A6A79C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC982483198
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C7E2248BE;
	Thu, 20 Mar 2025 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOM8M31y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBB92222DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478578; cv=none; b=b15QcjsbUgTtogUG//ckhxe7yN26DDYXjGPJ+jv/AeFnFDYMFJl84G9w8ZzSr/+i9da0qudqIaP7gj9qNmarReH7+bLWBxZKZMMIgqDQyIwsb5cvNIQpsxVvSPJvHU6M1IJ2r4rkuA70OYqNBdtpQ1GNoH1fJQvDTOBBqzrDalA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478578; c=relaxed/simple;
	bh=Vp5FyzqPsmlPXh/HHjTNFz3/y0/vLZFHi8YPl/640QY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=u+E2N4moSJ5VibsAQHq35SDJEOLCkgY4+LvLp9iHEjExoMLMojZfCHvEW1IBlEovjcpkvOmmaS6UolE29549XfJHm75t3u8t9IGRQ4mi0fiW1MDllWlrowsr1pvzqGVfvN75BodGW7UxtPAExThyNfnz6wa3/1xAEOaQO9oSv/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YOM8M31y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742478575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hrU0uEtyRGySnnXxrdQSoop8bdInMwNlwF4N216RXFI=;
	b=YOM8M31yBE08hGmxcYiGnbEbNCChhAoMmAbmJYs9p6xde3EGON7qli3KSe56HjGm3xTpUB
	TGSX4aPiJUJ5fIY8NuccoFf55z0B+cbFHvroKCUk3S25YkD6dc5Hx5m/i4NtLv2pvGlx2E
	DGqEuU4TCxFVwKf7+aOVnZGjFBGRavw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-FGT0v92ZNrm_0m0apwrEfA-1; Thu,
 20 Mar 2025 09:49:32 -0400
X-MC-Unique: FGT0v92ZNrm_0m0apwrEfA-1
X-Mimecast-MFC-AGG-ID: FGT0v92ZNrm_0m0apwrEfA_1742478569
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 72799180AF50;
	Thu, 20 Mar 2025 13:49:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A36B71800946;
	Thu, 20 Mar 2025 13:49:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250320-goldbarren-brauhaus-6d6ff0a7be72@brauner>
References: <20250320-goldbarren-brauhaus-6d6ff0a7be72@brauner> <20250319031545.2999807-1-neil@brown.name> <20250319031545.2999807-4-neil@brown.name> <ee36dab38583d28205c4b40a87126c44cab69dc9.camel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    NeilBrown <neil@brown.name>,
    Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
    Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] cachefiles: Use lookup_one() rather than lookup_one_len()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3170279.1742478565.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 13:49:25 +0000
Message-ID: <3170280.1742478565@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christian Brauner <brauner@kernel.org> wrote:

> > > It also uses the lookup_one_len() family of functions which implicitly
> > > use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> > > confusing.  When we eventually update cachefiles to support idmap mounts
> > > it
> > 
> > Is that something we ever plan to do?
> 
> It should be pretty easy to do. I just didn't see a reason to do it yet.
> 
> Fwiw, the cache paths that cachefiles uses aren't private mounts like
> overlayfs does it, i.e., cachefiles doesn't do clone_private_mount() before
> stashing cache->mnt. ...

This is probably something cachefilesd needs to do in userspace before telling
the kernel through /dev/cachefiles where to find the cache.

David


