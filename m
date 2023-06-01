Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6147191D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 06:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjFAE0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 00:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFAE0h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 00:26:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586AA107
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 21:26:36 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-530638a60e1so384068a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 21:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685593596; x=1688185596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH54ZfR07bvx2it5kMbT2XCoKq4FYr76emvIl28NWxo=;
        b=XboIlDk6Glckt0sGHOtjbw6iiPKyy3vUg0ctkhF0OKTH2CIPL7wBwcdMMK9gWQNfX7
         12wjr48MrbLmZPXhqx6s/hmcAY+vKX0027Sh8qUOS0Xh8BOpfAlEoIxdHBfNd5jzbEKw
         e+6pfHEO2OpXvwHCA7ZjasUfm8+D6I2fd2yZ6XLBxLVjLscZyucIUDh4Ydks3vK9XC4f
         TaiAk0Rbskf4ZlMxfrDHQaUqeeQUVXUJBTKxnxguxWjQMrGrbp8VWeZyIbzF40zH4YU3
         9Zx+fWIQv0ERI7wQudqS9d1ttQ/nZcQWf9kOw8V0bB/EgKGKbGVx0zQOgtawjec2gHoC
         vSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685593596; x=1688185596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH54ZfR07bvx2it5kMbT2XCoKq4FYr76emvIl28NWxo=;
        b=lyQHhAXFmYbhV0GwJqa9wfjgG1Tczs3u2VD2umn5QJR2lLRIcoaz3L0ghEAnETwimR
         NWou9zVCpmlwZOh197pmRI+LE6ipPde726CISH9DHQy3/GHS5FOGcFGq8oHIyV+meGFz
         Tq8ww2FMohlyhsNChf9STINpE1AqTZrgmMmvMn/DmMU2ifbY9pnnC8SrZljDLP7tBF4h
         v80lNI2iwzxVvKhd90qz/LpGR1zUAUyKwdAyuMIuCE4/N9LRFWg+m4zCMpfUpp8wIcMc
         IFu6Km+7elitq3AderMyoKyINpHFb4snKQRhGIPkcNzEKBM7wBIfC6ehSdjkMzfGCULH
         5GVQ==
X-Gm-Message-State: AC+VfDza67VHWxw8qlSV1n6BkMUAJBJMpWRXKptymFD53a0hMjNiZoN7
        pPeqsf/o6Z0Zrq8UJhysLftphw==
X-Google-Smtp-Source: ACHHUZ6hlZU/MsjoyVz4yyhoe997V/qcrYIwn3uWW59qEXQKN9Rt7VfRZ5XiA6hG1XPeblBFMsaoCQ==
X-Received: by 2002:a17:902:724c:b0:1af:b9ed:1677 with SMTP id c12-20020a170902724c00b001afb9ed1677mr6568666pll.2.1685593595885;
        Wed, 31 May 2023 21:26:35 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b001a980a23802sm2281781pln.111.2023.05.31.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 21:26:34 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4ZtQ-006NBe-17;
        Thu, 01 Jun 2023 14:26:32 +1000
Date:   Thu, 1 Jun 2023 14:26:32 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com
Subject: Re: [PATCH v7 19/20] fs: iomap: use bio_add_folio_nofail where
 possible
Message-ID: <ZHgd+G7/gg0uOGMF@dread.disaster.area>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
 <58fa893c24c67340a63323f09a179fefdca07f2a.1685532726.git.johannes.thumshirn@wdc.com>
 <ZHfMC86ktyLtIxNb@dread.disaster.area>
 <20230601042021.GA21768@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601042021.GA21768@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 06:20:21AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 08:36:59AM +1000, Dave Chinner wrote:
> > We lose adjacent page merging with this change.
> 
> This is only used for adding the first folio to a brand new bio,
> so there is nothing to merge with yet at this point.

Ah, sorry, missed that. Carry on. :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com
