Return-Path: <linux-fsdevel+bounces-7070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C3D8218A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EFC1F20FE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559FE7492;
	Tue,  2 Jan 2024 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBTPyO05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71F6AB7
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704185814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mazOSbOiodJMTqfGsLxXYf0xfPTI8tO7drLObG3CBf4=;
	b=JBTPyO05PEJyYzM7GhttCrf0vad4oaFM4iElqPq0zdxlFB5oeMaz/AoNiDdQbAZ4UBA4E0
	TWO8A4LWwVY6RiLWlD/HDR5jnV19A+WvkYt7Kb2QYdGUr1uoWmHcc3njJbKxCOSaLCzYhC
	2hPuUGMxjtU+lpOKkgcUz3JFO4Da9/A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-EwCIza7jPTW1lhbi1HBPBA-1; Tue, 02 Jan 2024 03:56:48 -0500
X-MC-Unique: EwCIza7jPTW1lhbi1HBPBA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60B51807F56;
	Tue,  2 Jan 2024 08:56:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 636C81121312;
	Tue,  2 Jan 2024 08:56:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: bio_vec, bv_page and folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3490947.1704185806.1@warthog.procyon.org.uk>
Date: Tue, 02 Jan 2024 08:56:46 +0000
Message-ID: <3490948.1704185806@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Christoph, Willy,

Will bv_page in struct bio_vec ever become a folio pointer rather than I page
pointer?  I'm guessing not as it still presumably needs to be able to point to
non-folio pages.

David


