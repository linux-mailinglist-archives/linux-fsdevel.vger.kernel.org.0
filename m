Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0145365E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 18:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349464AbiE0QW6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 12:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbiE0QW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 12:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043C403C6;
        Fri, 27 May 2022 09:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CD0E61DDB;
        Fri, 27 May 2022 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99ED1C385A9;
        Fri, 27 May 2022 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653668575;
        bh=8XAC02Xg3Py4hds1HUWlnnOVkjDum3hK8PsY6LQ/M1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbanzFw6hk+ZxmKvBYBHJvrevsjnL/H+zkSXoD9fxEqQWa7YQ/GM2r6J2flebnNPk
         NPe+mNUtTNeKCCPHpf61gVNd7xWNTcyonFkBcaeqXmsOROx2Ap0VSGkpyGvAJurXaJ
         5ajqSsKilEN0lvcbMrGl0mLjavEHF4KFROBKRTL2fVZsqYOy5Zzvi56y3UKk8c6TXn
         L6BQzUAinNqQ0mKfP7nt6aqyxJT9lbnXadeQhxBkRQRKxxjgLiIzD9tfJGcqEM4P+B
         GAlP947kLR30hrfGsg9aVcc34w4x2YXwmE8rlgwV+ki8cEbsPdRfrkMTujtXO1bTzb
         lT0LXL87H+JvQ==
Date:   Fri, 27 May 2022 09:22:54 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [RFC PATCH v2 1/7] statx: add I/O alignment information
Message-ID: <YpD63ocQmmgpZVrd@magnolia>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <87r14ffivd.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r14ffivd.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 27, 2022 at 11:02:46AM +0200, Florian Weimer wrote:
> * Eric Biggers:
> 
> > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > index 1500a0f58041a..f822b23e81091 100644
> > --- a/include/uapi/linux/stat.h
> > +++ b/include/uapi/linux/stat.h
> > @@ -124,9 +124,13 @@ struct statx {
> >  	__u32	stx_dev_minor;
> >  	/* 0x90 */
> >  	__u64	stx_mnt_id;
> > -	__u64	__spare2;
> > +	__u32	stx_mem_align_dio;	/* Memory buffer alignment for direct I/O */
> > +	__u32	stx_offset_align_dio;	/* File offset alignment for direct I/O */
> >  	/* 0xa0 */
> > -	__u64	__spare3[12];	/* Spare space for future expansion */
> > +	__u32	stx_offset_align_optimal; /* Optimal file offset alignment for I/O */
> > +	__u32	__spare2;
> > +	/* 0xa8 */
> > +	__u64	__spare3[11];	/* Spare space for future expansion */
> >  	/* 0x100 */
> >  };
> 
> Are 32 bits enough?  Would it make sense to store the base-2 logarithm
> instead?

I don't think a log2 will work here, XFS will want to report things like
raid stripe sizes, which can be any multiple of the fs blocksize.

32 bits is probably enough, seeing as the kernel won't do an IO larger
than 2GB anyway.

--D

> Thanks,
> Florian
> 
