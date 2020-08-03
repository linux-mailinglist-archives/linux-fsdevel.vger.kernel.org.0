Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8F23A8D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 16:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHCOrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHCOrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:47:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B74C061756
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2020 07:47:44 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a186so10111450qke.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jSEcpjJOquc529ZwoycPhflNQKRcL97Z3GUPK/MTFhg=;
        b=NGJ+cGs/7Y5yanvxauvBQNlpaQtun8x5OXswBR95fjESI+Q1GyxIm26mBIJiQZlchx
         DnHpQPnaiAYiQeJ7fbILu6QdY5Rd11V8/qKJe4l/2w1iWVLomfjMRhY7F1HbDB+a88/v
         OxW7fJVYu/9qupGnZQbIDl8RQ39QYHWJjpj6Y7eEVD2A8NOnmSLcJvTqsh8RSUHTZPrm
         iB78LpIkLOgboZguy+rRN/6HLRUkZASiQtIdBkfmKC7u09IfxeH6wtHsiiiO6m7p/yy5
         JixVWy5wqO/esbMdb7V3i86xLFulz50ivT2vhoOcOZ+NFnlgeqV1YkGRMJJ5EjFVX0il
         hJDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jSEcpjJOquc529ZwoycPhflNQKRcL97Z3GUPK/MTFhg=;
        b=PISUDw1ykVr57lQTIbJGqkYYGyet2u73zwCnQyhR0IG9WD63AZnBk2ZDru0XdQ8Umb
         pzLt4llFkytqvX+wgAt5+NCaxONgb682cnfu54F8g9kUpQjqPzXBrwIpHFmUewMrcfpl
         gOn5aeeg5nfvI0WbkBbCYADTbb/yWF5Su70+S0nb04wrZrsvonDDxOd6xlRjS/n1XXEZ
         JmV7y2fsOwJTlBy2S2/ko9rlDoNiODhkAcELCQqgwepThyHKs/E/8pDTwKzbajHFTzAy
         U04dL7P4GKyxpDSS3U34tHlk2+WuVFk5+RjXmEHBn6BjU2BDb6PcCqbAe/9mddZuxnlj
         vkEQ==
X-Gm-Message-State: AOAM531L2WwX/4qyBnV9DUIX4OXrj1kJ7ZKi+pA6gMd/9QLaBieQsUyz
        0eXNVxyew5gi3pT1W9BYQGIRYRuwf5yYDrMMcw==
X-Google-Smtp-Source: ABdhPJw7sHEqkxXBQdZEh6QBRcoghAHfysqJXJXhfAsQDkKtCR//v760mqThiImnXfcrSB5dpdxJ6/pM/TKRNguNpQ==
X-Received: by 2002:ad4:4482:: with SMTP id m2mr15332118qvt.102.1596466063346;
 Mon, 03 Aug 2020 07:47:43 -0700 (PDT)
Date:   Mon,  3 Aug 2020 14:47:17 +0000
Message-Id: <20200803144719.3184138-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH 0/2] Per process tracking of dma buffers
From:   Kalesh Singh <kaleshsingh@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Ioannis Ilkos <ilkos@google.com>,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since debugfs doesn't have stable abi. This patch series enables per
process accounting of dma buffers using trace events.

Kalesh Singh (2):
  fs: Add fd_install file operation
  dmabuf/tracing: Add dma-buf trace events

 Documentation/filesystems/vfs.rst |  5 ++
 drivers/dma-buf/dma-buf.c         | 29 ++++++++++++
 fs/file.c                         |  3 ++
 include/linux/fs.h                |  1 +
 include/trace/events/dma_buf.h    | 77 +++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 include/trace/events/dma_buf.h

-- 
2.28.0.163.g6104cc2f0b6-goog

