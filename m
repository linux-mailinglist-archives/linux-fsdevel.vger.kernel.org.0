Return-Path: <linux-fsdevel+bounces-64649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D112CBEFE11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11B6C3B4642
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 08:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535EB2E9EA7;
	Mon, 20 Oct 2025 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lckka8uC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F8238D32
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948272; cv=none; b=XATDcrxKczIGXaWN6rxEEk2GGDvvgYdlat+CcuMxOeGuBxZuOLeFvL8JXcb5xjmuT1jgR4EWUdHwlARWUUJ/pRIWLz+4hsWe9WyWzUlmlpkr6dRbrpbsU5r6Hs6XG+cShpR/i9HhbmStRc4AY6se5tQv7wB4Hg9ew3yFSmyJjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948272; c=relaxed/simple;
	bh=wXy4bXJunpzIasDOg3VAyqbdjQMBGQKs1Uuhvlmw2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb9wtzb9ejMDQv4LxsSAruRqn95Jf7GCGTFZt+FwHf8dl+jIVGt4H859nhcDGSazWP8SzVkfit2EZi+fPq7Yfx5sGI+XDhVah1XNeMWGGiZchYpSn00MiBRxka/P41RtI5wQSKxUNOGB+BujPtRoKckZbcn6ZnJwWkH/ohoW8u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lckka8uC; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45F213F2A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1760948257;
	bh=86s/ouX70lGh09yGTchrSOA+sttK8bLG5RFqPHU+grU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=lckka8uC5/C7LYwV7SVbvHsEgjH/uPeh9ihbaWb2s+RKU7SaR2B/MVLDEXXYp7ag3
	 SDuGwfJehb6a9u8xCWe4e/f11lMaVVrbaTISyvpVReuY5e5cW7Zw4N/SGMUnnN7zlI
	 5DqPSq4SfFT4/51du+4UNjkweSXl9FYiITCysN8MCq1ZsRSxUSWUN3mGTF5R1Qk0Rd
	 4ms1ukZe4UuqW/j9I6f4gqa4pL3T26aIsgLActJEH2sSVNRe8+f+IeK0qcXMBAV52w
	 vLJ32J0gkRYB4L3eD4wepFvXYzVX+Al8L1jYgKNQRDXPyF7rSIdmhJ0rjTTXIhgr/M
	 dnQGGZwpkxKFAd8klYp37b7OXiO2WDrTyl6XvR80xd9a0wJf8Femv2h+mnuMON6dev
	 GcATyamXpm2MEmMuF7syD3AxHee0j1yACHrP2ajRcqOYkokE1IGxswCPFXSL8R8tn2
	 0ZM+v0ZnAqWzOG9jT4dDqzgSEf/lnFzBD3H4FdzCXrTXpDApP1pZQNcGsbn2OvXGMy
	 2fwklvfr9Pz2GpzqJB0DHyHGQbuyz+uyYRb44EMR0nWjLU0+phVs95f8AYKmfnACuk
	 41aRBt86rAT479okXxdLGIPZxGrTQl2hAcnElp0czxfmwo+6j5LSadoAYmQ2TzMSIf
	 uaaKUBVOK7WlaUd7H9t2Sgc0=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b5fc7164eb5so38476266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 01:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948257; x=1761553057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86s/ouX70lGh09yGTchrSOA+sttK8bLG5RFqPHU+grU=;
        b=OeyTJ1R/pe1GvKB/Usz8O6ZBmkzD6wlp8KlAes4Otva29w0JCleB+aibvX+tIyLQ1C
         7Vq/VrSH8TbNeAR4m7vmH1ZtUSH6Gc1VhUdJmf0LvksHt71ElK+bjH/3DkkIV0bjhUzn
         s8fQPK+nRdyYHaVD91fXIF18HMjvZz1RhhIICKEKgr43oKA4mHEeUy204/FEbY7cXb8f
         OnsXwtK7VM0cZRZEAS9ThTzPWtnz/c+pT8mEHbxpWkVkVMzMP9LKizzedtDZdni0tH8X
         fnikjhoXpE30Zz6ms/2xRbHX6nPInuEfu5G73IhkSbJgevKIvJrDVu55w9A9nR3DAHfl
         7ZAg==
X-Forwarded-Encrypted: i=1; AJvYcCXkS068CpEfKax97JIx11RubnqSsrPJ6lAyOUaWx7O7bAALJC03VlUWY1NJxpJFkXbEEsU0RnZLS/1MkDgM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsw8E28O2PKPfSw9kBhysxUT0E/JJ2V8kBiT/SmquOzsDaKVIi
	jZFQnfo0WNxZnl0BY8Gs1VX41lyEHaLBVv8/YiVNftI200fg3jHEBlVHal9SbtfDuv62TR4yWiO
	DD1rTFXgBEjJe3b2g/IeDWEcbSCipuNGbLAx6SmvT/k96IB1F9Osmpz043rjiRtnnDVvDwKL72B
	4qR4kWwLs=
