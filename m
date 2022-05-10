Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E8752278B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiEJX0T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 19:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiEJX0D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 19:26:03 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 721B13BBC5;
        Tue, 10 May 2022 16:25:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CD42653469D;
        Wed, 11 May 2022 09:25:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noZEm-00ATWh-9C; Wed, 11 May 2022 09:25:52 +1000
Date:   Wed, 11 May 2022 09:25:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20220510232552.GD2306852@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <20220510123512.h6jjqgowex6gnjh5@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510123512.h6jjqgowex6gnjh5@ws.net.home>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=627af484
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=k7MNvsyqWiSqLKXAZKIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 02:35:12PM +0200, Karel Zak wrote:
> On Mon, May 09, 2022 at 02:48:15PM +0200, Christian Brauner wrote:
> > One comment about this. We really need to have this interface support
> > giving us mount options like "relatime" back in numeric form (I assume
> > this will be possible.). It is royally annoying having to maintain a
> > mapping table in userspace just to do:
> > 
> > relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> > ro	 -> MS_RDONLY/MOUNT_ATTR_RDONLY
> > 
> > A library shouldn't be required to use this interface. Conservative
> > low-level software that keeps its shared library dependencies minimal
> > will need to be able to use that interface without having to go to an
> > external library that transforms text-based output to binary form (Which
> > I'm very sure will need to happen if we go with a text-based
> > interface.).
> 
> Sounds like David's fsinfo() :-)
> 
> We need an interface where the kernel returns a consistent mount table    
> entry (more syscalls to get more key=value could be a way how to get
> inconsistent data).                                              
> 
> IMHO all the attempts to make a trivial interface will be unsuccessful
> because the mount table is complex (tree) and mixes strings, paths,
> and flags. We will always end with a complex interface or complex
> strings (like the last xatts attempt). There is no 3rd path to go ...
> 
> The best would be simplified fsinfo() where userspace defines
> a request (wanted "keys"), and the kernel fills a buffer with data
> separated by some header metadata struct. In this case, the kernel can
> return strings and structs with binary data.  
> 
> 
> I'd love something like:
> 
> ssize_t sz;
> fsinfo_query query[] = {
>     { .request = FSINFO_MOUNT_PATH },
>     { .request = FSINFO_PROPAGATION },
>     { .request = FSINFO_CHILDREN_IDS },
> };
> 
> sz = fsinfo(dfd, "", AT_EMPTY_PATH,
>                 &query, ARRAY_SIZE(query),
>                 buf, sizeof(buf));
> 
> for (p = buf; p < buf + sz; ) {
> {
>     fsinfo_entry *e = (struct fsinfo_entry) p;
>     char *data = p + sizeof(struct fsinfo_entry);
> 
>     switch(e->request) {
>     case FSINFO_MOUNT_PATH:
>         printf("mountpoint %s\n", data);
>         break;
>     case FSINFO_PROPAGATION:
>         printf("propagation %x\n", (uintptr_t) data);
>         break;
>     case FSINFO_CHILDREN_IDS:
>         fsinfo_child *x = (fsinfo_child *) data;
>         for (i = 0; i < e->count; i++) {
>             printf("child: %d\n", x[i].mnt_id);
>         }
>         break;
>     ...
>     }
> 
>     p += sizeof(struct fsinfo_entry) + e->len;
> }

That's pretty much what a multi-xattr get operation looks like.
It's a bit more more intricate in the setup of the request/return
buffer, but otherwise the structure of the code is the same.

I just don't see why we need special purpose interfaces like this
for key/value information when small tweaks to the existing
generic key/value interfaces can provide exactly the same
functionality....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
