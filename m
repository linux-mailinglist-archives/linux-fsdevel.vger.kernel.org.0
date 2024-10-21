Return-Path: <linux-fsdevel+bounces-32491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7192E9A6C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 16:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282131F21454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD611FA252;
	Mon, 21 Oct 2024 14:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehTK5qga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA81B59A
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521962; cv=none; b=egPC5pl+5lWFy0dDrdGmJYj7O/sJaHvwS+HTdhnsjRrVKa2EbN7nFg/szypL1Hx+qXtndDtlOD8EX0xfmuyB60zwVpTegPqti3xRo8GO5HPOVqdlHIgMEI31foye4A4KkzOWhCPOA1hP7nON2NJDv3thYkemSpK/i4PoaHDv6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521962; c=relaxed/simple;
	bh=MlfWX4tqpaCWzQbuTo9owf+BHcmgyI86ZvsjuJjKESw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=i2nwYmpx0RmIySBEnWrjirZaqe2Dm82onX5X1alXEjypjBzyAP9sAaRdbWH7ppnD5qgRwdgfENSauKsWhA4O2yVG/c4m5RaLl8YFY/MQ3IgvEvu8SVzXRTl+zn9HLAJ4KBKC1O946/uLPnw4lNtrly5wQwAQeB/z/XnhadjywOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehTK5qga; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729521959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZF/W6huHYmJAWgOtJhZ3UzfsAIEzi9eYFD/euXGD1Qk=;
	b=ehTK5qgarTCzHjXvLUou/F18ZqfLZ0r545SWe2PlvP2wx4Ga17HFQ0Vvc7SfNhUeByQ/l3
	0DjfzLs1JYvkFqFepWsBxW6bibIj+y2JkL2AvcrcdjWd+tJVYZdaGvzs19LTZZ1iFVITGm
	9uXnzD7bBORJtdPbHgHmLYcMMl4IQ9k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-G7bERathNQCOvlq-b9um2Q-1; Mon,
 21 Oct 2024 10:45:56 -0400
X-MC-Unique: G7bERathNQCOvlq-b9um2Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7093A1955F41;
	Mon, 21 Oct 2024 14:45:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.218])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E959B1955E83;
	Mon, 21 Oct 2024 14:45:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZxFQw4OI9rrc7UYc@Antony2201.local>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local> <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me> <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info> <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me> <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
To: Antony Antony <antony@phenome.org>
Cc: dhowells@redhat.com, Sedat Dilek <sedat.dilek@gmail.com>,
    Maximilian Bosch <maximilian@mbosch.me>,
    Linux regressions mailing list <regressions@lists.linux.dev>,
    LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
    Christian Brauner <brauner@kernel.org>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2171404.1729521950.1@warthog.procyon.org.uk>
Date: Mon, 21 Oct 2024 15:45:50 +0100
Message-ID: <2171405.1729521950@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Can you tell me what parameters you're mounting 9p with?  Looking at the
backtrace:

[   32.390878]  bad_page+0x70/0x110
[   32.391056]  free_unref_page+0x363/0x4f0
[   32.391257]  p9_release_pages+0x41/0x90 [9pnet]
[   32.391627]  p9_virtio_zc_request+0x3d4/0x720 [9pnet_virtio]
[   32.391896]  ? p9pdu_finalize+0x32/0xa0 [9pnet]
[   32.392153]  p9_client_zc_rpc.constprop.0+0x102/0x310 [9pnet]
[   32.392447]  ? kmem_cache_free+0x36/0x370
[   32.392703]  p9_client_read_once+0x1a6/0x310 [9pnet]
[   32.392992]  p9_client_read+0x56/0x80 [9pnet]
[   32.393238]  v9fs_issue_read+0x50/0xd0 [9p]
[   32.393467]  netfs_read_to_pagecache+0x20c/0x480 [netfs]
[   32.393832]  netfs_readahead+0x225/0x330 [netfs]
[   32.394154]  read_pages+0x6a/0x250

it's using buffered I/O, but when I try and use 9p from qemu, it wants to use
unbuffered/direct I/O.

David


