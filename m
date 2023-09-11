Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2479B9C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 02:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbjIKUzR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242926AbjIKQef (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:34:35 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89699D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Sep 2023 09:34:30 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rksk92h18zMpp3l;
        Mon, 11 Sep 2023 16:34:25 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rksk77429zMpp9y;
        Mon, 11 Sep 2023 18:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694450065;
        bh=0hFruZJStHpPF1Wqo50DPh1U7wqvk9JxmohujdtDbTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fr7Wgm3YM831AOjTywMLv1N2mQ9HYqiQIBAWoxCl7gHiXAFmiIT9VfdORoNSb4UCn
         ZNUSE7IyAaJtBofi1jvpuk+uvWuJFyYJHGKPd4XR91M3G7U8rlgMDZclxXUns829e2
         heI4EcUO1XSG9f2OUsttoRGGaa0/OqLqcLDZ9H50=
Date:   Mon, 11 Sep 2023 18:34:20 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 0/5] Landlock: IOCTL support
Message-ID: <20230911.eushohth1Ue2@digikod.net>
References: <20230814172816.3907299-1-gnoack@google.com>
 <20230818.iechoCh0eew0@digikod.net>
 <ZOjCz5j4+tgptF53@google.com>
 <20230825.Zoo4ohn1aivo@digikod.net>
 <20230826.ohtooph0Ahmu@digikod.net>
 <ZPMiVaL3kVaTnivh@google.com>
 <20230904.aiWae8eineo4@digikod.net>
 <ZP7lxmXklksadvz+@google.com>
 <20230911.jie6Rai8ughe@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230911.jie6Rai8ughe@digikod.net>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 11, 2023 at 05:25:34PM +0200, Mickaël Salaün wrote:
> On Mon, Sep 11, 2023 at 12:02:46PM +0200, Günther Noack wrote:
> > Hello!
> > 
> > On Mon, Sep 04, 2023 at 08:08:29PM +0200, Mickaël Salaün wrote:
> > > On Sat, Sep 02, 2023 at 01:53:57PM +0200, Günther Noack wrote:
> > > > On Sat, Aug 26, 2023 at 08:26:30PM +0200, Mickaël Salaün wrote:
> > > > > On Fri, Aug 25, 2023 at 06:50:29PM +0200, Mickaël Salaün wrote:
> > > > > > On Fri, Aug 25, 2023 at 05:03:43PM +0200, Günther Noack wrote:

