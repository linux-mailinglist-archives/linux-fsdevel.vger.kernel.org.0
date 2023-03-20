Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0966C1135
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 12:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjCTLwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjCTLwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:52:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E922A29;
        Mon, 20 Mar 2023 04:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD7EB80E5E;
        Mon, 20 Mar 2023 11:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413C6C433EF;
        Mon, 20 Mar 2023 11:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679313118;
        bh=oeXEKxSqwYXZ2L7D1f98LwaQiOs5VHVF2FdoXmyu9lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eGSIQVBh0/azjZiFtVAmqwiROTkEGDv8ag2iFASAvnu7PuD6hA1l5BCzijpuM6Tcx
         TEN0dJ3IUpLkOOPgipnJbIK/1X2cViRoavLY6wRyziME7HNuqZvKx96BaY8s2DE2vh
         Wx9521umvTPPzEMtGzjEeiNIZUEdZYaqTZlrYD74DYNmIn7riwKSNTyCPFzAtiIfe0
         9atXWH0utLaK9mFCsibBsQATLnxPR++rXY3QbtId9Y3qjE59UUeFwRoIGWOHCSupHf
         qThC5k1uwLnQYzOv2pRotRIrw0CxnuM3T3Rk4iPNaRl/D7GSpt97S9sQ7wtQmRIEY1
         83YAH91wIXQXA==
Date:   Mon, 20 Mar 2023 12:51:53 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] do_open(): Fix O_DIRECTORY | O_CREAT behavior
Message-ID: <20230320115153.7n5cq4wl2hmcbndf@wittgenstein>
References: <20230320071442.172228-1-pedro.falcato@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230320071442.172228-1-pedro.falcato@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 20, 2023 at 07:14:42AM +0000, Pedro Falcato wrote:
> On Linux, open(O_DIRECTORY | O_CREAT) has historically meant "open
> directory or create a regular file". This has remained mostly true,
> except open(O_DIR | O_CREAT) has started returning an error *while
> creating the file*. Restore the old behavior.
> 
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
> I did not explicitly add a Fixes: tag because I was unable to bisect this locally,

This dates back to the lookup rework done for v5.7. Specifically, this
was introduced by:

Fixes: 973d4b73fbaf ("do_last(): rejoin the common path even earlier in FMODE_{OPENED,CREATED} case")

> but it seems to me that this was introduced in the path walking refactoring done in early 2020.
> Al, if you have a rough idea of what may have added this bug, feel free to add a Fixes.
> 
> This should also probably get CC'd to stable, but I'll leave this to your criteria.
>  fs/namei.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index edfedfbccae..7b26db2f0f8 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3540,8 +3540,18 @@ static int do_open(struct nameidata *nd,
>  		if (unlikely(error))
>  			return error;
>  	}
> -	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> -		return -ENOTDIR;
> +
> +	if ((open_flag & (O_DIRECTORY | O_CREAT)) != (O_DIRECTORY | O_CREAT) ||
> +	    !(file->f_mode & FMODE_CREATED)) {
> +		/* O_DIRECTORY | O_CREAT has the strange property of being the
> +		 * only open(O_DIRECTORY) lookup that can create and return a
> +		 * regular file *if we indeed did create*. Because of this,
> +		 * only return -ENOTDIR if we're not O_DIR | O_CREAT or if we
> +		 * did not create a file.
> +		 */

So before we continue down that road should we maybe treat this as a
chance to fix the old bug? Because this behavior of returning -ENOTDIR
has existed ever since v5.7 now. Since that time we had three LTS
releases all returning ENOTDIR even if the file was created.

So yeah, we could return to the old behavior. But we could also see this
as a chance to get rid of the bug. IOW, fail right at O_DIRECTORY | O_CREAT
with ENOTDIR and not even create the file anymore. No one has really
noticed this from 5.7 until now and afaict this has been a bug ever
since the dark ages and is mentioned as a bug on man 2 openat.
