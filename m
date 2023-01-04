Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF1165D3A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 14:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbjADNCi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 08:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjADNCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 08:02:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7B6167EF;
        Wed,  4 Jan 2023 05:02:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so23994020wro.9;
        Wed, 04 Jan 2023 05:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWjOlCqMwzQz/Hg94TN2KxI6imNafL+AVNRZZCemGVk=;
        b=TWF80AnTeMUmdMxOuazU8OayeCgApz3GNHYOaziZhvjkJ6R8P7mWJATQR9jXBbT2Al
         82xMyz4BGlqoNTaH8c+9tVjN9u8jjbOfnYc3M10cO33OdPc8ylLgfTpe6EkamBe77KwN
         Ns4RcWCrE4EexHFGh0d6/tbSBcvj8cpgiERYeN3Ps9TO3etSGxqwweCVn/HZn+Zw9aLz
         MYLebHrclSGhOw5mDlGjQmxell1WoAZbWoXBVH0JoIVXU0oz8X+3kEgzPYI3zYtzdlwP
         9uDCNIoKi3Z9et1m5pzX1jSwb6ZbSLkn5ie/gtsqvhWaQwNVu3A1uC2xTK1rusjXqZvT
         YvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWjOlCqMwzQz/Hg94TN2KxI6imNafL+AVNRZZCemGVk=;
        b=nVjvlVYQtNgshnPWiG6R8hiiLdb9BdaMXQ6BGoCWl96NvZeMG8qYRGvPmCqnGFiqTJ
         I2bjYo9wCLU5Q3WvH1Hs4o2z7It7vIX3C/u/T8YGPS4WFPpyqB6J0cvSRHdoP3zasfmu
         qbUdxoKyx2VqBpYYhvtXuCKI40lwAYVMvmKEJl/ZKG1wlxvOPzjlzVkYVhQeUTBribZy
         4zOY3zYCbR6vB5iEI1JyYl0/exSROzftrnyDbcyEUKYVrxwG7PZRJvaAHfVt7eMqivc1
         BfRrDM6DiNgnizt5cIw1cazQsHFqbOh7j/mf2snyHUAnbFkwcsRV6Yhrs4dSRijutq4B
         G+hg==
X-Gm-Message-State: AFqh2koU39eGeeQzFJ7EQaF760GCCwCV/KPH/AdIg0XRfOH5GVgZ7Ayo
        5l3KZZ0ocgv5jJbpHQZGWCI=
X-Google-Smtp-Source: AMrXdXtoldOFg6N0VCr5Vo24GCpxEqGx4BjSLHXShIJ3HiTr6wpi7qB3NEhQ6i6p2636C/XUGp6BhQ==
X-Received: by 2002:a5d:5612:0:b0:279:d235:790c with SMTP id l18-20020a5d5612000000b00279d235790cmr22354110wrv.42.1672837352461;
        Wed, 04 Jan 2023 05:02:32 -0800 (PST)
