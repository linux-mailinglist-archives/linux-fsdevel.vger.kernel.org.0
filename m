Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6AB7A00B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 06:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfG3Ebr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 00:31:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45131 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfG3Ebr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:31:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so28374257plr.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2019 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jff1v1+xBPkVNib6smzi9or+Z5ivIfKl1/5fyTJeUXM=;
        b=iUwi2yxDTTmnyE3W9f7x2PRFahy0EfU0FRkjor6FL8ZBn1HAc2NNHhXNQiP7DxiNXu
         zexrCt1ieoP6GiruyGPiscfXflKZOURfcgJM0pwFS/XDldhQqEZTrJtDVEhimzEVxy8M
         woNn/63idoITGhRZHnK2nEAbwDzdkrb5pqT2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jff1v1+xBPkVNib6smzi9or+Z5ivIfKl1/5fyTJeUXM=;
        b=eFCkN3Xfbqsqx5DhOclTPd7M5Jbp/m4TpDP3a5aYbVEyHcFNqwfYr/BGX5XfUMWQhV
         zGfk29nZIY8Kur6RywKF536pR93PSpCJMc7Rhw65GQDR867czvNYscR/mE3WB1icj4+e
         qWhASaEswH9jPubR00kWKUuce+pwwlGbIMxVHJNRShl6p3thNg4NfI+gYekoxveymS+o
         9glwwF49aMyBTjEP9Z4QbjqJtcmrY7920aipTvMxj+enjVED26e6fWOryoOpu6lmPCNG
         JMufEuiQj8GdMVpXcq2DgnGOVJ3T86TQ9WHW2cqMhnSuiPjkRHDOc8XsS0BVvNhafcif
         dbJw==
X-Gm-Message-State: APjAAAW0JbuahvDhyCzxhuzudWRaAIGZwPqSDQMKhg106IoU9vZIqmEH
        MWOriPQrTgH+B4sOp8VtseQScA==
X-Google-Smtp-Source: APXvYqzLt+3JbxlxdApPdi1+DZco+EZiCDg4gvrywPkbPKK4SrOK6PKWeBkEZPzVR2ez5PRxBD9nvA==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr118837503plb.25.1564461106724;
        Mon, 29 Jul 2019 21:31:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v12sm54532952pjk.13.2019.07.29.21.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 21:31:45 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:31:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Subject: Re: [PATCH 19/20] pstore: fs superblock limits
Message-ID: <201907292129.AC796230@keescook>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-20-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-20-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:23PM -0700, Deepa Dinamani wrote:
> Also update the gran since pstore has microsecond granularity.

So, I'm fine with this, but technically the granularity depends on the
backend storage... many have no actual time keeping, though. My point is,
pstore's timestamps are really mostly a lie, but the most common backend
(ramoops) is seconds-granularity.

So, I'm fine with this, but it's a lie but it's a lie that doesn't
matter, so ...

Acked-by: Kees Cook <keescook@chromium.org>

I'm open to suggestions to improve it...

-Kees

> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: anton@enomsg.org
> Cc: ccross@android.com
> Cc: keescook@chromium.org
> Cc: tony.luck@intel.com
> ---
>  fs/pstore/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 89a80b568a17..ee752f9fda57 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -388,7 +388,9 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_blocksize_bits	= PAGE_SHIFT;
>  	sb->s_magic		= PSTOREFS_MAGIC;
>  	sb->s_op		= &pstore_ops;
> -	sb->s_time_gran		= 1;
> +	sb->s_time_gran         = NSEC_PER_USEC;
> +	sb->s_time_min		= S64_MIN;
> +	sb->s_time_max		= S64_MAX;
>  
>  	parse_options(data);
>  
> -- 
> 2.17.1
> 

-- 
Kees Cook
