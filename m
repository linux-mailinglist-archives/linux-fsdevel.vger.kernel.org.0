Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219A5B8EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Sep 2022 20:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiINSNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Sep 2022 14:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiINSNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:13:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E63830F63;
        Wed, 14 Sep 2022 11:13:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35FDBB81C5A;
        Wed, 14 Sep 2022 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA34C433C1;
        Wed, 14 Sep 2022 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663179208;
        bh=fWStAdSjgQT2wzPc1VHO70yNyePHm2Nb0E7V5N5FSA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=naODD2dxg+E/B4DF1PVygYLC2VuSoJvnovugNGZjiiYVTZ31ytQwa6EiYcy37dsSs
         9SlTC6Y7Hmo710amps4MJEqK3yelsXR8K3flkiqmIUdeWqIC39M4LHdzV50MvHadWT
         D4H8z3f9gTtqLu2Ikpg0VJVyB68zGioMLlIVr3XsHU7XdnrlfIik6x1htvPPU18zzx
         11g5Yd+JTvj+hmOcRwdpinwt4zPlVxIVa983dOFYXdnn0YAaBXMa5DTLz2Z5/pls4x
         73aSfB4TTTnQo+hLJe0UY6PzIUK8Ic12/gTEnW4KRW9GDs7bcKlzkvuSIN4++WIsmC
         HUFRDGgXGfDEA==
Date:   Wed, 14 Sep 2022 11:13:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com,
        david@fromorbit.com, hch@infradead.org, jane.chu@oracle.com
Subject: Re: [PATCH 1/3] xfs: fix the calculation of length and end
Message-ID: <YyIZyE7I0ewoxtgj@magnolia>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1662114961-66-2-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662114961-66-2-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:35:59AM +0000, Shiyang Ruan wrote:
> The end should be start + length - 1.  Also fix the calculation of the
> length when seeking for intersection of notify range and device.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks correct to me,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_notify_failure.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
> index c4078d0ec108..3830f908e215 100644
> --- a/fs/xfs/xfs_notify_failure.c
> +++ b/fs/xfs/xfs_notify_failure.c
> @@ -114,7 +114,7 @@ xfs_dax_notify_ddev_failure(
>  	int			error = 0;
>  	xfs_fsblock_t		fsbno = XFS_DADDR_TO_FSB(mp, daddr);
>  	xfs_agnumber_t		agno = XFS_FSB_TO_AGNO(mp, fsbno);
> -	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen);
> +	xfs_fsblock_t		end_fsbno = XFS_DADDR_TO_FSB(mp, daddr + bblen - 1);
>  	xfs_agnumber_t		end_agno = XFS_FSB_TO_AGNO(mp, end_fsbno);
>  
>  	error = xfs_trans_alloc_empty(mp, &tp);
> @@ -210,7 +210,7 @@ xfs_dax_notify_failure(
>  	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
>  
>  	/* Ignore the range out of filesystem area */
> -	if (offset + len < ddev_start)
> +	if (offset + len - 1 < ddev_start)
>  		return -ENXIO;
>  	if (offset > ddev_end)
>  		return -ENXIO;
> @@ -222,8 +222,8 @@ xfs_dax_notify_failure(
>  		len -= ddev_start - offset;
>  		offset = 0;
>  	}
> -	if (offset + len > ddev_end)
> -		len -= ddev_end - offset;
> +	if (offset + len - 1 > ddev_end)
> +		len -= offset + len - 1 - ddev_end;
>  
>  	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
>  			mf_flags);
> -- 
> 2.37.2
> 
