Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDAE42EDB0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 11:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhJOJcl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 05:32:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59600 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbhJOJcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:32:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0CEAD1FD39;
        Fri, 15 Oct 2021 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634290225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vrVBy4iu/vWndrF2YkZJ1wiG86xLeYYCvLKhGTpz9Bs=;
        b=zaO2z9ubBrWTZ2y8aqN/UCaA9HuXQond6ok0lcnMBDYfmoYEFQE9y0iefqer5V+UyLS3x5
        otQ/FcvH+fbD5cap2sQvom3fErVS1BTGdcck4hrxvU0SQ3Rfm+qs6INmPe/QU9PiuyaagG
        qti21eImyj/sK8NYwp+Wv81S+5nM5BM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634290225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vrVBy4iu/vWndrF2YkZJ1wiG86xLeYYCvLKhGTpz9Bs=;
        b=u3JY8DOHrAnB7x3Tc8xfk37raw0s4VG7/iTkGNMxPBoMU8o0AfjO1upLt9ssl69qewIpz7
        wSzPV/Q0PxdR15CQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id EF107A3B81;
        Fri, 15 Oct 2021 09:30:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D50F31E0A40; Fri, 15 Oct 2021 11:30:24 +0200 (CEST)
Date:   Fri, 15 Oct 2021 11:30:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org, repnop@google.com, kernel@collabora.com
Subject: Re: [PATCH v7 12/28] fanotify: Support null inode event in
 fanotify_dfid_inode
Message-ID: <20211015093024.GF23102@quack2.suse.cz>
References: <20211014213646.1139469-1-krisman@collabora.com>
 <20211014213646.1139469-13-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014213646.1139469-13-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-10-21 18:36:30, Gabriel Krisman Bertazi wrote:
> FAN_FS_ERROR doesn't support DFID, but this function is still called for
> every event.  The problem is that it is not capable of handling null
> inodes, which now can happen in case of superblock error events.  For
> this case, just returning dir will be enough.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index c620b4f6fe12..397ee623ff1e 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -452,7 +452,7 @@ static struct inode *fanotify_dfid_inode(u32 event_mask, const void *data,
>  	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
>  		return dir;
>  
> -	if (S_ISDIR(inode->i_mode))
> +	if (inode && S_ISDIR(inode->i_mode))
>  		return inode;
>  
>  	return dir;
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
