Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10992CD3C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 11:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388549AbgLCKgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 05:36:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgLCKgD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:36:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1C0EACEB;
        Thu,  3 Dec 2020 10:35:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 77AB11E12FF; Thu,  3 Dec 2020 11:35:22 +0100 (CET)
Date:   Thu, 3 Dec 2020 11:35:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 7/7] fsnotify: optimize merging of marks with no ignored
 masks
Message-ID: <20201203103522.GC11854@quack2.suse.cz>
References: <20201202120713.702387-1-amir73il@gmail.com>
 <20201202120713.702387-8-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202120713.702387-8-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-12-20 14:07:13, Amir Goldstein wrote:
> fsnotify() tries to merge marks on all object types (sb, mount, inode)
> even if the object's mask shows no interest in the specific event type.
> 
> This is done for the case that the object has marks with the event type
> in their ignored mask, but the common case is that an object does not
> have any marks with ignored mask.
> 
> Set a bit in object's fsnotify mask during fsnotify_recalc_mask() to
> indicate the existence of any marks with ignored masks.
> 
> Instead of merging marks of all object types, only merge marks from
> objects that either showed interest in the specific event type or have
> any marks with ignored mask.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

The idea looks sound to me and the patch fine (besides one bug noted
below). I'd be interested if an actual performance impact of this and
previous change could be noticed. Maybe some careful microbenchmark could
reveal it...

> +	/*
> +	 * Consider only marks that care about this type of event and marks with
> +	 * an ignored mask.
> +	 */
> +	test_mask |= FS_HAS_IGNORED_MASK;
> +	if (test_mask && sb->s_fsnotify_mask) {
		      ^^ Just '&' here.


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
