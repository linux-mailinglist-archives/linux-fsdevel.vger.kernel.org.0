Return-Path: <linux-fsdevel+bounces-26512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45095A404
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F691B21005
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1891B2ED2;
	Wed, 21 Aug 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJq2pS0+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21D0152199
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 17:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724261920; cv=none; b=ao3DSl7GqS4upki0VMYSiXpJiTXSCbCoWShledJfIpYlcQCtVjpZrJmpbNSY+46Q0z+8CUZyQ+h3LQLJ0vs+UxR4j5ou4bjLOhq/6RP6oogSaD12WtoOJ1oKg7i2aGZHTS+mgHHjsryWweEs/S3OwNYLS1cR+oy8Vny6jFpwTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724261920; c=relaxed/simple;
	bh=AhMZ+uQ1BV1xhGz6UcmZZfRH+tXgklsPayiRRouO2p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRT+HjJERO2cqFJFi8fVgjfVlM5GMbk0YPM8yM6b1gj0+Plwp23VpAhoGe3vlkvdx/lnIqHsyq9f+bEJ0ZCE6YVlBCS2BBAzfSbfs5tQZLNdwfPQ6S94jrItcKAwfa6en/ChOjlqHBf/Wa9TnhMmwqSRuYvD5kjcJWORtJ5IeZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJq2pS0+; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7094468d392so3904429a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 10:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724261918; x=1724866718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCSIdr3XwAi8vBwKMY1j81MCcBt+9bEYHvqwuAbnhNU=;
        b=CJq2pS0+hom4gPg3g+lo+9J60SZEiDlnUyw+VW1VPkf/lPCf90kEyQsIx1GcVjWPwV
         0zlQw6WY7iqw2Of3dZTpPpH+gVIinpydsrE3nux09dyDkNjjGF0OMdc5EX6sVtoE7Brl
         /tjnXU/6XRyMHc7OlKZI3b8rwcKr1g+QU7qkrFGMUZp4y2RkSolrZ7XDBoI5cgTwHj8r
         HTRwB6T5ur/w9geOBvd7lTLDL5c+ucTLaXhYjX6p+OCgrUTT8h9tDyfVR8aaAiY0qelt
         YQpJjwgAXNn3OebhyqWw3mgnGg8WWH9CUT4GeGl9nk4y3siPq2vs0eHmAqi1EgHBjbx1
         TaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724261918; x=1724866718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iCSIdr3XwAi8vBwKMY1j81MCcBt+9bEYHvqwuAbnhNU=;
        b=vLV8mZt+ZXZzHHYBt7pgV53V38UGDE09i3zt2LjFVAY2W8b8j1sbe7kEVjN3hXXM7o
         h8JVBLTTELAHSM5wcKSjBs11v3ztNOik9XFi8lRtaK4XEI4VX9ol43LXlYp3I2cpJuyB
         iVCRk92eeJ+2RUDOBfsvspeu9Oay6CY2vYKYinpZE4RdNKPBYxQ/uorFoiSZasM4/Hbs
         CCeUNRxFJ2x731r2XfdlQLPu+EcFVxaW0GHTOGoSd5zPE5z0dZiHh6kXZQyUGnpZeN7H
         /Ux9/eZL2uenvhRDZsY3edF9EorGsFGubBgXYRF8cAmXjMHUI5/XionYRT8nSLv8xnqm
         zaWg==
X-Forwarded-Encrypted: i=1; AJvYcCUKLwcbCXg5bUc/c023XSD6QjbA7Ci8p5eZFygpObA1FnhGYoCqBRkQ3ahcTYgHzwsx+ylLg2L8M6yIqW97@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvwrAUC1HpVgFq3VkFGuBtdFKNTHYeqaGZH0xXRwhyV7iNSng
	EBJOqtGCW+U5KVziv3ChtWhVNL8dfESqRcu7TFhAcuneBz5jnS5fOTpj6VqS0V1LyBgqsw9P9i2
	WEK+kG9UdswD/K4hT5SIjkXBeqaE=
X-Google-Smtp-Source: AGHT+IFcbiHLAUvHEVm4KWJ9x42wLZXTLYA1tIQ5xX/T0s5rGsIo/6FosZLvedefNKTetOI7LNu0VOBc2XCzIDL6hD4=
X-Received: by 2002:a05:6830:6189:b0:703:5dbc:1aa9 with SMTP id
 46e09a7af769-70df87015a0mr4108023a34.13.1724261917653; Wed, 21 Aug 2024
 10:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-2-joannelkoong@gmail.com> <b6850802-1440-4e38-af90-756b656a5f78@linux.alibaba.com>
