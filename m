Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D9740229
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjF0Rah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjF0Rag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:30:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EB198;
        Tue, 27 Jun 2023 10:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0832A611E6;
        Tue, 27 Jun 2023 17:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E3DC433C0;
        Tue, 27 Jun 2023 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687887034;
        bh=r04FJeB+aVXEw3+VGzeA7ERawnho+uOP3FnxGvrlWnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s4MdskLJ54XjiMB1gziJh03q8HBOOaMEQYrKbSeLtPzGx7CVDZmefNksLr1VuttCw
         VocNJzH21DpjkIvSqD6WFj/ezDfvYxcmMCwmPFCq64qXRoJY2ovikFcDbBpfOIcVkg
         lQJBAj6tXa0FJy9lgBa+RViZrkgqrPB2Z60V+6LZElVVd9TvrUrnk8WlnY3ySQOmQg
         eKZKUzo58KMKbWg1ApS9nYLBoqkmjHVvkYGulhVPNq99hPCisjEV6SIXbPW7j+tOMM
         kYS6Gutrml5ebMAfJkozqeIqsmPQXjQZnBS+6WDG3xE/PpF7vXB9HsE36DEG20y9EV
         +ftnEtEcw+D3A==
Date:   Tue, 27 Jun 2023 19:30:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, gregkh@linuxfoundation.org,
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
Message-ID: <20230627-ausgaben-brauhaus-a33e292558d8@brauner>
References: <20230626201713.1204982-1-surenb@google.com>
 <ZJn1tQDgfmcE7mNG@slm.duckdns.org>
 <20230627-kanon-hievt-bfdb583ddaa6@brauner>
 <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpECKqYiekDK6Zw58w10n1T4Q3R+2nymfHX2ZGfQVDC3VQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:09:27AM -0700, Suren Baghdasaryan wrote:
> On Tue, Jun 27, 2023 at 1:24 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Jun 26, 2023 at 10:31:49AM -1000, Tejun Heo wrote:
> > > On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > > > diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> > > > index 73f5c120def8..a7e404ff31bb 100644
> > > > --- a/include/linux/kernfs.h
> > > > +++ b/include/linux/kernfs.h
> > > > @@ -273,6 +273,11 @@ struct kernfs_ops {
> > > >      */
> > > >     int (*open)(struct kernfs_open_file *of);
> > > >     void (*release)(struct kernfs_open_file *of);
> > > > +   /*
> > > > +    * Free resources tied to the lifecycle of the file, like a
> > > > +    * waitqueue used for polling.
> > > > +    */
> > > > +   void (*free)(struct kernfs_open_file *of);
> > >
> > > I think this can use a bit more commenting - ie. explain that release may be
> > > called earlier than the actual freeing of the file and how that can lead to
> > > problems. Othre than that, looks fine to me.
> >
> > It seems the more natural thing to do would be to introduce a ->drain()
> > operation and order it before ->release(), no?
> 
> I assume you mean we should add a ->drain() operation and call it when
> kernfs_drain_open_files()  causes kernfs_release_file()? That would
> work but if any existing release() handler counts on the current
> behavior (release() being called while draining) then we should find
> and fix these. Hopefully they don't really depend on the current
> behavior but I dunno.

Before I wrote that I did a naive

        > git grep -A 20 kernfs_ops | grep \\.release
        kernel/cgroup/cgroup.c- .release                = cgroup_file_release,
        kernel/cgroup/cgroup.c- .release                = cgroup_file_release,

which only gave cgroup_release_file(). Might be I'm missing some convoluted
callchains though or macro magic...

->release() was added in

    commit 0e67db2f9fe91937e798e3d7d22c50a8438187e1
    kernfs: add kernfs_ops->open/release() callbacks

    Add ->open/release() methods to kernfs_ops.  ->open() is called when
    the file is opened and ->release() when the file is either released or
    severed.  These callbacks can be used, for example, to manage
    persistent caching objects over multiple seq_file iterations.

    Signed-off-by: Tejun Heo <tj@kernel.org>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Acked-by: Acked-by: Zefan Li <lizefan@huawei.com>


which mentions "either releases or severed" which imho already points to
separate methods.
