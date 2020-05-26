Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39481C6413
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgEEWoa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:44:30 -0400
Received: from crocodile.birch.relay.mailchannels.net ([23.83.209.45]:50278
        "EHLO crocodile.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbgEEWo3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:44:29 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 May 2020 18:44:28 EDT
X-Sender-Id: dreamhost|x-authsender|cosmos@claycon.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 78166700E91;
        Tue,  5 May 2020 22:26:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a81.g.dreamhost.com (100-96-6-17.trex.outbound.svc.cluster.local [100.96.6.17])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AFDDD7011B5;
        Tue,  5 May 2020 22:26:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|cosmos@claycon.org
Received: from pdx1-sub0-mail-a81.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.8);
        Tue, 05 May 2020 22:26:42 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|cosmos@claycon.org
X-MailChannels-Auth-Id: dreamhost
X-Gusty-Arch: 77dfea3d492064f3_1588717602224_2324846253
X-MC-Loop-Signature: 1588717602224:2854189442
X-MC-Ingress-Time: 1588717602223
Received: from pdx1-sub0-mail-a81.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a81.g.dreamhost.com (Postfix) with ESMTP id 4081B7F567;
        Tue,  5 May 2020 15:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=claycon.org; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=claycon.org; bh=1L82ZcdVX8X2vKTP+qh58U006UU=; b=
        CZyjyQRBgk7jfQAz0BxPAIrixRYTu/DzEXYlRcbJs3xrMJLaYoevWP2GKkIv+TDv
        eNt25Mp/xAbxwI2zoX8zQlfXxsgtdiGIHQczoZ864otSd8zxNAcaselfmMQiU4SV
        9SreDwRhSyAplOo6amIPOMPEDVV+va3HINGD0tt5NuU=
Received: from ps29521.dreamhostps.com (ps29521.dreamhostps.com [69.163.186.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cosmos@claycon.org)
        by pdx1-sub0-mail-a81.g.dreamhost.com (Postfix) with ESMTPSA id CB3057F565;
        Tue,  5 May 2020 15:26:39 -0700 (PDT)
Date:   Tue, 5 May 2020 17:26:40 -0500
X-DH-BACKEND: pdx1-sub0-mail-a81
From:   Clay Harris <bugs@claycon.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-5.7] splice: move f_mode checks to do_{splice,tee}()
Message-ID: <20200505222640.phkjuqfuselwl6gm@ps29521.dreamhostps.com>
References: <51b4370ef70eebf941f6cef503943d7f7de3ea4d.1588621153.git.asml.silence@gmail.com>
 <20200505211029.azfj2c4scoh6x2kx@ps29521.dreamhostps.com>
 <2146b60d-d982-59c4-33d3-a5e6ad68fc8e@gmail.com>
 <20200505220032.fm5vqf3xuaucnjle@ps29521.dreamhostps.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505220032.fm5vqf3xuaucnjle@ps29521.dreamhostps.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrjeejgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucggtfgfnhhsuhgsshgtrhhisggvpdfftffgtefojffquffvnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpeevlhgrhicujfgrrhhrihhsuceosghughhssegtlhgrhigtohhnrdhorhhgqeenucggtffrrghtthgvrhhnpefgtdekjeehffefvdfhhedttdehkeejgfegiedtjedthfeuvdfgieevkeekvdfhvdenucfkphepieelrdduieefrddukeeirdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehpshdvleehvddurdgurhgvrghmhhhoshhtphhsrdgtohhmpdhinhgvthepieelrdduieefrddukeeirdejgedprhgvthhurhhnqdhprghthhepvehlrgihucfjrghrrhhishcuoegsuhhgshestghlrgihtghonhdrohhrgheqpdhmrghilhhfrhhomhepsghughhssegtlhgrhigtohhnrdhorhhgpdhnrhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05 2020 at 17:00:32 -0500, Clay Harris quoth thus:

> On Wed, May 06 2020 at 00:38:05 +0300, Pavel Begunkov quoth thus:
> 
> > On 06/05/2020 00:10, Clay Harris wrote:
> > > On Mon, May 04 2020 at 22:39:35 +0300, Pavel Begunkov quoth thus:
> > > 
> > >> do_splice() is used by io_uring, as will be do_tee(). Move f_mode
> > >> checks from sys_{splice,tee}() to do_{splice,tee}(), so they're
> > >> enforced for io_uring as well.
> > > 
> > > I'm not seeing any check against splicing a pipe to itself in the
> > > io_uring path, although maybe I just missed it.  As the comment
> > > below says: /* Splicing to self would be fun, but... */ .
> > 
> > io_uring just forwards a request to do_splice(), which do the check at the exact
> > place you mentioned. The similar story is with do_tee().
> 
> Okay.  I'd been thinking that since you were moving the file mode
> checks into io_uring that the previous place they were called wasn't
> on the path.  Evidently, you're just moving the mode checks earlier.

My bad.  I meant to say *later*.  (After the syscall entry, at the spot
io_uring would call.)

