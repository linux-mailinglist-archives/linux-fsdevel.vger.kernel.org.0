Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D863504B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Apr 2022 05:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiDRDLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Apr 2022 23:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiDRDLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:11:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36775186F9;
        Sun, 17 Apr 2022 20:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cr0CVOdS5okWrJVBplWYDXiXksMwwPiOAV0K2em79Qw=; b=Lq6N9I9OQl8ZiOp+wKe9GGd1X3
        cMMaJLRrsuevLRaK4khhCJYxxCBoKL/mXsZlAJ72jCyG94owuVXAXJVmAgTGJ10ND/3fvdOywPfXk
        51dhD82AtEdlNPJYa9a1Rj7Sc2jEtYvI7SMg9DYpnvIOeMS138kaFdXx92+C2Po53BTcEBKb6M/7+
        f5jdSvmGXz3sa08efWBnfJ9Ievcp8P6+4Q059t4y+DJ90NfI6pZfQ30ToP2gIvWILVVgnwf+6aDNS
        LvUK1uZNvz+JKNdhwMvbD9xgPp8zRCxELk6TLmkQ8hUG/6c8Bh7L5butrNV5IKOPjHxy/3IpTMa9x
        iO3QAJTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngHkx-001l2F-RE; Mon, 18 Apr 2022 03:08:51 +0000
Date:   Mon, 18 Apr 2022 04:08:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, david@fromorbit.com,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        jlayton@kernel.org
Subject: Re: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <YlzWQyF5e14/UVDs@casper.infradead.org>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220415140924.oirar6dklelujnxs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415140924.oirar6dklelujnxs@wittgenstein>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 04:09:24PM +0200, Christian Brauner wrote:
> > +			inode_sgid_strip(mnt_userns, dir, &mode);
> >  	} else
> >  		inode_fsgid_set(inode, mnt_userns);
> >  	inode->i_mode = mode;
> > @@ -2405,3 +2403,21 @@ struct timespec64 current_time(struct inode *inode)
> >  	return timestamp_truncate(now, inode);
> >  }
> >  EXPORT_SYMBOL(current_time);
> > +
> > +void inode_sgid_strip(struct user_namespace *mnt_userns,
> > +		      const struct inode *dir, umode_t *mode)
> > +{
> > +	if (!dir || !(dir->i_mode & S_ISGID))
> > +		return;
> > +	if ((*mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> > +		return;
> > +	if (S_ISDIR(*mode))
> > +		return;
> 
> I'd place that check first as this whole function is really only
> relevant for non-directories.
> 
> Otherwise I can live with *mode being a pointer although I still find
> this unpleasant API wise but the bikeshed does it's job without having
> my color. :)

No, I think your instincts are correct.  This should be

umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
		const struct inode *dir, umode_t mode)
{
	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
		return mode;
	if (mode & (S_ISGID | S_IXGRP) != (S_ISGID | S_IXGRP))
		return mode;
...

and the same for prepare_mode().

And really, I think this should be called inode_strip_sgid().  Right?
