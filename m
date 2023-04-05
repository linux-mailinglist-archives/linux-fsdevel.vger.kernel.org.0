Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5365B6D7764
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 10:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbjDEIzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjDEIzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:55:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D22D72
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 01:55:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B8C062490
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 08:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30748C433EF;
        Wed,  5 Apr 2023 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680684946;
        bh=olSKq5vO0n0Jlgmzdd57y9Bt9KmPhDNgNTZhSI9v8fg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+U30hj0ijDnXTxznvQaQFJO7IEmn97nnWPhWaqWx1aGPLFPRd/szxQ6J/hMdpQSP
         H9LjiE7aSRkbczbYt2JhWAEwKbgWZnXaYWtf5vh2G1fET/b5AupPx1ZNTV0aPY6aMT
         DSig1eNXVzDuJFBS92qw4FJdxUA+RuVQF/ZEHXt3LUNXNQIBz+Xnxz7HRrV2415C+l
         lzjN/xn/rTl2J1Zfj5cvf4+FoaxxyE3yCh0EZ+EgOqPVshyyxSpCi7k9dvHq2wxxbG
         eUZBNe75l6rWsJMy17iISVrcOkwHHudawx0rktWpEsCcqMYin+pRqFkXFFrpbYYgww
         K+yrXl2u/21vg==
Date:   Wed, 5 Apr 2023 10:55:39 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Karel Zak <kzak@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>,
        Tom Moyer <tom.moyer@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Leif Sahlberg <lsahlber@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        NeilBrown <neilb@suse.com>, Steve Dickson <steved@redhat.com>
Subject: Re: [RFC PATCH] Legacy mount option "sloppy" support
Message-ID: <20230405-geldregen-jenseits-6fa53a60b729@brauner>
References: <167963629788.253682.5439077048343743982.stgit@donald.themaw.net>
 <20230328184815.ycgxqen7difgnjt3@ws.net.home>
 <27b8d5a5-9ab9-c418-ce9c-0faf90677bde@themaw.net>
 <20230403-disarm-awhile-621819599ecb@brauner>
 <a5581bc7-c522-33a1-4e11-31b71bafd8cc@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5581bc7-c522-33a1-4e11-31b71bafd8cc@themaw.net>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 04, 2023 at 09:52:27AM +0800, Ian Kent wrote:
> On 3/4/23 21:08, Christian Brauner wrote:
> > On Wed, Mar 29, 2023 at 09:03:51AM +0800, Ian Kent wrote:
> > > On 29/3/23 02:48, Karel Zak wrote:
> > > > On Fri, Mar 24, 2023 at 01:39:09PM +0800, Ian Kent wrote:
> > > > > Karel do you find what I'm saying is accurate?
> > > > > Do you think we will be able to get rid of the sloppy option over
> > > > > time with the move to use the mount API?
> > > > The question is what we're talking about :-)
> > > > 
> > > > For mount(8) and libmount, there is nothing like the "sloppy" mount option.
> > > > 
> > > > If you use it in your fstab or as "mount -o sloppy" on the command line,
> > > > then it's used as any other fs-specific mount option; the library copies
> > > > the string to mount(2) or fsconfig(2) syscall. The library has no clue
> > > > what the string means (it's the same as "mount -o foobar").
> > > Which is what the problem really is.
> > > 
> > > 
> > > If anyone uses this option with a file system that has previously
> > > 
> > > allowed it then mounts fail if it isn't handled properly. Then the
> > > 
> > > intended purpose of it is irrelevant because it causes a fail.
> > > 
> > > 
> > > I guess the notion of ignoring it for fsconfig(), assuming it isn't
> > > 
> > > actually needed for the option handling, might not be a viable idea
> > > 
> > > ... although I haven't actually added that to fsconfig(), I probably
> > > 
> > > should add that to this series.
> > > 
> > > 
> > > But first the question of whether the option is actually needed anymore
> > > 
> > > by those that allow it needs to be answered.
> > > 
> > > 
> > > In case anyone has forgotten it was introduced because, at one time
> > > 
> > > different OSes supported slightly different options for for the same
> > > 
> > > thing and one could not include multiple options for the same thing
> > > 
> > > in automount map entries without causing the mount to fail.
> > > 
> > > 
> > > So we also need to answer, is this option conflict still present for
> > > 
> > > any of the file systems that allow it, currently nfs, cifs and ntfs
> > > 
> > > (I'll need to look up the ntfs maintainer but lets answer this for
> > > 
> > > nfs and cifs first).
> > > 
> > > 
> > > If it isn't actually needed ignoring it in fsconfig() (a deprecation
> > > 
> > > warning would be in order) and eventually getting rid of it would be
> > > 
> > > a good idea, yes?
> > Yes, I think this is a good idea.
> > The whole reason for this mount option seems a bit hacky tbh so getting
> > rid of it would be great.
> 
> Thanks for thinking about this Christian.
> 
> It is something that has concerned me for a long time now.
> 
> 
> I know the impression that people get is that it's hacky and it's
> 
> accurate to an extent but there was real need and value for it at
> 
> one point (although it was around before my time).

No, I get it and I understand that there was a rationale behind it.

> 
> 
> But now we get tripped up because trying to get rid of it causes
> 
> the problem of the option itself not working which tends to obscure
> 
> the actual use case of users.

Yeah, agreed.

> 
> 
> I think the change to use the mount API is the best opportunity we've
> 
> had to clean this up in forever, particularly since the mount API
> 
> makes it particularly hard to continue to use it.

Agreed.

> 
> 
> I'm still thinking about it and I'll post an updated patch and
> 
> accompanying discussion at some point. At the very least we need a
> 
> clear upstream position on it to allow those of us with customers
> 
> that think they need it to pass on the deprecation notice and reasoning.

I think that "sloppy" is exactly what it is "sloppy" so if we can purge
it from the new mount api then we should do it.
