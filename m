Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC3611F8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 05:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ2DGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 23:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJ2DFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:05:54 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8613B983;
        Fri, 28 Oct 2022 20:05:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b29so6265505pfp.13;
        Fri, 28 Oct 2022 20:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOsckJ5PfexfpxOh25NE4KUZFMDcjmqpw0ICdOEl0VY=;
        b=UTEz3B7YLUBgwzUTik6VGJr2kM9SSlawzxdXhRCjbktjOPb2awA9sj2J3amJUWFX+7
         mT0NUpEt8eTx+844NG2FS7D5d6qB8VlBcTHslA4DXcR1kZ4JTI3Td3+7zylvb789nx+w
         kWmM2yLiMJh4CcNvDq6YQJdOH3ZH+cu8Z5qyYA1yObmpND15o5UN2hLPBWTW4zZoYG5Z
         U//nA7n1rhrN8r18DoKXz3gDdbvznyr4ZRyn7140rp8X2y91UFUhG2SIEydNVDbxXoNC
         n2JeCWI/Ff/sE/4BFaH211uMIBOK0ia4fekOk5vrn6ERD0e6yjeMpKwFJ2hOnLeKxhdy
         WNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOsckJ5PfexfpxOh25NE4KUZFMDcjmqpw0ICdOEl0VY=;
        b=YBzMi6t/rPLZy0EyK9PHzZiOVFR68+CGIx6/fK/BF0f0z7PZ574Z8oDuiJ94WgQRcv
         xrbwA2QgZ0GlsGaRtlVUTLWiB/GZT46oK3bTWz5wZEYN8FagthK5RlUi9Tzdip/v4Hgy
         P9jVh7yk0Uzbz0O7bEQA5/IZNZ6RtSxPDkhivD5SqcpLAwEOrg1EKAQ6ZhmWcqqQsa9o
         ITdEDhERGxs1oIA2Q50yql6knUtuqhgRImDakdxF87QIQOJO0/UkrXzbr0Tl2w2tt3O3
         hIQxhgXz+J89TMfjfZ5jWu+TD5XdHb52fjsLzJTBTSSYVbvrcZ/aTI6T5Ny80TZAmoxw
         t/ww==
X-Gm-Message-State: ACrzQf1pEfTwIOdIraKljRT07UET40B1wRDpr3gbRGpVYskitdsxo4wN
        81Vh5uG9xsfAI7RDlobrxPM=
X-Google-Smtp-Source: AMsMyM6eVg3yN2qF7v5ZhwkqhnR3TQLFI3m7L1d0hEmgQykC+d8Tj3IoSrMc8qmTe+lY3FhKsuGQXA==
X-Received: by 2002:a05:6a00:3391:b0:56c:1494:6ea4 with SMTP id cm17-20020a056a00339100b0056c14946ea4mr2261933pfb.73.1667012743062;
        Fri, 28 Oct 2022 20:05:43 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902ec8500b0016c0c82e85csm181921plg.75.2022.10.28.20.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:05:42 -0700 (PDT)
Date:   Sat, 29 Oct 2022 08:35:38 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221029030538.s6j6olqyno32mnrh@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <Y1vOTsRzI0GMosaN@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vOTsRzI0GMosaN@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/28 01:42PM, Matthew Wilcox wrote:
> On Fri, Oct 28, 2022 at 10:00:33AM +0530, Ritesh Harjani (IBM) wrote:
> > @@ -1354,7 +1399,8 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	 * invalid, grab a new one.
> >  	 */
> >  	for (i = 0; i < nblocks && pos < end_pos; i++, pos += len) {
> > -		if (iop && !test_bit(i, iop->state))
> > +		if (iop && (!test_bit(i, iop->state) ||
> > +			    !test_bit(i + nblocks, iop->state)))
> >  			continue;
> >  
> >  		error = wpc->ops->map_blocks(wpc, inode, pos);
> 
> Why do we need to test both uptodate and dirty?  Surely we only need to
> test the dirty bit?  How can a !uptodate block ever be marked as dirty?

Yes, you are right. We don't need to test uptodate bit. 
In later revisions, I will correct that.

> 
> More generally, I think open-coding this is going to lead to confusion.
> We need wrappers like 'iop_block_dirty()' and 'iop_block_uptodate()'.

Sure. Make sense. Thanks for the suggestion.


> (iop is still a bad name for this, but nobody's stepped up with a better
> one yet).

Looks fine to me :)

-ritesh
