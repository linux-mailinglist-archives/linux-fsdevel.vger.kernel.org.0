Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FF745AA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 12:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjGCK6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 06:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjGCK57 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:57:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD53C4;
        Mon,  3 Jul 2023 03:57:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C4D60EE1;
        Mon,  3 Jul 2023 10:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ADFC433C7;
        Mon,  3 Jul 2023 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688381877;
        bh=X6NTHK1V9hQ3u5YQ6AjJYZg0fYXUZsJMcSevMRkdaj8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkiF4/UPjK3AQx1uvID62TrA4kyplMqx9JwcK/quxoavokz+xAC4L2Zl3HdEDWC1s
         DsSLBHqEqj3O/j6bf+32TgKkTcmVygdacEwoxqfrxjIQL9hqRtyTH24Ggj7rl6J/Et
         P7+jORQrXGcdIJyaGY84kfOQSlrXgblO/qxS6cbqv/zGnr5ahmAKWL9JhvzWo3KBP5
         cgx0LpM61tekxfVkTXMRgb2pcAF89WKlDabTXQPtOn1NQYAn5aLa8jTTqDbcQ1Ab2N
         DBWxurZIT4/ZWZ4inYg898H/g0ZDPjTgIMqmA1PFEeTDpZAsmyHJ6hD37Nfd+Pv9f0
         Hb0pieczgkV9g==
Date:   Mon, 3 Jul 2023 12:57:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Kara <jack@suse.cz>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org,
        "damien.lemoal" <damien.lemoal@opensource.wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 15/79] bfs: switch to new ctime accessors
Message-ID: <20230703-tauschen-kriegen-b0acf3b1f11f@brauner>
References: <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-14-jlayton@kernel.org>
 <20230621164808.5lhujni7qb36hhtk@quack3>
 <646b7283ede4945b335ad16aea5ff60e1361241e.camel@kernel.org>
 <20230622123050.thpf7qdnmidq3thj@quack3>
 <d316dca7c248693575dae3d8032e9e3332bbae7a.camel@kernel.org>
 <20230622145747.lokguccxtrrpgb3b@quack3>
 <20230623-kaffee-volumen-014cfa91a2ee@brauner>
 <20230703-gebucht-improvisieren-6c9b66612f07@brauner>
 <a05703b82a903f82efe32b9b358fc03b71fe7460.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a05703b82a903f82efe32b9b358fc03b71fe7460.camel@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 03, 2023 at 06:46:33AM -0400, Jeff Layton wrote:
> On Mon, 2023-07-03 at 12:12 +0200, Christian Brauner wrote:
> > On Fri, Jun 23, 2023 at 02:33:26PM +0200, Christian Brauner wrote:
> > > On Thu, Jun 22, 2023 at 04:57:47PM +0200, Jan Kara wrote:
> > > > On Thu 22-06-23 08:51:58, Jeff Layton wrote:
> > > > > On Thu, 2023-06-22 at 14:30 +0200, Jan Kara wrote:
> > > > > > On Wed 21-06-23 12:57:19, Jeff Layton wrote:
> > > > > > > On Wed, 2023-06-21 at 18:48 +0200, Jan Kara wrote:
> > > > > > > > On Wed 21-06-23 10:45:28, Jeff Layton wrote:
> > > > > > > > > In later patches, we're going to change how the ctime.tv_nsec field is
> > > > > > > > > utilized. Switch to using accessor functions instead of raw accesses of
> > > > > > > > > inode->i_ctime.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > 
> > > > > > > > ...
> > > > > > > > 
> > > > > > > > > diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> > > > > > > > > index 1926bec2c850..c964316be32b 100644
> > > > > > > > > --- a/fs/bfs/inode.c
> > > > > > > > > +++ b/fs/bfs/inode.c
> > > > > > > > > @@ -82,10 +82,10 @@ struct inode *bfs_iget(struct super_block *sb, unsigned long ino)
> > > > > > > > >  	inode->i_blocks = BFS_FILEBLOCKS(di);
> > > > > > > > >  	inode->i_atime.tv_sec =  le32_to_cpu(di->i_atime);
> > > > > > > > >  	inode->i_mtime.tv_sec =  le32_to_cpu(di->i_mtime);
> > > > > > > > > -	inode->i_ctime.tv_sec =  le32_to_cpu(di->i_ctime);
> > > > > > > > > +	inode_ctime_set_sec(inode, le32_to_cpu(di->i_ctime));
> > > > > > > > >  	inode->i_atime.tv_nsec = 0;
> > > > > > > > >  	inode->i_mtime.tv_nsec = 0;
> > > > > > > > > -	inode->i_ctime.tv_nsec = 0;
> > > > > > > > > +	inode_ctime_set_nsec(inode, 0);
> > > > > > > > 
> > > > > > > > So I'm somewhat wondering here - in other filesystem you construct
> > > > > > > > timespec64 and then use inode_ctime_set(). Here you use
> > > > > > > > inode_ctime_set_sec() + inode_ctime_set_nsec(). What's the benefit? It
> > > > > > > > seems these two functions are not used that much some maybe we could just
> > > > > > > > live with just inode_ctime_set() and constructing timespec64 when needed?
> > > > > > > > 
> > > > > > > > 								Honza
> > > > > > > 
> > > > > > > The main advantage is that by using that, I didn't need to do quite so
> > > > > > > much of this conversion by hand. My coccinelle skills are pretty
> > > > > > > primitive. I went with whatever conversion was going to give minimal
> > > > > > > changes, to the existing accesses for the most part.
> > > > > > > 
> > > > > > > We could certainly do it the way you suggest, it just means having to
> > > > > > > re-touch a lot of this code by hand, or someone with better coccinelle
> > > > > > > chops suggesting a way to declare a temporary variables in place.
> > > > > > 
> > > > > > Well, maybe temporary variables aren't that convenient but we could provide
> > > > > > function setting ctime from sec & nsec value without having to declare
> > > > > > temporary timespec64? Attached is a semantic patch that should deal with
> > > > > > that - at least it seems to handle all the cases I've found.
> > > > > > 
> > > > > 
> > > > > Ok, let me try respinning this with your cocci script and see how it
> > > > > looks.
> > > > > 
> > > > > Damien also suggested in a reply to the zonefs patch a preference for
> > > > > the naming style you have above. Should I also rename these like?
> > > > > 
> > > > >     inode_ctime_peek -> inode_get_ctime
> > > > >     inode_ctime_set -> inode_set_ctime
> > > > > 
> > > > > This would be the time to change it if that's preferred.
> > > > 
> > > > I don't really care much so whatever you decide is better :)
> > > 
> > > I have a mild preference for inode_{get,set}_ctime().
> > 
> > Jeff, did you plan on sending a v2 with this renamed or do you want me
> > to pick this up now?
> 
> I'm working on a new set that I'll send out in a few days. Sorry it has
> taken a while, I spent quite a bit of time trying to improve my
> coccinelle chops for this.

Absolutely no problem of course. I just wanted to check that I didn't
pointlessly delay you by not taking care of this.

Thanks!
