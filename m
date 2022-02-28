Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C84C7C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 22:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiB1VrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 16:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiB1Vq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:46:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAA38EB6C;
        Mon, 28 Feb 2022 13:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N545Bg0aT8KhLLd2OG1IQXN/AD3lvoWIlsQfgm7m5H4=; b=FtDsg516jj6CJiv/N0e6OzBDWo
        ZMMU7rd3YTKgR0GNaVUdja6mG+1gQmfik7uA562UR4atXzveJIT8+hemPPwS8o6Nofp0crAGFg9fb
        rtAWMCjLR3bJguQh7GrskS5fmHBbGfsHr85ScBp4EIDH49y2gZs4CpyO9xCwhfZVBUpCz8QuHHwvL
        J2AfBXmE3Jw6/IdrWUyEaWDELYHlCIpVM0JKPVEYg14lIbIOk8hEZm/TEtcXpBjDZuTC/pxL9U4yQ
        nqnHKwrAbFipHOHWhEOelTAsdXSQ4HMhuBiQoHWRVKGfhC40LDv+gfjuJur91Qzmoh54sSTVO40D0
        8i6bi3bA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOnqP-00EDkX-5c; Mon, 28 Feb 2022 21:46:13 +0000
Date:   Mon, 28 Feb 2022 13:46:13 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh1CpZWoWGPl0X5A@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <YfiXkk9HJpatFxnd@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfiXkk9HJpatFxnd@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:14:42AM +0000, Matthew Wilcox wrote:
> On Mon, Jan 31, 2022 at 05:33:29PM -0800, Luis Chamberlain wrote:
> > It would seem we keep tacking on things with ioctls for the block
> > layer and filesystems. Even for new trendy things like io_uring [0].
> 
> I think the problem is that it's a huge effort to add a new syscall.

As we'll all agree it should be.

> You have to get it into each architecture.  Having a single place to
> add a new syscall would help reduce the number of places we use
> multiplexor syscalls like ioctl().

Jeesh, is such a thing really possible? I wonder if Arnd has tried or
what he'd think...

I'm not arguing in favor of this, I am not sure if we want to be
encouraging new syscalls for everything. I'd agree that if its generic
perhaps so, but my own focus on this thread was block / fs.

So my hope with this thread was to encourage discussion for alternatives
to ioctls specifically for the block layer / filesystems.

> > For a few years I have found this odd, and have slowly started
> > asking folks why we don't consider alternatives like a generic
> > netlink family. I've at least been told that this is desirable
> > but no one has worked on it.
> 
> I don't know that I agree that "generic netlink" is desirable.
> I'd like to know more about the pros and cons of this idea.

Yeah it was just an idea example of a framework which does actually
get us closer to some form of real data types for what is being
supported, and which also pushes us to use kdoc.

> > Possible issues? Kernels without CONFIG_NET. Is that a deal breaker?
> > We already have a few filesystems with their own generic netlink
> > families, so not sure if this is a good argument against this.
> > 
> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family fs
> > fs/cifs/netlink.c:      ret = genl_register_family(&cifs_genl_family);
> > fs/dlm/netlink.c:       return genl_register_family(&family);
> > fs/ksmbd/transport_ipc.c:       ret = genl_register_family(&ksmbd_genl_family);
> > fs/quota/netlink.c:     if (genl_register_family(&quota_genl_family) != 0)
> 
> I'm not sure these are good arguments in favour ... other than quota,
> these are all network filesystems, which aren't much use without
> CONFIG_NET.

It's a good point.

> > mcgrof@fulton ~/linux-next (git::master)$ git grep genl_register_family drivers/block
> > drivers/block/nbd.c:    if (genl_register_family(&nbd_genl_family)) {
> 
> The, er, _network_ block device, right?

:) Sure.

  Luis
