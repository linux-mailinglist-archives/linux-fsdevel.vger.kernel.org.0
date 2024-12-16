Return-Path: <linux-fsdevel+bounces-37524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 091529F3B23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 21:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF357A66E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A511D4601;
	Mon, 16 Dec 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJjI8Az8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE21D5CE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2024 20:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381714; cv=none; b=idlv4Aboh0TKB0aZfKCiCWMkpwtpVEkdCVw2RSWuYSnuFebAECX1fwexh9PQwtOmYx9Wd1MDy2MNhwwvO7HZFypYfzhkjFgzfvfDd0h7sB09oIkFVK1mw0u2C57lgl/iuo4iNHsM+s4/n3G1TKy1IXDWIePEXfG7acYEYwpv/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381714; c=relaxed/simple;
	bh=2MDo0CYjbgS3+aTOA6R0iIDfuuEZBPXPgr5AGDed70I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTLTkdfNvhQqThMT2MouDZCQ1EIiH+w7ZoOoDBRJcS1dxUr+GV/IfORMh/nytkCG7nPaRd2EuNd2Ub1hQH8xsLVz+4VO0iNU3tevI8lq4LNdVHIzEVbQX/jKeUi9aifhZxtOCGCfqGTruOWUvjvtX2vJKeRanfC81dQXWFHnAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJjI8Az8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adTBnOlG7OP+mEEaZME4U1Xm6Whye29vdivXZFAeN/g=;
	b=WJjI8Az8RxDrgBUsGVaHYzoLvGihfxi6O4rWYXF96ibqgIrdHXYhjF88Wk5xybYZW9OWsp
	+2q36FCxa7EM6pohWDzRUwZqCoJQ85YCBfsRRjrI99BPMb8pcO3f8XuT2JkMhI+ocvW2CF
	Iz1lFQp9TkExkNyEWU2SXYvjoS11XjE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-jA7cNRPXO32tOToDKSMRqw-1; Mon,
 16 Dec 2024 15:41:46 -0500
X-MC-Unique: jA7cNRPXO32tOToDKSMRqw-1
X-Mimecast-MFC-AGG-ID: jA7cNRPXO32tOToDKSMRqw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5273A1956052;
	Mon, 16 Dec 2024 20:41:43 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B548A19560A2;
	Mon, 16 Dec 2024 20:41:36 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 01/32] netfs: Clean up some whitespace in trace header
