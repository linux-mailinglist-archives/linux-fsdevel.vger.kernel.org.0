Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA21350A29B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389243AbiDUOh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiDUOh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:37:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D093ED05
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Apr 2022 07:34:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D435E1F748;
        Thu, 21 Apr 2022 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650551676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW9bTC29yJ2D9E2slsqT9T5TKVptxdRb5RXK4X3Xy64=;
        b=MLckJfPg8JBcmxKIn0+ZFJB+ANS56jPRM0rJyix84ORryM2iJPbSA16QrblU8KSQmnAe4H
        Ir4ru7EduglnLvjK4UNOJ2i6yhmbx+LavX3ld8Qd5RvL/GmKQM99AK74BvFYMlmRi+/ZKj
        3OtfHK6R7DqLliuhb9Gj/n1Zoai9pBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650551676;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aW9bTC29yJ2D9E2slsqT9T5TKVptxdRb5RXK4X3Xy64=;
        b=/haoQzvUFpY/U0GXmE0DilTDY/GWDGJmVWKgB/SgSDxSEQxOhHX7LaxLDNvRYy6HaeWguM
        a+MQeavdNvXc2/Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF5E92C146;
        Thu, 21 Apr 2022 14:34:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 73D02A0622; Thu, 21 Apr 2022 16:34:36 +0200 (CEST)
Date:   Thu, 21 Apr 2022 16:34:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 05/16] fsnotify: pass flags argument to
 fsnotify_alloc_group()
Message-ID: <20220421143436.24juxgyf3mu7f5mc@quack3.lan>
References: <20220413090935.3127107-1-amir73il@gmail.com>
 <20220413090935.3127107-6-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413090935.3127107-6-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 12:09:24, Amir Goldstein wrote:
> Add flags argument to fsnotify_alloc_group(), define and use the flag
> FSNOTIFY_GROUP_USER in inotify and fanotify instead of the helper
> fsnotify_alloc_user_group() to indicate user allocation.
> 
> Although the flag FSNOTIFY_GROUP_USER is currently not used after group
> allocation, we store the flags argument in the group struct for future
> use of other group flags.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good, just one nit:

> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 2ff686882303..2057ae4bf8e9 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -210,6 +210,11 @@ struct fsnotify_group {
>  	unsigned int priority;
>  	bool shutdown;		/* group is being shut down, don't queue more events */
>  
> +#define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
> +#define FSNOTIFY_GROUP_FLAG(group, flag) \

Is the FSNOTIFY_GROUP_FLAG() macro that useful? It isn't shorter than
"group->flags & FSNOTIFY_GROUP_xxx" and it only obfuscates things.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
