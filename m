Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E403E8F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbhHKLiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 07:38:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59482 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhHKLiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:38:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B7AD7221C8;
        Wed, 11 Aug 2021 11:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628681861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Qg256a2cRijtU4ToakVHy7eaZvLeHLKe/OB/WYR1yU=;
        b=XMvQLX/opMEmdc/KG3IyuO3vhruRZi3Kr3Xah6jKaqufWH+xv9YB+NUZ4hAV7gNUKTazaO
        J63bhc8LlT99kDlqYx0MRwIomTsAYf0LIh/819C873cGlNfWc94T+i0oVA+rB9DjtkwjEl
        uymgoEqp5r5u/78bpDbkFLfGcYJPqnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628681861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4Qg256a2cRijtU4ToakVHy7eaZvLeHLKe/OB/WYR1yU=;
        b=yzeRnc0Mxnij4E+0SJ46x4lrjkVK1W+6dFidWytbYflh6jI8M/Exh8RL5QI3OB1ncqDKkt
        pWb6kdxCKBLsREDA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 71E38A3C27;
        Wed, 11 Aug 2021 11:37:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DEDC1E6204; Wed, 11 Aug 2021 13:37:41 +0200 (CEST)
Date:   Wed, 11 Aug 2021 13:37:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fsnotify: count all objects with attached
 connectors
Message-ID: <20210811113741.GD14725@quack2.suse.cz>
References: <20210810151220.285179-1-amir73il@gmail.com>
 <20210810151220.285179-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810151220.285179-4-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 10-08-21 18:12:19, Amir Goldstein wrote:
> Rename s_fsnotify_inode_refs to s_fsnotify_connectors and count all
> objects with attached connectors, not only inodes with attached
> connectors.
> 
> This will be used to optimize fsnotify() calls on sb without any
> type of marks.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

... just a minor nit below ...

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 640574294216..d48d2018dfa4 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1507,8 +1507,8 @@ struct super_block {
>  	/* Number of inodes with nlink == 0 but still referenced */
>  	atomic_long_t s_remove_count;
>  
> -	/* Pending fsnotify inode refs */
> -	atomic_long_t s_fsnotify_inode_refs;
> +	/* Number of inode/mount/sb objects that are being watched */
> +	atomic_long_t s_fsnotify_connectors;

I've realized inode watches will be double-accounted because we increment
s_fsnotify_connectors both when attaching a connector and when grabbing
inode reference. It doesn't really matter and avoiding this would require
special treatment of inode connectors (we need to decrement
s_fsnotify_connectors only after dropping inode reference). So I'll just
reflect this in the comment here so that we don't forget.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
