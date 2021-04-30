Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07DB36FADD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 14:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbhD3Msp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 08:48:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44250 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhD3Msp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 08:48:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 19ED2AF0C;
        Fri, 30 Apr 2021 12:47:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D350A1E3029; Fri, 30 Apr 2021 14:47:56 +0200 (CEST)
Date:   Fri, 30 Apr 2021 14:47:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Junxiao Bi <junxiao.bi@oracle.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, ocfs2-devel@oss.oracle.com,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [Cluster-devel] [PATCH 1/3] fs/buffer.c: add new api to allow
 eof writeback
Message-ID: <20210430124756.GA5315@quack2.suse.cz>
References: <20210426220552.45413-1-junxiao.bi@oracle.com>
 <CAHc6FU62TpZTnAYd3DWFNWWPZP-6z+9JrS82t+YnU-EtFrnU0Q@mail.gmail.com>
 <3f06d108-1b58-6473-35fa-0d6978e219b8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f06d108-1b58-6473-35fa-0d6978e219b8@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 29-04-21 11:07:15, Junxiao Bi wrote:
> On 4/29/21 10:14 AM, Andreas Gruenbacher wrote:
> > On Tue, Apr 27, 2021 at 4:44 AM Junxiao Bi <junxiao.bi@oracle.com> wrote:
> > > When doing truncate/fallocate for some filesytem like ocfs2, it
> > > will zero some pages that are out of inode size and then later
> > > update the inode size, so it needs this api to writeback eof
> > > pages.
> > is this in reaction to Jan's "[PATCH 0/12 v4] fs: Hole punch vs page
> > cache filling races" patch set [*]? It doesn't look like the kind of
> > patch Christoph would be happy with.
> 
> Thank you for pointing the patch set. I think that is fixing a different
> issue.
> 
> The issue here is when extending file size with fallocate/truncate, if the
> original inode size
> 
> is in the middle of the last cluster block(1M), eof part will be zeroed with
> buffer write first,
> 
> and then new inode size is updated, so there is a window that dirty pages is
> out of inode size,
> 
> if writeback is kicked in, block_write_full_page will drop all those eof
> pages.

I agree that the buffers describing part of the cluster beyond i_size won't
be written. But page cache will remain zeroed out so that is fine. So you
only need to zero out the on disk contents. Since this is actually
physically contiguous range of blocks why don't you just use
sb_issue_zeroout() to zero out the tail of the cluster? It will be more
efficient than going through the page cache and you also won't have to
tweak block_write_full_page()...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
