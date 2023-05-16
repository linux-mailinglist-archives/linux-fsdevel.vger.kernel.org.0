Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D71704DC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 14:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjEPM3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 08:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjEPM3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 08:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD6E4696;
        Tue, 16 May 2023 05:29:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D40661630;
        Tue, 16 May 2023 12:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A9FC433EF;
        Tue, 16 May 2023 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684240155;
        bh=r5AMvFjsu0wKe7WHLiRzP77bMszVHQQWOY6pFFdPMp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lANxTGZXG7Ih7FQ4OAKuX2sRdIGEL5/iElliXC9BdQT7Y/Nj90xXvtnRwfKcbmApZ
         iVHsEcaRcFQHfDjVS+TiXVyoILUda7NRv0epEz2DXzN9dWes582+tA3cqhDTC0Xqli
         jkRNVtDdm051IugYIWygBQTpsTZ0WhFiCEube7LgRAQ6tf/BDiV0wuZdBt+woBgMfs
         hrMuSZtNdlfMRsWqq1ZLMhiXQGK/l2sf8pUQj/IL8yLvG9TbwK1buRx0lARYX36gym
         vZSJ2S0baBkWSKIbaZFN2j/yvB/XDJEt43qSSZLeui7Lz/JVvc6UG+hMMziBFkiDdy
         XhyWesJEu2H+Q==
Date:   Tue, 16 May 2023 14:29:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "eggert@cs.ucla.edu" <eggert@cs.ucla.edu>,
        "bruno@clisp.org" <bruno@clisp.org>,
        "ondrej.valousek.xm@renesas.com" <ondrej.valousek.xm@renesas.com>,
        "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] fix NFSv4 acl detection on F39
Message-ID: <20230516-editieren-flechten-34165a3268a9@brauner>
References: <TYXPR01MB1854B3C3B8215DD0FA7B83CCD96D9@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <17355394.lhrHg4fidi@nimes>
 <32edbaf1-d3b1-6057-aefc-d83df3266c20@cs.ucla.edu>
 <4f1519d8-bda1-1b15-4a78-a8072ba1551a@cs.ucla.edu>
 <TYXPR01MB18547A591663A4934B5D4D82D9789@TYXPR01MB1854.jpnprd01.prod.outlook.com>
 <fb005d7e29f1167b83acf7b10800ff3124ee2a50.camel@redhat.com>
 <f967cbcc1620d1a5e68d7f005571dc569c8b5bb4.camel@hammerspace.com>
 <d4e26d9e4d9113f8da20425f5bf7ad91c786f381.camel@redhat.com>
 <20230516-distanz-abkommen-95e565ba928b@brauner>
 <b4f836aa654acef4825dc8e502afe415a6956ffb.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4f836aa654acef4825dc8e502afe415a6956ffb.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 08:20:33AM -0400, Jeff Layton wrote:
> On Tue, 2023-05-16 at 11:17 +0200, Christian Brauner wrote:
> > On Mon, May 15, 2023 at 01:49:21PM -0400, Jeff Layton wrote:
> > > On Mon, 2023-05-15 at 17:28 +0000, Trond Myklebust wrote:
> > > > On Mon, 2023-05-15 at 13:11 -0400, Jeff Layton wrote:
> > > > > On Mon, 2023-05-15 at 11:50 +0000, Ondrej Valousek wrote:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > Ok first of all, thanks for taking initiative on this, I am unable
> > > > > > to proceed on this on my own at the moment.
> > > > > > I see few problems with this:
> > > > > > 
> > > > > > 1. The calculation of the 'listbufsize' is incorrect in your patch.
> > > > > > It will _not_work as you expected and won't limit the number of
> > > > > > syscalls (which is why we came up with this patch, right?). Check
> > > > > > with my original proposal, we really need to check for
> > > > > > 'system.nfs4' xattr name presence here
> > > > > > 2. It mistakenly detects an ACL presence on files which do not have
> > > > > > any ACL on NFSv4 filesystem. Digging further it seems that kernel
> > > > > > in F39 behaves differently to the previous kernels:
> > > > > > 
> > > > > > F38: 
> > > > > > # getfattr -m . /path_to_nfs4_file
> > > > > > # file: path_to_nfs4_file
> > > > > > system.nfs4_acl                                    <---- only
> > > > > > single xattr detected
> > > > > > 
> > > > > > F39:
> > > > > > # getfattr -m . /path_to_nfs4_file
> > > > > > # file: path_to_nfs4_file
> > > > > > system.nfs4_acl
> > > > > > system.posix_acl_default
> > > > > > /* SOMETIMES even shows this */
> > > > > > system.posix_acl_default
> > > > > 
> > > > > (cc'ing Christian and relevant kernel lists)
> > > > > 
> > > > > I assume the F39 kernel is v6.4-rc based? If so, then I think that's
> > > > > a
> > > > > regression. NFSv4 client inodes should _not_ report a POSIX ACL
> > > > > attribute since the protocol doesn't support them.
> > > > > 
> > > > > In fact, I think the rationale in the kernel commit below is wrong.
> > > > > NFSv4 has a listxattr operation, but doesn't support POSIX ACLs.
> > > > > 
> > > > > Christian, do we need to revert this?
> > > > > 
> > > > > commit e499214ce3ef50c50522719e753a1ffc928c2ec1
> > > > > Author: Christian Brauner <brauner@kernel.org>
> > > > > Date:   Wed Feb 1 14:15:01 2023 +0100
> > > > > 
> > > > >     acl: don't depend on IOP_XATTR
> > > > >     
> > > > > 
> > > > 
> > > > 
> > > > No. The problem is commit f2620f166e2a ("xattr: simplify listxattr
> > > > helpers") which helpfully inserts posix acl handlers into
> > > > generic_listxattr(), and makes it impossible to call from
> > > > nfs4_listxattr().
> > > > 
> > > 
> > > 
> > > Ahh ok. Looking at that function though, it seems like it'd only report
> > > these for mounts that set SB_POSIXACL. Any reason that we have that
> > > turned on with v4 mounts?
> > 
> > You seem to just be calling generic_listxattr() in fs/nfs/nfs4proc.c and
> > not using it as an inode operation.
> > 
> 
> Correct, but even if we were, this would be doing the wrong thing. As
> Trond pointed out, f2620f166e2a changed the behavior of
> generic_listxattr to make it include the POSIX ACL entries.
> 
> > So imho just add a tiny helper into
> > fs/xattr.c that takes a boolean argument and skips over POSIX ACLs that
> > you can call in nfs4. That should be enough, no?
> > 
> 
> The only other user of generic_listxattr is HFS, and I don't think it
> supports POSIX ACLs either. I think we should probably just remove the
> call to posix_acl_listxattr from generic_listxattr.

Ok, I see. Thanks for spotting this.

The reason POSIX ACLs were moved into generic_listxattr() was because
they would've been included before too. If any filesystem would have
registered sb->s_xattr handlers for POSIX ACLs they would've been
included in generic_listxattr().

Can you send a patch to me so I can route it to Linus? Please add a
comment that this function doesn't return POSIX ACLs.
