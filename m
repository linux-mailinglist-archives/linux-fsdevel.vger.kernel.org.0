Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC749BB0C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 19:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiAYSO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 13:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAYSO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:14:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B669C06173B;
        Tue, 25 Jan 2022 10:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QguUO9iElD2uimtN6/KPbOt0qekHNlpVkvs8+DjH69c=; b=uaK3s2h5rUUptGzpogZMFDWObe
        9ULZR/LqtY/+bEM2lmks7rtmA/gvNTdTE0cJFb5ebFuqX0ZMmKP5MPDeDKuX5xnzPIh6FHG8K34Ok
        m9SA9LjwcR2yFL0SWaXTAXlFcczAbZyc+LGLFI/bdXOsd0y2i+DhvW3izMOHxAUSTBsBoBUUeiBqe
        UaO48mGvCi7SJFTFxM44tKdXa4hMH/hXmsUrx9yF0DM/PZZ+NR9FBsUEGKMByeAlqKvkttrxn/+/H
        O6wMgYXnJvYi3IKF/R5V1YwdbnuESffdlAYaXM9Yj6kjVpHhns2rtpSsFpM1MtDwyVMTiigB8MJLq
        B/aWlgyQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCQL8-009Bmm-83; Tue, 25 Jan 2022 18:14:46 +0000
Date:   Tue, 25 Jan 2022 10:14:46 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1] binfmt_misc: fix crash when load/unload module
Message-ID: <YfA+FshocO96c/WH@bombadil.infradead.org>
References: <20220124003342.1457437-1-ztong0001@gmail.com>
 <202201241937.i9KSsyAj-lkp@intel.com>
 <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124151611.30db4381d910c853fc0c9728@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 24, 2022 at 03:16:11PM -0800, Andrew Morton wrote:
> On Mon, 24 Jan 2022 19:40:53 +0800 kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Tong,
> > 
> > 
> > >> fs/binfmt_misc.c:828:21: error: incompatible pointer types assigning to 'struct ctl_table_header *' from 'struct sysctl_header *' [-Werror,-Wincompatible-pointer-types]
> >            binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> >                               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.
> > 
> > 
> > vim +828 fs/binfmt_misc.c
> > 
> >    821	
> >    822	static int __init init_misc_binfmt(void)
> >    823	{
> >    824		int err = register_filesystem(&bm_fs_type);
> >    825		if (!err)
> >    826			insert_binfmt(&misc_format);
> >    827	
> >  > 828		binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");
> >    829		if (!binfmt_misc_header) {
> >    830			pr_warn("Failed to create fs/binfmt_misc sysctl mount point");
> >    831			return -ENOMEM;
> >    832		}
> >    833		return 0;
> >    834	}
> >    835	
> 
> This is actually a blooper in Luis's "sysctl: add helper to register a
> sysctl mount point".
> 
> Please test, review, ridicule, etc:
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: include/linux/sysctl.h: fix register_sysctl_mount_point() return type
> 
> The CONFIG_SYSCTL=n stub returns the wrong type.
> 
> Fixes: ee9efac48a082 ("sysctl: add helper to register a sysctl mount point")
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Tong Zhang <ztong0001@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
