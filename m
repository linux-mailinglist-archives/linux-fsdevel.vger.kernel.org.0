Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6079D27FCFD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Oct 2020 12:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbgJAKMW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Oct 2020 06:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:41054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgJAKMW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:12:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2C18AC2F;
        Thu,  1 Oct 2020 10:12:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A657C1E12EF; Thu,  1 Oct 2020 12:12:19 +0200 (CEST)
Date:   Thu, 1 Oct 2020 12:12:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/3] fanotify: define bit map fields to hold response
 decision  context
Message-ID: <20201001101219.GE17860@quack2.suse.cz>
References: <2745105.e9J7NaK4W3@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2745105.e9J7NaK4W3@x2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-09-20 12:12:28, Steve Grubb wrote:
> This patch defines 2 bit maps within the response variable returned from
> user space on a permission event. The first field is 3 bits for the context
> type. The context type will describe what the meaning is of the second bit
> field. The default is none. The patch defines one additional context type
> which means that the second field is a rule number. This will allow for the
> creation of 6 other context types in the future if other users of the API
> identify different needs. The second field is 10 bits wide and can be used
> to pass along the data described by the context. Neither of these bit maps
> are directly adjacent and could be expanded if the need arises.
> 
> To support this, several macros were created to facilitate storing and
> retrieving the values. There is also a macro for user space to check that
> the data being sent is valid. Of course, without this check, anything that
> overflows the bit field will trigger an EINVAL based on the use of
> of INVALID_RESPONSE_MASK in process_access_response().
> 
> Signed-off-by: Steve Grubb <sgrubb@redhat.com>

So how likely do you find other context types are or that you'd need to
further expand the information passed from userspace? Because if there are
decent changes the expansion will be needed then I'd rather do something
like:

struct fanotify_response {
	__s32 fd;
	__u16 response;
	__u16 extra_info_type;
};

which is also backwards compatible and then userspace can set extra_info_type
and based on the type we'd know how much more bytes we need to copy from
buf to get additional information for that info type. 

This is much more flexible than what you propose and not that complex to
implement, you get type safety for extra information and don't need to use
macros to cram everything in u32 etc. Overall cleaner interface I'd say.

So in your case you'd then have something like:

#define FAN_RESPONSE_INFO_AUDIT_RULE 1

struct fanotify_response_audit_rule {
	__u32 rule;
};

								Honza

> ---
>  fs/notify/fanotify/fanotify.c      |  3 +--
>  fs/notify/fanotify/fanotify_user.c |  7 +------
>  include/linux/fanotify.h           |  5 +++++
>  include/uapi/linux/fanotify.h      | 31 ++++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 85eda539b35f..e72b7e59aa24 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -178,11 +178,10 @@ static int fanotify_get_response(struct fsnotify_group *group,
>  	}
>  
>  	/* userspace responded, convert to something usable */
> -	switch (event->response & ~FAN_AUDIT) {
> +	switch (FAN_DEC_MASK(event->response)) {
>  	case FAN_ALLOW:
>  		ret = 0;
>  		break;
> -	case FAN_DENY:
>  	default:
>  		ret = -EPERM;
>  	}
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index c8da9ea1e76e..3b8e515904fc 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -187,13 +187,8 @@ static int process_access_response(struct fsnotify_group *group,
>  	 * userspace can send a valid response or we will clean it up after the
>  	 * timeout
>  	 */
> -	switch (response & ~FAN_AUDIT) {
> -	case FAN_ALLOW:
> -	case FAN_DENY:
> -		break;
> -	default:
> +	if (FAN_INVALID_RESPONSE_MASK(response))
>  		return -EINVAL;
> -	}
>  
>  	if (fd < 0)
>  		return -EINVAL;
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index b79fa9bb7359..b3281d0e1b55 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -72,6 +72,11 @@
>  #define ALL_FANOTIFY_EVENT_BITS		(FANOTIFY_OUTGOING_EVENTS | \
>  					 FANOTIFY_EVENT_FLAGS)
>  
> +/* This mask is to check for invalid bits of a user space permission response */
> +#define FAN_INVALID_RESPONSE_MASK(x) ((x) & ~(FAN_ALLOW | FAN_DENY | \
> +					FAN_AUDIT | FAN_DEC_CONTEXT_TYPE | \
> +					FAN_DEC_CONTEXT))
> +
>  /* Do not use these old uapi constants internally */
>  #undef FAN_ALL_CLASS_BITS
>  #undef FAN_ALL_INIT_FLAGS
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index a88c7c6d0692..785d68ebcb58 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -152,6 +152,37 @@ struct fanotify_response {
>  #define FAN_DENY	0x02
>  #define FAN_AUDIT	0x10	/* Bit mask to create audit record for result */
>  
> +/*
> + * User space may need to record additional information about its decision.
> + * The context type records what kind of information is included. A bit mask
> + * defines the type of information included and then the context of the
> + * decision. The context type is 3 bits allowing for 8 kinds of context.
> + * The default is none. We also define 10 bits to allow up to 1024 kinds of
> + * context to be returned.
> + *
> + * If the context type is Rule, then the context following is the rule number
> + * that triggered the user space decision.
> + *
> + * There are helper macros defined so that it can be standardized across tools.
> + * A full example of how user space can use this looks like this:
> + *
> + * if (FAN_DEC_CONTEXT_VALUE_VALID(rule_number))
> + *	response.response = FAN_DENY | FAN_AUDIT | FAN_DEC_CONTEXT_TYPE_RULE |
> + *			    FAN_DEC_CONTEXT_VALUE(rule_number);
> + */
> +#define FAN_DEC_MASK(x) ((x) & (FAN_ALLOW|FAN_DENY))
> +#define FAN_DEC_CONTEXT_TYPE 0x70000000
> +#define FAN_DEC_CONTEXT      0x00FFC000
> +
> +#define FAN_DEC_CONTEXT_TYPE_VALUE(x)    (((x) & 0x07) << 28)
> +#define FAN_DEC_CONTEXT_TYPE_TO_VALUE(x) (((x) & FAN_DEC_CONTEXT_TYPE) >> 28)
> +#define FAN_DEC_CONTEXT_VALUE(x)         (((x) & 0x3FF) << 14)
> +#define FAN_DEC_CONTEXT_TO_VALUE(x)      (((x) & FAN_DEC_CONTEXT) >> 14)
> +#define FAN_DEC_CONTEXT_VALUE_VALID(x)   ((x) >= 0 && (x) < 1024)
> +
> +#define FAN_DEC_CONTEXT_TYPE_NONE  FAN_DEC_CONTEXT_TYPE_VALUE(0)
> +#define FAN_DEC_CONTEXT_TYPE_RULE  FAN_DEC_CONTEXT_TYPE_VALUE(1)
> +
>  /* No fd set in event */
>  #define FAN_NOFD	-1
>  
> -- 
> 2.26.2
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
