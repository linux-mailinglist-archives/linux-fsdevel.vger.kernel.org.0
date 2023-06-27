Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C973F705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 10:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjF0IZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 04:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjF0IYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:24:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A35212B;
        Tue, 27 Jun 2023 01:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DE2060FD8;
        Tue, 27 Jun 2023 08:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA386C433CA;
        Tue, 27 Jun 2023 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687854263;
        bh=PN+dhNU90c6TSMh3/nk0lQ0xTCk2Ol9fv6nVZ+3C3Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzpntFt4cDFZqdnwrhYYQu9Rl/AdiT/dgFwqBf9uhifEdWwBRB/S7RkW/lNEObdOD
         veTLCh6DRqPTzJ6vgmoz+qoJmY6o62HH07i2GPye7qgYSTjk/7HbebRORp60zwhyKq
         klfDw2Se8as5Kw0aL3AoWUhdQtPNPqzCykvpI6NNE/wnjUpFICvXM/jzQwClGPNnoJ
         aN2t25b2FEPFSitFyPrzZdY2Y507lIck+lAdzzqbrgRFrVBh6tK5laCYTAPUdiXXL2
         iLwRq19wb4oxMX/6BgEZyFIOcrsUg+4YGFRpNKVtFQhzDAaOWSSZ3udpE9ORPNxRK/
         WDbv8eOaCDkPw==
Date:   Tue, 27 Jun 2023 10:24:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, gregkh@linuxfoundation.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <20230627-kanon-hievt-bfdb583ddaa6@brauner>
References: <20230626201713.1204982-1-surenb@google.com>
 <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 10:31:49AM -1000, Tejun Heo wrote:
> On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > index 73f5c120def8..a7e404ff31bb 100644
> > --- a/include/linux/kernfs.h
> > +++ b/include/linux/kernfs.h
> > @@ -273,6 +273,11 @@ struct kernfs_ops {
> >  	 */
> >  	int (*open)(struct kernfs_open_file *of);
> >  	void (*release)(struct kernfs_open_file *of);
> > +	/*
> > +	 * Free resources tied to the lifecycle of the file, like a
> > +	 * waitqueue used for polling.
> > +	 */
> > +	void (*free)(struct kernfs_open_file *of);
> 
> I think this can use a bit more commenting - ie. explain that release may be
> called earlier than the actual freeing of the file and how that can lead to
> problems. Othre than that, looks fine to me.

It seems the more natural thing to do would be to introduce a ->drain()
operation and order it before ->release(), no?
