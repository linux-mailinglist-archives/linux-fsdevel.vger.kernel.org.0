Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2628251E2C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 May 2022 02:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445092AbiEGAf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 20:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445071AbiEGAfw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 20:35:52 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC6586543F;
        Fri,  6 May 2022 17:32:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id C2F1A5344B9;
        Sat,  7 May 2022 10:32:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nn8Ma-008ucI-Uc; Sat, 07 May 2022 10:32:00 +1000
Date:   Sat, 7 May 2022 10:32:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     tytso <tytso@mit.edu>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220507003200.GM1949718@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <YnRf5CNN2yNKVu0B@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnRf5CNN2yNKVu0B@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6275be06
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=6tRzxmq33S4bAUIDdMMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 04:38:12PM -0700, tytso wrote:
> On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> > 
> > : - root
> > bar - an attribute
> > foo: - a folder (can contain attributes and/or folders)
> > 
> > The contents of a folder is represented by a null separated list of names.
> > 
> > Examples:
> > 
> > $ getfattr -etext -n ":" .
> > # file: .
> > :="mnt:\000mntns:"
> 
> In your example, does it matter what "." is?  It looks like in some
> cases, it makes no difference at all, and in other cases, like this,
> '.' *does* matter:
> 
> > $ getfattr -etext -n ":mnt:info" .
> > # file: .
> > :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
> 
> Is that right?
> 
> > $ getfattr -etext -n ":mntns:" .
> > # file: .
> > :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> 
> What is this returning?  All possible mount name spaces?  Or all of
> the mount spaces where '.' happens to exist?
> 
> Also, using the null character means that we can't really use shell
> scripts calling getfattr.

Yeah, it should be returning an attr per namespace, not an attr
whose value contains all the valid namespaces.

i.e. if the next level of the heirachy is 21, 22, 24, .... we should
be seeing a listing of multiple attributes with naming like:

:mntns:21:
:mntns:22:
:mntns:24:
....

rather than an attribute whose value contains the names of the
attrbiutes in the next layer of the heirarchy. Then we can just
pull the namespace we want and feed it directly to:

$ getfattr -n ":mntns:21:"

and we get a list of all the attributes available for that
namespace...

> I understand that the problem is that in
> some cases, you might want to return a pathname, and NULL is the only
> character which is guaranteed not to show up in a pathname.  However,
> it makes parsing the returned value in a shell script exciting.

We shouldn't be returning the names of children in an attribute
value. We have a syscall API for doing this that - listxattr() will
iterate attribute names just like a directory does with readdir()
via listxattr(). IOWs, we should not need to encode the next layer
of child attribute names into the value of the parent attribute - if
we do a listxattr on a parent that has children, return the list of
child names as individual attribute names....

(Yes, I know listxattr null separates the attribute names - it's a
godawful kernel API - but that's not the programmatic interface
we should expose at the shell script level.)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
