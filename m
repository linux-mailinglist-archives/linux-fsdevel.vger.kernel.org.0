Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F046A4E5347
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 14:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiCWNjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 09:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbiCWNjp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8E35F8D6;
        Wed, 23 Mar 2022 06:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3593B81F13;
        Wed, 23 Mar 2022 13:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EFBC340E8;
        Wed, 23 Mar 2022 13:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648042690;
        bh=FS4rMUgYm98K72DS/l0zV5frCfm1kqj/zcgo/7pabXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT3Ze9V22MkpJEe9f7BnjRn/vnsga2B9nHBVD0kV8zKLTi+VEroCdcjGzZlWKuHYJ
         1gyqGo/IrlVtRZkznGfLmYBmgt2Uworm16hjtXdDeQl+39jWHRbUTf26ct9hOH0/uG
         er6PCviMcAqG8oVa0XLsFb3EYWzzpovOYPuNPGhM=
Date:   Wed, 23 Mar 2022 14:38:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <Yjsiv2XesJRzoeTW@kroah.com>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:24:40PM +0100, Miklos Szeredi wrote:
> On Wed, 23 Mar 2022 at 12:43, Christian Brauner <brauner@kernel.org> wrote:
> 
> > Yes, we really need a way to query for various fs information. I'm a bit
> > torn about the details of this interface though. I would really like if
> > we had interfaces that are really easy to use from userspace comparable
> > to statx for example.
> 
> The reason I stated thinking about this is that Amir wanted a per-sb
> iostat interface and dumped it into /proc/PID/mountstats.  And that is
> definitely not the right way to go about this.
> 
> So we could add a statfsx() and start filling in new stuff, and that's
> what Linus suggested.  But then we might need to add stuff that is not
> representable in a flat structure (like for example the stuff that
> nfs_show_stats does) and that again needs new infrastructure.
> 
> Another example is task info in /proc.  Utilities are doing a crazy
> number of syscalls to get trivial information.  Why don't we have a
> procx(2) syscall?  I guess because lots of that is difficult to
> represent in a flat structure.  Just take the lsof example: tt's doing
> hundreds of thousands of syscalls on a desktop computer with just a
> few hundred processes.
> 
> So I'm trying to look beyond fsinfo and about how we could better
> retrieve attributes, statistics, small bits and pieces within a
> unified framework.
> 
> The ease of use argument does not really come into the picture here,
> because (unlike stat and friends) most of this info is specialized and
> will be either consumed by libraries, specialized utilities
> (util-linux, procos) or with a generic utility application that can
> query any information about anything that is exported through such an
> interface.    That applies to plain stat(2) as well: most users will
> not switch to statx() simply because that's too generic.  And that's
> fine, for info as common as struct stat a syscall is warranted.  If
> the info is more specialized, then I think a truly generic interface
> is a much better choice.
> 
> >  I know having this generic as possible was the
> > goal but I'm just a bit uneasy with such interfaces. They become
> > cumbersome to use in userspace. I'm not sure if the data: part for
> > example should be in this at all. That seems a bit out of place to me.
> 
> Good point, reduction of scope may help.
> 
> > Would it be really that bad if we added multiple syscalls for different
> > types of info? For example, querying mount information could reasonably
> > be a more focussed separate system call allowing to retrieve detailed
> > mount propagation info, flags, idmappings and so on. Prior approaches to
> > solve this in a completely generic way have gotten us not very far too
> > so I'm a bit worried about this aspect too.
> 
> And I fear that this will just result in more and more ad-hoc
> interfaces being added, because a new feature didn't quite fit the old
> API.  You can see the history of this happening all over the place
> with multiple new syscall versions being added as the old one turns
> out to be not generic enough.
> 
> I think a new interface needs to
> 
>   - be uniform (a single utility can be used to retrieve various
> attributes and statistics, contrast this with e.g. stat(1),
> getfattr(1), lsattr(1) not to mention various fs specific tools).
> 
>  - have a hierarchical namespace (the unix path lookup is an example
> of this that stood the test of time)
> 
>  - allow retrieving arbitrary text or binary data
> 
> And whatever form it takes, I'm sure it will be easier to use than the
> mess we currently have in various interfaces like the mount or process
> stats.

This has been proposed in the past a few times.  Most recently by the
KVM developers, which tried to create a "generic" api, but ended up just
making something to work for KVM as they got tired of people ignoring
their more intrusive patch sets.  See virt/kvm/binary_stats.c for what
they ended up with, and perhaps you can just use that same type of
interface here as well?

thanks,

greg k-h
