Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94413680196
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 22:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjA2Vdx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Jan 2023 16:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjA2Vdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Jan 2023 16:33:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27051630F
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 13:33:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74F61B80DBB
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 21:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69BCC433D2;
        Sun, 29 Jan 2023 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675028027;
        bh=Zdc0PXxqXD6z8q58RPbLoU3GBY87Skvlv8yCAyRg0nE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xDHgj7b9+Ou3sul1xrajZBCEITuGZWA7oxf7c0lM45Fj1C9i9dF7Zv/BmJjz9Y43+
         qZkqoKAsVFaQ8qzgZb4N+8x4iHzB7C7+ndZVyLcGX1JdBfqNtuf12dNRaRjz6adCv1
         uXuPMEBfs3cTLXkAy9kq1fTDb6m+UZ8QklvFXCEg=
Date:   Sun, 29 Jan 2023 13:33:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: Convert writepage_t callback to pass a folio
Message-Id: <20230129133346.0d39a8d1eead866cbff0c061@linux-foundation.org>
In-Reply-To: <202301290130.frg9YGk5-lkp@intel.com>
References: <20230126201255.1681189-2-willy@infradead.org>
        <202301290130.frg9YGk5-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 29 Jan 2023 01:13:56 +0800 kernel test robot <lkp@intel.com> wrote:

> Hi Matthew,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20230125]
> [cannot apply to tytso-ext4/dev akpm-mm/mm-everything cifs/for-next mszeredi-fuse/for-next xfs-linux/for-next trondmy-nfs/linux-next hubcap/for-next linus/master v6.2-rc5 v6.2-rc4 v6.2-rc3 v6.2-rc5]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Convert-writepage_t-callback-to-pass-a-folio/20230128-112951
> patch link:    https://lore.kernel.org/r/20230126201255.1681189-2-willy%40infradead.org
> patch subject: [PATCH 1/2] fs: Convert writepage_t callback to pass a folio
> config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20230129/202301290130.frg9YGk5-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/19e834de445f5d3a390fff94320e71e8077ce632
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Matthew-Wilcox-Oracle/fs-Convert-writepage_t-callback-to-pass-a-folio/20230128-112951
>         git checkout 19e834de445f5d3a390fff94320e71e8077ce632
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash fs/gfs2/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    fs/gfs2/log.c: In function 'gfs2_ail1_start_one':
> >> fs/gfs2/log.c:143:55: error: passing argument 3 of 'write_cache_pages' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      143 |                 ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
>          |                                                       ^~~~~~~~~~~~~~~~

Thanks.  This is due to a conflict with a recent upstream merge from
the GFS tree.  Stephen addressed this in linux-next:

https://lkml.kernel.org/r/20230127173638.1efbe423@canb.auug.org.au

a) I could rebase mm.git onto -rc5 or later.

b) Or I could disable Matthew's patches until late merge window,
   after I resync with mainline for stragglers such as this.

c) Or I could do nothing - things will get sorted out once Matthew's
   commits hit mainline during the regular merge.

Perhaps a)?  People don't want to have to deal with conflicts when
merging current mm.git onto current mainline.
