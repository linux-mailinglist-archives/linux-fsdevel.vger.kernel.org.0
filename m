Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F832983B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Oct 2020 22:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418894AbgJYV37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Oct 2020 17:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417516AbgJYV37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Oct 2020 17:29:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4557C061755;
        Sun, 25 Oct 2020 14:29:58 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b69so6640534qkg.8;
        Sun, 25 Oct 2020 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYCL1zGD5+oYRaeJnoOagIe7phzlJ0DMXOGMO1PS/x0=;
        b=ELrWhfTrT1F1m8mw8Xm/N1I2rqYhYq7FRpWTD3VB7PYLKCwtL4cHdQLs6OH74vXBrE
         zC62ku/0YQp/YDXn41o9R2YcEo40fo54Tegpxrc3T4YG2bj24mHDOBYi1jqQkXftR7xD
         q/AXJmDSRYbUKfp1qo9qMTIhhpiF30Xz/PIK9BYX8xuesa9doZVHMk837R4+Sl0PJiQZ
         3i+CLYKZiHDHMPgJh7+E3rndz9aTg97BlMvTCHC3ZIZQPmlWHajn/5sjIcyYYliLKKKc
         fauEDIu1YLBiosWdwJTyps4cYzd0a7HWcS99kDKNdHrCPnrCFlA+C864ipNOfJkijfhM
         yL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYCL1zGD5+oYRaeJnoOagIe7phzlJ0DMXOGMO1PS/x0=;
        b=DiwBl4CR3tB1qQ+1CU5TNjM0xHAz7AhvY67A/1REfOw850xNgIxFqaqLmRF+hdIren
         rRm1CjUcWBdtRsGLiX02L5edRolU8c3/XJioafdeOMzfhWo6ii0AxKHNBVGIRqkxQpnx
         bm4U2V8RJR5CL2LTopiBX/kO2WplreYOzvlPUzw5uIghxo5Bzse7TuvuvKjmnkANTqA5
         iKcdYobNNimtp1BDRYWnkmJ4t7rxi1OvrzV7duvUJ7tW40gmm7qZQZ1HQxyYh9D0RCOv
         ASir+CC1Io0jrNKHiijkq3ychx7A03T/pu72irfsrMSJmCxIDEgY+7lEBYD1nUzWGNMS
         841w==
X-Gm-Message-State: AOAM530OCQxt2nriCwKLCMaYNJ1EJxyKtsGqJegZuKxT7coXnPPf1HPr
        YOzbEqSB/BhPph/f7Zd04noW8QPIgg==
X-Google-Smtp-Source: ABdhPJxoEoFyr2ekqTgO2YlLS9SX27DJOg+vNe6KYeqlCUwwfeu6LeMmmBVNFN+rHRu4JEE3Osfxxw==
X-Received: by 2002:a37:44c4:: with SMTP id r187mr13988608qka.235.1603661397518;
        Sun, 25 Oct 2020 14:29:57 -0700 (PDT)
Received: from moria.home.lan ([2601:19b:c500:a1:7285:c2ff:fed5:c918])
        by smtp.gmail.com with ESMTPSA id a200sm5352221qkb.66.2020.10.25.14.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:29:54 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, axboe@kernel.dk,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] generic_file_buffered_read() improvements
Date:   Sun, 25 Oct 2020 17:29:47 -0400
Message-Id: <20201025212949.602194-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rebased onto current mainline - this series already included Jens' patch for
IOCB_WAITQ behaviour so nothing changed, but Jens might want to glance at it.

Kent Overstreet (2):
  fs: Break generic_file_buffered_read up into multiple functions
  fs: generic_file_buffered_read() now uses find_get_pages_contig

 mm/filemap.c | 572 +++++++++++++++++++++++++++++----------------------
 1 file changed, 329 insertions(+), 243 deletions(-)

-- 
2.28.0

