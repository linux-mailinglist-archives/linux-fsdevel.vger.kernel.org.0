Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AA64F0BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 19:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiLPSJK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 13:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiLPSJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 13:09:08 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CD433C26
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 10:09:07 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id x25-20020a056830115900b00670932eff32so1838850otq.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 10:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMhT+z9S4ajvxZOpLPtLzBkB1H+/PH1H0XtszQxrbJw=;
        b=3VAfy5O+VCkVtOfxakZNYZE++GSccgfUZynRfiJZVTPmwzodC4nBISkvKJKCVVzsfC
         bOrRm41GoJ4b9FJr93ZFQCakcWBYH8fM2DL5hUog5orU9DPbO2FSAIUBkJwczrO4oZku
         duKKS2eLGkOFTbR8mx9HnMp+xhkv1yjMFjpRBd83NBxJ2euotrQkoRiDdRNw96HvQVrQ
         T+WRwxhhEowAQdcNilPYv/pQUoQ1dQkGEU15amAK34TiJPg5W7wvzz1x3P4F7qZmiQae
         D+OQyPl6e/imaEvApBo3SULLI+ZdNrYbFkaDKCznkaEOExr35qiluRQwUod6XbFcHkAu
         JQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMhT+z9S4ajvxZOpLPtLzBkB1H+/PH1H0XtszQxrbJw=;
        b=fUvDxUd9x7nEeLQ/l5NoUOvvNlRmGE8+LONfGZ/q9PYC06hzG59x0FNncX3BocP9cL
         AIbt5NCPlUcyuBewkdnPDcPGEpw8FDNf2YHMuHCQFL9Q8BM///e2aCCjYhGiTKSn3piq
         CiRUaqJT1O0yevsRLCSv0Tgt8iEKA/7ovTyjnWSvP75sBufPtKWRIeCoWC5ppI8bKQzr
         gtMeC6YCpsaGjDRmMgRMisKRCxp4cf+0DaCmhiNSoPnh6XUkPsuX+4PLe7WvQyRC/kX7
         iKmY65avuIVHEXaiZ+osd5VqGWm/9iwUal4ABSuEQHlbWr+napVp5Ob67PRddXtLh1Ov
         D7VQ==
X-Gm-Message-State: ANoB5pl499RkJuFstE8KjfHp4sCv9eo9CxUsqC097hgRg6CF3ruQg4ls
        97Wmh531TIgnmKHin35t7yJ2XA==
X-Google-Smtp-Source: AA0mqf4s8QbHTaWAc78Qc0VKG9ixx0lYe4dR2HPiAeNsWHPMuXp46GHQm+sR36gi9GPrhCSGzz/Zqg==
X-Received: by 2002:a9d:7345:0:b0:670:9f08:2c48 with SMTP id l5-20020a9d7345000000b006709f082c48mr9495152otk.9.1671214146523;
        Fri, 16 Dec 2022 10:09:06 -0800 (PST)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683022fa00b00661ad8741b4sm1139620otc.24.2022.12.16.10.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Dec 2022 10:09:05 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 2/2] hfsplus: fix uninit-value in hfsplus_delete_cat()
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <946950be-482c-ef9f-404c-2ce758ba175d@huawei.com>
Date:   Fri, 16 Dec 2022 10:09:00 -0800
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aditya Garg <gargaditya08@live.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>, hannes@cmpxchg.org,
        "Theodore Y . Ts'o" <tytso@mit.edu>, muchun.song@linux.dev,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B5CECB6-C620-479A-A8EC-817CCCD9ECBB@dubeyko.com>
References: <20221215081820.948990-1-chenxiaosong2@huawei.com>
 <20221215081820.948990-3-chenxiaosong2@huawei.com>
 <6258B9FC-0A00-46BC-9C6C-720963D58A06@dubeyko.com>
 <946950be-482c-ef9f-404c-2ce758ba175d@huawei.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Dec 15, 2022, at 5:16 PM, ChenXiaoSong <chenxiaosong2@huawei.com> =
