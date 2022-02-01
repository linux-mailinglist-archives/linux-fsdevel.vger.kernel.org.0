Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AFB4A64C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbiBATSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:18:22 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33413 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBATSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:18:21 -0500
Received: by mail-pl1-f179.google.com with SMTP id k17so16293574plk.0;
        Tue, 01 Feb 2022 11:18:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hp34bVqoar/e3InZNjkVm77xuFkZxmxfiyCdI22uRdU=;
        b=AIccoLkHpr/RUyTWOaE6Ga4Yqn3uv2IcISGTVhQuhHBY3+D33lEARLxXtYKgKKQwdP
         cRzPK2SZE2qZqN2HI2K8rwnFppm7qIQwPhYncYlXMDF2qOIoMWg3+RkYBQNSay1XqzIm
         g5evfR4ES1cUY9uFs+8E4EU0X8BImGD8E/0L/8jsNKzy46YzJYJPvTvwkskI30ADKD4c
         efpLDo4hmI9Bz2XGg80Bv62TyrBMRHDzbGr81PGkYVc+lGHMtiHD5x8E3V994PVb0h1I
         1Wn9WGL4fQNoVYfTNl2X1dcRICmq8yVq7qGwKU9/WEk0jtXC50JYZFb7ztMn80BVhOs8
         YNCQ==
X-Gm-Message-State: AOAM531l33KSNNErN8yltwGq6Mgl+U/XqAu9OX6V816Z/S5D59OEPwL+
        EcroFvSt36ShcZeo26lfjdc=
X-Google-Smtp-Source: ABdhPJwVjQ8XwIE/Pdopyd4xqNbc3uXzt+CS6ObdWGWjnTBypf2k1gl84D5YDxPWH3xnxlch5HtAXg==
X-Received: by 2002:a17:90b:4d12:: with SMTP id mw18mr4005365pjb.104.1643743100937;
        Tue, 01 Feb 2022 11:18:20 -0800 (PST)
Received: from [192.168.51.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id ns21sm3381040pjb.43.2022.02.01.11.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 11:18:19 -0800 (PST)
Message-ID: <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
Date:   Tue, 1 Feb 2022 11:18:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 2/3] nvme: add copy offload support
Content-Language: en-US
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/1/22 10:33, Mikulas Patocka wrote:
> +static inline blk_status_t nvme_setup_read_token(struct nvme_ns *ns, struct request *req)
> +{
> +	struct bio *bio = req->bio;
> +	struct nvme_copy_token *token = page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;

Hmm ... shouldn't this function use bvec_kmap_local() instead of 
page_to_virt()?

Thanks,

Bart.
