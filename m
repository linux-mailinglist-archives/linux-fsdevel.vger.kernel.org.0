Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C13630E96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiKSMBW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Nov 2022 07:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSMBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:01:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AED97AAA;
        Sat, 19 Nov 2022 04:01:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2159460B72;
        Sat, 19 Nov 2022 12:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D295C433C1;
        Sat, 19 Nov 2022 12:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668859279;
        bh=88gsDwKEYpSXJAj8eqiYfmf/h0e4AlZEIfT5yZJhdII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMrv0gHVzHZxWOHVq12gYx6mrKUXVZk9OyBH9p0ocn2G4hrFEoJ2vnle34tZ2W2Dr
         sRETnqMRdayQe8zmYCRbL/Sf1d+aCzX4ziTcos9cP7r9gG4jGJJeN6WWv4nNLtTRMC
         HWzdWsG6wuIvlhraPgsNsYybrP7D6ec1A2N76F1QUOf3HkqS+fWek18624Ag4AzVwT
         RALFi5MJ7ZL4O1fnj8g+hvBT4sEmQn/VJHrQd15Mh4IsKbkVMujkXnyzyycG0k+9aM
         zlIk4G5VM4eCyCg8u2fkJE40JH4d+us/+b8euvdN5yHhvDo+jCpth9Mo/Xm8kfgsAr
         j0OEi9mmjAFNA==
Date:   Sat, 19 Nov 2022 13:01:11 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v4] proc: report open files as size in stat() for
 /proc/pid/fd
Message-ID: <20221119120111.2dh3tomoawwpyjrg@wittgenstein>
References: <20221024173140.30673-1-ivan@cloudflare.com>
 <Y3fYu2VCBgREBBau@bfoster>
 <CABWYdi3csS3BpoMd8xO=ZXFeBH7KtuLkxzQ8VE5+rO5wrx-yQQ@mail.gmail.com>
 <Y3feB8wHdfx48uCl@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y3feB8wHdfx48uCl@bfoster>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 18, 2022 at 02:33:27PM -0500, Brian Foster wrote:
> On Fri, Nov 18, 2022 at 11:18:36AM -0800, Ivan Babrou wrote:
> > On Fri, Nov 18, 2022 at 11:10 AM Brian Foster <bfoster@redhat.com> wrote:
> > > > +static int proc_fd_getattr(struct user_namespace *mnt_userns,
> > > > +                     const struct path *path, struct kstat *stat,
> > > > +                     u32 request_mask, unsigned int query_flags)
> > > > +{
> > > > +     struct inode *inode = d_inode(path->dentry);
> > > > +     int rv = 0;
> > > > +
> > > > +     generic_fillattr(&init_user_ns, inode, stat);
> > > > +
> > >
> > > Sorry I missed this on v3, but shouldn't this pass through the
> > > mnt_userns parameter?
> > 
> > The mnt_userns parameter was added in 549c729 (fs: make helpers idmap
> > mount aware), and it's not passed anywhere in fs/proc.
> > 
> > Looking at other uses of generic_fillattr, all of them use "init_user_ns":
> > 
> 
> Interesting. It looks like this would have used mnt_userns from
> vfs_getattr_nosec() before proc_fd_getattr() is wired up, right? I'm not
> familiar enough with that change to say whether /proc should use one
> value or the other, or perhaps it just doesn't matter.?
> 
> Christian?

Hey Brian,

This should pass init_user_ns. So it is correct the way it is done now.
The init_user_ns is used to indicate that no idmappings are used and
since procfs doesn't support the creation of idmapped mounts and doesn't
need to, passing it here makes the most sense. Technically passing down
mnt_userns would work too but that would make it look like procfs could
support idmapped mounts which isn't the case and so we don't do it this
way.

Starting soon this will be a lot clearer too since we're about to
introduce struct mnt_idmap and replace passing around userns here.
That'll make things also safer as the helpers that currently could be
passed a mnt_userns - which could be any userns - will now only be able
to take mnt_idmap which is a different type.

Long story short, the way your patch does it is correct.

Thanks!
Christian
