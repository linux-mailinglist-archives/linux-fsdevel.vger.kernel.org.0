Return-Path: <linux-fsdevel+bounces-65403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62098C0452B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 06:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB14E355630
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 04:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46027FD48;
	Fri, 24 Oct 2025 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWllSkIH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3127602C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761279727; cv=none; b=QM/FEin+DXGvyNXPzs7Va0g0Xe1PmWE3ZZdbAuDB/UtekeKh1w7bD2nxv7iNkWiG3//5z4yXp8LXQxNKjfO+I/PLt2iPQeDRGTgJHC2Qk/5iDBGSBTsL7+E4itwGFgciajAzRfu8qkQNA5/fc7o0nXgdOEkbD5a3c886wxomtFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761279727; c=relaxed/simple;
	bh=faIDFSrWblGzojWXds5591T0YsArkV+e0TTMP15FAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ2BhUxm+T2kYRBhJ/ySuxfBPGKcOg466466j6JaMcpIcA15YcBe6HYCdy9rt04oweKgFuYd1bHFijyTVVV+t4W2LMBDpEOjV6rDBQOswiq5wOYW8bbEf8jgGL5/8Y4x5e4TcrZ9b1iSAxtjkdr5vIaDbyPs+gTH6uwilUYcQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWllSkIH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761279724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcyH9reGqGAeYbGxR5vDfBAZeC8+dhdfp3nQT7CViH8=;
	b=ZWllSkIHztHHJeZkz8Ig9Ia5tqQPmQSB3Kwbx34VpiLjj2GcY0Ud1yCvG14gws+FK4DYhp
	6t4jVFBxhhYt5r0GhkzHbD22tiXBbIhcPl47H3kQfElcKtM+vjQ6a0EDWp6KKvbdV600MS
	IOallOZUeZh4M5NJGYMO6uuH/J8n9+M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-WDD9V3B9O1agD7-K0GP8SA-1; Fri,
 24 Oct 2025 00:21:59 -0400
X-MC-Unique: WDD9V3B9O1agD7-K0GP8SA-1
X-Mimecast-MFC-AGG-ID: WDD9V3B9O1agD7-K0GP8SA_1761279717
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3CA318002DD;
	Fri, 24 Oct 2025 04:21:57 +0000 (UTC)
