Return-Path: <linux-fsdevel+bounces-14282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D887A76B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 13:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9841F2463C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3E63FE2E;
	Wed, 13 Mar 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9V0VbxP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8E3FB0F
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710331991; cv=none; b=IlxnLCaFnf69BRO9BLmNMLtEJNSQuUvsmzsKf/gXBD4iVESgw3s93hYq20AQGYeV6Bhha2IjQOlgqNZnMUjiLJt0wlJtssQ9ijGXKA1W6OSiOFVTO/QXMrbfyOb1lm02GWPsNKFpcmFIq4QAgShBmaqEgOUcW21zAJXqUiReSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710331991; c=relaxed/simple;
	bh=KY3GmGiPcro3a+CAKfJWS6zbPB2AHWvN4QxteRVDrsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdY+zIZ6NV1fB6CX0JUTPtBMBpEsB0HMEZ8+9yemD82Dz8nuSGTo1joAi6TR3OOIUPH4HUxbY5tH8M93H0zjJtLtB1ozSMI1bXzax/T/SbaYUEZs/4OHT04d16B6QL8SklGaHy/jJOZcJ0CCKAIJZwIszYZsGDJnGcOMWRrqHz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E9V0VbxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710331988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FQcf1nOKlMmN0CZVH5a2pQzTSI6ZekOBuZjHd+HZgWU=;
	b=E9V0VbxPV3ZzkkEJTuK/FJYBzWxWy5F9K/Y82vh56ab96hxG/DB/rzmxwW0rEvjexorMou
	tqtKxfafI/dp05dSKEi3fv6VY01h4iweUVFviFLwjwz4UsrVqWIWgITrAar+vFqKhdTGjM
	1qq6Ycip1/PAu8zGPyYyY9+LSXm0eGQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-bn3cwYwINeCfsO7QsZGFFA-1; Wed, 13 Mar 2024 08:13:04 -0400
X-MC-Unique: bn3cwYwINeCfsO7QsZGFFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D2088007AF;
	Wed, 13 Mar 2024 12:13:04 +0000 (UTC)
Received: from bfoster (unknown [10.22.16.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 67E3C1121306;
	Wed, 13 Mar 2024 12:13:02 +0000 (UTC)
Date: Wed, 13 Mar 2024 08:14:44 -0400
From: Brian Foster <bfoster@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: Re: [PATCH v2 4/6] virtiofs: support bounce buffer backed by
 scattered pages
Message-ID: <ZfGYtAq01tPv7BNc@bfoster>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240228144126.2864064-5-houtao@huaweicloud.com>
 <ZeCcV9Jo3mTRPsME@bfoster>
 <ef80346a-532a-c394-77f7-ec9f640e5b6f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef80346a-532a-c394-77f7-ec9f640e5b6f@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, Mar 09, 2024 at 12:14:23PM +0800, Hou Tao wrote:
> Hi,
> 
> On 2/29/2024 11:01 PM, Brian Foster wrote:
> > On Wed, Feb 28, 2024 at 10:41:24PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> When reading a file kept in virtiofs from kernel (e.g., insmod a kernel
> >> module), if the cache of virtiofs is disabled, the read buffer will be
> >> passed to virtiofs through out_args[0].value instead of pages. Because
> >> virtiofs can't get the pages for the read buffer, virtio_fs_argbuf_new()
> >> will create a bounce buffer for the read buffer by using kmalloc() and
> >> copy the read buffer into bounce buffer. If the read buffer is large
> >> (e.g., 1MB), the allocation will incur significant stress on the memory
> >> subsystem.
> >>
> >> So instead of allocating bounce buffer by using kmalloc(), allocate a
> >> bounce buffer which is backed by scattered pages. The original idea is
> >> to use vmap(), but the use of GFP_ATOMIC is no possible for vmap(). To
> >> simplify the copy operations in the bounce buffer, use a bio_vec flex
> >> array to represent the argbuf. Also add an is_flat field in struct
> >> virtio_fs_argbuf to distinguish between kmalloc-ed and scattered bounce
> >> buffer.
> >>
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  fs/fuse/virtio_fs.c | 163 ++++++++++++++++++++++++++++++++++++++++----
> >>  1 file changed, 149 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> >> index f10fff7f23a0f..ffea684bd100d 100644
> >> --- a/fs/fuse/virtio_fs.c
> >> +++ b/fs/fuse/virtio_fs.c
> > ...
> >> @@ -408,42 +425,143 @@ static void virtio_fs_request_dispatch_work(struct work_struct *work)
> >>  	}
> >>  }
> >>  
> > ...  
> >>  static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
> >>  					      unsigned int offset,
> >>  					      const void *src, unsigned int len)
> >>  {
> >> -	memcpy(argbuf->buf + offset, src, len);
> >> +	struct iov_iter iter;
> >> +	unsigned int copied;
> >> +
> >> +	if (argbuf->is_flat) {
> >> +		memcpy(argbuf->f.buf + offset, src, len);
> >> +		return;
> >> +	}
> >> +
> >> +	iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec,
> >> +		      argbuf->s.nr, argbuf->s.size);
> >> +	iov_iter_advance(&iter, offset);
> > Hi Hou,
> >
> > Just a random comment, but it seems a little inefficient to reinit and
> > readvance the iter like this on every copy/call. It looks like offset is
> > already incremented in the callers of the argbuf copy helpers. Perhaps
> > iov_iter could be lifted into the callers and passed down, or even just
> > include it in the argbuf structure and init it at alloc time?
> 
> Sorry for the late reply. Being busy with off-site workshop these days.
> 

