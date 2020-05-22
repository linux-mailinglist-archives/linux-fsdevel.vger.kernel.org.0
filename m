Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DED11DECC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbgEVQIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 12:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgEVQIR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 12:08:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF3AC061A0E;
        Fri, 22 May 2020 09:08:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jcADX-00Da8N-70; Fri, 22 May 2020 16:08:15 +0000
Date:   Fri, 22 May 2020 17:08:15 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ovl: make private mounts longterm
Message-ID: <20200522160815.GT23230@ZenIV.linux.org.uk>
References: <20200522085723.29007-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522085723.29007-1-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 10:57:23AM +0200, Miklos Szeredi wrote:
> Overlayfs is using clone_private_mount() to create internal mounts for
> underlying layers.  These are used for operations requiring a path, such as
> dentry_open().
> 
> Since these private mounts are not in any namespace they are treated as
> short term, "detached" mounts and mntput() involves taking the global
> mount_lock, which can result in serious cacheline pingpong.
> 
> Make these private mounts longterm instead, which trade the penalty on
> mntput() for a slightly longer shutdown time due to an added RCU grace
> period when putting these mounts.
> 
> Introduce a new helper kern_unmount_many() that can take care of multiple
> longterm mounts with a single RCU grace period.

Umm...

1) Documentation/filesystems/porting - something along the lines
of "clone_private_mount() returns a longterm mount now, so the proper
destructor of its result is kern_unmount()"

2) the name kern_unmount_many() has an unfortunate clash with
fput_many(), with arguments that look similar and mean something
entirely different.  How about kern_unmount_array()?

3)
> -	mntput(ofs->upper_mnt);
> -	for (i = 1; i < ofs->numlayer; i++) {
> -		iput(ofs->layers[i].trap);
> -		mntput(ofs->layers[i].mnt);
> +
> +	if (!ofs->layers) {
> +		/* Deal with partial setup */
> +		kern_unmount(ofs->upper_mnt);
> +	} else {
> +		/* Hack!  Reuse ofs->layers as a mounts array */
> +		struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
> +
> +		for (i = 0; i < ofs->numlayer; i++) {
> +			iput(ofs->layers[i].trap);
> +			mounts[i] = ofs->layers[i].mnt;
> +		}
> +		kern_unmount_many(mounts, ofs->numlayer);
> +		kfree(ofs->layers);

That's _way_ too subtle.  AFAICS, you rely upon ->upper_mnt == ->layers[0].mnt,
->layers[0].trap == NULL, without even mentioning that.  And the hack you do
mention...  Yecchhh...  How many layers are possible, again?
