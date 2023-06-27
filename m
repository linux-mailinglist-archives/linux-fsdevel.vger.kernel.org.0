Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F773F47E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjF0G0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 02:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjF0GZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5F2272C;
        Mon, 26 Jun 2023 23:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8557F6100E;
        Tue, 27 Jun 2023 06:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61516C433C8;
        Tue, 27 Jun 2023 06:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687847141;
        bh=G+F0E2NcaLt8e1QCrT2yY6Id7JkiDTVt7DBza4Bc/dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5XvuwFfrqNnOwm9y1fTdCNvb5JbWJefenTltGV07r8SGY9J08p6MIEbptiY/uwkC
         US5xTwvT+G5A8rL/dC3GzkZblQxIE240V0y+Psc6WBXDCwZmxmDqwQxkqEk7aYdmzd
         zE/2SXVui3/GzPlRnRS/FQFr8Usb0Hp6mwZtaj3Y=
Date:   Tue, 27 Jun 2023 08:25:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <2023062757-hardening-confusion-6f4e@gregkh>
References: <20230626201713.1204982-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626201713.1204982-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> kernfs_ops.release operation can be called from kernfs_drain_open_files
> which is not tied to the file's real lifecycle. Introduce a new kernfs_ops
> free operation which is called only when the last fput() of the file is
> performed and therefore is strictly tied to the file's lifecycle. This
> operation will be used for freeing resources tied to the file, like
> waitqueues used for polling the file.

This is confusing, shouldn't release be the "last" time the file is
handled and then all resources attached to it freed?  Why do we need
another callback, shouldn't release handle this?


> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/kernfs/file.c       | 8 +++++---
>  include/linux/kernfs.h | 5 +++++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 40c4661f15b7..acc52d23d8f6 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -766,7 +766,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
>  
>  /* used from release/drain to ensure that ->release() is called exactly once */
>  static void kernfs_release_file(struct kernfs_node *kn,
> -				struct kernfs_open_file *of)
> +				struct kernfs_open_file *of, bool final)

Adding flags to functions like this are a pain, now we need to look it
up every time to see what that bool means.

And when we do, we see that it is not documented here so we have no idea
of what it is :(

This is not going to be maintainable as-is, sorry.

>  {
>  	/*
>  	 * @of is guaranteed to have no other file operations in flight and
> @@ -787,6 +787,8 @@ static void kernfs_release_file(struct kernfs_node *kn,
>  		of->released = true;
>  		of_on(of)->nr_to_release--;
>  	}
> +	if (final && kn->attr.ops->free)
> +		kn->attr.ops->free(of);
>  }
>  
>  static int kernfs_fop_release(struct inode *inode, struct file *filp)
> @@ -798,7 +800,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
>  		struct mutex *mutex;
>  
>  		mutex = kernfs_open_file_mutex_lock(kn);
> -		kernfs_release_file(kn, of);
> +		kernfs_release_file(kn, of, true);
>  		mutex_unlock(mutex);
>  	}
>  
> @@ -852,7 +854,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  		}
>  
>  		if (kn->flags & KERNFS_HAS_RELEASE)
> -			kernfs_release_file(kn, of);
> +			kernfs_release_file(kn, of, false);

Why isn't this also the "last" time things are touched here?  why is it
false?


>  	}
>  
>  	WARN_ON_ONCE(on->nr_mmapped || on->nr_to_release);
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index 73f5c120def8..a7e404ff31bb 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -273,6 +273,11 @@ struct kernfs_ops {
>  	 */
>  	int (*open)(struct kernfs_open_file *of);
>  	void (*release)(struct kernfs_open_file *of);
> +	/*
> +	 * Free resources tied to the lifecycle of the file, like a
> +	 * waitqueue used for polling.
> +	 */
> +	void (*free)(struct kernfs_open_file *of);

I agree with Tejun, this needs to be documented much better and show how
you really should never need to use this :)

thanks,

greg k-h
