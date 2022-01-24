Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A4497E1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbiAXLiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 06:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbiAXLiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 06:38:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB5C06173B;
        Mon, 24 Jan 2022 03:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97E48B80AE3;
        Mon, 24 Jan 2022 11:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B80C340E9;
        Mon, 24 Jan 2022 11:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643024282;
        bh=1MZf/s1Gjno9sXlUpwND0z7JXF7AAJRWueQDZe7+Ol8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r427IhO03TztnS479ygJJ6WhkFqaUcbILkmKBs+4FdfzPBPF/ceZoLeevHJgaqaEj
         8JSGmyoKMbawO6JMv/k0ftS8SPr4lQHo6A3ijgZpnbSgk3WdMk/ltfHqq9Rs6D+KJ+
         8Lxp2vO6SUwFEyYE+D+OSRsOKlhRZ4Pi/Y4BqwAHdXktzZmdxVcPNhJyALIhzRYMrI
         s/Co6kwq5NmzdMv8OFbooqCwRbFdXhP3xcy/22wup6heCaWfUz3zpbgmXgsdxaTdly
         d/lC5mBex1pcgXl3aomIMNWs6+UNBl36D62hctx7/KdHZdK9I0mfGrecWHdHkWSlqk
         NinlQ1CyhOM3A==
Date:   Mon, 24 Jan 2022 12:37:58 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Pre-allocate superblock in sget_fc() if !test
Message-ID: <20220124113758.y34xceepk7oe26h7@wittgenstein>
References: <20220121185255.27601-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220121185255.27601-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:52:55PM -0500, Waiman Long wrote:
> When the test function is not defined in sget_fc(), we always need
> to allocate a new superblock. So there is no point in acquiring the
> sb_lock twice in this case. Optimize the !test case by pre-allocating
> the superblock first before acquring the lock.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/super.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a6405d44d4ca..c2bd5c34a826 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -520,6 +520,8 @@ struct super_block *sget_fc(struct fs_context *fc,
>  	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
>  	int err;
>  
> +	if (!test)
> +		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);

Shouldn't we treat this allocation failure as "fatal" right away and not
bother taking locks, walking lists and so on? Seems strange to treat it
as fatal below but not here.

(The code-flow in here has always been a bit challenging to follow imho.
So not super keen to see more special-cases in there. Curious: do you
see any noticeable performance impact from that lock being taken and
dropped for the !test case?)
