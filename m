Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7F63831B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 05:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKYESn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 23:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKYESl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 23:18:41 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E354C28E06;
        Thu, 24 Nov 2022 20:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pxM0Tai1NwFg2mqAJQ1nSkdVi+JTmOQz5Ac0dKx9+yk=; b=taGO1ATiA5q4QgCU8nnvoBtIcc
        lO9tlrR7Y/phz7gCl0S4yEi9UyLuDogzERxdHX9JqxMx7QNxr0xB2EhdUMJOdDgEyHWEEp5DDWN9u
        l6Gzx6ztvsZLRESGJpoB6+OUFikQQXY7cjlOv796YW8IR5gYUYdrkSTQ1rzAWyIzqZdM96Z0MOFAh
        OiUvYtMAfx5zuGD88T9ju9s/hCqn2q7fdDoZUXY/GEnTjJzKS2dwZkaYWZxZpBR6zT3XXo0QMw1vZ
        izeGgBxcMCN4zr8t1TxKibzgwAf91BD4KL+Z4b7yozfju0WMWwTJUD1dHKmLwOqtq1C74L5M9SCfu
        eN4qXCrg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oyQAK-006aa1-1q;
        Fri, 25 Nov 2022 04:18:16 +0000
Date:   Fri, 25 Nov 2022 04:18:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Nitesh Shetty <nj.shetty@samsung.com>, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        james.smart@broadcom.com, kch@nvidia.com, naohiro.aota@wdc.com,
        jth@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, anuj20.g@samsung.com,
        joshi.k@samsung.com, p.raghav@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com
Subject: Re: [PATCH v5 10/10] fs: add support for copy file range in zonefs
Message-ID: <Y4BCCB9U10mkiehu@ZenIV>
References: <20221123055827.26996-1-nj.shetty@samsung.com>
 <CGME20221123061044epcas5p2ac082a91fc8197821f29e84278b6203c@epcas5p2.samsung.com>
 <20221123055827.26996-11-nj.shetty@samsung.com>
 <729254f8-2468-e694-715e-72bcbef80ff3@opensource.wdc.com>
 <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <349a4d66-3a9f-a095-005c-1f180c5f3aac@opensource.wdc.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:47:55AM +0900, Damien Le Moal wrote:
> >> +	inode_lock(src_inode);
> >> +	inode_lock(dst_inode);
> > 
> > So you did zonefs_copy_file_checks() outside of these locks, which mean
> > that everything about the source and destination files may have changed.
> > This does not work.
> 
> I forgot to mention that locking 2 inodes blindly like this can leads to
> deadlocks if another process tries a copy range from dst to src at the
> same time (lock order is reversed and so can deadlock).

Not to mention the deadlocks with existing places where fs/namei.c locks
two inodes...
