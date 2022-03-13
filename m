Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057E84D71F1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Mar 2022 01:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiCMApZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Mar 2022 19:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiCMApY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Mar 2022 19:45:24 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FA11178;
        Sat, 12 Mar 2022 16:44:17 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTCL7-00ATUk-Fi; Sun, 13 Mar 2022 00:44:05 +0000
Date:   Sun, 13 Mar 2022 00:44:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v1] fs: Fix inconsistent f_mode
Message-ID: <Yi0+VYSyqbyXZyDS@zeniv-ca.linux.org.uk>
References: <20220228215935.748017-1-mic@digikod.net>
 <20220301092232.wh7m3fxbe7hyxmcu@wittgenstein>
 <f6b63133-d555-a77c-0847-de15a9302283@digikod.net>
 <CAHC9VhQd3rL-13k0u39Krkdjp2_dtPfgEPxr=kawWUM9FjjOsw@mail.gmail.com>
 <8d520529-4d3e-4874-f359-0ead9207cead@canonical.com>
 <CAHC9VhRrjqe1AdZYtjpzLJyBF6FTeQ4EcEwsOd2YMimA5_tzEA@mail.gmail.com>
 <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b848fe63-e86d-af38-5198-5519cb3c02ef@I-love.SAKURA.ne.jp>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 12, 2022 at 10:34:27AM +0900, Tetsuo Handa wrote:
> On 2022/03/12 7:15, Paul Moore wrote:
> > The silence on this has been deafening :/  No thoughts on fixing, or
> > not fixing OPEN_FMODE(), Al?
> 
> On 2022/03/01 19:15, Mickaël Salaün wrote:
> > 
> > On 01/03/2022 10:22, Christian Brauner wrote:
> >> That specific part seems a bit risky at first glance. Given that the
> >> patch referenced is from 2009 this means we've been allowing O_WRONLY |
> >> O_RDWR to succeed for almost 13 years now.
> >
> > Yeah, it's an old bug, but we should keep in mind that a file descriptor
> > created with such flags cannot be used to read nor write. However,
> > unfortunately, it can be used for things like ioctl, fstat, chdir… I
> > don't know if there is any user of this trick.
> 
> I got a reply from Al at https://lkml.kernel.org/r/20090212032821.GD28946@ZenIV.linux.org.uk
> that sys_open(path, 3) is for ioctls only. And I'm using this trick when opening something
> for ioctls only.

... so it's not just fdutils.  Cast in stone, IOW.
