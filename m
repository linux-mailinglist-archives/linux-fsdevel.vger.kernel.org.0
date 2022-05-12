Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D1152567B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 22:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358463AbiELUla (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 16:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358441AbiELUlO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 16:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4754C3A1BB;
        Thu, 12 May 2022 13:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D62AA615DD;
        Thu, 12 May 2022 20:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8B9C385B8;
        Thu, 12 May 2022 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652388072;
        bh=2Xd2ROOskgwp1XtfA2/97bDTnCNRzKk/N7iQN4Ad1oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GwjQauSMysxIYAlepKdaM3VHxtlSgRNyvBJW3dxOAdeBH+B6HeP2ioB95iGLQ5y51
         TmcbUFlhA0cwUEWrcNrrc3OVz8/6Tpuf/mxI9Xvj8+oAkAWgp/k1LlEb5T1fojqRcb
         uRY0bLMptAkmWRmH+Tt9lP2MtJAoieB314iNMS4Y=
Date:   Thu, 12 May 2022 13:41:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     cgel.zte@gmail.com
Cc:     ammarfaizi2@gnuweeb.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn,
        willy@infradead.org, xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.yunkai@zte.com.cn
Subject: Re: [PATCH v7] mm/ksm: introduce ksm_force for each process
Message-Id: <20220512134111.cfd6c9ee639fe81d4f55a1f3@linux-foundation.org>
In-Reply-To: <20220512070347.1628163-1-xu.xin16@zte.com.cn>
References: <fb4f0d4c-aaf7-b225-f5bb-7c41c48fb8f1@gnuweeb.org>
        <20220512070347.1628163-1-xu.xin16@zte.com.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 May 2022 07:03:47 +0000 cgel.zte@gmail.com wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> To use KSM, we have to explicitly call madvise() in application code,
> which means installed apps on OS needs to be uninstall and source code
> needs to be modified. It is inconvenient.
> 
> In order to change this situation, We add a new proc file ksm_force
> under /proc/<pid>/ to support turning on/off KSM scanning of a
> process's mm dynamically.
> 
> If ksm_force is set to 1, force all anonymous and 'qualified' VMAs
> of this mm to be involved in KSM scanning without explicitly calling
> madvise to mark VMA as MADV_MERGEABLE. But It is effective only when
> the klob of /sys/kernel/mm/ksm/run is set as 1.
> 
> If ksm_force is set to 0, cancel the feature of ksm_force of this
> process and unmerge those merged pages belonging to VMAs which is not
> madvised as MADV_MERGEABLE of this process, but leave MADV_MERGEABLE
> areas merged.

It certainly seems like a useful feature.

> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Reviewed-by: wangyong <wang.yong12@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This patch doesn't have your Signed-off-by:.  It should, because you
were on the delivery path.  This is described in
Documentation/process/submitting-patches.rst, "Developer's Certificate
of Origin".

I'll queue it for some testing but please do resend with that tag.


> +/* Check if vma is qualified for ksmd scanning */
> +static bool ksm_vma_check(struct vm_area_struct *vma)

I have trouble with "check" names, because the name doesn't convey what
is being checked, nor does the name convey whether it's checking for
truth or for falsity.

I suggest that "vma_scannable" is a more informative name.  It doesn't
need the "ksm_" prefix as this is a static file-local function.

See, with the name "vma_scannable", that comment which you added is
barely needed.

--- a/mm/ksm.c~mm-ksm-introduce-ksm_force-for-each-process-fix
+++ a/mm/ksm.c
@@ -335,7 +335,7 @@ static void __init ksm_slab_free(void)
 }
 
 /* Check if vma is qualified for ksmd scanning */
-static bool ksm_vma_check(struct vm_area_struct *vma)
+static bool vma_scannable(struct vm_area_struct *vma)
 {
 	unsigned long vm_flags = vma->vm_flags;
 
@@ -551,7 +551,7 @@ static struct vm_area_struct *find_merge
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !ksm_vma_check(vma) || !vma->anon_vma)
+	if (!vma || !vma_scannable(vma) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
@@ -2328,7 +2328,7 @@ next_mm:
 		goto no_vmas;
 
 	for_each_vma(vmi, vma) {
-		if (!ksm_vma_check(vma))
+		if (!vma_scannable(vma))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
_