> > > > > > > (In fact, it seems to me almost like FIOQSIZE might rather be missing a security
> > > > > > > hook check for one of the "getting file attribute" hooks?)
> > > > > > > 
> > > > > > > So basically, the implementation that I currently ended up with is:
> > > > > > > 
> > > > > > 
> > > > > > Before checking these commands, we first need to check that the original
> > > > > > domain handle LANDLOCK_ACCESS_FS_IOCTL. We should try to pack this new
> > > > > > bit and replace the file's allowed_access field (see
> > > > > > landlock_add_fs_access_mask() and similar helpers in the network patch
> > > > > > series that does a similar thing but for ruleset's handle access
> > > > > > rights), but here is the idea:
> > > > > > 
> > > > > > if (!landlock_file_handles_ioctl(file))
> > > > > > 	return 0;
> > > > > > 
> > > > > > > switch (cmd) {
> > > > > > 	/*
> > > > > > 	 * Allows file descriptor and file description operations (see
> > > > > > 	 * fcntl commands).
> > > > > > 	 */
> > > > > > >   case FIOCLEX:
> > > > > > >   case FIONCLEX:
> > > > > > >   case FIONBIO:
> > > > > > >   case FIOASYNC:
> > > > > > 
> > > > > > >   case FIOQSIZE:
> > > > > 
> > > > > We need to handle FIOQSIZE as done by do_vfs_ioctl: add the same i_mode
> > > > > checks. A kselftest test should check that ENOTTY is returned according
> > > > > to the file type and the access rights.
> > > > 
> > > > It's not clear to me why we would need to add the same i_mode checks for
> > > > S_ISDIR() || S_ISREG() || S_ISLNK() there?  If these checks in do_vfs_ioctl()
> > > > fail, it returns -ENOTTY.  Is that not an appropriate error already?
> > > 
> > > The LSM IOCTL hook is called before do_vfs_ioctl(), and I think that
> > > Landlock should not change the error codes according to the error types
> > > (i.e. return ENOTTY when the inode is something else than a directory,
> > > regular file, or symlink). Indeed, I think it's valuable to not blindly
> > > return EACCES when the IOCTL doesn't make sense for this file type. This
> > > should help user space handle meaningful error messages, inconsistent
> > > requests, and fallback mechanisms. Tests should check these return
> > > codes, see the network patch series (and especially the latest reviews
> > > and changes) that takes care of this kind of error codes compatibility.
> > > 
> > > We could also return 0 (i.e. accept the request) and rely on the
> > > do_vfs_ioctl() check to return ENOTTY, but this is unnecessary risky
> > > from an access control point of view. Let's directly return ENOTTY as a
> > > safeguard (which BTW also avoids some useless CPU instructions) and test
> > > this behavior.
> > > 
> > > I think an access control mechanism, and especially Landlock, should be
> > > as discreet as possible, and help developers quickly debug issues (and
> > > avoid going through the access control layer if it doesn't make sense).
> > > I think error ordering like this could be useful but I'd like to get
> > > other point of views.
> > 
> > I see what you mean now, OK.
> > 
> > Another option, btw, would be to return ENOTTY generally when Landlock denies an
> > IOCTL attempt, instead of EACCES, as I have previously suggested in
> > https://lore.kernel.org/all/ZNpnrCjYqFoGkwyf@google.com/ -- should we maybe just
> > do that instead?
> > 
> > I believe that users of ioctl(2) should be better equipped to deal with ENOTTY,
> > because that is an error that ioctl(2) can return in general, whereas EACCES can
> > only be returned if one of the specific subcommands returns it.
> > 
> > According to the man page, ENOTTY is the error that ioctl(2) returns if the
> > given "request does not apply to the kind of object that the file descriptor fd
> > references".
> > 
> > That is not 100% what is happening here, but from the errors listed in ioctl(2),
> > this seems to be the closest, semantically.
> > 
> > What do you think?
> 
> ENOTTY has a (kinda) well-defined semantic, which should not depend on
> an access control. Other LSMs already return EACCES for denied IOCTLs,
> so the man page should be updated with this information instead. ;)

Well, thinking about this again, for the sake of consistency with other
IOCTLs, we should not specifically handle IOCTL error codes, but instead
return either 0 or -EACCES. The network error cases are special because
the LSM is called before some user-provided data are interpreted by the
network stack, and in this case we need to interpret these data ourself.
But in the case of IOCTLs, we may only need to handle the cases where an
IOCTL command may be interpreted by different implementations (e.g. VFS
or FS implementation), but even that is not a good idea, see below.

For FIOQSIZE, I don't think anymore that we should try to mimic the
do_vfs_ioctl() implementation. In fact, this approach could end up
confusing developers and leaking metadata (see FIGETBSZ). Even with
FIONREAD, the FS (i.e. vfs_ioctl() call) should follow the same
semantic as the VFS (i.e. do_vfs_ioctl() code), so we should treat them
the same and keep it simple: either return 0 or -EACCES.

About the file_ioctl() IOCTLs, we should check that there are no
overlapping with other IOCTLs (with different name). I think we should
trust the FS implementation to implement the same semantic, but much
less the device drivers. The main issue is with VFS and FS code
returning -ENOIOCTLCMD because in this case it is forwarded to any
implementation.

However, in the case of delegation, and as a safeguard, what we could do
to avoid driver IOCTL command overlaps is to check if the file is a
block or character device. In this case, we just don't delegate any
access right but make LANDLOCK_ACCESS_FS_IOCTL handle them (we need to
manage VFS's IOCTLs that deal with block/char device though). Again, we
should make sure that -ENOIOCTLCMD will not trick us (for the delegate
cases). I'm not sure how the link between drivers and the FS storing the
related block/char device is managed though. Does that make sense?
