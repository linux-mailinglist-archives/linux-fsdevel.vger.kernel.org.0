Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7828049BB0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 19:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiAYSPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 13:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiAYSPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:15:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857AC06173B;
        Tue, 25 Jan 2022 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M3s699EVxCb56KZAXK+UJZIZV/pHJFXz3t4X5vkCuKc=; b=K7wzsAzPE9oRmTTee4QGCkMIHk
        GSUmlgI5RZ4Er2TXkLbsVMfd5xCs5YGSzfyvveCBtgWg5NzJD2RFRNRfSwlfOb+wt2ALkn51O44b7
        m0ftmlEkdEKfiiBwpcQYToP9VuCUnfJUZoNaRgILBrI1mWht9JxZ/5MrY9ucmhkc4jk9QAZr6u8mF
        10AGEjakjdbgHF6e31X6E3QGAyPo2JPc2LY6SD+kfw+OFDp/albY83Ito9VTTiuFzZ+shZH90M1nc
        MwjtrNycYwXCVcbY0szLiR0FtLa4BJcwV/XZk5I6EB6OF+sQw608qjcVdnFo6kCjq3EUx/OY4Q9O+
        6zjqUm0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCQLw-009Bq2-QS; Tue, 25 Jan 2022 18:15:36 +0000
Date:   Tue, 25 Jan 2022 10:15:36 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 1/2] binfmt_misc: fix crash when load/unload module
Message-ID: <YfA+SJZrd4nkFSgH@bombadil.infradead.org>
References: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
 <20220124181812.1869535-2-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124181812.1869535-2-ztong0001@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 10:18:12AM -0800, Tong Zhang wrote:
> We should unregister the table upon module unload otherwise something
> horrible will happen when we load binfmt_misc module again. Also note
> that we should keep value returned by register_sysctl_mount_point() and
> release it later, otherwise it will leak.
> Also, per Christian's comment, to fully restore the old behavior that
> won't break userspace the check(binfmt_misc_header) should be
> eliminated.
> 
> reproduce:
> modprobe binfmt_misc
> modprobe -r binfmt_misc
> modprobe binfmt_misc
> modprobe -r binfmt_misc
> modprobe binfmt_misc
> 
> [   18.032038] Call Trace:
> [   18.032108]  <TASK>
> [   18.032169]  dump_stack_lvl+0x34/0x44
> [   18.032273]  __register_sysctl_table+0x6f4/0x720
> [   18.032397]  ? preempt_count_sub+0xf/0xb0
> [   18.032508]  ? 0xffffffffc0040000
> [   18.032600]  init_misc_binfmt+0x2d/0x1000 [binfmt_misc]
> [   18.042520] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
> modprobe: can't load module binfmt_misc (kernel/fs/binfmt_misc.ko): Cannot allocate memory
> [   18.063549] binfmt_misc: Failed to create fs/binfmt_misc sysctl mount point
> [   18.204779] BUG: unable to handle page fault for address: fffffbfff8004802
> 
> Fixes: 3ba442d5331f ("fs: move binfmt_misc sysctl to its own file")
> Co-developed-by: Christian Brauner<brauner@kernel.org>
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
