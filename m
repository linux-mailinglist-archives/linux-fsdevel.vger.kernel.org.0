Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321C6F029E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 10:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbjD0Idq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 04:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242907AbjD0Idp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A849D8;
        Thu, 27 Apr 2023 01:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66781611FC;
        Thu, 27 Apr 2023 08:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF347C433D2;
        Thu, 27 Apr 2023 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682584422;
        bh=ENn2OWUvA1rQkKqlqTqZfLxN0tWDEscUe4wjLWNox3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFNHUnqUQvcVUeS0x1krOU8fmWG7nz9M7wh9oSU+As4Nztc18CpjNl/XR3gtG2Qdw
         VHU5BAYLycvzBLrqyo6yz3jfSuX8Biq6gRCEhA4Ts01r9i4zb0S3iAKZ/Ct3F5AwEF
         d83UA+zNLp7C9AXFaLRGwQrULf9WKNp7XDSwBPWmrYme+btM9uKvjwDzRsDOQ9g5QH
         CCGmaJEmVPAPa+635WyY1dqJIHxTpZLm7h/LdoO6U3eag058maZljRno0eLKRt4W6R
         5XBOAFFSJAXTVkmT3ix/H81ByR0SDCL9GGq5tN1zPN03hz6+eGaAzOq/3yzbG+EwGl
         ONoQioElzhEww==
Date:   Thu, 27 Apr 2023 10:33:38 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pidfd updates
Message-ID: <20230427-postweg-ruder-ae997dab3346@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
 <CAHk-=whOE+wXrxykHK0GimbNmxyr4a07kTpG8dzoceowTz1Yxg@mail.gmail.com>
 <20230425060427.GP3390869@ZenIV>
 <20230425-sturheit-jungautor-97d92d7861e2@brauner>
 <20230427010715.GX3390869@ZenIV>
 <20230427073908.GA3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230427073908.GA3390869@ZenIV>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 08:39:08AM +0100, Al Viro wrote:
