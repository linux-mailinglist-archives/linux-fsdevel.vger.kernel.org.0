Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6A656DF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfFZPnr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 11:43:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49636 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZPnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 11:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DVYqe3tpQ8e1sMTCWOSh9xLpYFRFLHE+hBBBu6gUiVY=; b=JiqZyiWjMhOWaBcr2IrbgLkM4
        0syeulFERs2blphfx8J9OQQYfDcD66MEDA/eYqMG3YlVaiNtVmnfwdsQ65mUOa5tobSAjIu4o0moB
        8ozOmeOpYAerFJ54x2vEzjiR8SfnDfyWG+bdR1ZUOZNrlL/SYacZFBNxtNQ7BkGu8CuE2RuIHDLu+
        CaRHYuI+HSdl81J/22Qtg+UiLTkGUTCTPoK9RgIw1FJLZsPC0ZS5UU4A0RQGMZLPHDKHcZxxfrX3Z
        j7RrqvM1qVcwEiIAm5WRBQmOct/BZjqliivvm1uRzpyKv/GzpK/wBw3vN8gt+E6H+zEEVMvM/k0vT
        MgqmUKwSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hgA4c-0000SB-CS; Wed, 26 Jun 2019 15:43:02 +0000
Date:   Wed, 26 Jun 2019 08:43:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, matthew.garrett@nebula.com,
        yuchao0@huawei.com, tytso@mit.edu, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, hch@infradead.org,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, cluster-devel@redhat.com,
        jfs-discussion@lists.sourceforge.net, linux-efi@vger.kernel.org,
        Jan Kara <jack@suse.cz>, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/5] vfs: create a generic checking function for
 FS_IOC_FSSETXATTR
Message-ID: <20190626154302.GA31445@infradead.org>
References: <156151632209.2283456.3592379873620132456.stgit@magnolia>
 <156151633829.2283456.834142172527987802.stgit@magnolia>
 <20190626041133.GB32272@ZenIV.linux.org.uk>
 <20190626153542.GE5171@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626153542.GE5171@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 26, 2019 at 08:35:42AM -0700, Darrick J. Wong wrote:
> > static inline void simple_fill_fsxattr(struct fsxattr *fa, unsigned xflags)
> > {
> > 	memset(fa, 0, sizeof(*fa));
> > 	fa->fsx_xflags = xflags;
> > }
> > 
> > and let the compiler optimize the crap out?
> 
> The v2 series used to do that, but Christoph complained that having a
> helper for a two-line memset and initialization was silly[1] so now we
> have this version.
> 
> I don't mind reinstating it as a static inline helper, but I'd like some
> input from any of the btrfs developers (or you, Al) about which form is
> preferred.

I complained having that helper in btrfs.  I think Al wants a generic
one, which at least makes a little more sense.

That being said I wonder if we should lift these attr ioctls to
file op methods and deal with all that crap in VFS code instead of
having all those duplicated ioctl parsers.
