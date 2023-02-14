Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E986970B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 23:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjBNW0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 17:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBNW0I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:26:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E93C0D
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:26:07 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id bx22so16448444pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 14:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fT7g2wL7HeV8NqtQRuy1JY99lFDtyRbvhw2bdDBnmAI=;
        b=gW6KmkNlIgZJoiwmNpG0y+C/I6D/5bISMwX1SFAraxy5u/aFz4QpTQuRyhB94AfYLi
         12iy3B7xCfHN0bX3pIRSSfT0oilJV8guoHtEH1C2t2EuWkFw/LvUfdIAWQ/6gLGGCY8M
         ts65yKOJGj8QQ/G5OfxDI08OcP0dbFGULaCLIEQO4XofdBaYHz3KiEHs7YgurFdf6gr1
         e2Y2jPCz2euUi8d4529Bjh5Df84JXEs8cKvDbGl6DrLXJJVlC9/FZBqhISe8nFk8XHlK
         PS70FiUpMsRD4pe5mfMaR+j/CcdxbWK/h4AenD23Nm4H3hzoSQSXI9XJJ5uZ+Pc7DHkG
         TifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fT7g2wL7HeV8NqtQRuy1JY99lFDtyRbvhw2bdDBnmAI=;
        b=sjw4Afeojnc0VBOFzicxlJHupQ4+6SfREFBG4nEBikyJH86wnqMY4C8ApS1MlPhAJQ
         wPP1U7ODbqhyHYH1VIIXVHXmyY45spF7i2FANopeQpU1ykJxpA2bAhVPd5o0b1fOdCHG
         5Kl6mkSVSU2a55k4pm+56KkF7gruUg2rneFT4Z6tizFNixrl+XJrSPC7EwVbaLtf3hUc
         EASJmJb0ocfdlopn8+12qNF3Q7f/NoegUhzq7jASFvYfKa9UXJP54awKQBSuT07bv/9u
         jXEznIU4xkSVTgrMoNF8JLN1lG1k29ZBh4cPffKW2v9POPhbACdpeqSl6jPXqvuEWpl+
         UMhA==
X-Gm-Message-State: AO0yUKW3qawUYOzhvepRcrhKmc+9Bn5/3AkpgmXu3UC/mR2CizOvxglm
        UIYrkr2QaledW5onV8x+5kEWUo8mINXwKFTs
X-Google-Smtp-Source: AK7set+HXmZ2Qs+OPPZJDAvMHg6Pzqm7TNsETvrujLhZQJE7EA+2IuUtOXkophoef2keb87fgYg/zg==
X-Received: by 2002:a05:6a20:4405:b0:bd:a50:e274 with SMTP id ce5-20020a056a20440500b000bd0a50e274mr4771918pzb.28.1676413566915;
        Tue, 14 Feb 2023 14:26:06 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id f24-20020aa78b18000000b0058e1b55391esm10507929pfd.178.2023.02.14.14.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:26:06 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS3kQ-00FN52-Gb; Wed, 15 Feb 2023 09:26:02 +1100
Date:   Wed, 15 Feb 2023 09:26:02 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: failed delalloc conversion results in bad
 extent lists
Message-ID: <20230214222602.GN360264@dread.disaster.area>
References: <20230214055114.4141947-1-david@fromorbit.com>
 <20230214055114.4141947-3-david@fromorbit.com>
 <Y+tCn8owdne7Cbfg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+tCn8owdne7Cbfg@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:13:19AM -0800, Christoph Hellwig wrote:
> On Tue, Feb 14, 2023 at 04:51:13PM +1100, Dave Chinner wrote:
> > index 958e4bb2e51e..fb718a5825d5 100644
> > --- a/fs/xfs/libxfs/xfs_bmap.c
> > +++ b/fs/xfs/libxfs/xfs_bmap.c
> > @@ -4553,8 +4553,12 @@ xfs_bmapi_convert_delalloc(
> >  		 * should only happen for the COW fork, where another thread
> >  		 * might have moved the extent to the data fork in the meantime.
> >  		 */
> > -		WARN_ON_ONCE(whichfork != XFS_COW_FORK);
> > -		error = -EAGAIN;
> > +		if (whichfork != XFS_COW_FORK) {
> > +			xfs_bmap_mark_sick(ip, whichfork);
> > +			error = -EFSCORRUPTED;
> > +		} else {
> > +			error = -EAGAIN;
> > +		}
> 
> The comment above should probably be expanded a bit on what this means
> for a non-cow fork extent and how we'll handle it later.
> 
> > +	if (error) {
> > +		if ((error == -EFSCORRUPTED) || (error == -EFSBADCRC))
> 
> Nit: no need for the inner braces.
> 
> >  
> > +		/*
> > +		 * If the inode is sick, then it might have delalloc extents
> > +		 * within EOF that we were unable to convert. We have to punch
> > +		 * them out here to release the reservation as there is no
> > +		 * longer any data to write back into the delalloc range now.
> > +		 */
> > +		if (!xfs_inode_is_healthy(ip))
> > +			xfs_bmap_punch_delalloc_range(ip, 0,
> > +						i_size_read(VFS_I(ip)));
> 
> Is i_size_read the right check here?  The delalloc extent could extend
> past i_size if i_size is not block aligned.  Can't we just simply pass
> (xfs_off_t)-1 here?

Probably, we just killed all the delalloc blocks beyond eof via
xfs_free_eofblocks() in the line above this, so I didn't seem
necessary to try to punch blocks beyond EOF for this case. Easy
enough to do to be safe, just need a comment update to go with
it....

Cheers,

Dave.
> 
> 

-- 
Dave Chinner
david@fromorbit.com
