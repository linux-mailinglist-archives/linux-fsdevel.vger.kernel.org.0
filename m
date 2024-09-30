Return-Path: <linux-fsdevel+bounces-30335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24790989F33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 12:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B471F229D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BB189918;
	Mon, 30 Sep 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geSTv6Pb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8125F18859A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691292; cv=none; b=X9KenTOEVSI4WiiVoojIBdyrYyNXc5JF13oEf1Z7K3UsAAetp0PIW1mtsymW8EQJxBiVXAFORnv8gG39q9jYij4O2rgiib8gYnRdAXJH42q544RC6ZBQw3Vs3RpruzlrgUlBCTav7NnS4UNfNdInOYwFgHH/lgpWKmyxfRubJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691292; c=relaxed/simple;
	bh=u5LzmKmSSYeAV/1TeRHnvLY1uEs7ntSGGDzgim23sL0=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=frVUqFZDCrRfeTvP+fGeN+vwdof/2yqfilnPehsRYnhgFzMx3KJal2q5G53Z7FMl4c/IRbg73EQJfLJq6XefBJBNzZI78jZcdX2frQ0TKqu7n1vxY7siqWEcQzgeonaoA8pFahKzejkpvU46DZBtx8PbY/Ta1kKufN1wUzsugPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geSTv6Pb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727691289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1eP9GvI939vq5faaiwjlrkeAzFNfzmPqR6Xep+C8muA=;
	b=geSTv6PbXicE2KdvfKjWhTdkaEY/PbjSu1zAvIm6t3sSkOz0f69raPW7ALV/FKX2Xk1RHB
	zxw00J4nOHJHpQihkx9bJbumww4lPXbK3WLPqZRjEp+OScUhL3sz/YcMj0gW5UA02LW+K+
	FsjfcvAj5Gwqg5IonkHoGpX44wJdV/A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-D6Ih_b4QP7yzzmFi6k_zxQ-1; Mon,
 30 Sep 2024 06:14:46 -0400
X-MC-Unique: D6Ih_b4QP7yzzmFi6k_zxQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B448E1955D47;
	Mon, 30 Sep 2024 10:14:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94B643003E4D;
	Mon, 30 Sep 2024 10:14:42 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    netfs@lists.linux.dev, linux-doc@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Add folio_queue API documentation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2912368.1727691281.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2024 11:14:41 +0100
Message-ID: <2912369.1727691281@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

    =

Add API documentation for folio_queue.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-doc@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 Documentation/core-api/folio_queue.rst |  212 +++++++++++++++++++++++++++=
++++++
 include/linux/folio_queue.h            |  168 ++++++++++++++++++++++++++
 2 files changed, 380 insertions(+)

diff --git a/Documentation/core-api/folio_queue.rst b/Documentation/core-a=
pi/folio_queue.rst
new file mode 100644
index 000000000000..1fe7a9bc4b8d
--- /dev/null
+++ b/Documentation/core-api/folio_queue.rst
@@ -0,0 +1,212 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Folio Queue
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: David Howells <dhowells@redhat.com>
+
+.. Contents:
+
+ * Overview
+ * Initialisation
+ * Adding and removing folios
+ * Querying information about a folio
+ * Querying information about a folio_queue
+ * Folio queue iteration
+ * Folio marks
+ * Lockless simultaneous production/consumption issues
+
+
+Overview
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+The folio_queue struct forms a single segment in a segmented list of foli=
os
+that can be used to form an I/O buffer.  As such, the list can be iterate=
d over
+using the ITER_FOLIOQ iov_iter type.
+
+The publicly accessible members of the structure are::
+
+	struct folio_queue {
+		struct folio_queue *next;
+		struct folio_queue *prev;
+		...
+	};
+
+A pair of pointers are provided, ``next`` and ``prev``, that point to the
+segments on either side of the segment being accessed.  Whilst this is a
+doubly-linked list, it is intentionally not a circular list; the outward
+sibling pointers in terminal segments should be NULL.
+
+Each segment in the list also stores:
+
+ * an ordered sequence of folio pointers,
+ * the size of each folio and
+ * three 1-bit marks per folio,
+
+but hese should not be accessed directly as the underlying data structure=
 may
+change, but rather the access functions outlined below should be used.
+
+The facility can be made accessible by::
+
+	#include <linux/folio_queue.h>
+
+and to use the iterator::
+
+	#include <linux/uio.h>
+
+
+Initialisation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A segment should be initialised by calling::
+
+	void folioq_init(struct folio_queue *folioq);
+
+with a pointer to the segment to be initialised.  Note that this will not
+necessarily initialise all the folio pointers, so care must be taken to c=
heck
+the number of folios added.
+
+
+Adding and removing folios
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+Folios can be set in the next unused slot in a segment struct by calling =
one
+of::
+
+	unsigned int folioq_append(struct folio_queue *folioq,
+				   struct folio *folio);
+
+	unsigned int folioq_append_mark(struct folio_queue *folioq,
+					struct folio *folio);
+
+Both functions update the stored folio count, store the folio and note it=
s
+size.  The second function also sets the first mark for the folio added. =
 Both
+functions return the number of the slot used.  [!] Note that no attempt i=
s made
+to check that the capacity wasn't overrun and the list will not be extend=
ed
+automatically.
+
+A folio can be excised by calling::
+
+	void folioq_clear(struct folio_queue *folioq, unsigned int slot);
+
+This clears the slot in the array and also clears all the marks for that =
folio,
+but doesn't change the folio count - so future accesses of that slot must=
 check
+if the slot is occupied.
+
+
+Querying information about a folio
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Information about the folio in a particular slot may be queried by the
+following function::
+
+	struct folio *folioq_folio(const struct folio_queue *folioq,
+				   unsigned int slot);
+
+If a folio has not yet been set in that slot, this may yield an undefined
+pointer.  The size of the folio in a slot may be queried with either of::
+
+	unsigned int folioq_folio_order(const struct folio_queue *folioq,
+					unsigned int slot);
+
+	size_t folioq_folio_size(const struct folio_queue *folioq,
+				 unsigned int slot);
+
+The first function returns the size as an order and the second as a numbe=
r of
+bytes.
+
+
+Querying information about a folio_queue
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Information may be retrieved about a particular segment with the followin=
g
+functions::
+
+	unsigned int folioq_nr_slots(const struct folio_queue *folioq);
+
+	unsigned int folioq_count(struct folio_queue *folioq);
+
+	bool folioq_full(struct folio_queue *folioq);
+
+The first function returns the maximum capacity of a segment.  It must no=
t be
+assumed that this won't vary between segments.  The second returns the nu=
mber
+of folios added to a segments and the third is a shorthand to indicate if=
 the
+segment has been filled to capacity.
+
+Not that the count and fullness are not affected by clearing folios from =
the
+segment.  These are more about indicating how many slots in the array hav=
e been
+initialised, and it assumed that slots won't get reused, but rather the s=
egment
+will get discarded as the queue is consumed.
+
+
+Folio marks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Folios within a queue can also have marks assigned to them.  These marks =
can be
+used to note information such as if a folio needs folio_put() calling upo=
n it.
+There are three marks available to be set for each folio.
+
+The marks can be set by::
+
+	void folioq_mark(struct folio_queue *folioq, unsigned int slot);
+	void folioq_mark2(struct folio_queue *folioq, unsigned int slot);
+	void folioq_mark3(struct folio_queue *folioq, unsigned int slot);
+
+Cleared by::
+
+	void folioq_unmark(struct folio_queue *folioq, unsigned int slot);
+	void folioq_unmark2(struct folio_queue *folioq, unsigned int slot);
+	void folioq_unmark3(struct folio_queue *folioq, unsigned int slot);
+
+And the marks can be queried by::
+
+	bool folioq_is_marked(const struct folio_queue *folioq, unsigned int slo=
t);
+	bool folioq_is_marked2(const struct folio_queue *folioq, unsigned int sl=
ot);
+	bool folioq_is_marked3(const struct folio_queue *folioq, unsigned int sl=
ot);
+
+The marks can be used for any purpose and are not interpreted by this API=
.
+
+
+Folio queue iteration
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+A list of segments may be iterated over using the I/O iterator facility u=
sing
+an ``iov_iter`` iterator of ``ITER_FOLIOQ`` type.  The iterator may be
+initialised with::
+
+	void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
+				  const struct folio_queue *folioq,
+				  unsigned int first_slot, unsigned int offset,
+				  size_t count);
+
+This may be told to start at a particular segment, slot and offset within=
 a
+queue.  The iov iterator functions will follow the next pointers when adv=
ancing
+and prev pointers when reverting when needed.
+
+
+Lockless simultaneous production/consumption issues
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+If properly managed, the list can be extended by the producer at the head=
 end
+and shortened by the consumer at the tail end simultaneously without the =
need
+to take locks.  The ITER_FOLIOQ iterator inserts appropriate barriers to =
aid
+with this.
+
+Care must be taken when simultaneously producing and consuming a list.  I=
f the
+last segment is reached and the folios it refers to are entirely consumed=
 by
+the IOV iterators, an iov_iter struct will be left pointing to the last s=
egment
+with a slot number equal to the capacity of that segment.  The iterator w=
ill
+try to continue on from this if there's another segment available when it=
 is
+used again, but care must be taken lest the segment got removed and freed=
 by
+the consumer before the iterator was advanced.
+
+It is recommended that the queue always contain at least one segment, eve=
n if
+that segment has never been filled or is entirely spent.  This prevents t=
he
+head and tail pointers from collapsing.
+
+
+API Function Reference
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+.. kernel-doc:: include/linux/folio_queue.h
diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 955680c3bb5f..af871405ae55 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -3,6 +3,12 @@
  *
  * Copyright (C) 2024 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
+ *
+ * See:
+ *
+ *	Documentation/core-api/folio_queue.rst
+ *
+ * for a description of the API.
  */
 =

 #ifndef _LINUX_FOLIO_QUEUE_H
@@ -33,6 +39,13 @@ struct folio_queue {
 #endif
 };
 =

+/**
+ * folioq_init - Initialise a folio queue segment
+ * @folioq: The segment to initialise
+ *
+ * Initialise a folio queue segment.  Note that the folio pointers are
+ * left uninitialised.
+ */
 static inline void folioq_init(struct folio_queue *folioq)
 {
 	folio_batch_init(&folioq->vec);
@@ -43,62 +56,155 @@ static inline void folioq_init(struct folio_queue *fo=
lioq)
 	folioq->marks3 =3D 0;
 }
 =

+/**
+ * folioq_nr_slots: Query the capacity of a folio queue segment
+ * @folioq: The segment to query
+ *
+ * Query the number of folios that a particular folio queue segment might=
 hold.
+ * [!] NOTE: This must not be assumed to be the same for every segment!
+ */
 static inline unsigned int folioq_nr_slots(const struct folio_queue *foli=
oq)
 {
 	return PAGEVEC_SIZE;
 }
 =

+/**
+ * folioq_count: Query the occupancy of a folio queue segment
+ * @folioq: The segment to query
+ *
+ * Query the number of folios that have been added to a folio queue segme=
nt.
+ * Note that this is not decreased as folios are removed from a segment.
+ */
 static inline unsigned int folioq_count(struct folio_queue *folioq)
 {
 	return folio_batch_count(&folioq->vec);
 }
 =

+/**
+ * folioq_count: Query if a folio queue segment is full
+ * @folioq: The segment to query
+ *
+ * Query if a folio queue segment is fully occupied.  Note that this does=
 not
+ * change if folios are removed from a segment.
+ */
 static inline bool folioq_full(struct folio_queue *folioq)
 {
 	//return !folio_batch_space(&folioq->vec);
 	return folioq_count(folioq) >=3D folioq_nr_slots(folioq);
 }
 =