No worries.

> I have tried a similar idea before in which iov_iter was saved directly
> in argbuf struct, but it didn't work out well. The reason is that for
> copy both in_args and out_args, an iov_iter is needed, but the direction
> is different. Currently the bi-directional io_vec is not supported, so
> the code have to initialize the iov_iter twice: one for copy from
> in_args and another one for copy to out_args.
> 

Ok, seems reasonable enough.

> For dio read initiated from kernel, both of its in_numargs and
> out_numargs is 1, so there will be only one iov_iter_advance() in
> virtio_fs_argbuf_copy_to_out_arg() and the offset is 64, so I think the
> overhead will be fine. For dio write initiated from kernel, its
> in_numargs is 2 and out_numargs is 1, so there will be two invocations
> of iov_iter_advance(). The first one with offset=64, and the another one
> with offset=round_up_page_size(64 + write_size), so the later one may
> introduce extra overhead. But compared with the overhead of data copy, I
> still think the overhead of calling iov_iter_advance() is fine.
> 

I'm not claiming the overhead is some practical problem here, but rather
that we shouldn't need to be concerned with it in the first place with
some cleaner code. It's been a bit since I first looked at this. I was
originally wondering about defining the iov_iter in the caller and pass
as a param, but on another look, do the lowest level helpers really need
to exist?

If you don't anticipate further users, IMO something like the diff below
is a bit more clean (compile tested only, but no reinits and less code
overall). But that's just my .02, feel free to use it or not..

Brian

--- 8< ---

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 9ee71051c89f..9de477e9ccd5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -544,26 +544,6 @@ static unsigned int virtio_fs_argbuf_setup_sg(struct virtio_fs_argbuf *argbuf,
 	return cur - sg;
 }
 
-static void virtio_fs_argbuf_copy_from_in_arg(struct virtio_fs_argbuf *argbuf,
-					      unsigned int offset,
-					      const void *src, unsigned int len)
-{
-	struct iov_iter iter;
-	unsigned int copied;
-
-	if (argbuf->is_flat) {
-		memcpy(argbuf->f.buf + offset, src, len);
-		return;
-	}
-
-	iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec,
-		      argbuf->s.nr, argbuf->s.size);
-	iov_iter_advance(&iter, offset);
-
-	copied = _copy_to_iter(src, len, &iter);
-	WARN_ON_ONCE(copied != len);
-}
-
 static unsigned int
 virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
 				 const struct fuse_args *args)
