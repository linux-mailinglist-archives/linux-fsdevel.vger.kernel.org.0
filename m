Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4C6E6F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 00:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjDRWnx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 18:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjDRWnv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:43:51 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126F4EF4;
        Tue, 18 Apr 2023 15:43:49 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1a6bc48aec8so11608935ad.2;
        Tue, 18 Apr 2023 15:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681857829; x=1684449829;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRd1Pn/ei3QfwgTQ2bN6W/oJfrlsBAZasHc6v7hkSkA=;
        b=LLwn6kx9J+JGtc7ToaBoLaY70lz6ZxTF4uM3G8B60kKnDWUubJudWPtIdlneFaveBf
         uJtG0/Pbztx8/z37HrnXXju5D1vrngnYGidlq/XTV+2WgxqZWFawHRlCWHh1AgzjFHUe
         JZR9phwdvmMRzfDAaTw/NLNbbYqRG3vJ3nizlgl0WH5YZuUs0wz/+8hKaFvldVRQoMso
         /GT00PF8KDJPQgIKaT4zezpu9yCCMs8hMfBm2euWtzmRhkGFAd1KifVXggwhe+mlcfn3
         usfqtlibiyrDUw4ZRR4ySgDKD+mPiobTQQjhBykFYryyr3/6hjH0gL5dA4jF1m/agjqI
         Gz/A==
X-Gm-Message-State: AAQBX9cZFFscto1vP+kARHPgCXlUvfOAVx/HpMuSkwpKunv3znfWM0n8
        Luqpuawx5Nx9m3hL2uatUrg=
X-Google-Smtp-Source: AKy350bwRPit77QBRyCkurpbLJcKpUzou5Ygm5yswkmtHRjJpN/wCGE3gl3bGCRqpWafsB3KLZ6hBA==
X-Received: by 2002:a17:903:32c1:b0:1a1:b656:2149 with SMTP id i1-20020a17090332c100b001a1b6562149mr4070484plr.50.1681857828891;
        Tue, 18 Apr 2023 15:43:48 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:5d9b:263d:206c:895a? ([2620:15c:211:201:5d9b:263d:206c:895a])
        by smtp.gmail.com with ESMTPSA id k5-20020a170902e90500b001a64a335e42sm10127547pld.160.2023.04.18.15.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 15:43:48 -0700 (PDT)
Message-ID: <b74cc3d8-bfde-8375-3b19-24ea13eb1196@acm.org>
Date:   Tue, 18 Apr 2023 15:43:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/4] block: Introduce provisioning primitives
Content-Language: en-US
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <20230414000219.92640-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-1-sarthakkukreti@chromium.org>
 <20230418221207.244685-2-sarthakkukreti@chromium.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230418221207.244685-2-sarthakkukreti@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/18/23 15:12, Sarthak Kukreti wrote:
>   	/* Fail if we don't recognize the flags. */
> -	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
> +	if (mode != 0 && mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
>   		return -EOPNOTSUPP;

Is this change necessary? Doesn't (mode & ~BLKDEV_FALLOC_FL_SUPPORTED) 
!= 0 imply that mode != 0?

Thanks,

Bart.

