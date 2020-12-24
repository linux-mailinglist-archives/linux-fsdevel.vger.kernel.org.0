Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2B92E26B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Dec 2020 13:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgLXMOi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Dec 2020 07:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgLXMOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Dec 2020 07:14:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C48C06179C;
        Thu, 24 Dec 2020 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ifO2Z41UF/ZdXjDCo5wL8aXgOUw3K83yCcmilFeONd8=; b=J4sz+5UcNIflCLTVeCfClavL70
        sYTuvVbC1vbi1wUVFepnDPTYAaMqiXlJ4lKmAANmUAs1LS1KS3+oOWf/MrIJZ93DMAgLmKBkczCNX
        9UZ5afuYzKyUMEgCD0dGsVULGDstM4r5nrh1VUR5+VghVXUGLavMRr3xSes9DAVmkRB6Cc42dCAzt
        aki6C2pQiaM2s0G0rBdUndm+vm/kRMnDxZePRsQbUv2Mitkoqb51C4VWEf2xycHkuviUUlzq+oQqT
        7sh9/4EGb3T138Pn1PZ0Swy91ONGqLCoiuVZrZcugMwflgPAy7Qqlvh0ni9NT3PgsnnS/UnFu3UgZ
        Dt2M8D3w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ksPVA-0002V2-SM; Thu, 24 Dec 2020 12:13:52 +0000
Date:   Thu, 24 Dec 2020 12:13:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201224121352.GT874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org>
 <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org>
 <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org>
 <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 24, 2020 at 11:32:55AM +0200, Amir Goldstein wrote:
> In current master, syncfs() on any file by any container user will
> result in full syncfs() of the upperfs, which is very bad for container
> isolation. This has been partly fixed by Chengguang Xu [1] and I expect
> his work will be merged soon. Overlayfs still does not do the writeback
> and syncfs() in overlay still waits for all upper fs writeback to complete,
> but at least syncfs() in overlay only kicks writeback for upper fs files
> dirtied by this overlay.
> 
> [1] https://lore.kernel.org/linux-unionfs/CAJfpegsbb4iTxW8ZyuRFVNc63zg7Ku7vzpSNuzHASYZH-d5wWA@mail.gmail.com/
> 
> Sharing the same SEEN flag among thousands of containers is also
> far from ideal, because effectively this means that any given workload
> in any single container has very little chance of observing the SEEN flag.

Perhaps you misunderstand how errseq works.  If each container samples
the errseq at startup, then they will all see any error which occurs
during their lifespan (and possibly an error which occurred before they
started up).

> To this end, I do agree with Matthew that overlayfs should sample errseq
> and the best patchset to implement it so far IMO is Jeff's patchset [2].
> This patch set was written to cater only "volatile" overlayfs mount, but
> there is no reason not to use the same mechanism for regular overlay
> mount. The only difference being that "volatile" overlay only checks for
> error since mount on syncfs() (because "volatile" overlay does NOT
> syncfs upper fs) and regular overlay checks and advances the overlay's
> errseq sample on syncfs (and does syncfs upper fs).
> 
> Matthew, I hope that my explanation of the use case and Jeff's answer
> is sufficient to understand why the split of the SEEN flag is needed.
> 
> [2] https://lore.kernel.org/linux-unionfs/20201213132713.66864-1-jlayton@kernel.org/

No, it still feels weird and wrong.

