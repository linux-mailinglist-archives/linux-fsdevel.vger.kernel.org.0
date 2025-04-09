Return-Path: <linux-fsdevel+bounces-46077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DDDA8240E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DD34A249D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 11:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4766B25E471;
	Wed,  9 Apr 2025 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1BPhc5r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7225E455
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199825; cv=none; b=WbCQGkmcy/H44hALwEZwQtybnKIVquY3toxOQOb368sWuVIk9/hy7PpbpLXvKgASYDRyBdaaVgdHH2Cz8F+OR+pwop7/mvwQFKe9o2o0KhOjrljosuVJoHa99ogE4dr6lAnMZ5H9Nq5bAmRk0duD5iML4UGAZmP72U9SFs/c4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199825; c=relaxed/simple;
	bh=bYsI9fKny4SxKbP5giJ46oTfBA030R5OcsLlxdPQ3rc=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=i1vIG4j5Z3S/v6LnqaYCkHCNaN0jJ94gEecTvz7337MCvmvoIm8RePv/4dPJqirkK12gaLomk9UT4Ka7ifROk9xjCd7/LLGwr3LQ2u6W1VM5g7cQWJafXs0/jAcRdnYatxlWkkbzzgrZTnrZpF1f4sAxilFti4qAdCOPhHJpCus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1BPhc5r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744199822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9NW6RqANC34MSybPlsfK/Ojrrpi57Btk5nqfiDMR41o=;
	b=D1BPhc5r6gHhxPCeVQ1FV6bsQwkycTA+sO3vT/YV1p/zaGX2XEDBnSDFrLAYvivKWq0b1z
	tuJGl1H2FPT2lYzYyHR839OkPXzZ1gxz+jrrznFkH3PA9fYe9M53H9h0UTD+zRTB86VQxZ
	9SF7WZbpcTrfVmve+Hmi5wt5wKO4CQ0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-DD6Y0lk6PsChPzmI_5p8DQ-1; Wed,
 09 Apr 2025 07:56:57 -0400
X-MC-Unique: DD6Y0lk6PsChPzmI_5p8DQ-1
X-Mimecast-MFC-AGG-ID: DD6Y0lk6PsChPzmI_5p8DQ_1744199816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E9BE195609E;
	Wed,  9 Apr 2025 11:56:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B71A180B488;
	Wed,  9 Apr 2025 11:56:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1BEAB585-4A65-475C-85CC-332C98859546@fb.com>
References: <1BEAB585-4A65-475C-85CC-332C98859546@fb.com> <b395436343d8df2efdebb737580fe976@manguebit.com> <20250407184730.3568147-1-song@kernel.org> <1478622.1744097510@warthog.procyon.org.uk> <05f5b9f694ca9b1573ea8e1801098b65@manguebit.com>
To: Song Liu <songliubraving@meta.com>
Cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Song Liu <song@kernel.org>,
    "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1672920.1744199813.1@warthog.procyon.org.uk>
Date: Wed, 09 Apr 2025 12:56:53 +0100
Message-ID: <1672921.1744199813@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Song Liu <songliubraving@meta.com> wrote:

> Thanks for the review. I guess we will need the following changes, 

You need a little bit more.  The error handling in the init function also
needs #ifdef'ing too lest the compiler warn about unused goto labels.

> probably in two separate patches?

Hmmm... yes.  I'm suddenly uncertain about the order modules are inited.  It
might actually need to be fs_initcall().

David


