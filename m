Return-Path: <linux-fsdevel+bounces-67736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DAC48705
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 18:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7225B1888E33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB9B2E6CC6;
	Mon, 10 Nov 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNBFueMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70248255F2D;
	Mon, 10 Nov 2025 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762797376; cv=none; b=l0w6fZnThtdBjebFrzpSOTGmKkdA7th3Q0ZgTQvVHjNUF33fGlXou8Xt+5dAHMQ5zF033aFdIZ64NB+v4nydClZYJpoCMDYydi5OnqiLvVQGzleS+cXJhDemuXD8k4KV2n+3DA/zGS0OQgbRl6H66PpFvvm5MhYfbhQHci7fLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762797376; c=relaxed/simple;
	bh=gm1qRBF5oW6n2bEVBKKR6PMqTztb7+J/zHlsLOfRBes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDxQV7RCxsFnpjhOUbZjcfyYwinVfVJZHGRTNgW6Ox++buGSTQolfaYBdICfZvMDTfchPTYgmeCT+QO3qSPyFAGSnKiwpvmucxfZYQLzG2vQZY+3krn7YulCo/k/OUNUoombIxv0EM5Jub1UEmFh4nXXEkUqiuo+oZXyZ9JG4xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNBFueMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2032C4CEFB;
	Mon, 10 Nov 2025 17:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762797376;
	bh=gm1qRBF5oW6n2bEVBKKR6PMqTztb7+J/zHlsLOfRBes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNBFueMu0WCOq1aBRzf7gokOFYgAJkcqkY01ShTMq5OGXP/5n+zkAy3597TpkFlaD
	 CVqiDqUCWed1j+VqnxawrjXfteP98NDL+MuVGOxr9XLuQ62n64WaKxYSh7t0iLJQ+O
	 FhbJgBqgHCR0vh+bxXCVw09T59l8v422Pl7fbhYu8CqyGGpSqBTZHhyinUTbF5fX00
	 Pv8JqL2lmad2SLQY470stoeg4Zm4bXNyyeaGOxfsBGSf02A5VInuPkbBzHKTH62fMf
	 kBgoMAWfgnGEffUmfWlv1j2XYJwaXPvy5qUjucL65IEsvbvAm++94O3P/r/88fxbDH
	 GHQzSayaAifTA==
Date: Mon, 10 Nov 2025 09:56:15 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the
 connection
Message-ID: <20251110175615.GY196362@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs>
 <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
 <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
 <e0b83d5f-d6b2-4383-a90f-437437d4cb75@bsbernd.com>
 <20251108000254.GK196391@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251108000254.GK196391@frogsfrogsfrogs>

