Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146D04D9D67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242626AbiCOOZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 10:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiCOOZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:25:08 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BCB54BE0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 07:23:56 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id kj21so12206796qvb.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 07:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xh3j/GyDKAkH+mhH+O+Z91OS2wkGYBwp1E3DXBXZ0sQ=;
        b=vs54IXrzFMB04rjiYh+EnVph2p6r9ljD49QH7XSLLzEd2GcfSE/oPlMGfqRP16ls1U
         jyejB/+sKOvGt8jBGfmuXO37gQoLXjYbBYRTvZtQ/l8hxt7D6TZP8ERqrIH2W9AtEcH6
         8ogXBjB6bpKFzQbbAbFxPF38to+nn5UOXS6t8g28SoZa97Vn8jzdJC+3KSTO1mhHEJXN
         91FbIXf7lNLJBBRqJy5ZoCzchXzvXhpmbQF2N1E1MusHL5cB3k5Y9myc5Uv3CeoXsMse
         lDCrD6W/nCnU8NfaoJMjorsOMPtL1UFP30uu4qDfayGBj19B6lWkFdTnxbO6lYnkMNv2
         nH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xh3j/GyDKAkH+mhH+O+Z91OS2wkGYBwp1E3DXBXZ0sQ=;
        b=SIGrc4U0NEYrIkARTeWRFfiqRL5e9pVnr7xwbq2oR3b5/hExC/+Kk1J4b9dwSp1I/K
         rERiog/c4WAa/mXHOKSNtUbWxLgd7mpR7ayIsjewXvY9Ixid5gQnNj3uq5XWmGvTspet
         XP8K/YMbbEHJteIJj7IEX7w/QyoYFyEerRtvbFfByLUOwg/q7z8W4krrTk5pCXgW3N1G
         1gi0KO/ZfBqvsKJ8wCHm8aa/IjME8sP77llv9vaXjywkIlG4/GoYTLAST8WWTrXUbDp5
         bjKKMOlrqy1cdzppS+49TmCY6pF7kq0XjJO2uMgU785MpDKr/pG5LEqxWgQon6pgNqc9
         bsrw==
X-Gm-Message-State: AOAM530YRddAbh9uNZBfWIm6//hJPcusaLxAhF9UXaD04IFaKGk78S7x
        2rE8V/w8Pk708RyzbtdggDXrNw==
X-Google-Smtp-Source: ABdhPJxnHgzC0C7gzo9iTAOfCmZkSMBoAOA1x3kmK2wRW/NjkyDVQjY2YzeqE/0DodKcuXil1ew5XQ==
X-Received: by 2002:ad4:5aa4:0:b0:440:ac92:53a9 with SMTP id u4-20020ad45aa4000000b00440ac9253a9mr7678194qvg.130.1647354235463;
        Tue, 15 Mar 2022 07:23:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11-20020ac85f4b000000b002e1e038a8fdsm1536037qta.13.2022.03.15.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 07:23:54 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:23:53 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-btrfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        kanchan Joshi <joshi.k@samsung.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: btrfs profiles to test was: (Re: [LSF/MM TOPIC] FS, MM, and
 stable trees)
Message-ID: <YjCheepcDh/oRp9M@localhost.localdomain>
References: <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
 <Yij2rqDn4TiN3kK9@localhost.localdomain>
 <Yij5YTD5+V2qpsSs@bombadil.infradead.org>
 <YikZ2Zy6CtdNQ7WQ@localhost.localdomain>
 <YilUPAGQBPwI0V3n@bombadil.infradead.org>
 <YipIqqiz91D39nMQ@localhost.localdomain>
 <YiwAWRRS8AmurVm6@bombadil.infradead.org>
 <Yi/FiHhw01zW2NXc@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi/FiHhw01zW2NXc@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:45:28PM -0700, Luis Chamberlain wrote:
> On Fri, Mar 11, 2022 at 06:07:21PM -0800, Luis Chamberlain wrote:
> > On Thu, Mar 10, 2022 at 01:51:22PM -0500, Josef Bacik wrote:
> > > [root@fedora-rawhide ~]# cat /xfstests-dev/local.config
> > > [btrfs_normal_freespacetree]
> > > [btrfs_compress_freespacetree]
> > > [btrfs_normal]
> > > [btrfs_compression]
> > > [kdave]
> > > [btrfs_normal_noholes]
> > > [btrfs_compress_noholes]
> > > [btrfs_noholes_freespacetree]
> > 
> > + linux-btrfs and zone folks.
> > 
> > The name needs to be: $FS_$FANCY_SINGLE_SPACED_NAME
> 
> Actually using_underscores_is_fine for the hostnames so we can keep
> your original except kdave :) and that just gets mapped to btrfs_kdave
> for now until you guys figure out what to call it.
> 

Lol you didn't need to save the name, I just threw that in there because Sterba
wanted me to test something specific for some patch and I just never deleted it.

> Likewise it would be useful if someone goees through these and gives me
> hints as to the kernel revision that supports such config, so that if
> testing on stable for instance or an older kernel, then the kconfig
> option for them does not appear.
> 

I'm cloning this stuff and doing it now, I got fed up trying to find the
performance difference between virtme and libvirt.  If your shit gives me the
right performance and makes it so I don't have to think then I'll be happy
enough to use it.  Thanks,

Josef
