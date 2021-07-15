Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190943CAFF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhGPAHN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 20:07:13 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:29118 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhGPAHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 20:07:04 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210716000408epoutp034c83826fc69c886639bdcc76349aa8f3~SHJal_B_h0468004680epoutp03c
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jul 2021 00:04:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210716000408epoutp034c83826fc69c886639bdcc76349aa8f3~SHJal_B_h0468004680epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626393848;
        bh=j2kzLNB+0mbogiu26v6+dNSgU1Dz4I+pKyBxOp59DQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZVlNnjbk5/I4qD/hFk5dFdtWV/Yc1+pCdfVv5MOGGO/76nTYCr+QdcOrVeyvONe7B
         l3du8T5UtP0xCkPIeMjmmp9eBOnwgwHJ1cVJj9QpPnRgtXYTAlcAfs1ETtUeCLBBWh
         IFprTgcLD7OJjsHPYF5n6bG8at67t2+bFDBUIo2o=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210716000403epcas1p276ad7f08625bb866ac974d7aae830192~SHJVpP1Tx0789907899epcas1p2X;
        Fri, 16 Jul 2021 00:04:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GQs0f1kR4z4x9Q1; Fri, 16 Jul
        2021 00:04:02 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.0E.13454.1FCC0F06; Fri, 16 Jul 2021 09:04:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210716000354epcas1p16242ac95ff24f244fd94c0c49d1de0fa~SHJNOfaA12258022580epcas1p1X;
        Fri, 16 Jul 2021 00:03:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210716000354epsmtrp16ac661616d50154a3d1bdad564c20bad~SHJNMwRHz2134121341epsmtrp1F;
        Fri, 16 Jul 2021 00:03:54 +0000 (GMT)
X-AuditID: b6c32a39-185ff7000002348e-ef-60f0ccf1a0c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.FA.08394.AECC0F06; Fri, 16 Jul 2021 09:03:54 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210716000353epsmtip29282b57089dc9ae38a59aeb1645a771d~SHJMqRqGX1664016640epsmtip2T;
        Fri, 16 Jul 2021 00:03:53 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        senozhatsky@chromium.org, sandeen@sandeen.net, willy@infradead.org,
        hch@infradead.org, viro@zeniv.linux.org.uk,
        ronniesahlberg@gmail.com, dan.carpenter@oracle.com, hch@lst.de,
        christian@brauner.io, smfrench@gmail.com, hyc.lee@gmail.com,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v6 09/13] ksmbd: add smb3 engine part 2
Date:   Fri, 16 Jul 2021 08:53:52 +0900
Message-Id: <20210715235356.3191-10-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715235356.3191-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmge6nMx8SDNrnsVgcf/2X3aLxnbLF
        63/TWSxOT1jEZLFy9VEmi2v337NbvPi/i9ni5//vjBZ79p5ksbi8aw6bxY/p9Ra9fZ9YLVqv
        aFns3riIzeLNi8NsFrcmzmezOP/3OKvF7x9z2ByEPP7O/cjsMbvhIovHzll32T02r9Dy2L3g
        M5PH7psNbB6tO/6ye3x8eovFo2/LKkaPLYsfMnl83iTnsenJW6YAnqgcm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zByg55QUyhJzSoFCAYnFxUr6djZF
        +aUlqQoZ+cUltkqpBSk5BYYGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZx2ZeYi84sUCoYvvK
        V8wNjJfP83cxcnJICJhILPh3jKmLkYtDSGAHo8SS1cfYIJxPjBLd106yQjjfGCUm3l3PCNPy
        dMc5qMReRomFZ56xgSTAWrYtMu9i5OBgE9CW+LNFFCQsIhArcWPHa2aQemaBLmaJp/fPMIEk
        hAXMJXZe/QxmswioShzYfRnM5hWwkbiw4j07xDJ5idUbDjCD2JxA8ccnvzGCDJIQOMMh8WtG
        EyvIMgkBF4lF070g6oUlXh3fAtUrJfGyvw3KLpc4cfIXE4RdI7Fh3j52iFZjiZ4XJSAms4Cm
        xPpd+hAVihI7f88Fe5dZgE/i3dceqEW8Eh1tQhAlqhJ9lw5DDZSW6Gr/ALXIQ2L5vS0skNDp
        Z5Q4s2oL+wRGuVkIGxYwMq5iFEstKM5NTy02LDBFjrFNjODUq2W5g3H62w96hxiZOBgPMUpw
        MCuJ8C41epsgxJuSWFmVWpQfX1Sak1p8iNEUGHQTmaVEk/OByT+vJN7Q1MjY2NjCxMzczNRY
        SZx3J9uhBCGB9MSS1OzU1ILUIpg+Jg5OqQYmi6zXMx7fO1wWkrTzEf/rhj0fNxxRzP7I/8Kl
        +5Uje1jwGrkJNrP/b/5115xpVXGb/ROTzISH4k5cl+qu+j+9xDT/dfXvuXYPlEMesywLflpX
        qPXNajun8M++D3mTtC2rni+w51DdeTvwqETNzx9N0U7SO5Pu5Wt7+3IraiU4vZ1sm/vz9hye
        5oLXh+bq1ez3Y047P92kmIuFQfrhM0aWMLNth05nfa67rq5yTU9/Z83cK+UGoeJhwsze+spr
        1qX03cxt+7OqxUFR+EPm/uy5z44vYrt9xlq3cO5lmz+rZssvuxPn7G1+UFSuc7aQi4Xq7SIt
        1ch3DN45XPMrd57u31FyT1uqtyqxde0W7iVKLMUZiYZazEXFiQCSNTbFRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvO6rMx8SDLY94bU4/vovu0XjO2WL
        1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y16+z6xWrRe
        0bLYvXERm8WbF4fZLG5NnM9mcf7vcVaL3z/msDkIefyd+5HZY3bDRRaPnbPusntsXqHlsXvB
        ZyaP3Tcb2Dxad/xl9/j49BaLR9+WVYweWxY/ZPL4vEnOY9OTt0wBPFFcNimpOZllqUX6dglc
        GcdmXmIvOLFAqGL7ylfMDYyXz/N3MXJySAiYSDzdcY61i5GLQ0hgN6PEnYevmCES0hLHTpwB
        sjmAbGGJw4eLIWo+MEqsPneFCSTOJqAt8WeLKEi5iEC8xM2G2ywgNcwCc5gldm48wgiSEBYw
        l9h59TMTiM0ioCpxYPdlMJtXwEbiwor37BC75CVWbzgAtpcTKP745DewXiEBa4n1azawTGDk
        W8DIsIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhKtDR3MG5f9UHvECMTB+MhRgkO
        ZiUR3qVGbxOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
        YLqUl2L6J7hBu+jC29tnVrXVyyRun1Kd/nzFY9ETqfMtj+hw9fvyRb3kTvM85Ls4aKLFBjvu
        9X6vpGKCw5iu2YjG8t+L+JA09+O0rb5zFq3ZGWhl7Pro/8e02obOh67z1Xd/8T3WHzLd0e7W
        QV6ByQVNb/6+nzt37+3gQ9r3jJYcM51ckm+yfGFPtVPZvwiTrQ7uV++INTve6bjG86r9WnXA
        +iMr4hYIv1b2Kdtl/jYtPs9tqs73kws5S9trC6fLcPneCy+dkjf7gC7nfCO/5qa1iUXi27av
        CexX8Pye4Nyf2a1o/qHyAnN2xdewixea/FW0kx/83ZW1ltPdJebgwxjba+2e5cpnuqLsTt89
        qcRSnJFoqMVcVJwIACJnYHYBAwAA
X-CMS-MailID: 20210716000354epcas1p16242ac95ff24f244fd94c0c49d1de0fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210716000354epcas1p16242ac95ff24f244fd94c0c49d1de0fa
References: <20210715235356.3191-1-namjae.jeon@samsung.com>
        <CGME20210716000354epcas1p16242ac95ff24f244fd94c0c49d1de0fa@epcas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds error status, nls, acls, auto negotiation and smb2misc.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/misc.c       |  338 ++++++++
 fs/ksmbd/misc.h       |   35 +
 fs/ksmbd/ndr.c        |  338 ++++++++
 fs/ksmbd/ndr.h        |   22 +
 fs/ksmbd/nterr.h      |  543 ++++++++++++
 fs/ksmbd/smb2misc.c   |  433 ++++++++++
 fs/ksmbd/smb_common.c |  655 +++++++++++++++
 fs/ksmbd/smb_common.h |  543 ++++++++++++
 fs/ksmbd/smbacl.c     | 1344 ++++++++++++++++++++++++++++++
 fs/ksmbd/smbacl.h     |  212 +++++
 fs/ksmbd/smbfsctl.h   |   91 ++
 fs/ksmbd/smbstatus.h  | 1822 +++++++++++++++++++++++++++++++++++++++++
 fs/ksmbd/unicode.c    |  384 +++++++++
 fs/ksmbd/unicode.h    |  357 ++++++++
 fs/ksmbd/uniupr.h     |  268 ++++++
 15 files changed, 7385 insertions(+)
 create mode 100644 fs/ksmbd/misc.c
 create mode 100644 fs/ksmbd/misc.h
 create mode 100644 fs/ksmbd/ndr.c
 create mode 100644 fs/ksmbd/ndr.h
 create mode 100644 fs/ksmbd/nterr.h
 create mode 100644 fs/ksmbd/smb2misc.c
 create mode 100644 fs/ksmbd/smb_common.c
 create mode 100644 fs/ksmbd/smb_common.h
 create mode 100644 fs/ksmbd/smbacl.c
 create mode 100644 fs/ksmbd/smbacl.h
 create mode 100644 fs/ksmbd/smbfsctl.h
 create mode 100644 fs/ksmbd/smbstatus.h
 create mode 100644 fs/ksmbd/unicode.c
 create mode 100644 fs/ksmbd/unicode.h
 create mode 100644 fs/ksmbd/uniupr.h

diff --git a/fs/ksmbd/misc.c b/fs/ksmbd/misc.c
new file mode 100644
index 000000000000..0b307ca28a19
--- /dev/null
+++ b/fs/ksmbd/misc.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/xattr.h>
+#include <linux/fs.h>
+
+#include "misc.h"
+#include "smb_common.h"
+#include "connection.h"
+#include "vfs.h"
+
+#include "mgmt/share_config.h"
+
+/**
+ * match_pattern() - compare a string with a pattern which might include
+ * wildcard '*' and '?'
+ * TODO : implement consideration about DOS_DOT, DOS_QM and DOS_STAR
+ *
+ * @string:	string to compare with a pattern
+ * @len:	string length
+ * @pattern:	pattern string which might include wildcard '*' and '?'
+ *
+ * Return:	0 if pattern matched with the string, otherwise non zero value
+ */
+int match_pattern(const char *str, size_t len, const char *pattern)
+{
+	const char *s = str;
+	const char *p = pattern;
+	bool star = false;
+
+	while (*s && len) {
+		switch (*p) {
+		case '?':
+			s++;
+			len--;
+			p++;
+			break;
+		case '*':
+			star = true;
+			str = s;
+			if (!*++p)
+				return true;
+			pattern = p;
+			break;
+		default:
+			if (tolower(*s) == tolower(*p)) {
+				s++;
+				len--;
+				p++;
+			} else {
+				if (!star)
+					return false;
+				str++;
+				s = str;
+				p = pattern;
+			}
+			break;
+		}
+	}
+
+	if (*p == '*')
+		++p;
+	return !*p;
+}
+
+/*
+ * is_char_allowed() - check for valid character
+ * @ch:		input character to be checked
+ *
+ * Return:	1 if char is allowed, otherwise 0
+ */
+static inline int is_char_allowed(char ch)
+{
+	/* check for control chars, wildcards etc. */
+	if (!(ch & 0x80) &&
+	    (ch <= 0x1f ||
+	     ch == '?' || ch == '"' || ch == '<' ||
+	     ch == '>' || ch == '|' || ch == '*'))
+		return 0;
+
+	return 1;
+}
+
+int ksmbd_validate_filename(char *filename)
+{
+	while (*filename) {
+		char c = *filename;
+
+		filename++;
+		if (!is_char_allowed(c)) {
+			ksmbd_debug(VFS, "File name validation failed: 0x%x\n", c);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+static int ksmbd_validate_stream_name(char *stream_name)
+{
+	while (*stream_name) {
+		char c = *stream_name;
+
+		stream_name++;
+		if (c == '/' || c == ':' || c == '\\') {
+			pr_err("Stream name validation failed: %c\n", c);
+			return -ENOENT;
+		}
+	}
+
+	return 0;
+}
+
+int parse_stream_name(char *filename, char **stream_name, int *s_type)
+{
+	char *stream_type;
+	char *s_name;
+	int rc = 0;
+
+	s_name = filename;
+	filename = strsep(&s_name, ":");
+	ksmbd_debug(SMB, "filename : %s, streams : %s\n", filename, s_name);
+	if (strchr(s_name, ':')) {
+		stream_type = s_name;
+		s_name = strsep(&stream_type, ":");
+
+		rc = ksmbd_validate_stream_name(s_name);
+		if (rc < 0) {
+			rc = -ENOENT;
+			goto out;
+		}
+
+		ksmbd_debug(SMB, "stream name : %s, stream type : %s\n", s_name,
+			    stream_type);
+		if (!strncasecmp("$data", stream_type, 5))
+			*s_type = DATA_STREAM;
+		else if (!strncasecmp("$index_allocation", stream_type, 17))
+			*s_type = DIR_STREAM;
+		else
+			rc = -ENOENT;
+	}
+
+	*stream_name = s_name;
+out:
+	return rc;
+}
+
+/**
+ * convert_to_nt_pathname() - extract and return windows path string
+ *      whose share directory prefix was removed from file path
+ * @filename : unix filename
+ * @sharepath: share path string
+ *
+ * Return : windows path string or error
+ */
+
+char *convert_to_nt_pathname(char *filename, char *sharepath)
+{
+	char *ab_pathname;
+	int len, name_len;
+
+	name_len = strlen(filename);
+	ab_pathname = kmalloc(name_len, GFP_KERNEL);
+	if (!ab_pathname)
+		return NULL;
+
+	ab_pathname[0] = '\\';
+	ab_pathname[1] = '\0';
+
+	len = strlen(sharepath);
+	if (!strncmp(filename, sharepath, len) && name_len != len) {
+		strscpy(ab_pathname, &filename[len], name_len);
+		ksmbd_conv_path_to_windows(ab_pathname);
+	}
+
+	return ab_pathname;
+}
+
+int get_nlink(struct kstat *st)
+{
+	int nlink;
+
+	nlink = st->nlink;
+	if (S_ISDIR(st->mode))
+		nlink--;
+
+	return nlink;
+}
+
+void ksmbd_conv_path_to_unix(char *path)
+{
+	strreplace(path, '\\', '/');
+}
+
+void ksmbd_strip_last_slash(char *path)
+{
+	int len = strlen(path);
+
+	while (len && path[len - 1] == '/') {
+		path[len - 1] = '\0';
+		len--;
+	}
+}
+
+void ksmbd_conv_path_to_windows(char *path)
+{
+	strreplace(path, '/', '\\');
+}
+
+/**
+ * ksmbd_extract_sharename() - get share name from tree connect request
+ * @treename:	buffer containing tree name and share name
+ *
+ * Return:      share name on success, otherwise error
+ */
+char *ksmbd_extract_sharename(char *treename)
+{
+	char *name = treename;
+	char *dst;
+	char *pos = strrchr(name, '\\');
+
+	if (pos)
+		name = (pos + 1);
+
+	/* caller has to free the memory */
+	dst = kstrdup(name, GFP_KERNEL);
+	if (!dst)
+		return ERR_PTR(-ENOMEM);
+	return dst;
+}
+
+/**
+ * convert_to_unix_name() - convert windows name to unix format
+ * @path:	name to be converted
+ * @tid:	tree id of mathing share
+ *
+ * Return:	converted name on success, otherwise NULL
+ */
+char *convert_to_unix_name(struct ksmbd_share_config *share, char *name)
+{
+	int no_slash = 0, name_len, path_len;
+	char *new_name;
+
+	if (name[0] == '/')
+		name++;
+
+	path_len = share->path_sz;
+	name_len = strlen(name);
+	new_name = kmalloc(path_len + name_len + 2, GFP_KERNEL);
+	if (!new_name)
+		return new_name;
+
+	memcpy(new_name, share->path, path_len);
+	if (new_name[path_len - 1] != '/') {
+		new_name[path_len] = '/';
+		no_slash = 1;
+	}
+
+	memcpy(new_name + path_len + no_slash, name, name_len);
+	path_len += name_len + no_slash;
+	new_name[path_len] = 0x00;
+	return new_name;
+}
+
+char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
+				  const struct nls_table *local_nls,
+				  int *conv_len)
+{
+	char *conv;
+	int  sz = min(4 * d_info->name_len, PATH_MAX);
+
+	if (!sz)
+		return NULL;
+
+	conv = kmalloc(sz, GFP_KERNEL);
+	if (!conv)
+		return NULL;
+
+	/* XXX */
+	*conv_len = smbConvertToUTF16((__le16 *)conv, d_info->name,
+				      d_info->name_len, local_nls, 0);
+	*conv_len *= 2;
+
+	/* We allocate buffer twice bigger than needed. */
+	conv[*conv_len] = 0x00;
+	conv[*conv_len + 1] = 0x00;
+	return conv;
+}
+
+/*
+ * Convert the NT UTC (based 1601-01-01, in hundred nanosecond units)
+ * into Unix UTC (based 1970-01-01, in seconds).
+ */
+struct timespec64 ksmbd_NTtimeToUnix(__le64 ntutc)
+{
+	struct timespec64 ts;
+
+	/* Subtract the NTFS time offset, then convert to 1s intervals. */
+	s64 t = le64_to_cpu(ntutc) - NTFS_TIME_OFFSET;
+	u64 abs_t;
+
+	/*
+	 * Unfortunately can not use normal 64 bit division on 32 bit arch, but
+	 * the alternative, do_div, does not work with negative numbers so have
+	 * to special case them
+	 */
+	if (t < 0) {
+		abs_t = -t;
+		ts.tv_nsec = do_div(abs_t, 10000000) * 100;
+		ts.tv_nsec = -ts.tv_nsec;
+		ts.tv_sec = -abs_t;
+	} else {
+		abs_t = t;
+		ts.tv_nsec = do_div(abs_t, 10000000) * 100;
+		ts.tv_sec = abs_t;
+	}
+
+	return ts;
+}
+
+/* Convert the Unix UTC into NT UTC. */
+inline u64 ksmbd_UnixTimeToNT(struct timespec64 t)
+{
+	/* Convert to 100ns intervals and then add the NTFS time offset. */
+	return (u64)t.tv_sec * 10000000 + t.tv_nsec / 100 + NTFS_TIME_OFFSET;
+}
+
+inline long long ksmbd_systime(void)
+{
+	struct timespec64	ts;
+
+	ktime_get_real_ts64(&ts);
+	return ksmbd_UnixTimeToNT(ts);
+}
diff --git a/fs/ksmbd/misc.h b/fs/ksmbd/misc.h
new file mode 100644
index 000000000000..af8717d4d85b
--- /dev/null
+++ b/fs/ksmbd/misc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_MISC_H__
+#define __KSMBD_MISC_H__
+
+struct ksmbd_share_config;
+struct nls_table;
+struct kstat;
+struct ksmbd_file;
+
+int match_pattern(const char *str, size_t len, const char *pattern);
+int ksmbd_validate_filename(char *filename);
+int parse_stream_name(char *filename, char **stream_name, int *s_type);
+char *convert_to_nt_pathname(char *filename, char *sharepath);
+int get_nlink(struct kstat *st);
+void ksmbd_conv_path_to_unix(char *path);
+void ksmbd_strip_last_slash(char *path);
+void ksmbd_conv_path_to_windows(char *path);
+char *ksmbd_extract_sharename(char *treename);
+char *convert_to_unix_name(struct ksmbd_share_config *share, char *name);
+
+#define KSMBD_DIR_INFO_ALIGNMENT	8
+struct ksmbd_dir_info;
+char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
+				  const struct nls_table *local_nls,
+				  int *conv_len);
+
+#define NTFS_TIME_OFFSET	((u64)(369 * 365 + 89) * 24 * 3600 * 10000000)
+struct timespec64 ksmbd_NTtimeToUnix(__le64 ntutc);
+u64 ksmbd_UnixTimeToNT(struct timespec64 t);
+long long ksmbd_systime(void);
+#endif /* __KSMBD_MISC_H__ */
diff --git a/fs/ksmbd/ndr.c b/fs/ksmbd/ndr.c
new file mode 100644
index 000000000000..cf0df78259c9
--- /dev/null
+++ b/fs/ksmbd/ndr.c
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2021 Samsung Electronics Co., Ltd.
+ *   Author(s): Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+#include <linux/fs.h>
+
+#include "glob.h"
+#include "ndr.h"
+
+static inline char *ndr_get_field(struct ndr *n)
+{
+	return n->data + n->offset;
+}
+
+static int try_to_realloc_ndr_blob(struct ndr *n, size_t sz)
+{
+	char *data;
+
+	data = krealloc(n->data, n->offset + sz + 1024, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	n->data = data;
+	n->length += 1024;
+	memset(n->data + n->offset, 0, 1024);
+	return 0;
+}
+
+static void ndr_write_int16(struct ndr *n, __u16 value)
+{
+	if (n->length <= n->offset + sizeof(value))
+		try_to_realloc_ndr_blob(n, sizeof(value));
+
+	*(__le16 *)ndr_get_field(n) = cpu_to_le16(value);
+	n->offset += sizeof(value);
+}
+
+static void ndr_write_int32(struct ndr *n, __u32 value)
+{
+	if (n->length <= n->offset + sizeof(value))
+		try_to_realloc_ndr_blob(n, sizeof(value));
+
+	*(__le32 *)ndr_get_field(n) = cpu_to_le32(value);
+	n->offset += sizeof(value);
+}
+
+static void ndr_write_int64(struct ndr *n, __u64 value)
+{
+	if (n->length <= n->offset + sizeof(value))
+		try_to_realloc_ndr_blob(n, sizeof(value));
+
+	*(__le64 *)ndr_get_field(n) = cpu_to_le64(value);
+	n->offset += sizeof(value);
+}
+
+static int ndr_write_bytes(struct ndr *n, void *value, size_t sz)
+{
+	if (n->length <= n->offset + sz)
+		try_to_realloc_ndr_blob(n, sz);
+
+	memcpy(ndr_get_field(n), value, sz);
+	n->offset += sz;
+	return 0;
+}
+
+static int ndr_write_string(struct ndr *n, void *value, size_t sz)
+{
+	if (n->length <= n->offset + sz)
+		try_to_realloc_ndr_blob(n, sz);
+
+	strncpy(ndr_get_field(n), value, sz);
+	sz++;
+	n->offset += sz;
+	n->offset = ALIGN(n->offset, 2);
+	return 0;
+}
+
+static int ndr_read_string(struct ndr *n, void *value, size_t sz)
+{
+	int len = strnlen(ndr_get_field(n), sz);
+
+	memcpy(value, ndr_get_field(n), len);
+	len++;
+	n->offset += len;
+	n->offset = ALIGN(n->offset, 2);
+	return 0;
+}
+
+static int ndr_read_bytes(struct ndr *n, void *value, size_t sz)
+{
+	memcpy(value, ndr_get_field(n), sz);
+	n->offset += sz;
+	return 0;
+}
+
+static __u16 ndr_read_int16(struct ndr *n)
+{
+	__u16 ret;
+
+	ret = le16_to_cpu(*(__le16 *)ndr_get_field(n));
+	n->offset += sizeof(__u16);
+	return ret;
+}
+
+static __u32 ndr_read_int32(struct ndr *n)
+{
+	__u32 ret;
+
+	ret = le32_to_cpu(*(__le32 *)ndr_get_field(n));
+	n->offset += sizeof(__u32);
+	return ret;
+}
+
+static __u64 ndr_read_int64(struct ndr *n)
+{
+	__u64 ret;
+
+	ret = le64_to_cpu(*(__le64 *)ndr_get_field(n));
+	n->offset += sizeof(__u64);
+	return ret;
+}
+
+int ndr_encode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
+{
+	char hex_attr[12] = {0};
+
+	n->offset = 0;
+	n->length = 1024;
+	n->data = kzalloc(n->length, GFP_KERNEL);
+	if (!n->data)
+		return -ENOMEM;
+
+	if (da->version == 3) {
+		snprintf(hex_attr, 10, "0x%x", da->attr);
+		ndr_write_string(n, hex_attr, strlen(hex_attr));
+	} else {
+		ndr_write_string(n, "", strlen(""));
+	}
+	ndr_write_int16(n, da->version);
+	ndr_write_int32(n, da->version);
+
+	ndr_write_int32(n, da->flags);
+	ndr_write_int32(n, da->attr);
+	if (da->version == 3) {
+		ndr_write_int32(n, da->ea_size);
+		ndr_write_int64(n, da->size);
+		ndr_write_int64(n, da->alloc_size);
+	} else {
+		ndr_write_int64(n, da->itime);
+	}
+	ndr_write_int64(n, da->create_time);
+	if (da->version == 3)
+		ndr_write_int64(n, da->change_time);
+	return 0;
+}
+
+int ndr_decode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
+{
+	char hex_attr[12] = {0};
+	int version2;
+
+	n->offset = 0;
+	ndr_read_string(n, hex_attr, n->length - n->offset);
+	da->version = ndr_read_int16(n);
+
+	if (da->version != 3 && da->version != 4) {
+		pr_err("v%d version is not supported\n", da->version);
+		return -EINVAL;
+	}
+
+	version2 = ndr_read_int32(n);
+	if (da->version != version2) {
+		pr_err("ndr version mismatched(version: %d, version2: %d)\n",
+		       da->version, version2);
+		return -EINVAL;
+	}
+
+	ndr_read_int32(n);
+	da->attr = ndr_read_int32(n);
+	if (da->version == 4) {
+		da->itime = ndr_read_int64(n);
+		da->create_time = ndr_read_int64(n);
+	} else {
+		ndr_read_int32(n);
+		ndr_read_int64(n);
+		ndr_read_int64(n);
+		da->create_time = ndr_read_int64(n);
+		ndr_read_int64(n);
+	}
+
+	return 0;
+}
+
+static int ndr_encode_posix_acl_entry(struct ndr *n, struct xattr_smb_acl *acl)
+{
+	int i;
+
+	ndr_write_int32(n, acl->count);
+	n->offset = ALIGN(n->offset, 8);
+	ndr_write_int32(n, acl->count);
+	ndr_write_int32(n, 0);
+
+	for (i = 0; i < acl->count; i++) {
+		n->offset = ALIGN(n->offset, 8);
+		ndr_write_int16(n, acl->entries[i].type);
+		ndr_write_int16(n, acl->entries[i].type);
+
+		if (acl->entries[i].type == SMB_ACL_USER) {
+			n->offset = ALIGN(n->offset, 8);
+			ndr_write_int64(n, acl->entries[i].uid);
+		} else if (acl->entries[i].type == SMB_ACL_GROUP) {
+			n->offset = ALIGN(n->offset, 8);
+			ndr_write_int64(n, acl->entries[i].gid);
+		}
+
+		/* push permission */
+		ndr_write_int32(n, acl->entries[i].perm);
+	}
+
+	return 0;
+}
+
+int ndr_encode_posix_acl(struct ndr *n,
+			 struct user_namespace *user_ns,
+			 struct inode *inode,
+			 struct xattr_smb_acl *acl,
+			 struct xattr_smb_acl *def_acl)
+{
+	int ref_id = 0x00020000;
+
+	n->offset = 0;
+	n->length = 1024;
+	n->data = kzalloc(n->length, GFP_KERNEL);
+	if (!n->data)
+		return -ENOMEM;
+
+	if (acl) {
+		/* ACL ACCESS */
+		ndr_write_int32(n, ref_id);
+		ref_id += 4;
+	} else {
+		ndr_write_int32(n, 0);
+	}
+
+	if (def_acl) {
+		/* DEFAULT ACL ACCESS */
+		ndr_write_int32(n, ref_id);
+		ref_id += 4;
+	} else {
+		ndr_write_int32(n, 0);
+	}
+
+	ndr_write_int64(n, from_kuid(user_ns, inode->i_uid));
+	ndr_write_int64(n, from_kgid(user_ns, inode->i_gid));
+	ndr_write_int32(n, inode->i_mode);
+
+	if (acl) {
+		ndr_encode_posix_acl_entry(n, acl);
+		if (def_acl)
+			ndr_encode_posix_acl_entry(n, def_acl);
+	}
+	return 0;
+}
+
+int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
+{
+	int ref_id = 0x00020004;
+
+	n->offset = 0;
+	n->length = 2048;
+	n->data = kzalloc(n->length, GFP_KERNEL);
+	if (!n->data)
+		return -ENOMEM;
+
+	ndr_write_int16(n, acl->version);
+	ndr_write_int32(n, acl->version);
+	ndr_write_int16(n, 2);
+	ndr_write_int32(n, ref_id);
+
+	/* push hash type and hash 64bytes */
+	ndr_write_int16(n, acl->hash_type);
+	ndr_write_bytes(n, acl->hash, XATTR_SD_HASH_SIZE);
+	ndr_write_bytes(n, acl->desc, acl->desc_len);
+	ndr_write_int64(n, acl->current_time);
+	ndr_write_bytes(n, acl->posix_acl_hash, XATTR_SD_HASH_SIZE);
+
+	/* push ndr for security descriptor */
+	ndr_write_bytes(n, acl->sd_buf, acl->sd_size);
+
+	return 0;
+}
+
+int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
+{
+	int version2;
+
+	n->offset = 0;
+	acl->version = ndr_read_int16(n);
+	if (acl->version != 4) {
+		pr_err("v%d version is not supported\n", acl->version);
+		return -EINVAL;
+	}
+
+	version2 = ndr_read_int32(n);
+	if (acl->version != version2) {
+		pr_err("ndr version mismatched(version: %d, version2: %d)\n",
+		       acl->version, version2);
+		return -EINVAL;
+	}
+
+	/* Read Level */
+	ndr_read_int16(n);
+	/* Read Ref Id */
+	ndr_read_int32(n);
+	acl->hash_type = ndr_read_int16(n);
+	ndr_read_bytes(n, acl->hash, XATTR_SD_HASH_SIZE);
+
+	ndr_read_bytes(n, acl->desc, 10);
+	if (strncmp(acl->desc, "posix_acl", 9)) {
+		pr_err("Invalid acl description : %s\n", acl->desc);
+		return -EINVAL;
+	}
+
+	/* Read Time */
+	ndr_read_int64(n);
+	/* Read Posix ACL hash */
+	ndr_read_bytes(n, acl->posix_acl_hash, XATTR_SD_HASH_SIZE);
+	acl->sd_size = n->length - n->offset;
+	acl->sd_buf = kzalloc(acl->sd_size, GFP_KERNEL);
+	if (!acl->sd_buf)
+		return -ENOMEM;
+
+	ndr_read_bytes(n, acl->sd_buf, acl->sd_size);
+
+	return 0;
+}
diff --git a/fs/ksmbd/ndr.h b/fs/ksmbd/ndr.h
new file mode 100644
index 000000000000..60ca265d1bb0
--- /dev/null
+++ b/fs/ksmbd/ndr.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ *   Author(s): Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+struct ndr {
+	char	*data;
+	int	offset;
+	int	length;
+};
+
+#define NDR_NTSD_OFFSETOF	0xA0
+
+int ndr_encode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da);
+int ndr_decode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da);
+int ndr_encode_posix_acl(struct ndr *n, struct user_namespace *user_ns,
+			 struct inode *inode, struct xattr_smb_acl *acl,
+			 struct xattr_smb_acl *def_acl);
+int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl);
+int ndr_encode_v3_ntacl(struct ndr *n, struct xattr_ntacl *acl);
+int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl);
diff --git a/fs/ksmbd/nterr.h b/fs/ksmbd/nterr.h
new file mode 100644
index 000000000000..2f358f88a018
--- /dev/null
+++ b/fs/ksmbd/nterr.h
@@ -0,0 +1,543 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Unix SMB/Netbios implementation.
+ * Version 1.9.
+ * NT error code constants
+ * Copyright (C) Andrew Tridgell              1992-2000
+ * Copyright (C) John H Terpstra              1996-2000
+ * Copyright (C) Luke Kenneth Casson Leighton 1996-2000
+ * Copyright (C) Paul Ashton                  1998-2000
+ */
+
+#ifndef _NTERR_H
+#define _NTERR_H
+
+/* Win32 Status codes. */
+#define NT_STATUS_MORE_ENTRIES         0x0105
+#define NT_ERROR_INVALID_PARAMETER     0x0057
+#define NT_ERROR_INSUFFICIENT_BUFFER   0x007a
+#define NT_STATUS_1804                 0x070c
+#define NT_STATUS_NOTIFY_ENUM_DIR      0x010c
+#define NT_STATUS_INVALID_LOCK_RANGE   (0xC0000000 | 0x01a1)
+/*
+ * Win32 Error codes extracted using a loop in smbclient then printing a netmon
+ * sniff to a file.
+ */
+
+#define NT_STATUS_OK                   0x0000
+#define NT_STATUS_SOME_UNMAPPED        0x0107
+#define NT_STATUS_BUFFER_OVERFLOW  0x80000005
+#define NT_STATUS_NO_MORE_ENTRIES  0x8000001a
+#define NT_STATUS_MEDIA_CHANGED    0x8000001c
+#define NT_STATUS_END_OF_MEDIA     0x8000001e
+#define NT_STATUS_MEDIA_CHECK      0x80000020
+#define NT_STATUS_NO_DATA_DETECTED 0x8000001c
+#define NT_STATUS_STOPPED_ON_SYMLINK 0x8000002d
+#define NT_STATUS_DEVICE_REQUIRES_CLEANING 0x80000288
+#define NT_STATUS_DEVICE_DOOR_OPEN 0x80000288
+#define NT_STATUS_UNSUCCESSFUL (0xC0000000 | 0x0001)
+#define NT_STATUS_NOT_IMPLEMENTED (0xC0000000 | 0x0002)
+#define NT_STATUS_INVALID_INFO_CLASS (0xC0000000 | 0x0003)
+#define NT_STATUS_INFO_LENGTH_MISMATCH (0xC0000000 | 0x0004)
+#define NT_STATUS_ACCESS_VIOLATION (0xC0000000 | 0x0005)
+#define NT_STATUS_IN_PAGE_ERROR (0xC0000000 | 0x0006)
+#define NT_STATUS_PAGEFILE_QUOTA (0xC0000000 | 0x0007)
+#define NT_STATUS_INVALID_HANDLE (0xC0000000 | 0x0008)
+#define NT_STATUS_BAD_INITIAL_STACK (0xC0000000 | 0x0009)
+#define NT_STATUS_BAD_INITIAL_PC (0xC0000000 | 0x000a)
+#define NT_STATUS_INVALID_CID (0xC0000000 | 0x000b)
+#define NT_STATUS_TIMER_NOT_CANCELED (0xC0000000 | 0x000c)
+#define NT_STATUS_INVALID_PARAMETER (0xC0000000 | 0x000d)
+#define NT_STATUS_NO_SUCH_DEVICE (0xC0000000 | 0x000e)
+#define NT_STATUS_NO_SUCH_FILE (0xC0000000 | 0x000f)
+#define NT_STATUS_INVALID_DEVICE_REQUEST (0xC0000000 | 0x0010)
+#define NT_STATUS_END_OF_FILE (0xC0000000 | 0x0011)
+#define NT_STATUS_WRONG_VOLUME (0xC0000000 | 0x0012)
+#define NT_STATUS_NO_MEDIA_IN_DEVICE (0xC0000000 | 0x0013)
+#define NT_STATUS_UNRECOGNIZED_MEDIA (0xC0000000 | 0x0014)
+#define NT_STATUS_NONEXISTENT_SECTOR (0xC0000000 | 0x0015)
+#define NT_STATUS_MORE_PROCESSING_REQUIRED (0xC0000000 | 0x0016)
+#define NT_STATUS_NO_MEMORY (0xC0000000 | 0x0017)
+#define NT_STATUS_CONFLICTING_ADDRESSES (0xC0000000 | 0x0018)
+#define NT_STATUS_NOT_MAPPED_VIEW (0xC0000000 | 0x0019)
+#define NT_STATUS_UNABLE_TO_FREE_VM (0x80000000 | 0x001a)
+#define NT_STATUS_UNABLE_TO_DELETE_SECTION (0xC0000000 | 0x001b)
+#define NT_STATUS_INVALID_SYSTEM_SERVICE (0xC0000000 | 0x001c)
+#define NT_STATUS_ILLEGAL_INSTRUCTION (0xC0000000 | 0x001d)
+#define NT_STATUS_INVALID_LOCK_SEQUENCE (0xC0000000 | 0x001e)
+#define NT_STATUS_INVALID_VIEW_SIZE (0xC0000000 | 0x001f)
+#define NT_STATUS_INVALID_FILE_FOR_SECTION (0xC0000000 | 0x0020)
+#define NT_STATUS_ALREADY_COMMITTED (0xC0000000 | 0x0021)
+#define NT_STATUS_ACCESS_DENIED (0xC0000000 | 0x0022)
+#define NT_STATUS_BUFFER_TOO_SMALL (0xC0000000 | 0x0023)
+#define NT_STATUS_OBJECT_TYPE_MISMATCH (0xC0000000 | 0x0024)
+#define NT_STATUS_NONCONTINUABLE_EXCEPTION (0xC0000000 | 0x0025)
+#define NT_STATUS_INVALID_DISPOSITION (0xC0000000 | 0x0026)
+#define NT_STATUS_UNWIND (0xC0000000 | 0x0027)
+#define NT_STATUS_BAD_STACK (0xC0000000 | 0x0028)
+#define NT_STATUS_INVALID_UNWIND_TARGET (0xC0000000 | 0x0029)
+#define NT_STATUS_NOT_LOCKED (0xC0000000 | 0x002a)
+#define NT_STATUS_PARITY_ERROR (0xC0000000 | 0x002b)
+#define NT_STATUS_UNABLE_TO_DECOMMIT_VM (0xC0000000 | 0x002c)
+#define NT_STATUS_NOT_COMMITTED (0xC0000000 | 0x002d)
+#define NT_STATUS_INVALID_PORT_ATTRIBUTES (0xC0000000 | 0x002e)
+#define NT_STATUS_PORT_MESSAGE_TOO_LONG (0xC0000000 | 0x002f)
+#define NT_STATUS_INVALID_PARAMETER_MIX (0xC0000000 | 0x0030)
+#define NT_STATUS_INVALID_QUOTA_LOWER (0xC0000000 | 0x0031)
+#define NT_STATUS_DISK_CORRUPT_ERROR (0xC0000000 | 0x0032)
+#define NT_STATUS_OBJECT_NAME_INVALID (0xC0000000 | 0x0033)
+#define NT_STATUS_OBJECT_NAME_NOT_FOUND (0xC0000000 | 0x0034)
+#define NT_STATUS_OBJECT_NAME_COLLISION (0xC0000000 | 0x0035)
+#define NT_STATUS_HANDLE_NOT_WAITABLE (0xC0000000 | 0x0036)
+#define NT_STATUS_PORT_DISCONNECTED (0xC0000000 | 0x0037)
+#define NT_STATUS_DEVICE_ALREADY_ATTACHED (0xC0000000 | 0x0038)
+#define NT_STATUS_OBJECT_PATH_INVALID (0xC0000000 | 0x0039)
+#define NT_STATUS_OBJECT_PATH_NOT_FOUND (0xC0000000 | 0x003a)
+#define NT_STATUS_OBJECT_PATH_SYNTAX_BAD (0xC0000000 | 0x003b)
+#define NT_STATUS_DATA_OVERRUN (0xC0000000 | 0x003c)
+#define NT_STATUS_DATA_LATE_ERROR (0xC0000000 | 0x003d)
+#define NT_STATUS_DATA_ERROR (0xC0000000 | 0x003e)
+#define NT_STATUS_CRC_ERROR (0xC0000000 | 0x003f)
+#define NT_STATUS_SECTION_TOO_BIG (0xC0000000 | 0x0040)
+#define NT_STATUS_PORT_CONNECTION_REFUSED (0xC0000000 | 0x0041)
+#define NT_STATUS_INVALID_PORT_HANDLE (0xC0000000 | 0x0042)
+#define NT_STATUS_SHARING_VIOLATION (0xC0000000 | 0x0043)
+#define NT_STATUS_QUOTA_EXCEEDED (0xC0000000 | 0x0044)
+#define NT_STATUS_INVALID_PAGE_PROTECTION (0xC0000000 | 0x0045)
+#define NT_STATUS_MUTANT_NOT_OWNED (0xC0000000 | 0x0046)
+#define NT_STATUS_SEMAPHORE_LIMIT_EXCEEDED (0xC0000000 | 0x0047)
+#define NT_STATUS_PORT_ALREADY_SET (0xC0000000 | 0x0048)
+#define NT_STATUS_SECTION_NOT_IMAGE (0xC0000000 | 0x0049)
+#define NT_STATUS_SUSPEND_COUNT_EXCEEDED (0xC0000000 | 0x004a)
+#define NT_STATUS_THREAD_IS_TERMINATING (0xC0000000 | 0x004b)
+#define NT_STATUS_BAD_WORKING_SET_LIMIT (0xC0000000 | 0x004c)
+#define NT_STATUS_INCOMPATIBLE_FILE_MAP (0xC0000000 | 0x004d)
+#define NT_STATUS_SECTION_PROTECTION (0xC0000000 | 0x004e)
+#define NT_STATUS_EAS_NOT_SUPPORTED (0xC0000000 | 0x004f)
+#define NT_STATUS_EA_TOO_LARGE (0xC0000000 | 0x0050)
+#define NT_STATUS_NONEXISTENT_EA_ENTRY (0xC0000000 | 0x0051)
+#define NT_STATUS_NO_EAS_ON_FILE (0xC0000000 | 0x0052)
+#define NT_STATUS_EA_CORRUPT_ERROR (0xC0000000 | 0x0053)
+#define NT_STATUS_FILE_LOCK_CONFLICT (0xC0000000 | 0x0054)
+#define NT_STATUS_LOCK_NOT_GRANTED (0xC0000000 | 0x0055)
+#define NT_STATUS_DELETE_PENDING (0xC0000000 | 0x0056)
+#define NT_STATUS_CTL_FILE_NOT_SUPPORTED (0xC0000000 | 0x0057)
+#define NT_STATUS_UNKNOWN_REVISION (0xC0000000 | 0x0058)
+#define NT_STATUS_REVISION_MISMATCH (0xC0000000 | 0x0059)
+#define NT_STATUS_INVALID_OWNER (0xC0000000 | 0x005a)
+#define NT_STATUS_INVALID_PRIMARY_GROUP (0xC0000000 | 0x005b)
+#define NT_STATUS_NO_IMPERSONATION_TOKEN (0xC0000000 | 0x005c)
+#define NT_STATUS_CANT_DISABLE_MANDATORY (0xC0000000 | 0x005d)
+#define NT_STATUS_NO_LOGON_SERVERS (0xC0000000 | 0x005e)
+#define NT_STATUS_NO_SUCH_LOGON_SESSION (0xC0000000 | 0x005f)
+#define NT_STATUS_NO_SUCH_PRIVILEGE (0xC0000000 | 0x0060)
+#define NT_STATUS_PRIVILEGE_NOT_HELD (0xC0000000 | 0x0061)
+#define NT_STATUS_INVALID_ACCOUNT_NAME (0xC0000000 | 0x0062)
+#define NT_STATUS_USER_EXISTS (0xC0000000 | 0x0063)
+#define NT_STATUS_NO_SUCH_USER (0xC0000000 | 0x0064)
+#define NT_STATUS_GROUP_EXISTS (0xC0000000 | 0x0065)
+#define NT_STATUS_NO_SUCH_GROUP (0xC0000000 | 0x0066)
+#define NT_STATUS_MEMBER_IN_GROUP (0xC0000000 | 0x0067)
+#define NT_STATUS_MEMBER_NOT_IN_GROUP (0xC0000000 | 0x0068)
+#define NT_STATUS_LAST_ADMIN (0xC0000000 | 0x0069)
+#define NT_STATUS_WRONG_PASSWORD (0xC0000000 | 0x006a)
+#define NT_STATUS_ILL_FORMED_PASSWORD (0xC0000000 | 0x006b)
+#define NT_STATUS_PASSWORD_RESTRICTION (0xC0000000 | 0x006c)
+#define NT_STATUS_LOGON_FAILURE (0xC0000000 | 0x006d)
+#define NT_STATUS_ACCOUNT_RESTRICTION (0xC0000000 | 0x006e)
+#define NT_STATUS_INVALID_LOGON_HOURS (0xC0000000 | 0x006f)
+#define NT_STATUS_INVALID_WORKSTATION (0xC0000000 | 0x0070)
+#define NT_STATUS_PASSWORD_EXPIRED (0xC0000000 | 0x0071)
+#define NT_STATUS_ACCOUNT_DISABLED (0xC0000000 | 0x0072)
+#define NT_STATUS_NONE_MAPPED (0xC0000000 | 0x0073)
+#define NT_STATUS_TOO_MANY_LUIDS_REQUESTED (0xC0000000 | 0x0074)
+#define NT_STATUS_LUIDS_EXHAUSTED (0xC0000000 | 0x0075)
+#define NT_STATUS_INVALID_SUB_AUTHORITY (0xC0000000 | 0x0076)
+#define NT_STATUS_INVALID_ACL (0xC0000000 | 0x0077)
+#define NT_STATUS_INVALID_SID (0xC0000000 | 0x0078)
+#define NT_STATUS_INVALID_SECURITY_DESCR (0xC0000000 | 0x0079)
+#define NT_STATUS_PROCEDURE_NOT_FOUND (0xC0000000 | 0x007a)
+#define NT_STATUS_INVALID_IMAGE_FORMAT (0xC0000000 | 0x007b)
+#define NT_STATUS_NO_TOKEN (0xC0000000 | 0x007c)
+#define NT_STATUS_BAD_INHERITANCE_ACL (0xC0000000 | 0x007d)
+#define NT_STATUS_RANGE_NOT_LOCKED (0xC0000000 | 0x007e)
+#define NT_STATUS_DISK_FULL (0xC0000000 | 0x007f)
+#define NT_STATUS_SERVER_DISABLED (0xC0000000 | 0x0080)
+#define NT_STATUS_SERVER_NOT_DISABLED (0xC0000000 | 0x0081)
+#define NT_STATUS_TOO_MANY_GUIDS_REQUESTED (0xC0000000 | 0x0082)
+#define NT_STATUS_GUIDS_EXHAUSTED (0xC0000000 | 0x0083)
+#define NT_STATUS_INVALID_ID_AUTHORITY (0xC0000000 | 0x0084)
+#define NT_STATUS_AGENTS_EXHAUSTED (0xC0000000 | 0x0085)
+#define NT_STATUS_INVALID_VOLUME_LABEL (0xC0000000 | 0x0086)
+#define NT_STATUS_SECTION_NOT_EXTENDED (0xC0000000 | 0x0087)
+#define NT_STATUS_NOT_MAPPED_DATA (0xC0000000 | 0x0088)
+#define NT_STATUS_RESOURCE_DATA_NOT_FOUND (0xC0000000 | 0x0089)
+#define NT_STATUS_RESOURCE_TYPE_NOT_FOUND (0xC0000000 | 0x008a)
+#define NT_STATUS_RESOURCE_NAME_NOT_FOUND (0xC0000000 | 0x008b)
+#define NT_STATUS_ARRAY_BOUNDS_EXCEEDED (0xC0000000 | 0x008c)
+#define NT_STATUS_FLOAT_DENORMAL_OPERAND (0xC0000000 | 0x008d)
+#define NT_STATUS_FLOAT_DIVIDE_BY_ZERO (0xC0000000 | 0x008e)
+#define NT_STATUS_FLOAT_INEXACT_RESULT (0xC0000000 | 0x008f)
+#define NT_STATUS_FLOAT_INVALID_OPERATION (0xC0000000 | 0x0090)
+#define NT_STATUS_FLOAT_OVERFLOW (0xC0000000 | 0x0091)
+#define NT_STATUS_FLOAT_STACK_CHECK (0xC0000000 | 0x0092)
+#define NT_STATUS_FLOAT_UNDERFLOW (0xC0000000 | 0x0093)
+#define NT_STATUS_INTEGER_DIVIDE_BY_ZERO (0xC0000000 | 0x0094)
+#define NT_STATUS_INTEGER_OVERFLOW (0xC0000000 | 0x0095)
+#define NT_STATUS_PRIVILEGED_INSTRUCTION (0xC0000000 | 0x0096)
+#define NT_STATUS_TOO_MANY_PAGING_FILES (0xC0000000 | 0x0097)
+#define NT_STATUS_FILE_INVALID (0xC0000000 | 0x0098)
+#define NT_STATUS_ALLOTTED_SPACE_EXCEEDED (0xC0000000 | 0x0099)
+#define NT_STATUS_INSUFFICIENT_RESOURCES (0xC0000000 | 0x009a)
+#define NT_STATUS_DFS_EXIT_PATH_FOUND (0xC0000000 | 0x009b)
+#define NT_STATUS_DEVICE_DATA_ERROR (0xC0000000 | 0x009c)
+#define NT_STATUS_DEVICE_NOT_CONNECTED (0xC0000000 | 0x009d)
+#define NT_STATUS_DEVICE_POWER_FAILURE (0xC0000000 | 0x009e)
+#define NT_STATUS_FREE_VM_NOT_AT_BASE (0xC0000000 | 0x009f)
+#define NT_STATUS_MEMORY_NOT_ALLOCATED (0xC0000000 | 0x00a0)
+#define NT_STATUS_WORKING_SET_QUOTA (0xC0000000 | 0x00a1)
+#define NT_STATUS_MEDIA_WRITE_PROTECTED (0xC0000000 | 0x00a2)
+#define NT_STATUS_DEVICE_NOT_READY (0xC0000000 | 0x00a3)
+#define NT_STATUS_INVALID_GROUP_ATTRIBUTES (0xC0000000 | 0x00a4)
+#define NT_STATUS_BAD_IMPERSONATION_LEVEL (0xC0000000 | 0x00a5)
+#define NT_STATUS_CANT_OPEN_ANONYMOUS (0xC0000000 | 0x00a6)
+#define NT_STATUS_BAD_VALIDATION_CLASS (0xC0000000 | 0x00a7)
+#define NT_STATUS_BAD_TOKEN_TYPE (0xC0000000 | 0x00a8)
+#define NT_STATUS_BAD_MASTER_BOOT_RECORD (0xC0000000 | 0x00a9)
+#define NT_STATUS_INSTRUCTION_MISALIGNMENT (0xC0000000 | 0x00aa)
+#define NT_STATUS_INSTANCE_NOT_AVAILABLE (0xC0000000 | 0x00ab)
+#define NT_STATUS_PIPE_NOT_AVAILABLE (0xC0000000 | 0x00ac)
+#define NT_STATUS_INVALID_PIPE_STATE (0xC0000000 | 0x00ad)
+#define NT_STATUS_PIPE_BUSY (0xC0000000 | 0x00ae)
+#define NT_STATUS_ILLEGAL_FUNCTION (0xC0000000 | 0x00af)
+#define NT_STATUS_PIPE_DISCONNECTED (0xC0000000 | 0x00b0)
+#define NT_STATUS_PIPE_CLOSING (0xC0000000 | 0x00b1)
+#define NT_STATUS_PIPE_CONNECTED (0xC0000000 | 0x00b2)
+#define NT_STATUS_PIPE_LISTENING (0xC0000000 | 0x00b3)
+#define NT_STATUS_INVALID_READ_MODE (0xC0000000 | 0x00b4)
+#define NT_STATUS_IO_TIMEOUT (0xC0000000 | 0x00b5)
+#define NT_STATUS_FILE_FORCED_CLOSED (0xC0000000 | 0x00b6)
+#define NT_STATUS_PROFILING_NOT_STARTED (0xC0000000 | 0x00b7)
+#define NT_STATUS_PROFILING_NOT_STOPPED (0xC0000000 | 0x00b8)
+#define NT_STATUS_COULD_NOT_INTERPRET (0xC0000000 | 0x00b9)
+#define NT_STATUS_FILE_IS_A_DIRECTORY (0xC0000000 | 0x00ba)
+#define NT_STATUS_NOT_SUPPORTED (0xC0000000 | 0x00bb)
+#define NT_STATUS_REMOTE_NOT_LISTENING (0xC0000000 | 0x00bc)
+#define NT_STATUS_DUPLICATE_NAME (0xC0000000 | 0x00bd)
+#define NT_STATUS_BAD_NETWORK_PATH (0xC0000000 | 0x00be)
+#define NT_STATUS_NETWORK_BUSY (0xC0000000 | 0x00bf)
+#define NT_STATUS_DEVICE_DOES_NOT_EXIST (0xC0000000 | 0x00c0)
+#define NT_STATUS_TOO_MANY_COMMANDS (0xC0000000 | 0x00c1)
+#define NT_STATUS_ADAPTER_HARDWARE_ERROR (0xC0000000 | 0x00c2)
+#define NT_STATUS_INVALID_NETWORK_RESPONSE (0xC0000000 | 0x00c3)
+#define NT_STATUS_UNEXPECTED_NETWORK_ERROR (0xC0000000 | 0x00c4)
+#define NT_STATUS_BAD_REMOTE_ADAPTER (0xC0000000 | 0x00c5)
+#define NT_STATUS_PRINT_QUEUE_FULL (0xC0000000 | 0x00c6)
+#define NT_STATUS_NO_SPOOL_SPACE (0xC0000000 | 0x00c7)
+#define NT_STATUS_PRINT_CANCELLED (0xC0000000 | 0x00c8)
+#define NT_STATUS_NETWORK_NAME_DELETED (0xC0000000 | 0x00c9)
+#define NT_STATUS_NETWORK_ACCESS_DENIED (0xC0000000 | 0x00ca)
+#define NT_STATUS_BAD_DEVICE_TYPE (0xC0000000 | 0x00cb)
+#define NT_STATUS_BAD_NETWORK_NAME (0xC0000000 | 0x00cc)
+#define NT_STATUS_TOO_MANY_NAMES (0xC0000000 | 0x00cd)
+#define NT_STATUS_TOO_MANY_SESSIONS (0xC0000000 | 0x00ce)
+#define NT_STATUS_SHARING_PAUSED (0xC0000000 | 0x00cf)
+#define NT_STATUS_REQUEST_NOT_ACCEPTED (0xC0000000 | 0x00d0)
+#define NT_STATUS_REDIRECTOR_PAUSED (0xC0000000 | 0x00d1)
+#define NT_STATUS_NET_WRITE_FAULT (0xC0000000 | 0x00d2)
+#define NT_STATUS_PROFILING_AT_LIMIT (0xC0000000 | 0x00d3)
+#define NT_STATUS_NOT_SAME_DEVICE (0xC0000000 | 0x00d4)
+#define NT_STATUS_FILE_RENAMED (0xC0000000 | 0x00d5)
+#define NT_STATUS_VIRTUAL_CIRCUIT_CLOSED (0xC0000000 | 0x00d6)
+#define NT_STATUS_NO_SECURITY_ON_OBJECT (0xC0000000 | 0x00d7)
+#define NT_STATUS_CANT_WAIT (0xC0000000 | 0x00d8)
+#define NT_STATUS_PIPE_EMPTY (0xC0000000 | 0x00d9)
+#define NT_STATUS_CANT_ACCESS_DOMAIN_INFO (0xC0000000 | 0x00da)
+#define NT_STATUS_CANT_TERMINATE_SELF (0xC0000000 | 0x00db)
+#define NT_STATUS_INVALID_SERVER_STATE (0xC0000000 | 0x00dc)
+#define NT_STATUS_INVALID_DOMAIN_STATE (0xC0000000 | 0x00dd)
+#define NT_STATUS_INVALID_DOMAIN_ROLE (0xC0000000 | 0x00de)
+#define NT_STATUS_NO_SUCH_DOMAIN (0xC0000000 | 0x00df)
+#define NT_STATUS_DOMAIN_EXISTS (0xC0000000 | 0x00e0)
+#define NT_STATUS_DOMAIN_LIMIT_EXCEEDED (0xC0000000 | 0x00e1)
+#define NT_STATUS_OPLOCK_NOT_GRANTED (0xC0000000 | 0x00e2)
+#define NT_STATUS_INVALID_OPLOCK_PROTOCOL (0xC0000000 | 0x00e3)
+#define NT_STATUS_INTERNAL_DB_CORRUPTION (0xC0000000 | 0x00e4)
+#define NT_STATUS_INTERNAL_ERROR (0xC0000000 | 0x00e5)
+#define NT_STATUS_GENERIC_NOT_MAPPED (0xC0000000 | 0x00e6)
+#define NT_STATUS_BAD_DESCRIPTOR_FORMAT (0xC0000000 | 0x00e7)
+#define NT_STATUS_INVALID_USER_BUFFER (0xC0000000 | 0x00e8)
+#define NT_STATUS_UNEXPECTED_IO_ERROR (0xC0000000 | 0x00e9)
+#define NT_STATUS_UNEXPECTED_MM_CREATE_ERR (0xC0000000 | 0x00ea)
+#define NT_STATUS_UNEXPECTED_MM_MAP_ERROR (0xC0000000 | 0x00eb)
+#define NT_STATUS_UNEXPECTED_MM_EXTEND_ERR (0xC0000000 | 0x00ec)
+#define NT_STATUS_NOT_LOGON_PROCESS (0xC0000000 | 0x00ed)
+#define NT_STATUS_LOGON_SESSION_EXISTS (0xC0000000 | 0x00ee)
+#define NT_STATUS_INVALID_PARAMETER_1 (0xC0000000 | 0x00ef)
+#define NT_STATUS_INVALID_PARAMETER_2 (0xC0000000 | 0x00f0)
+#define NT_STATUS_INVALID_PARAMETER_3 (0xC0000000 | 0x00f1)
+#define NT_STATUS_INVALID_PARAMETER_4 (0xC0000000 | 0x00f2)
+#define NT_STATUS_INVALID_PARAMETER_5 (0xC0000000 | 0x00f3)
+#define NT_STATUS_INVALID_PARAMETER_6 (0xC0000000 | 0x00f4)
+#define NT_STATUS_INVALID_PARAMETER_7 (0xC0000000 | 0x00f5)
+#define NT_STATUS_INVALID_PARAMETER_8 (0xC0000000 | 0x00f6)
+#define NT_STATUS_INVALID_PARAMETER_9 (0xC0000000 | 0x00f7)
+#define NT_STATUS_INVALID_PARAMETER_10 (0xC0000000 | 0x00f8)
+#define NT_STATUS_INVALID_PARAMETER_11 (0xC0000000 | 0x00f9)
+#define NT_STATUS_INVALID_PARAMETER_12 (0xC0000000 | 0x00fa)
+#define NT_STATUS_REDIRECTOR_NOT_STARTED (0xC0000000 | 0x00fb)
+#define NT_STATUS_REDIRECTOR_STARTED (0xC0000000 | 0x00fc)
+#define NT_STATUS_STACK_OVERFLOW (0xC0000000 | 0x00fd)
+#define NT_STATUS_NO_SUCH_PACKAGE (0xC0000000 | 0x00fe)
+#define NT_STATUS_BAD_FUNCTION_TABLE (0xC0000000 | 0x00ff)
+#define NT_STATUS_DIRECTORY_NOT_EMPTY (0xC0000000 | 0x0101)
+#define NT_STATUS_FILE_CORRUPT_ERROR (0xC0000000 | 0x0102)
+#define NT_STATUS_NOT_A_DIRECTORY (0xC0000000 | 0x0103)
+#define NT_STATUS_BAD_LOGON_SESSION_STATE (0xC0000000 | 0x0104)
+#define NT_STATUS_LOGON_SESSION_COLLISION (0xC0000000 | 0x0105)
+#define NT_STATUS_NAME_TOO_LONG (0xC0000000 | 0x0106)
+#define NT_STATUS_FILES_OPEN (0xC0000000 | 0x0107)
+#define NT_STATUS_CONNECTION_IN_USE (0xC0000000 | 0x0108)
+#define NT_STATUS_MESSAGE_NOT_FOUND (0xC0000000 | 0x0109)
+#define NT_STATUS_PROCESS_IS_TERMINATING (0xC0000000 | 0x010a)
+#define NT_STATUS_INVALID_LOGON_TYPE (0xC0000000 | 0x010b)
+#define NT_STATUS_NO_GUID_TRANSLATION (0xC0000000 | 0x010c)
+#define NT_STATUS_CANNOT_IMPERSONATE (0xC0000000 | 0x010d)
+#define NT_STATUS_IMAGE_ALREADY_LOADED (0xC0000000 | 0x010e)
+#define NT_STATUS_ABIOS_NOT_PRESENT (0xC0000000 | 0x010f)
+#define NT_STATUS_ABIOS_LID_NOT_EXIST (0xC0000000 | 0x0110)
+#define NT_STATUS_ABIOS_LID_ALREADY_OWNED (0xC0000000 | 0x0111)
+#define NT_STATUS_ABIOS_NOT_LID_OWNER (0xC0000000 | 0x0112)
+#define NT_STATUS_ABIOS_INVALID_COMMAND (0xC0000000 | 0x0113)
+#define NT_STATUS_ABIOS_INVALID_LID (0xC0000000 | 0x0114)
+#define NT_STATUS_ABIOS_SELECTOR_NOT_AVAILABLE (0xC0000000 | 0x0115)
+#define NT_STATUS_ABIOS_INVALID_SELECTOR (0xC0000000 | 0x0116)
+#define NT_STATUS_NO_LDT (0xC0000000 | 0x0117)
+#define NT_STATUS_INVALID_LDT_SIZE (0xC0000000 | 0x0118)
+#define NT_STATUS_INVALID_LDT_OFFSET (0xC0000000 | 0x0119)
+#define NT_STATUS_INVALID_LDT_DESCRIPTOR (0xC0000000 | 0x011a)
+#define NT_STATUS_INVALID_IMAGE_NE_FORMAT (0xC0000000 | 0x011b)
+#define NT_STATUS_RXACT_INVALID_STATE (0xC0000000 | 0x011c)
+#define NT_STATUS_RXACT_COMMIT_FAILURE (0xC0000000 | 0x011d)
+#define NT_STATUS_MAPPED_FILE_SIZE_ZERO (0xC0000000 | 0x011e)
+#define NT_STATUS_TOO_MANY_OPENED_FILES (0xC0000000 | 0x011f)
+#define NT_STATUS_CANCELLED (0xC0000000 | 0x0120)
+#define NT_STATUS_CANNOT_DELETE (0xC0000000 | 0x0121)
+#define NT_STATUS_INVALID_COMPUTER_NAME (0xC0000000 | 0x0122)
+#define NT_STATUS_FILE_DELETED (0xC0000000 | 0x0123)
+#define NT_STATUS_SPECIAL_ACCOUNT (0xC0000000 | 0x0124)
+#define NT_STATUS_SPECIAL_GROUP (0xC0000000 | 0x0125)
+#define NT_STATUS_SPECIAL_USER (0xC0000000 | 0x0126)
+#define NT_STATUS_MEMBERS_PRIMARY_GROUP (0xC0000000 | 0x0127)
+#define NT_STATUS_FILE_CLOSED (0xC0000000 | 0x0128)
+#define NT_STATUS_TOO_MANY_THREADS (0xC0000000 | 0x0129)
+#define NT_STATUS_THREAD_NOT_IN_PROCESS (0xC0000000 | 0x012a)
+#define NT_STATUS_TOKEN_ALREADY_IN_USE (0xC0000000 | 0x012b)
+#define NT_STATUS_PAGEFILE_QUOTA_EXCEEDED (0xC0000000 | 0x012c)
+#define NT_STATUS_COMMITMENT_LIMIT (0xC0000000 | 0x012d)
+#define NT_STATUS_INVALID_IMAGE_LE_FORMAT (0xC0000000 | 0x012e)
+#define NT_STATUS_INVALID_IMAGE_NOT_MZ (0xC0000000 | 0x012f)
+#define NT_STATUS_INVALID_IMAGE_PROTECT (0xC0000000 | 0x0130)
+#define NT_STATUS_INVALID_IMAGE_WIN_16 (0xC0000000 | 0x0131)
+#define NT_STATUS_LOGON_SERVER_CONFLICT (0xC0000000 | 0x0132)
+#define NT_STATUS_TIME_DIFFERENCE_AT_DC (0xC0000000 | 0x0133)
+#define NT_STATUS_SYNCHRONIZATION_REQUIRED (0xC0000000 | 0x0134)
+#define NT_STATUS_DLL_NOT_FOUND (0xC0000000 | 0x0135)
+#define NT_STATUS_OPEN_FAILED (0xC0000000 | 0x0136)
+#define NT_STATUS_IO_PRIVILEGE_FAILED (0xC0000000 | 0x0137)
+#define NT_STATUS_ORDINAL_NOT_FOUND (0xC0000000 | 0x0138)
+#define NT_STATUS_ENTRYPOINT_NOT_FOUND (0xC0000000 | 0x0139)
+#define NT_STATUS_CONTROL_C_EXIT (0xC0000000 | 0x013a)
+#define NT_STATUS_LOCAL_DISCONNECT (0xC0000000 | 0x013b)
+#define NT_STATUS_REMOTE_DISCONNECT (0xC0000000 | 0x013c)
+#define NT_STATUS_REMOTE_RESOURCES (0xC0000000 | 0x013d)
+#define NT_STATUS_LINK_FAILED (0xC0000000 | 0x013e)
+#define NT_STATUS_LINK_TIMEOUT (0xC0000000 | 0x013f)
+#define NT_STATUS_INVALID_CONNECTION (0xC0000000 | 0x0140)
+#define NT_STATUS_INVALID_ADDRESS (0xC0000000 | 0x0141)
+#define NT_STATUS_DLL_INIT_FAILED (0xC0000000 | 0x0142)
+#define NT_STATUS_MISSING_SYSTEMFILE (0xC0000000 | 0x0143)
+#define NT_STATUS_UNHANDLED_EXCEPTION (0xC0000000 | 0x0144)
+#define NT_STATUS_APP_INIT_FAILURE (0xC0000000 | 0x0145)
+#define NT_STATUS_PAGEFILE_CREATE_FAILED (0xC0000000 | 0x0146)
+#define NT_STATUS_NO_PAGEFILE (0xC0000000 | 0x0147)
+#define NT_STATUS_INVALID_LEVEL (0xC0000000 | 0x0148)
+#define NT_STATUS_WRONG_PASSWORD_CORE (0xC0000000 | 0x0149)
+#define NT_STATUS_ILLEGAL_FLOAT_CONTEXT (0xC0000000 | 0x014a)
+#define NT_STATUS_PIPE_BROKEN (0xC0000000 | 0x014b)
+#define NT_STATUS_REGISTRY_CORRUPT (0xC0000000 | 0x014c)
+#define NT_STATUS_REGISTRY_IO_FAILED (0xC0000000 | 0x014d)
+#define NT_STATUS_NO_EVENT_PAIR (0xC0000000 | 0x014e)
+#define NT_STATUS_UNRECOGNIZED_VOLUME (0xC0000000 | 0x014f)
+#define NT_STATUS_SERIAL_NO_DEVICE_INITED (0xC0000000 | 0x0150)
+#define NT_STATUS_NO_SUCH_ALIAS (0xC0000000 | 0x0151)
+#define NT_STATUS_MEMBER_NOT_IN_ALIAS (0xC0000000 | 0x0152)
+#define NT_STATUS_MEMBER_IN_ALIAS (0xC0000000 | 0x0153)
+#define NT_STATUS_ALIAS_EXISTS (0xC0000000 | 0x0154)
+#define NT_STATUS_LOGON_NOT_GRANTED (0xC0000000 | 0x0155)
+#define NT_STATUS_TOO_MANY_SECRETS (0xC0000000 | 0x0156)
+#define NT_STATUS_SECRET_TOO_LONG (0xC0000000 | 0x0157)
+#define NT_STATUS_INTERNAL_DB_ERROR (0xC0000000 | 0x0158)
+#define NT_STATUS_FULLSCREEN_MODE (0xC0000000 | 0x0159)
+#define NT_STATUS_TOO_MANY_CONTEXT_IDS (0xC0000000 | 0x015a)
+#define NT_STATUS_LOGON_TYPE_NOT_GRANTED (0xC0000000 | 0x015b)
+#define NT_STATUS_NOT_REGISTRY_FILE (0xC0000000 | 0x015c)
+#define NT_STATUS_NT_CROSS_ENCRYPTION_REQUIRED (0xC0000000 | 0x015d)
+#define NT_STATUS_DOMAIN_CTRLR_CONFIG_ERROR (0xC0000000 | 0x015e)
+#define NT_STATUS_FT_MISSING_MEMBER (0xC0000000 | 0x015f)
+#define NT_STATUS_ILL_FORMED_SERVICE_ENTRY (0xC0000000 | 0x0160)
+#define NT_STATUS_ILLEGAL_CHARACTER (0xC0000000 | 0x0161)
+#define NT_STATUS_UNMAPPABLE_CHARACTER (0xC0000000 | 0x0162)
+#define NT_STATUS_UNDEFINED_CHARACTER (0xC0000000 | 0x0163)
+#define NT_STATUS_FLOPPY_VOLUME (0xC0000000 | 0x0164)
+#define NT_STATUS_FLOPPY_ID_MARK_NOT_FOUND (0xC0000000 | 0x0165)
+#define NT_STATUS_FLOPPY_WRONG_CYLINDER (0xC0000000 | 0x0166)
+#define NT_STATUS_FLOPPY_UNKNOWN_ERROR (0xC0000000 | 0x0167)
+#define NT_STATUS_FLOPPY_BAD_REGISTERS (0xC0000000 | 0x0168)
+#define NT_STATUS_DISK_RECALIBRATE_FAILED (0xC0000000 | 0x0169)
+#define NT_STATUS_DISK_OPERATION_FAILED (0xC0000000 | 0x016a)
+#define NT_STATUS_DISK_RESET_FAILED (0xC0000000 | 0x016b)
+#define NT_STATUS_SHARED_IRQ_BUSY (0xC0000000 | 0x016c)
+#define NT_STATUS_FT_ORPHANING (0xC0000000 | 0x016d)
+#define NT_STATUS_PARTITION_FAILURE (0xC0000000 | 0x0172)
+#define NT_STATUS_INVALID_BLOCK_LENGTH (0xC0000000 | 0x0173)
+#define NT_STATUS_DEVICE_NOT_PARTITIONED (0xC0000000 | 0x0174)
+#define NT_STATUS_UNABLE_TO_LOCK_MEDIA (0xC0000000 | 0x0175)
+#define NT_STATUS_UNABLE_TO_UNLOAD_MEDIA (0xC0000000 | 0x0176)
+#define NT_STATUS_EOM_OVERFLOW (0xC0000000 | 0x0177)
+#define NT_STATUS_NO_MEDIA (0xC0000000 | 0x0178)
+#define NT_STATUS_NO_SUCH_MEMBER (0xC0000000 | 0x017a)
+#define NT_STATUS_INVALID_MEMBER (0xC0000000 | 0x017b)
+#define NT_STATUS_KEY_DELETED (0xC0000000 | 0x017c)
+#define NT_STATUS_NO_LOG_SPACE (0xC0000000 | 0x017d)
+#define NT_STATUS_TOO_MANY_SIDS (0xC0000000 | 0x017e)
+#define NT_STATUS_LM_CROSS_ENCRYPTION_REQUIRED (0xC0000000 | 0x017f)
+#define NT_STATUS_KEY_HAS_CHILDREN (0xC0000000 | 0x0180)
+#define NT_STATUS_CHILD_MUST_BE_VOLATILE (0xC0000000 | 0x0181)
+#define NT_STATUS_DEVICE_CONFIGURATION_ERROR (0xC0000000 | 0x0182)
+#define NT_STATUS_DRIVER_INTERNAL_ERROR (0xC0000000 | 0x0183)
+#define NT_STATUS_INVALID_DEVICE_STATE (0xC0000000 | 0x0184)
+#define NT_STATUS_IO_DEVICE_ERROR (0xC0000000 | 0x0185)
+#define NT_STATUS_DEVICE_PROTOCOL_ERROR (0xC0000000 | 0x0186)
+#define NT_STATUS_BACKUP_CONTROLLER (0xC0000000 | 0x0187)
+#define NT_STATUS_LOG_FILE_FULL (0xC0000000 | 0x0188)
+#define NT_STATUS_TOO_LATE (0xC0000000 | 0x0189)
+#define NT_STATUS_NO_TRUST_LSA_SECRET (0xC0000000 | 0x018a)
+#define NT_STATUS_NO_TRUST_SAM_ACCOUNT (0xC0000000 | 0x018b)
+#define NT_STATUS_TRUSTED_DOMAIN_FAILURE (0xC0000000 | 0x018c)
+#define NT_STATUS_TRUSTED_RELATIONSHIP_FAILURE (0xC0000000 | 0x018d)
+#define NT_STATUS_EVENTLOG_FILE_CORRUPT (0xC0000000 | 0x018e)
+#define NT_STATUS_EVENTLOG_CANT_START (0xC0000000 | 0x018f)
+#define NT_STATUS_TRUST_FAILURE (0xC0000000 | 0x0190)
+#define NT_STATUS_MUTANT_LIMIT_EXCEEDED (0xC0000000 | 0x0191)
+#define NT_STATUS_NETLOGON_NOT_STARTED (0xC0000000 | 0x0192)
+#define NT_STATUS_ACCOUNT_EXPIRED (0xC0000000 | 0x0193)
+#define NT_STATUS_POSSIBLE_DEADLOCK (0xC0000000 | 0x0194)
+#define NT_STATUS_NETWORK_CREDENTIAL_CONFLICT (0xC0000000 | 0x0195)
+#define NT_STATUS_REMOTE_SESSION_LIMIT (0xC0000000 | 0x0196)
+#define NT_STATUS_EVENTLOG_FILE_CHANGED (0xC0000000 | 0x0197)
+#define NT_STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT (0xC0000000 | 0x0198)
+#define NT_STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT (0xC0000000 | 0x0199)
+#define NT_STATUS_NOLOGON_SERVER_TRUST_ACCOUNT (0xC0000000 | 0x019a)
+#define NT_STATUS_DOMAIN_TRUST_INCONSISTENT (0xC0000000 | 0x019b)
+#define NT_STATUS_FS_DRIVER_REQUIRED (0xC0000000 | 0x019c)
+#define NT_STATUS_NO_USER_SESSION_KEY (0xC0000000 | 0x0202)
+#define NT_STATUS_USER_SESSION_DELETED (0xC0000000 | 0x0203)
+#define NT_STATUS_RESOURCE_LANG_NOT_FOUND (0xC0000000 | 0x0204)
+#define NT_STATUS_INSUFF_SERVER_RESOURCES (0xC0000000 | 0x0205)
+#define NT_STATUS_INVALID_BUFFER_SIZE (0xC0000000 | 0x0206)
+#define NT_STATUS_INVALID_ADDRESS_COMPONENT (0xC0000000 | 0x0207)
+#define NT_STATUS_INVALID_ADDRESS_WILDCARD (0xC0000000 | 0x0208)
+#define NT_STATUS_TOO_MANY_ADDRESSES (0xC0000000 | 0x0209)
+#define NT_STATUS_ADDRESS_ALREADY_EXISTS (0xC0000000 | 0x020a)
+#define NT_STATUS_ADDRESS_CLOSED (0xC0000000 | 0x020b)
+#define NT_STATUS_CONNECTION_DISCONNECTED (0xC0000000 | 0x020c)
+#define NT_STATUS_CONNECTION_RESET (0xC0000000 | 0x020d)
+#define NT_STATUS_TOO_MANY_NODES (0xC0000000 | 0x020e)
+#define NT_STATUS_TRANSACTION_ABORTED (0xC0000000 | 0x020f)
+#define NT_STATUS_TRANSACTION_TIMED_OUT (0xC0000000 | 0x0210)
+#define NT_STATUS_TRANSACTION_NO_RELEASE (0xC0000000 | 0x0211)
+#define NT_STATUS_TRANSACTION_NO_MATCH (0xC0000000 | 0x0212)
+#define NT_STATUS_TRANSACTION_RESPONDED (0xC0000000 | 0x0213)
+#define NT_STATUS_TRANSACTION_INVALID_ID (0xC0000000 | 0x0214)
+#define NT_STATUS_TRANSACTION_INVALID_TYPE (0xC0000000 | 0x0215)
+#define NT_STATUS_NOT_SERVER_SESSION (0xC0000000 | 0x0216)
+#define NT_STATUS_NOT_CLIENT_SESSION (0xC0000000 | 0x0217)
+#define NT_STATUS_CANNOT_LOAD_REGISTRY_FILE (0xC0000000 | 0x0218)
+#define NT_STATUS_DEBUG_ATTACH_FAILED (0xC0000000 | 0x0219)
+#define NT_STATUS_SYSTEM_PROCESS_TERMINATED (0xC0000000 | 0x021a)
+#define NT_STATUS_DATA_NOT_ACCEPTED (0xC0000000 | 0x021b)
+#define NT_STATUS_NO_BROWSER_SERVERS_FOUND (0xC0000000 | 0x021c)
+#define NT_STATUS_VDM_HARD_ERROR (0xC0000000 | 0x021d)
+#define NT_STATUS_DRIVER_CANCEL_TIMEOUT (0xC0000000 | 0x021e)
+#define NT_STATUS_REPLY_MESSAGE_MISMATCH (0xC0000000 | 0x021f)
+#define NT_STATUS_MAPPED_ALIGNMENT (0xC0000000 | 0x0220)
+#define NT_STATUS_IMAGE_CHECKSUM_MISMATCH (0xC0000000 | 0x0221)
+#define NT_STATUS_LOST_WRITEBEHIND_DATA (0xC0000000 | 0x0222)
+#define NT_STATUS_CLIENT_SERVER_PARAMETERS_INVALID (0xC0000000 | 0x0223)
+#define NT_STATUS_PASSWORD_MUST_CHANGE (0xC0000000 | 0x0224)
+#define NT_STATUS_NOT_FOUND (0xC0000000 | 0x0225)
+#define NT_STATUS_NOT_TINY_STREAM (0xC0000000 | 0x0226)
+#define NT_STATUS_RECOVERY_FAILURE (0xC0000000 | 0x0227)
+#define NT_STATUS_STACK_OVERFLOW_READ (0xC0000000 | 0x0228)
+#define NT_STATUS_FAIL_CHECK (0xC0000000 | 0x0229)
+#define NT_STATUS_DUPLICATE_OBJECTID (0xC0000000 | 0x022a)
+#define NT_STATUS_OBJECTID_EXISTS (0xC0000000 | 0x022b)
+#define NT_STATUS_CONVERT_TO_LARGE (0xC0000000 | 0x022c)
+#define NT_STATUS_RETRY (0xC0000000 | 0x022d)
+#define NT_STATUS_FOUND_OUT_OF_SCOPE (0xC0000000 | 0x022e)
+#define NT_STATUS_ALLOCATE_BUCKET (0xC0000000 | 0x022f)
+#define NT_STATUS_PROPSET_NOT_FOUND (0xC0000000 | 0x0230)
+#define NT_STATUS_MARSHALL_OVERFLOW (0xC0000000 | 0x0231)
+#define NT_STATUS_INVALID_VARIANT (0xC0000000 | 0x0232)
+#define NT_STATUS_DOMAIN_CONTROLLER_NOT_FOUND (0xC0000000 | 0x0233)
+#define NT_STATUS_ACCOUNT_LOCKED_OUT (0xC0000000 | 0x0234)
+#define NT_STATUS_HANDLE_NOT_CLOSABLE (0xC0000000 | 0x0235)
+#define NT_STATUS_CONNECTION_REFUSED (0xC0000000 | 0x0236)
+#define NT_STATUS_GRACEFUL_DISCONNECT (0xC0000000 | 0x0237)
+#define NT_STATUS_ADDRESS_ALREADY_ASSOCIATED (0xC0000000 | 0x0238)
+#define NT_STATUS_ADDRESS_NOT_ASSOCIATED (0xC0000000 | 0x0239)
+#define NT_STATUS_CONNECTION_INVALID (0xC0000000 | 0x023a)
+#define NT_STATUS_CONNECTION_ACTIVE (0xC0000000 | 0x023b)
+#define NT_STATUS_NETWORK_UNREACHABLE (0xC0000000 | 0x023c)
+#define NT_STATUS_HOST_UNREACHABLE (0xC0000000 | 0x023d)
+#define NT_STATUS_PROTOCOL_UNREACHABLE (0xC0000000 | 0x023e)
+#define NT_STATUS_PORT_UNREACHABLE (0xC0000000 | 0x023f)
+#define NT_STATUS_REQUEST_ABORTED (0xC0000000 | 0x0240)
+#define NT_STATUS_CONNECTION_ABORTED (0xC0000000 | 0x0241)
+#define NT_STATUS_BAD_COMPRESSION_BUFFER (0xC0000000 | 0x0242)
+#define NT_STATUS_USER_MAPPED_FILE (0xC0000000 | 0x0243)
+#define NT_STATUS_AUDIT_FAILED (0xC0000000 | 0x0244)
+#define NT_STATUS_TIMER_RESOLUTION_NOT_SET (0xC0000000 | 0x0245)
+#define NT_STATUS_CONNECTION_COUNT_LIMIT (0xC0000000 | 0x0246)
+#define NT_STATUS_LOGIN_TIME_RESTRICTION (0xC0000000 | 0x0247)
+#define NT_STATUS_LOGIN_WKSTA_RESTRICTION (0xC0000000 | 0x0248)
+#define NT_STATUS_IMAGE_MP_UP_MISMATCH (0xC0000000 | 0x0249)
+#define NT_STATUS_INSUFFICIENT_LOGON_INFO (0xC0000000 | 0x0250)
+#define NT_STATUS_BAD_DLL_ENTRYPOINT (0xC0000000 | 0x0251)
+#define NT_STATUS_BAD_SERVICE_ENTRYPOINT (0xC0000000 | 0x0252)
+#define NT_STATUS_LPC_REPLY_LOST (0xC0000000 | 0x0253)
+#define NT_STATUS_IP_ADDRESS_CONFLICT1 (0xC0000000 | 0x0254)
+#define NT_STATUS_IP_ADDRESS_CONFLICT2 (0xC0000000 | 0x0255)
+#define NT_STATUS_REGISTRY_QUOTA_LIMIT (0xC0000000 | 0x0256)
+#define NT_STATUS_PATH_NOT_COVERED (0xC0000000 | 0x0257)
+#define NT_STATUS_NO_CALLBACK_ACTIVE (0xC0000000 | 0x0258)
+#define NT_STATUS_LICENSE_QUOTA_EXCEEDED (0xC0000000 | 0x0259)
+#define NT_STATUS_PWD_TOO_SHORT (0xC0000000 | 0x025a)
+#define NT_STATUS_PWD_TOO_RECENT (0xC0000000 | 0x025b)
+#define NT_STATUS_PWD_HISTORY_CONFLICT (0xC0000000 | 0x025c)
+#define NT_STATUS_PLUGPLAY_NO_DEVICE (0xC0000000 | 0x025e)
+#define NT_STATUS_UNSUPPORTED_COMPRESSION (0xC0000000 | 0x025f)
+#define NT_STATUS_INVALID_HW_PROFILE (0xC0000000 | 0x0260)
+#define NT_STATUS_INVALID_PLUGPLAY_DEVICE_PATH (0xC0000000 | 0x0261)
+#define NT_STATUS_DRIVER_ORDINAL_NOT_FOUND (0xC0000000 | 0x0262)
+#define NT_STATUS_DRIVER_ENTRYPOINT_NOT_FOUND (0xC0000000 | 0x0263)
+#define NT_STATUS_RESOURCE_NOT_OWNED (0xC0000000 | 0x0264)
+#define NT_STATUS_TOO_MANY_LINKS (0xC0000000 | 0x0265)
+#define NT_STATUS_QUOTA_LIST_INCONSISTENT (0xC0000000 | 0x0266)
+#define NT_STATUS_FILE_IS_OFFLINE (0xC0000000 | 0x0267)
+#define NT_STATUS_NETWORK_SESSION_EXPIRED  (0xC0000000 | 0x035c)
+#define NT_STATUS_NO_SUCH_JOB (0xC0000000 | 0xEDE)     /* scheduler */
+#define NT_STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP (0xC0000000 | 0x5D0000)
+#define NT_STATUS_PENDING 0x00000103
+#endif				/* _NTERR_H */
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
new file mode 100644
index 000000000000..4508631c5706
--- /dev/null
+++ b/fs/ksmbd/smb2misc.c
@@ -0,0 +1,433 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "glob.h"
+#include "nterr.h"
+#include "smb2pdu.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "mgmt/user_session.h"
+#include "connection.h"
+
+static int check_smb2_hdr(struct smb2_hdr *hdr)
+{
+	/*
+	 * Make sure that this really is an SMB, that it is a response.
+	 */
+	if (hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
+		return 1;
+	return 0;
+}
+
+/*
+ *  The following table defines the expected "StructureSize" of SMB2 requests
+ *  in order by SMB2 command.  This is similar to "wct" in SMB/CIFS requests.
+ *
+ *  Note that commands are defined in smb2pdu.h in le16 but the array below is
+ *  indexed by command in host byte order
+ */
+static const __le16 smb2_req_struct_sizes[NUMBER_OF_SMB2_COMMANDS] = {
+	/* SMB2_NEGOTIATE */ cpu_to_le16(36),
+	/* SMB2_SESSION_SETUP */ cpu_to_le16(25),
+	/* SMB2_LOGOFF */ cpu_to_le16(4),
+	/* SMB2_TREE_CONNECT */ cpu_to_le16(9),
+	/* SMB2_TREE_DISCONNECT */ cpu_to_le16(4),
+	/* SMB2_CREATE */ cpu_to_le16(57),
+	/* SMB2_CLOSE */ cpu_to_le16(24),
+	/* SMB2_FLUSH */ cpu_to_le16(24),
+	/* SMB2_READ */ cpu_to_le16(49),
+	/* SMB2_WRITE */ cpu_to_le16(49),
+	/* SMB2_LOCK */ cpu_to_le16(48),
+	/* SMB2_IOCTL */ cpu_to_le16(57),
+	/* SMB2_CANCEL */ cpu_to_le16(4),
+	/* SMB2_ECHO */ cpu_to_le16(4),
+	/* SMB2_QUERY_DIRECTORY */ cpu_to_le16(33),
+	/* SMB2_CHANGE_NOTIFY */ cpu_to_le16(32),
+	/* SMB2_QUERY_INFO */ cpu_to_le16(41),
+	/* SMB2_SET_INFO */ cpu_to_le16(33),
+	/* use 44 for lease break */
+	/* SMB2_OPLOCK_BREAK */ cpu_to_le16(36)
+};
+
+/*
+ * The size of the variable area depends on the offset and length fields
+ * located in different fields for various SMB2 requests. SMB2 requests
+ * with no variable length info, show an offset of zero for the offset field.
+ */
+static const bool has_smb2_data_area[NUMBER_OF_SMB2_COMMANDS] = {
+	/* SMB2_NEGOTIATE */ true,
+	/* SMB2_SESSION_SETUP */ true,
+	/* SMB2_LOGOFF */ false,
+	/* SMB2_TREE_CONNECT */	true,
+	/* SMB2_TREE_DISCONNECT */ false,
+	/* SMB2_CREATE */ true,
+	/* SMB2_CLOSE */ false,
+	/* SMB2_FLUSH */ false,
+	/* SMB2_READ */	true,
+	/* SMB2_WRITE */ true,
+	/* SMB2_LOCK */	true,
+	/* SMB2_IOCTL */ true,
+	/* SMB2_CANCEL */ false, /* BB CHECK this not listed in documentation */
+	/* SMB2_ECHO */ false,
+	/* SMB2_QUERY_DIRECTORY */ true,
+	/* SMB2_CHANGE_NOTIFY */ false,
+	/* SMB2_QUERY_INFO */ true,
+	/* SMB2_SET_INFO */ true,
+	/* SMB2_OPLOCK_BREAK */ false
+};
+
+/*
+ * Returns the pointer to the beginning of the data area. Length of the data
+ * area and the offset to it (from the beginning of the smb are also returned.
+ */
+static char *smb2_get_data_area_len(int *off, int *len, struct smb2_hdr *hdr)
+{
+	*off = 0;
+	*len = 0;
+
+	/* error reqeusts do not have data area */
+	if (hdr->Status && hdr->Status != STATUS_MORE_PROCESSING_REQUIRED &&
+	    (((struct smb2_err_rsp *)hdr)->StructureSize) == SMB2_ERROR_STRUCTURE_SIZE2_LE)
+		return NULL;
+
+	/*
+	 * Following commands have data areas so we have to get the location
+	 * of the data buffer offset and data buffer length for the particular
+	 * command.
+	 */
+	switch (hdr->Command) {
+	case SMB2_SESSION_SETUP:
+		*off = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferOffset);
+		*len = le16_to_cpu(((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
+		break;
+	case SMB2_TREE_CONNECT:
+		*off = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*len = le16_to_cpu(((struct smb2_tree_connect_req *)hdr)->PathLength);
+		break;
+	case SMB2_CREATE:
+	{
+		if (((struct smb2_create_req *)hdr)->CreateContextsLength) {
+			*off = le32_to_cpu(((struct smb2_create_req *)
+				hdr)->CreateContextsOffset);
+			*len = le32_to_cpu(((struct smb2_create_req *)
+				hdr)->CreateContextsLength);
+			break;
+		}
+
+		*off = le16_to_cpu(((struct smb2_create_req *)hdr)->NameOffset);
+		*len = le16_to_cpu(((struct smb2_create_req *)hdr)->NameLength);
+		break;
+	}
+	case SMB2_QUERY_INFO:
+		*off = le16_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*len = le32_to_cpu(((struct smb2_query_info_req *)hdr)->InputBufferLength);
+		break;
+	case SMB2_SET_INFO:
+		*off = le16_to_cpu(((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*len = le32_to_cpu(((struct smb2_set_info_req *)hdr)->BufferLength);
+		break;
+	case SMB2_READ:
+		*off = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoOffset);
+		*len = le16_to_cpu(((struct smb2_read_req *)hdr)->ReadChannelInfoLength);
+		break;
+	case SMB2_WRITE:
+		if (((struct smb2_write_req *)hdr)->DataOffset) {
+			*off = le16_to_cpu(((struct smb2_write_req *)hdr)->DataOffset);
+			*len = le32_to_cpu(((struct smb2_write_req *)hdr)->Length);
+			break;
+		}
+
+		*off = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoOffset);
+		*len = le16_to_cpu(((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
+		break;
+	case SMB2_QUERY_DIRECTORY:
+		*off = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*len = le16_to_cpu(((struct smb2_query_directory_req *)hdr)->FileNameLength);
+		break;
+	case SMB2_LOCK:
+	{
+		int lock_count;
+
+		/*
+		 * smb2_lock request size is 48 included single
+		 * smb2_lock_element structure size.
+		 */
+		lock_count = le16_to_cpu(((struct smb2_lock_req *)hdr)->LockCount) - 1;
+		if (lock_count > 0) {
+			*off = __SMB2_HEADER_STRUCTURE_SIZE + 48;
+			*len = sizeof(struct smb2_lock_element) * lock_count;
+		}
+		break;
+	}
+	case SMB2_IOCTL:
+		*off = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputOffset);
+		*len = le32_to_cpu(((struct smb2_ioctl_req *)hdr)->InputCount);
+
+		break;
+	default:
+		ksmbd_debug(SMB, "no length check for command\n");
+		break;
+	}
+
+	/*
+	 * Invalid length or offset probably means data area is invalid, but
+	 * we have little choice but to ignore the data area in this case.
+	 */
+	if (*off > 4096) {
+		ksmbd_debug(SMB, "offset %d too large, data area ignored\n",
+			    *off);
+		*len = 0;
+		*off = 0;
+	} else if (*off < 0) {
+		ksmbd_debug(SMB,
+			    "negative offset %d to data invalid ignore data area\n",
+			    *off);
+		*off = 0;
+		*len = 0;
+	} else if (*len < 0) {
+		ksmbd_debug(SMB,
+			    "negative data length %d invalid, data area ignored\n",
+			    *len);
+		*len = 0;
+	} else if (*len > 128 * 1024) {
+		ksmbd_debug(SMB, "data area larger than 128K: %d\n", *len);
+		*len = 0;
+	}
+
+	/* return pointer to beginning of data area, ie offset from SMB start */
+	if ((*off != 0) && (*len != 0))
+		return (char *)hdr + *off;
+	else
+		return NULL;
+}
+
+/*
+ * Calculate the size of the SMB message based on the fixed header
+ * portion, the number of word parameters and the data portion of the message.
+ */
+static unsigned int smb2_calc_size(void *buf)
+{
+	struct smb2_pdu *pdu = (struct smb2_pdu *)buf;
+	struct smb2_hdr *hdr = &pdu->hdr;
+	int offset; /* the offset from the beginning of SMB to data area */
+	int data_length; /* the length of the variable length data area */
+	/* Structure Size has already been checked to make sure it is 64 */
+	int len = le16_to_cpu(hdr->StructureSize);
+
+	/*
+	 * StructureSize2, ie length of fixed parameter area has already
+	 * been checked to make sure it is the correct length.
+	 */
+	len += le16_to_cpu(pdu->StructureSize2);
+
+	if (has_smb2_data_area[le16_to_cpu(hdr->Command)] == false)
+		goto calc_size_exit;
+
+	smb2_get_data_area_len(&offset, &data_length, hdr);
+	ksmbd_debug(SMB, "SMB2 data length %d offset %d\n", data_length,
+		    offset);
+
+	if (data_length > 0) {
+		/*
+		 * Check to make sure that data area begins after fixed area,
+		 * Note that last byte of the fixed area is part of data area
+		 * for some commands, typically those with odd StructureSize,
+		 * so we must add one to the calculation.
+		 */
+		if (offset + 1 < len)
+			ksmbd_debug(SMB,
+				    "data area offset %d overlaps SMB2 header %d\n",
+				    offset + 1, len);
+		else
+			len = offset + data_length;
+	}
+calc_size_exit:
+	ksmbd_debug(SMB, "SMB2 len %d\n", len);
+	return len;
+}
+
+static inline int smb2_query_info_req_len(struct smb2_query_info_req *h)
+{
+	return le32_to_cpu(h->InputBufferLength) +
+		le32_to_cpu(h->OutputBufferLength);
+}
+
+static inline int smb2_set_info_req_len(struct smb2_set_info_req *h)
+{
+	return le32_to_cpu(h->BufferLength);
+}
+
+static inline int smb2_read_req_len(struct smb2_read_req *h)
+{
+	return le32_to_cpu(h->Length);
+}
+
+static inline int smb2_write_req_len(struct smb2_write_req *h)
+{
+	return le32_to_cpu(h->Length);
+}
+
+static inline int smb2_query_dir_req_len(struct smb2_query_directory_req *h)
+{
+	return le32_to_cpu(h->OutputBufferLength);
+}
+
+static inline int smb2_ioctl_req_len(struct smb2_ioctl_req *h)
+{
+	return le32_to_cpu(h->InputCount) +
+		le32_to_cpu(h->OutputCount);
+}
+
+static inline int smb2_ioctl_resp_len(struct smb2_ioctl_req *h)
+{
+	return le32_to_cpu(h->MaxInputResponse) +
+		le32_to_cpu(h->MaxOutputResponse);
+}
+
+static int smb2_validate_credit_charge(struct smb2_hdr *hdr)
+{
+	int req_len = 0, expect_resp_len = 0, calc_credit_num, max_len;
+	int credit_charge = le16_to_cpu(hdr->CreditCharge);
+	void *__hdr = hdr;
+
+	switch (hdr->Command) {
+	case SMB2_QUERY_INFO:
+		req_len = smb2_query_info_req_len(__hdr);
+		break;
+	case SMB2_SET_INFO:
+		req_len = smb2_set_info_req_len(__hdr);
+		break;
+	case SMB2_READ:
+		req_len = smb2_read_req_len(__hdr);
+		break;
+	case SMB2_WRITE:
+		req_len = smb2_write_req_len(__hdr);
+		break;
+	case SMB2_QUERY_DIRECTORY:
+		req_len = smb2_query_dir_req_len(__hdr);
+		break;
+	case SMB2_IOCTL:
+		req_len = smb2_ioctl_req_len(__hdr);
+		expect_resp_len = smb2_ioctl_resp_len(__hdr);
+		break;
+	default:
+		return 0;
+	}
+
+	credit_charge = max(1, credit_charge);
+	max_len = max(req_len, expect_resp_len);
+	calc_credit_num = DIV_ROUND_UP(max_len, SMB2_MAX_BUFFER_SIZE);
+
+	if (credit_charge < calc_credit_num) {
+		pr_err("Insufficient credit charge, given: %d, needed: %d\n",
+		       credit_charge, calc_credit_num);
+		return 1;
+	}
+
+	return 0;
+}
+
+int ksmbd_smb2_check_message(struct ksmbd_work *work)
+{
+	struct smb2_pdu *pdu = work->request_buf;
+	struct smb2_hdr *hdr = &pdu->hdr;
+	int command;
+	__u32 clc_len;  /* calculated length */
+	__u32 len = get_rfc1002_len(pdu);
+
+	if (work->next_smb2_rcv_hdr_off) {
+		pdu = ksmbd_req_buf_next(work);
+		hdr = &pdu->hdr;
+	}
+
+	if (le32_to_cpu(hdr->NextCommand) > 0) {
+		len = le32_to_cpu(hdr->NextCommand);
+	} else if (work->next_smb2_rcv_hdr_off) {
+		len -= work->next_smb2_rcv_hdr_off;
+		len = round_up(len, 8);
+	}
+
+	if (check_smb2_hdr(hdr))
+		return 1;
+
+	if (hdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
+		ksmbd_debug(SMB, "Illegal structure size %u\n",
+			    le16_to_cpu(hdr->StructureSize));
+		return 1;
+	}
+
+	command = le16_to_cpu(hdr->Command);
+	if (command >= NUMBER_OF_SMB2_COMMANDS) {
+		ksmbd_debug(SMB, "Illegal SMB2 command %d\n", command);
+		return 1;
+	}
+
+	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
+		if (command != SMB2_OPLOCK_BREAK_HE &&
+		    (hdr->Status == 0 || pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
+			/* error packets have 9 byte structure size */
+			ksmbd_debug(SMB,
+				    "Illegal request size %u for command %d\n",
+				    le16_to_cpu(pdu->StructureSize2), command);
+			return 1;
+		} else if (command == SMB2_OPLOCK_BREAK_HE &&
+			   hdr->Status == 0 &&
+			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
+			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+			/* special case for SMB2.1 lease break message */
+			ksmbd_debug(SMB,
+				    "Illegal request size %d for oplock break\n",
+				    le16_to_cpu(pdu->StructureSize2));
+			return 1;
+		}
+	}
+
+	clc_len = smb2_calc_size(hdr);
+	if (len != clc_len) {
+		/* server can return one byte more due to implied bcc[0] */
+		if (clc_len == len + 1)
+			return 0;
+
+		/*
+		 * Some windows servers (win2016) will pad also the final
+		 * PDU in a compound to 8 bytes.
+		 */
+		if (ALIGN(clc_len, 8) == len)
+			return 0;
+
+		/*
+		 * windows client also pad up to 8 bytes when compounding.
+		 * If pad is longer than eight bytes, log the server behavior
+		 * (once), since may indicate a problem but allow it and
+		 * continue since the frame is parseable.
+		 */
+		if (clc_len < len) {
+			ksmbd_debug(SMB,
+				    "cli req padded more than expected. Length %d not %d for cmd:%d mid:%llu\n",
+				    len, clc_len, command,
+				    le64_to_cpu(hdr->MessageId));
+			return 0;
+		}
+
+		if (command == SMB2_LOCK_HE && len == 88)
+			return 0;
+
+		ksmbd_debug(SMB,
+			    "cli req too short, len %d not %d. cmd:%d mid:%llu\n",
+			    len, clc_len, command,
+			    le64_to_cpu(hdr->MessageId));
+
+		return 1;
+	}
+
+	return work->conn->vals->capabilities & SMB2_GLOBAL_CAP_LARGE_MTU ?
+		smb2_validate_credit_charge(hdr) : 0;
+}
+
+int smb2_negotiate_request(struct ksmbd_work *work)
+{
+	return ksmbd_smb_negotiate_common(work, SMB2_NEGOTIATE_HE);
+}
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
new file mode 100644
index 000000000000..24c6bb476f6e
--- /dev/null
+++ b/fs/ksmbd/smb_common.c
@@ -0,0 +1,655 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ *   Copyright (C) 2018 Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+#include "smb_common.h"
+#include "server.h"
+#include "misc.h"
+#include "smbstatus.h"
+#include "connection.h"
+#include "ksmbd_work.h"
+#include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/share_config.h"
+
+/*for shortname implementation */
+static const char basechars[43] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_-!@#$%";
+#define MANGLE_BASE (sizeof(basechars) / sizeof(char) - 1)
+#define MAGIC_CHAR '~'
+#define PERIOD '.'
+#define mangle(V) ((char)(basechars[(V) % MANGLE_BASE]))
+#define KSMBD_MIN_SUPPORTED_HEADER_SIZE	(sizeof(struct smb2_hdr))
+
+struct smb_protocol {
+	int		index;
+	char		*name;
+	char		*prot;
+	__u16		prot_id;
+};
+
+static struct smb_protocol smb_protos[] = {
+	{
+		SMB21_PROT,
+		"\2SMB 2.1",
+		"SMB2_10",
+		SMB21_PROT_ID
+	},
+	{
+		SMB2X_PROT,
+		"\2SMB 2.???",
+		"SMB2_22",
+		SMB2X_PROT_ID
+	},
+	{
+		SMB30_PROT,
+		"\2SMB 3.0",
+		"SMB3_00",
+		SMB30_PROT_ID
+	},
+	{
+		SMB302_PROT,
+		"\2SMB 3.02",
+		"SMB3_02",
+		SMB302_PROT_ID
+	},
+	{
+		SMB311_PROT,
+		"\2SMB 3.1.1",
+		"SMB3_11",
+		SMB311_PROT_ID
+	},
+};
+
+unsigned int ksmbd_server_side_copy_max_chunk_count(void)
+{
+	return 256;
+}
+
+unsigned int ksmbd_server_side_copy_max_chunk_size(void)
+{
+	return (2U << 30) - 1;
+}
+
+unsigned int ksmbd_server_side_copy_max_total_size(void)
+{
+	return (2U << 30) - 1;
+}
+
+inline int ksmbd_min_protocol(void)
+{
+	return SMB2_PROT;
+}
+
+inline int ksmbd_max_protocol(void)
+{
+	return SMB311_PROT;
+}
+
+int ksmbd_lookup_protocol_idx(char *str)
+{
+	int offt = ARRAY_SIZE(smb_protos) - 1;
+	int len = strlen(str);
+
+	while (offt >= 0) {
+		if (!strncmp(str, smb_protos[offt].prot, len)) {
+			ksmbd_debug(SMB, "selected %s dialect idx = %d\n",
+				    smb_protos[offt].prot, offt);
+			return smb_protos[offt].index;
+		}
+		offt--;
+	}
+	return -1;
+}
+
+/**
+ * ksmbd_verify_smb_message() - check for valid smb2 request header
+ * @work:	smb work
+ *
+ * check for valid smb signature and packet direction(request/response)
+ *
+ * Return:      0 on success, otherwise 1
+ */
+int ksmbd_verify_smb_message(struct ksmbd_work *work)
+{
+	struct smb2_hdr *smb2_hdr = work->request_buf;
+
+	if (smb2_hdr->ProtocolId == SMB2_PROTO_NUMBER)
+		return ksmbd_smb2_check_message(work);
+
+	return 0;
+}
+
+/**
+ * ksmbd_smb_request() - check for valid smb request type
+ * @conn:	connection instance
+ *
+ * Return:      true on success, otherwise false
+ */
+bool ksmbd_smb_request(struct ksmbd_conn *conn)
+{
+	int type = *(char *)conn->request_buf;
+
+	switch (type) {
+	case RFC1002_SESSION_MESSAGE:
+		/* Regular SMB request */
+		return true;
+	case RFC1002_SESSION_KEEP_ALIVE:
+		ksmbd_debug(SMB, "RFC 1002 session keep alive\n");
+		break;
+	default:
+		ksmbd_debug(SMB, "RFC 1002 unknown request type 0x%x\n", type);
+	}
+
+	return false;
+}
+
+static bool supported_protocol(int idx)
+{
+	if (idx == SMB2X_PROT &&
+	    (server_conf.min_protocol >= SMB21_PROT ||
+	     server_conf.max_protocol <= SMB311_PROT))
+		return true;
+
+	return (server_conf.min_protocol <= idx &&
+		idx <= server_conf.max_protocol);
+}
+
+static char *next_dialect(char *dialect, int *next_off)
+{
+	dialect = dialect + *next_off;
+	*next_off = strlen(dialect);
+	return dialect;
+}
+
+static int ksmbd_lookup_dialect_by_name(char *cli_dialects, __le16 byte_count)
+{
+	int i, seq_num, bcount, next;
+	char *dialect;
+
+	for (i = ARRAY_SIZE(smb_protos) - 1; i >= 0; i--) {
+		seq_num = 0;
+		next = 0;
+		dialect = cli_dialects;
+		bcount = le16_to_cpu(byte_count);
+		do {
+			dialect = next_dialect(dialect, &next);
+			ksmbd_debug(SMB, "client requested dialect %s\n",
+				    dialect);
+			if (!strcmp(dialect, smb_protos[i].name)) {
+				if (supported_protocol(smb_protos[i].index)) {
+					ksmbd_debug(SMB,
+						    "selected %s dialect\n",
+						    smb_protos[i].name);
+					if (smb_protos[i].index == SMB1_PROT)
+						return seq_num;
+					return smb_protos[i].prot_id;
+				}
+			}
+			seq_num++;
+			bcount -= (++next);
+		} while (bcount > 0);
+	}
+
+	return BAD_PROT_ID;
+}
+
+int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count)
+{
+	int i;
+	int count;
+
+	for (i = ARRAY_SIZE(smb_protos) - 1; i >= 0; i--) {
+		count = le16_to_cpu(dialects_count);
+		while (--count >= 0) {
+			ksmbd_debug(SMB, "client requested dialect 0x%x\n",
+				    le16_to_cpu(cli_dialects[count]));
+			if (le16_to_cpu(cli_dialects[count]) !=
+					smb_protos[i].prot_id)
+				continue;
+
+			if (supported_protocol(smb_protos[i].index)) {
+				ksmbd_debug(SMB, "selected %s dialect\n",
+					    smb_protos[i].name);
+				return smb_protos[i].prot_id;
+			}
+		}
+	}
+
+	return BAD_PROT_ID;
+}
+
+int ksmbd_negotiate_smb_dialect(void *buf)
+{
+	__le32 proto;
+
+	proto = ((struct smb2_hdr *)buf)->ProtocolId;
+	if (proto == SMB2_PROTO_NUMBER) {
+		struct smb2_negotiate_req *req;
+
+		req = (struct smb2_negotiate_req *)buf;
+		return ksmbd_lookup_dialect_by_id(req->Dialects,
+						  req->DialectCount);
+	}
+
+	proto = *(__le32 *)((struct smb_hdr *)buf)->Protocol;
+	if (proto == SMB1_PROTO_NUMBER) {
+		struct smb_negotiate_req *req;
+
+		req = (struct smb_negotiate_req *)buf;
+		return ksmbd_lookup_dialect_by_name(req->DialectsArray,
+						    req->ByteCount);
+	}
+
+	return BAD_PROT_ID;
+}
+
+#define SMB_COM_NEGOTIATE	0x72
+int ksmbd_init_smb_server(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+
+	if (conn->need_neg == false)
+		return 0;
+
+	init_smb3_11_server(conn);
+
+	if (conn->ops->get_cmd_val(work) != SMB_COM_NEGOTIATE)
+		conn->need_neg = false;
+	return 0;
+}
+
+bool ksmbd_pdu_size_has_room(unsigned int pdu)
+{
+	return (pdu >= KSMBD_MIN_SUPPORTED_HEADER_SIZE - 4);
+}
+
+int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work, int info_level,
+				      struct ksmbd_file *dir,
+				      struct ksmbd_dir_info *d_info,
+				      char *search_pattern,
+				      int (*fn)(struct ksmbd_conn *, int,
+						struct ksmbd_dir_info *,
+						struct user_namespace *,
+						struct ksmbd_kstat *))
+{
+	int i, rc = 0;
+	struct ksmbd_conn *conn = work->conn;
+	struct user_namespace *user_ns = file_mnt_user_ns(dir->filp);
+
+	for (i = 0; i < 2; i++) {
+		struct kstat kstat;
+		struct ksmbd_kstat ksmbd_kstat;
+
+		if (!dir->dot_dotdot[i]) { /* fill dot entry info */
+			if (i == 0) {
+				d_info->name = ".";
+				d_info->name_len = 1;
+			} else {
+				d_info->name = "..";
+				d_info->name_len = 2;
+			}
+
+			if (!match_pattern(d_info->name, d_info->name_len,
+					   search_pattern)) {
+				dir->dot_dotdot[i] = 1;
+				continue;
+			}
+
+			ksmbd_kstat.kstat = &kstat;
+			ksmbd_vfs_fill_dentry_attrs(work,
+						    user_ns,
+						    dir->filp->f_path.dentry->d_parent,
+						    &ksmbd_kstat);
+			rc = fn(conn, info_level, d_info,
+				user_ns, &ksmbd_kstat);
+			if (rc)
+				break;
+			if (d_info->out_buf_len <= 0)
+				break;
+
+			dir->dot_dotdot[i] = 1;
+			if (d_info->flags & SMB2_RETURN_SINGLE_ENTRY) {
+				d_info->out_buf_len = 0;
+				break;
+			}
+		}
+	}
+
+	return rc;
+}
+
+/**
+ * ksmbd_extract_shortname() - get shortname from long filename
+ * @conn:	connection instance
+ * @longname:	source long filename
+ * @shortname:	destination short filename
+ *
+ * Return:	shortname length or 0 when source long name is '.' or '..'
+ * TODO: Though this function comforms the restriction of 8.3 Filename spec,
+ * but the result is different with Windows 7's one. need to check.
+ */
+int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
+			    char *shortname)
+{
+	const char *p;
+	char base[9], extension[4];
+	char out[13] = {0};
+	int baselen = 0;
+	int extlen = 0, len = 0;
+	unsigned int csum = 0;
+	const unsigned char *ptr;
+	bool dot_present = true;
+
+	p = longname;
+	if ((*p == '.') || (!(strcmp(p, "..")))) {
+		/*no mangling required */
+		return 0;
+	}
+
+	p = strrchr(longname, '.');
+	if (p == longname) { /*name starts with a dot*/
+		strscpy(extension, "___", strlen("___"));
+	} else {
+		if (p) {
+			p++;
+			while (*p && extlen < 3) {
+				if (*p != '.')
+					extension[extlen++] = toupper(*p);
+				p++;
+			}
+			extension[extlen] = '\0';
+		} else {
+			dot_present = false;
+		}
+	}
+
+	p = longname;
+	if (*p == '.') {
+		p++;
+		longname++;
+	}
+	while (*p && (baselen < 5)) {
+		if (*p != '.')
+			base[baselen++] = toupper(*p);
+		p++;
+	}
+
+	base[baselen] = MAGIC_CHAR;
+	memcpy(out, base, baselen + 1);
+
+	ptr = longname;
+	len = strlen(longname);
+	for (; len > 0; len--, ptr++)
+		csum += *ptr;
+
+	csum = csum % (MANGLE_BASE * MANGLE_BASE);
+	out[baselen + 1] = mangle(csum / MANGLE_BASE);
+	out[baselen + 2] = mangle(csum);
+	out[baselen + 3] = PERIOD;
+
+	if (dot_present)
+		memcpy(&out[baselen + 4], extension, 4);
+	else
+		out[baselen + 4] = '\0';
+	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
+			  conn->local_nls, 0);
+	len = strlen(out) * 2;
+	return len;
+}
+
+static int __smb2_negotiate(struct ksmbd_conn *conn)
+{
+	return (conn->dialect >= SMB20_PROT_ID &&
+		conn->dialect <= SMB311_PROT_ID);
+}
+
+static int smb_handle_negotiate(struct ksmbd_work *work)
+{
+	struct smb_negotiate_rsp *neg_rsp = work->response_buf;
+
+	ksmbd_debug(SMB, "Unsupported SMB protocol\n");
+	neg_rsp->hdr.Status.CifsError = STATUS_INVALID_LOGON_TYPE;
+	return -EINVAL;
+}
+
+int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
+{
+	struct ksmbd_conn *conn = work->conn;
+	int ret;
+
+	conn->dialect = ksmbd_negotiate_smb_dialect(work->request_buf);
+	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
+
+	if (command == SMB2_NEGOTIATE_HE) {
+		struct smb2_hdr *smb2_hdr = work->request_buf;
+
+		if (smb2_hdr->ProtocolId != SMB2_PROTO_NUMBER) {
+			ksmbd_debug(SMB, "Downgrade to SMB1 negotiation\n");
+			command = SMB_COM_NEGOTIATE;
+		}
+	}
+
+	if (command == SMB2_NEGOTIATE_HE) {
+		ret = smb2_handle_negotiate(work);
+		init_smb2_neg_rsp(work);
+		return ret;
+	}
+
+	if (command == SMB_COM_NEGOTIATE) {
+		if (__smb2_negotiate(conn)) {
+			conn->need_neg = true;
+			init_smb3_11_server(conn);
+			init_smb2_neg_rsp(work);
+			ksmbd_debug(SMB, "Upgrade to SMB2 negotiation\n");
+			return 0;
+		}
+		return smb_handle_negotiate(work);
+	}
+
+	pr_err("Unknown SMB negotiation command: %u\n", command);
+	return -EINVAL;
+}
+
+enum SHARED_MODE_ERRORS {
+	SHARE_DELETE_ERROR,
+	SHARE_READ_ERROR,
+	SHARE_WRITE_ERROR,
+	FILE_READ_ERROR,
+	FILE_WRITE_ERROR,
+	FILE_DELETE_ERROR,
+};
+
+static const char * const shared_mode_errors[] = {
+	"Current access mode does not permit SHARE_DELETE",
+	"Current access mode does not permit SHARE_READ",
+	"Current access mode does not permit SHARE_WRITE",
+	"Desired access mode does not permit FILE_READ",
+	"Desired access mode does not permit FILE_WRITE",
+	"Desired access mode does not permit FILE_DELETE",
+};
+
+static void smb_shared_mode_error(int error, struct ksmbd_file *prev_fp,
+				  struct ksmbd_file *curr_fp)
+{
+	ksmbd_debug(SMB, "%s\n", shared_mode_errors[error]);
+	ksmbd_debug(SMB, "Current mode: 0x%x Desired mode: 0x%x\n",
+		    prev_fp->saccess, curr_fp->daccess);
+}
+
+int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
+{
+	int rc = 0;
+	struct ksmbd_file *prev_fp;
+
+	/*
+	 * Lookup fp in master fp list, and check desired access and
+	 * shared mode between previous open and current open.
+	 */
+	read_lock(&curr_fp->f_ci->m_lock);
+	list_for_each_entry(prev_fp, &curr_fp->f_ci->m_fp_list, node) {
+		if (file_inode(filp) != file_inode(prev_fp->filp))
+			continue;
+
+		if (filp == prev_fp->filp)
+			continue;
+
+		if (ksmbd_stream_fd(prev_fp) && ksmbd_stream_fd(curr_fp))
+			if (strcmp(prev_fp->stream.name, curr_fp->stream.name))
+				continue;
+
+		if (prev_fp->attrib_only != curr_fp->attrib_only)
+			continue;
+
+		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE) &&
+		    curr_fp->daccess & FILE_DELETE_LE) {
+			smb_shared_mode_error(SHARE_DELETE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		/*
+		 * Only check FILE_SHARE_DELETE if stream opened and
+		 * normal file opened.
+		 */
+		if (ksmbd_stream_fd(prev_fp) && !ksmbd_stream_fd(curr_fp))
+			continue;
+
+		if (!(prev_fp->saccess & FILE_SHARE_READ_LE) &&
+		    curr_fp->daccess & (FILE_EXECUTE_LE | FILE_READ_DATA_LE)) {
+			smb_shared_mode_error(SHARE_READ_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (!(prev_fp->saccess & FILE_SHARE_WRITE_LE) &&
+		    curr_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
+			smb_shared_mode_error(SHARE_WRITE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & (FILE_EXECUTE_LE | FILE_READ_DATA_LE) &&
+		    !(curr_fp->saccess & FILE_SHARE_READ_LE)) {
+			smb_shared_mode_error(FILE_READ_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE) &&
+		    !(curr_fp->saccess & FILE_SHARE_WRITE_LE)) {
+			smb_shared_mode_error(FILE_WRITE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & FILE_DELETE_LE &&
+		    !(curr_fp->saccess & FILE_SHARE_DELETE_LE)) {
+			smb_shared_mode_error(FILE_DELETE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+	}
+	read_unlock(&curr_fp->f_ci->m_lock);
+
+	return rc;
+}
+
+bool is_asterisk(char *p)
+{
+	return p && p[0] == '*';
+}
+
+int ksmbd_override_fsids(struct ksmbd_work *work)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_share_config *share = work->tcon->share_conf;
+	struct cred *cred;
+	struct group_info *gi;
+	unsigned int uid;
+	unsigned int gid;
+
+	uid = user_uid(sess->user);
+	gid = user_gid(sess->user);
+	if (share->force_uid != KSMBD_SHARE_INVALID_UID)
+		uid = share->force_uid;
+	if (share->force_gid != KSMBD_SHARE_INVALID_GID)
+		gid = share->force_gid;
+
+	cred = prepare_kernel_cred(NULL);
+	if (!cred)
+		return -ENOMEM;
+
+	cred->fsuid = make_kuid(current_user_ns(), uid);
+	cred->fsgid = make_kgid(current_user_ns(), gid);
+
+	gi = groups_alloc(0);
+	if (!gi) {
+		abort_creds(cred);
+		return -ENOMEM;
+	}
+	set_groups(cred, gi);
+	put_group_info(gi);
+
+	if (!uid_eq(cred->fsuid, GLOBAL_ROOT_UID))
+		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
+
+	WARN_ON(work->saved_cred);
+	work->saved_cred = override_creds(cred);
+	if (!work->saved_cred) {
+		abort_creds(cred);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+void ksmbd_revert_fsids(struct ksmbd_work *work)
+{
+	const struct cred *cred;
+
+	WARN_ON(!work->saved_cred);
+
+	cred = current_cred();
+	revert_creds(work->saved_cred);
+	put_cred(cred);
+	work->saved_cred = NULL;
+}
+
+__le32 smb_map_generic_desired_access(__le32 daccess)
+{
+	if (daccess & FILE_GENERIC_READ_LE) {
+		daccess |= cpu_to_le32(GENERIC_READ_FLAGS);
+		daccess &= ~FILE_GENERIC_READ_LE;
+	}
+
+	if (daccess & FILE_GENERIC_WRITE_LE) {
+		daccess |= cpu_to_le32(GENERIC_WRITE_FLAGS);
+		daccess &= ~FILE_GENERIC_WRITE_LE;
+	}
+
+	if (daccess & FILE_GENERIC_EXECUTE_LE) {
+		daccess |= cpu_to_le32(GENERIC_EXECUTE_FLAGS);
+		daccess &= ~FILE_GENERIC_EXECUTE_LE;
+	}
+
+	if (daccess & FILE_GENERIC_ALL_LE) {
+		daccess |= cpu_to_le32(GENERIC_ALL_FLAGS);
+		daccess &= ~FILE_GENERIC_ALL_LE;
+	}
+
+	return daccess;
+}
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
new file mode 100644
index 000000000000..b8c350725905
--- /dev/null
+++ b/fs/ksmbd/smb_common.h
@@ -0,0 +1,543 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SMB_COMMON_H__
+#define __SMB_COMMON_H__
+
+#include <linux/kernel.h>
+
+#include "glob.h"
+#include "nterr.h"
+#include "smb2pdu.h"
+
+/* ksmbd's Specific ERRNO */
+#define ESHARE			50000
+
+#define SMB1_PROT		0
+#define SMB2_PROT		1
+#define SMB21_PROT		2
+/* multi-protocol negotiate request */
+#define SMB2X_PROT		3
+#define SMB30_PROT		4
+#define SMB302_PROT		5
+#define SMB311_PROT		6
+#define BAD_PROT		0xFFFF
+
+#define SMB1_VERSION_STRING	"1.0"
+#define SMB20_VERSION_STRING	"2.0"
+#define SMB21_VERSION_STRING	"2.1"
+#define SMB30_VERSION_STRING	"3.0"
+#define SMB302_VERSION_STRING	"3.02"
+#define SMB311_VERSION_STRING	"3.1.1"
+
+/* Dialects */
+#define SMB10_PROT_ID		0x00
+#define SMB20_PROT_ID		0x0202
+#define SMB21_PROT_ID		0x0210
+/* multi-protocol negotiate request */
+#define SMB2X_PROT_ID		0x02FF
+#define SMB30_PROT_ID		0x0300
+#define SMB302_PROT_ID		0x0302
+#define SMB311_PROT_ID		0x0311
+#define BAD_PROT_ID		0xFFFF
+
+#define SMB_ECHO_INTERVAL	(60 * HZ)
+
+#define CIFS_DEFAULT_IOSIZE	(64 * 1024)
+#define MAX_CIFS_SMALL_BUFFER_SIZE 448 /* big enough for most */
+
+/* RFC 1002 session packet types */
+#define RFC1002_SESSION_MESSAGE			0x00
+#define RFC1002_SESSION_REQUEST			0x81
+#define RFC1002_POSITIVE_SESSION_RESPONSE	0x82
+#define RFC1002_NEGATIVE_SESSION_RESPONSE	0x83
+#define RFC1002_RETARGET_SESSION_RESPONSE	0x84
+#define RFC1002_SESSION_KEEP_ALIVE		0x85
+
+/* Responses when opening a file. */
+#define F_SUPERSEDED	0
+#define F_OPENED	1
+#define F_CREATED	2
+#define F_OVERWRITTEN	3
+
+/*
+ * File Attribute flags
+ */
+#define ATTR_READONLY			0x0001
+#define ATTR_HIDDEN			0x0002
+#define ATTR_SYSTEM			0x0004
+#define ATTR_VOLUME			0x0008
+#define ATTR_DIRECTORY			0x0010
+#define ATTR_ARCHIVE			0x0020
+#define ATTR_DEVICE			0x0040
+#define ATTR_NORMAL			0x0080
+#define ATTR_TEMPORARY			0x0100
+#define ATTR_SPARSE			0x0200
+#define ATTR_REPARSE			0x0400
+#define ATTR_COMPRESSED			0x0800
+#define ATTR_OFFLINE			0x1000
+#define ATTR_NOT_CONTENT_INDEXED	0x2000
+#define ATTR_ENCRYPTED			0x4000
+#define ATTR_POSIX_SEMANTICS		0x01000000
+#define ATTR_BACKUP_SEMANTICS		0x02000000
+#define ATTR_DELETE_ON_CLOSE		0x04000000
+#define ATTR_SEQUENTIAL_SCAN		0x08000000
+#define ATTR_RANDOM_ACCESS		0x10000000
+#define ATTR_NO_BUFFERING		0x20000000
+#define ATTR_WRITE_THROUGH		0x80000000
+
+#define ATTR_READONLY_LE		cpu_to_le32(ATTR_READONLY)
+#define ATTR_HIDDEN_LE			cpu_to_le32(ATTR_HIDDEN)
+#define ATTR_SYSTEM_LE			cpu_to_le32(ATTR_SYSTEM)
+#define ATTR_DIRECTORY_LE		cpu_to_le32(ATTR_DIRECTORY)
+#define ATTR_ARCHIVE_LE			cpu_to_le32(ATTR_ARCHIVE)
+#define ATTR_NORMAL_LE			cpu_to_le32(ATTR_NORMAL)
+#define ATTR_TEMPORARY_LE		cpu_to_le32(ATTR_TEMPORARY)
+#define ATTR_SPARSE_FILE_LE		cpu_to_le32(ATTR_SPARSE)
+#define ATTR_REPARSE_POINT_LE		cpu_to_le32(ATTR_REPARSE)
+#define ATTR_COMPRESSED_LE		cpu_to_le32(ATTR_COMPRESSED)
+#define ATTR_OFFLINE_LE			cpu_to_le32(ATTR_OFFLINE)
+#define ATTR_NOT_CONTENT_INDEXED_LE	cpu_to_le32(ATTR_NOT_CONTENT_INDEXED)
+#define ATTR_ENCRYPTED_LE		cpu_to_le32(ATTR_ENCRYPTED)
+#define ATTR_INTEGRITY_STREAML_LE	cpu_to_le32(0x00008000)
+#define ATTR_NO_SCRUB_DATA_LE		cpu_to_le32(0x00020000)
+#define ATTR_MASK_LE			cpu_to_le32(0x00007FB7)
+
+/* List of FileSystemAttributes - see 2.5.1 of MS-FSCC */
+#define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
+#define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
+#define FILE_SUPPORT_INTEGRITY_STREAMS	0x04000000
+#define FILE_SUPPORTS_USN_JOURNAL	0x02000000
+#define FILE_SUPPORTS_OPEN_BY_FILE_ID	0x01000000
+#define FILE_SUPPORTS_EXTENDED_ATTRIBUTES 0x00800000
+#define FILE_SUPPORTS_HARD_LINKS	0x00400000
+#define FILE_SUPPORTS_TRANSACTIONS	0x00200000
+#define FILE_SEQUENTIAL_WRITE_ONCE	0x00100000
+#define FILE_READ_ONLY_VOLUME		0x00080000
+#define FILE_NAMED_STREAMS		0x00040000
+#define FILE_SUPPORTS_ENCRYPTION	0x00020000
+#define FILE_SUPPORTS_OBJECT_IDS	0x00010000
+#define FILE_VOLUME_IS_COMPRESSED	0x00008000
+#define FILE_SUPPORTS_REMOTE_STORAGE	0x00000100
+#define FILE_SUPPORTS_REPARSE_POINTS	0x00000080
+#define FILE_SUPPORTS_SPARSE_FILES	0x00000040
+#define FILE_VOLUME_QUOTAS		0x00000020
+#define FILE_FILE_COMPRESSION		0x00000010
+#define FILE_PERSISTENT_ACLS		0x00000008
+#define FILE_UNICODE_ON_DISK		0x00000004
+#define FILE_CASE_PRESERVED_NAMES	0x00000002
+#define FILE_CASE_SENSITIVE_SEARCH	0x00000001
+
+#define FILE_READ_DATA        0x00000001  /* Data can be read from the file   */
+#define FILE_WRITE_DATA       0x00000002  /* Data can be written to the file  */
+#define FILE_APPEND_DATA      0x00000004  /* Data can be appended to the file */
+#define FILE_READ_EA          0x00000008  /* Extended attributes associated   */
+/* with the file can be read        */
+#define FILE_WRITE_EA         0x00000010  /* Extended attributes associated   */
+/* with the file can be written     */
+#define FILE_EXECUTE          0x00000020  /*Data can be read into memory from */
+/* the file using system paging I/O */
+#define FILE_DELETE_CHILD     0x00000040
+#define FILE_READ_ATTRIBUTES  0x00000080  /* Attributes associated with the   */
+/* file can be read                 */
+#define FILE_WRITE_ATTRIBUTES 0x00000100  /* Attributes associated with the   */
+/* file can be written              */
+#define DELETE                0x00010000  /* The file can be deleted          */
+#define READ_CONTROL          0x00020000  /* The access control list and      */
+/* ownership associated with the    */
+/* file can be read                 */
+#define WRITE_DAC             0x00040000  /* The access control list and      */
+/* ownership associated with the    */
+/* file can be written.             */
+#define WRITE_OWNER           0x00080000  /* Ownership information associated */
+/* with the file can be written     */
+#define SYNCHRONIZE           0x00100000  /* The file handle can waited on to */
+/* synchronize with the completion  */
+/* of an input/output request       */
+#define GENERIC_ALL           0x10000000
+#define GENERIC_EXECUTE       0x20000000
+#define GENERIC_WRITE         0x40000000
+#define GENERIC_READ          0x80000000
+/* In summary - Relevant file       */
+/* access flags from CIFS are       */
+/* file_read_data, file_write_data  */
+/* file_execute, file_read_attributes*/
+/* write_dac, and delete.           */
+
+#define FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_READ_ATTRIBUTES)
+#define FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
+		| FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES)
+#define FILE_EXEC_RIGHTS (FILE_EXECUTE)
+
+#define SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
+		| FILE_READ_ATTRIBUTES \
+		| DELETE | READ_CONTROL | WRITE_DAC \
+		| WRITE_OWNER | SYNCHRONIZE)
+#define SET_FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
+		| FILE_WRITE_EA \
+		| FILE_DELETE_CHILD \
+		| FILE_WRITE_ATTRIBUTES \
+		| DELETE | READ_CONTROL | WRITE_DAC \
+		| WRITE_OWNER | SYNCHRONIZE)
+#define SET_FILE_EXEC_RIGHTS (FILE_READ_EA | FILE_WRITE_EA | FILE_EXECUTE \
+		| FILE_READ_ATTRIBUTES \
+		| FILE_WRITE_ATTRIBUTES \
+		| DELETE | READ_CONTROL | WRITE_DAC \
+		| WRITE_OWNER | SYNCHRONIZE)
+
+#define SET_MINIMUM_RIGHTS (FILE_READ_EA | FILE_READ_ATTRIBUTES \
+		| READ_CONTROL | SYNCHRONIZE)
+
+/* generic flags for file open */
+#define GENERIC_READ_FLAGS	(READ_CONTROL | FILE_READ_DATA | \
+		FILE_READ_ATTRIBUTES | \
+		FILE_READ_EA | SYNCHRONIZE)
+
+#define GENERIC_WRITE_FLAGS	(READ_CONTROL | FILE_WRITE_DATA | \
+		FILE_WRITE_ATTRIBUTES | FILE_WRITE_EA | \
+		FILE_APPEND_DATA | SYNCHRONIZE)
+
+#define GENERIC_EXECUTE_FLAGS	(READ_CONTROL | FILE_EXECUTE | \
+		FILE_READ_ATTRIBUTES | SYNCHRONIZE)
+
+#define GENERIC_ALL_FLAGS	(DELETE | READ_CONTROL | WRITE_DAC | \
+		WRITE_OWNER | SYNCHRONIZE | FILE_READ_DATA | \
+		FILE_WRITE_DATA | FILE_APPEND_DATA | \
+		FILE_READ_EA | FILE_WRITE_EA | \
+		FILE_EXECUTE | FILE_DELETE_CHILD | \
+		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
+
+#define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
+
+#define SMB1_CLIENT_GUID_SIZE		(16)
+struct smb_hdr {
+	__be32 smb_buf_length;
+	__u8 Protocol[4];
+	__u8 Command;
+	union {
+		struct {
+			__u8 ErrorClass;
+			__u8 Reserved;
+			__le16 Error;
+		} __packed DosError;
+		__le32 CifsError;
+	} __packed Status;
+	__u8 Flags;
+	__le16 Flags2;          /* note: le */
+	__le16 PidHigh;
+	union {
+		struct {
+			__le32 SequenceNumber;  /* le */
+			__u32 Reserved; /* zero */
+		} __packed Sequence;
+		__u8 SecuritySignature[8];      /* le */
+	} __packed Signature;
+	__u8 pad[2];
+	__le16 Tid;
+	__le16 Pid;
+	__le16 Uid;
+	__le16 Mid;
+	__u8 WordCount;
+} __packed;
+
+struct smb_negotiate_req {
+	struct smb_hdr hdr;     /* wct = 0 */
+	__le16 ByteCount;
+	unsigned char DialectsArray[1];
+} __packed;
+
+struct smb_negotiate_rsp {
+	struct smb_hdr hdr;     /* wct = 17 */
+	__le16 DialectIndex; /* 0xFFFF = no dialect acceptable */
+	__u8 SecurityMode;
+	__le16 MaxMpxCount;
+	__le16 MaxNumberVcs;
+	__le32 MaxBufferSize;
+	__le32 MaxRawSize;
+	__le32 SessionKey;
+	__le32 Capabilities;    /* see below */
+	__le32 SystemTimeLow;
+	__le32 SystemTimeHigh;
+	__le16 ServerTimeZone;
+	__u8 EncryptionKeyLength;
+	__le16 ByteCount;
+	union {
+		unsigned char EncryptionKey[8]; /* cap extended security off */
+		/* followed by Domain name - if extended security is off */
+		/* followed by 16 bytes of server GUID */
+		/* then security blob if cap_extended_security negotiated */
+		struct {
+			unsigned char GUID[SMB1_CLIENT_GUID_SIZE];
+			unsigned char SecurityBlob[1];
+		} __packed extended_response;
+	} __packed u;
+} __packed;
+
+struct filesystem_attribute_info {
+	__le32 Attributes;
+	__le32 MaxPathNameComponentLength;
+	__le32 FileSystemNameLen;
+	__le16 FileSystemName[1]; /* do not have to save this - get subset? */
+} __packed;
+
+struct filesystem_device_info {
+	__le32 DeviceType;
+	__le32 DeviceCharacteristics;
+} __packed; /* device info level 0x104 */
+
+struct filesystem_vol_info {
+	__le64 VolumeCreationTime;
+	__le32 SerialNumber;
+	__le32 VolumeLabelSize;
+	__le16 Reserved;
+	__le16 VolumeLabel[1];
+} __packed;
+
+struct filesystem_info {
+	__le64 TotalAllocationUnits;
+	__le64 FreeAllocationUnits;
+	__le32 SectorsPerAllocationUnit;
+	__le32 BytesPerSector;
+} __packed;     /* size info, level 0x103 */
+
+#define EXTENDED_INFO_MAGIC 0x43667364	/* Cfsd */
+#define STRING_LENGTH 28
+
+struct fs_extended_info {
+	__le32 magic;
+	__le32 version;
+	__le32 release;
+	__u64 rel_date;
+	char    version_string[STRING_LENGTH];
+} __packed;
+
+struct object_id_info {
+	char objid[16];
+	struct fs_extended_info extended_info;
+} __packed;
+
+struct file_directory_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	char FileName[1];
+} __packed;   /* level 0x101 FF resp data */
+
+struct file_names_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le32 FileNameLength;
+	char FileName[1];
+} __packed;   /* level 0xc FF resp data */
+
+struct file_full_directory_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	__le32 EaSize;
+	char FileName[1];
+} __packed; /* level 0x102 FF resp */
+
+struct file_both_directory_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	__le32 EaSize; /* length of the xattrs */
+	__u8   ShortNameLength;
+	__u8   Reserved;
+	__u8   ShortName[24];
+	char FileName[1];
+} __packed; /* level 0x104 FFrsp data */
+
+struct file_id_both_directory_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	__le32 EaSize; /* length of the xattrs */
+	__u8   ShortNameLength;
+	__u8   Reserved;
+	__u8   ShortName[24];
+	__le16 Reserved2;
+	__le64 UniqueId;
+	char FileName[1];
+} __packed;
+
+struct file_id_full_dir_info {
+	__le32 NextEntryOffset;
+	__u32 FileIndex;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 ExtFileAttributes;
+	__le32 FileNameLength;
+	__le32 EaSize; /* EA size */
+	__le32 Reserved;
+	__le64 UniqueId; /* inode num - le since Samba puts ino in low 32 bit*/
+	char FileName[1];
+} __packed; /* level 0x105 FF rsp data */
+
+struct smb_version_values {
+	char		*version_string;
+	__u16		protocol_id;
+	__le16		lock_cmd;
+	__u32		capabilities;
+	__u32		max_read_size;
+	__u32		max_write_size;
+	__u32		max_trans_size;
+	__u32		large_lock_type;
+	__u32		exclusive_lock_type;
+	__u32		shared_lock_type;
+	__u32		unlock_lock_type;
+	size_t		header_size;
+	size_t		max_header_size;
+	size_t		read_rsp_size;
+	unsigned int	cap_unix;
+	unsigned int	cap_nt_find;
+	unsigned int	cap_large_files;
+	__u16		signing_enabled;
+	__u16		signing_required;
+	size_t		create_lease_size;
+	size_t		create_durable_size;
+	size_t		create_durable_v2_size;
+	size_t		create_mxac_size;
+	size_t		create_disk_id_size;
+	size_t		create_posix_size;
+};
+
+struct filesystem_posix_info {
+	/* For undefined recommended transfer size return -1 in that field */
+	__le32 OptimalTransferSize;  /* bsize on some os, iosize on other os */
+	__le32 BlockSize;
+	/* The next three fields are in terms of the block size.
+	 * (above). If block size is unknown, 4096 would be a
+	 * reasonable block size for a server to report.
+	 * Note that returning the blocks/blocksavail removes need
+	 * to make a second call (to QFSInfo level 0x103 to get this info.
+	 * UserBlockAvail is typically less than or equal to BlocksAvail,
+	 * if no distinction is made return the same value in each
+	 */
+	__le64 TotalBlocks;
+	__le64 BlocksAvail;       /* bfree */
+	__le64 UserBlocksAvail;   /* bavail */
+	/* For undefined Node fields or FSID return -1 */
+	__le64 TotalFileNodes;
+	__le64 FreeFileNodes;
+	__le64 FileSysIdentifier;   /* fsid */
+	/* NB Namelen comes from FILE_SYSTEM_ATTRIBUTE_INFO call */
+	/* NB flags can come from FILE_SYSTEM_DEVICE_INFO call   */
+} __packed;
+
+struct smb_version_ops {
+	u16 (*get_cmd_val)(struct ksmbd_work *swork);
+	int (*init_rsp_hdr)(struct ksmbd_work *swork);
+	void (*set_rsp_status)(struct ksmbd_work *swork, __le32 err);
+	int (*allocate_rsp_buf)(struct ksmbd_work *work);
+	int (*set_rsp_credits)(struct ksmbd_work *work);
+	int (*check_user_session)(struct ksmbd_work *work);
+	int (*get_ksmbd_tcon)(struct ksmbd_work *work);
+	bool (*is_sign_req)(struct ksmbd_work *work, unsigned int command);
+	int (*check_sign_req)(struct ksmbd_work *work);
+	void (*set_sign_rsp)(struct ksmbd_work *work);
+	int (*generate_signingkey)(struct ksmbd_session *sess, struct ksmbd_conn *conn);
+	int (*generate_encryptionkey)(struct ksmbd_session *sess);
+	int (*is_transform_hdr)(void *buf);
+	int (*decrypt_req)(struct ksmbd_work *work);
+	int (*encrypt_resp)(struct ksmbd_work *work);
+};
+
+struct smb_version_cmds {
+	int (*proc)(struct ksmbd_work *swork);
+};
+
+static inline size_t
+smb2_hdr_size_no_buflen(struct smb_version_values *vals)
+{
+	return vals->header_size - 4;
+}
+
+int ksmbd_min_protocol(void);
+int ksmbd_max_protocol(void);
+
+int ksmbd_lookup_protocol_idx(char *str);
+
+int ksmbd_verify_smb_message(struct ksmbd_work *work);
+bool ksmbd_smb_request(struct ksmbd_conn *conn);
+
+int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count);
+
+int ksmbd_negotiate_smb_dialect(void *buf);
+int ksmbd_init_smb_server(struct ksmbd_work *work);
+
+bool ksmbd_pdu_size_has_room(unsigned int pdu);
+
+struct ksmbd_kstat;
+int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,
+				      int info_level,
+				      struct ksmbd_file *dir,
+				      struct ksmbd_dir_info *d_info,
+				      char *search_pattern,
+				      int (*fn)(struct ksmbd_conn *,
+						int,
+						struct ksmbd_dir_info *,
+						struct user_namespace *,
+						struct ksmbd_kstat *));
+
+int ksmbd_extract_shortname(struct ksmbd_conn *conn,
+			    const char *longname,
+			    char *shortname);
+
+int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
+
+int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
+int ksmbd_override_fsids(struct ksmbd_work *work);
+void ksmbd_revert_fsids(struct ksmbd_work *work);
+
+unsigned int ksmbd_server_side_copy_max_chunk_count(void);
+unsigned int ksmbd_server_side_copy_max_chunk_size(void);
+unsigned int ksmbd_server_side_copy_max_total_size(void);
+bool is_asterisk(char *p);
+__le32 smb_map_generic_desired_access(__le32 daccess);
+
+static inline unsigned int get_rfc1002_len(void *buf)
+{
+	return be32_to_cpu(*((__be32 *)buf)) & 0xffffff;
+}
+
+static inline void inc_rfc1001_len(void *buf, int count)
+{
+	be32_add_cpu((__be32 *)buf, count);
+}
+#endif /* __SMB_COMMON_H__ */
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
new file mode 100644
index 000000000000..fa99d950a6f2
--- /dev/null
+++ b/fs/ksmbd/smbacl.c
@@ -0,0 +1,1344 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/*
+ *   Copyright (C) International Business Machines  Corp., 2007,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *   Copyright (C) 2020 Samsung Electronics Co., Ltd.
+ *   Author(s): Namjae Jeon <linkinjeon@kernel.org>
+ */
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "smbacl.h"
+#include "smb_common.h"
+#include "server.h"
+#include "misc.h"
+#include "mgmt/share_config.h"
+
+static const struct smb_sid domain = {1, 4, {0, 0, 0, 0, 0, 5},
+	{cpu_to_le32(21), cpu_to_le32(1), cpu_to_le32(2), cpu_to_le32(3),
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/* security id for everyone/world system group */
+static const struct smb_sid creator_owner = {
+	1, 1, {0, 0, 0, 0, 0, 3}, {0} };
+/* security id for everyone/world system group */
+static const struct smb_sid creator_group = {
+	1, 1, {0, 0, 0, 0, 0, 3}, {cpu_to_le32(1)} };
+
+/* security id for everyone/world system group */
+static const struct smb_sid sid_everyone = {
+	1, 1, {0, 0, 0, 0, 0, 1}, {0} };
+/* security id for Authenticated Users system group */
+static const struct smb_sid sid_authusers = {
+	1, 1, {0, 0, 0, 0, 0, 5}, {cpu_to_le32(11)} };
+
+/* S-1-22-1 Unmapped Unix users */
+static const struct smb_sid sid_unix_users = {1, 1, {0, 0, 0, 0, 0, 22},
+		{cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/* S-1-22-2 Unmapped Unix groups */
+static const struct smb_sid sid_unix_groups = { 1, 1, {0, 0, 0, 0, 0, 22},
+		{cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/*
+ * See http://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx
+ */
+
+/* S-1-5-88 MS NFS and Apple style UID/GID/mode */
+
+/* S-1-5-88-1 Unix uid */
+static const struct smb_sid sid_unix_NFS_users = { 1, 2, {0, 0, 0, 0, 0, 5},
+	{cpu_to_le32(88),
+	 cpu_to_le32(1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/* S-1-5-88-2 Unix gid */
+static const struct smb_sid sid_unix_NFS_groups = { 1, 2, {0, 0, 0, 0, 0, 5},
+	{cpu_to_le32(88),
+	 cpu_to_le32(2), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/* S-1-5-88-3 Unix mode */
+static const struct smb_sid sid_unix_NFS_mode = { 1, 2, {0, 0, 0, 0, 0, 5},
+	{cpu_to_le32(88),
+	 cpu_to_le32(3), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} };
+
+/*
+ * if the two SIDs (roughly equivalent to a UUID for a user or group) are
+ * the same returns zero, if they do not match returns non-zero.
+ */
+int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
+{
+	int i;
+	int num_subauth, num_sat, num_saw;
+
+	if (!ctsid || !cwsid)
+		return 1;
+
+	/* compare the revision */
+	if (ctsid->revision != cwsid->revision) {
+		if (ctsid->revision > cwsid->revision)
+			return 1;
+		else
+			return -1;
+	}
+
+	/* compare all of the six auth values */
+	for (i = 0; i < NUM_AUTHS; ++i) {
+		if (ctsid->authority[i] != cwsid->authority[i]) {
+			if (ctsid->authority[i] > cwsid->authority[i])
+				return 1;
+			else
+				return -1;
+		}
+	}
+
+	/* compare all of the subauth values if any */
+	num_sat = ctsid->num_subauth;
+	num_saw = cwsid->num_subauth;
+	num_subauth = num_sat < num_saw ? num_sat : num_saw;
+	if (num_subauth) {
+		for (i = 0; i < num_subauth; ++i) {
+			if (ctsid->sub_auth[i] != cwsid->sub_auth[i]) {
+				if (le32_to_cpu(ctsid->sub_auth[i]) >
+				    le32_to_cpu(cwsid->sub_auth[i]))
+					return 1;
+				else
+					return -1;
+			}
+		}
+	}
+
+	return 0; /* sids compare/match */
+}
+
+static void smb_copy_sid(struct smb_sid *dst, const struct smb_sid *src)
+{
+	int i;
+
+	dst->revision = src->revision;
+	dst->num_subauth = min_t(u8, src->num_subauth, SID_MAX_SUB_AUTHORITIES);
+	for (i = 0; i < NUM_AUTHS; ++i)
+		dst->authority[i] = src->authority[i];
+	for (i = 0; i < dst->num_subauth; ++i)
+		dst->sub_auth[i] = src->sub_auth[i];
+}
+
+/*
+ * change posix mode to reflect permissions
+ * pmode is the existing mode (we only want to overwrite part of this
+ * bits to set can be: S_IRWXU, S_IRWXG or S_IRWXO ie 00700 or 00070 or 00007
+ */
+static umode_t access_flags_to_mode(struct smb_fattr *fattr, __le32 ace_flags,
+				    int type)
+{
+	__u32 flags = le32_to_cpu(ace_flags);
+	umode_t mode = 0;
+
+	if (flags & GENERIC_ALL) {
+		mode = 0777;
+		ksmbd_debug(SMB, "all perms\n");
+		return mode;
+	}
+
+	if ((flags & GENERIC_READ) || (flags & FILE_READ_RIGHTS))
+		mode = 0444;
+	if ((flags & GENERIC_WRITE) || (flags & FILE_WRITE_RIGHTS)) {
+		mode |= 0222;
+		if (S_ISDIR(fattr->cf_mode))
+			mode |= 0111;
+	}
+	if ((flags & GENERIC_EXECUTE) || (flags & FILE_EXEC_RIGHTS))
+		mode |= 0111;
+
+	if (type == ACCESS_DENIED_ACE_TYPE || type == ACCESS_DENIED_OBJECT_ACE_TYPE)
+		mode = ~mode;
+
+	ksmbd_debug(SMB, "access flags 0x%x mode now %04o\n", flags, mode);
+
+	return mode;
+}
+
+/*
+ * Generate access flags to reflect permissions mode is the existing mode.
+ * This function is called for every ACE in the DACL whose SID matches
+ * with either owner or group or everyone.
+ */
+static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
+				 __u32 *pace_flags)
+{
+	/* reset access mask */
+	*pace_flags = 0x0;
+
+	/* bits to use are either S_IRWXU or S_IRWXG or S_IRWXO */
+	mode &= bits_to_use;
+
+	/*
+	 * check for R/W/X UGO since we do not know whose flags
+	 * is this but we have cleared all the bits sans RWX for
+	 * either user or group or other as per bits_to_use
+	 */
+	if (mode & 0444)
+		*pace_flags |= SET_FILE_READ_RIGHTS;
+	if (mode & 0222)
+		*pace_flags |= FILE_WRITE_RIGHTS;
+	if (mode & 0111)
+		*pace_flags |= SET_FILE_EXEC_RIGHTS;
+
+	ksmbd_debug(SMB, "mode: %o, access flags now 0x%x\n",
+		    mode, *pace_flags);
+}
+
+static __u16 fill_ace_for_sid(struct smb_ace *pntace,
+			      const struct smb_sid *psid, int type, int flags,
+			      umode_t mode, umode_t bits)
+{
+	int i;
+	__u16 size = 0;
+	__u32 access_req = 0;
+
+	pntace->type = type;
+	pntace->flags = flags;
+	mode_to_access_flags(mode, bits, &access_req);
+	if (!access_req)
+		access_req = SET_MINIMUM_RIGHTS;
+	pntace->access_req = cpu_to_le32(access_req);
+
+	pntace->sid.revision = psid->revision;
+	pntace->sid.num_subauth = psid->num_subauth;
+	for (i = 0; i < NUM_AUTHS; i++)
+		pntace->sid.authority[i] = psid->authority[i];
+	for (i = 0; i < psid->num_subauth; i++)
+		pntace->sid.sub_auth[i] = psid->sub_auth[i];
+
+	size = 1 + 1 + 2 + 4 + 1 + 1 + 6 + (psid->num_subauth * 4);
+	pntace->size = cpu_to_le16(size);
+
+	return size;
+}
+
+void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
+{
+	switch (sidtype) {
+	case SIDOWNER:
+		smb_copy_sid(ssid, &server_conf.domain_sid);
+		break;
+	case SIDUNIX_USER:
+		smb_copy_sid(ssid, &sid_unix_users);
+		break;
+	case SIDUNIX_GROUP:
+		smb_copy_sid(ssid, &sid_unix_groups);
+		break;
+	case SIDCREATOR_OWNER:
+		smb_copy_sid(ssid, &creator_owner);
+		return;
+	case SIDCREATOR_GROUP:
+		smb_copy_sid(ssid, &creator_group);
+		return;
+	case SIDNFS_USER:
+		smb_copy_sid(ssid, &sid_unix_NFS_users);
+		break;
+	case SIDNFS_GROUP:
+		smb_copy_sid(ssid, &sid_unix_NFS_groups);
+		break;
+	case SIDNFS_MODE:
+		smb_copy_sid(ssid, &sid_unix_NFS_mode);
+		break;
+	default:
+		return;
+	}
+
+	/* RID */
+	ssid->sub_auth[ssid->num_subauth] = cpu_to_le32(cid);
+	ssid->num_subauth++;
+}
+
+static int sid_to_id(struct user_namespace *user_ns,
+		     struct smb_sid *psid, uint sidtype,
+		     struct smb_fattr *fattr)
+{
+	int rc = -EINVAL;
+
+	/*
+	 * If we have too many subauthorities, then something is really wrong.
+	 * Just return an error.
+	 */
+	if (unlikely(psid->num_subauth > SID_MAX_SUB_AUTHORITIES)) {
+		pr_err("%s: %u subauthorities is too many!\n",
+		       __func__, psid->num_subauth);
+		return -EIO;
+	}
+
+	if (sidtype == SIDOWNER) {
+		kuid_t uid;
+		uid_t id;
+
+		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
+		if (id > 0) {
+			uid = make_kuid(user_ns, id);
+			if (uid_valid(uid) && kuid_has_mapping(user_ns, uid)) {
+				fattr->cf_uid = uid;
+				rc = 0;
+			}
+		}
+	} else {
+		kgid_t gid;
+		gid_t id;
+
+		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
+		if (id > 0) {
+			gid = make_kgid(user_ns, id);
+			if (gid_valid(gid) && kgid_has_mapping(user_ns, gid)) {
+				fattr->cf_gid = gid;
+				rc = 0;
+			}
+		}
+	}
+
+	return rc;
+}
+
+void posix_state_to_acl(struct posix_acl_state *state,
+			struct posix_acl_entry *pace)
+{
+	int i;
+
+	pace->e_tag = ACL_USER_OBJ;
+	pace->e_perm = state->owner.allow;
+	for (i = 0; i < state->users->n; i++) {
+		pace++;
+		pace->e_tag = ACL_USER;
+		pace->e_uid = state->users->aces[i].uid;
+		pace->e_perm = state->users->aces[i].perms.allow;
+	}
+
+	pace++;
+	pace->e_tag = ACL_GROUP_OBJ;
+	pace->e_perm = state->group.allow;
+
+	for (i = 0; i < state->groups->n; i++) {
+		pace++;
+		pace->e_tag = ACL_GROUP;
+		pace->e_gid = state->groups->aces[i].gid;
+		pace->e_perm = state->groups->aces[i].perms.allow;
+	}
+
+	if (state->users->n || state->groups->n) {
+		pace++;
+		pace->e_tag = ACL_MASK;
+		pace->e_perm = state->mask.allow;
+	}
+
+	pace++;
+	pace->e_tag = ACL_OTHER;
+	pace->e_perm = state->other.allow;
+}
+
+int init_acl_state(struct posix_acl_state *state, int cnt)
+{
+	int alloc;
+
+	memset(state, 0, sizeof(struct posix_acl_state));
+	/*
+	 * In the worst case, each individual acl could be for a distinct
+	 * named user or group, but we don't know which, so we allocate
+	 * enough space for either:
+	 */
+	alloc = sizeof(struct posix_ace_state_array)
+		+ cnt * sizeof(struct posix_user_ace_state);
+	state->users = kzalloc(alloc, GFP_KERNEL);
+	if (!state->users)
+		return -ENOMEM;
+	state->groups = kzalloc(alloc, GFP_KERNEL);
+	if (!state->groups) {
+		kfree(state->users);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+void free_acl_state(struct posix_acl_state *state)
+{
+	kfree(state->users);
+	kfree(state->groups);
+}
+
+static void parse_dacl(struct user_namespace *user_ns,
+		       struct smb_acl *pdacl, char *end_of_acl,
+		       struct smb_sid *pownersid, struct smb_sid *pgrpsid,
+		       struct smb_fattr *fattr)
+{
+	int i, ret;
+	int num_aces = 0;
+	int acl_size;
+	char *acl_base;
+	struct smb_ace **ppace;
+	struct posix_acl_entry *cf_pace, *cf_pdace;
+	struct posix_acl_state acl_state, default_acl_state;
+	umode_t mode = 0, acl_mode;
+	bool owner_found = false, group_found = false, others_found = false;
+
+	if (!pdacl)
+		return;
+
+	/* validate that we do not go past end of acl */
+	if (end_of_acl <= (char *)pdacl ||
+	    end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size)) {
+		pr_err("ACL too small to parse DACL\n");
+		return;
+	}
+
+	ksmbd_debug(SMB, "DACL revision %d size %d num aces %d\n",
+		    le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
+		    le32_to_cpu(pdacl->num_aces));
+
+	acl_base = (char *)pdacl;
+	acl_size = sizeof(struct smb_acl);
+
+	num_aces = le32_to_cpu(pdacl->num_aces);
+	if (num_aces <= 0)
+		return;
+
+	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
+		return;
+
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	if (!ppace)
+		return;
+
+	ret = init_acl_state(&acl_state, num_aces);
+	if (ret)
+		return;
+	ret = init_acl_state(&default_acl_state, num_aces);
+	if (ret) {
+		free_acl_state(&acl_state);
+		return;
+	}
+
+	/*
+	 * reset rwx permissions for user/group/other.
+	 * Also, if num_aces is 0 i.e. DACL has no ACEs,
+	 * user/group/other have no permissions
+	 */
+	for (i = 0; i < num_aces; ++i) {
+		ppace[i] = (struct smb_ace *)(acl_base + acl_size);
+		acl_base = (char *)ppace[i];
+		acl_size = le16_to_cpu(ppace[i]->size);
+		ppace[i]->access_req =
+			smb_map_generic_desired_access(ppace[i]->access_req);
+
+		if (!(compare_sids(&ppace[i]->sid, &sid_unix_NFS_mode))) {
+			fattr->cf_mode =
+				le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+			break;
+		} else if (!compare_sids(&ppace[i]->sid, pownersid)) {
+			acl_mode = access_flags_to_mode(fattr,
+							ppace[i]->access_req,
+							ppace[i]->type);
+			acl_mode &= 0700;
+
+			if (!owner_found) {
+				mode &= ~(0700);
+				mode |= acl_mode;
+			}
+			owner_found = true;
+		} else if (!compare_sids(&ppace[i]->sid, pgrpsid) ||
+			   ppace[i]->sid.sub_auth[ppace[i]->sid.num_subauth - 1] ==
+			    DOMAIN_USER_RID_LE) {
+			acl_mode = access_flags_to_mode(fattr,
+							ppace[i]->access_req,
+							ppace[i]->type);
+			acl_mode &= 0070;
+			if (!group_found) {
+				mode &= ~(0070);
+				mode |= acl_mode;
+			}
+			group_found = true;
+		} else if (!compare_sids(&ppace[i]->sid, &sid_everyone)) {
+			acl_mode = access_flags_to_mode(fattr,
+							ppace[i]->access_req,
+							ppace[i]->type);
+			acl_mode &= 0007;
+			if (!others_found) {
+				mode &= ~(0007);
+				mode |= acl_mode;
+			}
+			others_found = true;
+		} else if (!compare_sids(&ppace[i]->sid, &creator_owner)) {
+			continue;
+		} else if (!compare_sids(&ppace[i]->sid, &creator_group)) {
+			continue;
+		} else if (!compare_sids(&ppace[i]->sid, &sid_authusers)) {
+			continue;
+		} else {
+			struct smb_fattr temp_fattr;
+
+			acl_mode = access_flags_to_mode(fattr, ppace[i]->access_req,
+							ppace[i]->type);
+			temp_fattr.cf_uid = INVALID_UID;
+			ret = sid_to_id(user_ns, &ppace[i]->sid, SIDOWNER, &temp_fattr);
+			if (ret || uid_eq(temp_fattr.cf_uid, INVALID_UID)) {
+				pr_err("%s: Error %d mapping Owner SID to uid\n",
+				       __func__, ret);
+				continue;
+			}
+
+			acl_state.owner.allow = ((acl_mode & 0700) >> 6) | 0004;
+			acl_state.users->aces[acl_state.users->n].uid =
+				temp_fattr.cf_uid;
+			acl_state.users->aces[acl_state.users->n++].perms.allow =
+				((acl_mode & 0700) >> 6) | 0004;
+			default_acl_state.owner.allow = ((acl_mode & 0700) >> 6) | 0004;
+			default_acl_state.users->aces[default_acl_state.users->n].uid =
+				temp_fattr.cf_uid;
+			default_acl_state.users->aces[default_acl_state.users->n++].perms.allow =
+				((acl_mode & 0700) >> 6) | 0004;
+		}
+	}
+	kfree(ppace);
+
+	if (owner_found) {
+		/* The owner must be set to at least read-only. */
+		acl_state.owner.allow = ((mode & 0700) >> 6) | 0004;
+		acl_state.users->aces[acl_state.users->n].uid = fattr->cf_uid;
+		acl_state.users->aces[acl_state.users->n++].perms.allow =
+			((mode & 0700) >> 6) | 0004;
+		default_acl_state.owner.allow = ((mode & 0700) >> 6) | 0004;
+		default_acl_state.users->aces[default_acl_state.users->n].uid =
+			fattr->cf_uid;
+		default_acl_state.users->aces[default_acl_state.users->n++].perms.allow =
+			((mode & 0700) >> 6) | 0004;
+	}
+
+	if (group_found) {
+		acl_state.group.allow = (mode & 0070) >> 3;
+		acl_state.groups->aces[acl_state.groups->n].gid =
+			fattr->cf_gid;
+		acl_state.groups->aces[acl_state.groups->n++].perms.allow =
+			(mode & 0070) >> 3;
+		default_acl_state.group.allow = (mode & 0070) >> 3;
+		default_acl_state.groups->aces[default_acl_state.groups->n].gid =
+			fattr->cf_gid;
+		default_acl_state.groups->aces[default_acl_state.groups->n++].perms.allow =
+			(mode & 0070) >> 3;
+	}
+
+	if (others_found) {
+		fattr->cf_mode &= ~(0007);
+		fattr->cf_mode |= mode & 0007;
+
+		acl_state.other.allow = mode & 0007;
+		default_acl_state.other.allow = mode & 0007;
+	}
+
+	if (acl_state.users->n || acl_state.groups->n) {
+		acl_state.mask.allow = 0x07;
+		fattr->cf_acls = posix_acl_alloc(acl_state.users->n +
+			acl_state.groups->n + 4, GFP_KERNEL);
+		if (fattr->cf_acls) {
+			cf_pace = fattr->cf_acls->a_entries;
+			posix_state_to_acl(&acl_state, cf_pace);
+		}
+	}
+
+	if (default_acl_state.users->n || default_acl_state.groups->n) {
+		default_acl_state.mask.allow = 0x07;
+		fattr->cf_dacls =
+			posix_acl_alloc(default_acl_state.users->n +
+			default_acl_state.groups->n + 4, GFP_KERNEL);
+		if (fattr->cf_dacls) {
+			cf_pdace = fattr->cf_dacls->a_entries;
+			posix_state_to_acl(&default_acl_state, cf_pdace);
+		}
+	}
+	free_acl_state(&acl_state);
+	free_acl_state(&default_acl_state);
+}
+
+static void set_posix_acl_entries_dacl(struct user_namespace *user_ns,
+				       struct smb_ace *pndace,
+				       struct smb_fattr *fattr, u32 *num_aces,
+				       u16 *size, u32 nt_aces_num)
+{
+	struct posix_acl_entry *pace;
+	struct smb_sid *sid;
+	struct smb_ace *ntace;
+	int i, j;
+
+	if (!fattr->cf_acls)
+		goto posix_default_acl;
+
+	pace = fattr->cf_acls->a_entries;
+	for (i = 0; i < fattr->cf_acls->a_count; i++, pace++) {
+		int flags = 0;
+
+		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		if (!sid)
+			break;
+
+		if (pace->e_tag == ACL_USER) {
+			uid_t uid;
+			unsigned int sid_type = SIDOWNER;
+
+			uid = from_kuid(user_ns, pace->e_uid);
+			if (!uid)
+				sid_type = SIDUNIX_USER;
+			id_to_sid(uid, sid_type, sid);
+		} else if (pace->e_tag == ACL_GROUP) {
+			gid_t gid;
+
+			gid = from_kgid(user_ns, pace->e_gid);
+			id_to_sid(gid, SIDUNIX_GROUP, sid);
+		} else if (pace->e_tag == ACL_OTHER && !nt_aces_num) {
+			smb_copy_sid(sid, &sid_everyone);
+		} else {
+			kfree(sid);
+			continue;
+		}
+		ntace = pndace;
+		for (j = 0; j < nt_aces_num; j++) {
+			if (ntace->sid.sub_auth[ntace->sid.num_subauth - 1] ==
+					sid->sub_auth[sid->num_subauth - 1])
+				goto pass_same_sid;
+			ntace = (struct smb_ace *)((char *)ntace +
+					le16_to_cpu(ntace->size));
+		}
+
+		if (S_ISDIR(fattr->cf_mode) && pace->e_tag == ACL_OTHER)
+			flags = 0x03;
+
+		ntace = (struct smb_ace *)((char *)pndace + *size);
+		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
+				pace->e_perm, 0777);
+		(*num_aces)++;
+		if (pace->e_tag == ACL_USER)
+			ntace->access_req |=
+				FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+
+		if (S_ISDIR(fattr->cf_mode) &&
+		    (pace->e_tag == ACL_USER || pace->e_tag == ACL_GROUP)) {
+			ntace = (struct smb_ace *)((char *)pndace + *size);
+			*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED,
+					0x03, pace->e_perm, 0777);
+			(*num_aces)++;
+			if (pace->e_tag == ACL_USER)
+				ntace->access_req |=
+					FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+		}
+
+pass_same_sid:
+		kfree(sid);
+	}
+
+	if (nt_aces_num)
+		return;
+
+posix_default_acl:
+	if (!fattr->cf_dacls)
+		return;
+
+	pace = fattr->cf_dacls->a_entries;
+	for (i = 0; i < fattr->cf_dacls->a_count; i++, pace++) {
+		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		if (!sid)
+			break;
+
+		if (pace->e_tag == ACL_USER) {
+			uid_t uid;
+
+			uid = from_kuid(user_ns, pace->e_uid);
+			id_to_sid(uid, SIDCREATOR_OWNER, sid);
+		} else if (pace->e_tag == ACL_GROUP) {
+			gid_t gid;
+
+			gid = from_kgid(user_ns, pace->e_gid);
+			id_to_sid(gid, SIDCREATOR_GROUP, sid);
+		} else {
+			kfree(sid);
+			continue;
+		}
+
+		ntace = (struct smb_ace *)((char *)pndace + *size);
+		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, 0x0b,
+				pace->e_perm, 0777);
+		(*num_aces)++;
+		if (pace->e_tag == ACL_USER)
+			ntace->access_req |=
+				FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+		kfree(sid);
+	}
+}
+
+static void set_ntacl_dacl(struct user_namespace *user_ns,
+			   struct smb_acl *pndacl,
+			   struct smb_acl *nt_dacl,
+			   const struct smb_sid *pownersid,
+			   const struct smb_sid *pgrpsid,
+			   struct smb_fattr *fattr)
+{
+	struct smb_ace *ntace, *pndace;
+	int nt_num_aces = le32_to_cpu(nt_dacl->num_aces), num_aces = 0;
+	unsigned short size = 0;
+	int i;
+
+	pndace = (struct smb_ace *)((char *)pndacl + sizeof(struct smb_acl));
+	if (nt_num_aces) {
+		ntace = (struct smb_ace *)((char *)nt_dacl + sizeof(struct smb_acl));
+		for (i = 0; i < nt_num_aces; i++) {
+			memcpy((char *)pndace + size, ntace, le16_to_cpu(ntace->size));
+			size += le16_to_cpu(ntace->size);
+			ntace = (struct smb_ace *)((char *)ntace + le16_to_cpu(ntace->size));
+			num_aces++;
+		}
+	}
+
+	set_posix_acl_entries_dacl(user_ns, pndace, fattr,
+				   &num_aces, &size, nt_num_aces);
+	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
+}
+
+static void set_mode_dacl(struct user_namespace *user_ns,
+			  struct smb_acl *pndacl, struct smb_fattr *fattr)
+{
+	struct smb_ace *pace, *pndace;
+	u32 num_aces = 0;
+	u16 size = 0, ace_size = 0;
+	uid_t uid;
+	const struct smb_sid *sid;
+
+	pace = pndace = (struct smb_ace *)((char *)pndacl + sizeof(struct smb_acl));
+
+	if (fattr->cf_acls) {
+		set_posix_acl_entries_dacl(user_ns, pndace, fattr,
+					   &num_aces, &size, num_aces);
+		goto out;
+	}
+
+	/* owner RID */
+	uid = from_kuid(user_ns, fattr->cf_uid);
+	if (uid)
+		sid = &server_conf.domain_sid;
+	else
+		sid = &sid_unix_users;
+	ace_size = fill_ace_for_sid(pace, sid, ACCESS_ALLOWED, 0,
+				    fattr->cf_mode, 0700);
+	pace->sid.sub_auth[pace->sid.num_subauth++] = cpu_to_le32(uid);
+	pace->access_req |= FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+	pace->size = cpu_to_le16(ace_size + 4);
+	size += le16_to_cpu(pace->size);
+	pace = (struct smb_ace *)((char *)pndace + size);
+
+	/* Group RID */
+	ace_size = fill_ace_for_sid(pace, &sid_unix_groups,
+				    ACCESS_ALLOWED, 0, fattr->cf_mode, 0070);
+	pace->sid.sub_auth[pace->sid.num_subauth++] =
+		cpu_to_le32(from_kgid(user_ns, fattr->cf_gid));
+	pace->size = cpu_to_le16(ace_size + 4);
+	size += le16_to_cpu(pace->size);
+	pace = (struct smb_ace *)((char *)pndace + size);
+	num_aces = 3;
+
+	if (S_ISDIR(fattr->cf_mode)) {
+		pace = (struct smb_ace *)((char *)pndace + size);
+
+		/* creator owner */
+		size += fill_ace_for_sid(pace, &creator_owner, ACCESS_ALLOWED,
+					 0x0b, fattr->cf_mode, 0700);
+		pace->access_req |= FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+		pace = (struct smb_ace *)((char *)pndace + size);
+
+		/* creator group */
+		size += fill_ace_for_sid(pace, &creator_group, ACCESS_ALLOWED,
+					 0x0b, fattr->cf_mode, 0070);
+		pace = (struct smb_ace *)((char *)pndace + size);
+		num_aces = 5;
+	}
+
+	/* other */
+	size += fill_ace_for_sid(pace, &sid_everyone, ACCESS_ALLOWED, 0,
+				 fattr->cf_mode, 0007);
+
+out:
+	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
+}
+
+static int parse_sid(struct smb_sid *psid, char *end_of_acl)
+{
+	/*
+	 * validate that we do not go past end of ACL - sid must be at least 8
+	 * bytes long (assuming no sub-auths - e.g. the null SID
+	 */
+	if (end_of_acl < (char *)psid + 8) {
+		pr_err("ACL too small to parse SID %p\n", psid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Convert CIFS ACL to POSIX form */
+int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+		   int acl_len, struct smb_fattr *fattr)
+{
+	int rc = 0;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
+	char *end_of_acl = ((char *)pntsd) + acl_len;
+	__u32 dacloffset;
+	int pntsd_type;
+
+	if (!pntsd)
+		return -EIO;
+
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
+			le32_to_cpu(pntsd->osidoffset));
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
+			le32_to_cpu(pntsd->gsidoffset));
+	dacloffset = le32_to_cpu(pntsd->dacloffset);
+	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
+	ksmbd_debug(SMB,
+		    "revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
+		    pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
+		    le32_to_cpu(pntsd->gsidoffset),
+		    le32_to_cpu(pntsd->sacloffset), dacloffset);
+
+	pntsd_type = le16_to_cpu(pntsd->type);
+	if (!(pntsd_type & DACL_PRESENT)) {
+		ksmbd_debug(SMB, "DACL_PRESENT in DACL type is not set\n");
+		return rc;
+	}
+
+	pntsd->type = cpu_to_le16(DACL_PRESENT);
+
+	if (pntsd->osidoffset) {
+		rc = parse_sid(owner_sid_ptr, end_of_acl);
+		if (rc) {
+			pr_err("%s: Error %d parsing Owner SID\n", __func__, rc);
+			return rc;
+		}
+
+		rc = sid_to_id(user_ns, owner_sid_ptr, SIDOWNER, fattr);
+		if (rc) {
+			pr_err("%s: Error %d mapping Owner SID to uid\n",
+			       __func__, rc);
+			owner_sid_ptr = NULL;
+		}
+	}
+
+	if (pntsd->gsidoffset) {
+		rc = parse_sid(group_sid_ptr, end_of_acl);
+		if (rc) {
+			pr_err("%s: Error %d mapping Owner SID to gid\n",
+			       __func__, rc);
+			return rc;
+		}
+		rc = sid_to_id(user_ns, group_sid_ptr, SIDUNIX_GROUP, fattr);
+		if (rc) {
+			pr_err("%s: Error %d mapping Group SID to gid\n",
+			       __func__, rc);
+			group_sid_ptr = NULL;
+		}
+	}
+
+	if ((pntsd_type & (DACL_AUTO_INHERITED | DACL_AUTO_INHERIT_REQ)) ==
+	    (DACL_AUTO_INHERITED | DACL_AUTO_INHERIT_REQ))
+		pntsd->type |= cpu_to_le16(DACL_AUTO_INHERITED);
+	if (pntsd_type & DACL_PROTECTED)
+		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
+
+	if (dacloffset) {
+		parse_dacl(user_ns, dacl_ptr, end_of_acl,
+			   owner_sid_ptr, group_sid_ptr, fattr);
+	}
+
+	return 0;
+}
+
+/* Convert permission bits from mode to equivalent CIFS ACL */
+int build_sec_desc(struct user_namespace *user_ns,
+		   struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
+		   int addition_info, __u32 *secdesclen,
+		   struct smb_fattr *fattr)
+{
+	int rc = 0;
+	__u32 offset;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_sid *nowner_sid_ptr, *ngroup_sid_ptr;
+	struct smb_acl *dacl_ptr = NULL; /* no need for SACL ptr */
+	uid_t uid;
+	gid_t gid;
+	unsigned int sid_type = SIDOWNER;
+
+	nowner_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	if (!nowner_sid_ptr)
+		return -ENOMEM;
+
+	uid = from_kuid(user_ns, fattr->cf_uid);
+	if (!uid)
+		sid_type = SIDUNIX_USER;
+	id_to_sid(uid, sid_type, nowner_sid_ptr);
+
+	ngroup_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	if (!ngroup_sid_ptr) {
+		kfree(nowner_sid_ptr);
+		return -ENOMEM;
+	}
+
+	gid = from_kgid(user_ns, fattr->cf_gid);
+	id_to_sid(gid, SIDUNIX_GROUP, ngroup_sid_ptr);
+
+	offset = sizeof(struct smb_ntsd);
+	pntsd->sacloffset = 0;
+	pntsd->revision = cpu_to_le16(1);
+	pntsd->type = cpu_to_le16(SELF_RELATIVE);
+	if (ppntsd)
+		pntsd->type |= ppntsd->type;
+
+	if (addition_info & OWNER_SECINFO) {
+		pntsd->osidoffset = cpu_to_le32(offset);
+		owner_sid_ptr = (struct smb_sid *)((char *)pntsd + offset);
+		smb_copy_sid(owner_sid_ptr, nowner_sid_ptr);
+		offset += 1 + 1 + 6 + (nowner_sid_ptr->num_subauth * 4);
+	}
+
+	if (addition_info & GROUP_SECINFO) {
+		pntsd->gsidoffset = cpu_to_le32(offset);
+		group_sid_ptr = (struct smb_sid *)((char *)pntsd + offset);
+		smb_copy_sid(group_sid_ptr, ngroup_sid_ptr);
+		offset += 1 + 1 + 6 + (ngroup_sid_ptr->num_subauth * 4);
+	}
+
+	if (addition_info & DACL_SECINFO) {
+		pntsd->type |= cpu_to_le16(DACL_PRESENT);
+		dacl_ptr = (struct smb_acl *)((char *)pntsd + offset);
+		dacl_ptr->revision = cpu_to_le16(2);
+		dacl_ptr->size = cpu_to_le16(sizeof(struct smb_acl));
+		dacl_ptr->num_aces = 0;
+
+		if (!ppntsd) {
+			set_mode_dacl(user_ns, dacl_ptr, fattr);
+		} else if (!ppntsd->dacloffset) {
+			goto out;
+		} else {
+			struct smb_acl *ppdacl_ptr;
+
+			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd +
+						le32_to_cpu(ppntsd->dacloffset));
+			set_ntacl_dacl(user_ns, dacl_ptr, ppdacl_ptr,
+				       nowner_sid_ptr, ngroup_sid_ptr, fattr);
+		}
+		pntsd->dacloffset = cpu_to_le32(offset);
+		offset += le16_to_cpu(dacl_ptr->size);
+	}
+
+out:
+	kfree(nowner_sid_ptr);
+	kfree(ngroup_sid_ptr);
+	*secdesclen = offset;
+	return rc;
+}
+
+static void smb_set_ace(struct smb_ace *ace, const struct smb_sid *sid, u8 type,
+			u8 flags, __le32 access_req)
+{
+	ace->type = type;
+	ace->flags = flags;
+	ace->access_req = access_req;
+	smb_copy_sid(&ace->sid, sid);
+	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 + (sid->num_subauth * 4));
+}
+
+int smb_inherit_dacl(struct ksmbd_conn *conn,
+		     struct path *path,
+		     unsigned int uid, unsigned int gid)
+{
+	const struct smb_sid *psid, *creator = NULL;
+	struct smb_ace *parent_aces, *aces;
+	struct smb_acl *parent_pdacl;
+	struct smb_ntsd *parent_pntsd = NULL;
+	struct smb_sid owner_sid, group_sid;
+	struct dentry *parent = path->dentry->d_parent;
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0;
+	int rc = 0, num_aces, dacloffset, pntsd_type, acl_len;
+	char *aces_base;
+	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
+
+	acl_len = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+					 parent, &parent_pntsd);
+	if (acl_len <= 0)
+		return -ENOENT;
+	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
+	if (!dacloffset) {
+		rc = -EINVAL;
+		goto free_parent_pntsd;
+	}
+
+	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
+	num_aces = le32_to_cpu(parent_pdacl->num_aces);
+	pntsd_type = le16_to_cpu(parent_pntsd->type);
+
+	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, GFP_KERNEL);
+	if (!aces_base) {
+		rc = -ENOMEM;
+		goto free_parent_pntsd;
+	}
+
+	aces = (struct smb_ace *)aces_base;
+	parent_aces = (struct smb_ace *)((char *)parent_pdacl +
+			sizeof(struct smb_acl));
+
+	if (pntsd_type & DACL_AUTO_INHERITED)
+		inherited_flags = INHERITED_ACE;
+
+	for (i = 0; i < num_aces; i++) {
+		flags = parent_aces->flags;
+		if (!smb_inherit_flags(flags, is_dir))
+			goto pass;
+		if (is_dir) {
+			flags &= ~(INHERIT_ONLY_ACE | INHERITED_ACE);
+			if (!(flags & CONTAINER_INHERIT_ACE))
+				flags |= INHERIT_ONLY_ACE;
+			if (flags & NO_PROPAGATE_INHERIT_ACE)
+				flags = 0;
+		} else {
+			flags = 0;
+		}
+
+		if (!compare_sids(&creator_owner, &parent_aces->sid)) {
+			creator = &creator_owner;
+			id_to_sid(uid, SIDOWNER, &owner_sid);
+			psid = &owner_sid;
+		} else if (!compare_sids(&creator_group, &parent_aces->sid)) {
+			creator = &creator_group;
+			id_to_sid(gid, SIDUNIX_GROUP, &group_sid);
+			psid = &group_sid;
+		} else {
+			creator = NULL;
+			psid = &parent_aces->sid;
+		}
+
+		if (is_dir && creator && flags & CONTAINER_INHERIT_ACE) {
+			smb_set_ace(aces, psid, parent_aces->type, inherited_flags,
+				    parent_aces->access_req);
+			nt_size += le16_to_cpu(aces->size);
+			ace_cnt++;
+			aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
+			flags |= INHERIT_ONLY_ACE;
+			psid = creator;
+		} else if (is_dir && !(parent_aces->flags & NO_PROPAGATE_INHERIT_ACE)) {
+			psid = &parent_aces->sid;
+		}
+
+		smb_set_ace(aces, psid, parent_aces->type, flags | inherited_flags,
+			    parent_aces->access_req);
+		nt_size += le16_to_cpu(aces->size);
+		aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
+		ace_cnt++;
+pass:
+		parent_aces =
+			(struct smb_ace *)((char *)parent_aces + le16_to_cpu(parent_aces->size));
+	}
+
+	if (nt_size > 0) {
+		struct smb_ntsd *pntsd;
+		struct smb_acl *pdacl;
+		struct smb_sid *powner_sid = NULL, *pgroup_sid = NULL;
+		int powner_sid_size = 0, pgroup_sid_size = 0, pntsd_size;
+
+		if (parent_pntsd->osidoffset) {
+			powner_sid = (struct smb_sid *)((char *)parent_pntsd +
+					le32_to_cpu(parent_pntsd->osidoffset));
+			powner_sid_size = 1 + 1 + 6 + (powner_sid->num_subauth * 4);
+		}
+		if (parent_pntsd->gsidoffset) {
+			pgroup_sid = (struct smb_sid *)((char *)parent_pntsd +
+					le32_to_cpu(parent_pntsd->gsidoffset));
+			pgroup_sid_size = 1 + 1 + 6 + (pgroup_sid->num_subauth * 4);
+		}
+
+		pntsd = kzalloc(sizeof(struct smb_ntsd) + powner_sid_size +
+				pgroup_sid_size + sizeof(struct smb_acl) +
+				nt_size, GFP_KERNEL);
+		if (!pntsd) {
+			rc = -ENOMEM;
+			goto free_aces_base;
+		}
+
+		pntsd->revision = cpu_to_le16(1);
+		pntsd->type = cpu_to_le16(SELF_RELATIVE | DACL_PRESENT);
+		if (le16_to_cpu(parent_pntsd->type) & DACL_AUTO_INHERITED)
+			pntsd->type |= cpu_to_le16(DACL_AUTO_INHERITED);
+		pntsd_size = sizeof(struct smb_ntsd);
+		pntsd->osidoffset = parent_pntsd->osidoffset;
+		pntsd->gsidoffset = parent_pntsd->gsidoffset;
+		pntsd->dacloffset = parent_pntsd->dacloffset;
+
+		if (pntsd->osidoffset) {
+			struct smb_sid *owner_sid = (struct smb_sid *)((char *)pntsd +
+					le32_to_cpu(pntsd->osidoffset));
+			memcpy(owner_sid, powner_sid, powner_sid_size);
+			pntsd_size += powner_sid_size;
+		}
+
+		if (pntsd->gsidoffset) {
+			struct smb_sid *group_sid = (struct smb_sid *)((char *)pntsd +
+					le32_to_cpu(pntsd->gsidoffset));
+			memcpy(group_sid, pgroup_sid, pgroup_sid_size);
+			pntsd_size += pgroup_sid_size;
+		}
+
+		if (pntsd->dacloffset) {
+			struct smb_ace *pace;
+
+			pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
+			pdacl->revision = cpu_to_le16(2);
+			pdacl->size = cpu_to_le16(sizeof(struct smb_acl) + nt_size);
+			pdacl->num_aces = cpu_to_le32(ace_cnt);
+			pace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+			memcpy(pace, aces_base, nt_size);
+			pntsd_size += sizeof(struct smb_acl) + nt_size;
+		}
+
+		ksmbd_vfs_set_sd_xattr(conn, user_ns,
+				       path->dentry, pntsd, pntsd_size);
+		kfree(pntsd);
+	}
+
+free_aces_base:
+	kfree(aces_base);
+free_parent_pntsd:
+	kfree(parent_pntsd);
+	return rc;
+}
+
+bool smb_inherit_flags(int flags, bool is_dir)
+{
+	if (!is_dir)
+		return (flags & OBJECT_INHERIT_ACE) != 0;
+
+	if (flags & OBJECT_INHERIT_ACE && !(flags & NO_PROPAGATE_INHERIT_ACE))
+		return true;
+
+	if (flags & CONTAINER_INHERIT_ACE)
+		return true;
+	return false;
+}
+
+int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+			__le32 *pdaccess, int uid)
+{
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+	struct smb_ntsd *pntsd = NULL;
+	struct smb_acl *pdacl;
+	struct posix_acl *posix_acls;
+	int rc = 0, acl_size;
+	struct smb_sid sid;
+	int granted = le32_to_cpu(*pdaccess & ~FILE_MAXIMAL_ACCESS_LE);
+	struct smb_ace *ace;
+	int i, found = 0;
+	unsigned int access_bits = 0;
+	struct smb_ace *others_ace = NULL;
+	struct posix_acl_entry *pa_entry;
+	unsigned int sid_type = SIDOWNER;
+	char *end_of_acl;
+
+	ksmbd_debug(SMB, "check permission using windows acl\n");
+	acl_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
+					  path->dentry, &pntsd);
+	if (acl_size <= 0 || !pntsd || !pntsd->dacloffset) {
+		kfree(pntsd);
+		return 0;
+	}
+
+	pdacl = (struct smb_acl *)((char *)pntsd + le32_to_cpu(pntsd->dacloffset));
+	end_of_acl = ((char *)pntsd) + acl_size;
+	if (end_of_acl <= (char *)pdacl) {
+		kfree(pntsd);
+		return 0;
+	}
+
+	if (end_of_acl < (char *)pdacl + le16_to_cpu(pdacl->size) ||
+	    le16_to_cpu(pdacl->size) < sizeof(struct smb_acl)) {
+		kfree(pntsd);
+		return 0;
+	}
+
+	if (!pdacl->num_aces) {
+		if (!(le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) &&
+		    *pdaccess & ~(FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE)) {
+			rc = -EACCES;
+			goto err_out;
+		}
+		kfree(pntsd);
+		return 0;
+	}
+
+	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE) {
+		granted = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
+			DELETE;
+
+		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+		for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+			granted |= le32_to_cpu(ace->access_req);
+			ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
+			if (end_of_acl < (char *)ace)
+				goto err_out;
+		}
+
+		if (!pdacl->num_aces)
+			granted = GENERIC_ALL_FLAGS;
+	}
+
+	if (!uid)
+		sid_type = SIDUNIX_USER;
+	id_to_sid(uid, sid_type, &sid);
+
+	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
+	for (i = 0; i < le32_to_cpu(pdacl->num_aces); i++) {
+		if (!compare_sids(&sid, &ace->sid) ||
+		    !compare_sids(&sid_unix_NFS_mode, &ace->sid)) {
+			found = 1;
+			break;
+		}
+		if (!compare_sids(&sid_everyone, &ace->sid))
+			others_ace = ace;
+
+		ace = (struct smb_ace *)((char *)ace + le16_to_cpu(ace->size));
+		if (end_of_acl < (char *)ace)
+			goto err_out;
+	}
+
+	if (*pdaccess & FILE_MAXIMAL_ACCESS_LE && found) {
+		granted = READ_CONTROL | WRITE_DAC | FILE_READ_ATTRIBUTES |
+			DELETE;
+
+		granted |= le32_to_cpu(ace->access_req);
+
+		if (!pdacl->num_aces)
+			granted = GENERIC_ALL_FLAGS;
+	}
+
+	posix_acls = get_acl(d_inode(path->dentry), ACL_TYPE_ACCESS);
+	if (posix_acls && !found) {
+		unsigned int id = -1;
+
+		pa_entry = posix_acls->a_entries;
+		for (i = 0; i < posix_acls->a_count; i++, pa_entry++) {
+			if (pa_entry->e_tag == ACL_USER)
+				id = from_kuid(user_ns,
+					       pa_entry->e_uid);
+			else if (pa_entry->e_tag == ACL_GROUP)
+				id = from_kgid(user_ns,
+					       pa_entry->e_gid);
+			else
+				continue;
+
+			if (id == uid) {
+				mode_to_access_flags(pa_entry->e_perm, 0777, &access_bits);
+				if (!access_bits)
+					access_bits = SET_MINIMUM_RIGHTS;
+				goto check_access_bits;
+			}
+		}
+	}
+	if (posix_acls)
+		posix_acl_release(posix_acls);
+
+	if (!found) {
+		if (others_ace) {
+			ace = others_ace;
+		} else {
+			ksmbd_debug(SMB, "Can't find corresponding sid\n");
+			rc = -EACCES;
+			goto err_out;
+		}
+	}
+
+	switch (ace->type) {
+	case ACCESS_ALLOWED_ACE_TYPE:
+		access_bits = le32_to_cpu(ace->access_req);
+		break;
+	case ACCESS_DENIED_ACE_TYPE:
+	case ACCESS_DENIED_CALLBACK_ACE_TYPE:
+		access_bits = le32_to_cpu(~ace->access_req);
+		break;
+	}
+
+check_access_bits:
+	if (granted &
+	    ~(access_bits | FILE_READ_ATTRIBUTES | READ_CONTROL | WRITE_DAC | DELETE)) {
+		ksmbd_debug(SMB, "Access denied with winACL, granted : %x, access_req : %x\n",
+			    granted, le32_to_cpu(ace->access_req));
+		rc = -EACCES;
+		goto err_out;
+	}
+
+	*pdaccess = cpu_to_le32(granted);
+err_out:
+	kfree(pntsd);
+	return rc;
+}
+
+int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
+		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 bool type_check)
+{
+	int rc;
+	struct smb_fattr fattr = {{0}};
+	struct inode *inode = d_inode(path->dentry);
+	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
+
+	fattr.cf_uid = INVALID_UID;
+	fattr.cf_gid = INVALID_GID;
+	fattr.cf_mode = inode->i_mode;
+
+	rc = parse_sec_desc(user_ns, pntsd, ntsd_len, &fattr);
+	if (rc)
+		goto out;
+
+	inode->i_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
+	if (!uid_eq(fattr.cf_uid, INVALID_UID))
+		inode->i_uid = fattr.cf_uid;
+	if (!gid_eq(fattr.cf_gid, INVALID_GID))
+		inode->i_gid = fattr.cf_gid;
+	mark_inode_dirty(inode);
+
+	ksmbd_vfs_remove_acl_xattrs(user_ns, path->dentry);
+	/* Update posix acls */
+	if (fattr.cf_dacls) {
+		rc = set_posix_acl(user_ns, inode,
+				   ACL_TYPE_ACCESS, fattr.cf_acls);
+		if (S_ISDIR(inode->i_mode) && fattr.cf_dacls)
+			rc = set_posix_acl(user_ns, inode,
+					   ACL_TYPE_DEFAULT, fattr.cf_dacls);
+	}
+
+	/* Check it only calling from SD BUFFER context */
+	if (type_check && !(le16_to_cpu(pntsd->type) & DACL_PRESENT))
+		goto out;
+
+	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
+		/* Update WinACL in xattr */
+		ksmbd_vfs_remove_sd_xattrs(user_ns, path->dentry);
+		ksmbd_vfs_set_sd_xattr(conn, user_ns,
+				       path->dentry, pntsd, ntsd_len);
+	}
+
+out:
+	posix_acl_release(fattr.cf_acls);
+	posix_acl_release(fattr.cf_dacls);
+	mark_inode_dirty(inode);
+	return rc;
+}
+
+void ksmbd_init_domain(u32 *sub_auth)
+{
+	int i;
+
+	memcpy(&server_conf.domain_sid, &domain, sizeof(struct smb_sid));
+	for (i = 0; i < 3; ++i)
+		server_conf.domain_sid.sub_auth[i + 1] = cpu_to_le32(sub_auth[i]);
+}
diff --git a/fs/ksmbd/smbacl.h b/fs/ksmbd/smbacl.h
new file mode 100644
index 000000000000..940f686a1d95
--- /dev/null
+++ b/fs/ksmbd/smbacl.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   Copyright (c) International Business Machines  Corp., 2007
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *   Modified by Namjae Jeon (linkinjeon@kernel.org)
+ */
+
+#ifndef _SMBACL_H
+#define _SMBACL_H
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/posix_acl.h>
+
+#include "mgmt/tree_connect.h"
+
+#define NUM_AUTHS (6)	/* number of authority fields */
+#define SID_MAX_SUB_AUTHORITIES (15) /* max number of sub authority fields */
+
+/*
+ * ACE types - see MS-DTYP 2.4.4.1
+ */
+enum {
+	ACCESS_ALLOWED,
+	ACCESS_DENIED,
+};
+
+/*
+ * Security ID types
+ */
+enum {
+	SIDOWNER = 1,
+	SIDGROUP,
+	SIDCREATOR_OWNER,
+	SIDCREATOR_GROUP,
+	SIDUNIX_USER,
+	SIDUNIX_GROUP,
+	SIDNFS_USER,
+	SIDNFS_GROUP,
+	SIDNFS_MODE,
+};
+
+/* Revision for ACLs */
+#define SD_REVISION	1
+
+/* Control flags for Security Descriptor */
+#define OWNER_DEFAULTED		0x0001
+#define GROUP_DEFAULTED		0x0002
+#define DACL_PRESENT		0x0004
+#define DACL_DEFAULTED		0x0008
+#define SACL_PRESENT		0x0010
+#define SACL_DEFAULTED		0x0020
+#define DACL_TRUSTED		0x0040
+#define SERVER_SECURITY		0x0080
+#define DACL_AUTO_INHERIT_REQ	0x0100
+#define SACL_AUTO_INHERIT_REQ	0x0200
+#define DACL_AUTO_INHERITED	0x0400
+#define SACL_AUTO_INHERITED	0x0800
+#define DACL_PROTECTED		0x1000
+#define SACL_PROTECTED		0x2000
+#define RM_CONTROL_VALID	0x4000
+#define SELF_RELATIVE		0x8000
+
+/* ACE types - see MS-DTYP 2.4.4.1 */
+#define ACCESS_ALLOWED_ACE_TYPE 0x00
+#define ACCESS_DENIED_ACE_TYPE  0x01
+#define SYSTEM_AUDIT_ACE_TYPE   0x02
+#define SYSTEM_ALARM_ACE_TYPE   0x03
+#define ACCESS_ALLOWED_COMPOUND_ACE_TYPE 0x04
+#define ACCESS_ALLOWED_OBJECT_ACE_TYPE  0x05
+#define ACCESS_DENIED_OBJECT_ACE_TYPE   0x06
+#define SYSTEM_AUDIT_OBJECT_ACE_TYPE    0x07
+#define SYSTEM_ALARM_OBJECT_ACE_TYPE    0x08
+#define ACCESS_ALLOWED_CALLBACK_ACE_TYPE 0x09
+#define ACCESS_DENIED_CALLBACK_ACE_TYPE 0x0A
+#define ACCESS_ALLOWED_CALLBACK_OBJECT_ACE_TYPE 0x0B
+#define ACCESS_DENIED_CALLBACK_OBJECT_ACE_TYPE  0x0C
+#define SYSTEM_AUDIT_CALLBACK_ACE_TYPE  0x0D
+#define SYSTEM_ALARM_CALLBACK_ACE_TYPE  0x0E /* Reserved */
+#define SYSTEM_AUDIT_CALLBACK_OBJECT_ACE_TYPE 0x0F
+#define SYSTEM_ALARM_CALLBACK_OBJECT_ACE_TYPE 0x10 /* reserved */
+#define SYSTEM_MANDATORY_LABEL_ACE_TYPE 0x11
+#define SYSTEM_RESOURCE_ATTRIBUTE_ACE_TYPE 0x12
+#define SYSTEM_SCOPED_POLICY_ID_ACE_TYPE 0x13
+
+/* ACE flags */
+#define OBJECT_INHERIT_ACE		0x01
+#define CONTAINER_INHERIT_ACE		0x02
+#define NO_PROPAGATE_INHERIT_ACE	0x04
+#define INHERIT_ONLY_ACE		0x08
+#define INHERITED_ACE			0x10
+#define SUCCESSFUL_ACCESS_ACE_FLAG	0x40
+#define FAILED_ACCESS_ACE_FLAG		0x80
+
+/*
+ * Maximum size of a string representation of a SID:
+ *
+ * The fields are unsigned values in decimal. So:
+ *
+ * u8:  max 3 bytes in decimal
+ * u32: max 10 bytes in decimal
+ *
+ * "S-" + 3 bytes for version field + 15 for authority field + NULL terminator
+ *
+ * For authority field, max is when all 6 values are non-zero and it must be
+ * represented in hex. So "-0x" + 12 hex digits.
+ *
+ * Add 11 bytes for each subauthority field (10 bytes each + 1 for '-')
+ */
+#define SID_STRING_BASE_SIZE (2 + 3 + 15 + 1)
+#define SID_STRING_SUBAUTH_SIZE (11) /* size of a single subauth string */
+
+#define DOMAIN_USER_RID_LE	cpu_to_le32(513)
+
+struct ksmbd_conn;
+
+struct smb_ntsd {
+	__le16 revision; /* revision level */
+	__le16 type;
+	__le32 osidoffset;
+	__le32 gsidoffset;
+	__le32 sacloffset;
+	__le32 dacloffset;
+} __packed;
+
+struct smb_sid {
+	__u8 revision; /* revision level */
+	__u8 num_subauth;
+	__u8 authority[NUM_AUTHS];
+	__le32 sub_auth[SID_MAX_SUB_AUTHORITIES]; /* sub_auth[num_subauth] */
+} __packed;
+
+/* size of a struct cifs_sid, sans sub_auth array */
+#define CIFS_SID_BASE_SIZE (1 + 1 + NUM_AUTHS)
+
+struct smb_acl {
+	__le16 revision; /* revision level */
+	__le16 size;
+	__le32 num_aces;
+} __packed;
+
+struct smb_ace {
+	__u8 type;
+	__u8 flags;
+	__le16 size;
+	__le32 access_req;
+	struct smb_sid sid; /* ie UUID of user or group who gets these perms */
+} __packed;
+
+struct smb_fattr {
+	kuid_t	cf_uid;
+	kgid_t	cf_gid;
+	umode_t	cf_mode;
+	__le32 daccess;
+	struct posix_acl *cf_acls;
+	struct posix_acl *cf_dacls;
+};
+
+struct posix_ace_state {
+	u32 allow;
+	u32 deny;
+};
+
+struct posix_user_ace_state {
+	union {
+		kuid_t uid;
+		kgid_t gid;
+	};
+	struct posix_ace_state perms;
+};
+
+struct posix_ace_state_array {
+	int n;
+	struct posix_user_ace_state aces[];
+};
+
+/*
+ * while processing the nfsv4 ace, this maintains the partial permissions
+ * calculated so far:
+ */
+
+struct posix_acl_state {
+	struct posix_ace_state owner;
+	struct posix_ace_state group;
+	struct posix_ace_state other;
+	struct posix_ace_state everyone;
+	struct posix_ace_state mask; /* deny unused in this case */
+	struct posix_ace_state_array *users;
+	struct posix_ace_state_array *groups;
+};
+
+int parse_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+		   int acl_len, struct smb_fattr *fattr);
+int build_sec_desc(struct user_namespace *user_ns, struct smb_ntsd *pntsd,
+		   struct smb_ntsd *ppntsd, int addition_info,
+		   __u32 *secdesclen, struct smb_fattr *fattr);
+int init_acl_state(struct posix_acl_state *state, int cnt);
+void free_acl_state(struct posix_acl_state *state);
+void posix_state_to_acl(struct posix_acl_state *state,
+			struct posix_acl_entry *pace);
+int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid);
+bool smb_inherit_flags(int flags, bool is_dir);
+int smb_inherit_dacl(struct ksmbd_conn *conn, struct path *path,
+		     unsigned int uid, unsigned int gid);
+int smb_check_perm_dacl(struct ksmbd_conn *conn, struct path *path,
+			__le32 *pdaccess, int uid);
+int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
+		 struct path *path, struct smb_ntsd *pntsd, int ntsd_len,
+		 bool type_check);
+void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
+void ksmbd_init_domain(u32 *sub_auth);
+#endif /* _SMBACL_H */
diff --git a/fs/ksmbd/smbfsctl.h b/fs/ksmbd/smbfsctl.h
new file mode 100644
index 000000000000..b98418aae20c
--- /dev/null
+++ b/fs/ksmbd/smbfsctl.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   fs/cifs/smbfsctl.h: SMB, CIFS, SMB2 FSCTL definitions
+ *
+ *   Copyright (c) International Business Machines  Corp., 2002,2009
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ */
+
+/* IOCTL information */
+/*
+ * List of ioctl/fsctl function codes that are or could be useful in the
+ * future to remote clients like cifs or SMB2 client.  There is probably
+ * a slightly larger set of fsctls that NTFS local filesystem could handle,
+ * including the seven below that we do not have struct definitions for.
+ * Even with protocol definitions for most of these now available, we still
+ * need to do some experimentation to identify which are practical to do
+ * remotely.  Some of the following, such as the encryption/compression ones
+ * could be invoked from tools via a specialized hook into the VFS rather
+ * than via the standard vfs entry points
+ */
+
+#ifndef __KSMBD_SMBFSCTL_H
+#define __KSMBD_SMBFSCTL_H
+
+#define FSCTL_DFS_GET_REFERRALS      0x00060194
+#define FSCTL_DFS_GET_REFERRALS_EX   0x000601B0
+#define FSCTL_REQUEST_OPLOCK_LEVEL_1 0x00090000
+#define FSCTL_REQUEST_OPLOCK_LEVEL_2 0x00090004
+#define FSCTL_REQUEST_BATCH_OPLOCK   0x00090008
+#define FSCTL_LOCK_VOLUME            0x00090018
+#define FSCTL_UNLOCK_VOLUME          0x0009001C
+#define FSCTL_IS_PATHNAME_VALID      0x0009002C /* BB add struct */
+#define FSCTL_GET_COMPRESSION        0x0009003C /* BB add struct */
+#define FSCTL_SET_COMPRESSION        0x0009C040 /* BB add struct */
+#define FSCTL_QUERY_FAT_BPB          0x00090058 /* BB add struct */
+/* Verify the next FSCTL number, we had it as 0x00090090 before */
+#define FSCTL_FILESYSTEM_GET_STATS   0x00090060 /* BB add struct */
+#define FSCTL_GET_NTFS_VOLUME_DATA   0x00090064 /* BB add struct */
+#define FSCTL_GET_RETRIEVAL_POINTERS 0x00090073 /* BB add struct */
+#define FSCTL_IS_VOLUME_DIRTY        0x00090078 /* BB add struct */
+#define FSCTL_ALLOW_EXTENDED_DASD_IO 0x00090083 /* BB add struct */
+#define FSCTL_REQUEST_FILTER_OPLOCK  0x0009008C
+#define FSCTL_FIND_FILES_BY_SID      0x0009008F /* BB add struct */
+#define FSCTL_SET_OBJECT_ID          0x00090098 /* BB add struct */
+#define FSCTL_GET_OBJECT_ID          0x0009009C /* BB add struct */
+#define FSCTL_DELETE_OBJECT_ID       0x000900A0 /* BB add struct */
+#define FSCTL_SET_REPARSE_POINT      0x000900A4 /* BB add struct */
+#define FSCTL_GET_REPARSE_POINT      0x000900A8 /* BB add struct */
+#define FSCTL_DELETE_REPARSE_POINT   0x000900AC /* BB add struct */
+#define FSCTL_SET_OBJECT_ID_EXTENDED 0x000900BC /* BB add struct */
+#define FSCTL_CREATE_OR_GET_OBJECT_ID 0x000900C0 /* BB add struct */
+#define FSCTL_SET_SPARSE             0x000900C4 /* BB add struct */
+#define FSCTL_SET_ZERO_DATA          0x000980C8 /* BB add struct */
+#define FSCTL_SET_ENCRYPTION         0x000900D7 /* BB add struct */
+#define FSCTL_ENCRYPTION_FSCTL_IO    0x000900DB /* BB add struct */
+#define FSCTL_WRITE_RAW_ENCRYPTED    0x000900DF /* BB add struct */
+#define FSCTL_READ_RAW_ENCRYPTED     0x000900E3 /* BB add struct */
+#define FSCTL_READ_FILE_USN_DATA     0x000900EB /* BB add struct */
+#define FSCTL_WRITE_USN_CLOSE_RECORD 0x000900EF /* BB add struct */
+#define FSCTL_SIS_COPYFILE           0x00090100 /* BB add struct */
+#define FSCTL_RECALL_FILE            0x00090117 /* BB add struct */
+#define FSCTL_QUERY_SPARING_INFO     0x00090138 /* BB add struct */
+#define FSCTL_SET_ZERO_ON_DEALLOC    0x00090194 /* BB add struct */
+#define FSCTL_SET_SHORT_NAME_BEHAVIOR 0x000901B4 /* BB add struct */
+#define FSCTL_QUERY_ALLOCATED_RANGES 0x000940CF /* BB add struct */
+#define FSCTL_SET_DEFECT_MANAGEMENT  0x00098134 /* BB add struct */
+#define FSCTL_DUPLICATE_EXTENTS_TO_FILE 0x00098344
+#define FSCTL_SIS_LINK_FILES         0x0009C104
+#define FSCTL_PIPE_PEEK              0x0011400C /* BB add struct */
+#define FSCTL_PIPE_TRANSCEIVE        0x0011C017 /* BB add struct */
+/* strange that the number for this op is not sequential with previous op */
+#define FSCTL_PIPE_WAIT              0x00110018 /* BB add struct */
+#define FSCTL_REQUEST_RESUME_KEY     0x00140078
+#define FSCTL_LMR_GET_LINK_TRACK_INF 0x001400E8 /* BB add struct */
+#define FSCTL_LMR_SET_LINK_TRACK_INF 0x001400EC /* BB add struct */
+#define FSCTL_VALIDATE_NEGOTIATE_INFO 0x00140204
+#define FSCTL_QUERY_NETWORK_INTERFACE_INFO 0x001401FC
+#define FSCTL_COPYCHUNK              0x001440F2
+#define FSCTL_COPYCHUNK_WRITE        0x001480F2
+
+#define IO_REPARSE_TAG_MOUNT_POINT   0xA0000003
+#define IO_REPARSE_TAG_HSM           0xC0000004
+#define IO_REPARSE_TAG_SIS           0x80000007
+
+/* WSL reparse tags */
+#define IO_REPARSE_TAG_LX_SYMLINK_LE	cpu_to_le32(0xA000001D)
+#define IO_REPARSE_TAG_AF_UNIX_LE	cpu_to_le32(0x80000023)
+#define IO_REPARSE_TAG_LX_FIFO_LE	cpu_to_le32(0x80000024)
+#define IO_REPARSE_TAG_LX_CHR_LE	cpu_to_le32(0x80000025)
+#define IO_REPARSE_TAG_LX_BLK_LE	cpu_to_le32(0x80000026)
+#endif /* __KSMBD_SMBFSCTL_H */
diff --git a/fs/ksmbd/smbstatus.h b/fs/ksmbd/smbstatus.h
new file mode 100644
index 000000000000..108a8b6ed24a
--- /dev/null
+++ b/fs/ksmbd/smbstatus.h
@@ -0,0 +1,1822 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   fs/cifs/smb2status.h
+ *
+ *   SMB2 Status code (network error) definitions
+ *   Definitions are from MS-ERREF
+ *
+ *   Copyright (c) International Business Machines  Corp., 2009,2011
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ */
+
+/*
+ *  0 1 2 3 4 5 6 7 8 9 0 A B C D E F 0 1 2 3 4 5 6 7 8 9 A B C D E F
+ *  SEV C N <-------Facility--------> <------Error Status Code------>
+ *
+ *  C is set if "customer defined" error, N bit is reserved and MBZ
+ */
+
+#define STATUS_SEVERITY_SUCCESS cpu_to_le32(0x0000)
+#define STATUS_SEVERITY_INFORMATIONAL cpu_to_le32(0x0001)
+#define STATUS_SEVERITY_WARNING cpu_to_le32(0x0002)
+#define STATUS_SEVERITY_ERROR cpu_to_le32(0x0003)
+
+struct ntstatus {
+	/* Facility is the high 12 bits of the following field */
+	__le32 Facility; /* low 2 bits Severity, next is Customer, then rsrvd */
+	__le32 Code;
+};
+
+#define STATUS_SUCCESS 0x00000000
+#define STATUS_WAIT_0 cpu_to_le32(0x00000000)
+#define STATUS_WAIT_1 cpu_to_le32(0x00000001)
+#define STATUS_WAIT_2 cpu_to_le32(0x00000002)
+#define STATUS_WAIT_3 cpu_to_le32(0x00000003)
+#define STATUS_WAIT_63 cpu_to_le32(0x0000003F)
+#define STATUS_ABANDONED cpu_to_le32(0x00000080)
+#define STATUS_ABANDONED_WAIT_0 cpu_to_le32(0x00000080)
+#define STATUS_ABANDONED_WAIT_63 cpu_to_le32(0x000000BF)
+#define STATUS_USER_APC cpu_to_le32(0x000000C0)
+#define STATUS_KERNEL_APC cpu_to_le32(0x00000100)
+#define STATUS_ALERTED cpu_to_le32(0x00000101)
+#define STATUS_TIMEOUT cpu_to_le32(0x00000102)
+#define STATUS_PENDING cpu_to_le32(0x00000103)
+#define STATUS_REPARSE cpu_to_le32(0x00000104)
+#define STATUS_MORE_ENTRIES cpu_to_le32(0x00000105)
+#define STATUS_NOT_ALL_ASSIGNED cpu_to_le32(0x00000106)
+#define STATUS_SOME_NOT_MAPPED cpu_to_le32(0x00000107)
+#define STATUS_OPLOCK_BREAK_IN_PROGRESS cpu_to_le32(0x00000108)
+#define STATUS_VOLUME_MOUNTED cpu_to_le32(0x00000109)
+#define STATUS_RXACT_COMMITTED cpu_to_le32(0x0000010A)
+#define STATUS_NOTIFY_CLEANUP cpu_to_le32(0x0000010B)
+#define STATUS_NOTIFY_ENUM_DIR cpu_to_le32(0x0000010C)
+#define STATUS_NO_QUOTAS_FOR_ACCOUNT cpu_to_le32(0x0000010D)
+#define STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED cpu_to_le32(0x0000010E)
+#define STATUS_PAGE_FAULT_TRANSITION cpu_to_le32(0x00000110)
+#define STATUS_PAGE_FAULT_DEMAND_ZERO cpu_to_le32(0x00000111)
+#define STATUS_PAGE_FAULT_COPY_ON_WRITE cpu_to_le32(0x00000112)
+#define STATUS_PAGE_FAULT_GUARD_PAGE cpu_to_le32(0x00000113)
+#define STATUS_PAGE_FAULT_PAGING_FILE cpu_to_le32(0x00000114)
+#define STATUS_CACHE_PAGE_LOCKED cpu_to_le32(0x00000115)
+#define STATUS_CRASH_DUMP cpu_to_le32(0x00000116)
+#define STATUS_BUFFER_ALL_ZEROS cpu_to_le32(0x00000117)
+#define STATUS_REPARSE_OBJECT cpu_to_le32(0x00000118)
+#define STATUS_RESOURCE_REQUIREMENTS_CHANGED cpu_to_le32(0x00000119)
+#define STATUS_TRANSLATION_COMPLETE cpu_to_le32(0x00000120)
+#define STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY cpu_to_le32(0x00000121)
+#define STATUS_NOTHING_TO_TERMINATE cpu_to_le32(0x00000122)
+#define STATUS_PROCESS_NOT_IN_JOB cpu_to_le32(0x00000123)
+#define STATUS_PROCESS_IN_JOB cpu_to_le32(0x00000124)
+#define STATUS_VOLSNAP_HIBERNATE_READY cpu_to_le32(0x00000125)
+#define STATUS_FSFILTER_OP_COMPLETED_SUCCESSFULLY cpu_to_le32(0x00000126)
+#define STATUS_INTERRUPT_VECTOR_ALREADY_CONNECTED cpu_to_le32(0x00000127)
+#define STATUS_INTERRUPT_STILL_CONNECTED cpu_to_le32(0x00000128)
+#define STATUS_PROCESS_CLONED cpu_to_le32(0x00000129)
+#define STATUS_FILE_LOCKED_WITH_ONLY_READERS cpu_to_le32(0x0000012A)
+#define STATUS_FILE_LOCKED_WITH_WRITERS cpu_to_le32(0x0000012B)
+#define STATUS_RESOURCEMANAGER_READ_ONLY cpu_to_le32(0x00000202)
+#define STATUS_WAIT_FOR_OPLOCK cpu_to_le32(0x00000367)
+#define DBG_EXCEPTION_HANDLED cpu_to_le32(0x00010001)
+#define DBG_CONTINUE cpu_to_le32(0x00010002)
+#define STATUS_FLT_IO_COMPLETE cpu_to_le32(0x001C0001)
+#define STATUS_OBJECT_NAME_EXISTS cpu_to_le32(0x40000000)
+#define STATUS_THREAD_WAS_SUSPENDED cpu_to_le32(0x40000001)
+#define STATUS_WORKING_SET_LIMIT_RANGE cpu_to_le32(0x40000002)
+#define STATUS_IMAGE_NOT_AT_BASE cpu_to_le32(0x40000003)
+#define STATUS_RXACT_STATE_CREATED cpu_to_le32(0x40000004)
+#define STATUS_SEGMENT_NOTIFICATION cpu_to_le32(0x40000005)
+#define STATUS_LOCAL_USER_SESSION_KEY cpu_to_le32(0x40000006)
+#define STATUS_BAD_CURRENT_DIRECTORY cpu_to_le32(0x40000007)
+#define STATUS_SERIAL_MORE_WRITES cpu_to_le32(0x40000008)
+#define STATUS_REGISTRY_RECOVERED cpu_to_le32(0x40000009)
+#define STATUS_FT_READ_RECOVERY_FROM_BACKUP cpu_to_le32(0x4000000A)
+#define STATUS_FT_WRITE_RECOVERY cpu_to_le32(0x4000000B)
+#define STATUS_SERIAL_COUNTER_TIMEOUT cpu_to_le32(0x4000000C)
+#define STATUS_NULL_LM_PASSWORD cpu_to_le32(0x4000000D)
+#define STATUS_IMAGE_MACHINE_TYPE_MISMATCH cpu_to_le32(0x4000000E)
+#define STATUS_RECEIVE_PARTIAL cpu_to_le32(0x4000000F)
+#define STATUS_RECEIVE_EXPEDITED cpu_to_le32(0x40000010)
+#define STATUS_RECEIVE_PARTIAL_EXPEDITED cpu_to_le32(0x40000011)
+#define STATUS_EVENT_DONE cpu_to_le32(0x40000012)
+#define STATUS_EVENT_PENDING cpu_to_le32(0x40000013)
+#define STATUS_CHECKING_FILE_SYSTEM cpu_to_le32(0x40000014)
+#define STATUS_FATAL_APP_EXIT cpu_to_le32(0x40000015)
+#define STATUS_PREDEFINED_HANDLE cpu_to_le32(0x40000016)
+#define STATUS_WAS_UNLOCKED cpu_to_le32(0x40000017)
+#define STATUS_SERVICE_NOTIFICATION cpu_to_le32(0x40000018)
+#define STATUS_WAS_LOCKED cpu_to_le32(0x40000019)
+#define STATUS_LOG_HARD_ERROR cpu_to_le32(0x4000001A)
+#define STATUS_ALREADY_WIN32 cpu_to_le32(0x4000001B)
+#define STATUS_WX86_UNSIMULATE cpu_to_le32(0x4000001C)
+#define STATUS_WX86_CONTINUE cpu_to_le32(0x4000001D)
+#define STATUS_WX86_SINGLE_STEP cpu_to_le32(0x4000001E)
+#define STATUS_WX86_BREAKPOINT cpu_to_le32(0x4000001F)
+#define STATUS_WX86_EXCEPTION_CONTINUE cpu_to_le32(0x40000020)
+#define STATUS_WX86_EXCEPTION_LASTCHANCE cpu_to_le32(0x40000021)
+#define STATUS_WX86_EXCEPTION_CHAIN cpu_to_le32(0x40000022)
+#define STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE cpu_to_le32(0x40000023)
+#define STATUS_NO_YIELD_PERFORMED cpu_to_le32(0x40000024)
+#define STATUS_TIMER_RESUME_IGNORED cpu_to_le32(0x40000025)
+#define STATUS_ARBITRATION_UNHANDLED cpu_to_le32(0x40000026)
+#define STATUS_CARDBUS_NOT_SUPPORTED cpu_to_le32(0x40000027)
+#define STATUS_WX86_CREATEWX86TIB cpu_to_le32(0x40000028)
+#define STATUS_MP_PROCESSOR_MISMATCH cpu_to_le32(0x40000029)
+#define STATUS_HIBERNATED cpu_to_le32(0x4000002A)
+#define STATUS_RESUME_HIBERNATION cpu_to_le32(0x4000002B)
+#define STATUS_FIRMWARE_UPDATED cpu_to_le32(0x4000002C)
+#define STATUS_DRIVERS_LEAKING_LOCKED_PAGES cpu_to_le32(0x4000002D)
+#define STATUS_MESSAGE_RETRIEVED cpu_to_le32(0x4000002E)
+#define STATUS_SYSTEM_POWERSTATE_TRANSITION cpu_to_le32(0x4000002F)
+#define STATUS_ALPC_CHECK_COMPLETION_LIST cpu_to_le32(0x40000030)
+#define STATUS_SYSTEM_POWERSTATE_COMPLEX_TRANSITION cpu_to_le32(0x40000031)
+#define STATUS_ACCESS_AUDIT_BY_POLICY cpu_to_le32(0x40000032)
+#define STATUS_ABANDON_HIBERFILE cpu_to_le32(0x40000033)
+#define STATUS_BIZRULES_NOT_ENABLED cpu_to_le32(0x40000034)
+#define STATUS_WAKE_SYSTEM cpu_to_le32(0x40000294)
+#define STATUS_DS_SHUTTING_DOWN cpu_to_le32(0x40000370)
+#define DBG_REPLY_LATER cpu_to_le32(0x40010001)
+#define DBG_UNABLE_TO_PROVIDE_HANDLE cpu_to_le32(0x40010002)
+#define DBG_TERMINATE_THREAD cpu_to_le32(0x40010003)
+#define DBG_TERMINATE_PROCESS cpu_to_le32(0x40010004)
+#define DBG_CONTROL_C cpu_to_le32(0x40010005)
+#define DBG_PRINTEXCEPTION_C cpu_to_le32(0x40010006)
+#define DBG_RIPEXCEPTION cpu_to_le32(0x40010007)
+#define DBG_CONTROL_BREAK cpu_to_le32(0x40010008)
+#define DBG_COMMAND_EXCEPTION cpu_to_le32(0x40010009)
+#define RPC_NT_UUID_LOCAL_ONLY cpu_to_le32(0x40020056)
+#define RPC_NT_SEND_INCOMPLETE cpu_to_le32(0x400200AF)
+#define STATUS_CTX_CDM_CONNECT cpu_to_le32(0x400A0004)
+#define STATUS_CTX_CDM_DISCONNECT cpu_to_le32(0x400A0005)
+#define STATUS_SXS_RELEASE_ACTIVATION_CONTEXT cpu_to_le32(0x4015000D)
+#define STATUS_RECOVERY_NOT_NEEDED cpu_to_le32(0x40190034)
+#define STATUS_RM_ALREADY_STARTED cpu_to_le32(0x40190035)
+#define STATUS_LOG_NO_RESTART cpu_to_le32(0x401A000C)
+#define STATUS_VIDEO_DRIVER_DEBUG_REPORT_REQUEST cpu_to_le32(0x401B00EC)
+#define STATUS_GRAPHICS_PARTIAL_DATA_POPULATED cpu_to_le32(0x401E000A)
+#define STATUS_GRAPHICS_DRIVER_MISMATCH cpu_to_le32(0x401E0117)
+#define STATUS_GRAPHICS_MODE_NOT_PINNED cpu_to_le32(0x401E0307)
+#define STATUS_GRAPHICS_NO_PREFERRED_MODE cpu_to_le32(0x401E031E)
+#define STATUS_GRAPHICS_DATASET_IS_EMPTY cpu_to_le32(0x401E034B)
+#define STATUS_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET cpu_to_le32(0x401E034C)
+#define STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED	\
+	cpu_to_le32(0x401E0351)
+#define STATUS_GRAPHICS_UNKNOWN_CHILD_STATUS cpu_to_le32(0x401E042F)
+#define STATUS_GRAPHICS_LEADLINK_START_DEFERRED cpu_to_le32(0x401E0437)
+#define STATUS_GRAPHICS_POLLING_TOO_FREQUENTLY cpu_to_le32(0x401E0439)
+#define STATUS_GRAPHICS_START_DEFERRED cpu_to_le32(0x401E043A)
+#define STATUS_NDIS_INDICATION_REQUIRED cpu_to_le32(0x40230001)
+#define STATUS_GUARD_PAGE_VIOLATION cpu_to_le32(0x80000001)
+#define STATUS_DATATYPE_MISALIGNMENT cpu_to_le32(0x80000002)
+#define STATUS_BREAKPOINT cpu_to_le32(0x80000003)
+#define STATUS_SINGLE_STEP cpu_to_le32(0x80000004)
+#define STATUS_BUFFER_OVERFLOW cpu_to_le32(0x80000005)
+#define STATUS_NO_MORE_FILES cpu_to_le32(0x80000006)
+#define STATUS_WAKE_SYSTEM_DEBUGGER cpu_to_le32(0x80000007)
+#define STATUS_HANDLES_CLOSED cpu_to_le32(0x8000000A)
+#define STATUS_NO_INHERITANCE cpu_to_le32(0x8000000B)
+#define STATUS_GUID_SUBSTITUTION_MADE cpu_to_le32(0x8000000C)
+#define STATUS_PARTIAL_COPY cpu_to_le32(0x8000000D)
+#define STATUS_DEVICE_PAPER_EMPTY cpu_to_le32(0x8000000E)
+#define STATUS_DEVICE_POWERED_OFF cpu_to_le32(0x8000000F)
+#define STATUS_DEVICE_OFF_LINE cpu_to_le32(0x80000010)
+#define STATUS_DEVICE_BUSY cpu_to_le32(0x80000011)
+#define STATUS_NO_MORE_EAS cpu_to_le32(0x80000012)
+#define STATUS_INVALID_EA_NAME cpu_to_le32(0x80000013)
+#define STATUS_EA_LIST_INCONSISTENT cpu_to_le32(0x80000014)
+#define STATUS_INVALID_EA_FLAG cpu_to_le32(0x80000015)
+#define STATUS_VERIFY_REQUIRED cpu_to_le32(0x80000016)
+#define STATUS_EXTRANEOUS_INFORMATION cpu_to_le32(0x80000017)
+#define STATUS_RXACT_COMMIT_NECESSARY cpu_to_le32(0x80000018)
+#define STATUS_NO_MORE_ENTRIES cpu_to_le32(0x8000001A)
+#define STATUS_FILEMARK_DETECTED cpu_to_le32(0x8000001B)
+#define STATUS_MEDIA_CHANGED cpu_to_le32(0x8000001C)
+#define STATUS_BUS_RESET cpu_to_le32(0x8000001D)
+#define STATUS_END_OF_MEDIA cpu_to_le32(0x8000001E)
+#define STATUS_BEGINNING_OF_MEDIA cpu_to_le32(0x8000001F)
+#define STATUS_MEDIA_CHECK cpu_to_le32(0x80000020)
+#define STATUS_SETMARK_DETECTED cpu_to_le32(0x80000021)
+#define STATUS_NO_DATA_DETECTED cpu_to_le32(0x80000022)
+#define STATUS_REDIRECTOR_HAS_OPEN_HANDLES cpu_to_le32(0x80000023)
+#define STATUS_SERVER_HAS_OPEN_HANDLES cpu_to_le32(0x80000024)
+#define STATUS_ALREADY_DISCONNECTED cpu_to_le32(0x80000025)
+#define STATUS_LONGJUMP cpu_to_le32(0x80000026)
+#define STATUS_CLEANER_CARTRIDGE_INSTALLED cpu_to_le32(0x80000027)
+#define STATUS_PLUGPLAY_QUERY_VETOED cpu_to_le32(0x80000028)
+#define STATUS_UNWIND_CONSOLIDATE cpu_to_le32(0x80000029)
+#define STATUS_REGISTRY_HIVE_RECOVERED cpu_to_le32(0x8000002A)
+#define STATUS_DLL_MIGHT_BE_INSECURE cpu_to_le32(0x8000002B)
+#define STATUS_DLL_MIGHT_BE_INCOMPATIBLE cpu_to_le32(0x8000002C)
+#define STATUS_STOPPED_ON_SYMLINK cpu_to_le32(0x8000002D)
+#define STATUS_DEVICE_REQUIRES_CLEANING cpu_to_le32(0x80000288)
+#define STATUS_DEVICE_DOOR_OPEN cpu_to_le32(0x80000289)
+#define STATUS_DATA_LOST_REPAIR cpu_to_le32(0x80000803)
+#define DBG_EXCEPTION_NOT_HANDLED cpu_to_le32(0x80010001)
+#define STATUS_CLUSTER_NODE_ALREADY_UP cpu_to_le32(0x80130001)
+#define STATUS_CLUSTER_NODE_ALREADY_DOWN cpu_to_le32(0x80130002)
+#define STATUS_CLUSTER_NETWORK_ALREADY_ONLINE cpu_to_le32(0x80130003)
+#define STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE cpu_to_le32(0x80130004)
+#define STATUS_CLUSTER_NODE_ALREADY_MEMBER cpu_to_le32(0x80130005)
+#define STATUS_COULD_NOT_RESIZE_LOG cpu_to_le32(0x80190009)
+#define STATUS_NO_TXF_METADATA cpu_to_le32(0x80190029)
+#define STATUS_CANT_RECOVER_WITH_HANDLE_OPEN cpu_to_le32(0x80190031)
+#define STATUS_TXF_METADATA_ALREADY_PRESENT cpu_to_le32(0x80190041)
+#define STATUS_TRANSACTION_SCOPE_CALLBACKS_NOT_SET cpu_to_le32(0x80190042)
+#define STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD_RECOVERED	\
+	cpu_to_le32(0x801B00EB)
+#define STATUS_FLT_BUFFER_TOO_SMALL cpu_to_le32(0x801C0001)
+#define STATUS_FVE_PARTIAL_METADATA cpu_to_le32(0x80210001)
+#define STATUS_UNSUCCESSFUL cpu_to_le32(0xC0000001)
+#define STATUS_NOT_IMPLEMENTED cpu_to_le32(0xC0000002)
+#define STATUS_INVALID_INFO_CLASS cpu_to_le32(0xC0000003)
+#define STATUS_INFO_LENGTH_MISMATCH cpu_to_le32(0xC0000004)
+#define STATUS_ACCESS_VIOLATION cpu_to_le32(0xC0000005)
+#define STATUS_IN_PAGE_ERROR cpu_to_le32(0xC0000006)
+#define STATUS_PAGEFILE_QUOTA cpu_to_le32(0xC0000007)
+#define STATUS_INVALID_HANDLE cpu_to_le32(0xC0000008)
+#define STATUS_BAD_INITIAL_STACK cpu_to_le32(0xC0000009)
+#define STATUS_BAD_INITIAL_PC cpu_to_le32(0xC000000A)
+#define STATUS_INVALID_CID cpu_to_le32(0xC000000B)
+#define STATUS_TIMER_NOT_CANCELED cpu_to_le32(0xC000000C)
+#define STATUS_INVALID_PARAMETER cpu_to_le32(0xC000000D)
+#define STATUS_NO_SUCH_DEVICE cpu_to_le32(0xC000000E)
+#define STATUS_NO_SUCH_FILE cpu_to_le32(0xC000000F)
+#define STATUS_INVALID_DEVICE_REQUEST cpu_to_le32(0xC0000010)
+#define STATUS_END_OF_FILE cpu_to_le32(0xC0000011)
+#define STATUS_WRONG_VOLUME cpu_to_le32(0xC0000012)
+#define STATUS_NO_MEDIA_IN_DEVICE cpu_to_le32(0xC0000013)
+#define STATUS_UNRECOGNIZED_MEDIA cpu_to_le32(0xC0000014)
+#define STATUS_NONEXISTENT_SECTOR cpu_to_le32(0xC0000015)
+#define STATUS_MORE_PROCESSING_REQUIRED cpu_to_le32(0xC0000016)
+#define STATUS_NO_MEMORY cpu_to_le32(0xC0000017)
+#define STATUS_CONFLICTING_ADDRESSES cpu_to_le32(0xC0000018)
+#define STATUS_NOT_MAPPED_VIEW cpu_to_le32(0xC0000019)
+#define STATUS_UNABLE_TO_FREE_VM cpu_to_le32(0xC000001A)
+#define STATUS_UNABLE_TO_DELETE_SECTION cpu_to_le32(0xC000001B)
+#define STATUS_INVALID_SYSTEM_SERVICE cpu_to_le32(0xC000001C)
+#define STATUS_ILLEGAL_INSTRUCTION cpu_to_le32(0xC000001D)
+#define STATUS_INVALID_LOCK_SEQUENCE cpu_to_le32(0xC000001E)
+#define STATUS_INVALID_VIEW_SIZE cpu_to_le32(0xC000001F)
+#define STATUS_INVALID_FILE_FOR_SECTION cpu_to_le32(0xC0000020)
+#define STATUS_ALREADY_COMMITTED cpu_to_le32(0xC0000021)
+#define STATUS_ACCESS_DENIED cpu_to_le32(0xC0000022)
+#define STATUS_BUFFER_TOO_SMALL cpu_to_le32(0xC0000023)
+#define STATUS_OBJECT_TYPE_MISMATCH cpu_to_le32(0xC0000024)
+#define STATUS_NONCONTINUABLE_EXCEPTION cpu_to_le32(0xC0000025)
+#define STATUS_INVALID_DISPOSITION cpu_to_le32(0xC0000026)
+#define STATUS_UNWIND cpu_to_le32(0xC0000027)
+#define STATUS_BAD_STACK cpu_to_le32(0xC0000028)
+#define STATUS_INVALID_UNWIND_TARGET cpu_to_le32(0xC0000029)
+#define STATUS_NOT_LOCKED cpu_to_le32(0xC000002A)
+#define STATUS_PARITY_ERROR cpu_to_le32(0xC000002B)
+#define STATUS_UNABLE_TO_DECOMMIT_VM cpu_to_le32(0xC000002C)
+#define STATUS_NOT_COMMITTED cpu_to_le32(0xC000002D)
+#define STATUS_INVALID_PORT_ATTRIBUTES cpu_to_le32(0xC000002E)
+#define STATUS_PORT_MESSAGE_TOO_LONG cpu_to_le32(0xC000002F)
+#define STATUS_INVALID_PARAMETER_MIX cpu_to_le32(0xC0000030)
+#define STATUS_INVALID_QUOTA_LOWER cpu_to_le32(0xC0000031)
+#define STATUS_DISK_CORRUPT_ERROR cpu_to_le32(0xC0000032)
+#define STATUS_OBJECT_NAME_INVALID cpu_to_le32(0xC0000033)
+#define STATUS_OBJECT_NAME_NOT_FOUND cpu_to_le32(0xC0000034)
+#define STATUS_OBJECT_NAME_COLLISION cpu_to_le32(0xC0000035)
+#define STATUS_PORT_DISCONNECTED cpu_to_le32(0xC0000037)
+#define STATUS_DEVICE_ALREADY_ATTACHED cpu_to_le32(0xC0000038)
+#define STATUS_OBJECT_PATH_INVALID cpu_to_le32(0xC0000039)
+#define STATUS_OBJECT_PATH_NOT_FOUND cpu_to_le32(0xC000003A)
+#define STATUS_OBJECT_PATH_SYNTAX_BAD cpu_to_le32(0xC000003B)
+#define STATUS_DATA_OVERRUN cpu_to_le32(0xC000003C)
+#define STATUS_DATA_LATE_ERROR cpu_to_le32(0xC000003D)
+#define STATUS_DATA_ERROR cpu_to_le32(0xC000003E)
+#define STATUS_CRC_ERROR cpu_to_le32(0xC000003F)
+#define STATUS_SECTION_TOO_BIG cpu_to_le32(0xC0000040)
+#define STATUS_PORT_CONNECTION_REFUSED cpu_to_le32(0xC0000041)
+#define STATUS_INVALID_PORT_HANDLE cpu_to_le32(0xC0000042)
+#define STATUS_SHARING_VIOLATION cpu_to_le32(0xC0000043)
+#define STATUS_QUOTA_EXCEEDED cpu_to_le32(0xC0000044)
+#define STATUS_INVALID_PAGE_PROTECTION cpu_to_le32(0xC0000045)
+#define STATUS_MUTANT_NOT_OWNED cpu_to_le32(0xC0000046)
+#define STATUS_SEMAPHORE_LIMIT_EXCEEDED cpu_to_le32(0xC0000047)
+#define STATUS_PORT_ALREADY_SET cpu_to_le32(0xC0000048)
+#define STATUS_SECTION_NOT_IMAGE cpu_to_le32(0xC0000049)
+#define STATUS_SUSPEND_COUNT_EXCEEDED cpu_to_le32(0xC000004A)
+#define STATUS_THREAD_IS_TERMINATING cpu_to_le32(0xC000004B)
+#define STATUS_BAD_WORKING_SET_LIMIT cpu_to_le32(0xC000004C)
+#define STATUS_INCOMPATIBLE_FILE_MAP cpu_to_le32(0xC000004D)
+#define STATUS_SECTION_PROTECTION cpu_to_le32(0xC000004E)
+#define STATUS_EAS_NOT_SUPPORTED cpu_to_le32(0xC000004F)
+#define STATUS_EA_TOO_LARGE cpu_to_le32(0xC0000050)
+#define STATUS_NONEXISTENT_EA_ENTRY cpu_to_le32(0xC0000051)
+#define STATUS_NO_EAS_ON_FILE cpu_to_le32(0xC0000052)
+#define STATUS_EA_CORRUPT_ERROR cpu_to_le32(0xC0000053)
+#define STATUS_FILE_LOCK_CONFLICT cpu_to_le32(0xC0000054)
+#define STATUS_LOCK_NOT_GRANTED cpu_to_le32(0xC0000055)
+#define STATUS_DELETE_PENDING cpu_to_le32(0xC0000056)
+#define STATUS_CTL_FILE_NOT_SUPPORTED cpu_to_le32(0xC0000057)
+#define STATUS_UNKNOWN_REVISION cpu_to_le32(0xC0000058)
+#define STATUS_REVISION_MISMATCH cpu_to_le32(0xC0000059)
+#define STATUS_INVALID_OWNER cpu_to_le32(0xC000005A)
+#define STATUS_INVALID_PRIMARY_GROUP cpu_to_le32(0xC000005B)
+#define STATUS_NO_IMPERSONATION_TOKEN cpu_to_le32(0xC000005C)
+#define STATUS_CANT_DISABLE_MANDATORY cpu_to_le32(0xC000005D)
+#define STATUS_NO_LOGON_SERVERS cpu_to_le32(0xC000005E)
+#define STATUS_NO_SUCH_LOGON_SESSION cpu_to_le32(0xC000005F)
+#define STATUS_NO_SUCH_PRIVILEGE cpu_to_le32(0xC0000060)
+#define STATUS_PRIVILEGE_NOT_HELD cpu_to_le32(0xC0000061)
+#define STATUS_INVALID_ACCOUNT_NAME cpu_to_le32(0xC0000062)
+#define STATUS_USER_EXISTS cpu_to_le32(0xC0000063)
+#define STATUS_NO_SUCH_USER cpu_to_le32(0xC0000064)
+#define STATUS_GROUP_EXISTS cpu_to_le32(0xC0000065)
+#define STATUS_NO_SUCH_GROUP cpu_to_le32(0xC0000066)
+#define STATUS_MEMBER_IN_GROUP cpu_to_le32(0xC0000067)
+#define STATUS_MEMBER_NOT_IN_GROUP cpu_to_le32(0xC0000068)
+#define STATUS_LAST_ADMIN cpu_to_le32(0xC0000069)
+#define STATUS_WRONG_PASSWORD cpu_to_le32(0xC000006A)
+#define STATUS_ILL_FORMED_PASSWORD cpu_to_le32(0xC000006B)
+#define STATUS_PASSWORD_RESTRICTION cpu_to_le32(0xC000006C)
+#define STATUS_LOGON_FAILURE cpu_to_le32(0xC000006D)
+#define STATUS_ACCOUNT_RESTRICTION cpu_to_le32(0xC000006E)
+#define STATUS_INVALID_LOGON_HOURS cpu_to_le32(0xC000006F)
+#define STATUS_INVALID_WORKSTATION cpu_to_le32(0xC0000070)
+#define STATUS_PASSWORD_EXPIRED cpu_to_le32(0xC0000071)
+#define STATUS_ACCOUNT_DISABLED cpu_to_le32(0xC0000072)
+#define STATUS_NONE_MAPPED cpu_to_le32(0xC0000073)
+#define STATUS_TOO_MANY_LUIDS_REQUESTED cpu_to_le32(0xC0000074)
+#define STATUS_LUIDS_EXHAUSTED cpu_to_le32(0xC0000075)
+#define STATUS_INVALID_SUB_AUTHORITY cpu_to_le32(0xC0000076)
+#define STATUS_INVALID_ACL cpu_to_le32(0xC0000077)
+#define STATUS_INVALID_SID cpu_to_le32(0xC0000078)
+#define STATUS_INVALID_SECURITY_DESCR cpu_to_le32(0xC0000079)
+#define STATUS_PROCEDURE_NOT_FOUND cpu_to_le32(0xC000007A)
+#define STATUS_INVALID_IMAGE_FORMAT cpu_to_le32(0xC000007B)
+#define STATUS_NO_TOKEN cpu_to_le32(0xC000007C)
+#define STATUS_BAD_INHERITANCE_ACL cpu_to_le32(0xC000007D)
+#define STATUS_RANGE_NOT_LOCKED cpu_to_le32(0xC000007E)
+#define STATUS_DISK_FULL cpu_to_le32(0xC000007F)
+#define STATUS_SERVER_DISABLED cpu_to_le32(0xC0000080)
+#define STATUS_SERVER_NOT_DISABLED cpu_to_le32(0xC0000081)
+#define STATUS_TOO_MANY_GUIDS_REQUESTED cpu_to_le32(0xC0000082)
+#define STATUS_GUIDS_EXHAUSTED cpu_to_le32(0xC0000083)
+#define STATUS_INVALID_ID_AUTHORITY cpu_to_le32(0xC0000084)
+#define STATUS_AGENTS_EXHAUSTED cpu_to_le32(0xC0000085)
+#define STATUS_INVALID_VOLUME_LABEL cpu_to_le32(0xC0000086)
+#define STATUS_SECTION_NOT_EXTENDED cpu_to_le32(0xC0000087)
+#define STATUS_NOT_MAPPED_DATA cpu_to_le32(0xC0000088)
+#define STATUS_RESOURCE_DATA_NOT_FOUND cpu_to_le32(0xC0000089)
+#define STATUS_RESOURCE_TYPE_NOT_FOUND cpu_to_le32(0xC000008A)
+#define STATUS_RESOURCE_NAME_NOT_FOUND cpu_to_le32(0xC000008B)
+#define STATUS_ARRAY_BOUNDS_EXCEEDED cpu_to_le32(0xC000008C)
+#define STATUS_FLOAT_DENORMAL_OPERAND cpu_to_le32(0xC000008D)
+#define STATUS_FLOAT_DIVIDE_BY_ZERO cpu_to_le32(0xC000008E)
+#define STATUS_FLOAT_INEXACT_RESULT cpu_to_le32(0xC000008F)
+#define STATUS_FLOAT_INVALID_OPERATION cpu_to_le32(0xC0000090)
+#define STATUS_FLOAT_OVERFLOW cpu_to_le32(0xC0000091)
+#define STATUS_FLOAT_STACK_CHECK cpu_to_le32(0xC0000092)
+#define STATUS_FLOAT_UNDERFLOW cpu_to_le32(0xC0000093)
+#define STATUS_INTEGER_DIVIDE_BY_ZERO cpu_to_le32(0xC0000094)
+#define STATUS_INTEGER_OVERFLOW cpu_to_le32(0xC0000095)
+#define STATUS_PRIVILEGED_INSTRUCTION cpu_to_le32(0xC0000096)
+#define STATUS_TOO_MANY_PAGING_FILES cpu_to_le32(0xC0000097)
+#define STATUS_FILE_INVALID cpu_to_le32(0xC0000098)
+#define STATUS_ALLOTTED_SPACE_EXCEEDED cpu_to_le32(0xC0000099)
+#define STATUS_INSUFFICIENT_RESOURCES cpu_to_le32(0xC000009A)
+#define STATUS_DFS_EXIT_PATH_FOUND cpu_to_le32(0xC000009B)
+#define STATUS_DEVICE_DATA_ERROR cpu_to_le32(0xC000009C)
+#define STATUS_DEVICE_NOT_CONNECTED cpu_to_le32(0xC000009D)
+#define STATUS_DEVICE_POWER_FAILURE cpu_to_le32(0xC000009E)
+#define STATUS_FREE_VM_NOT_AT_BASE cpu_to_le32(0xC000009F)
+#define STATUS_MEMORY_NOT_ALLOCATED cpu_to_le32(0xC00000A0)
+#define STATUS_WORKING_SET_QUOTA cpu_to_le32(0xC00000A1)
+#define STATUS_MEDIA_WRITE_PROTECTED cpu_to_le32(0xC00000A2)
+#define STATUS_DEVICE_NOT_READY cpu_to_le32(0xC00000A3)
+#define STATUS_INVALID_GROUP_ATTRIBUTES cpu_to_le32(0xC00000A4)
+#define STATUS_BAD_IMPERSONATION_LEVEL cpu_to_le32(0xC00000A5)
+#define STATUS_CANT_OPEN_ANONYMOUS cpu_to_le32(0xC00000A6)
+#define STATUS_BAD_VALIDATION_CLASS cpu_to_le32(0xC00000A7)
+#define STATUS_BAD_TOKEN_TYPE cpu_to_le32(0xC00000A8)
+#define STATUS_BAD_MASTER_BOOT_RECORD cpu_to_le32(0xC00000A9)
+#define STATUS_INSTRUCTION_MISALIGNMENT cpu_to_le32(0xC00000AA)
+#define STATUS_INSTANCE_NOT_AVAILABLE cpu_to_le32(0xC00000AB)
+#define STATUS_PIPE_NOT_AVAILABLE cpu_to_le32(0xC00000AC)
+#define STATUS_INVALID_PIPE_STATE cpu_to_le32(0xC00000AD)
+#define STATUS_PIPE_BUSY cpu_to_le32(0xC00000AE)
+#define STATUS_ILLEGAL_FUNCTION cpu_to_le32(0xC00000AF)
+#define STATUS_PIPE_DISCONNECTED cpu_to_le32(0xC00000B0)
+#define STATUS_PIPE_CLOSING cpu_to_le32(0xC00000B1)
+#define STATUS_PIPE_CONNECTED cpu_to_le32(0xC00000B2)
+#define STATUS_PIPE_LISTENING cpu_to_le32(0xC00000B3)
+#define STATUS_INVALID_READ_MODE cpu_to_le32(0xC00000B4)
+#define STATUS_IO_TIMEOUT cpu_to_le32(0xC00000B5)
+#define STATUS_FILE_FORCED_CLOSED cpu_to_le32(0xC00000B6)
+#define STATUS_PROFILING_NOT_STARTED cpu_to_le32(0xC00000B7)
+#define STATUS_PROFILING_NOT_STOPPED cpu_to_le32(0xC00000B8)
+#define STATUS_COULD_NOT_INTERPRET cpu_to_le32(0xC00000B9)
+#define STATUS_FILE_IS_A_DIRECTORY cpu_to_le32(0xC00000BA)
+#define STATUS_NOT_SUPPORTED cpu_to_le32(0xC00000BB)
+#define STATUS_REMOTE_NOT_LISTENING cpu_to_le32(0xC00000BC)
+#define STATUS_DUPLICATE_NAME cpu_to_le32(0xC00000BD)
+#define STATUS_BAD_NETWORK_PATH cpu_to_le32(0xC00000BE)
+#define STATUS_NETWORK_BUSY cpu_to_le32(0xC00000BF)
+#define STATUS_DEVICE_DOES_NOT_EXIST cpu_to_le32(0xC00000C0)
+#define STATUS_TOO_MANY_COMMANDS cpu_to_le32(0xC00000C1)
+#define STATUS_ADAPTER_HARDWARE_ERROR cpu_to_le32(0xC00000C2)
+#define STATUS_INVALID_NETWORK_RESPONSE cpu_to_le32(0xC00000C3)
+#define STATUS_UNEXPECTED_NETWORK_ERROR cpu_to_le32(0xC00000C4)
+#define STATUS_BAD_REMOTE_ADAPTER cpu_to_le32(0xC00000C5)
+#define STATUS_PRINT_QUEUE_FULL cpu_to_le32(0xC00000C6)
+#define STATUS_NO_SPOOL_SPACE cpu_to_le32(0xC00000C7)
+#define STATUS_PRINT_CANCELLED cpu_to_le32(0xC00000C8)
+#define STATUS_NETWORK_NAME_DELETED cpu_to_le32(0xC00000C9)
+#define STATUS_NETWORK_ACCESS_DENIED cpu_to_le32(0xC00000CA)
+#define STATUS_BAD_DEVICE_TYPE cpu_to_le32(0xC00000CB)
+#define STATUS_BAD_NETWORK_NAME cpu_to_le32(0xC00000CC)
+#define STATUS_TOO_MANY_NAMES cpu_to_le32(0xC00000CD)
+#define STATUS_TOO_MANY_SESSIONS cpu_to_le32(0xC00000CE)
+#define STATUS_SHARING_PAUSED cpu_to_le32(0xC00000CF)
+#define STATUS_REQUEST_NOT_ACCEPTED cpu_to_le32(0xC00000D0)
+#define STATUS_REDIRECTOR_PAUSED cpu_to_le32(0xC00000D1)
+#define STATUS_NET_WRITE_FAULT cpu_to_le32(0xC00000D2)
+#define STATUS_PROFILING_AT_LIMIT cpu_to_le32(0xC00000D3)
+#define STATUS_NOT_SAME_DEVICE cpu_to_le32(0xC00000D4)
+#define STATUS_FILE_RENAMED cpu_to_le32(0xC00000D5)
+#define STATUS_VIRTUAL_CIRCUIT_CLOSED cpu_to_le32(0xC00000D6)
+#define STATUS_NO_SECURITY_ON_OBJECT cpu_to_le32(0xC00000D7)
+#define STATUS_CANT_WAIT cpu_to_le32(0xC00000D8)
+#define STATUS_PIPE_EMPTY cpu_to_le32(0xC00000D9)
+#define STATUS_CANT_ACCESS_DOMAIN_INFO cpu_to_le32(0xC00000DA)
+#define STATUS_CANT_TERMINATE_SELF cpu_to_le32(0xC00000DB)
+#define STATUS_INVALID_SERVER_STATE cpu_to_le32(0xC00000DC)
+#define STATUS_INVALID_DOMAIN_STATE cpu_to_le32(0xC00000DD)
+#define STATUS_INVALID_DOMAIN_ROLE cpu_to_le32(0xC00000DE)
+#define STATUS_NO_SUCH_DOMAIN cpu_to_le32(0xC00000DF)
+#define STATUS_DOMAIN_EXISTS cpu_to_le32(0xC00000E0)
+#define STATUS_DOMAIN_LIMIT_EXCEEDED cpu_to_le32(0xC00000E1)
+#define STATUS_OPLOCK_NOT_GRANTED cpu_to_le32(0xC00000E2)
+#define STATUS_INVALID_OPLOCK_PROTOCOL cpu_to_le32(0xC00000E3)
+#define STATUS_INTERNAL_DB_CORRUPTION cpu_to_le32(0xC00000E4)
+#define STATUS_INTERNAL_ERROR cpu_to_le32(0xC00000E5)
+#define STATUS_GENERIC_NOT_MAPPED cpu_to_le32(0xC00000E6)
+#define STATUS_BAD_DESCRIPTOR_FORMAT cpu_to_le32(0xC00000E7)
+#define STATUS_INVALID_USER_BUFFER cpu_to_le32(0xC00000E8)
+#define STATUS_UNEXPECTED_IO_ERROR cpu_to_le32(0xC00000E9)
+#define STATUS_UNEXPECTED_MM_CREATE_ERR cpu_to_le32(0xC00000EA)
+#define STATUS_UNEXPECTED_MM_MAP_ERROR cpu_to_le32(0xC00000EB)
+#define STATUS_UNEXPECTED_MM_EXTEND_ERR cpu_to_le32(0xC00000EC)
+#define STATUS_NOT_LOGON_PROCESS cpu_to_le32(0xC00000ED)
+#define STATUS_LOGON_SESSION_EXISTS cpu_to_le32(0xC00000EE)
+#define STATUS_INVALID_PARAMETER_1 cpu_to_le32(0xC00000EF)
+#define STATUS_INVALID_PARAMETER_2 cpu_to_le32(0xC00000F0)
+#define STATUS_INVALID_PARAMETER_3 cpu_to_le32(0xC00000F1)
+#define STATUS_INVALID_PARAMETER_4 cpu_to_le32(0xC00000F2)
+#define STATUS_INVALID_PARAMETER_5 cpu_to_le32(0xC00000F3)
+#define STATUS_INVALID_PARAMETER_6 cpu_to_le32(0xC00000F4)
+#define STATUS_INVALID_PARAMETER_7 cpu_to_le32(0xC00000F5)
+#define STATUS_INVALID_PARAMETER_8 cpu_to_le32(0xC00000F6)
+#define STATUS_INVALID_PARAMETER_9 cpu_to_le32(0xC00000F7)
+#define STATUS_INVALID_PARAMETER_10 cpu_to_le32(0xC00000F8)
+#define STATUS_INVALID_PARAMETER_11 cpu_to_le32(0xC00000F9)
+#define STATUS_INVALID_PARAMETER_12 cpu_to_le32(0xC00000FA)
+#define STATUS_REDIRECTOR_NOT_STARTED cpu_to_le32(0xC00000FB)
+#define STATUS_REDIRECTOR_STARTED cpu_to_le32(0xC00000FC)
+#define STATUS_STACK_OVERFLOW cpu_to_le32(0xC00000FD)
+#define STATUS_NO_SUCH_PACKAGE cpu_to_le32(0xC00000FE)
+#define STATUS_BAD_FUNCTION_TABLE cpu_to_le32(0xC00000FF)
+#define STATUS_VARIABLE_NOT_FOUND cpu_to_le32(0xC0000100)
+#define STATUS_DIRECTORY_NOT_EMPTY cpu_to_le32(0xC0000101)
+#define STATUS_FILE_CORRUPT_ERROR cpu_to_le32(0xC0000102)
+#define STATUS_NOT_A_DIRECTORY cpu_to_le32(0xC0000103)
+#define STATUS_BAD_LOGON_SESSION_STATE cpu_to_le32(0xC0000104)
+#define STATUS_LOGON_SESSION_COLLISION cpu_to_le32(0xC0000105)
+#define STATUS_NAME_TOO_LONG cpu_to_le32(0xC0000106)
+#define STATUS_FILES_OPEN cpu_to_le32(0xC0000107)
+#define STATUS_CONNECTION_IN_USE cpu_to_le32(0xC0000108)
+#define STATUS_MESSAGE_NOT_FOUND cpu_to_le32(0xC0000109)
+#define STATUS_PROCESS_IS_TERMINATING cpu_to_le32(0xC000010A)
+#define STATUS_INVALID_LOGON_TYPE cpu_to_le32(0xC000010B)
+#define STATUS_NO_GUID_TRANSLATION cpu_to_le32(0xC000010C)
+#define STATUS_CANNOT_IMPERSONATE cpu_to_le32(0xC000010D)
+#define STATUS_IMAGE_ALREADY_LOADED cpu_to_le32(0xC000010E)
+#define STATUS_ABIOS_NOT_PRESENT cpu_to_le32(0xC000010F)
+#define STATUS_ABIOS_LID_NOT_EXIST cpu_to_le32(0xC0000110)
+#define STATUS_ABIOS_LID_ALREADY_OWNED cpu_to_le32(0xC0000111)
+#define STATUS_ABIOS_NOT_LID_OWNER cpu_to_le32(0xC0000112)
+#define STATUS_ABIOS_INVALID_COMMAND cpu_to_le32(0xC0000113)
+#define STATUS_ABIOS_INVALID_LID cpu_to_le32(0xC0000114)
+#define STATUS_ABIOS_SELECTOR_NOT_AVAILABLE cpu_to_le32(0xC0000115)
+#define STATUS_ABIOS_INVALID_SELECTOR cpu_to_le32(0xC0000116)
+#define STATUS_NO_LDT cpu_to_le32(0xC0000117)
+#define STATUS_INVALID_LDT_SIZE cpu_to_le32(0xC0000118)
+#define STATUS_INVALID_LDT_OFFSET cpu_to_le32(0xC0000119)
+#define STATUS_INVALID_LDT_DESCRIPTOR cpu_to_le32(0xC000011A)
+#define STATUS_INVALID_IMAGE_NE_FORMAT cpu_to_le32(0xC000011B)
+#define STATUS_RXACT_INVALID_STATE cpu_to_le32(0xC000011C)
+#define STATUS_RXACT_COMMIT_FAILURE cpu_to_le32(0xC000011D)
+#define STATUS_MAPPED_FILE_SIZE_ZERO cpu_to_le32(0xC000011E)
+#define STATUS_TOO_MANY_OPENED_FILES cpu_to_le32(0xC000011F)
+#define STATUS_CANCELLED cpu_to_le32(0xC0000120)
+#define STATUS_CANNOT_DELETE cpu_to_le32(0xC0000121)
+#define STATUS_INVALID_COMPUTER_NAME cpu_to_le32(0xC0000122)
+#define STATUS_FILE_DELETED cpu_to_le32(0xC0000123)
+#define STATUS_SPECIAL_ACCOUNT cpu_to_le32(0xC0000124)
+#define STATUS_SPECIAL_GROUP cpu_to_le32(0xC0000125)
+#define STATUS_SPECIAL_USER cpu_to_le32(0xC0000126)
+#define STATUS_MEMBERS_PRIMARY_GROUP cpu_to_le32(0xC0000127)
+#define STATUS_FILE_CLOSED cpu_to_le32(0xC0000128)
+#define STATUS_TOO_MANY_THREADS cpu_to_le32(0xC0000129)
+#define STATUS_THREAD_NOT_IN_PROCESS cpu_to_le32(0xC000012A)
+#define STATUS_TOKEN_ALREADY_IN_USE cpu_to_le32(0xC000012B)
+#define STATUS_PAGEFILE_QUOTA_EXCEEDED cpu_to_le32(0xC000012C)
+#define STATUS_COMMITMENT_LIMIT cpu_to_le32(0xC000012D)
+#define STATUS_INVALID_IMAGE_LE_FORMAT cpu_to_le32(0xC000012E)
+#define STATUS_INVALID_IMAGE_NOT_MZ cpu_to_le32(0xC000012F)
+#define STATUS_INVALID_IMAGE_PROTECT cpu_to_le32(0xC0000130)
+#define STATUS_INVALID_IMAGE_WIN_16 cpu_to_le32(0xC0000131)
+#define STATUS_LOGON_SERVER_CONFLICT cpu_to_le32(0xC0000132)
+#define STATUS_TIME_DIFFERENCE_AT_DC cpu_to_le32(0xC0000133)
+#define STATUS_SYNCHRONIZATION_REQUIRED cpu_to_le32(0xC0000134)
+#define STATUS_DLL_NOT_FOUND cpu_to_le32(0xC0000135)
+#define STATUS_OPEN_FAILED cpu_to_le32(0xC0000136)
+#define STATUS_IO_PRIVILEGE_FAILED cpu_to_le32(0xC0000137)
+#define STATUS_ORDINAL_NOT_FOUND cpu_to_le32(0xC0000138)
+#define STATUS_ENTRYPOINT_NOT_FOUND cpu_to_le32(0xC0000139)
+#define STATUS_CONTROL_C_EXIT cpu_to_le32(0xC000013A)
+#define STATUS_LOCAL_DISCONNECT cpu_to_le32(0xC000013B)
+#define STATUS_REMOTE_DISCONNECT cpu_to_le32(0xC000013C)
+#define STATUS_REMOTE_RESOURCES cpu_to_le32(0xC000013D)
+#define STATUS_LINK_FAILED cpu_to_le32(0xC000013E)
+#define STATUS_LINK_TIMEOUT cpu_to_le32(0xC000013F)
+#define STATUS_INVALID_CONNECTION cpu_to_le32(0xC0000140)
+#define STATUS_INVALID_ADDRESS cpu_to_le32(0xC0000141)
+#define STATUS_DLL_INIT_FAILED cpu_to_le32(0xC0000142)
+#define STATUS_MISSING_SYSTEMFILE cpu_to_le32(0xC0000143)
+#define STATUS_UNHANDLED_EXCEPTION cpu_to_le32(0xC0000144)
+#define STATUS_APP_INIT_FAILURE cpu_to_le32(0xC0000145)
+#define STATUS_PAGEFILE_CREATE_FAILED cpu_to_le32(0xC0000146)
+#define STATUS_NO_PAGEFILE cpu_to_le32(0xC0000147)
+#define STATUS_INVALID_LEVEL cpu_to_le32(0xC0000148)
+#define STATUS_WRONG_PASSWORD_CORE cpu_to_le32(0xC0000149)
+#define STATUS_ILLEGAL_FLOAT_CONTEXT cpu_to_le32(0xC000014A)
+#define STATUS_PIPE_BROKEN cpu_to_le32(0xC000014B)
+#define STATUS_REGISTRY_CORRUPT cpu_to_le32(0xC000014C)
+#define STATUS_REGISTRY_IO_FAILED cpu_to_le32(0xC000014D)
+#define STATUS_NO_EVENT_PAIR cpu_to_le32(0xC000014E)
+#define STATUS_UNRECOGNIZED_VOLUME cpu_to_le32(0xC000014F)
+#define STATUS_SERIAL_NO_DEVICE_INITED cpu_to_le32(0xC0000150)
+#define STATUS_NO_SUCH_ALIAS cpu_to_le32(0xC0000151)
+#define STATUS_MEMBER_NOT_IN_ALIAS cpu_to_le32(0xC0000152)
+#define STATUS_MEMBER_IN_ALIAS cpu_to_le32(0xC0000153)
+#define STATUS_ALIAS_EXISTS cpu_to_le32(0xC0000154)
+#define STATUS_LOGON_NOT_GRANTED cpu_to_le32(0xC0000155)
+#define STATUS_TOO_MANY_SECRETS cpu_to_le32(0xC0000156)
+#define STATUS_SECRET_TOO_LONG cpu_to_le32(0xC0000157)
+#define STATUS_INTERNAL_DB_ERROR cpu_to_le32(0xC0000158)
+#define STATUS_FULLSCREEN_MODE cpu_to_le32(0xC0000159)
+#define STATUS_TOO_MANY_CONTEXT_IDS cpu_to_le32(0xC000015A)
+#define STATUS_LOGON_TYPE_NOT_GRANTED cpu_to_le32(0xC000015B)
+#define STATUS_NOT_REGISTRY_FILE cpu_to_le32(0xC000015C)
+#define STATUS_NT_CROSS_ENCRYPTION_REQUIRED cpu_to_le32(0xC000015D)
+#define STATUS_DOMAIN_CTRLR_CONFIG_ERROR cpu_to_le32(0xC000015E)
+#define STATUS_FT_MISSING_MEMBER cpu_to_le32(0xC000015F)
+#define STATUS_ILL_FORMED_SERVICE_ENTRY cpu_to_le32(0xC0000160)
+#define STATUS_ILLEGAL_CHARACTER cpu_to_le32(0xC0000161)
+#define STATUS_UNMAPPABLE_CHARACTER cpu_to_le32(0xC0000162)
+#define STATUS_UNDEFINED_CHARACTER cpu_to_le32(0xC0000163)
+#define STATUS_FLOPPY_VOLUME cpu_to_le32(0xC0000164)
+#define STATUS_FLOPPY_ID_MARK_NOT_FOUND cpu_to_le32(0xC0000165)
+#define STATUS_FLOPPY_WRONG_CYLINDER cpu_to_le32(0xC0000166)
+#define STATUS_FLOPPY_UNKNOWN_ERROR cpu_to_le32(0xC0000167)
+#define STATUS_FLOPPY_BAD_REGISTERS cpu_to_le32(0xC0000168)
+#define STATUS_DISK_RECALIBRATE_FAILED cpu_to_le32(0xC0000169)
+#define STATUS_DISK_OPERATION_FAILED cpu_to_le32(0xC000016A)
+#define STATUS_DISK_RESET_FAILED cpu_to_le32(0xC000016B)
+#define STATUS_SHARED_IRQ_BUSY cpu_to_le32(0xC000016C)
+#define STATUS_FT_ORPHANING cpu_to_le32(0xC000016D)
+#define STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT cpu_to_le32(0xC000016E)
+#define STATUS_PARTITION_FAILURE cpu_to_le32(0xC0000172)
+#define STATUS_INVALID_BLOCK_LENGTH cpu_to_le32(0xC0000173)
+#define STATUS_DEVICE_NOT_PARTITIONED cpu_to_le32(0xC0000174)
+#define STATUS_UNABLE_TO_LOCK_MEDIA cpu_to_le32(0xC0000175)
+#define STATUS_UNABLE_TO_UNLOAD_MEDIA cpu_to_le32(0xC0000176)
+#define STATUS_EOM_OVERFLOW cpu_to_le32(0xC0000177)
+#define STATUS_NO_MEDIA cpu_to_le32(0xC0000178)
+#define STATUS_NO_SUCH_MEMBER cpu_to_le32(0xC000017A)
+#define STATUS_INVALID_MEMBER cpu_to_le32(0xC000017B)
+#define STATUS_KEY_DELETED cpu_to_le32(0xC000017C)
+#define STATUS_NO_LOG_SPACE cpu_to_le32(0xC000017D)
+#define STATUS_TOO_MANY_SIDS cpu_to_le32(0xC000017E)
+#define STATUS_LM_CROSS_ENCRYPTION_REQUIRED cpu_to_le32(0xC000017F)
+#define STATUS_KEY_HAS_CHILDREN cpu_to_le32(0xC0000180)
+#define STATUS_CHILD_MUST_BE_VOLATILE cpu_to_le32(0xC0000181)
+#define STATUS_DEVICE_CONFIGURATION_ERROR cpu_to_le32(0xC0000182)
+#define STATUS_DRIVER_INTERNAL_ERROR cpu_to_le32(0xC0000183)
+#define STATUS_INVALID_DEVICE_STATE cpu_to_le32(0xC0000184)
+#define STATUS_IO_DEVICE_ERROR cpu_to_le32(0xC0000185)
+#define STATUS_DEVICE_PROTOCOL_ERROR cpu_to_le32(0xC0000186)
+#define STATUS_BACKUP_CONTROLLER cpu_to_le32(0xC0000187)
+#define STATUS_LOG_FILE_FULL cpu_to_le32(0xC0000188)
+#define STATUS_TOO_LATE cpu_to_le32(0xC0000189)
+#define STATUS_NO_TRUST_LSA_SECRET cpu_to_le32(0xC000018A)
+#define STATUS_NO_TRUST_SAM_ACCOUNT cpu_to_le32(0xC000018B)
+#define STATUS_TRUSTED_DOMAIN_FAILURE cpu_to_le32(0xC000018C)
+#define STATUS_TRUSTED_RELATIONSHIP_FAILURE cpu_to_le32(0xC000018D)
+#define STATUS_EVENTLOG_FILE_CORRUPT cpu_to_le32(0xC000018E)
+#define STATUS_EVENTLOG_CANT_START cpu_to_le32(0xC000018F)
+#define STATUS_TRUST_FAILURE cpu_to_le32(0xC0000190)
+#define STATUS_MUTANT_LIMIT_EXCEEDED cpu_to_le32(0xC0000191)
+#define STATUS_NETLOGON_NOT_STARTED cpu_to_le32(0xC0000192)
+#define STATUS_ACCOUNT_EXPIRED cpu_to_le32(0xC0000193)
+#define STATUS_POSSIBLE_DEADLOCK cpu_to_le32(0xC0000194)
+#define STATUS_NETWORK_CREDENTIAL_CONFLICT cpu_to_le32(0xC0000195)
+#define STATUS_REMOTE_SESSION_LIMIT cpu_to_le32(0xC0000196)
+#define STATUS_EVENTLOG_FILE_CHANGED cpu_to_le32(0xC0000197)
+#define STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT cpu_to_le32(0xC0000198)
+#define STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT cpu_to_le32(0xC0000199)
+#define STATUS_NOLOGON_SERVER_TRUST_ACCOUNT cpu_to_le32(0xC000019A)
+#define STATUS_DOMAIN_TRUST_INCONSISTENT cpu_to_le32(0xC000019B)
+#define STATUS_FS_DRIVER_REQUIRED cpu_to_le32(0xC000019C)
+#define STATUS_IMAGE_ALREADY_LOADED_AS_DLL cpu_to_le32(0xC000019D)
+#define STATUS_NETWORK_OPEN_RESTRICTION cpu_to_le32(0xC0000201)
+#define STATUS_NO_USER_SESSION_KEY cpu_to_le32(0xC0000202)
+#define STATUS_USER_SESSION_DELETED cpu_to_le32(0xC0000203)
+#define STATUS_RESOURCE_LANG_NOT_FOUND cpu_to_le32(0xC0000204)
+#define STATUS_INSUFF_SERVER_RESOURCES cpu_to_le32(0xC0000205)
+#define STATUS_INVALID_BUFFER_SIZE cpu_to_le32(0xC0000206)
+#define STATUS_INVALID_ADDRESS_COMPONENT cpu_to_le32(0xC0000207)
+#define STATUS_INVALID_ADDRESS_WILDCARD cpu_to_le32(0xC0000208)
+#define STATUS_TOO_MANY_ADDRESSES cpu_to_le32(0xC0000209)
+#define STATUS_ADDRESS_ALREADY_EXISTS cpu_to_le32(0xC000020A)
+#define STATUS_ADDRESS_CLOSED cpu_to_le32(0xC000020B)
+#define STATUS_CONNECTION_DISCONNECTED cpu_to_le32(0xC000020C)
+#define STATUS_CONNECTION_RESET cpu_to_le32(0xC000020D)
+#define STATUS_TOO_MANY_NODES cpu_to_le32(0xC000020E)
+#define STATUS_TRANSACTION_ABORTED cpu_to_le32(0xC000020F)
+#define STATUS_TRANSACTION_TIMED_OUT cpu_to_le32(0xC0000210)
+#define STATUS_TRANSACTION_NO_RELEASE cpu_to_le32(0xC0000211)
+#define STATUS_TRANSACTION_NO_MATCH cpu_to_le32(0xC0000212)
+#define STATUS_TRANSACTION_RESPONDED cpu_to_le32(0xC0000213)
+#define STATUS_TRANSACTION_INVALID_ID cpu_to_le32(0xC0000214)
+#define STATUS_TRANSACTION_INVALID_TYPE cpu_to_le32(0xC0000215)
+#define STATUS_NOT_SERVER_SESSION cpu_to_le32(0xC0000216)
+#define STATUS_NOT_CLIENT_SESSION cpu_to_le32(0xC0000217)
+#define STATUS_CANNOT_LOAD_REGISTRY_FILE cpu_to_le32(0xC0000218)
+#define STATUS_DEBUG_ATTACH_FAILED cpu_to_le32(0xC0000219)
+#define STATUS_SYSTEM_PROCESS_TERMINATED cpu_to_le32(0xC000021A)
+#define STATUS_DATA_NOT_ACCEPTED cpu_to_le32(0xC000021B)
+#define STATUS_NO_BROWSER_SERVERS_FOUND cpu_to_le32(0xC000021C)
+#define STATUS_VDM_HARD_ERROR cpu_to_le32(0xC000021D)
+#define STATUS_DRIVER_CANCEL_TIMEOUT cpu_to_le32(0xC000021E)
+#define STATUS_REPLY_MESSAGE_MISMATCH cpu_to_le32(0xC000021F)
+#define STATUS_MAPPED_ALIGNMENT cpu_to_le32(0xC0000220)
+#define STATUS_IMAGE_CHECKSUM_MISMATCH cpu_to_le32(0xC0000221)
+#define STATUS_LOST_WRITEBEHIND_DATA cpu_to_le32(0xC0000222)
+#define STATUS_CLIENT_SERVER_PARAMETERS_INVALID cpu_to_le32(0xC0000223)
+#define STATUS_PASSWORD_MUST_CHANGE cpu_to_le32(0xC0000224)
+#define STATUS_NOT_FOUND cpu_to_le32(0xC0000225)
+#define STATUS_NOT_TINY_STREAM cpu_to_le32(0xC0000226)
+#define STATUS_RECOVERY_FAILURE cpu_to_le32(0xC0000227)
+#define STATUS_STACK_OVERFLOW_READ cpu_to_le32(0xC0000228)
+#define STATUS_FAIL_CHECK cpu_to_le32(0xC0000229)
+#define STATUS_DUPLICATE_OBJECTID cpu_to_le32(0xC000022A)
+#define STATUS_OBJECTID_EXISTS cpu_to_le32(0xC000022B)
+#define STATUS_CONVERT_TO_LARGE cpu_to_le32(0xC000022C)
+#define STATUS_RETRY cpu_to_le32(0xC000022D)
+#define STATUS_FOUND_OUT_OF_SCOPE cpu_to_le32(0xC000022E)
+#define STATUS_ALLOCATE_BUCKET cpu_to_le32(0xC000022F)
+#define STATUS_PROPSET_NOT_FOUND cpu_to_le32(0xC0000230)
+#define STATUS_MARSHALL_OVERFLOW cpu_to_le32(0xC0000231)
+#define STATUS_INVALID_VARIANT cpu_to_le32(0xC0000232)
+#define STATUS_DOMAIN_CONTROLLER_NOT_FOUND cpu_to_le32(0xC0000233)
+#define STATUS_ACCOUNT_LOCKED_OUT cpu_to_le32(0xC0000234)
+#define STATUS_HANDLE_NOT_CLOSABLE cpu_to_le32(0xC0000235)
+#define STATUS_CONNECTION_REFUSED cpu_to_le32(0xC0000236)
+#define STATUS_GRACEFUL_DISCONNECT cpu_to_le32(0xC0000237)
+#define STATUS_ADDRESS_ALREADY_ASSOCIATED cpu_to_le32(0xC0000238)
+#define STATUS_ADDRESS_NOT_ASSOCIATED cpu_to_le32(0xC0000239)
+#define STATUS_CONNECTION_INVALID cpu_to_le32(0xC000023A)
+#define STATUS_CONNECTION_ACTIVE cpu_to_le32(0xC000023B)
+#define STATUS_NETWORK_UNREACHABLE cpu_to_le32(0xC000023C)
+#define STATUS_HOST_UNREACHABLE cpu_to_le32(0xC000023D)
+#define STATUS_PROTOCOL_UNREACHABLE cpu_to_le32(0xC000023E)
+#define STATUS_PORT_UNREACHABLE cpu_to_le32(0xC000023F)
+#define STATUS_REQUEST_ABORTED cpu_to_le32(0xC0000240)
+#define STATUS_CONNECTION_ABORTED cpu_to_le32(0xC0000241)
+#define STATUS_BAD_COMPRESSION_BUFFER cpu_to_le32(0xC0000242)
+#define STATUS_USER_MAPPED_FILE cpu_to_le32(0xC0000243)
+#define STATUS_AUDIT_FAILED cpu_to_le32(0xC0000244)
+#define STATUS_TIMER_RESOLUTION_NOT_SET cpu_to_le32(0xC0000245)
+#define STATUS_CONNECTION_COUNT_LIMIT cpu_to_le32(0xC0000246)
+#define STATUS_LOGIN_TIME_RESTRICTION cpu_to_le32(0xC0000247)
+#define STATUS_LOGIN_WKSTA_RESTRICTION cpu_to_le32(0xC0000248)
+#define STATUS_IMAGE_MP_UP_MISMATCH cpu_to_le32(0xC0000249)
+#define STATUS_INSUFFICIENT_LOGON_INFO cpu_to_le32(0xC0000250)
+#define STATUS_BAD_DLL_ENTRYPOINT cpu_to_le32(0xC0000251)
+#define STATUS_BAD_SERVICE_ENTRYPOINT cpu_to_le32(0xC0000252)
+#define STATUS_LPC_REPLY_LOST cpu_to_le32(0xC0000253)
+#define STATUS_IP_ADDRESS_CONFLICT1 cpu_to_le32(0xC0000254)
+#define STATUS_IP_ADDRESS_CONFLICT2 cpu_to_le32(0xC0000255)
+#define STATUS_REGISTRY_QUOTA_LIMIT cpu_to_le32(0xC0000256)
+#define STATUS_PATH_NOT_COVERED cpu_to_le32(0xC0000257)
+#define STATUS_NO_CALLBACK_ACTIVE cpu_to_le32(0xC0000258)
+#define STATUS_LICENSE_QUOTA_EXCEEDED cpu_to_le32(0xC0000259)
+#define STATUS_PWD_TOO_SHORT cpu_to_le32(0xC000025A)
+#define STATUS_PWD_TOO_RECENT cpu_to_le32(0xC000025B)
+#define STATUS_PWD_HISTORY_CONFLICT cpu_to_le32(0xC000025C)
+#define STATUS_PLUGPLAY_NO_DEVICE cpu_to_le32(0xC000025E)
+#define STATUS_UNSUPPORTED_COMPRESSION cpu_to_le32(0xC000025F)
+#define STATUS_INVALID_HW_PROFILE cpu_to_le32(0xC0000260)
+#define STATUS_INVALID_PLUGPLAY_DEVICE_PATH cpu_to_le32(0xC0000261)
+#define STATUS_DRIVER_ORDINAL_NOT_FOUND cpu_to_le32(0xC0000262)
+#define STATUS_DRIVER_ENTRYPOINT_NOT_FOUND cpu_to_le32(0xC0000263)
+#define STATUS_RESOURCE_NOT_OWNED cpu_to_le32(0xC0000264)
+#define STATUS_TOO_MANY_LINKS cpu_to_le32(0xC0000265)
+#define STATUS_QUOTA_LIST_INCONSISTENT cpu_to_le32(0xC0000266)
+#define STATUS_FILE_IS_OFFLINE cpu_to_le32(0xC0000267)
+#define STATUS_EVALUATION_EXPIRATION cpu_to_le32(0xC0000268)
+#define STATUS_ILLEGAL_DLL_RELOCATION cpu_to_le32(0xC0000269)
+#define STATUS_LICENSE_VIOLATION cpu_to_le32(0xC000026A)
+#define STATUS_DLL_INIT_FAILED_LOGOFF cpu_to_le32(0xC000026B)
+#define STATUS_DRIVER_UNABLE_TO_LOAD cpu_to_le32(0xC000026C)
+#define STATUS_DFS_UNAVAILABLE cpu_to_le32(0xC000026D)
+#define STATUS_VOLUME_DISMOUNTED cpu_to_le32(0xC000026E)
+#define STATUS_WX86_INTERNAL_ERROR cpu_to_le32(0xC000026F)
+#define STATUS_WX86_FLOAT_STACK_CHECK cpu_to_le32(0xC0000270)
+#define STATUS_VALIDATE_CONTINUE cpu_to_le32(0xC0000271)
+#define STATUS_NO_MATCH cpu_to_le32(0xC0000272)
+#define STATUS_NO_MORE_MATCHES cpu_to_le32(0xC0000273)
+#define STATUS_NOT_A_REPARSE_POINT cpu_to_le32(0xC0000275)
+#define STATUS_IO_REPARSE_TAG_INVALID cpu_to_le32(0xC0000276)
+#define STATUS_IO_REPARSE_TAG_MISMATCH cpu_to_le32(0xC0000277)
+#define STATUS_IO_REPARSE_DATA_INVALID cpu_to_le32(0xC0000278)
+#define STATUS_IO_REPARSE_TAG_NOT_HANDLED cpu_to_le32(0xC0000279)
+#define STATUS_REPARSE_POINT_NOT_RESOLVED cpu_to_le32(0xC0000280)
+#define STATUS_DIRECTORY_IS_A_REPARSE_POINT cpu_to_le32(0xC0000281)
+#define STATUS_RANGE_LIST_CONFLICT cpu_to_le32(0xC0000282)
+#define STATUS_SOURCE_ELEMENT_EMPTY cpu_to_le32(0xC0000283)
+#define STATUS_DESTINATION_ELEMENT_FULL cpu_to_le32(0xC0000284)
+#define STATUS_ILLEGAL_ELEMENT_ADDRESS cpu_to_le32(0xC0000285)
+#define STATUS_MAGAZINE_NOT_PRESENT cpu_to_le32(0xC0000286)
+#define STATUS_REINITIALIZATION_NEEDED cpu_to_le32(0xC0000287)
+#define STATUS_ENCRYPTION_FAILED cpu_to_le32(0xC000028A)
+#define STATUS_DECRYPTION_FAILED cpu_to_le32(0xC000028B)
+#define STATUS_RANGE_NOT_FOUND cpu_to_le32(0xC000028C)
+#define STATUS_NO_RECOVERY_POLICY cpu_to_le32(0xC000028D)
+#define STATUS_NO_EFS cpu_to_le32(0xC000028E)
+#define STATUS_WRONG_EFS cpu_to_le32(0xC000028F)
+#define STATUS_NO_USER_KEYS cpu_to_le32(0xC0000290)
+#define STATUS_FILE_NOT_ENCRYPTED cpu_to_le32(0xC0000291)
+#define STATUS_NOT_EXPORT_FORMAT cpu_to_le32(0xC0000292)
+#define STATUS_FILE_ENCRYPTED cpu_to_le32(0xC0000293)
+#define STATUS_WMI_GUID_NOT_FOUND cpu_to_le32(0xC0000295)
+#define STATUS_WMI_INSTANCE_NOT_FOUND cpu_to_le32(0xC0000296)
+#define STATUS_WMI_ITEMID_NOT_FOUND cpu_to_le32(0xC0000297)
+#define STATUS_WMI_TRY_AGAIN cpu_to_le32(0xC0000298)
+#define STATUS_SHARED_POLICY cpu_to_le32(0xC0000299)
+#define STATUS_POLICY_OBJECT_NOT_FOUND cpu_to_le32(0xC000029A)
+#define STATUS_POLICY_ONLY_IN_DS cpu_to_le32(0xC000029B)
+#define STATUS_VOLUME_NOT_UPGRADED cpu_to_le32(0xC000029C)
+#define STATUS_REMOTE_STORAGE_NOT_ACTIVE cpu_to_le32(0xC000029D)
+#define STATUS_REMOTE_STORAGE_MEDIA_ERROR cpu_to_le32(0xC000029E)
+#define STATUS_NO_TRACKING_SERVICE cpu_to_le32(0xC000029F)
+#define STATUS_SERVER_SID_MISMATCH cpu_to_le32(0xC00002A0)
+#define STATUS_DS_NO_ATTRIBUTE_OR_VALUE cpu_to_le32(0xC00002A1)
+#define STATUS_DS_INVALID_ATTRIBUTE_SYNTAX cpu_to_le32(0xC00002A2)
+#define STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED cpu_to_le32(0xC00002A3)
+#define STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS cpu_to_le32(0xC00002A4)
+#define STATUS_DS_BUSY cpu_to_le32(0xC00002A5)
+#define STATUS_DS_UNAVAILABLE cpu_to_le32(0xC00002A6)
+#define STATUS_DS_NO_RIDS_ALLOCATED cpu_to_le32(0xC00002A7)
+#define STATUS_DS_NO_MORE_RIDS cpu_to_le32(0xC00002A8)
+#define STATUS_DS_INCORRECT_ROLE_OWNER cpu_to_le32(0xC00002A9)
+#define STATUS_DS_RIDMGR_INIT_ERROR cpu_to_le32(0xC00002AA)
+#define STATUS_DS_OBJ_CLASS_VIOLATION cpu_to_le32(0xC00002AB)
+#define STATUS_DS_CANT_ON_NON_LEAF cpu_to_le32(0xC00002AC)
+#define STATUS_DS_CANT_ON_RDN cpu_to_le32(0xC00002AD)
+#define STATUS_DS_CANT_MOD_OBJ_CLASS cpu_to_le32(0xC00002AE)
+#define STATUS_DS_CROSS_DOM_MOVE_FAILED cpu_to_le32(0xC00002AF)
+#define STATUS_DS_GC_NOT_AVAILABLE cpu_to_le32(0xC00002B0)
+#define STATUS_DIRECTORY_SERVICE_REQUIRED cpu_to_le32(0xC00002B1)
+#define STATUS_REPARSE_ATTRIBUTE_CONFLICT cpu_to_le32(0xC00002B2)
+#define STATUS_CANT_ENABLE_DENY_ONLY cpu_to_le32(0xC00002B3)
+#define STATUS_FLOAT_MULTIPLE_FAULTS cpu_to_le32(0xC00002B4)
+#define STATUS_FLOAT_MULTIPLE_TRAPS cpu_to_le32(0xC00002B5)
+#define STATUS_DEVICE_REMOVED cpu_to_le32(0xC00002B6)
+#define STATUS_JOURNAL_DELETE_IN_PROGRESS cpu_to_le32(0xC00002B7)
+#define STATUS_JOURNAL_NOT_ACTIVE cpu_to_le32(0xC00002B8)
+#define STATUS_NOINTERFACE cpu_to_le32(0xC00002B9)
+#define STATUS_DS_ADMIN_LIMIT_EXCEEDED cpu_to_le32(0xC00002C1)
+#define STATUS_DRIVER_FAILED_SLEEP cpu_to_le32(0xC00002C2)
+#define STATUS_MUTUAL_AUTHENTICATION_FAILED cpu_to_le32(0xC00002C3)
+#define STATUS_CORRUPT_SYSTEM_FILE cpu_to_le32(0xC00002C4)
+#define STATUS_DATATYPE_MISALIGNMENT_ERROR cpu_to_le32(0xC00002C5)
+#define STATUS_WMI_READ_ONLY cpu_to_le32(0xC00002C6)
+#define STATUS_WMI_SET_FAILURE cpu_to_le32(0xC00002C7)
+#define STATUS_COMMITMENT_MINIMUM cpu_to_le32(0xC00002C8)
+#define STATUS_REG_NAT_CONSUMPTION cpu_to_le32(0xC00002C9)
+#define STATUS_TRANSPORT_FULL cpu_to_le32(0xC00002CA)
+#define STATUS_DS_SAM_INIT_FAILURE cpu_to_le32(0xC00002CB)
+#define STATUS_ONLY_IF_CONNECTED cpu_to_le32(0xC00002CC)
+#define STATUS_DS_SENSITIVE_GROUP_VIOLATION cpu_to_le32(0xC00002CD)
+#define STATUS_PNP_RESTART_ENUMERATION cpu_to_le32(0xC00002CE)
+#define STATUS_JOURNAL_ENTRY_DELETED cpu_to_le32(0xC00002CF)
+#define STATUS_DS_CANT_MOD_PRIMARYGROUPID cpu_to_le32(0xC00002D0)
+#define STATUS_SYSTEM_IMAGE_BAD_SIGNATURE cpu_to_le32(0xC00002D1)
+#define STATUS_PNP_REBOOT_REQUIRED cpu_to_le32(0xC00002D2)
+#define STATUS_POWER_STATE_INVALID cpu_to_le32(0xC00002D3)
+#define STATUS_DS_INVALID_GROUP_TYPE cpu_to_le32(0xC00002D4)
+#define STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN cpu_to_le32(0xC00002D5)
+#define STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN cpu_to_le32(0xC00002D6)
+#define STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER cpu_to_le32(0xC00002D7)
+#define STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER cpu_to_le32(0xC00002D8)
+#define STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER cpu_to_le32(0xC00002D9)
+#define STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER cpu_to_le32(0xC00002DA)
+#define STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER	\
+	cpu_to_le32(0xC00002DB)
+#define STATUS_DS_HAVE_PRIMARY_MEMBERS cpu_to_le32(0xC00002DC)
+#define STATUS_WMI_NOT_SUPPORTED cpu_to_le32(0xC00002DD)
+#define STATUS_INSUFFICIENT_POWER cpu_to_le32(0xC00002DE)
+#define STATUS_SAM_NEED_BOOTKEY_PASSWORD cpu_to_le32(0xC00002DF)
+#define STATUS_SAM_NEED_BOOTKEY_FLOPPY cpu_to_le32(0xC00002E0)
+#define STATUS_DS_CANT_START cpu_to_le32(0xC00002E1)
+#define STATUS_DS_INIT_FAILURE cpu_to_le32(0xC00002E2)
+#define STATUS_SAM_INIT_FAILURE cpu_to_le32(0xC00002E3)
+#define STATUS_DS_GC_REQUIRED cpu_to_le32(0xC00002E4)
+#define STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY cpu_to_le32(0xC00002E5)
+#define STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS cpu_to_le32(0xC00002E6)
+#define STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED cpu_to_le32(0xC00002E7)
+#define STATUS_MULTIPLE_FAULT_VIOLATION cpu_to_le32(0xC00002E8)
+#define STATUS_CURRENT_DOMAIN_NOT_ALLOWED cpu_to_le32(0xC00002E9)
+#define STATUS_CANNOT_MAKE cpu_to_le32(0xC00002EA)
+#define STATUS_SYSTEM_SHUTDOWN cpu_to_le32(0xC00002EB)
+#define STATUS_DS_INIT_FAILURE_CONSOLE cpu_to_le32(0xC00002EC)
+#define STATUS_DS_SAM_INIT_FAILURE_CONSOLE cpu_to_le32(0xC00002ED)
+#define STATUS_UNFINISHED_CONTEXT_DELETED cpu_to_le32(0xC00002EE)
+#define STATUS_NO_TGT_REPLY cpu_to_le32(0xC00002EF)
+#define STATUS_OBJECTID_NOT_FOUND cpu_to_le32(0xC00002F0)
+#define STATUS_NO_IP_ADDRESSES cpu_to_le32(0xC00002F1)
+#define STATUS_WRONG_CREDENTIAL_HANDLE cpu_to_le32(0xC00002F2)
+#define STATUS_CRYPTO_SYSTEM_INVALID cpu_to_le32(0xC00002F3)
+#define STATUS_MAX_REFERRALS_EXCEEDED cpu_to_le32(0xC00002F4)
+#define STATUS_MUST_BE_KDC cpu_to_le32(0xC00002F5)
+#define STATUS_STRONG_CRYPTO_NOT_SUPPORTED cpu_to_le32(0xC00002F6)
+#define STATUS_TOO_MANY_PRINCIPALS cpu_to_le32(0xC00002F7)
+#define STATUS_NO_PA_DATA cpu_to_le32(0xC00002F8)
+#define STATUS_PKINIT_NAME_MISMATCH cpu_to_le32(0xC00002F9)
+#define STATUS_SMARTCARD_LOGON_REQUIRED cpu_to_le32(0xC00002FA)
+#define STATUS_KDC_INVALID_REQUEST cpu_to_le32(0xC00002FB)
+#define STATUS_KDC_UNABLE_TO_REFER cpu_to_le32(0xC00002FC)
+#define STATUS_KDC_UNKNOWN_ETYPE cpu_to_le32(0xC00002FD)
+#define STATUS_SHUTDOWN_IN_PROGRESS cpu_to_le32(0xC00002FE)
+#define STATUS_SERVER_SHUTDOWN_IN_PROGRESS cpu_to_le32(0xC00002FF)
+#define STATUS_NOT_SUPPORTED_ON_SBS cpu_to_le32(0xC0000300)
+#define STATUS_WMI_GUID_DISCONNECTED cpu_to_le32(0xC0000301)
+#define STATUS_WMI_ALREADY_DISABLED cpu_to_le32(0xC0000302)
+#define STATUS_WMI_ALREADY_ENABLED cpu_to_le32(0xC0000303)
+#define STATUS_MFT_TOO_FRAGMENTED cpu_to_le32(0xC0000304)
+#define STATUS_COPY_PROTECTION_FAILURE cpu_to_le32(0xC0000305)
+#define STATUS_CSS_AUTHENTICATION_FAILURE cpu_to_le32(0xC0000306)
+#define STATUS_CSS_KEY_NOT_PRESENT cpu_to_le32(0xC0000307)
+#define STATUS_CSS_KEY_NOT_ESTABLISHED cpu_to_le32(0xC0000308)
+#define STATUS_CSS_SCRAMBLED_SECTOR cpu_to_le32(0xC0000309)
+#define STATUS_CSS_REGION_MISMATCH cpu_to_le32(0xC000030A)
+#define STATUS_CSS_RESETS_EXHAUSTED cpu_to_le32(0xC000030B)
+#define STATUS_PKINIT_FAILURE cpu_to_le32(0xC0000320)
+#define STATUS_SMARTCARD_SUBSYSTEM_FAILURE cpu_to_le32(0xC0000321)
+#define STATUS_NO_KERB_KEY cpu_to_le32(0xC0000322)
+#define STATUS_HOST_DOWN cpu_to_le32(0xC0000350)
+#define STATUS_UNSUPPORTED_PREAUTH cpu_to_le32(0xC0000351)
+#define STATUS_EFS_ALG_BLOB_TOO_BIG cpu_to_le32(0xC0000352)
+#define STATUS_PORT_NOT_SET cpu_to_le32(0xC0000353)
+#define STATUS_DEBUGGER_INACTIVE cpu_to_le32(0xC0000354)
+#define STATUS_DS_VERSION_CHECK_FAILURE cpu_to_le32(0xC0000355)
+#define STATUS_AUDITING_DISABLED cpu_to_le32(0xC0000356)
+#define STATUS_PRENT4_MACHINE_ACCOUNT cpu_to_le32(0xC0000357)
+#define STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER cpu_to_le32(0xC0000358)
+#define STATUS_INVALID_IMAGE_WIN_32 cpu_to_le32(0xC0000359)
+#define STATUS_INVALID_IMAGE_WIN_64 cpu_to_le32(0xC000035A)
+#define STATUS_BAD_BINDINGS cpu_to_le32(0xC000035B)
+#define STATUS_NETWORK_SESSION_EXPIRED cpu_to_le32(0xC000035C)
+#define STATUS_APPHELP_BLOCK cpu_to_le32(0xC000035D)
+#define STATUS_ALL_SIDS_FILTERED cpu_to_le32(0xC000035E)
+#define STATUS_NOT_SAFE_MODE_DRIVER cpu_to_le32(0xC000035F)
+#define STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT cpu_to_le32(0xC0000361)
+#define STATUS_ACCESS_DISABLED_BY_POLICY_PATH cpu_to_le32(0xC0000362)
+#define STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER cpu_to_le32(0xC0000363)
+#define STATUS_ACCESS_DISABLED_BY_POLICY_OTHER cpu_to_le32(0xC0000364)
+#define STATUS_FAILED_DRIVER_ENTRY cpu_to_le32(0xC0000365)
+#define STATUS_DEVICE_ENUMERATION_ERROR cpu_to_le32(0xC0000366)
+#define STATUS_MOUNT_POINT_NOT_RESOLVED cpu_to_le32(0xC0000368)
+#define STATUS_INVALID_DEVICE_OBJECT_PARAMETER cpu_to_le32(0xC0000369)
+#define STATUS_MCA_OCCURRED cpu_to_le32(0xC000036A)
+#define STATUS_DRIVER_BLOCKED_CRITICAL cpu_to_le32(0xC000036B)
+#define STATUS_DRIVER_BLOCKED cpu_to_le32(0xC000036C)
+#define STATUS_DRIVER_DATABASE_ERROR cpu_to_le32(0xC000036D)
+#define STATUS_SYSTEM_HIVE_TOO_LARGE cpu_to_le32(0xC000036E)
+#define STATUS_INVALID_IMPORT_OF_NON_DLL cpu_to_le32(0xC000036F)
+#define STATUS_NO_SECRETS cpu_to_le32(0xC0000371)
+#define STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY cpu_to_le32(0xC0000372)
+#define STATUS_FAILED_STACK_SWITCH cpu_to_le32(0xC0000373)
+#define STATUS_HEAP_CORRUPTION cpu_to_le32(0xC0000374)
+#define STATUS_SMARTCARD_WRONG_PIN cpu_to_le32(0xC0000380)
+#define STATUS_SMARTCARD_CARD_BLOCKED cpu_to_le32(0xC0000381)
+#define STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED cpu_to_le32(0xC0000382)
+#define STATUS_SMARTCARD_NO_CARD cpu_to_le32(0xC0000383)
+#define STATUS_SMARTCARD_NO_KEY_CONTAINER cpu_to_le32(0xC0000384)
+#define STATUS_SMARTCARD_NO_CERTIFICATE cpu_to_le32(0xC0000385)
+#define STATUS_SMARTCARD_NO_KEYSET cpu_to_le32(0xC0000386)
+#define STATUS_SMARTCARD_IO_ERROR cpu_to_le32(0xC0000387)
+#define STATUS_DOWNGRADE_DETECTED cpu_to_le32(0xC0000388)
+#define STATUS_SMARTCARD_CERT_REVOKED cpu_to_le32(0xC0000389)
+#define STATUS_ISSUING_CA_UNTRUSTED cpu_to_le32(0xC000038A)
+#define STATUS_REVOCATION_OFFLINE_C cpu_to_le32(0xC000038B)
+#define STATUS_PKINIT_CLIENT_FAILURE cpu_to_le32(0xC000038C)
+#define STATUS_SMARTCARD_CERT_EXPIRED cpu_to_le32(0xC000038D)
+#define STATUS_DRIVER_FAILED_PRIOR_UNLOAD cpu_to_le32(0xC000038E)
+#define STATUS_SMARTCARD_SILENT_CONTEXT cpu_to_le32(0xC000038F)
+#define STATUS_PER_USER_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000401)
+#define STATUS_ALL_USER_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000402)
+#define STATUS_USER_DELETE_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000403)
+#define STATUS_DS_NAME_NOT_UNIQUE cpu_to_le32(0xC0000404)
+#define STATUS_DS_DUPLICATE_ID_FOUND cpu_to_le32(0xC0000405)
+#define STATUS_DS_GROUP_CONVERSION_ERROR cpu_to_le32(0xC0000406)
+#define STATUS_VOLSNAP_PREPARE_HIBERNATE cpu_to_le32(0xC0000407)
+#define STATUS_USER2USER_REQUIRED cpu_to_le32(0xC0000408)
+#define STATUS_STACK_BUFFER_OVERRUN cpu_to_le32(0xC0000409)
+#define STATUS_NO_S4U_PROT_SUPPORT cpu_to_le32(0xC000040A)
+#define STATUS_CROSSREALM_DELEGATION_FAILURE cpu_to_le32(0xC000040B)
+#define STATUS_REVOCATION_OFFLINE_KDC cpu_to_le32(0xC000040C)
+#define STATUS_ISSUING_CA_UNTRUSTED_KDC cpu_to_le32(0xC000040D)
+#define STATUS_KDC_CERT_EXPIRED cpu_to_le32(0xC000040E)
+#define STATUS_KDC_CERT_REVOKED cpu_to_le32(0xC000040F)
+#define STATUS_PARAMETER_QUOTA_EXCEEDED cpu_to_le32(0xC0000410)
+#define STATUS_HIBERNATION_FAILURE cpu_to_le32(0xC0000411)
+#define STATUS_DELAY_LOAD_FAILED cpu_to_le32(0xC0000412)
+#define STATUS_AUTHENTICATION_FIREWALL_FAILED cpu_to_le32(0xC0000413)
+#define STATUS_VDM_DISALLOWED cpu_to_le32(0xC0000414)
+#define STATUS_HUNG_DISPLAY_DRIVER_THREAD cpu_to_le32(0xC0000415)
+#define STATUS_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE	\
+	cpu_to_le32(0xC0000416)
+#define STATUS_INVALID_CRUNTIME_PARAMETER cpu_to_le32(0xC0000417)
+#define STATUS_NTLM_BLOCKED cpu_to_le32(0xC0000418)
+#define STATUS_ASSERTION_FAILURE cpu_to_le32(0xC0000420)
+#define STATUS_VERIFIER_STOP cpu_to_le32(0xC0000421)
+#define STATUS_CALLBACK_POP_STACK cpu_to_le32(0xC0000423)
+#define STATUS_INCOMPATIBLE_DRIVER_BLOCKED cpu_to_le32(0xC0000424)
+#define STATUS_HIVE_UNLOADED cpu_to_le32(0xC0000425)
+#define STATUS_COMPRESSION_DISABLED cpu_to_le32(0xC0000426)
+#define STATUS_FILE_SYSTEM_LIMITATION cpu_to_le32(0xC0000427)
+#define STATUS_INVALID_IMAGE_HASH cpu_to_le32(0xC0000428)
+#define STATUS_NOT_CAPABLE cpu_to_le32(0xC0000429)
+#define STATUS_REQUEST_OUT_OF_SEQUENCE cpu_to_le32(0xC000042A)
+#define STATUS_IMPLEMENTATION_LIMIT cpu_to_le32(0xC000042B)
+#define STATUS_ELEVATION_REQUIRED cpu_to_le32(0xC000042C)
+#define STATUS_BEYOND_VDL cpu_to_le32(0xC0000432)
+#define STATUS_ENCOUNTERED_WRITE_IN_PROGRESS cpu_to_le32(0xC0000433)
+#define STATUS_PTE_CHANGED cpu_to_le32(0xC0000434)
+#define STATUS_PURGE_FAILED cpu_to_le32(0xC0000435)
+#define STATUS_CRED_REQUIRES_CONFIRMATION cpu_to_le32(0xC0000440)
+#define STATUS_CS_ENCRYPTION_INVALID_SERVER_RESPONSE cpu_to_le32(0xC0000441)
+#define STATUS_CS_ENCRYPTION_UNSUPPORTED_SERVER cpu_to_le32(0xC0000442)
+#define STATUS_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE cpu_to_le32(0xC0000443)
+#define STATUS_CS_ENCRYPTION_NEW_ENCRYPTED_FILE cpu_to_le32(0xC0000444)
+#define STATUS_CS_ENCRYPTION_FILE_NOT_CSE cpu_to_le32(0xC0000445)
+#define STATUS_INVALID_LABEL cpu_to_le32(0xC0000446)
+#define STATUS_DRIVER_PROCESS_TERMINATED cpu_to_le32(0xC0000450)
+#define STATUS_AMBIGUOUS_SYSTEM_DEVICE cpu_to_le32(0xC0000451)
+#define STATUS_SYSTEM_DEVICE_NOT_FOUND cpu_to_le32(0xC0000452)
+#define STATUS_RESTART_BOOT_APPLICATION cpu_to_le32(0xC0000453)
+#define STATUS_INVALID_TASK_NAME cpu_to_le32(0xC0000500)
+#define STATUS_INVALID_TASK_INDEX cpu_to_le32(0xC0000501)
+#define STATUS_THREAD_ALREADY_IN_TASK cpu_to_le32(0xC0000502)
+#define STATUS_CALLBACK_BYPASS cpu_to_le32(0xC0000503)
+#define STATUS_PORT_CLOSED cpu_to_le32(0xC0000700)
+#define STATUS_MESSAGE_LOST cpu_to_le32(0xC0000701)
+#define STATUS_INVALID_MESSAGE cpu_to_le32(0xC0000702)
+#define STATUS_REQUEST_CANCELED cpu_to_le32(0xC0000703)
+#define STATUS_RECURSIVE_DISPATCH cpu_to_le32(0xC0000704)
+#define STATUS_LPC_RECEIVE_BUFFER_EXPECTED cpu_to_le32(0xC0000705)
+#define STATUS_LPC_INVALID_CONNECTION_USAGE cpu_to_le32(0xC0000706)
+#define STATUS_LPC_REQUESTS_NOT_ALLOWED cpu_to_le32(0xC0000707)
+#define STATUS_RESOURCE_IN_USE cpu_to_le32(0xC0000708)
+#define STATUS_HARDWARE_MEMORY_ERROR cpu_to_le32(0xC0000709)
+#define STATUS_THREADPOOL_HANDLE_EXCEPTION cpu_to_le32(0xC000070A)
+#define STATUS_THREADPOOL_SET_EVENT_ON_COMPLETION_FAILED cpu_to_le32(0xC000070B)
+#define STATUS_THREADPOOL_RELEASE_SEMAPHORE_ON_COMPLETION_FAILED	\
+	cpu_to_le32(0xC000070C)
+#define STATUS_THREADPOOL_RELEASE_MUTEX_ON_COMPLETION_FAILED	\
+	cpu_to_le32(0xC000070D)
+#define STATUS_THREADPOOL_FREE_LIBRARY_ON_COMPLETION_FAILED	\
+	cpu_to_le32(0xC000070E)
+#define STATUS_THREADPOOL_RELEASED_DURING_OPERATION cpu_to_le32(0xC000070F)
+#define STATUS_CALLBACK_RETURNED_WHILE_IMPERSONATING cpu_to_le32(0xC0000710)
+#define STATUS_APC_RETURNED_WHILE_IMPERSONATING cpu_to_le32(0xC0000711)
+#define STATUS_PROCESS_IS_PROTECTED cpu_to_le32(0xC0000712)
+#define STATUS_MCA_EXCEPTION cpu_to_le32(0xC0000713)
+#define STATUS_CERTIFICATE_MAPPING_NOT_UNIQUE cpu_to_le32(0xC0000714)
+#define STATUS_SYMLINK_CLASS_DISABLED cpu_to_le32(0xC0000715)
+#define STATUS_INVALID_IDN_NORMALIZATION cpu_to_le32(0xC0000716)
+#define STATUS_NO_UNICODE_TRANSLATION cpu_to_le32(0xC0000717)
+#define STATUS_ALREADY_REGISTERED cpu_to_le32(0xC0000718)
+#define STATUS_CONTEXT_MISMATCH cpu_to_le32(0xC0000719)
+#define STATUS_PORT_ALREADY_HAS_COMPLETION_LIST cpu_to_le32(0xC000071A)
+#define STATUS_CALLBACK_RETURNED_THREAD_PRIORITY cpu_to_le32(0xC000071B)
+#define STATUS_INVALID_THREAD cpu_to_le32(0xC000071C)
+#define STATUS_CALLBACK_RETURNED_TRANSACTION cpu_to_le32(0xC000071D)
+#define STATUS_CALLBACK_RETURNED_LDR_LOCK cpu_to_le32(0xC000071E)
+#define STATUS_CALLBACK_RETURNED_LANG cpu_to_le32(0xC000071F)
+#define STATUS_CALLBACK_RETURNED_PRI_BACK cpu_to_le32(0xC0000720)
+#define STATUS_CALLBACK_RETURNED_THREAD_AFFINITY cpu_to_le32(0xC0000721)
+#define STATUS_DISK_REPAIR_DISABLED cpu_to_le32(0xC0000800)
+#define STATUS_DS_DOMAIN_RENAME_IN_PROGRESS cpu_to_le32(0xC0000801)
+#define STATUS_DISK_QUOTA_EXCEEDED cpu_to_le32(0xC0000802)
+#define STATUS_CONTENT_BLOCKED cpu_to_le32(0xC0000804)
+#define STATUS_BAD_CLUSTERS cpu_to_le32(0xC0000805)
+#define STATUS_VOLUME_DIRTY cpu_to_le32(0xC0000806)
+#define STATUS_FILE_CHECKED_OUT cpu_to_le32(0xC0000901)
+#define STATUS_CHECKOUT_REQUIRED cpu_to_le32(0xC0000902)
+#define STATUS_BAD_FILE_TYPE cpu_to_le32(0xC0000903)
+#define STATUS_FILE_TOO_LARGE cpu_to_le32(0xC0000904)
+#define STATUS_FORMS_AUTH_REQUIRED cpu_to_le32(0xC0000905)
+#define STATUS_VIRUS_INFECTED cpu_to_le32(0xC0000906)
+#define STATUS_VIRUS_DELETED cpu_to_le32(0xC0000907)
+#define STATUS_BAD_MCFG_TABLE cpu_to_le32(0xC0000908)
+#define STATUS_WOW_ASSERTION cpu_to_le32(0xC0009898)
+#define STATUS_INVALID_SIGNATURE cpu_to_le32(0xC000A000)
+#define STATUS_HMAC_NOT_SUPPORTED cpu_to_le32(0xC000A001)
+#define STATUS_IPSEC_QUEUE_OVERFLOW cpu_to_le32(0xC000A010)
+#define STATUS_ND_QUEUE_OVERFLOW cpu_to_le32(0xC000A011)
+#define STATUS_HOPLIMIT_EXCEEDED cpu_to_le32(0xC000A012)
+#define STATUS_PROTOCOL_NOT_SUPPORTED cpu_to_le32(0xC000A013)
+#define STATUS_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED	\
+	cpu_to_le32(0xC000A080)
+#define STATUS_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR	\
+	cpu_to_le32(0xC000A081)
+#define STATUS_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR cpu_to_le32(0xC000A082)
+#define STATUS_XML_PARSE_ERROR cpu_to_le32(0xC000A083)
+#define STATUS_XMLDSIG_ERROR cpu_to_le32(0xC000A084)
+#define STATUS_WRONG_COMPARTMENT cpu_to_le32(0xC000A085)
+#define STATUS_AUTHIP_FAILURE cpu_to_le32(0xC000A086)
+#define DBG_NO_STATE_CHANGE cpu_to_le32(0xC0010001)
+#define DBG_APP_NOT_IDLE cpu_to_le32(0xC0010002)
+#define RPC_NT_INVALID_STRING_BINDING cpu_to_le32(0xC0020001)
+#define RPC_NT_WRONG_KIND_OF_BINDING cpu_to_le32(0xC0020002)
+#define RPC_NT_INVALID_BINDING cpu_to_le32(0xC0020003)
+#define RPC_NT_PROTSEQ_NOT_SUPPORTED cpu_to_le32(0xC0020004)
+#define RPC_NT_INVALID_RPC_PROTSEQ cpu_to_le32(0xC0020005)
+#define RPC_NT_INVALID_STRING_UUID cpu_to_le32(0xC0020006)
+#define RPC_NT_INVALID_ENDPOINT_FORMAT cpu_to_le32(0xC0020007)
+#define RPC_NT_INVALID_NET_ADDR cpu_to_le32(0xC0020008)
+#define RPC_NT_NO_ENDPOINT_FOUND cpu_to_le32(0xC0020009)
+#define RPC_NT_INVALID_TIMEOUT cpu_to_le32(0xC002000A)
+#define RPC_NT_OBJECT_NOT_FOUND cpu_to_le32(0xC002000B)
+#define RPC_NT_ALREADY_REGISTERED cpu_to_le32(0xC002000C)
+#define RPC_NT_TYPE_ALREADY_REGISTERED cpu_to_le32(0xC002000D)
+#define RPC_NT_ALREADY_LISTENING cpu_to_le32(0xC002000E)
+#define RPC_NT_NO_PROTSEQS_REGISTERED cpu_to_le32(0xC002000F)
+#define RPC_NT_NOT_LISTENING cpu_to_le32(0xC0020010)
+#define RPC_NT_UNKNOWN_MGR_TYPE cpu_to_le32(0xC0020011)
+#define RPC_NT_UNKNOWN_IF cpu_to_le32(0xC0020012)
+#define RPC_NT_NO_BINDINGS cpu_to_le32(0xC0020013)
+#define RPC_NT_NO_PROTSEQS cpu_to_le32(0xC0020014)
+#define RPC_NT_CANT_CREATE_ENDPOINT cpu_to_le32(0xC0020015)
+#define RPC_NT_OUT_OF_RESOURCES cpu_to_le32(0xC0020016)
+#define RPC_NT_SERVER_UNAVAILABLE cpu_to_le32(0xC0020017)
+#define RPC_NT_SERVER_TOO_BUSY cpu_to_le32(0xC0020018)
+#define RPC_NT_INVALID_NETWORK_OPTIONS cpu_to_le32(0xC0020019)
+#define RPC_NT_NO_CALL_ACTIVE cpu_to_le32(0xC002001A)
+#define RPC_NT_CALL_FAILED cpu_to_le32(0xC002001B)
+#define RPC_NT_CALL_FAILED_DNE cpu_to_le32(0xC002001C)
+#define RPC_NT_PROTOCOL_ERROR cpu_to_le32(0xC002001D)
+#define RPC_NT_UNSUPPORTED_TRANS_SYN cpu_to_le32(0xC002001F)
+#define RPC_NT_UNSUPPORTED_TYPE cpu_to_le32(0xC0020021)
+#define RPC_NT_INVALID_TAG cpu_to_le32(0xC0020022)
+#define RPC_NT_INVALID_BOUND cpu_to_le32(0xC0020023)
+#define RPC_NT_NO_ENTRY_NAME cpu_to_le32(0xC0020024)
+#define RPC_NT_INVALID_NAME_SYNTAX cpu_to_le32(0xC0020025)
+#define RPC_NT_UNSUPPORTED_NAME_SYNTAX cpu_to_le32(0xC0020026)
+#define RPC_NT_UUID_NO_ADDRESS cpu_to_le32(0xC0020028)
+#define RPC_NT_DUPLICATE_ENDPOINT cpu_to_le32(0xC0020029)
+#define RPC_NT_UNKNOWN_AUTHN_TYPE cpu_to_le32(0xC002002A)
+#define RPC_NT_MAX_CALLS_TOO_SMALL cpu_to_le32(0xC002002B)
+#define RPC_NT_STRING_TOO_LONG cpu_to_le32(0xC002002C)
+#define RPC_NT_PROTSEQ_NOT_FOUND cpu_to_le32(0xC002002D)
+#define RPC_NT_PROCNUM_OUT_OF_RANGE cpu_to_le32(0xC002002E)
+#define RPC_NT_BINDING_HAS_NO_AUTH cpu_to_le32(0xC002002F)
+#define RPC_NT_UNKNOWN_AUTHN_SERVICE cpu_to_le32(0xC0020030)
+#define RPC_NT_UNKNOWN_AUTHN_LEVEL cpu_to_le32(0xC0020031)
+#define RPC_NT_INVALID_AUTH_IDENTITY cpu_to_le32(0xC0020032)
+#define RPC_NT_UNKNOWN_AUTHZ_SERVICE cpu_to_le32(0xC0020033)
+#define EPT_NT_INVALID_ENTRY cpu_to_le32(0xC0020034)
+#define EPT_NT_CANT_PERFORM_OP cpu_to_le32(0xC0020035)
+#define EPT_NT_NOT_REGISTERED cpu_to_le32(0xC0020036)
+#define RPC_NT_NOTHING_TO_EXPORT cpu_to_le32(0xC0020037)
+#define RPC_NT_INCOMPLETE_NAME cpu_to_le32(0xC0020038)
+#define RPC_NT_INVALID_VERS_OPTION cpu_to_le32(0xC0020039)
+#define RPC_NT_NO_MORE_MEMBERS cpu_to_le32(0xC002003A)
+#define RPC_NT_NOT_ALL_OBJS_UNEXPORTED cpu_to_le32(0xC002003B)
+#define RPC_NT_INTERFACE_NOT_FOUND cpu_to_le32(0xC002003C)
+#define RPC_NT_ENTRY_ALREADY_EXISTS cpu_to_le32(0xC002003D)
+#define RPC_NT_ENTRY_NOT_FOUND cpu_to_le32(0xC002003E)
+#define RPC_NT_NAME_SERVICE_UNAVAILABLE cpu_to_le32(0xC002003F)
+#define RPC_NT_INVALID_NAF_ID cpu_to_le32(0xC0020040)
+#define RPC_NT_CANNOT_SUPPORT cpu_to_le32(0xC0020041)
+#define RPC_NT_NO_CONTEXT_AVAILABLE cpu_to_le32(0xC0020042)
+#define RPC_NT_INTERNAL_ERROR cpu_to_le32(0xC0020043)
+#define RPC_NT_ZERO_DIVIDE cpu_to_le32(0xC0020044)
+#define RPC_NT_ADDRESS_ERROR cpu_to_le32(0xC0020045)
+#define RPC_NT_FP_DIV_ZERO cpu_to_le32(0xC0020046)
+#define RPC_NT_FP_UNDERFLOW cpu_to_le32(0xC0020047)
+#define RPC_NT_FP_OVERFLOW cpu_to_le32(0xC0020048)
+#define RPC_NT_CALL_IN_PROGRESS cpu_to_le32(0xC0020049)
+#define RPC_NT_NO_MORE_BINDINGS cpu_to_le32(0xC002004A)
+#define RPC_NT_GROUP_MEMBER_NOT_FOUND cpu_to_le32(0xC002004B)
+#define EPT_NT_CANT_CREATE cpu_to_le32(0xC002004C)
+#define RPC_NT_INVALID_OBJECT cpu_to_le32(0xC002004D)
+#define RPC_NT_NO_INTERFACES cpu_to_le32(0xC002004F)
+#define RPC_NT_CALL_CANCELLED cpu_to_le32(0xC0020050)
+#define RPC_NT_BINDING_INCOMPLETE cpu_to_le32(0xC0020051)
+#define RPC_NT_COMM_FAILURE cpu_to_le32(0xC0020052)
+#define RPC_NT_UNSUPPORTED_AUTHN_LEVEL cpu_to_le32(0xC0020053)
+#define RPC_NT_NO_PRINC_NAME cpu_to_le32(0xC0020054)
+#define RPC_NT_NOT_RPC_ERROR cpu_to_le32(0xC0020055)
+#define RPC_NT_SEC_PKG_ERROR cpu_to_le32(0xC0020057)
+#define RPC_NT_NOT_CANCELLED cpu_to_le32(0xC0020058)
+#define RPC_NT_INVALID_ASYNC_HANDLE cpu_to_le32(0xC0020062)
+#define RPC_NT_INVALID_ASYNC_CALL cpu_to_le32(0xC0020063)
+#define RPC_NT_PROXY_ACCESS_DENIED cpu_to_le32(0xC0020064)
+#define RPC_NT_NO_MORE_ENTRIES cpu_to_le32(0xC0030001)
+#define RPC_NT_SS_CHAR_TRANS_OPEN_FAIL cpu_to_le32(0xC0030002)
+#define RPC_NT_SS_CHAR_TRANS_SHORT_FILE cpu_to_le32(0xC0030003)
+#define RPC_NT_SS_IN_NULL_CONTEXT cpu_to_le32(0xC0030004)
+#define RPC_NT_SS_CONTEXT_MISMATCH cpu_to_le32(0xC0030005)
+#define RPC_NT_SS_CONTEXT_DAMAGED cpu_to_le32(0xC0030006)
+#define RPC_NT_SS_HANDLES_MISMATCH cpu_to_le32(0xC0030007)
+#define RPC_NT_SS_CANNOT_GET_CALL_HANDLE cpu_to_le32(0xC0030008)
+#define RPC_NT_NULL_REF_POINTER cpu_to_le32(0xC0030009)
+#define RPC_NT_ENUM_VALUE_OUT_OF_RANGE cpu_to_le32(0xC003000A)
+#define RPC_NT_BYTE_COUNT_TOO_SMALL cpu_to_le32(0xC003000B)
+#define RPC_NT_BAD_STUB_DATA cpu_to_le32(0xC003000C)
+#define RPC_NT_INVALID_ES_ACTION cpu_to_le32(0xC0030059)
+#define RPC_NT_WRONG_ES_VERSION cpu_to_le32(0xC003005A)
+#define RPC_NT_WRONG_STUB_VERSION cpu_to_le32(0xC003005B)
+#define RPC_NT_INVALID_PIPE_OBJECT cpu_to_le32(0xC003005C)
+#define RPC_NT_INVALID_PIPE_OPERATION cpu_to_le32(0xC003005D)
+#define RPC_NT_WRONG_PIPE_VERSION cpu_to_le32(0xC003005E)
+#define RPC_NT_PIPE_CLOSED cpu_to_le32(0xC003005F)
+#define RPC_NT_PIPE_DISCIPLINE_ERROR cpu_to_le32(0xC0030060)
+#define RPC_NT_PIPE_EMPTY cpu_to_le32(0xC0030061)
+#define STATUS_PNP_BAD_MPS_TABLE cpu_to_le32(0xC0040035)
+#define STATUS_PNP_TRANSLATION_FAILED cpu_to_le32(0xC0040036)
+#define STATUS_PNP_IRQ_TRANSLATION_FAILED cpu_to_le32(0xC0040037)
+#define STATUS_PNP_INVALID_ID cpu_to_le32(0xC0040038)
+#define STATUS_IO_REISSUE_AS_CACHED cpu_to_le32(0xC0040039)
+#define STATUS_CTX_WINSTATION_NAME_INVALID cpu_to_le32(0xC00A0001)
+#define STATUS_CTX_INVALID_PD cpu_to_le32(0xC00A0002)
+#define STATUS_CTX_PD_NOT_FOUND cpu_to_le32(0xC00A0003)
+#define STATUS_CTX_CLOSE_PENDING cpu_to_le32(0xC00A0006)
+#define STATUS_CTX_NO_OUTBUF cpu_to_le32(0xC00A0007)
+#define STATUS_CTX_MODEM_INF_NOT_FOUND cpu_to_le32(0xC00A0008)
+#define STATUS_CTX_INVALID_MODEMNAME cpu_to_le32(0xC00A0009)
+#define STATUS_CTX_RESPONSE_ERROR cpu_to_le32(0xC00A000A)
+#define STATUS_CTX_MODEM_RESPONSE_TIMEOUT cpu_to_le32(0xC00A000B)
+#define STATUS_CTX_MODEM_RESPONSE_NO_CARRIER cpu_to_le32(0xC00A000C)
+#define STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE cpu_to_le32(0xC00A000D)
+#define STATUS_CTX_MODEM_RESPONSE_BUSY cpu_to_le32(0xC00A000E)
+#define STATUS_CTX_MODEM_RESPONSE_VOICE cpu_to_le32(0xC00A000F)
+#define STATUS_CTX_TD_ERROR cpu_to_le32(0xC00A0010)
+#define STATUS_CTX_LICENSE_CLIENT_INVALID cpu_to_le32(0xC00A0012)
+#define STATUS_CTX_LICENSE_NOT_AVAILABLE cpu_to_le32(0xC00A0013)
+#define STATUS_CTX_LICENSE_EXPIRED cpu_to_le32(0xC00A0014)
+#define STATUS_CTX_WINSTATION_NOT_FOUND cpu_to_le32(0xC00A0015)
+#define STATUS_CTX_WINSTATION_NAME_COLLISION cpu_to_le32(0xC00A0016)
+#define STATUS_CTX_WINSTATION_BUSY cpu_to_le32(0xC00A0017)
+#define STATUS_CTX_BAD_VIDEO_MODE cpu_to_le32(0xC00A0018)
+#define STATUS_CTX_GRAPHICS_INVALID cpu_to_le32(0xC00A0022)
+#define STATUS_CTX_NOT_CONSOLE cpu_to_le32(0xC00A0024)
+#define STATUS_CTX_CLIENT_QUERY_TIMEOUT cpu_to_le32(0xC00A0026)
+#define STATUS_CTX_CONSOLE_DISCONNECT cpu_to_le32(0xC00A0027)
+#define STATUS_CTX_CONSOLE_CONNECT cpu_to_le32(0xC00A0028)
+#define STATUS_CTX_SHADOW_DENIED cpu_to_le32(0xC00A002A)
+#define STATUS_CTX_WINSTATION_ACCESS_DENIED cpu_to_le32(0xC00A002B)
+#define STATUS_CTX_INVALID_WD cpu_to_le32(0xC00A002E)
+#define STATUS_CTX_WD_NOT_FOUND cpu_to_le32(0xC00A002F)
+#define STATUS_CTX_SHADOW_INVALID cpu_to_le32(0xC00A0030)
+#define STATUS_CTX_SHADOW_DISABLED cpu_to_le32(0xC00A0031)
+#define STATUS_RDP_PROTOCOL_ERROR cpu_to_le32(0xC00A0032)
+#define STATUS_CTX_CLIENT_LICENSE_NOT_SET cpu_to_le32(0xC00A0033)
+#define STATUS_CTX_CLIENT_LICENSE_IN_USE cpu_to_le32(0xC00A0034)
+#define STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE cpu_to_le32(0xC00A0035)
+#define STATUS_CTX_SHADOW_NOT_RUNNING cpu_to_le32(0xC00A0036)
+#define STATUS_CTX_LOGON_DISABLED cpu_to_le32(0xC00A0037)
+#define STATUS_CTX_SECURITY_LAYER_ERROR cpu_to_le32(0xC00A0038)
+#define STATUS_TS_INCOMPATIBLE_SESSIONS cpu_to_le32(0xC00A0039)
+#define STATUS_MUI_FILE_NOT_FOUND cpu_to_le32(0xC00B0001)
+#define STATUS_MUI_INVALID_FILE cpu_to_le32(0xC00B0002)
+#define STATUS_MUI_INVALID_RC_CONFIG cpu_to_le32(0xC00B0003)
+#define STATUS_MUI_INVALID_LOCALE_NAME cpu_to_le32(0xC00B0004)
+#define STATUS_MUI_INVALID_ULTIMATEFALLBACK_NAME cpu_to_le32(0xC00B0005)
+#define STATUS_MUI_FILE_NOT_LOADED cpu_to_le32(0xC00B0006)
+#define STATUS_RESOURCE_ENUM_USER_STOP cpu_to_le32(0xC00B0007)
+#define STATUS_CLUSTER_INVALID_NODE cpu_to_le32(0xC0130001)
+#define STATUS_CLUSTER_NODE_EXISTS cpu_to_le32(0xC0130002)
+#define STATUS_CLUSTER_JOIN_IN_PROGRESS cpu_to_le32(0xC0130003)
+#define STATUS_CLUSTER_NODE_NOT_FOUND cpu_to_le32(0xC0130004)
+#define STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND cpu_to_le32(0xC0130005)
+#define STATUS_CLUSTER_NETWORK_EXISTS cpu_to_le32(0xC0130006)
+#define STATUS_CLUSTER_NETWORK_NOT_FOUND cpu_to_le32(0xC0130007)
+#define STATUS_CLUSTER_NETINTERFACE_EXISTS cpu_to_le32(0xC0130008)
+#define STATUS_CLUSTER_NETINTERFACE_NOT_FOUND cpu_to_le32(0xC0130009)
+#define STATUS_CLUSTER_INVALID_REQUEST cpu_to_le32(0xC013000A)
+#define STATUS_CLUSTER_INVALID_NETWORK_PROVIDER cpu_to_le32(0xC013000B)
+#define STATUS_CLUSTER_NODE_DOWN cpu_to_le32(0xC013000C)
+#define STATUS_CLUSTER_NODE_UNREACHABLE cpu_to_le32(0xC013000D)
+#define STATUS_CLUSTER_NODE_NOT_MEMBER cpu_to_le32(0xC013000E)
+#define STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS cpu_to_le32(0xC013000F)
+#define STATUS_CLUSTER_INVALID_NETWORK cpu_to_le32(0xC0130010)
+#define STATUS_CLUSTER_NO_NET_ADAPTERS cpu_to_le32(0xC0130011)
+#define STATUS_CLUSTER_NODE_UP cpu_to_le32(0xC0130012)
+#define STATUS_CLUSTER_NODE_PAUSED cpu_to_le32(0xC0130013)
+#define STATUS_CLUSTER_NODE_NOT_PAUSED cpu_to_le32(0xC0130014)
+#define STATUS_CLUSTER_NO_SECURITY_CONTEXT cpu_to_le32(0xC0130015)
+#define STATUS_CLUSTER_NETWORK_NOT_INTERNAL cpu_to_le32(0xC0130016)
+#define STATUS_CLUSTER_POISONED cpu_to_le32(0xC0130017)
+#define STATUS_ACPI_INVALID_OPCODE cpu_to_le32(0xC0140001)
+#define STATUS_ACPI_STACK_OVERFLOW cpu_to_le32(0xC0140002)
+#define STATUS_ACPI_ASSERT_FAILED cpu_to_le32(0xC0140003)
+#define STATUS_ACPI_INVALID_INDEX cpu_to_le32(0xC0140004)
+#define STATUS_ACPI_INVALID_ARGUMENT cpu_to_le32(0xC0140005)
+#define STATUS_ACPI_FATAL cpu_to_le32(0xC0140006)
+#define STATUS_ACPI_INVALID_SUPERNAME cpu_to_le32(0xC0140007)
+#define STATUS_ACPI_INVALID_ARGTYPE cpu_to_le32(0xC0140008)
+#define STATUS_ACPI_INVALID_OBJTYPE cpu_to_le32(0xC0140009)
+#define STATUS_ACPI_INVALID_TARGETTYPE cpu_to_le32(0xC014000A)
+#define STATUS_ACPI_INCORRECT_ARGUMENT_COUNT cpu_to_le32(0xC014000B)
+#define STATUS_ACPI_ADDRESS_NOT_MAPPED cpu_to_le32(0xC014000C)
+#define STATUS_ACPI_INVALID_EVENTTYPE cpu_to_le32(0xC014000D)
+#define STATUS_ACPI_HANDLER_COLLISION cpu_to_le32(0xC014000E)
+#define STATUS_ACPI_INVALID_DATA cpu_to_le32(0xC014000F)
+#define STATUS_ACPI_INVALID_REGION cpu_to_le32(0xC0140010)
+#define STATUS_ACPI_INVALID_ACCESS_SIZE cpu_to_le32(0xC0140011)
+#define STATUS_ACPI_ACQUIRE_GLOBAL_LOCK cpu_to_le32(0xC0140012)
+#define STATUS_ACPI_ALREADY_INITIALIZED cpu_to_le32(0xC0140013)
+#define STATUS_ACPI_NOT_INITIALIZED cpu_to_le32(0xC0140014)
+#define STATUS_ACPI_INVALID_MUTEX_LEVEL cpu_to_le32(0xC0140015)
+#define STATUS_ACPI_MUTEX_NOT_OWNED cpu_to_le32(0xC0140016)
+#define STATUS_ACPI_MUTEX_NOT_OWNER cpu_to_le32(0xC0140017)
+#define STATUS_ACPI_RS_ACCESS cpu_to_le32(0xC0140018)
+#define STATUS_ACPI_INVALID_TABLE cpu_to_le32(0xC0140019)
+#define STATUS_ACPI_REG_HANDLER_FAILED cpu_to_le32(0xC0140020)
+#define STATUS_ACPI_POWER_REQUEST_FAILED cpu_to_le32(0xC0140021)
+#define STATUS_SXS_SECTION_NOT_FOUND cpu_to_le32(0xC0150001)
+#define STATUS_SXS_CANT_GEN_ACTCTX cpu_to_le32(0xC0150002)
+#define STATUS_SXS_INVALID_ACTCTXDATA_FORMAT cpu_to_le32(0xC0150003)
+#define STATUS_SXS_ASSEMBLY_NOT_FOUND cpu_to_le32(0xC0150004)
+#define STATUS_SXS_MANIFEST_FORMAT_ERROR cpu_to_le32(0xC0150005)
+#define STATUS_SXS_MANIFEST_PARSE_ERROR cpu_to_le32(0xC0150006)
+#define STATUS_SXS_ACTIVATION_CONTEXT_DISABLED cpu_to_le32(0xC0150007)
+#define STATUS_SXS_KEY_NOT_FOUND cpu_to_le32(0xC0150008)
+#define STATUS_SXS_VERSION_CONFLICT cpu_to_le32(0xC0150009)
+#define STATUS_SXS_WRONG_SECTION_TYPE cpu_to_le32(0xC015000A)
+#define STATUS_SXS_THREAD_QUERIES_DISABLED cpu_to_le32(0xC015000B)
+#define STATUS_SXS_ASSEMBLY_MISSING cpu_to_le32(0xC015000C)
+#define STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET cpu_to_le32(0xC015000E)
+#define STATUS_SXS_EARLY_DEACTIVATION cpu_to_le32(0xC015000F)
+#define STATUS_SXS_INVALID_DEACTIVATION cpu_to_le32(0xC0150010)
+#define STATUS_SXS_MULTIPLE_DEACTIVATION cpu_to_le32(0xC0150011)
+#define STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY	\
+	cpu_to_le32(0xC0150012)
+#define STATUS_SXS_PROCESS_TERMINATION_REQUESTED cpu_to_le32(0xC0150013)
+#define STATUS_SXS_CORRUPT_ACTIVATION_STACK cpu_to_le32(0xC0150014)
+#define STATUS_SXS_CORRUPTION cpu_to_le32(0xC0150015)
+#define STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE cpu_to_le32(0xC0150016)
+#define STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME cpu_to_le32(0xC0150017)
+#define STATUS_SXS_IDENTITY_DUPLICATE_ATTRIBUTE cpu_to_le32(0xC0150018)
+#define STATUS_SXS_IDENTITY_PARSE_ERROR cpu_to_le32(0xC0150019)
+#define STATUS_SXS_COMPONENT_STORE_CORRUPT cpu_to_le32(0xC015001A)
+#define STATUS_SXS_FILE_HASH_MISMATCH cpu_to_le32(0xC015001B)
+#define STATUS_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT	\
+	cpu_to_le32(0xC015001C)
+#define STATUS_SXS_IDENTITIES_DIFFERENT cpu_to_le32(0xC015001D)
+#define STATUS_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT cpu_to_le32(0xC015001E)
+#define STATUS_SXS_FILE_NOT_PART_OF_ASSEMBLY cpu_to_le32(0xC015001F)
+#define STATUS_ADVANCED_INSTALLER_FAILED cpu_to_le32(0xC0150020)
+#define STATUS_XML_ENCODING_MISMATCH cpu_to_le32(0xC0150021)
+#define STATUS_SXS_MANIFEST_TOO_BIG cpu_to_le32(0xC0150022)
+#define STATUS_SXS_SETTING_NOT_REGISTERED cpu_to_le32(0xC0150023)
+#define STATUS_SXS_TRANSACTION_CLOSURE_INCOMPLETE cpu_to_le32(0xC0150024)
+#define STATUS_SMI_PRIMITIVE_INSTALLER_FAILED cpu_to_le32(0xC0150025)
+#define STATUS_GENERIC_COMMAND_FAILED cpu_to_le32(0xC0150026)
+#define STATUS_SXS_FILE_HASH_MISSING cpu_to_le32(0xC0150027)
+#define STATUS_TRANSACTIONAL_CONFLICT cpu_to_le32(0xC0190001)
+#define STATUS_INVALID_TRANSACTION cpu_to_le32(0xC0190002)
+#define STATUS_TRANSACTION_NOT_ACTIVE cpu_to_le32(0xC0190003)
+#define STATUS_TM_INITIALIZATION_FAILED cpu_to_le32(0xC0190004)
+#define STATUS_RM_NOT_ACTIVE cpu_to_le32(0xC0190005)
+#define STATUS_RM_METADATA_CORRUPT cpu_to_le32(0xC0190006)
+#define STATUS_TRANSACTION_NOT_JOINED cpu_to_le32(0xC0190007)
+#define STATUS_DIRECTORY_NOT_RM cpu_to_le32(0xC0190008)
+#define STATUS_TRANSACTIONS_UNSUPPORTED_REMOTE cpu_to_le32(0xC019000A)
+#define STATUS_LOG_RESIZE_INVALID_SIZE cpu_to_le32(0xC019000B)
+#define STATUS_REMOTE_FILE_VERSION_MISMATCH cpu_to_le32(0xC019000C)
+#define STATUS_CRM_PROTOCOL_ALREADY_EXISTS cpu_to_le32(0xC019000F)
+#define STATUS_TRANSACTION_PROPAGATION_FAILED cpu_to_le32(0xC0190010)
+#define STATUS_CRM_PROTOCOL_NOT_FOUND cpu_to_le32(0xC0190011)
+#define STATUS_TRANSACTION_SUPERIOR_EXISTS cpu_to_le32(0xC0190012)
+#define STATUS_TRANSACTION_REQUEST_NOT_VALID cpu_to_le32(0xC0190013)
+#define STATUS_TRANSACTION_NOT_REQUESTED cpu_to_le32(0xC0190014)
+#define STATUS_TRANSACTION_ALREADY_ABORTED cpu_to_le32(0xC0190015)
+#define STATUS_TRANSACTION_ALREADY_COMMITTED cpu_to_le32(0xC0190016)
+#define STATUS_TRANSACTION_INVALID_MARSHALL_BUFFER cpu_to_le32(0xC0190017)
+#define STATUS_CURRENT_TRANSACTION_NOT_VALID cpu_to_le32(0xC0190018)
+#define STATUS_LOG_GROWTH_FAILED cpu_to_le32(0xC0190019)
+#define STATUS_OBJECT_NO_LONGER_EXISTS cpu_to_le32(0xC0190021)
+#define STATUS_STREAM_MINIVERSION_NOT_FOUND cpu_to_le32(0xC0190022)
+#define STATUS_STREAM_MINIVERSION_NOT_VALID cpu_to_le32(0xC0190023)
+#define STATUS_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION	\
+	cpu_to_le32(0xC0190024)
+#define STATUS_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT cpu_to_le32(0xC0190025)
+#define STATUS_CANT_CREATE_MORE_STREAM_MINIVERSIONS cpu_to_le32(0xC0190026)
+#define STATUS_HANDLE_NO_LONGER_VALID cpu_to_le32(0xC0190028)
+#define STATUS_LOG_CORRUPTION_DETECTED cpu_to_le32(0xC0190030)
+#define STATUS_RM_DISCONNECTED cpu_to_le32(0xC0190032)
+#define STATUS_ENLISTMENT_NOT_SUPERIOR cpu_to_le32(0xC0190033)
+#define STATUS_FILE_IDENTITY_NOT_PERSISTENT cpu_to_le32(0xC0190036)
+#define STATUS_CANT_BREAK_TRANSACTIONAL_DEPENDENCY cpu_to_le32(0xC0190037)
+#define STATUS_CANT_CROSS_RM_BOUNDARY cpu_to_le32(0xC0190038)
+#define STATUS_TXF_DIR_NOT_EMPTY cpu_to_le32(0xC0190039)
+#define STATUS_INDOUBT_TRANSACTIONS_EXIST cpu_to_le32(0xC019003A)
+#define STATUS_TM_VOLATILE cpu_to_le32(0xC019003B)
+#define STATUS_ROLLBACK_TIMER_EXPIRED cpu_to_le32(0xC019003C)
+#define STATUS_TXF_ATTRIBUTE_CORRUPT cpu_to_le32(0xC019003D)
+#define STATUS_EFS_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC019003E)
+#define STATUS_TRANSACTIONAL_OPEN_NOT_ALLOWED cpu_to_le32(0xC019003F)
+#define STATUS_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE cpu_to_le32(0xC0190040)
+#define STATUS_TRANSACTION_REQUIRED_PROMOTION cpu_to_le32(0xC0190043)
+#define STATUS_CANNOT_EXECUTE_FILE_IN_TRANSACTION cpu_to_le32(0xC0190044)
+#define STATUS_TRANSACTIONS_NOT_FROZEN cpu_to_le32(0xC0190045)
+#define STATUS_TRANSACTION_FREEZE_IN_PROGRESS cpu_to_le32(0xC0190046)
+#define STATUS_NOT_SNAPSHOT_VOLUME cpu_to_le32(0xC0190047)
+#define STATUS_NO_SAVEPOINT_WITH_OPEN_FILES cpu_to_le32(0xC0190048)
+#define STATUS_SPARSE_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC0190049)
+#define STATUS_TM_IDENTITY_MISMATCH cpu_to_le32(0xC019004A)
+#define STATUS_FLOATED_SECTION cpu_to_le32(0xC019004B)
+#define STATUS_CANNOT_ACCEPT_TRANSACTED_WORK cpu_to_le32(0xC019004C)
+#define STATUS_CANNOT_ABORT_TRANSACTIONS cpu_to_le32(0xC019004D)
+#define STATUS_TRANSACTION_NOT_FOUND cpu_to_le32(0xC019004E)
+#define STATUS_RESOURCEMANAGER_NOT_FOUND cpu_to_le32(0xC019004F)
+#define STATUS_ENLISTMENT_NOT_FOUND cpu_to_le32(0xC0190050)
+#define STATUS_TRANSACTIONMANAGER_NOT_FOUND cpu_to_le32(0xC0190051)
+#define STATUS_TRANSACTIONMANAGER_NOT_ONLINE cpu_to_le32(0xC0190052)
+#define STATUS_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION	\
+	cpu_to_le32(0xC0190053)
+#define STATUS_TRANSACTION_NOT_ROOT cpu_to_le32(0xC0190054)
+#define STATUS_TRANSACTION_OBJECT_EXPIRED cpu_to_le32(0xC0190055)
+#define STATUS_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC0190056)
+#define STATUS_TRANSACTION_RESPONSE_NOT_ENLISTED cpu_to_le32(0xC0190057)
+#define STATUS_TRANSACTION_RECORD_TOO_LONG cpu_to_le32(0xC0190058)
+#define STATUS_NO_LINK_TRACKING_IN_TRANSACTION cpu_to_le32(0xC0190059)
+#define STATUS_OPERATION_NOT_SUPPORTED_IN_TRANSACTION cpu_to_le32(0xC019005A)
+#define STATUS_TRANSACTION_INTEGRITY_VIOLATED cpu_to_le32(0xC019005B)
+#define STATUS_LOG_SECTOR_INVALID cpu_to_le32(0xC01A0001)
+#define STATUS_LOG_SECTOR_PARITY_INVALID cpu_to_le32(0xC01A0002)
+#define STATUS_LOG_SECTOR_REMAPPED cpu_to_le32(0xC01A0003)
+#define STATUS_LOG_BLOCK_INCOMPLETE cpu_to_le32(0xC01A0004)
+#define STATUS_LOG_INVALID_RANGE cpu_to_le32(0xC01A0005)
+#define STATUS_LOG_BLOCKS_EXHAUSTED cpu_to_le32(0xC01A0006)
+#define STATUS_LOG_READ_CONTEXT_INVALID cpu_to_le32(0xC01A0007)
+#define STATUS_LOG_RESTART_INVALID cpu_to_le32(0xC01A0008)
+#define STATUS_LOG_BLOCK_VERSION cpu_to_le32(0xC01A0009)
+#define STATUS_LOG_BLOCK_INVALID cpu_to_le32(0xC01A000A)
+#define STATUS_LOG_READ_MODE_INVALID cpu_to_le32(0xC01A000B)
+#define STATUS_LOG_METADATA_CORRUPT cpu_to_le32(0xC01A000D)
+#define STATUS_LOG_METADATA_INVALID cpu_to_le32(0xC01A000E)
+#define STATUS_LOG_METADATA_INCONSISTENT cpu_to_le32(0xC01A000F)
+#define STATUS_LOG_RESERVATION_INVALID cpu_to_le32(0xC01A0010)
+#define STATUS_LOG_CANT_DELETE cpu_to_le32(0xC01A0011)
+#define STATUS_LOG_CONTAINER_LIMIT_EXCEEDED cpu_to_le32(0xC01A0012)
+#define STATUS_LOG_START_OF_LOG cpu_to_le32(0xC01A0013)
+#define STATUS_LOG_POLICY_ALREADY_INSTALLED cpu_to_le32(0xC01A0014)
+#define STATUS_LOG_POLICY_NOT_INSTALLED cpu_to_le32(0xC01A0015)
+#define STATUS_LOG_POLICY_INVALID cpu_to_le32(0xC01A0016)
+#define STATUS_LOG_POLICY_CONFLICT cpu_to_le32(0xC01A0017)
+#define STATUS_LOG_PINNED_ARCHIVE_TAIL cpu_to_le32(0xC01A0018)
+#define STATUS_LOG_RECORD_NONEXISTENT cpu_to_le32(0xC01A0019)
+#define STATUS_LOG_RECORDS_RESERVED_INVALID cpu_to_le32(0xC01A001A)
+#define STATUS_LOG_SPACE_RESERVED_INVALID cpu_to_le32(0xC01A001B)
+#define STATUS_LOG_TAIL_INVALID cpu_to_le32(0xC01A001C)
+#define STATUS_LOG_FULL cpu_to_le32(0xC01A001D)
+#define STATUS_LOG_MULTIPLEXED cpu_to_le32(0xC01A001E)
+#define STATUS_LOG_DEDICATED cpu_to_le32(0xC01A001F)
+#define STATUS_LOG_ARCHIVE_NOT_IN_PROGRESS cpu_to_le32(0xC01A0020)
+#define STATUS_LOG_ARCHIVE_IN_PROGRESS cpu_to_le32(0xC01A0021)
+#define STATUS_LOG_EPHEMERAL cpu_to_le32(0xC01A0022)
+#define STATUS_LOG_NOT_ENOUGH_CONTAINERS cpu_to_le32(0xC01A0023)
+#define STATUS_LOG_CLIENT_ALREADY_REGISTERED cpu_to_le32(0xC01A0024)
+#define STATUS_LOG_CLIENT_NOT_REGISTERED cpu_to_le32(0xC01A0025)
+#define STATUS_LOG_FULL_HANDLER_IN_PROGRESS cpu_to_le32(0xC01A0026)
+#define STATUS_LOG_CONTAINER_READ_FAILED cpu_to_le32(0xC01A0027)
+#define STATUS_LOG_CONTAINER_WRITE_FAILED cpu_to_le32(0xC01A0028)
+#define STATUS_LOG_CONTAINER_OPEN_FAILED cpu_to_le32(0xC01A0029)
+#define STATUS_LOG_CONTAINER_STATE_INVALID cpu_to_le32(0xC01A002A)
+#define STATUS_LOG_STATE_INVALID cpu_to_le32(0xC01A002B)
+#define STATUS_LOG_PINNED cpu_to_le32(0xC01A002C)
+#define STATUS_LOG_METADATA_FLUSH_FAILED cpu_to_le32(0xC01A002D)
+#define STATUS_LOG_INCONSISTENT_SECURITY cpu_to_le32(0xC01A002E)
+#define STATUS_LOG_APPENDED_FLUSH_FAILED cpu_to_le32(0xC01A002F)
+#define STATUS_LOG_PINNED_RESERVATION cpu_to_le32(0xC01A0030)
+#define STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD cpu_to_le32(0xC01B00EA)
+#define STATUS_FLT_NO_HANDLER_DEFINED cpu_to_le32(0xC01C0001)
+#define STATUS_FLT_CONTEXT_ALREADY_DEFINED cpu_to_le32(0xC01C0002)
+#define STATUS_FLT_INVALID_ASYNCHRONOUS_REQUEST cpu_to_le32(0xC01C0003)
+#define STATUS_FLT_DISALLOW_FAST_IO cpu_to_le32(0xC01C0004)
+#define STATUS_FLT_INVALID_NAME_REQUEST cpu_to_le32(0xC01C0005)
+#define STATUS_FLT_NOT_SAFE_TO_POST_OPERATION cpu_to_le32(0xC01C0006)
+#define STATUS_FLT_NOT_INITIALIZED cpu_to_le32(0xC01C0007)
+#define STATUS_FLT_FILTER_NOT_READY cpu_to_le32(0xC01C0008)
+#define STATUS_FLT_POST_OPERATION_CLEANUP cpu_to_le32(0xC01C0009)
+#define STATUS_FLT_INTERNAL_ERROR cpu_to_le32(0xC01C000A)
+#define STATUS_FLT_DELETING_OBJECT cpu_to_le32(0xC01C000B)
+#define STATUS_FLT_MUST_BE_NONPAGED_POOL cpu_to_le32(0xC01C000C)
+#define STATUS_FLT_DUPLICATE_ENTRY cpu_to_le32(0xC01C000D)
+#define STATUS_FLT_CBDQ_DISABLED cpu_to_le32(0xC01C000E)
+#define STATUS_FLT_DO_NOT_ATTACH cpu_to_le32(0xC01C000F)
+#define STATUS_FLT_DO_NOT_DETACH cpu_to_le32(0xC01C0010)
+#define STATUS_FLT_INSTANCE_ALTITUDE_COLLISION cpu_to_le32(0xC01C0011)
+#define STATUS_FLT_INSTANCE_NAME_COLLISION cpu_to_le32(0xC01C0012)
+#define STATUS_FLT_FILTER_NOT_FOUND cpu_to_le32(0xC01C0013)
+#define STATUS_FLT_VOLUME_NOT_FOUND cpu_to_le32(0xC01C0014)
+#define STATUS_FLT_INSTANCE_NOT_FOUND cpu_to_le32(0xC01C0015)
+#define STATUS_FLT_CONTEXT_ALLOCATION_NOT_FOUND cpu_to_le32(0xC01C0016)
+#define STATUS_FLT_INVALID_CONTEXT_REGISTRATION cpu_to_le32(0xC01C0017)
+#define STATUS_FLT_NAME_CACHE_MISS cpu_to_le32(0xC01C0018)
+#define STATUS_FLT_NO_DEVICE_OBJECT cpu_to_le32(0xC01C0019)
+#define STATUS_FLT_VOLUME_ALREADY_MOUNTED cpu_to_le32(0xC01C001A)
+#define STATUS_FLT_ALREADY_ENLISTED cpu_to_le32(0xC01C001B)
+#define STATUS_FLT_CONTEXT_ALREADY_LINKED cpu_to_le32(0xC01C001C)
+#define STATUS_FLT_NO_WAITER_FOR_REPLY cpu_to_le32(0xC01C0020)
+#define STATUS_MONITOR_NO_DESCRIPTOR cpu_to_le32(0xC01D0001)
+#define STATUS_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT cpu_to_le32(0xC01D0002)
+#define STATUS_MONITOR_INVALID_DESCRIPTOR_CHECKSUM cpu_to_le32(0xC01D0003)
+#define STATUS_MONITOR_INVALID_STANDARD_TIMING_BLOCK cpu_to_le32(0xC01D0004)
+#define STATUS_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED cpu_to_le32(0xC01D0005)
+#define STATUS_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK	\
+	cpu_to_le32(0xC01D0006)
+#define STATUS_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK	\
+	cpu_to_le32(0xC01D0007)
+#define STATUS_MONITOR_NO_MORE_DESCRIPTOR_DATA cpu_to_le32(0xC01D0008)
+#define STATUS_MONITOR_INVALID_DETAILED_TIMING_BLOCK cpu_to_le32(0xC01D0009)
+#define STATUS_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER cpu_to_le32(0xC01E0000)
+#define STATUS_GRAPHICS_INSUFFICIENT_DMA_BUFFER cpu_to_le32(0xC01E0001)
+#define STATUS_GRAPHICS_INVALID_DISPLAY_ADAPTER cpu_to_le32(0xC01E0002)
+#define STATUS_GRAPHICS_ADAPTER_WAS_RESET cpu_to_le32(0xC01E0003)
+#define STATUS_GRAPHICS_INVALID_DRIVER_MODEL cpu_to_le32(0xC01E0004)
+#define STATUS_GRAPHICS_PRESENT_MODE_CHANGED cpu_to_le32(0xC01E0005)
+#define STATUS_GRAPHICS_PRESENT_OCCLUDED cpu_to_le32(0xC01E0006)
+#define STATUS_GRAPHICS_PRESENT_DENIED cpu_to_le32(0xC01E0007)
+#define STATUS_GRAPHICS_CANNOTCOLORCONVERT cpu_to_le32(0xC01E0008)
+#define STATUS_GRAPHICS_NO_VIDEO_MEMORY cpu_to_le32(0xC01E0100)
+#define STATUS_GRAPHICS_CANT_LOCK_MEMORY cpu_to_le32(0xC01E0101)
+#define STATUS_GRAPHICS_ALLOCATION_BUSY cpu_to_le32(0xC01E0102)
+#define STATUS_GRAPHICS_TOO_MANY_REFERENCES cpu_to_le32(0xC01E0103)
+#define STATUS_GRAPHICS_TRY_AGAIN_LATER cpu_to_le32(0xC01E0104)
+#define STATUS_GRAPHICS_TRY_AGAIN_NOW cpu_to_le32(0xC01E0105)
+#define STATUS_GRAPHICS_ALLOCATION_INVALID cpu_to_le32(0xC01E0106)
+#define STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE cpu_to_le32(0xC01E0107)
+#define STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED cpu_to_le32(0xC01E0108)
+#define STATUS_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION cpu_to_le32(0xC01E0109)
+#define STATUS_GRAPHICS_INVALID_ALLOCATION_USAGE cpu_to_le32(0xC01E0110)
+#define STATUS_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION cpu_to_le32(0xC01E0111)
+#define STATUS_GRAPHICS_ALLOCATION_CLOSED cpu_to_le32(0xC01E0112)
+#define STATUS_GRAPHICS_INVALID_ALLOCATION_INSTANCE cpu_to_le32(0xC01E0113)
+#define STATUS_GRAPHICS_INVALID_ALLOCATION_HANDLE cpu_to_le32(0xC01E0114)
+#define STATUS_GRAPHICS_WRONG_ALLOCATION_DEVICE cpu_to_le32(0xC01E0115)
+#define STATUS_GRAPHICS_ALLOCATION_CONTENT_LOST cpu_to_le32(0xC01E0116)
+#define STATUS_GRAPHICS_GPU_EXCEPTION_ON_DEVICE cpu_to_le32(0xC01E0200)
+#define STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY cpu_to_le32(0xC01E0300)
+#define STATUS_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED cpu_to_le32(0xC01E0301)
+#define STATUS_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED	\
+	cpu_to_le32(0xC01E0302)
+#define STATUS_GRAPHICS_INVALID_VIDPN cpu_to_le32(0xC01E0303)
+#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE cpu_to_le32(0xC01E0304)
+#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET cpu_to_le32(0xC01E0305)
+#define STATUS_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED cpu_to_le32(0xC01E0306)
+#define STATUS_GRAPHICS_INVALID_VIDPN_SOURCEMODESET cpu_to_le32(0xC01E0308)
+#define STATUS_GRAPHICS_INVALID_VIDPN_TARGETMODESET cpu_to_le32(0xC01E0309)
+#define STATUS_GRAPHICS_INVALID_FREQUENCY cpu_to_le32(0xC01E030A)
+#define STATUS_GRAPHICS_INVALID_ACTIVE_REGION cpu_to_le32(0xC01E030B)
+#define STATUS_GRAPHICS_INVALID_TOTAL_REGION cpu_to_le32(0xC01E030C)
+#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE	\
+	cpu_to_le32(0xC01E0310)
+#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE	\
+	cpu_to_le32(0xC01E0311)
+#define STATUS_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET cpu_to_le32(0xC01E0312)
+#define STATUS_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY cpu_to_le32(0xC01E0313)
+#define STATUS_GRAPHICS_MODE_ALREADY_IN_MODESET cpu_to_le32(0xC01E0314)
+#define STATUS_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET cpu_to_le32(0xC01E0315)
+#define STATUS_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET cpu_to_le32(0xC01E0316)
+#define STATUS_GRAPHICS_SOURCE_ALREADY_IN_SET cpu_to_le32(0xC01E0317)
+#define STATUS_GRAPHICS_TARGET_ALREADY_IN_SET cpu_to_le32(0xC01E0318)
+#define STATUS_GRAPHICS_INVALID_VIDPN_PRESENT_PATH cpu_to_le32(0xC01E0319)
+#define STATUS_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY cpu_to_le32(0xC01E031A)
+#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET	\
+	cpu_to_le32(0xC01E031B)
+#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE cpu_to_le32(0xC01E031C)
+#define STATUS_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET cpu_to_le32(0xC01E031D)
+#define STATUS_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET cpu_to_le32(0xC01E031F)
+#define STATUS_GRAPHICS_STALE_MODESET cpu_to_le32(0xC01E0320)
+#define STATUS_GRAPHICS_INVALID_MONITOR_SOURCEMODESET cpu_to_le32(0xC01E0321)
+#define STATUS_GRAPHICS_INVALID_MONITOR_SOURCE_MODE cpu_to_le32(0xC01E0322)
+#define STATUS_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN cpu_to_le32(0xC01E0323)
+#define STATUS_GRAPHICS_MODE_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0324)
+#define STATUS_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION	\
+	cpu_to_le32(0xC01E0325)
+#define STATUS_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES	\
+	cpu_to_le32(0xC01E0326)
+#define STATUS_GRAPHICS_PATH_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0327)
+#define STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE	\
+	cpu_to_le32(0xC01E0328)
+#define STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET	\
+	cpu_to_le32(0xC01E0329)
+#define STATUS_GRAPHICS_INVALID_MONITORDESCRIPTORSET cpu_to_le32(0xC01E032A)
+#define STATUS_GRAPHICS_INVALID_MONITORDESCRIPTOR cpu_to_le32(0xC01E032B)
+#define STATUS_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET cpu_to_le32(0xC01E032C)
+#define STATUS_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET cpu_to_le32(0xC01E032D)
+#define STATUS_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE	\
+	cpu_to_le32(0xC01E032E)
+#define STATUS_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE cpu_to_le32(0xC01E032F)
+#define STATUS_GRAPHICS_RESOURCES_NOT_RELATED cpu_to_le32(0xC01E0330)
+#define STATUS_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0331)
+#define STATUS_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0332)
+#define STATUS_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET cpu_to_le32(0xC01E0333)
+#define STATUS_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER	\
+	cpu_to_le32(0xC01E0334)
+#define STATUS_GRAPHICS_NO_VIDPNMGR cpu_to_le32(0xC01E0335)
+#define STATUS_GRAPHICS_NO_ACTIVE_VIDPN cpu_to_le32(0xC01E0336)
+#define STATUS_GRAPHICS_STALE_VIDPN_TOPOLOGY cpu_to_le32(0xC01E0337)
+#define STATUS_GRAPHICS_MONITOR_NOT_CONNECTED cpu_to_le32(0xC01E0338)
+#define STATUS_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0339)
+#define STATUS_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE cpu_to_le32(0xC01E033A)
+#define STATUS_GRAPHICS_INVALID_VISIBLEREGION_SIZE cpu_to_le32(0xC01E033B)
+#define STATUS_GRAPHICS_INVALID_STRIDE cpu_to_le32(0xC01E033C)
+#define STATUS_GRAPHICS_INVALID_PIXELFORMAT cpu_to_le32(0xC01E033D)
+#define STATUS_GRAPHICS_INVALID_COLORBASIS cpu_to_le32(0xC01E033E)
+#define STATUS_GRAPHICS_INVALID_PIXELVALUEACCESSMODE cpu_to_le32(0xC01E033F)
+#define STATUS_GRAPHICS_TARGET_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0340)
+#define STATUS_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT	\
+	cpu_to_le32(0xC01E0341)
+#define STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE cpu_to_le32(0xC01E0342)
+#define STATUS_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN cpu_to_le32(0xC01E0343)
+#define STATUS_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL cpu_to_le32(0xC01E0344)
+#define STATUS_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION	\
+	cpu_to_le32(0xC01E0345)
+#define STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORTED \
+	cpu_to_le32(0xC01E0346)
+#define STATUS_GRAPHICS_INVALID_GAMMA_RAMP cpu_to_le32(0xC01E0347)
+#define STATUS_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED cpu_to_le32(0xC01E0348)
+#define STATUS_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED cpu_to_le32(0xC01E0349)
+#define STATUS_GRAPHICS_MODE_NOT_IN_MODESET cpu_to_le32(0xC01E034A)
+#define STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON	\
+	cpu_to_le32(0xC01E034D)
+#define STATUS_GRAPHICS_INVALID_PATH_CONTENT_TYPE cpu_to_le32(0xC01E034E)
+#define STATUS_GRAPHICS_INVALID_COPYPROTECTION_TYPE cpu_to_le32(0xC01E034F)
+#define STATUS_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS	\
+	cpu_to_le32(0xC01E0350)
+#define STATUS_GRAPHICS_INVALID_SCANLINE_ORDERING cpu_to_le32(0xC01E0352)
+#define STATUS_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED cpu_to_le32(0xC01E0353)
+#define STATUS_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS cpu_to_le32(0xC01E0354)
+#define STATUS_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT cpu_to_le32(0xC01E0355)
+#define STATUS_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM cpu_to_le32(0xC01E0356)
+#define STATUS_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN	\
+	cpu_to_le32(0xC01E0357)
+#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT	\
+	cpu_to_le32(0xC01E0358)
+#define STATUS_GRAPHICS_MAX_NUM_PATHS_REACHED cpu_to_le32(0xC01E0359)
+#define STATUS_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION	\
+	cpu_to_le32(0xC01E035A)
+#define STATUS_GRAPHICS_INVALID_CLIENT_TYPE cpu_to_le32(0xC01E035B)
+#define STATUS_GRAPHICS_CLIENTVIDPN_NOT_SET cpu_to_le32(0xC01E035C)
+#define STATUS_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED	\
+	cpu_to_le32(0xC01E0400)
+#define STATUS_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED cpu_to_le32(0xC01E0401)
+#define STATUS_GRAPHICS_NOT_A_LINKED_ADAPTER cpu_to_le32(0xC01E0430)
+#define STATUS_GRAPHICS_LEADLINK_NOT_ENUMERATED cpu_to_le32(0xC01E0431)
+#define STATUS_GRAPHICS_CHAINLINKS_NOT_ENUMERATED cpu_to_le32(0xC01E0432)
+#define STATUS_GRAPHICS_ADAPTER_CHAIN_NOT_READY cpu_to_le32(0xC01E0433)
+#define STATUS_GRAPHICS_CHAINLINKS_NOT_STARTED cpu_to_le32(0xC01E0434)
+#define STATUS_GRAPHICS_CHAINLINKS_NOT_POWERED_ON cpu_to_le32(0xC01E0435)
+#define STATUS_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE cpu_to_le32(0xC01E0436)
+#define STATUS_GRAPHICS_NOT_POST_DEVICE_DRIVER cpu_to_le32(0xC01E0438)
+#define STATUS_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED cpu_to_le32(0xC01E043B)
+#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTICS \
+	cpu_to_le32(0xC01E051C)
+#define STATUS_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST cpu_to_le32(0xC01E051D)
+#define STATUS_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR cpu_to_le32(0xC01E051E)
+#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS \
+	cpu_to_le32(0xC01E051F)
+#define STATUS_GRAPHICS_OPM_SIGNALING_NOT_SUPPORTED cpu_to_le32(0xC01E0520)
+#define STATUS_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST	\
+	cpu_to_le32(0xC01E0521)
+#define STATUS_GRAPHICS_OPM_NOT_SUPPORTED cpu_to_le32(0xC01E0500)
+#define STATUS_GRAPHICS_COPP_NOT_SUPPORTED cpu_to_le32(0xC01E0501)
+#define STATUS_GRAPHICS_UAB_NOT_SUPPORTED cpu_to_le32(0xC01E0502)
+#define STATUS_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS cpu_to_le32(0xC01E0503)
+#define STATUS_GRAPHICS_OPM_PARAMETER_ARRAY_TOO_SMALL cpu_to_le32(0xC01E0504)
+#define STATUS_GRAPHICS_OPM_NO_PROTECTED_OUTPUTS_EXIST cpu_to_le32(0xC01E0505)
+#define STATUS_GRAPHICS_PVP_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME	\
+	cpu_to_le32(0xC01E0506)
+#define STATUS_GRAPHICS_PVP_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP	\
+	cpu_to_le32(0xC01E0507)
+#define STATUS_GRAPHICS_PVP_MIRRORING_DEVICES_NOT_SUPPORTED	\
+	cpu_to_le32(0xC01E0508)
+#define STATUS_GRAPHICS_OPM_INVALID_POINTER cpu_to_le32(0xC01E050A)
+#define STATUS_GRAPHICS_OPM_INTERNAL_ERROR cpu_to_le32(0xC01E050B)
+#define STATUS_GRAPHICS_OPM_INVALID_HANDLE cpu_to_le32(0xC01E050C)
+#define STATUS_GRAPHICS_PVP_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE	\
+	cpu_to_le32(0xC01E050D)
+#define STATUS_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH cpu_to_le32(0xC01E050E)
+#define STATUS_GRAPHICS_OPM_SPANNING_MODE_ENABLED cpu_to_le32(0xC01E050F)
+#define STATUS_GRAPHICS_OPM_THEATER_MODE_ENABLED cpu_to_le32(0xC01E0510)
+#define STATUS_GRAPHICS_PVP_HFS_FAILED cpu_to_le32(0xC01E0511)
+#define STATUS_GRAPHICS_OPM_INVALID_SRM cpu_to_le32(0xC01E0512)
+#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP cpu_to_le32(0xC01E0513)
+#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP cpu_to_le32(0xC01E0514)
+#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA	\
+	cpu_to_le32(0xC01E0515)
+#define STATUS_GRAPHICS_OPM_HDCP_SRM_NEVER_SET cpu_to_le32(0xC01E0516)
+#define STATUS_GRAPHICS_OPM_RESOLUTION_TOO_HIGH cpu_to_le32(0xC01E0517)
+#define STATUS_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE	\
+	cpu_to_le32(0xC01E0518)
+#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_NO_LONGER_EXISTS	\
+	cpu_to_le32(0xC01E051A)
+#define STATUS_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS	\
+	cpu_to_le32(0xC01E051B)
+#define STATUS_GRAPHICS_I2C_NOT_SUPPORTED cpu_to_le32(0xC01E0580)
+#define STATUS_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST cpu_to_le32(0xC01E0581)
+#define STATUS_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA cpu_to_le32(0xC01E0582)
+#define STATUS_GRAPHICS_I2C_ERROR_RECEIVING_DATA cpu_to_le32(0xC01E0583)
+#define STATUS_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED cpu_to_le32(0xC01E0584)
+#define STATUS_GRAPHICS_DDCCI_INVALID_DATA cpu_to_le32(0xC01E0585)
+#define STATUS_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYTE \
+	cpu_to_le32(0xC01E0586)
+#define STATUS_GRAPHICS_DDCCI_INVALID_CAPABILITIES_STRING	\
+	cpu_to_le32(0xC01E0587)
+#define STATUS_GRAPHICS_MCA_INTERNAL_ERROR cpu_to_le32(0xC01E0588)
+#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND cpu_to_le32(0xC01E0589)
+#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH cpu_to_le32(0xC01E058A)
+#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM cpu_to_le32(0xC01E058B)
+#define STATUS_GRAPHICS_INVALID_PHYSICAL_MONITOR_HANDLE cpu_to_le32(0xC01E058C)
+#define STATUS_GRAPHICS_MONITOR_NO_LONGER_EXISTS cpu_to_le32(0xC01E058D)
+#define STATUS_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED cpu_to_le32(0xC01E05E0)
+#define STATUS_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME	\
+	cpu_to_le32(0xC01E05E1)
+#define STATUS_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP	\
+	cpu_to_le32(0xC01E05E2)
+#define STATUS_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED cpu_to_le32(0xC01E05E3)
+#define STATUS_GRAPHICS_INVALID_POINTER cpu_to_le32(0xC01E05E4)
+#define STATUS_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE	\
+	cpu_to_le32(0xC01E05E5)
+#define STATUS_GRAPHICS_PARAMETER_ARRAY_TOO_SMALL cpu_to_le32(0xC01E05E6)
+#define STATUS_GRAPHICS_INTERNAL_ERROR cpu_to_le32(0xC01E05E7)
+#define STATUS_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS cpu_to_le32(0xC01E05E8)
+#define STATUS_FVE_LOCKED_VOLUME cpu_to_le32(0xC0210000)
+#define STATUS_FVE_NOT_ENCRYPTED cpu_to_le32(0xC0210001)
+#define STATUS_FVE_BAD_INFORMATION cpu_to_le32(0xC0210002)
+#define STATUS_FVE_TOO_SMALL cpu_to_le32(0xC0210003)
+#define STATUS_FVE_FAILED_WRONG_FS cpu_to_le32(0xC0210004)
+#define STATUS_FVE_FAILED_BAD_FS cpu_to_le32(0xC0210005)
+#define STATUS_FVE_FS_NOT_EXTENDED cpu_to_le32(0xC0210006)
+#define STATUS_FVE_FS_MOUNTED cpu_to_le32(0xC0210007)
+#define STATUS_FVE_NO_LICENSE cpu_to_le32(0xC0210008)
+#define STATUS_FVE_ACTION_NOT_ALLOWED cpu_to_le32(0xC0210009)
+#define STATUS_FVE_BAD_DATA cpu_to_le32(0xC021000A)
+#define STATUS_FVE_VOLUME_NOT_BOUND cpu_to_le32(0xC021000B)
+#define STATUS_FVE_NOT_DATA_VOLUME cpu_to_le32(0xC021000C)
+#define STATUS_FVE_CONV_READ_ERROR cpu_to_le32(0xC021000D)
+#define STATUS_FVE_CONV_WRITE_ERROR cpu_to_le32(0xC021000E)
+#define STATUS_FVE_OVERLAPPED_UPDATE cpu_to_le32(0xC021000F)
+#define STATUS_FVE_FAILED_SECTOR_SIZE cpu_to_le32(0xC0210010)
+#define STATUS_FVE_FAILED_AUTHENTICATION cpu_to_le32(0xC0210011)
+#define STATUS_FVE_NOT_OS_VOLUME cpu_to_le32(0xC0210012)
+#define STATUS_FVE_KEYFILE_NOT_FOUND cpu_to_le32(0xC0210013)
+#define STATUS_FVE_KEYFILE_INVALID cpu_to_le32(0xC0210014)
+#define STATUS_FVE_KEYFILE_NO_VMK cpu_to_le32(0xC0210015)
+#define STATUS_FVE_TPM_DISABLED cpu_to_le32(0xC0210016)
+#define STATUS_FVE_TPM_SRK_AUTH_NOT_ZERO cpu_to_le32(0xC0210017)
+#define STATUS_FVE_TPM_INVALID_PCR cpu_to_le32(0xC0210018)
+#define STATUS_FVE_TPM_NO_VMK cpu_to_le32(0xC0210019)
+#define STATUS_FVE_PIN_INVALID cpu_to_le32(0xC021001A)
+#define STATUS_FVE_AUTH_INVALID_APPLICATION cpu_to_le32(0xC021001B)
+#define STATUS_FVE_AUTH_INVALID_CONFIG cpu_to_le32(0xC021001C)
+#define STATUS_FVE_DEBUGGER_ENABLED cpu_to_le32(0xC021001D)
+#define STATUS_FVE_DRY_RUN_FAILED cpu_to_le32(0xC021001E)
+#define STATUS_FVE_BAD_METADATA_POINTER cpu_to_le32(0xC021001F)
+#define STATUS_FVE_OLD_METADATA_COPY cpu_to_le32(0xC0210020)
+#define STATUS_FVE_REBOOT_REQUIRED cpu_to_le32(0xC0210021)
+#define STATUS_FVE_RAW_ACCESS cpu_to_le32(0xC0210022)
+#define STATUS_FVE_RAW_BLOCKED cpu_to_le32(0xC0210023)
+#define STATUS_FWP_CALLOUT_NOT_FOUND cpu_to_le32(0xC0220001)
+#define STATUS_FWP_CONDITION_NOT_FOUND cpu_to_le32(0xC0220002)
+#define STATUS_FWP_FILTER_NOT_FOUND cpu_to_le32(0xC0220003)
+#define STATUS_FWP_LAYER_NOT_FOUND cpu_to_le32(0xC0220004)
+#define STATUS_FWP_PROVIDER_NOT_FOUND cpu_to_le32(0xC0220005)
+#define STATUS_FWP_PROVIDER_CONTEXT_NOT_FOUND cpu_to_le32(0xC0220006)
+#define STATUS_FWP_SUBLAYER_NOT_FOUND cpu_to_le32(0xC0220007)
+#define STATUS_FWP_NOT_FOUND cpu_to_le32(0xC0220008)
+#define STATUS_FWP_ALREADY_EXISTS cpu_to_le32(0xC0220009)
+#define STATUS_FWP_IN_USE cpu_to_le32(0xC022000A)
+#define STATUS_FWP_DYNAMIC_SESSION_IN_PROGRESS cpu_to_le32(0xC022000B)
+#define STATUS_FWP_WRONG_SESSION cpu_to_le32(0xC022000C)
+#define STATUS_FWP_NO_TXN_IN_PROGRESS cpu_to_le32(0xC022000D)
+#define STATUS_FWP_TXN_IN_PROGRESS cpu_to_le32(0xC022000E)
+#define STATUS_FWP_TXN_ABORTED cpu_to_le32(0xC022000F)
+#define STATUS_FWP_SESSION_ABORTED cpu_to_le32(0xC0220010)
+#define STATUS_FWP_INCOMPATIBLE_TXN cpu_to_le32(0xC0220011)
+#define STATUS_FWP_TIMEOUT cpu_to_le32(0xC0220012)
+#define STATUS_FWP_NET_EVENTS_DISABLED cpu_to_le32(0xC0220013)
+#define STATUS_FWP_INCOMPATIBLE_LAYER cpu_to_le32(0xC0220014)
+#define STATUS_FWP_KM_CLIENTS_ONLY cpu_to_le32(0xC0220015)
+#define STATUS_FWP_LIFETIME_MISMATCH cpu_to_le32(0xC0220016)
+#define STATUS_FWP_BUILTIN_OBJECT cpu_to_le32(0xC0220017)
+#define STATUS_FWP_TOO_MANY_BOOTTIME_FILTERS cpu_to_le32(0xC0220018)
+#define STATUS_FWP_TOO_MANY_CALLOUTS cpu_to_le32(0xC0220018)
+#define STATUS_FWP_NOTIFICATION_DROPPED cpu_to_le32(0xC0220019)
+#define STATUS_FWP_TRAFFIC_MISMATCH cpu_to_le32(0xC022001A)
+#define STATUS_FWP_INCOMPATIBLE_SA_STATE cpu_to_le32(0xC022001B)
+#define STATUS_FWP_NULL_POINTER cpu_to_le32(0xC022001C)
+#define STATUS_FWP_INVALID_ENUMERATOR cpu_to_le32(0xC022001D)
+#define STATUS_FWP_INVALID_FLAGS cpu_to_le32(0xC022001E)
+#define STATUS_FWP_INVALID_NET_MASK cpu_to_le32(0xC022001F)
+#define STATUS_FWP_INVALID_RANGE cpu_to_le32(0xC0220020)
+#define STATUS_FWP_INVALID_INTERVAL cpu_to_le32(0xC0220021)
+#define STATUS_FWP_ZERO_LENGTH_ARRAY cpu_to_le32(0xC0220022)
+#define STATUS_FWP_NULL_DISPLAY_NAME cpu_to_le32(0xC0220023)
+#define STATUS_FWP_INVALID_ACTION_TYPE cpu_to_le32(0xC0220024)
+#define STATUS_FWP_INVALID_WEIGHT cpu_to_le32(0xC0220025)
+#define STATUS_FWP_MATCH_TYPE_MISMATCH cpu_to_le32(0xC0220026)
+#define STATUS_FWP_TYPE_MISMATCH cpu_to_le32(0xC0220027)
+#define STATUS_FWP_OUT_OF_BOUNDS cpu_to_le32(0xC0220028)
+#define STATUS_FWP_RESERVED cpu_to_le32(0xC0220029)
+#define STATUS_FWP_DUPLICATE_CONDITION cpu_to_le32(0xC022002A)
+#define STATUS_FWP_DUPLICATE_KEYMOD cpu_to_le32(0xC022002B)
+#define STATUS_FWP_ACTION_INCOMPATIBLE_WITH_LAYER cpu_to_le32(0xC022002C)
+#define STATUS_FWP_ACTION_INCOMPATIBLE_WITH_SUBLAYER cpu_to_le32(0xC022002D)
+#define STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_LAYER cpu_to_le32(0xC022002E)
+#define STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_CALLOUT cpu_to_le32(0xC022002F)
+#define STATUS_FWP_INCOMPATIBLE_AUTH_METHOD cpu_to_le32(0xC0220030)
+#define STATUS_FWP_INCOMPATIBLE_DH_GROUP cpu_to_le32(0xC0220031)
+#define STATUS_FWP_EM_NOT_SUPPORTED cpu_to_le32(0xC0220032)
+#define STATUS_FWP_NEVER_MATCH cpu_to_le32(0xC0220033)
+#define STATUS_FWP_PROVIDER_CONTEXT_MISMATCH cpu_to_le32(0xC0220034)
+#define STATUS_FWP_INVALID_PARAMETER cpu_to_le32(0xC0220035)
+#define STATUS_FWP_TOO_MANY_SUBLAYERS cpu_to_le32(0xC0220036)
+#define STATUS_FWP_CALLOUT_NOTIFICATION_FAILED cpu_to_le32(0xC0220037)
+#define STATUS_FWP_INCOMPATIBLE_AUTH_CONFIG cpu_to_le32(0xC0220038)
+#define STATUS_FWP_INCOMPATIBLE_CIPHER_CONFIG cpu_to_le32(0xC0220039)
+#define STATUS_FWP_TCPIP_NOT_READY cpu_to_le32(0xC0220100)
+#define STATUS_FWP_INJECT_HANDLE_CLOSING cpu_to_le32(0xC0220101)
+#define STATUS_FWP_INJECT_HANDLE_STALE cpu_to_le32(0xC0220102)
+#define STATUS_FWP_CANNOT_PEND cpu_to_le32(0xC0220103)
+#define STATUS_NDIS_CLOSING cpu_to_le32(0xC0230002)
+#define STATUS_NDIS_BAD_VERSION cpu_to_le32(0xC0230004)
+#define STATUS_NDIS_BAD_CHARACTERISTICS cpu_to_le32(0xC0230005)
+#define STATUS_NDIS_ADAPTER_NOT_FOUND cpu_to_le32(0xC0230006)
+#define STATUS_NDIS_OPEN_FAILED cpu_to_le32(0xC0230007)
+#define STATUS_NDIS_DEVICE_FAILED cpu_to_le32(0xC0230008)
+#define STATUS_NDIS_MULTICAST_FULL cpu_to_le32(0xC0230009)
+#define STATUS_NDIS_MULTICAST_EXISTS cpu_to_le32(0xC023000A)
+#define STATUS_NDIS_MULTICAST_NOT_FOUND cpu_to_le32(0xC023000B)
+#define STATUS_NDIS_REQUEST_ABORTED cpu_to_le32(0xC023000C)
+#define STATUS_NDIS_RESET_IN_PROGRESS cpu_to_le32(0xC023000D)
+#define STATUS_NDIS_INVALID_PACKET cpu_to_le32(0xC023000F)
+#define STATUS_NDIS_INVALID_DEVICE_REQUEST cpu_to_le32(0xC0230010)
+#define STATUS_NDIS_ADAPTER_NOT_READY cpu_to_le32(0xC0230011)
+#define STATUS_NDIS_INVALID_LENGTH cpu_to_le32(0xC0230014)
+#define STATUS_NDIS_INVALID_DATA cpu_to_le32(0xC0230015)
+#define STATUS_NDIS_BUFFER_TOO_SHORT cpu_to_le32(0xC0230016)
+#define STATUS_NDIS_INVALID_OID cpu_to_le32(0xC0230017)
+#define STATUS_NDIS_ADAPTER_REMOVED cpu_to_le32(0xC0230018)
+#define STATUS_NDIS_UNSUPPORTED_MEDIA cpu_to_le32(0xC0230019)
+#define STATUS_NDIS_GROUP_ADDRESS_IN_USE cpu_to_le32(0xC023001A)
+#define STATUS_NDIS_FILE_NOT_FOUND cpu_to_le32(0xC023001B)
+#define STATUS_NDIS_ERROR_READING_FILE cpu_to_le32(0xC023001C)
+#define STATUS_NDIS_ALREADY_MAPPED cpu_to_le32(0xC023001D)
+#define STATUS_NDIS_RESOURCE_CONFLICT cpu_to_le32(0xC023001E)
+#define STATUS_NDIS_MEDIA_DISCONNECTED cpu_to_le32(0xC023001F)
+#define STATUS_NDIS_INVALID_ADDRESS cpu_to_le32(0xC0230022)
+#define STATUS_NDIS_PAUSED cpu_to_le32(0xC023002A)
+#define STATUS_NDIS_INTERFACE_NOT_FOUND cpu_to_le32(0xC023002B)
+#define STATUS_NDIS_UNSUPPORTED_REVISION cpu_to_le32(0xC023002C)
+#define STATUS_NDIS_INVALID_PORT cpu_to_le32(0xC023002D)
+#define STATUS_NDIS_INVALID_PORT_STATE cpu_to_le32(0xC023002E)
+#define STATUS_NDIS_LOW_POWER_STATE cpu_to_le32(0xC023002F)
+#define STATUS_NDIS_NOT_SUPPORTED cpu_to_le32(0xC02300BB)
+#define STATUS_NDIS_DOT11_AUTO_CONFIG_ENABLED cpu_to_le32(0xC0232000)
+#define STATUS_NDIS_DOT11_MEDIA_IN_USE cpu_to_le32(0xC0232001)
+#define STATUS_NDIS_DOT11_POWER_STATE_INVALID cpu_to_le32(0xC0232002)
+#define STATUS_IPSEC_BAD_SPI cpu_to_le32(0xC0360001)
+#define STATUS_IPSEC_SA_LIFETIME_EXPIRED cpu_to_le32(0xC0360002)
+#define STATUS_IPSEC_WRONG_SA cpu_to_le32(0xC0360003)
+#define STATUS_IPSEC_REPLAY_CHECK_FAILED cpu_to_le32(0xC0360004)
+#define STATUS_IPSEC_INVALID_PACKET cpu_to_le32(0xC0360005)
+#define STATUS_IPSEC_INTEGRITY_CHECK_FAILED cpu_to_le32(0xC0360006)
+#define STATUS_IPSEC_CLEAR_TEXT_DROP cpu_to_le32(0xC0360007)
+
+#define STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP cpu_to_le32(0xC05D0000)
+#define STATUS_INVALID_LOCK_RANGE cpu_to_le32(0xC00001a1)
diff --git a/fs/ksmbd/unicode.c b/fs/ksmbd/unicode.c
new file mode 100644
index 000000000000..a0db699ddafd
--- /dev/null
+++ b/fs/ksmbd/unicode.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Some of the source code in this file came from fs/cifs/cifs_unicode.c
+ *
+ *   Copyright (c) International Business Machines  Corp., 2000,2009
+ *   Modified by Steve French (sfrench@us.ibm.com)
+ *   Modified by Namjae Jeon (linkinjeon@kernel.org)
+ */
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+#include "glob.h"
+#include "unicode.h"
+#include "uniupr.h"
+#include "smb_common.h"
+
+/*
+ * smb_utf16_bytes() - how long will a string be after conversion?
+ * @from:	pointer to input string
+ * @maxbytes:	don't go past this many bytes of input string
+ * @codepage:	destination codepage
+ *
+ * Walk a utf16le string and return the number of bytes that the string will
+ * be after being converted to the given charset, not including any null
+ * termination required. Don't walk past maxbytes in the source buffer.
+ *
+ * Return:	string length after conversion
+ */
+static int smb_utf16_bytes(const __le16 *from, int maxbytes,
+			   const struct nls_table *codepage)
+{
+	int i;
+	int charlen, outlen = 0;
+	int maxwords = maxbytes / 2;
+	char tmp[NLS_MAX_CHARSET_SIZE];
+	__u16 ftmp;
+
+	for (i = 0; i < maxwords; i++) {
+		ftmp = get_unaligned_le16(&from[i]);
+		if (ftmp == 0)
+			break;
+
+		charlen = codepage->uni2char(ftmp, tmp, NLS_MAX_CHARSET_SIZE);
+		if (charlen > 0)
+			outlen += charlen;
+		else
+			outlen++;
+	}
+
+	return outlen;
+}
+
+/*
+ * cifs_mapchar() - convert a host-endian char to proper char in codepage
+ * @target:	where converted character should be copied
+ * @src_char:	2 byte host-endian source character
+ * @cp:		codepage to which character should be converted
+ * @mapchar:	should character be mapped according to mapchars mount option?
+ *
+ * This function handles the conversion of a single character. It is the
+ * responsibility of the caller to ensure that the target buffer is large
+ * enough to hold the result of the conversion (at least NLS_MAX_CHARSET_SIZE).
+ *
+ * Return:	string length after conversion
+ */
+static int
+cifs_mapchar(char *target, const __u16 src_char, const struct nls_table *cp,
+	     bool mapchar)
+{
+	int len = 1;
+
+	if (!mapchar)
+		goto cp_convert;
+
+	/*
+	 * BB: Cannot handle remapping UNI_SLASH until all the calls to
+	 *     build_path_from_dentry are modified, as they use slash as
+	 *     separator.
+	 */
+	switch (src_char) {
+	case UNI_COLON:
+		*target = ':';
+		break;
+	case UNI_ASTERISK:
+		*target = '*';
+		break;
+	case UNI_QUESTION:
+		*target = '?';
+		break;
+	case UNI_PIPE:
+		*target = '|';
+		break;
+	case UNI_GRTRTHAN:
+		*target = '>';
+		break;
+	case UNI_LESSTHAN:
+		*target = '<';
+		break;
+	default:
+		goto cp_convert;
+	}
+
+out:
+	return len;
+
+cp_convert:
+	len = cp->uni2char(src_char, target, NLS_MAX_CHARSET_SIZE);
+	if (len <= 0) {
+		*target = '?';
+		len = 1;
+	}
+
+	goto out;
+}
+
+/*
+ * is_char_allowed() - check for valid character
+ * @ch:		input character to be checked
+ *
+ * Return:	1 if char is allowed, otherwise 0
+ */
+static inline int is_char_allowed(char *ch)
+{
+	/* check for control chars, wildcards etc. */
+	if (!(*ch & 0x80) &&
+	    (*ch <= 0x1f ||
+	     *ch == '?' || *ch == '"' || *ch == '<' ||
+	     *ch == '>' || *ch == '|'))
+		return 0;
+
+	return 1;
+}
+
+/*
+ * smb_from_utf16() - convert utf16le string to local charset
+ * @to:		destination buffer
+ * @from:	source buffer
+ * @tolen:	destination buffer size (in bytes)
+ * @fromlen:	source buffer size (in bytes)
+ * @codepage:	codepage to which characters should be converted
+ * @mapchar:	should characters be remapped according to the mapchars option?
+ *
+ * Convert a little-endian utf16le string (as sent by the server) to a string
+ * in the provided codepage. The tolen and fromlen parameters are to ensure
+ * that the code doesn't walk off of the end of the buffer (which is always
+ * a danger if the alignment of the source buffer is off). The destination
+ * string is always properly null terminated and fits in the destination
+ * buffer. Returns the length of the destination string in bytes (including
+ * null terminator).
+ *
+ * Note that some windows versions actually send multiword UTF-16 characters
+ * instead of straight UTF16-2. The linux nls routines however aren't able to
+ * deal with those characters properly. In the event that we get some of
+ * those characters, they won't be translated properly.
+ *
+ * Return:	string length after conversion
+ */
+static int smb_from_utf16(char *to, const __le16 *from, int tolen, int fromlen,
+			  const struct nls_table *codepage, bool mapchar)
+{
+	int i, charlen, safelen;
+	int outlen = 0;
+	int nullsize = nls_nullsize(codepage);
+	int fromwords = fromlen / 2;
+	char tmp[NLS_MAX_CHARSET_SIZE];
+	__u16 ftmp;
+
+	/*
+	 * because the chars can be of varying widths, we need to take care
+	 * not to overflow the destination buffer when we get close to the
+	 * end of it. Until we get to this offset, we don't need to check
+	 * for overflow however.
+	 */
+	safelen = tolen - (NLS_MAX_CHARSET_SIZE + nullsize);
+
+	for (i = 0; i < fromwords; i++) {
+		ftmp = get_unaligned_le16(&from[i]);
+		if (ftmp == 0)
+			break;
+
+		/*
+		 * check to see if converting this character might make the
+		 * conversion bleed into the null terminator
+		 */
+		if (outlen >= safelen) {
+			charlen = cifs_mapchar(tmp, ftmp, codepage, mapchar);
+			if ((outlen + charlen) > (tolen - nullsize))
+				break;
+		}
+
+		/* put converted char into 'to' buffer */
+		charlen = cifs_mapchar(&to[outlen], ftmp, codepage, mapchar);
+		outlen += charlen;
+	}
+
+	/* properly null-terminate string */
+	for (i = 0; i < nullsize; i++)
+		to[outlen++] = 0;
+
+	return outlen;
+}
+
+/*
+ * smb_strtoUTF16() - Convert character string to unicode string
+ * @to:		destination buffer
+ * @from:	source buffer
+ * @len:	destination buffer size (in bytes)
+ * @codepage:	codepage to which characters should be converted
+ *
+ * Return:	string length after conversion
+ */
+int smb_strtoUTF16(__le16 *to, const char *from, int len,
+		   const struct nls_table *codepage)
+{
+	int charlen;
+	int i;
+	wchar_t wchar_to; /* needed to quiet sparse */
+
+	/* special case for utf8 to handle no plane0 chars */
+	if (!strcmp(codepage->charset, "utf8")) {
+		/*
+		 * convert utf8 -> utf16, we assume we have enough space
+		 * as caller should have assumed conversion does not overflow
+		 * in destination len is length in wchar_t units (16bits)
+		 */
+		i  = utf8s_to_utf16s(from, len, UTF16_LITTLE_ENDIAN,
+				     (wchar_t *)to, len);
+
+		/* if success terminate and exit */
+		if (i >= 0)
+			goto success;
+		/*
+		 * if fails fall back to UCS encoding as this
+		 * function should not return negative values
+		 * currently can fail only if source contains
+		 * invalid encoded characters
+		 */
+	}
+
+	for (i = 0; len > 0 && *from; i++, from += charlen, len -= charlen) {
+		charlen = codepage->char2uni(from, len, &wchar_to);
+		if (charlen < 1) {
+			/* A question mark */
+			wchar_to = 0x003f;
+			charlen = 1;
+		}
+		put_unaligned_le16(wchar_to, &to[i]);
+	}
+
+success:
+	put_unaligned_le16(0, &to[i]);
+	return i;
+}
+
+/*
+ * smb_strndup_from_utf16() - copy a string from wire format to the local
+ *		codepage
+ * @src:	source string
+ * @maxlen:	don't walk past this many bytes in the source string
+ * @is_unicode:	is this a unicode string?
+ * @codepage:	destination codepage
+ *
+ * Take a string given by the server, convert it to the local codepage and
+ * put it in a new buffer. Returns a pointer to the new string or NULL on
+ * error.
+ *
+ * Return:	destination string buffer or error ptr
+ */
+char *smb_strndup_from_utf16(const char *src, const int maxlen,
+			     const bool is_unicode,
+			     const struct nls_table *codepage)
+{
+	int len, ret;
+	char *dst;
+
+	if (is_unicode) {
+		len = smb_utf16_bytes((__le16 *)src, maxlen, codepage);
+		len += nls_nullsize(codepage);
+		dst = kmalloc(len, GFP_KERNEL);
+		if (!dst)
+			return ERR_PTR(-ENOMEM);
+		ret = smb_from_utf16(dst, (__le16 *)src, len, maxlen, codepage,
+				     false);
+		if (ret < 0) {
+			kfree(dst);
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		len = strnlen(src, maxlen);
+		len++;
+		dst = kmalloc(len, GFP_KERNEL);
+		if (!dst)
+			return ERR_PTR(-ENOMEM);
+		strscpy(dst, src, len);
+	}
+
+	return dst;
+}
+
+/*
+ * Convert 16 bit Unicode pathname to wire format from string in current code
+ * page. Conversion may involve remapping up the six characters that are
+ * only legal in POSIX-like OS (if they are present in the string). Path
+ * names are little endian 16 bit Unicode on the wire
+ */
+/*
+ * smbConvertToUTF16() - convert string from local charset to utf16
+ * @target:	destination buffer
+ * @source:	source buffer
+ * @srclen:	source buffer size (in bytes)
+ * @cp:		codepage to which characters should be converted
+ * @mapchar:	should characters be remapped according to the mapchars option?
+ *
+ * Convert 16 bit Unicode pathname to wire format from string in current code
+ * page. Conversion may involve remapping up the six characters that are
+ * only legal in POSIX-like OS (if they are present in the string). Path
+ * names are little endian 16 bit Unicode on the wire
+ *
+ * Return:	char length after conversion
+ */
+int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
+		      const struct nls_table *cp, int mapchars)
+{
+	int i, j, charlen;
+	char src_char;
+	__le16 dst_char;
+	wchar_t tmp;
+
+	if (!mapchars)
+		return smb_strtoUTF16(target, source, srclen, cp);
+
+	for (i = 0, j = 0; i < srclen; j++) {
+		src_char = source[i];
+		charlen = 1;
+		switch (src_char) {
+		case 0:
+			put_unaligned(0, &target[j]);
+			return j;
+		case ':':
+			dst_char = cpu_to_le16(UNI_COLON);
+			break;
+		case '*':
+			dst_char = cpu_to_le16(UNI_ASTERISK);
+			break;
+		case '?':
+			dst_char = cpu_to_le16(UNI_QUESTION);
+			break;
+		case '<':
+			dst_char = cpu_to_le16(UNI_LESSTHAN);
+			break;
+		case '>':
+			dst_char = cpu_to_le16(UNI_GRTRTHAN);
+			break;
+		case '|':
+			dst_char = cpu_to_le16(UNI_PIPE);
+			break;
+		/*
+		 * FIXME: We can not handle remapping backslash (UNI_SLASH)
+		 * until all the calls to build_path_from_dentry are modified,
+		 * as they use backslash as separator.
+		 */
+		default:
+			charlen = cp->char2uni(source + i, srclen - i, &tmp);
+			dst_char = cpu_to_le16(tmp);
+
+			/*
+			 * if no match, use question mark, which at least in
+			 * some cases serves as wild card
+			 */
+			if (charlen < 1) {
+				dst_char = cpu_to_le16(0x003f);
+				charlen = 1;
+			}
+		}
+		/*
+		 * character may take more than one byte in the source string,
+		 * but will take exactly two bytes in the target string
+		 */
+		i += charlen;
+		put_unaligned(dst_char, &target[j]);
+	}
+
+	return j;
+}
diff --git a/fs/ksmbd/unicode.h b/fs/ksmbd/unicode.h
new file mode 100644
index 000000000000..5593024230ae
--- /dev/null
+++ b/fs/ksmbd/unicode.h
@@ -0,0 +1,357 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Some of the source code in this file came from fs/cifs/cifs_unicode.c
+ * cifs_unicode:  Unicode kernel case support
+ *
+ * Function:
+ *     Convert a unicode character to upper or lower case using
+ *     compressed tables.
+ *
+ *   Copyright (c) International Business Machines  Corp., 2000,2009
+ *
+ *
+ * Notes:
+ *     These APIs are based on the C library functions.  The semantics
+ *     should match the C functions but with expanded size operands.
+ *
+ *     The upper/lower functions are based on a table created by mkupr.
+ *     This is a compressed table of upper and lower case conversion.
+ *
+ */
+#ifndef _CIFS_UNICODE_H
+#define _CIFS_UNICODE_H
+
+#include <asm/byteorder.h>
+#include <linux/types.h>
+#include <linux/nls.h>
+
+#define  UNIUPR_NOLOWER		/* Example to not expand lower case tables */
+
+/*
+ * Windows maps these to the user defined 16 bit Unicode range since they are
+ * reserved symbols (along with \ and /), otherwise illegal to store
+ * in filenames in NTFS
+ */
+#define UNI_ASTERISK    ((__u16)('*' + 0xF000))
+#define UNI_QUESTION    ((__u16)('?' + 0xF000))
+#define UNI_COLON       ((__u16)(':' + 0xF000))
+#define UNI_GRTRTHAN    ((__u16)('>' + 0xF000))
+#define UNI_LESSTHAN    ((__u16)('<' + 0xF000))
+#define UNI_PIPE        ((__u16)('|' + 0xF000))
+#define UNI_SLASH       ((__u16)('\\' + 0xF000))
+
+/* Just define what we want from uniupr.h.  We don't want to define the tables
+ * in each source file.
+ */
+#ifndef	UNICASERANGE_DEFINED
+struct UniCaseRange {
+	wchar_t start;
+	wchar_t end;
+	signed char *table;
+};
+#endif				/* UNICASERANGE_DEFINED */
+
+#ifndef UNIUPR_NOUPPER
+extern signed char SmbUniUpperTable[512];
+extern const struct UniCaseRange SmbUniUpperRange[];
+#endif				/* UNIUPR_NOUPPER */
+
+#ifndef UNIUPR_NOLOWER
+extern signed char CifsUniLowerTable[512];
+extern const struct UniCaseRange CifsUniLowerRange[];
+#endif				/* UNIUPR_NOLOWER */
+
+#ifdef __KERNEL__
+int smb_strtoUTF16(__le16 *to, const char *from, int len,
+		   const struct nls_table *codepage);
+char *smb_strndup_from_utf16(const char *src, const int maxlen,
+			     const bool is_unicode,
+			     const struct nls_table *codepage);
+int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
+		      const struct nls_table *cp, int mapchars);
+char *ksmbd_extract_sharename(char *treename);
+#endif
+
+/*
+ * UniStrcat:  Concatenate the second string to the first
+ *
+ * Returns:
+ *     Address of the first string
+ */
+static inline wchar_t *UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
+{
+	wchar_t *anchor = ucs1;	/* save a pointer to start of ucs1 */
+
+	while (*ucs1++)
+	/*NULL*/;	/* To end of first string */
+	ucs1--;			/* Return to the null */
+	while ((*ucs1++ = *ucs2++))
+	/*NULL*/;	/* copy string 2 over */
+	return anchor;
+}
+
+/*
+ * UniStrchr:  Find a character in a string
+ *
+ * Returns:
+ *     Address of first occurrence of character in string
+ *     or NULL if the character is not in the string
+ */
+static inline wchar_t *UniStrchr(const wchar_t *ucs, wchar_t uc)
+{
+	while ((*ucs != uc) && *ucs)
+		ucs++;
+
+	if (*ucs == uc)
+		return (wchar_t *)ucs;
+	return NULL;
+}
+
+/*
+ * UniStrcmp:  Compare two strings
+ *
+ * Returns:
+ *     < 0:  First string is less than second
+ *     = 0:  Strings are equal
+ *     > 0:  First string is greater than second
+ */
+static inline int UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
+{
+	while ((*ucs1 == *ucs2) && *ucs1) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)*ucs2;
+}
+
+/*
+ * UniStrcpy:  Copy a string
+ */
+static inline wchar_t *UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
+{
+	wchar_t *anchor = ucs1;	/* save the start of result string */
+
+	while ((*ucs1++ = *ucs2++))
+	/*NULL*/;
+	return anchor;
+}
+
+/*
+ * UniStrlen:  Return the length of a string (in 16 bit Unicode chars not bytes)
+ */
+static inline size_t UniStrlen(const wchar_t *ucs1)
+{
+	int i = 0;
+
+	while (*ucs1++)
+		i++;
+	return i;
+}
+
+/*
+ * UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a
+ *		string (length limited)
+ */
+static inline size_t UniStrnlen(const wchar_t *ucs1, int maxlen)
+{
+	int i = 0;
+
+	while (*ucs1++) {
+		i++;
+		if (i >= maxlen)
+			break;
+	}
+	return i;
+}
+
+/*
+ * UniStrncat:  Concatenate length limited string
+ */
+static inline wchar_t *UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
+
+	while (*ucs1++)
+	/*NULL*/;
+	ucs1--;			/* point to null terminator of s1 */
+	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
+		ucs1++;
+		ucs2++;
+	}
+	*ucs1 = 0;		/* Null terminate the result */
+	return anchor;
+}
+
+/*
+ * UniStrncmp:  Compare length limited string
+ */
+static inline int UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)*ucs2;
+}
+
+/*
+ * UniStrncmp_le:  Compare length limited string - native to little-endian
+ */
+static inline int
+UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int)*ucs1 - (int)__le16_to_cpu(*ucs2);
+}
+
+/*
+ * UniStrncpy:  Copy length limited string with pad
+ */
+static inline wchar_t *UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;
+
+	while (n-- && *ucs2)	/* Copy the strings */
+		*ucs1++ = *ucs2++;
+
+	n++;
+	while (n--)		/* Pad with nulls */
+		*ucs1++ = 0;
+	return anchor;
+}
+
+/*
+ * UniStrncpy_le:  Copy length limited string with pad to little-endian
+ */
+static inline wchar_t *UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	wchar_t *anchor = ucs1;
+
+	while (n-- && *ucs2)	/* Copy the strings */
+		*ucs1++ = __le16_to_cpu(*ucs2++);
+
+	n++;
+	while (n--)		/* Pad with nulls */
+		*ucs1++ = 0;
+	return anchor;
+}
+
+/*
+ * UniStrstr:  Find a string in a string
+ *
+ * Returns:
+ *     Address of first match found
+ *     NULL if no matching string is found
+ */
+static inline wchar_t *UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
+{
+	const wchar_t *anchor1 = ucs1;
+	const wchar_t *anchor2 = ucs2;
+
+	while (*ucs1) {
+		if (*ucs1 == *ucs2) {
+			/* Partial match found */
+			ucs1++;
+			ucs2++;
+		} else {
+			if (!*ucs2)	/* Match found */
+				return (wchar_t *)anchor1;
+			ucs1 = ++anchor1;	/* No match */
+			ucs2 = anchor2;
+		}
+	}
+
+	if (!*ucs2)		/* Both end together */
+		return (wchar_t *)anchor1;	/* Match found */
+	return NULL;		/* No match */
+}
+
+#ifndef UNIUPR_NOUPPER
+/*
+ * UniToupper:  Convert a unicode character to upper case
+ */
+static inline wchar_t UniToupper(register wchar_t uc)
+{
+	register const struct UniCaseRange *rp;
+
+	if (uc < sizeof(SmbUniUpperTable)) {
+		/* Latin characters */
+		return uc + SmbUniUpperTable[uc];	/* Use base tables */
+	}
+
+	rp = SmbUniUpperRange;	/* Use range tables */
+	while (rp->start) {
+		if (uc < rp->start)	/* Before start of range */
+			return uc;	/* Uppercase = input */
+		if (uc <= rp->end)	/* In range */
+			return uc + rp->table[uc - rp->start];
+		rp++;	/* Try next range */
+	}
+	return uc;		/* Past last range */
+}
+
+/*
+ * UniStrupr:  Upper case a unicode string
+ */
+static inline __le16 *UniStrupr(register __le16 *upin)
+{
+	register __le16 *up;
+
+	up = upin;
+	while (*up) {		/* For all characters */
+		*up = cpu_to_le16(UniToupper(le16_to_cpu(*up)));
+		up++;
+	}
+	return upin;		/* Return input pointer */
+}
+#endif				/* UNIUPR_NOUPPER */
+
+#ifndef UNIUPR_NOLOWER
+/*
+ * UniTolower:  Convert a unicode character to lower case
+ */
+static inline wchar_t UniTolower(register wchar_t uc)
+{
+	register const struct UniCaseRange *rp;
+
+	if (uc < sizeof(CifsUniLowerTable)) {
+		/* Latin characters */
+		return uc + CifsUniLowerTable[uc];	/* Use base tables */
+	}
+
+	rp = CifsUniLowerRange;	/* Use range tables */
+	while (rp->start) {
+		if (uc < rp->start)	/* Before start of range */
+			return uc;	/* Uppercase = input */
+		if (uc <= rp->end)	/* In range */
+			return uc + rp->table[uc - rp->start];
+		rp++;	/* Try next range */
+	}
+	return uc;		/* Past last range */
+}
+
+/*
+ * UniStrlwr:  Lower case a unicode string
+ */
+static inline wchar_t *UniStrlwr(register wchar_t *upin)
+{
+	register wchar_t *up;
+
+	up = upin;
+	while (*up) {		/* For all characters */
+		*up = UniTolower(*up);
+		up++;
+	}
+	return upin;		/* Return input pointer */
+}
+
+#endif
+
+#endif /* _CIFS_UNICODE_H */
diff --git a/fs/ksmbd/uniupr.h b/fs/ksmbd/uniupr.h
new file mode 100644
index 000000000000..26583b776897
--- /dev/null
+++ b/fs/ksmbd/uniupr.h
@@ -0,0 +1,268 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Some of the source code in this file came from fs/cifs/uniupr.h
+ *   Copyright (c) International Business Machines  Corp., 2000,2002
+ *
+ * uniupr.h - Unicode compressed case ranges
+ *
+ */
+#ifndef __KSMBD_UNIUPR_H
+#define __KSMBD_UNIUPR_H
+
+#ifndef UNIUPR_NOUPPER
+/*
+ * Latin upper case
+ */
+signed char SmbUniUpperTable[512] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 000-00f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 010-01f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 020-02f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 030-03f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 040-04f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 050-05f */
+	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+				-32, -32, -32, -32, -32,	/* 060-06f */
+	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+				-32, 0, 0, 0, 0, 0,	/* 070-07f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 080-08f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 090-09f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0a0-0af */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0b0-0bf */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0c0-0cf */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0d0-0df */
+	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+			 -32, -32, -32, -32, -32, -32,	/* 0e0-0ef */
+	-32, -32, -32, -32, -32, -32, -32, 0, -32, -32,
+			 -32, -32, -32, -32, -32, 121,	/* 0f0-0ff */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 100-10f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 110-11f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 120-12f */
+	0, 0, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0,	/* 130-13f */
+	-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1,	/* 140-14f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 150-15f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 160-16f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, 0, -1, 0, -1, 0, -1, 0,	/* 170-17f */
+	0, 0, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0,	/* 180-18f */
+	0, 0, -1, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0,	/* 190-19f */
+	0, -1, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, 0, -1, 0, 0,	/* 1a0-1af */
+	-1, 0, 0, 0, -1, 0, -1, 0, 0, -1, 0, 0, 0, -1, 0, 0,	/* 1b0-1bf */
+	0, 0, 0, 0, 0, -1, -2, 0, -1, -2, 0, -1, -2, 0, -1, 0,	/* 1c0-1cf */
+	-1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, -79, 0, -1, /* 1d0-1df */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e0-1ef */
+	0, 0, -1, -2, 0, -1, 0, 0, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1f0-1ff */
+};
+
+/* Upper case range - Greek */
+static signed char UniCaseRangeU03a0[47] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -38, -37, -37, -37,	/* 3a0-3af */
+	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+					 -32, -32, -32, -32,	/* 3b0-3bf */
+	-32, -32, -31, -32, -32, -32, -32, -32, -32, -32, -32, -32, -64,
+	-63, -63,
+};
+
+/* Upper case range - Cyrillic */
+static signed char UniCaseRangeU0430[48] = {
+	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+					 -32, -32, -32, -32,	/* 430-43f */
+	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+					 -32, -32, -32, -32,	/* 440-44f */
+	0, -80, -80, -80, -80, -80, -80, -80, -80, -80, -80,
+					 -80, -80, 0, -80, -80,	/* 450-45f */
+};
+
+/* Upper case range - Extended cyrillic */
+static signed char UniCaseRangeU0490[61] = {
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 490-49f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 4a0-4af */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 4b0-4bf */
+	0, 0, -1, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1,
+};
+
+/* Upper case range - Extended latin and greek */
+static signed char UniCaseRangeU1e00[509] = {
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e00-1e0f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e10-1e1f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e20-1e2f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e30-1e3f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e40-1e4f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e50-1e5f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e60-1e6f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e70-1e7f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1e80-1e8f */
+	0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, -59, 0, -1, 0, -1,	/* 1e90-1e9f */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ea0-1eaf */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1eb0-1ebf */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ec0-1ecf */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ed0-1edf */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, -1,	/* 1ee0-1eef */
+	0, -1, 0, -1, 0, -1, 0, -1, 0, -1, 0, 0, 0, 0, 0, 0,	/* 1ef0-1eff */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f00-1f0f */
+	8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f10-1f1f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f20-1f2f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f30-1f3f */
+	8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f40-1f4f */
+	0, 8, 0, 8, 0, 8, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f50-1f5f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f60-1f6f */
+	74, 74, 86, 86, 86, 86, 100, 100, 0, 0, 112, 112,
+				 126, 126, 0, 0,	/* 1f70-1f7f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f80-1f8f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f90-1f9f */
+	8, 8, 8, 8, 8, 8, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fa0-1faf */
+	8, 8, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fb0-1fbf */
+	0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fc0-1fcf */
+	8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fd0-1fdf */
+	8, 8, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1fe0-1fef */
+	0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0,
+};
+
+/* Upper case range - Wide latin */
+static signed char UniCaseRangeUff40[27] = {
+	0, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+			 -32, -32, -32, -32, -32,	/* ff40-ff4f */
+	-32, -32, -32, -32, -32, -32, -32, -32, -32, -32, -32,
+};
+
+/*
+ * Upper Case Range
+ */
+const struct UniCaseRange SmbUniUpperRange[] = {
+	{0x03a0, 0x03ce, UniCaseRangeU03a0},
+	{0x0430, 0x045f, UniCaseRangeU0430},
+	{0x0490, 0x04cc, UniCaseRangeU0490},
+	{0x1e00, 0x1ffc, UniCaseRangeU1e00},
+	{0xff40, 0xff5a, UniCaseRangeUff40},
+	{0}
+};
+#endif
+
+#ifndef UNIUPR_NOLOWER
+/*
+ * Latin lower case
+ */
+signed char CifsUniLowerTable[512] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 000-00f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 010-01f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 020-02f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 030-03f */
+	0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+					 32, 32, 32,	/* 040-04f */
+	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 0, 0,
+					 0, 0, 0,	/* 050-05f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 060-06f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 070-07f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 080-08f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 090-09f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0a0-0af */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0b0-0bf */
+	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+				 32, 32, 32, 32,	/* 0c0-0cf */
+	32, 32, 32, 32, 32, 32, 32, 0, 32, 32, 32, 32,
+					 32, 32, 32, 0,	/* 0d0-0df */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0e0-0ef */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 0f0-0ff */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 100-10f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 110-11f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 120-12f */
+	0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1,	/* 130-13f */
+	0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0,	/* 140-14f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 150-15f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 160-16f */
+	1, 0, 1, 0, 1, 0, 1, 0, -121, 1, 0, 1, 0, 1, 0,
+						 0,	/* 170-17f */
+	0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 79,
+						 0,	/* 180-18f */
+	0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,	/* 190-19f */
+	1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1,	/* 1a0-1af */
+	0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,	/* 1b0-1bf */
+	0, 0, 0, 0, 2, 1, 0, 2, 1, 0, 2, 1, 0, 1, 0, 1,	/* 1c0-1cf */
+	0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0,	/* 1d0-1df */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e0-1ef */
+	0, 2, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1f0-1ff */
+};
+
+/* Lower case range - Greek */
+static signed char UniCaseRangeL0380[44] = {
+	0, 0, 0, 0, 0, 0, 38, 0, 37, 37, 37, 0, 64, 0, 63, 63,	/* 380-38f */
+	0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+						 32, 32, 32,	/* 390-39f */
+	32, 32, 0, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+};
+
+/* Lower case range - Cyrillic */
+static signed char UniCaseRangeL0400[48] = {
+	0, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80,
+					 0, 80, 80,	/* 400-40f */
+	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+					 32, 32, 32,	/* 410-41f */
+	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+					 32, 32, 32,	/* 420-42f */
+};
+
+/* Lower case range - Extended cyrillic */
+static signed char UniCaseRangeL0490[60] = {
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 490-49f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 4a0-4af */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 4b0-4bf */
+	0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1,
+};
+
+/* Lower case range - Extended latin and greek */
+static signed char UniCaseRangeL1e00[504] = {
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e00-1e0f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e10-1e1f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e20-1e2f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e30-1e3f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e40-1e4f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e50-1e5f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e60-1e6f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e70-1e7f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1e80-1e8f */
+	1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0,	/* 1e90-1e9f */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1ea0-1eaf */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1eb0-1ebf */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1ec0-1ecf */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1ed0-1edf */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0,	/* 1ee0-1eef */
+	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0,	/* 1ef0-1eff */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f00-1f0f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, 0, 0,	/* 1f10-1f1f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f20-1f2f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f30-1f3f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, 0, 0,	/* 1f40-1f4f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, -8, 0, -8, 0, -8, 0, -8,	/* 1f50-1f5f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f60-1f6f */
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,	/* 1f70-1f7f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f80-1f8f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1f90-1f9f */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -8, -8, -8, -8, -8, -8,	/* 1fa0-1faf */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -74, -74, -9, 0, 0, 0,	/* 1fb0-1fbf */
+	0, 0, 0, 0, 0, 0, 0, 0, -86, -86, -86, -86, -9, 0,
+							 0, 0,	/* 1fc0-1fcf */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -100, -100, 0, 0, 0, 0,	/* 1fd0-1fdf */
+	0, 0, 0, 0, 0, 0, 0, 0, -8, -8, -112, -112, -7, 0,
+							 0, 0,	/* 1fe0-1fef */
+	0, 0, 0, 0, 0, 0, 0, 0,
+};
+
+/* Lower case range - Wide latin */
+static signed char UniCaseRangeLff20[27] = {
+	0, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+							 32,	/* ff20-ff2f */
+	32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
+};
+
+/*
+ * Lower Case Range
+ */
+const struct UniCaseRange CifsUniLowerRange[] = {
+	{0x0380, 0x03ab, UniCaseRangeL0380},
+	{0x0400, 0x042f, UniCaseRangeL0400},
+	{0x0490, 0x04cb, UniCaseRangeL0490},
+	{0x1e00, 0x1ff7, UniCaseRangeL1e00},
+	{0xff20, 0xff3a, UniCaseRangeLff20},
+	{0}
+};
+#endif
+
+#endif /* __KSMBD_UNIUPR_H */
-- 
2.17.1

