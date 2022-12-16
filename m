Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE564EF9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 17:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiLPQpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 11:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbiLPQoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:44:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD112E687;
        Fri, 16 Dec 2022 08:43:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B54D234588;
        Fri, 16 Dec 2022 16:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671209024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odwET7RAJt4TyX2c0eIiYppqthEh1UCsaW9+/jL2kns=;
        b=xWkCYvJJcIhuomKFa0qbKF1b6jKhBc1nCaqwf4rU8Qfy/aQkvwRuxlvgINu/W5XshFcpqs
        aVsg5AJWBVVLpyUdkZldHi2HJmGc03v4KoK/MT1VgPs12LKde+BPU3kcVpkybg+K7ZnbwP
        7aF9Z/wTytEZoYCIkEQHur57R16mLz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671209024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odwET7RAJt4TyX2c0eIiYppqthEh1UCsaW9+/jL2kns=;
        b=mhw6SA5W7W6VoFVGnzby+z7jJ3LSIG35U7TS/KxzU4sQbpJQocr/N2KgUgniszDZLULex2
        lzOiaOVGNrGgjPDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C3AD138FD;
        Fri, 16 Dec 2022 16:43:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mr41IkCgnGOILgAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 16:43:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 894A4A0762; Fri, 16 Dec 2022 17:43:42 +0100 (CET)
Date:   Fri, 16 Dec 2022 17:43:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20221216164342.ojcbdifdmafq5njw@quack3>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> This patch adds a flag, FAN_INFO and an extensible buffer to provide
> additional information about response decisions.  The buffer contains
> one or more headers defining the information type and the length of the
> following information.  The patch defines one additional information
> type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> allow for the creation of other information types in the future if other
> users of the API identify different needs.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Thanks for the patches. They look very good to me. Just two nits below. I
can do the small updates on commit if there would be no other changes. But
I'd like to get some review from audit guys for patch 3/3 before I commit
this.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index caa1211bac8c..cf3584351e00 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -283,19 +283,44 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
>  	return client_fd;
>  }
>  
> +static int process_access_response_info(int fd, const char __user *info, size_t info_len,
> +					struct fanotify_response_info_audit_rule *friar)

I prefer to keep lines within 80 columns, unless there is really good
reason (like with strings) to have them longer.

BTW, why do you call the info structure 'friar'? I feel some language twist
escapes me ;)

> +{
> +	if (fd == FAN_NOFD)
> +		return -ENOENT;

I would not test 'fd' in this function at all. After all it is not part of
the response info structure and you do check it in
process_access_response() anyway.

> +
> +	if (info_len != sizeof(*friar))
> +		return -EINVAL;
> +
> +	if (copy_from_user(friar, info, sizeof(*friar)))
> +		return -EFAULT;
> +
> +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> +		return -EINVAL;
> +	if (friar->hdr.pad != 0)
> +		return -EINVAL;
> +	if (friar->hdr.len != sizeof(*friar))
> +		return -EINVAL;
> +
> +	return info_len;
> +}
> +

...

> @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
>  		return -EINVAL;
>  	}
>  
> -	if (fd < 0)
> +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
>  		return -EINVAL;
>  
> -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> +	if (response & FAN_INFO) {
> +		ret = process_access_response_info(fd, info, info_len, &friar);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = 0;
> +	}
> +
> +	if (fd < 0)
>  		return -EINVAL;

And here I'd do:

	if (fd == FAN_NOFD)
		return 0;
	if (fd < 0)
		return -EINVAL;

As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
extra info is understood by the kernel so that application writing fanotify
responses has a way to check which information it can provide to the
kernel.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
