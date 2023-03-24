Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CECC6C77D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 07:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjCXGYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 02:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCXGYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:24:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BC14687;
        Thu, 23 Mar 2023 23:24:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso651427pjb.3;
        Thu, 23 Mar 2023 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679639053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gg+Nsm6tcL5yVwisqqOCzwyC+QFvP6IJKg/xOEnEw4=;
        b=YD7aApoa2wmPLKup872tCwpuexBHKmDDGYQKsA3sNhW8fTRn2XWhjUUTM4hhIgIekL
         bZCtAx+lzwY/pR96VwvieF+Okg3KahE6wMREF6HoZ0DTFlblDD0t7KFet5FZR5IhbH/N
         dk/2GigPG8p1fYvJ0aEt0nY8FNtK2klW6nuuRQZKzPYWKzCyvVCwDVEkmlAlJCqYMQkX
         //z3Z7RRpdWEcmU7iS1vzMA4tOhYGRqIF+al0ViJcANw6DF8MAklH68yOLYXcYRkjcw+
         y7ESYFAKjUXKb2Lhh/v5kyPOSw6Yoh6Ya/F/5iP/NGtAXgKcXanoV2eV5apwsOZpxeje
         NF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679639053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gg+Nsm6tcL5yVwisqqOCzwyC+QFvP6IJKg/xOEnEw4=;
        b=cJkR9+KigrqeWMhEv5DGJdEt3NXZbbyTwwK3x7vwRqp5RBMq+f7Ql8IeAx0+K7vjuk
         jKDVTVE7vteR98Jd32bZPC3uOueMMEJYriZ53gt3D2WGXaLaWM0yul1cgC96CyWihny/
         kMmPOKrpCfebj77oIlGAzmldVYxXiEkN70miubPAegJZGbuWh29Kdmh088sy9hYy+3fl
         TAgwCLGzu7RHnc7EJVsqqd/xcbzS5605OhJrbHJLK7uHRPzr1OsyY072PsWOwbTcbM5i
         oPcO0sWXjo/q8UGFVc/cnpGt9lm3LZOnyfGvunhAeSVoiScLSAnteTj7LEMpfl0AzART
         /kOA==
X-Gm-Message-State: AAQBX9dzT1YvFAFlAkkbvlbTO16O5GwHBbnx/fT3Kz+Tmyp74mMMETEZ
        4tDyjItlGdXALpkVdQ1ipz9GlwDXqrkE6A==
X-Google-Smtp-Source: AKy350bCFPXGsMbPU6EZpUl/RFKFCBwPhD9fjkabLqNkx4Vdl5E7xLlzH1csUAZpy4+c7C5A2ksnBA==
X-Received: by 2002:a17:90b:4b10:b0:23d:41:3582 with SMTP id lx16-20020a17090b4b1000b0023d00413582mr1729412pjb.8.1679639053020;
        Thu, 23 Mar 2023 23:24:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id ay6-20020a1709028b8600b0019a997bca5csm13275036plb.121.2023.03.23.23.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 23:24:12 -0700 (PDT)
From:   ye xingchen <yexingchen116@gmail.com>
X-Google-Original-From: ye xingchen <ye.xingchen@zte.com.cn>
To:     mcgrof@kernel.org
Cc:     akpm@linux-foundation.org, chi.minghao@zte.com.cn,
        hch@infradead.org, keescook@chromium.org, linmiaohe@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, willy@infradead.org,
        ye.xingchen@zte.com.cn, yzaikin@google.com
Subject: Re: [PATCH V5 1/2] mm: compaction: move compaction sysctl to its own file
Date:   Fri, 24 Mar 2023 06:24:08 +0000
Message-Id: <20230324062408.49217-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZByq/TcnxYbeReJZ@bombadil.infradead.org>
References: <ZByq/TcnxYbeReJZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>$ ./scripts/bloat-o-meter vmlinux.old vmlinux
>add/remove: 1/0 grow/shrink: 1/2 up/down: 346/-350 (-4)
>Function                                     old     new   delta
>vm_compaction                                  -     320    +320
>kcompactd_init                               167     193     +26
>proc_dointvec_minmax_warn_RT_change          104      10     -94
>vm_table                                    2112    1856    -256
>Total: Before=19287558, After=19287554, chg -0.00%
>
>So I don't think we need to pause this move or others where are have savings.
>
>Minghao, can you fix the commit log, and explain how you are also saving
>4 bytes as per the above bloat-o-meter results?

$ ./scripts/bloat-o-meter vmlinux vmlinux.new
add/remove: 1/0 grow/shrink: 1/1 up/down: 350/-256 (94)
Function                                     old     new   delta
vm_compaction                                  -     320    +320
kcompactd_init                               180     210     +30
vm_table                                    2112    1856    -256
Total: Before=21104198, After=21104292, chg +0.00%

In my environment, kcompactd_init increases by 30 instead of 26.
And proc_dointvec_minmax_warn_RT_change No expansion.

  minghao
