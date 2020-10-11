Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4269F28A7C2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387963AbgJKOW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgJKOW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:22:58 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D63C0613CE;
        Sun, 11 Oct 2020 07:22:58 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id s66so13460206otb.2;
        Sun, 11 Oct 2020 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cygGmMKwe8ox8+ba1k/Dv7fr+XqllMIbIsz8Hntkd5E=;
        b=miZzENfpfIyXwxc6OW51smuOi4U1lomaRMltfa7/X76qVjOXEeimYZOOPQ9PObxdYf
         WEHQ4+poOU4TN1L/g9+12WGu/UuLDNgpPlzg1T8nFe6BgNlv/BfRniP+kZ9/GqkTk+q+
         /ER9hkLgEIfvimq03KeLc3Lsl1GRE5F+Ja+3k4UyHQaj0fXBEsz2D2Mf+ZrNndvLPwa6
         kZgE1LsJLKaWbq2bD0dwUi+o5KfIWEEiQye6NxUTOQMOFW6lZyU3S8a1xhJ8uUU/F6AQ
         fVtnzz4QDtB80I9Od3Cs1leiyLEyup9U8CllC68x4jvIpaxJ4QKpGDcOs2raLSnz/G3S
         6Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cygGmMKwe8ox8+ba1k/Dv7fr+XqllMIbIsz8Hntkd5E=;
        b=QeIdnI1FKBImgmLnhaPxoHS2b8guukSVkCNj6xTpi3BIE9Uu+8Efpmn0HwV1Qyteq5
         Sl09sj69idY2z0ZHCDGzXgFVkSyPy5PrC4ZN22DAHC4NVQ7fYhHJWxnwRwyuq1EBST/y
         6xlQ2ZS/mtNKvpwkwu+oeSkAEWRW5Ywgi1NoXTlKE/qvCZGa5dpq4jbm8ObSydfHGdAM
         9p4JKtXxu+64my5ZRg/R2ccN8RU9zvghzbIEk/Aa+YnoAfpA2G4Ue2BfBOnvecsLoIsI
         KwJqM5MByZR1lakN41aoTjD7Di/4BmqCvwr/QVGco/UyMoNJ4AqqIW0kllr+yQMnl1AA
         4lOA==
X-Gm-Message-State: AOAM533pQGK/psxqXENtEWr8Om9rSgdKgQDk2hdIBpPS9wjgq9cHUr9d
        gpi89k1SpMpeDAHpp0+Tn+pOOMStuRk=
X-Google-Smtp-Source: ABdhPJyrpJLRZxNsp0L3FGVnWjpbcA5Xj9Cvm9ADGsHHKlVYroMS/Gi1xSPH2OibKBzfjCzWWZbXhQ==
X-Received: by 2002:a9d:bee:: with SMTP id 101mr14806782oth.257.1602426177360;
        Sun, 11 Oct 2020 07:22:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w125sm8758418oiw.30.2020.10.11.07.22.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Oct 2020 07:22:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 11 Oct 2020 07:22:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 4/5] alpha: simplify osf_mount
Message-ID: <20201011142255.GA203430@roeck-us.net>
References: <20200917082236.2518236-1-hch@lst.de>
 <20200917082236.2518236-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917082236.2518236-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:22:35AM +0200, Christoph Hellwig wrote:
