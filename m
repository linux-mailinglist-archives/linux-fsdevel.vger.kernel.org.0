Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30945EFF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 15:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbhKZOjK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 09:39:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:52742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353859AbhKZOgR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:36:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 797C21FD37;
        Fri, 26 Nov 2021 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637937183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1fzidqYL56unlF2FIZaeBfX9obUguACzN89MufyMIc=;
        b=gSdaIOsERXGSL4TcKaCGE34ifCcO4tN5LkUbIo5l5zencb0sOYtKQV23sGzLRTabNo6Qm0
        RGvDuaCb5wjOOdHZmrF1hQYbOFCBbtTdRBcjzB32z0Wi9aoJu8tul70eFzwGeeOZsICIgh
        rYwWgO2R2J5v/udnjSUr65XeO93anPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637937183;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1fzidqYL56unlF2FIZaeBfX9obUguACzN89MufyMIc=;
        b=5AvR0gFY4EcOv+pKuePvzmi8iNrvxM1Fs9pOD3oqmHWIGu/E+t9Uju8jBwHedGbIC8xzmd
        rCeom3mC5Eb1YMAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id EF5A1A3B83;
        Fri, 26 Nov 2021 14:33:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BFC4E1E11F3; Fri, 26 Nov 2021 15:32:59 +0100 (CET)
Date:   Fri, 26 Nov 2021 15:32:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chengguang Xu <charliecgxu@tencent.com>,
        ronyjin <ronyjin@tencent.com>
Subject: Re: [RFC PATCH V6 2/7] ovl: mark overlayfs inode dirty when it has
 upper
Message-ID: <20211126143259.GH13004@quack2.suse.cz>
References: <20211122030038.1938875-1-cgxu519@mykernel.net>
 <20211122030038.1938875-3-cgxu519@mykernel.net>
 <20211126091007.GB13004@quack2.suse.cz>
 <17d5c5a6fed.f090bcae10973.4735687401243313694@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17d5c5a6fed.f090bcae10973.4735687401243313694@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-11-21 21:06:10, Chengguang Xu wrote:
>  ---- 在 星期五, 2021-11-26 17:10:07 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Mon 22-11-21 11:00:33, Chengguang Xu wrote:
>  > > From: Chengguang Xu <charliecgxu@tencent.com>
>  > > 
>  > > We simply mark overlayfs inode dirty when it has upper,
>  > > it's much simpler than mark dirtiness on modification.
>  > > 
>  > > Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
>  > > ---
>  > >  fs/overlayfs/inode.c | 4 +++-
>  > >  fs/overlayfs/util.c  | 1 +
>  > >  2 files changed, 4 insertions(+), 1 deletion(-)
>  > > 
>  > > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>  > > index 1f36158c7dbe..027ffc0a2539 100644
>  > > --- a/fs/overlayfs/inode.c
>  > > +++ b/fs/overlayfs/inode.c
>  > > @@ -778,8 +778,10 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
>  > >  {
>  > >      struct inode *realinode;
>  > >  
>  > > -    if (oip->upperdentry)
>  > > +    if (oip->upperdentry) {
>  > >          OVL_I(inode)->__upperdentry = oip->upperdentry;
>  > > +        mark_inode_dirty(inode);
>  > > +    }
>  > >      if (oip->lowerpath && oip->lowerpath->dentry)
>  > >          OVL_I(inode)->lower = igrab(d_inode(oip->lowerpath->dentry));
>  > >      if (oip->lowerdata)
>  > 
>  > Hum, does this get called only for inodes with upper inode existing? I
>  > suppose we do not need to track inodes that were not copied up because they
>  > cannot be dirty? I'm sorry, my knowledge of overlayfs is rather limited so
>  > I may be missing something basic.
>  > 
> 
> Well, as long as overly inode has upper it can be modified without copy-up,
> so we need to track all overlay inodes which have upper inode.

OK, and oip->upperdentry is set only if there's upper inode, now I
understand. Thanks for explanation and feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