wrote:
>=20
> =E5=9C=A8 2022/12/16 3:03, Viacheslav Dubeyko =E5=86=99=E9=81=93:
>> Maybe, I am missing something. But where in the second version of the =
patch
>> initialization of subfolders?
>=20
> The first patch of the patchset factor out hfsplus_init_inode() from =
hfsplus_new_inode():
>=20
> void hfsplus_init_inode(struct hfsplus_inode_info *hip)
> {
>        INIT_LIST_HEAD(&hip->open_dir_list);
>        spin_lock_init(&hip->open_dir_lock);
>        mutex_init(&hip->extents_lock);
>        atomic_set(&hip->opencnt, 0);
>        hip->extent_state =3D 0;
>        hip->flags =3D 0;
>        hip->userflags =3D 0;
>        hip->subfolders =3D 0; /* I am here */
>        memset(hip->first_extents, 0, sizeof(hfsplus_extent_rec));
>        memset(hip->cached_extents, 0, sizeof(hfsplus_extent_rec));
>        hip->alloc_blocks =3D 0;
>        hip->first_blocks =3D 0;
>        hip->cached_start =3D 0;
>        hip->cached_blocks =3D 0;
>        hip->phys_size =3D 0;
>        hip->fs_blocks =3D 0;
>        hip->rsrc_inode =3D NULL;
> }

As far as I can see, you sent 0/2, 1/2, 2/2 patches in second version. =
And patch 1/2 contains
only this:

diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6aa919e59483..2aa719e00ae5 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -472,6 +472,7 @@ extern const struct dentry_operations =
hfsplus_dentry_operations;

int hfsplus_write_begin(struct file *file, struct address_space =
*mapping,
		loff_t pos, unsigned len, struct page **pagep, void =
**fsdata);
+void hfsplus_init_inode(struct hfsplus_inode_info *hip);
struct inode *hfsplus_new_inode(struct super_block *sb, struct inode =
*dir,
				umode_t mode);
void hfsplus_delete_inode(struct inode *inode);
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 840577a0c1e7..d921b32d292e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -379,22 +379,8 @@ static const struct file_operations =
hfsplus_file_operations =3D {
	.unlocked_ioctl =3D hfsplus_ioctl,
};

-struct inode *hfsplus_new_inode(struct super_block *sb, struct inode =
*dir,
-				umode_t mode)
+void hfsplus_init_inode(struct hfsplus_inode_info *hip)
{
-	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
-	struct inode *inode =3D new_inode(sb);
-	struct hfsplus_inode_info *hip;
-
-	if (!inode)
-		return NULL;
-
-	inode->i_ino =3D sbi->next_cnid++;
-	inode_init_owner(&init_user_ns, inode, dir, mode);
-	set_nlink(inode, 1);
-	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D =
current_time(inode);
-
-	hip =3D HFSPLUS_I(inode);
	INIT_LIST_HEAD(&hip->open_dir_list);
	spin_lock_init(&hip->open_dir_lock);
	mutex_init(&hip->extents_lock);
@@ -412,6 +398,25 @@ struct inode *hfsplus_new_inode(struct super_block =
*sb, struct inode *dir,
	hip->phys_size =3D 0;
	hip->fs_blocks =3D 0;
	hip->rsrc_inode =3D NULL;
+}
+
+struct inode *hfsplus_new_inode(struct super_block *sb, struct inode =
*dir,
+				umode_t mode)
+{
+	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
+	struct inode *inode =3D new_inode(sb);
+	struct hfsplus_inode_info *hip;
+
+	if (!inode)
+		return NULL;
+
+	inode->i_ino =3D sbi->next_cnid++;
+	inode_init_owner(&init_user_ns, inode, dir, mode);
+	set_nlink(inode, 1);
+	inode->i_mtime =3D inode->i_atime =3D inode->i_ctime =3D =
current_time(inode);
+
+	hip =3D HFSPLUS_I(inode);
+	hfsplus_init_inode(hip);
	if (S_ISDIR(inode->i_mode)) {
		inode->i_size =3D 2;
		sbi->folder_count++;
--=20
2.31.1

So, where is here hip->subfolders =3D 0; /* I am here */? Sorry, maybe I =
missed some email.

Thanks,
Slava.


