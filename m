Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D496688D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 02:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjAMBDy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 20:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237088AbjAMBDx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:03:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286875D437;
        Thu, 12 Jan 2023 17:03:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6006C621E9;
        Fri, 13 Jan 2023 01:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CD0C433D2;
        Fri, 13 Jan 2023 01:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673571830;
        bh=GvscdVhdioCnpNZOfyufMWuET+aoLnxbqmqCVUJ0Vzg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B9NGXL/xiB1Ow2yixMxCRFjhqpbk8gXeKGnfPH/HimISnQhMUPs1Sql5+9wd+5R2f
         7LS/MjcJErPodLBUz0yH+rOGs+FdlynnHVkd3ast5Upmjrq+Q8Nfqo1O6WWCGBEbR+
         hPPnRuS7aRhYE1/rrWzsvDe/pwqfnyt+Fg6eiAiUg87fjYZ36UX96cjsQv31/28HRP
         KWOdMXApEQyeIjQtZObNoTxeOV2tt3HQP7WJVZtX85/irQL67/PAxpm94yKIrp5bMB
         d9OwprVtDxUF+aXED26AoYPgsXL68DxUstNpH11scaSwRsZGzs3gApht6S2lJnbY7J
         ZgDyL53R19PTg==
Message-ID: <2060f8d47dd0fd1999733b87b1919f6642b6e9e1.camel@kernel.org>
Subject: Re: [PATCH rcu v2 09/20] fs: Remove CONFIG_SRCU
From:   Jeff Layton <jlayton@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>
Date:   Thu, 12 Jan 2023 20:03:48 -0500
In-Reply-To: <20230113001132.3375334-9-paulmck@kernel.org>
References: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
         <20230113001132.3375334-9-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-01-12 at 16:11 -0800, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in conditional compilation based on CONFIG_SRCU.
> Therefore, remove the #ifdef and throw away the #else clause.
>=20
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: <linux-fsdevel@vger.kernel.org>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---
>  fs/locks.c | 25 -------------------------
>  1 file changed, 25 deletions(-)
>=20
> diff --git a/fs/locks.c b/fs/locks.c
> index 8f01bee177159..1909a9de242c8 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -1889,7 +1889,6 @@ int generic_setlease(struct file *filp, long arg, s=
truct file_lock **flp,
>  }
>  EXPORT_SYMBOL(generic_setlease);
> =20
> -#if IS_ENABLED(CONFIG_SRCU)
>  /*
>   * Kernel subsystems can register to be notified on any attempt to set
>   * a new lease with the lease_notifier_chain. This is used by (e.g.) nfs=
d
> @@ -1923,30 +1922,6 @@ void lease_unregister_notifier(struct notifier_blo=
ck *nb)
>  }
>  EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> =20
> -#else /* !IS_ENABLED(CONFIG_SRCU) */
> -static inline void
> -lease_notifier_chain_init(void)
> -{
> -}
> -
> -static inline void
> -setlease_notifier(long arg, struct file_lock *lease)
> -{
> -}
> -
> -int lease_register_notifier(struct notifier_block *nb)
> -{
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(lease_register_notifier);
> -
> -void lease_unregister_notifier(struct notifier_block *nb)
> -{
> -}
> -EXPORT_SYMBOL_GPL(lease_unregister_notifier);
> -
> -#endif /* IS_ENABLED(CONFIG_SRCU) */
> -
>  /**
>   * vfs_setlease        -       sets a lease on an open file
>   * @filp:	file pointer

Reviewed-by: Jeff Layton <jlayton@kernel.org>
