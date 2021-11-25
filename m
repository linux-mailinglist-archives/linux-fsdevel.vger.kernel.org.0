Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B82F45D729
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 10:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353993AbhKYJbV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 04:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346117AbhKYJ3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 04:29:20 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2919BC061761
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 01:23:10 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id de30so10855726qkb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Nov 2021 01:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6cQ2VBT6GEq5IzxtMFOrkAmdfUkzXXUJICym+jfQClw=;
        b=4mJ9AwSHB31PIpdJFgjtZiPI3O5U6l1D0qy0KW0UNf5MH6ozT0e6B86+3bb+ubsNsn
         bM94zULnP3/Sn5TW2sU/aVPK6VkQM9qy7472OA32+vcwka6MF4HPtv3JEMMLnnF7wmI8
         ICnVsm3JYbKZ1EmnKJc5Z6apqZ2RUZkPkq+9OUBvr5SxgxoGUUCPzzNRjS9cNIPRmf9W
         FkRzAaXZcf5J4VFjOvxT6jDJIPAkJGMRS0lNjaglMXitLBGhfTqTjyAGLSVTx96zOYvc
         geD85MYGed6A2vdWo2NGX8n2KXD9U2AGeoO0+MzV1KSKw8zpkUNflxlTE2C1KHr75DOI
         PH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6cQ2VBT6GEq5IzxtMFOrkAmdfUkzXXUJICym+jfQClw=;
        b=b2ZZIOPLjn6p+WozNZPFsIqnCf9jYqDKP82x34XzRfCWIjY5Cjz2yMG+iFQu7CGw+i
         KwgfFDRlBsW1fLYUMUbjdnnPhKIQRImY/UzMRg5x7F8IzS/yoq+BMcpfIhXYKnNE9cm1
         oPoCHYi2GhFHJgvTvQEiTk5ccVBihZsd9t++iacg2SnQxriUWyU77eFPHEGtxUblGfA5
         R8yHaD2K6pW0btec+Jal80Z/Uea86R/EiGbA1i2WxWja1NoeCRLtU1FDqOWbxs/bfEPg
         4B6DVCm9RCg7BsSiedGR129WlB6PWeSMZTfsoE8wua9buOyr422gTzL6nnjycr9UPHQV
         2Nzw==
X-Gm-Message-State: AOAM5333xNtp3ERC6lhxJFVqUfZQtdLhS9L/GR6NFL7PoURmfTQyjqlB
        iAJPXoBJeYiBp4FkkwagdEDNyA==
X-Google-Smtp-Source: ABdhPJwrHAepVsZs+KL0K+Dovd/v3IZvIaLP3c/YHUpcEAnEaPTq5AjU/2Qs0P+96c5OryJ5OBqRAA==
X-Received: by 2002:a05:620a:f8b:: with SMTP id b11mr13482119qkn.81.1637832189250;
        Thu, 25 Nov 2021 01:23:09 -0800 (PST)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id 16sm1314112qty.2.2021.11.25.01.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 01:23:08 -0800 (PST)
Date:   Thu, 25 Nov 2021 09:23:03 +0000
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
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
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 7/8] cdrom: simplify subdirectory registration with
 register_sysctl()
Message-ID: <YZ9V9yxGapfPF4+g@equinox>
References: <20211123202422.819032-1-mcgrof@kernel.org>
 <20211123202422.819032-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123202422.819032-8-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:24:21PM -0800, Luis Chamberlain wrote:
> There is no need to user boiler plate code to specify a set of base
> directories we're going to stuff sysctls under. Simplify this by using
> register_sysctl() and specifying the directory path directly.
> 
> // pycocci sysctl-subdir-register-sysctl-simplify.cocci PATH
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
>  drivers/cdrom/cdrom.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> index 9877e413fce3..1b57d4666e43 100644
> --- a/drivers/cdrom/cdrom.c
> +++ b/drivers/cdrom/cdrom.c
> @@ -3691,27 +3691,6 @@ static struct ctl_table cdrom_table[] = {
>  	},
>  	{ }
>  };
> -
> -static struct ctl_table cdrom_cdrom_table[] = {
> -	{
> -		.procname	= "cdrom",
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= cdrom_table,
> -	},
> -	{ }
> -};
> -
> -/* Make sure that /proc/sys/dev is there */
> -static struct ctl_table cdrom_root_table[] = {
> -	{
> -		.procname	= "dev",
> -		.maxlen		= 0,
> -		.mode		= 0555,
> -		.child		= cdrom_cdrom_table,
> -	},
> -	{ }
> -};
>  static struct ctl_table_header *cdrom_sysctl_header;
>  
>  static void cdrom_sysctl_register(void)
> @@ -3721,7 +3700,7 @@ static void cdrom_sysctl_register(void)
>  	if (!atomic_add_unless(&initialized, 1, 1))
>  		return;
>  
> -	cdrom_sysctl_header = register_sysctl_table(cdrom_root_table);
> +	cdrom_sysctl_header = register_sysctl("dev/cdrom", cdrom_table);
>  
>  	/* set the defaults */
>  	cdrom_sysctl_settings.autoclose = autoclose;
> -- 
> 2.33.0
> 

Dear Luis,

Thank you for the patch. Tested and working, looks good to me. As this
has already been pulled into Andrew Morton's tree, I have added in Jens
and the linux-block list so there is awareness that the patch will go
via -mm then linux-next tree.

For what it's worth (although guess it won't be in the commit now):
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
