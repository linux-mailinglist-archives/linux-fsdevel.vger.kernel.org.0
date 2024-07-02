Return-Path: <linux-fsdevel+bounces-22954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612CF924258
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172881F25E00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22C21BC072;
	Tue,  2 Jul 2024 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv89PDwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06B1BBBD3
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jul 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934104; cv=none; b=DGyhLaM0YsdjQ8LCE9GhWfzP5TIszKFZbt72SAueg4zqQbEeB643fbXl5850NAw37IJSq5Sy1UHXRv0zg9UzKJyLy/aSEUPxxh2FWEfgF+2hXHP9xCBigF4ouMnOM7lQWIEMxuSSfLBsW1QeqkajFWpgD/hNGADS0Adwe/WchQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934104; c=relaxed/simple;
	bh=GBExoAyi14FWumTv2b2BvBpSUJKfb1TjRsX8SUbwMmg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=VeA7PTGWBzPEJQn2wRSa6BOIIO7Fa9RkSOR7RlQt9Wp2uDLr1MBERCGD92OK6TPV+7vak5t86Y8UeFC8cmMZX6MsxysIpj5GmNARIX5IWMd67vqLj1YVdsBr0phIdoHJzuDbpvahzXdcRxq2WYCqaMAACjZ3TBeEMvwwrlmznOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv89PDwc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719934101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EuKA2CrmVYsEvBv4xr49dZlBQrADeiuoiS4+oOF5a44=;
	b=dv89PDwcpthsdv98GnFy7HDMykZrLPB3ClDbAnSGPNmv/I79zJ38rNU4CzcwdyzGT9cq+t
	6xIv+sQlkCxP6zBvlttGspWnU/JaXrxzCLQ0KyUx2Xv6Xn6cEOUyEL78Bvnbp1jQwl1h5D
	qiocgo6BcAh2xsx/c2eHhiDTnUMck6o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-TECHW8MOMFmgITuaFfCrgQ-1; Tue,
 02 Jul 2024 11:28:18 -0400
X-MC-Unique: TECHW8MOMFmgITuaFfCrgQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5055419373FE;
	Tue,  2 Jul 2024 15:28:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.111])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 163DC19560A3;
	Tue,  2 Jul 2024 15:28:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240702024055.1411407-1-nichen@iscas.ac.cn>
References: <20240702024055.1411407-1-nichen@iscas.ac.cn>
To: Christian Brauner <brauner@kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Cc: dhowells@redhat.com, marc.dionne@auristor.com,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Convert comma to semicolon
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3043963.1719934093.1@warthog.procyon.org.uk>
Date: Tue, 02 Jul 2024 16:28:13 +0100
Message-ID: <3043964.1719934093@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Chen Ni <nichen@iscas.ac.cn> wrote:

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Acked-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/20240702024055.1411407-1-nichen@iscas.ac.cn/

Christian: Can you add this to the VFS tree?


