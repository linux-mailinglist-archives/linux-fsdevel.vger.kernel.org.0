Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE434668E5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbhLBRPo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 12:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348055AbhLBRPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:15:43 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8B6C06174A
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Dec 2021 09:12:20 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso608369otf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Dec 2021 09:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qJBV9vGvoPciWav+3b9AzlUhVYyyPz27rcokUA7KllU=;
        b=Fc3BCuwmgCAp2QlCVFVD8zSDs9CkOEE1Q29C/BTdQ7E76su4yz0Q9l2W5bI0PCkrcy
         UsYrufqdVtCWGTecuIHpvBSkdDM9Fe03EyNIRnUpz49pLQztJfrj228wsqOKRfIL2YcF
         1TTJFQUH4ASM2E7C/hBH2bQpXQCl3uhqV4jtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qJBV9vGvoPciWav+3b9AzlUhVYyyPz27rcokUA7KllU=;
        b=hQRb1xYM2kASp2PnYI9sW/rpMZsy+9OQKrscc8+CSgNImuti5eYIjBzaSBFmIuFa4O
         XJG7+rl9Bmg9rm6vm6xQ4TIG+4jPpirLDRgpfUQhisWbydO5F0uoyWiznQbD0lDzbnMh
         sdU0XawVhhgBQYMIn5IAVNyJiirIxAJYI3fnpTf4XqwZqJqsRMATc0ev7/PNmmI4Mh7I
         G+orpdteDnK/4nZTPHjo1Z5eUWfsqw3cro4RtJjJslKbzoTJxuGQqMspatb4YCowAkVS
         U5AbbMaed5I483jFgHLTDg5XkcTyoLV4dC+yrNOBzIovWeY0GebrLrvMnBfXzAER5Wau
         2DnQ==
X-Gm-Message-State: AOAM533RGDVHE0zrYEE7peFrj3cyTLCvoOKmBRGRPdZHlG8qDEv6iUVG
        usxYnAMDIH5oUS0q+Ze3zUNtYQ==
X-Google-Smtp-Source: ABdhPJy/iW9sAcVtoCMYCn0t4wpbCygP1WYijE3gFyH0UvLT474z0xZ8Dg/juVdGbysx89E8/swogQ==
X-Received: by 2002:a9d:6107:: with SMTP id i7mr12024646otj.165.1638465140174;
        Thu, 02 Dec 2021 09:12:20 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:49aa:e3a:9f96:cf34])
        by smtp.gmail.com with ESMTPSA id w10sm138176ott.46.2021.12.02.09.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:12:19 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:12:18 -0600
From:   Seth Forshee <sforshee@digitalocean.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 03/10] fs: tweak fsuidgid_has_mapping()
Message-ID: <Yaj+cuzaAIaIReM7@do-x1extreme>
References: <20211130121032.3753852-1-brauner@kernel.org>
 <20211130121032.3753852-4-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130121032.3753852-4-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 01:10:25PM +0100, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> If the caller's fs{g,u}id aren't mapped in the mount's idmapping we can
> return early and skip the check whether the mapped fs{g,u}id also have a
> mapping in the filesystem's idmapping. If the fs{g,u}id aren't mapped in
> the mount's idmapping they consequently can't be mapped in the
> filesystem's idmapping. So there's no point in checking that.
> 
> Link: https://lore.kernel.org/r/20211123114227.3124056-4-brauner@kernel.org (v1)
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> CC: linux-fsdevel@vger.kernel.org
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Seth Forshee <sforshee@digitalocean.com>

> ---
> /* v2 */
> unchanged
> ---
>  include/linux/fs.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f5d1ae0a783a..28ab20ce0adc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1695,10 +1695,18 @@ static inline void inode_fsgid_set(struct inode *inode,
>  static inline bool fsuidgid_has_mapping(struct super_block *sb,
>  					struct user_namespace *mnt_userns)
>  {
> -	struct user_namespace *s_user_ns = sb->s_user_ns;
> +	struct user_namespace *fs_userns = sb->s_user_ns;
> +	kuid_t kuid;
> +	kgid_t kgid;
>  
> -	return kuid_has_mapping(s_user_ns, mapped_fsuid(mnt_userns)) &&
> -	       kgid_has_mapping(s_user_ns, mapped_fsgid(mnt_userns));
> +	kuid = mapped_fsuid(mnt_userns);
> +	if (!uid_valid(kuid))
> +		return false;
> +	kgid = mapped_fsgid(mnt_userns);
> +	if (!gid_valid(kgid))
> +		return false;
> +	return kuid_has_mapping(fs_userns, kuid) &&
> +	       kgid_has_mapping(fs_userns, kgid);
>  }
>  
>  extern struct timespec64 current_time(struct inode *inode);
> -- 
> 2.30.2
> 
