Return-Path: <linux-fsdevel+bounces-63943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5590BBD28FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16E644EE120
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0E2FF16B;
	Mon, 13 Oct 2025 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="xI/WgtXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AF15E5BB;
	Mon, 13 Oct 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351219; cv=none; b=uALxhB0yBdlV3dUcWR+4hHa1B/hvaAP4q8rPaDdYLIE5zptMv+j0XTwR4+f9NfTpVCVMjEZYU4zifH5JAr2Tt5QvOJCQ5Z7vXAEgOmox2FPFxtNcf3tmrw6ygy28XS3rwDnH3CObFEOjRYSKb3k4GwQkW7yt17XgRT04f3nt780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351219; c=relaxed/simple;
	bh=ABmn+fLVsctJIcVsQ8EXkfemm3Yt7M2ThU/pU1MhG9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+vEpPyBc6X6bzYFfUdsxV56axzXB7CdObPtwLr1+NTv55rT/YFp/n8xJztvyDMc2Frx+0qeypuSYU+9FJP9MqvzG3CNYMG7BZZgjiTDm5zFWnnZelWsvw+6q5YZUoLa62BJn5UzZLp4co5H+Ja4RbbpH3YdZwuyvf0IEFkkfbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=xI/WgtXI; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id C50BA14C2D3;
	Mon, 13 Oct 2025 12:26:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760351214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liVWWnazWktLk7qYgIAJtTqEdttWgrGsPA7uT5rJXvE=;
	b=xI/WgtXIs8rnlF78rRIuhG85Om82BhXX1ipNuWomu80ZemdzezlD3qOo1vHKI0MmwCyjQ4
	TVJ+EwQfiTrv6kzqAinIkJ91eRXixNKlrUE8LQhvszZRyeUB6m8G683VMv6jAm8Pl6iepX
	wAviR/0MKstVpFbNayZXsaPaJIEUIU2s9Jr1kVFJuzxhHSYgwmd9a6OPue1tNePOzTfl+4
	3INJRJvvVOynG+Z/KL+Uzuf5ulq0U6HCNQo5iXp1n2OJH9uODYAVazzZouzjDOaQJsWSG5
	Xe9K6a9ye88FRrt4/R8egH/VZXB1z5ilb7AaxJTCVj8Q7uuBTAw3+oszHhlYog==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id e164d6cc;
	Mon, 13 Oct 2025 10:26:50 +0000 (UTC)
Date: Mon, 13 Oct 2025 19:26:35 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ericvh@kernel.org, lucho@ionkov.net,
	linux_oss@crudebyte.com, eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aOzT2-e8_p92WfP-@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251010214222.1347785-5-sandeen@redhat.com>

Hi Eric,

Thanks for this V3!

I find it much cleaner, hopefully will be easier to debug :)
... Which turned out to be needed right away, trying with qemu's 9p
export "mount -t 9p -o trans=virtio tmp /mnt" apparently calls
p9_virtio_create() with fc->source == NULL, instead of the expected
"tmp" string
(FWIW I tried '-o trans=tcp 127.0.0.1' and I got the same problem in
p9_fd_create_tcp(), might be easier to test with diod if that's what you
used)

Looking at other filesystems (e.g. fs/nfs/fs_context.c but others are
the same) it looks like they all define a fsparam_string "source" option
explicitly?...

Something like this looks like it works to do (+ probably make the error
more verbose? nothing in dmesg hints at why mount returns EINVAL...)
-----
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 6c07635f5776..999d54a0c7d9 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -34,6 +34,8 @@ struct kmem_cache *v9fs_inode_cache;
  */
 
 enum {
+	/* Mount-point source */
+	Opt_source,
 	/* Options that take integer arguments */
 	Opt_debug, Opt_dfltuid, Opt_dfltgid, Opt_afid,
 	/* String options */
@@ -82,6 +84,7 @@ static const struct constant_table p9_cache_mode[] = {
  * the client, and all the transports.
  */
 const struct fs_parameter_spec v9fs_param_spec[] = {
+	fsparam_string  ("source",      Opt_source),
 	fsparam_u32hex	("debug",	Opt_debug),
 	fsparam_uid	("dfltuid",	Opt_dfltuid),
 	fsparam_gid	("dfltgid",	Opt_dfltgid),
@@ -210,6 +213,14 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	}
 
 	switch (opt) {
+	case Opt_source:
+                if (fc->source) {
+			pr_info("p9: multiple sources not supported\n");
+			return -EINVAL;
+		}
+		fc->source = param->string;
+		param->string = NULL;
+		break;
 	case Opt_debug:
 		session_opts->debug = result.uint_32;
 #ifdef CONFIG_NET_9P_DEBUG
-----

I'll try to find some time to test a mix of actual mount options later
this week

Cheers,
-- 
Dominique Martinet | Asmadeus

