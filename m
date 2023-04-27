Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431186F0367
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 11:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbjD0J2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 05:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243357AbjD0J2k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:28:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4785DC3
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 02:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D74D6639D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Apr 2023 09:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0450C433A4;
        Thu, 27 Apr 2023 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682587711;
        bh=UnHn+YtAc/wU+d/5ukiUKtKSMVRXThfe+Kv7ab/gX3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ekthNoQlAaRr1yeLw6JlrHKDxirYQ+urqx7HizsoghHS8Rquw39Xp0ZAoP4G0LvcJ
         z2LAgVL45phgM9AHLAvtFfZ5CpryQhAVMtTz/Q8biSbSmS9iB68ZqFjq2LJL7RyEco
         KMmGqR9oHEAnk8tQHqA/sYGNYDpwe0G6JXZkMUvpoSzsGYP+lqpvLVEU2K06APdpST
         MmSon40+HYVIvVjiE3NBF+oA9a3V7l6f318MryuMSfoGallIqrgeNwLxtILKcuBlqM
         2n3TgKyylZ12uV22ul+jSn0tGzHhjx3hqdMMaFOy0DR0skvSFLjnIlQnj+Oafv/TJx
         K6kKDk+gV9PGw==
Date:   Thu, 27 Apr 2023 11:28:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "Kernel.org Bugbot" <bugbot@kernel.org>
Cc:     bugs@lists.linux.dev, willy@infradead.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: large pause when opening file descriptor which is power of 2
Message-ID: <20230427-arbeit-davor-6b1b48bc555a@brauner>
References: <ZEl34WthS8UNJnNd@casper.infradead.org>
 <20230426-b217366c6-4f880518247a@bugzilla.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230426-b217366c6-4f880518247a@bugzilla.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:42:01PM +0000, Kernel.org Bugbot wrote:
> phemmer+kernel writes via Kernel.org Bugzilla:
> 
> (In reply to Bugbot from comment #1)
> > Matthew Wilcox <willy@infradead.org> writes:
> > 
> > On Wed, Apr 26, 2023 at 05:58:06PM +0000, Kernel.org Bugbot wrote:
> > > When running a threaded program, and opening a file descriptor that
> > > is a power of 2 (starting at 64), the call takes a very long time to
> > > complete. Normally such a call takes less than 2us. However with this
> > > issue, I've seen the call take up to around 50ms. Additionally this only
> > > happens the first time, and not subsequent times that file descriptor is
> > > used. I'm guessing there might be some expansion of some internal data
> > > structures going on. But I cannot see why this process would take so long.
> > 
> > Because we allocate a new block of memory and then memcpy() the old
> > block of memory into it.  This isn't surprising behaviour to me.
> > I don't think there's much we can do to change it (Allocating a
> > segmented array of file descriptors has previously been vetoed by
> > people who have programs with a million file descriptors).  Is it
> > causing you problems?
> 
> Yes. I'm using using sockets for IPC. Specifically haproxy with its SPOE protocol. Low latency is important. Normally a call (including optional connect if a new connection is needed) will easily complete in under 100us. So I want to set a timeout of 1ms to avoid blocking traffic. However because this issue effectively randomly pops up, that 1ms timeout is too low, and the issue can actually impact multiple in-flight requests because haproxy tries to share that one IPC connection for them all. But if I raise the timeout (and I'd have to raise it to something like 100ms, as I've seen delays up to 47ms in just light testing), then I run the risk of significantly impacting traffic if there is a legitimate slowdown. While a low timeout and the occasional failure is probably the better of the two options, I'd prefer not to fail at all.

I wonder if you could use io_uring for this. The problem sounds a lot
like it could be solved by using the fixed file descriptor feature. The
async and linking operation nature of it might be rather valuable for
this as well...
