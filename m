Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E308D0F2F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 14:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfJIMvf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 08:51:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:52332 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729575AbfJIMvf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:51:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61D1AB15E;
        Wed,  9 Oct 2019 12:51:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 42CCB1E4851; Wed,  9 Oct 2019 14:51:32 +0200 (CEST)
Date:   Wed, 9 Oct 2019 14:51:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 5/8] ext4: move inode extension/truncate code out from
 ->iomap_end() callback
Message-ID: <20191009125132.GC5050@quack2.suse.cz>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <da556191f9dba2b477cce57665ded57bfd396463.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008112512.GH5078@quack2.suse.cz>
 <20191009101848.GG2125@poseidon.bobrowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009101848.GG2125@poseidon.bobrowski.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-10-19 21:18:50, Matthew Bobrowski wrote:
> > Just small nits below:
> > 
> > > +static int ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > > +				       ssize_t written, size_t count)
> > > +{
> > > +	int ret = 0;
> > 
> > I think both the function and callsites may be slightly simpler if you let
> > the function return 'written' or error (not 0 or error). But I'll leave
> > that decision upto you.
> 
> Hm, don't we actually need to return 0 for success cases so that
> iomap_dio_complete() behaves correctly i.e. increments iocb->ki_pos,
> etc?

Correct, iomap_dio_complete() expects 0 on success. So if we keep calling
ext4_handle_inode_extension() from ->end_io handler, we'd need some
specialcasing there and I agree that changing ext4_handle_inode_extension()
return convention isn't then very beneficial. If we stop calling
ext4_handle_inode_extension() from ->end_io handler (patch 8/8 discussion
pending), then the change would be a clear win.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
