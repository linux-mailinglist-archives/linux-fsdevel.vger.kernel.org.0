Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD28343686
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 03:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhCVCEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 22:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCVCEF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:04:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D89C061756
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 19:04:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x126so9915104pfc.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Mar 2021 19:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x65YhMq/iIE/GtERdS4jdT1t3LPDIu95hEMHpqLewfQ=;
        b=XrTYv7S7ygcocSpP6b76OaPDTYkOI7KCPq5noz1URQ5UN2wYHWrpq7jNy0TJzxQDlT
         NmofbH+Ev4puboNp8o4V0J3FkTu+LguHsb41JsVdoEiTuXlkclSb0Nc7dfEVm9XW2K0f
         3sZ7tsQcgR/mOoHZQdMSPDvLIvj8Y2pQ2N/gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x65YhMq/iIE/GtERdS4jdT1t3LPDIu95hEMHpqLewfQ=;
        b=tbLp9VCehnMPVuhBl3QTz1vaaWvzfVoyT0R3inP8bvkZX9a1Nqno2YoJATtvjy83kZ
         cqTfUd2WTC3144IuXSUdrMXAvmmW4jz59Mnk1N8AfevLiNAW1xQHulRbGfNz7sNn8Ad9
         0VFk2Ua0o37b+tTV8VlEkCfLYgIy48G8RxySBVzwCWLPdpL1xh0fQa8M9k+IgauJWoR6
         un7oO5GWWNcHfmFYm8x1SDW6jmxkuaKLrlPNcLMCgjLZD1Dl+prsaiGUFlBooND+M/PU
         8D4Uvr4HAFQAy9+QTw0tr4DLVyFitf+e4FNPzWF0aYEzBnJYSGTJJ9dBuOedbW7UdMY/
         PdtA==
X-Gm-Message-State: AOAM530j6mTEb7dpow4MUa8tJweblO6nTgHgPd5V5cFoxNjrWw5X1cg5
        nngcoU+7+b5pPGHvZG6+IUWIvA==
X-Google-Smtp-Source: ABdhPJx83QBnIf0wj61XqsgP/x34LyD50kxnYCMCY7mstz/EnXTszo1slqBcQBUpu3OnflBed+k9Xg==
X-Received: by 2002:a63:4845:: with SMTP id x5mr19891695pgk.315.1616378644662;
        Sun, 21 Mar 2021 19:04:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e1sm11649000pjt.10.2021.03.21.19.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:04:03 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>
Cc:     Kees Cook <keescook@chromium.org>, wad@chromium.org,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        gladkov.alexey@gmail.com, avagin@gmail.com, paulmck@kernel.org,
        elver@google.com, a.darwish@linutronix.de, amistry@google.com,
        linux-fsdevel@vger.kernel.org, andreyknvl@google.com,
        samitolvanen@google.com, michael.weiss@aisec.fraunhofer.de,
        rostedt@goodmis.org, peterz@infradead.org, luto@amacapital.net,
        rppt@kernel.org, shorne@gmail.com, adobriyan@gmail.com,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH] seccomp: fix the cond to report loaded filters
Date:   Sun, 21 Mar 2021 19:03:29 -0700
Message-Id: <161637860542.4053241.2227340233601035129.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <OSBPR01MB26772D245E2CF4F26B76A989F5669@OSBPR01MB2677.jpnprd01.prod.outlook.com>
References: <OSBPR01MB26772D245E2CF4F26B76A989F5669@OSBPR01MB2677.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 21 Mar 2021 15:52:19 +0000, Kenta.Tada@sony.com wrote:
> Strictly speaking, seccomp filters are only used
> when CONFIG_SECCOMP_FILTER.
> This patch fixes the condition to enable "Seccomp_filters"
> in /proc/$pid/status.

Applied to for-next/seccomp, thanks!

[1/1] seccomp: fix the cond to report loaded filters
      https://git.kernel.org/kees/c/15a2fd51384a

-- 
Kees Cook

