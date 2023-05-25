Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9B171092B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 11:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240581AbjEYJss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 05:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjEYJsq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 05:48:46 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4555F191;
        Thu, 25 May 2023 02:48:45 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-439494cbfedso227423137.3;
        Thu, 25 May 2023 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685008124; x=1687600124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQh+45Nz0JdYt5YoKDhD/qR63ItYpY/eVsSLPvtod8Q=;
        b=eG1wbx4VBsjKLyjuDWKYKV/VkWjuc9Sv369WKPBhJGQ8wTWZViCohT5Hb9OPlFT8BV
         Sf00wKGtMMeDg5a5AhoRWLy/ForyOEMS2mwQTcYN2KHk2y8cJNqn786GA6YktTBI21Vm
         777Bpn37vsOc3ImxWTkIF6UA/DyyxLogn0f1tgvb8DVW/Xp1+wXnF335hs/Myvkr07SW
         2SOVWZQa4hG5H9duINgs0cFpnLKBSlfvmXbqjKk1UXFEsbBk/AI5U7qCEXQxlv8HEqzr
         bwTWVWsFNHwZKPL/cr0lVIr6+NkOXtR7r2d/yH4xxL6SOD6FrMwH8TDFwM2X5pf3heYa
         HOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685008124; x=1687600124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQh+45Nz0JdYt5YoKDhD/qR63ItYpY/eVsSLPvtod8Q=;
        b=iN6tOhEDYAZwJQVU2+Ihs0o9+EygWTNTUN/dM8OFOBFGfye0/GasWdpNvoCtSW71BX
         KbUFl7qRVwurkQCJYqbTiZwNX5VHy+P0LxvAtfw6Y7u7bKV7bX0KH8IRTJsnLgSmyJsj
         NWsz+qY3pVDgAC45ajDJk+M+uHXIP4a+MrMp8fTSiN++jG2m5yxw+CI7/amedipU+4E3
         lAU7NCE3oeA6zxw95oKWk1vbXUOPe2bTCipNENG58u2p7sLUQL6PjxmurRJn4h5T6c3V
         4Dpq8Wh+SS4y1v7f8CYqYqaDZwaTT/7KUAB3SVfMO2w6FUDp3KjOEHw0DJDRf7LigKIR
         hT2g==
X-Gm-Message-State: AC+VfDzPyHQuxEqMtHSAEXooCRnj2JoDhMpnGvrshrow9X40W0POgBlz
        iXyH7BxTFFRMC3cvnlrtSlIrq0Da1DMs4M3GFS4=
X-Google-Smtp-Source: ACHHUZ5pPduQ3JgOvASZqNytGhNjS1z0Sqe5F2B3v1y2iUv9Fp5ZPRNcu1YM8+0HWrmopbt8vDQPq7tyL4SyFrsQ1X8=
X-Received: by 2002:a05:6102:d5:b0:437:e49d:634a with SMTP id
 u21-20020a05610200d500b00437e49d634amr5259020vsp.35.1685008124269; Thu, 25
 May 2023 02:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <ca02955f-1877-4fde-b453-3c1d22794740@kili.mountain>
 <CAOQ4uxi6ST19WGkZiM=ewoK_9o-7DHvZcAc3v2c5GrqSFf0WDQ@mail.gmail.com>
 <20230524140648.u6pexxspze7pz63z@quack3> <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
In-Reply-To: <080107ac-873c-41dc-b7c7-208970181c40@kili.mountain>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 May 2023 12:48:33 +0300
Message-ID: <CAOQ4uxgA-kQOOp69pyKhQpMZZuyWZ0t6ir+nqL4yL9wX5CBNgQ@mail.gmail.com>
Subject: Re: [bug report] fanotify: support reporting non-decodeable file handles
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 12:26=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
>
> On Wed, May 24, 2023 at 04:06:48PM +0200, Jan Kara wrote:
> > Yes, I've checked and all ->encode_fh() implementations return
> > FILEID_INVALID in case of problems (which are basically always only
> > problems with not enough space in the handle buffer).
>
> ceph_encode_fh() can return -EINVAL

Ouch! thanks for pointing this out

Jeff,

In your own backyard ;-)
Do you think this new information calls for rebasing my fix on top of maste=
r
and marking it for stable? or is this still low risk in your opinion?

Thanks,
Amir.


