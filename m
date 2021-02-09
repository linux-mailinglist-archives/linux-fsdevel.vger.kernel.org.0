Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895FF3145F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 02:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBIB6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 20:58:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:35330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhBIB6a (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:58:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 393C6AB71;
        Tue,  9 Feb 2021 01:57:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3145ADA7C8; Tue,  9 Feb 2021 02:55:56 +0100 (CET)
Date:   Tue, 9 Feb 2021 02:55:55 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>
Subject: Re: [PATCH v15.1 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
Message-ID: <20210209015555.GQ1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>
References: <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
 <20210205145836.gtty4r6a4ftolehj@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205145836.gtty4r6a4ftolehj@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 05, 2021 at 11:58:36PM +0900, Naohiro Aota wrote:
> Since the zoned filesystem requires sequential write out of metadata, we
> cannot proceed with a hole in tree-log pages. When such a hole exists,
> btree_write_cache_pages() will return -EAGAIN. This happens when someone,
> e.g., a concurrent transaction commit, writes a dirty extent in this
> tree-log commit.
> 
> If we are not going to wait for the extents, we can hope the concurrent
> writing fills the hole for us. So, we can ignore the error in this case and
> hope the next write will succeed.
> 
> If we want to wait for them and got the error, we cannot wait for them
> because it will cause a deadlock. So, let's bail out to a full commit in
> this case.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Inserted before the last patch, thanks.
