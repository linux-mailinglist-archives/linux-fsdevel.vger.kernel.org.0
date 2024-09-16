Return-Path: <linux-fsdevel+bounces-29529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAEB97A802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A934CB2232B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 19:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649EE15B10C;
	Mon, 16 Sep 2024 19:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="MS5zq9OS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EA72E659
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516638; cv=none; b=vDfQ6Dr4C+M5I8VnusYgROPibP1O6VuBXUsSMvH/JmWk9Oav3SBcpAZgUkMu5p0RChU0ZGQsywLx242jD6qlAXX/SCdc/AmWXgwElKxw3GJwF2QZ/GGArD2IQUh2tIKEFhd/JudE48M593f8py04zewxnBF8r7fm/WSbpTxnxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516638; c=relaxed/simple;
	bh=dusYjb8DhB01SnkvYeGbS3EzpGJwNnbKxI+TVAyC7kI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OM20y0zqT5q0YLwTgl4oZooUA6NdN9BRjcbO3o6Bb31Hi4JqKnzag60DHpfgruGkLYevHghb3lXj1nK/ml0kjRI5rLv9mNbmnMG73FeMmEFJ7yPA9NOomxRpk3Hz1WSI26ZX4cvzrt74v7RAV0irM4z+/T8JdaR9iwppmdpBQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=MS5zq9OS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=BTefG0YbA7Al6HnRJ2E3RI/eQivIer3nRgRwz0BbvPI=; b=MS5zq9OSUW3XrsAB0nRDMgBshW
	MRObGEJ8Pv8JVGtfHvmIUjSruq1uf6arAcjZX+Fc3TBeBywaJFOIXY+jIXPxrGQA3xopqEqNOPPwB
	Bre4/pcmu8MkVMFpiVeVwGJqHSJeRtaMcxcVsUcyoMWAoG7fy9+nPDjpShJTXsq8bMyZtX8KIE1vH
	NEe2lgn0m0TAL0dPJacrzLtEHhK6n0GFGJbhfLH6SEPNFoJKsRLGkuSF8pLU1hDxzlSA1HWnsrOwZ
	DbRDVJITLQFDV/cZOChMgEiV/5Louou/rVOzSaEK65TUChkj5UEiAjW0nb9LlaO7aHxK9WegHfxep
	BdEePOnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqHqT-0000000D2OP-0Egz;
	Mon, 16 Sep 2024 19:57:13 +0000
Date: Mon, 16 Sep 2024 20:57:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC] more descriptor fun: dma_buf_fd()
Message-ID: <20240916195713.GP2825852@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	dma_buf_fd() takes dmabuf and either inserts the corresponding
struct file reference into descriptor table (and returns the descriptor)
or returns an error.  In the former case dmabuf reference is consumed,
in the latter it is not.

	At the very least, the calling conventions are wrong; it should
consume dmabuf reference in all cases.	A look at the callers confirms
that (see below for details) - a plenty of them do immediate dma_buf_put()
on failure, with varying amount of headache, there's a couple of dmabuf
leaks in those who forget to do that and finally there's one caller
that tries to do something to dmabuf after the failure.  Unfortunately,
the same caller tries to access it after _success_ as well, which leads
to UAF.  So does one of the callers that do straight dma_buf_put()
on failure...

	Suggested solutions:

A) add dma_buf_expose(dmabuf, flags) that would be an equivalent of
	int fd = dma_buf_fd(dmabuf, flags);
	if (fd < 0)
		dma_buf_put(dmabuf);
	return fd;
export it and mark dma_buf_fd() deprecated.  Switch the in-tree users
to dma_buf_expose(), fixing that couple of leaks and simplifying the
rest.  Fix the racy ones, by replacing dma_buf_fd() with get_unused_fd_flags()
before everything else and fd_install() at the very end.  Remove dma_buf_fd()
in the next cycle.

B) manually fix the leaks by adding dma_buf_put() on failure, fix the
UAF same way as in (A), add a big scary warning about dma_buf_fd() and
the issues around it.

C) longer term, add a delayed fd_install() with separate "commit everything
that has been added", which would be told either to transfer all pending
additions into the descriptor table or drop all file references and free
the reserved descriptors.  Provide an analogue of dma_buf_fd() using that,
with commit done in vfs_ioctl() or some other suitable place in the call
chain.  That would seriously simplify the cleanups on failure exits in
a lot of places in drm, at the very least.

Suggestions, preferences?

PS: dma_buf_fd() callers (in the current -next):

1) [dma-heap] dma_heap_buffer_alloc():
	...
	fd = dma_buf_fd(dmabuf, fd_flags);
	if (fd < 0) {
		dma_buf_put(dmabuf);
		/* just return, as put will call release and that will free */
	}
	return fd;

