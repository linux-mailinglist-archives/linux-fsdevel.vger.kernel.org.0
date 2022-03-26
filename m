Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5284E7EDD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 05:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiCZEVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 00:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiCZEVP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:21:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2197723F3F9;
        Fri, 25 Mar 2022 21:19:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22Q4JAos018812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 26 Mar 2022 00:19:11 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D60DD15C0038; Sat, 26 Mar 2022 00:19:10 -0400 (EDT)
Date:   Sat, 26 Mar 2022 00:19:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Karel Zak <kzak@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH] getvalues(2) prototype
Message-ID: <Yj6UPi6SDc7wMtCA@mit.edu>
References: <20220322192712.709170-1-mszeredi@redhat.com>
 <20220323114215.pfrxy2b6vsvqig6a@wittgenstein>
 <CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8igA0DT66GFH2ZanspA@mail.gmail.com>
 <YjudB7XARLlRtBiR@mit.edu>
 <CAJfpegtiRx6jRFUuPeXDxwJpBhYn0ekKkwYbGowUehGZkqVmAw@mail.gmail.com>
 <20220325084646.7g6oto2ce3vou54x@ws.net.home>
 <Yj2DPRusMAzV/N5U@kroah.com>
 <20220325092553.rncxqrjslv6e4c7v@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325092553.rncxqrjslv6e4c7v@ws.net.home>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:25:53AM +0100, Karel Zak wrote:
> 
> Right, the speed of ps(1) or lsof(1) is not important. IMHO the current
> discussion about getvalues() goes in wrong direction :-)
> 
> I guess the primary motivation is not to replace open+read+close, but
> provide to userspace something usable to get information from mount
> table, because the current /proc/#/mountinfo and notification by
> poll() is horrible.

I think that's because the getvalues(2) prototype *only* optimizes
away open+read+close, and doesn't do a *thing* with respect to
/proc/<pid>/mountinfo.

> Don't forget that the previous attempt was fsinfo() from David Howells
> (unfortunately, it was too complex and rejected by Linus).

fsinfo() tried to do a lot more than solving the /proc/<pid>/mountinfo
problem; perhaps that was the cause of the complexity.

Ignoring the notification problem (which I suspect we could solve with
an extension of fsnotify), if the goal is to find a cleaner way to
fetch information about a process's mount namespace and the mounts in
that namespace, why not trying to export that information via sysfs?
Information about devices are just as complex, after all.

We could make mount namespaces to be their own first class object, so
there would be an entry in /proc/<pid> which returns the mount
namespace id used by a particular process.  Similarly, let each
mounted file system be its own first class object.  Information about
each mount namespace would be in /sys/mnt_ns, and information about
each mounted file system would be in /sys/superblock.  Then in
/sys/mnt_ns there would be a directory for each (superblock,
mountpoint) pair.

Given how quickly programs like lsof can open tens of thousands of
small files, and typically there are't that many mounted file systems
in a particular mount namespace, performance really shouldn't be a
problem.

If it works well enough for other kernel objects that are accessed via
sysfs, and fsinfo() is way to complex, why don't we try a pattern
which has worked and is "native" to Linux?

					- Ted

