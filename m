Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57F6D0BB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjC3Qrb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjC3QrJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:09 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC40D31B
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3261b76b17aso440655ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRZV8ywqR2kBvNxc/qL+fQ/rwLDqfOEPDg5PO2Ta6A=;
        b=RE6fgm5c2Gilxa/U/OIvbPcnQ974yXrsOY1m3Sn+NECU77/+5dVgVYDmk+oOY7Om20
         FpP4yTGw3Wd6nUkjmLyIsUBLuwA1JLOklHk85b3Q2b2OWhqV9a/J1MFUloC0IOJZ+Hir
         WqiPqy/0nB0DdjKOziqemqYaUonIJgjFfg8Z5wtvE70dFm36cja8VWg6kqk4EQ72wkxb
         d79h7jxmS4f7lEmSQioYgA0LqcfCUgFDNgbacJuNspVSR1JnaWG4SNy8AamIXJQ0PBqK
         4004snZ2WHNhXBkFiY5jF/a1XK9UDPLUk7F315CYDkhbiVpdFo8xXjiui5z6KX93K0zt
         7ChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwRZV8ywqR2kBvNxc/qL+fQ/rwLDqfOEPDg5PO2Ta6A=;
        b=bJTtb0sCW7+Y8+6rGqw8s4zF5cyC3G71PV9G6OD5JaMVXQtmb43RK2HKk+NxUoHgVx
         YPxGlmZOPVU6P1sesOxB48I1NaNpSH2Hi8ImHKLBo3lbUh83DH6EqMpCftoT9DCvSP/k
         5aE9NA77wG9qngiXvbFl7DviXLMChvaKmUnrqsCrAlFDGB5AVYTRNEIy+mEoW9EVSE/Z
         /kmQwElByx2rgonpWZkCoss0n/sXA2QbZbA7UM6Lf25HMLr/Mqin50L3jq21gcNhEGtx
         KiU9xae4y4J6uMhxGmrhB6u1lEuN15R8hqEIEdDU/dnPOyadv0Ec9+LZjNZD/dbXMl7E
         AppQ==
X-Gm-Message-State: AAQBX9e3OnfgTOknxe0uBOBCKrlwsDZxPNKI92HfWFr4VfQ9E5HP5b8v
        z+gYD3Km9E44vapxAEN28yYUi/CeT3FVybwzoaU3fw==
X-Google-Smtp-Source: AKy350Y6sN/BAsh7YbRsPF+y21IFjfzeioNqmtGdKN3EbrrDjq9080JE+cEKeHpg2e4Vave9ljXMyQ==
X-Received: by 2002:a05:6e02:48a:b0:325:e065:8bf8 with SMTP id b10-20020a056e02048a00b00325e0658bf8mr1793859ils.0.1680194825646;
        Thu, 30 Mar 2023 09:47:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
Date:   Thu, 30 Mar 2023 10:46:51 -0600
Message-Id: <20230330164702.1647898-1-axboe@kernel.dk>
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

No real changes since v6, just sending it out so that whatever is in
my tree matches what has been sent out upstream. Changes since v6:

- Rearrange a few of the sound/IB patches to avoid them seeing
  ITER_UBUF in the middle of the series. End result is the same.

- Correct a few comments, notably one on why __ubuf_iovec isn't const.

Passes all my testing, and also re-ran the micro benchmark as it's
probably more relevant than my peak testing. In short, it's reading
4k from /dev/zero in a loop with readv. Before the patches, that'd
be turned into an ITER_IOVEC, and after an ITER_UBUF. Graph here:

https://kernel.dk/4k-zero-read.png

and in real numbers it ends up being a 3.7% reduction with using
ITER_UBUF. Sadly, in absolute numbers, comparing read(2) and readv(2),
the latter takes 2.11x as long in the stock kernel, and 2.01x as long
with the patches. So while single segment is better now than before,
it's still waaaay slower than having to copy in a single iovec. Testing
was run with all security mitigations off.


-- 
Jens Axboe


