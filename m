Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7B54AA77D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 08:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379629AbiBEH6P convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 5 Feb 2022 02:58:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49760 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBEH6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:58:14 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 331BA72C905;
        Sat,  5 Feb 2022 10:58:02 +0300 (MSK)
Received: from tower (46-138-221-29.dynamic.spd-mgts.ru [46.138.221.29])
        by imap.altlinux.org (Postfix) with ESMTPSA id CDF5F4A46F0;
        Sat,  5 Feb 2022 10:58:01 +0300 (MSK)
Date:   Sat, 5 Feb 2022 10:57:58 +0300
From:   "Anton V. Boyarshinov" <boyarsh@altlinux.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        ebiederm@xmission.com, legion@kernel.org, ldv@altlinux.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Add ability to disallow idmapped mounts
Message-ID: <20220205105758.1623e78d@tower>
In-Reply-To: <20220204151032.7q22hgzcil4hqvkl@wittgenstein>
References: <20220204065338.251469-1-boyarsh@altlinux.org>
        <20220204094515.6vvxhzcyemvrb2yy@wittgenstein>
        <20220204132616.28de9c4a@tower>
        <20220204151032.7q22hgzcil4hqvkl@wittgenstein>
Organization: ALT Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-alt-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

В Fri, 4 Feb 2022 16:10:32 +0100
Christian Brauner <brauner@kernel.org> пишет:


> > It turns off much more than idmapped mounts only. More fine grained
> > control seems better for me.  
> 
> If you allow user namespaces and not idmapped mounts you haven't reduced
> your attack surface.

I have. And many other people have. People who have creating user
namespaces by unpriviliged user disabled. I find it sad that we have no
tool in mainline kernel to limit users access to creating user
namespaces except complete disabling them. But many distros have that
tools. Different tools with different interfaces and semantics :(

And at least one major GNU/Linux distro disabled idmapped mounts
unconditionally. If I were the author of this functionality, I would
prefer to have a knob then have it unavailible for for so many users. But as you wish.

> An unprivileged user can reach much more
> exploitable code simply via unshare -user --map-root -mount which we
> still allow upstream without a second thought even with all the past and
> present exploits (see
> https://www.openwall.com/lists/oss-security/2022/01/29/1 for a current
> one from this January).
> 
> >   
> > > They can neither
> > > be created as an unprivileged user nor can they be created inside user
> > > namespaces.  
> > 
> > But actions of fully privileged user can open non-obvious ways to
> > privilege escalation.  
> 
> A fully privileged user potentially being able to cause issues is really
> not an argument; especially not for a new sysctl.
> You need root to create idmapped mounts and you need root to turn off
> the new knob.
> 
> It also trivially applies to a whole slew of even basic kernel tunables
> basically everything that can be reached by unprivileged users after a
> privileged user has turned it on or configured it.
> 
> After 2 years we haven't seen any issue with this code and while I'm not
> promising that there won't ever be issues - nobody can do that - the
> pure suspicion that there could be some is not a justification for
> anything.