Date: Mon, 16 Dec 2024 20:40:51 +0000
Message-ID: <20241216204124.3752367-2-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Clean up some whitespace in the netfs trace header.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/netfs.h | 130 +++++++++++++++++------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index bf511bca896e..c3c309f8fbe1 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -250,13 +250,13 @@ TRACE_EVENT(netfs_read,
 	    TP_ARGS(rreq, start, len, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		cookie		)
-		    __field(loff_t,			i_size		)
-		    __field(loff_t,			start		)
-		    __field(size_t,			len		)
-		    __field(enum netfs_read_trace,	what		)
-		    __field(unsigned int,		netfs_inode	)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		cookie)
+		    __field(loff_t,			i_size)
+		    __field(loff_t,			start)
+		    __field(size_t,			len)
+		    __field(enum netfs_read_trace,	what)
+		    __field(unsigned int,		netfs_inode)
 			     ),
 
 	    TP_fast_assign(
@@ -284,10 +284,10 @@ TRACE_EVENT(netfs_rreq,
 	    TP_ARGS(rreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		flags		)
-		    __field(enum netfs_io_origin,	origin		)
-		    __field(enum netfs_rreq_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		flags)
+		    __field(enum netfs_io_origin,	origin)
+		    __field(enum netfs_rreq_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -311,15 +311,15 @@ TRACE_EVENT(netfs_sreq,
 	    TP_ARGS(sreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned short,		index		)
-		    __field(short,			error		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum netfs_sreq_trace,	what		)
-		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
-		    __field(loff_t,			start		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned short,		index)
+		    __field(short,			error)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum netfs_sreq_trace,	what)
+		    __field(size_t,			len)
+		    __field(size_t,			transferred)
+		    __field(loff_t,			start)
 			     ),
 
 	    TP_fast_assign(
@@ -351,15 +351,15 @@ TRACE_EVENT(netfs_failure,
 	    TP_ARGS(rreq, sreq, error, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(short,			index		)
-		    __field(short,			error		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum netfs_failure,		what		)
-		    __field(size_t,			len		)
-		    __field(size_t,			transferred	)
-		    __field(loff_t,			start		)
+		    __field(unsigned int,		rreq)
+		    __field(short,			index)
+		    __field(short,			error)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum netfs_failure,		what)
+		    __field(size_t,			len)
+		    __field(size_t,			transferred)
+		    __field(loff_t,			start)
 			     ),
 
 	    TP_fast_assign(
@@ -390,9 +390,9 @@ TRACE_EVENT(netfs_rreq_ref,
 	    TP_ARGS(rreq_debug_id, ref, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(int,			ref		)
-		    __field(enum netfs_rreq_ref_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(int,			ref)
+		    __field(enum netfs_rreq_ref_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -414,10 +414,10 @@ TRACE_EVENT(netfs_sreq_ref,
 	    TP_ARGS(rreq_debug_id, subreq_debug_index, ref, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		rreq		)
-		    __field(unsigned int,		subreq		)
-		    __field(int,			ref		)
-		    __field(enum netfs_sreq_ref_trace,	what		)
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		subreq)
+		    __field(int,			ref)
+		    __field(enum netfs_sreq_ref_trace,	what)
 			     ),
 
 	    TP_fast_assign(
@@ -465,10 +465,10 @@ TRACE_EVENT(netfs_write_iter,
 	    TP_ARGS(iocb, from),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned long long,		start		)
-		    __field(size_t,			len		)
-		    __field(unsigned int,		flags		)
-		    __field(unsigned int,		ino		)
+		    __field(unsigned long long,		start)
+		    __field(size_t,			len)
+		    __field(unsigned int,		flags)
+		    __field(unsigned int,		ino)
 			     ),
 
 	    TP_fast_assign(
@@ -489,12 +489,12 @@ TRACE_EVENT(netfs_write,
 	    TP_ARGS(wreq, what),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		cookie		)
-		    __field(unsigned int,		ino		)
-		    __field(enum netfs_write_trace,	what		)
-		    __field(unsigned long long,		start		)
-		    __field(unsigned long long,		len		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+		    __field(enum netfs_write_trace,	what)
+		    __field(unsigned long long,		start)
+		    __field(unsigned long long,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -522,10 +522,10 @@ TRACE_EVENT(netfs_collect,
 	    TP_ARGS(wreq),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		len		)
-		    __field(unsigned long long,		transferred	)
-		    __field(unsigned long long,		start		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		len)
+		    __field(unsigned long long,		transferred)
+		    __field(unsigned long long,		start)
 			     ),
 
 	    TP_fast_assign(
@@ -548,12 +548,12 @@ TRACE_EVENT(netfs_collect_sreq,
 	    TP_ARGS(wreq, subreq),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		wreq		)
-		    __field(unsigned int,		subreq		)
-		    __field(unsigned int,		stream		)
-		    __field(unsigned int,		len		)
-		    __field(unsigned int,		transferred	)
-		    __field(unsigned long long,		start		)
+		    __field(unsigned int,		wreq)
+		    __field(unsigned int,		subreq)
+		    __field(unsigned int,		stream)
+		    __field(unsigned int,		len)
+		    __field(unsigned int,		transferred)
+		    __field(unsigned long long,		start)
 			     ),
 
 	    TP_fast_assign(
@@ -579,11 +579,11 @@ TRACE_EVENT(netfs_collect_folio,
 	    TP_ARGS(wreq, folio, fend, collected_to),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	wreq		)
-		    __field(unsigned long,	index		)
-		    __field(unsigned long long,	fend		)
-		    __field(unsigned long long,	cleaned_to	)
-		    __field(unsigned long long,	collected_to	)
+		    __field(unsigned int,	wreq)
+		    __field(unsigned long,	index)
+		    __field(unsigned long long,	fend)
+		    __field(unsigned long long,	cleaned_to)
+		    __field(unsigned long long,	collected_to)
 			     ),
 
 	    TP_fast_assign(
@@ -608,10 +608,10 @@ TRACE_EVENT(netfs_collect_state,
 	    TP_ARGS(wreq, collected_to, notes),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	wreq		)
-		    __field(unsigned int,	notes		)
-		    __field(unsigned long long,	collected_to	)
-		    __field(unsigned long long,	cleaned_to	)
+		    __field(unsigned int,	wreq)
+		    __field(unsigned int,	notes)
+		    __field(unsigned long long,	collected_to)
+		    __field(unsigned long long,	cleaned_to)
 			     ),
 
 	    TP_fast_assign(


