Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5627BA9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 04:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgI2CFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 22:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgI2CFX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:05:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75534C061755;
        Mon, 28 Sep 2020 19:05:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id jw11so1819390pjb.0;
        Mon, 28 Sep 2020 19:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iG/bDnzqe0Ijt5t+Wte/8y83V66TpQLjZGlUCfab1wM=;
        b=EpFofk08+f9XITxoematI1OddFtlpiCUaEhRU1X8Rf3an9Wf7Z359hgUmUFpbHoPlP
         8RxfGcHxl0ll7p8Vv9aC0nB8jAe7BcKRPgFm1MJIUV9iNEvpimIJEC0XLsnt1/o09PcF
         +GLVK5dBh3fVli5MWTsCkWGgNgmhoTdolAxDXRIiqkfMi4eimOGaYCGATR+SVIHdsRRe
         9mlew9d5gcr78P46fZ8EGcWjjz6bnPhryLd+yC3/II6dTOxBQ5NLB2GCCaAyLRCPKYv2
         rPd5QHyrYZI4Q/h2/BO7k4yYlBisKMqi/mF5QSB++gKtFHSyPRDoj4d0X7CICgzyDec8
         3y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iG/bDnzqe0Ijt5t+Wte/8y83V66TpQLjZGlUCfab1wM=;
        b=GITYyTXUu+joFGvxRbVicd6Joh7V+S65i8Y7o5GMxQXRMgkTcgAJnp6sV/CMQT8aCc
         nz81fKNIjj/lb7LZyxbNBISV7i+EBfPbHDrIDOiyBG7cvEZxqG3unU8970sxcQbHorh9
         llFOdSndaaBrAHv7n2y6KNwIPjkDDdkiZHpqp3bbnqGKQFQH1pkowTASlndsaJ3O6kvR
         3tKYyTx6/mpDHmdcM49DoTolEN+u0MRSdbLMv/9bcv9CrxbjUlSwU4A9aLVWNpL5FnUz
         v9xBkXd90zoNkNTRyKBIe0meUhkSoU1NvXar4oW2KRaXxG55i9W0VeVlc+Uxd2JHbRK9
         xTvg==
X-Gm-Message-State: AOAM532U/T+5RrMs5foNiMAFUVI2buskkbGLMQUuvntLqucLnSxWjS+l
        NJZ4PF/6OdTcLTghSA0DOjE=
X-Google-Smtp-Source: ABdhPJxJpmMaNJwZ6htIVmhNPWkcCWKRWoXVeHqM+7TyR3A1gD0li91bQ1A0WrWY5y6DMA7aPmnDtA==
X-Received: by 2002:a17:90a:c255:: with SMTP id d21mr1857806pjx.212.1601345122954;
        Mon, 28 Sep 2020 19:05:22 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 31sm2577845pgs.59.2020.09.28.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 19:05:21 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:05:20 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC] process /proc/PID/smaps vs /proc/PID/smaps_rollup
Message-ID: <20200929020520.GC871730@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

One of our unprivileged daemon process needs process PSS info. That
info is usually available in /proc/PID/smaps on per-vma basis, on
in /proc/PID/smaps_rollup as a bunch of accumulated per-vma values.
The latter one is much faster and simpler to get, but, unlike smaps,
smaps_rollup requires PTRACE_MODE_READ, which we don't want to
grant to our unprivileged daemon.

So the question is - can we get, somehow, accumulated PSS info from
a non-privileged process? (Iterating through all process' smaps
vma-s consumes quite a bit of CPU time). This is related to another
question - why do smaps and smaps_rollup have different permission
requirements?

	-ss
