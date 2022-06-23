Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26735586E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 20:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbiFWSSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 14:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiFWSQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:16:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186994D9C9;
        Thu, 23 Jun 2022 10:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22CD5B824BC;
        Thu, 23 Jun 2022 17:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812B1C3411B;
        Thu, 23 Jun 2022 17:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656005002;
        bh=wHCbmf5IRU39rWTli2nZUaGZkhlxJIj37MxQFogSdEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PyKKn5AmJY5LA84KqOczZyyRySup5L6Azsjk02/PDhbsW5QDnbgiunWdXq6+5Hdly
         so5Jt85YlQB9yKrlKNekvT01BKoj61uSsEu/gk7IN2BYRRSZpJ27dJHNI3qqcUG7Au
         zhBqRL1Qly6dDmbG/gEgCOJOudXz40JLfL6p+bxfc6GS+W4PIbHRpxLNi83ee1O/GS
         uP5kPq9auC78LW6pOr1jPPca7r7KzTXLrrbzcVjhNuSFmJf/idfZ+iKYrqA82FALa/
         yKF7FO0a8934AaK2M+hpSsOnQSPqHVFK1nrJQcNXnJEua4rVcuQoWL5ptjezOKzdVE
         vp2zp8L/1LTLQ==
Date:   Thu, 23 Jun 2022 10:23:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/8] statx: add direct I/O alignment information
Message-ID: <YrShiIjNCIANjSwL@sol.localdomain>
References: <20220616201506.124209-1-ebiggers@kernel.org>
 <20220616201506.124209-2-ebiggers@kernel.org>
 <YrSNlFgW6X4pUelg@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrSNlFgW6X4pUelg@magnolia>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:58:12AM -0700, Darrick J. Wong wrote:
> > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > index 7df06931f25d8..ff277ced50e9f 100644
> > --- a/include/linux/stat.h
> > +++ b/include/linux/stat.h
> > @@ -50,6 +50,8 @@ struct kstat {
> >  	struct timespec64 btime;			/* File creation time */
> >  	u64		blocks;
> >  	u64		mnt_id;
> > +	u32		dio_mem_align;
> > +	u32		dio_offset_align;
> 
> Hmm.  Does the XFS port of XFS_IOC_DIOINFO to STATX_DIOALIGN look like
> this?
> 
> 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> 
> 	kstat.dio_mem_align = target->bt_logical_sectorsize;
> 	kstat.dio_offset_align = target->bt_logical_sectorsize;
> 	kstat.result_mask |= STATX_DIOALIGN;

Yes, I think so.

However, if we need more fields as Avi Kivity requested at
https://lore.kernel.org/r/6c06b2d4-2d96-c4a6-7aca-5147a91e7cf2@scylladb.com
that is going to complicate things.  I haven't had a chance to look
into whether those extra fields are really needed.  Your opinion on whether XFS
(and any other filesystem) needs them would be appreciated.

> 
> And I guess you're tabling the "optimal" IO discussions for now, because
> there are too many variants of what that means?
> 

Yes, that's omitted for now due to the apparent redundancy with stx_blksize.

- Eric
