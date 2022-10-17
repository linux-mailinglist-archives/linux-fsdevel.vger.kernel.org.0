Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949FE601344
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJQQSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJQQSG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 12:18:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9E6CF44;
        Mon, 17 Oct 2022 09:18:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so11454007pjb.2;
        Mon, 17 Oct 2022 09:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPOgLKtqJqc/KkUndkqLjqrqFd6Qi0PDVLbeuKh7FTw=;
        b=q4cfhBfNy4i8qzlQX6+OteLtFU9IPky21iCQeSAduA33cWBF/akGv01p4X2WqaAypq
         Qz9U3QYo9P17o/x1Wnj5iIuERGQJvlMW5/jyUthYy+SNEesjFzSnYy6uw5cgR1qPoKTc
         Ekn9Y0Oaatou+qg4G0Eaxf7nxzxpZmDH796Qamf9kkTd2ptegwWHOo+bpOHjBYZx5NOp
         9Ci57iNswficoBuLd6IX2pDr7uStAaWB+K6W5ISfXQ+xVI0D0tzRJBPUBgs5igMaa7Am
         ZXRfdFClTAuFsgKi8GPPg5O4Ocon3+Bh8simIG5nuTt3/bDWk5eKXuim1Y8+yy0d6/Ue
         QKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPOgLKtqJqc/KkUndkqLjqrqFd6Qi0PDVLbeuKh7FTw=;
        b=H/P5Lstv8FSX1G8ZPwZpFxA3az55C2VpyoJAwL9vTrAv3YBXmNIixjDy8RucXp957B
         3wmuMeRx85BN2EAQGwN6+sx9a2Mh9E6NlWkcaUqhtXO1QlFss1bO/NnpEe5406XWPEVY
         pnjLg7W5MFqblEM6rKRRL4l5VTMphs4O8nrwXzkZZ+/OUhXXNsMfzMpNyXk86kf/bC0z
         gSjBbRPCH+OlpMPaVRFoD1wro3m36NamOXeb8XAPc9+i0kMG0zvPsJg/2gmErve7lNFp
         BHgN4Y/hG1oBoQMuIWJ6EeSfNTrGZB3lVdeSbALwPtVYx/GMbEsqp0mFtW4Po04k9LSE
         BkHQ==
X-Gm-Message-State: ACrzQf1YOcCOjllaRPP2az0Neh/TghNoUBXmvkf/53rYx0UEHwxZbNWT
        x9t2sz8yjP94rhEYB1GNnCo=
X-Google-Smtp-Source: AMsMyM5TTPDWNe4izGZlGnC0+XsuJnNJBl+hb+FP55XZjAsmo33n/GD+2CnVAKmNDEFYy4AdR882Dw==
X-Received: by 2002:a17:90a:890b:b0:20d:981a:a5b5 with SMTP id u11-20020a17090a890b00b0020d981aa5b5mr30088023pjn.186.1666023485280;
        Mon, 17 Oct 2022 09:18:05 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id z22-20020a62d116000000b0055f209690c0sm7272326pfg.50.2022.10.17.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 09:18:04 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hughd@google.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 0/2] Rework find_get_entries() and find_lock_entries()
Date:   Mon, 17 Oct 2022 09:17:58 -0700
Message-Id: <20221017161800.2003-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Originally the callers of find_get_entries() and find_lock_entries()
were keeping track of the start index themselves as
they traverse the search range.

This resulted in hacky code such as in shmem_undo_range():

			index = folio->index + folio_nr_pages(folio) - 1;

where the - 1 is only present to stay in the right spot after
incrementing index later. This sort of calculation was also being done
on every folio despite not even using index later within that function.

These patches change find_get_entries() and find_lock_entries() to calculate
the new index instead of leaving it to the callers so we can avoid all
these complications.

---
v3:
  Fixed a typo in commit messages
  Shifted calculations to after the rcu_read_unlock()

v2:
  Fixed an issue when handling shadow entries
  Dropped patches removing the indices array; it is required for value
entries

Vishal Moola (Oracle) (2):
  filemap: find_lock_entries() now updates start offset
  filemap: find_get_entries() now updates start offset

 mm/filemap.c  | 28 +++++++++++++++++++++++-----
 mm/internal.h |  4 ++--
 mm/shmem.c    | 19 ++++++-------------
 mm/truncate.c | 30 ++++++++++--------------------
 4 files changed, 41 insertions(+), 40 deletions(-)

-- 
2.36.1

