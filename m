Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C683B1C3FB5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 18:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEDQVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 12:21:18 -0400
Received: from verein.lst.de ([213.95.11.211]:58786 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgEDQVS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 12:21:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1E9F868BEB; Mon,  4 May 2020 18:21:15 +0200 (CEST)
Date:   Mon, 4 May 2020 18:21:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        Borislav Petkov <bp@alien8.de>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
Message-ID: <20200504162114.GA637@lst.de>
References: <20200425075706.721917-1-hch@lst.de> <20200425075706.721917-6-hch@lst.de> <6c47f731-7bff-f186-da55-7ce6cffacdc3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c47f731-7bff-f186-da55-7ce6cffacdc3@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 10:16:40AM -0600, Jens Axboe wrote:
> On 4/25/20 1:57 AM, Christoph Hellwig wrote:
> >  	if (HFSPLUS_SB(sb)->session >= 0) {
> > +		struct cdrom_tocentry te;
> > +
> > +		if (!cdi)
> > +			return -EINVAL;
> > +
> >  		te.cdte_track = HFSPLUS_SB(sb)->session;
> >  		te.cdte_format = CDROM_LBA;
> > -		res = ioctl_by_bdev(sb->s_bdev,
> > -			CDROMREADTOCENTRY, (unsigned long)&te);
> > -		if (!res && (te.cdte_ctrl & CDROM_DATA_TRACK) == 4) {
> > -			*start = (sector_t)te.cdte_addr.lba << 2;
> > -			return 0;
> > +		if (cdrom_read_tocentry(cdi, &te) ||
> > +		    (te.cdte_ctrl & CDROM_DATA_TRACK) != 4) {
> > +			pr_err("invalid session number or type of track\n");
> > +			return -EINVAL;
> >  		}
> 
> I must be missing something obvious from just looking over the patches,
> but how does this work if cdrom is modular and hfsplus is builtin?

In that case disk_to_cdi will return NULL as it uses IS_REACHABLE
and the file systems won't query the CD-ROM specific information.
