Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC06816A6BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBXNCW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 08:02:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgBXNCV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:02:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16CBCAD79;
        Mon, 24 Feb 2020 13:02:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2FE441E0E33; Mon, 24 Feb 2020 14:02:19 +0100 (CET)
Date:   Mon, 24 Feb 2020 14:02:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: ext2, possible circular locking dependency detected
Message-ID: <20200224130219.GE27857@quack2.suse.cz>
References: <4946.1582339996@jrobl>
 <20200224090846.GB27857@quack2.suse.cz>
 <24689.1582538536@jrobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24689.1582538536@jrobl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 24-02-20 19:02:16, J. R. Okajima wrote:
> Jan Kara:
> > This is not the right way how memalloc_nofs_save() should be used (you
> > could just use GFP_NOFS instead of GFP_KERNEL instead of wrapping the
> > allocation inside memalloc_nofs_save/restore()). The
> > memalloc_nofs_save/restore() API is created so that you can change the
> > allocation context at the place which mandates the new context - i.e., in
> > this case when acquiring / dropping xattr_sem. That way you don't have to
> > propagate the context information down to function calls and the code is
> > also future-proof - if you add new allocation, they will use correct
> > allocation context.
> 
> Thanks for the lecture about memalloc_nofs_save/restore().
> Honestly speaking, I didn't know these APIs and I always use GFP_NOFS
> flag. Investigating this lockdep warning, I read the comments in gfp.h.
> 
>  * %GFP_NOFS will use direct reclaim but will not use any filesystem interfaces.
>  * Please try to avoid using this flag directly and instead use
>  * memalloc_nofs_{save,restore} to mark the whole scope which cannot/shouldn't
>  * recurse into the FS layer with a short explanation why. All allocation
>  * requests will inherit GFP_NOFS implicitly.
> 
> Actually grep-ping the whole kernel source tree told me there are
> several "one-liners" like ...nofs_save(); kmalloc(); ...nofs_restore
> sequence.  But re-reading the comments and your mail, I understand these
> APIs are for much wider region than such one-liner.
> 
> I don't think it a good idea that I send you another patch replaced by
> GFP_NOFS.  You can fix it simply and you know much more than me about
> this matter, and I will be satisfied when this problem is fixed by you.

OK, in the end I've decided to go with a different solution because I
realized the warning is a false positive one. The patch has passed a
fstests run but I'd be grateful if you could verify whether you can no longer
trigger the lockdep warning. Thanks!

								Honza

PS: I've posted the patch separately to the list.

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