On Fri, Nov 07, 2025 at 04:02:54PM -0800, Darrick J. Wong wrote:
> On Fri, Nov 07, 2025 at 11:03:24PM +0100, Bernd Schubert wrote:
> > 
> > 
> > On 11/7/25 05:26, Darrick J. Wong wrote:
> > > [I read this email backwards, like I do]
> > > 
> > > On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
> > >> On Wed, Nov 5, 2025 at 4:17 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > >>>
> > >>> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
> > >>>
> > >>> <snipping here because this thread has gotten very long>
> > >>>
> > >>>>>>> +       while (wait_event_timeout(fc->blocked_waitq,
> > >>>>>>> +                       !fc->connected || atomic_read(&fc->num_waiting) == 0,
> > >>>>>>> +                       HZ) == 0) {
> > >>>>>>> +               /* empty */
> > >>>>>>> +       }
> > >>>>>>
> > >>>>>> I'm wondering if it's necessary to wait here for all the pending
> > >>>>>> requests to complete or abort?
> > >>>>>
> > >>>>> I'm not 100% sure what the fuse client shutdown sequence is supposed to
> > >>>>> be.  If someone kills a program with a large number of open unlinked
> > >>>>> files and immediately calls umount(), then the fuse client could be in
> > >>>>> the process of sending FUSE_RELEASE requests to the server.
> > >>>>>
> > >>>>> [background info, feel free to speedread this paragraph]
> > >>>>> For a non-fuseblk server, unmount aborts all pending requests and
> > >>>>> disconnects the fuse device.  This means that the fuse server won't see
> > >>>>> all the FUSE_REQUESTs before libfuse calls ->destroy having observed the
> > >>>>> fusedev shutdown.  The end result is that (on fuse2fs anyway) you end up
> > >>>>> with a lot of .fuseXXXXX files that nobody cleans up.
> > >>>>>
> > >>>>> If you make ->destroy release all the remaining open files, now you run
> > >>>>> into a second problem, which is that if there are a lot of open unlinked
> > >>>>> files, freeing the inodes can collectively take enough time that the
> > >>>>> FUSE_DESTROY request times out.
> > >>>>>
> > >>>>> On a fuseblk server with libfuse running in multithreaded mode, there
> > >>>>> can be several threads reading fuse requests from the fusedev.  The
> > >>>>> kernel actually sends its own FUSE_DESTROY request, but there's no
> > >>>>> coordination between the fuse workers, which means that the fuse server
> > >>>>> can process FUSE_DESTROY at the same time it's processing FUSE_RELEASE.
> > >>>>> If ->destroy closes the filesystem before the FUSE_RELEASE requests are
> > >>>>> processed, you end up with the same .fuseXXXXX file cleanup problem.
> > >>>>
> > >>>> imo it is the responsibility of the server to coordinate this and make
> > >>>> sure it has handled all the requests it has received before it starts
> > >>>> executing the destruction logic.
> > >>>
> > >>> I think we're all saying that some sort of fuse request reordering
> > >>> barrier is needed here, but there's at least three opinions about where
> > >>> that barrier should be implemented.  Clearly I think the barrier should
> > >>> be in the kernel, but let me think more about where it could go if it
> > >>> were somewhere else.
> > >>>
> > >>> First, Joanne's suggestion for putting it in the fuse server itself:
> > >>>
> > >>> I don't see how it's generally possible for the fuse server to know that
> > >>> it's processed all the requests that the kernel might have sent it.
> > >>> AFAICT each libfuse thread does roughly this:
> > >>>
> > >>> 1. read() a request from the fusedev fd
> > >>> 2. decode the request data and maybe do some allocations or transform it
> > >>> 3. call fuse server with request
> > >>> 4. fuse server does ... something with the request
> > >>> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
> > >>>
> > >>> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
> > >>> out if there are other fuse worker threads that are somewhere in steps
> > >>> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
> > >>> that are waiting in fuse_session_receive_buf_internal, so fuse servers
> > >>> can't ask the library about that either.
> > >>>
> > >>> Taking a narrower view, it might be possible for the fuse server to
> > >>> figure this out by maintaining an open resource count.  It would
> > >>> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
> > >>> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
> > >>> the only kind of request that can be pending when a FUSE_DESTROY comes
> > >>> in, then destroy just has to wait for the counter to hit zero.
> > >>
> > >> I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
> > >> if there are X worker threads that are all running fuse_do_work( )
> > >> then if you get a FUSE_DESTROY on one of those threads that thread can
> > >> set some se->destroyed field. At this point the other threads will
> > >> have already called fuse_session_receive_buf_internal() on all the
> > >> flushed background requests, so after they process it and return from
> > >> fuse_session_process_buf_internal(), then they check if se->destroyed
> > >> was set, and if it is they exit the thread, while in the thread that
> > >> got the FUSE_DESTROY it sleeps until all the threads have completed
> > >> and then it executes the destroy logic.That to me seems like the
> > >> cleanest approach.
> > > 
> > > Hrm.  Well now (scrolling to the bottom and back) that I know that the
> > > FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
> > > think that /could/ work.
> > > 
> > > One tricky thing with having worker threads check a flag and exit is
> > > that they can be sleeping in the kernel (from _fuse_session_receive_buf)
> > > when the "just go away" flag gets set.  If the thread never wakes up,
> > > then it'll never exit.  In theory you could have the FUSE_DESTROY thread
> > > call pthread_cancel on all the other worker threads to eliminate them
> > > once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
> > > nightmares from adventures in pthread_cancel at Sun in 2002. :P
> > > 
> > > Maybe an easier approach would be to have fuse_do_work increment a
> > > counter when it receives a buffer and decrement it when it finishes with
> > > that buffer.  The FUSE_DESTROY thread merely has to wait for that
> > > counter to reach 1, at which point it's the only thread with a request
> > > to process, so it can call do_destroy.  That at least would avoid adding
> > > a new user of pthread_cancel() into the mt loop code.
> > 
> > I will read through the rest (too tired right now) durig the weekend. 
> > I was also thinking about counter. And let's please also do this right
> > also handling io-uring. I.e. all CQEs needs to have been handled.
> > Without io-uring it would be probably a counter in decreased in 
> > fuse_free_req(), with io-uring it is a bit more complex.
> 
> Oh right, the uring backend.
> 
> Assuming that it's really true that the only requests pending during an
> unmount are going to be FUSE_RELEASE (nobody's actually said that's
> true) then it's *much* easier to count the number of open files in
> fuse_session and make _do_destroy in the lowlevel library wait until the
> open file count reaches zero.

FWIW I tried this out over the weekend with the patch below and the
wait_event() turned off in the kernel.  It seems to work (though I only
tried it cursorily with iouring) so if the kernel fuse developers would
rather not have a wait_event() in the unmount path then I suppose this
is a way to move ahead with this topic.

