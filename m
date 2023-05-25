Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE47108CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 11:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjEYJ02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238018AbjEYJ00 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 05:26:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE377195
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 02:26:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so2158615e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 May 2023 02:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685006783; x=1687598783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXorc/Ao0djwBR5i8gI65lCGvXzAg/Z+z3rr0V+9Wp4=;
        b=tpwpGVHDQLPfRjsQosbekXoWW5IgUuFzmpVGnPK78cdjjHQSclapCqZDFbLXpw45ht
         eT6TbvnFZg7NVZlF2JYoSvC6Yg+tdCtOJTPqL61bK7EcpzfTA62/1PkbaVDJ8FokLt1K
         jlhL2ztKglsbCqdcUAA0fi7gBi5x/DerzL7d5RGiFnuqSqNQWGvamJAINOARRL1tDaQo
         i2xmnhKfI33fbWPc01tA23Fnw2LBS/gROECrlm03rRdXQoUdMG1VMFZcGWWxTNr1Yx4v
         fOdcZgr2mRXHgwQDXLCRjVrBtu1QjcZ/HIqOwBXz/FD48NftK1wYeY+Weof/tZVNc4Mj
         v57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685006783; x=1687598783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXorc/Ao0djwBR5i8gI65lCGvXzAg/Z+z3rr0V+9Wp4=;
        b=j6k5J+jqW5/qh1yUGNSWKsabeNah8sDENWGefjusmyuep2bJWjPn2rUOzIapBtzPvG
         nssAqpCIBkJSV39oUE7bVNsiF+Sf1D/JC96IyH47TGLb+2SHh+hHlGXO4wgj9gxL/aJv
         Y3ttIygALHANZOXwZkpnPX48Q99FTRV1AMHdmVMfFcrBSsGXe/OvQYM7aZ/cAKr6SwSg
         +i2vj1UdlCMXowZmb4sVasklmjPSVvyKp0fpPEeYUbex1w5ujpGyie25+NZ4JK2lOft2
         YLp+z4RaSud26v0szVi3pv2zV31lDHQmhBhFNnxE7rFRLCbQOIbTYgxsegwSIsKW5CIS
         Jstw==
X-Gm-Message-State: AC+VfDzepz7bLI7QZi59cCvEPlLfSaKVucbjj9niAKoJumuKcq0fHaAC
        egKymoF/62mLwkCNrV7pl70mGA==
X-Google-Smtp-Source: ACHHUZ7rmoPjIMfC/+8a4HeULsZH8aC3cj93N62dkvYh8afc7wEE0h+bFB60yBgCHJ0V7O1OYUPGBA==
X-Received: by 2002:a05:600c:205a:b0:3f4:26d4:91b0 with SMTP id p26-20020a05600c205a00b003f426d491b0mr1860574wmg.40.1685006783337;
        Thu, 25 May 2023 02:26:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b003047f7a7ad1sm1133808wro.71.2023.05.25.02.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 02:26:21 -0700 (PDT)
Date:   Thu, 25 May 2023 07:46:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file
 handles
Message-ID: <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
 <20230524140648.u6pexxspze7pz63z@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524140648.u6pexxspze7pz63z@quack3>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 24, 2023 at 04:06:48PM +0200, Jan Kara wrote:
> Yes, I've checked and all ->encode_fh() implementations return
> FILEID_INVALID in case of problems (which are basically always only
> problems with not enough space in the handle buffer).

ceph_encode_fh() can return -EINVAL

$ smdb.py functions encode_fh > where
$ for i in $(cut -d '|' -f 3 where | sort -u) ; do smdb.py return_states $i ; done | grep INTER | tee out

regards,
dan carpenter

fs/btrfs/export.c | btrfs_encode_fh | 36 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/btrfs/export.c | btrfs_encode_fh | 37 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/btrfs/export.c | btrfs_encode_fh | 43 |            77|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/btrfs/export.c | btrfs_encode_fh | 44 |            79|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/btrfs/export.c | btrfs_encode_fh | 45 |            78|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 69 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 70 |         (-22)|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 71 |            78|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 72 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 73 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 88 |             2|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ceph/export.c | ceph_encode_fh | 89 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fat/nfs.c | fat_encode_fh_nostale | 84 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fat/nfs.c | fat_encode_fh_nostale | 85 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fat/nfs.c | fat_encode_fh_nostale | 88 |           114|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fat/nfs.c | fat_encode_fh_nostale | 89 |           113|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fuse/inode.c | fuse_encode_fh | 475 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fuse/inode.c | fuse_encode_fh | 478 |           130|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/fuse/inode.c | fuse_encode_fh | 479 |           129|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/gfs2/export.c | gfs2_encode_fh | 37 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/gfs2/export.c | gfs2_encode_fh | 38 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/gfs2/export.c | gfs2_encode_fh | 40 |             4|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/gfs2/export.c | gfs2_encode_fh | 42 |             8|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/isofs/export.c | isofs_export_encode_fh | 93 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/isofs/export.c | isofs_export_encode_fh | 94 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/isofs/export.c | isofs_export_encode_fh | 96 |             2|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/isofs/export.c | isofs_export_encode_fh | 97 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/kernfs/mount.c | kernfs_encode_fh | 59 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/kernfs/mount.c | kernfs_encode_fh | 60 |           254|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nfs/export.c | nfs_encode_fh | 39 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nfs/export.c | nfs_encode_fh | 45 | s32min-s32max|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nilfs2/namei.c | nilfs_encode_fh | 289 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nilfs2/namei.c | nilfs_encode_fh | 290 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nilfs2/namei.c | nilfs_encode_fh | 291 |            98|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/nilfs2/namei.c | nilfs_encode_fh | 292 |            97|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ocfs2/export.c | ocfs2_encode_fh | 213 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ocfs2/export.c | ocfs2_encode_fh | 214 |             2|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/ocfs2/export.c | ocfs2_encode_fh | 215 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/orangefs/super.c | orangefs_encode_fh | 100 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/orangefs/super.c | orangefs_encode_fh | 101 |             2|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/orangefs/super.c | orangefs_encode_fh | 102 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/overlayfs/export.c | ovl_encode_fh | 111 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/overlayfs/export.c | ovl_encode_fh | 112 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/overlayfs/export.c | ovl_encode_fh | 113 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/overlayfs/export.c | ovl_encode_fh | 114 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/overlayfs/export.c | ovl_encode_fh | 115 |           248|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/reiserfs/inode.c | reiserfs_encode_fh | 740 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/reiserfs/inode.c | reiserfs_encode_fh | 741 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/reiserfs/inode.c | reiserfs_encode_fh | 744 |             3|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/reiserfs/inode.c | reiserfs_encode_fh | 745 |             6|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/reiserfs/inode.c | reiserfs_encode_fh | 746 |             5|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
mm/shmem.c | shmem_encode_fh | 2144 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
mm/shmem.c | shmem_encode_fh | 2149 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/udf/namei.c | udf_encode_fh | 447 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/udf/namei.c | udf_encode_fh | 448 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/udf/namei.c | udf_encode_fh | 450 |            82|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/udf/namei.c | udf_encode_fh | 451 |            81|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/xfs/xfs_export.c | xfs_fs_encode_fh | 48 |           255|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/xfs/xfs_export.c | xfs_fs_encode_fh | 53 |           130|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/xfs/xfs_export.c | xfs_fs_encode_fh | 54 |           129|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/xfs/xfs_export.c | xfs_fs_encode_fh | 55 |             1|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
fs/xfs/xfs_export.c | xfs_fs_encode_fh | 56 |             2|        INTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct inode*) |
