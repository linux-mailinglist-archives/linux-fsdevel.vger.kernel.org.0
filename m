Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4D7B71C8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 21:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjJCTdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 15:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbjJCTdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:33:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6A4BD;
        Tue,  3 Oct 2023 12:33:13 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b281a2aa94so236713966b.2;
        Tue, 03 Oct 2023 12:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696361591; x=1696966391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkslXHLDdqe/kJth9a5DbbfuzLD/lhb/E8VJPcSrJC0=;
        b=XUPLricia6l7kx2bLQEfk/Wl2pqGs5RYwe/TvsFw47kubttygG6QG+TCAcZiiChqB8
         2eTjqV15I/9Zo7DZjoUQacqwj5D7os61+8O9vt3LMMX8k1DAB7rd2x6sxgYTye4NGqSs
         vrk0tPyX4sTd/nzwwuBaLjq3ycmM2GLuvPsRgB21Ur5S9OjsCPb/N9tIRlA3Mvtl4Cet
         XW74JnzfZz+4vUOjjpH46XkUfEhPaDJJe0RSojOXH60tk8MrJkeaLuaJ6z67oERxtfYQ
         9iWTCLogqZrk24v91vsh8DvrAfIAzESb6VUzubFCpQ2j9vsm79CzjIglwiCGhXb8Mwhq
         N1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696361591; x=1696966391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EkslXHLDdqe/kJth9a5DbbfuzLD/lhb/E8VJPcSrJC0=;
        b=MjU5QMLEEz62iDqm6K+5qRM3SxccAG+Ai2mxNVlU7x3F5Pq6lV5kbfaEY071uBeb9i
         ZTASGmk84PsOimZnEDjjIJOmdbqlHTM0LMf/JX/oQdS5vqXU/Sg9xafT1nI5ecLvryoo
         3ITujprS1nHl80a+Hn9Y5I066laOar4+mrpQEsdXFXuHmWxuRudwT3Y9bI9aRLO3MvgZ
         dIvIcvxu1O5Wh4iJYvpPb/b+jXjmYkGhO3UrkjcYBrXTvPLIhg21HGg2YgltfQD0WGfI
         BN6zwVHmFWldM5gPP/M06N6KGN/TIiixGgO+XXNJ5CSl5E/K5nezsNxkPknYeU/AWoR8
         3CIA==
X-Gm-Message-State: AOJu0YxZEKDX40VSqcPpNs6cmcbwxx6Y93jjtM6j/9aHsd9mfEpuxT7S
        fnXnTbNRZ1o9VF5e5oZK2DU=
X-Google-Smtp-Source: AGHT+IGgKe563hYUHo1ADGuyIWwz1AY5awkWMy1iqDgMHqx5QyXqECYy6Am6mL23MX6XUi1d9DEU6Q==
X-Received: by 2002:a17:906:845a:b0:9ae:3fdd:4dd with SMTP id e26-20020a170906845a00b009ae3fdd04ddmr133365ejy.24.1696361591270;
        Tue, 03 Oct 2023 12:33:11 -0700 (PDT)
Received: from ?IPV6:2003:c5:8703:581b:e3c:8ca8:1005:8d8e? (p200300c58703581b0e3c8ca810058d8e.dip0.t-ipconnect.de. [2003:c5:8703:581b:e3c:8ca8:1005:8d8e])
        by smtp.gmail.com with ESMTPSA id sa18-20020a170906edb200b009adc77330ebsm1546758ejb.199.2023.10.03.12.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 12:33:10 -0700 (PDT)
Message-ID: <002b90af-5411-a493-594c-45ae8c4f164e@gmail.com>
Date:   Tue, 3 Oct 2023 21:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/13] fs/f2fs: Restore the whint_mode mount option
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-2-bvanassche@acm.org>
Content-Language: en-US
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230920191442.3701673-2-bvanassche@acm.org>
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
> Restore support for the whint_mode mount option by reverting commit
> 930e2607638d ("f2fs: remove obsolete whint_mode").
>
> Cc: Jaegeuk Kim<jaegeuk@kernel.org>
> Cc: Chao Yu<chao@kernel.org>
> Signed-off-by: Bart Van Assche<bvanassche@acm.org>

Reviewed-by: Bean Huo <beanhuo@micron.com>

