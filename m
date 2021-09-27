Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00023419E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbhI0SmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhI0SmI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:42:08 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D03C061604;
        Mon, 27 Sep 2021 11:40:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g41so81316005lfv.1;
        Mon, 27 Sep 2021 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pdr5O+ncPIf9G/2QSda1ETX+uwxMJUuxX92fOEy4vzw=;
        b=DFqRWuh/WI82L2FmoCvszLqKef36S6o7+A8JQPZ2WMKppSliKsG/GH/qgXZX50DdyZ
         8bui0C2oTOAdOQw6CnvLCbY8gWXSHGyLyl49unOe7bm2aLsLwKW3th2rtT9JkdbWQCsT
         kqDq1IwX7Gp6bcEu3f5TIcTTTBn937KTGfeU8gJANo02MqFi37lLGS/lX4PbMyeBNqLq
         RpiojMnHsp6Dk+1O9J1kft7w02rGDeRFfSLRY9k9f5tQ1ZjJtpHXA/IcX8TNYwrm7NKM
         xXgKn1uJkSj1hR727iFIHLf7IFyO9t09lTeL/X5Awxhzyh059KtRyzwndsyOoW/ArFHc
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdr5O+ncPIf9G/2QSda1ETX+uwxMJUuxX92fOEy4vzw=;
        b=7xXOfMoD4LELehQJN+iKIOyE//xGYaHpFlDkzkc7sXLXaPpp2i+tGfEhHX6XFVmi0d
         w8Bga6/vePxl+E3qsvl09ctuhZyCCVqDVSjh58RTq9qcV9eg7/IYyhBb0RFuFLqH9+2p
         hfl4F9BGbaCMXAh/+QgJTlw7/exxJk2qVG9ZBPJJCLup/821EYu31tkQ/uXdTVdhsgBs
         epkBGgre1Cxgo+WxZIm5iqD45lsNxHi3SY16QmbE9y2u+9KjXaqeCxK3izYklvxdwkor
         qNfSyqqZtgCKegR13UObfMsQ3iduhH/qBTlC46PT10TVTysTTNiN4XAn8VZFvmbH2qdU
         i/1A==
X-Gm-Message-State: AOAM531eC12S1kz446LXqmjXgO/mnZVuqvIUKue26Oa/0hb0tcYLcNQv
        s4xtVS0kiFBxnX5l3yyxwpQ=
X-Google-Smtp-Source: ABdhPJzYFkq1H+2xH0kzZSyFuHyPhJ+vpWU9lbI/8TpLYsEf+HVRRRl1hUVv9fQqNQlHC8/DaywkfA==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr1440263ljg.158.1632768027968;
        Mon, 27 Sep 2021 11:40:27 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id b2sm942155lff.289.2021.09.27.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:40:27 -0700 (PDT)
Date:   Mon, 27 Sep 2021 21:40:24 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/ntfs3: Fix memory leak if fill_super failed
Message-ID: <20210927184024.m6jarhnrdrhlwnop@kari-VirtualBox>
References: <16cbff75-f705-37cb-ad3f-43d433352f6b@paragon-software.com>
 <f34b8f25-96c7-16d6-1e1c-6bb6c5342edd@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f34b8f25-96c7-16d6-1e1c-6bb6c5342edd@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:47:14PM +0300, Konstantin Komarov wrote:
> Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context.
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 800897777eb0..7099d9b1f3aa 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -1308,6 +1308,9 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
>  	if (err == -EOPNOTSUPP)
>  		sbi->flags |= NTFS_FLAGS_NODISCARD;
>  
> +	/* Restore fc->s_fs_info to free memory allocated in ntfs_init_fs_context. */
> +	fc->s_fs_info = sbi;

Won't build and I do not understand what this does in ntfs_discard.

> +
>  	return err;
>  }
>  
> -- 
> 2.33.0
> 
> 
