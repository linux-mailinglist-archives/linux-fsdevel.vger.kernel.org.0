Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B5950A478
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390238AbiDUPm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 11:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349678AbiDUPm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:42:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430632EDE
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 08:40:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9DCE921112;
        Thu, 21 Apr 2022 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650555605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZuNuiI2tqLawFsDAG7UJYCJbq6wx8NWybiQMFtSdqmA=;
        b=LJyDpegQw4SQQdlb2C202+1lcFuBC/qH/oXRGK2+XpBaskPb0c3gkZNV1aH9u4bTGrqQj7
        wGAgk1c1NUPj4hTTti1Sp7TyWRnfD9WmNkR+A3B95ByXVL1JPkQLmdE0d2psfFAz4KbiJ/
        9akE7qdYlaoC2w8YYARU9nVH7typvj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650555605;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZuNuiI2tqLawFsDAG7UJYCJbq6wx8NWybiQMFtSdqmA=;
        b=AZLniw3DmIUg4nNv/mSU47Uw8pOZWLEVeWTTzsG0tybgUEbFBF3mLEC2nK0rVPYRVpD9Bq
        j1elcGhyF0BxlpDg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8B57E2C14B;
        Thu, 21 Apr 2022 15:40:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 38C94A0620; Thu, 21 Apr 2022 17:40:05 +0200 (CEST)
Date:   Thu, 21 Apr 2022 17:40:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 14/16] fanotify: implement "evictable" inode marks
Message-ID: <20220421154005.vb6ms3o4fho2z7d6@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
 <20220413090935.3127107-15-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-15-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 12:09:33, Amir Goldstein wrote:
> When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
> pin the marked inode to inode cache, so when inode is evicted from cache
> due to memory pressure, the mark will be lost.
> 
> When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
> this flag, the marked inode is pinned to inode cache.
> 
> When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
> existing mark already has the inode pinned, the mark update fails with
> error EEXIST.
> 
> Evictable inode marks can be used to setup inode marks with ignored mask
> to suppress events from uninteresting files or directories in a lazy
> manner, upon receiving the first event, without having to iterate all
> the uninteresting files or directories before hand.
> 
> The evictbale inode mark feature allows performing this lazy marks setup
> without exhausting the system memory with pinned inodes.
> 
> This change does not enable the feature yet.
> 
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one nit below...

> @@ -1097,6 +1099,18 @@ static int fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
>  			*recalc = true;
>  	}
>  
> +	if (fsn_mark->connector->type != FSNOTIFY_OBJ_TYPE_INODE ||
> +	    want_iref == !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
> +		return 0;
> +
> +	/*
> +	 * NO_IREF may be removed from a mark, but not added.
> +	 * When removed, fsnotify_recalc_mask() will take the inode ref.
> +	 */
> +	WARN_ON_ONCE(!want_iref);
> +	fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
> +	*recalc = true;
> +
>  	return 0;
>  }

Since we always return 0 from this function, we may as well just drop the
'recalc' argument and return whether mask recalc is needed?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