> On Thu, Apr 27, 2023 at 02:07:15AM +0100, Al Viro wrote:
> > On Tue, Apr 25, 2023 at 02:34:15PM +0200, Christian Brauner wrote:
> > 
> > 
> > > struct fd_file {
> > > 	struct file *file;
> > > 	int fd;
> > > 	int __user *fd_user;
> > 
> > Why is it an int?  Because your case has it that way?
> > 
> > We have a bunch of places where we have an ioctl with
> > a field in some structure filled that way; any primitive
> > that combines put_user() with descriptor handling is
> > going to cause trouble as soon as somebody deals with
> > a structure where such member is unsigned long.  Gets
> > especially funny on 64bit big-endian...
> > 
> > And that objection is orthogonal to that 3-member structure -
> > even if you pass int __user * as an explicit argument into
> > your helper, the same trouble will be there.
> > 
> > Al, still going through that zoo...
> 
> FWIW, surprisingly large part of messy users in ioctls might get
> simplified nicely if we add something along the lines of
> 
> int delayed_dup(struct file *file, unsigned flags)
> {
> 	struct delayed_dup *p = kmalloc(sizeof(struct delayed_dup), GFP_KERNEL);
> 	int fd;
> 
> 	if (likely(p))
> 		fd = p->fd = get_unused_fd_flags(flags);
> 	else
> 		fd = -ENOMEM;
> 	if (likely(fd >= 0)) {
> 		p->file = file;
> 		init_task_work(&p->work, __do_delayed_dup);
> 		if (!task_work_add(&p, TWA_RESUME))
> 			return fd;
> 		put_unused_fd(fd);
> 		fd = -EINVAL;
> 	}
> 	fput(file);
> 	kfree(p);
> 	return fd;
> }
> 
> with
> 
> struct delayed_dup {
> 	struct callback_head work;
> 	struct file *file;
> 	unsigned fd;
> };
> 
> static void __do_delayed_dup(struct callback_head *work)
> {
> 	struct delayed_dup *p = container_of(work, struct delayed_dup, work);
> 
> 	if (!syscall_get_error(current, current_pt_regs())) {
> 		fd_install(p->fd, p->file);
> 	} else {
> 		put_unused_fd(p->fd);
> 		fput(p->file);
> 	}
> 	kfree(p);
> }
> 
> Random example (completely untested - I'm not even sure it compiles):
> 
> diff --git a/drivers/dma-buf/sync_file.c b/drivers/dma-buf/sync_file.c
> index af57799c86ce..7c62becfddc9 100644
> --- a/drivers/dma-buf/sync_file.c
> +++ b/drivers/dma-buf/sync_file.c
> @@ -207,55 +207,34 @@ static __poll_t sync_file_poll(struct file *file, poll_table *wait)
>  static long sync_file_ioctl_merge(struct sync_file *sync_file,
>  				  unsigned long arg)
>  {
> -	int fd = get_unused_fd_flags(O_CLOEXEC);
>  	int err;
>  	struct sync_file *fence2, *fence3;
> +	struct sync_merge_data __user *argp = (void *)arg;
>  	struct sync_merge_data data;
>  
> -	if (fd < 0)
> -		return fd;
> -
> -	if (copy_from_user(&data, (void __user *)arg, sizeof(data))) {
> -		err = -EFAULT;
> -		goto err_put_fd;
> -	}
> +	if (copy_from_user(&data, argp, sizeof(data)))
> +		return -EFAULT;
>  
> -	if (data.flags || data.pad) {
> -		err = -EINVAL;
> -		goto err_put_fd;
> -	}
> +	if (data.flags || data.pad)
> +		return -EINVAL;
>  
>  	fence2 = sync_file_fdget(data.fd2);
> -	if (!fence2) {
> -		err = -ENOENT;
> -		goto err_put_fd;
> -	}
> +	if (!fence2)
> +		return -ENOENT;
>  
>  	data.name[sizeof(data.name) - 1] = '\0';
>  	fence3 = sync_file_merge(data.name, sync_file, fence2);
> -	if (!fence3) {
> +	if (fence3)
> +		err = delayed_dup(fence3->file, O_CLOEXEC);
> +	else
>  		err = -ENOMEM;
> -		goto err_put_fence2;
> -	}
>  
> -	data.fence = fd;
> -	if (copy_to_user((void __user *)arg, &data, sizeof(data))) {
> -		err = -EFAULT;
> -		goto err_put_fence3;
> +	if (err >= 0) {
> +		data.fence = err;
> +		err = copy_to_user(argp, &data, sizeof(data)) ? -EFAULT : 0;
>  	}
>  
> -	fd_install(fd, fence3->file);
> -	fput(fence2->file);
> -	return 0;
> -
> -err_put_fence3:
> -	fput(fence3->file);
> -
> -err_put_fence2:
>  	fput(fence2->file);
> -
> -err_put_fd:
> -	put_unused_fd(fd);
>  	return err;
>  }
>  
> 
> IMO it's much easier to follow that way, and that's a fairly typical
> example.  One primitive call instead of three, *much* simpler handling
> of failure exits, no need to deal with unroll on copy_to_user() failures
> (here those were handled; most of the drivers/gpu/drm stuff is buried
> quite a few call levels deeper than the place where copyout is done,
> so currently it doesn't even try to DTRT in that respect).
> 
> It's not a panacea - for that to be useful we need
> 	* no side effects of file opening that wouldn't be undone by fput()
> 	* enough work done to make the overhead negligible
> 	* moderate amount of files opened in one call
> 	* a pattern that could be massaged into "open file, then deal with
> inserting it into descriptor table".
> 
> There's a plenty of fd_install() users that match that pattern.
> Certainly not all of them, but almost everything in drivers does.
> 
> I'm still digging through the rest - there's a couple of other patterns
> that seem to be common, but I'm not through the entire pile yet.

So the earlier proposal plus added complexity to hide it from users.
I don't feel strongly that we really do need to do something here but if
this is something you feel strongly about then sure. But a few points:

* I don't think this is much of a simplification for file descriptor
  handling in those callers. Judging by the example you pasted here the
  simplifications to this function are much more based on changing the
  general structure. I suspect it'll be the same for a lot of other
  codepaths. But I'm happy to be convinced otherwise.
* This delayed_dup() thing is fairly complex with the task work stuff
  and the memory allocation mixed in there.
* It adds an async pattern into the fd installation path which
  feels like yet another complex add on.

Ultimately what I try to gauge with changes like that is how likely are
people going to use a pattern without someone having to go through the
tree every few months to make sure that the api isn't abused. I'm not
sure that this wouldn't just end up being misused.

File descriptor installation is not core functionality for drivers. It's
just something that they have to do and so it's not that people usually
put a lot of thought into it. So that's why I think an API has to be
dumb enough. A three call api may still be simpler to use than an overly
clever single call api.
