Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E385D5F647B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 12:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJFKqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 06:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJFKp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:45:58 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2357598345;
        Thu,  6 Oct 2022 03:45:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s30so2230068eds.1;
        Thu, 06 Oct 2022 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=JlewNC+bXlKO7hBF9QOboFp9ra4eqjAA0Th/QL6KAjs=;
        b=V5+22EF0z9JU3TfI7zxVGI90zPEHaY34y3h0majEKYCjGaxXZDT37hKKKI2ShmVu1M
         RzY8kc3+Wqfr+m7saN4YLi14O7o3qH3nz4Bs8f6XSSJIhQb+MNJDTpih29LFpDiEsPTk
         qOdsENd7pDSqzB+dtQAmBMyDgk9lRMhVbTdy2zWul19DJPGScWzerIbCcfo2JOoXg01V
         GSEutzkRW4r1nIEAIhP5wOIyTJ24zDk07ILyK8iTQJgLVNg7mSR/xsYv4/Cd4RDxPYZc
         mrXuYSYrOkdgWhL4GZMGOy50WSwXBW96EZ0jocVGE/+CcaFlivqSN3epjzlWXreIjKog
         KRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=JlewNC+bXlKO7hBF9QOboFp9ra4eqjAA0Th/QL6KAjs=;
        b=6DtqucRiRGVeU/0rjt8zj91nlgp428L3YuD9v54LqNLbxoaC6AH2USjH46PYdTiY+O
         KKuqMvFT3PjyWTTcmJSOGoZ7/L3ChoLxqe2osojI6gtr4yt6wMWpVzsNCdSSWiOmh75N
         x671Eq6AEOOeI0o0tpJz2mHq3C2j5Fd+zlyjtTaoAbMqi3BB4hd7zA7uO8P+5mET1c0X
         4mchSxppT4BrttrJF2EMRMlgsDJ0pe/3id/nW3vmY3lQbFWR4u0EedOt/nQM1/uE8sYi
         GsfE1s+IkOGHXN4ILeyr/RrcbAZY1qbz+r0CzSvRvJqg/K9KI9z24TOsWgZ+8jA4OzcK
         CzMw==
X-Gm-Message-State: ACrzQf3VlqL4FWM9x4u5kQBwdfwJtvOxVse8gE+779jpW6TC0BhgUutz
        zAJvdjAsnhztlzrq7VYtx+fRc63v8RI=
X-Google-Smtp-Source: AMsMyM7ed9G8B2olEg4hdfNCZCSrGATCWwkhVigJk1KTXGizVbtVMH8ibbpRk9eXGGw6rmS3Tw1E+Q==
X-Received: by 2002:a05:6402:280f:b0:458:ea37:7f00 with SMTP id h15-20020a056402280f00b00458ea377f00mr3909895ede.1.1665053155458;
        Thu, 06 Oct 2022 03:45:55 -0700 (PDT)
Received: from masalkhi.. (p5ddb3856.dip0.t-ipconnect.de. [93.219.56.86])
        by smtp.gmail.com with ESMTPSA id d1-20020a056402144100b00456f2dbb379sm2369104edx.62.2022.10.06.03.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 03:45:55 -0700 (PDT)
From:   Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: A field in files_struct has been used without initialization
Date:   Thu,  6 Oct 2022 12:44:39 +0200
Message-Id: <20221006104439.46235-1-abd.masalkhi@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Linux community,

I have came acrose the following code in dup_fd()

1	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
2	if (!newf)
3		goto out;
4
5	atomic_set(&newf->count, 1);
6
7	spin_lock_init(&newf->file_lock);
8	newf->resize_in_progress = false;
9	init_waitqueue_head(&newf->resize_wait);
10	newf->next_fd = 0;
11	new_fdt = &newf->fdtab;
12	new_fdt->max_fds = NR_OPEN_DEFAULT;
13	new_fdt->close_on_exec = newf->close_on_exec_init;

On line 13 new_fdt->close_on_exec has given the value of
newf->close_on_exec_init, but new_fdt->close_on_exec itself has not
been initialized, is it intended to be like this.

Thanky you very much!
