Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1000AF892E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 07:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfKLG4m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 01:56:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfKLG4l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 01:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WzJP5ecelfPrbPkpFdZW5saIiDsiXjsKrOz9Vo/Rvb0=; b=OlFvdt3wLOwmBUAZk2yEp4RNW
        I3bct+sprhJ6pz1IsQYpJkg8FZDpj28AVlIHBeoHgWxYKaFSrgigAQoslr65aDVp+bGS+jUUpPnf7
        +0pwKUa0rB4i+8tBxIRr2+gglGQoqUvEVP9aqoJWfBTbysXf8MBtKCC6mc2MUYiUd4rEEGlb8Vzmz
        zdH9ghLmseScW4y7uV88+9flHR3xHMMJVsvg7KfHo7sPjyA3sqXSYWk6cnu2qcGLjFry7PGzwYTVg
        a7zaeMrFGOsbUGeBh1bEH9eftnbXBBcs+swwnOa83egkEtbN0At9pMmDOANTZdwPKwNZyONoemVXo
        iR7q83i7A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUQ4x-0005RM-4z; Tue, 12 Nov 2019 06:55:07 +0000
Date:   Mon, 11 Nov 2019 22:55:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     ira.weiny@intel.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Dave Chinner <david@fromorbit.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/2] fs: Move swap_[de]activate to file_operations
Message-ID: <20191112065507.GA15915@infradead.org>
References: <20191112003452.4756-1-ira.weiny@intel.com>
 <20191112003452.4756-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112003452.4756-3-ira.weiny@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:34:52PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> swap_activate() and swap_deactivate() have nothing to do with
> address spaces.  We want to eventually make the address space operations
> dynamic to switch inode flags on the fly.  So to simplify this code as
> well as properly track these operations we move these functions to the
> file_operations vector.

What is the point?  If we switch aops for DAX vs not we might as well
switch file operations as well, as they pretty much are entirely
different.
