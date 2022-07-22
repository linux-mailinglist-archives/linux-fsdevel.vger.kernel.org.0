Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6CA57E938
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 23:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbiGVVxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVVxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:53:32 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35222BCE;
        Fri, 22 Jul 2022 14:53:29 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id pc13so5411341pjb.4;
        Fri, 22 Jul 2022 14:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/9ILdx708OW7jSObyY5pa58AA+3as2Qya1907y+8fL0=;
        b=H9ikxUJKrPhugOMnYgtnDupbCgm5NXC3aH66OLJm4oksO1RA8EnNZ2oam5Gpux5sEc
         Ow+ujqBVDbZcZNSSC6iIiDDJB9VQO8lwz1tRiSSUDE8+JsrjzOd3yKouhNiMjgmwSIsS
         dT+PYLZmelujqDprGloPofmThIn/HGYLr2K79kbCMOMlqBumK707xZsU9YlNqbXxpUOE
         OhpmIr0PmqBXaQeqyyh1MAaDl11vfXkmjCs2OTs84nAKnVM28Dh54YGW00178a5Q6Kxh
         blzf8pz6UtuSE3TNjPbqBs80B2GeZy255P3hjC3lGrku6Dl5zASoDlXk98b6gZU1MVsf
         bvrQ==
X-Gm-Message-State: AJIora9052eoeEc9h8DGOe54jIOd5bZveEzamoMiMXXikUuqUCWhx11u
        X0Su071jJalbFBN0iMQdHt0=
X-Google-Smtp-Source: AGRyM1t7imcNuYeIaEv8vICLeZiQnBr59yZPN4mi226Jb3Z9WZnCpwK2veWClFg5W6B+PlhOsRs3ZA==
X-Received: by 2002:a17:90b:4a4d:b0:1f2:5211:e8d6 with SMTP id lb13-20020a17090b4a4d00b001f25211e8d6mr1739197pjb.96.1658526808447;
        Fri, 22 Jul 2022 14:53:28 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:805b:3c64:6a1f:424c? ([2620:15c:211:201:805b:3c64:6a1f:424c])
        by smtp.gmail.com with ESMTPSA id z2-20020a1709027e8200b0016b8b35d725sm4262422pla.95.2022.07.22.14.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 14:53:27 -0700 (PDT)
Message-ID: <ccad8981-cf10-c332-8129-e881096949bc@acm.org>
Date:   Fri, 22 Jul 2022 14:53:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv6 05/11] block: add a helper function for dio alignment
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-6-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220610195830.3574005-6-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/10/22 12:58, Keith Busch wrote:
> +static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
> +			      struct iov_iter *iter)
> +{
> +	return ((pos | iov_iter_alignment(iter)) &
> +	    (bdev_logical_block_size(bdev) - 1));
> +}

A nit: if you have to repost this patch series, please leave out the 
outer parentheses from the return statement. Otherwise this patch looks 
good to me.

Thanks,

Bart.
