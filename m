Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5743774A69B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 00:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjGFWND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 18:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFWNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:13:02 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323951B6;
        Thu,  6 Jul 2023 15:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AOUdoCKv7lMKEBDeJuW8QLGANU11vjlDtc+UqVr1zFk=; b=oejr2bmq1uN3b7HrJx+ElPbSw5
        we3jUSGkXPajsm1VTvHviFC3GwS/NaHsz1QsPFRkvaUq7r+rBdyS2errjC3EY1PRnVjcDpGUlgYvK
        /1soI8bcSeGMJWZholjAS8+Qt+OwFn3a0aWHzps1cm/yKVnv/q2YxMXWdR874NBXlbeB4wr+Skl2c
        nM3+qFNFe9U/hWkDh9MMQME0URBrMEUda85VjmrM7Gu5M5Eh2LxPzWYWt/Fbt8l1kSRtIAT4twoVr
        jwlsg1lVsmOlMQlJWr5vCfx9rhtl9TtKl2S6xbuCXnbXSHWru+tXgvWDWT4P1WhYRdUGV2SMVYxDS
        1rK8eJQg==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHXDb-0035IK-0N;
        Thu, 06 Jul 2023 22:12:55 +0000
Date:   Thu, 6 Jul 2023 15:12:51 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 32/92] configfs: convert to ctime accessor functions
Message-ID: <ZKc8Y8IB4DShCPZf@google.com>
Mail-Followup-To: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-30-jlayton@kernel.org>
 <20230706105446.r32oft4i3cj5bk3y@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706105446.r32oft4i3cj5bk3y@quack3>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:54:46PM +0200, Jan Kara wrote:
> On Wed 05-07-23 15:00:57, Jeff Layton wrote:
> > In later patches, we're going to change how the inode's ctime field is
> > used. Switch to using accessor functions instead of raw accesses of
> > inode->i_ctime.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Agreed.

Acked-by: Joel Becker <jlbec@evilplan.org>

> 
> 								Honza
> 
> > ---
> >  fs/configfs/inode.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> > index 1c15edbe70ff..fbdcb3582926 100644
> > --- a/fs/configfs/inode.c
> > +++ b/fs/configfs/inode.c
> > @@ -88,8 +88,7 @@ int configfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >  static inline void set_default_inode_attr(struct inode * inode, umode_t mode)
> >  {
> >  	inode->i_mode = mode;
> > -	inode->i_atime = inode->i_mtime =
> > -		inode->i_ctime = current_time(inode);
> > +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
> >  }
> >  
> >  static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
> > @@ -99,7 +98,7 @@ static inline void set_inode_attr(struct inode * inode, struct iattr * iattr)
> >  	inode->i_gid = iattr->ia_gid;
> >  	inode->i_atime = iattr->ia_atime;
> >  	inode->i_mtime = iattr->ia_mtime;
> > -	inode->i_ctime = iattr->ia_ctime;
> > +	inode_set_ctime_to_ts(inode, iattr->ia_ctime);
> >  }
> >  
> >  struct inode *configfs_new_inode(umode_t mode, struct configfs_dirent *sd,
> > @@ -172,7 +171,7 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	p_inode = d_inode(dentry->d_parent);
> > -	p_inode->i_mtime = p_inode->i_ctime = current_time(p_inode);
> > +	p_inode->i_mtime = inode_set_ctime_current(p_inode);
> >  	configfs_set_inode_lock_class(sd, inode);
> >  	return inode;
> >  }
> > -- 
> > 2.41.0
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 

Life's Little Instruction Book #237

	"Seek out the good in people."

			http://www.jlbec.org/
			jlbec@evilplan.org