> Merge the mount_args structures and mount helpers to simplify the code a
> bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/kernel/osf_sys.c | 111 +++++++++---------------------------
>  1 file changed, 28 insertions(+), 83 deletions(-)
> 
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index d5367a1c6300c1..5fd155b13503b5 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -421,109 +421,54 @@ SYSCALL_DEFINE3(osf_fstatfs64, unsigned long, fd,
>   *
>   * Although to be frank, neither are the native Linux/i386 ones..
>   */
> -struct ufs_args {
> +struct osf_mount_args {
>  	char __user *devname;
>  	int flags;
>  	uid_t exroot;
> +	/* this has lots more here for cdfs at least, but we don't bother */
>  };
>  
> -struct cdfs_args {
> -	char __user *devname;
> -	int flags;
> -	uid_t exroot;
> -
> -	/* This has lots more here, which Linux handles with the option block
> -	   but I'm too lazy to do the translation into ASCII.  */
> -};
> -
> -struct procfs_args {
> -	char __user *devname;
> -	int flags;
> -	uid_t exroot;
> -};
> -
> -/*
> - * We can't actually handle ufs yet, so we translate UFS mounts to
> - * ext2fs mounts. I wouldn't mind a UFS filesystem, but the UFS
> - * layout is so braindead it's a major headache doing it.
> - *
> - * Just how long ago was it written? OTOH our UFS driver may be still
> - * unhappy with OSF UFS. [CHECKME]
> - */
> -static int
> -osf_ufs_mount(const char __user *dirname,
> -	      struct ufs_args __user *args, int flags)
> +SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
> +		int, flag, void __user *, data)
>  {
> -	int retval;
> -	struct cdfs_args tmp;
> +	struct osf_mount_args tmp;
>  	struct filename *devname;
> -
> -	retval = -EFAULT;
> -	if (copy_from_user(&tmp, args, sizeof(tmp)))
> -		goto out;
> -	devname = getname(tmp.devname);
> -	retval = PTR_ERR(devname);
> -	if (IS_ERR(devname))
> -		goto out;
> -	retval = do_mount(devname->name, dirname, "ext2", flags, NULL);
> -	putname(devname);
> - out:
> -	return retval;
> -}
> -
> -static int
> -osf_cdfs_mount(const char __user *dirname,
> -	       struct cdfs_args __user *args, int flags)
> -{
> +	const char *fstype;
>  	int retval;
> -	struct cdfs_args tmp;
> -	struct filename *devname;
> -
> -	retval = -EFAULT;
> -	if (copy_from_user(&tmp, args, sizeof(tmp)))
> -		goto out;
> -	devname = getname(tmp.devname);
> -	retval = PTR_ERR(devname);
> -	if (IS_ERR(devname))
> -		goto out;
> -	retval = do_mount(devname->name, dirname, "iso9660", flags, NULL);
> -	putname(devname);
> - out:
> -	return retval;
> -}
> -
> -static int
> -osf_procfs_mount(const char __user *dirname,
> -		 struct procfs_args __user *args, int flags)
> -{
> -	struct procfs_args tmp;
>  
>  	if (copy_from_user(&tmp, args, sizeof(tmp)))
>  		return -EFAULT;
>  
arch/alpha/kernel/osf_sys.c:440:27: error: 'args' undeclared (first use in this function)

> -	return do_mount("", dirname, "proc", flags, NULL);
> -}
> -
> -SYSCALL_DEFINE4(osf_mount, unsigned long, typenr, const char __user *, path,
> -		int, flag, void __user *, data)
> -{
> -	int retval;
> -
>  	switch (typenr) {
> -	case 1:
> -		retval = osf_ufs_mount(path, data, flag);
> +	case 1: /* ufs */
> +		/*
> +		 * We can't actually handle ufs yet, so we translate UFS mounts
> +		 * to ext2 mounts. I wouldn't mind a UFS filesystem, but the UFS
> +		 * layout is so braindead it's a major headache doing it.
> +		 *
> +		 * Just how long ago was it written? OTOH our UFS driver may be
> +		 * still unhappy with OSF UFS. [CHECKME]
> +		 */
> +		fstype = "ext2";
> +		devname = getname(tmp.devname);
>  		break;
> -	case 6:
> -		retval = osf_cdfs_mount(path, data, flag);
> +	case 6: /* cdfs */
> +		fstype = "iso9660";
> +		devname = getname(tmp.devname);
>  		break;
> -	case 9:
> -		retval = osf_procfs_mount(path, data, flag);
> +	case 9: /* procfs */
> +		fstype = "proc";
> +		devname = getname_kernel("");
>  		break;
>  	default:
> -		retval = -EINVAL;
>  		printk("osf_mount(%ld, %x)\n", typenr, flag);
> +		return -EINVAL;
>  	}
>  
> +	if (IS_ERR(devname))
> +		return PTR_ERR(devname);
> +	retval = do_mount(devname.name, dirname, fstype, flags, NULL);

arch/alpha/kernel/osf_sys.c:471:34: error:
	'dirname' undeclared (first use in this function); did you mean 'devname'?

> +	putname(devname);
>  	return retval;
>  }
>  
