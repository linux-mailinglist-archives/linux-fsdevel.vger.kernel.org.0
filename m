Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4E53F58A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 07:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbiFGFbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 01:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbiFGFbL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 01:31:11 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01342AE25F;
        Mon,  6 Jun 2022 22:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EnkEOmhPrqh2D4k3tHU1H0RuvtUPK4K0jq5RGmjFiRM=; b=pRzDPsduT5NyGMnydxA8f55N1Z
        h43zYeCDXeJ4jbqeMxub++tJvQaYCnl9LXpVFkkPQJIHyNsNRG6n+i/jtLoDCEUl6vHwdQ/vLiftm
        flsxT6hH0wXg+KozawQ/WSFIxnZ8lG6CMh7u42i0uB1GK52LqAsdcqoXE2zQftjm+hQkR5yJl9E7n
        fIU/sIcEdDIGZTrXVWk3WJUbLs30lHdFzIkJvK+pXszZus+2y8aX5h6I70caMsBoBuFCvOPCFgMT+
        s7famyRFrsLq/BXR57ZG4dbGBOLjpR9/yL9PDqHNJLO80Le7559c+JiSTQS6moH8bu+mOY2Tlc4UX
        I1v+x5Hg==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyRo3-004age-8C; Tue, 07 Jun 2022 05:31:07 +0000
Date:   Tue, 7 Jun 2022 05:31:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oliver Ford <ojford@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs: inotify: Add full paths option to inotify
Message-ID: <Yp7im6e4gugY2pSA@zeniv-ca.linux.org.uk>
References: <20220606224241.25254-1-ojford@gmail.com>
 <20220606224241.25254-2-ojford@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606224241.25254-2-ojford@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 06, 2022 at 11:42:41PM +0100, Oliver Ford wrote:

> @@ -203,6 +204,8 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  {
>  	struct inotify_event inotify_event;
>  	struct inotify_event_info *event;
> +	struct path event_path;
> +	struct inotify_inode_mark *i_mark;
>  	size_t event_size = sizeof(struct inotify_event);
>  	size_t name_len;
>  	size_t pad_name_len;
> @@ -210,6 +213,18 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, fsn_event);
>  
>  	event = INOTIFY_E(fsn_event);
> +	/* ensure caller has access to view the full path */
> +	if (event->mask & IN_FULL_PATHS && event->mask & IN_MOVE_SELF &&
> +	    kern_path(event->name, 0, &event_path)) {
> +		i_mark = inotify_idr_find(group, event->wd);
> +		if (likely(i_mark)) {
> +			fsnotify_destroy_mark(&i_mark->fsn_mark, group);
> +			/* match ref taken by inotify_idr_find */
> +			fsnotify_put_mark(&i_mark->fsn_mark);
> +		}
> +		return -EACCES;
> +	}
> +

What.  The.  Hell?

Could you please explain how is it not a massive dentry and mount leak and
just what is being attempted here, anyway?

Incidentally, who said that pathname will be still resolving to whatever
it used to resolve to back when the operation had happened?  Or that
it would make any sense for the read(2) caller, while we are at it...

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>
