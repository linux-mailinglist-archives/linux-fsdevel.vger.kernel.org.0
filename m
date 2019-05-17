Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC54A21EFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 22:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfEQUSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 16:18:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55331 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbfEQUSj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 16:18:39 -0400
Received: from [192.168.4.253] (c-73-70-228-160.hsd1.ca.comcast.net [73.70.228.160])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x4HKIIrM1494008
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 17 May 2019 13:18:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x4HKIIrM1494008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558124301;
        bh=vdDVB5ppVXE7h0lfdpmULNAc1TPNhv9ZuI1v8nlJhKE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=w+h6VnLJISTUnmerbPvDhhsWCy/r0YsosYHQEnxdVxG2uoPtEu72EotaKkMA+IOKi
         /5ztDVZ9ZYTutKg1TMnU0B7RR9gadjw1szGEGs1uDLVMQ48nOzkQsPrDG0UUBaXVyv
         A4mk4bixtJWgj+qcqrbrItfmsUJYhcc1tr+BA1zdFagk7CnsltIs5pIvrEQkyg/QhI
         HaEfkfIRud2BCOMPltSa/tt0MKNzjyIr+E6w4VudCnVG6Dp2SR+7+JEFbgaaWVckE0
         c0DSjqSD4F4NPIbygtlbHtgrWQQf6+q85/2gmn8didrBz93R9GG8GLD3QA4jQbozAM
         vwTbflaM0/oqg==
Date:   Fri, 17 May 2019 13:18:11 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190517165519.11507-3-roberto.sassu@huawei.com>
References: <20190517165519.11507-1-roberto.sassu@huawei.com> <20190517165519.11507-3-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] initramfs: introduce do_readxattrs()
To:     Roberto Sassu <roberto.sassu@huawei.com>, viro@zeniv.linux.org.uk
CC:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, arnd@arndb.de,
        rob@landley.net, james.w.mcmechan@gmail.com, niveditas98@gmail.com
