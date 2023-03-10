Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC416B559B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Mar 2023 00:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjCJX3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 18:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjCJX3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 18:29:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5779E12C822;
        Fri, 10 Mar 2023 15:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vxh+5loJXr3QOkEBXraKRrSEsoLxyjcuI0B+WEdhvrc=; b=ICn+4H1Gid6ISIQtmA0dRRbsb8
        TA5WsB7AvOCX+EZG9pAFvNij/xCRcRVffQ8DW1eKISqZhVdSweKez4Ce4x6bNBbtzrxAb3g/QEuQY
        Tgr2QdR77Rqua6uRpaqyFTZqzSdIsVTrMeEb8BmWcxEHuLzpriCVgZUTuzips3XFyZibgMPeH/JJG
        7AHXtJJ84yqwS7cGnh2ZAZre7hmo0fkKTYShqUS1WzB3bJkjmaooFmGGSreXLsWcb5IK6592fhuCN
        NLUCBWdbzyfO99+sFR9jKYhNMMC+dlHEnIFt5rF3WEDeMKkGshOoxh1DZjxsHRCEEpSrV6uM7y73S
        ls83Dbxw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pamAN-00GcM6-0Y; Fri, 10 Mar 2023 23:28:51 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] ppc: simplify sysctl registration
Date:   Fri, 10 Mar 2023 15:28:48 -0800
Message-Id: <20230310232850.3960676-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can simplify the way we do sysctl registration both by
reducing the number of lines and also avoiding calllers which
could do recursion. The docs are being updated to help reflect
this better [0].

[0] https://lore.kernel.org/all/20230310223947.3917711-1-mcgrof@kernel.org/T/#u     

Luis Chamberlain (2):
  ppc: simplify one-level sysctl registration for
    powersave_nap_ctl_table
  ppc: simplify one-level sysctl registration for
    nmi_wd_lpm_factor_ctl_table

 arch/powerpc/kernel/idle.c                | 10 +---------
 arch/powerpc/platforms/pseries/mobility.c | 10 +---------
 2 files changed, 2 insertions(+), 18 deletions(-)

-- 
2.39.1