Received: from suse.localnet (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id e13-20020adfe7cd000000b0027f9f073211sm25104720wrn.65.2023.01.04.05.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:02:31 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Ira Weiny <ira.weiny@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 2/4] fs/sysv: Change the signature of dir_get_page()
Date:   Wed, 04 Jan 2023 14:02:30 +0100
Message-ID: <1840126.tdWV9SEqCh@suse>
In-Reply-To: <202301041814.3Lbh2QfK-lkp@intel.com>
References: <202301041814.3Lbh2QfK-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 4 gennaio 2023 12:59:24 CET Dan Carpenter wrote:
> Hi Fabio,
>=20
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:  =20
> https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/fs-sy=
sv-U
> se-the-offset_in_page-helper/20221231-155850 base: =20
> git://git.infradead.org/users/hch/configfs.git for-next
> patch link:  =20
> https://lore.kernel.org/r/20221231075717.10258-3-fmdefrancesco%40gmail.com
> patch subject: [PATCH 2/4] fs/sysv: Change the signature of dir_get_page()
> config: xtensa-randconfig-m031-20230101
> compiler: xtensa-linux-gcc (GCC) 12.1.0
>=20
> If you fix the issue, kindly add following tag where applicable
>=20
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
>=20
> smatch warnings:
> fs/sysv/dir.c:190 sysv_add_link() warn: passing zero to 'PTR_ERR'
>=20
> vim +/PTR_ERR +190 fs/sysv/dir.c
>=20
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  174  int=20
sysv_add_link(struct
> dentry *dentry, struct inode *inode) ^1da177e4c3f41 Linus Torvalds      =
=20
> 2005-04-16  175  {
> 2b0143b5c986be David Howells         2015-03-17  176  	struct inode *dir=
=20
=3D
> d_inode(dentry->d_parent); ^1da177e4c3f41 Linus Torvalds        2005-04-1=
6=20
> 177  	const char * name =3D dentry->d_name.name; ^1da177e4c3f41 Linus=20
Torvalds=20
>       2005-04-16  178  	int namelen =3D dentry->d_name.len;=20
^1da177e4c3f41
> Linus Torvalds        2005-04-16  179  	struct page *page =3D NULL;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  180  	struct=20
sysv_dir_entry
> * de; ^1da177e4c3f41 Linus Torvalds        2005-04-16  181  =09
unsigned long
> npages =3D dir_pages(dir); ^1da177e4c3f41 Linus Torvalds        2005-04-1=
6 =20
182
>  	unsigned long n; ^1da177e4c3f41 Linus Torvalds        2005-04-16 =20
183=20
> 	char *kaddr;
> 26a6441aadde86 Nicholas Piggin       2007-10-16  184  	loff_t pos;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  185  	int err;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  186
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  187  	/* We take care=20
of
> directory expansion in the same loop */ ^1da177e4c3f41 Linus Torvalds    =
  =20
> 2005-04-16  188  	for (n =3D 0; n <=3D npages; n++) { 4b8a9c0afda16b Fabi=
o M. De
> Francesco 2022-12-31  189  		kaddr =3D dir_get_page(dir, n, &page);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16 @190  		err =3D=20
PTR_ERR(page);
>=20
> This "err" assignment is a dead store (pointless/never used).

Hi Dan,

Thanks for catching it.
I'll wait for comments on this series one or two more days and then delete=
=20
that assignment.

Again thanks,

=46abio

> 4b8a9c0afda16b Fabio M. De Francesco 2022-12-31  191  		if=20
(IS_ERR(kaddr))
> 4b8a9c0afda16b Fabio M. De Francesco 2022-12-31  192  		=09
return
> PTR_ERR(kaddr); ^1da177e4c3f41 Linus Torvalds        2005-04-16  193  =09
	de =3D
> (struct sysv_dir_entry *)kaddr; 09cbfeaf1a5a67 Kirill A. Shutemov  =20
> 2016-04-01  194  		kaddr +=3D PAGE_SIZE - SYSV_DIRSIZE;=20
^1da177e4c3f41 Linus
> Torvalds        2005-04-16  195  		while ((char *)de <=3D kaddr)=20
{
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  196  		=09
if (!de->inode)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  197  		=09
	goto got_it;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  198  		=09
err =3D -EEXIST;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  199  		=09
if
> (namecompare(namelen, SYSV_NAMELEN, name, de->name)) ^1da177e4c3f41 Linus
> Torvalds        2005-04-16  200  				goto=20
out_page; ^1da177e4c3f41 Linus
> Torvalds        2005-04-16  201  			de++;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  202  		}
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  203  	=09
dir_put_page(page);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  204  	}
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  205  	BUG();
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  206  	return -EINVAL;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  207
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  208  got_it:
> 1023904333f9cb Fabio M. De Francesco 2022-12-31  209  	pos =3D=20
page_offset(page)
> + offset_in_page(de); ^1da177e4c3f41 Linus Torvalds        2005-04-16  21=
0=20
> 	lock_page(page); f4e420dc423148 Christoph Hellwig     2010-06-04 =20
211  	err
> =3D sysv_prepare_chunk(page, pos, SYSV_DIRSIZE); ^1da177e4c3f41 Linus Tor=
valds=20
>       2005-04-16  212  	if (err)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  213  		goto=20
out_unlock;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  214  	memcpy (de->name,=
=20
name,
> namelen); ^1da177e4c3f41 Linus Torvalds        2005-04-16  215  	memset
> (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2); ^1da177e4c3f41 Linus
> Torvalds        2005-04-16  216  	de->inode =3D
> cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino); 26a6441aadde86 Nicholas
> Piggin       2007-10-16  217  	err =3D dir_commit_chunk(page, pos,
> SYSV_DIRSIZE); 02027d42c3f747 Deepa Dinamani        2016-09-14  218=20
> 	dir->i_mtime =3D dir->i_ctime =3D current_time(dir); ^1da177e4c3f41=20
Linus
> Torvalds        2005-04-16  219  	mark_inode_dirty(dir); ^1da177e4c3f41=20
Linus
> Torvalds        2005-04-16  220  out_page:
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  221  =09
dir_put_page(page);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  222  	return err;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  223  out_unlock:
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  224  =09
unlock_page(page);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  225  	goto out_page;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  226  }
>=20
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp




