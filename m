Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE67626911
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Nov 2022 12:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKLLRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Nov 2022 06:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbiKLLR1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Nov 2022 06:17:27 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8F1F607;
        Sat, 12 Nov 2022 03:17:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1668249063; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=cCExhhTFEX3QBBDEO7eNkVH64rQHEy90REKBoYaxQvgaFH4AZlKHDMn8exZuW65rmWDMbCDWK7qP/lcgLSAjbfRyY0kOOMk4oKpRZCwaINRtegcQs7I8faLFuPyOT3TqIsvcVNGkHJYMaBN8HLTXNuz3kHB8YcGSIgZBN240O0c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1668249063; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=I7Q4D57L0Fon5Y8OnWeD+j+i4yBdJ+wVG0hPi+xhFQ8=; 
        b=UfU5qRrr5Xw5lMpe2TXVlG5nQNLpOizm3z7ffPbOl6+m/9Isl+ejHq35iFbPL929U8npPGk76RdzEuVljTTn0CRVawlhwLF8tINjrLYmlipwi2s953+El1VLr3f1YDfuk/rqnV2x9zUIKIbeBjoc0i0vd7fd+aBAVhX3+9Kihpk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1668249063;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=I7Q4D57L0Fon5Y8OnWeD+j+i4yBdJ+wVG0hPi+xhFQ8=;
        b=Fi3TU3wBUF/MWae+TX25M+DpVcTzI7q7h4Re+i2nMNUP5mScOP8xWudmN6LlH7dt
        039pWLOp6n4Wci7DwK61rRfc8d/0tHo5tYOfPWmFQ7NM310Gl6MLiX1aWuV7qcpOSYP
        A2CKstDiMgydjb7EvzdBSv+wrUoUNDXB3WeHqtcw=
Received: from kampyooter.. (110.226.30.173 [110.226.30.173]) by mx.zoho.in
        with SMTPS id 1668249062205101.81942800584966; Sat, 12 Nov 2022 16:01:02 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     keyrings <keyrings@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3cdc67df35a283c4d1a341d039d0c2251ff72930.1668248462.git.code@siddh.me>
Subject: [RESEND PATCH v2 1/2] include/linux/watch_queue: Improve documentation
Date:   Sat, 12 Nov 2022 16:00:40 +0530
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1668248462.git.code@siddh.me>
References: <cover.1668248462.git.code@siddh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce kerneldoc-style comments, and document a couple of things
explicitly.

Signed-off-by: Siddh Raman Pant <code@siddh.me>
---
 include/linux/watch_queue.h | 102 ++++++++++++++++++++++++++----------
 1 file changed, 75 insertions(+), 27 deletions(-)

diff --git a/include/linux/watch_queue.h b/include/linux/watch_queue.h
index fc6bba20273b..7f8b1f15634b 100644
--- a/include/linux/watch_queue.h
+++ b/include/linux/watch_queue.h
@@ -18,57 +18,103 @@
=20
 struct cred;
=20
+/**
+ * struct watch_type_filter - Filter on watch type
+ *
+ * @type: Type of watch_notification
+ * @subtype_filter: Bitmask of subtypes to filter on
+ * @info_filter: Filter on watch_notification::info
+ * @info_mask: Mask of relevant bits in info_filter
+ */
 struct watch_type_filter {
 =09enum watch_notification_type type;
-=09__u32=09=09subtype_filter[1];=09/* Bitmask of subtypes to filter on */
-=09__u32=09=09info_filter;=09=09/* Filter on watch_notification::info */
-=09__u32=09=09info_mask;=09=09/* Mask of relevant bits in info_filter */
+=09__u32=09=09subtype_filter[1];
+=09__u32=09=09info_filter;
+=09__u32=09=09info_mask;
 };
=20
+/**
+ * struct watch_filter - Filter on watch
+ *
+ * @rcu: RCU head (in union with type_filter)
+ * @type_filter: Bitmask of accepted types (in union with rcu)
+ * @nr_filters: Number of filters
+ * @filters: Array of watch_type_filter
+ */
 struct watch_filter {
 =09union {
 =09=09struct rcu_head=09rcu;
-=09=09/* Bitmask of accepted types */
 =09=09DECLARE_BITMAP(type_filter, WATCH_TYPE__NR);
 =09};
-=09u32=09=09=09nr_filters;=09/* Number of filters */
+=09u32=09=09=09 nr_filters;
 =09struct watch_type_filter filters[];
 };
=20
+/**
+ * struct watch_queue - General notification queue
+ *
+ * @rcu: RCU head
+ * @filter: Filter to use on watches
+ * @pipe: The pipe we're using as a buffer
+ * @watches: Contributory watches
+ * @notes: Preallocated notifications
+ * @notes_bitmap: Allocation bitmap for notes
+ * @usage: Object usage count
+ * @lock: To serialize accesses and removes
+ * @nr_notes: Number of notes
+ * @nr_pages: Number of pages in notes[]
+ * @defunct: True when queues closed
+ */
 struct watch_queue {
 =09struct rcu_head=09=09rcu;
 =09struct watch_filter __rcu *filter;
-=09struct pipe_inode_info=09*pipe;=09=09/* The pipe we're using as a buffe=
r */
-=09struct hlist_head=09watches;=09/* Contributory watches */
-=09struct page=09=09**notes;=09/* Preallocated notifications */
-=09unsigned long=09=09*notes_bitmap;=09/* Allocation bitmap for notes */
-=09struct kref=09=09usage;=09=09/* Object usage count */
+=09struct pipe_inode_info=09*pipe;
+=09struct hlist_head=09watches;
+=09struct page=09=09**notes;
+=09unsigned long=09=09*notes_bitmap;
+=09struct kref=09=09usage;
 =09spinlock_t=09=09lock;
-=09unsigned int=09=09nr_notes;=09/* Number of notes */
-=09unsigned int=09=09nr_pages;=09/* Number of pages in notes[] */
-=09bool=09=09=09defunct;=09/* T when queues closed */
+=09unsigned int=09=09nr_notes;
+=09unsigned int=09=09nr_pages;
+=09bool=09=09=09defunct;
 };
=20
-/*
- * Representation of a watch on an object.
+/**
+ * struct watch - Representation of a watch on an object
+ *
+ * @rcu: RCU head (in union with info_id)
+ * @info_id: ID to be OR'd in to info field (in union with rcu)
+ * @queue: Queue to post events to
+ * @queue_node: Link in queue->watches
+ * @watch_list: Link in watch_list->watchers
+ * @list_node: The list node
+ * @cred: Creds of the owner of the watch
+ * @private: Private data for the watched object
+ * @id: Internal identifier
+ * @usage: Object usage count
  */
 struct watch {
 =09union {
 =09=09struct rcu_head=09rcu;
-=09=09u32=09=09info_id;=09/* ID to be OR'd in to info field */
+=09=09u32=09=09info_id;
 =09};
-=09struct watch_queue __rcu *queue;=09/* Queue to post events to */
-=09struct hlist_node=09queue_node;=09/* Link in queue->watches */
+=09struct watch_queue __rcu *queue;
+=09struct hlist_node=09queue_node;
 =09struct watch_list __rcu=09*watch_list;
-=09struct hlist_node=09list_node;=09/* Link in watch_list->watchers */
-=09const struct cred=09*cred;=09=09/* Creds of the owner of the watch */
-=09void=09=09=09*private;=09/* Private data for the watched object */
-=09u64=09=09=09id;=09=09/* Internal identifier */
-=09struct kref=09=09usage;=09=09/* Object usage count */
+=09struct hlist_node=09list_node;
+=09const struct cred=09*cred;
+=09void=09=09=09*private;
+=09u64=09=09=09id;
+=09struct kref=09=09usage;
 };
=20
-/*
- * List of watches on an object.
+/**
+ * struct watch_list - List of watches on an object
+ *
+ * @rcu: RCU head
+ * @watchers: List head
+ * @release_watch: Function to release watch
+ * @lock: To protect addition and removal of watches
  */
 struct watch_list {
 =09struct rcu_head=09=09rcu;
@@ -118,8 +164,10 @@ static inline void remove_watch_list(struct watch_list=
 *wlist, u64 id)
 }
=20
 /**
- * watch_sizeof - Calculate the information part of the size of a watch re=
cord,
- * given the structure size.
+ * watch_sizeof() - Calculate the information part of the size of a watch
+ *=09=09    record, given the structure size.
+ *
+ * @STRUCT: The structure whose size is to be given
  */
 #define watch_sizeof(STRUCT) (sizeof(STRUCT) << WATCH_INFO_LENGTH__SHIFT)
=20
--=20
2.35.1


