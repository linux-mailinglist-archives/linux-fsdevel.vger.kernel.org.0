Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774E3E53B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 08:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236716AbhHJGoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 02:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhHJGoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:44:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE8C0613D3
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Aug 2021 23:43:59 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id bo18so9642200pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Aug 2021 23:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dt9Z2kNoAjwNvhojQa8fzEPO+Lfu62+yOG35U73emvA=;
        b=EOBa7LhLykicmZRjCh80EaPfdWYNsv6HA6ivBseULBa7TPZ4vDLbuGfrEkyp92awoN
         vwb6b2HDZJKvI7vyHSRaNCy8fBZaaoKCbJzI4w3IkDTdMGV2y+kDZxzs8nK84l2ISG1M
         fDFPg4cpFM42kpxGGaIL+wO1TBuIrrk0XUD1uCIZvimyU0stnXkF284AwOpPyeiUlSn7
         c8EzP1g7Dnbn3teTFVLNe5tqEjFuZHfMPz0PiODZgTParevH6SHaz7n0Zh7Lh8OZbjbb
         l/RrGTO+oSTq9vEH4DUkGe7H//xGtvR5/rHWVz7vCvCu322GeWbQXENE9sYmYxlEcGr5
         GVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dt9Z2kNoAjwNvhojQa8fzEPO+Lfu62+yOG35U73emvA=;
        b=aqWygKa/b+dT5wX8Lhpy1f7VpqN5g4s7AFQBJC7iEZ9AGzpp6L3hpwQwoADvde/g7k
         rQB1NnCu8V/rXLDqL+P5akuaz4Jk4lJBrLkSfX6D656s3ARDDXXjhX09gNMD4dM5kZUn
         78vpbgrCyvw0lx4VkjQaKXattCVV4R8DyLITeTfc0GTB/ZQh/wOqzyHXq6egtph+A0IN
         eCdd4pCOb6QOUeawrwaJdCNZbWBsJjjsUjT04w50W7aTGXiKJYEUR0Ajb20shuBnrYES
         QdPh16XewFGFB3igZiIpyUXo7tXH4pT9SbgFtV4nkiPithC5SlO3y9x0PDIzoPWnO9E+
         9MSw==
X-Gm-Message-State: AOAM5329H8Ov367sF8J8eo/hW+6gOf1GJMn8t7Xo+W6IfdsrcgpuZyOn
        ht2LIvp4tQxdTe50zkG+gyIVnA==
X-Google-Smtp-Source: ABdhPJwI6LIr356jRNCvxsR+mbeop6rKgrLKbwwm8nKzD5FkqMIv+98dWOJpTK3XNdUlZdNMOBIqrA==
X-Received: by 2002:a62:1c84:0:b029:39a:87b9:91e with SMTP id c126-20020a621c840000b029039a87b9091emr21729806pfc.7.1628577839103;
        Mon, 09 Aug 2021 23:43:59 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:46f7:f8ea:5192:59e7])
        by smtp.gmail.com with ESMTPSA id i6sm22481052pfa.44.2021.08.09.23.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:43:58 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:43:47 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] fsnotify: optimize the case of no marks of any type
Message-ID: <YRIgI2HisRLS3ILA@google.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
 <20210803180344.2398374-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803180344.2398374-5-amir73il@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:03:44PM +0300, Amir Goldstein wrote:
> Add a simple check in the inline helpers to avoid calling fsnotify()
> and __fsnotify_parent() in case there are no marks of any type
> (inode/sb/mount) for an inode's sb, so there can be no objects
> of any type interested in the event.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

LGTM.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
>  include/linux/fsnotify.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index f8acddcf54fb..12d3a7d308ab 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -30,6 +30,9 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
>  				 struct inode *child,
>  				 const struct qstr *name, u32 cookie)
>  {
> +	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
> +		return;
> +
>  	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
>  }
>  
> @@ -41,6 +44,9 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
>  
>  static inline void fsnotify_inode(struct inode *inode, __u32 mask)
>  {
> +	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
> +		return;
> +
>  	if (S_ISDIR(inode->i_mode))
>  		mask |= FS_ISDIR;
>  
> @@ -53,6 +59,9 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
>  {
>  	struct inode *inode = d_inode(dentry);
>  
> +	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
> +		return 0;
> +
>  	if (S_ISDIR(inode->i_mode)) {
>  		mask |= FS_ISDIR;
>  
> -- 
> 2.25.1
> 
/M
