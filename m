Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666B12C6BBB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 19:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgK0Sti (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 13:49:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:58044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgK0Ssh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:48:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F36B2AC0C;
        Fri, 27 Nov 2020 18:48:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EC17ADA7D9; Fri, 27 Nov 2020 19:47:20 +0100 (CET)
Date:   Fri, 27 Nov 2020 19:47:20 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 06/41] btrfs: introduce max_zone_append_size
Message-ID: <20201127184720.GC6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <173cd5def63acdf094a3b83ce129696c26fd3a3c.1605007036.git.naohiro.aota@wdc.com>
 <a6c5cdf0-a880-9c92-cc3d-db0736185489@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c5cdf0-a880-9c92-cc3d-db0736185489@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 19, 2020 at 05:23:20PM +0800, Anand Jain wrote:
> On 10/11/20 7:26 pm, Naohiro Aota wrote:
> > The zone append write command has a maximum IO size restriction it
> > accepts. This is because a zone append write command cannot be split, as
> > we ask the device to place the data into a specific target zone and the
> > device responds with the actual written location of the data.
> > 
> > Introduce max_zone_append_size to zone_info and fs_info to track the
> > value, so we can limit all I/O to a zoned block device that we want to
> > write using the zone append command to the device's limits.
> > 
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> 
> Looks good except for - what happens when we replace or add a new zone
> device with a different queue_max_zone_append_sectors(queue) value. ?

The max zone seems to be a constraint for all devices so yeah it should
be recalculated.
