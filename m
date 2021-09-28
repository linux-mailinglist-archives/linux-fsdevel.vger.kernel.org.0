Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3BF41B55F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbhI1RqO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbhI1RqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:46:08 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73658C06161C;
        Tue, 28 Sep 2021 10:44:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u18so93956332lfd.12;
        Tue, 28 Sep 2021 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aZjQH7QMaSl5FVaqYf6XvxwPYWNnZykG+9zOEaj2ve8=;
        b=ikPva56GfBzLVz9pfiLjNMzDQwJQ13fOS6PD+07irzd9UwvL09+1AvafRN/kRz7tfr
         m07+bSlrSOOWl+czXXBnR9T5Is0yfpPCg5awpeF2pvKGIHRl7OWfsWtJ0XnGgLOB5Bqz
         EpUgBtWailjmwVvqs/f/Frx03W8BPM6UUfEtFmVhRvzWrI937buBDjfl3WzMBNJ64YBD
         cMdFjBYoad6Dq1SOLHGVS5Lo3L16+vYbHl1HlrLmwUM9+8VZA9lR7KTlZHBfY29VNs0c
         yUMxeLFPA2IlKhJLe9jOAN51Sw7C5LQUQfx7bS4hQ6NsHejJeyacccnlFVDoFc1EsdnW
         4fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aZjQH7QMaSl5FVaqYf6XvxwPYWNnZykG+9zOEaj2ve8=;
        b=KDW4JKLj4r2DcvoJJbVFjUYjENSh7c4S6DPsVpo8v45TyJeyZ5pK7SUyXav2qvMxZZ
         XTwDKlLVp8fl/Uc53Sj35tB9suHc7ZjneuCOO+7n8XoqLerBJz2SpN0Fjji50DDHWBFp
         vVu7dknUvkf878oTwpu450ZWl2jC+5HY4Rx91TlZNBVnWjrWkJ7AnlGTeWDaKxwcnVSQ
         oTDoVe/UkViTUSalgENcNcyiGL8hBAlbTJzMjiEZEaCN7HoR6NRXoArlZJx3cOvhZouF
         /JqcW59elMpYMlkTpT7pp67KEnh5UMEj7EivgPZn7gqPIu0PutO+jtjTWtpqsI1tdQ7I
         k4tA==
X-Gm-Message-State: AOAM533rsA43pN6Cq+7q0WevA6XfP4CIoSpDxUwPa5z9uwqSjDuRT03B
        zMaTKr+BQmKDq1jlW5I23htRgjSW1lw=
X-Google-Smtp-Source: ABdhPJx56tNegwxTEFCawBFhlyG+ObrsBC9oQQtRrYyvlPxrw7+usHAtHxuaL9eiYgL9xPgmdg2wvw==
X-Received: by 2002:ac2:57cb:: with SMTP id k11mr6558368lfo.70.1632851065421;
        Tue, 28 Sep 2021 10:44:25 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l9sm1988435lfh.36.2021.09.28.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:44:25 -0700 (PDT)
Date:   Tue, 28 Sep 2021 20:44:23 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs/ntfs3: Fix memory leak if fill_super failed
Message-ID: <20210928174423.z7a6chrjmmyezlsp@kari-VirtualBox>
References: <a7c2e6d3-68a1-25f7-232e-935ae9e5f6c8@paragon-software.com>
 <5ee2a090-1709-5ca0-1e78-8db1f3ded973@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee2a090-1709-5ca0-1e78-8db1f3ded973@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:17:29PM +0300, Konstantin Komarov wrote:
> Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/super.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 800897777eb0..aff90f70e7bf 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1242,6 +1242,10 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	return 0;
>  out:
>  	iput(inode);
> +
> +	/* Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context. */
> +	fc->s_fs_info = sbi;
> +

Nack. fc->s_fs_info is already pointing to sbi. We null this just before
we exit so it is impossible to be anything else in failure case.

	fc->fs_private = NULL;
	fc->s_fs_info = NULL;

	return 0;
out:
	iput(inode);

>  	return err;
>  }
>  
> -- 
> 2.33.0
> 
> 
