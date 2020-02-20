Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFD165781
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 07:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBTGXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 01:23:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36968 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so1399114pgl.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDL37BgDk/5hTL1aygm8F5m/3WsNy7EX3MegTZpHh8A=;
        b=hE28D14boNTmJ1vj0aiii9wgqR4x726AYt0+Ugz1vZZxyNY/ZjRyjStYJ/E86o9UZQ
         m+ILEBowROnzV6IEZacRqVHipZV2ubqx1exLZGnLz532+kkOuDI07VE0085ZhhSVT6BX
         PBBz06hnw5jDBaa5zAzGTaC7k047+cizE829A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDL37BgDk/5hTL1aygm8F5m/3WsNy7EX3MegTZpHh8A=;
        b=qe2OLB3rg40E/bZ+V/5itxkXZL9dpXtRLAipO85CnCNi/qtFpJInSoaAOmpN8Ir0+k
         2/48qePyEo2ZRD9vOTZymFTg1zSORiEap+56cTHYXd73JdoONMFuiw3PddtDnxRjpfs5
         bRCsBY1VdscLxR8dHk5nq2IAXdMeBeBRbFjMJlEI1B0/qCvqnh9soG5Mm75L1y0xGdgU
         ZGtm2f3sILZsbNh6t+P/h85OyMD7HmraJIcH+hqcFtmLor2U5/OLisEGzObeEbklrMur
         Zr89stwm5ePJPv3pEQ5d9RsQIPd7MzmmO/Hj+6jJ8ZKdSK1CYecZEA12bPM08LXlvFhb
         9g+g==
X-Gm-Message-State: APjAAAWVkFSLp7j0gEpHBrna5FxNS35JC96O0IacCz478D38GnVVGfcL
        /dvRnglL/uIbH/T743xn0h4muJobSOk=
X-Google-Smtp-Source: APXvYqwClzmaR771bSUMDQ76QXcQ9gHM+Y7s77UVkVWl9nHyOMS3rkIB6M1k/7iT21xhJ1goPJEBhg==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr30460282pfc.179.1582179779343;
        Wed, 19 Feb 2020 22:22:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a35sm1886088pgl.20.2020.02.19.22.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:22:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fcntl: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:22:43 -0800
Message-Id: <20200220062243.68809-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

fs/fcntl.c: In function ‘send_sigio_to_task’:
fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
  738 |   kernel_siginfo_t si;
      |                    ^~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/fcntl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9bc167562ee8..2e4c0fa2074b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
 		return;
 
 	switch (signum) {
-		kernel_siginfo_t si;
-		default:
+		default: {
+			kernel_siginfo_t si;
+
 			/* Queue a rt signal with the appropriate fd as its
 			   value.  We use SI_SIGIO as the source, not 
 			   SI_KERNEL, since kernel signals always get 
@@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
 			si.si_fd    = fd;
 			if (!do_send_sig_info(signum, &si, p, type))
 				break;
+		}
 		/* fall-through - fall back on the old plain SIGIO signal */
 		case 0:
 			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);

