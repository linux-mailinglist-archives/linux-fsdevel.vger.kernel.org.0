Return-Path: <linux-fsdevel+bounces-54996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343EB063A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4D84E6766
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 15:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8F25484D;
	Tue, 15 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFevYIgn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4F533D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595183; cv=none; b=qugwERI78T9dFCgFBD3Jy4xMK3Z/JdXtPV+6zZB11kBw2aGn8MzFJCovP2p1NPzFPPDZ5cNumOFanuLFGjzEaJB/ibpKw9dU6hFZUrtkmbrg9A18hKC4V0oSfdhIePMxDihsmCHkU+ldvtNnNYqBDLLUWEfyc5iLWjAC4IYjQek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595183; c=relaxed/simple;
	bh=fdO5VfW6X60MkvIII8cRamu7Sgs5twFB5WytZ9oeUao=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=P3d7ezNT8DVPI/ANozdrKx3bg+lsqY7M75DPZAACaX1M8bDLw+R5IWi5aQf2/bXK/3VP2PzifkdKm0OYYWaFwzjIIFD2ZsyDZwN/GcjEFEtfJhubmgWpCoHonGwJ/2hbFEjoM13v8b/Fsjm3i5ExVPe57WG6lY5J3X/6+Z8+GSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFevYIgn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ6VLvXQFvvpoa4OU5x7ISX5suRFkKwL8aobTGgqAAc=;
	b=CFevYIgnoWsLhYdCL5wt6tkoru9SnuGAGkszcxss0axHoF3bojIb3DwL+Eyx7l8YSDzSjn
	QZNUMHeY+M3XdglivZhX5M4fV23RHEacgOwYGvfYt9C3r8ABorLjuuZJoOQSVOwq2Vlt2b
	D9HLy1v/4ncfekbENRIf3ix7G8flnhM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-5W-uSxY4OsSiYOOSwvsaUA-1; Tue,
 15 Jul 2025 11:59:37 -0400
X-MC-Unique: 5W-uSxY4OsSiYOOSwvsaUA-1
X-Mimecast-MFC-AGG-ID: 5W-uSxY4OsSiYOOSwvsaUA_1752595175
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879581956096;
	Tue, 15 Jul 2025 15:59:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8576B30001A1;
	Tue, 15 Jul 2025 15:59:33 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3457636.1752593748@warthog.procyon.org.uk>
References: <3457636.1752593748@warthog.procyon.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Add support for RENAME_NOREPLACE and RENAME_EXCHANGE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3458631.1752595171.1@warthog.procyon.org.uk>
Date: Tue, 15 Jul 2025 16:59:31 +0100
Message-ID: <3458632.1752595171@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

David Howells <dhowells@redhat.com> wrote:

> +	kenter("%u", YFSRENAME_REPLACE);

Meh.  I forgot to remove a debugging line.

David


