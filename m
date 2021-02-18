Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220C231ECF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhBRRKU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 12:10:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233344AbhBROHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 09:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613657182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YxxJ29aSymX4Z00nCing50dEBN/DdhwTMSMb6j8OPe4=;
        b=ZvgoU0z4aFqjvsl8Fk9AJ2TwmAIYgrf5JvQDQjmtFidN4kW29bFlduLH3H/wDJFEG7q92C
        TlRYzLBFQkmaQQp6y6nspFlT+5Wvfw1Joi4FBMRueMXK+d/F9e3+Lbq9blol6DqNtaV7jd
        fPER1j+Wcdh8/+xadIyj/nBcypyeFt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-ndaNfz4WPi-ih6BZqMZ9cw-1; Thu, 18 Feb 2021 09:02:48 -0500
X-MC-Unique: ndaNfz4WPi-ih6BZqMZ9cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44AB6106BBDB;
        Thu, 18 Feb 2021 14:02:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-119-68.rdu2.redhat.com [10.10.119.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B241619CA;
        Thu, 18 Feb 2021 14:02:37 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210216093044.GA24615@lst.de>
References: <20210216093044.GA24615@lst.de> <20210216084230.GA23669@lst.de> <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk> <1376938.1613429183@warthog.procyon.org.uk> <1419965.1613467771@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, linux-cachefs@redhat.com,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 34/33] netfs: Pass flag rather than use in_softirq()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2017128.1613656956.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 18 Feb 2021 14:02:36 +0000
Message-ID: <2017129.1613656956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Feb 16, 2021 at 09:29:31AM +0000, David Howells wrote:
> > Is there a better way to do it?  The intent is to process the assessme=
nt
> > phase in the calling thread's context if possible rather than bumping =
over
> > to a worker thread.  For synchronous I/O, for example, that's done in =
the
> > caller's thread.  Maybe that's the answer - if it's known to be
> > asynchronous, I have to punt, but otherwise don't have to.
> =

> Yes, i think you want an explicit flag instead.

How about the attached instead?

David
---
commit 29b3e9eed616db01f15c7998c062b4e501ea6582
Author: David Howells <dhowells@redhat.com>
Date:   Mon Feb 15 21:56:43 2021 +0000

    netfs: Pass flag rather than use in_softirq()
    =

    The in_softirq() in netfs_rreq_terminated() works fine for the cache b=
eing
    on a normal disk, as the completion handlers may get called in softirq
    context, but for an NVMe drive, the completion handler may get called =
in
    IRQ context.
    =

    Fix to pass a flag to netfs_subreq_terminated() to indicate whether we
    think the function isn't being called from a context in which we can d=
o
    allocations, waits and I/O submissions (such as softirq or interrupt
    context).  If this flag is set, netfs lib has to punt to a worker thre=
ad to
    handle anything like that.
    =

    The symptom involves warnings like the following appearing and the ker=
nel
    hanging:
    =

     WARNING: CPU: 0 PID: 0 at kernel/softirq.c:175 __local_bh_enable_ip+0=
