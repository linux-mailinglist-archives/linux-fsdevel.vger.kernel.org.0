Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17C662B5C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 17:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjAIQh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjAIQh6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAC5FCA
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 08:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673282232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CaUmCofw67cYQpW+1L+v6UW3vJNvAD0zWauvjW5LLKI=;
        b=GBllzLLdgJuSP1Pk41woHEThBW80tANZIMHckIX0TRBoPeLUl3R/ZJelNqY2A+AFEuhjtv
        2AOhWVOP0aKmOJbQF2JvvSLPJ4rdCFTk9CwKhg3ihXHQ5uAytJw2J5nfNDfxFirY/MTp7q
        +hfJlMTQFPdlIvLWGUmq2oZnmqtAqls=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-482-amnhgN3pP_KOWF_5wBgohQ-1; Mon, 09 Jan 2023 11:37:11 -0500
X-MC-Unique: amnhgN3pP_KOWF_5wBgohQ-1
Received: by mail-ed1-f70.google.com with SMTP id q10-20020a056402518a00b0048e5bc8cb74so5647179edd.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 08:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaUmCofw67cYQpW+1L+v6UW3vJNvAD0zWauvjW5LLKI=;
        b=hPZjslY2gHh4F2DbUF7oPDyPKEUMU0CAIFN9nUUPiAAocLWBpLgCwhHSRs9nttUs02
         lIProR9pKfLb8XJn38BKdWAVwuqdD8k7g2Ly0gAEnq306sAs3qi5M9JICPQiFKTuMdIq
         yIoXbKGE0qLGXt69IfFXu6I+v9cxXFw/A/F2aA2FaUqVb4BX//M7eD2VRR86pOzoqQTW
         Iv2SQsZBs55qp+Aph73XK/VBPNILnUVTfdjJ6fYSBhKR0vYCNojhAkDPTjAS3Ek7eswp
         FzTdCPIwMUyUXfGWNecCRTu2MzYxZYGE17PYjURztyeCg81qvDyV7CiPWdGnhjKepE5/
         HfZQ==
X-Gm-Message-State: AFqh2ko64RT8MRMPtb3vxAZTd8wVhojzG23deYZgZKBf24MBcsVkANNv
        QZJwNs5RT0Goa+ga+0LLhHPONIM6LlycL4uYtwWLzwOq3nAQLOpxSmSqBjaVkTrLaGe0QG8SWYa
        SEyh1FAdf2x+L6iAWNx8Y+nL4
X-Received: by 2002:aa7:d281:0:b0:499:1ed2:6456 with SMTP id w1-20020aa7d281000000b004991ed26456mr5206895edq.22.1673282229972;
        Mon, 09 Jan 2023 08:37:09 -0800 (PST)
X-Google-Smtp-Source: AMrXdXscVCOYigmRoHTWb4vV/saLzV6ZfpNcVMsmtVCVgTbBhRfilAfUqkF4N52m/GSBKWuNy7yTow==
X-Received: by 2002:aa7:d281:0:b0:499:1ed2:6456 with SMTP id w1-20020aa7d281000000b004991ed26456mr5206889edq.22.1673282229825;
        Mon, 09 Jan 2023 08:37:09 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7de82000000b004972644b19fsm3706906edv.16.2023.01.09.08.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:37:09 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:37:07 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Eric Sandeen <sandeen@redhat.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] xfs: add attribute type for fs-verity
Message-ID: <20230109163707.v2c5vet2c4qkqegn@aalbersh.remote.csb>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-4-aalbersh@redhat.com>
 <733b882c-30fc-eea0-db01-55d25f272d92@redhat.com>
 <20221214010356.GC3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221214010356.GC3600936@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 14, 2022 at 12:03:56PM +1100, Dave Chinner wrote:
> On Tue, Dec 13, 2022 at 11:43:42AM -0600, Eric Sandeen wrote:
> > On 12/13/22 11:29 AM, Andrey Albershteyn wrote:
> > > The Merkle tree pages and descriptor are stored in the extended
> > > attributes of the inode. Add new attribute type for fs-verity
> > > metadata. Skip fs-verity attributes for getfattr as it can not parse
> > > binary page names.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > 
> > 
> > >  DECLARE_EVENT_CLASS(xfs_attr_list_class,
> > > diff --git a/fs/xfs/xfs_xattr.c b/fs/xfs/xfs_xattr.c
> > > index 5b57f6348d630..acbfa29d04af0 100644
> > > --- a/fs/xfs/xfs_xattr.c
> > > +++ b/fs/xfs/xfs_xattr.c
> > > @@ -237,6 +237,9 @@ xfs_xattr_put_listent(
> > >  	if (flags & XFS_ATTR_PARENT)
> > >  		return;
> > >  
> > > +	if (flags & XFS_ATTR_VERITY)
> > > +		return;
> > > +
> > 
> > Just a nitpick, but now that there are already 2 cases like this, I wonder
> > if it would be wise to #define something like an XFS_ATTR_VISIBLE_MASK
> > (or maybe XFS_ATTR_INTERNAL_MASK) and use that to decide, rather than
> > testing each one individually?
> 
> Seems like a good idea to me.

Agreed.

> 
> There's also a couple of other spots that a comment about internal
> vs externally visible xattr namespaces might be appropriate. e.g
> xfs_attr_filter() in the ioctl code should never have internal xattr
> namespaces added to it, and similarly a comment at the top of
> fs/xfs/xfs_xattr.c that the interfaces implemented in the file are
> only for exposing externally visible xattr namespaces to users.

Thanks, will describe that.

> 
> That way it becomes more obvious that we handle internal vs external
> xattr namespaces very differently.
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

