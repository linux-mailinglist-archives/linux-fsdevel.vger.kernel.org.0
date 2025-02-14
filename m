Return-Path: <linux-fsdevel+bounces-41752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2063A366DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676BB170AE7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02A81C8616;
	Fri, 14 Feb 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCBJP9ID"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AE19066D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564980; cv=none; b=j4ve7TR8j6N9gVg5q0doZTo9wmrHV62YlYwxLS9zIhkJ0ZTzC9twqvgMZ9xxrLl1BjpJ+RcolnlO6dNjR3NjiF+A4gZfEWO5IUjH+qPeKJs9SovUZlQxErNbGTt6VK6kpoTOux8XmbhsTKuQDMj/hYm/zS9VpcYNjhViei9kNQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564980; c=relaxed/simple;
	bh=1uaP1d2sLA+8C3VqKAyaEw+qF7wwJHctclvNHKHDj1g=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ezMFBH+DGKmLpHvwzwWw7A/+3aKqc+gVXiTkelebIx2+zaKpcTBZtMcauOxJyXtlGgYO+hIrhMlWEVazXx+cNznrYXh+pb+mjuSFWegDUAmAF5hJamQp2Asx5ayfFD0OzW12moEP/0pYoartXMPkORD5ObrJK+R4eDVVUTQN6wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCBJP9ID; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739564977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c8A56lR9/Hy0OlmZRM31DYAC0QTHZRP692d8y79gV0k=;
	b=JCBJP9IDIGYEqDkTS5vvM+slV8l2eSNoNM0NiY1Pcqx8EJ13itlkOYQhu5qULx6Jpkmy37
	556FO06M5I2sf/4E0fdi9lOtJZVxCkjcRFsBJl8KhUEKoe4Mr7Cu38kcHpQhaqH2bHBhUt
	uPll8zFRVC6J9eJ69wHkRrlZ8Q7MXA8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-7-wIRc_CNce8x2dlntqXAQ-1; Fri,
 14 Feb 2025 15:29:33 -0500
X-MC-Unique: 7-wIRc_CNce8x2dlntqXAQ-1
X-Mimecast-MFC-AGG-ID: 7-wIRc_CNce8x2dlntqXAQ_1739564972
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E9F601800264;
	Fri, 14 Feb 2025 20:29:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8293B19373C4;
	Fri, 14 Feb 2025 20:29:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250117035044.23309-1-slava@dubeyko.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
    Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com,
    linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
    Slava.Dubeyko@ibm.com
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17774.1739564968.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 20:29:28 +0000
Message-ID: <17775.1739564968@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Are these patches on a git branch somewhere?  The patches I got from Willy to
do the folio conversion of ceph are going to need a bit of updating after
these fixes.

David


