Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BB651CCCF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 01:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386823AbiEEXmX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 19:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiEEXmW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 19:42:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522DD2559B;
        Thu,  5 May 2022 16:38:41 -0700 (PDT)
Received: from penguin.thunk.org (corpnat-104-133-9-85.corp.google.com [104.133.9.85] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 245NcDT2021685
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 May 2022 19:38:14 -0400
Received: by penguin.thunk.org (Postfix, from userid 1000)
        id 4B9634B485; Thu,  5 May 2022 16:38:12 -0700 (PDT)
Date:   Thu, 5 May 2022 16:38:12 -0700
From:   tytso <tytso@mit.edu>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
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
Message-ID: <YnRf5CNN2yNKVu0B@mit.edu>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> 
> : - root
> bar - an attribute
> foo: - a folder (can contain attributes and/or folders)
> 
> The contents of a folder is represented by a null separated list of names.
> 
> Examples:
> 
> $ getfattr -etext -n ":" .
> # file: .
> :="mnt:\000mntns:"

In your example, does it matter what "." is?  It looks like in some
cases, it makes no difference at all, and in other cases, like this,
'.' *does* matter:

> $ getfattr -etext -n ":mnt:info" .
> # file: .
> :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"

Is that right?

> $ getfattr -etext -n ":mntns:" .
> # file: .
> :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"

What is this returning?  All possible mount name spaces?  Or all of
the mount spaces where '.' happens to exist?

Also, using the null character means that we can't really use shell
scripts calling getfattr.  I understand that the problem is that in
some cases, you might want to return a pathname, and NULL is the only
character which is guaranteed not to show up in a pathname.  However,
it makes parsing the returned value in a shell script exciting.

   	 	     	      	       	 - Ted
