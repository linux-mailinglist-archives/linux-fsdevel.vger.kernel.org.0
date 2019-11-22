Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C38107355
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfKVNhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:37:04 -0500
Received: from verein.lst.de ([213.95.11.211]:52044 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVNhE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:37:04 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5138F68C4E; Fri, 22 Nov 2019 14:37:01 +0100 (CET)
Date:   Fri, 22 Nov 2019 14:37:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        sandeen@sandeen.net
Subject: Re: [PATCH 1/5] fs: Enable bmap() function to properly return
 errors
Message-ID: <20191122133701.GA25822@lst.de>
References: <20191122085320.124560-1-cmaiolino@redhat.com> <20191122085320.124560-2-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122085320.124560-2-cmaiolino@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 22, 2019 at 09:53:16AM +0100, Carlos Maiolino wrote:
> By now, bmap() will either return the physical block number related to
> the requested file offset or 0 in case of error or the requested offset
> maps into a hole.
> This patch makes the needed changes to enable bmap() to proper return
> errors, using the return value as an error return, and now, a pointer
> must be passed to bmap() to be filled with the mapped physical block.
> 
> It will change the behavior of bmap() on return:
> 
> - negative value in case of error
> - zero on success or map fell into a hole
> 
> In case of a hole, the *block will be zero too
> 
> Since this is a prep patch, by now, the only error return is -EINVAL if
> ->bmap doesn't exist.
> 
> Changelog:
> 
> 	V6:
> 		- Fix bmap() doc function
> 			Reported-by: kbuild test robot <lkp@intel.com>
> 	V5:
> 		- Rebasing against 5.3 required changes to the f2fs
> 		  check_swap_activate() function
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---

The changelog goes under the --- if you really want a per-patch
changelog.  I personally find the per-patch changelog horribly
distracting and much prefer just one in the cover letter, though.

Otherwise this looks good, although we really need to kill these
users rather sooner than later..

Signed-off-by: Christoph Hellwig <hch@lst.de>