+/**
+ * folioq_is_marked: Check first folio mark in a folio queue segment
+ * @folioq: The segment to query
+ * @slot: The slot number of the folio to query
+ *
+ * Determine if the first mark is set for the folio in the specified slot=
 in a
+ * folio queue segment.
+ */
 static inline bool folioq_is_marked(const struct folio_queue *folioq, uns=
igned int slot)
 {
 	return test_bit(slot, &folioq->marks);
 }
 =

+/**
+ * folioq_mark: Set the first mark on a folio in a folio queue segment
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Set the first mark for the folio in the specified slot in a folio queu=
e
+ * segment.
+ */
 static inline void folioq_mark(struct folio_queue *folioq, unsigned int s=
lot)
 {
 	set_bit(slot, &folioq->marks);
 }
 =

+/**
+ * folioq_unmark: Clear the first mark on a folio in a folio queue segmen=
t
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Clear the first mark for the folio in the specified slot in a folio qu=
eue
+ * segment.
+ */
 static inline void folioq_unmark(struct folio_queue *folioq, unsigned int=
 slot)
 {
 	clear_bit(slot, &folioq->marks);
 }
 =

+/**
+ * folioq_is_marked2: Check second folio mark in a folio queue segment
+ * @folioq: The segment to query
+ * @slot: The slot number of the folio to query
+ *
+ * Determine if the second mark is set for the folio in the specified slo=
t in a
+ * folio queue segment.
+ */
 static inline bool folioq_is_marked2(const struct folio_queue *folioq, un=
signed int slot)
 {
 	return test_bit(slot, &folioq->marks2);
 }
 =

+/**
+ * folioq_mark2: Set the second mark on a folio in a folio queue segment
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Set the second mark for the folio in the specified slot in a folio que=
ue
+ * segment.
+ */
 static inline void folioq_mark2(struct folio_queue *folioq, unsigned int =
slot)
 {
 	set_bit(slot, &folioq->marks2);
 }
 =

+/**
+ * folioq_unmark2: Clear the second mark on a folio in a folio queue segm=
ent
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Clear the second mark for the folio in the specified slot in a folio q=
ueue
+ * segment.
+ */
 static inline void folioq_unmark2(struct folio_queue *folioq, unsigned in=
t slot)
 {
 	clear_bit(slot, &folioq->marks2);
 }
 =

+/**
+ * folioq_is_marked3: Check third folio mark in a folio queue segment
+ * @folioq: The segment to query
+ * @slot: The slot number of the folio to query
+ *
+ * Determine if the third mark is set for the folio in the specified slot=
 in a
+ * folio queue segment.
+ */
 static inline bool folioq_is_marked3(const struct folio_queue *folioq, un=
signed int slot)
 {
 	return test_bit(slot, &folioq->marks3);
 }
 =

+/**
+ * folioq_mark3: Set the third mark on a folio in a folio queue segment
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Set the third mark for the folio in the specified slot in a folio queu=
e
+ * segment.
+ */
 static inline void folioq_mark3(struct folio_queue *folioq, unsigned int =
slot)
 {
 	set_bit(slot, &folioq->marks3);
 }
 =

+/**
+ * folioq_unmark3: Clear the third mark on a folio in a folio queue segme=
nt
+ * @folioq: The segment to modify
+ * @slot: The slot number of the folio to modify
+ *
+ * Clear the third mark for the folio in the specified slot in a folio qu=
eue
+ * segment.
+ */
 static inline void folioq_unmark3(struct folio_queue *folioq, unsigned in=
t slot)
 {
 	clear_bit(slot, &folioq->marks3);
@@ -111,6 +217,19 @@ static inline unsigned int __folio_order(struct folio=
 *folio)
 	return folio->_flags_1 & 0xff;
 }
 =

