Return-Path: <linux-fsdevel+bounces-3549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953897F63D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EED1C20DB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 16:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559E3FB0A;
	Thu, 23 Nov 2023 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX4/9pSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8B3FB01
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 16:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66766C433C9;
	Thu, 23 Nov 2023 16:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700756547;
	bh=/k/+tNL5NWxzLpiCvFKdDiC6BAh8XJh1/AFp1Bkusb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UX4/9pSW7ooc2RORb9woOj/HAY/c+tmFCQwKSQ7GIaZFPd3pzlWaNA5icty8iuC73
	 efEBZCYb18bbKgku0KGZ/NKNIReBQKMeRq2vlILWtqhW5whlJlJt51hubMh6vCeBU0
	 Jm9e2CMR/rv/5oDPPceBzOaQwNTRb3qT1PzPRo3bBwezjiV2zRQM8mNSdRTmeDAmfz
	 F2kq+fnBDmWH3Md/grFKLICiSnnQRB+GmfCq58/M4mv2tf517qRX7TBkybBt0JR8xH
	 1mryn0Hv2wGeLe5MzCpSHMyR9ooYYBy98s3HkqIf0z3S27pydFh6lUtFdUD6oD9yYW
	 OymW1RympKk5w==
Date: Thu, 23 Nov 2023 17:22:22 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/16] splice: remove permission hook from
 iter_file_splice_write()
Message-ID: <20231123-geboren-deutlich-b5efc843f530@brauner>
References: <20231122122715.2561213-1-amir73il@gmail.com>
 <20231122122715.2561213-6-amir73il@gmail.com>
 <ZV8Dk7UOLejEhzQN@infradead.org>
 <CAOQ4uxhxG_G6pjVTikakuUpru1XfaJoKWs4+HwNxCE5PxGTq_Q@mail.gmail.com>
 <ZV9sTfUfM9PU1IFw@infradead.org>
 <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiDbGCn3vB4VwQyzdE9k8JjCeMGOqsVN=J5=-KCkvuQ2g@mail.gmail.com>

> > diff --git a/fs/splice.c b/fs/splice.c
> > index d983d375ff1130..982a0872fa03e9 100644
> > --- a/fs/splice.c
> > +++ b/fs/splice.c
> > @@ -684,6 +684,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
> >
> >         splice_from_pipe_begin(&sd);
> >         while (sd.total_len) {
> > +               struct kiocb kiocb;
> >                 struct iov_iter from;
> >                 unsigned int head, tail, mask;
> >                 size_t left;
> > @@ -733,7 +734,10 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
> >                 }
> >
> >                 iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
> > -               ret = vfs_iter_write(out, &from, &sd.pos, 0);
> > +               init_sync_kiocb(&kiocb, out);
> > +               kiocb.ki_pos = sd.pos;
> > +               ret = out->f_op->write_iter(&kiocb, &from);
> > +               sd.pos = kiocb.ki_pos;
> >                 if (ret <= 0)
> >                         break;
> >
> 
> Are we open coding call_write_iter() now?
> Is that a trend that I am not aware of?

I'll fold that in as-is but I'll use call_write_iter() for now.
We can remove that later. For now consistency matters more.

