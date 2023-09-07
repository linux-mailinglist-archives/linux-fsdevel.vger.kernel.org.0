Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1140B79748B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjIGPjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 11:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbjIGPXS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EFA197;
        Thu,  7 Sep 2023 08:23:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f3975ddd4so833304a91.1;
        Thu, 07 Sep 2023 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100192; x=1694704992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OZ0CpUOcPuxcuBRABu/k9kg3Q8DjApWrdkW9McQp5wM=;
        b=p2vudTLuncPRSqqNwbqQ/SsZJgMWJLDsCdiC4qlc9+z27cAoYRrl76lW0ct53nB8uB
         s0y6ujrhdTwUh8Shcf5KwdOFv/gDYiNEBWCmXWRJ7t5zFB971AD2zq37ZtzLqHhu/Ofq
         5qNCAmwuBNe7z9mj+UGyARurEJxSZZyqIra0NtPM3jHnA13AyVn1mrQpi/2Z5aBER+ys
         zCKHX3tvZPUnnjNBJNJB14yBC2MO+3GyW1+9hP/P3ERJBWYqpAD2aS2JtEMA5gtp87iD
         I5XAb86bbCUC1e4+hUU6B7hueawiRc1CmKIFuarG5zAC7w/7uY0C+CXdPcgpdoo8y2OZ
         wpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100192; x=1694704992;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZ0CpUOcPuxcuBRABu/k9kg3Q8DjApWrdkW9McQp5wM=;
        b=BiPA9QsY+k2rYB0PQ03VWOhmj7v8Ac9MupD9GeRM+qJ2LJcPtLeS7PvYc6hHur5law
         IF+N25bzlDr1oJcta4oGleD6N0hM2SreweVLtCAyHHAIM+Z3pp5P9P7cGpfgPb2pzDgo
         6EU0lp8/IeUicFTV5ohrSDeJk/AvJI2N7YNRPVZqSSis0npeTsk/d+kterqo1iR0Cy2i
         5OoPQOaYW0HHSv+wFEh7D9sx+hs94znu7nrUBHe0FljBXFlr1Mopi1djokDqNYclUPWN
         /Wwx72yDjXRucUd/hrAxkcvKqXtF+uJteRfncsWDmLOECPzaX0TYtDRGS+TPmYu642fi
         jcFA==
X-Gm-Message-State: AOJu0YysWe+05Lg4A3WwoqQuFWmt9zPIOCdrqoqso5A20ovXTKxCHEGW
        uabGZqelzjHoLB9nvbv19PNaLUTSwM4=
X-Google-Smtp-Source: AGHT+IFwNcs9Ljydqg3D8vQKhkC795cu5TrIekXRsrD/qAZOZq6eizQDLVHH9eoXr/ABjeBeoLRMHw==
X-Received: by 2002:a17:90a:5d0b:b0:273:4944:2eba with SMTP id s11-20020a17090a5d0b00b0027349442ebamr17410965pji.40.1694100192395;
        Thu, 07 Sep 2023 08:23:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ga18-20020a17090b039200b00262eb0d141esm1611029pjb.28.2023.09.07.08.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 08:23:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dc4b7b2c-89c0-d16f-43e2-0aec5c9b8e1b@roeck-us.net>
Date:   Thu, 7 Sep 2023 08:23:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 13/13] ntfs3: free the sbi in ->kill_sb
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
References: <20230809220545.1308228-1-hch@lst.de>
 <20230809220545.1308228-14-hch@lst.de>
 <56f72849-178a-4cb7-b2e1-b7fc6695a6ef@roeck-us.net>
 <20230907-lektion-organismus-f223e15828d9@brauner>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230907-lektion-organismus-f223e15828d9@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/7/23 06:54, Christian Brauner wrote:
> On Thu, Sep 07, 2023 at 06:05:40AM -0700, Guenter Roeck wrote:
>> On Wed, Aug 09, 2023 at 03:05:45PM -0700, Christoph Hellwig wrote:
>>> As a rule of thumb everything allocated to the fs_context and moved into
>>> the super_block should be freed by ->kill_sb so that the teardown
>>> handling doesn't need to be duplicated between the fill_super error
>>> path and put_super.  Implement an ntfs3-specific kill_sb method to do
>>> that.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>>
>> This patch results in:
> 
> The appended patch should fix this. Are you able to test it?
> I will as well.

Yes, this patch restores the previous behavior (no more backtrace or crash).

Tested-by: Guenter Roeck <linux@roeck-us.net>

I say "restore previous behavior" because my simple "recursive copy; partially
remove copied files" test still fails. That problem apparently existed since
ntfs3 has been introduced (I see it as far back as v5.15).

Thanks,
Guenter

