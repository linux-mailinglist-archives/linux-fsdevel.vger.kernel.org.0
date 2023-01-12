Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E980A668725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 23:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjALWnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 17:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240331AbjALWn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:43:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE715E0B1;
        Thu, 12 Jan 2023 14:43:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0B25B8202D;
        Thu, 12 Jan 2023 22:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFCCC433D2;
        Thu, 12 Jan 2023 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673563404;
        bh=M0PE5K49Lt9N6b6AGULprMk3DV6RqX9m6o0ZXhQ0nvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qwZW0yTZ8dmBYJ+BcnEza5N7KBNKVW74HvuCZfov7e5HU2MaQN+9zqXZfdYu5wivp
         yGkVG4UgXyMpfb0gFeiY9ZotrLMNhxUHgU3P133QRNeds7jMgdF+JlztBH6vRhieCj
         qUtBvF9USHTvC2fNm4orZt96e0WojrF9wiQeia/Y=
Date:   Thu, 12 Jan 2023 14:43:23 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chao Yu <chao@kernel.org>
Cc:     adobriyan@gmail.com, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: remove mark_inode_dirty() in proc_notify_change()
Message-Id: <20230112144323.2fa71c10876c0f5e0b5321a4@linux-foundation.org>
In-Reply-To: <20230112032720.1855235-1-chao@kernel.org>
References: <20230112032720.1855235-1-chao@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Jan 2023 11:27:20 +0800 Chao Yu <chao@kernel.org> wrote:

> proc_notify_change() has updated i_uid, i_gid and i_mode into proc
> dirent, we don't need to call mark_inode_dirty() for later writeback,
> remove it.
> 
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -127,7 +127,6 @@ static int proc_notify_change(struct user_namespace *mnt_userns,
>  		return error;
>  
>  	setattr_copy(&init_user_ns, inode, iattr);
> -	mark_inode_dirty(inode);
>  
>  	proc_set_user(de, inode->i_uid, inode->i_gid);
>  	de->mode = inode->i_mode;

procfs call mark_inode_dirty() in three places.

Does mark_inode_dirty() of a procfs file actually serve any purpose?
