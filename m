Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FADE6F69A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjEDLOc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 07:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDLOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 07:14:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE1A3A82
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 May 2023 04:14:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3063208beedso273466f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 May 2023 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683198868; x=1685790868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yH3bt14dGnfscNm47+nXT+mBzcYegduTl6Jt3DNt4m0=;
        b=FsdKdWOqLjHCkoYNLSEU2nhueCHjdj/l+NlkCGCp4OwatyMTaurP+wfzEY8qgyJxpm
         ONMl4fZ4YPebYy4D8PoXsTvRxpmhrJkSFgJj9MsOuSt39/MSJ7sdfoA/7HR6hsN1XRKt
         Cbiei1gQGV8RvYaPmCq7utIbQGirNLTNmm67ohBKKhmY3iFQ7NkyM2rhgGuHKdxSY7lo
         NAI4s4W4qAEiHq9uAPqubJKsQsxFocvzo80FEGuKb2hPKd5I0tUESSDETBqHnLPl2ZE3
         7yW5JawcMA6SvyHWf1FlO56fQDFj1LWso23yy1M5vrwG5rXZ+M/RU899kDkABHqKmiuh
         4IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683198868; x=1685790868;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH3bt14dGnfscNm47+nXT+mBzcYegduTl6Jt3DNt4m0=;
        b=T+bqiIzZ7KczIGSPT0d2d+LpG/y+CHhwaCuVw4qEIBnhrJCaEs1b11APEOS2ai8+ny
         Gf3ZgFihanufTQi+mnWMucY7NLvdJaShMUEZWxIlqNHFNyCh7hjctxgTrZl9vQjLG84E
         170CWPf0yjEjK6k6dvheyBxd2wJyxN/S0Cdf+8WBW3Unb4wzE+VKc+rWreiotfo08/+u
         6uARWfv8g2xzihxsGCEkwgK8NKXBBB9UY3VSyaR+DOcbFerHejKMXv5ruYKRdko+1Xw/
         ZeeS5d/TI0mPpi2s3T0xKahpeg5UO0d4ry2aSsh13rkgoH0WmVLW9TGLrCTEVje3cyWG
         MNwg==
X-Gm-Message-State: AC+VfDybZ1uOD+TQ5X7FMswxHdkGIGQAGLiARgcJki6x2/sNvLghv4XR
        i9BEbeSgiB6bFv+FIUMecsPC3Q==
X-Google-Smtp-Source: ACHHUZ6WPZzK6gnDryZoi2sgkeE2nomZehsMB62P2PMmWfIj+qOh4DdUJEJ2JbH0nMm+TuxiLE7Lqg==
X-Received: by 2002:a5d:4b06:0:b0:306:3995:a123 with SMTP id v6-20020a5d4b06000000b003063995a123mr2142214wrq.27.1683198867997;
        Thu, 04 May 2023 04:14:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f4-20020a0560001b0400b002ffbf2213d4sm36643705wrz.75.2023.05.04.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 04:14:25 -0700 (PDT)
Date:   Thu, 4 May 2023 14:14:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     penguin-kernel@i-love.sakura.ne.jp
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fs: hfsplus: remove WARN_ON() from
 hfsplus_cat_{read,write}_inode()
Message-ID: <6caecd65-bd3c-45d4-8bfa-f73ddc072e94@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Tetsuo Handa,

The patch 81b21c0f0138: "fs: hfsplus: remove WARN_ON() from
hfsplus_cat_{read,write}_inode()" from Apr 11, 2023, leads to the
following Smatch static checker warning:

	fs/hfsplus/inode.c:596 hfsplus_cat_write_inode()
	warn: missing error code here? 'hfsplus_find_cat()' failed. 'res' = '0'

fs/hfsplus/inode.c
    577 int hfsplus_cat_write_inode(struct inode *inode)
    578 {
    579         struct inode *main_inode = inode;
    580         struct hfs_find_data fd;
    581         hfsplus_cat_entry entry;
    582         int res = 0;
    583 
    584         if (HFSPLUS_IS_RSRC(inode))
    585                 main_inode = HFSPLUS_I(inode)->rsrc_inode;
    586 
    587         if (!main_inode->i_nlink)
    588                 return 0;
    589 
    590         if (hfs_find_init(HFSPLUS_SB(main_inode->i_sb)->cat_tree, &fd))
    591                 /* panic? */
    592                 return -EIO;
    593 
    594         if (hfsplus_find_cat(main_inode->i_sb, main_inode->i_ino, &fd))
    595                 /* panic? */
--> 596                 goto out;

res = -EIO?

    597 
    598         if (S_ISDIR(main_inode->i_mode)) {
    599                 struct hfsplus_cat_folder *folder = &entry.folder;
    600 
    601                 if (fd.entrylength < sizeof(struct hfsplus_cat_folder)) {
    602                         pr_err("bad catalog folder entry\n");
    603                         res = -EIO;
    604                         goto out;
    605                 }
    606                 hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
    607                                         sizeof(struct hfsplus_cat_folder));
    608                 /* simple node checks? */
    609                 hfsplus_cat_set_perms(inode, &folder->permissions);
    610                 folder->access_date = hfsp_ut2mt(inode->i_atime);
    611                 folder->content_mod_date = hfsp_ut2mt(inode->i_mtime);
    612                 folder->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
    613                 folder->valence = cpu_to_be32(inode->i_size - 2);
    614                 if (folder->flags & cpu_to_be16(HFSPLUS_HAS_FOLDER_COUNT)) {
    615                         folder->subfolders =
    616                                 cpu_to_be32(HFSPLUS_I(inode)->subfolders);
    617                 }
    618                 hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
    619                                          sizeof(struct hfsplus_cat_folder));
    620         } else if (HFSPLUS_IS_RSRC(inode)) {
    621                 struct hfsplus_cat_file *file = &entry.file;
    622                 hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
    623                                sizeof(struct hfsplus_cat_file));
    624                 hfsplus_inode_write_fork(inode, &file->rsrc_fork);
    625                 hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
    626                                 sizeof(struct hfsplus_cat_file));
    627         } else {
    628                 struct hfsplus_cat_file *file = &entry.file;
    629 
    630                 if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
    631                         pr_err("bad catalog file entry\n");
    632                         res = -EIO;
    633                         goto out;
    634                 }
    635                 hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
    636                                         sizeof(struct hfsplus_cat_file));
    637                 hfsplus_inode_write_fork(inode, &file->data_fork);
    638                 hfsplus_cat_set_perms(inode, &file->permissions);
    639                 if (HFSPLUS_FLG_IMMUTABLE &
    640                                 (file->permissions.rootflags |
    641                                         file->permissions.userflags))
    642                         file->flags |= cpu_to_be16(HFSPLUS_FILE_LOCKED);
    643                 else
    644                         file->flags &= cpu_to_be16(~HFSPLUS_FILE_LOCKED);
    645                 file->access_date = hfsp_ut2mt(inode->i_atime);
    646                 file->content_mod_date = hfsp_ut2mt(inode->i_mtime);
    647                 file->attribute_mod_date = hfsp_ut2mt(inode->i_ctime);
    648                 hfs_bnode_write(fd.bnode, &entry, fd.entryoffset,
    649                                          sizeof(struct hfsplus_cat_file));
    650         }
    651 
    652         set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
    653 out:
    654         hfs_find_exit(&fd);
    655         return res;
    656 }

regards,
dan carpenter
