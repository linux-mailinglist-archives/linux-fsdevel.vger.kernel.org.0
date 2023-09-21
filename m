Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856ED7AA52F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 00:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjIUWkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 18:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjIUWkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:40:25 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D7B3C22;
        Thu, 21 Sep 2023 13:11:05 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c1ff5b741cso12529355ad.2;
        Thu, 21 Sep 2023 13:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695327065; x=1695931865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqLUJredNWFn6UV9EpZQHzPOud7X+d09rY2QfVP8FfM=;
        b=hB++SQVsehyjfHesltdoKUlix0BRL+fSqltcUJUpDSz0hE4z2v3h17Yn7tT5cr6eA4
         fuxNjGLSy15TF9h0wRHOCgBrbR3VARg4ovhRmzamN9unix/8twLGHTd9GHnI7N/6WovJ
         UnqaY+TPIyI6Xcnq5IMeiNQVQP6CDlH9CcGNvMy8sNMClDxphv4nOrJ6Jt2YFavfOJ8Z
         UJskvTvezFck9oe5WxqPB35kkemR6pAYN/PeiJrRAbZ+O8UbkN8Fl1/RjLvWki88AIXw
         jhfjlr6uaP3kfYE1KkZamw8j1iHv9cgta24m/z7pOq3HB6cNv2fKt3Tvg5AugJ9Q2ZED
         Nzow==
X-Gm-Message-State: AOJu0YxBLOJG1vJoR1s1nW2IErM/uppeLm8s2GLWT0YTmGH7jkAS4yZy
        kXre58vLoAksw15UZAOLYZc=
X-Google-Smtp-Source: AGHT+IE4uBXaKeNClIyeQxDM3JodKlX79G3w3w9XgQ/pS0vx9mNOOgruGpeL+ibjNdK7nkmnSAy4Ag==
X-Received: by 2002:a17:902:82c3:b0:1c3:f745:1cd5 with SMTP id u3-20020a17090282c300b001c3f7451cd5mr6113963plz.34.1695327065034;
        Thu, 21 Sep 2023 13:11:05 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6903:9a1f:51f3:593e? ([2620:15c:211:201:6903:9a1f:51f3:593e])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b87bedcc6fsm1922245plh.93.2023.09.21.13.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 13:11:03 -0700 (PDT)
Message-ID: <e547d35e-856b-4d0e-a77d-7f37fad3dde5@acm.org>
Date:   Thu, 21 Sep 2023 13:11:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Bean Huo <huobean@gmail.com>,
        Bean Huo <beanhuo@iokpp.de>, Avri Altman <avri.altman@wdc.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Luca Porzio <lporzio@micron.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <ZQtHwsNvS1wYDKfG@casper.infradead.org>
 <1522d8ec-6b15-45d5-b6d9-517337e2c8cf@acm.org> <ZQv07Mg7qIXayHlf@x1-carbon>
 <8781636a-57ac-4dbd-8ec6-b49c10c81345@acm.org>
 <ZQyZEqXJymyFWlKV@casper.infradead.org>
 <4cacae64-6a11-41ab-9bec-f8915da00106@acm.org>
 <ZQydeSIoHHJDQjHW@casper.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZQydeSIoHHJDQjHW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/21/23 12:46, Matthew Wilcox wrote:
> If vendor support already exists, then why did you dodge the question
> asking for quantified data that I asked earlier?  And can we have that
> data now?

 From Rho, Eunhee, Kanchan Joshi, Seung-Uk Shin, Nitesh Jagadeesh 
Shetty, Jooyoung Hwang, Sangyeun Cho, Daniel DG Lee, and Jaeheon Jeong. 
"{FStream}: Managing Flash Streams in the File System." In 16th USENIX 
Conference on File and Storage Technologies (FAST 18), pp. 257-264. 
2018: "Experimental results show that FStream enhances the filebench 
performance by 5%∼35% and reduces WAF (Write Amplification Factor) by 
7%∼46%. For a NoSQL database benchmark, performance is improved by up to 
38% and WAF is reduced by up to 81%." Please note that these results are 
for ext4 instead of F2FS. The benefit for F2FS is probably smaller since 
F2FS is optimized for NAND flash media.

I have Cc-ed open source contributors from multiple UFS vendors on this 
email and I hope that they can share performance numbers for F2FS.

Thanks,

Bart.