--D

From: Darrick J. Wong <djwong@kernel.org>
Subject: [PATCH] libfuse: wait in do_destroy until all open files are closed

Joanne suggests that libfuse should defer a FUSE_DESTROY request until
all FUSE_RELEASEs have completed.  Let's see if that works by tracking
the count of open files.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/fuse_i.h        |    4 ++++
 lib/fuse_lowlevel.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/lib/fuse_i.h b/lib/fuse_i.h
index 0ce2c0134ed879..dfe9d9f067498e 100644
--- a/lib/fuse_i.h
+++ b/lib/fuse_i.h
@@ -117,6 +117,10 @@ struct fuse_session {
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
index 12724ed66bdcc8..f12c6db0eb0e60 100644
--- a/lib/fuse_lowlevel.c
+++ b/lib/fuse_lowlevel.c
@@ -52,6 +52,30 @@
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
+static inline void wait_for_zero_open_files(struct fuse_session *se)
+{
+	pthread_mutex_lock(&se->lock);
+	while (se->open_files > 0)
+		pthread_cond_wait(&se->zero_open_files, &se->lock);
+	pthread_mutex_unlock(&se->lock);
+}
+
 struct fuse_pollhandle {
 	uint64_t kh;
 	struct fuse_session *se;
@@ -559,18 +583,28 @@ int fuse_reply_create_iflags(fuse_req_t req, const struct fuse_entry_param *e,
 		FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
 	struct fuse_entry_out *earg = (struct fuse_entry_out *) buf;
 	struct fuse_open_out *oarg = (struct fuse_open_out *) (buf + entrysize);
+	struct fuse_session *se = req->se;
+	int error;
 
 	memset(buf, 0, sizeof(buf));
 	fill_entry(earg, e, iflags);
 	fill_open(oarg, f);
-	return send_reply_ok(req, buf,
+	error = send_reply_ok(req, buf,
 			     entrysize + sizeof(struct fuse_open_out));
+	if (!error)
+		inc_open_files(se);
+	return error;
 }
 
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
 		      const struct fuse_file_info *f)
 {
-	return fuse_reply_create_iflags(req, e, 0, f);
+	struct fuse_session *se = req->se;
+	int error = fuse_reply_create_iflags(req, e, 0, f);
+
+	if (!error)
+		inc_open_files(se);
+	return error;
 }
 
 int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
@@ -676,10 +710,15 @@ int fuse_lowlevel_iomap_device_remove(struct fuse_session *se, int device_id)
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
@@ -1947,6 +1986,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	const struct fuse_release_in *arg = op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -1965,6 +2005,7 @@ static void _do_release(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.release(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_release(fuse_req_t req, const fuse_ino_t nodeid,
@@ -2069,6 +2110,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 {
 	(void)in_payload;
 	struct fuse_release_in *arg = (struct fuse_release_in *)op_in;
+	struct fuse_session *se = req->se;
 	struct fuse_file_info fi;
 
 	memset(&fi, 0, sizeof(fi));
@@ -2079,6 +2121,7 @@ static void _do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
 		req->se->op.releasedir(req, nodeid, &fi);
 	else
 		fuse_reply_err(req, 0);
+	dec_open_files(se);
 }
 
 static void do_releasedir(fuse_req_t req, const fuse_ino_t nodeid,
@@ -3376,6 +3419,8 @@ static void _do_destroy(fuse_req_t req, const fuse_ino_t nodeid,
 	(void)op_in;
 	(void)in_payload;
 
+	wait_for_zero_open_files(se);
+
 	mountpoint = atomic_exchange(&se->mountpoint, NULL);
 	free(mountpoint);
 
@@ -4315,6 +4360,7 @@ void fuse_session_destroy(struct fuse_session *se)
 		fuse_ll_pipe_free(llp);
 	pthread_key_delete(se->pipe_key);
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 	free(se->cuse_data);
@@ -4690,6 +4736,7 @@ fuse_session_new_versioned(struct fuse_args *args,
 	list_init_nreq(&se->notify_list);
 	se->notify_ctr = 1;
 	pthread_mutex_init(&se->lock, NULL);
+	pthread_cond_init(&se->zero_open_files, NULL);
 	sem_init(&se->mt_finish, 0, 0);
 	pthread_mutex_init(&se->mt_lock, NULL);
 
@@ -4717,6 +4764,7 @@ fuse_session_new_versioned(struct fuse_args *args,
 
 out5:
 	sem_destroy(&se->mt_finish);
+	pthread_cond_destroy(&se->zero_open_files);
 	pthread_mutex_destroy(&se->mt_lock);
 	pthread_mutex_destroy(&se->lock);
 out4:

