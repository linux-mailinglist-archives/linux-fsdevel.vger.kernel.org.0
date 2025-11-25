Return-Path: <linux-fsdevel+bounces-69769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192C6C84A6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 12:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F28E3A724E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6748C314B66;
	Tue, 25 Nov 2025 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ACETJP7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646B2EE5FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764069115; cv=none; b=Rkvy07AUBrvvlyL9a7SlTS3q6FxpMRrbRmYpNrQ0E1Z/E7jb4hakFOJAAeoUQuUJsAiwwp7afDtn1fQl7BZhfICga+ts44zVJJ0zxu6Z1q88u/XCWFqJm/E4m/5724n5al3UnlRzv28psQj36tIaGwhhyFA5sjT8u7Zfzsw+8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764069115; c=relaxed/simple;
	bh=Ntf82IHEqyNamlHrPnUCIlHyHwbDqRAXXbwnFps5LPs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=oxeFFUarMiY+62R8omvDZHf+nigDr1poPQMFnjcfjH+6M99QlJu19S+eznkXz5lWRJBDrGYL3Ve+DS7NUNpjekVfl9MRw5ZGwhdZPT057qtxLYT2qy4oEejuGGERknqOlbEY4wduuWUfXzg95mCYmvtvEYGMDDY0liEW4eMa4cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ACETJP7t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764069113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntf82IHEqyNamlHrPnUCIlHyHwbDqRAXXbwnFps5LPs=;
	b=ACETJP7tauTvxukBjrZXHd7u9eps/GuXYQskWdj+hEKiFNr/K/2xLQGgLWwDVQTOaphCCE
	KJvG9/ZXRGW0wQVIwXyF2TrsqPmhMWGobmMKCWYqjIpgU1RcBoOraRV3tsRXsJFmrPXgx9
	JNgpzVnEDDU8zJAjceX52XFd7Yit3zs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-hIGinUV3OMePKQ31XrzAvA-1; Tue,
 25 Nov 2025 06:11:47 -0500
X-MC-Unique: hIGinUV3OMePKQ31XrzAvA-1
X-Mimecast-MFC-AGG-ID: hIGinUV3OMePKQ31XrzAvA_1764069106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B16BE195420C;
	Tue, 25 Nov 2025 11:11:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 020CC19560B2;
	Tue, 25 Nov 2025 11:11:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <b14a083e-d754-48a9-b480-1344a07479aa@samba.org>
References: <b14a083e-d754-48a9-b480-1344a07479aa@samba.org> <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org> <7b897d50-f637-4f96-ba64-26920e314739@samba.org> <20251124124251.3565566-1-dhowells@redhat.com> <20251124124251.3565566-8-dhowells@redhat.com> <3635951.1763995018@warthog.procyon.org.uk> <3639864.1763995480@warthog.procyon.org.uk>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH v4 07/11] cifs: Clean up some places where an extra kvec[] was required for rfc1002
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3677673.1764069095.1@warthog.procyon.org.uk>
Date: Tue, 25 Nov 2025 11:11:35 +0000
Message-ID: <3677674.1764069095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Metze,

Do you want me to repost my patches so you can associate URLs with them?

David


