Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F2D4A7089
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbiBBMOm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 07:14:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36552 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiBBMOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:14:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14876175A;
        Wed,  2 Feb 2022 12:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E59DC004E1;
        Wed,  2 Feb 2022 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643804081;
        bh=VamCilcq6wjRLI++9tndqd2QWBVCTYmYLwnJvqufanM=;
        h=From:To:Cc:Subject:Date:From;
        b=AxKPNTcuOPsH/976c+Hz4inrrO5DYWTjo1ZEKLBpv79Y3+3u/8SKLdftiiLP6NBQh
         mo4uVe8H87/2ZIs9EZ/CiQkNV6SVgIOEWsRzAajm3zyWGCERVGsu+Gh93l7508nebM
         fPDNRIg4n7X1Cd5R/r+VdhXzJ9EggykWxk1aGEZJMpXlSEhtOvl06YwQF4AhEsvLYo
         fzL1gh1ctKrANsobFSnHfotqElk68RUZstxA2L/5q15YxY2Kaq3GcfDHTbeynftoTi
         BVoio3t3Yk3zlHdmxhqC7aED/xDjEtuMir/Gtr4qx+39jfd8ci6NlCeHI8j6hhINSg
         yVVpweu9wY1AQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/binfmt_elf: fix PT_LOAD p_align values for loaders
Date:   Wed,  2 Feb 2022 14:14:33 +0200
Message-Id: <20220202121433.3697146-1-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Rui Salvaterra reported that Aisleroit solitaire crashes with "Wrong
__data_start/_end pair" assertion from libgc after update to v5.17-rc1.

Bisection pointed to commit 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD
p_align values for static PIE") that fixed handling of static PIEs, but
made the condition that guards load_bias calculation to exclude loader
binaries.

Restoring the check for presence of interpreter fixes the problem.

Fixes: 9630f0d60fec ("fs/binfmt_elf: use PT_LOAD p_align values for static PIE")
Reported-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..9e11e6f13e83 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1117,7 +1117,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
-			if (alignment > ELF_MIN_ALIGN) {
+			if (interpreter || alignment > ELF_MIN_ALIGN) {
 				load_bias = ELF_ET_DYN_BASE;
 				if (current->flags & PF_RANDOMIZE)
 					load_bias += arch_mmap_rnd();
-- 
2.34.1

