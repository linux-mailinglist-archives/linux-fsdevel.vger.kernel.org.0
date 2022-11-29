Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEDC63C754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 19:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiK2SoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 13:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236151AbiK2SoF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A0BFD04
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 10:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669747390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xrzLVG1k5EnBtphk2uFVHERYEn0Mr4MkJDkjcj5T9h4=;
        b=hscTqsdZVe/d1T+joo6zbVXuKecLhgL23pOjvwAKXDYpCXQ62BvXpHtGg/U5F/dIHqqVx2
        eiHViVMTnd/pasoOALr8DVuzKFMM2ySszT5ButR+RW54kJ1XDpZ0TivisHee3kUjZQjrhA
        +qHAqUtNdg3KDOQH8E1pKqcJldXWWWg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-u-qaFgypOfWg8pcUrceDgw-1; Tue, 29 Nov 2022 13:43:08 -0500
X-MC-Unique: u-qaFgypOfWg8pcUrceDgw-1
Received: by mail-qk1-f198.google.com with SMTP id bp11-20020a05620a458b00b006fc8fa99f8eso6756343qkb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 10:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrzLVG1k5EnBtphk2uFVHERYEn0Mr4MkJDkjcj5T9h4=;
        b=zEz+8enTHYUIJwveK+ngVeEsYupycV/MWJFwNVnfUvsn3gpiZfKjRK353JJJxxctkw
         ohOnDQfkQgcYozJEOBuUm3M91XKgX7PyfqT1Bo6KoYLs0WnYdRq2dprBbR4UfAaju1Ul
         LWey5w8kIEaWa/XgL8Ggfjb4H/L2OIdtgTREQwykoresFzG35OxjBZnUJisfdLXJU1h8
         f0ah63n4mqnIVuPk/Vc9zXe4V6j5EQjYVPkDxlxl46dVJvNDXx3DJMDoCrP0xS3Sd3I5
         1ywbUnCQULUuquEPAZJTr+woamT7xNDbCASxrSrWHWfiSoNG50KGD1zHk0vMt74+tq/K
         nLSQ==
X-Gm-Message-State: ANoB5plp+DOJRP+aQsp30+LYkT5nu5U93ixRBlQftusaXiJYfFwMo/jG
        tJVUfuhlCT7a9FEflQ9fNhywg23E6p5t4NfeGzRja05gXagzHEKm+BP8NH10HcO2u0OuDJCl4RB
        SYMZOAYg1qwVRIYNzQLXkttYWeA==
X-Received: by 2002:a05:6214:3804:b0:4c6:a8f1:8a1c with SMTP id ns4-20020a056214380400b004c6a8f18a1cmr36707861qvb.93.1669747387797;
        Tue, 29 Nov 2022 10:43:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7YkONDHOKsKocqr1O0t98DPzC0rnu0Ht4Nf6n8BGBvgDGC4uKC53l0ZKbVrU/0YXQdRY8xIA==
X-Received: by 2002:a05:6214:3804:b0:4c6:a8f1:8a1c with SMTP id ns4-20020a056214380400b004c6a8f18a1cmr36707840qvb.93.1669747387514;
        Tue, 29 Nov 2022 10:43:07 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id g4-20020ac870c4000000b003992448029esm8946444qtp.19.2022.11.29.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 10:43:07 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:43:13 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/remap_range: avoid spurious writeback on zero length
 request
Message-ID: <Y4ZSwUj0eGjnDBMT@bfoster>
References: <20221128160813.3950889-1-bfoster@redhat.com>
 <Y4TubQFwHExk07w4@magnolia>
 <Y4XtL9SzQN/A4w5U@bfoster>
 <Y4ZNDTC8rL0f9WE+@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4ZNDTC8rL0f9WE+@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 10:18:53AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 29, 2022 at 06:29:51AM -0500, Brian Foster wrote:
> > On Mon, Nov 28, 2022 at 09:22:53AM -0800, Darrick J. Wong wrote:
> > > On Mon, Nov 28, 2022 at 11:08:13AM -0500, Brian Foster wrote:
> > > > generic_remap_checks() can reduce the effective request length (i.e.,
> > > > after the reflink extend to EOF case is handled) down to zero. If this
> > > > occurs, __generic_remap_file_range_prep() proceeds through dio
> > > > serialization, file mapping flush calls, and may invoke file_modified()
> > > > before returning back to the filesystem caller, all of which immediately
> > > > check for len == 0 and return.
> > > > 
> > > > While this is mostly harmless, it is spurious and not completely
> > > > without side effect. A filemap write call can submit I/O (but not
> > > > wait on it) when the specified end byte precedes the start but
> > > > happens to land on the same aligned page boundary, which can occur
> > > > from __generic_remap_file_range_prep() when len is 0.
> > > > 
> > > > The dedupe path already has a len == 0 check to break out before doing
> > > > range comparisons. Lift this check a bit earlier in the function to
> > > > cover the general case of len == 0 and avoid the unnecessary work.
> > > > 
> > > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > 
> > > Looks correct,
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Should there be an(other) "if (!*len) return 0;" after the
> > > generic_remap_check_len call to skip the mtime update if the remap
> > > request gets shortened to avoid remapping an unaligned eofblock into the
> > > middle of the destination file?
> > > 
> > 
> > Looks sensible to me, though I guess I would do something like the
> > appended diff. Do you want to just fold that into this patch?
> 
> Yes, could you fold it in and send a v2 with my rvb on it, please?
> 

Sure. I'll change both lines to do 'if (ret || *len == 0),' not sure why
I didn't do that the first time..

Brian

> --D
> 
> > Brian
> > 
> > --- 8< ---
> > 
> > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > index 32ea992f9acc..2f236c9c5802 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -347,7 +347,7 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> >  
> >  	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
> >  			remap_flags);
> > -	if (ret)
> > +	if (ret || *len == 0)
> >  		return ret;
> >  
> >  	/* If can't alter the file contents, we're done. */
> > 
> 

