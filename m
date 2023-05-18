Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9FF7089C1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjERUq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjERUqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 16:46:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B47F7;
        Thu, 18 May 2023 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wq3sItf/PoJeyu07IU6Q1xFb/1kHPugpGIY2upH/8nw=; b=wbTF6oOc7X6Z9c1uvMWpf0zo+O
        ReP2mzsiACAH8BcbYUJD7hdpz35r2XdQkQu5X7GVnSoKd6OTF8gjoz7HvQKxJS1gXhyaELVLYeZHI
        /BITminog8QnB0vNau475sTBu4pa/BQvVM1uUDQ9gN0VR6tNwZFa4y+dv05CYtWInHGqWHEL8WKvR
        mLlM/XTBM7EaAuGNh9RLnyj5356RxMk9Az4iBXillOtrY9BTMf/55KxALNjiKGEX5RlH1u6EWEfMY
        8+eA6E6t9DOK4WmCpVzXYwyWnfjF90ynsUnHxSlhseieo7NgLu8BZzI0D1Wq4jt8LuV6W9/rdXWOr
        j2esyC2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzkWK-00E8vi-2L;
        Thu, 18 May 2023 20:46:44 +0000
Date:   Thu, 18 May 2023 13:46:44 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 0/2] sysctl: Remove register_sysctl_table from sources
Message-ID: <ZGaOtM0TqmwOkdd6@bombadil.infradead.org>
References: <CGME20230518160715eucas1p174602d770f0d46e0294b7dba8d6d36dc@eucas1p1.samsung.com>
 <20230518160705.3888592-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518160705.3888592-1-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 06:07:03PM +0200, Joel Granados wrote:
> This is part of the general push to deprecate register_sysctl_paths and
> register_sysctl_table. This patchset completely removes register_sysctl_table
> and replaces it with register_sysctl effectively transitioning 5 base paths
> ("kernel", "vm", "fs", "dev" and "debug") to the new call. Besides removing the
> actuall function, I also removed it from the checks done in check-sysctl-docs.
> 
> Testing for this change was done in the same way as with previous sysctl
> replacement patches: I made sure that the result of `find /proc/sys/ | sha1sum`
> was the same before and after the patchset.
> 
> Have pushed this through 0-day. Waiting on results..
> 
> Feedback greatly appreciated.

Thanks so much! I merged this to sysctl-testing as build tests are ongoing. But
I incorporated these minor changes to your first patch as register_sysctl_init()
is more obvious about when we cannot care about the return value.

If the build tests come through I'll push to sysctl-next.

diff --git a/fs/sysctls.c b/fs/sysctls.c
index 228420f5fe1b..76a0aee8c229 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -31,11 +31,7 @@ static struct ctl_table fs_shared_sysctls[] = {
 
 static int __init init_fs_sysctls(void)
 {
-	/*
-	 * We do not check the return code for register_sysctl because the
-	 * original call to register_sysctl_base always returned 0.
-	 */
-	register_sysctl("fs", fs_shared_sysctls);
+	register_sysctl_init("fs", fs_shared_sysctls);
 	return 0;
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f784b0fe5689..fa2aa8bd32b6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2350,10 +2350,10 @@ static struct ctl_table dev_table[] = {
 
 int __init sysctl_init_bases(void)
 {
-	register_sysctl("kernel", kern_table);
-	register_sysctl("vm", vm_table);
-	register_sysctl("debug", debug_table);
-	register_sysctl("dev", dev_table);
+	register_sysctl_init("kernel", kern_table);
+	register_sysctl_init("vm", vm_table);
+	register_sysctl_init("debug", debug_table);
+	register_sysctl_init("dev", dev_table);
 
 	return 0;
 }
