Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324B6537A47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 14:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiE3MAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 08:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiE3MAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 08:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AE577CB32
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 May 2022 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653912015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s6m/WuTtMLiTml1zyTa6vH2XE0zybbCP5FZ30i2PI+w=;
        b=LMPiyBDQ+t/ktRN8QjamHK6b5fpjzHDiRMuS0Fxc7Zxe4DSzMmg+bZ4wjnnWRQXBOBU819
        7RDXUkX9XcyVJRP5KLj/HBbbP7BcSENox39W86WwD8Dci8faQQl3cmgPM7gQt+yq6GYeti
        Uad/6p/H7TNjnPDuhp5DtpOo0Xf4uRE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-246OYT5qPbK6TzGSISrxqg-1; Mon, 30 May 2022 08:00:13 -0400
X-MC-Unique: 246OYT5qPbK6TzGSISrxqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFB21802814;
        Mon, 30 May 2022 12:00:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFDAE492C3B;
        Mon, 30 May 2022 12:00:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 24UC0Cg0027804;
        Mon, 30 May 2022 08:00:12 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 24UC0CQ2027800;
        Mon, 30 May 2022 08:00:12 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 30 May 2022 08:00:12 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     manualinux@yahoo.es,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
cc:     ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: [PATCH] ntfs3: provide block_invalidate_folio to fix memory leak
In-Reply-To: <20220530131524.7fb5640d@yahoo.es>
Message-ID: <alpine.LRH.2.02.2205300746310.21817@file01.intranet.prod.int.rdu2.redhat.com>
References: <20220524075112.5438df32.ref@yahoo.es> <20220524075112.5438df32@yahoo.es> <alpine.LRH.2.02.2205240501130.17784@file01.intranet.prod.int.rdu2.redhat.com> <20220524113314.71fe17f0@yahoo.es> <20220525130538.38fd3d35@yahoo.es> <20220527072629.332b078d@yahoo.es>
 <20220527080211.15d631be@yahoo.es> <alpine.LRH.2.02.2205271338250.20527@file01.intranet.prod.int.rdu2.redhat.com> <20220528061836.22230f86@yahoo.es> <20220530131524.7fb5640d@yahoo.es>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="185206533-914130331-1653911218=:21817"
Content-ID: <alpine.LRH.2.02.2205300747050.21817@file01.intranet.prod.int.rdu2.redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185206533-914130331-1653911218=:21817
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.02.2205300747051.21817@file01.intranet.prod.int.rdu2.redhat.com>



On Mon, 30 May 2022, manualinux@yahoo.es wrote:

> 
> Hello again,
> 
> When you have time, try moving a large file from a SpadFS partition to
> an NTFS partition mounted with the NTFS3 driver and with a 5.18 kernel,
> and then, move the same file back again, to the SpadFS partition. At
> that very moment is when the size of the file remains permanently in
> the system memory (in my particular case). This does not happen if we
> do it to another Linux file system, nor does it happen if we do it from
> a NTFS partition to another XFS or Ext4 partition.
> 
> So no ccache or anything, I swap files quite often between the SpadFS
> partition and an external hard disk with an NTFS partition. Anyway,
> this problem is really unusual, and it must have some technical
> explanation, because with the ntfs-3g driver this doesn't happen.
> 
> If this information is of any use to you I will be satisfied.
> 
> Regards,
>      
> José Luis Lara Carrascal - Webmaster de Manualinux - GNU/Linux en
> Español (https://manualinux.es)

Hi

SpadFS is innocent here :)

The NTFS3 driver in the kernel 5.18 contains the same bug as SpadFS did - 
missing the invalidate_folio method. This patch adds this method and fixes 
the bug.

Mikulas



Author: Mikulas Patocka <mpatocka@redhat.com>

The ntfs3 filesystem lacks the 'invalidate_folio' method and it causes
memory leak. If you write to the filesystem and then unmount it, the
cached written data are not freed and they are permanently leaked.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: José Luis Lara Carrascal <manualinux@yahoo.es>
Fixes: 7ba13abbd31e ("fs: Turn block_invalidatepage into block_invalidate_folio")
Cc: stable@vger.kernel.org	# v5.18

---
 fs/ntfs3/inode.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/fs/ntfs3/inode.c
===================================================================
--- linux-2.6.orig/fs/ntfs3/inode.c	2022-05-16 16:57:24.000000000 +0200
+++ linux-2.6/fs/ntfs3/inode.c	2022-05-30 13:36:45.000000000 +0200
@@ -1951,6 +1951,7 @@ const struct address_space_operations nt
 	.direct_IO	= ntfs_direct_IO,
 	.bmap		= ntfs_bmap,
 	.dirty_folio	= block_dirty_folio,
+	.invalidate_folio = block_invalidate_folio,
 };
 
 const struct address_space_operations ntfs_aops_cmpr = {
--185206533-914130331-1653911218=:21817--

