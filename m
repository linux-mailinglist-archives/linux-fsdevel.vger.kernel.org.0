Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6C34D71ED
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 01:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiCMAoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 19:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiCMAoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:44:18 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AAA10FCB;
        Sat, 12 Mar 2022 16:43:10 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTCJk-00ATSa-Ff; Sun, 13 Mar 2022 00:42:40 +0000
Date:   Sun, 13 Mar 2022 00:42:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Steve French <sfrench@samba.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
Message-ID: <Yi0+AMVrzoujuMlm@zeniv-ca.linux.org.uk>
References: <20220228215935.748017-1-mic@digikod.net>
 <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
 <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
 <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
 <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:15:01PM -0500, Paul Moore wrote:

> The silence on this has been deafening :/  No thoughts on fixing, or
> not fixing OPEN_FMODE(), Al?
> 
> At this point I have to assume OPEN_FMODE() isn't changing so I'm
> going to go ahead with moving SELinux over to file::f_flags.  Once
> I've got something working I'll CC the LSM list on the patches in case
> the other LSMs want to do something similar.  Full disclosure, that
> might not happen until early-to-mid next week due to the weekend, new
> kernel expected on Sunday, etc.

ENOBUG.  The primary user of that is fdutils; they wanted to be able
to issue ioctls on a floppy disk drive, with no disk inserted.  Or with
a disk that has weird formatting (as the matter of fact, some of those
ioctls are precisely "use such-and-such weird format").

A cleaner solution would be to have a separate device node (or sysfs
file, or...) for that kind of OOB stuff.  However, that's not how it
had been done way back when, and we are stuck with the existing ABI.
Namely, "have the lower two bits of flags both set" for "open for
ioctls only; require MAY_READ|MAY_WRITE on device node, allow
neither read() nor write() on that descriptor".

I'm not sure if anyone _uses_ fdutils these days.  OTOH, you never
know what kind of weird setups gets used, and qemu has floppy
emulation, so we can't even go for "no floppy drive is going to
be in working condition nowadays".

So I'm afraid that this ABI is going to stay ;-/  It's a long-standing
wart, from at least '94 if not earlier, it's documented (open(2)) and
it's used by a package that is shipped at least by debian and ubuntu.

And it's certainly *not* the kind of code anyone sane would want to
migrate to a replacement ABI, no matter how nice - look through the
list of utilities in there and imagine what the testing for regressions
would feel like.
