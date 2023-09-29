Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B77B3631
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjI2O6a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 10:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjI2O63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:58:29 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB53F9;
        Fri, 29 Sep 2023 07:58:27 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c5cd27b1acso127971645ad.2;
        Fri, 29 Sep 2023 07:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695999507; x=1696604307;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za8EzqdYzUyppdLLpiPtivTza7p59Ioizqu+gaqUd3g=;
        b=HyJH0ZshpIwmE49aHtyK7gu7yM2ZaBkZLMQz+RIRYMDvSVzNr7n63vKPgYO7442bT4
         pnmp1au4L+29l4my+hIXh+zUvw9Cv9E1z2f/ISc1LKBsQcztgSlJGm7Qs5S2WsTUHPEJ
         EiCFeO0AF2B/nMaeLKOThgwp0nUN2dJzUqWvYNfYvIUOmm95HOprvn4CD1rU8PZwHtlG
         nX5ULskx9Vt936XKDDqvR5wVAx8YTR0un8cYS2dT/DllRTYnZGyoB3Hn9k5z+YMa6gLO
         GzvWQyYKQ5b5tusu4Vd6rPLHiV75A6WJKMmLxrEeSwvhHo9fT2M3Iloy0FVaO3wFYmKG
         SfKA==
X-Gm-Message-State: AOJu0Yy7mA8aBSOAiOr7smIK50eOxPSuFVyRu7Imyc3NRYiIzyrFJOIx
        KaZD3xxz0g+NY3njH2ifAi0=
X-Google-Smtp-Source: AGHT+IG5sgVITHE7nR5diwLXn/2VF45vvGKMJi6rof6uCdXanJ/bkpRzf92xSKeM2Bi/n6Pno9YC+w==
X-Received: by 2002:a17:902:d34b:b0:1bb:9b29:20d9 with SMTP id l11-20020a170902d34b00b001bb9b2920d9mr4928956plk.20.1695999506875;
        Fri, 29 Sep 2023 07:58:26 -0700 (PDT)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id iy3-20020a170903130300b001b9d335223csm13018814plb.26.2023.09.29.07.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 07:58:26 -0700 (PDT)
Message-ID: <378f6c3b-5c4d-4df8-ae1e-e8abb9ee47a3@acm.org>
Date:   Fri, 29 Sep 2023 07:58:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] block atomic writes
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230929102726.2985188-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/29/23 03:27, John Garry wrote:
> The atomic writes feature requires dedicated HW support, like
> SCSI WRITE_ATOMIC_16 command.

This is not correct. Log-structured filesystems can implement atomic
writes without support for atomic writes in the block device(s) used
by the filesystem. See also the F2FS_IOC_*_ATOMIC_WRITE ioctls. This
being said, I hope that atomic write support will be added in the
block layer and also that a single interface will be supported by all
filesystems.

Thanks,

Bart.

