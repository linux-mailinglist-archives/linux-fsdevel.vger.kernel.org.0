Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E6552C74D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 01:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiERXGy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 19:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiERXGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 19:06:52 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F810149173;
        Wed, 18 May 2022 16:06:51 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id f10so3500090pjs.3;
        Wed, 18 May 2022 16:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M2OU/ev/wtDvqHYNj5hP9zKluj3H/LLJ6QYPls9G5Tw=;
        b=She1oSRkXAOR2vDYrAltVV/WB7OxYOBeezghF/surT4V49JqBCK9Nh/jSmT8WqsquH
         7W6X8Jf+MKZfvjkXW3wVAjITl9fhJhtC+L+4dpkUvApsFZeyDnxT18dYRubYRRVTrBL7
         BN2UbupOH3kN1JjNdoLa9w/S+E1YS0vxSYJUY938W4hxOgRH0IqlvxGOwhdLHbJWYJQj
         rsfaAQVJz9FY/gXNt2XBQDPE92DpqgCshwTEz+W98ALbI6eWdmQmwrIsvx8fp2vKUNHA
         dM3w9iMxU9a3hLr5n9/eKj8JbYWxCOioFOi6zYowocS4h2MbZa5SS1fLSymGij4O/DmJ
         Edcg==
X-Gm-Message-State: AOAM533NybFLfg2ehZTJbYlNPlb4sJ+1RExNY12cBNfWio6Cu7+LGqeU
        5IEOwkiXieziWpob0glETJI=
X-Google-Smtp-Source: ABdhPJxrRrwxuaXVXZU5unUYT2Wp/ah35BZYv61mf/nd9Yr//ww7daRstQvEvrGocfyzbj6E/VCrbQ==
X-Received: by 2002:a17:90a:9282:b0:1dc:4a1b:ea55 with SMTP id n2-20020a17090a928200b001dc4a1bea55mr1854383pjo.24.1652915210525;
        Wed, 18 May 2022 16:06:50 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
        by smtp.gmail.com with ESMTPSA id t1-20020a17090340c100b0015e8d4eb271sm2130390pld.187.2022.05.18.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:06:49 -0700 (PDT)
Date:   Wed, 18 May 2022 16:06:46 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        pankydev8@gmail.com, gost.dev@samsung.com,
        damien.lemoal@opensource.wdc.com, jiangbo.365@bytedance.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned devices
Message-ID: <20220518230646.5xx6dpo4helwyqcv@garbanzo>
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
 <20220516165416.171196-1-p.raghav@samsung.com>
 <20220517081048.GA13947@lst.de>
 <YoPAnj9ufkt5nh1G@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoPAnj9ufkt5nh1G@mit.edu>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 11:34:54AM -0400, Theodore Ts'o wrote:
> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
> > I'm a little surprised about all this activity.
> > 
> > I though the conclusion at LSF/MM was that for Linux itself there
> > is very little benefit in supporting this scheme.  It will massively
> > fragment the supported based of devices and applications, while only
> > having the benefit of supporting some Samsung legacy devices.
> 
> FWIW,
> 
> That wasn't my impression from that LSF/MM session, but once the
> videos become available, folks can decide for themselves.

Agreed, contrary to conventional storage devices, with the zone storage
ecosystem we simply have a requirement of zone drive replacements matching
zone size. That requirement exists for po2 or npo2. The work in this patch
set proves that supporting npo2 was in the end straight forward. As the one
putting together the BoF I can say that there were no sticking points raised
to move forward with this when the topic came up. So I am very surprised to
hear about any other perceived conclusion.

  Luis
