Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF452599AA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348463AbiHSLNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHSLNe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:13:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5AF66128;
        Fri, 19 Aug 2022 04:13:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB31D2012A;
        Fri, 19 Aug 2022 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660907609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDiDqL4eZ1S6ynqk3mNLxZ6ZUEZmbiyxsoE9XpxMsmA=;
        b=pf6mw92r9UxMsHr+gbnPE/wonUtoKd4stGwfPKc/CAz90htMEef1ipxKM7aSzL/giTr7KW
        VPCocLRJD/BlU1GWaJztpYrSL+KdlgP6HWh8buSZQQ6OzEjvgnYzttQFeXEZzah462uGAY
        edK5rMNKCfo18sh0HXvPS+nhAaFV8Po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660907609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HDiDqL4eZ1S6ynqk3mNLxZ6ZUEZmbiyxsoE9XpxMsmA=;
        b=e2jfLCPD7kHQP7PsKpLuOJdFNZnKuKfJpcYCEA39438+liET3XSMKWJHE1ZRLSlpa61HDp
        ydwVYEOJcqATwOCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 761F62C141;
        Fri, 19 Aug 2022 11:13:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DF38AA0635; Fri, 19 Aug 2022 13:13:28 +0200 (CEST)
Date:   Fri, 19 Aug 2022 13:13:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
Message-ID: <20220819111328.2j6u53sfmxsj2nyt@quack3>
References: <cover.1659996830.git.rgb@redhat.com>
 <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Richard!

On Tue 09-08-22 13:22:53, Richard Guy Briggs wrote:
> This patch adds a flag, FAN_INFO and an extensible buffer to provide
> additional information about response decisions.  The buffer contains
> one or more headers defining the information type and the length of the
> following information.  The patch defines one additional information
> type, FAN_RESPONSE_INFO_AUDIT_RULE, an audit rule number.  This will
> allow for the creation of other information types in the future if other
> users of the API identify different needs.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  10 ++-
>  fs/notify/fanotify/fanotify.h      |   2 +
>  fs/notify/fanotify/fanotify_user.c | 104 +++++++++++++++++++++++------
>  include/linux/fanotify.h           |   5 ++
>  include/uapi/linux/fanotify.h      |  27 +++++++-
>  5 files changed, 123 insertions(+), 25 deletions(-)

Amir and Matthew covered most of the comments so let me add just a few I
have on top:

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index abfa3712c185..14c30e173632 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -428,6 +428,8 @@ struct fanotify_perm_event {
>  	u32 response;			/* userspace answer to the event */
>  	unsigned short state;		/* state of the event */
>  	int fd;		/* fd we passed to userspace for this event */
> +	size_t info_len;
> +	char *info_buf;
>  };

Rather than this, I'd expand struct fanotify_perm_event by adding:

	union info {
		struct fanotify_response_info_header hdr;
		struct fanotify_response_info_audit_rule audit_rule;
	}

at the end of the struct. Currently that is more memory efficient, easier
to code, and more CPU efficient as well. The 'hdr' member of the union can
be used to look at type of the info and then appropriate union member can
be used to get the data. If we ever grow additional info that has
non-trivial size, changing the code to use dynamically allocated buffer as
you do now is very easy. But until that moment it is just overengineering.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index ff67ca0d25cc..a4ae953f0e62 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -289,13 +289,18 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
>   */
>  static void finish_permission_event(struct fsnotify_group *group,
>  				    struct fanotify_perm_event *event,
> -				    u32 response)
> +				    struct fanotify_response *response,

Why do you pass struct fanotify_response here instead of plain u32? I don't
see you'd use it anywhere and it introduces some unnecessary churn in other
places.

> +				    size_t info_len, char *info_buf)
>  				    __releases(&group->notification_lock)
>  {
>  	bool destroy = false;
>  
>  	assert_spin_locked(&group->notification_lock);
> -	event->response = response;
> +	event->response = response->response & ~FAN_INFO;

Why do you mask out FAN_INFO here? I don't see a good reason for that.

> +	if (response->response & FAN_INFO) {
> +		event->info_len = info_len;
> +		event->info_buf = info_buf;
> +	}
>  	if (event->state == FAN_EVENT_CANCELED)
>  		destroy = true;
>  	else
...

> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index f1f89132d60e..4d08823a5698 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -180,15 +180,40 @@ struct fanotify_event_info_error {
>  	__u32 error_count;
>  };
>  
> +/*
> + * User space may need to record additional information about its decision.
> + * The extra information type records what kind of information is included.
> + * The default is none. We also define an extra information buffer whose
> + * size is determined by the extra information type.
> + *
> + * If the context type is Rule, then the context following is the rule number
> + * that triggered the user space decision.
> + */
> +
> +#define FAN_RESPONSE_INFO_NONE		0

Why do you define this? I don't see it being used anywhere (in a meaningful
way). You can as well make FAN_RESPONSE_INFO_AUDIT_RULE be type 0...

> +#define FAN_RESPONSE_INFO_AUDIT_RULE	1
> +
>  struct fanotify_response {
>  	__s32 fd;
>  	__u32 response;
>  };
>  
> +struct fanotify_response_info_header {
> +	__u8 type;
> +	__u8 pad;
> +	__u16 len;
> +};
> +
> +struct fanotify_response_info_audit_rule {
> +	struct fanotify_response_info_header hdr;
> +	__u32 audit_rule;
> +};
> +

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