>
> $ smdb.py functions encode_fh > where
> $ for i in $(cut -d '|' -f 3 where | sort -u) ; do smdb.py return_states =
$i ; done | grep INTER | tee out
>
> regards,
> dan carpenter
>
> fs/btrfs/export.c | btrfs_encode_fh | 36 |           255|        INTERNAL=
 | -1 |                      | int(*)(struct inode*, uint*, int*, struct in=
ode*) |
> fs/btrfs/export.c | btrfs_encode_fh | 37 |           255|        INTERNAL=
 | -1 |                      | int(*)(struct inode*, uint*, int*, struct in=
ode*) |
> fs/btrfs/export.c | btrfs_encode_fh | 43 |            77|        INTERNAL=
 | -1 |                      | int(*)(struct inode*, uint*, int*, struct in=
ode*) |
> fs/btrfs/export.c | btrfs_encode_fh | 44 |            79|        INTERNAL=
 | -1 |                      | int(*)(struct inode*, uint*, int*, struct in=
ode*) |
> fs/btrfs/export.c | btrfs_encode_fh | 45 |            78|        INTERNAL=
 | -1 |                      | int(*)(struct inode*, uint*, int*, struct in=
ode*) |
> fs/ceph/export.c | ceph_encode_fh | 69 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 70 |         (-22)|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 71 |            78|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 72 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 73 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 88 |             2|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/ceph/export.c | ceph_encode_fh | 89 |             1|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/fat/nfs.c | fat_encode_fh_nostale | 84 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/fat/nfs.c | fat_encode_fh_nostale | 85 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/fat/nfs.c | fat_encode_fh_nostale | 88 |           114|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/fat/nfs.c | fat_encode_fh_nostale | 89 |           113|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/fuse/inode.c | fuse_encode_fh | 475 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/fuse/inode.c | fuse_encode_fh | 478 |           130|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/fuse/inode.c | fuse_encode_fh | 479 |           129|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/gfs2/export.c | gfs2_encode_fh | 37 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/gfs2/export.c | gfs2_encode_fh | 38 |           255|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/gfs2/export.c | gfs2_encode_fh | 40 |             4|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/gfs2/export.c | gfs2_encode_fh | 42 |             8|        INTERNAL |=
 -1 |                      | int(*)(struct inode*, uint*, int*, struct inod=
e*) |
> fs/isofs/export.c | isofs_export_encode_fh | 93 |           255|        I=
NTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, st=
ruct inode*) |
> fs/isofs/export.c | isofs_export_encode_fh | 94 |           255|        I=
NTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, st=
ruct inode*) |
> fs/isofs/export.c | isofs_export_encode_fh | 96 |             2|        I=
NTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, st=
ruct inode*) |
> fs/isofs/export.c | isofs_export_encode_fh | 97 |             1|        I=
NTERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, st=
ruct inode*) |
> fs/kernfs/mount.c | kernfs_encode_fh | 59 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/kernfs/mount.c | kernfs_encode_fh | 60 |           254|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/nfs/export.c | nfs_encode_fh | 39 |           255|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/nfs/export.c | nfs_encode_fh | 45 | s32min-s32max|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/nilfs2/namei.c | nilfs_encode_fh | 289 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/nilfs2/namei.c | nilfs_encode_fh | 290 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/nilfs2/namei.c | nilfs_encode_fh | 291 |            98|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/nilfs2/namei.c | nilfs_encode_fh | 292 |            97|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/ocfs2/export.c | ocfs2_encode_fh | 213 |           255|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/ocfs2/export.c | ocfs2_encode_fh | 214 |             2|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/ocfs2/export.c | ocfs2_encode_fh | 215 |             1|        INTERNA=
L | -1 |                      | int(*)(struct inode*, uint*, int*, struct i=
node*) |
> fs/orangefs/super.c | orangefs_encode_fh | 100 |           255|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/orangefs/super.c | orangefs_encode_fh | 101 |             2|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/orangefs/super.c | orangefs_encode_fh | 102 |             1|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/overlayfs/export.c | ovl_encode_fh | 111 |           255|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/overlayfs/export.c | ovl_encode_fh | 112 |           255|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/overlayfs/export.c | ovl_encode_fh | 113 |           255|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/overlayfs/export.c | ovl_encode_fh | 114 |           255|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/overlayfs/export.c | ovl_encode_fh | 115 |           248|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/reiserfs/inode.c | reiserfs_encode_fh | 740 |           255|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/reiserfs/inode.c | reiserfs_encode_fh | 741 |           255|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/reiserfs/inode.c | reiserfs_encode_fh | 744 |             3|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/reiserfs/inode.c | reiserfs_encode_fh | 745 |             6|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> fs/reiserfs/inode.c | reiserfs_encode_fh | 746 |             5|        IN=
TERNAL | -1 |                      | int(*)(struct inode*, uint*, int*, str=
uct inode*) |
> mm/shmem.c | shmem_encode_fh | 2144 |           255|        INTERNAL | -1=
 |                      | int(*)(struct inode*, uint*, int*, struct inode*)=
 |
> mm/shmem.c | shmem_encode_fh | 2149 |             1|        INTERNAL | -1=
 |                      | int(*)(struct inode*, uint*, int*, struct inode*)=
 |
> fs/udf/namei.c | udf_encode_fh | 447 |           255|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/udf/namei.c | udf_encode_fh | 448 |           255|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/udf/namei.c | udf_encode_fh | 450 |            82|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/udf/namei.c | udf_encode_fh | 451 |            81|        INTERNAL | -=
1 |                      | int(*)(struct inode*, uint*, int*, struct inode*=
) |
> fs/xfs/xfs_export.c | xfs_fs_encode_fh | 48 |           255|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/xfs/xfs_export.c | xfs_fs_encode_fh | 53 |           130|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/xfs/xfs_export.c | xfs_fs_encode_fh | 54 |           129|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/xfs/xfs_export.c | xfs_fs_encode_fh | 55 |             1|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
> fs/xfs/xfs_export.c | xfs_fs_encode_fh | 56 |             2|        INTER=
NAL | -1 |                      | int(*)(struct inode*, uint*, int*, struct=
 inode*) |
