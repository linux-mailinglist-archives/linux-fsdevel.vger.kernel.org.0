Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3765233B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 15:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbiEKNJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiEKNJP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 09:09:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1770E6A048
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 06:09:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BD3701F8FD;
        Wed, 11 May 2022 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652274552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuKGyvdcSpbjF7bwqwdB/X/hBU2ECEs5tnmODzF0B8I=;
        b=gIFCcGxkEFRP1rWsVYvgvu22ZySKA2ELjESh9Jy0N0dhQwWQjASYbUKaLoztSZpxzAgK7x
        1d8Y8Bc+VBNW7l41My12kd66rz1Qz1DQe3+BCCHeU34HrwUYthseSeui7tJSsVl952tHqv
        HRiNpEElg2uJ7ZpdREkIefXfTE/23wE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652274552;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wuKGyvdcSpbjF7bwqwdB/X/hBU2ECEs5tnmODzF0B8I=;
        b=AN+QhKDnZtB8LBjUPYW6v66HCnXVK7Q67364nzwCvz4SuctjlySPqNHoIL5qN+mogrMdGO
        QJpJKYr9p5ncOHCA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A36052C141;
        Wed, 11 May 2022 13:09:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2666CA062A; Wed, 11 May 2022 15:09:12 +0200 (CEST)
Date:   Wed, 11 May 2022 15:09:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsnotify: consistent behavior for parent not
 watching children
Message-ID: <20220511130912.fohl7qakxaobepf7@quack3.lan>
References: <20220511092914.731897-1-amir73il@gmail.com>
 <20220511092914.731897-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511092914.731897-3-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 12:29:14, Amir Goldstein wrote:
> The logic for handling events on child in groups that have a mark on
> the parent inode, but without FS_EVENT_ON_CHILD flag in the mask is
> duplicated in several places and inconsistent.
> 
> Move the logic into the preparation of mark type iterator, so that the
> parent mark type will be excluded from all mark type iterations in that
> case.
> 
> This results in several subtle changes of behavior, hopefully all
> desired changes of behavior, for example:
> 
> - Group A has a mount mark with FS_MODIFY in mask
> - Group A has a mark with ignore mask that does not survive FS_MODIFY
>   and does not watch children on directory D.
> - Group B has a mark with FS_MODIFY in mask that does watch children
>   on directory D.
> - FS_MODIFY event on file D/foo should not clear the ignore mask of
>   group A, but before this change it does

Since FS_MODIFY of directory never happens I guess the ignore mask is never
cleared? Am I missing something?

> And if group A ignore mask was set to survive FS_MODIFY:
> - FS_MODIFY event on file D/foo should be reported to group A on account
>   of the mount mark, but before this change it is wrongly ignored
> 
> Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> Reported-by: Jan Kara <jack@suse.com>
> Link: https://lore.kernel.org/linux-fsdevel/20220314113337.j7slrb5srxukztje@quack3.lan/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Just one nit below.

> @@ -393,6 +386,23 @@ static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
>  	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
>  }
>  
> +static void fsnotify_iter_set_report_mark_type(
> +		struct fsnotify_iter_info *iter_info, int iter_type)
> +{
> +	struct fsnotify_mark *mark = iter_info->marks[iter_type];
> +
> +	/*
> +	 * FSNOTIFY_ITER_TYPE_PARENT indicates that this inode is watching
> +	 * children and interested in this event, which is an event
> +	 * possible on child. But is *this mark* watching children?
> +	 */
> +	if (iter_type == FSNOTIFY_ITER_TYPE_PARENT &&
> +	    !(mark->mask & FS_EVENT_ON_CHILD))
> +		return;
> +
> +	fsnotify_iter_set_report_type(iter_info, iter_type);
> +}
> +
>  /*
>   * iter_info is a multi head priority queue of marks.
>   * Pick a subset of marks from queue heads, all with the same group
> @@ -423,7 +433,7 @@ static bool fsnotify_iter_select_report_types(
>  	fsnotify_foreach_iter_type(type) {
>  		mark = iter_info->marks[type];
>  		if (mark && mark->group == iter_info->current_group)
> -			fsnotify_iter_set_report_type(iter_info, type);
> +			fsnotify_iter_set_report_mark_type(iter_info, type);
>  	}

I think it is confusing to hide another condition in
fsnotify_iter_set_report_mark_type() I'd rather have it explicitely here in
fsnotify_iter_select_report_types().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
