Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95A452CB18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 06:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiESE25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 00:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiESE2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 00:28:54 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B221BC03B3;
        Wed, 18 May 2022 21:28:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id y13so6822333eje.2;
        Wed, 18 May 2022 21:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YVivavOUL0ESIMZFNZScTS19Sf8/enmueYLabJ2OE/Y=;
        b=CBornHqjfnGVwj5upL0hltJQXF12obal81yYfJNKbTJCwtF1I/4zscM+3sx4zH0ryJ
         oxK3yzvveydI6GKDDqmaSZKqBToSz8haEzOLpf268lYy9YNEXOVEwsRcO/Mlm3QBh87u
         KmX8n6lJEAm/JPxvk4+D4UfSoQ7CwDDV1UOuPNy8qcPA8IRP34RnNIIrmhSsPhA9I47q
         rTRzDEo0jFcU/qOuxWpsLT2ijubwfMsw16ZAElfV8okh0GKqrmd2ZhnY5RFx+k4UibOf
         Ep5m/bU+PsDanxusmt8Z2dDDsoabZeVWfkZjnrTV86mNCZrBKit5GWinEy05jj8Z7xYP
         vtgA==
X-Gm-Message-State: AOAM530mzrCKOK5kSfd3TOZ957LuGbCyQbzV8fcU9Aofks2ZZXxBsBNj
        0xK6I6nlg7VKDLI5L9NEchQ=
X-Google-Smtp-Source: ABdhPJzXxQYKbFgoabOZaX/s0jFlh6Qe1bCTr8yivdy0VI4mQ0BqjcpdFza+l8OONL0UjyyjAcvynw==
X-Received: by 2002:a17:906:6a16:b0:6f4:63ae:76c with SMTP id qw22-20020a1709066a1600b006f463ae076cmr2422674ejc.705.1652934530204;
        Wed, 18 May 2022 21:28:50 -0700 (PDT)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id eo20-20020a1709069b1400b006f3ef214e58sm1651339ejc.190.2022.05.18.21.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 21:28:49 -0700 (PDT)
Message-ID: <a6fc5d6a-1426-7832-0118-349206c7b13b@acm.org>
Date:   Thu, 19 May 2022 06:28:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv2 1/3] block/bio: remove duplicate append pages code
Content-Language: en-US
To:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        damien.lemoal@opensource.wdc.com, Keith Busch <kbusch@kernel.org>
References: <20220518171131.3525293-1-kbusch@fb.com>
 <20220518171131.3525293-2-kbusch@fb.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220518171131.3525293-2-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/18/22 19:11, Keith Busch wrote:
> +	for (left = size, i = 0; left > 0; left -= len, i++) {
> +		struct page *page = pages[i];
> +		bool same_page = false;
> +
> +		len = min_t(size_t, PAGE_SIZE - offset, left);
> +		if (bio_add_hw_page(q, bio, page, len, offset,
> +				max_append_sectors, &same_page) != len) {
> +			bio_put_pages(pages + i, left, offset);
> +			ret = -EINVAL;
> +			break;
> +		}
> +		if (same_page)
> +			put_page(page);
> +		offset = 0;
> +	}

Consider renaming 'same_page' into 'merged'. I think that name reflects 
much better the purpose of that variable.

Thanks,

Bart.