x35/0x50
     ...
     RIP: 0010:__local_bh_enable_ip+0x35/0x50
     ...
     Call Trace:
      <IRQ>
      rxrpc_kernel_begin_call+0x7d/0x1b0 [rxrpc]
      ? afs_rx_new_call+0x40/0x40 [kafs]
      ? afs_alloc_call+0x28/0x120 [kafs]
      afs_make_call+0x120/0x510 [kafs]
      ? afs_rx_new_call+0x40/0x40 [kafs]
      ? afs_alloc_flat_call+0xba/0x100 [kafs]
      ? __kmalloc+0x167/0x2f0
      ? afs_alloc_flat_call+0x9b/0x100 [kafs]
      afs_wait_for_operation+0x2d/0x200 [kafs]
      afs_do_sync_operation+0x16/0x20 [kafs]
      afs_req_issue_op+0x8c/0xb0 [kafs]
      netfs_rreq_assess+0x125/0x7d0 [netfs]
      ? cachefiles_end_operation+0x40/0x40 [cachefiles]
      netfs_subreq_terminated+0x117/0x220 [netfs]
      cachefiles_read_complete+0x21/0x60 [cachefiles]
      iomap_dio_bio_end_io+0xdd/0x110
      blk_update_request+0x20a/0x380
      blk_mq_end_request+0x1c/0x120
      nvme_process_cq+0x159/0x1f0 [nvme]
      nvme_irq+0x10/0x20 [nvme]
      __handle_irq_event_percpu+0x37/0x150
      handle_irq_event+0x49/0xb0
      handle_edge_irq+0x7c/0x200
      asm_call_irq_on_stack+0xf/0x20
      </IRQ>
      common_interrupt+0xad/0x120
      asm_common_interrupt+0x1e/0x40
     ...
    =

    Reported-by: Marc Dionne <marc.dionne@auristor.com>
    Signed-off-by: David Howells <dhowells@redhat.com>
    cc: Matthew Wilcox <willy@infradead.org>
    cc: linux-mm@kvack.org
    cc: linux-cachefs@redhat.com
    cc: linux-afs@lists.infradead.org
    cc: linux-nfs@vger.kernel.org
    cc: linux-cifs@vger.kernel.org
    cc: ceph-devel@vger.kernel.org
    cc: v9fs-developer@lists.sourceforge.net
    cc: linux-fsdevel@vger.kernel.org

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 8f28d4f4cfd7..6dcdbbfb48e2 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -223,7 +223,7 @@ static void afs_fetch_data_notify(struct afs_operation=
 *op)
 =

 	if (subreq) {
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-		netfs_subreq_terminated(subreq, error ?: req->actual_len);
+		netfs_subreq_terminated(subreq, error ?: req->actual_len, false);
 		req->subreq =3D NULL;
 	} else if (req->done) {
 		req->done(req);
@@ -289,7 +289,7 @@ static void afs_req_issue_op(struct netfs_read_subrequ=
est *subreq)
 =

 	fsreq =3D afs_alloc_read(GFP_NOFS);
 	if (!fsreq)
-		return netfs_subreq_terminated(subreq, -ENOMEM);
+		return netfs_subreq_terminated(subreq, -ENOMEM, false);
 =

 	fsreq->subreq	=3D subreq;
 	fsreq->pos	=3D subreq->start + subreq->transferred;
@@ -304,7 +304,7 @@ static void afs_req_issue_op(struct netfs_read_subrequ=
est *subreq)
 =

 	ret =3D afs_fetch_data(fsreq->vnode, fsreq);
 	if (ret < 0)
-		return netfs_subreq_terminated(subreq, ret);
+		return netfs_subreq_terminated(subreq, ret, false);
 }
 =

 static int afs_symlink_readpage(struct page *page)
diff --git a/fs/cachefiles/rdwr2.c b/fs/cachefiles/rdwr2.c
index 4cea5a2a2d6e..40668bfe6688 100644
--- a/fs/cachefiles/rdwr2.c
+++ b/fs/cachefiles/rdwr2.c
@@ -23,6 +23,7 @@ struct cachefiles_kiocb {
 	};
 	netfs_io_terminated_t	term_func;
 	void			*term_func_priv;
+	bool			was_async;
 };
 =

 static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
@@ -43,10 +44,9 @@ static void cachefiles_read_complete(struct kiocb *iocb=
, long ret, long ret2)
 	_enter("%ld,%ld", ret, ret2);
 =

 	if (ki->term_func) {
-		if (ret < 0)
-			ki->term_func(ki->term_func_priv, ret);
-		else
-			ki->term_func(ki->term_func_priv, ki->skipped + ret);
+		if (ret >=3D 0)
+			ret +=3D ki->skipped;
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
 	}
 =

 	cachefiles_put_kiocb(ki);
@@ -114,6 +114,7 @@ static int cachefiles_read(struct netfs_cache_resource=
s *cres,
 	ki->skipped		=3D skipped;
 	ki->term_func		=3D term_func;
 	ki->term_func_priv	=3D term_func_priv;
+	ki->was_async		=3D true;
 =

 	if (ki->term_func)
 		ki->iocb.ki_complete =3D cachefiles_read_complete;
@@ -141,6 +142,7 @@ static int cachefiles_read(struct netfs_cache_resource=
s *cres,
 		ret =3D -EINTR;
 		fallthrough;
 	default:
+		ki->was_async =3D false;
 		cachefiles_read_complete(&ki->iocb, ret, 0);
 		if (ret > 0)
 			ret =3D 0;
@@ -156,7 +158,7 @@ static int cachefiles_read(struct netfs_cache_resource=
s *cres,
 	kfree(ki);
 presubmission_error:
 	if (term_func)
-		term_func(term_func_priv, ret < 0 ? ret : skipped);
+		term_func(term_func_priv, ret < 0 ? ret : skipped, false);
 	return ret;
 }
 =

@@ -175,7 +177,7 @@ static void cachefiles_write_complete(struct kiocb *io=
cb, long ret, long ret2)
 	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
 =

 	if (ki->term_func)
-		ki->term_func(ki->term_func_priv, ret);
+		ki->term_func(ki->term_func_priv, ret, ki->was_async);
 =

 	cachefiles_put_kiocb(ki);
 }
@@ -214,6 +216,7 @@ static int cachefiles_write(struct netfs_cache_resourc=
es *cres,
 	ki->len			=3D len;
 	ki->term_func		=3D term_func;
 	ki->term_func_priv	=3D term_func_priv;
+	ki->was_async		=3D true;
 =

 	if (ki->term_func)
 		ki->iocb.ki_complete =3D cachefiles_write_complete;
@@ -250,6 +253,7 @@ static int cachefiles_write(struct netfs_cache_resourc=
es *cres,
 		ret =3D -EINTR;
 		/* Fall through */
 	default:
+		ki->was_async =3D false;
 		cachefiles_write_complete(&ki->iocb, ret, 0);
 		if (ret > 0)
 			ret =3D 0;
@@ -265,7 +269,7 @@ static int cachefiles_write(struct netfs_cache_resourc=
es *cres,
 	kfree(ki);
 presubmission_error:
 	if (term_func)
-		term_func(term_func_priv, -ENOMEM);
+		term_func(term_func_priv, -ENOMEM, false);
 	return -ENOMEM;
 }
 =

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0dd64d31eff6..dcfd805d168e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -221,7 +221,7 @@ static void finish_netfs_read(struct ceph_osd_request =
*req)
 	if (err >=3D 0 && err < subreq->len)
 		__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
 =

-	netfs_subreq_terminated(subreq, err);
+	netfs_subreq_terminated(subreq, err, true);
 =

 	num_pages =3D calc_pages_for(osd_data->alignment, osd_data->length);
 	ceph_put_page_vector(osd_data->pages, num_pages, false);
@@ -276,7 +276,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subr=
equest *subreq)
 out:
 	ceph_osdc_put_request(req);
 	if (err)
-		netfs_subreq_terminated(subreq, err);
+		netfs_subreq_terminated(subreq, err, false);
 	dout("%s: result %d\n", __func__, err);
 }
 =

diff --git a/fs/netfs/read_helper.c b/fs/netfs/read_helper.c
index 9191a3617d91..5f5de8278499 100644
--- a/fs/netfs/read_helper.c
+++ b/fs/netfs/read_helper.c
@@ -29,12 +29,13 @@ module_param_named(debug, netfs_debug, uint, S_IWUSR |=
 S_IRUGO);
 MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
 =

 static void netfs_rreq_work(struct work_struct *);
-static void __netfs_put_subrequest(struct netfs_read_subrequest *);
+static void __netfs_put_subrequest(struct netfs_read_subrequest *, bool);
 =

-static void netfs_put_subrequest(struct netfs_read_subrequest *subreq)
+static void netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+				 bool was_async)
 {
 	if (refcount_dec_and_test(&subreq->usage))
-		__netfs_put_subrequest(subreq);
+		__netfs_put_subrequest(subreq, was_async);
 }
 =

 static struct netfs_read_request *netfs_alloc_read_request(
@@ -67,7 +68,8 @@ static void netfs_get_read_request(struct netfs_read_req=
uest *rreq)
 	refcount_inc(&rreq->usage);
 }
 =

-static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq)
+static void netfs_rreq_clear_subreqs(struct netfs_read_request *rreq,
+				     bool was_async)
 {
 	struct netfs_read_subrequest *subreq;
 =

@@ -75,7 +77,7 @@ static void netfs_rreq_clear_subreqs(struct netfs_read_r=
equest *rreq)
 		subreq =3D list_first_entry(&rreq->subrequests,
 					  struct netfs_read_subrequest, rreq_link);
 		list_del(&subreq->rreq_link);
-		netfs_put_subrequest(subreq);
+		netfs_put_subrequest(subreq, was_async);
 	}
 }
 =

@@ -83,7 +85,7 @@ static void netfs_free_read_request(struct work_struct *=
work)
 {
 	struct netfs_read_request *rreq =3D
 		container_of(work, struct netfs_read_request, work);
-	netfs_rreq_clear_subreqs(rreq);
+	netfs_rreq_clear_subreqs(rreq, false);
 	if (rreq->netfs_priv)
 		rreq->netfs_ops->cleanup(rreq->mapping, rreq->netfs_priv);
 	trace_netfs_rreq(rreq, netfs_rreq_trace_free);
@@ -93,10 +95,10 @@ static void netfs_free_read_request(struct work_struct=
 *work)
 	netfs_stat_d(&netfs_n_rh_rreq);
 }
 =

-static void netfs_put_read_request(struct netfs_read_request *rreq)
+static void netfs_put_read_request(struct netfs_read_request *rreq, bool =
was_async)
 {
 	if (refcount_dec_and_test(&rreq->usage)) {
-		if (in_softirq()) {
+		if (was_async) {
 			rreq->work.func =3D netfs_free_read_request;
 			if (!queue_work(system_unbound_wq, &rreq->work))
 				BUG();
@@ -131,12 +133,15 @@ static void netfs_get_read_subrequest(struct netfs_r=
ead_subrequest *subreq)
 	refcount_inc(&subreq->usage);
 }
 =

-static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq)
+static void __netfs_put_subrequest(struct netfs_read_subrequest *subreq,
+				   bool was_async)
 {
+	struct netfs_read_request *rreq =3D subreq->rreq;
+
 	trace_netfs_sreq(subreq, netfs_sreq_trace_free);
-	netfs_put_read_request(subreq->rreq);
 	kfree(subreq);
 	netfs_stat_d(&netfs_n_rh_sreq);
+	netfs_put_read_request(rreq, was_async);
 }
 =

 /*
@@ -152,11 +157,12 @@ static void netfs_clear_unread(struct netfs_read_sub=
request *subreq)
 	iov_iter_zero(iov_iter_count(&iter), &iter);
 }
 =

-static void netfs_cache_read_terminated(void *priv, ssize_t transferred_o=
r_error)
+static void netfs_cache_read_terminated(void *priv, ssize_t transferred_o=
r_error,
+					bool was_async)
 {
 	struct netfs_read_subrequest *subreq =3D priv;
 =

-	netfs_subreq_terminated(subreq, transferred_or_error);
+	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
 }
 =

 /*
@@ -186,7 +192,7 @@ static void netfs_fill_with_zeroes(struct netfs_read_r=
equest *rreq,
 {
 	netfs_stat(&netfs_n_rh_zero);
 	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	netfs_subreq_terminated(subreq, 0);
+	netfs_subreq_terminated(subreq, 0, false);
 }
 =

 /*
@@ -215,11 +221,11 @@ static void netfs_read_from_server(struct netfs_read=
_request *rreq,
 /*
  * Release those waiting.
  */
-static void netfs_rreq_completed(struct netfs_read_request *rreq)
+static void netfs_rreq_completed(struct netfs_read_request *rreq, bool wa=
s_async)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
-	netfs_rreq_clear_subreqs(rreq);
-	netfs_put_read_request(rreq);
+	netfs_rreq_clear_subreqs(rreq, was_async);
+	netfs_put_read_request(rreq, was_async);
 }
 =

 /*
@@ -228,7 +234,8 @@ static void netfs_rreq_completed(struct netfs_read_req=
uest *rreq)
  *
  * May be called in softirq mode and we inherit a ref from the caller.
  */
-static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq=
)
+static void netfs_rreq_unmark_after_write(struct netfs_read_request *rreq=
,
+					  bool was_async)
 {
 	struct netfs_read_subrequest *subreq;
 	struct pagevec pvec;
@@ -258,10 +265,11 @@ static void netfs_rreq_unmark_after_write(struct net=
fs_read_request *rreq)
 	}
 =

 	rcu_read_unlock();
-	netfs_rreq_completed(rreq);
+	netfs_rreq_completed(rreq, was_async);
 }
 =

-static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or=
_error)
+static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or=
_error,
+				       bool was_async)
 {
 	struct netfs_read_subrequest *subreq =3D priv;
 	struct netfs_read_request *rreq =3D subreq->rreq;
@@ -278,9 +286,9 @@ static void netfs_rreq_copy_terminated(void *priv, ssi=
ze_t transferred_or_error)
 =

 	/* If we decrement nr_wr_ops to 0, the ref belongs to us. */
 	if (atomic_dec_and_test(&rreq->nr_wr_ops))
-		netfs_rreq_unmark_after_write(rreq);
+		netfs_rreq_unmark_after_write(rreq, was_async);
 =

-	netfs_put_subrequest(subreq);
+	netfs_put_subrequest(subreq, was_async);
 }
 =

 /*
@@ -304,7 +312,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_=
read_request *rreq)
 	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
 		if (!test_bit(NETFS_SREQ_WRITE_TO_CACHE, &subreq->flags)) {
 			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq);
+			netfs_put_subrequest(subreq, false);
 		}
 	}
 =

@@ -324,7 +332,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_=
read_request *rreq)
 			subreq->len +=3D next->len;
 			subreq->len =3D round_up(subreq->len, PAGE_SIZE);
 			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next);
+			netfs_put_subrequest(next, false);
 		}
 =

 		iov_iter_xarray(&iter, WRITE, &rreq->mapping->i_pages,
@@ -340,7 +348,7 @@ static void netfs_rreq_do_write_to_cache(struct netfs_=
read_request *rreq)
 =

 	/* If we decrement nr_wr_ops to 0, the usage ref belongs to us. */
 	if (atomic_dec_and_test(&rreq->nr_wr_ops))
