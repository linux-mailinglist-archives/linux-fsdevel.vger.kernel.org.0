Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D132D9095
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 21:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405936AbgLMUcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 15:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLMUcY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 15:32:24 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA19C0613CF
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 12:31:44 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id y5so14929603iow.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Dec 2020 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mO3ZqJhIxbX7vTpYatbvJAJX21HijBHzkIVlmrXK3lU=;
        b=DRChml0JHiiHpFk9nZsbvlo4dk8fWQ0V6GwcpyXiboV13ckYTUIDNZyPeNMRkfCgU/
         3Stz4zrI+bnW6TFfle/1/96abeqGp3xdsm6IYYnHM9wpycBW0N26cpUxLBMnty3Z/SKu
         FfKS0a+s1fMDswVfHQ0fpQHMjavk2U4bGDAOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mO3ZqJhIxbX7vTpYatbvJAJX21HijBHzkIVlmrXK3lU=;
        b=NmRF8EppQCRyY0UZOV44q1joU3G8soC6DyrdjYKVAHqNQ5Wx5e0ufPUTHq0FSTk1wG
         A5k+ObwPKkdPm7SYXBa72B4tiQRs5K7gHMnlb6w9P0AlgOUYMYEz/vXztiiPtu9TOX7F
         s3vtutQquqw5oKTtMbCa4dJd7wLYLJ0ly7dD8sPgfkJ99dujCH5ZS4m2fivzYo8UwQ7W
         IBre40cDSBHUpbJ7/tXLcAX6NnU3zIzoAkXzUI7fpzKkDDakQMBYKIPS6FmZHEF5NWmr
         XMfKGmvym3wZjqspSn55eCVOCXA2NCYwbyOS6gQFfhWdVGXBtIuo9IEjxvf/lq0sxByI
         P9gg==
X-Gm-Message-State: AOAM532maE0HfGf0Haqcy9g5IqbbZl60fdFhD0upAFoWRwcAwLyFGu9F
        0QBK4BO5MyJd6kq+I7NfeirWCg==
X-Google-Smtp-Source: ABdhPJzPsdgGoMifz1+dZBzqynk5KJactRDboFL5nKfQxw7Jd3vqxqf6Y3PoKej13yu2e2vxGXWtvw==
X-Received: by 2002:a02:c981:: with SMTP id b1mr28944142jap.6.1607891503932;
        Sun, 13 Dec 2020 12:31:43 -0800 (PST)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id m8sm8098882ioh.16.2020.12.13.12.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Dec 2020 12:31:43 -0800 (PST)
Date:   Sun, 13 Dec 2020 20:31:41 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 0/2] errseq+overlayfs: accomodate the volatile upper
 layer use-case
Message-ID: <20201213203140.GC8562@ircssh-2.c.rugged-nimbus-611.internal>
References: <20201213132713.66864-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213132713.66864-1-jlayton@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 08:27:11AM -0500, Jeff Layton wrote:
> What about this as an alternate approach to the problem that Sargun has
> been working on? I have some minor concerns about the complexity of
> managing a stateful object across two different words. That can be
> done, but I think this may be simpler.
> 
> This set steals an extra flag bit from the errseq_t counter so that we
> have two flags: one indicating whether to increment the counter at set
> time, and another to indicate whether the error has been reported to
> userland.
> 

This approach works, and I believe you suggested it early on, but I was unsure
whether it was okay to use another bit for state information.

> This should give you the semantics you want in the syncfs case, no?  If
> this does look like it's a suitable approach, then I'll plan to clean up
> the comments and docs.
> 
From a raw semantics perspective, this looks correct, and it looks like we could
stash it as well for later reference (there's no going backwards, and....well,
2**19 errors is unlikely.). We do ~10s of overlayfs mounts / sec at peak,
but even then we usually see a single disk error on a machine before it fails,
I'm not sure if in the field people get more churn out of the errseq than that.


> I have a vague feeling that this might help us eventually kill the
> AS_EIO and AS_ENOSPC bits too, but that would require a bit more work to
> plumb in "since" samples at appropriate places.
> 
> Jeff Layton (2):
>   errseq: split the SEEN flag into two new flags
>   overlayfs: propagate errors from upper to overlay sb in sync_fs
> 
>  fs/overlayfs/ovl_entry.h |  1 +
>  fs/overlayfs/super.c     | 14 +++++++--
>  include/linux/errseq.h   |  2 ++
>  lib/errseq.c             | 64 +++++++++++++++++++++++++++++++++-------
>  4 files changed, 67 insertions(+), 14 deletions(-)
> 
> -- 
> 2.29.2
> 
