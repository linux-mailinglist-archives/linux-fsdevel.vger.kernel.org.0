Return-Path: <linux-fsdevel+bounces-59306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52904B3729C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB65166005
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE393371E88;
	Tue, 26 Aug 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auGkwzL+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C62F6597
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234322; cv=none; b=H6QUHTb285VwhpDTq1ayyFOH+lyN4+flOC1id5p1wBRyQpN5Phfuu6UMRJ8mzM4Nxpy/a27sAzl6W+Pmd/c26RJdfHNAVS/glARCKMt4YlMt7OEaypkQAPVU2fLH5s5onaPO6BBmHiyS9BTrhj0psaXxoSfyZVtut9QRbi8V+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234322; c=relaxed/simple;
	bh=p8211bDUpL3KQrBAknmHSYaZpquCVjiY4Kfbbv9Urdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUOq06wUwFtqF91zQuRo7viK7y85Hgq3ZZZgLFGMHdduIeDkUKgO1I5niEIa6jZGCbLqQ7z06QLo3FVz3RIlI4WtLTGE7n7Y9/cNyVo+50eGdonLNghT5gOym9+PyzbmbakBPng0pnWThzJpWLf7oPiH3HCJQEfLFGJsm5i6wYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auGkwzL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC909C4CEF1;
	Tue, 26 Aug 2025 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234321;
	bh=p8211bDUpL3KQrBAknmHSYaZpquCVjiY4Kfbbv9Urdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auGkwzL+HUsjdSDx0zuC+pDuGL2r3/0JI8RWG+BGBKjy5eMDyoFPNQ3sh71e95YGB
	 8HVvazAfwVMSSdwAAmpUcNCcg5TiBUhrNL0txjlqAm3Ri8PZbhhuWYNN+W2ZGpUmLI
	 uzhlvMRKGAHTtpAvrg/OUDan6bvCxbM18MrjqgdZHWzUWmXDspu0KqvudvW8mvgQIy
	 i7Mxhe4FEYTZIErn+jhtcJJ8jB94+IB/hERo1jkeOb5yIuVe0dmUy/KrUfNVWeqegg
	 1QzV0mOGVoVW4yQoOUNcqFI8TZbAztSfJF/lbt9EH8TzBNIuwM8Dewning2pky5Jgi
	 d8Fk3lGkUjmkA==
Date: Tue, 26 Aug 2025 11:52:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/7] fuse: capture the unique id of fuse commands being
 sent
Message-ID: <20250826185201.GA19809@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708609.15537.12935438672031544498.stgit@frogsfrogsfrogs>
 <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z_xLxDSJDcsdes+e=25ZGyKL4_No0b1fF_kUbDfB6u2w@mail.gmail.com>

On Thu, Aug 21, 2025 at 05:15:50PM -0700, Joanne Koong wrote:
> On Wed, Aug 20, 2025 at 5:51 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > The fuse_request_{send,end} tracepoints capture the value of
> > req->in.h.unique in the trace output.  It would be really nice if we
> > could use this to match a request to its response for debugging and
> > latency analysis, but the call to trace_fuse_request_send occurs before
> > the unique id has been set:
> >
> > fuse_request_send:    connection 8388608 req 0 opcode 1 (FUSE_LOOKUP) len 107
> > fuse_request_end:     connection 8388608 req 6 len 16 error -2
> >
> > Move the callsites to trace_fuse_request_send to after the unique id has
> > been set, or right before we decide to cancel a request having not set
> > one.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/dev.c       |    6 +++++-
> >  fs/fuse/dev_uring.c |    8 +++++++-
> 
> I think we'll also need to do the equivalent for virtio.

Ackpth, virtio sends commands too??

Oh, yes, it does -- judging from the fuse_get_unique calls, at least
virtio_fs_send_req and maybe virtio_fs_send_forget need to add a call to
trace_fuse_request_send?

> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 6f2b277973ca7d..05d6e7779387a4 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -376,10 +376,15 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
> >         if (fiq->connected) {
> >                 if (req->in.h.opcode != FUSE_NOTIFY_REPLY)
> >                         req->in.h.unique = fuse_get_unique_locked(fiq);
> > +
> > +               /* tracepoint captures in.h.unique */
> > +               trace_fuse_request_send(req);
> > +
> >                 list_add_tail(&req->list, &fiq->pending);
> >                 fuse_dev_wake_and_unlock(fiq);
> >         } else {
> >                 spin_unlock(&fiq->lock);
> > +               trace_fuse_request_send(req);
> 
> Should this request still show up in the trace even though the request
> doesn't actually get sent to the server? imo that makes it
> misleading/confusing unless the trace also indicates -ENOTCONN.

Hrmm.  I was thinking that it would be very nice to have
fuse_request_{send,end} bracket the start and end of a fuse request,
even if we kill it immediately.

OTOH from a tracing "efficiency" perspective it's probably ok for
never-sent requests only to ever hit the fuse_request_end tracepoint
since the id will not get reused for quite some time.

<shrug> Thoughts?

--D

> >                 req->out.h.error = -ENOTCONN;
> >                 clear_bit(FR_PENDING, &req->flags);
> >                 fuse_request_end(req);
> > @@ -398,7 +403,6 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
> >         req->in.h.len = sizeof(struct fuse_in_header) +
> >                 fuse_len_args(req->args->in_numargs,
> >                               (struct fuse_arg *) req->args->in_args);
> > -       trace_fuse_request_send(req);
> >         fiq->ops->send_req(fiq, req);
> >  }
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 249b210becb1cc..14f263d4419392 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -7,6 +7,7 @@
> >  #include "fuse_i.h"
> >  #include "dev_uring_i.h"
> >  #include "fuse_dev_i.h"
> > +#include "fuse_trace.h"
> >
> >  #include <linux/fs.h>
> >  #include <linux/io_uring/cmd.h>
> > @@ -1265,12 +1266,17 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
> >
> >         err = -EINVAL;
> >         queue = fuse_uring_task_to_queue(ring);
> > -       if (!queue)
> > +       if (!queue) {
> > +               trace_fuse_request_send(req);
> 
> Same question here.
> 
> Thanks,
> Joanne
> 