-		netfs_rreq_unmark_after_write(rreq);
+		netfs_rreq_unmark_after_write(rreq, false);
 }
 =

 static void netfs_rreq_write_to_cache_work(struct work_struct *work)
@@ -351,9 +359,10 @@ static void netfs_rreq_write_to_cache_work(struct wor=
k_struct *work)
 	netfs_rreq_do_write_to_cache(rreq);
 }
 =

-static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq)
+static void netfs_rreq_write_to_cache(struct netfs_read_request *rreq,
+				      bool was_async)
 {
-	if (in_softirq()) {
+	if (was_async) {
 		rreq->work.func =3D netfs_rreq_write_to_cache_work;
 		if (!queue_work(system_unbound_wq, &rreq->work))
 			BUG();
@@ -479,7 +488,7 @@ static bool netfs_rreq_perform_resubmissions(struct ne=
tfs_read_request *rreq)
 {
 	struct netfs_read_subrequest *subreq;
 =

-	WARN_ON(in_softirq());
+	WARN_ON(in_interrupt());
 =

 	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
 =

@@ -538,7 +547,7 @@ static void netfs_rreq_is_still_valid(struct netfs_rea=
d_request *rreq)
  * Note that we could be in an ordinary kernel thread, on a workqueue or =
in
  * softirq context at this point.  We inherit a ref from the caller.
  */
-static void netfs_rreq_assess(struct netfs_read_request *rreq)
+static void netfs_rreq_assess(struct netfs_read_request *rreq, bool was_a=
sync)
 {
 	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
 =

@@ -558,30 +567,31 @@ static void netfs_rreq_assess(struct netfs_read_requ=
est *rreq)
 	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
 =

 	if (test_bit(NETFS_RREQ_WRITE_TO_CACHE, &rreq->flags))
-		return netfs_rreq_write_to_cache(rreq);
+		return netfs_rreq_write_to_cache(rreq, was_async);
 =

-	netfs_rreq_completed(rreq);
+	netfs_rreq_completed(rreq, was_async);
 }
 =

 static void netfs_rreq_work(struct work_struct *work)
 {
 	struct netfs_read_request *rreq =3D
 		container_of(work, struct netfs_read_request, work);
-	netfs_rreq_assess(rreq);
+	netfs_rreq_assess(rreq, false);
 }
 =

 /*
  * Handle the completion of all outstanding I/O operations on a read requ=
est.
  * We inherit a ref from the caller.
  */
-static void netfs_rreq_terminated(struct netfs_read_request *rreq)
+static void netfs_rreq_terminated(struct netfs_read_request *rreq,
+				  bool was_async)
 {
 	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
-	    in_softirq()) {
+	    was_async) {
 		if (!queue_work(system_unbound_wq, &rreq->work))
 			BUG();
 	} else {
-		netfs_rreq_assess(rreq);
+		netfs_rreq_assess(rreq, was_async);
 	}
 }
 =

@@ -589,6 +599,7 @@ static void netfs_rreq_terminated(struct netfs_read_re=
quest *rreq)
  * netfs_subreq_terminated - Note the termination of an I/O operation.
  * @subreq: The I/O request that has terminated.
  * @transferred_or_error: The amount of data transferred or an error code=
.
+ * @was_async: The termination was asynchronous
  *
  * This tells the read helper that a contributory I/O operation has termi=
nated,
  * one way or another, and that it should integrate the results.
@@ -599,11 +610,12 @@ static void netfs_rreq_terminated(struct netfs_read_=
request *rreq)
  * error code.  The helper will look after reissuing I/O operations as
  * appropriate and writing downloaded data to the cache.
  *
- * This may be called from a softirq handler, so we want to avoid taking =
the
- * spinlock if we can.
+ * If @was_async is true, the caller might be running in softirq or inter=
rupt
+ * context and we can't sleep.
  */
 void netfs_subreq_terminated(struct netfs_read_subrequest *subreq,
-			     ssize_t transferred_or_error)
+			     ssize_t transferred_or_error,
+			     bool was_async)
 {
 	struct netfs_read_request *rreq =3D subreq->rreq;
 	int u;
@@ -647,11 +659,11 @@ void netfs_subreq_terminated(struct netfs_read_subre=
quest *subreq,
 	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
 	u =3D atomic_dec_return(&rreq->nr_rd_ops);
 	if (u =3D=3D 0)
-		netfs_rreq_terminated(rreq);
+		netfs_rreq_terminated(rreq, was_async);
 	else if (u =3D=3D 1)
 		wake_up_var(&rreq->nr_rd_ops);
 =

-	netfs_put_subrequest(subreq);
+	netfs_put_subrequest(subreq, was_async);
 	return;
 =

 incomplete:
@@ -796,7 +808,7 @@ static bool netfs_rreq_submit_slice(struct netfs_read_=
request *rreq,
 =

 subreq_failed:
 	rreq->error =3D subreq->error;
-	netfs_put_subrequest(subreq);
+	netfs_put_subrequest(subreq, false);
 	return false;
 }
 =

@@ -901,7 +913,7 @@ void netfs_readahead(struct readahead_control *ractl,
 	} while (rreq->submitted < rreq->len);
 =

 	if (rreq->submitted =3D=3D 0) {
-		netfs_put_read_request(rreq);
+		netfs_put_read_request(rreq, false);
 		return;
 	}
 =

@@ -913,11 +925,11 @@ void netfs_readahead(struct readahead_control *ractl=
,
 =

 	/* If we decrement nr_rd_ops to 0, the ref belongs to us. */
 	if (atomic_dec_and_test(&rreq->nr_rd_ops))
-		netfs_rreq_assess(rreq);
+		netfs_rreq_assess(rreq, false);
 	return;
 =

 cleanup_free:
-	netfs_put_read_request(rreq);
+	netfs_put_read_request(rreq, false);
 	return;
 cleanup:
 	if (netfs_priv)
@@ -991,14 +1003,14 @@ int netfs_readpage(struct file *file,
 	 */
 	do {
 		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) =3D=3D 1=
);
-		netfs_rreq_assess(rreq);
+		netfs_rreq_assess(rreq, false);
 	} while (test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags));
 =

 	ret =3D rreq->error;
 	if (ret =3D=3D 0 && rreq->submitted < rreq->len)
 		ret =3D -EIO;
 out:
-	netfs_put_read_request(rreq);
+	netfs_put_read_request(rreq, false);
 	return ret;
 }
 EXPORT_SYMBOL(netfs_readpage);
@@ -1136,7 +1148,7 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 	 */
 	for (;;) {
 		wait_var_event(&rreq->nr_rd_ops, atomic_read(&rreq->nr_rd_ops) =3D=3D 1=
);
-		netfs_rreq_assess(rreq);
+		netfs_rreq_assess(rreq, false);
 		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
 			break;
 		cond_resched();
@@ -1145,7 +1157,7 @@ int netfs_write_begin(struct file *file, struct addr=
ess_space *mapping,
 	ret =3D rreq->error;
 	if (ret =3D=3D 0 && rreq->submitted < rreq->len)
 		ret =3D -EIO;
-	netfs_put_read_request(rreq);
+	netfs_put_read_request(rreq, false);
 	if (ret < 0)
 		goto error;
 =

diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index b2589b39feb8..c22b64db237d 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -60,7 +60,8 @@ enum netfs_read_source {
 	NETFS_INVALID_READ,
 } __mode(byte);
 =

-typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_=
error);
+typedef void (*netfs_io_terminated_t)(void *priv, ssize_t transferred_or_=
error,
+				      bool was_async);
 =

 /*
  * Resources required to do operations on a cache.
@@ -189,7 +190,7 @@ extern int netfs_write_begin(struct file *, struct add=
ress_space *,
 			     const struct netfs_read_request_ops *,
 			     void *);
 =

-extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize=
_t);
+extern void netfs_subreq_terminated(struct netfs_read_subrequest *, ssize=
_t, bool);
 extern void netfs_stats_show(struct seq_file *);
 =

 #endif /* _LINUX_NETFS_H */

