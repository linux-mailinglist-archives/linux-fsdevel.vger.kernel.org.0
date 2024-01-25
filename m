Return-Path: <linux-fsdevel+bounces-9002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED7683CC1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA452849FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFDC135A57;
	Thu, 25 Jan 2024 19:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jwllmu97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AC91350E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210939; cv=none; b=qMKg8EQRFVZGfyqrSXBl6S/WEUaFni8Q2JPX9vz4wXN1/oEJH4BLo+Dkdlb+pBgYfz9F6nN7o7ZPpgeYzPs8rc8MQCxja1ofLBoe8gMl8vG8WIqnWIFdh4pcpgsPM/jdBTVfUfhl7XAWcjBq339/3r0HAY7XMXOjtI2WkkYQi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210939; c=relaxed/simple;
	bh=Klf1n72HKz+7NLRCuzAOesPmv7RwpZWk37FL3U1M6Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWGHE3kJqbLYrrrvr+EGykjDURWBhizdpmT4Ft10T7fqzDTGwHQhI5c0FLuTMXylaQndilYIHwUPfcQtyhj9a4+NN99gjwy5hmiMVTjiB6TxDghRGRwMzTmN8Dc6MOkMFnWW2hq/gzIWW+E4Og+ZH6LsEa+BbUIqhNc37LRRsnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jwllmu97; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706210936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orENYTchG91SsGUpfMPnTLKwMM3GW/2swFPCPjquPdc=;
	b=Jwllmu97Afoi5uxG+dXTWACWVZNnGl5HkJSSte1IvkrLMG2aMgpEq4WkMyyU7/aiLnZ2qe
	HLppifWetAjmyrc/d0jLyEeVLhugPDxt7myKQiMDJM7wy0a9oSQ8q12yHgaM4TCF2Ktn44
	06kwh+tLrT8fZt+DSGz93fkDmLyVNIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-p7iKSKg_ObCnrrZaKzoIWA-1; Thu, 25 Jan 2024 14:28:51 -0500
X-MC-Unique: p7iKSKg_ObCnrrZaKzoIWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C23185A58C;
	Thu, 25 Jan 2024 19:28:50 +0000 (UTC)
Received: from [192.168.37.1] (ovpn-0-9.rdu2.redhat.com [10.22.0.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F4C40CD14B;
	Thu, 25 Jan 2024 19:28:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Gao Xiang <xiang@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Eric Sandeen <esandeen@redhat.com>, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Roadmap for netfslib and local caching (cachefiles)
Date: Thu, 25 Jan 2024 14:28:46 -0500
Message-ID: <EB613778-D963-438B-AA20-66D5E5E0DD90@redhat.com>
In-Reply-To: <524118.1706195224@warthog.procyon.org.uk>
References: <B01D6639-6F09-4542-A1CE-5023D059B84F@redhat.com>
 <520668.1706191347@warthog.procyon.org.uk>
 <524118.1706195224@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 25 Jan 2024, at 10:07, David Howells wrote:

> Benjamin Coddington <bcodding@redhat.com> wrote:
>
>>> NFS.  NFS at the very least needs to be altered to give up the use of
>>> PG_private_2.
>>
>> Forgive what may be a naive question, but where is NFS using PG_private_2?
>
> aka PG_fscache.
>
> See nfs_fscache_release_folio() for example where it uses folio_test_fscache()
> and folio_wait_fscache().

Ah, thanks!  At the end of the netfslib work, will NFS still be able to
utilize fscache and still manage its own folios, or are you looking at
making fscache be an all-or-nothing depending on the use of netfslib?

I think NFS might easily stop using PG_fscache by carrying that information on
folio->private (since we're currently stuck with it).

Ben


