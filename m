Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E404864C224
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 03:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiLNCHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 21:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237054AbiLNCHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 21:07:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70165EBD
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 18:07:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z8-20020a17090abd8800b00219ed30ce47so5594600pjr.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 18:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45RQdk/Pt1OwbmIBrWKLRwNWhtjQa23QL11BAFqftYk=;
        b=ocNKCykuU+Ywi3AZsTWEajbKc2gIC/LLl6ErnVgVuCDOKGJN7I8q3ycw849ngFZ620
         NOZzGVVD47LdVaNO2YCwqy42O5nKGCe7mJCTjBbAhcveFcFw9m6aJiUfh+Nh6IYJVOoM
         8AkyuCu68Nuh+PYBfvmEE7gVV6o1ldr8iWbMEAvM7SANMqj7kUFRfeXgF3FZbvDmvLXK
         87MAcLt4uGBFeCVhMerd8n14mkHauBYECEq7E638k97OWg8NRAZjUaam2wXcbrHCrN6+
         H34oxGhXnHuSTRUKqZlt7iBgABtM/qNtfpt1oCmKE2xcyh+ZTgty7zdisxsqPmQW1njy
         lJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45RQdk/Pt1OwbmIBrWKLRwNWhtjQa23QL11BAFqftYk=;
        b=z62KKo+Xtp0mrDXjhX0Qqq6PTxmySrbDrfqj6ZQkkrEJXaalpcyEQkvwSCOHb/eoZh
         gRFrtZx66lalpnt+aB92oD9NOTq3dBQV1KNsaJ+eg8EnHeeZIexRo9ADx9WN6igd1d5c
         +zyg64uqi6M78E/ItdyqG03ZV0UEEM/fM6sTJCXO8eLtWDUv2GhluWpRE2aTKiyeU91W
         OdNTrQmaBo5cgmE+J0BnaZFNpQHUCbGaPus77SgNREa/ui3xBPzR5Hk8fbUPx0xEgV7Z
         Cs5qjU4Adspr9R9ok+J2CGxZf9KI1vId6eNOD862+iIH0CCMviSbXuFBoKTC1RnOLbSY
         sQOw==
X-Gm-Message-State: ANoB5pkSaPNjjOhoVxrXzvlv1vuYcf9HFn/xpLOKpN8iFBGk4K/ZRSDv
        n+K36FFPH7CJl7EmK7t/8Flnfz4VElnIY7g1
X-Google-Smtp-Source: AA0mqf7NZW3hYUAiFV+ERydRLogNcS7jgs53ctybgx2mB/1dT6V4jw6XA11TfWyAKzoVaJUYMnjWig==
X-Received: by 2002:a05:6a20:a6a0:b0:af:6d54:239a with SMTP id ba32-20020a056a20a6a000b000af6d54239amr116181pzb.38.1670983669765;
        Tue, 13 Dec 2022 18:07:49 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id d3-20020a17090a6f0300b00213ee5a12c9sm162351pjk.55.2022.12.13.18.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 18:07:49 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5HBS-008AfK-PV; Wed, 14 Dec 2022 13:07:46 +1100
Date:   Wed, 14 Dec 2022 13:07:46 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] xfs: don't enable large folios on fs-verity
 sealed inode
Message-ID: <20221214020746.GH3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-9-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-9-aalbersh@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:32PM +0100, Andrey Albershteyn wrote:
> fs-verity doesn't work with large folios. Don't enable large folios
> on those inode which are already sealed with fs-verity (indicated by
> diflag).
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_iops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index b229d25c1c3d6..a4c8db588690e 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1294,7 +1294,12 @@ xfs_setup_inode(
>  	gfp_mask = mapping_gfp_mask(inode->i_mapping);
>  	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));
>  
> -	mapping_set_large_folios(inode->i_mapping);
> +	/*
> +	 * As fs-verity doesn't support folios so far, we won't enable them on
> +	 * sealed inodes
> +	 */
> +	if (!IS_VERITY(inode))
> +		mapping_set_large_folios(inode->i_mapping);
>  
>  	/*
>  	 * If there is no attribute fork no ACL can exist on this inode,

Looks reasonable to me.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
