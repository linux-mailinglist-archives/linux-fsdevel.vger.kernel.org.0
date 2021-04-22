Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A826E367F8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhDVL0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 07:26:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:43232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236007AbhDVL0r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 07:26:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90D6DAE58;
        Thu, 22 Apr 2021 11:26:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 62EA91E37A2; Thu, 22 Apr 2021 13:26:12 +0200 (CEST)
Date:   Thu, 22 Apr 2021 13:26:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Hole punch races in GFS2
Message-ID: <20210422112612.GF26221@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I am looking into how GFS2 protects against races between hole punching and
things like page fault or readahead and AFAICT it seems it does not. In
particular is there anything that protects against a race like:

CPU1					CPU2
gfs2_fallocate()
  __gfs2_punch_hole()
    truncate_pagecache_range()
					gfs2_fault()
					  - faults in old data into page
					    cache
    punch_hole()

And now we have stale data in the page cache (data corruption). If
gfs2_page_mkwrite() sneaked in that window as well, we might be even racing
with writeback and are possibly corrupting the filesystem on disk. Is there
anything I'm missing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
