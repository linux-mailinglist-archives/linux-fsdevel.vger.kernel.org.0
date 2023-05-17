Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841A070617F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjEQHnH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEQHnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 03:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5423BDA;
        Wed, 17 May 2023 00:43:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E04A261505;
        Wed, 17 May 2023 07:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7059C433EF;
        Wed, 17 May 2023 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684309384;
        bh=O9BH3MMwJ9QLfDiBDxx6MYQ6q0OrfOn8kxK3I1Ze9Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SLx3zhrnBRX6BxumCB+uz3OasNrIpbQdUVmqHECCNSMmOYtLfHVLI/2UdI8m4bXmO
         Iy6AzzQIxzE+3p194U1XkRaTZvpVKg+zmEfpwmZQkSwWKrXu689ly7ad5ROanbBmJT
         1LPT43AY7EcRHmZj35LxqtRBKrdO5SHnSplTwn2gzEd9SY8iIEgkn627b/nfqmz3MS
         2gQ5joEbjYPfCXNc0j1oItjy9zHwQdceeUxO9aGXq4GoTQJWusb40Xj4xBhSpEl8vn
         ELQ1Sm6wLqvecjdmaZXocjz1upV+qrC2V463RyiWMRV2sfvGsWiV3mLf/xp6BGrfCJ
         eQ2C/llrMFFog==
Date:   Wed, 17 May 2023 09:42:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Ondrej Valousek <ondrej.valousek.xm@renesas.com>,
        "trondmy@hammerspace.com" <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A pass-through support for NFSv4 style ACL
Message-ID: <20230517-herstellen-zitat-21eeccd36558@brauner>
References: <20230516124655.82283-1-jlayton@kernel.org>
 <20230516-notorisch-geblickt-6b591fbd77c1@brauner>
 <TYXPR01MB18549D3A5B0BE777D7F6B284D9799@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc4317d9cb8f10aa0b3750bdb6db8b4e77ff26f8.camel@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 05:22:30PM -0400, Jeff Layton wrote:
> On Tue, 2023-05-16 at 20:50 +0000, Ondrej Valousek wrote:
> > 
> > Hi Christian,
> > 
> > Would it be possible to patch kernel the way it accepts native (i.e no
> > conversion to Posix ACL) NFSv4 style ACLs for filesystems that can
> > support them?
> > I.E. OpenZFS, NTFS, could be also interesting for Microsofts WSL2  or
> > Samba right?
> > 
> > I mean, I am not trying to push richacl again knowing they have been
> > rejected, but just NFS4 style Acls as they are so similar to Windows
> > ACLs.
> > 
> 
> Erm, except you kind of are if you want to do this. I don't see how this
> idea works unless you resurrect RichACLs or something like them.

I have no idea about the original flame war that ended RichACLs in
additition to having no clear clue what RichACLs are supposed to
achieve. My current knowledge extends to "Christoph didn't like them".

> 
> > The idea here would be that we could
> > - mount NTFS/ZFS filesystem and inspect ACLs using existing tools
> > (nfs4_getacl)
> > - share with NFSv4 in a pass through mode
> > - in Windows WSL2 we could inspect local filesystem ACLs using the
> > same tools
> > 
> > Does it make any sense or it would require lot of changes to VFS
> > subsystem or its a nonsense altogether?

Yes, very likely.

We'd either have to change the current inode operations for getting and
setting acls to take a new struct acl that can contain either posix acls
or rich acls or add new ones just for these new fangled ones.

Choosing the first - more sensible - of these two options will mean
updating each filesystem's acl inode operations. Might turn out to not
be invasive code as it might boil down to struct posix_acl *acl =
acl->posix at the beginning of each method but still.

Then we'd probably also need to:

* handle permission checking (see Jeff's comment below)
* change/update the ACL caching layer
* if the past hast taught me anything then overlayfs would probably need
  some additional logic as well

> > 
> 
> Eventually you have to actually enforce the ACL. Do NTFS/ZFS already
> have code to do this? If not then someone would need to write it.
> 
> Also windows and nfs acls do have some differences, so you'll need a
> translation layer too.

Jeff, I know you have some knowledge in this area you probably are
better equipped to judge the sanity and feasibility of this.
