Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E253EA66B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbhHLOVP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 10:21:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbhHLOVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:21:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C581221FF;
        Thu, 12 Aug 2021 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628778048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EClbvh9H+h5jyqo9gR5SEvG/Auimr/66D2NFteFl1D8=;
        b=lV2elbtYUDc84fX/o5rXKWB/zott34AxpZXY6uRtGS+5sm4816iMxnMkJvpmtAvP/8xhlx
        HStjguATPwUnhtbaWej9MlkiYPdN6jZuhVWq2Tq/ngnl823VW0WoJoZrmF+VkdxdCPYaR8
        b3bk5IP9Hax9He7QiI8UaHyr52Rgt/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628778048;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EClbvh9H+h5jyqo9gR5SEvG/Auimr/66D2NFteFl1D8=;
        b=uAC8kh+39aQAVX9rctu7o6GTL2p468GQ2NLM65o535WUQyksmoVofTdIQafrFK9aaNAB9j
        xyLLAfzqlwxNrFBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id F10B2A3F5B;
        Thu, 12 Aug 2021 14:20:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B7F771F2BA7; Thu, 12 Aug 2021 16:20:47 +0200 (CEST)
Date:   Thu, 12 Aug 2021 16:20:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com, amir73il@gmail.com,
        djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v5 14/23] fanotify: Encode invalid file handler when no
 inode is provided
Message-ID: <20210812142047.GG14675@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-15-krisman@collabora.com>
 <20210805095618.GF14483@quack2.suse.cz>
 <87fsvf65zu.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsvf65zu.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-08-21 17:12:05, Gabriel Krisman Bertazi wrote:
> Jan Kara <jack@suse.cz> writes:
> >> @@ -376,14 +371,24 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
> >>  		fh->flags |= FANOTIFY_FH_FLAG_EXT_BUF;
> >>  	}
> >>  
> >> -	dwords = fh_len >> 2;
> >> -	type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> >> -	err = -EINVAL;
> >> -	if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >> -		goto out_err;
> >> -
> >> -	fh->type = type;
> >> -	fh->len = fh_len;
> >> +	if (inode) {
> >> +		dwords = fh_len >> 2;
> >> +		type = exportfs_encode_inode_fh(inode, buf, &dwords, NULL);
> >> +		err = -EINVAL;
> >> +		if (!type || type == FILEID_INVALID || fh_len != dwords << 2)
> >> +			goto out_err;
> >> +		fh->type = type;
> >> +		fh->len = fh_len;
> >> +	} else {
> >> +		/*
> >> +		 * Invalid FHs are used on FAN_FS_ERROR for errors not
> >> +		 * linked to any inode. Caller needs to guarantee the fh
> >> +		 * has at least FANOTIFY_NULL_FH_LEN bytes of space.
> >> +		 */
> >> +		fh->type = FILEID_INVALID;
> >> +		fh->len = FANOTIFY_NULL_FH_LEN;
> >> +		memset(buf, 0, FANOTIFY_NULL_FH_LEN);
> >> +	}
> >
> > Maybe it will become clearer later during the series but why do you set
> > fh->len to FANOTIFY_NULL_FH_LEN and not 0?
> 
> Jan,
> 
> That is how we encode a NULL file handle (i.e. superblock error).  Amir
> suggested it would be an invalid FILEID_INVALID, with a zeroed handle of
> size 8.  I will improve the comment on the next iteration.

Thanks for info. Then I have a question for Amir I guess :) Amir, what's
the advantage of zeroed handle of size 8 instead of just 0 length file
handle?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
