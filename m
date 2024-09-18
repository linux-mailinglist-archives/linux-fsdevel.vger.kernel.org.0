Return-Path: <linux-fsdevel+bounces-29634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F797BAEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 12:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083E01F21E60
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD56817DFED;
	Wed, 18 Sep 2024 10:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRokE+kU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7BF17B4E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2024 10:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726655666; cv=none; b=c5zMhrDvsa1RvG+or7PAod8RLMetDgr8t1f0ChLMI52ArG4J2o6nzXHcAFl1BQVkTUStgXTRUdEBQHMxO4VSHtyoH7Q1wwY2ndY/5jMKCJR4f82X3l0u0nhwlABZR18cvzIT/0JBlVCB6Dx+OW5fEHKYR0g6ZskNF3Yz5LQr2AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726655666; c=relaxed/simple;
	bh=Xz/P70dztk4pTRM2Nu+dD1GG7jljHNnM8F4TB/8wcX0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=oyDstoTjJRyxoNJjQtp5HEZQdq/mLJufZGB4ElFAaf6wgof1M+TlbEfNYDJrHR+fL1lz7NN5CHvjJbOokqaiJBwc7j8ecvCFur7cZB+XErFodxnoxO3kisY3BYzUU+QWq2g/T6tCsKRPsWXkUF9icT6UvWV7NNigJQ4CdBXHF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YRokE+kU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726655663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwtyLChgJVgoa3fI0zoE+dagFr4Cxa13T7NXYF82EWQ=;
	b=YRokE+kUwzeO7Vbn61RL4SMAvc6IouBYDDosuGgxX46BD4QbprA7PajTj90qew92GLMnv6
	FIh/PjQ8OXJMqGFbe5PMytXqGLyo0gWfmhRwJYqk9QDEWGGVW4HsvHBSGwXkoT4X3l5snX
	P1vF+57cXTB9sYQlWxNVtp9capDlS+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-2ePgcKwtPwaNLyieX90OPg-1; Wed,
 18 Sep 2024 06:34:20 -0400
X-MC-Unique: 2ePgcKwtPwaNLyieX90OPg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9B9B19560B5;
	Wed, 18 Sep 2024 10:34:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE46B19560AA;
	Wed, 18 Sep 2024 10:34:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020>
References: <Zuo50UCuM1F7EVLk@xsang-OptiPlex-9020> <202409131438.3f225fbf-oliver.sang@intel.com> <1263138.1726214359@warthog.procyon.org.uk> <20240913-felsen-nervig-7ea082a2702c@brauner>
To: Oliver Sang <oliver.sang@intel.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    oe-lkp@lists.linux.dev, lkp@intel.com,
    Linux Memory Management List <linux-mm@kvack.org>,
    "Jeff
 Layton" <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2362634.1726655653.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Sep 2024 11:34:13 +0100
Message-ID: <2362635.1726655653@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Does this:

https://lore.kernel.org/linux-fsdevel/2280667.1726594254@warthog.procyon.o=
rg.uk/T/#u

	[PATCH] cifs: Fix reversion of the iter in cifs_readv_receive()

help?

David


