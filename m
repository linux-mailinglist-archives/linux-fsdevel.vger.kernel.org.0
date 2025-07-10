Return-Path: <linux-fsdevel+bounces-54472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CB4B00062
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF9E77AA4EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 11:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545B2E54D9;
	Thu, 10 Jul 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OuLeM8t3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421502E3378
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146251; cv=none; b=LjVIk/oOqwlE8KvOJnsqU5TpdlKOdc4fMEUxuatUNPMnQqkqx8lhS8wJRRHNAGvZY+sDM5J4War4oihFejkhwQZC6qN6n0DILX1GgRNAVwHI1OlMb0CZcBbk2RbBlGbWpgWw4qOKw4B1W8eOZa7iGQqeKZds1/xyj6b4pKxLLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146251; c=relaxed/simple;
	bh=NAjPhCMTcRKqpq6hV7XgsKxibbrVUUtCrEogQBqfDuY=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=GLMTHpQDbmu+IScgCR+AdjvNvVna7/rlnuAR/VXXw1YZBf7r6jD2IcfBtCp+PFS2G4tM2psa47cVQd94tIV8ztNVC6l0heSkOI8kRz9ZwSbFBPmOPhUq3uSLKUyHJDqpzXV3OpgSBVZV8sojKt9AuYwpdm2/OZv7Dl6tdodFmKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OuLeM8t3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752146249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+o3ywtcCI2GACuBhI4aVWCkSd8fJwvm6rbRb1axiSEk=;
	b=OuLeM8t3Zyb2dEFqgGi357Y1cycMlVLsfXDINtLASLZwRtWyO8c4oZHeBAJzGitwEueyEm
	h1zpfUpPa/n/4KQbjQBtXT1VVakJRtgrITor2eQBd7XR5207AeRqLZCP6HQT56WbWdIgYc
	8MwmDesEk0TaYkX08aZ1ifPjIVPcGYE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-4qOVVfThPz2ylueXkhPf9g-1; Thu,
 10 Jul 2025 07:17:25 -0400
X-MC-Unique: 4qOVVfThPz2ylueXkhPf9g-1
X-Mimecast-MFC-AGG-ID: 4qOVVfThPz2ylueXkhPf9g_1752146243
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ADCC19560B0;
	Thu, 10 Jul 2025 11:17:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71A4A19373D8;
	Thu, 10 Jul 2025 11:17:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2807750.1752144428@warthog.procyon.org.uk>
References: <2807750.1752144428@warthog.procyon.org.uk> <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com> <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com> <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com> <2738562.1752092552@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Christian Brauner <christian@brauner.io>,
    Viacheslav Dubeyko <slava@dubeyko.com>,
    Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2808911.1752146237.1@warthog.procyon.org.uk>
Date: Thu, 10 Jul 2025 12:17:17 +0100
Message-ID: <2808912.1752146237@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> I managed to reproduce it on my test machine with ceph + fscache.
> 
> Does this fix the problem for you?

There's at least one more bug in there, so this won't fix all of the cases.

David


