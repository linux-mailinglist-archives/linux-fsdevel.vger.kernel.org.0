Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745074379E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjF3IkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 04:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjF3Ij7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:39:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE901BDB;
        Fri, 30 Jun 2023 01:39:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so2548692e87.2;
        Fri, 30 Jun 2023 01:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688114397; x=1690706397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj8sD4PQmFmIt0sWpLcMRcCBS/cUVC91KAMlJbfG4Sw=;
        b=IF+x2Un0ialJwvRc2NJZ87xNlukX7lDwsStdmTu+xNU+6CvSPn0CyHPHZJUwE4jAL1
         KFbaE2oHBh9eaBZShydJb2DBNgqHHSYbHVTPLGTcyeuQz1YkA7lv5i2L27Dby6ZKDMF6
         0HeYvL8jCIS0qYZSeo0DFdF74NSEzx1HYXBPDnV2utmYtNfkvyHh5lkqD/wEsp/YnoOA
         wPfodenPGnlFf0dX/bXaV49haiZfa/U+4OsfuMmsUJsjqT5UbuQlB+eMMYrDleHgHvao
         WMgvQsI5461VZwAmIIn2HqNoUNc7Sw1ynA0j9V4LE8bBfHIDX3ZMhTJF6F9kmEPjcl2W
         maDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688114397; x=1690706397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj8sD4PQmFmIt0sWpLcMRcCBS/cUVC91KAMlJbfG4Sw=;
        b=LZCvRfgf8JrCuGyM7D+aeq5uggCCtKeBKKLGDoO59+XXO+19hZJ0I9Oq4ZPSFA15Oh
         aUU555kNHIcUNGNNjXZZv5PxmlmDR7w7jti/AR8gBajP2bMG8gEmD98GGd0d6feLUGqe
         x9nSb4Lrwsq/6rZXMwHdIuNubKrPuwJRztuLq0nY7ZyomT1wK31F7QPy8mi1bjIZ6UaR
         KM9hj54S2dbPvDsuVeKj5H3aDju9Q/uINtoMxlXRUXQxEtE/mDW9FIc5qzdH4023/0Cp
         Zzm1XxTyleaVLD16kQf8jVSUu9eO+YaWjlqjFIRcaf1Gfg4k3272+Sngb3TbgA9pULgM
         FiMA==
X-Gm-Message-State: ABy/qLas7zRh+impY47bN92reHSnf/SUj/jglwQiWDhA8+5rYb6ImDAv
        udLmg3h6jZqnBTM9mub5KQE=
X-Google-Smtp-Source: APBJJlGdd1jko5UZbV19KyqK5ZPkUF/xVq2+MvZOMbV5sekvFNXQJdzxBE4YinCaMesxPmIoqidSGg==
X-Received: by 2002:ac2:4ec5:0:b0:4fb:7de4:c837 with SMTP id p5-20020ac24ec5000000b004fb7de4c837mr1650272lfr.68.1688114396551;
        Fri, 30 Jun 2023 01:39:56 -0700 (PDT)
Received: from lano-work.. ([80.120.136.76])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c020e00b003fba92fad35sm6032789wmi.26.2023.06.30.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 01:39:56 -0700 (PDT)
From:   Norbert Lange <nolange79@gmail.com>
X-Google-Original-From: Norbert Lange <norbert.lange@andritz.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        containers@lists.linux-foundation.org, jan.kiszka@siemens.com,
        jannh@google.com, avagin@gmail.com, dima@arista.com,
        James.Bottomley@HansenPartnership.com, christian.brauner@ubuntu.com
Subject: Re: [PATCH v8 1/1] ns: add binfmt_misc to the user namespace
Date:   Fri, 30 Jun 2023 10:38:52 +0200
Message-Id: <20230630083852.3988-1-norbert.lange@andritz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
References: <8eb5498d-89f6-e39e-d757-404cc3cfaa5c@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Any news on this? What remains to be done, who needs to be harrassed?

Regards, Norbert
