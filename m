Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4865F6341
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbiJFJFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 05:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJFJFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547C148EB7;
        Thu,  6 Oct 2022 02:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1CE7B8205A;
        Thu,  6 Oct 2022 09:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB455C433D6;
        Thu,  6 Oct 2022 09:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665047115;
        bh=3jGXsNPSS4O1TEpS68FiH8Y48vDWXXQybQJHFsdIyaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHAgPTyna9bAa5+1gY1y6nPN3rE3uxDZIDS9lvu9KCJX+0UHxssIa95r+hCe0rgsb
         uCg+oilhWGlEg0HRKfKcRYYzLuUnuRoklCSpB8zkg9W/7UlpdKLCkpo9dB5iNQSAHt
         q4zZUXAk4CMUMsIn5JKS8i1RMQw7xnCcemwF24WdQNAybg2yzc/SrmqjhygWlrdeA0
         gEPZqRhnne1FkqYY5PcU/5ah2xFo86ptFevX/EHKDgV8bAHgI3nJpZJW5DsbTo8fuy
         8EPEbJam5U0csRzGMkDqlDA/DadY0A1WEqA16RoGFhSfaMcdf/hMuC3asH4eoy7tTs
         5b0y4Sw0n/IGA==
Date:   Thu, 6 Oct 2022 11:05:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Message-ID: <20221006090506.paqjf537cox7lqrq@wittgenstein>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006082735.1321612-2-keescook@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 01:27:34AM -0700, Kees Cook wrote:
> The check_unsafe_exec() counting of n_fs would not add up under a heavily
> threaded process trying to perform a suid exec, causing the suid portion
> to fail. This counting error appears to be unneeded, but to catch any
> possible conditions, explicitly unshare fs_struct on exec, if it ends up

Isn't this a potential uapi break? Afaict, before this change a call to
clone{3}(CLONE_FS) followed by an exec in the child would have the
parent and child share fs information. So if the child e.g., changes the
working directory post exec it would also affect the parent. But after
this change here this would no longer be true. So a child changing a
workding directoro would not affect the parent anymore. IOW, an exec is
accompanied by an unshare(CLONE_FS). Might still be worth trying ofc but
it seems like a non-trivial uapi change but there might be few users
that do clone{3}(CLONE_FS) followed by an exec.

> +/*
> + * Unshare the filesystem structure if it is being shared
> + */
> +int unshare_fs(void)
> +{
> +	struct fs_struct *new_fs = NULL;
> +	int error;
> +
> +	error = unshare_fs_alloc(CLONE_FS, &new_fs);
> +	if (error || !new_fs)
> +		return error;

You should just check for error here, not new_fs.
