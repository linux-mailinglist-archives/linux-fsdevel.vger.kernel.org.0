Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B27B6EB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjJCQkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjJCQkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:40:52 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859E9E;
        Tue,  3 Oct 2023 09:40:48 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5859b1c92a0so766480a12.2;
        Tue, 03 Oct 2023 09:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351248; x=1696956048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JjOvJviiB1YciK0Ddc9QDsHo4Z5SKKOd0Z6vFwPd3F0=;
        b=dWUI+17qhVseS7J/8c5pjmtE7oyRUpjocvEUfwIWcoa2XGWIRPCiQb+8bRYY78ftzZ
         CpCtM46irOd/CCkoJ7BOLl7WCr8xzQ2dRfMEXEdRlO/dXObk4/u82NRISrLFtHVAQrZb
         4OlMaPTMZryUI0WkyALOmcYPUYl4gaZX4DpkExS2R5EB6gYP41gOWjotWQsZ/DiUtM3k
         rCisJctOBMygucjBVkiLaUIIYGlxX8BRxfRCY2sTOXbklpQyu3vJbyUVPjDS0oLCGhuH
         qXWFZ9ZtWopLzm3qf8zymXh1Ve72I497A0oED1nCLmNaVcBW801oU6DNffAX+lPsbWJb
         Cekg==
X-Gm-Message-State: AOJu0Yxo5x1WS3Tzkn99Ln20YmBCHe5KCps59fSQ84UtOLy96Qxaruth
        kRFWaFFpL1JrtOC4mLgHeOs=
X-Google-Smtp-Source: AGHT+IEkJC0j4q3G/j/OwL01WVjZmfBkxBT8BYOG8ftBNdCmA9VmlrrpSaGbeLg8MIWvhWr115Wo0Q==
X-Received: by 2002:a05:6a20:6a23:b0:160:57a6:7eea with SMTP id p35-20020a056a206a2300b0016057a67eeamr17004575pzk.37.1696351247970;
        Tue, 03 Oct 2023 09:40:47 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001c41e1e9ca7sm1790448plz.215.2023.10.03.09.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:40:47 -0700 (PDT)
Message-ID: <7f031c7a-1830-4331-86f9-4d5fbca94b8a@acm.org>
Date:   Tue, 3 Oct 2023 09:40:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] block: Add atomic write operations to request_queue
 limits
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-2-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-2-john.g.garry@oracle.com>
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

On 9/29/23 03:27, John Garry wrote:
> +What:		/sys/block/<disk>/atomic_write_unit_min_bytes
> +Date:		May 2023
> +Contact:	Himanshu Madhani <himanshu.madhani@oracle.com>
> +Description:
> +		[RO] This parameter specifies the smallest block which can
> +		be written atomically with an atomic write operation. All
> +		atomic write operations must begin at a
> +		atomic_write_unit_min boundary and must be multiples of
> +		atomic_write_unit_min. This value must be a power-of-two.

I have two comments about these descriptions:
- Referring to "atomic writes" only is not sufficient. It should be
   explained that in this context "atomic" means "indivisible" only and
   also that there are no guarantees that the data written by an atomic
   write will survive a power failure. See also the difference between
   the NVMe parameters AWUN and AWUPF.
- atomic_write_unit_min_bytes will always be the logical block size so I
   don't think it is useful to make the block layer track this value nor
   to export this value through sysfs.

Thanks,

Bart.
