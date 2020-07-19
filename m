Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1043B2252EF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 19:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgGSRFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 13:05:48 -0400
Received: from mail.hallyn.com ([178.63.66.53]:53560 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGSRFr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:05:47 -0400
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 612ACE93; Sun, 19 Jul 2020 12:05:45 -0500 (CDT)
Date:   Sun, 19 Jul 2020 12:05:45 -0500
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
Subject: Re: [PATCH v6 6/7] prctl: exe link permission error changed from
 -EINVAL to -EPERM
Message-ID: <20200719170545.GB3936@mail.hallyn.com>
References: <20200719100418.2112740-1-areber@redhat.com>
 <20200719100418.2112740-7-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719100418.2112740-7-areber@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:04:16PM +0200, Adrian Reber wrote:
> From: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> 
> This brings consistency with the rest of the prctl() syscall where
> -EPERM is returned when failing a capability check.
> 
> Signed-off-by: Nicolas Viennot <Nicolas.Viennot@twosigma.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>

Ok, i see how EINVAL snuck its way in there through validate_prctl_map()s
evolution :)

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  kernel/sys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a3f4ef0bbda3..ca11af9d815d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2015,7 +2015,7 @@ static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data
>  		 * This may have implications in the tomoyo subsystem.
>  		 */
>  		if (!checkpoint_restore_ns_capable(current_user_ns()))
> -			return -EINVAL;
> +			return -EPERM;
>  
>  		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
>  		if (error)
> -- 
> 2.26.2
