Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7D52DE17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 22:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiESUJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 16:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241704AbiESUJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 16:09:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5651762AD
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 13:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652990964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2QLjS41iX7Cqc4n2R+Zu10cbTgIyeHJ/q9wUZvnh1+c=;
        b=WJh/U3qGTdE9MgwhPE0gfq+mWLsOaLTZKw27VUb+cZY4hHXljWa1IhO5SO2tqLxlo61Eg6
        glpt340egn1/jW4AYI2u6bycTh5Mz71UvUTKeivNjGoVNa0fNbxt8/iNOxCXj9SN1hp5yS
        Lfje4NPvsoGmYio2Ga1nOr+9ZDv3mIQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-cfWgeyxHM0SY_CAMqqRamg-1; Thu, 19 May 2022 16:09:19 -0400
X-MC-Unique: cfWgeyxHM0SY_CAMqqRamg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59EF0803B22;
        Thu, 19 May 2022 20:09:19 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36E3D400E114;
        Thu, 19 May 2022 20:09:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E92C22208FA; Thu, 19 May 2022 16:09:18 -0400 (EDT)
Date:   Thu, 19 May 2022 16:09:18 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
Message-ID: <Yoaj7jhLpp34K9+v@redhat.com>
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
> Hi Al,
> 
> Do you see anything bad with allowing ->atomic_open() to take a positive dentry
> and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
> 
> It looks wrong not to allow optimizing away the roundtrip associated with
> revalidation when we do allow optimizing away the roundtrip for the initial
> lookup in the same situation.
> 
> Thanks,
> Miklos
> 
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 509657fdf4f5..d35b5cbf7f64 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3267,7 +3267,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		dput(dentry);
>  		dentry = NULL;
>  	}
> -	if (dentry->d_inode) {
> +	if (dentry->d_inode && !d_atomic_open(dentry)) {
>  		/* Cached positive dentry: will open in f_op->open */
>  		return dentry;

Hi Miklos,

I see that lookup_open() calls d_revalidate() first. So basically
idea is that fuse ->.d_revalidate will skip LOOKUP needed to make sure
dentry is still valid (Only if atomic lookup+open is implemented) and
return 1 claiming dentry is valid.

And later in ->atomic_open(), it will either open the file or 
get an error and invalidate dentry. Hence will save one LOOKUP in
success case. Do I understand the intent right?

Thanks
Vivek

>  	}
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index f5bba51480b2..da681bdbc34e 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -208,6 +208,7 @@ struct dentry_operations {
>  #define DCACHE_NOKEY_NAME		0x02000000 /* Encrypted name encoded without key */
>  #define DCACHE_OP_REAL			0x04000000
>  
> +#define DCACHE_ATOMIC_OPEN		0x08000000 /* Always use ->atomic_open() to open this file */
>  #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
>  #define DCACHE_DENTRY_CURSOR		0x20000000
>  #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
> @@ -446,6 +447,11 @@ static inline bool d_is_positive(const struct dentry *dentry)
>  	return !d_is_negative(dentry);
>  }
>  
> +static inline bool d_atomic_open(const struct dentry *dentry)
> +{
> +	return dentry->d_flags & DCACHE_ATOMIC_OPEN;
> +}
> +
>  /**
>   * d_really_is_negative - Determine if a dentry is really negative (ignoring fallthroughs)
>   * @dentry: The dentry in question
> 

