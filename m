Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8287B392E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjI2Rvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 13:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjI2Rvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:51:49 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E69C1B0;
        Fri, 29 Sep 2023 10:51:47 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-68bed2c786eso11747107b3a.0;
        Fri, 29 Sep 2023 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009907; x=1696614707;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2/eTj4ZTeW96Njy5Yu8y4iGoVQL5PWTi4ftqXgho1g=;
        b=QUxaK+xX2mybE4Jo8Y7ulUTnBoN+v47Fj5sH1LWxj2kR+QzDeDkI+zjQF9rXoswxkY
         baZNOkWT3ewYzpsgmb7fHRwauT5kvXZW3d/BoL2KOLS5zuDIayAKzte200Xvd9YVfeAv
         CAVc+QNk62vfB/YLvC8cpOEy9L7kakOLWHe/S+ZpzubB1aWRm58Zo9KiO9QzauLginp6
         Xwr9ae3f6CZlqM1akmuzu6P69bYVy55HCMW1z/7SB8mds9YhqJYNzMBfI91RKQG3WXI4
         lGSSJogUSt4LZ0PbQVwENFhMuNroibNA86fH8uWhrA0NfrZTV9OTpM/gHhL7iUaqL9nb
         O4IQ==
X-Gm-Message-State: AOJu0YwpMMzy4Vp6z4LplMGggDEWsFGhosNfgh69qCLf19FIV0BFtdlQ
        GB2Dqfp13dvfnDoE6udRLWM=
X-Google-Smtp-Source: AGHT+IGOOjLnU6w2a9/rCpNU/gUfKj+HX8K9T3Khoyfb1oo9lzEzxrnEv7Kr7MNDQD94unm8RFU33Q==
X-Received: by 2002:a05:6a20:548f:b0:161:28e0:9abd with SMTP id i15-20020a056a20548f00b0016128e09abdmr5716860pzk.16.1696009906659;
        Fri, 29 Sep 2023 10:51:46 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001c73d829fb0sm2953239plb.32.2023.09.29.10.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 10:51:46 -0700 (PDT)
Message-ID: <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
Date:   Fri, 29 Sep 2023 10:51:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] block: Add fops atomic write support
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-11-john.g.garry@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-11-john.g.garry@oracle.com>
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
> +	if (pos % atomic_write_unit_min_bytes)
> +		return false;
> +	if (iov_iter_count(iter) % atomic_write_unit_min_bytes)
> +		return false;
> +	if (!is_power_of_2(iov_iter_count(iter)))
> +		return false;
[ ... ]
> +	if (pos % iov_iter_count(iter))
> +		return false;

Where do these rules come from? Is there any standard that requires
any of the above?

Thanks,

Bart.

