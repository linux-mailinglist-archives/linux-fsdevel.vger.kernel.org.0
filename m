Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2863147859
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2020 06:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgAXFyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 00:54:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgAXFyA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 00:54:00 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5132071A;
        Fri, 24 Jan 2020 05:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579845239;
        bh=PD319ZtzsARpjQN1qMfKAV/AztFjbl+rqa9IicPM79c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+N98E0/dZZRYj9BMz9tUTtbHDoSnZvlNf8oRs8RP+l/FZb0ctHVNOVfdHtZWXdXR
         gG/Cx4DZH2U+0Sncv8BudMGmyMmULJOBTJyfeb3sMsM4RJltlvJVBGaMvyx7BE+ep+
         O9wEiILKvXBu44x4EbHiFVxgdBWRTe4dhjwAB/Gg=
Date:   Thu, 23 Jan 2020 21:53:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH] ext4: fix race conditions in ->d_compare() and ->d_hash()
Message-ID: <20200124055358.GD832@sol.localdomain>
References: <20200124041234.159740-1-ebiggers@kernel.org>
 <20200124050423.GA31271@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200124051601.GB832@sol.localdomain>
 <20200124052740.GB31271@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124052740.GB31271@hsiangkao-HP-ZHAN-66-Pro-G1>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 24, 2020 at 01:27:50PM +0800, Gao Xiang wrote:
> On Thu, Jan 23, 2020 at 09:16:01PM -0800, Eric Biggers wrote:
> > On Fri, Jan 24, 2020 at 01:04:25PM +0800, Gao Xiang wrote:
> > > > diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> > > > index 8964778aabefb..0129d14629881 100644
> > > > --- a/fs/ext4/dir.c
> > > > +++ b/fs/ext4/dir.c
> > > > @@ -671,9 +671,11 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
> > > >  			  const char *str, const struct qstr *name)
> > > >  {
> > > >  	struct qstr qstr = {.name = str, .len = len };
> > > > -	struct inode *inode = dentry->d_parent->d_inode;
> > > > +	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> > > 
> > > I'm not sure if we really need READ_ONCE d_parent here (p.s. d_parent
> > > won't be NULL anyway), and d_seq will guard all its validity. If I'm
> > > wrong, correct me kindly...
> > > 
> > > Otherwise, it looks good to me...
> > > Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
> > > 
> > 
> > While d_parent can't be set to NULL, it can still be changed concurrently.
> > So we need READ_ONCE() to ensure that a consistent value is used.
> 
> If I understand correctly, unlazy RCU->ref-walk will be guarded by
> seqlock, and for ref-walk we have d_lock (and even parent lock)
> in relative paths. So I prematurely think no race of renaming or
> unlinking evenually.
> 
> I'm curious about that if experts could correct me about this.
> 

Taking a seqlock for read doesn't prevent the protected data from changing.
It just allows the reader to detect that it changed.

So we still need to handle the dentry fields being changed concurrently here,
even if it will be detected by a read_seqcount_retry() later.

- Eric
