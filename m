Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC587224BE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 13:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjFELh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 07:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjFELhw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F77F3;
        Mon,  5 Jun 2023 04:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98AD622E2;
        Mon,  5 Jun 2023 11:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B00FC433D2;
        Mon,  5 Jun 2023 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685965065;
        bh=g1Jm1kuE6FZy6aQlpylRVCnAlYFy7qHWSvUkJ8cHFlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8yGl7XeFHkjPAfdT1VFrpKf2/2wku2VGX1YfYyqc60jQatjY23mPzUNAlGt44HGi
         7TNlyb8iGY1PSlAt8kdkSYa0QcI0BK02UvE8XdZomTHqp3cThBwDs+c+W8VBAIgURd
         X+5Gy5a3AhoRjY51ktZhmGirZaxcMCTHtSGvzgFPQikFw9vcA8T3yJsnrvXgoQ1oDk
         8giNz731+MJgyCIRr3yB003IzTXnJHG2j0M0UWDqHTa5s6390u4J2yqsm9+pLzspgl
         DaYduXtr+m1F2tmVhhOG8B9bEglyuNLkqX3ZmFgfIxt8JzFFHAAJeYNgmMgK9a48ip
         AyO5oysj9UtFQ==
Date:   Mon, 5 Jun 2023 13:37:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: uuid ioctl - was: Re: [PATCH] overlayfs: Trigger file
 re-evaluation by IMA / EVM after writes
Message-ID: <20230605-allgegenwart-bellt-e05884aab89a@brauner>
References: <20230407-trasse-umgearbeitet-d580452b7a9b@brauner>
 <078d8c1fd6b6de59cde8aa85f8e59a056cb78614.camel@linux.ibm.com>
 <20230520-angenehm-orangen-80fdce6f9012@brauner>
 <ZGqgDjJqFSlpIkz/@dread.disaster.area>
 <20230522-unsensibel-backblech-7be4e920ba87@brauner>
 <20230602012335.GB16848@frogsfrogsfrogs>
 <20230602042714.GE1128744@mit.edu>
 <ZHmNksPcA9tudSVQ@dread.disaster.area>
 <20230602-dividende-model-62b2bdc073cf@brauner>
 <ZH0XVWBqs9zJF69X@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZH0XVWBqs9zJF69X@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 08:59:33AM +1000, Dave Chinner wrote:
> On Fri, Jun 02, 2023 at 03:52:16PM +0200, Christian Brauner wrote:
> > On Fri, Jun 02, 2023 at 04:34:58PM +1000, Dave Chinner wrote:
> > > On Fri, Jun 02, 2023 at 12:27:14AM -0400, Theodore Ts'o wrote:
> > > > On Thu, Jun 01, 2023 at 06:23:35PM -0700, Darrick J. Wong wrote:
> > > There's an obvious solution: a newly provisioned filesystem needs to
> > > change the uuid at first mount. The only issue is the
> > > kernel/filesystem doesn't know when the first mount is.
> > > 
> > > Darrick suggested "mount -o setuuid=xxxx" on #xfs earlier, but that
> > > requires changing userspace init stuff and, well, I hate single use
> > > case mount options like this.
> > > 
> > > However, we have a golden image that every client image is cloned
> > > from. Say we set a special feature bit in that golden image that
> > > means "need UUID regeneration". Then on the first mount of the
> > > cloned image after provisioning, the filesystem sees the bit and
> > > automatically regenerates the UUID with needing any help from
> > > userspace at all.
> > > 
> > > Problem solved, yes? We don't need userspace to change the uuid on
> > > first boot of the newly provisioned VM - the filesystem just makes
> > > it happen.
> > 
> > systemd-repart implements the following logic currently: If the GPT
> > *partition* and *disk* UUIDs are 0 then it will generate new UUIDs
> > before the first mount.
> > 
> > So for the *filesystem* UUID I think the golden image should either have
> > the UUID set to zero as well or to a special UUID. Either way, it would
> > mean the filesystem needs to generate a new UUID when it is mounted the
> > first time.
> > 
> > If we do this then all filesystems that support this should use the same
> > value to indicate "generate new UUID".
> 
> Ok, the main problem here is that all existing filesystem
> implementations don't consider a zero UUID special. If you do this
> on an existing kernel, it won't do anything and will not throw any
> errors. Now we have the problem that userspace infrastructure can't
> rely on the kernel telling it that it doesn't support the
> functionality it is relying on. i.e. we have a mounted filesystems
> and now userspace has to detect and handle the fact it still needs
> to change the filesystem UUID.
> 
> Further, if this is not handled properly, every root filesystem
> having a zero or duplicate "special" UUID is a landmine for OS
> kernel upgrades to trip over. i.e. upgrade from old, unsupported to
> new supported kernel and the next boot regens the UUID unexpectedly
> and breaks anything relying on the old UUID.
> 
> Hence the point of using a feature bit is that the kernel will
> refuse to mount the filesysetm if it does not understand the feature
> bit. This way we have a hard image deployment testing failure that people
> building and deploying images will notice. Hence they can configure
> the build scripts to use the correct "change uuid" mechanism
> with older OS releases and can take appropriate action when building
> "legacy OS" images.
> 
> Yes, distros and vendors can backport the feature bit support if
> they want, and then deployment of up-to-date older OS releases will
> work with this new infrastructure correctly. But that is not
> guaranteed to happen, so we really need a hard failure for
> unsupported kernels.
> 
> So, yeah, I really do think this needs to be driven by a filesystem
> feature bit, not retrospectively defining a special UUID value to
> trigger this upgrade behaviour...

Using a zero/special UUID would have made this usable for most
filesystems which allows userspace to more easily detect this. Using a
filesystem feature bit makes this a lot more fragmented between
filesystems.

But allowing to refuse being mounted on older kernels when the feature
bit is set and unknown can be quite useful. So this is also fine by me.

So, the protocol should be to create a filesystem with a zero UUID and
the new feature bit set. At the first mount the UUID will be generated.

Only thing I would really love to see is a short blurb about this in
Documentation/filesystems/uuid.rst so we have a reference point for how
we expect this to work and how a filesystem should implement this.
