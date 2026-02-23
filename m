Return-Path: <linux-fsdevel+bounces-78113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DAfEizinGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7617F5A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA0C1307F033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17337F8A2;
	Mon, 23 Feb 2026 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKNmNMXh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84237F73D;
	Mon, 23 Feb 2026 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889153; cv=none; b=sGokjsDCIPIlzse/SIlJO4UNsW/ICV1D0kP1+lqw7jH/IE6ZPsZ+1s0wzJJAC+P8o6F5hfB4qO14xua4/UYcL0SEMTDeAzbiOp5m+CP0DLgY12ddwLYuzX3nscfHf8+aq6jzXeN6Ac7/0N9FEpTtmz0eT46ZSabbLqIXh60SSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889153; c=relaxed/simple;
	bh=ntUsdZ3QY8ru1O5eKZYdCxgI01S6NLdqbYoHpih5P4Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOUDfl4NqHwQOGF749r2lQiQ3P7T/ShBx6yXrQCp7JuZ3Pb5CVeoWFZtc0FzKGu3mDjdFxO2Q6yhlwPcFybpZlKQO9LfHqryxrqi7wIOwMYisJ931Vpg0k7v7fO9UNUAo8EJ++LKu+YLOZkosE+lForsdvZaEO5IYC2HRFUgWZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKNmNMXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6848EC19421;
	Mon, 23 Feb 2026 23:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889153;
	bh=ntUsdZ3QY8ru1O5eKZYdCxgI01S6NLdqbYoHpih5P4Q=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=dKNmNMXhbpCVhinrRxaIQ7VeIXWauZpcoCX5ntE+KdbDEgvC+zQ79U9TJP/atG9vW
	 eGwCSd1N5RKW7iZKuh6B3tXbE4AJELIv2Cpa/j+xUyaoBu8ZIIZSGBSstOgQaeAZvL
	 zrqgE0u6g15FulSDt0lJCy0+7PQst22pzInUupAPywkMk+qLYdSNSvmkV+C6AsgZ/9
	 UrOpssNQtP7X2iQGs9T5vN1gtdGqFWy9MXtBajeWNcgJJwmYFQYjcvPqZHZcTfqMms
	 MP8yduM3TNFxy83GcRsEf3cZukfC+1J1lCd/KdrewHRYxLkQHSCBeAkjsUu+nOI4U6
	 QoRI6k6IMSWbA==
Date: Mon, 23 Feb 2026 15:25:53 -0800
Subject: [PATCH 02/25] libfuse: wait in do_destroy until all open files are
 closed
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188739974.3940670.1723787127539419788.stgit@frogsfrogsfrogs>
In-Reply-To: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
References: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78113-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEA7617F5A6
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

This patch complements the Linux kernel patch "fuse: flush pending fuse
events before aborting the connection".

This test opens a large number of files, unlinks them (which really just
renames them to fuse hidden files), closes the program, unmounts the
filesystem, and runs fsck to check that there aren't any inconsistencies
in the filesystem.

Unfortunately, the 488.full file shows that there are a lot of hidden
files left over in the filesystem, with incorrect link counts.  Tracing
fuse_request_* shows that there are a large number of FUSE_RELEASE
commands that are queued up on behalf of the unlinked files at the time
that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
aborted, the fuse server would have responded to the RELEASE commands by
removing the hidden files; instead they stick around.

For upper-level fuse servers that don't use fuseblk mode this isn't a
problem because libfuse responds to the connection going down by pruning
its inode cache and calling the fuse server's ->release for any open
files before calling the server's ->destroy function.

For fuseblk servers this is a problem, however, because the kernel sends
FUSE_DESTROY to the fuse server, and the fuse server has to write all of
its pending changes to the block device before replying to the DESTROY
request because the kernel releases its O_EXCL hold on the block device.
This means that the kernel must flush all pending FUSE_RELEASE requests
before issuing FUSE_DESTROY.

