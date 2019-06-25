Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1339528C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2019 11:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfFYJ5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jun 2019 05:57:40 -0400
Received: from verein.lst.de ([213.95.11.211]:33296 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbfFYJ5k (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:57:40 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F14BB68B02; Tue, 25 Jun 2019 11:57:07 +0200 (CEST)
Date:   Tue, 25 Jun 2019 11:57:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, cluster-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
Message-ID: <20190625095707.GA1462@lst.de>
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de> <20190624182243.22447-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624182243.22447-1-agruenba@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 08:22:43PM +0200, Andreas Gruenbacher wrote:
> That would work, but I don't like how this leaves us with a vfs function
> that updates i_size without bothering to dirty the inode very much.

This isn't a VFS function, it is a helper library.

> 
> How about if we move the __generic_write_end call into the page_done
> callback and leave special handling to the filesystem code if needed
> instead?  The below patch seems to work for gfs2.

That seems way more complicated.  I'd much rather go with something
like may patch plus maybe a big fat comment explaining that persisting
the size update is the file systems job.  Note that a lot of the modern
file systems don't use the VFS inode tracking for that, besides XFS
that includes at least btrfs and ocfs2 as well.
