Return-Path: <linux-fsdevel+bounces-55691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74917B0DDEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F19162311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7E2ECE88;
	Tue, 22 Jul 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0iQvhfF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DADA2EBDD9;
	Tue, 22 Jul 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193374; cv=none; b=SgzmkHLgeKPoz0xqiBwrwdDv6X2AGvuwntJlGtrtFfS0UL3n/Rj1JcwXsJMTmFv1HvZdCL0rYivi0MvzDzP087/tiQYrPNQWJaattQOo7ofFsmMimOKEA1tQGgbY3jUJaBQ/8+1A2ueTf4ozC9tXNbX5b//qDmTBmBKZ1x5O4vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193374; c=relaxed/simple;
	bh=oh8d5w6pmWcQoQr9QN3tW4zD99WCRc47yE197CL2qdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gnm156dsQaCdKNUGTwHpnVAApj+oHIAPdP43s0XFLBBZwdWugMWqVYznCM206HuQX9I4dvuUtD/xIBPPAvOlkXgQROdjBb4jbO1TleUhAvygCZZxQUwEHGmQOHtvBPgE3vaWIe1nFOsFLP1JhVY0S802hS1qmbG5cL6adH6jC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0iQvhfF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B60EC4CEEB;
	Tue, 22 Jul 2025 14:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193374;
	bh=oh8d5w6pmWcQoQr9QN3tW4zD99WCRc47yE197CL2qdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0iQvhfF0XtokcJxw2FAp+B1ONCmIJ4sAs8q8IOsHFXUtvWeFLbdZCnGaily9TLWWa
	 /CeYP1YkzNGW7Rj9lMwSZgmD3GN1eWzRQw+PC6sJxnTO1BbEnVNgi3ezFKiMHSWE5b
	 2X5xSKSgrCuuZx9wVbk4gPhwxnpKkyO2bgRnfAEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.15 039/187] netfs: Fix race between cache write completion and ALL_QUEUED being set
Date: Tue, 22 Jul 2025 15:43:29 +0200
Message-ID: <20250722134347.213935942@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 89635eae076cd8eaa5cb752f66538c9dc6c9fdc3 upstream.

When netfslib is issuing subrequests, the subrequests start processing
immediately and may complete before we reach the end of the issuing
function.  At the end of the issuing function we set NETFS_RREQ_ALL_QUEUED
to indicate to the collector that we aren't going to issue any more subreqs
and that it can do the final notifications and cleanup.

Now, this isn't a problem if the request is synchronous
(NETFS_RREQ_OFFLOAD_COLLECTION is unset) as the result collection will be
done in-thread and we're guaranteed an opportunity to run the collector.

However, if the request is asynchronous, collection is primarily triggered
by the termination of subrequests queuing it on a workqueue.  Now, a race
can occur here if the app thread sets ALL_QUEUED after the last subrequest
terminates.

This can happen most easily with the copy2cache code (as used by Ceph)
where, in the collection routine of a read request, an asynchronous write
request is spawned to copy data to the cache.  Folios are added to the
write request as they're unlocked, but there may be a delay before
ALL_QUEUED is set as the write subrequests may complete before we get
there.

If all the write subreqs have finished by the ALL_QUEUED point, no further
events happen and the collection never happens, leaving the request
hanging.

Fix this by queuing the collector after setting ALL_QUEUED.  This is a bit
heavy-handed and it may be sufficient to do it only if there are no extant
subreqs.

Also add a tracepoint to cross-reference both requests in a copy-to-request
operation and add a trace to the netfs_rreq tracepoint to indicate the
setting of ALL_QUEUED.

Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only use one work item")
Reported-by: Max Kellermann <max.kellermann@ionos.com>
Link: https://lore.kernel.org/r/CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/20250711151005.2956810-3-dhowells@redhat.com
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
cc: Paulo Alcantara <pc@manguebit.org>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: netfs@lists.linux.dev
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/netfs/read_pgpriv2.c      |    4 ++++
 include/trace/events/netfs.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -111,6 +111,7 @@ static struct netfs_io_request *netfs_pg
 		goto cancel_put;
 
 	__set_bit(NETFS_RREQ_OFFLOAD_COLLECTION, &creq->flags);
+	trace_netfs_copy2cache(rreq, creq);
 	trace_netfs_write(creq, netfs_write_trace_copy_to_cache);
 	netfs_stat(&netfs_n_wh_copy_to_cache);
 	rreq->copy_to_cache = creq;
@@ -155,6 +156,9 @@ void netfs_pgpriv2_end_copy_to_cache(str
 	netfs_issue_write(creq, &creq->io_streams[1]);
 	smp_wmb(); /* Write lists before ALL_QUEUED. */
 	set_bit(NETFS_RREQ_ALL_QUEUED, &creq->flags);
+	trace_netfs_rreq(rreq, netfs_rreq_trace_end_copy_to_cache);
+	if (list_empty_careful(&creq->io_streams[1].subrequests))
+		netfs_wake_collector(creq);
 
 	netfs_put_request(creq, netfs_rreq_trace_put_return);
 	creq->copy_to_cache = NULL;
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -55,6 +55,7 @@
 	EM(netfs_rreq_trace_complete,		"COMPLET")	\
 	EM(netfs_rreq_trace_dirty,		"DIRTY  ")	\
 	EM(netfs_rreq_trace_done,		"DONE   ")	\
+	EM(netfs_rreq_trace_end_copy_to_cache,	"END-C2C")	\
 	EM(netfs_rreq_trace_free,		"FREE   ")	\
 	EM(netfs_rreq_trace_recollect,		"RECLLCT")	\
 	EM(netfs_rreq_trace_redirty,		"REDIRTY")	\
@@ -550,6 +551,35 @@ TRACE_EVENT(netfs_write,
 		      __entry->start, __entry->start + __entry->len - 1)
 	    );
 
+TRACE_EVENT(netfs_copy2cache,
+	    TP_PROTO(const struct netfs_io_request *rreq,
+		     const struct netfs_io_request *creq),
+
+	    TP_ARGS(rreq, creq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		rreq)
+		    __field(unsigned int,		creq)
+		    __field(unsigned int,		cookie)
+		    __field(unsigned int,		ino)
+			     ),
+
+	    TP_fast_assign(
+		    struct netfs_inode *__ctx = netfs_inode(rreq->inode);
+		    struct fscache_cookie *__cookie = netfs_i_cookie(__ctx);
+		    __entry->rreq	= rreq->debug_id;
+		    __entry->creq	= creq->debug_id;
+		    __entry->cookie	= __cookie ? __cookie->debug_id : 0;
+		    __entry->ino	= rreq->inode->i_ino;
+			   ),
+
+	    TP_printk("R=%08x CR=%08x c=%08x i=%x ",
+		      __entry->rreq,
+		      __entry->creq,
+		      __entry->cookie,
+		      __entry->ino)
+	    );
+
 TRACE_EVENT(netfs_collect,
 	    TP_PROTO(const struct netfs_io_request *wreq),
 



