Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC015729B91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjFIN1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjFIN1m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:27:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6876C270B;
        Fri,  9 Jun 2023 06:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0577A60E8D;
        Fri,  9 Jun 2023 13:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7BCC433EF;
        Fri,  9 Jun 2023 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686317260;
        bh=oSuiJiclTzvMA00+ishDDZSJ5F4CCgIPlxz3qberOkU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ctTfeKacHWo5l9K9DxzQOrtlTLoG85/EKA7MvHQ/F1/2q0zByBrbmyXzsM5xu9ZiB
         z9wHdsdfD4pFeRxFcqVecbJ+Otm388ULgG+bsoled+ga5itRm8LLiC22OcTX19F+j+
         6yIPcNN1B7m9Ur7wYkJS4IGiKr+2aBq5+dqDL6XT4Raq7b5xw0RxxqP1BRnkC/teoQ
         1BBAFxOID86v/atOu3NX+L9wnqyt+99xF7OTaMcfAz05y5B3IH3bJDB665QOEe/kU6
         AzdHw7nXRvFkJ5TMlrv7YVHd1aILHvSrpMhR/sNk7+XbKVcwqz4pHqjL+n9s6tGy8X
         915cASV+pKXDw==
Message-ID: <671ceeb2e019c11617a481739c2e17604456c48c.camel@kernel.org>
Subject: Re: [PATCH 0/9] fs: add some missing ctime updates
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org
Date:   Fri, 09 Jun 2023 09:27:36 -0400
In-Reply-To: <2023060931-magazine-nickname-f386@gregkh>
References: <20230609125023.399942-1-jlayton@kernel.org>
         <2023060931-magazine-nickname-f386@gregkh>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-06-09 at 15:10 +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 09, 2023 at 08:50:14AM -0400, Jeff Layton wrote:
> > While working on a patch series to change how we handle the ctime, I
> > found a number of places that update the mtime without a corresponding
> > ctime update. POSIX requires that when the mtime is updated that the
> > ctime also be updated.
> >=20
> > Note that these are largely untested other than for compilation, so
> > please review carefully. These are a preliminary set for the upcoming
> > rework of how we handle the ctime.
> >=20
> > None of these seem to be very crucial, but it would be nice if
> > various maintainers could pick these up for v6.5. Please let me know if
> > you do.
> >=20
> > Jeff Layton (9):
> >   ibmvmc: update ctime in conjunction with mtime on write
> >   usb: update the ctime as well when updating mtime after an ioctl
> >   autofs: set ctime as well when mtime changes on a dir
> >   bfs: update ctime in addition to mtime when adding entries
> >   efivarfs: update ctime when mtime changes on a write
> >   exfat: ensure that ctime is updated whenever the mtime is
> >   gfs2: update ctime when quota is updated
> >   apparmor: update ctime whenever the mtime changes on an inode
> >   cifs: update the ctime on a partial page write
> >=20
> >  drivers/misc/ibmvmc.c             |  2 +-
> >  drivers/usb/core/devio.c          | 16 ++++++++--------
> >  fs/autofs/root.c                  |  6 +++---
> >  fs/bfs/dir.c                      |  2 +-
> >  fs/efivarfs/file.c                |  2 +-
> >  fs/exfat/namei.c                  |  8 ++++----
> >  fs/gfs2/quota.c                   |  2 +-
> >  fs/smb/client/file.c              |  2 +-
> >  security/apparmor/apparmorfs.c    |  7 +++++--
> >  security/apparmor/policy_unpack.c | 11 +++++++----
> >  10 files changed, 32 insertions(+), 26 deletions(-)
> >=20
> > --=20
> > 2.40.1
> >=20
>=20
> All of these need commit log messages, didn't checkpatch warn you about
> that?

It did, once I ran it. ;)

I'll repost the set with more elaborate changelogs.
--=20
Jeff Layton <jlayton@kernel.org>
