Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEF6197C12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 14:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgC3MhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 08:37:12 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:54278 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgC3MhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:37:12 -0400
Received: by mail-wm1-f53.google.com with SMTP id c81so19748755wmd.4;
        Mon, 30 Mar 2020 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/7higiBp8m8zEWus6g7LwOrycKN3KCg2+w1BuqcejLM=;
        b=RGI56L5YiZA4CQQFn1Qym7Jhzs4NviUr7qD9Z2wFzQvFV+d0yl9lSv5M1ek3x+PGU/
         oKflYlGfeLuv4qvBLVysI1IF1Kko7avAEL7RsQOto4VAUnytlVy8EAfspqUVEIPk0Na1
         /+ZxFP5ORNwP1FTrtCv98mB23qQQyUvg4Y7zfwPfyg4dE0JpacIZOF+E+L9WTJ7GaSSt
         pDN+ne6lf3oTmh+n/pTj1no/RFwEhkCXxSOj4fIhs/KB7e43AafgfxZpMPSvsk/6OlUm
         NdFM1c4U0COF0RLTSUkPCMoPTUXSDqWtxHZaFFAUp2fZ37NN57wy0qc6Q8VDlLXUm6uD
         50hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/7higiBp8m8zEWus6g7LwOrycKN3KCg2+w1BuqcejLM=;
        b=go+1o7RTyaEoZdNaUhQRYxAHMlHC3QEQsEEzCUWRdgnxThcZBxnVw5JBKdb5X4eZxi
         SUEmtvcM2urCw9PYRdnhDSQ82/nwFI5bh1I4sw6odufdRtqJKPSQmxdJTbuHO4MD/SDe
         4ZZ9MAZ2l4PJjAgyskQQnPbMId0eUD69x5v3P02iy5TDr/N8nAhuXWtR0kgrio95dAMe
         F3C6fIBMqtD6mmCW83RYWGOEOOZ2t6RNW6SDfOCVi7fF9UR05cg1DXyyJkjFRBctz7Sa
         AtIVSEwRSJiqCTPYesgtB2Qyakgo0eV3ysVJ79yxjtl0KtY54cxaVOmKqt/+JKcYuxhI
         6Q9A==
X-Gm-Message-State: ANhLgQ0psUjvsN5Li22RTfkFX5x+WwQRMaZxxUXKNf0PHnNdrtsZh1UO
        EpPiedlvnN1bIKI3cfZ0fAw=
X-Google-Smtp-Source: ADFU+vuNF1yH3slMRPssR7hBdoYw6J2VdCQ6D+ACSFa5Qw4S1cGd17eKLSF8L5XGdFYvus6EM02iPA==
X-Received: by 2002:a7b:c39a:: with SMTP id s26mr1929612wmj.167.1585571829783;
        Mon, 30 Mar 2020 05:37:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id z1sm10091858wrp.90.2020.03.30.05.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:37:09 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 0/9] XArray: several cleanups
Date:   Mon, 30 Mar 2020 12:36:34 +0000
Message-Id: <20200330123643.17120-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Trivial cleanup for XArray.

No functional change.

Wei Yang (9):
  XArray: fix comment on Zero/Retry entry
  XArray: simplify the calculation of shift
  XArray: handle a NULL head by itself
  XArray: don't expect to have more nr_values than count
  XArray: entry in last level is not expected to be a node
  XArray: internal node is a xa_node when it is bigger than
    XA_ZERO_ENTRY
  XArray: the NULL xa_node condition is handled in xas_top
  XArray: take xas_error() handling for clearer logic
  XArray: adjust xa_offset till it gets the correct node

 include/linux/xarray.h |  6 +++---
 lib/xarray.c           | 31 ++++++++++++-------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

-- 
2.23.0

