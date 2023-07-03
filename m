Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2067459D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 12:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGCKMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjGCKMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:12:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826279B;
        Mon,  3 Jul 2023 03:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 186AF60EA9;
        Mon,  3 Jul 2023 10:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F076DC433C8;
        Mon,  3 Jul 2023 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688379153;
        bh=NCFy55Pajaam8SaLdnPOr8W0by3nz+Ef4X/6Dc6sYsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEzYALP3Hf9tNTQXM82NBY90r1JwMHulX99CSv404A/nj4+oOcW8rvFQxm8sFWZDs
         3MZ6R1qiEmnop48inYrAYE5JY45pdf5EYVI24Wqb4RBBFwHRw9CHWEo53t001Rqy83
         1wYnDToEL1fr3o+EwqCPPeteYwAlzuMvmIzsa8OqI+1bjrnsaQBUfogT6YqqJlSN44
         WqC2fBJF7iMKyWlGF8q2UAagsmxCW6v5DFlitW1mu8eBcluxqLwPB0FtxXtixtNBTG
         +dVIIlzdpcpZOM/RqmEnGREZU3XW0DINlw1e+i3OL827LMEw0khaFMfJlCd7/lOUQh
         kaXVXOp1tobCQ==
Date:   Mon, 3 Jul 2023 12:12:29 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Kara <jack@suse.cz>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        "damien.lemoal" <damien.lemoal@opensource.wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
Message-ID: <20230703-gebucht-improvisieren-6c9b66612f07@brauner>
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-14-jlayton@kernel.org>
 <20230621164808.5lhujni7qb36hhtk@quack3>
 <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
 <20230622123050.thpf7qdnmidq3thj@quack3>
 <d316dca7c248693575dae3d8032e9e3332bbae7a.camel@kernel.org>
 <20230622145747.lokguccxtrrpgb3b@quack3>
 <20230623-kaffee-volumen-014cfa91a2ee@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623-kaffee-volumen-014cfa91a2ee@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 23, 2023 at 02:33:26PM +0200, Christian Brauner wrote:
> On Thu, Jun 22, 2023 at 04:57:47PM +0200, Jan Kara wrote:
> > On Thu 22-06-23 08:51:58, Jeff Layton wrote:
> > > On Thu, 2023-06-22 at 14:30 +0200, Jan Kara wrote:
> > > > On Wed 21-06-23 12:57:19, Jeff Layton wrote:
> > > > > On Wed, 2023-06-21 at 18:48 +0200, Jan Kara wrote:
> > > > > > On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> > > > > > > In later patches, we're going to change how the ctime.tv_nsec field is
> > > > > > > utilized. Switch to using accessor functions instead of raw accesses of
> > > > > > > inode->i_ctime.
> > > > > > > 
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > 
> > > > > > ...
> > > > > > 
> > > > > > > diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> > > > > > > index 1926bec2c850..c964316be32b 100644
> > > > > > > --- a/fs/bfs/inode.c
> > > > > > > +++ b/fs/bfs/inode.c
> > > > > > > @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
> > > > > > >  	inode->i_blocks = BFS_FILEBLOCKS(di);
> > > > > > >  	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
> > > > > > >  	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
> > > > > > > -	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
> > > > > > > +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
> > > > > > >  	inode->i_atime.tv_nsec = 0;
> > > > > > >  	inode->i_mtime.tv_nsec = 0;
> > > > > > > -	inode->i_ctime.tv_nsec = 0;
> > > > > > > +	inode_ctime_set_nsec(inode, 0);
> > > > > > 
> > > > > > So I'm somewhat wondering here - in other filesystem you construct
> > > > > > timespec64 and then use inode_ctime_set(). Here you use
> > > > > > inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? It
> > > > > > seems these two functions are not used that much some maybe we could just
> > > > > > live with just inode_ctime_set() and constructing timespec64 when needed?
> > > > > > 
> > > > > > 								Honza
> > > > > 
> > > > > The main advantage is that by using that, I didn't need to do quite so
> > > > > much of this conversion by hand. My coccinelle skills are pretty
> > > > > primitive. I went with whatever conversion was going to give minimal
> > > > > changes, to the existing accesses for the most part.
> > > > > 
> > > > > We could certainly do it the way you suggest, it just means having to
> > > > > re-touch a lot of this code by hand, or someone with better coccinelle
> > > > > chops suggesting a way to declare a temporary variables in place.
> > > > 
> > > > Well, maybe temporary variables aren't that convenient but we could provide
> > > > function setting ctime from sec & nsec value without having to declare
> > > > temporary timespec64? Attached is a semantic patch that should deal with
> > > > that - at least it seems to handle all the cases I've found.
> > > > 
> > > 
> > > Ok, let me try respinning this with your cocci script and see how it
> > > looks.
> > > 
> > > Damien also suggested in a reply to the zonefs patch a preference for
> > > the naming style you have above. Should I also rename these like?
> > > 
> > >     inode_ctime_peek -> inode_get_ctime
> > >     inode_ctime_set -> inode_set_ctime
> > > 
> > > This would be the time to change it if that's preferred.
> > 
> > I don't really care much so whatever you decide is better :)
> 
> I have a mild preference for inode_{get,set}_ctime().

Jeff, did you plan on sending a v2 with this renamed or do you want me
to pick this up now?
