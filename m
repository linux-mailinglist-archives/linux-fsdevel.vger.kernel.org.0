Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE8A6B8848
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 03:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCNCTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCNCTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:19:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC131B541;
        Mon, 13 Mar 2023 19:19:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C8B61572;
        Tue, 14 Mar 2023 02:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFDAC4339C;
        Tue, 14 Mar 2023 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678760373;
        bh=jQhD/M7Ani+bWf3eE9KwDDKZgpO+n2YjiyMZ49M+DVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TEy2LQY75YaxuMZ9i9d0txb/bAPwVksXWhiZdQy+Gp0ocrEuwRrFo+5Wh7rqlFeNe
         1LlrirqETNh2b1bMxwBWU+ClRS3UtSm156sFelxG38ph5FucwHNDR7Wyqo4Eq0iphr
         BLQ4sFlz8R2QZTg6FkeByENg0z1522RLRjMbOHgw=
Date:   Mon, 13 Mar 2023 19:19:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>,
        "Andreas Gruenbacher" <agruenba@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        <linux-afs@lists.infradead.org>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-nilfs@vger.kernel.org>,
        <cgroups@vger.kernel.org>
Subject: Re: [linux-next:master] [mm] 480c454ff6:
 BUG:kernel_NULL_pointer_dereference
Message-Id: <20230313191931.f84776cb09dc8c4b50673a76@linux-foundation.org>
In-Reply-To: <202303140916.5e8e96b2-yujie.liu@intel.com>
References: <202303140916.5e8e96b2-yujie.liu@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Mar 2023 10:10:42 +0800 kernel test robot <yujie.liu@intel.com> wrote:

> Greeting,
> 
> Previous report:
> https://lore.kernel.org/oe-lkp/202303100947.9b421b1c-yujie.liu@intel.com
> 
> FYI, we noticed BUG:kernel_NULL_pointer_dereference,address due to commit (built with gcc-11):
> 
> commit: 480c454ff64b734a35677ee4b239e32143a4235c ("mm: return an ERR_PTR from __filemap_get_folio")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> [test failed on linux-next/master 24469a0e5052ba01a35a15f104717a82b7a4798b]
> 
> in testcase: trinity
> version: trinity-x86_64-e63e4843-1_20220913
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-04
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [   29.300153][ T6430] BUG: kernel NULL pointer dereference, address: 0000000000000000

Thanks, I expect this is fixed by

commit 151dff099e8e6d9c8efcc75ad0ad3b8eead58704
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Mar 10 08:00:23 2023 +0100

    mm-return-an-err_ptr-from-__filemap_get_folio-fix
    
    fix null-pointer deref
    
    Link: https://lkml.kernel.org/r/20230310070023.GA13563@lst.de
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reported-by: Naoya Horiguchi <naoya.horiguchi@linux.dev>
      Link: https://lkml.kernel.org/r/20230310043137.GA1624890@u2004
    Cc: Andreas Gruenbacher <agruenba@redhat.com>
    Cc: Hugh Dickins <hughd@google.com>
    Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
    Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/swap_state.c b/mm/swap_state.c
index c7160070b9da..b76a65ac28b3 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -390,6 +390,8 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 	struct swap_info_struct *si;
 	struct folio *folio = filemap_get_entry(mapping, index);
 
+	if (!folio)
+		return ERR_PTR(-ENOENT);
 	if (!xa_is_value(folio))
 		return folio;
 	if (!shmem_mapping(mapping))



