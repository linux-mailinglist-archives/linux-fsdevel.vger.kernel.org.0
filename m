Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2273A5F8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbhFNJ7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbhFNJ7Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:59:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E64C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 02:56:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i94so13818324wri.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8dQB5RiYtoDq4FDDd+N3kyGCeRcm2O5w9VesrPQlgos=;
        b=aL4qLPGhTq+N0yzqIqhDBgs6GyLDIwk0cIHNLwFUBQtrqYhL5gfpXFbneU/oL2ZELQ
         36d2aFWWsQwC1tUaD959+E1FmgBllmdKeepKIQWUsH71yamWhKcb1m/h1VkHSNPExmSZ
         5DW5tB8qQjwkMwId06jzv55DG1oHeBBPjPsacfKtMM8QVp46n+y6NC7PPQbVjBC1bJYd
         DxqkLiS8+AZ6Oh4Nin5iNTC/CmyTbIaN3sMd9NfydvxbTTwWZ0BIy1OmTaB5fLBDY54T
         trzDy1NFTAHg6iedcL+ZbsnAb8s0ogiXTX9WT9m5mxRdWpONqO7Yc4r9r9APQzv6jfCC
         dOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8dQB5RiYtoDq4FDDd+N3kyGCeRcm2O5w9VesrPQlgos=;
        b=nsLWBb1jC8qctiGzuqmpBwQmeGmbvO40nh315Pz/UzhsKVxSjrggRbp9ig8jX/54ac
         LJdbI9zNZtQzWLFqn6grdcZknd+MKQ1+Aw1JKVlq3Fe5125NX2p4FOz8j3CMPz+eolws
         yVgcHsz5xgMIpLUOPZNq/PXPQX0Gq12ebJl6NISpKgy/BKkkU9OLBVyp8pPamamfZSSS
         w9bhPDTJesiTkXQObtIYvjlD45cN73lnPZXjAwzEJRDjWYLYnuebHV97F998rNFPwCdQ
         Xsiizo4Z5fWahTaqNvHn+8WHH3S0mcbrq+8VestlaGOlLpve8Z9X1GKEKUJqhxVgR6QB
         Ld4A==
X-Gm-Message-State: AOAM5300aeLf3GKOT2Xm7mLZZZNqq0fAejDZnXkU1Qeq+JwFHZhdIHKc
        gssq5U8B8d0KCqlLdMkccaqit6RwOD0=
X-Google-Smtp-Source: ABdhPJzIbVTSwMFumAPs9fNnfBhe89NALORu48VujlurhmKIi8EgavmMIFJVk69RRMwsebKCTMZw7w==
X-Received: by 2002:adf:ee50:: with SMTP id w16mr17595140wro.187.1623664617948;
        Mon, 14 Jun 2021 02:56:57 -0700 (PDT)
Received: from [84.217.163.14] (c-afacd954.51034-0-757473696b74.bbcust.telenor.se. [84.217.163.14])
        by smtp.gmail.com with ESMTPSA id 4sm15065323wry.74.2021.06.14.02.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 02:56:57 -0700 (PDT)
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Possible bogus "fuse: trying to steal weird page" warning related to
 PG_workingset.
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Message-ID: <016b2fe2-0d52-95c9-c519-40b14480587a@gmail.com>
Date:   Mon, 14 Jun 2021 11:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi. I recently upgraded to kernel series 5.10 from 4.19 and I now get warnings like
this in dmesg:

page:00000000e966ec4e refcount:1 mapcount:0 mapping:0000000000000000 index:0xd3414 pfn:0x14914a
flags: 0x8000000000000077(locked|referenced|uptodate|lru|active|workingset)
raw: 8000000000000077 ffffdc7f4d312b48 ffffdc7f452452c8 0000000000000000
raw: 00000000000d3414 0000000000000000 00000001ffffffff ffff8fd080123000
page dumped because: fuse: trying to steal weird page

The warning in fuse_check_page() doesn't check for PG_workingset which seems to be what
trips the warning. I'm not entirely sure this is a bogus warning but there used to be
similar bogus warnings caused by a missing PG_waiters check. The PG_workingset
page flag was introduced in 4.20 which explains why I get the warning now.

I only get the new warning if I do writes to a fuse fs (mergerfs) and at the same
time put the system under memory pressure by running many qemu VMs.

/Thomas Lindroth
