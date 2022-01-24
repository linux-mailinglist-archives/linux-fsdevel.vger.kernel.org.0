Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9064498826
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 19:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiAXSTx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiAXSTx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:19:53 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0359BC06173D;
        Mon, 24 Jan 2022 10:19:53 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y27so12647179pfa.0;
        Mon, 24 Jan 2022 10:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+REnE2qytEWXveNoQywafEUjqB6EHdYXNAl8aiO2sig=;
        b=Cz3lMY6//KFbU63smgPcLM+GODnPgF4odFx+So3Lajyd5LEskDLnjvXWuI7nss33Hk
         zQSTc9HBldxBcVlC8sxMcX7sbppZCOo5ZRkZQ9oJqG8Qp50w7vBlpxABtjl2sLD99uKm
         yB9G6REjFhxd6AvLyRTFvTc1hEjEOwPwBDHX9+GnneY5SnydxXdNyfkFycXc5hHoNeBs
         7Hwdb3V+jbjcILLr9nl9BHP+4J/x7q8r0DZn2vuTzZp4/oMgZbg5DFQ3qC0PLsgRIfFJ
         4wNky5jfc5HxX7OC/tX80PL5SaKl3cXn73gHQG37QqS7v6bHg16pcF4vAX0PzWMIIyfK
         FloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+REnE2qytEWXveNoQywafEUjqB6EHdYXNAl8aiO2sig=;
        b=cjL6cUfm9iOu/m6DV7bTGcMYpZlrwhMS4zKdCp+YVNj3amUQJtCFs0GjmYsVVAKnmj
         DYNNLWeUCBDNcixLxxZvL2ZNt6pAOGluppEs0r1VKiYOTbG0E2L7SKe9pnMKrYlb8/HS
         oXwx25nD6WJ81czKQ/TGattiPI1PZ53WGzPvX5+zPN8hCJKbtA/xr5J/eh9YLrRzhlUw
         wCkIGk3OwIRDAhbtEtKWYW8i8Tc0+MT+xZHeohbvL6b0nWIUzLLtlE0sJizn2Z6aGyw+
         b+N86Pa9gMmPtenmFJPHwAEyWjmf76CANk+23UFTudUuH1mjICJK4o7X79/LsfAupmo5
         uLuQ==
X-Gm-Message-State: AOAM5316Xcd+eAqpbVz5JRTem3PICsFnzrLAwsWebHw+lVGIAu0of2GJ
        0CQ5t/UwWRE8NnONSdeosHg=
X-Google-Smtp-Source: ABdhPJyNXz5OdJkMZleUKSbRwjATaHr1oaZvzDyiJqA4ALBnhVTdx6LLPpNJIIB881p6u4Q5oKP3RA==
X-Received: by 2002:a63:9347:: with SMTP id w7mr12521229pgm.84.1643048392218;
        Mon, 24 Jan 2022 10:19:52 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id ha11sm366667pjb.3.2022.01.24.10.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:19:51 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH v2 0/2] Fix regression on binfmt_misc
Date:   Mon, 24 Jan 2022 10:18:11 -0800
Message-Id: <20220124181812.1869535-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
References: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series fixes a couple of issues introduced in the previous
binfmt_misc refactor. Please see more information below.
Thanks,
- Tong

Changes since v1:

  - removed check from binfmt_misc to restore old behavior per Christian's
    comment
  - modified return type of register_sysctl_mount_point to fix CE

Tong Zhang (2):
  binfmt_misc: fix crash when load/unload module
  sysctl: fix return type to make compiler happy

 fs/binfmt_misc.c       | 8 ++++----
 include/linux/sysctl.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