In-Reply-To: <b6850802-1440-4e38-af90-756b656a5f78@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Aug 2024 10:38:26 -0700
Message-ID: <CAJnrk1aVKY8Y0bdRoqEgBrX8q_c1E3KU9bL3-m-Cfsh6fNaqcw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fuse: add optional kernel-enforced timeout for requests
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, laoar.shao@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:56=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.=
com> wrote:
>
> Hi, Joanne,
>
> On 8/14/24 7:22 AM, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This commit adds a timeout option (in seconds) for requests. If the
> > timeout elapses before the server replies to the request, the request
> > will fail with -ETIME.
> >
> > There are 3 possibilities for a request that times out:
> > a) The request times out before the request has been sent to userspace
> > b) The request times out after the request has been sent to userspace
> > and before it receives a reply from the server
> > c) The request times out after the request has been sent to userspace
> > and the server replies while the kernel is timing out the request
> >
> > While a request timeout is being handled, there may be other handlers
> > running at the same time if:
> > a) the kernel is forwarding the request to the server
> > b) the kernel is processing the server's reply to the request
> > c) the request is being re-sent
> > d) the connection is aborting
> > e) the device is getting released
> >
> > Proper synchronization must be added to ensure that the request is
> > handled correctly in all of these cases. To this effect, there is a new
> > FR_FINISHING bit added to the request flags, which is set atomically by
> > either the timeout handler (see fuse_request_timeout()) which is invoke=
d
> > after the request timeout elapses or set by the request reply handler
> > (see dev_do_write()), whichever gets there first. If the reply handler
> > and the timeout handler are executing simultaneously and the reply hand=
ler
> > sets FR_FINISHING before the timeout handler, then the request will be
> > handled as if the timeout did not elapse. If the timeout handler sets
> > FR_FINISHING before the reply handler, then the request will fail with
> > -ETIME and the request will be cleaned up.
> >
> > Currently, this is the refcount lifecycle of a request:
> >
> > Synchronous request is created:
> > fuse_simple_request -> allocates request, sets refcount to 1
> >   __fuse_request_send -> acquires refcount
> >     queues request and waits for reply...
> > fuse_simple_request -> drops refcount
> >
> > Background request is created:
> > fuse_simple_background -> allocates request, sets refcount to 1
> >
> > Request is replied to:
> > fuse_dev_do_write
> >   fuse_request_end -> drops refcount on request
> >
> > Proper acquires on the request reference must be added to ensure that t=
he
> > timeout handler does not drop the last refcount on the request while
> > other handlers may be operating on the request. Please note that the
> > timeout handler may get invoked at any phase of the request's
> > lifetime (eg before the request has been forwarded to userspace, etc).
> >
> > It is always guaranteed that there is a refcount on the request when th=
e
> > timeout handler is executing. The timeout handler will be either
> > deactivated by the reply/abort/release handlers, or if the timeout
> > handler is concurrently executing on another CPU, the reply/abort/relea=
se
> > handlers will wait for the timeout handler to finish executing first be=
fore
> > it drops the final refcount on the request.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev.c    | 192 +++++++++++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/fuse_i.h |  14 ++++
> >  fs/fuse/inode.c  |   7 ++
> >  3 files changed, 205 insertions(+), 8 deletions(-)
>
> > @@ -1951,9 +2105,10 @@ static ssize_t fuse_dev_do_write(struct fuse_dev=
 *fud,
> >               goto copy_finish;
> >       }
> >
> > +     __fuse_get_request(req);
> > +
>
> While re-inspecting the patch, I doubt if acquiring an extra req->count
> here is really needed here.
>
> There are three conditions for concurrency between reply receiving and
> timeout handler:
>
> 1. timeout handler acquires fpq->lock first and delets the request from
> processing[] table.  In this case, fuse_dev_write() has no chance of
> accessing this request since it has previously already been removed from
> the processing[] table.  No concurrency and no extra refcount needed here=
.
>
> 2. fuse_dev_write() acquires fpq->lock first and sets FR_FINISHING.  In
> this case the timeout handler will be disactivated when seeing
> FR_FINISHING.  Also No concurrency and no extra refcount needed here.
>
> 2. fuse_dev_write() acquires fpq->lock first but timeout handler sets
> FR_FINISHING first.  In this case, fuse_dev_write() handler will return,
> leaving the request to the timeout hadler. The access to fuse_req from
> fuse_dev_write() is safe as long as fuse_dev_write() still holds
> fpq->lock, as the timeout handler may free the request only after
> acquiring and releasing fpq->lock.  Besides, as for fuse_dev_write(),
> the only operation after releasing fpq->lock is fuse_copy_finish(cs),
> which shall be safe even when the fuse_req may have been freed by the
> timeout handler (not seriously confirmed though)?
>
> Please correct me if I missed something.

Hi Jingbo,

Thanks for taking the time to reinspect this patch. I agree with your
analysis above. That all sounds right to me.
I don't remember why I added this line in v1. I think I had missed
that the fpq lock would prevent the request from being completely
freed out by the timeout handler so no extra refcount is necessary.
I'll remove this for v5.


Thanks,
Joanne

>
> >       /* Is it an interrupt reply ID? */
> >       if (oh.unique & FUSE_INT_REQ_BIT) {
> > -             __fuse_get_request(req);
> >               spin_unlock(&fpq->lock);
> >
> >               err =3D 0;
> > @@ -1969,6 +2124,18 @@ static ssize_t fuse_dev_do_write(struct fuse_dev=
 *fud,
> >               goto copy_finish;
> >       }
> >
> > +     if (test_and_set_bit(FR_FINISHING, &req->flags)) {
> > +             /* timeout handler is already finishing the request */
> > +             spin_unlock(&fpq->lock);
> > +             fuse_put_request(req);
> > +             goto copy_finish;
> > +     }
> > +
> > +     /*
> > +      * FR_FINISHING ensures the timeout handler will be a no-op if it=
 runs,
> > +      * but unset req->fpq here as an extra safeguard
> > +      */
> > +     req->fpq =3D NULL;
> >       clear_bit(FR_SENT, &req->flags);
> >       list_move(&req->list, &fpq->io);
> >       req->out.h =3D oh;
> > @@ -1995,6 +2162,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev =
*fud,
> >       spin_unlock(&fpq->lock);
> >
> >       fuse_request_end(req);
> > +     fuse_put_request(req);
> >  out:
> >       return err ? err : nbytes;
> >
>
>
> --
> Thanks,
> Jingbo

