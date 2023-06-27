Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397C07404CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 22:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjF0UQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 16:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjF0UQV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:16:21 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F74C3A8B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 13:15:50 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687896928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PBDCLg4nh1a3JNfoLT/K/WfOkVo+8mu4et1Jo0Iy2Y=;
        b=aMlkln9yD7XSwAjPGWxvEzlBoUe4vxwcU1IXTiOV15HUiysuEqAhtJGxBiPIMlvVXXsJQR
        D6FmrD7lqW0CJljVB5QFTVJcN+zhg5B6sTpWx2/bxNhCA4gstowrXOztLarilzsP56AwsE
        uG/Sm83fDJtpSt0ZGgsfGXhzbwZByLM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627201524.ool73bps2lre2tsz@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <aeb2690c-4f0a-003d-ba8b-fe06cd4142d1@kernel.dk>
 <20230627000635.43azxbkd2uf3tu6b@moria.home.lan>
 <91e9064b-84e3-1712-0395-b017c7c4a964@kernel.dk>
 <20230627020525.2vqnt2pxhtgiddyv@moria.home.lan>
 <b92ea170-d531-00f3-ca7a-613c05dcbf5f@kernel.dk>
 <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23922545-917a-06bd-ec92-ff6aa66118e2@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:16:01AM -0600, Jens Axboe wrote:
> On 6/26/23 8:59?PM, Jens Axboe wrote:
> > On 6/26/23 8:05?PM, Kent Overstreet wrote:
> >> On Mon, Jun 26, 2023 at 07:13:54PM -0600, Jens Axboe wrote:
> >>> Doesn't reproduce for me with XFS. The above ktest doesn't work for me
> >>> either:
> >>
> >> It just popped for me on xfs, but it took half an hour or so of looping
> >> vs. 30 seconds on bcachefs.
> > 
> > OK, I'll try and leave it running overnight and see if I can get it to
> > trigger.
> 
> I did manage to reproduce it, and also managed to get bcachefs to run
> the test. But I had to add:
> 
> diff --git a/check b/check
> index 5f9f1a6bec88..6d74bd4933bd 100755
> --- a/check
> +++ b/check
> @@ -283,7 +283,7 @@ while [ $# -gt 0 ]; do
>  	case "$1" in
>  	-\? | -h | --help) usage ;;
>  
> -	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> +	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-bcachefs)
>  		FSTYP="${1:1}"
>  		;;
>  	-overlay)

I wonder if this is due to an upstream fstests change I haven't seen
yet, I'll have a look.

> to ktest/tests/xfstests/ and run it with -bcachefs, otherwise it kept
> failing because it assumed it was XFS.
> 
> I suspected this was just a timing issue, and it looks like that's
> exactly what it is. Looking at the test case, it'll randomly kill -9
> fsstress, and if that happens while we have io_uring IO pending, then we
> process completions inline (for a PF_EXITING current). This means they
> get pushed to fallback work, which runs out of line. If we hit that case
> AND the timing is such that it hasn't been processed yet, we'll still be
> holding a file reference under the mount point and umount will -EBUSY
> fail.
> 
> As far as I can tell, this can happen with aio as well, it's just harder
> to hit. If the fput happens while the task is exiting, then fput will
> end up being delayed through a workqueue as well. The test case assumes
> that once it's reaped the exit of the killed task that all files are
> released, which isn't necessarily true if they are done out-of-line.

Yeah, I traced it through to the delayed fput code as well.

I'm not sure delayed fput is responsible here; what I learned when I was
tracking this down has mostly fell out of my brain, so take anything I
say with a large grain of salt. But I believe I tested with delayed_fput
completely disabled, and found another thing in io_uring with the same
effect as delayed_fput that wasn't being flushed.

> For io_uring specifically, it may make sense to wait on the fallback
> work. The below patch does this, and should fix the issue. But I'm not
> fully convinced that this is really needed, as I do think this can
> happen without io_uring as well. It just doesn't right now as the test
> does buffered IO, and aio will be fully sync with buffered IO. That
> means there's either no gap where aio will hit it without O_DIRECT, or
> it's just small enough that it hasn't been hit.

I just tried your patch and I still have generic/388 failing - it
might've taken a bit longer to pop this time.

I wonder if there might be a better way of solving this though? For aio,
when a process is exiting we just synchronously tear down the ioctx,
including waiting for outstanding iocbs.

delayed_fput, even though I believe not responsible here, seems sketchy
to me because there doesn't seem to be a straightforward way to flush
delayed fputs for a given _process_ - there's a single global work item,
and we can only flush globally.

Would what aio does work here?

(disclaimer: I haven't studied the io_uring code so I haven't figured
out the approach your patch is taking yet)
