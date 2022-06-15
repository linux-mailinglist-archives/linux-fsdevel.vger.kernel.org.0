Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D9154C94B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 14:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiFOM6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 08:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242450AbiFOM6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:58:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F311AF2C
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655297880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fSDv3pB77XuzeUNZezPJm4SyZkEnyUHPf0B4cMPJ4cY=;
        b=ghoXTDPx56NxAF4oO5V4sVahozeFzpt5bRKZE9UHCvuvDiptg+xMjnebwWKTWdHJxf72Hg
        2P8cjJMTJF3eGIM4hGnj92c0PyssqIPZYOxYZE0FE7cP+Yja2AWyO3MElFsLtR+3ZiHLum
        wHNeUR7F455YD1p5UytXTj7sfbmTTKo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-PAP_tR3aMR-0ta0PbGIVyQ-1; Wed, 15 Jun 2022 08:57:59 -0400
X-MC-Unique: PAP_tR3aMR-0ta0PbGIVyQ-1
Received: by mail-qk1-f198.google.com with SMTP id az18-20020a05620a171200b006a708307e94so9963757qkb.14
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 05:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSDv3pB77XuzeUNZezPJm4SyZkEnyUHPf0B4cMPJ4cY=;
        b=e+2lojAGpj5hjiiri6vZu2I5YfMBZKLAQY0R5878m+w7psG7s4PolFfViJw6PiAICw
         FLhP8vEcJhnwP3jLEnnywMoeURG883upkZdZlUdLF8kV5Qof0gH6mg4P/B+l2F7Kzixh
         /DNLWJJBJQtGS1DTAgdqS8DVIXjo00ojvkboDpETBp4AtcnkxJ4o9XR+b8RCSogm2wjv
         0+1PupQzQupki1FAVddccStt2wP6XzZd2HukZfAzpLZtj28v4V9qkV38oMvkvbIPShRj
         Dv/Xj2Hl/VpxvA5SFKv2qeXcVC5fd5HfNvNC+XzhTN+wgKtsGt8IfAL46a4C2suoRIaM
         hENA==
X-Gm-Message-State: AJIora+AeA7gft/u1haCSIKUrEuohO4VKE/SazzsMh0BsNxuYl+2dB9p
        fX6US+zYDZFK213Qxth2ct3QoOfvf2V+5jD1Ss+10K4uarqiUi2luOVdtrALw/+PYnbx/1M4sge
        uIqZLHsvxKYHP78nOEu8HLUATBQ==
X-Received: by 2002:ac8:5805:0:b0:306:7772:286f with SMTP id g5-20020ac85805000000b003067772286fmr99494qtg.402.1655297878610;
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCeCN28ZKU6d+OG8D7NjHn3G2vBu6R1QHB/HUCDHsoF3WNAM7jk+5+GNqy/PBi6xXTshARZQ==
X-Received: by 2002:ac8:5805:0:b0:306:7772:286f with SMTP id g5-20020ac85805000000b003067772286fmr99485qtg.402.1655297878383;
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id f8-20020a05620a408800b006a77e6df09asm10746678qko.24.2022.06.15.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:57:58 -0700 (PDT)
Date:   Wed, 15 Jun 2022 08:57:56 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YqnXVMtBkS2nbx70@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqm+jmkDA+um2+hd@infradead.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:12:14AM -0700, Christoph Hellwig wrote:
> On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
> > The IDR tree has hardcoded tag propagation logic to handle the
> > internal IDR_FREE tag and ignore all others. Fix up the hardcoded
> > logic to support additional tags.
> > 
> > This is specifically to support a new internal IDR_TGID radix tree
> > tag used to improve search efficiency of pids with associated
> > PIDTYPE_TGID tasks within a pid namespace.
> 
> Wouldn't it make sense to switch over to an xarray here rather
> then adding new features to the radix tree?
> 

The xarray question crossed my mind when I first waded into this code
and realized the idr tree seems to be some sort of offshoot or custom
mode of the core radix tree. I eventually realized that the problem wrt
to normal radix tree tags in the idr variant was that the tag
propagation logic in the idr variant simply didn't care to handle
traditional tags, presumably because they were unused in that mode. So
this patch doesn't really add a feature to the radix-tree, it just fixes
up some of the grotty idr tree logic to handle both forms of tags.

I assume it makes sense for this to move towards xarray in general, but
I don't have enough context on either side to know what the sticking
points are. In particular, does xarray support something analogous to
IDR_FREE or otherwise solve whatever problem idr currently depends on it
for (i.e. efficient id allocation)? I think Willy has done work in this
area so I'm hoping he can chime in on some of that if he's put any
thought into the idr thing specifically..

WRT to this series, I really don't think it makes much sense to put a
broad rework of the idr code in front of what is otherwise an
incremental performance improvement based on using a mechanism that
radix-tree pretty much already supports (i.e. tags). Is there some
fundamental problem you see with this patch that apparently depends on
xarray for some reason, or are you just calling it out as apparent
technical debt in this area of code? If the latter, then I think it
makes more sense to consider that as a followup effort.

Brian