Received: from fedora (unknown [10.72.120.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50F0A180057D;
	Fri, 24 Oct 2025 04:21:48 +0000 (UTC)
Date: Fri, 24 Oct 2025 12:21:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] io_uring/uring_cmd: avoid double indirect call in
 task work dispatch
Message-ID: <aPr-11nDqcz4z_V-@fedora>
References: <20251023201830.3109805-1-csander@purestorage.com>
 <20251023201830.3109805-4-csander@purestorage.com>
 <aPr1i-k0byzYjv8G@fedora>
 <CADUfDZp21icTKrWHcgRTfmsxtdab85b6R75wAYXW2dA+dzXmoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp21icTKrWHcgRTfmsxtdab85b6R75wAYXW2dA+dzXmoA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 23, 2025 at 08:49:40PM -0700, Caleb Sander Mateos wrote:
> On Thu, Oct 23, 2025 at 8:42 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Thu, Oct 23, 2025 at 02:18:30PM -0600, Caleb Sander Mateos wrote:
> > > io_uring task work dispatch makes an indirect call to struct io_kiocb's
> > > io_task_work.func field to allow running arbitrary task work functions.
> > > In the uring_cmd case, this calls io_uring_cmd_work(), which immediately
> > > makes another indirect call to struct io_uring_cmd's task_work_cb field.
> > > Define the uring_cmd task work callbacks as functions whose signatures
> > > match io_req_tw_func_t. Define a IO_URING_CMD_TASK_WORK_ISSUE_FLAGS
> > > constant in io_uring/cmd.h to avoid manufacturing issue_flags in the
> > > uring_cmd task work callbacks. Now uring_cmd task work dispatch makes a
> > > single indirect call to the uring_cmd implementation's callback. This
> > > also allows removing the task_work_cb field from struct io_uring_cmd,
> > > freeing up some additional storage space.
> >
> > The idea looks good.
> >
> > >
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  block/ioctl.c                |  4 +++-
> > >  drivers/block/ublk_drv.c     | 15 +++++++++------
> > >  drivers/nvme/host/ioctl.c    |  5 +++--
> > >  fs/btrfs/ioctl.c             |  4 +++-
> > >  fs/fuse/dev_uring.c          |  5 +++--
> > >  include/linux/io_uring/cmd.h | 16 +++++++---------
> > >  io_uring/uring_cmd.c         | 13 ++-----------
> > >  7 files changed, 30 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/block/ioctl.c b/block/ioctl.c
> > > index d7489a56b33c..5c10d48fab27 100644
> > > --- a/block/ioctl.c
> > > +++ b/block/ioctl.c
> > > @@ -767,13 +767,15 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
> > >  struct blk_iou_cmd {
> > >       int res;
> > >       bool nowait;
> > >  };
> > >
> > > -static void blk_cmd_complete(struct io_uring_cmd *cmd, unsigned int issue_flags)
> > > +static void blk_cmd_complete(struct io_kiocb *req, io_tw_token_t tw)
> > >  {
> > > +     struct io_uring_cmd *cmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> > >       struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
> > > +     unsigned int issue_flags = IO_URING_CMD_TASK_WORK_ISSUE_FLAGS;
> >
> > Now `io_kiocb` is exposed to driver, it could be perfect if 'io_uring_cmd'
> > is kept in kernel API interface, IMO.
> 
> You mean change the io_req_tw_func_t signature to pass struct
> io_uring_cmd * instead of struct io_kiocb *? I don't think that would
> make sense because task work is a more general concept, not just for
> uring_cmd. I agree it's a bit ugly exposing struct io_kiocb * outside
> of the io_uring core, but I don't see a way to encapsulate it without
> other downsides (the additional indirect call or the gross macro from
> v1). Treating it as an opaque pointer type seems like the least bad
> option...

If switching to `struct io_kiocb *` can't be accepted, `opaque pointer type`
might not be too bad:

	- share the callback storage for both `io_uring_cmd_tw_t` and
	`io_req_tw_func_t` via union

	- add one request flag for deciding to dispatch which one & prepare `io_kiocb *`
	or `io_uring_cmd *`.

> 
> >
> > ...
> >
> > > diff --git a/include/linux/io_uring/cmd.h b/include/linux/io_uring/cmd.h
> > > index b84b97c21b43..3efad93404f9 100644
> > > --- a/include/linux/io_uring/cmd.h
> > > +++ b/include/linux/io_uring/cmd.h
> > > @@ -9,18 +9,13 @@
> > >  /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
> > >  #define IORING_URING_CMD_CANCELABLE  (1U << 30)
> > >  /* io_uring_cmd is being issued again */
> > >  #define IORING_URING_CMD_REISSUE     (1U << 31)
> > >
> > > -typedef void (*io_uring_cmd_tw_t)(struct io_uring_cmd *cmd,
> > > -                               unsigned issue_flags);
> > > -
> > >  struct io_uring_cmd {
> > >       struct file     *file;
> > >       const struct io_uring_sqe *sqe;
> > > -     /* callback to defer completions to task context */
> > > -     io_uring_cmd_tw_t task_work_cb;
> > >       u32             cmd_op;
> > >       u32             flags;
> > >       u8              pdu[32]; /* available inline for free use */
> >
> > pdu[40]
> 
> I considered that, but wondered if we might want to reuse the 8 bytes
> for something internal to uring_cmd rather than providing it to the
> driver's uring_cmd implementation. If we increase pdu and a driver
> starts using more than 32 bytes, it will be difficult to claw back. It
> seems reasonable to reserve half the space for the io_uring/uring_cmd
> layer and half for the driver.

Fair enough, but I think the 8bytes need to define as reserved, at least
with document benefit.


Thanks,
Ming


