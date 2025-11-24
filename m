Return-Path: <linux-fsdevel+bounces-69687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D356C811AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0A624E30F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F4B28150F;
	Mon, 24 Nov 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Piok+fw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C0D271456
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 14:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995489; cv=none; b=QKb7zsfJYOe6kJZxBwAepgZo1AMKR9I07s+ZHA4luoI2mybF49dgi391xfYtQmKNDd6JP+UKa7qXILjmRJNAD15ln1X6ya6wHyksHTHwbqWyHx60wDfMCu5aWMgdjKYyZpTgY1qr8VtcOBZb78og5151vRtLXXTl+Njp46qyYHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995489; c=relaxed/simple;
	bh=8+tkTP0NwvtQmTjv12H6kM7UcFF8HqdpXSy+DqdelRs=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=a+/OjkXbhcET5KpQtMSNl0eGhSYeyL/iNKVUOwAazjBUGzqH6oum3rqIx95WMbGURpdMHIS+Wo3AAe7gepk+wGQtSDFVqb0DjsjUcAh/sraTUYb9ns37Ba9yuWtUzR9wF6SZGy1OwqP4dOZCqGR6k2IAe1VIbZoiN8Zn0rp+5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Piok+fw2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763995486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m+kDkfiHcw+Tn6pSwMAenGkpyvxrtXwvdAEKNawQEMk=;
	b=Piok+fw2HJJ1kQE0fQnzKsoNH+bVEjdcgCpgZUgqNXzOBHDipT0laH3gYrMt67HTpTXBvA
	6fJ41h4V4hhQYJaw1fp/i3jOlF+MU+G9/JmXie/fdLuIyQIzVVslFTA+qV+GK9zIvP5v68
	RGLjSXcp9rDU8OVeWO98ATOUdG9rVSM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-vaouvjpkMqaeLHNv1BOO3A-1; Mon,
 24 Nov 2025 09:44:45 -0500
X-MC-Unique: vaouvjpkMqaeLHNv1BOO3A-1
X-Mimecast-MFC-AGG-ID: vaouvjpkMqaeLHNv1BOO3A_1763995483
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ABC9C1954B0B;
	Mon, 24 Nov 2025 14:44:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 689A119560B2;
	Mon, 24 Nov 2025 14:44:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org>
References: <ad8ef7da-db2a-4033-8701-cf2fc61b8a1d@samba.org> <7b897d50-f637-4f96-ba64-26920e314739@samba.org> <20251124124251.3565566-1-dhowells@redhat.com> <20251124124251.3565566-8-dhowells@redhat.com> <3635951.1763995018@warthog.procyon.org.uk>
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
Content-ID: <3639863.1763995480.1@warthog.procyon.org.uk>
Date: Mon, 24 Nov 2025 14:44:40 +0000
Message-ID: <3639864.1763995480@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stefan Metzmacher <metze@samba.org> wrote:

> Ok, I can just squash as well as the EIO changes below my branch
> I'll hopefully be able to post later today or tomorrow.
> 
> My idea would be that my branch would replace ksmbd-for-next
> and add your any my changes on top.

I've merged in your requested changes and repushed my branch.

David


