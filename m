Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8424D163F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbiCHLaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiCHLaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:30:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5562340EC;
        Tue,  8 Mar 2022 03:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FF2E6165E;
        Tue,  8 Mar 2022 11:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F59C340EC;
        Tue,  8 Mar 2022 11:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646738954;
        bh=nbU7mIeF1Dy+lDixzqyrU78B2yr27pHjzue9SkRm4Hk=;
        h=From:To:Cc:Subject:Date:From;
        b=tL8aqieZSys2aIh27sli7QGG4YOp1+MeuG7B+WlabZhSCARn1d40Fww91RNulXxbV
         QRMgvY+phO2KgcfPNAqHn7Jp4BhtvWBM1p9C0PAKMi4WcnFQe92Lp9o1KgC/pm0gIT
         WvosfQBi/2LlWpfilPsVLi5JAeHxs+/qH6ydPwPmeumValKveILma8vRRrvV8Ir0lX
         Vuc4k/ZnVN/vurAahkm4J42plgXSW3RF2fvB5b1Vf0dVyyCPsgRr973ujFAw46L3RF
         u+Zrfgx3jsx91nDlx+TQOB0zeJeCbPbU8xzfSNXlghvxGcsIBEmE+78VEOKHtDLIiu
         NUbTxe5QWV2Nw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v3 0/3] MAP_POPULATE for device memory
Date:   Tue,  8 Mar 2022 13:28:30 +0200
Message-Id: <20220308112833.262805-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGX is weird.  SGX memory is managed outside the core mm.  It doesn't
have a 'struct page' and get_user_pages() doesn't work on it.  Its VMAs
are marked with VM_IO.  So, none of the existing methods for avoiding
page faults work on SGX memory.

This patch set essentially helps extend existing "normal RAM" kernel
ABIs to work for avoiding faults for SGX too.  SGX users want to enjoy
all of the benefits of a delayed allocation policy (better resource use,
overcommit, NUMA affinity) but without the cost of millions of faults.

Jarkko Sakkinen (3):
  mm: Add f_op->populate() for populating memory outside of core mm
  x86/sgx: Export sgx_encl_page_alloc()
  x86/sgx: Implement EAUG population with MAP_POPULATE

 arch/x86/kernel/cpu/sgx/driver.c | 128 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/encl.c   |  38 +++++++++
 arch/x86/kernel/cpu/sgx/encl.h   |   3 +
 arch/x86/kernel/cpu/sgx/ioctl.c  |  38 ---------
 include/linux/fs.h               |   1 +
 mm/gup.c                         |  11 ++-
 6 files changed, 178 insertions(+), 41 deletions(-)

-- 
2.35.1

