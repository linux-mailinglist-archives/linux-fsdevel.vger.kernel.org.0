Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F53C2252DE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgGSQu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 12:50:57 -0400
Received: from mail.hallyn.com ([178.63.66.53]:52818 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgGSQu5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:50:57 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id E91F9E93; Sun, 19 Jul 2020 11:50:54 -0500 (CDT)
Date:   Sun, 19 Jul 2020 11:50:54 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v6 4/7] proc: allow access in init userns for map_files
 with CAP_CHECKPOINT_RESTORE
Message-ID: <20200719165054.GA3936@mail.hallyn.com>
References: <20200719100418.2112740-1-areber@redhat.com>
 <20200719100418.2112740-5-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719100418.2112740-5-areber@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:04:14PM +0200, Adrian Reber wrote:
> Opening files in /proc/pid/map_files when the current user is
> CAP_CHECKPOINT_RESTORE capable in the root namespace is useful for
> checkpointing and restoring to recover files that are unreachable via
> the file system such as deleted files, or memfd files.
> 
> Signed-off-by: Adrian Reber <areber@redhat.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>  fs/proc/base.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 65893686d1f1..b824a8c89011 100644
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
> +	if (!checkpoint_restore_ns_capable(&init_user_ns))
>  		return ERR_PTR(-EPERM);
>  
>  	return proc_pid_get_link(dentry, inode, done);
> -- 
> 2.26.2
