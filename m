Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5511D40FF3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbhIQSYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344423AbhIQSYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D11C061767;
        Fri, 17 Sep 2021 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ip6/d0KVA5eLYOz78z8ZvhxQLMpGbc01h5vuLB6lJwU=; b=XDy3LOE+qcr1jRa3cO8f3cX+We
        I0PJsDXoJ5bfxBw5UYGmyFpaJzcKUp6A/RYLVNfLLGnR833Bx80TUGcGkGuWxAl9FixDCTq96apkg
        0j2xcy0BqvuZV1Xw6E1kXNg80vjs8Gir4EOKQOUGLhO5SGld/m8txngmqZXGGfpFRcpTqFvrUl0eE
        UtVVhjBXbyaPcgKLFkWOmVJNPg75xV17buwsRbEXwBMe0H7MZhcFCKeecKNjWY6fIj6aHXiu9rhIl
        TOSjDTA2dKaBg3+w/bCoodJGZ2hbYApnE7LMrkb8r9HuvjpVs8SHnp6hZP74L62rLkYPyVehbzoo4
        3etjOb3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5m-Ig; Fri, 17 Sep 2021 18:22:28 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 10/14] x86/build: Tuck away built-in firmware under its kconfig symbol
Date:   Fri, 17 Sep 2021 11:22:22 -0700
Message-Id: <20210917182226.3532898-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Now that it is clear that built-in firmware is only used
when built-in firmware is enabled update x86 relocs to
reflect that.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 arch/x86/tools/relocs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c82207d387..ab3554d4aa06 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -63,7 +63,9 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"(__parainstructions|__alt_instructions)(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
 	"__(start|end)_pci_.*|"
+#if CONFIG_FW_LOADER_BUILTIN
 	"__(start|end)_builtin_fw|"
+#endif
 	"__(start|stop)___ksymtab(_gpl)?|"
 	"__(start|stop)___kcrctab(_gpl)?|"
 	"__(start|stop)___param|"
-- 
2.30.2

