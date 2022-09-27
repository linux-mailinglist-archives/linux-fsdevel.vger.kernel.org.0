Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965A25EC42A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiI0NTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiI0NSm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:18:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E818359;
        Tue, 27 Sep 2022 06:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AD6961977;
        Tue, 27 Sep 2022 13:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A25EC433B5;
        Tue, 27 Sep 2022 13:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284623;
        bh=YX50CyMPv+QeqZWeqvuQdIqygaaBPbt0G7syFQ3oahg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSBzagRif/7KEuNh05bndddeO+IfQxgSIk6P2IK8UZyZvI4sQyAtEsQSZA4S55ZLX
         ELxaf43a1qqiIhX2LO0LzDukDzcVXPyTqW4YcM8hEMWg7XhFwn2TFO5SdAAnjoDXva
         e1KVrKlegJbH3mZFAKyNm+NHIZZGUhxm8gauPpQvKOoH9nMAnzF7sIJNWuc7yVevSc
         /JSu8iExkaYUEeGnd5qCoIpIoeBfDdsgr5M2Is7IP2XDjxugJhbEVmBbvwlvBK+BbB
         63Saq5SkGdnapglDVfGciTriJ2iZIZOR81X90zmwyq5n633HU2H8MyfUDfYMq64pHL
         x5i5M8ijnlIrg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v10 15/27] scripts: checkpatch: diagnose uses of `%pA` in the C side as errors
Date:   Tue, 27 Sep 2022 15:14:46 +0200
Message-Id: <20220927131518.30000-16-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The `%pA` format specifier is only intended to be used from Rust.

`checkpatch.pl` already gives a warning for invalid specificers:

    WARNING: Invalid vsprintf pointer extension '%pA'

This makes it an error and introduces an explanatory message:

    ERROR: Invalid vsprintf pointer extension '%pA' - '%pA' is only intended to be used from Rust code

Suggested-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Co-developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/checkpatch.pl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..74a769310adf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6783,15 +6783,19 @@ sub process {
 				}
 				if ($bad_specifier ne "") {
 					my $stat_real = get_stat_real($linenr, $lc);
+					my $msg_level = \&WARN;
 					my $ext_type = "Invalid";
 					my $use = "";
 					if ($bad_specifier =~ /p[Ff]/) {
 						$use = " - use %pS instead";
 						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
+					} elsif ($bad_specifier =~ /pA/) {
+						$use =  " - '%pA' is only intended to be used from Rust code";
+						$msg_level = \&ERROR;
 					}
 
-					WARN("VSPRINTF_POINTER_EXTENSION",
-					     "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
+					&{$msg_level}("VSPRINTF_POINTER_EXTENSION",
+						      "$ext_type vsprintf pointer extension '$bad_specifier'$use\n" . "$here\n$stat_real\n");
 				}
 			}
 		}
-- 
2.37.3

