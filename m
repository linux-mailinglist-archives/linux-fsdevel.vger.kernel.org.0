Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2312452590C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 02:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348528AbiEMApJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 20:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243156AbiEMApI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 20:45:08 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51AF28B69A;
        Thu, 12 May 2022 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJfkC5Ggl9PBSX8dbtET+FNDoEEEikJyMuvYPYbye6c=; b=OvNNgZ0/ROFK3Q4PvFu625p3nm
        9fKSysyDUF+Y5nlb1vJz2fWZJDBEkccJWNiPHKu5IEgAvg/dyxhy161XDrM1rTbxmR1dptd9IJIwM
        yUA+GFBbkL3lZ/5cMuoKZqGJJ1EwZZVvzJ8KzX2DkApp0DFEEVJXDUZBdAtLcaeZWFgvv2u+tMfoj
        L+iNt1GOVWrLYL7dlN9hgjE7+XwqaZ60A3rtXoA/K5HZGUEGKFz/HSyT1EcSTYjno+suprdK03k4/
        oqtRrlt8q27FiysVwrpRNqtKhRX1bj6jtL52B6WCo/eoCpavpVYK6dJokI+fW5gfAcXbh8O2vLRTd
        nMrQiGFA==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npJQX-00ERhN-RB; Fri, 13 May 2022 00:45:05 +0000
Date:   Fri, 13 May 2022 00:45:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Gou Hao <gouhao@uniontech.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiaofenfang@uniontech.com, willy@infradead.org
Subject: Re: [PATCH V2] fs: remove fget_many and fput_many interface
Message-ID: <Yn2qEej5rjnVKw5i@zeniv-ca.linux.org.uk>
References: <20211102024648.14578-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102024648.14578-1-gouhao@uniontech.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 02, 2021 at 10:46:48AM +0800, Gou Hao wrote:
> These two interface were added in 091141a42 commit,
> but now there is no place to call them.
> 
> The only user of fput/fget_many() was removed in commit
> 62906e89e63b ("io_uring: remove file batch-get optimisation").
> 
> A user of get_file_rcu_many() were removed in commit 
> f073531070d2 ("init: add an init_dup helper").
> 
> And replace atomic_long_sub/add to atomic_long_dec/inc
> can improve performance.
> 
> Here are the test results of unixbench:
> 
> Cmd: ./Run -c 64 context1
> 
> Without patch:
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> Pipe-based Context Switching                   4000.0    2798407.0   6996.0
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         6996.0
> 
> With patch:
> System Benchmarks Partial Index              BASELINE       RESULT    INDEX
> Pipe-based Context Switching                   4000.0    3486268.8   8715.7
>                                                                    ========
> System Benchmarks Index Score (Partial Only)                         8715.7
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Rebased and applied, with deep apologies for having it fall through cracks
back in November.
