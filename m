Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6E610949
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 06:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJ1Eap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 00:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJ1Ean (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 00:30:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78340642E1;
        Thu, 27 Oct 2022 21:30:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l6so3723482pjj.0;
        Thu, 27 Oct 2022 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7vxRfNDB5EN1hgmTtbRLJQeEyhUNSYeroKj2HcQQ0M=;
        b=byLwWjYEbJtFUlpMSNlpvFJGOcSs+peGuwltGOi15ixS7J9B/d/yDJU8qlsuv1C6p5
         0DFuar3VK4MYl5KgXdhq6MvdsY9I43AbD2X3MoHfExpXKtcSFtTZNGEwJ1srCpdtMvg8
         OLXxU5nXt0GaKA01WPR4nNz74tQF8DXBVJuR89+E5ERfQOOvlTM/MkQHTDemRJcANZh3
         6so/OCMDiEby3FUDk3Zdei7JCZu4N6z3q7ty6YE2fLGqfn5ZOBMJqfNRCP1pM6RgVtWN
         uF52tQqeW2fEe8QWOwJzuwKtWy3xJNcVEve0tALh1AsOmrdylcPIwrntC2/r7Kk7E354
         D1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7vxRfNDB5EN1hgmTtbRLJQeEyhUNSYeroKj2HcQQ0M=;
        b=2qfHyUVNPeU8BphnpqYtzGl9351yxetlb/eVRIAeIiH8+OxOO0oid/vASiVxuYMHeG
         98NDcOfo0AqfSTAn8Ef6mZCZLHss+SaYWCIMH+/IRxfA1Fo/cHqR7K/SCnRk0ux4eMen
         meEGNJUeXi0YiQSf2D583HO961p2MdjKd/8yW+v0ZfPC+MI2DYsUR+fE344Y6V1tQvk/
         9Ba8xZFpwDHZEJBA+P+7owtDUENJPA7X6K2Yl71XKVZXAXRe1ZIhe8KpbooVdD4zNSJ9
         5QrxUMDdJpCLdqypQEaapgrVct6sbKPOoDHjIJFn+QAE8u3rQHRKBWVCw+l8sDMp8sxq
         tL5w==
X-Gm-Message-State: ACrzQf3D1S1mNki/kT79O9ut7W4LNGYUwPbW+UT3ylyT3EFQqO8GycIw
        Zuw0MJNPTRHTC88z4zm5zMdy5y9YiKU=
X-Google-Smtp-Source: AMsMyM4X9dEOyJoHvtteDH140dv+UHfPAepfhPYP7Je1KWDao+PFukonhRBD+GgAHCXG9KJhXU2nOg==
X-Received: by 2002:a17:90b:17c9:b0:213:32a9:465b with SMTP id me9-20020a17090b17c900b0021332a9465bmr13797192pjb.54.1666931440740;
        Thu, 27 Oct 2022 21:30:40 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id b18-20020a170902d51200b00186748fe6ccsm1972828plg.214.2022.10.27.21.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 21:30:40 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC 0/2] iomap: Add support for subpage dirty state tracking to improve write performance
Date:   Fri, 28 Oct 2022 10:00:31 +0530
Message-Id: <cover.1666928993.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Please find the RFC patchset which adds support for iomap subpage dirty state 
tracking which improves write performance and should reduce the write amplification 
on platforms with smaller filesystem blocksize compared to pagesize.
E.g. On Power with 64k default pagesize and with 4k XFS filesystem blocksize.

I have done some minimal fsstress and fstests testing using this patchset 
and haven't noticed any issues as such. Posting this RFC to get some 
initial comments/thoughts on the patch. 
I will run full fstests with XFS if this RFC looks good. 

From review perspective, it will be helpful if one can also review the error 
handling path. I wasn't sure on whether we need to clear the dirty state bitmap 
of blocks within a folio or not in iomap_writepage_map(). I don't clear that,
since AFAIU, the error in that function is due to failed ->map_blocks() function
which has nothing to do with tracking subpage dirty state of a block within
folio. But please let me know your thoughts on this or other error handling path.


Performance results
======================
1. Performance testing of below fio workload reveals ~16x performance
improvement on nvme with XFS (4k blocksize) on Power (64K pagesize)
FIO reported write bw scores, improved from ~28 MBps to ~452 MBps.

<test_randwrite.fio>
[global]
	ioengine=psync
	rw=randwrite
	overwrite=1
	pre_read=1
	direct=0
	bs=4k
	size=1G
	dir=./
	numjobs=8
	fdatasync=1
	runtime=60
	iodepth=64
	group_reporting=1

[fio-run]

2. Also our internal performance team reported that this patch improves there
   database workload performance by around ~83% (with XFS on Power)


Note: I did come across an older RFC around the same logic to track subpage
dirty tracking here [1]. But it seems no one pursued it after iomap received
folio changes update. 

[1]: https://lore.kernel.org/linux-xfs/20200821123306.1658495-1-yukuai3@huawei.com/#t

Ritesh Harjani (IBM) (2):
  iomap: Change uptodate variable name to state
  iomap: Support subpage size dirty tracking to improve write performance

 fs/iomap/buffered-io.c | 79 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 15 deletions(-)

-- 
2.37.3