@@ -577,26 +557,6 @@ virtio_fs_argbuf_out_args_offset(struct virtio_fs_argbuf *argbuf,
 	return round_up(offset, PAGE_SIZE);
 }
 
-static void virtio_fs_argbuf_copy_to_out_arg(struct virtio_fs_argbuf *argbuf,
-					     unsigned int offset, void *dst,
-					     unsigned int len)
-{
-	struct iov_iter iter;
-	unsigned int copied;
-
-	if (argbuf->is_flat) {
-		memcpy(dst, argbuf->f.buf + offset, len);
-		return;
-	}
-
-	iov_iter_bvec(&iter, ITER_SOURCE, argbuf->s.bvec,
-		      argbuf->s.nr, argbuf->s.size);
-	iov_iter_advance(&iter, offset);
-
-	copied = _copy_from_iter(dst, len, &iter);
-	WARN_ON_ONCE(copied != len);
-}
-
 /*
  * Returns 1 if queue is full and sender should wait a bit before sending
  * next request, 0 otherwise.
@@ -684,23 +644,41 @@ static void virtio_fs_hiprio_dispatch_work(struct work_struct *work)
 static void copy_args_to_argbuf(struct fuse_req *req)
 {
 	struct fuse_args *args = req->args;
+	struct virtio_fs_argbuf *argbuf = req->argbuf;
+	struct iov_iter iter;
+	unsigned int copied;
 	unsigned int offset = 0;
 	unsigned int num_in;
 	unsigned int i;
 
+	if (!argbuf->is_flat) {
+		iov_iter_bvec(&iter, ITER_DEST, argbuf->s.bvec, argbuf->s.nr,
+			argbuf->s.size);
+	}
+
 	num_in = args->in_numargs - args->in_pages;
 	for (i = 0; i < num_in; i++) {
-		virtio_fs_argbuf_copy_from_in_arg(req->argbuf, offset,
-						  args->in_args[i].value,
-						  args->in_args[i].size);
-		offset += args->in_args[i].size;
+		const void *src = args->in_args[i].value;
+		unsigned int len = args->in_args[i].size;
+
+		if (argbuf->is_flat) {
+			memcpy(argbuf->f.buf + offset, src, len);
+			offset += len;
+			continue;
+		}
+
+		iov_iter_advance(&iter, len);
+		copied = _copy_to_iter(src, len, &iter);
+		WARN_ON_ONCE(copied != len);
 	}
 }
 
 /* Copy args out of req->argbuf */
 static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 {
-	struct virtio_fs_argbuf *argbuf;
+	struct virtio_fs_argbuf *argbuf = req->argbuf;
+	struct iov_iter iter;
+	unsigned int copied;
 	unsigned int remaining;
 	unsigned int offset;
 	unsigned int num_out;
@@ -711,10 +689,14 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 	if (!num_out)
 		goto out;
 
-	argbuf = req->argbuf;
+	if (!argbuf->is_flat)
+		iov_iter_bvec(&iter, ITER_SOURCE, argbuf->s.bvec,
+		      argbuf->s.nr, argbuf->s.size);
+
 	offset = virtio_fs_argbuf_out_args_offset(argbuf, args);
 	for (i = 0; i < num_out; i++) {
 		unsigned int argsize = args->out_args[i].size;
+		void *dst = args->out_args[i].value;
 
 		if (args->out_argvar &&
 		    i == args->out_numargs - 1 &&
@@ -722,10 +704,14 @@ static void copy_args_from_argbuf(struct fuse_args *args, struct fuse_req *req)
 			argsize = remaining;
 		}
 
-		virtio_fs_argbuf_copy_to_out_arg(argbuf, offset,
-						 args->out_args[i].value,
-						 argsize);
-		offset += argsize;
+		if (argbuf->is_flat) {
+			memcpy(dst, argbuf->f.buf + offset, argsize);
+			offset += argsize;
+		} else {
+			iov_iter_advance(&iter, argsize);
+			copied = _copy_from_iter(dst, argsize, &iter);
+			WARN_ON_ONCE(copied != argsize);
+		}
 
 		if (i != args->out_numargs - 1)
 			remaining -= argsize;


