Return-Path: <linux-fsdevel+bounces-69685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449DC81133
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94BF4E6D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E8280338;
	Mon, 24 Nov 2025 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6rGaQH3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6A27E07A
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763995097; cv=none; b=ffFUaxsLrs0YBouyZu1pkzzPhxxjYiAsh+U/lc5RLc/gTeG9HglM3WZBojIxhd9cmqKPzdl2iUYpq/qhUHesVWx0AJsXoKVYAS35J4ZcN3h5Zlszs0tDFqfawW2d4Gc2mLgxkcf08bwZByRJTPRTJmBnCEoRcGvUcNCU65QNlIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763995097; c=relaxed/simple;
	bh=B9dtQP2sraJQY39GwNGhh+Xoy8eX+Fuq0DQ8cERk7Q4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=MPhtpex4GAgkbNze2VkWzDzViC0n6ln7P1k7U2Z9/47spDDnJUvJSw3CpxraV/Qxn05GxupqSxqCrSvkNhaNtOKzt4gU2zSMpcaY7pzEHhcP4V5Xd7oMHwzxYpZYLnA1WZK2IhXnyMJgNQ2GhHXEVEFBrmImjwW8k4Lk+ZmMxt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6rGaQH3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763995095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B9dtQP2sraJQY39GwNGhh+Xoy8eX+Fuq0DQ8cERk7Q4=;
	b=T6rGaQH3oDQzGoSphC96NtZ/bAj7ouDggeuqEoBf0B5ixwc31MrRXncxZVoBySKe1qojGq
	4oq1NGqy89/QJ/rzjmsGMfJeJsgThpV6yWpq0ZIcjntdWMiKWRGDWVDgwKthAoZNZ+Vh+c
	m69+txmADVyJriSD/j+GLyrASiydrM8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-nky6k9zlPmu4mNlpESda7A-1; Mon,
 24 Nov 2025 09:38:08 -0500
X-MC-Unique: nky6k9zlPmu4mNlpESda7A-1
X-Mimecast-MFC-AGG-ID: nky6k9zlPmu4mNlpESda7A_1763995086
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA9519560A2;
	Mon, 24 Nov 2025 14:38:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB3201956056;
	Mon, 24 Nov 2025 14:38:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <026c8869-b90d-47df-859a-9f0a6c56d653@samba.org>
References: <026c8869-b90d-47df-859a-9f0a6c56d653@samba.org> <20251124124251.3565566-1-dhowells@redhat.com> <20251124124251.3565566-12-dhowells@redhat.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Paulo Alcantara <pc@manguebit.org>,
    Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/11] cifs: Add a tracepoint to log EIO errors
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3636008.1763995083.1@warthog.procyon.org.uk>
Date: Mon, 24 Nov 2025 14:38:03 +0000
Message-ID: <3636009.1763995083@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stefan Metzmacher <metze@samba.org> wrote:

> would you mind if we remove all smbdirect.c changes from this patch,
> as my changes I'm currently rebasing on this would remove them again
> anyway.

Sure.

David


