Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648C9518748
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 16:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237438AbiECO5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiECO5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 10:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22721E39;
        Tue,  3 May 2022 07:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B923560C8E;
        Tue,  3 May 2022 14:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25B5C385A4;
        Tue,  3 May 2022 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651589630;
        bh=w4Xoznwtn3tyLr1cRCPJ8Tdo2kOlrKOwvD7MSq9598s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyWn4OGCKIQfCoxx32JI1GCwxVovGVNz6H+TT+Vmx1nsr80YfM9XlxGM+qPZ4Vjcf
         vutt68+pESkS+B05T6D76+md0K1qTXmBrG5Xw6qAeJb+comkTppxOC4FYmH6777Img
         LPA/+W66303oz14RM5evehJfP/n/hn5hy981rZDI=
Date:   Tue, 3 May 2022 16:53:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <YnFB/ct2Q/yYBnm8@kroah.com>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <CAOQ4uxim+JmFbXPQcasELDEgRDP-spdPtJrLuhvSiyxErSUkvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxim+JmFbXPQcasELDEgRDP-spdPtJrLuhvSiyxErSUkvw@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 03, 2022 at 05:39:46PM +0300, Amir Goldstein wrote:
> On Tue, May 3, 2022 at 3:23 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > This is a simplification of the getvalues(2) prototype and moving it to the
> > getxattr(2) interface, as suggested by Dave.
> >
> > The patch itself just adds the possibility to retrieve a single line of
> > /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> > patchset grew out of).
> >
> > But this should be able to serve Amir's per-sb iostats, as well as a host of
> > other cases where some statistic needs to be retrieved from some object.  Note:
> > a filesystem object often represents other kinds of objects (such as processes
> > in /proc) so this is not limited to fs attributes.
> >
> > This also opens up the interface to setting attributes via setxattr(2).
> >
> > After some pondering I made the namespace so:
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
> >
> > $ getfattr -etext -n ":mnt:" .
> > # file: .
> > :mnt:="info"
> >
> > $ getfattr -etext -n ":mnt:info" .
> > # file: .
> > :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
> >
> > $ getfattr -etext -n ":mntns:" .
> > # file: .
> > :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> >
> > $ getfattr -etext -n ":mntns:28:" .
> > # file: .
> > :mntns:28:="info"
> >
> > Comments?
> >
> 
> I like that :)
> 
> It should be noted that while this API mandates text keys,
> it does not mandate text values, so for example, sb iostats could be
> exported as text or as binary struct, or as individual text/binary records or
> all of the above.

Ugh, no, that would be a total mess.  Don't go exporting random binary
structs depending on the file, that's going to be completely
unmaintainable.  As it is, this is going to be hard enough with random
text fields.

As for this format, it needs to be required to be documented in
Documentation/ABI/ for each entry and key type so that we have a chance
of knowing what is going on and tracking how things are working and
validating stuff.

thanks,

greg k-h
