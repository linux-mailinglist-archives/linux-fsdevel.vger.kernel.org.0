Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C4752363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 15:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbjGMNVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbjGMNUl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61830270A;
        Thu, 13 Jul 2023 06:20:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2C7461077;
        Thu, 13 Jul 2023 13:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA113C433C8;
        Thu, 13 Jul 2023 13:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689254431;
        bh=/HyMH976r1TkXdXXLMFe5egKFttnbGRT4cnSU1IDGSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IyX8o5M49S3zdzIxtruMjTRp3CoLKS1Rhzh8MHa3gYd3oaysfgiI9455gtBEoX6/h
         VbqM0gkLxd4eQvSWW7TISIVbalZNozQIlll8xozP/Mpus0rGu4PKXHlVyyOaDlD8Nm
         MLz+0GsLu/xdnFlvqHh5WF5qicq294o0Dn9/hQp3R3SN5d/FjQLuMIOEbYVwPvBGkV
         3pZL3qgJ3VM0f7sHcfQmUY8ueP8p88W4jCtOqXictAbtRiKpiIxS6sBpv5C7XYkSe3
         I03sippl4hiN2aJerdZ/8LQgvMnUA8TpzL9Fg6A61oDg35Njc6Ts11QAdJ1MBAVhhm
         G+bK9ll/f7X2A==
Date:   Thu, 13 Jul 2023 15:20:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        xu xin <cgel.zte@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@devkernel.io>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Janis Danisevskis <jdanis@google.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] procfs: block chmod on /proc/thread-self/comm
Message-ID: <20230713-shrimps-sachkenntnis-0343cc776cc2@brauner>
References: <20230713121907.9693-1-cyphar@cyphar.com>
 <e26a9bab-6443-4a0a-809a-ca1c1b4d28c3@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e26a9bab-6443-4a0a-809a-ca1c1b4d28c3@t-8ch.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:01:24PM +0200, Thomas Weißschuh wrote:
> On 2023-07-13 22:19:04+1000, Aleksa Sarai wrote:
> > Due to an oversight in commit 1b3044e39a89 ("procfs: fix pthread
> > cross-thread naming if !PR_DUMPABLE") in switching from REG to NOD,
> > chmod operations on /proc/thread-self/comm were no longer blocked as
> > they are on almost all other procfs files.
> > 
> > A very similar situation with /proc/self/environ was used to as a root
> > exploit a long time ago, but procfs has SB_I_NOEXEC so this is simply a
> > correctness issue.
> > 
> > Ref: https://lwn.net/Articles/191954/
> > Ref: 6d76fa58b050 ("Don't allow chmod() on the /proc/<pid>/ files")
> > Fixes: 1b3044e39a89 ("procfs: fix pthread cross-thread naming if !PR_DUMPABLE")
> > Cc: stable@vger.kernel.org # v4.7+
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  fs/proc/base.c                               | 3 ++-
> >  tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index 05452c3b9872..7394229816f3 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -3583,7 +3583,8 @@ static int proc_tid_comm_permission(struct mnt_idmap *idmap,
> >  }
> >  
> >  static const struct inode_operations proc_tid_comm_inode_operations = {
> > -		.permission = proc_tid_comm_permission,
> > +		.setattr	= proc_setattr,
> > +		.permission	= proc_tid_comm_permission,
> >  };
> 
> Given that this seems to be a recurring theme a more systematic
> aproach would help.
> 
> Something like the following (untested) patch:
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 05452c3b9872..b90f2e9cda66 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2649,6 +2649,7 @@ static struct dentry *proc_pident_instantiate(struct dentry *dentry,
>  		set_nlink(inode, 2);	/* Use getattr to fix if necessary */
>  	if (p->iop)
>  		inode->i_op = p->iop;
> +	WARN_ON(!inode->i_op->setattr);

Hm, no. This is hacky.

To fix this properly we will need to wean off notify_change() from
falling back to simple_setattr() when no i_op->setattr() method is
defined. To do that we will have to go through every filesystem and port
all that rely on this fallback to set simple_setattr() explicitly as
their i_op->setattr() method.

Christoph and I just discussed this in relation to another patch.

This is a bugfix so it should be as minimal as possible for easy
backport.
