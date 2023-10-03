Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56D57B6ED8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjJCQpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjJCQpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:45:35 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49827AC;
        Tue,  3 Oct 2023 09:45:32 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so846464a91.0;
        Tue, 03 Oct 2023 09:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351532; x=1696956332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXhSrsitouTtG4jnIpF6WlTXUJWU1AdtRoPHLHegjNE=;
        b=a+dYzxhGi6fjYnt4lG8eX5xqljr9JMXZ19YT8gocz3oLqjdjQ2sHe/Xv37FIVar891
         exQrAW832r44VYRUsQjG1AMi0fmDnQx+byRNwe8/I8FOILjowEp6crsMO8RVKuc7s+Je
         aWkUDp9AbZHhCCcJhPsG7yuk9UkWsjJIzASWw79hGwOJSmsihY+cVXfZzBYoiBjmM/Ml
         d4r1Oqh1Z6xo4P9jm5Jt0oeW3t43DMmiBtb26ZRfVpXs8e3/ka8gctHLP/SxRRwYbu8V
         EqwsyYbOwXJQfe24rXal4h4ryqvg6LWI8fkauHBWwAyPrqy5chnhFZkW7Sbcztfha/+K
         KIRQ==
X-Gm-Message-State: AOJu0Yz68YL6vC0tgX0ecrTPfuDk9I0Snl28UQwjZDUcaM+JU7yJ19C0
        pxOrFYHrimB1Ekz09gNvWvo=
X-Google-Smtp-Source: AGHT+IEwC8qVv1+tkY+wONdL32+rPKEpsbXoCH+j3Wnz44caGKeaCpNY+K3ZBdFDu5Ezk2vd0L3+eQ==
X-Received: by 2002:a17:90a:5d18:b0:26b:4a9e:3c7e with SMTP id s24-20020a17090a5d1800b0026b4a9e3c7emr14066923pji.4.1696351531639;
        Tue, 03 Oct 2023 09:45:31 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:fc96:5ba7:a6f5:b187? ([2620:15c:211:201:fc96:5ba7:a6f5:b187])
        by smtp.gmail.com with ESMTPSA id e59-20020a17090a6fc100b0026b70d2a8a2sm1719463pjk.29.2023.10.03.09.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 09:45:30 -0700 (PDT)
Message-ID: <8e2f4aeb-e00e-453a-9658-b1c4ae352084@acm.org>
Date:   Tue, 3 Oct 2023 09:45:28 -0700
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
 <17ee1669-5830-4ead-888d-a6a4624b638a@acm.org>
 <5d26fa3b-ec34-bc39-ecfe-4616a04977ca@oracle.com>
 <b7a6f380-c6fa-45e0-b727-ba804c6684e4@acm.org>
 <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1adeff8e-e2fe-7dc3-283e-4979f9bd6adc@oracle.com>
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

On 10/3/23 01:37, John Garry wrote:
> I don't think that is_power_of_2(write length) is specific to XFS.

I think this is specific to XFS. Can you show me the F2FS code that 
restricts the length of an atomic write to a power of two? I haven't 
found it. The only power-of-two check that I found in F2FS is the 
following (maybe I overlooked something):

$ git grep -nH is_power fs/f2fs
fs/f2fs/super.c:3914:	if (!is_power_of_2(zone_sectors)) {

Thanks,

Bart.
