Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D616DE41D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDKSoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 14:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjDKSog (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:44:36 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF7DE52
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 11:44:35 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1842e8a8825so10863845fac.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112; t=1681238674; x=1683830674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtGg8qzIAGJzBJdEOM7Y7uYY00XXCPirXOoDKESDF8E=;
        b=uOQRswTipTo+/h4sHnOvIu4FXDZylUmew82Dy1uLrqDXo4KaMGkWHj4OmzV2b/KY/M
         ivmc27+jhF65XMkpce4JH5PsQR5x1WboY9T7gIOo4ffhEt7kH6k78RkSFdq4sTzLt5Dx
         CBLmgpedia1rGSKYC7ro4wHU9apVRFPb4Hw8scqZoM11KuJ7QolnCIELmv/C5w5dd/vd
         oSJGzMEc6q1yCYtyVbjvChPL9UnRjnh7Y8e2Ds715idtS0jlYYs5h4d2n4PeGP6V8yxC
         Ii/zJClyZljkJDh+XUPA6/bbtkkBkC7kJsfcjzOSltypUD+dIXM6Jki6D68jhvVGgEJa
         eF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681238674; x=1683830674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtGg8qzIAGJzBJdEOM7Y7uYY00XXCPirXOoDKESDF8E=;
        b=j2dkKUhBv49E2U/1TzQUpmUUGrJRIIrND2TjQQHPfGjzGYRfxXf3rUhSukT2ZDOYPH
         foGb9Ez9s9oowSkdVNnbNsBSDKylWkPj2fstsULn2SRXDWnQqWBZQoRLyymjaRuekEA8
         cmgAO9HNgab7nAF2Wg4FMQAN7rBhuzJVgbf+aJsPSq/2fopaPQGpFNdMoHNPn/Zv9UtZ
         bbTDm1sPq/QJb93oN3AXjqU0VOHA5hVPO2hl29rgyiB+0yTZ+OX/YpzOrITcvxWj1SFD
         LLMQnIFUFe1wm96W+klzkbcHONbNcNFgzD8N4PUcPG/MQoP5WYhope9f2vyzzCzBiEVb
         4C4w==
X-Gm-Message-State: AAQBX9cmwN4+GLNC6XRAIEufDOMwvjtrYxvzAvPCZt3WrCfebCSfzUUg
        ZeCDH7Y/xDyT11/lnce4s1M28w==
X-Google-Smtp-Source: AKy350blrpI2hLZ9hpHMpMzNZw0khms9DDTPjBplBYVH5GAHP/ThnwrTXLHo5rv16+Xj3gDLgNZQpg==
X-Received: by 2002:a05:6870:738e:b0:184:3723:c145 with SMTP id z14-20020a056870738e00b001843723c145mr5994153oam.12.1681238674541;
        Tue, 11 Apr 2023 11:44:34 -0700 (PDT)
Received: from smtpclient.apple (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id ax15-20020a05687c020f00b0017243edbe5bsm5320962oac.58.2023.04.11.11.44.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:44:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [PATCH] hfsplus: remove WARN_ON() from
 hfsplus_cat_{read,write}_inode()
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <15308173-5252-d6a3-ae3b-e96d46cb6f41@I-love.SAKURA.ne.jp>
Date:   Tue, 11 Apr 2023 11:44:27 -0700
Cc:     syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        damien.lemoal@opensource.wdc.com, jlayton@kernel.org,
        willy@infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <04609E60-896F-4E40-96D3-1C9AC80F89D1@dubeyko.com>
References: <0000000000008a836b05eec3a7e9@google.com>
 <15308173-5252-d6a3-ae3b-e96d46cb6f41@I-love.SAKURA.ne.jp>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Apr 11, 2023, at 3:57 AM, Tetsuo Handa =
<penguin-kernel@I-love.SAKURA.ne.jp> wrote:
>=20
> syzbot is hitting WARN_ON() in hfsplus_cat_{read,write}_inode(), for
> crafted filesystem image can contain bogus length. There conditions =
are
> not kernel bugs that can justify kernel to panic.
>=20
> Reported-by: syzbot =
<syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=3De2787430e752a92b8750
> Reported-by: syzbot =
<syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=3D4913dca2ea6e4d43f3f1
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> fs/hfsplus/inode.c | 28 +++++++++++++++++++++++-----
> 1 file changed, 23 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index abb91f5fae92..b21660475ac1 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -511,7 +511,11 @@ int hfsplus_cat_read_inode(struct inode *inode, =
struct hfs_find_data *fd)
> 	if (type =3D=3D HFSPLUS_FOLDER) {
> 		struct hfsplus_cat_folder *folder =3D &entry.folder;
>=20
> -		WARN_ON(fd->entrylength < sizeof(struct =
hfsplus_cat_folder));
> +		if (fd->entrylength < sizeof(struct hfsplus_cat_folder)) =
{
> +			pr_err("bad catalog folder entry\n");
> +			res =3D -EIO;
> +			goto out;
> +		}
> 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
> 					sizeof(struct =
hfsplus_cat_folder));
> 		hfsplus_get_perms(inode, &folder->permissions, 1);
> @@ -531,7 +535,11 @@ int hfsplus_cat_read_inode(struct inode *inode, =
struct hfs_find_data *fd)
> 	} else if (type =3D=3D HFSPLUS_FILE) {
> 		struct hfsplus_cat_file *file =3D &entry.file;
>=20
> -		WARN_ON(fd->entrylength < sizeof(struct =
hfsplus_cat_file));
> +		if (fd->entrylength < sizeof(struct hfsplus_cat_file)) {
> +			pr_err("bad catalog file entry\n");
> +			res =3D -EIO;
> +			goto out;
> +		}
> 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
> 					sizeof(struct =
hfsplus_cat_file));
>=20
> @@ -562,6 +570,7 @@ int hfsplus_cat_read_inode(struct inode *inode, =
struct hfs_find_data *fd)
> 		pr_err("bad catalog entry used to create inode\n");
> 		res =3D -EIO;
> 	}
> +out:
> 	return res;
> }
>=20
> @@ -570,6 +579,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
> 	struct inode *main_inode =3D inode;
> 	struct hfs_find_data fd;
> 	hfsplus_cat_entry entry;
> +	int res =3D 0;
>=20
> 	if (HFSPLUS_IS_RSRC(inode))
> 		main_inode =3D HFSPLUS_I(inode)->rsrc_inode;
> @@ -588,7 +598,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
> 	if (S_ISDIR(main_inode->i_mode)) {
> 		struct hfsplus_cat_folder *folder =3D &entry.folder;
>=20
> -		WARN_ON(fd.entrylength < sizeof(struct =
hfsplus_cat_folder));
> +		if (fd.entrylength < sizeof(struct hfsplus_cat_folder)) =
{
> +			pr_err("bad catalog folder entry\n");
> +			res =3D -EIO;
> +			goto out;
> +		}
> 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
> 					sizeof(struct =
hfsplus_cat_folder));
> 		/* simple node checks? */
> @@ -613,7 +627,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
> 	} else {
> 		struct hfsplus_cat_file *file =3D &entry.file;
>=20
> -		WARN_ON(fd.entrylength < sizeof(struct =
hfsplus_cat_file));
> +		if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
> +			pr_err("bad catalog file entry\n");
> +			res =3D -EIO;
> +			goto out;
> +		}
> 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
> 					sizeof(struct =
hfsplus_cat_file));
> 		hfsplus_inode_write_fork(inode, &file->data_fork);
> @@ -634,7 +652,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
> 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
> out:
> 	hfs_find_exit(&fd);
> -	return 0;
> +	return res;
> }
>=20

Looks reasonable to me. Maybe, WARN_ON() provided the opportunity to see
the call stack of the issue. It could be useful for the issue=E2=80=99s =
environment
analysis. But returning error from the function(s) makes the execution =
flow
much better.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


> int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
> --=20
> 2.34.1
>=20

