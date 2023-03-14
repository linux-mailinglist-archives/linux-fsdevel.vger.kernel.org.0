Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B0A6B9A0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjCNPnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 11:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjCNPnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 11:43:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1465CB1EF2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 08:42:48 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id r4so8862152ila.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 08:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678808528; x=1681400528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDfqgaIEHo4E5opoNKOuRm6CSyleb5F755xTWTdZGVE=;
        b=cqr2PPTnA1nZdHrmf6ynLY7KqHvs24mqWuD9b4UTcV8vwBkt8C7BS721mkO/wLARIM
         +rDdw3COcIcK21iwxVG4TeasQsKo6SI0kKe1qcVaynHHCSm1gHlpE2/VEFI+jG2jJxvg
         W8FsP0bARo5lBcdpu1p0KYFKou5WWlHIXKl0IH4SFpvmTaGm7MJG+rL7YOCgKCAPWwNR
         +pWt6f0+5dRBri/Mou+XFdZ2ls7xeAM5X4FRZ5XkbtfQN8bQAkOFMvzgeOvqsY0IfHCL
         F81S1gXguhkq3zwFRis/m0WMJwgtEasbDg0BM6MYGOBjW3tOY4WIEb8m3whw1A3opaqN
         OzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678808528; x=1681400528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDfqgaIEHo4E5opoNKOuRm6CSyleb5F755xTWTdZGVE=;
        b=lTmRX4nq5LS9+BuE69MKrsma68ltthRtxQTcxn0Rls3lJAfn4YQT8llK0uTf1E0mpp
         OrjOulG3HhRAJkcmDKQwMCfI+tse2mw/pJ3ZtZezK+tG2Y7eHapC/qLzeiJXr1hz9ajA
         yYwZUlVj5yOZeq6isC7TIzJ0wheyU2tqjZSdLZGsIkw42FeZX0SzX/GIkH6u3GJcuSs1
         FhGDUw84EmTjWycAKmBPQUU3dR3g9tVABhDDGq1IJwHNVVz8OdvFjeqdaVlIrQwPhY3v
         esKFDQVsMQDqz+LbU3AJoov55sRTR8aJxZPyKmBJ6PW2dMyEef/B+pwjEhJP4qJxpESv
         msmA==
X-Gm-Message-State: AO0yUKW/GkMWXNInfIz0omfw1Jqk6m87EIPqJvIECYXiC1k3hdDMueHK
        hJETZjt7ViziOs/NsGaHugJhQQ==
X-Google-Smtp-Source: AK7set8JXOA4OeX1nkyB8Dv6R8Jhh4sULF2tTatzvUZs37iVa57yyxmC0xUY9xdRBCeicfIYDqBcNg==
X-Received: by 2002:a05:6e02:13ef:b0:317:36d8:cfc6 with SMTP id w15-20020a056e0213ef00b0031736d8cfc6mr8747450ilj.3.1678808527599;
        Tue, 14 Mar 2023 08:42:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u9-20020a02cb89000000b003b0692eb199sm867929jap.20.2023.03.14.08.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 08:42:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     brauner@kernel.org
Subject: [PATCHSET v2 for-next 0/3] Add FMODE_NOWAIT support to pipes
Date:   Tue, 14 Mar 2023 09:42:00 -0600
Message-Id: <20230314154203.181070-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One thing that's always been a bit slower than I'd like with io_uring is
dealing with pipes. They don't support IOCB_NOWAIT, and hence we need to
punt them to io-wq for handling.

This series adds support for FMODE_NOWAIT to pipes.

Patch 1 extends pipe_buf_operations->confirm() to accept a nonblock
parameter, and wires up the caller, pipe_buf_confirm(), to have that
argument too.

Patch 2 makes pipes deal with IOCB_NOWAIT for locking the pipe, calling
pipe_buf_confirm(), and for allocating new pages on writes.

Patch 3 flicks the switch and enables FMODE_NOWAIT for pipes.

Curious on how big of a difference this makes, I wrote a small benchmark
that simply opens 128 pipes and then does 256 rounds of reading and
writing to them. This was run 10 times, discarding the first run as it's
always a bit slower. Before the patch:

Avg:	262.52 msec
Stdev:	  2.12 msec
Min:	261.07 msec
Max	267.91 msec

and after the patch:

Avg:	24.14 msec
Stdev:	 9.61 msec
Min:	17.84 msec
Max:	43.75 msec

or about a 10x improvement in performance (and efficiency) for pipes
being empty on read attempt. If we run the same test but with pipes
already having data, the improvement is even better (as expected):

Before:

Avg:	249.24 msec
Stdev:	  0.20 msec
Min:	248.96 msec
Max:	249.53 msec

After:

Avg:	 10.86 msec
Stdev:	  0.91 msec
Min:	 10.02 msec
Max:	 12.67 msec

or about a 23x improvement.

I ran the patches through the ltp pipe and splice tests, no regressions
observed. Looking at io_uring traces, we can see that we no longer have
any io_uring_queue_async_work() traces after the patch, where previously
everything was done via io-wq.

Changes since v1:
- Add acks/reviewed-bys
- Fix missing __GFP_HARDWALL (willy)
- Get rid of nasty double ternary (willy,christian)

-- 
Jens Axboe


