Return-Path: <linux-fsdevel+bounces-29148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD89976666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A41A1F22264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C856519F425;
	Thu, 12 Sep 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K48XCpxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581B19F404;
	Thu, 12 Sep 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135660; cv=none; b=BnBBZBNwq2Ui7yq3zba2wRrHSeEFya9sTqYVQzoVAS99esF/NH0NxlqGUggmTIeev9rCteqjV7qeP01ZHWbnYhySYCZI3Ly5VepQxJqyo3f8wa6Yj1s9V9A+G9zZwaCLO1Up5njA+/G+7s/8V/W1bXvMTkIUCQMRp+8UtxeWWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135660; c=relaxed/simple;
	bh=IpdC1qHf35nRG6qUjgDllXwIwjChqVrshS7gOGlNxCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdKc15De0Ui0fk2m9jr9EQuV7w9hErQBYTL8KPWl6RhVucgEZ+Lp0wUFbDOzDgvBLccFPY7EyMsuRZV1k6lE72islnX3jBxWioPNnw5PkVaDEMTd76bJTiA9fl70TZ9KnRNwnISGKZ+7JTsLTZb2xLDXh1sHR9lWDpAA01KX6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K48XCpxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7194C4CEC3;
	Thu, 12 Sep 2024 10:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726135659;
	bh=IpdC1qHf35nRG6qUjgDllXwIwjChqVrshS7gOGlNxCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K48XCpxEBtS3sCUM32a2hL29xTUoKht3NYuzmOq/4grw8ydiTrinOYO/kFGu+xyLz
	 I+8FSSXQMEVaSYYHKtnR91/4vrZLCuKKFGfi1oXHR63EQZ8McOhZ8vt5vsVwU0INT6
	 3tifCnKVxu5JL1tourN6tczzGgBI0qwwWilMxlOOOPCs5rNNm6douO2FT5OkNHg5qk
	 QcLd1zEu3GCunannyrXiV2rOvoRh2ECgVeLAOOExb4vtguFq+eCerN3ZnKlP/sjUhL
	 LYdtJXE+3UZsjeZbon2gun4DlRaw/OUlBL0Tu+s7LbGOMkmF7fH9GBU+LGLeCvsI57
	 FXwyA//Yt594Q==
Date: Thu, 12 Sep 2024 12:07:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Benjamin Coddington <bcodding@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Neil Brown <neilb@suse.de>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexander Ahring Oder Aring <aahringo@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v1 0/4] Fixup NLM and kNFSD file lock callbacks
Message-ID: <20240912-zuspielen-selektiert-01ef380e0c1b@brauner>
References: <cover.1726083391.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1726083391.git.bcodding@redhat.com>

On Wed, Sep 11, 2024 at 03:42:56PM GMT, Benjamin Coddington wrote:
> Last year both GFS2 and OCFS2 had some work done to make their locking more
> robust when exported over NFS.  Unfortunately, part of that work caused both
> NLM (for NFS v3 exports) and kNFSD (for NFSv4.1+ exports) to no longer send
> lock notifications to clients.
> 
> This in itself is not a huge problem because most NFS clients will still
> poll the server in order to acquire a conflicted lock, but now that I've
> noticed it I can't help but try to fix it because there are big advantages
> for setups that might depend on timely lock notifications, and we've
> supported that as a feature for a long time.
> 
> Its important for NLM and kNFSD that they do not block their kernel threads
> inside filesystem's file_lock implementations because that can produce
> deadlocks.  We used to make sure of this by only trusting that
> posix_lock_file() can correctly handle blocking lock calls asynchronously,
> so the lock managers would only setup their file_lock requests for async
> callbacks if the filesystem did not define its own lock() file operation.
> 
> However, when GFS2 and OCFS2 grew the capability to correctly
> handle blocking lock requests asynchronously, they started signalling this
> behavior with EXPORT_OP_ASYNC_LOCK, and the check for also trusting
> posix_lock_file() was inadvertently dropped, so now most filesystems no
> longer produce lock notifications when exported over NFS.
> 
> I tried to fix this by simply including the old check for lock(), but the
> resulting include mess and layering violations was more than I could accept.
> There's a much cleaner way presented here using an fop_flag, which while
> potentially flag-greedy, greatly simplifies the problem and grooms the

It's fine. I've explicitly added the fop_flags so that stuff like this
we would not want to put into f->f_mode can live there.

> way for future uses by both filesystems and lock managers alike.

