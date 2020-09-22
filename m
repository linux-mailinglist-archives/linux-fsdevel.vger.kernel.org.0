Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6197B2742CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVNTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 09:19:41 -0400
Received: from verein.lst.de ([213.95.11.211]:44564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIVNTl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:19:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DE23167373; Tue, 22 Sep 2020 15:19:39 +0200 (CEST)
Date:   Tue, 22 Sep 2020 15:19:39 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "dsterba@suse.com" <dsterba@suse.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/15] iomap: Allow filesystem to call
 iomap_dio_complete without i_rwsem
Message-ID: <20200922131939.GB20432@lst.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de> <20200921144353.31319-4-rgoldwyn@suse.de> <SN4PR0401MB359847A0A50291840C0C96649B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359847A0A50291840C0C96649B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:09:29PM +0000, Johannes Thumshirn wrote:
> On 21/09/2020 16:44, Goldwyn Rodrigues wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > This is to avoid the deadlock caused in btrfs because of O_DIRECT |
> > O_DSYNC.
> > 
> > Filesystems such as btrfs require i_rwsem while performing sync on a
> > file. iomap_dio_rw() is called under i_rw_sem. This leads to a
> > deadlock because of:
> > 
> > iomap_dio_complete()
> >   generic_write_sync()
> >     btrfs_sync_file()
> > 
> > Separate out iomap_dio_complete() from iomap_dio_rw(), so filesystems
> > can call iomap_dio_complete() after unlocking i_rwsem.
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> 
> This is missing Christoph's S-o-b

Goldwyn picked this up for a rfc.  But this looks like my patch with
a sane commit log, so:

Signed-off-by: Christoph Hellwig <hch@lst.de>
