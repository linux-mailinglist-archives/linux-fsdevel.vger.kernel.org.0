Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30667B7214
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 21:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbjJCTwb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbjJCTwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:52:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DBE93;
        Tue,  3 Oct 2023 12:52:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-327b7e08456so1368704f8f.2;
        Tue, 03 Oct 2023 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696362746; x=1696967546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGvbcU4evdPhE8iD+CAmE+ISh81ZLVdJetADKqCwGtI=;
        b=PbytnJl5mtAyvS14O54oCwDtqsSFIllnGzOamC9GsDxySE1ECpLUGNcwslgnHpOQqU
         Em3yyIQUYPjoLyoKFF5RP22ufcPcZmm/yiHbRLJ8KdYqrTRVcRMgTNNmdYCZyS1VQPPT
         1yOhqCxelDXsXWTN6yuCDKG9rOj/EKk43WNtCfJphyjcvgUU7IgMl5lQbn6sIqQ8/KuB
         zwUVflkhms1AC1EZxuztcfB5tZD/5xz3ygZkvcF5UmPoCb+3jR0RgXBMfeV1sQQODM9g
         0N1HsOqSHzR2lpFI/tzm24ENhg1acKGBa2pfzqbep9S7Gc4Kp326a979COMpU9IF16zc
         agJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696362746; x=1696967546;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGvbcU4evdPhE8iD+CAmE+ISh81ZLVdJetADKqCwGtI=;
        b=UoKEcN6je4SaRXxa+Z9q1xOHWXMTZtcNqJqfAvVhlegJUkXFB75NZsAB23v8Eymb9n
         KAmBHLOpE1DLoxmUR1S2HnmAifIgpu27XBAb58MqICwJeilhp2MbH9HGX0goPeiQ9BoG
         4sFgL+XAbyoBh7UhwJPIkdMnVTMshQEJqaAU8p9W3YdNWPhfzS2EsYPi1TGjAUDSSX3h
         hT23teqitZnsCaAT1CjIm69kqRfma6fw19DKwgctV9wIymGUpKUD9F+PG7Q7u64ntXRk
         uRGSKvC/ZKl0PLYA7M0AEcgKkz3c4f3BYeBAZXx52Odu/CQgZqDQzAm5ybIYPk9c2fBm
         0Z5g==
X-Gm-Message-State: AOJu0Yzg9NL2mzvSIvdUP8IYh55aya3rrve9PqaL+Of8tsM/C+ItEP5c
        FKXXd09Kf+04e+wqPiy7ziQ=
X-Google-Smtp-Source: AGHT+IFc5DKAVdvvnMKAbV3yTqkpBKWzgGin1SS+L3YArAnuoHR5ECozV6H8lJD+nMwjfYyf0gJ4DA==
X-Received: by 2002:adf:ed52:0:b0:31f:fa1a:83fb with SMTP id u18-20020adfed52000000b0031ffa1a83fbmr243934wro.7.1696362746060;
        Tue, 03 Oct 2023 12:52:26 -0700 (PDT)
Received: from ?IPV6:2003:c5:8703:581b:e3c:8ca8:1005:8d8e? (p200300c58703581b0e3c8ca810058d8e.dip0.t-ipconnect.de. [2003:c5:8703:581b:e3c:8ca8:1005:8d8e])
        by smtp.gmail.com with ESMTPSA id k13-20020a5d628d000000b0031f34a395e7sm2267975wru.45.2023.10.03.12.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:52:25 -0700 (PDT)
Message-ID: <0c4b2871-2240-d2ab-1d69-4180910c8f1d@gmail.com>
Date:   Tue, 3 Oct 2023 21:52:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/13] block: Restore write hint support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-5-bvanassche@acm.org>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230920191442.3701673-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.09.23 9:14 PM, Bart Van Assche wrote:
> Cc: Christoph Hellwig<hch@lst.de>
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>

Reviewed-by: Bean Huo <beanhuo@micron.com>


