Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A529743B942
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhJZSTu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 14:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhJZSTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:19:49 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CAC061745;
        Tue, 26 Oct 2021 11:17:24 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id k13so251801ljj.12;
        Tue, 26 Oct 2021 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbkycfBpiPzNz9mU9kLDzsxQuKQ9vzT3rMC0AKEjNkk=;
        b=PNi4bZGi9qc5Fq5YyVp5QoxTeUJ4eSQu8LDldDiJBDWYN34lZPCOz3EeFMrhlenKim
         Fyy/EYZ293+ika4AtxlkXQ4GzvFfrza/RPydEgRtXmV4TDKYnDfTTNwVu3dO6vg5806s
         EtCO9NN7q75ENNFzuV/qwvS/iKLrwxNbWiQ5oVi2li3YdHqlqCNz+8JOJOdXR5b388D2
         jM2OW+v/KALLxr5fUHrpIh+Qmujjg56HdN23B/SC5Wg1VLtwiXXwkFbmM+ZwQxL+UEgg
         DhZO89R+lM/raMYq2nvZ/vQiV9njZ1JzlsG2Y2xpwcnLfjky/Tj5iXNJhN0qBT6mYjWF
         3PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbkycfBpiPzNz9mU9kLDzsxQuKQ9vzT3rMC0AKEjNkk=;
        b=5HU5tsoIARgxcOwi/Gds7yaPNspllIB9F4PLmKUPMHGsGUlQQ1ttc23mIbX+LfTxYK
         lWwuQzGaCnIajAWiJ0getoDLb6auCIJYZv0EbyWQ5vP75QaDQGrMIYKp0ddikivG1KAz
         uQgTo8zTSGqcr9gXFH6q9RdhXLtdOV4Xdq7Ni1kEyNjvZDHEwobtJKjZLUmk7w1Ohmxd
         y3f/fnTfBiXmp1epomwbrNYpN18WEGVkOiAIvdWggEDfaD2ugUyIDwWVF7qnUSD3x4IC
         9ZZcYz7hvnnpBPEatAV0LoyIXVqYRuFNIr8tgPO+hJ6q9b7g3hVRFSJmBbj30aGTU65+
         /RhA==
X-Gm-Message-State: AOAM532kvuUMhJOpunlJHz+LVvW+RX0aeFmXeBGjTjBMZoi1yqon4ZGe
        O2OiDNKEyWS/s59azo4Dsqk=
X-Google-Smtp-Source: ABdhPJyhMoeGvZPoK9EvZlMCo7em/vPsOoZzfbj4/UKWBmt47d67dHTmk7KQO6SQKGVxSofl3miYrA==
X-Received: by 2002:a05:651c:617:: with SMTP id k23mr27312236lje.402.1635272243035;
        Tue, 26 Oct 2021 11:17:23 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id g18sm46711ljl.26.2021.10.26.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:17:22 -0700 (PDT)
Date:   Tue, 26 Oct 2021 21:17:20 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Ganapathi Kamath <hgkamath@hotmail.com>
Subject: Re: [PATCH 1/4] fs/ntfs3: Keep preallocated only if option prealloc
 enabled
Message-ID: <20211026181720.46jaw46hn2vwtqgk@kari-VirtualBox>
References: <a57c1c49-4ef3-15ee-d2cd-d77fb4246b3c@paragon-software.com>
 <19b0fc31-a28f-69aa-27dc-e6514a10643e@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b0fc31-a28f-69aa-27dc-e6514a10643e@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 07:40:57PM +0300, Konstantin Komarov wrote:
> If size of file was reduced, we still kept allocated blocks.
> This commit makes ntfs3 work as other fs like btrfs.
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=214719
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> 
> Reported-by: Ganapathi Kamath <hgkamath@hotmail.com>
> Tested-by: Ganapathi Kamath <hgkamath@hotmail.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 43b1451bff53..3ac0482c6880 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -494,7 +494,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
>  
>  	down_write(&ni->file.run_lock);
>  	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
> -			    &new_valid, true, NULL);
> +			    &new_valid, ni->mi.sbi->options->prealloc, NULL);
>  	up_write(&ni->file.run_lock);
>  
>  	if (new_valid < ni->i_valid)
> -- 
> 2.33.0
> 
> 