From:   hpa@zytor.com
Message-ID: <CD9A4F89-7CA5-4329-A06A-F8DEB87905A5@zytor.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 17, 2019 9:55:19 AM PDT, Roberto Sassu <roberto=2Esassu@huawei=2Ecom=
> wrote:
>This patch adds support for an alternative method to add xattrs to
>files in
>the rootfs filesystem=2E Instead of extracting them directly from the ram
>disk image, they are extracted from a regular file called =2Exattr-list,
>that
>can be added by any ram disk generator available today=2E The file format
>is:
>
><file #N data len (ASCII, 10 chars)><file #N path>\0
><xattr #N data len (ASCII, 8 chars)><xattr #N name>\0<xattr #N value>
>
>=2Exattr-list can be generated by executing:
>
>$ getfattr --absolute-names -d -h -R -e hex -m - \
>      <file list> | xattr=2Eawk -b > ${initdir}/=2Exattr-list
>
>where the content of the xattr=2Eawk script is:
>
>#! /usr/bin/awk -f
>{
>  if (!length($0)) {
>    printf("%=2E10x%s\0", len, file);
>    for (x in xattr) {
>      printf("%=2E8x%s\0", xattr_len[x], x);
>      for (i =3D 0; i < length(xattr[x]) / 2; i++) {
>        printf("%c", strtonum("0x"substr(xattr[x], i * 2 + 1, 2)));
>      }
>    }
>    i =3D 0;
>    delete xattr;
>    delete xattr_len;
>    next;
>  };
>  if (i =3D=3D 0) {
>    file=3D$3;
>    len=3Dlength(file) + 8 + 1;
>  }
>  if (i > 0) {
>    split($0, a, "=3D");
>    xattr[a[1]]=3Dsubstr(a[2], 3);
>    xattr_len[a[1]]=3Dlength(a[1]) + 1 + 8 + length(xattr[a[1]]) / 2;
>    len+=3Dxattr_len[a[1]];
>  };
>  i++;
>}
>
>Signed-off-by: Roberto Sassu <roberto=2Esassu@huawei=2Ecom>
>---
> init/initramfs=2Ec | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 99 insertions(+)
>
>diff --git a/init/initramfs=2Ec b/init/initramfs=2Ec
>index 0c6dd1d5d3f6=2E=2E6ec018c6279a 100644
>--- a/init/initramfs=2Ec
>+++ b/init/initramfs=2Ec
>@@ -13,6 +13,8 @@
> #include <linux/namei=2Eh>
> #include <linux/xattr=2Eh>
>=20
>+#define XATTR_LIST_FILENAME "=2Exattr-list"
>+
> static ssize_t __init xwrite(int fd, const char *p, size_t count)
> {
> 	ssize_t out =3D 0;
>@@ -382,6 +384,97 @@ static int __init __maybe_unused do_setxattrs(char
>*pathname)
> 	return 0;
> }
>=20
>+struct path_hdr {
>+	char p_size[10]; /* total size including p_size field */
>+	char p_data[];   /* <path>\0<xattrs> */
>+};
>+
>+static int __init do_readxattrs(void)
>+{
>+	struct path_hdr hdr;
>+	char *path =3D NULL;
>+	char str[sizeof(hdr=2Ep_size) + 1];
>+	unsigned long file_entry_size;
>+	size_t size, path_size, total_size;
>+	struct kstat st;
>+	struct file *file;
>+	loff_t pos;
>+	int ret;
>+
>+	ret =3D vfs_lstat(XATTR_LIST_FILENAME, &st);
>+	if (ret < 0)
>+		return ret;
>+
>+	total_size =3D st=2Esize;
>+
>+	file =3D filp_open(XATTR_LIST_FILENAME, O_RDONLY, 0);
>+	if (IS_ERR(file))
>+		return PTR_ERR(file);
>+
>+	pos =3D file->f_pos;
>+
>+	while (total_size) {
>+		size =3D kernel_read(file, (char *)&hdr, sizeof(hdr), &pos);
>+		if (size !=3D sizeof(hdr)) {
>+			ret =3D -EIO;
>+			goto out;
>+		}
>+
>+		total_size -=3D size;
>+
>+		str[sizeof(hdr=2Ep_size)] =3D 0;
>+		memcpy(str, hdr=2Ep_size, sizeof(hdr=2Ep_size));
>+		ret =3D kstrtoul(str, 16, &file_entry_size);
>+		if (ret < 0)
>+			goto out;
>+
>+		file_entry_size -=3D sizeof(sizeof(hdr=2Ep_size));
>+		if (file_entry_size > total_size) {
>+			ret =3D -EINVAL;
>+			goto out;
>+		}
>+
>+		path =3D vmalloc(file_entry_size);
>+		if (!path) {
>+			ret =3D -ENOMEM;
>+			goto out;
>+		}
>+
>+		size =3D kernel_read(file, path, file_entry_size, &pos);
>+		if (size !=3D file_entry_size) {
>+			ret =3D -EIO;
>+			goto out_free;
>+		}
>+
>+		total_size -=3D size;
>+
>+		path_size =3D strnlen(path, file_entry_size);
>+		if (path_size =3D=3D file_entry_size) {
>+			ret =3D -EINVAL;
>+			goto out_free;
>+		}
>+
>+		xattr_buf =3D path + path_size + 1;
>+		xattr_len =3D file_entry_size - path_size - 1;
>+
>+		ret =3D do_setxattrs(path);
>+		vfree(path);
>+		path =3D NULL;
>+
>+		if (ret < 0)
>+			break;
>+	}
>+out_free:
>+	vfree(path);
>+out:
>+	fput(file);
>+
>+	if (ret < 0)
>+		error("Unable to parse xattrs");
>+
>+	return ret;
>+}
>+
> static __initdata int wfd;
>=20
> static int __init do_name(void)
>@@ -391,6 +484,11 @@ static int __init do_name(void)
> 	if (strcmp(collected, "TRAILER!!!") =3D=3D 0) {
> 		free_hash();
> 		return 0;
>+	} else if (strcmp(collected, XATTR_LIST_FILENAME) =3D=3D 0) {
>+		struct kstat st;
>+
>+		if (!vfs_lstat(collected, &st))
>+			do_readxattrs();
> 	}
> 	clean_path(collected, mode);
> 	if (S_ISREG(mode)) {
>@@ -562,6 +660,7 @@ static char * __init unpack_to_rootfs(char *buf,
>unsigned long len)
> 		buf +=3D my_inptr;
> 		len -=3D my_inptr;
> 	}
>+	do_readxattrs();
> 	dir_utime();
> 	kfree(name_buf);
> 	kfree(symlink_buf);

Ok=2E=2E=2E I just realized this does not work for a modular initramfs, co=
mposed at load time from multiple files, which is a very real problem=2E Sh=
ould be easy enough to deal with: instead of one large file, use one compan=
ion file per source file, perhaps something like filename=2E=2Exattrs (sugg=
esting double dots to make it less likely to conflict with a "real" file=2E=
) No leading dot, as it makes it more likely that archivers will sort them =
before the file proper=2E

A side benefit is that the format can be simpler as there is no need to en=
code the filename=2E

A technically cleaner solution still, but which would need archiver modifi=
cations, would be to encode the xattrs as an optionally nameless file (just=
 an empty string) with a new file mode value, immediately following the ori=
ginal file=2E The advantage there is that the archiver itself could support=
 xattrs and other extended metadata (which has been requested elsewhere); t=
he disadvantage obviously is that that it requires new support in the archi=
ver=2E However, at least it ought to be simpler since it is still a higher =
protocol level than the cpio archive itself=2E

There's already one special case in cpio, which is the "!!!TRAILER!!!" fil=
ename; although I don't think it is part of the formal spec, to the extent =
there is one, I would expect that in practice it is always encoded with a m=
ode of 0, which incidentally could be used to unbreak the case where such a=
 filename actually exists=2E So one way to support such extended metadata w=
ould be to set mode to 0 and use the filename to encode the type of metadat=
a=2E I wonder how existing GNU or BSD cpio (the BSD one is better maintaine=
d these days) would deal with reading such a file; it would at least not be=
 a regression if it just read it still, possibly with warnings=2E It could =
also be possible to use bits 17:16 in the mode, which are traditionally alw=
ays zero (mode_t being 16 bits), but I believe are present in most or all o=
f the cpio formats for historical reasons=2E It might be accepted better by=
 existing implementations to use one of these high bits combined with S_IFR=
EG, I dont know=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
