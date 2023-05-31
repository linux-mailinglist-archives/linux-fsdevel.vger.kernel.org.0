Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3BE71736D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 03:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjEaB56 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 21:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjEaB55 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 21:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688F137;
        Tue, 30 May 2023 18:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ACDB635F6;
        Wed, 31 May 2023 01:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62353C433EF;
        Wed, 31 May 2023 01:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685498270;
        bh=dzF+yG3jjN1BucIulDWBDlfSuDTCMG7xQb67qJZLTDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7wFwU95uWOzsqIW+g8zVCScS0tL5zf39iZGpoU2AVeC9UT/dId/D8o9L/yGjE+io
         l/d5qOXnmrwNcOCQPA4Qv58cKlzRWWiimerpmofl3kr3/8k/JqU/S1cGBCkVj4f19r
         l+3XrKO1aReEwqqcr5PGuXXU/O6k6PrzKQCATkTeAY5Ncu2/j/5orXrzZ4oSTh1xw2
         uesA7fhVAg+OgYVFxyEXjEXBcwpu7My3wc+r5NB48H4F6PACipyZXzXTHoxJeAZDq7
         9UUEtSYA5TsONp18ynEIL7K9lf7WwWGAYHDas00CejgwPzuwEXvjZm0ued+Zep68ao
         2pRomtWZ3FfwQ==
Date:   Tue, 30 May 2023 18:57:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Benjamin Segall <bsegall@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
Message-ID: <20230531015748.GB1648@quark.localdomain>
References: <xm26pm6hvfer.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26pm6hvfer.fsf@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 11:32:28AM -0700, Benjamin Segall wrote:
> autoremove_wake_function uses list_del_init_careful, so should epoll's
> more aggressive variant. It only doesn't because it was copied from an
> older wait.c rather than the most recent.
> 
> Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
> Signed-off-by: Ben Segall <bsegall@google.com>
> Cc: stable@vger.kernel.org
> ---
>  fs/eventpoll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 52954d4637b5..081df056398a 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1756,11 +1756,11 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
>  static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
>  				       unsigned int mode, int sync, void *key)
>  {
>  	int ret = default_wake_function(wq_entry, mode, sync, key);
>  
> -	list_del_init(&wq_entry->entry);
> +	list_del_init_careful(&wq_entry->entry);
>  	return ret;
>  }

Can you please provide a more detailed explanation about why
list_del_init_careful() is needed here?

- Eric
