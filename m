Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3F523371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 14:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbiEKMyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 08:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiEKMyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 08:54:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBE768308
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 05:54:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D60B421C89;
        Wed, 11 May 2022 12:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652273681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHvaNZ/OeKvwlBgTbZhGHPlUxU4Tfp6b8enR9S+hpFI=;
        b=pFoOkWrWSIymPl7RD7cyaPv87JFskZccC2rWgNwPY8Xj/ZJZ4EN1wiepffT6K3zKwoy2l3
        XG7p85zWNpR/n5TL1Lrbxy2HxDEfnufLQujv+G6+lmduZLgMR5NxawMyEkvAXAFU27mwUF
        PZdIH6uscfguEu2J9YFSfqCvJatl8CY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652273681;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JHvaNZ/OeKvwlBgTbZhGHPlUxU4Tfp6b8enR9S+hpFI=;
        b=AJB6oAfYqMwwnr1ugY63mKPVDT56b0rxBbpzZQvMCHzHEFNJZTSqYRxLp1HSeadftq4AUR
        YxeeE/MtXIv/ClAg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D851D2C141;
        Wed, 11 May 2022 12:54:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7BE7CA062A; Wed, 11 May 2022 14:54:40 +0200 (CEST)
Date:   Wed, 11 May 2022 14:54:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fsnotify: introduce mark type iterator
Message-ID: <20220511125440.5zsuzn7eemdvfksi@quack3.lan>
References: <20220511092914.731897-1-amir73il@gmail.com>
 <20220511092914.731897-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511092914.731897-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> of iteratating all marks of a specific group interested in an event
> by consulting the iterator report_mask.
> 
> Use an open coded version of that iterator in fsnotify_iter_next()
> that collects all marks of the current iteration group without
> consulting the iterator report_mask.
> 
> At the moment, the two iterator variants are the same, but this
> decoupling will allow us to exclude some of the group's marks from
> reporting the event, for example for event on child and inode marks
> on parent did not request to watch events on children.
> 
> Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> Reported-by: Jan Kara <jack@suse.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Mostly looks good. Two nits below.

>  /*
> - * Pop from iter_info multi head queue, the marks that were iterated in the
> + * Pop from iter_info multi head queue, the marks that belong to the group of
>   * current iteration step.
>   */
>  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
>  {
> +	struct fsnotify_mark *mark;
>  	int type;
>  
>  	fsnotify_foreach_iter_type(type) {
> -		if (fsnotify_iter_should_report_type(iter_info, type))
> +		mark = iter_info->marks[type];
> +		if (mark && mark->group == iter_info->current_group)
>  			iter_info->marks[type] =
>  				fsnotify_next_mark(iter_info->marks[type]);

Wouldn't it be more natural here to use the new helper
fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
types which were already reported...

> @@ -438,6 +438,9 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
>  
>  #define fsnotify_foreach_iter_type(type) \
>  	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
> +#define fsnotify_foreach_iter_mark_type(iter, mark, type) \
> +	for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++) \
> +		if (!(mark = fsnotify_iter_mark(iter, type))) {} else

Hum, you're really inventive here ;) I'd rather go for something a bit more
conservative and readable like:

static inline int fsnotify_iter_step(struct fsnotify_iter_info *iter, int type,
				     struct fsnotify_mark **markp)
{
	while (type < FSNOTIFY_ITER_TYPE_COUNT) {
		*markp = fsnotify_iter_mark(iter, type);
		if (*markp)
			break;
		type++;
	}
	return type;
}

#define fsnotify_foreach_iter_mark_type(iter, mark, type) \
	for (type = 0; \
	     (type = fsnotify_iter_step(iter, type, &mark)) < FSNOTIFY_ITER_TYPE_COUNT; \
	     type++)


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