For fuse-iomap servers this will also be a problem because iomap servers
are expected to release all exclusively-held resources before unmount
returns from the kernel.

Create a function to push all the background requests to the queue
before sending FUSE_DESTROY.  That way, all the pending file release
events are processed by the fuse server before it tears itself down, and
we don't end up with a corrupt filesystem.

Note that multithreaded fuse servers will need to track the number of
open files and defer a FUSE_DESTROY request until that number reaches
zero.  An earlier version of this patch made the kernel wait for the
RELEASE acknowledgements before sending DESTROY, but the kernel people
weren't comfortable with adding blocking waits to unmount.

This patch implements the deferral for the multithreaded libfuse
backend.  However, we must implement this deferral by starting a new
background thread because libfuse in io_uring mode starts up a bunch of
threads, each of which submit batches of SQEs to request fuse commands,
and then waits for the kernel to mark some CQEs to note which slots now
have fuse commands to process.  Each uring thread processes the fuse
comands in the CQE serially, which means that _do_destroy can't just
wait for the open file counter to hit zero; it has to start a new
background thread to do that, so that it can continue to process pending
fuse commands.

[Aside: is this bad for fuse command processing latency?  Suppose we get
two CQE completions, then the second command won't even be looked at
until the first one is done.]

Non-uring fuse by contrast reads one fuse command and processes it
immediately, so one command taking a long time won't stall any other
commands.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_i.h        |    4 ++
 lib/fuse_lowlevel.c |  107 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 104 insertions(+), 7 deletions(-)


diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 65d2f68f7f3091..c7d0d38408105f 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -122,6 +122,10 @@ struct fuse_session {
 	 */
 	uint32_t conn_want;
 	uint64_t conn_want_ext;
+
+	/* destroy has to wait for all the open files to go away */
+	pthread_cond_t zero_open_files;
+	uint64_t open_files;
 };
 
 struct fuse_chan {
diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
index ac6b2fd25d24c7..c3d57f5c5b104c 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -54,6 +54,22 @@
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
 
+static inline void inc_open_files(struct fuse_session *se)
+{
+	pthread_mutex_lock(&se->lock);
+	se->open_files++;
+	pthread_mutex_unlock(&se->lock);
+}
+
+static inline void dec_open_files(struct fuse_session *se)
+{
+	pthread_mutex_lock(&se->lock);
+	se->open_files--;
+	if (!se->open_files)
+		pthread_cond_broadcast(&se->zero_open_files);
+	pthread_mutex_unlock(&se->lock);
+}
+
 struct fuse_pollhandle {
 	uint64_t kh;
 	struct fuse_session *se;
@@ -550,12 +566,17 @@ int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 		FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
 	struct fuse_entry_out *earg = (struct fuse_entry_out *) buf;
 	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
+	struct fuse_session *se = req->se;
+	int error;
 
 	memset(buf, 0, sizeof(buf));
 	fill_entry(earg, e);
 	fill_open(oarg, f);
-	return send_reply_ok(req, buf,
+	error = send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
+	if (!error)
+		inc_open_files(se);
+	return error;
 }
 
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
@@ -606,10 +627,15 @@ int fuse_passthrough_close(fuse_req_t req, int backing_id)
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
 	struct fuse_open_out arg;
+	struct fuse_session *se = req->se;
+	int error;
 
 	memset(&arg, 0, sizeof(arg));
 	fill_open(&arg, f);
-	return send_reply_ok(req, &arg, sizeof(arg));
+	error = send_reply_ok(req, &arg, sizeof(arg));
+	if (!error)
+		inc_open_files(se);
+	return error;
 }
 
 static int do_fuse_reply_write(fuse_req_t req, size_t count)
@@ -1877,6 +1903,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	const struct fuse_release_in *arg = op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -1895,6 +1922,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.release(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_release(fuse_req_t req, const fuse_ino_t nodeid,
@@ -1999,6 +2027,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	struct fuse_release_in *arg = (struct fuse_release_in *)op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -2009,6 +2038,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.releasedir(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
@@ -3027,15 +3057,21 @@ do_init(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 	_do_init(req, nodeid, inarg, NULL);
 }
 
-static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
-			const void *op_in, const void *in_payload)
+static void *__fuse_destroy_sync(void *arg)
 {
+	struct fuse_req *req = arg;
 	struct fuse_session *se = req->se;
 	char *mountpoint;
 
-	(void) nodeid;
-	(void)op_in;
-	(void)in_payload;
+	/*
+	 * Wait for all the FUSE_RELEASE requests to work their way through the
+	 * other worker threads, if any.
+	 */
+	pthread_mutex_lock(&se->lock);
+	se->open_files--;
+	while (se->open_files > 0)
+		pthread_cond_wait(&se->zero_open_files, &se->lock);
+	pthread_mutex_unlock(&se->lock);
 
 	mountpoint = atomic_exchange(&se->mountpoint, NULL);
 	free(mountpoint);
@@ -3046,6 +3082,54 @@ static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
 		se->op.destroy(se->userdata);
 
 	send_reply_ok(req, NULL, 0);
+	return NULL;
+}
+
+/*
+ * Destroy the fuse session asynchronously.
+ *
+ * If we have any open files, then we want to kick the actual destroy call to a
+ * new detached background thread that can wait for the open file count to
+ * reach zero without blocking processing of the rest of the commands that are
+ * pending in the fuse thread's cqe.  For non-uring multithreaded mode, we also
+ * use the detached thread to avoid blocking a fuse worker from processing
+ * other commands.
+ *
+ * If the kernel sends us an explicit FUSE_DESTROY command then it won't tear
+ * down the fuse fd until it receives the reply, so fuse_session_destroy
+ * doesn't need to wait for this thread.
+ */
+static int __fuse_destroy_try_async(fuse_req_t req)
+{
+	pthread_t destroy_thread;
+	pthread_attr_t destroy_attr;
+	int ret;
+
+	ret = pthread_attr_init(&destroy_attr);
+	if (ret)
+		return ret;
+
+	ret = pthread_attr_setdetachstate(&destroy_attr,
+			PTHREAD_CREATE_DETACHED);
+	if (ret)
+		return ret;
+
+	return pthread_create(&destroy_thread, &destroy_attr,
+			__fuse_destroy_sync, req);
+}
+
+static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
+			const void *op_in, const void *in_payload)
+{
+	struct fuse_session *se = req->se;
+
+	(void) nodeid;
+	(void)op_in;
+	(void)in_payload;
+
+	if (se->open_files > 0 && __fuse_destroy_try_async(req) == 0)
+		return;
+	__fuse_destroy_sync(req);
 }
 
 static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
@@ -3891,6 +3975,7 @@ void fuse_session_destroy(struct fuse_session *se)
 		fuse_ll_pipe_free(llp);
 	pthread_key_delete(se->pipe_key);
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 	free(se->cuse_data);
@@ -4275,9 +4360,16 @@ fuse_session_new_versioned(struct fuse_args *args,
 	list_init_nreq(&se->notify_list);
 	se->notify_ctr = 1;
 	pthread_mutex_init(&se->lock, NULL);
+	pthread_cond_init(&se->zero_open_files, NULL);
 	sem_init(&se->mt_finish, 0, 0);
 	pthread_mutex_init(&se->mt_lock, NULL);
 
+	/*
+	 * Bias the open file counter by 1 so that we only wake the condition
+	 * variable once FUSE_DESTROY has been seen.
+	 */
+	se->open_files = 1;
+
 	err = pthread_key_create(&se->pipe_key, fuse_ll_pipe_destructor);
 	if (err) {
 		fuse_log(FUSE_LOG_ERR, "fuse: failed to create thread specific key: %s\n",
@@ -4302,6 +4394,7 @@ fuse_session_new_versioned(struct fuse_args *args,
 
 out5:
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 out4:


