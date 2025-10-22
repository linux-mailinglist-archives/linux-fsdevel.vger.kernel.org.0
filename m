Return-Path: <linux-fsdevel+bounces-65202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0F6BFDF80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 21:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9343F3A7FEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7734DCE1;
	Wed, 22 Oct 2025 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvKcsnqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5E534D4FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160077; cv=none; b=IqfQyIeMgxGaSFtSR3zsN2ijeLuaRX9s8532ZZ7qqo6fgh0Yhtk7CE7GbS1Q+1OZIR2ap4117vkpu1SdkFHqi1B+uhNJJD6fZMr+/cV3nPQ+pSMD9eiSOpqt4EMa9H95DDY6rDKgQ8zgXuic5862Ww4M4rlp/X0AoRaDKlOPEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160077; c=relaxed/simple;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BnZzmHQjJkggWXBzm8LGkh7LyAT1wajN/hSztziGBpwvV4ugMHhmzxdamV1EkJmC/U8AHFnuaCyV3Gxw7TK6ME92zUa3hw45YQ2dXoRAyR7pLHxOe2pIpvyAYyngiSzCce3AIntgqm58Cuu4Zx2c9OTe3gi+x/efuSCPQSiW+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvKcsnqu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761160074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=18zbZNBSnfzEQNxf3NzURV1iOgz5TdTGposrZRBN7p8=;
	b=KvKcsnqupeSvp7fmKyS90gE+w02KPo4Ysj4aJCq0ubDiZylkISVxP9ECSRL4PXwqwoy5e3
	7jEKl0KM9X/uCX/RgstJecGTbNTAy8gEwFBSNp2CwaoDnaEtLrMlfZgmCSA2gkLOKBl5wc
	tVshdGtERn2KSVNof1lPJDvbN3ZZ0qA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-oZlGmZ9NMNCnjhH_uti7fQ-1; Wed,
 22 Oct 2025 15:07:51 -0400
X-MC-Unique: oZlGmZ9NMNCnjhH_uti7fQ-1
X-Mimecast-MFC-AGG-ID: oZlGmZ9NMNCnjhH_uti7fQ_1761160070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3ABD1800657;
	Wed, 22 Oct 2025 19:07:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F0151955F22;
	Wed, 22 Oct 2025 19:07:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1784747.1761158912@warthog.procyon.org.uk>
References: <1784747.1761158912@warthog.procyon.org.uk>
To: Markus Suvanto <markus.suvanto@gmail.com>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    Christian Brauner <christian@brauner.io>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: Fix dynamic lookup to fail on cell lookup failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1785738.1761160065.1@warthog.procyon.org.uk>
Date: Wed, 22 Oct 2025 20:07:46 +0100
Message-ID: <1785739.1761160066@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")


