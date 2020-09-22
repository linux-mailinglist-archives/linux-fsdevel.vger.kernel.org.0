Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28962742FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIVN04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:26:56 -0400
Received: from verein.lst.de ([213.95.11.211]:44653 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726605AbgIVN04 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:26:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5C23F67373; Tue, 22 Sep 2020 15:26:54 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:26:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        david@fromorbit.com, hch@lst.de, johannes.thumshirn@wdc.com,
        dsterba@suse.com, darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 15/15] iomap: Reinstate lockdep_assert_held in
 iomap_dio_rw()
Message-ID: <20200922132654.GG20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-16-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921144353.31319-16-rgoldwyn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:43:53AM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs holds inode_lock_shared() while performing DIO within EOF, so
> lockdep_assert_held() check can be re-instated.
> 
> Revert 3ad99bec6e82 ("iomap: remove lockdep_assert_held()")

It turns out gfs2 also calls without the lock, so while I'd love to see
the assert come back we'd regress gfs2.
