Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8371A3EB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 05:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgDJDX7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 23:23:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56086 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbgDJDX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:23:58 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03A3Ni0m031164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 23:23:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 748E142013D; Thu,  9 Apr 2020 23:23:44 -0400 (EDT)
Date:   Thu, 9 Apr 2020 23:23:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Gioh Kim <gioh.kim@lge.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Message-ID: <20200410032344.GI45598@mit.edu>
References: <20200229001411.128010-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229001411.128010-1-guro@fb.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 04:14:11PM -0800, Roman Gushchin wrote:
> Since commit a8ac900b8163 ("ext4: use non-movable memory for the
> superblock") buffers for ext4 superblock were allocated using
> the sb_bread_unmovable() helper which allocated buffer heads
> out of non-movable memory blocks. It was necessarily to not block
> page migrations and do not cause cma allocation failures.
> 
> However commit 85c8f176a611 ("ext4: preload block group descriptors")
> broke this by introducing pre-reading of the ext4 superblock.
> The problem is that __breadahead() is using __getblk() underneath,
> which allocates buffer heads out of movable memory.
> 
> It resulted in page migration failures I've seen on a machine
> with an ext4 partition and a preallocated cma area.
> 
> Fix this by introducing sb_breadahead_unmovable() and
> __breadahead_gfp() helpers which use non-movable memory for buffer
> head allocations and use them for the ext4 superblock readahead.

Applied, thanks.  Apologies for not picking this up earlier.

	 	  	    	    	    - Ted
