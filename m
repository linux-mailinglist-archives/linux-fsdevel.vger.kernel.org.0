Return-Path: <linux-fsdevel+bounces-3657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA727F6E06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 09:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CE0281733
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A71FBE62;
	Fri, 24 Nov 2023 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPGk9fnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740249471;
	Fri, 24 Nov 2023 08:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA6C433C7;
	Fri, 24 Nov 2023 08:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700814281;
	bh=pLRUlHYGVhu8BUklUaIDxuuBipDIZz/0vTGfjdNnKY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPGk9fnQWWWRuEpyadDVK4qAcVhv/V38KizImZG/s36KWYsaNDoov9umKYVz9DD9h
	 YrvwomQIlxnAlkv5Srf5v+SuUrIlyyeMM/bMDiQuI/lLc2rFHFXJ2dwFVU/gNXdBqp
	 +ElGRS8CX4k5mBYCIs+sfFLbd9RrsFmA4Eq7E/odbkYQ3Bdyr+2u+sFp4OlFTE5GGc
	 6WD4TdUnwjFRjWX9vT2RtwG+N9e0wQZXZoDB2F+UxmV//f7hMRQq4wr0xv18fI7SuX
	 ac0O4/9k1ubvOR7EHwi7D2bEcevZ3c2LUDMU76xGFie80pF6BPp9b+ZA1YL9iTP/Xu
	 clMAQx+ySSAjg==
Date: Fri, 24 Nov 2023 09:24:35 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] scsi: target: core: add missing file_{start,end}_write()
Message-ID: <20231124-zanken-ammoniak-0d5a19006645@brauner>
References: <20231123092000.2665902-1-amir73il@gmail.com>
 <2f3bf38b-a803-43e5-a9b9-54a88f837125@kernel.dk>
 <CAOQ4uxj6BBSgGKWQn=2ocsL_rd-PbjPAiK2w9rsqnxpNamxr9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj6BBSgGKWQn=2ocsL_rd-PbjPAiK2w9rsqnxpNamxr9g@mail.gmail.com>

On Fri, Nov 24, 2023 at 09:54:49AM +0200, Amir Goldstein wrote:
> On Thu, Nov 23, 2023 at 10:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 11/23/23 2:20 AM, Amir Goldstein wrote:
> > > The callers of vfs_iter_write() are required to hold file_start_write().
> > > file_start_write() is a no-op for the S_ISBLK() case, but it is really
> > > needed when the backing file is a regular file.
> > >
> > > We are going to move file_{start,end}_write() into vfs_iter_write(), but
> > > we need to fix this first, so that the fix could be backported to stable
> > > kernels.
> >
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> >
> 
> Christian,
> 
> Shall we just stash this at the bottom of vfs.rw and fixup
> "move file_{start,end}_write() into vfs_iter_write()" patch?

Ok.

> 
> I see no strong reason to expedite a fix for something rare
> that has been broken for a long time.

Agreed.

> 
> If Martin decides to expedite it, we can alway rebase vfs.rw
> once the fix is merged to master.

It's now the first commit on that branch. Let me know if I should drop it.

