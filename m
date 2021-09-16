Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7E40ED04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 00:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhIPWBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240567AbhIPWBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:01:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B93C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 15:00:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so4808644pls.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgZT1XC7G7Q8x79HhR59+Cupimv0CKdkeGrNL4A8Xx8=;
        b=BoNo1Cg4OlDT1EgGfZBU15ouPLGhO1LNII4sl9+rYyYBUZdEgFHJ57ISSXckZaIAAB
         hFhtcyZ79TTWcF1c7MpDMCnNp+TVYJZGtjjKNQgOMpVKpchZ+jfoOQLe/C63IDidXrNC
         cQzgxNnpao++bNXKLqRe6+0x0MVyapQgokn94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QgZT1XC7G7Q8x79HhR59+Cupimv0CKdkeGrNL4A8Xx8=;
        b=qLdcPqd7MrUBC0zVOHdUMIkUsQkE9Qcxip+lyEv2oZUo0txwJdy4FM3Ihyw7D27rMu
         42C9ckJUP5ZpOjm0NxC7j8bTZ6HOIWbjtT81q7JmwX1DZ8oQ1PyZ4tl4zjO1Nz06O6Ml
         zyurb1Z36Lsk5DGDiEYvuE/+7w+bRqzmyNQUrAYxUPQrkK9ZGYNe/wUVhosG7yOUljRx
         nYQJmp3LOZrqipTYfIvy1+/Jc/Tom3w1ivhyI2dGib6z3YMzHpZ9AF+5ZslgfBh4gtMX
         fdxmSYxsPjqNIKtgZkfoz+gZm+FEqN8QAhFUNMy+4XKjXUk/bN62OOs20rpx3Z2PqwEB
         OedQ==
X-Gm-Message-State: AOAM531IgmwmNVRrhCqfEFIus+GbvXGUkjLSnS2osPnvtd/apYE4KICs
        vkwsR6egSnXVW2aci7ebzuvzyA==
X-Google-Smtp-Source: ABdhPJxYFlKyO0l7iPw8xR3e4r2q9UdfQZbC0fk2CIcbgICOD0EEbtfK6agibZbD4Pve2h7X45IRDg==
X-Received: by 2002:a17:90a:f190:: with SMTP id bv16mr17196129pjb.76.1631829601959;
        Thu, 16 Sep 2021 15:00:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o9sm4318030pfh.217.2021.09.16.15.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:00:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2] binfmt_elf: Reintroduce using MAP_FIXED_NOREPLACE
Date:   Thu, 16 Sep 2021 14:59:47 -0700
Message-Id: <20210916215947.3993776-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5456; h=from:subject; bh=l1xfacQIzr280Zi74kwdiG88aSQKHLZ+n9yn8gc4K2E=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhQ75ThNHIlbCr7ypZpgj0HN0mhaDLJiYk3btIZhdc mDznu3eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYUO+UwAKCRCJcvTf3G3AJoBKD/ 9iJ0dh+HoluBp67x4y32KvdaxOvHZP+QF4qv+HoThabTE8ek02bTa70vV0eOV1Dp8VJn7r2NhZMXOI Ki24arJ3Ad+/RbR1rvrCsmLJ5Nevz+/bIvc2YMwWLsbYAPza5BwUYpJ3L0arF7sBnca86bYlYEV23B IWFRp8MHDYsWzxAyxGyhsxXXFOe7dd7j9kM7gIoFcwVUNTKC9Znrq+qLx8+Jqlfm3mJIY2LZqyRtvB 6gWGiM+pvtOd3lXTiM9WMK3v4KYGGxa0qD9RCu67sBUcXbDfM589DitRI/wH5b5xH1+Fk4U6q+vNbr 5oooeyYu1k1+fhjrW2K8xdm3hhiTQ0GuqM711bQTNpuDB/UCEJDetGsYZmcUWFo0I4Y4MzoYAsaRCd hX6X11G174WGklsLawns6d/lFvjR5yuXroyX9hZOUZGfxKs+G5gFqcq+HyCbuIaOHcIaaH8LEXYZJE 9nVMSDcFpZXYi4pDMKnrRu5sib/ITSQVZuWraXY7i4jdgvmQSMt9L2LaQFar5xewWY2DjfWygD1Dqk MRdawMaLEhYn679RqKhu4CSYChFYhk89LU8QALVIMlj7gteQ7IJEIGJJ2D9LOv0BcD4dhZNgsNVHP0 v2W/j5nmnD56X+0Dnhxn1zia6sJ4IfdBW22CgDygxPSs6QbPRGqFuentU8ig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf
executable mappings") reverted back to using MAP_FIXED to map ELF
LOAD segments because it was found that the segments in some binaries
overlap and can cause MAP_FIXED_NOREPLACE to fail.

