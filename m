Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3464A870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 21:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiLLUI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiLLUI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:08:57 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B5B1759E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:51 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r72so584786iod.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqt+AIDkq5YYDe+y48sDLPDnCEEyOu4Nl+HUJuzC8mQ=;
        b=XUiHIGSW28Xds9UCv2ov33FCY9Ph3jyQ2ZDFH+sg/YEkHs/3MhNVvR+DAdMH1PJVBp
         lBXXHRsxBItS9Jl+7NOQLty6dYPp4ENplzuKSV6gzjSP1jhduhQlc77gTUlsj+RNzH4M
         +WDoaSoq9A2jqzKGC+TPFqhZbbg1yGBt8PoEVdjIImLaGVf2R/WNRlSOnc4+bBQkPg0a
         3XdFogYkxibWWrkrM3FZ5D4t2WjwuG3ha6vBAy0t2B0n74sZ/UFlN48K7/zCt6GIBW8Z
         SDHRqAvzWPIUbW1clDYKsimB1aKhCYmSPefCnh6UnZ60J04dNJ2Oj3K2UIHm0A4/b5I5
         Ktaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqt+AIDkq5YYDe+y48sDLPDnCEEyOu4Nl+HUJuzC8mQ=;
        b=qWQzscSmqCof9DZ4vSAAQC7R1GAvMoNZQ9+R7O0DgxLri6agdXBZr4aCOLprwSvm6X
         noyY91zh0MePMRhuFpuRY8nCiIcsXqP3fS3gDE4xK+myPvzZ8roX/+J1M04fGVOVwjks
         /C1J5gbrhiwJpri1dCueRidxLm0pB+jbM3Cgac1HDWVuS2+c5ZNbTA2//xKMPIy3gGfQ
         htdJq3DHU1/CTIc5DETXhXEhHjjbxWD1G39MuexZwK+2pJZx/m0ST08ANJMtWn46pCzx
         nvb0/KqulA8iZv1KOHn2maILSTbBi31wWHSyc8bMRDlO3zwGAFPAKeUvDQChDlZK/n/O
         BxhQ==
X-Gm-Message-State: ANoB5pl6TLw5jOkjWjDn2ehsVbvx1RaHKBJVP5mzL/pO/HvRrFf1KqWE
        H9edysVZ11mvBdtYC/K3ypFrAw==
X-Google-Smtp-Source: AA0mqf69QR98ezCK74+uOyYLL0kLMaBB/dL0CmkX0+tMdR2fMkhaW5NnEoGdUtRYlqISmBFVu3Km0Q==
X-Received: by 2002:a5d:9343:0:b0:6db:3123:261 with SMTP id i3-20020a5d9343000000b006db31230261mr2160665ioo.2.1670875730346;
        Mon, 12 Dec 2022 12:08:50 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id j192-20020a0263c9000000b0038a2bc43350sm209290jac.53.2022.12.12.12.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:08:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     viro@zeniv.linux.org.uk, tytso@mit.edu, jack@suse.cz,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221210101042.2012931-1-linmiaohe@huawei.com>
References: <20221210101042.2012931-1-linmiaohe@huawei.com>
Subject: Re: [PATCH] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
Message-Id: <167087572893.15871.14396720847219305165.b4-ty@kernel.dk>
Date:   Mon, 12 Dec 2022 13:08:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On Sat, 10 Dec 2022 18:10:42 +0800, Miaohe Lin wrote:
> EXPIRE_DIRTY_ATIME is not used anymore. Remove it.
> 
> 

Applied, thanks!

[1/1] writeback: remove obsolete macro EXPIRE_DIRTY_ATIME
      commit: 23e188a16423a6e65290abf39dd427ff047e6843

Best regards,
-- 
Jens Axboe


