Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACA415465C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 15:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBFOka (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 09:40:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:52126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgBFOka (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:40:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 898B8ADAD;
        Thu,  6 Feb 2020 14:40:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 85E87DA952; Thu,  6 Feb 2020 15:40:15 +0100 (CET)
Date:   Thu, 6 Feb 2020 15:40:15 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm: Speedup page cache truncation
Message-ID: <20200206144015.GY2654@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200204142514.15826-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-1-jack@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:06PM +0100, Jan Kara wrote:
> Hello,
> 
> conversion of page cache to xarray (commit 69b6c1319b6 "mm: Convert truncate to
> XArray" in particular) has regressed performance of page cache truncation
> by about 10% (see my original report here [1]). This patch series aims at
> improving the truncation to get some of that regression back.
> 
> The first patch fixes a long standing bug with xas_for_each_marked() that I've
> uncovered when debugging my patches. The remaining patches then work towards
> the ability to stop clearing marks in xas_store() which improves truncation
> performance by about 6%.
> 
> The patches have passed radix_tree tests in tools/testing and also fstests runs
> for ext4 & xfs.

I've tested the patchset on btrfs too, no problems found.