X-Gm-Gg: ASbGncvS39gB/iz32SCPhc0ukSYPT9TBjTcCawDj4a3K498uZos3o7fMWlW0Ldkt/yQ
	QTcZYJst8u/J9v69LTxKzW6gxv+//yIyBJJTz+Pl/rlfdzI7Iaz2Vlma377vRWqCVaeKHsxLIFx
	uA43OxY2sGEiV1iq75Lg9mVE7F+JlD3bAurIcIL73lLPmtpmfXwunnBeoOOVTzZmSba1p1rJnU1
	fHvroHRTbH1f+DD+Doc5Q2/TI7SNtpLE46qPlIi6M/ssUVVMw6rlJdRp0T73Na2Xks8MuPGHFe8
	pC8OQoGAoDtXOGw7ZPfuMIJRzFXWsoblKV7PRDJWqAT2ptr4KSt0N96TVl/E463qEf3T0Wrk7c+
	9vlfLCFbpiHC24HAovvVBmTgK25llHyqm8AFd43OcQN5GkXTyGE16pY6fWk1RuGwNVa6Ryg==
X-Received: by 2002:a17:906:c103:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b645f7eadb3mr1492687566b.29.1760948256692;
        Mon, 20 Oct 2025 01:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzMhah7EzxZDwqCkpyVoP2s7DftxVySjWiXzqQzD3h14y1yWqq3TgY1JjMBhazxQtyPqZDfw==
X-Received: by 2002:a17:906:c103:b0:b50:9f92:fde0 with SMTP id a640c23a62f3a-b645f7eadb3mr1492684666b.29.1760948256237;
        Mon, 20 Oct 2025 01:17:36 -0700 (PDT)
Received: from localhost (net-2-34-30-56.cust.vodafonedsl.it. [2.34.30.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebf49fd8sm727774666b.83.2025.10.20.01.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:17:35 -0700 (PDT)
From: Alessio Faina <alessio.faina@canonical.com>
To: kernel-esm-reviews@groups.canonical.com
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [SRU][B][PATCH 1/1] afs: Fix lock recursion
Date: Mon, 20 Oct 2025 10:17:23 +0200
Message-ID: <20251020081733.18036-2-alessio.faina@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020081733.18036-1-alessio.faina@canonical.com>
References: <20251020081733.18036-1-alessio.faina@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

afs_wake_up_async_call() can incur lock recursion.  The problem is that it
is called from AF_RXRPC whilst holding the ->notify_lock, but it tries to
take a ref on the afs_call struct in order to pass it to a work queue - but
if the afs_call is already queued, we then have an extraneous ref that must
be put... calling afs_put_call() may call back down into AF_RXRPC through
rxrpc_kernel_shutdown_call(), however, which might try taking the
->notify_lock again.

This case isn't very common, however, so defer it to a workqueue.  The oops
looks something like:

  BUG: spinlock recursion on CPU#0, krxrpcio/7001/1646
   lock: 0xffff888141399b30, .magic: dead4ead, .owner: krxrpcio/7001/1646, .owner_cpu: 0
  CPU: 0 UID: 0 PID: 1646 Comm: krxrpcio/7001 Not tainted 6.12.0-rc2-build3+ #4351
  Hardware name: ASUS All Series/H97-PLUS, BIOS 2306 10/09/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x47/0x70
   do_raw_spin_lock+0x3c/0x90
   rxrpc_kernel_shutdown_call+0x83/0xb0
   afs_put_call+0xd7/0x180
   rxrpc_notify_socket+0xa0/0x190
   rxrpc_input_split_jumbo+0x198/0x1d0
   rxrpc_input_data+0x14b/0x1e0
   ? rxrpc_input_call_packet+0xc2/0x1f0
   rxrpc_input_call_event+0xad/0x6b0
   rxrpc_input_packet_on_conn+0x1e1/0x210
   rxrpc_input_packet+0x3f2/0x4d0
   rxrpc_io_thread+0x243/0x410
   ? __pfx_rxrpc_io_thread+0x10/0x10
   kthread+0xcf/0xe0
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x24/0x40
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/1394602.1729162732@warthog.procyon.org.uk
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
(backported from commit 610a79ffea02102899a1373fe226d949944a7ed6)
[alessiofaina: removed call to rxrpc_kernel_put_peer,
substituted inexistent rxrpc_kernel_shutdown_call/rxrpc_kernel_put_call
with rxrpc_kernel_end_call,
fixed trace_afs_call first parameter
fixed afs_deferred_put_call conflict between __refcount_dec_and_test
and atomic_dec_return
fixed use of non existent afs_unuse_server_notime with previously used
afs_put_server/afs_put_cb_interest/afs_put_addrlist]
CVE-2024-53090
Signed-off-by: Alessio Faina <alessio.faina@canonical.com>
---
 fs/afs/internal.h |  2 ++
 fs/afs/rxrpc.c    | 78 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 58 insertions(+), 22 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index f564b09db87b..8552f9897578 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -84,6 +84,7 @@ struct afs_call {
 	wait_queue_head_t	waitq;		/* processes awaiting completion */
 	struct work_struct	async_work;	/* async I/O processor */
 	struct work_struct	work;		/* actual work processor */
+	struct work_struct	free_work;	/* Deferred free processor */
 	struct rxrpc_call	*rxcall;	/* RxRPC call handle */
 	struct key		*key;		/* security for this call */
 	struct afs_net		*net;		/* The network namespace */
@@ -793,6 +794,7 @@ extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
 extern int afs_queue_call_work(struct afs_call *);
 extern long afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t, bool);
+void afs_deferred_put_call(struct afs_call *call);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
 					    size_t, size_t);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 8a3ac5816ad0..03cd92cb3820 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -19,6 +19,7 @@
 
 struct workqueue_struct *afs_async_calls;
 
+static void afs_deferred_free_worker(struct work_struct *work);
 static void afs_wake_up_call_waiter(struct sock *, struct rxrpc_call *, unsigned long);
 static long afs_wait_for_call_to_complete(struct afs_call *, struct afs_addr_cursor *);
 static void afs_wake_up_async_call(struct sock *, struct rxrpc_call *, unsigned long);
@@ -140,6 +141,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	call->net = net;
 	atomic_set(&call->usage, 1);
 	INIT_WORK(&call->async_work, afs_process_async_call);
+	INIT_WORK(&call->free_work, afs_deferred_free_worker);
 	init_waitqueue_head(&call->waitq);
 	spin_lock_init(&call->state_lock);
 
@@ -149,6 +151,35 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
 	return call;
 }
 
