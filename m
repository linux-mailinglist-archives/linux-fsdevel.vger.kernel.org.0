Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B1178FDC0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Sep 2023 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbjIAMvP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Sep 2023 08:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbjIAMvP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:51:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479BE1726;
        Fri,  1 Sep 2023 05:50:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE22260DFF;
        Fri,  1 Sep 2023 12:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AD8C433C8;
        Fri,  1 Sep 2023 12:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693572638;
        bh=nMZ96azLHYWOYXamjxieuqFfT91YKa/NfwWGHknuPOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8wsQTwLmYV87LF3PK4H2AQ7G1wx/tK9CDEsJ/DyuLkl21MZG6X5XYFgyIrPrP7Vq
         a7NP/uk99iNgEq6sSEUfRzicNdhdarQM0aI0Je56+u4rmDeO9xkiCzV561wHIXOM4q
         x8MaI0RWxXkHXLJCLZsaKRBOtiYGRUcJaODa6gPqTOAiAzJ26qL6DBEVsF6Ace5KjC
         +G4rdN1g1utaP9bkhWy6SoNufaCKGaR50a9tkSHr2HgB/HIfQg1VRU49174lyRcTe4
         /0QR7t888E4uYAZFkq5a8rMhFbPbAO5ZncJbbWxn3n03+EQyOzYlm9b9CO5+jupH1L
         qaoteLrPPTfbw==
Date:   Fri, 1 Sep 2023 14:50:33 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Bernd Schubert <bernd.schubert@fastmail.fm>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        miklos@szeredi.hu, dsingh@ddn.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/2] fs: Add and export file_needs_remove_privs
Message-ID: <20230901-briefe-amtieren-0c8b555219cb@brauner>
References: <20230831112431.2998368-1-bschubert@ddn.com>
 <20230831112431.2998368-2-bschubert@ddn.com>
 <20230831-letzlich-eruption-9187c3adaca6@brauner>
 <99bc64c2-44e2-5000-45b7-d9343bcc8fb8@fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99bc64c2-44e2-5000-45b7-d9343bcc8fb8@fastmail.fm>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 31, 2023 at 04:17:01PM +0200, Bernd Schubert wrote:
> 
> 
> On 8/31/23 15:40, Christian Brauner wrote:
> > On Thu, Aug 31, 2023 at 01:24:30PM +0200, Bernd Schubert wrote:
> > > File systems want to hold a shared lock for DIO writes,
> > > but may need to drop file priveliges - that a requires an
> > > exclusive lock. The new export function file_needs_remove_privs()
> > > is added in order to first check if that is needed.
> > > 
> > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > Cc: Dharmendra Singh <dsingh@ddn.com>
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: linux-btrfs@vger.kernel.org
> > > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> > > ---
> > >   fs/inode.c         | 8 ++++++++
> > >   include/linux/fs.h | 1 +
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 67611a360031..9b05db602e41 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -2013,6 +2013,14 @@ int dentry_needs_remove_privs(struct mnt_idmap *idmap,
> > >   	return mask;
> > >   }
> > > +int file_needs_remove_privs(struct file *file)
> > > +{
> > > +	struct dentry *dentry = file_dentry(file);
> > > +
> > > +	return dentry_needs_remove_privs(file_mnt_idmap(file), dentry);
> > 
> > Ugh, I wanted to propose to get rid of this dentry dance but I propsed
> > that before and remembered it's because of __vfs_getxattr() which is
> > called from the capability security hook that we need it...
> 
> Is there anything specific you are suggesting?

No, it's not actionable for you here. It would require adding inode
methods to set and get filesystem capabilities and then converting it in
such a way that we don't need to rely on passing dentries around. That's
a separate larger patchset that we would need with surgery across a
bunch of filesystems and the vfs - Seth (Forshee) has been working on this.

The callchains are just pointless which I remembered when I saw the
patchset:

file_needs_remove_privs(file)
-> dentry_needs_remove_privs(dentry)
   -> inode = d_inode(dentry)
      // do inode stuff
      // security_needs_*(dentry)

point is ideally we shouldn't need the dentry in *remove_privs() at all.
