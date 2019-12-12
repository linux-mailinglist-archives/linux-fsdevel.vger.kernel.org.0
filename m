Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75A4C11D373
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 18:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfLLRNm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 12:13:42 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23252 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbfLLRNg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576170815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/9RPsLV3hmHV/aDZLnceRyys47s4obu7zT1ywSY+3U=;
        b=YTAZqjSCLBiEE8kML0HOJn5E9JOKVc33ekj4DXHQypAKD/iRzyytggRDD8Q9P340+IZhbb
        1cO/fkgBUnhgu1N4vj3T3VILZS86pNh/NSvgpU7yYOCWhbEA+bBpOzsbD8rJfuiDphBQsg
        R17b1xCkZDcGayWbhRQedmmm+AuUXXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-ugnwkmHgMqya7HmLmDbz_g-1; Thu, 12 Dec 2019 12:13:31 -0500
X-MC-Unique: ugnwkmHgMqya7HmLmDbz_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546F1800053;
        Thu, 12 Dec 2019 17:13:29 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C082A5C1C3;
        Thu, 12 Dec 2019 17:13:25 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Igor Mammedov <imammedo@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC v4 13/13] virtio-mem: Drop slab objects when unplug continues to fail
Date:   Thu, 12 Dec 2019 18:11:37 +0100
Message-Id: <20191212171137.13872-14-david@redhat.com>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Start dropping slab objects after 30 minutes and repeat every 30 minutes
in case we can't unplug more memory using alloc_contig_range().
Log messages and make it configurable. Enable dropping slab objects as
default (especially, reclaimable slab objects that are not movable).

In the future, we might want to implement+use drop_slab_range(), which
will also come in handy for other users (e.g., offlining, gigantic huge
pages).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3a57434f92ed..8f25f7453a08 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -25,6 +25,11 @@ static bool unplug_online =3D true;
 module_param(unplug_online, bool, 0644);
 MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
=20
+static bool drop_slab_objects =3D true;
+module_param(drop_slab_objects, bool, 0644);
+MODULE_PARM_DESC(drop_slab_objects,
+		 "Drop slab objects when unplug continues to fail");
+
 enum virtio_mem_mb_state {
 	/* Unplugged, not added to Linux. Can be reused later. */
 	VIRTIO_MEM_MB_STATE_UNUSED =3D 0,
@@ -1384,6 +1389,7 @@ static int virtio_mem_mb_unplug_any_sb_online(struc=
t virtio_mem *vm,
 static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t dif=
f)
 {
 	uint64_t nb_sb =3D diff / vm->subblock_size;
+	bool retried =3D false;
 	unsigned long mb_id;
 	int rc;
=20
@@ -1421,6 +1427,7 @@ static int virtio_mem_unplug_request(struct virtio_=
mem *vm, uint64_t diff)
 		return 0;
 	}
=20
+retry_locked:
 	/* Try to unplug subblocks of partially plugged online blocks. */
 	virtio_mem_for_each_mb_state(vm, mb_id,
 				     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
@@ -1445,6 +1452,29 @@ static int virtio_mem_unplug_request(struct virtio=
_mem *vm, uint64_t diff)
 	}
=20
 	mutex_unlock(&vm->hotplug_mutex);
+
+	/*
+	 * If we can't unplug the requested amount of memory for a long time,
+	 * start freeing up memory in caches. This might harm performance,
+	 * is configurable, and we log a message. Retry imemdiately a second
+	 * time - then wait another VIRTIO_MEM_RETRY_TIMER_MAX_MS.
+	 */
+	if (nb_sb && !retried && drop_slab_objects &&
+	    vm->retry_timer_ms =3D=3D VIRTIO_MEM_RETRY_TIMER_MAX_MS) {
+		if (vm->nid =3D=3D NUMA_NO_NODE) {
+			dev_info(&vm->vdev->dev, "dropping all slab objects\n");
+			drop_slab();
+		} else {
+			dev_info(&vm->vdev->dev,
+				 "dropping all slab objects on node=3D%d\n",
+				 vm->nid);
+			drop_slab_node(vm->nid);
+		}
+		retried =3D true;
+		mutex_lock(&vm->hotplug_mutex);
+		goto retry_locked;
+	}
+
 	return nb_sb ? -EBUSY : 0;
 out_unlock:
 	mutex_unlock(&vm->hotplug_mutex);
--=20
2.23.0

