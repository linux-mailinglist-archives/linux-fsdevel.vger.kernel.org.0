Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C31563CAAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236555AbiK2VxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiK2VxQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:53:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F33C778;
        Tue, 29 Nov 2022 13:53:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE4E36190F;
        Tue, 29 Nov 2022 21:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F489C433C1;
        Tue, 29 Nov 2022 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669758794;
        bh=bTRQpleHw3e1K5h45HcxReRuVfkr0k9Fzd604qTzi5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dpDk1X6tQ2hnPFoGDJRzCv91NF9jt8l573UZXNLtRR3q2bgDYdsC5L0ja5KkP4GSE
         k+1HuESDtsV6nLetO4cFAmy2hjwSpuy+MseHExN6KLofSazIW0ziY5rNuB9NbFcwPQ
         +za2U8Z+pOD4mB8mjgM2qbwUaW28eEHCA3tWdRCRS4JFhU20dvER+Sp6WnqfOVmOez
         cETU5OOEkfhxkvGyc71fhQfjLYxopKod9flKUFVOKHvL9d3sYvFCNPU9MA1rA56bqT
         PLh0IEj9QuiDvc8ZJGsdc00HcnhflwQxvKr5I5XZiGUiNqf2w4B5BCMSswGjWmKERz
         ponDng64FfQoA==
Date:   Tue, 29 Nov 2022 13:53:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 10/9] xfs: add debug knob to slow down writeback for
 fun
Message-ID: <Y4Z/SRoONpVMv3dZ@magnolia>
References: <20221123055812.747923-1-david@fromorbit.com>
 <Y4U3XWf5j1zVGvV4@magnolia>
 <Y4VejsHGU/tZuRYs@magnolia>
 <20221129013453.GY3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129013453.GY3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 12:34:53PM +1100, Dave Chinner wrote:
> On Mon, Nov 28, 2022 at 05:21:18PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Add a new error injection knob so that we can arbitrarily slow down
> > writeback to test for race conditions and aberrant reclaim behavior if
> > the writeback mechanisms are slow to issue writeback.  This will enable
> > functional testing for the ifork sequence counters introduced in commit
> > 745b3f76d1c8 ("xfs: maintain a sequence count for inode fork
> > manipulations").
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> > v2: this time with tracepoints
> > ---
> .....
> 
> > @@ -267,6 +270,14 @@ xfs_errortag_valid(
> >  	return true;
> >  }
> >  
> > +bool
> > +xfs_errortag_enabled(
> > +	struct xfs_mount	*mp,
> > +	unsigned int		tag)
> > +{
> > +	return mp->m_errortag && mp->m_errortag[tag] != 0;
> > +}
> 
> Perhaps consider using the new xfs_errortag_valid() helper? i.e.
> 
> {
> 	if (!mp->errortag)
> 		return false;
> 	if (!xfs_errortag_valid(tag))
> 		return false;
> 	return mp->m_errortag[tag] != 0;

Fixed.

> }
> 
> > +
> >  bool
> >  xfs_errortag_test(
> >  	struct xfs_mount	*mp,
> > diff --git a/fs/xfs/xfs_error.h b/fs/xfs/xfs_error.h
> > index 5191e9145e55..936d0c52d6af 100644
> > --- a/fs/xfs/xfs_error.h
> > +++ b/fs/xfs/xfs_error.h
> > @@ -45,6 +45,17 @@ extern bool xfs_errortag_test(struct xfs_mount *mp, const char *expression,
> >  		const char *file, int line, unsigned int error_tag);
> >  #define XFS_TEST_ERROR(expr, mp, tag)		\
> >  	((expr) || xfs_errortag_test((mp), #expr, __FILE__, __LINE__, (tag)))
> > +bool xfs_errortag_enabled(struct xfs_mount *mp, unsigned int tag);
> > +#define XFS_ERRORTAG_DELAY(mp, tag)		\
> > +	do { \
> > +		if (!xfs_errortag_enabled((mp), (tag))) \
> > +			break; \
> > +		xfs_warn_ratelimited((mp), \
> > +"Injecting %ums delay at file %s, line %d, on filesystem \"%s\"", \
> > +				(mp)->m_errortag[(tag)], __FILE__, __LINE__, \
> > +				(mp)->m_super->s_id); \
> > +		mdelay((mp)->m_errortag[(tag)]); \
> > +	} while (0)
> 
> Putting a might_sleep() in this macro might be a good idea - that
> will catch delays being added inside spin lock contexts...

Done.  Thanks for the review!

--D

> Other than that, it looks fine.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> -- 
> Dave Chinner
> david@fromorbit.com