+/**
+ * folioq_append: Add a folio to a folio queue segment
+ * @folioq: The segment to add to
+ * @folio: The folio to add
+ *
+ * Add a folio to the tail of the sequence in a folio queue segment, incr=
easing
+ * the occupancy count and returning the slot number for the folio just a=
dded.
+ * The folio size is extracted and stored in the queue and the marks are =
left
+ * unmodified.
+ *
+ * Note that it's left up to the caller to check that the segment capacit=
y will
+ * not be exceeded and to extend the queue.
+ */
 static inline unsigned int folioq_append(struct folio_queue *folioq, stru=
ct folio *folio)
 {
 	unsigned int slot =3D folioq->vec.nr++;
@@ -120,6 +239,19 @@ static inline unsigned int folioq_append(struct folio=
_queue *folioq, struct foli
 	return slot;
 }
 =

+/**
+ * folioq_append_mark: Add a folio to a folio queue segment
+ * @folioq: The segment to add to
+ * @folio: The folio to add
+ *
+ * Add a folio to the tail of the sequence in a folio queue segment, incr=
easing
+ * the occupancy count and returning the slot number for the folio just a=
dded.
+ * The folio size is extracted and stored in the queue, the first mark is=
 set
+ * and and the second and third marks are left unmodified.
+ *
+ * Note that it's left up to the caller to check that the segment capacit=
y will
+ * not be exceeded and to extend the queue.
+ */
 static inline unsigned int folioq_append_mark(struct folio_queue *folioq,=
 struct folio *folio)
 {
 	unsigned int slot =3D folioq->vec.nr++;
@@ -130,21 +262,57 @@ static inline unsigned int folioq_append_mark(struct=
 folio_queue *folioq, struct
 	return slot;
 }
 =

+/**
+ * folioq_folio: Get a folio from a folio queue segment
+ * @folioq: The segment to access
+ * @slot: The folio slot to access
+ *
+ * Retrieve the folio in the specified slot from a folio queue segment.  =
Note
+ * that no bounds check is made and if the slot hasn't been added into ye=
t, the
+ * pointer will be undefined.  If the slot has been cleared, NULL will be
+ * returned.
+ */
 static inline struct folio *folioq_folio(const struct folio_queue *folioq=
, unsigned int slot)
 {
 	return folioq->vec.folios[slot];
 }
 =

+/**
+ * folioq_folio_order: Get the order of a folio from a folio queue segmen=
t
+ * @folioq: The segment to access
+ * @slot: The folio slot to access
+ *
+ * Retrieve the order of the folio in the specified slot from a folio que=
ue
+ * segment.  Note that no bounds check is made and if the slot hasn't bee=
n
+ * added into yet, the order returned will be 0.
+ */
 static inline unsigned int folioq_folio_order(const struct folio_queue *f=
olioq, unsigned int slot)
 {
 	return folioq->orders[slot];
 }
 =

+/**
+ * folioq_folio_size: Get the size of a folio from a folio queue segment
+ * @folioq: The segment to access
+ * @slot: The folio slot to access
+ *
+ * Retrieve the size of the folio in the specified slot from a folio queu=
e
+ * segment.  Note that no bounds check is made and if the slot hasn't bee=
n
+ * added into yet, the size returned will be PAGE_SIZE.
+ */
 static inline size_t folioq_folio_size(const struct folio_queue *folioq, =
unsigned int slot)
 {
 	return PAGE_SIZE << folioq_folio_order(folioq, slot);
 }
 =

+/**
+ * folioq_clear: Clear a folio from a folio queue segment
+ * @folioq: The segment to clear
+ * @slot: The folio slot to clear
+ *
+ * Clear a folio from a sequence in a folio queue segment and clear its m=
arks.
+ * The occupancy count is left unchanged.
+ */
 static inline void folioq_clear(struct folio_queue *folioq, unsigned int =
slot)
 {
 	folioq->vec.folios[slot] =3D NULL;