+static void afs_free_call(struct afs_call *call)
+{
+	struct afs_net *net = call->net;
+	int o;
+
+	ASSERT(!work_pending(&call->async_work));
+	ASSERT(call->type->name != NULL);
+
+	if (call->rxcall) {
+		rxrpc_kernel_end_call(net->socket, call->rxcall);
+		call->rxcall = NULL;
+	}
+	if (call->type->destructor)
+		call->type->destructor(call);
+
+	afs_put_server(call->net, call->cm_server);
+	afs_put_cb_interest(call->net, call->cbi);
+	kfree(call->request);
+
+	o = atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(call, afs_call_trace_free, 0, o,
+		       __builtin_return_address(0));
+	kfree(call);
+
+	o = atomic_dec_return(&net->nr_outstanding_calls);
+	if (o == 0)
+		wake_up_atomic_t(&net->nr_outstanding_calls);
+}
+
 /*
  * Dispose of a reference on a call.
  */
@@ -160,30 +191,32 @@ void afs_put_call(struct afs_call *call)
 
 	trace_afs_call(call, afs_call_trace_put, n, o,
 		       __builtin_return_address(0));
+	if (o == 0)
+		afs_free_call(call);
+}
 
-	ASSERTCMP(n, >=, 0);
-	if (n == 0) {
-		ASSERT(!work_pending(&call->async_work));
-		ASSERT(call->type->name != NULL);
+static void afs_deferred_free_worker(struct work_struct *work)
+{
+	struct afs_call *call = container_of(work, struct afs_call, free_work);
 
-		if (call->rxcall) {
-			rxrpc_kernel_end_call(net->socket, call->rxcall);
-			call->rxcall = NULL;
-		}
-		if (call->type->destructor)
-			call->type->destructor(call);
+	afs_free_call(call);
+}
 
-		afs_put_server(call->net, call->cm_server);
-		afs_put_cb_interest(call->net, call->cbi);
-		kfree(call->request);
-		kfree(call);
+/*
+ * Dispose of a reference on a call, deferring the cleanup to a workqueue
+ * to avoid lock recursion.
+ */
+void afs_deferred_put_call(struct afs_call *call)
+{
+	struct afs_net *net = call->net;
+	int n, o;
 
-		o = atomic_dec_return(&net->nr_outstanding_calls);
-		trace_afs_call(call, afs_call_trace_free, 0, o,
-			       __builtin_return_address(0));
-		if (o == 0)
-			wake_up_atomic_t(&net->nr_outstanding_calls);
-	}
+	n = atomic_dec_return(&call->usage);
+	o = atomic_read(&net->nr_outstanding_calls);
+	trace_afs_call(call, afs_call_trace_put, n, o,
+		       __builtin_return_address(0));
+	if (o == 0)
+		schedule_work(&call->free_work);
 }
 
 /*
@@ -636,7 +669,8 @@ static void afs_wake_up_call_waiter(struct sock *sk, struct rxrpc_call *rxcall,
 }
 
 /*
- * wake up an asynchronous call
+ * Wake up an asynchronous call.  The caller is holding the call notify
+ * spinlock around this, so we can't call afs_put_call().
  */
 static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 				   unsigned long call_user_ID)
@@ -654,7 +688,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
 			       __builtin_return_address(0));
 
 		if (!queue_work(afs_async_calls, &call->async_work))
-			afs_put_call(call);
+			afs_deferred_put_call(call);
 	}
 }
 
-- 
2.43.0


