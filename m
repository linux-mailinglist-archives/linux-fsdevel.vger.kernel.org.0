Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD64CB291
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Mar 2022 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiCBWvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Mar 2022 17:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCBWvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:51:47 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1B11029D6;
        Wed,  2 Mar 2022 14:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cA/im1dmXrUD82WWJsDC0s7CUiOhwfEqA+Dub8QQkec=; b=zAd5g+LdzL45SyO0HIcd9iun5W
        VgrSAbIUAYOTkevd8vRxwz005p7+xxZyOq0L6EPqCtROxfRcUXCdRuwsCSuLXTdoZ2vwPai7uoAwP
        k3y2seROOh7zl1VvKLgP40kSRqteL9FyhA5YL3fui299PIX5p/IWFTO3sxuxBYGFaggaGZsimlWRU
        hxCbylspbhoBc43fu5k0NaWB2Kp1Wq3POByJsMwxmibqiAOiWvjp8lLdIeEEZqTh8u3yDGvMt/jEa
        wjph19ZVoEh1GChk4TUunJsiyujzuqQ9Q6CT1Gjnb07PhP1cgXLy6cPUxsLBpZ8gR6fg9xhglAHmi
        bT1EGwQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPXnB-004dAP-N4; Wed, 02 Mar 2022 22:49:57 +0000
Date:   Wed, 2 Mar 2022 14:49:57 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs/proc: optimize exactly register one ctl_table
Message-ID: <Yh/0lYpuaYyXEq9u@bombadil.infradead.org>
References: <20220302025511.20374-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302025511.20374-1-tangmeng@uniontech.com>
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

On Wed, Mar 02, 2022 at 10:55:10AM +0800, Meng Tang wrote:
> Sysctls are being moved out of kernel/sysctl.c and out to
> their own respective subsystems / users to help with easier
> maintance and avoid merge conflicts. But when we move just
> one entry and to its own new file the last entry for this
> new file must be empty, so we are essentialy bloating the
> kernel one extra empty entry per each newly moved sysctl.
> 
> To help with this, this adds support for registering just
> one ctl_table, therefore not bloating the kernel when we
> move a single ctl_table to its own file.
> 
> Since the process of registering just one single table is the
> same as that of registering an array table, so the code is
> similar to registering an array table. The difference between
> registering just one table and registering an array table is
> that we no longer traversal through pointers when registering
> a single table. These lead to that we have to add a complete
> implementation process for register just one ctl_table, so we
> have to add so much code.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Meng Tang <tangmeng@uniontech.com>

Is there really no helpers which you can add to share code?
Now that you did this work, look carefully.

  Luis
