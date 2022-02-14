Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F04B5396
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 15:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355278AbiBNOni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 09:43:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOne (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:43:34 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42284AE3A
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 06:43:24 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h6so27227632wrb.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8k2aplyYI1OYSbtp/sgTQSaIuXBRyilQhTxzdkcz5oM=;
        b=Kc2NhjEECM3Ike+mng8fkAJ0mNxNc5SBRyB1PT/O3H3V73wWQu3kwBEGUi5ElHSAO6
         q/catBw7mYZcPXvpUSNGnDCmFkfOprjpwGMz6wSXWiaoqXAACWp7PtLen87Y+bonxIN1
         43L0PWcSripPNaWQR0fPqEBkHOT6yEI9uerxrKLq7QvgKav7FpvSEmgITr/+K7GNiY7B
         iGv1xfjWwKDDpaeAFwxKWhda453SESLLxjeVVCBBsqVXsGNJhNOf5ctlwJ+geYh8BJzm
         +M1D4w1q9VU+f7mXbY+O6oCCD3RJ0jSdWtuGak4JKBjXo3YRHbJI8Le+vdXU7RVyZi3f
         3Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8k2aplyYI1OYSbtp/sgTQSaIuXBRyilQhTxzdkcz5oM=;
        b=dfCfXl2KNKxP1rDZVu61wqa8Ptu088Oz1KKhrpdZIi/QSzyopvXvl1xYt4Oeh9aAVV
         F9xF3Uo8O0Y/c+gKZzYlsEN+wGLNVwEhzjbSopKKfaODXoNg8YN1RquN1FsETgECIwPB
         vnaPV8hLJzU+WyWaVoIMOM8PSNzNoGHvGn4r2wJuLlbde/66DJj5yC739Ky1/9eTGIdf
         T61x2g7ssinMJW5A+hNM9RPM0lLtdqp3TUjN4L+BzZ0gMQgYiXoRPmBqCVX0ugWnSFMO
         DiR/cPvPpbH1UuxMQR+joHC/aOVd++2RFwqi+JIHeDfeCkjOfivUlvnOInibxSlu5Y18
         ua9Q==
X-Gm-Message-State: AOAM533egSjcdEG807OaopSJKQHNhpEehIouwh7pOGyJEkCOz5+r6HGn
        m5dWF+I++CHH05ISwLQV2fJADA==
X-Google-Smtp-Source: ABdhPJw7yRUYoEyGu9ey4dIfTWZqAtG97B1/NFiN85MQVuWJ6su5QCeF3PBi//ZfG99hTeOE+wDSOA==
X-Received: by 2002:a5d:52c9:: with SMTP id r9mr11422010wrv.449.1644849803276;
        Mon, 14 Feb 2022 06:43:23 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id o16sm12358972wmc.25.2022.02.14.06.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:43:22 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:43:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com,
        syzbot+0ed9f769264276638893@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] Revert "iomap: fall back to buffered writes for
 invalidation failures"
Message-ID: <YgpqiG7fvX7pHEHO@google.com>
References: <20220209085243.3136536-1-lee.jones@linaro.org>
 <20220210045911.GF8338@magnolia>
 <YgTl2Lm9Vk50WNSj@google.com>
 <YgZ0lyr91jw6JaHg@casper.infradead.org>
 <YgowAl01rq5A8Sil@google.com>
 <20220214134206.GA29930@lst.de>
 <YgpjIustbUeRqvR2@google.com>
 <YgpmN/R7jAf97PBU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgpmN/R7jAf97PBU@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 14 Feb 2022, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 02:11:46PM +0000, Lee Jones wrote:
> > On Mon, 14 Feb 2022, Christoph Hellwig wrote:
> > 
> > > Let me repeat myself:  Please send a proper bug report to the linux-ext4
> > > list.  Thanks!
> > 
> > Okay, so it is valid.  Question answered, thanks.
> > 
> > I still believe that I am unqualified to attempt to debug this myself.
> 
> Nobody's asking you to debug it yourself.

Not meaning to drag this out any longer than is absolutely necessary,
but that's exactly what I was asked to do.

I fully appreciate how complex this subsystem is and am aware of my
inadequacy in the area.

> instead of wasting everybody's time.

That was never the intention.

> We're asking you to file a clear bug report

No problem.  Will comply.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
