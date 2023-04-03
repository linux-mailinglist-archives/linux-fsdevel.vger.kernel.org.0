Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8456D4E74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 18:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjDCQzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 12:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjDCQzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:55:10 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7DFEC;
        Mon,  3 Apr 2023 09:55:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d3so7708426ybu.1;
        Mon, 03 Apr 2023 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680540909;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rMlyMyGAXV0z5XSp7j3z7zp9mBm9G15dE1BDQjwHdxU=;
        b=bosEISgEfdGd9gNK+e3A+56FgWcCYT5jER74Pcqc7gO/KnZ8ObCBY2cq8iDHmysdV1
         9lJYeXHAHNY8vf/RKMIrGYDpZJkVWLaU+MJO7GZIZtY30um97/x3afEZ/SZK6fXWNiaT
         cJbPR/MWm6cON7kcu74SLYWsQa5oi1wZvqF8rt/2+RxFPmioH6/tnGOoSir44Ii7wIZS
         GifZfrCRm75k5xx/WRPn7/XchWFnVBBc1/owhXfw5MAys4O0FRzq0c9Te30BtWWZuScZ
         jXudfAArolpXSXwb/4bJmpFlz6QKptG3//O41YhyN5umPnF+lMiNR+1VT59o9LSwqsA6
         nZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680540909;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMlyMyGAXV0z5XSp7j3z7zp9mBm9G15dE1BDQjwHdxU=;
        b=kTscbyZsFj140csJlLCpQpq6GaeBYGrOBLfa0puJE8ggnT1YetQ1o0LF62HgLN98Mb
         xlu84ULAEl2NMnVTYvOiM+iSSWrMhFcFG4Zd9z4goMaNlNY3woLZ4CGs1Z6mVqO/G8/Y
         4jRGr9hIghkBBUwJ2vzbFaajnPLXH4E/kKDzPy5TW/kSKciTmiwuQjjVANXtBCx0EdfX
         IGsdCO2ewOsjrmSCZFEfQO4uoLDh3RY4MHK7IfdX4CPgW8JCCYFBdhJu366toGgzxWjC
         0pjKzmEe9FKtjSvcHSYdLKWrRrEjdDGrX0CybUwmmQ5s/xYaww5TZkwPhrRS1CarXkVo
         AYuw==
X-Gm-Message-State: AAQBX9eiO/WENOcluEMKPvVUvJWHw2e1okfroIAxBJZ10cx1XnWBmZip
        rdLZoEqiFOgDZ845rTDkyyKzEAAX03GsHZN4BpqRLbv+Hece/A==
X-Google-Smtp-Source: AKy350aUUNo2n+WNF3q2RMSZ0x+sRA1uHxlbAoCwHryV90v1ngfbP44KPIfhD8VJpynhgfJqBs64RmoGeYVx2lDivdE=
X-Received: by 2002:a25:688a:0:b0:b46:c5aa:86ef with SMTP id
 d132-20020a25688a000000b00b46c5aa86efmr19051459ybc.12.1680540909346; Mon, 03
 Apr 2023 09:55:09 -0700 (PDT)
MIME-Version: 1.0
From:   Askar Safin <safinaskar@gmail.com>
Date:   Mon, 3 Apr 2023 19:54:33 +0300
Message-ID: <CAPnZJGB2fyTS07W4dzSPUbGm9R_27bKL4UamLb63g1PCQJHTOA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] fuse: API for Checkpoint/Restore
To:     aleksandr.mikhalitsyn@canonical.com
Cc:     criu@openvz.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches seem to be related to the well-known suspend+fuse problem
(see my comment here:
https://bugzilla.kernel.org/show_bug.cgi?id=34932#c12 ). Still
reproducible on modern kernels. Please, somehow address this
long-standing problem.

CC me when answering

-- 
Askar Safin
