Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA7D2DF070
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Dec 2020 17:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgLSQZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Dec 2020 11:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgLSQZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Dec 2020 11:25:02 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDAC0613CF;
        Sat, 19 Dec 2020 08:24:22 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id y15so3662510qtv.5;
        Sat, 19 Dec 2020 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Idw1858AaNcCEHT1+hYkeNUEED08Ky6S/MizwxAB2c=;
        b=IGJcsVY0daqFmjd3zPw0ss8DgAC8NgHzwgf9WnT+6pJYPGE65F/uHeKVw+anR+JGuK
         gtw2CPJreJrPGlh6WYUfSYv8hVwx1c/nV43JqtpLlZxHLq6nM2M9NYZWIfzZkI6XcrCi
         bEUsZxZhmhFW4sBF4ZWEPWj6aJTTGrGzngb5MvOK+086NPn8w7P5IcvXo0UBnj7WS8KV
         pQo2TmUqZIbGYNcNZxsQ4L2ruxzVQZzdA5eh2EaXzKkCIFOhmi3keOEILGit0JXHQN3+
         vJJfNRH9Y1YR45eP5Yf5snSqzAjNZSOYCNGJOcx+23fW+TvxrHlp0J7Ime2QeaAxgsBz
         H9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2Idw1858AaNcCEHT1+hYkeNUEED08Ky6S/MizwxAB2c=;
        b=Iw7ns6a5mAL1uqme9lxbFZMZAh/9Hr9vKTVMZCmL4/dlhjtnz6LYWN51MTIjQTwoQA
         lfkcdainLYp2T7gh+RBhKnSXoYBOGPf8GI9Y99fkh8b8z6qIi3cn+DGuYCrvY8lPQoqa
         6DxF1lhPagn+J8O+XD/bGgzO7okS65+dQRLcA0BTlEjz50y/VFta8ow38nLRDxHUJVYT
         cXz0Ug+GYY1mLOl78qrSJuX/smZDyHKSIaTFeeZgAY6m3vcEDbliL1yUC30hg7eaaM+/
         /xizGKz0S7h66OS+egZQ+xavzCzRK2ljlReG47gLbgL4p+cejj/lN2VFoHiN0ljZ8xU1
         itww==
X-Gm-Message-State: AOAM5311qia4al8yUpKzG1T91UmawAlzicQgp3EhXYe6sqFJsJLJoYPl
        schasrcCKcFLNCAatVP/QlA=
X-Google-Smtp-Source: ABdhPJz+suuSsTBU1YT+pWGS2urPFSp/SgvBWH6K4qQVbSrtoOg07nO+RQAubcPSH3JsnKepbC8twA==
X-Received: by 2002:ac8:7b2c:: with SMTP id l12mr9813723qtu.105.1608395061778;
        Sat, 19 Dec 2020 08:24:21 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id m8sm497156qkh.21.2020.12.19.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 08:24:20 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 19 Dec 2020 11:23:47 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Fox Chen <foxhlchen@gmail.com>, akpm@linux-foundation.org,
        dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <X94pE6IrziQCd4ra@mtj.duckdns.org>
References: <efb7469c7bad2f6458c9a537b8e3623e7c303c21.camel@themaw.net>
 <da4f730bbbb20c0920599ca5afc316e2c092b7d8.camel@themaw.net>
 <CAC2o3DJsvB6kj=S6D3q+_OBjgez9Q9B5s3-_gjUjaKmb2MkTHQ@mail.gmail.com>
 <c4002127c72c07a00e8ba0fae6b0ebf5ba8e08e7.camel@themaw.net>
 <a39b73a53778094279522f1665be01ce15fb21f4.camel@themaw.net>
 <c8a6c9adc3651e64cf694f580a8cb3d87d7cb893.camel@themaw.net>
 <X9t1xVTZ/ApIvPMg@mtj.duckdns.org>
 <67a3012a6a215001c8be9344aee1c99897ff8b7e.camel@themaw.net>
 <X9zDu15MvJP3NU8K@mtj.duckdns.org>
 <37c339831d4e7f3c6db88fbca80c6c2bd835dff2.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37c339831d4e7f3c6db88fbca80c6c2bd835dff2.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Sat, Dec 19, 2020 at 03:08:13PM +0800, Ian Kent wrote:
> And looking further I see there's a race that kernfs can't do anything
> about between kernfs_refresh_inode() and fs/inode.c:update_times().

Do kernfs files end up calling into that path tho? Doesn't look like it to
me but if so yeah we'd need to override the update_time for kernfs.

> +static int kernfs_iop_update_time(struct inode *inode, struct timespec64 *time, int flags)
>  {
> -	struct inode *inode = d_inode(path->dentry);
>  	struct kernfs_node *kn = inode->i_private;
> +	struct kernfs_iattrs *attrs;
>  
>  	mutex_lock(&kernfs_mutex);
> +	attrs = kernfs_iattrs(kn);
> +	if (!attrs) {
> +		mutex_unlock(&kernfs_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	/* Which kernfs node attributes should be updated from
> +	 * time?
> +	 */
> +
>  	kernfs_refresh_inode(kn, inode);
>  	mutex_unlock(&kernfs_mutex);

I don't see how this would reflect the changes from kernfs_setattr() into
the attached inode. This would actually make the attr updates obviously racy
- the userland visible attrs would be stale until the inode gets reclaimed
and then when it gets reinstantiated it'd show the latest information.

That said, if you wanna take the direction where attr updates are reflected
to the associated inode when the change occurs, which makes sense, the right
thing to do would be making kernfs_setattr() update the associated inode if
existent.

Thanks.

-- 
tejun
