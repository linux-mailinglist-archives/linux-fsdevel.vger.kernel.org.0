Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57405B38B5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIINN6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 09:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiIINN5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:13:57 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5A3719E;
        Fri,  9 Sep 2022 06:13:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 130792045; Fri,  9 Sep 2022 09:13:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 130792045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1662729236;
        bh=rJg8KreJCBLlbOSbA81HfdmeNkeHmTjwnB8MS5F2HS8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Napy9rfH0y46dso4O3L1OjcbWruSJc1fI+BPvZBW2P6SCYKi49faWIXUmnvZWENBc
         n/u3lq/6R1MnQxJLEJQeNe6riBIdiMYkWu4j4qSHm7nsFQkgKD7YKmdLMRPv2ETv5f
         wPNsJb82RZV6gHlkBnKtD8kAEXVaY5gDbjAqzjdI=
Date:   Fri, 9 Sep 2022 09:13:55 -0400
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        battery dude <jyf007@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>
Subject: Re: Does NFS support Linux Capabilities
Message-ID: <20220909131355.GA5674@fieldses.org>
References: <CAMBbDaF2Ni0gMRKNeFTQwgAOPPYy7RLXYwDJyZ1edq=tfATFzw@mail.gmail.com>
 <1D8F1768-D42A-4775-9B0E-B507D5F9E51E@oracle.com>
 <YxsGIoFlKkpQdSDY@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxsGIoFlKkpQdSDY@mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 09, 2022 at 05:23:46AM -0400, Theodore Ts'o wrote:
> On Thu, Sep 08, 2022 at 08:24:02PM +0000, Chuck Lever III wrote:
> > Given these enormous challenges, who would be willing to pay for
> > standardization and implementation? I'm not saying it can't or
> > shouldn't be done, just that it would be a mighty heavy lift.
> > But maybe other folks on the Cc: list have ideas that could
> > make this easier than I believe it to be.
> 
> ... and this is why the C2 by '92 initiative was doomed to failure,
> and why Posix.1e never completed the standardization process.  :-)
> 
> Honestly, capabilities are super coarse-grained, and I'm not sure they
> are all that useful if we were create blank slate requirements for a
> modern high-security system.  So I'm not convinced the costs are
> sufficient to balance the benefits.

I seem to recall the immediate practical problem people have hit is that
some rpms will fail if it can't set file capabilities.  So in practice
NFS may not work any more for root filesystems.  Maybe there's some
workaround.

Taking a quick look at my laptop, there's not as many as I expected:

[root@parkour bfields]# getcap -r /usr
/usr/bin/arping cap_net_raw=p
/usr/bin/clockdiff cap_net_raw=p
/usr/bin/dumpcap cap_net_admin,cap_net_raw=ep
/usr/bin/newgidmap cap_setgid=ep
/usr/bin/newuidmap cap_setuid=ep
/usr/sbin/mtr-packet cap_net_raw=ep
/usr/sbin/suexec cap_setgid,cap_setuid=ep

--b.
