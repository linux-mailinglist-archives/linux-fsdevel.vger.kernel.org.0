Return-Path: <linux-fsdevel+bounces-29284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55433977A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 09:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F47F1C21D63
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 07:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF81BC9EB;
	Fri, 13 Sep 2024 07:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTN0b4zl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A07F1BB6A4
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Sep 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214370; cv=none; b=bpZDo38ZRqsW10V5gCouJD1fBuT7OhJcU1g0sCo/UoLyOefe54LgXXX1f6PTn1sfWX+KFMeYCY6Wl3Thw7X7X5uDXkLRd34r1ZkKftBM4atrCqKgcNoLKGOJYxmfMEUaj6RwhhbgESiGV9REjniPJkpeeSeuvRmGzYakm9ef+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214370; c=relaxed/simple;
	bh=kgtxvsYQ+THuJREDp/R0kMk6JWPfaY7Kq1aHhRJ3s8E=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=RGmwT8D9vD9CoMlS3GrBo+lDzD6w2fGQRj35lgoyRp0+ie82limdar/0I2WR7qpG7bw2NW5wV94vf3MDD70I7br19k+cZ4Rk04GGPDcvVv+78UcJ0TH5379bPBJix/Scrx1NmNNXqrccRADC02I1wbEKcwf3ZDwhQJS1F4ScmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aTN0b4zl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726214368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyeF+/WYzR3SYi9omjxf05OynwYJxePvZ/auujDdqu4=;
	b=aTN0b4zlYVZHiJ1khOXj4B77PH8Zk5JoTocdgq7gkWuxnbyQx+LUA9DHmmExIQq7zJI8M8
	CV39u3BWWxdX9pSasG3monZLx/sYBiRC0CpeP1IeuJFjk0I+6zCI0hNRRZ8nxrVwB/fjDD
	yS6GZitT9Ifrsb91DCdb9zTp78zCJ74=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-OrTa6mQ8NEiM4VnKY-WhyQ-1; Fri,
 13 Sep 2024 03:59:25 -0400
X-MC-Unique: OrTa6mQ8NEiM4VnKY-WhyQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A94211956077;
	Fri, 13 Sep 2024 07:59:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0215C30001AB;
	Fri, 13 Sep 2024 07:59:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <202409131438.3f225fbf-oliver.sang@intel.com>
References: <202409131438.3f225fbf-oliver.sang@intel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: dhowells@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
    Linux Memory Management List <linux-mm@kvack.org>,
    Christian Brauner <brauner@kernel.org>,
    Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1263137.1726214359.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Sep 2024 08:59:19 +0100
Message-ID: <1263138.1726214359@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Can you try with the attached change?  It'll get folded into Christian's
vfs.netfs branch at some point.

David
---
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 84a517a0189d..97003155bfac 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1026,7 +1026,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter=
 *iter,
 		iov_offset +=3D part;
 		extracted +=3D part;
 =

-		*pages =3D folio_page(folio, offset % PAGE_SIZE);
+		*pages =3D folio_page(folio, offset / PAGE_SIZE);
 		get_page(*pages);
 		pages++;
 		maxpages--;


