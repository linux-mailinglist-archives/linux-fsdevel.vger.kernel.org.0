Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AB6C8702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjCXUov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbjCXUou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:44:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2A1A5EC
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:48 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so2958194plb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Mar 2023 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679690688; x=1682282688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pSgaQBDdZgpBn2Wl/XYhmwViW/l2oXoS2KOFDkKyzSg=;
        b=a0XTr8ansym41nWRImRfgEAXaFbv2lIQdm8p2pNWe+VVIniYZ3KwoNcnPkk9Wk+h4e
         IpTBYCppgcXV3WDuaoLcIg5R9EGS9+oec8J6bKkBNk559z/t4oCP7dfEu+mvz33pxF4y
         8Rho7++Ab4tWGcs068WKPiTSCWOKsBOM1ZsCWDt7jcgktWGmyMEimp+NAVwQuUBiYaHY
         qVYAIc0FuXg9T+zsvn+Esb7n6GhIRqio1YLXJj9zTkyRCKl3PIvhwtHCw1ERP6elDtQX
         L73JbfgprB9IAG1mSkszVpctAgHTf7pv1I0Xea/4lNDoSpoaOurOKf2eC+pasXkjIvgJ
         uD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679690688; x=1682282688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSgaQBDdZgpBn2Wl/XYhmwViW/l2oXoS2KOFDkKyzSg=;
        b=561IcwECZvZyV42mZWMN+mv24PuEKVw7l8oFlOvSPBk/gp8grJdvZsVwLmVgOWAJh9
         uLRA5GfuTw3AcleWPrlIB46mXcdEvM2Y6SBH0ZIlxB8h1hSE18JupsW3ytb525I6fywN
         zeqv1jMaYEzcPEX2NBedeTK+55ocJC8Gp9zLpSqG7FC3fwPvy7CpB530uNPkpoOn6LqR
         1Hm5pIR5+Gmr4g0nA+vLlX2UWf9fMQnEgTpj3S0SK71LSAhf6kPXyJa9iK33eSL0OOBh
         ZT6oLr/g/hf2i7AkmDTv9tzJ8aQ6W5jkbAuRteOeiENHqwITi1AV54nvQamWFVV3MCVV
         3tFg==
X-Gm-Message-State: AAQBX9fZ91dWWdiXOEg4//0/p26G2RHA0pl3nH0F1O7OxtmbQ7WnmQVp
        Q3bnOZW37e+Sv/zpC3S7uzZvcHMgjSOwMapQ9kSj2w==
X-Google-Smtp-Source: AKy350ZN/cAesDww4cKenyYYoJdXJR/8BoOja2jhLuk+sLCJyVkJeLvt8SeftRoH7BIB5SdWMP0rFw==
X-Received: by 2002:a17:902:7297:b0:19d:2a3:f019 with SMTP id d23-20020a170902729700b0019d02a3f019mr3437912pll.1.1679690687919;
        Fri, 24 Mar 2023 13:44:47 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc9-20020a17090325c900b0019a87ede846sm14605344plb.285.2023.03.24.13.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 13:44:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org
Subject: [PATCHSET 0/2] Turn single segment imports into ITER_UBUF
Date:   Fri, 24 Mar 2023 14:44:41 -0600
Message-Id: <20230324204443.45950-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We've been doing a few conversions of ITER_IOVEC to ITER_UBUF in select
spots, as the latter is cheaper to iterate and hence saves some cycles.
I recently experimented [1] with io_uring converting single segment READV
and WRITEV into non-vectored variants, as we can save some cycles through
that as well.

But there's really no reason why we can't just do this further down,
enabling it for everyone. It's quite common to use vectored reads or
writes even with a single segment, unfortunately, even for cases where
there's no specific reason to do so. From a bit of non-scientific
testing on a vm on my laptop, I see about 60% of the import_iovec()
calls being for a single segment.

I initially was worried that we'd have callers assuming an ITER_IOVEC
iter after a call import_iovec() or import_single_range(), but an audit
of the kernel code actually looks sane in that regard. Of the ones that
do call it, I ran the ltp test cases and they all still pass.

[1] https://lore.kernel.org/io-uring/43cb1fb7-b30b-8df1-bba6-e50797d680c6@kernel.dk/

-- 
Jens Axboe


