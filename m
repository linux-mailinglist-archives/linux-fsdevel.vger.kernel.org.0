Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089A1DEDBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfJUNhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 09:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728670AbfJUNhS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D0DCAEAF;
        Mon, 21 Oct 2019 13:37:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 097D31E4AA0; Mon, 21 Oct 2019 15:37:15 +0200 (CEST)
Date:   Mon, 21 Oct 2019 15:37:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 04/12] ext4: introduce new callback for IOMAP_REPORT
Message-ID: <20191021133715.GD25184@quack2.suse.cz>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f82e93ccc50014bf6c47318fd089a035d8032b28.1571647179.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 20:18:09, Matthew Bobrowski wrote:
> As part of the ext4_iomap_begin() cleanups that precede this patch,
> here we also split up the IOMAP_REPORT branch into a completely
> separate ->iomap_begin() callback named
> ext4_iomap_begin_report(). Again, the raionale for this change is to
> reduce the overall clutter that's starting to become apparent as we
> start to port more functionality over to the iomap infrastructure.
> 
> Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

One nit below.

> +	ext4_es_find_extent_range(inode, &ext4_es_is_delayed,
> +				  map->m_lblk, end, &es);
> +
> +	if (!es.es_len || es.es_lblk > end)
> +		return false;
> +
> +	if (es.es_lblk > map->m_lblk) {
> +		map->m_len = es.es_lblk - map->m_lblk;
> +		return false;
> +	}
> +
> +	if (es.es_lblk <= map->m_lblk)

This condition must be always true AFAICT.

> +		offset = map->m_lblk - es.es_lblk;
> +
> +	map->m_lblk = es.es_lblk + offset;
> +	map->m_len = es.es_len - offset;
> +
> +	return true;
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
