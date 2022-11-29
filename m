Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936D63B74C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 02:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbiK2Be7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 20:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiK2Be5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:34:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1947642F7F
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:34:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so12265946pfx.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8UxR0vmo60MaG7PcPSAExNLPv9v74btYUzUjbptZdnw=;
        b=FtcJe+Uu937tlBSvl8+oJHblsX7O5ip2QzxvDGMrtje7JTh6zZWGHZd6yTtEKi+ByG
         Kc9v5fAaW60PHuovrWHwDJYPX7voRZ4Z/DhqbrC15uhQ2ZWNrdCUkFklGmdeuohLqSDI
         OULxtKp8/nsCO6/Bc8Dv877fFmAilfXyDXHbp02Dq3YmKfwfdByB89faOjqPRSudESvE
         9eY5tZx7+X8RECSDEexPY5sIg5XTHb/HFJsUdsrrhb7x1DthwoRoHOHcCZtIvzNX2T+a
         D3u4+f6DskTnM4/mK2Q3hgR8Zc1UP1BIVkkLtFzOrIpwt1TXrJnQRXTYDWxJq/5Ge7ZH
         c+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UxR0vmo60MaG7PcPSAExNLPv9v74btYUzUjbptZdnw=;
        b=N4WE/oA2trpeoQ43+y1FSoWKSOeHfDtt6jqGEHreFnrzSzpNCSihqqFhywc9CBvXkJ
         MRySI1crIn9cRDDyxBFGXuhCXszh7svve4mslzsp5tdsBkX+qeB987M7zF7aIbNNjYg+
         OkE264klKZm/Vd10HIAVQZ3ABmx5p01ckM3vnEOpNgLjuYfd73V+0hqZVOPw5Nr3Zlak
         ut8EyLgOcmef1oYJI0vTBpIj7HO1EVW4NJx2dFXeA/UvRxhKi9FGzPMN0GvQ5PS9et/Z
         0XwFbNBKQrHB2yZYgupYsWCydzYbCjnIULFiE3z2wP3jUwutcYjkc8YxuKsnxKTFbThp
         whVA==
X-Gm-Message-State: ANoB5pniyK94isYAr/HFzNhgiAWl9ux3a2FlZU8vRgdmRGq4Z8IavK8L
        LHyrokmr/5LI8/ptsLsBWISGjA==
X-Google-Smtp-Source: AA0mqf6RitAbceu9CoV8/Tiea4fE55+y/t+UK4nK3ogoOUTC2ZvtezEgr29dqMX1MepyTXYmymkarQ==
X-Received: by 2002:a63:1b60:0:b0:46f:b2a5:2e2d with SMTP id b32-20020a631b60000000b0046fb2a52e2dmr32937222pgm.400.1669685696608;
        Mon, 28 Nov 2022 17:34:56 -0800 (PST)
Received: from dread.disaster.area (pa49-186-65-106.pa.vic.optusnet.com.au. [49.186.65.106])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090340c300b001897a8b537asm5011150pld.221.2022.11.28.17.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 17:34:56 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ozpWP-002FWy-CT; Tue, 29 Nov 2022 12:34:53 +1100
Date:   Tue, 29 Nov 2022 12:34:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/9] xfs: add debug knob to slow down writeback for
 fun
Message-ID: <20221129013453.GY3600936@dread.disaster.area>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
 <Y4VejsHGU/tZuRYs@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4VejsHGU/tZuRYs@magnolia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 05:21:18PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new error injection knob so that we can arbitrarily slow down
> writeback to test for race conditions and aberrant reclaim behavior if
> the writeback mechanisms are slow to issue writeback.  This will enable
> functional testing for the ifork sequence counters introduced in commit
> 745b3f76d1c8 ("xfs: maintain a sequence count for inode fork
> manipulations").
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
> v2: this time with tracepoints
> ---
.....

> @@ -267,6 +270,14 @@ xfs_errortag_valid(
>  	return true;
>  }
>  
> +bool
> +xfs_errortag_enabled(
> +	struct xfs_mount	*mp,
> +	unsigned int		tag)
> +{
> +	return mp->m_errortag && mp->m_errortag[tag] != 0;
> +}

Perhaps consider using the new xfs_errortag_valid() helper? i.e.

{
	if (!mp->errortag)
		return false;
	if (!xfs_errortag_valid(tag))
		return false;
	return mp->m_errortag[tag] != 0;
}

> +
>  bool
>  xfs_errortag_test(
>  	struct xfs_mount	*mp,
> diff --git a/fs/xfs/xfs_error.h b/fs/xfs/xfs_error.h
> index 5191e9145e55..936d0c52d6af 100644
> --- a/fs/xfs/xfs_error.h
> +++ b/fs/xfs/xfs_error.h
> @@ -45,6 +45,17 @@ extern bool xfs_errortag_test(struct xfs_mount *mp, const char *expression,
>  		const char *file, int line, unsigned int error_tag);
>  #define XFS_TEST_ERROR(expr, mp, tag)		\
>  	((expr) || xfs_errortag_test((mp), #expr, __FILE__, __LINE__, (tag)))
> +bool xfs_errortag_enabled(struct xfs_mount *mp, unsigned int tag);
> +#define XFS_ERRORTAG_DELAY(mp, tag)		\
> +	do { \
> +		if (!xfs_errortag_enabled((mp), (tag))) \
> +			break; \
> +		xfs_warn_ratelimited((mp), \
> +"Injecting %ums delay at file %s, line %d, on filesystem \"%s\"", \
> +				(mp)->m_errortag[(tag)], __FILE__, __LINE__, \
> +				(mp)->m_super->s_id); \
> +		mdelay((mp)->m_errortag[(tag)]); \
> +	} while (0)

Putting a might_sleep() in this macro might be a good idea - that
will catch delays being added inside spin lock contexts...

Other than that, it looks fine.

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
