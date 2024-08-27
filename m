Return-Path: <linux-fsdevel+bounces-27376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C90960E4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106F2286DDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 14:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7698D44C8C;
	Tue, 27 Aug 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbmNjXMC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C71C6F43
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770026; cv=none; b=nG3OFPho9Mpiz3paT0v3NhIvk2lUQHes8M3M2UmHgOMAz4pMtkOtbcK7mGfPtgpJhkRpP08km+DHBGA0lo3N/0E6yKR5I1kvZX6XU2DLaUN84AH1za8zUegfnPkor3DgIVxv6nMD+aQ2KiMI+z4PY85n4xkAKLeEd3rtz+ko21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770026; c=relaxed/simple;
	bh=+AmonIJCykCJOo/Uu7OJvxf21efia77ZJrd62BC4QT4=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=UCipK5ZmdKBPN0ZdjOJvNZYOTHTwqpCFqZrW+Tx3AQTnUIdoLitV5GgVZiPRTbEzjIyFbFiFb/VOw0UJMeo+MM0wg+YdLRZkzJbGU+TUI9AL290MTe82afotaMzbA4Ko+Er4yqeHL+eAQcJLYwaP4stXEWmiLTpBTea9Ms2kzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbmNjXMC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724770024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=aFd0/WLiPXvJiPqmeiXOS+H/ZKM/prGo2nSmnbwce94=;
	b=TbmNjXMCMthsRFDMg5VVrTx/0yYY2YvEGRGi9pPJ9oV7yJmIOoq51GQ+LkXoDSm9GNmfKE
	ea1GVFTyfndCLHpNqOfZzIvhNDNvO0m18vk2Z+Y6qkUELvXMoQpSn8ksIQo8iWNy0qslCa
	Pb4JM6lnAEDvu6HlYJBDvgkSRts+rgk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-9rtXBTUGNpe2wr4MTBTVGQ-1; Tue,
 27 Aug 2024 10:47:01 -0400
X-MC-Unique: 9rtXBTUGNpe2wr4MTBTVGQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23F7C1955BF4;
	Tue, 27 Aug 2024 14:46:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61AAD19560AA;
	Tue, 27 Aug 2024 14:46:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Jan Kara <jack@suse.cz>
cc: dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
    Steve French <sfrench@samba.org>, netfs@lists.linux.dev,
    linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: The mapping->invalidate_lock, copy-offload and cifs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <774274.1724770015.1@warthog.procyon.org.uk>
Date: Tue, 27 Aug 2024 15:46:55 +0100
Message-ID: <774275.1724770015@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Jann,

I'm looking at trying to fix cifs_file_copychunk_range().  Currently, it
invalidates the destination range, apart from a partial folio at either end
which will be flushed, and then tries the copy.  But if the copy fails or can
only be partially completed (eg. ENOSPC), we lose any data in the destination
region, so I think it needs to be flushed and invalidated rather than just
being invalidated.

Now, we have filemap_invalidate_inode() which I can use to flush back and
invalidate the folios under the invalidate_lock (thereby avoiding the need for
launder_folio).  However, that doesn't prevent mmap from reinstating the
destination folios with modifications whilst the copy is ongoing the moment
the invalidate_lock is dropped.

Question is: would it be reasonable to do the copy offload whilst holding the
invalidate_lock for the duration?

Thanks,
David


