Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2FB550BF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiFSPxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiFSPxR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:53:17 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733710C5
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:53:16 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l4so8166980pgh.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jun 2022 08:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=pcdkkdhylXdNDYjASHj+IxOzRhQzZK0Fy/BFW8dN5rk=;
        b=W1wu9MZc/dVoeDAZlO1HvocrK+1DKEeOo0DL/4oKaCCrMJuVMP/7+kY4jj8ct6ToMh
         r8hXhuCGmMSj5hh0kyWpgRJDTSEQsSWCmeaMNAls9sOUaNT5f3pH0FFWZXr0DZy450Ji
         LcYymwdbBjtXnzno25Ekc1v+l9eerTd0VWvvrHa/gZiftBhWAMh6fKn7TEn18ZmExHMJ
         vndCTsc6T/Cxm4KCVRp5xyIIOCAKayJdh+OpdOxyW7qbQNV4Q9BxpqmFsmfnv928Z/YP
         rzh83EFQNVfNvwa4J0x0gNprIYVgVWWuLkvkLpUC8jWnM/2DoFB+9eTw0wbVOJDVsuxY
         9Ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pcdkkdhylXdNDYjASHj+IxOzRhQzZK0Fy/BFW8dN5rk=;
        b=Vqgn+Ss52lrm6b64yUDfnGDiuiVEbL8xZUAAYGmB34f2C04+m7NxPcMjys3xLMrgfW
         D/MyGjA6l2NHf8fo3KifrPWihgha1JQPxurE6r0rU91Eu6mQm8x0ZY9k9iHhgB/08M4+
         KxF5gIa5m3GPoyNnVVMO+j6pvDmX2LFEqNiaEF5rKzMJYskI3Cipwv30ZuHyEUXnBxbQ
         tZhjeLMIOjYLoJdTeUs3OrzPUgoeOJcSjjS62o5ugRiFqJ65lo3dPfftePPfj79MXgrM
         7jc5TTWKJyXbmbW9839EpvfoCn+anT9Ty9W71xyXdhTMLtwlnUGfyMca0Npr+lLX8e38
         agWA==
X-Gm-Message-State: AJIora8rCTLoHwdW85tNxev5K9XiLqPqjmLFm2Y4qOmn2OINIkR90oqo
        IbO/RldfoNh7Gt2Bj6IP5RHoOQ==
X-Google-Smtp-Source: AGRyM1t7t1ctbg5vI2AWUL2u+lxDQyS35Mj++5R+9/KYxh1cgAHYdKD8zgUe2YnRPRZMMXmum8lS0g==
X-Received: by 2002:a05:6a00:2444:b0:4fd:db81:cbdd with SMTP id d4-20020a056a00244400b004fddb81cbddmr20005379pfj.32.1655653996202;
        Sun, 19 Jun 2022 08:53:16 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s12-20020a63b40c000000b0040bc900d7aesm7013653pgf.35.2022.06.19.08.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jun 2022 08:53:15 -0700 (PDT)
Message-ID: <d539e911-50e2-da05-a8b9-b4fd541e7f9d@kernel.dk>
Date:   Sun, 19 Jun 2022 09:53:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] fs: use call_read_iter(file, &kiocb, &iter); for
 __kernel_{read|write}
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>, Li Chen <me@linux.beauty>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
References: <18179f8b59d.b7fe20f5281387.193977444358758943@linux.beauty>
 <Yq8+Bya1HMJ+KtNC@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yq8+Bya1HMJ+KtNC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/22 9:17 AM, Matthew Wilcox wrote:
> On Sat, Jun 18, 2022 at 08:19:11PM -0700, Li Chen wrote:
>> From: Li Chen <lchen@ambarella.com>
>>
>> Just use these helper functions to replace f_op->{read,write}_iter()
> 
> ... why?  You've saved a massive two bytes of kernel source.
> What is the point of these functions?  I'd rather just get rid of them.

Agree, kill both of these helpers. They aren't very broadly used either.

-- 
Jens Axboe

