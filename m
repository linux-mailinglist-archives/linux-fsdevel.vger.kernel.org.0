Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF278D0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 02:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbjH3AKp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 20:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbjH3AKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:10:31 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B6FE73;
        Tue, 29 Aug 2023 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KPbzJvpAfmJnxRfz6vyXdTOuKHu0zGU5IcaLiuqidr0=; b=R5nzjv+Zq3LT9nshlafMmOel/V
        V9V15FrSV4M//ybfLydJkCutspaga94ytJEx9riJh1zL9kWGgjuuGRS3RGNQd6UTwUkizww5yCRXa
        65QMSK2fJSU4GVUhcmzwiC0Hq1HKwf7DGR4vmOTpwGMfQqlHke7T1R8K/2jSpp3mx40NSO3T4g2W/
        plks+ScqIJIQRzH6Fj1pBu+DVUhZ7fIoVLT08blX/7g4fVPc+bxoQXE8ePVX4WwsUQ6HaxLzBDWrJ
        7SC0zFm+4u87xlQbvEUtvlqkCX+4IE1iKrcHU8n3T8dKHajJ0gVzh2wyU+407y+rz29fwaL3T7RiK
        4HRq0m2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qb8lD-001xRM-1m;
        Wed, 30 Aug 2023 00:08:39 +0000
Date:   Wed, 30 Aug 2023 01:08:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Suren Baghdasaryan <surenb@google.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        autofs@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/8] fs: add some missing ctime updates
Message-ID: <20230830000839.GB461907@ZenIV>
References: <20230612104524.17058-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612104524.17058-1-jlayton@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 06:45:16AM -0400, Jeff Layton wrote:
> Jeff Layton (8):
>   ibmvmc: update ctime in conjunction with mtime on write
>   usb: update the ctime as well when updating mtime after an ioctl
>   autofs: set ctime as well when mtime changes on a dir
>   bfs: update ctime in addition to mtime when adding entries
>   efivarfs: update ctime when mtime changes on a write
>   exfat: ensure that ctime is updated whenever the mtime is
>   apparmor: update ctime whenever the mtime changes on an inode
>   cifs: update the ctime on a partial page write
> 
>  drivers/misc/ibmvmc.c             |  2 +-
>  drivers/usb/core/devio.c          | 16 ++++++++--------
>  fs/autofs/root.c                  |  6 +++---
>  fs/bfs/dir.c                      |  2 +-
>  fs/efivarfs/file.c                |  2 +-
>  fs/exfat/namei.c                  |  8 ++++----
>  fs/smb/client/file.c              |  2 +-
>  security/apparmor/apparmorfs.c    |  7 +++++--
>  security/apparmor/policy_unpack.c | 11 +++++++----
>  9 files changed, 31 insertions(+), 25 deletions(-)

As a possible followup (again, apologies for being MIA for months):
touch_cmtime(inode)...
