Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081D5416B8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbhIXGYw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 02:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244241AbhIXGW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 02:22:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EACC0613DE
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so8876428pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MqGP9LMqqJMGAy3sQl4mgX42672AKmlBIPJNVCl2PBs=;
        b=fTqcY+WsERdzoOPpvaTo8qpxFm0CbD6HPGeTwGvDQoNnm1Bj6ql6u3jWOWXFf8Fq7F
         Q15KwMJ9DUrdFKrJGl21YEufa2x6M7w8LcvOloHVNIfj3nuGzlBpb+fWayG49TGZH5w9
         79SLY5uWot4z27tUNwy4rcdqHKHBTLaKcGY9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqGP9LMqqJMGAy3sQl4mgX42672AKmlBIPJNVCl2PBs=;
        b=TkLr+xWKiXZ88yanKlj7/R6LWGML3KmKQDVCrI6NWns2vEcyezhg1v9+YsM++hY60R
         x/9KRYaUJVfIIyL8miiump9BA+bN9KC41kdxeufwMkbyIMNQyscQ9mQ06Eovydhg6jZy
         KC1vjxzY7WjiV8kh6q2375QgHIesWyMv9wB5FdlEeK1y2ePVqZalImPkoDiLPahVZr53
         BEFzvo/flnmmalJykJJTCtRc2/fKuv9YnfIWRfM0S3whx+4G6RsDlfNqr1ii6QR/Pigg
         1933pAdiSRQkLO8kLptjMk/ZHU7v0G8+MKang1JkMNehIvmrNXqc2YBL4Y1o1Ib6+v0Q
         ssFA==
X-Gm-Message-State: AOAM5307LDSsPixreDaXXdzFrHW/dsyqoKtT95URvzRUzJTDJB4uq86O
        kAktJhsHJc0CtlnH/pnd8BFeUA==
X-Google-Smtp-Source: ABdhPJwfJZj2ZbWFQDmuxHrN9k1j5ZMHPc7UQuTGrEfZedlEiAdefUF+dDKuiKtIpbE3+wgAw8Mf0Q==
X-Received: by 2002:a17:90a:c982:: with SMTP id w2mr283172pjt.30.1632464417963;
        Thu, 23 Sep 2021 23:20:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mv6sm7119740pjb.16.2021.09.23.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:20:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Helge Deller <deller@gmx.de>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Stefan Metzmacher <metze@samba.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-hardening@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/3] leaking_addresses: Always print a trailing newline
Date:   Thu, 23 Sep 2021 23:20:05 -0700
Message-Id: <20210924062006.231699-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924062006.231699-1-keescook@chromium.org>
References: <20210924062006.231699-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; h=from:subject; bh=5lftZQczWL2NYn7i81/S0r7+lfWbje0junTyfy2SMv4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTW4WqXBX8L5MwMB+PTMTeALNE3r8NpP8q4VzKbwS JIaNQbKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU1uFgAKCRCJcvTf3G3AJjsmD/ 0WuSkZwR3MGbYJDi4shdfA9ea0lTwo/tRcec1N+TaYDy/KTm+u1jXXMflO6EhMp32CoU0ioyG/x65p 3cdwzReovQO0YCwmOIAqf2F3IVn0FIRFh9fpBzOaZO35CiblK8jY6Sr+yopgV8yFw38C6TFPyxxFbX y6wMUbhtPEQR0i9FXwWv5GE2jayS2KDQJoJqgtJWzoi6MvYe8rqpy9bz+bJpg1fEMJdW3BwHeEtZW0 IeApnzknnnAfpfqTuQjq57P16eTsfQHpxIo46RkvtCfD5P56WP2VBp6VwruecAr3NSHzSD1Gxuh+vx pQDuXFagqcqmzlKzoUmAYkuuA1nSPoYra9FrOfYU+Hm2oJPl0PdzATH1TSAC4aOj1cvoFAB2TQWEHs H5sgt1jY7Xl7ywhgkZbcfaWxJpqWc83Rc2A6Xz9z60JFbFYq05EIpiXrxXys4fyAq7x9+HhKCHWJFy 4TX1ggdfIcR+wpXYm9xVv/I1bVtVcOjebcKApPtFrS4md0wAASDyN4+Ly1nxaK+Kigz3sGv9uExmP1 fryIdiZOMWL7kHOizYjbm1v1BvU3X1GBPIgvDq9RF7B1n5dyffkQeL5o1YHkuKTfv/H5vRmnfZ10zw kYBbLF+yKczyv0rDwse0oGg7c+hKDqq77KqXlBAq1JVe/IgvFllZ2fMNol4A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For files that lack trailing newlines and match a leaking address (e.g.
wchan[1]), the leaking_addresses.pl report would run together with the
net line, making things look corrupted.

Unconditionally remove the newline on input, and write it back out on
output.

[1] https://lore.kernel.org/all/20210103142726.GC30643@xsang-OptiPlex-9020/

Cc: "Tobin C. Harding" <me@tobin.cc>
Cc: Tycho Andersen <tycho@tycho.pizza>
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

