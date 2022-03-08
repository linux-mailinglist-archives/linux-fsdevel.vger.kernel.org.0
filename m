Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FC64D15DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 12:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiCHLLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 06:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbiCHLLp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:11:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30518457AB;
        Tue,  8 Mar 2022 03:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C00A4615F4;
        Tue,  8 Mar 2022 11:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2075C340EC;
        Tue,  8 Mar 2022 11:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646737848;
        bh=Q2s/iQcTH+SXJFwnKcZFVY44y/cmyFC2fSfRw8SBNqU=;
        h=From:To:Cc:Subject:Date:From;
        b=rPpc8qQxwmbbms54yob29DznB7ZZaw77JUfFsFNryOCmsbofkY1WhFN2G65dPQxSR
         GLIVlzxEPZhvMJDd5tPub/BPBm7ZcjyhF/p+PfI8DBM+aPfjlny7OoSrta2Xs049ln
         TbZ9fewFAtjh3jtGlo5HIpkvi+sHJjS7Ah86vFbZb0DuFq0cE06qMjsItVLHyGaGdv
         gZ2zt2N1+H+RNwUDA0tAxeN/K++I7XryUtsdW0bEKIkJzjziFwn414fL+/I4sJvuPy
         AxVgEfJs4V1oiZDOXMpyFuqUKbfLX50MF82A4hQxdc5XFoCuOdGir2aIDA1ba5GXqg
         vjjB7qOieyRzw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH RFC v2 0/3] MAP_POPULATE for device memory
Date:   Tue,  8 Mar 2022 13:10:00 +0200
Message-Id: <20220308111003.257351-1-jarkko@kernel.org>
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
 mm/gup.c                         |   9 ++-
 6 files changed, 175 insertions(+), 42 deletions(-)

-- 
2.35.1