Thanks for looking at it!

> > > 
> > >> Fixes: 7d67af2c0134 ("io_uring: add splice(2) support")
> > >> Reported-by: Jann Horn <jannh@google.com>
> > >> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> > >> ---
> > >>  fs/splice.c | 45 ++++++++++++++++++---------------------------
> > >>  1 file changed, 18 insertions(+), 27 deletions(-)
> > >>
> > >> diff --git a/fs/splice.c b/fs/splice.c
> > >> index 4735defc46ee..fd0a1e7e5959 100644
> > >> --- a/fs/splice.c
> > >> +++ b/fs/splice.c
> > >> @@ -1118,6 +1118,10 @@ long do_splice(struct file *in, loff_t __user *off_in,
> > >>  	loff_t offset;
> > >>  	long ret;
> > >>  
> > >> +	if (unlikely(!(in->f_mode & FMODE_READ) ||
> > >> +		     !(out->f_mode & FMODE_WRITE)))
> > >> +		return -EBADF;
> > >> +
> > >>  	ipipe = get_pipe_info(in);
> > >>  	opipe = get_pipe_info(out);
> > >>  
> > >> @@ -1125,12 +1129,6 @@ long do_splice(struct file *in, loff_t __user *off_in,
> > >>  		if (off_in || off_out)
> > >>  			return -ESPIPE;
> > >>  
> > >> -		if (!(in->f_mode & FMODE_READ))
> > >> -			return -EBADF;
> > >> -
> > >> -		if (!(out->f_mode & FMODE_WRITE))
> > >> -			return -EBADF;
> > >> -
> > >>  		/* Splicing to self would be fun, but... */
> > >>  		if (ipipe == opipe)
> > >>  			return -EINVAL;
> > >> @@ -1153,9 +1151,6 @@ long do_splice(struct file *in, loff_t __user *off_in,
> > >>  			offset = out->f_pos;
> > >>  		}
> > >>  
> > >> -		if (unlikely(!(out->f_mode & FMODE_WRITE)))
> > >> -			return -EBADF;
> > >> -
> > >>  		if (unlikely(out->f_flags & O_APPEND))
> > >>  			return -EINVAL;
> > >>  
> > >> @@ -1440,15 +1435,11 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *, off_in,
> > >>  	error = -EBADF;
> > >>  	in = fdget(fd_in);
> > >>  	if (in.file) {
> > >> -		if (in.file->f_mode & FMODE_READ) {
> > >> -			out = fdget(fd_out);
> > >> -			if (out.file) {
> > >> -				if (out.file->f_mode & FMODE_WRITE)
> > >> -					error = do_splice(in.file, off_in,
> > >> -							  out.file, off_out,
> > >> -							  len, flags);
> > >> -				fdput(out);
> > >> -			}
> > >> +		out = fdget(fd_out);
> > >> +		if (out.file) {
> > >> +			error = do_splice(in.file, off_in, out.file, off_out,
> > >> +					  len, flags);
> > >> +			fdput(out);
> > >>  		}
> > >>  		fdput(in);
> > >>  	}
> > >> @@ -1770,6 +1761,10 @@ static long do_tee(struct file *in, struct file *out, size_t len,
> > >>  	struct pipe_inode_info *opipe = get_pipe_info(out);
> > >>  	int ret = -EINVAL;
> > >>  
> > >> +	if (unlikely(!(in->f_mode & FMODE_READ) ||
> > >> +		     !(out->f_mode & FMODE_WRITE)))
> > >> +		return -EBADF;
> > >> +
> > >>  	/*
> > >>  	 * Duplicate the contents of ipipe to opipe without actually
> > >>  	 * copying the data.
> > >> @@ -1795,7 +1790,7 @@ static long do_tee(struct file *in, struct file *out, size_t len,
> > >>  
> > >>  SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
> > >>  {
> > >> -	struct fd in;
> > >> +	struct fd in, out;
> > >>  	int error;
> > >>  
> > >>  	if (unlikely(flags & ~SPLICE_F_ALL))
> > >> @@ -1807,14 +1802,10 @@ SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, flags)
> > >>  	error = -EBADF;
> > >>  	in = fdget(fdin);
> > >>  	if (in.file) {
> > >> -		if (in.file->f_mode & FMODE_READ) {
> > >> -			struct fd out = fdget(fdout);
> > >> -			if (out.file) {
> > >> -				if (out.file->f_mode & FMODE_WRITE)
> > >> -					error = do_tee(in.file, out.file,
> > >> -							len, flags);
> > >> -				fdput(out);
> > >> -			}
> > >> +		out = fdget(fdout);
> > >> +		if (out.file) {
> > >> +			error = do_tee(in.file, out.file, len, flags);
> > >> +			fdput(out);
> > >>  		}
> > >>   		fdput(in);
> > >>   	}
> > >> -- 
> > >> 2.24.0
> > 
> > -- 
> > Pavel Begunkov
