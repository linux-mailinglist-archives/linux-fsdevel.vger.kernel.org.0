Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6F2C11DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 18:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbgKWRXq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 12:23:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:38938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbgKWRXp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:23:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99173AEC3;
        Mon, 23 Nov 2020 17:23:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1FB76DA818; Mon, 23 Nov 2020 18:21:56 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:21:56 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v10 08/41] btrfs: disallow NODATACOW in ZONED mode
Message-ID: <20201123172155.GJ8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com, hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <a7debcd84dafac8b0d0f67da6b4e410ea346bffb.1605007036.git.naohiro.aota@wdc.com>
 <05414b36-2a3f-b2fb-a596-48cf8d59512b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05414b36-2a3f-b2fb-a596-48cf8d59512b@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:17:21PM +0800, Anand Jain wrote:
> On 10/11/20 7:26 pm, Naohiro Aota wrote:
> > +				    unsigned int flags)
> > +{
> > +	if (btrfs_is_zoned(fs_info) && (flags & FS_NOCOW_FL))
> 
> 
> > +		return -EPERM;
> 
> nit:
>   Should it be -EINVAL instead? I am not sure. May be David can fix 
> while integrating.

IIRC we've discussed that in some previous iteration. EPERM should be
interpreted as that it's not permitted right now, but otherwise it is a
valid operation/flag. The constraint is the zoned device.

As an example: deleting default subvolume is not permitted (EPERM), but
otherwise subvolume deletion is a valid operation.

So, EINVAL is for invalid combination of parameters or a request for
something that does not make sense at all.
