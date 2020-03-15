Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E505185D99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 15:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgCOOeb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 10:34:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49496 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgCOOea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:34:30 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDULT-00Bybf-1t; Sun, 15 Mar 2020 14:34:27 +0000
Date:   Sun, 15 Mar 2020 14:34:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH v4 38/69] do_last(): simplify the liveness analysis
 past finish_open_created
Message-ID: <20200315143427.GV23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200315124007.1504-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315124007.1504-1-hdanton@sina.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 15, 2020 at 08:40:07PM +0800, Hillf Danton wrote:
> 
> On Fri, 13 Mar 2020 23:53:26 +0000
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Don't mess with got_write there - it is guaranteed to be false on
> > entry and it will be set true if and only if we decide to go for
> > truncation and manage to get write access for that.
> > 
> > Don't carry acc_mode through the entire thing - it's only used
> > in that part.  And don't bother with gotos in there - compiler is
> > quite capable of optimizing that.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/namei.c | 28 +++++++++++-----------------
> >  1 file changed, 11 insertions(+), 17 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index c85fdfd6b33d..8cdf8ef41194 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3122,9 +3122,9 @@ static const char *do_last(struct nameidata *nd,
> >  	kuid_t dir_uid = nd->inode->i_uid;
> >  	umode_t dir_mode = nd->inode->i_mode;
> >  	int open_flag = op->open_flag;
> > -	bool will_truncate = (open_flag & O_TRUNC) != 0;
> > +	bool do_truncate;
> >  	bool got_write = false;
> 
> Without got_write cut,
> 
> > -	int acc_mode = op->acc_mode;
> > +	int acc_mode;
> >  	unsigned seq;
> >  	struct inode *inode;
> >  	struct dentry *dentry;
> > @@ -3243,36 +3243,30 @@ static const char *do_last(struct nameidata *nd,
> >  		return ERR_PTR(-ENOTDIR);
> >  
> >  finish_open_created:
> > +	do_truncate = false;
> > +	acc_mode = op->acc_mode;
> >  	if (file->f_mode & FMODE_CREATED) {
> >  		/* Don't check for write permission, don't truncate */
> >  		open_flag &= ~O_TRUNC;
> > -		will_truncate = false;
> >  		acc_mode = 0;
> > -	} else if (!d_is_reg(nd->path.dentry)) {
> > -		will_truncate = false;
> > -	}
> > -	if (will_truncate) {
> > +	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
> >  		error = mnt_want_write(nd->path.mnt);
> >  		if (error)
> >  			return ERR_PTR(error);
> > -		got_write = true;
> > +		do_truncate = true;
> 
> replacing its role with do_truncate probably makes it easier to maintain
> do_last() leaving readers baffling and digging in logs after going up
> and down the code but failing to grip what is inteded in this patch.
> 
> And that kink can be fixed perhaps simply by not axing this got_write.

I'm sorry, I'd been unable to parse that ;-/  What do you mean?
