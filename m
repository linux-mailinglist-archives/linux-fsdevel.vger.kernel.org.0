Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA405FC32E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 11:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJLJk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiJLJkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 05:40:24 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C1552FD9
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 02:40:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id w2so16056167pfb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9YdxB2wq2UEPLQ4FXnLx9Rbnpi6ZD5Y9GZBTxGTCvc8=;
        b=M9MpWMyOd86VIVACzx/0jFJ2lRVctpCvc3OLrHyOH+B7z5M8Y8Sn/blqBeMvXx9s7l
         56xlPtH+Am4S1wrSmmcjPIcTSdY4uhTv0iw0VnAZMtrxHtvytWSx88hz0yG8MVyoOh5g
         U5q9M3o1wEE1vkyBU6cozDMQX1KSkN8Rx9ic4zhxI+j3nJFQLKC+fOGPx3KmbtGrDuJ5
         SgDCyA5sMNPy4p3PRFBTIuClN4NkevwO8BNfZC18rBC+RTOjz1XE/9SU0nM8lahrgQjU
         B6UUBSxM8OzvmjbH6bhZbRZUhRyBz6QA1mdA0mNmTSnCyJBdx624tKA2FDpNOHmebxsM
         H/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YdxB2wq2UEPLQ4FXnLx9Rbnpi6ZD5Y9GZBTxGTCvc8=;
        b=kDJu1dYu9FSkhFtlI3KswzOYN8YhcJNDrZ404oB5D4gBQIpCvxTkqR82mmUe+hKpWj
         zvodOlDCabp4izrsgJc37/6JVvImq5kNCKCVWO9QTPQP0e/trwhm3BJiWUNPtDgWiNmg
         MK9kVcHhdGQqtYQu0b3oV6pcJnZ8w18Fi0NULxHt7/6m/a2fE5Wu3nmxTBZCYKIfSG2a
         SdhkeQFud6mk66daDXuS/036HECxaoLUis8Qyp7RokV5mt9WodtSWti9nQnNvAH7b9NO
         iQl17k1wTSqAe4JUG6vFv+2gcPG4qS2forfkfnPLu2hXNj4VgQjYokSUhmEacM1rgyIR
         655w==
X-Gm-Message-State: ACrzQf2W2Z5++uvPSQIps2Rj3xIF/y6G/g1t4pItFhyeUT1cgtpymZT3
        kH4MwkMTjVwjpFD4PQ7bHKY5CIQIJ3U=
X-Google-Smtp-Source: AMsMyM6VbyHJ3TgnVYAutvL/pfamxOmqwv9zR2zbB/DUyhOtejX1+JBW+9ouiBPYlusC1hNSLlqGOw==
X-Received: by 2002:aa7:91c3:0:b0:563:1e9f:b200 with SMTP id z3-20020aa791c3000000b005631e9fb200mr19635117pfa.73.1665567616878;
        Wed, 12 Oct 2022 02:40:16 -0700 (PDT)
Received: from localhost ([58.34.94.196])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902694300b0016c5306917fsm10153852plt.53.2022.10.12.02.40.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Oct 2022 02:40:16 -0700 (PDT)
Date:   Wed, 12 Oct 2022 17:40:11 +0800
From:   lijiazi <jqqlijiazi@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     jiazi.li@transsion.com, linux-fsdevel@vger.kernel.org
Subject: inactive buffer head in lrus prevents page migrate
Message-ID: <20221012094011.GB19004@Jiazi.Li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi Al Viro,

I recently encountered a CMA page migration failure issue.
This page has private, and private data is buffer_head struct pointer.
buffer_head->b_count is not zero, so drop_buffers failed.

This leads to the failure of both directly reclaim and migration attempts for
this page.
Finally, CMA memory alloc failed.

This buffer_head detail info are as follows:

crash> struct buffer_head 0xffffffec9f0200d0 -x
struct buffer_head {
  b_state = 0x29, //has Uptodate, Req, Mapped flags
  b_this_page = 0xffffffec9f0200d0,
  b_page = 0xffffffbfb4bb0080,
  b_blocknr = 0x801b,
  b_size = 0x1000,
  b_data = 0xffffffed2ec02000 "\244\201",
  b_bdev = 0xffffffed169b2580,
  b_end_io = 0xffffff91006c44e4 <end_buffer_read_sync>,
  b_private = 0x0,
  b_assoc_buffers = {
    next = 0xffffffec9f020118,
    prev = 0xffffffec9f020118
  },
  b_assoc_map = 0x0,
  b_count = {
    counter = 0x1
  }
}

The b_count is 1, just because it's in cpu6 bh_lru:
crash> p bh_lrus:a | grep 0xffffffec9f0200d0 -B 1
per_cpu(bh_lrus, 6) = $7 = {
  bhs = {0xffffffed146867b8, 0xffffffec9f020548, 0xffffffed0f7e3138, 0xffffffed0f7e30d0,
	 0xffffffed0f6f7340, 0xffffffed0b8c59c0, 0xffffffeb7bdb7888, 0xffffffed0b8c5548,
	 0xffffffed0f7b7270, 0xffffffed0f7b7208, 0xffffffed0f7b7138, 0xffffffec9f0200d0,//this entry
	 0xffffffed0f7b7068, 0xffffffed0f7b7000, 0xffffffed0f7b7bc8, 0xffffffec9f020068}

On my device using kernel-4.19, inactive bh may be in bh_lrus for a long
time, and cause the corresponding page migration failure.

In function buffer_busy, can we check if b_count is greater than zero
just because it's in bh_lrus?
If yes, can we evict some inactive bhs to improve the success rate of
migration?

Thank you very much!
