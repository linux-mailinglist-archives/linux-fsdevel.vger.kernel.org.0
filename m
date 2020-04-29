Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64451BD29B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgD2Cq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbgD2Cq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003EC03C1AC;
        Tue, 28 Apr 2020 19:46:56 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTckK-00DwIZ-FV; Wed, 29 Apr 2020 02:46:48 +0000
Date:   Wed, 29 Apr 2020 03:46:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        NeilBrown <neilb@suse.de>, "Rafael J . Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] epoll: Fix UAF dentry name access in wakeup source setup
Message-ID: <20200429024648.GA23230@ZenIV.linux.org.uk>
References: <20200429023104.131925-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429023104.131925-1-jannh@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:31:04AM +0200, Jann Horn wrote:

> I'm guessing this will go through akpm's tree?
> 
>  fs/eventpoll.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 8c596641a72b0..5052a41670479 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1450,7 +1450,7 @@ static int reverse_path_check(void)
>  
>  static int ep_create_wakeup_source(struct epitem *epi)
>  {
> -	const char *name;
> +	struct name_snapshot name;
>  	struct wakeup_source *ws;
>  
>  	if (!epi->ep->ws) {
> @@ -1459,8 +1459,9 @@ static int ep_create_wakeup_source(struct epitem *epi)
>  			return -ENOMEM;
>  	}
>  
> -	name = epi->ffd.file->f_path.dentry->d_name.name;
> -	ws = wakeup_source_register(NULL, name);
> +	take_dentry_name_snapshot(&name, epi->ffd.file->f_path.dentry);
> +	ws = wakeup_source_register(NULL, name.name.name);
> +	release_dentry_name_snapshot(&name);

I'm not sure I like it.  Sure, it won't get freed under you that way; it still
can go absolutely stale by the time you return from wakeup_source_register().
What is it being used for?
