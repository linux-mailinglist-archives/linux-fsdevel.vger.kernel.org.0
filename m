Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9198C6B33D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 02:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCJByz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 20:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCJByu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 20:54:50 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415BFD286;
        Thu,  9 Mar 2023 17:54:48 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id a9so4048162plh.11;
        Thu, 09 Mar 2023 17:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678413287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbKrJaTuxGBwz2l1L0VhQTMXMffewmYTsSHazCC963M=;
        b=KfJmw3IGnKc36gNO0L0t7LoWhi1ocXye0xOF70I7kJd6nCwQxyDZDi5EVM0LnW5c29
         2vaRSR8G0dEqtxUQ5KvtALY/uC4dp8uX0wmfNzp+g6CgxDbRkl9r0qeVa3gL92tY4Fqp
         f+6BO04ewEGSPs6xtn1de3+D+tsLVI17kuUAmWNAzD53cGHEpsxAMqHmk6ui35KZBYlp
         cLHpPbloEtl0eIVpjfK4rh9mZmj7EhzNGvL3Ld0mbiRkl86aXsmv0itN4QdcDUDkijN/
         2un6XQ06P5MAWkkVQOrp3wvAvE2XB7LXtYoDNcSxI/187J00Fq5+xI3rot9vl6is0iAw
         AIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678413287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbKrJaTuxGBwz2l1L0VhQTMXMffewmYTsSHazCC963M=;
        b=ZbL96V3fuPDjvqYHID4YQ1E/dEfuWxoPyshicS+h/jLDTqJrQl/RISOHZVWIKliAAj
         d3qjW2o41g5zq87uUMZPWifOw8ROeUVAlc9r0ctK6xWpN+sVTqMrqut8Z50UIjnGq88p
         AHNjxHuW9TeTxiGGe88nOH+8ip7rZ5Cv9EOuIM+r9O2BowhanwB217Zp0+30XOY7Hn44
         CFy/M0EP+soOog0WbA7bl4gvBtOGD04d9fzt2mRTUilt8M8InIlyZj9WzIbmGokiGQwh
         r3hD4xm3x9dAL+P5UWSQrRZpZo72UCAu88m1cdjJaFSfvanfyO/awOlefq4L7oU5dK4l
         ia3A==
X-Gm-Message-State: AO0yUKVS28n0bwoEIcEjSx6kORvqCTANYnU+A5unhLX4bZPVIuQh1iHb
        9upF2+2bfl0FXhNjIp1dpZI=
X-Google-Smtp-Source: AK7set/EmfQT1M2FmsnIPc47RkYaUhRCbk42tHMoBZu0kIqfZDcoA5djaR/klcAuCJpwYJqkjWSmEA==
X-Received: by 2002:a17:902:dac8:b0:19a:a650:ac55 with SMTP id q8-20020a170902dac800b0019aa650ac55mr232742plx.23.1678413287523;
        Thu, 09 Mar 2023 17:54:47 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ju14-20020a17090b20ce00b002371e2ac56csm221566pjb.32.2023.03.09.17.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 17:54:47 -0800 (PST)
From:   ye xingchen <yexingchen116@gmail.com>
X-Google-Original-From: ye xingchen <ye.xingchen@zte.com.cn>
To:     mcgrof@kernel.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ye.xingchen@zte.com.cn, yzaikin@google.com,
        chi.minghao@zte.com.cn
Subject: Re: [PATCH V3 2/2] mm: compaction: limit illegal input parameters of compact_memory interface
Date:   Fri, 10 Mar 2023 01:54:43 +0000
Message-Id: <20230310015443.175552-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZAlY7jsj4daalgcY@bombadil.infradead.org>
References: <ZAlY7jsj4daalgcY@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>> From: Minghao Chi <chi.minghao@zte.com.cn>
>> 
>> Available only when CONFIG_COMPACTION is set. When 1 is written to
>> the file, all zones are compacted such that free memory is available
>> in contiguous blocks where possible.
>> But echo others-parameter > compact_memory, this function will be
>> triggered by writing parameters to the interface.
>> 
>> Applied this patch,
>> sh/$ echo 1.1 > /proc/sys/vm/compact_memory
>> sh/$ sh: write error: Invalid argument
>
>Didn't echo 2 > /proc/sys/vm/compact_memory used to work too?
yes
>
>Why kill that? Did the docs say only 1 was possible? If not
>perhaps the docs need to be updated?
In Documentation/admin-guide/sysctl/vm.rst:109 say: when 1 is written
to the file, all zones are compacted such that free memory is available
in contiguous blocks where possible.
So limit the value of interface compact_memory to 1.

Chi, and Ye
