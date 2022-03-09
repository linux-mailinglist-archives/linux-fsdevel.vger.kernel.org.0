Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124CE4D3932
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 19:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbiCISuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 13:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbiCISuU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:50:20 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CE61A41CE
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 10:49:21 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 10so172854qtz.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKuE38NOU2hkJuD1KLyg6RrwTXvuKBzM+TX7qgfpuP8=;
        b=2KYwnPO4qFOzkuFk8l6tZ/PALkc6qNAlX3MSb8GTgY8sih7mjaZlG/qJTxFRrkHK5y
         pJc8cfeGCMW2cOlQxQ3sSQ++SgRe59t/U9W9ZQJMgJc16hKH/banqiqtZxbOVwZo3Qn9
         exrp/qwEfSBfRcPmsjc7SsFGn4wvMmtOQvTUJiSLLgLkoLmFTsVLWR5T/xnjuyQ7wqQ1
         /cppXhdwFnQE0n/HiLTOjiKq+KdwidZT629XBNG7Ow3Lr85NJPyZtaGJIQszEHCN9cB2
         q3qWq+8rZBhDdKOwSAmDTS17WRDsRcyDp0XjQhYd6VP8RyilPoLvKIdekMdSyd7/7NNh
         S20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKuE38NOU2hkJuD1KLyg6RrwTXvuKBzM+TX7qgfpuP8=;
        b=tPflhK/0H6P0gH7doLLuY/BDB2+D8HkseXKZZBOcSshYTAu1MS7/bwIR6SdXmGWoUu
         sdPqyH+hXeTiUob384Amz6KRvPzGwsxZ4XkJkxy7mvOUsjflFGIjboMHriIf8b1YD5Sm
         P1F2Lr/eRlrC73vCqGRc5EoaAbZPTswKv4omQwYwnts+gHHVaZT2bkuh/m6k7dETat5F
         iHEHBLZVyTyqIVdIM3c6J8/9p3u4IHSDR3GKdfUTi6NCrXLurj1tm6khJkojhmsh6Kwq
         pake8YhzCpFnIwL7jRn7w+QJitWcmisAljKLS2vd5vjRy0hL8me8joXq6TRdgN9+70NC
         3iTA==
X-Gm-Message-State: AOAM5316/L42wJO0THQwdZwmkBEzzqtPlg0wwdW5ZU2B+Xc3hFbZH0oB
        iezjuoc55Q+DxgW/IP45nLr5LQ==
X-Google-Smtp-Source: ABdhPJwZqAklp4rUS0SV8Z7S7kiKHtg7aMVBylvoMgwVlNDkmvuCWlkXtYLS2NmzoyM74vWF0JnHyw==
X-Received: by 2002:ac8:60a:0:b0:2cc:1a58:3bc0 with SMTP id d10-20020ac8060a000000b002cc1a583bc0mr960891qth.358.1646851760291;
        Wed, 09 Mar 2022 10:49:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm1328785qkb.74.2022.03.09.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:49:19 -0800 (PST)
Date:   Wed, 9 Mar 2022 13:49:18 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yij2rqDn4TiN3kK9@localhost.localdomain>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <YieG8rZkgnfwygyu@mit.edu>
 <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yij08f7ee4pDZ2AC@bombadil.infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:41:53AM -0800, Luis Chamberlain wrote:
> On Tue, Mar 08, 2022 at 11:40:18AM -0500, Theodore Ts'o wrote:
> > One of my team members has been working with Darrick to set up a set
> > of xfs configs[1] recommended by Darrick, and she's stood up an
> > automated test spinner using gce-xfstests which can watch a git branch
> > and automatically kick off a set of tests whenever it is updated.
> 
> I think its important to note, as we would all know, that contrary to
> most other subsystems, in so far as blktests and fstests is concerned,
> simply passing a test once does not mean there is no issue given that
> some test can fail with a failure rate of 1/1,000 for instance.
> 

FWIW we (the btrfs team) have been running nightly runs of fstests against our
devel branch for over a year and tracking the results.  This allowed us to get
down to 0 failures because we could identify flakey tests and fix them or simply
disable them.  Then this means when we do have one of those 1/1,000 failures in
one of our configs (I copied Ted's approach and test all the various feature
combos) we know what set of parameters the failure was on and can go run that
test in a loop to reproduce the problem.

We like this approach because it's not a "wait a week to see if something
failed", we know the day after some new thing was merged if it caused a problem.
If it's more subtle then we still find it because a test will start failing at
some point.  It's a nice balance in how long we have to wait for results and
allows us to be a lot more sure in merging new code without hemming and hawing
for months.  Thanks,

Josef
