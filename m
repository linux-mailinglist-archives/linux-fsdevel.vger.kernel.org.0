Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7965B0BDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIGRyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 13:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIGRyJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:54:09 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66138BC13A
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Sep 2022 10:54:07 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b2so11040128qkh.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Sep 2022 10:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=crsgd12kREDdn4Z5CkQitLdcfYNnDp5ExCJttsFTe6k=;
        b=2ErPJwCX+rMbrZSatsDnWhtUSmQvlTSASo3PEsIFBrcyQXZIKBcdGGc568+XposyoI
         7ZK6Aig77VkmVF2YVzQNKb2OT2BVp77cp0KsjohYGgPYm5nW+vEabEGe5eyd6zT3jcDo
         8zsmxtqjymARBDYTjcRFcN9jXyqZy22NK58/S5U7ILgxxuua80nPNutDIO2bYcB9MFGL
         1Au00coPsYik4JTafK8FKi2fixLupS3+TdFZmp+dfs+bi8u1BrgTYouG4+gMogzt+Ckw
         EsDaxqBZaVmQU1tt9VMmkYohE/DWKBoTtezqu0SgHG5J9OGGdajXyfycG1/d2R01J4yr
         GoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=crsgd12kREDdn4Z5CkQitLdcfYNnDp5ExCJttsFTe6k=;
        b=po1t3IIPJKBS4UizdO1XRB4frf7tGSVX7seA26Dzg4wC5nSAopc5KBpIUaJi3wjrNF
         Rt3B1fiJcHpiKmQL91wyrLw0yKtvi0jmkt9TIhggGYoJGoFQTGP9X9lXWHxsDWEDIa3W
         aSh/kSt9UaRBrrjPVRJiG3y41WYyhEnhrgFgc0Sk6EQHsW2h5of2AnQWUcuNG/oy/1n3
         bR4OE12DMua3NEO2BfOD5br9FuqHvptf9AmEKh4WxLog7LW0He3sc5HsmcxgKtPacoZx
         27tvEphFqcB2zHlFdBT+dI5NHAHuXeuG4FpVxTg5DyTlNHQxbVAGzS/q4Quu53IFvUhc
         vJDw==
X-Gm-Message-State: ACgBeo0GJ0aHV54TSsGe8Lr7zSzrGLkYV8OM798ssLEDltD4gBUgKpWW
        To6uH41kjkbkQLN+5kw7uwRgiA==
X-Google-Smtp-Source: AA6agR4TctpuYni4248jRQkhzrm1mMLjp3gL4Iz3UzzJvaigtRN3Bu7t2yYY+5JZ1peZFLqxKsq//g==
X-Received: by 2002:a05:620a:2453:b0:6c5:8569:771e with SMTP id h19-20020a05620a245300b006c58569771emr3419894qkn.45.1662573246392;
        Wed, 07 Sep 2022 10:54:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n15-20020a05620a294f00b006b942f4ffe3sm15723871qkp.18.2022.09.07.10.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:54:05 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:54:04 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/17] btrfs: move repair_io_failure to volumes.c
Message-ID: <YxjavEPSjFK/BqoN@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-4-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:02AM +0300, Christoph Hellwig wrote:
> repair_io_failure ties directly into all the glory low-level details of
> mapping a bio with a logic address to the actual physical location.
> Move it right below btrfs_submit_bio to keep all the related logic
> together.
> 
> Also move btrfs_repair_eb_io_failure to its caller in disk-io.c now that
> repair_io_failure is available in a header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
