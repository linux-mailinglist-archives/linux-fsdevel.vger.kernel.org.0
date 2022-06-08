Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C505543188
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbiFHNhA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiFHNg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:36:58 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299DF0734
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 06:36:56 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D8A627171; Wed,  8 Jun 2022 09:36:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D8A627171
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1654695415;
        bh=Fn6B0pmZwoPY22gWtvqSEoLpF/15yGM7F1ECHXtChTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAes4Gv8ktd3OvijJJXIcwaW7aeM19P2o3QLRgCftX6kxWtTYnHdI3VQfFEQ+nwEF
         JHVtbxCyglySj5BkRRlx88ctgl6czchx3AXAmfD/InveiV36V40I2V+1GtsenOMepw
         1C5EHH9mFs9M8jtnlPZ+Nd3r3g25A7dG5iUkxDKI=
Date:   Wed, 8 Jun 2022 09:36:55 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     viro@zeniv.linux.org.uk, jlayton@kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
Subject: Re: vfs_test_lock - should it WARN if F_UNLCK and modified file_lock?
Message-ID: <20220608133655.GA13884@fieldses.org>
References: <9559FAE9-4E4A-4161-995F-32D800EC0D5B@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9559FAE9-4E4A-4161-995F-32D800EC0D5B@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 09:19:25AM -0400, Benjamin Coddington wrote:
> NLM sometimes gets burnt by implementations of f_op->lock for F_GETLK
> modifying the lock structure (swapping out fl_owner) when the return is
> F_UNLCK.
> 
> Yes, NLM should be more defensive, but perhaps we should be checking for
> everyone, as per POSIX "If no lock is found that would prevent this lock
> from being created, then the structure shall be left unchanged
> except for
> the lock type which shall be set to F_UNLCK."

Doesn't seem like changing fl_owner affects fcntl_getlk results in this
case, so I don't think posix applies?  Though, OK, maybe it violates the
principle of least surprise for vfs_test_lock to behave differently.

> That would save others from the pain, as the offenders would
> hopefully take
> notice.
> 
> Something like:
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 32c948fe2944..4cc425008036 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2274,8 +2274,16 @@ SYSCALL_DEFINE2(flock, unsigned int, fd,
> unsigned int, cmd)
>   */
>  int vfs_test_lock(struct file *filp, struct file_lock *fl)
>  {
> -       if (filp->f_op->lock)
> -               return filp->f_op->lock(filp, F_GETLK, fl);
> +       int ret;
> +       fl_owner_t test_owner = fl->fl_owner;
> +
> +       if (filp->f_op->lock) {
> +               ret = filp->f_op->lock(filp, F_GETLK, fl);
> +               if (fl->fl_type == F_UNLCK)
> +                       WARN_ON(fl->fl_owner != test_owner);

WARN_ON_ONCE?

> +               return ret;
> +       }
> +
>         posix_test_lock(filp, fl);
>         return 0;
>  }
> 
> .. I'm worried that might be too big of a hammer though.  Any thoughts?

No strong opinions here.

--b.
