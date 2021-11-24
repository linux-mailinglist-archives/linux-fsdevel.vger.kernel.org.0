Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F8445B7C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbhKXJwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 04:52:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60860 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhKXJwR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 04:52:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D12AA21961;
        Wed, 24 Nov 2021 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637747346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twMSLJi3dl6PV+ZvrQLD6fxiNCqI+8+IiOyNzLqomls=;
        b=AsSjhq5UWoJxHloKmYuZMvWa9oGBfue4hStjTj62gtxvDfOAPjPRfciIvzyhYYT/brTJj8
        ij8R2kAZIUFvqMD6QnOcHfmigo/jvWBIYGMwcHmpM2xFKF08a1tSD7at/XI9gi09iiD1G0
        fNjGCCcV8c01TxYpYRSJOBqjuIubvsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637747346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twMSLJi3dl6PV+ZvrQLD6fxiNCqI+8+IiOyNzLqomls=;
        b=zCpp+oSvqqEv+CCnvQnyAl+aiBQHmm2JBPCnsf3bwPtwcrPXovFbQnJN14LhTM2NOvpTLr
        3+hSl9JsXeV7JADw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B87A0A3B83;
        Wed, 24 Nov 2021 09:49:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A4FC61E14AC; Wed, 24 Nov 2021 10:49:06 +0100 (CET)
Date:   Wed, 24 Nov 2021 10:49:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        clemens@ladisch.de, arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@linux.ie, benh@kernel.crashing.org, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, jack@suse.cz,
        amir73il@gmail.com, phil@philpotter.co.uk, viro@zeniv.linux.org.uk,
        julia.lawall@inria.fr, ocfs2-devel@oss.oracle.com,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] ocfs2: simplify subdirectory registration with
 register_sysctl()
Message-ID: <20211124094906.GG8583@quack2.suse.cz>
References: <20211123202422.819032-1-mcgrof@kernel.org>
 <20211123202422.819032-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202422.819032-5-mcgrof@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 23-11-21 12:24:18, Luis Chamberlain wrote:
> There is no need to user boiler plate code to specify a set of base
> directories we're going to stuff sysctls under. Simplify this by using
> register_sysctl() and specifying the directory path directly.
> 
> // pycocci sysctl-subdir-register-sysctl-simplify.cocci PATH

Heh, nice example of using Coccinelle. The result looks good. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> 
> @c1@
> expression E1;
> identifier subdir, sysctls;
> @@
> 
> static struct ctl_table subdir[] = {
> 	{
> 		.procname = E1,
> 		.maxlen = 0,
> 		.mode = 0555,
> 		.child = sysctls,
> 	},
> 	{ }
> };
> 
> @c2@
> identifier c1.subdir;
> 
> expression E2;
> identifier base;
> @@
> 
> static struct ctl_table base[] = {
> 	{
> 		.procname = E2,
> 		.maxlen = 0,
> 		.mode = 0555,
> 		.child = subdir,
> 	},
> 	{ }
> };
> 
> @c3@
> identifier c2.base;
> identifier header;
> @@
> 
> header = register_sysctl_table(base);
> 
> @r1 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.subdir, c1.sysctls;
> @@
> 
> -static struct ctl_table subdir[] = {
> -	{
> -		.procname = E1,
> -		.maxlen = 0,
> -		.mode = 0555,
> -		.child = sysctls,
> -	},
> -	{ }
> -};
> 
> @r2 depends on c1 && c2 && c3@
> identifier c1.subdir;
> 
> expression c2.E2;
> identifier c2.base;
> @@
> -static struct ctl_table base[] = {
> -	{
> -		.procname = E2,
> -		.maxlen = 0,
> -		.mode = 0555,
> -		.child = subdir,
> -	},
> -	{ }
> -};
> 
> @initialize:python@
> @@
> 
> def make_my_fresh_expression(s1, s2):
>   return '"' + s1.strip('"') + "/" + s2.strip('"') + '"'
> 
> @r3 depends on c1 && c2 && c3@
> expression c1.E1;
> identifier c1.sysctls;
> expression c2.E2;
> identifier c2.base;
> identifier c3.header;
> fresh identifier E3 = script:python(E2, E1) { make_my_fresh_expression(E2, E1) };
> @@
> 
> header =
> -register_sysctl_table(base);
> +register_sysctl(E3, sysctls);
> 
> Generated-by: Coccinelle SmPL
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/ocfs2/stackglue.c | 25 +------------------------
>  1 file changed, 1 insertion(+), 24 deletions(-)
> 
> diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
> index 16f1bfc407f2..731558a6f27d 100644
> --- a/fs/ocfs2/stackglue.c
> +++ b/fs/ocfs2/stackglue.c
> @@ -672,31 +672,8 @@ static struct ctl_table ocfs2_mod_table[] = {
>  	{ }
>  };
>  
> -static struct ctl_table ocfs2_kern_table[] = {
> -	{
> -		.procname	= "ocfs2",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= ocfs2_mod_table
> -	},
> -	{ }
> -};
> -
> -static struct ctl_table ocfs2_root_table[] = {
> -	{
> -		.procname	= "fs",
> -		.data		= NULL,
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= ocfs2_kern_table
> -	},
> -	{ }
> -};
> -
>  static struct ctl_table_header *ocfs2_table_header;
>  
> -
>  /*
>   * Initialization
>   */
> @@ -705,7 +682,7 @@ static int __init ocfs2_stack_glue_init(void)
>  {
>  	strcpy(cluster_stack_name, OCFS2_STACK_PLUGIN_O2CB);
>  
> -	ocfs2_table_header = register_sysctl_table(ocfs2_root_table);
> +	ocfs2_table_header = register_sysctl("fs/ocfs2", ocfs2_mod_table);
>  	if (!ocfs2_table_header) {
>  		printk(KERN_ERR
>  		       "ocfs2 stack glue: unable to register sysctl\n");
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
