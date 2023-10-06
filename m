Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC57BBE9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjJFSVF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjJFSVD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:21:03 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C461B6;
        Fri,  6 Oct 2023 11:21:02 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-692b2bdfce9so2125616b3a.3;
        Fri, 06 Oct 2023 11:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696616462; x=1697221262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OtIXYu6L9i6v7dxIP0nr0O3hTeG8zC59VBStGfQQ6c=;
        b=vlNr+G9oa1rrsvR9fRRHoioguIZnCqqWpsObhPFfQ23yXd9cZvdRBTDXNiAfectd6x
         H1RxNVNJfAIfcXande4wjwQubBU6R31Qw6jeg/iyjwjhLCAuilAuTom4EDUBJnWqGWM9
         3vbo4uIjsoH/7XhcqL5eEYphn7EPtbB+aJ3I8n56bqbQyj+n106dSY+A0eWGrWxuo9NB
         nPTHcUSwVdgrgIP72qWA6MmnsxWXv/eyNP4S3OUx/PK/QM/h06m7Whlb31MqsdZ+RChW
         ssWbRhLkdI4NMQ62lbViwR9zdGfcfyOMz++a79XoOKh/5CvuRobM4T8mLPas4Sb3Pksw
         KyDw==
X-Gm-Message-State: AOJu0YxNpV3q8v5dNTysnJHMCuPZPgyWNQICN0KRI4QfWIy/uTTTKptI
        VPqXH3ccYSWE5Airt6l5Mys=
X-Google-Smtp-Source: AGHT+IHcnVjDkiYwHTfF6UZFWW1RKNq+4hMXLpjwSdMzq0kNxIl+tvTbiVP2OvSjmJSATEoajdUxVg==
X-Received: by 2002:a05:6a00:b8b:b0:68f:d1a7:1a3a with SMTP id g11-20020a056a000b8b00b0068fd1a71a3amr10311311pfj.8.1696616461633;
        Fri, 06 Oct 2023 11:21:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebdb:ae30:148c:2f33? ([2620:15c:211:201:ebdb:ae30:148c:2f33])
        by smtp.gmail.com with ESMTPSA id l19-20020a639853000000b0056b6d1ac949sm3583257pgo.13.2023.10.06.11.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 11:21:01 -0700 (PDT)
Message-ID: <c3803bd0-1ef6-4409-b697-d61c8c6d3adc@acm.org>
Date:   Fri, 6 Oct 2023 11:20:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] block: Make bio_set_ioprio() modify fewer
 bio->bi_ioprio bits
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Damien Le Moal <dlemoal@kernel.org>
References: <20231005194129.1882245-1-bvanassche@acm.org>
 <CGME20231005194156epcas5p14c65d7fbecc60f97624a9ef968bebf2e@epcas5p1.samsung.com>
 <20231005194129.1882245-2-bvanassche@acm.org>
 <20231006062813.GA3862@green245>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231006062813.GA3862@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/5/23 23:28, Kanchan Joshi wrote:
> On Thu, Oct 05, 2023 at 12:40:47PM -0700, Bart Van Assche wrote:
>> A later patch will store the data lifetime in the bio->bi_ioprio member
>> before bio_set_ioprio() is called. Make sure that bio_set_ioprio()
>> doesn't clear more bits than necessary.
> 
> Only lifetime bits need to be retained, but the patch retains the CDL
> bits too. Is that intentional?

Hi Kanchan,

Yes, this is intentional.

Thanks,

Bart.


