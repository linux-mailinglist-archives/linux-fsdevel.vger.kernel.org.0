Return-Path: <linux-fsdevel+bounces-4777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E725880370B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE51B20AE2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A45828DDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:37:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9AED8
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 06:07:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE97B227A8E; Mon,  4 Dec 2023 15:07:49 +0100 (CET)
Date: Mon, 4 Dec 2023 15:07:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: fork splice_file_range() from
 do_splice_direct()
Message-ID: <20231204140749.GB27396@lst.de>
References: <20231130141624.3338942-1-amir73il@gmail.com> <20231130141624.3338942-2-amir73il@gmail.com> <20231204083733.GA32438@lst.de> <20231204083849.GC32438@lst.de> <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjZAjJSR-AUH+UQM3AX9Ota3DVxygFSVkpEQdxK15n_qQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 04, 2023 at 03:29:43PM +0200, Amir Goldstein wrote:
> > > Shouldn't ceph be switched to use generic_copy_file_range?
> > > That does the capping of the size which we want, and doesn't update
> > > the file offsets, which would require recalculation in the ceph code.
> > >
> 
> IDK. I did not want to change the logic of the ceph code.
> I am not sure that we must impose MAX_RW_COUNT limit on ceph,
> although, i_layout.object_size may already be limited? Jeff?

We better don't go beyond it, as it is called from the copy_file_range
implementation which is expected to never return more than MAX_RW_COUNT.
So either it is a noop change, or it fixes a bug.

> 
> > > But this could avoid another exported API as splice_file_range could
> > > simply be folded into generic_copy_file_range which should reduce
> > > confusion.  And splice really is a mess for so many different layers
> > > of the onion being exposed.  I've been wanting to reduce some of that
> > > for a while but haven't found a really nice way yet.
> >
> > (and generic_copy_file_range really should be renamed to
> > splice_copy_file_range and moved to splice.c)
> 
> That depends if we are keeping two helpers.
> One with a cap of MAX_RW_COUNT and one without.
> If we are going to keep two helpers, I'd rather keep things as they are.
> If one helper, then I personally prefer splice_file_range() over
> splice_copy_file_range() and other reviewers (Jan) liked this
> name as well.

Well, splice_file_range makes sense if it is a separate helper.  But when
is the default implementation for ->copy_file_range and matches the
signature, naming it that way is not only sensible but required to keep
sanity.

> 
> Thanks,
> Amir.
---end quoted text---

