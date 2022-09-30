Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D45F0835
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 12:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI3KD6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 06:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiI3KD4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 06:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D72CE2CCE
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664532230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhJIFR3fLJdqOld3QNolz1hk+UXzk/h1s0G3zuVG5hU=;
        b=bVPAf4m6ka4WcLROJ5NU4Am3B0qTqbVgb0aHPJuzvaZstsgaV28GF9araxqFB7CgNjM8MM
        zeykR/Zq936yqKEiAZKckGGtCDifopqSPARvQa83hLA5BkutySciZNdg9Xio5ioSqhvHlA
        zigPLx9+5NWwsvIextCSdYYzM/vN770=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-_17oygTJOSymY6NwoIZxcg-1; Fri, 30 Sep 2022 06:03:49 -0400
X-MC-Unique: _17oygTJOSymY6NwoIZxcg-1
Received: by mail-wr1-f69.google.com with SMTP id q10-20020adfaa4a000000b0022cd70377e4so1377682wrd.19
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 03:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YhJIFR3fLJdqOld3QNolz1hk+UXzk/h1s0G3zuVG5hU=;
        b=BOQyBKO+jy9heE1vKQoQ0wNdP7ga/8sQhO/v3xRmWn+KduPVhUjAbppJN/1Xm93PWv
         N5iV5vHf1RSkHHWf7VPaE/Q1N27SG7f5HfyL9IUECHvdgA2KLIE4MWVB1idqtJ5789Bh
         fIGpwwUn1vRj7meO1OV2qCndm4anMwVOMJjC59sqWkQ4a2v0mZRKCILMjBVMlAKZZi3g
         RVnK7BuALqjHyt0mBS8hbJFvx5R+UKgwqolBZMTnHUztBEUHkwWysbtndtuBwtHF0UUv
         TAGUWTweD+d1rnJDa+6gJdyqdw8LQml9S4grnanRKJI6pU3MXEZAhkQZamdpfo+5Zzq4
         7ztg==
X-Gm-Message-State: ACrzQf3aCiJmkuX1Gs2JIUZLTduCgMd78qAX4a1dLySFaRHLtceo2TVe
        Gb5S/HwovTPzn0loBo3FScrU7FziBFuCYWvhd9q45oEPneTaNfhv9sfnByXTI+l2xtvGVw9W1Yy
        dIqrK3EmxmV/lyS+Ik7yZ1uHByQ==
X-Received: by 2002:a5d:5050:0:b0:22c:dbba:9ab1 with SMTP id h16-20020a5d5050000000b0022cdbba9ab1mr3989760wrt.341.1664532228258;
        Fri, 30 Sep 2022 03:03:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4lFa0FA2LLQPcNHZK1xjaF9GOjVJHBq44rmZCMIpQnmGgzw1L9Qmsr0Xfzv3TQBCyEA3JmCg==
X-Received: by 2002:a5d:5050:0:b0:22c:dbba:9ab1 with SMTP id h16-20020a5d5050000000b0022cdbba9ab1mr3989736wrt.341.1664532228029;
        Fri, 30 Sep 2022 03:03:48 -0700 (PDT)
Received: from [192.168.100.81] (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm6715940wmh.23.2022.09.30.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 03:03:47 -0700 (PDT)
Message-ID: <532d3039-464f-d527-c13a-c614e3787f0c@redhat.com>
Date:   Fri, 30 Sep 2022 12:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] exfat: use updated exfat_chain directly during renaming
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20220608020502epcas1p14911cac6731ee98fcb9c64282455caf7@epcas1p1.samsung.com>
 <20220608020408.2351676-1-sj1557.seo@samsung.com>
 <1ec3ff28-04e7-1b31-5cb0-fd0fde8f582c@redhat.com>
 <CAKYAXd8peY3zNz8QyVp=8s2B5EqhBxkOwYA4ZHWAZqs7xFt3cw@mail.gmail.com>
From:   Pavel Reichl <preichl@redhat.com>
In-Reply-To: <CAKYAXd8peY3zNz8QyVp=8s2B5EqhBxkOwYA4ZHWAZqs7xFt3cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 9/30/22 11:13, Namjae Jeon wrote:
> 2022-09-30 18:00 GMT+09:00, Pavel Reichl <preichl@redhat.com>:
>> On 6/8/22 04:04, Sungjong Seo wrote:
>>> Fixes: d8dad2588add ("exfat: fix referencing wrong parent directory
>>> information after renaming")
>> Hello,
>>
>> I just wonder, since the fixed patch had tag: 'Cc: stable@vger.kernel.org'
>> should this, fixing patch, go to stable as well?
> It was well applied into stable kernels although stable tag was missing.
Oh, OK, thank you!
>> Thanks!
>>
>>

