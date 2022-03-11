Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE5E4D5E00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiCKJAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 04:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243644AbiCKJAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:00:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8A1BB70E
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 00:59:28 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so17662910ejb.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 00:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G64fpheblSLP81xsfCcTMm/w43U6C4+OfpzMU4aumxM=;
        b=bcJcncRtBIs509i0VHLbfp7JvFTQqdmuWL67LnKnpkjYBZX6w8sBnx2452CLVTnMXo
         IKUWhehLe84pMDIQidNxt8g8sjHQCDAXb4fBVrB2Zdq9cqh9vN8TOHHhKZrBGJuEVI0Z
         Q54eH18VG7lb+hTmvW+zPVfTf4t3itb9zRMqS+yIRAQO7T4Q+Xnwu+9CF0Vl6inAWUMd
         FSY3aLV0Si8EWz5e3aPw5EbmiDM9MJr2qsvthGpCLxdPRWaRlvsNbNYiKTMdSfUrdnt5
         V/WC7ZXsvCiEG89fGqU15ZF7TF5iGTMqPaBHlKZrdn+yDeH/hE/Ve2DtRO8lApJJSfmc
         U/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G64fpheblSLP81xsfCcTMm/w43U6C4+OfpzMU4aumxM=;
        b=WsJQSc3rdDfAobx2t0R86AoAXvAk9tfXhFgJRR+dwgi1xReW6HRmrp251I60ghV2s/
         z9VVv4bGA2WfnYTPhuVSZ1dBi+wvSda0E+hgim7BXwq+XiXFUxDy82qHLxq0jk26v9uj
         jBrqxzvnr6i0SSeCiQNxc3ossWrwFYKqp/nbo+/ApThlZbaKZCeDcKJTtCLRv3m7eKmd
         6tSu8CsWr9MNKEBpi0Chsk4xgjmc7oxew8O7kmkabWax2J4jh1DAFhgdsqSomUPpdEar
         z8H1o6Cv6e1TGDh81cQ+ZwHqYl9jYUdx1Z3oM3RBTdt0FZo4RkbWlJWlXaZYUL36ofNa
         +gBQ==
X-Gm-Message-State: AOAM530SXTScqe7+2LrE89KJBlFzQQtAnnTvLdcvq42qbK20/p+R0Aly
        JCZwVFdo3Jc2wyNrt8/tO0sVgQ==
X-Google-Smtp-Source: ABdhPJyac4jXH7dT28BK3Z9Zkjxoc1MPNtVDYQV0VUf2kAKjcdr/4vp+AKTfrAUKQoO8NWSrVr47Og==
X-Received: by 2002:a17:907:3d86:b0:6db:9d9e:e470 with SMTP id he6-20020a1709073d8600b006db9d9ee470mr2767730ejc.373.1646989167197;
        Fri, 11 Mar 2022 00:59:27 -0800 (PST)
Received: from localhost (5.186.121.195.cgn.fibianet.dk. [5.186.121.195])
        by smtp.gmail.com with ESMTPSA id w12-20020a17090649cc00b006d0bee77b9asm2724958ejv.72.2022.03.11.00.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:59:26 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:59:25 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <keith.busch@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <20220311085925.c66kly5zy6otgcer@ArmHalley.local>
References: <69932637edee8e6d31bafa5fd39e19a9790dd4ab.camel@HansenPartnership.com>
 <DD05D9B0-195F-49EF-80DA-1AA0E4FA281F@javigon.com>
 <20220307151556.GB3260574@dhcp-10-100-145-180.wdc.com>
 <8f8255c3-5fa8-310b-9925-1e4e8b105547@opensource.wdc.com>
 <20220311072101.k52rkmsnecolsoel@ArmHalley.localdomain>
 <61c1b49c-cd34-614a-876a-29b796e4ff0d@opensource.wdc.com>
 <Yir9a8HusXWApk5l@infradead.org>
 <20220311075317.fjn3mj25dpicnpgi@ArmHalley.local>
 <YisMUruNKNlV8FhW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YisMUruNKNlV8FhW@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.03.2022 00:46, Christoph Hellwig wrote:
>On Fri, Mar 11, 2022 at 08:53:17AM +0100, Javier González wrote:
>> How do you propose we meed the request from Damien to support _all_
>> existing users if we remove the PO2 constraint from the block layer?
>
>By actually making the users support it.  Not by adding crap to
>block drivers to pretend that they are exposing something totally
>different than what they actually are.

Ok. Is it reasonable for you that we start removing the PO2 check in the
block layer and then add btrfs support? This will mean that some
applications that assume PO2 will not work.

	Damien: Are you OK with this?

We can then work on other parts as needed (e.g., ZoneFS)
