Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4135FA5699
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfIBMrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:47:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbfIBMrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:47:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lbUBQKgUDKPWb0RcIaYnoeNg0UvfzO7NgYVDACBffsE=; b=lhhhD47csSfZu68It2L5tINLt
        17W6y9t9pkSzoknsICEdFrT/qOji3pNE8RECrQchEr41cPbKf5RQsflQse9RyCxUlI47EBjKeEX4I
        l2rktPQdIPFQak1TMStJSEoIzfZ+tDtO/eReMV1lyPgF2bGtOJzeD+SHayMqBAQxSBw8UrsW7xEl9
        ZI6g2LEbKSjJlf5IC93Hz9DfowybXWR2pO9x5l7XYvXXmCME6Yumpg/MKMbu8lYYyAPOGlVTUM2lz
        4Z5LxY99DB7+b3p3WuQBr8DosrDjPliSvclmzL5OrrUwTpQNicLRU0GoZ5ze4PFIbg+uC4h16+9Eq
        LTBkhiI4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4lk9-0002Y1-1W; Mon, 02 Sep 2019 12:47:37 +0000
Date:   Mon, 2 Sep 2019 05:47:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 07/21] erofs: use erofs_inode naming
Message-ID: <20190902124737.GB8369@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-8-hsiangkao@aol.com>
 <20190902121021.GG15931@infradead.org>
 <20190902121306.GA2664@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902121306.GA2664@architecture4>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 02, 2019 at 08:13:06PM +0800, Gao Xiang wrote:
> Hi Christoph,
> 
> On Mon, Sep 02, 2019 at 05:10:21AM -0700, Christoph Hellwig wrote:
> > >  {
> > > -	struct erofs_vnode *vi = ptr;
> > > -
> > > -	inode_init_once(&vi->vfs_inode);
> > > +	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);
> > 
> > Why doesn't this use EROFS_I?  This looks a little odd.
> 
> Thanks for your reply and suggestion...
> EROFS_I seems the revert direction ---> inode to erofs_inode
> here we need "erofs_inode" to inode...
> 
> Am I missing something?.... Hope not....

No, you are not.  But the cast still looks odd.  Why not:

	struct erofs_inode *ei = ptr;

	inode_init_once(&ei->vfs_inode);
