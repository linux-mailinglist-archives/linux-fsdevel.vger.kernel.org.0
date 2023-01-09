Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B36662BBE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 17:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjAIQxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 11:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbjAIQw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBC4164D
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 08:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673283094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zH0iIm/82e8/+vbOmbtlqd9kWO2ASu2512CGHEzjOz4=;
        b=YghmDgzEKzr5Qx09DfHFegxeDYA07cgaCwJAGTm+HDa8TXaamMD0o5/jsT+GrNChnrgn4t
        5ZNe1sYRy4ueBrCXHKR3O5Luf5+Yey4lbDL0pgk/0RudIGm9vrUe43xAdAVjx+BcGAUjxO
        tBfTJbGNi1UWHHlEjhABHz10ofOAoYI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-527-hUptvM9pPwWA3-KpN1Xp-Q-1; Mon, 09 Jan 2023 11:51:33 -0500
X-MC-Unique: hUptvM9pPwWA3-KpN1Xp-Q-1
Received: by mail-ej1-f70.google.com with SMTP id qa18-20020a170907869200b007df87611618so5778227ejc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 08:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zH0iIm/82e8/+vbOmbtlqd9kWO2ASu2512CGHEzjOz4=;
        b=SV+y/dqfmANay7IvozVvHyVjjzSIbYQLeFuKeXcMoo9BSnF1pYF32WUS2K0XDmQr4J
         pm8Xf9snwuhd6/jXb2sAjzm9jd1PHDJOdSYlswfEwoSYOHNZjVfBpLUFT5kuYeekJC4u
         /GmSx7uwFM1CNL8AmREvvcxsKMRvrwEnXYoePTOh5xwf0R2FLzZHYMwPcmdU2d7nTLHb
         Scn53thyhAsfLtXSwRYVJDxGHY/DpKAJqrzMfQbmJ5eAEGAwhKPNhs1y1tsRxwUNclSN
         8cvR3sWI0rrefNSPl4OCfmRbgb2M7NEFOauLIRWDJOJRfjFi2UEhe+pfqoFqfGyDl3qx
         ezLw==
X-Gm-Message-State: AFqh2koQIUsIctsazStz/WH6GAdFKiiWq2MbDbrpxzFueUHTHd5R+RZx
        ydq+MQwAnoqL6yOHAaA/riw25iZ1gakXE1P2ZbZVW8QKonMCy7ShiWXDOBHTknrURr8OXJr76xH
        rTJzsCSQR910REQGfIAuhpFWI
X-Received: by 2002:aa7:d752:0:b0:499:bcfc:f47b with SMTP id a18-20020aa7d752000000b00499bcfcf47bmr2384275eds.16.1673283092007;
        Mon, 09 Jan 2023 08:51:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu8E1jgjThO9ffI96XDW5cVmIvQxVnT+jpvilrs0fzNH3qtf0G8n2DXIql8yjJlJPZn96Y00w==
X-Received: by 2002:aa7:d752:0:b0:499:bcfc:f47b with SMTP id a18-20020aa7d752000000b00499bcfcf47bmr2384268eds.16.1673283091883;
        Mon, 09 Jan 2023 08:51:31 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ch17-20020a0564021bd100b004585eba4baesm3943653edb.80.2023.01.09.08.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:51:31 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:51:29 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 05/11] xfs: add inode on-disk VERITY flag
Message-ID: <20230109165129.ztwml2wnjlk77oed@aalbersh.remote.csb>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-6-aalbersh@redhat.com>
 <20221214012928.GE3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214012928.GE3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:29:28PM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 06:29:29PM +0100, Andrey Albershteyn wrote:
> > Add flag to mark inodes which have fs-verity enabled on them (i.e.
> > descriptor exist and tree is built).
> .....
> > 
> >  static inline bool xfs_dinode_has_bigtime(const struct xfs_dinode *dip)
> >  {
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index f08a2d5f96ad4..8d9c9697d3619 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -636,6 +636,8 @@ xfs_ip2xflags(
> >  			flags |= FS_XFLAG_DAX;
> >  		if (ip->i_diflags2 & XFS_DIFLAG2_COWEXTSIZE)
> >  			flags |= FS_XFLAG_COWEXTSIZE;
> > +		if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
> > +			flags |= FS_VERITY_FL;
> >  	}
> 
> Ah, attribute flag confusion - easy to do. xflags (FS_XFLAG*) are a
> different set of (extended) flags than the standard VFS inode flags
> (FS_*_FL).
> 
> To place the verity enabled state in the extended flags, you would
> need to define FS_XFLAG_VERITY in include/uapi/linux/fs.h. You'll
> also need to add the conversion from FS_VERITY_FL to FS_XFLAG_VERITY
> to fileattr_fill_flags() and vice versa to fileattr_fill_xflags()
> 
> This will allow both the VFS inode flags UAPI and the
> FS_IOC_FSGETXATTR extended flag API to see the inode has verity
> enabled on it.
> 
> Once FS_XFLAG_VERITY is defined, changing the code in XFS to use it
> directly instead of FS_VERITY_FL will result in everything working
> correct throughout the code.

Oh I see, thanks for the explanation. They are truly confusing :( I
will adjusted it as suggested

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

-- 
- Andrey

