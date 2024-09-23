Return-Path: <linux-fsdevel+bounces-29900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBC97F147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF789282FB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF01A0B12;
	Mon, 23 Sep 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO+h062s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B701A08A0
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120332; cv=none; b=on7bc3/Tb56DO1Mo8UBC9gUMetWexLkzHoN8oTRwhJXpkBf+WvHf3/gYqF40B1kFyFpdFYcBlfvG8u1Bdpd43imBs51hJJN/At39/cg45WpM3ubD7eSWLbOUvr5753oadY0LMdYm88bkNGA04VKMgWwE+oMT4hsTcEspIeuddCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120332; c=relaxed/simple;
	bh=IMBNE2puIfzdked4t6uZlyrCqjh8qel5HvLo5rRBc9o=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=M5vd9NwTXEuB89TzzpcCwHEbYQijuUv0o2SxKHNNxp7SeOcxQ/zQbkQowN9c0A6ElK6Me42OH31Df5/AiGMH/KZ1pPuUyMkLQyx0BJFXz0o0cxwIhLqOZwK3hFlOnSEuFDgt2yZ4UIYhP+Y2buZ6NplBZzv12S2Nka+f6sYojpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cO+h062s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727120329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IMBNE2puIfzdked4t6uZlyrCqjh8qel5HvLo5rRBc9o=;
	b=cO+h062sPzmLwvgbadEEvHG06NXpi3wHF8Y0fKB4Aw8YGv0FiF09X7EOFwytLjx4iVEZdh
	U5r7lSU5vXC9yE+zIValoaMUDAMzeh86IPk96+eAXIIYFonxtPIpjOjVUGNkDOSVA12e2E
	5ELXZbeEDOd+1rtUbifRY3bHcrOVOgk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-BsQ4RlIhNY-hYa32ClXl0w-1; Mon,
 23 Sep 2024 15:38:44 -0400
X-MC-Unique: BsQ4RlIhNY-hYa32ClXl0w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 521C5190DE19;
	Mon, 23 Sep 2024 19:38:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DD619560AA;
	Mon, 23 Sep 2024 19:38:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240923183432.1876750-1-chantr4@gmail.com>
References: <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com>
To: Manu Bretelle <chantr4@gmail.com>
Cc: dhowells@redhat.com, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org, eddyz87@gmail.com
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <912765.1727120313.1@warthog.procyon.org.uk>
Date: Mon, 23 Sep 2024 20:38:33 +0100
Message-ID: <912766.1727120313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Manu,

Are you using any other network filesystem than 9p, or just 9p?

David


