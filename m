Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D344B3EDAE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhHPQ0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:26:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46490 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPQ0u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:26:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EAA1D1FF97;
        Mon, 16 Aug 2021 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629131177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZtW2eLH5Jc4BSlumnFX2rAGLAWiKCRNP7E7mnGiwas=;
        b=P2zBM7aVl9bt1cLchKdLrLR8BsistDtqUsKhKMaI+E4Cug1Dgmft6/i9wzJtvtIQZo0ZSs
        cCjQlP3qiUR8Ed1X6lZZRzAjoeLIvjdClWkzjhsRvMtazzTHDLc0xw4M92SkizeILa+i8h
        tWwQd0uM+2QrlK21PR+0bdjZmA0aHrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629131177;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AZtW2eLH5Jc4BSlumnFX2rAGLAWiKCRNP7E7mnGiwas=;
        b=A2oVdEY7DFwQYE/Tc8AoYVdDbdePd8JwwKD+YBbGzG5TcvZNs/ce2LhK3KYAzBHopk7QU6
        ZpQH+LA8r97/IkAA==
Received: from quack2.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id D3B58A3B8F;
        Mon, 16 Aug 2021 16:26:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 46EA01E0426; Mon, 16 Aug 2021 18:26:15 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:26:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     amir73il@gmail.com, jack@suse.com, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        khazhy@google.com, dhowells@redhat.com, david@fromorbit.com,
        tytso@mit.edu, djwong@kernel.org, repnop@google.com,
        kernel@collabora.com
Subject: Re: [PATCH v6 19/21] ext4: Send notifications on error
Message-ID: <20210816162615.GJ30215@quack2.suse.cz>
References: <20210812214010.3197279-1-krisman@collabora.com>
 <20210812214010.3197279-20-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812214010.3197279-20-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 12-08-21 17:40:08, Gabriel Krisman Bertazi wrote:
> Send a FS_ERROR message via fsnotify to a userspace monitoring tool
> whenever a ext4 error condition is triggered.  This follows the existing
> error conditions in ext4, so it is hooked to the ext4_error* functions.
> 
> It also follows the current dmesg reporting in the format.  The
> filesystem message is composed mostly by the string that would be
> otherwise printed in dmesg.
> 
> A new ext4 specific record format is exposed in the uapi, such that a
> monitoring tool knows what to expect when listening errors of an ext4
> filesystem.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/ext4/super.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

<snip>

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dfa09a277b56..b9ecd43678d7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -897,6 +904,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
>  		printk(KERN_CRIT "EXT4-fs error (device %s) in %s:%d: %s\n",
>  		       sb->s_id, function, line, errstr);
>  	}
> +	fsnotify_sb_error(sb, sb->s_root->d_inode, errno);
>  
>  	ext4_handle_error(sb, false, -errno, 0, 0, function, line);
>  }

Does it make sense to report root inode here? ext4_std_error() gets
generally used for filesystem-wide errors.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