The original intent of MAP_FIXED_NOREPLACE in the ELF loader was to
prevent the silent clobbering of an existing mapping (e.g. stack)
by the ELF image, which could lead to exploitable conditions. Quoting
commit 4ed28639519c ("fs, elf: drop MAP_FIXED usage from elf_map"),
which originally introduced the use of MAP_FIXED_NOREPLACE in the
loader:

    Both load_elf_interp and load_elf_binary rely on elf_map to map
    segments [to a specific] address and they use MAP_FIXED to enforce
    that. This is however [a] dangerous thing prone to silent data
    corruption which can be even exploitable.
    ...
    Let's take CVE-2017-1000253 as an example ... we could end up mapping
    [the executable] over the existing stack ... The [stack layout] issue
    has been fixed since then ... So we should be safe and any [similar]
    attack should be impractical. On the other hand this is just too
    subtle [an] assumption ... it can break quite easily and [be] hard to
    spot.
    ...
    Address this [weakness] by changing MAP_FIXED to the newly added
    MAP_FIXED_NOREPLACE. This will mean that mmap will fail if there is
    an existing mapping clashing with the requested one [instead of
    silently] clobbering it.

Then processing ET_DYN binaries the loader already calculates a total
size for the image when the first segment is mapped, maps the entire
image, and then unmaps the remainder before the remaining segments are
then individually mapped. To avoid the earlier problems (legitimate
overlapping LOAD segments specified in the ELF), apply the same
logic to ET_EXEC binaries as well. For both ET_EXEC and ET_DYN+INTERP
use MAP_FIXED_NOREPLACE for the initial total size mapping and then
use MAP_FIXED to build the final (possibly legitimately overlapping)
mappings. For ET_DYN w/out INTERP, continue to map at a system-selected
address in the mmap region.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Co-developed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Link: https://lore.kernel.org/lkml/1595869887-23307-2-git-send-email-anthony.yznaga@oracle.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 69d900a8473d..f3523807dbca 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1074,20 +1074,26 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		vaddr = elf_ppnt->p_vaddr;
 		/*
-		 * If we are loading ET_EXEC or we have already performed
-		 * the ET_DYN load_addr calculations, proceed normally.
+		 * The first time through the loop, load_addr_set is false:
+		 * layout will be calculated. Once set, use MAP_FIXED since
+		 * we know we've already safely mapped the entire region with
+		 * MAP_FIXED_NOREPLACE in the once-per-binary logic following.
 		 */
-		if (elf_ex->e_type == ET_EXEC || load_addr_set) {
+		if (load_addr_set) {
 			elf_flags |= MAP_FIXED;
+		} else if (elf_ex->e_type == ET_EXEC) {
+			/*
+			 * This logic is run once for the first LOAD Program
+			 * Header for ET_EXEC binaries. No special handling
+			 * is needed.
+			 */
+			elf_flags |= MAP_FIXED_NOREPLACE;
 		} else if (elf_ex->e_type == ET_DYN) {
 			/*
 			 * This logic is run once for the first LOAD Program
 			 * Header for ET_DYN binaries to calculate the
 			 * randomization (load_bias) for all the LOAD
-			 * Program Headers, and to calculate the entire
-			 * size of the ELF mapping (total_size). (Note that
-			 * load_addr_set is set to true later once the
-			 * initial mapping is performed.)
+			 * Program Headers.
 			 *
 			 * There are effectively two types of ET_DYN
 			 * binaries: programs (i.e. PIE: ET_DYN with INTERP)
@@ -1108,7 +1114,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * Therefore, programs are loaded offset from
 			 * ELF_ET_DYN_BASE and loaders are loaded into the
 			 * independently randomized mmap region (0 load_bias
-			 * without MAP_FIXED).
+			 * without MAP_FIXED nor MAP_FIXED_NOREPLACE).
 			 */
 			if (interpreter) {
 				load_bias = ELF_ET_DYN_BASE;
@@ -1117,7 +1123,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				alignment = maximum_alignment(elf_phdata, elf_ex->e_phnum);
 				if (alignment)
 					load_bias &= ~(alignment - 1);
-				elf_flags |= MAP_FIXED;
+				elf_flags |= MAP_FIXED_NOREPLACE;
 			} else
 				load_bias = 0;
 
@@ -1129,7 +1135,14 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			 * is then page aligned.
 			 */
 			load_bias = ELF_PAGESTART(load_bias - vaddr);
+		}
 
+		/*
+		 * Calculate the entire size of the ELF mapping (total_size).
+		 * (Note that load_addr_set is set to true later once the
+		 * initial mapping is performed.)
+		 */
+		if (!load_addr_set) {
 			total_size = total_mapping_size(elf_phdata,
 							elf_ex->e_phnum);
 			if (!total_size) {
-- 
2.30.2

