Return-Path: <linux-fsdevel+bounces-31180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC08992E8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23D01F24719
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6311D54EE;
	Mon,  7 Oct 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeWHm4gn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427EE1D47C0
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310441; cv=none; b=XpMUI73kjr1GTLR5aUGPnahWqKlyVYlxlLS6taTY8wAHAJgOXECOtOwNs7GEz6KPNbWabnANqNUz59uGMmoUrrbZT35meF+aAsAsRaV5NR2wenRgtTE1s0bl5coET+KPs0OPtOLIuaNLtSiI7WS1jGnHioT7pVJonAAMcCQm3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310441; c=relaxed/simple;
	bh=3uebTxn9YgI6i5zfpZtkhSyh67xtURKm0fPZi4CKTd0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=dTV4dkSBAz4Fcs+GY/DwEv0lYOOT6iXRbmIV7kYDT3l3FKxdMy9XULZKZ23spMKan/PEs1+QvRMJ9ozzjgk9Gu6QD8YrvcNs3oF7/85w00KO80yVKJJEqNz/Qy97M3jTGXfePABtfJrdcL0UUVQIzUujygDVtodEzbXXX5WaIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeWHm4gn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728310439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uebTxn9YgI6i5zfpZtkhSyh67xtURKm0fPZi4CKTd0=;
	b=BeWHm4gn4jh6+W5uhFWkxLh4RyyffWydsALVMGBPszX2GoVm5vC2bgin1FXhv9AYJdig9G
	aVTfjkLVE9w5DxazYNbfwY9584MmR41ADudXS3Wt2u+xOVCiObdqe7BU0kTYld7Mg6tH0A
	dzvCgIKRnbedNhNWotdRdF7SzeV61Es=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-iH58uYBVOJyWEmBMdLxVuw-1; Mon,
 07 Oct 2024 10:13:57 -0400
X-MC-Unique: iH58uYBVOJyWEmBMdLxVuw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D77C19560A5;
	Mon,  7 Oct 2024 14:13:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C148C19560A2;
	Mon,  7 Oct 2024 14:13:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241005182307.3190401-2-willy@infradead.org>
References: <20241005182307.3190401-2-willy@infradead.org> <20241005182307.3190401-1-willy@infradead.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] netfs: Remove call to folio_index()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4027692.1728310433.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Oct 2024 15:13:53 +0100
Message-ID: <4027693.1728310433@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Matthew Wilcox (Oracle) <willy@infradead.org> wrote:

> Calling folio_index() is pointless overhead; directly dereferencing
> folio->index is fine.
> =

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Fixes: c38f4e96e605 ("netfs: Provide func to copy data to pagecache for bu=
ffered write")
Acked-by: David Howells <dhowells@redhat.com>


