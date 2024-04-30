Return-Path: <linux-fsdevel+bounces-18366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6562E8B7A83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 772D61C20AF1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF1841C79;
	Tue, 30 Apr 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShIiwUqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE71527AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488473; cv=none; b=IPzUDBC5dWzuHfad+2MHnoeTriO2gbLnm2eFkia6Ucrl4iYNjH9RuYRwH0FDR7yQWwXqH900eCVBsRFPVL2wKG2WtcvO1DbvKRfvkkR/f91+RFcP2x8KNia+MnPmVtmV2xEmsLLCn+ocKkC259zjPpX/jufpraEOdnMTOUZmsWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488473; c=relaxed/simple;
	bh=17/ige2G0/bT+taZDR8dyDbj8f4gwH5Ssbdw0+0wOUY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=O6Hu3k88vlsOWvoqQytA9AxOYRtetGoT0RdKr0hRH4zq9ZcuJuCQYuhGjeVZh3J4eDVwzazkzADJZFNiNwsdw9HHNcu9+2nEVsQ2NjMlDTX2RqJYkuj1MAfWSLwwwHQtBLKyNwczLOtOajwBhA6i5wglmkqvL8niMK+Jyj37EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShIiwUqI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714488470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17/ige2G0/bT+taZDR8dyDbj8f4gwH5Ssbdw0+0wOUY=;
	b=ShIiwUqID8nb6Fskv3Wlo4F3XTlQdH20QDnPJ6XyU02P9BDvtAtwXkMTpUvsvXapRUd5Xg
	+5tOq8S+1hKv/DJJb3SZT/xgfU5qJrIqWpgJ+Ese7bnwfwSDAg/uWQva5slRdGXvwcz6Db
	6mEUSsbXdyWkLVZKfMgEuwfOxkcHF/s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-Yqhjr50rP_uciVJPbKQlhw-1; Tue,
 30 Apr 2024 10:47:46 -0400
X-MC-Unique: Yqhjr50rP_uciVJPbKQlhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7E0229AC014;
	Tue, 30 Apr 2024 14:47:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 46C461121312;
	Tue, 30 Apr 2024 14:47:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240430140930.262762-1-dhowells@redhat.com>
References: <20240430140930.262762-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    netfs@lists.linux.dev, linux-cifs@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/16] netfs, cifs: Delegate high-level I/O to netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <264959.1714488463.1@warthog.procyon.org.uk>
Date: Tue, 30 Apr 2024 15:47:43 +0100
Message-ID: <264960.1714488463@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Christian,

With Steve's agreement, could you pick this set of patches up also?

Thanks,
David


