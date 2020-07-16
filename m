Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514AF221EF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGPIwD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:52:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPIwC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:52:02 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jvzcE-0002BZ-15; Thu, 16 Jul 2020 08:51:42 +0000
Date:   Thu, 16 Jul 2020 10:51:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] proc: allow access in init userns for map_files
 with CAP_CHECKPOINT_RESTORE
Message-ID: <20200716085141.nr4wyeh62ahjwupd@wittgenstein>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-5-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715144954.1387760-5-areber@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 04:49:52PM +0200, Adrian Reber wrote:
> Opening files in /proc/pid/map_files when the current user is
> CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
> checkpointing and restoring to recover files that are unreachable via
> the file system such as deleted files, or memfd files.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> ---
>  fs/proc/base.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 65893686d1f1..cada783f229e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -2194,16 +2194,16 @@ struct map_files_info {
>  };
>  
>  /*
> - * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
> - * symlinks may be used to bypass permissions on ancestor directories in the
> - * path to the file in question.
> + * Only allow CAP_SYS_ADMIN and CAP_CHECKPOINT_RESTORE to follow the links, due
> + * to concerns about how the symlinks may be used to bypass permissions on
> + * ancestor directories in the path to the file in question.
>   */
>  static const char *
>  proc_map_files_get_link(struct dentry *dentry,
>  			struct inode *inode,
>  		        struct delayed_call *done)
>  {
> -	if (!capable(CAP_SYS_ADMIN))
> +	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))

So right now, when I'd do

git grep checkpoint_restore_ns_capable

I'd not hit that codepath which isn't great. So I'd suggest to use:

if (!checkpoint_restore_ns_capable(&init_user_ns))

at the end of the day, capable(<cap>) just calls
ns_capable(&init_user_ns, <cap>) anyway.

Thanks!
Christian
