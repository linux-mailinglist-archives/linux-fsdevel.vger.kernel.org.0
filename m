Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4023E12A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 12:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240368AbhHEK3q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 06:29:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbhHEK3o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:29:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6B0251FE3A;
        Thu,  5 Aug 2021 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628159369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ivDOXrqu2/1QgRDyhP/6hQ5YOvoQ51/byB+L18GMyo=;
        b=oCPKk6PLnk9vnbSEhElOvy5xZ2vnePFPICLK5ZqCU9D56i3nTa7BsX+ov0glYaBHdk+O87
        qJYUFhUMEMkBj8ZtDaNAsx27jF54KWFRAboH9El75/SF0QEjVydFMrEP0QjI4DGbc0JkhX
        XHDRHeksrTZvdnHACBIgQBCP4T3QDqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628159369;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ivDOXrqu2/1QgRDyhP/6hQ5YOvoQ51/byB+L18GMyo=;
        b=avZFaloaTR4F3Jz7APZ5uPsBkAK3nCpVaYyJNbun0y0aX0ivVPAqxYIjcdBYkyc/Xt2/qo
        CQ9A9H2Ia6dHiyDw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 480F2A3BA5;
        Thu,  5 Aug 2021 10:29:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F5731E1511; Thu,  5 Aug 2021 12:29:29 +0200 (CEST)
Date:   Thu, 5 Aug 2021 12:29:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v5 15/23] fanotify: Require fid_mode for any non-fd event
Message-ID: <20210805102929.GH14483@quack2.suse.cz>
References: <20210804160612.3575505-1-krisman@collabora.com>
 <20210804160612.3575505-16-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804160612.3575505-16-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 04-08-21 12:06:04, Gabriel Krisman Bertazi wrote:
> Like inode events, FAN_FS_ERROR will require fid mode.  Therefore,
> convert the verification during fanotify_mark(2) to require fid for any
> non-fd event.  This means fid_mode will not only be required for inode
> events, but for any event that doesn't provide a descriptor.
> 
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good. One style nit below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

 
>  	/*
> -	 * Events with data type inode do not carry enough information to report
> -	 * event->fd, so we do not allow setting a mask for inode events unless
> -	 * group supports reporting fid.
> -	 * inode events are not supported on a mount mark, because they do not
> -	 * carry enough information (i.e. path) to be filtered by mount point.
> -	 */
> +	* Events that do not carry enough information to report
> +	* event->fd require a group that supports reporting fid.  Those
> +	* events are not supported on a mount mark, because they do not
> +	* carry enough information (i.e. path) to be filtered by mount
> +	* point.
> +	*/
        ^ I think these should be one column more to the right to align
with the opening /*.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
