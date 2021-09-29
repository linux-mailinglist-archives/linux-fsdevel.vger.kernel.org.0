Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B802D41CEAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbhI2WEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 18:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbhI2WEG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:04:06 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6284FC06176C
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bb10so2529453plb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Sep 2021 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QzeUoqKUKdU45cYdDidDgQLqIck3N8SW7XLzzdbDWQ=;
        b=BOsK5j3gBTuXIo4JAyKTKnh5Y6FqjY5O6nb39X3/BEMzlOW69S8VBg9/Cyx402X0uC
         VX/hFTT8z3UwyDNLpYNgGyCtbxbAIco+EprvI+J0pXmbFfnxT/d78RlmJLnQ11mBalcR
         O80GyLP+BQjIy+cE6RbaI87yF/Et808MUydXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QzeUoqKUKdU45cYdDidDgQLqIck3N8SW7XLzzdbDWQ=;
        b=aMnJow/ejUORKvzDXHdRGddRee0e65zG6bLwVkQwtERifUpgcbT8h2+Sa1Wd62E++f
         139JRFXYoCEREdODnTYkXG0ifPkVcbIgAebzQJ6TVAJTqNlO2Ri3mF5W9D+SVxFt2wjl
         NLf9qTt5kLyY9IX6ex4IkDp5JBrHXB9d+xV6JCaAcZv2+WqDYbi782r6WJyU6UfSVkVs
         LrXgECcjFowAEJyBioAqCVrzkBhUpR6Z9zqorz7Ma6DPAip4buihTMFWmlDeEenPg19E
         x2ECLBwi9uFFoXmd6VuqLYwCvkrDPCKXCZc5E6jwimLNaclVxkEKev0Kd04vDF1b3R6c
         oKhA==
X-Gm-Message-State: AOAM532MBxxnejUJFmWebmuNmQXBGNI1sXGPXzhEKH7XKhGQUJmiMryR
        MbgS0GeG2rTmDFo3wm6BRd2D4Q==
X-Google-Smtp-Source: ABdhPJyYAgg64aWsOOg387OZcNjUHpe2vAG1a6SQuAqSkmq2/IZophCGC6DN2YrUFepeRzTUc2Qvrw==
X-Received: by 2002:a17:902:d202:b0:13a:709b:dfb0 with SMTP id t2-20020a170902d20200b0013a709bdfb0mr2069664ply.34.1632952944925;
        Wed, 29 Sep 2021 15:02:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2sm576691pgd.84.2021.09.29.15.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:02:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-hardening@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anand K Mistry <amistry@google.com>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Alexey Gladkov <legion@kernel.org>,
        =?UTF-8?q?Michael=20Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2 6/6] leaking_addresses: Always print a trailing newline
Date:   Wed, 29 Sep 2021 15:02:18 -0700
Message-Id: <20210929220218.691419-7-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210929220218.691419-1-keescook@chromium.org>
References: <20210929220218.691419-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; h=from:subject; bh=gRG/Q2MrocgVaHNX+D6+wn0nA1KaXO0grvA92z8kHco=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVOJpJCOqg+W5SWXrgp1mr8bnFhnfCdWico8ZwiP5 /UURmdWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVTiaQAKCRCJcvTf3G3AJh9EEA CGh7l0IuvGKvTlNBIftnvwHCcGybMPaL+NoLj8Q2pXBA286EzXeLUQMmzKYZ8Nd9Nz2b9zwZkYGFRn PD8E1mcA5i6fvu1E0EnKJhbDAdHu2HrYMl6sQbDO7ktRye0z9jfjZ5VfiXQkY+EqKyoz7DCwn04XDr nMHuX2tbkdllWdOu8RKgWHg5WiCl1pp8gfuvx3HD0cAx/Wmbml34p/9tSmWXZnxgLKdkrpyme7jiwY lQxgNRV3i85T6cdRJIa9oIrU8GC5UGWW+mb43gH0xJC8rCj7WTZ7TtsfR18cQDwqyxRanWyV3v88sX 3VHTBz5vZe/nZ/e42QZmevNF/CtrpFcN4lYBc2oCEcdMcP2/mTy9ZZpGD6fGzjauMPq3et29rhgaai ulI53iwA+nb45Ws2ySpyuTPH0+I2YRBOhTr3lpxIoYq1NN8UqvWUYdhu1JoV4DGiVxqv6qrOBNyIiV vjtDjdVlLIXK/PlarcJ6tWCNYQmJmhS7d+BALx2PAmCOx67kEdCxKwTIJs9VJ6ETDPUORKDTR1bnod qMHp3dMi2rSDxypc+un39fnjpynqpAO4GHycrr55/PQkJJ1MO/Ttp8264Njz8ekWOv4EBIsRCLKdEu ibXp6FkICQ7j4zsLYQN9LiqRuG9CTkBP2B83gbSNTQSmQ+gu+KfS3wGGABrg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For files that lack trailing newlines and match a leaking address (e.g.
wchan[1]), the leaking_addresses.pl report would run together with the
next line, making things look corrupted.

Unconditionally remove the newline on input, and write it back out on
output.

[1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/

Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/leaking_addresses.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index b2d8b8aa2d99..8f636a23bc3f 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -455,8 +455,9 @@ sub parse_file
 
 	open my $fh, "<", $file or return;
 	while ( <$fh> ) {
+		chomp;
 		if (may_leak_address($_)) {
-			print $file . ': ' . $_;
+			printf("$file: $_\n");
 		}
 	}
 	close $fh;
-- 
2.30.2

