Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECB2AEF03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 11:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgKKKyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 05:54:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgKKKyH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:54:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6455ABDE;
        Wed, 11 Nov 2020 10:54:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7F4971E130B; Wed, 11 Nov 2020 11:54:05 +0100 (CET)
Date:   Wed, 11 Nov 2020 11:54:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, miklos <miklos@szeredi.hu>,
        amir73il <amir73il@gmail.com>,
        linux-unionfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 07/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20201111105405.GB28132@quack2.suse.cz>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-8-cgxu519@mykernel.net>
 <20201110134551.GA28132@quack2.suse.cz>
 <175b2b6ef3d.11f9425843834.4407023737229017217@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175b2b6ef3d.11f9425843834.4407023737229017217@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-11-20 23:12:14, Chengguang Xu wrote:
>  ---- 在 星期二, 2020-11-10 21:45:51 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Sun 08-11-20 22:03:04, Chengguang Xu wrote:
>  > > +static int ovl_write_inode(struct inode *inode,
>  > > +               struct writeback_control *wbc)
>  > > +{
>  > > +    struct ovl_fs *ofs = inode->i_sb->s_fs_info;
>  > > +    struct inode *upper = ovl_inode_upper(inode);
>  > > +    unsigned long iflag = 0;
>  > > +    int ret = 0;
>  > > +
>  > > +    if (!upper)
>  > > +        return 0;
>  > > +
>  > > +    if (!ovl_should_sync(ofs))
>  > > +        return 0;
>  > > +
>  > > +    if (upper->i_sb->s_op->write_inode)
>  > > +        ret = upper->i_sb->s_op->write_inode(inode, wbc);
>  > > +
>  > > +    iflag |= upper->i_state & I_DIRTY_ALL;
>  > > +
>  > > +    if (mapping_writably_mapped(upper->i_mapping) ||
>  > > +        mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
>  > > +        iflag |= I_DIRTY_PAGES;
>  > > +
>  > > +    if (iflag)
>  > > +        ovl_mark_inode_dirty(inode);
>  > 
>  > I think you didn't incorporate feedback we were speaking about in the last
>  > version of the series. May comment in [1] still applies - you can miss
>  > inodes dirtied through mmap when you decide to clean the inode here. So
>  > IMHO you need something like:
>  > 
>  >     if (inode_is_open_for_write(inode))
>  >         ovl_mark_inode_dirty(inode);
>  > 
>  > here to keep inode dirty while it is open for write (and not based on upper
>  > inode state which is unreliable).
> 
> Hi Jan,
> 
> I not only checked upper inode state but also checked upper inode
> mmap(shared) state using  mapping_writably_mapped(upper->i_mapping).
> Maybe it's better to move i_state check after mmap check but isn't above
> checks enough for mmapped file? 

Ah, sorry, I'm blind! I missed the mapping_writably_mapped() check. Thanks
for explanation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