2) [udmabuf] export_udmabuf():
	...
	buf = dma_buf_export(&exp_info);
	if (IS_ERR(buf))
		return PTR_ERR(buf);
	return dma_buf_fd(buf, flags);
A leak on dma_buf_fd() failure - buf is local to export_udmabuf()
and the caller does not see it.

3) [amdkfd] kfd_ioctl_export_dmabuf():
	...
	ret = dma_buf_fd(dmabuf, args->flags);
	if (ret < 0) {
		dma_buf_put(dmabuf);
		goto err_out;
	}

4) [i915] intel_vgpu_get_dmabuf():
	...
	ret = dma_buf_fd(dmabuf, DRM_CLOEXEC | DRM_RDWR);
	if (ret < 0) {
		gvt_vgpu_err("create dma-buf fd failed ret:%d\n", ret);
		goto out_free_dmabuf;
	}
	...
	return dmabuf_fd;

out_free_dmabuf:
	dma_buf_put(dmabuf);
	...
Label is only reachable by that goto.

5) [vmwgfx] ttm_prime_handle_to_fd():
	...
	ret = dma_buf_fd(dma_buf, flags);
	if (ret >= 0) {
		*prime_fd = ret;
		ret = 0;
	} else
		dma_buf_put(dma_buf);
	...

6) [v4l2] vb2_core_expbuf():
	...
	ret = dma_buf_fd(dbuf, flags & ~O_ACCMODE);
	if (ret < 0) {
		dprintk(q, 3, "buffer %d, plane %d failed to export (%d)\n",
			vb->index, plane, ret);
		dma_buf_put(dbuf);
		return ret;
	}

7) [fastrpc] fastrpc_dmabuf_alloc():
	...
	bp.fd = dma_buf_fd(buf->dmabuf, O_ACCMODE);
	if (bp.fd < 0) {
		dma_buf_put(buf->dmabuf);
		return -EINVAL;
	}

8) [habanalabs] export_dmabuf():

	fd = dma_buf_fd(hl_dmabuf->dmabuf, flags);
	if (fd < 0) {
		dev_err(hdev->dev, "failed to get a file descriptor for a dma-buf, %d\n", fd);
		rc = fd;
		goto err_dma_buf_put;
	}
	...
	return 0;
err_dma_buf_put:
	hl_dmabuf->dmabuf->priv = NULL;
	dma_buf_put(hl_dmabuf->dmabuf);

That assignment to ->priv is actually a part of a race:

static void hl_release_dmabuf(struct dma_buf *dmabuf)
{
	struct hl_dmabuf_priv *hl_dmabuf = dmabuf->priv;
	struct hl_ctx *ctx;

	if (!hl_dmabuf)
		return;
	...

	/* Paired with get_file() in export_dmabuf() */
	fput(ctx->hpriv->file_priv->filp);
	kfree(hl_dmabuf);
}
gets called when dmabuf refcount gets to zero.  Which can
happen as soon as another thread calls close() on the guessed
descriptor, which can happen right after dma_buf_fd() -
before export_dmabuf() gets to
	/* Get compute device file to enforce release order, such that all exported dma-buf will be
	 * released first and only then the compute device.
	 * Paired with fput() in hl_release_dmabuf().
	 */
	get_file(ctx->hpriv->file_priv->filp);
What's more, it can happen before get to
	hl_dmabuf->ctx = ctx;
several lines prior to that get_file(), giving us a UAF.

9) [xen] dmabuf_exp_from_pages():

	ret = dma_buf_fd(gntdev_dmabuf->dmabuf, O_CLOEXEC);
	if (ret < 0)
		goto fail;
	...
	return 0;
fail:
	if (gntdev_dmabuf->dmabuf)
		dma_buf_put(gntdev_dmabuf->dmabuf);

There is one other branch to fail:
		gntdev_dmabuf->dmabuf = NULL;
		goto fail;
	}
So that conditional dma_buf_put() is executed if and only if
we reach fail: after failing dma_buf_fd().

Incidentally, the same function has a race similar to habanalabs caller -
we access gntdev_dmabuf after dma_buf_fd()
	mutex_lock(&args->dmabuf_priv->lock);
	list_add(&gntdev_dmabuf->next, &args->dmabuf_priv->exp_list);
	mutex_unlock(&args->dmabuf_priv->lock);
	get_file(gntdev_dmabuf->priv->filp);
Think what happens if another thread guesses the descriptor number
dma_buf_fd() will get (not hard at all) and call close(2) on it
in a tight loop...  And that get_file() is paired with fput()
done from dmabuf ->release(), similar to habanalabs case.

* mbochs_get_gfx_dmabuf() (in samples):
	return dma_buf_fd(dmabuf->buf, 0);
Same leak as in export_udmabuf()...

