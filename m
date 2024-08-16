Return-Path: <linux-fsdevel+bounces-26150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0C6955180
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 21:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6BB1C226A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 19:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627F1C4623;
	Fri, 16 Aug 2024 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYkBmuSm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35D61C37A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723836684; cv=none; b=fR7J7C0xhVWpSbqhIEWGLVxm2esHPNSJDFyI1CSt09dn9gQmxJbYq1IqpFNyUhmeCq2+Kh8zrOFsbIJxnWy/PnrM29Rgln7YJlOg1afMAYw4fHXa0ZRJrD4pvY6SZigN8Yre4zZLv1dFaqY+3EIBkx+lLTI1Shf3VdSjoCwbQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723836684; c=relaxed/simple;
	bh=a3UBjcnOVg9NQFsbusket7qF4bskI8OeVBv1Iky1Ikk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Ho+B7yZVB7sHRH0nLPOEh067+E5noURE5/e4KYqZhzGvy7SZxHEuW2E3nvYI+xW/CAtpreTuR+ommrWMt33WUQHjMkjKCgrHXrmDnxxWHxwnnJpU58cYkp0P+1d0s3jVyxznOwqb/bdBdoQlxlUR76+9bfDa3gfsULe+qIa2Hbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYkBmuSm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723836682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dAUVeRgH13oxbvE6MJ/L04r2yM6YzE3o8WtEBRvyajM=;
	b=CYkBmuSmV2/nUgKhd1Y5R5YEkYp4xqrso1YiuYAn8qFXy9/qslYX3cJcusqKF4gJlrNXF7
	IAp/UvUqxDcDN7PR+jdPAQTrKduFIGOA98fM/4MRAmylqDY5E1QB6T9kwNXZTCCkaSEtRB
	rlq6jc825AO42pPU6kJ0zE0C1eA+q90=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-KiX_NkxMM_erpn1TlFqLZQ-1; Fri,
 16 Aug 2024 15:31:15 -0400
X-MC-Unique: KiX_NkxMM_erpn1TlFqLZQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CBF101955F45;
	Fri, 16 Aug 2024 19:31:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6593719560A3;
	Fri, 16 Aug 2024 19:31:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240815090849.972355-1-kernel@pankajraghav.com>
References: <20240815090849.972355-1-kernel@pankajraghav.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: dhowells@redhat.com, brauner@kernel.org, akpm@linux-foundation.org,
    chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org,
    djwong@kernel.org, hare@suse.de, gost.dev@samsung.com,
    linux-xfs@vger.kernel.org, hch@lst.de, david@fromorbit.com,
    Zi Yan <ziy@nvidia.com>, yang@os.amperecomputing.com,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    willy@infradead.org, john.g.garry@oracle.com,
    cl@os.amperecomputing.com, p.raghav@samsung.com, mcgrof@kernel.org,
    ryan.roberts@arm.com
Subject: Re: [PATCH v12 00/10] enable bs > ps in XFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2924796.1723836663.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2024 20:31:03 +0100
Message-ID: <2924797.1723836663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Pankaj,

I applied the first five patches and set minimum folio size for afs files =
to
8K (see attached patch) and ran some tests.

With simple tests, I can see in the trace log that it is definitely creati=
ng
8K folios where it would previously create 4K folios.

However, with 'xfstests -g quick', generic/075 generic/112 generic/393 fai=
l
where they didn't previously.  I won't be able to look into this more till
Monday.

If you want to try using afs for yourself, install the kafs-client package
(available on Fedora and Debian), do 'systemctl start afs.mount' and then =
you
can, say, do:

	ls /afs/openafs.org/www/docs.openafs.org/

and browse the publicly accessible files under there.

David
---
commit d676df787baee3b710b9f0d284b21518473feb3c
Author: David Howells <dhowells@redhat.com>
Date:   Fri Aug 16 19:54:25 2024 +0100

    afs: [DEBUGGING] Set min folio order

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 3acf5e050072..c3842cba92e7 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -104,6 +104,7 @@ static int afs_inode_init_from_status(struct afs_opera=
tion *op,
 		inode->i_fop	=3D &afs_file_operations;
 		inode->i_mapping->a_ops	=3D &afs_file_aops;
 		mapping_set_large_folios(inode->i_mapping);
+		mapping_set_folio_min_order(inode->i_mapping, 1);
 		break;
 	case AFS_FTYPE_DIR:
 		inode->i_mode	=3D S_IFDIR |  (status->mode & S_IALLUGO);


