Return-Path: <linux-fsdevel+bounces-30351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF8398A353
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1A41F242BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954AA191F6C;
	Mon, 30 Sep 2024 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESp4XrK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FAC18EFD6
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700287; cv=none; b=YkSeN+UGVK4FpcbR08KHPwgdyW+3ejBXFbvEcUzrQYEgQI9VhqGJaMoRfja4tyMlkw15sWYpebwfTrLFltwEMX+VxjYzPMagbwUVKUtgrZRR0arlVTyxVZAtRglBIVF0dvgzRBJBe2x6SUqlwCDfXekEMid3mJ/lyTY9k6HquIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700287; c=relaxed/simple;
	bh=6vUuZ2dmjzVrkKIoa9FfLBuOBd8yL0AJKjCVHkJVKs0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rVmuEEAShaPydf/VP1MHIYSSYQUZ3u1/4u/MTqRKqBJBts4q9ILwlZIwMK1kzY4CZcK5eMoIpd2H7VX6KlLrF6wHoMsdA+8VkGZLSgjlwshwoF4NG0ipRTquuJBIs6Qv0smhqJdl9wpShJqR16dBQusoZOzzZ26ov/8Ox6Vyb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESp4XrK8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727700283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bVDH90pWvwnLUcopy8GzWW9f5uyvFXFYBMlGFlIsT8=;
	b=ESp4XrK8ugs1enaSltg3WyLRmon32/oqcDhvwu8jo31FLvkUhCB3tq91sJyPn9EpCurq5S
	rw/VXtnMLOv9Xz/b+DnSFB/tUpnyRsGn4aEGf1K1ocKqv1FNRRaiUiSDcM3RXJpN7S4OQ9
	XkV+gjlXmWr9xJZ1ME3JX/iAyJyXwR8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-q9x6f1A7NQmqo91dzCKIUg-1; Mon,
 30 Sep 2024 08:44:41 -0400
X-MC-Unique: q9x6f1A7NQmqo91dzCKIUg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 722E31944DDB;
	Mon, 30 Sep 2024 12:44:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3243E1979060;
	Mon, 30 Sep 2024 12:44:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240925103118.GE967758@unreal>
References: <20240925103118.GE967758@unreal> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <1279816.1727220013@warthog.procyon.org.uk> <4b5621958a758da830c1cf09c6f6893aed371f9d.camel@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: dhowells@redhat.com, Eduard Zingerman <eddyz87@gmail.com>,
    Christian Brauner <brauner@kernel.org>,
    Manu Bretelle <chantr4@gmail.com>, asmadeus@codewreck.org,
    ceph-devel@vger.kernel.org, christian@brauner.io, ericvh@kernel.org,
    hsiangkao@linux.alibaba.com, idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2968939.1727700270.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 13:44:30 +0100
Message-ID: <2968940.1727700270@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Okay, let's try something a little more drastic.  See if we can at least g=
et
it booting to the point we can read the tracelog.  If you can apply the
attached patch?  It won't release any folio_queue struct or put the refs o=
n
any pages, so it will quickly run out of memory - but if you have sufficie=
nt
menory, it might be enough to boot.

David
---
9p: [DEBUGGING] Don't release pages or folioq structs

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index af46a598f4d7..702286484176 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -84,8 +84,8 @@ static size_t netfs_load_buffer_from_ra(struct netfs_io_=
request *rreq,
 		folioq->orders[i] =3D order;
 		size +=3D PAGE_SIZE << order;
 =

-		if (!folio_batch_add(put_batch, folio))
-			folio_batch_release(put_batch);
+		//if (!folio_batch_add(put_batch, folio))
+		//	folio_batch_release(put_batch);
 	}
 =

 	for (int i =3D nr; i < folioq_nr_slots(folioq); i++)
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 63280791de3b..cec55b7eb5bc 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -88,7 +88,7 @@ struct folio_queue *netfs_delete_buffer_head(struct netf=
s_io_request *wreq)
 	if (next)
 		next->prev =3D NULL;
 	netfs_stat_d(&netfs_n_folioq);
-	kfree(head);
+	//kfree(head);
 	wreq->buffer =3D next;
 	return next;
 }
@@ -108,11 +108,11 @@ void netfs_clear_buffer(struct netfs_io_request *rre=
q)
 				continue;
 			if (folioq_is_marked(p, slot)) {
 				trace_netfs_folio(folio, netfs_folio_trace_put);
-				folio_put(folio);
+				//folio_put(folio);
 			}
 		}
 		netfs_stat_d(&netfs_n_folioq);
-		kfree(p);
+		//kfree(p);
 	}
 }
 =


