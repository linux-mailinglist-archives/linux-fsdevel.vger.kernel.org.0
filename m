Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1651FD4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 14:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbiEIMwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiEIMwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:52:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9345291CE6;
        Mon,  9 May 2022 05:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60DC160F83;
        Mon,  9 May 2022 12:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC776C385AB;
        Mon,  9 May 2022 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652100502;
        bh=PEkal2Mg+V+a1Uc4DwNy01rEfPajZVpu3xEyPDheL7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLdqiKtUmlalSDwS1n1Pd+QPOl3ZQ5Z/Px3VzfgDfi/iTVQE75a4Mx59sqYinG3Y/
         6JQ6tPdvw+spGntcA6/qBbzc0EWVWgvTCSeRhFt1TJnwfvlS403/93TzCxeTfDI7bL
         Y5ZOPkievIcmDHqw93+6S/hqUlUH3A62X+d+bPRUfl+mF2CJW2bDhz2iBiCLZyWITr
         djQO1sd/jt9/OKnyv7F6kp5sV6MSxq3kG3Cdq0CXHpH2YpoyabNaeZddaukEfsezds
         fZkIgyWymXJHtqeaAT7YcpcuzYjWrtm8sVHbltjmgphJAmYJA3YXh3Yq2Rnko/B5MD
         lwieyoWchdbeg==
Date:   Mon, 9 May 2022 14:48:15 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
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
Message-ID: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> This is a simplification of the getvalues(2) prototype and moving it to the
> getxattr(2) interface, as suggested by Dave.
> 
> The patch itself just adds the possibility to retrieve a single line of
> /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> patchset grew out of).
> 
> But this should be able to serve Amir's per-sb iostats, as well as a host of
> other cases where some statistic needs to be retrieved from some object.  Note:
> a filesystem object often represents other kinds of objects (such as processes
> in /proc) so this is not limited to fs attributes.
> 
> This also opens up the interface to setting attributes via setxattr(2).
> 
> After some pondering I made the namespace so:
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
> 
> $ getfattr -etext -n ":mnt:" .
> # file: .
> :mnt:="info"
> 
> $ getfattr -etext -n ":mnt:info" .
> # file: .
> :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"

Hey Miklos,

One comment about this. We really need to have this interface support
giving us mount options like "relatime" back in numeric form (I assume
this will be possible.). It is royally annoying having to maintain a
mapping table in userspace just to do:

relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
ro	 -> MS_RDONLY/MOUNT_ATTR_RDONLY

A library shouldn't be required to use this interface. Conservative
low-level software that keeps its shared library dependencies minimal
will need to be able to use that interface without having to go to an
external library that transforms text-based output to binary form (Which
I'm very sure will need to happen if we go with a text-based
interface.).

> 
> $ getfattr -etext -n ":mntns:" .
> # file: .
> :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> 
> $ getfattr -etext -n ":mntns:28:" .
> # file: .
> :mntns:28:="info"
> 
> Comments?

I'm not a fan of text-based APIs and I'm particularly not a fan of the
xattr APIs. But at this point I'm ready to compromise on a lot as long
as it gets us values out of the kernel in some way. :)

I had to use xattrs extensively in various low-level userspace projects
and they continue to be a source of races and memory bugs.

A few initial questions:

* The xattr APIs often require the caller to do sm like (copying some go
  code quickly as I have that lying around):

	for _, x := range split {
		xattr := string(x)
		// Call Getxattr() twice: First, to determine the size of the
		// buffer we need to allocate to store the extended attributes,
		// second, to actually store the extended attributes in the
		// buffer. Also, check if the size of the extended attribute
		// hasn't increased between the two calls.
		pre, err = unix.Getxattr(path, xattr, nil)
		if err != nil || pre < 0 {
			return nil, err
		}

		dest = make([]byte, pre)
		post := 0
		if pre > 0 {
			post, err = unix.Getxattr(path, xattr, dest)
			if err != nil || post < 0 {
				return nil, err
			}
		}

		if post > pre {
			return nil, fmt.Errorf("Extended attribute '%s' size increased from %d to %d during retrieval", xattr, pre, post)
		}

		xattrs[xattr] = string(dest)
	}

  This pattern of requesting the size first by passing empty arguments,
  then allocating the buffer and then passing down that buffer to
  retrieve that value is really annoying to use and error prone (I do
  of course understand why it exists.).

  For real xattrs it's not that bad because we can assume that these
  values don't change often and so the race window between
  getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
  fwiw, the post > pre check doesn't exist for no reason; we do indeed
  hit that race.
  
  In addition, it is costly having to call getxattr() twice. Again, for
  retrieving xattrs it often doesn't matter because it's not a super
  common operation but for mount and other info it might matter.

  Will we have to use the same pattern for mnt and other info as well?
  If so, I worry that the race is way more likely than it is for real
  xattrs.

* Would it be possible to support binary output with this interface?
  I really think users would love to have an interfact where they can
  get a struct with binary info back. I'm not advocating to make the
  whole interface binary but I wouldn't mind having the option to
  support it.
  Especially for some information at least. I'd really love to have a
  way go get a struct mount_info or whatever back that gives me all the
  details about a mount encompassed in a single struct.

  Callers like systemd will have to parse text and will end up
  converting everything from text into binary anyway; especially for
  mount information. So giving them an option for this out of the box
  would be quite good.

  Interfaces like statx aim to be as fast as possible because we exptect
  them to be called quite often. Retrieving mount info is quite costly
  and is done quite often as well. Maybe not for all software but for a
  lot of low-level software. Especially when starting services in
  systemd a lot of mount parsing happens similar when starting
  containers in runtimes.

* If we decide to go forward with this interface - and I think I
  mentioned this in the lsfmm session - could we please at least add a
  new system call? It really feels wrong to retrieve mount and other
  information through the xattr interfaces. They aren't really xattrs.

  Imho, xattrs are a bit like a wonky version of streams already (One of
  the reasons I find them quite unpleasant.). Making mount and other
  information retrievable directly through the getxattr() interface will
  turn them into a full-on streams implementation imho. I'd prefer not
  to do that (Which is another reason I'd prefer at least a separate
  system call.).
