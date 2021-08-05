Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C527F3E0E15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbhHEGQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 02:16:38 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38501 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbhHEGQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 02:16:17 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210805061601epoutp017e98b52577a5db676272b6f156f751fa~YVH0x3pGk1456314563epoutp01M
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 Aug 2021 06:16:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210805061601epoutp017e98b52577a5db676272b6f156f751fa~YVH0x3pGk1456314563epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628144162;
        bh=g0mD+5v0L7v+Km3OZAnPI5n2fVRSgvNdXonK3ve9U/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyBgb2ZihYaRsi7ZSn9oF9Y6xuv+qRQzWCQRB1WZcl6DHX90gp5lZHne8FOgt1u7w
         veXjEV4YD+TkZnUre9GdHT8UjW622xTeKJnfHbQD8ZzZgRZECexoK36h2IzIFJ760j
         1VIjbmxpc41oSgO5v9AVoMJP6OFgt1cilukuru5E=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210805061601epcas1p302b498036cbdc254ecf7dc9a807a1be6~YVH0GAcae0543205432epcas1p3h;
        Thu,  5 Aug 2021 06:16:01 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4GgJJc13pMz4x9Pr; Thu,  5 Aug
        2021 06:16:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.96.45479.F128B016; Thu,  5 Aug 2021 15:15:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210805061559epcas1p4383fada61dec0c39a79a0f09327263e6~YVHyGDO3n0961409614epcas1p4G;
        Thu,  5 Aug 2021 06:15:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210805061559epsmtrp170c79520f7c68db8cf2419bb4af6a5d6~YVHyEG-m91607716077epsmtrp1r;
        Thu,  5 Aug 2021 06:15:59 +0000 (GMT)
X-AuditID: b6c32a35-cd5ff7000001b1a7-77-610b821f80fe
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        38.43.08394.E128B016; Thu,  5 Aug 2021 15:15:58 +0900 (KST)
Received: from localhost.localdomain (unknown [10.89.31.111]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805061558epsmtip14b1b5f14de9684980972d9f66f7dcc0e~YVHxxLp6A0035500355epsmtip1B;
        Thu,  5 Aug 2021 06:15:58 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, aurelien.aptel@gmail.com,
        sandeen@sandeen.net, willy@infradead.org, hch@infradead.org,
        senozhatsky@chromium.org, christian@brauner.io,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com, hch@lst.de,
        dan.carpenter@oracle.com, metze@samba.org, smfrench@gmail.com,
        hyc.lee@gmail.com, Namjae Jeon <namjae.jeon@samsung.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v7 07/13] ksmbd: add authentication
Date:   Thu,  5 Aug 2021 15:05:40 +0900
Message-Id: <20210805060546.3268-8-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805060546.3268-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOuff2ttR03pTHzjBBuJshsgEttXh0YJyP5RKMqzNmg6hwhSuQ
        lbZpyxzLoh0LTBjycpkbLwnNGMIWeY5C7WBgB7JHB5MxEUc0yBtECO+Ha2nd9t/3O+f7zvf9
        fuccAS5uJb0FSSo9p1WxSpoUEt937JYE7kzbxkru/+KDOic3+OjjmZfR5OY1Av2cV46hG9VW
        DP059ISPxp614Gjl2RJAtyx3CPRHSzGJeipWCLR87RK6kjPHQ+l3A5C5tpxEU2MdJBrIv04i
        20YnD60tF5MH3ZmNkqc4U2ToIZjmwgd8pr4ygDGXzWOM+Z6BZNJNG3zm6eMBgilpyQFMTkMV
        YBqMDzFmvs6HqRuexhSiaGVYIsfGc1pfThWnjk9SJYTTkSdjDsfIQyXSQOk+tJf2VbHJXDh9
        5Jgi8M0kpb1N2vd9VpliX1KwOh0dfCBMq07Rc76Jap0+nOY08UqNVKIJ0rHJuhRVQlCcOnm/
        VCIJkduZscrEjMVuQvNFAfFB1twoMICub/Es4CaA1B440NVvx0KBmDIBONL3BHMWcwDOV//G
        cxaLAK5+9xP2XFJYbnFJLACWVU7y/5WMPrLZWQIBSb0K1xs8HQIP6gz8yzS5JcCpIhyOWroJ
        x4Y7JYMFazdIByaoXbC/vHjLQUS9DstarTyn205YXdO2FdaNCoMT1fVbkSA1KIBXxw0u0hFY
        ak0nnNgdTnQ28J3YG47nZrjwBdh1Z9XVwkewpvQHviMotIfIHtM7IE7thjdbgp0MP9i8VgIc
        GKdegDML2TwnWwQvZ4idlF0wp7fDdeAOmPXprMuIgSN3zYRzJLkALiw3YnnAp/A/hzIAqoAX
        p9ElJ3A6qUb6/zurA1svOUBuAvnTs0HtABOAdgAFOO0hijMKWbEonk39kNOqY7QpSk7XDuT2
        2eXj3p5xavtXUOljpPIQmUyG9oTuDZXL6BdFi2cWYsVUAqvn3uM4Dad9rsMEbt4GzHy4P63+
        ti19XWZjy+ivjH3r29LPZ5rhK211V/blm3aYTdEKsfFqydGjRnHURO0yETt8Nir1pdt9b21f
        Kg9s9c/3LmrYLCr0MEQcmgHCd2d5B4dWlpQWbqN05mxVz3TFqZAuTPHg9IXK+5sRo8N+70RH
        e9KbMDOVqhmhmmyRD9Ejxck0r+NTn/Xawj8PMjTVNCojz42vVi9Zvhme7i/+MvfYAWGekrl4
        KqVSK0l6nDn+98BU0WRvH//mvd9vDb7hx/dSDTVZC9wjMvwr8trOX6y6nP1jbXPj6V/PHTpu
        9A9us2KGuhPd/vuXo5jALrccIvjtJmvG4mtfAzL2E+H2wUs0oUtkpQG4Vsf+A1KsnYpSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5cE3eiwaP5VhbHX/9lt2h8p2zx
        +t90FovTExYxWaxcfZTJ4tr99+wWL/7vYrb4+f87o8WevSdZLC7vmsNmcXHZTxaLH9PrLXr7
        PrFatF7Rsti9cRGbxZsXh9ksbk2cz2Zx/u9xVovfP+awOQh7/J37kdljdsNFFo+ds+6ye2xe
        oeWxe8FnJo/dNxvYPFp3/GX3+Pj0FovH3F19jB59W1YxemxZ/JDJ4/MmOY9NT94yBfBGcdmk
        pOZklqUW6dslcGW0fTvFUjBtEktF16fnjA2MJ9YwdzFyckgImEjMWrQXyObiEBLYzShx+9gm
        RoiEtMSxE2eAEhxAtrDE4cPFEDUfGCUOvehgAYmzCWhL/NkiClIuIhAvcbPhNgtIDbPAemaJ
        s6+bWEASwgLGEpN+r2QDsVkEVCWuL5rDBGLzClhLLNh/lBVil7zE6g0HwA7iFLCReLV6M1hc
        CKjm/dtrzBMY+RYwMqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOHC3NHYzbV33Q
        O8TIxMF4iFGCg1lJhDd5MVeiEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
        C1KLYLJMHJxSDUwLLvAfNOKxFvPbbXhiSmhNq5TixfX8DS8+3/fWL05d8N9UdkHTNr1Nr2yf
        vjzyVTzt6D7u7P9Tg/3WiXE2epx0YVq+RFInxVbAoLi86sP9B5zlaR+kezflucwuXuV0LOSR
        Y/pFx8fLe29ts7n+8uS+H1/tvR3YJnXfO17zimkF19PYFSvT9HVf3g/8uewZg+P9PUu2ydy9
        3OzumVW3MPPH/vpPrGynVjpxbnHOYs2edISlZOKBBUInevx7Z0w3SP4zRTfS/sW9WgVDA+ve
        f9oL2lOPOivk7Jrys8RyQeCZwssqteuvnPsuvNtG+/3yGbeF5Z6a9xf9ONo7+zqHdZPhkWjX
        u+8fTT3BfD315O8TSizFGYmGWsxFxYkAfiqnswsDAAA=
X-CMS-MailID: 20210805061559epcas1p4383fada61dec0c39a79a0f09327263e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210805061559epcas1p4383fada61dec0c39a79a0f09327263e6
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
        <CGME20210805061559epcas1p4383fada61dec0c39a79a0f09327263e6@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds NTLM/NTLMv2/Kerberos authentications and signing/encryption.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/asn1.c                         |  343 ++++++
 fs/ksmbd/asn1.h                         |   21 +
 fs/ksmbd/auth.c                         | 1364 +++++++++++++++++++++++
 fs/ksmbd/auth.h                         |   67 ++
 fs/ksmbd/crypto_ctx.c                   |  282 +++++
 fs/ksmbd/crypto_ctx.h                   |   74 ++
 fs/ksmbd/ksmbd_spnego_negtokeninit.asn1 |   31 +
 fs/ksmbd/ksmbd_spnego_negtokentarg.asn1 |   19 +
 fs/ksmbd/ntlmssp.h                      |  169 +++
 9 files changed, 2370 insertions(+)
 create mode 100644 fs/ksmbd/asn1.c
 create mode 100644 fs/ksmbd/asn1.h
 create mode 100644 fs/ksmbd/auth.c
 create mode 100644 fs/ksmbd/auth.h
 create mode 100644 fs/ksmbd/crypto_ctx.c
 create mode 100644 fs/ksmbd/crypto_ctx.h
 create mode 100644 fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
 create mode 100644 fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
 create mode 100644 fs/ksmbd/ntlmssp.h

diff --git a/fs/ksmbd/asn1.c b/fs/ksmbd/asn1.c
new file mode 100644
index 000000000000..b014f4638610
--- /dev/null
+++ b/fs/ksmbd/asn1.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * The ASB.1/BER parsing code is derived from ip_nat_snmp_basic.c which was in
+ * turn derived from the gxsnmp package by Gregory McLean & Jochen Friedrich
+ *
+ * Copyright (c) 2000 RP Internet (www.rpi.net.au).
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/oid_registry.h>
+
+#include "glob.h"
+
+#include "asn1.h"
+#include "connection.h"
+#include "auth.h"
+#include "ksmbd_spnego_negtokeninit.asn1.h"
+#include "ksmbd_spnego_negtokentarg.asn1.h"
+
+#define SPNEGO_OID_LEN 7
+#define NTLMSSP_OID_LEN  10
+#define KRB5_OID_LEN  7
+#define KRB5U2U_OID_LEN  8
+#define MSKRB5_OID_LEN  7
+static unsigned long SPNEGO_OID[7] = { 1, 3, 6, 1, 5, 5, 2 };
+static unsigned long NTLMSSP_OID[10] = { 1, 3, 6, 1, 4, 1, 311, 2, 2, 10 };
+static unsigned long KRB5_OID[7] = { 1, 2, 840, 113554, 1, 2, 2 };
+static unsigned long KRB5U2U_OID[8] = { 1, 2, 840, 113554, 1, 2, 2, 3 };
+static unsigned long MSKRB5_OID[7] = { 1, 2, 840, 48018, 1, 2, 2 };
+
+static char NTLMSSP_OID_STR[NTLMSSP_OID_LEN] = { 0x2b, 0x06, 0x01, 0x04, 0x01,
+	0x82, 0x37, 0x02, 0x02, 0x0a };
+
+static bool
+asn1_subid_decode(const unsigned char **begin, const unsigned char *end,
+		  unsigned long *subid)
+{
+	const unsigned char *ptr = *begin;
+	unsigned char ch;
+
+	*subid = 0;
+
+	do {
+		if (ptr >= end)
+			return false;
+
+		ch = *ptr++;
+		*subid <<= 7;
+		*subid |= ch & 0x7F;
+	} while ((ch & 0x80) == 0x80);
+
+	*begin = ptr;
+	return true;
+}
+
+static bool asn1_oid_decode(const unsigned char *value, size_t vlen,
+			    unsigned long **oid, size_t *oidlen)
+{
+	const unsigned char *iptr = value, *end = value + vlen;
+	unsigned long *optr;
+	unsigned long subid;
+
+	vlen += 1;
+	if (vlen < 2 || vlen > UINT_MAX / sizeof(unsigned long))
+		goto fail_nullify;
+
+	*oid = kmalloc(vlen * sizeof(unsigned long), GFP_KERNEL);
+	if (!*oid)
+		return false;
+
+	optr = *oid;
+
+	if (!asn1_subid_decode(&iptr, end, &subid))
+		goto fail;
+
+	if (subid < 40) {
+		optr[0] = 0;
+		optr[1] = subid;
+	} else if (subid < 80) {
+		optr[0] = 1;
+		optr[1] = subid - 40;
+	} else {
+		optr[0] = 2;
+		optr[1] = subid - 80;
+	}
+
+	*oidlen = 2;
+	optr += 2;
+
+	while (iptr < end) {
+		if (++(*oidlen) > vlen)
+			goto fail;
+
+		if (!asn1_subid_decode(&iptr, end, optr++))
+			goto fail;
+	}
+	return true;
+
+fail:
+	kfree(*oid);
+fail_nullify:
+	*oid = NULL;
+	return false;
+}
+
+static bool oid_eq(unsigned long *oid1, unsigned int oid1len,
+		   unsigned long *oid2, unsigned int oid2len)
+{
+	if (oid1len != oid2len)
+		return false;
+
+	return memcmp(oid1, oid2, oid1len) == 0;
+}
+
+int
+ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
+			  struct ksmbd_conn *conn)
+{
+	return asn1_ber_decoder(&ksmbd_spnego_negtokeninit_decoder, conn,
+				security_blob, length);
+}
+
+int
+ksmbd_decode_negTokenTarg(unsigned char *security_blob, int length,
+			  struct ksmbd_conn *conn)
+{
+	return asn1_ber_decoder(&ksmbd_spnego_negtokentarg_decoder, conn,
+				security_blob, length);
+}
+
+static int compute_asn_hdr_len_bytes(int len)
+{
+	if (len > 0xFFFFFF)
+		return 4;
+	else if (len > 0xFFFF)
+		return 3;
+	else if (len > 0xFF)
+		return 2;
+	else if (len > 0x7F)
+		return 1;
+	else
+		return 0;
+}
+
+static void encode_asn_tag(char *buf, unsigned int *ofs, char tag, char seq,
+			   int length)
+{
+	int i;
+	int index = *ofs;
+	char hdr_len = compute_asn_hdr_len_bytes(length);
+	int len = length + 2 + hdr_len;
+
+	/* insert tag */
+	buf[index++] = tag;
+
+	if (!hdr_len) {
+		buf[index++] = len;
+	} else {
+		buf[index++] = 0x80 | hdr_len;
+		for (i = hdr_len - 1; i >= 0; i--)
+			buf[index++] = (len >> (i * 8)) & 0xFF;
+	}
+
+	/* insert seq */
+	len = len - (index - *ofs);
+	buf[index++] = seq;
+
+	if (!hdr_len) {
+		buf[index++] = len;
+	} else {
+		buf[index++] = 0x80 | hdr_len;
+		for (i = hdr_len - 1; i >= 0; i--)
+			buf[index++] = (len >> (i * 8)) & 0xFF;
+	}
+
+	*ofs += (index - *ofs);
+}
+
+int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
+				  char *ntlm_blob, int ntlm_blob_len)
+{
+	char *buf;
+	unsigned int ofs = 0;
+	int neg_result_len = 4 + compute_asn_hdr_len_bytes(1) * 2 + 1;
+	int oid_len = 4 + compute_asn_hdr_len_bytes(NTLMSSP_OID_LEN) * 2 +
+		NTLMSSP_OID_LEN;
+	int ntlmssp_len = 4 + compute_asn_hdr_len_bytes(ntlm_blob_len) * 2 +
+		ntlm_blob_len;
+	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len +
+			oid_len + ntlmssp_len) * 2 +
+			neg_result_len + oid_len + ntlmssp_len;
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* insert main gss header */
+	encode_asn_tag(buf, &ofs, 0xa1, 0x30, neg_result_len + oid_len +
+			ntlmssp_len);
+
+	/* insert neg result */
+	encode_asn_tag(buf, &ofs, 0xa0, 0x0a, 1);
+	buf[ofs++] = 1;
+
+	/* insert oid */
+	encode_asn_tag(buf, &ofs, 0xa1, 0x06, NTLMSSP_OID_LEN);
+	memcpy(buf + ofs, NTLMSSP_OID_STR, NTLMSSP_OID_LEN);
+	ofs += NTLMSSP_OID_LEN;
+
+	/* insert response token - ntlmssp blob */
+	encode_asn_tag(buf, &ofs, 0xa2, 0x04, ntlm_blob_len);
+	memcpy(buf + ofs, ntlm_blob, ntlm_blob_len);
+	ofs += ntlm_blob_len;
+
+	*pbuffer = buf;
+	*buflen = total_len;
+	return 0;
+}
+
+int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
+				   int neg_result)
+{
+	char *buf;
+	unsigned int ofs = 0;
+	int neg_result_len = 4 + compute_asn_hdr_len_bytes(1) * 2 + 1;
+	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len) * 2 +
+		neg_result_len;
+
+	buf = kmalloc(total_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* insert main gss header */
+	encode_asn_tag(buf, &ofs, 0xa1, 0x30, neg_result_len);
+
+	/* insert neg result */
+	encode_asn_tag(buf, &ofs, 0xa0, 0x0a, 1);
+	if (neg_result)
+		buf[ofs++] = 2;
+	else
+		buf[ofs++] = 0;
+
+	*pbuffer = buf;
+	*buflen = total_len;
+	return 0;
+}
+
+int ksmbd_gssapi_this_mech(void *context, size_t hdrlen, unsigned char tag,
+			   const void *value, size_t vlen)
+{
+	unsigned long *oid;
+	size_t oidlen;
+	int err = 0;
+
+	if (!asn1_oid_decode(value, vlen, &oid, &oidlen)) {
+		err = -EBADMSG;
+		goto out;
+	}
+
+	if (!oid_eq(oid, oidlen, SPNEGO_OID, SPNEGO_OID_LEN))
+		err = -EBADMSG;
+	kfree(oid);
+out:
+	if (err) {
+		char buf[50];
+
+		sprint_oid(value, vlen, buf, sizeof(buf));
+		ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+	}
+	return err;
+}
+
+int ksmbd_neg_token_init_mech_type(void *context, size_t hdrlen,
+				   unsigned char tag, const void *value,
+				   size_t vlen)
+{
+	struct ksmbd_conn *conn = context;
+	unsigned long *oid;
+	size_t oidlen;
+	int mech_type;
+	char buf[50];
+
+	if (!asn1_oid_decode(value, vlen, &oid, &oidlen))
+		goto fail;
+
+	if (oid_eq(oid, oidlen, NTLMSSP_OID, NTLMSSP_OID_LEN))
+		mech_type = KSMBD_AUTH_NTLMSSP;
+	else if (oid_eq(oid, oidlen, MSKRB5_OID, MSKRB5_OID_LEN))
+		mech_type = KSMBD_AUTH_MSKRB5;
+	else if (oid_eq(oid, oidlen, KRB5_OID, KRB5_OID_LEN))
+		mech_type = KSMBD_AUTH_KRB5;
+	else if (oid_eq(oid, oidlen, KRB5U2U_OID, KRB5U2U_OID_LEN))
+		mech_type = KSMBD_AUTH_KRB5U2U;
+	else
+		goto fail;
+
+	conn->auth_mechs |= mech_type;
+	if (conn->preferred_auth_mech == 0)
+		conn->preferred_auth_mech = mech_type;
+
+	kfree(oid);
+	return 0;
+
+fail:
+	kfree(oid);
+	sprint_oid(value, vlen, buf, sizeof(buf));
+	ksmbd_debug(AUTH, "Unexpected OID: %s\n", buf);
+	return -EBADMSG;
+}
+
+int ksmbd_neg_token_init_mech_token(void *context, size_t hdrlen,
+				    unsigned char tag, const void *value,
+				    size_t vlen)
+{
+	struct ksmbd_conn *conn = context;
+
+	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	if (!conn->mechToken)
+		return -ENOMEM;
+
+	memcpy(conn->mechToken, value, vlen);
+	conn->mechToken[vlen] = '\0';
+	return 0;
+}
+
+int ksmbd_neg_token_targ_resp_token(void *context, size_t hdrlen,
+				    unsigned char tag, const void *value,
+				    size_t vlen)
+{
+	struct ksmbd_conn *conn = context;
+
+	conn->mechToken = kmalloc(vlen + 1, GFP_KERNEL);
+	if (!conn->mechToken)
+		return -ENOMEM;
+
+	memcpy(conn->mechToken, value, vlen);
+	conn->mechToken[vlen] = '\0';
+	return 0;
+}
diff --git a/fs/ksmbd/asn1.h b/fs/ksmbd/asn1.h
new file mode 100644
index 000000000000..ce105f4ce305
--- /dev/null
+++ b/fs/ksmbd/asn1.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * The ASB.1/BER parsing code is derived from ip_nat_snmp_basic.c which was in
+ * turn derived from the gxsnmp package by Gregory McLean & Jochen Friedrich
+ *
+ * Copyright (c) 2000 RP Internet (www.rpi.net.au).
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __ASN1_H__
+#define __ASN1_H__
+
+int ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
+			      struct ksmbd_conn *conn);
+int ksmbd_decode_negTokenTarg(unsigned char *security_blob, int length,
+			      struct ksmbd_conn *conn);
+int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
+				  char *ntlm_blob, int ntlm_blob_len);
+int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
+				   int neg_result);
+#endif /* __ASN1_H__ */
diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
new file mode 100644
index 000000000000..de36f12070bf
--- /dev/null
+++ b/fs/ksmbd/auth.c
@@ -0,0 +1,1364 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/backing-dev.h>
+#include <linux/writeback.h>
+#include <linux/uio.h>
+#include <linux/xattr.h>
+#include <crypto/hash.h>
+#include <crypto/aead.h>
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+
+#include "auth.h"
+#include "glob.h"
+
+#include <linux/fips.h>
+#include <crypto/des.h>
+
+#include "server.h"
+#include "smb_common.h"
+#include "connection.h"
+#include "mgmt/user_session.h"
+#include "mgmt/user_config.h"
+#include "crypto_ctx.h"
+#include "transport_ipc.h"
+
+/*
+ * Fixed format data defining GSS header and fixed string
+ * "not_defined_in_RFC4178@please_ignore".
+ * So sec blob data in neg phase could be generated statically.
+ */
+static char NEGOTIATE_GSS_HEADER[AUTH_GSS_LENGTH] = {
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+	0x60, 0x5e, 0x06, 0x06, 0x2b, 0x06, 0x01, 0x05,
+	0x05, 0x02, 0xa0, 0x54, 0x30, 0x52, 0xa0, 0x24,
+	0x30, 0x22, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
+	0xf7, 0x12, 0x01, 0x02, 0x02, 0x06, 0x09, 0x2a,
+	0x86, 0x48, 0x82, 0xf7, 0x12, 0x01, 0x02, 0x02,
+	0x06, 0x0a, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82,
+	0x37, 0x02, 0x02, 0x0a, 0xa3, 0x2a, 0x30, 0x28,
+	0xa0, 0x26, 0x1b, 0x24, 0x6e, 0x6f, 0x74, 0x5f,
+	0x64, 0x65, 0x66, 0x69, 0x6e, 0x65, 0x64, 0x5f,
+	0x69, 0x6e, 0x5f, 0x52, 0x46, 0x43, 0x34, 0x31,
+	0x37, 0x38, 0x40, 0x70, 0x6c, 0x65, 0x61, 0x73,
+	0x65, 0x5f, 0x69, 0x67, 0x6e, 0x6f, 0x72, 0x65
+#else
+	0x60, 0x48, 0x06, 0x06, 0x2b, 0x06, 0x01, 0x05,
+	0x05, 0x02, 0xa0, 0x3e, 0x30, 0x3c, 0xa0, 0x0e,
+	0x30, 0x0c, 0x06, 0x0a, 0x2b, 0x06, 0x01, 0x04,
+	0x01, 0x82, 0x37, 0x02, 0x02, 0x0a, 0xa3, 0x2a,
+	0x30, 0x28, 0xa0, 0x26, 0x1b, 0x24, 0x6e, 0x6f,
+	0x74, 0x5f, 0x64, 0x65, 0x66, 0x69, 0x6e, 0x65,
+	0x64, 0x5f, 0x69, 0x6e, 0x5f, 0x52, 0x46, 0x43,
+	0x34, 0x31, 0x37, 0x38, 0x40, 0x70, 0x6c, 0x65,
+	0x61, 0x73, 0x65, 0x5f, 0x69, 0x67, 0x6e, 0x6f,
+	0x72, 0x65
+#endif
+};
+
+void ksmbd_copy_gss_neg_header(void *buf)
+{
+	memcpy(buf, NEGOTIATE_GSS_HEADER, AUTH_GSS_LENGTH);
+}
+
+static void
+str_to_key(unsigned char *str, unsigned char *key)
+{
+	int i;
+
+	key[0] = str[0] >> 1;
+	key[1] = ((str[0] & 0x01) << 6) | (str[1] >> 2);
+	key[2] = ((str[1] & 0x03) << 5) | (str[2] >> 3);
+	key[3] = ((str[2] & 0x07) << 4) | (str[3] >> 4);
+	key[4] = ((str[3] & 0x0F) << 3) | (str[4] >> 5);
+	key[5] = ((str[4] & 0x1F) << 2) | (str[5] >> 6);
+	key[6] = ((str[5] & 0x3F) << 1) | (str[6] >> 7);
+	key[7] = str[6] & 0x7F;
+	for (i = 0; i < 8; i++)
+		key[i] = (key[i] << 1);
+}
+
+static int
+smbhash(unsigned char *out, const unsigned char *in, unsigned char *key)
+{
+	unsigned char key2[8];
+	struct des_ctx ctx;
+
+	if (fips_enabled) {
+		ksmbd_debug(AUTH, "FIPS compliance enabled: DES not permitted\n");
+		return -ENOENT;
+	}
+
+	str_to_key(key, key2);
+	des_expand_key(&ctx, key2, DES_KEY_SIZE);
+	des_encrypt(&ctx, out, in);
+	memzero_explicit(&ctx, sizeof(ctx));
+	return 0;
+}
+
+static int ksmbd_enc_p24(unsigned char *p21, const unsigned char *c8, unsigned char *p24)
+{
+	int rc;
+
+	rc = smbhash(p24, c8, p21);
+	if (rc)
+		return rc;
+	rc = smbhash(p24 + 8, c8, p21 + 7);
+	if (rc)
+		return rc;
+	return smbhash(p24 + 16, c8, p21 + 14);
+}
+
+/* produce a md4 message digest from data of length n bytes */
+static int ksmbd_enc_md4(unsigned char *md4_hash, unsigned char *link_str,
+			 int link_len)
+{
+	int rc;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_md4();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "Crypto md4 allocation error\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_init(CRYPTO_MD4(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not init md4 shash\n");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_MD4(ctx), link_str, link_len);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not update with link_str\n");
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_MD4(ctx), md4_hash);
+	if (rc)
+		ksmbd_debug(AUTH, "Could not generate md4 hash\n");
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+static int ksmbd_enc_update_sess_key(unsigned char *md5_hash, char *nonce,
+				     char *server_challenge, int len)
+{
+	int rc;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_md5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "Crypto md5 allocation error\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_init(CRYPTO_MD5(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not init md5 shash\n");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_MD5(ctx), server_challenge, len);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not update with challenge\n");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_MD5(ctx), nonce, len);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not update with nonce\n");
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_MD5(ctx), md5_hash);
+	if (rc)
+		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+/**
+ * ksmbd_gen_sess_key() - function to generate session key
+ * @sess:	session of connection
+ * @hash:	source hash value to be used for find session key
+ * @hmac:	source hmac value to be used for finding session key
+ *
+ */
+static int ksmbd_gen_sess_key(struct ksmbd_session *sess, char *hash,
+			      char *hmac)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
+				 hash,
+				 CIFS_HMAC_MD5_HASH_SIZE);
+	if (rc) {
+		ksmbd_debug(AUTH, "hmacmd5 set key fail error %d\n", rc);
+		goto out;
+	}
+
+	rc = crypto_shash_init(CRYPTO_HMACMD5(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "could not init hmacmd5 error %d\n", rc);
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx),
+				 hmac,
+				 SMB2_NTLMV2_SESSKEY_SIZE);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not update with response error %d\n", rc);
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACMD5(ctx), sess->sess_key);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n", rc);
+		goto out;
+	}
+
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
+			    char *dname)
+{
+	int ret, len, conv_len;
+	wchar_t *domain = NULL;
+	__le16 *uniname = NULL;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "can't generate ntlmv2 hash\n");
+		return -ENOMEM;
+	}
+
+	ret = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
+				  user_passkey(sess->user),
+				  CIFS_ENCPWD_SIZE);
+	if (ret) {
+		ksmbd_debug(AUTH, "Could not set NT Hash as a key\n");
+		goto out;
+	}
+
+	ret = crypto_shash_init(CRYPTO_HMACMD5(ctx));
+	if (ret) {
+		ksmbd_debug(AUTH, "could not init hmacmd5\n");
+		goto out;
+	}
+
+	/* convert user_name to unicode */
+	len = strlen(user_name(sess->user));
+	uniname = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	if (!uniname) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	conv_len = smb_strtoUTF16(uniname, user_name(sess->user), len,
+				  sess->conn->local_nls);
+	if (conv_len < 0 || conv_len > len) {
+		ret = -EINVAL;
+		goto out;
+	}
+	UniStrupr(uniname);
+
+	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
+				  (char *)uniname,
+				  UNICODE_LEN(conv_len));
+	if (ret) {
+		ksmbd_debug(AUTH, "Could not update with user\n");
+		goto out;
+	}
+
+	/* Convert domain name or conn name to unicode and uppercase */
+	len = strlen(dname);
+	domain = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	if (!domain) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	conv_len = smb_strtoUTF16((__le16 *)domain, dname, len,
+				  sess->conn->local_nls);
+	if (conv_len < 0 || conv_len > len) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
+				  (char *)domain,
+				  UNICODE_LEN(conv_len));
+	if (ret) {
+		ksmbd_debug(AUTH, "Could not update with domain\n");
+		goto out;
+	}
+
+	ret = crypto_shash_final(CRYPTO_HMACMD5(ctx), ntlmv2_hash);
+	if (ret)
+		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
+out:
+	kfree(uniname);
+	kfree(domain);
+	ksmbd_release_crypto_ctx(ctx);
+	return ret;
+}
+
+/**
+ * ksmbd_auth_ntlm() - NTLM authentication handler
+ * @sess:	session of connection
+ * @pw_buf:	NTLM challenge response
+ * @passkey:	user password
+ *
+ * Return:	0 on success, error number on error
+ */
+int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf)
+{
+	int rc;
+	unsigned char p21[21];
+	char key[CIFS_AUTH_RESP_SIZE];
+
+	memset(p21, '\0', 21);
+	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
+	rc = ksmbd_enc_p24(p21, sess->ntlmssp.cryptkey, key);
+	if (rc) {
+		pr_err("password processing failed\n");
+		return rc;
+	}
+
+	ksmbd_enc_md4(sess->sess_key, user_passkey(sess->user),
+		      CIFS_SMB1_SESSKEY_SIZE);
+	memcpy(sess->sess_key + CIFS_SMB1_SESSKEY_SIZE, key,
+	       CIFS_AUTH_RESP_SIZE);
+	sess->sequence_number = 1;
+
+	if (strncmp(pw_buf, key, CIFS_AUTH_RESP_SIZE) != 0) {
+		ksmbd_debug(AUTH, "ntlmv1 authentication failed\n");
+		return -EINVAL;
+	}
+
+	ksmbd_debug(AUTH, "ntlmv1 authentication pass\n");
+	return 0;
+}
+
+/**
+ * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
+ * @sess:	session of connection
+ * @ntlmv2:		NTLMv2 challenge response
+ * @blen:		NTLMv2 blob length
+ * @domain_name:	domain name
+ *
+ * Return:	0 on success, error number on error
+ */
+int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
+		      int blen, char *domain_name)
+{
+	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
+	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
+	struct ksmbd_crypto_ctx *ctx;
+	char *construct = NULL;
+	int rc, len;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
+		return -ENOMEM;
+	}
+
+	rc = calc_ntlmv2_hash(sess, ntlmv2_hash, domain_name);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not get v2 hash rc %d\n", rc);
+		goto out;
+	}
+
+	rc = crypto_shash_setkey(CRYPTO_HMACMD5_TFM(ctx),
+				 ntlmv2_hash,
+				 CIFS_HMAC_MD5_HASH_SIZE);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not set NTLMV2 Hash as a key\n");
+		goto out;
+	}
+
+	rc = crypto_shash_init(CRYPTO_HMACMD5(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not init hmacmd5\n");
+		goto out;
+	}
+
+	len = CIFS_CRYPTO_KEY_SIZE + blen;
+	construct = kzalloc(len, GFP_KERNEL);
+	if (!construct) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(construct, sess->ntlmssp.cryptkey, CIFS_CRYPTO_KEY_SIZE);
+	memcpy(construct + CIFS_CRYPTO_KEY_SIZE, &ntlmv2->blob_signature, blen);
+
+	rc = crypto_shash_update(CRYPTO_HMACMD5(ctx), construct, len);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not update with response\n");
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACMD5(ctx), ntlmv2_rsp);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
+		goto out;
+	}
+
+	rc = ksmbd_gen_sess_key(sess, ntlmv2_hash, ntlmv2_rsp);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate sess key\n");
+		goto out;
+	}
+
+	if (memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE) != 0)
+		rc = -EINVAL;
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	kfree(construct);
+	return rc;
+}
+
+/**
+ * __ksmbd_auth_ntlmv2() - NTLM2(extended security) authentication handler
+ * @sess:	session of connection
+ * @client_nonce:	client nonce from LM response.
+ * @ntlm_resp:		ntlm response data from client.
+ *
+ * Return:	0 on success, error number on error
+ */
+static int __ksmbd_auth_ntlmv2(struct ksmbd_session *sess, char *client_nonce,
+			       char *ntlm_resp)
+{
+	char sess_key[CIFS_SMB1_SESSKEY_SIZE] = {0};
+	int rc;
+	unsigned char p21[21];
+	char key[CIFS_AUTH_RESP_SIZE];
+
+	rc = ksmbd_enc_update_sess_key(sess_key,
+				       client_nonce,
+				       (char *)sess->ntlmssp.cryptkey, 8);
+	if (rc) {
+		pr_err("password processing failed\n");
+		goto out;
+	}
+
+	memset(p21, '\0', 21);
+	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
+	rc = ksmbd_enc_p24(p21, sess_key, key);
+	if (rc) {
+		pr_err("password processing failed\n");
+		goto out;
+	}
+
+	if (memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE) != 0)
+		rc = -EINVAL;
+out:
+	return rc;
+}
+
+/**
+ * ksmbd_decode_ntlmssp_auth_blob() - helper function to construct
+ * authenticate blob
+ * @authblob:	authenticate blob source pointer
+ * @usr:	user details
+ * @sess:	session of connection
+ *
+ * Return:	0 on success, error number on error
+ */
+int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
+				   int blob_len, struct ksmbd_session *sess)
+{
+	char *domain_name;
+	unsigned int lm_off, nt_off;
+	unsigned short nt_len;
+	int ret;
+
+	if (blob_len < sizeof(struct authenticate_message)) {
+		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
+			    blob_len);
+		return -EINVAL;
+	}
+
+	if (memcmp(authblob->Signature, "NTLMSSP", 8)) {
+		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
+			    authblob->Signature);
+		return -EINVAL;
+	}
+
+	lm_off = le32_to_cpu(authblob->LmChallengeResponse.BufferOffset);
+	nt_off = le32_to_cpu(authblob->NtChallengeResponse.BufferOffset);
+	nt_len = le16_to_cpu(authblob->NtChallengeResponse.Length);
+
+	/* process NTLM authentication */
+	if (nt_len == CIFS_AUTH_RESP_SIZE) {
+		if (le32_to_cpu(authblob->NegotiateFlags) &
+		    NTLMSSP_NEGOTIATE_EXTENDED_SEC)
+			return __ksmbd_auth_ntlmv2(sess, (char *)authblob +
+				lm_off, (char *)authblob + nt_off);
+		else
+			return ksmbd_auth_ntlm(sess, (char *)authblob +
+				nt_off);
+	}
+
+	/* TODO : use domain name that imported from configuration file */
+	domain_name = smb_strndup_from_utf16((const char *)authblob +
+			le32_to_cpu(authblob->DomainName.BufferOffset),
+			le16_to_cpu(authblob->DomainName.Length), true,
+			sess->conn->local_nls);
+	if (IS_ERR(domain_name))
+		return PTR_ERR(domain_name);
+
+	/* process NTLMv2 authentication */
+	ksmbd_debug(AUTH, "decode_ntlmssp_authenticate_blob dname%s\n",
+		    domain_name);
+	ret = ksmbd_auth_ntlmv2(sess, (struct ntlmv2_resp *)((char *)authblob + nt_off),
+				nt_len - CIFS_ENCPWD_SIZE,
+				domain_name);
+	kfree(domain_name);
+	return ret;
+}
+
+/**
+ * ksmbd_decode_ntlmssp_neg_blob() - helper function to construct
+ * negotiate blob
+ * @negblob: negotiate blob source pointer
+ * @rsp:     response header pointer to be updated
+ * @sess:    session of connection
+ *
+ */
+int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
+				  int blob_len, struct ksmbd_session *sess)
+{
+	if (blob_len < sizeof(struct negotiate_message)) {
+		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
+			    blob_len);
+		return -EINVAL;
+	}
+
+	if (memcmp(negblob->Signature, "NTLMSSP", 8)) {
+		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
+			    negblob->Signature);
+		return -EINVAL;
+	}
+
+	sess->ntlmssp.client_flags = le32_to_cpu(negblob->NegotiateFlags);
+	return 0;
+}
+
+/**
+ * ksmbd_build_ntlmssp_challenge_blob() - helper function to construct
+ * challenge blob
+ * @chgblob: challenge blob source pointer to initialize
+ * @rsp:     response header pointer to be updated
+ * @sess:    session of connection
+ *
+ */
+unsigned int
+ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
+				   struct ksmbd_session *sess)
+{
+	struct target_info *tinfo;
+	wchar_t *name;
+	__u8 *target_name;
+	unsigned int flags, blob_off, blob_len, type, target_info_len = 0;
+	int len, uni_len, conv_len;
+	int cflags = sess->ntlmssp.client_flags;
+
+	memcpy(chgblob->Signature, NTLMSSP_SIGNATURE, 8);
+	chgblob->MessageType = NtLmChallenge;
+
+	flags = NTLMSSP_NEGOTIATE_UNICODE |
+		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_TARGET_TYPE_SERVER |
+		NTLMSSP_NEGOTIATE_TARGET_INFO;
+
+	if (cflags & NTLMSSP_NEGOTIATE_SIGN) {
+		flags |= NTLMSSP_NEGOTIATE_SIGN;
+		flags |= cflags & (NTLMSSP_NEGOTIATE_128 |
+				   NTLMSSP_NEGOTIATE_56);
+	}
+
+	if (cflags & NTLMSSP_NEGOTIATE_ALWAYS_SIGN)
+		flags |= NTLMSSP_NEGOTIATE_ALWAYS_SIGN;
+
+	if (cflags & NTLMSSP_REQUEST_TARGET)
+		flags |= NTLMSSP_REQUEST_TARGET;
+
+	if (sess->conn->use_spnego &&
+	    (cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
+		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
+
+	chgblob->NegotiateFlags = cpu_to_le32(flags);
+	len = strlen(ksmbd_netbios_name());
+	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	conv_len = smb_strtoUTF16((__le16 *)name, ksmbd_netbios_name(), len,
+				  sess->conn->local_nls);
+	if (conv_len < 0 || conv_len > len) {
+		kfree(name);
+		return -EINVAL;
+	}
+
+	uni_len = UNICODE_LEN(conv_len);
+
+	blob_off = sizeof(struct challenge_message);
+	blob_len = blob_off + uni_len;
+
+	chgblob->TargetName.Length = cpu_to_le16(uni_len);
+	chgblob->TargetName.MaximumLength = cpu_to_le16(uni_len);
+	chgblob->TargetName.BufferOffset = cpu_to_le32(blob_off);
+
+	/* Initialize random conn challenge */
+	get_random_bytes(sess->ntlmssp.cryptkey, sizeof(__u64));
+	memcpy(chgblob->Challenge, sess->ntlmssp.cryptkey,
+	       CIFS_CRYPTO_KEY_SIZE);
+
+	/* Add Target Information to security buffer */
+	chgblob->TargetInfoArray.BufferOffset = cpu_to_le32(blob_len);
+
+	target_name = (__u8 *)chgblob + blob_off;
+	memcpy(target_name, name, uni_len);
+	tinfo = (struct target_info *)(target_name + uni_len);
+
+	chgblob->TargetInfoArray.Length = 0;
+	/* Add target info list for NetBIOS/DNS settings */
+	for (type = NTLMSSP_AV_NB_COMPUTER_NAME;
+	     type <= NTLMSSP_AV_DNS_DOMAIN_NAME; type++) {
+		tinfo->Type = cpu_to_le16(type);
+		tinfo->Length = cpu_to_le16(uni_len);
+		memcpy(tinfo->Content, name, uni_len);
+		tinfo = (struct target_info *)((char *)tinfo + 4 + uni_len);
+		target_info_len += 4 + uni_len;
+	}
+
+	/* Add terminator subblock */
+	tinfo->Type = 0;
+	tinfo->Length = 0;
+	target_info_len += 4;
+
+	chgblob->TargetInfoArray.Length = cpu_to_le16(target_info_len);
+	chgblob->TargetInfoArray.MaximumLength = cpu_to_le16(target_info_len);
+	blob_len += target_info_len;
+	kfree(name);
+	ksmbd_debug(AUTH, "NTLMSSP SecurityBufferLength %d\n", blob_len);
+	return blob_len;
+}
+
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
+			    int in_len, char *out_blob, int *out_len)
+{
+	struct ksmbd_spnego_authen_response *resp;
+	struct ksmbd_user *user = NULL;
+	int retval;
+
+	resp = ksmbd_ipc_spnego_authen_request(in_blob, in_len);
+	if (!resp) {
+		ksmbd_debug(AUTH, "SPNEGO_AUTHEN_REQUEST failure\n");
+		return -EINVAL;
+	}
+
+	if (!(resp->login_response.status & KSMBD_USER_FLAG_OK)) {
+		ksmbd_debug(AUTH, "krb5 authentication failure\n");
+		retval = -EPERM;
+		goto out;
+	}
+
+	if (*out_len <= resp->spnego_blob_len) {
+		ksmbd_debug(AUTH, "buf len %d, but blob len %d\n",
+			    *out_len, resp->spnego_blob_len);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if (resp->session_key_len > sizeof(sess->sess_key)) {
+		ksmbd_debug(AUTH, "session key is too long\n");
+		retval = -EINVAL;
+		goto out;
+	}
+
+	user = ksmbd_alloc_user(&resp->login_response);
+	if (!user) {
+		ksmbd_debug(AUTH, "login failure\n");
+		retval = -ENOMEM;
+		goto out;
+	}
+	sess->user = user;
+
+	memcpy(sess->sess_key, resp->payload, resp->session_key_len);
+	memcpy(out_blob, resp->payload + resp->session_key_len,
+	       resp->spnego_blob_len);
+	*out_len = resp->spnego_blob_len;
+	retval = 0;
+out:
+	kvfree(resp);
+	return retval;
+}
+#else
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
+			    int in_len, char *out_blob, int *out_len)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+/**
+ * ksmbd_sign_smb2_pdu() - function to generate packet signing
+ * @conn:	connection
+ * @key:	signing key
+ * @iov:        buffer iov array
+ * @n_vec:	number of iovecs
+ * @sig:	signature value generated for client request packet
+ *
+ */
+int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			int n_vec, char *sig)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc, i;
+
+	ctx = ksmbd_crypto_ctx_find_hmacsha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_setkey(CRYPTO_HMACSHA256_TFM(ctx),
+				 key,
+				 SMB2_NTLMV2_SESSKEY_SIZE);
+	if (rc)
+		goto out;
+
+	rc = crypto_shash_init(CRYPTO_HMACSHA256(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "hmacsha256 init error %d\n", rc);
+		goto out;
+	}
+
+	for (i = 0; i < n_vec; i++) {
+		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
+					 iov[i].iov_base,
+					 iov[i].iov_len);
+		if (rc) {
+			ksmbd_debug(AUTH, "hmacsha256 update error %d\n", rc);
+			goto out;
+		}
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACSHA256(ctx), sig);
+	if (rc)
+		ksmbd_debug(AUTH, "hmacsha256 generation error %d\n", rc);
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+/**
+ * ksmbd_sign_smb3_pdu() - function to generate packet signing
+ * @conn:	connection
+ * @key:	signing key
+ * @iov:        buffer iov array
+ * @n_vec:	number of iovecs
+ * @sig:	signature value generated for client request packet
+ *
+ */
+int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			int n_vec, char *sig)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc, i;
+
+	ctx = ksmbd_crypto_ctx_find_cmacaes();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc cmac\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_setkey(CRYPTO_CMACAES_TFM(ctx),
+				 key,
+				 SMB2_CMACAES_SIZE);
+	if (rc)
+		goto out;
+
+	rc = crypto_shash_init(CRYPTO_CMACAES(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "cmaces init error %d\n", rc);
+		goto out;
+	}
+
+	for (i = 0; i < n_vec; i++) {
+		rc = crypto_shash_update(CRYPTO_CMACAES(ctx),
+					 iov[i].iov_base,
+					 iov[i].iov_len);
+		if (rc) {
+			ksmbd_debug(AUTH, "cmaces update error %d\n", rc);
+			goto out;
+		}
+	}
+
+	rc = crypto_shash_final(CRYPTO_CMACAES(ctx), sig);
+	if (rc)
+		ksmbd_debug(AUTH, "cmaces generation error %d\n", rc);
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+struct derivation {
+	struct kvec label;
+	struct kvec context;
+	bool binding;
+};
+
+static int generate_key(struct ksmbd_session *sess, struct kvec label,
+			struct kvec context, __u8 *key, unsigned int key_size)
+{
+	unsigned char zero = 0x0;
+	__u8 i[4] = {0, 0, 0, 1};
+	__u8 L128[4] = {0, 0, 0, 128};
+	__u8 L256[4] = {0, 0, 1, 0};
+	int rc;
+	unsigned char prfhash[SMB2_HMACSHA256_SIZE];
+	unsigned char *hashptr = prfhash;
+	struct ksmbd_crypto_ctx *ctx;
+
+	memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
+	memset(key, 0x0, key_size);
+
+	ctx = ksmbd_crypto_ctx_find_hmacsha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_setkey(CRYPTO_HMACSHA256_TFM(ctx),
+				 sess->sess_key,
+				 SMB2_NTLMV2_SESSKEY_SIZE);
+	if (rc)
+		goto smb3signkey_ret;
+
+	rc = crypto_shash_init(CRYPTO_HMACSHA256(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "hmacsha256 init error %d\n", rc);
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), i, 4);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with n\n");
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
+				 label.iov_base,
+				 label.iov_len);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with label\n");
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), &zero, 1);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with zero\n");
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx),
+				 context.iov_base,
+				 context.iov_len);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with context\n");
+		goto smb3signkey_ret;
+	}
+
+	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L256, 4);
+	else
+		rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L128, 4);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with L\n");
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACSHA256(ctx), hashptr);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n",
+			    rc);
+		goto smb3signkey_ret;
+	}
+
+	memcpy(key, hashptr, key_size);
+
+smb3signkey_ret:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+static int generate_smb3signingkey(struct ksmbd_session *sess,
+				   struct ksmbd_conn *conn,
+				   const struct derivation *signing)
+{
+	int rc;
+	struct channel *chann;
+	char *key;
+
+	chann = lookup_chann_list(sess, conn);
+	if (!chann)
+		return 0;
+
+	if (sess->conn->dialect >= SMB30_PROT_ID && signing->binding)
+		key = chann->smb3signingkey;
+	else
+		key = sess->smb3signingkey;
+
+	rc = generate_key(sess, signing->label, signing->context, key,
+			  SMB3_SIGN_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	if (!(sess->conn->dialect >= SMB30_PROT_ID && signing->binding))
+		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
+
+	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
+	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
+	ksmbd_debug(AUTH, "Session Key   %*ph\n",
+		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
+	ksmbd_debug(AUTH, "Signing Key   %*ph\n",
+		    SMB3_SIGN_KEY_SIZE, key);
+	return 0;
+}
+
+int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
+			       struct ksmbd_conn *conn)
+{
+	struct derivation d;
+
+	d.label.iov_base = "SMB2AESCMAC";
+	d.label.iov_len = 12;
+	d.context.iov_base = "SmbSign";
+	d.context.iov_len = 8;
+	d.binding = conn->binding;
+
+	return generate_smb3signingkey(sess, conn, &d);
+}
+
+int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
+				struct ksmbd_conn *conn)
+{
+	struct derivation d;
+
+	d.label.iov_base = "SMBSigningKey";
+	d.label.iov_len = 14;
+	if (conn->binding) {
+		struct preauth_session *preauth_sess;
+
+		preauth_sess = ksmbd_preauth_session_lookup(conn, sess->id);
+		if (!preauth_sess)
+			return -ENOENT;
+		d.context.iov_base = preauth_sess->Preauth_HashValue;
+	} else {
+		d.context.iov_base = sess->Preauth_HashValue;
+	}
+	d.context.iov_len = 64;
+	d.binding = conn->binding;
+
+	return generate_smb3signingkey(sess, conn, &d);
+}
+
+struct derivation_twin {
+	struct derivation encryption;
+	struct derivation decryption;
+};
+
+static int generate_smb3encryptionkey(struct ksmbd_session *sess,
+				      const struct derivation_twin *ptwin)
+{
+	int rc;
+
+	rc = generate_key(sess, ptwin->encryption.label,
+			  ptwin->encryption.context, sess->smb3encryptionkey,
+			  SMB3_ENC_DEC_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	rc = generate_key(sess, ptwin->decryption.label,
+			  ptwin->decryption.context,
+			  sess->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
+	ksmbd_debug(AUTH, "Cipher type   %d\n", sess->conn->cipher_type);
+	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
+	ksmbd_debug(AUTH, "Session Key   %*ph\n",
+		    SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
+	if (sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    sess->conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
+		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
+			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3encryptionkey);
+		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
+			    SMB3_GCM256_CRYPTKEY_SIZE, sess->smb3decryptionkey);
+	} else {
+		ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
+			    SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3encryptionkey);
+		ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
+			    SMB3_GCM128_CRYPTKEY_SIZE, sess->smb3decryptionkey);
+	}
+	return 0;
+}
+
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess)
+{
+	struct derivation_twin twin;
+	struct derivation *d;
+
+	d = &twin.encryption;
+	d->label.iov_base = "SMB2AESCCM";
+	d->label.iov_len = 11;
+	d->context.iov_base = "ServerOut";
+	d->context.iov_len = 10;
+
+	d = &twin.decryption;
+	d->label.iov_base = "SMB2AESCCM";
+	d->label.iov_len = 11;
+	d->context.iov_base = "ServerIn ";
+	d->context.iov_len = 10;
+
+	return generate_smb3encryptionkey(sess, &twin);
+}
+
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess)
+{
+	struct derivation_twin twin;
+	struct derivation *d;
+
+	d = &twin.encryption;
+	d->label.iov_base = "SMBS2CCipherKey";
+	d->label.iov_len = 16;
+	d->context.iov_base = sess->Preauth_HashValue;
+	d->context.iov_len = 64;
+
+	d = &twin.decryption;
+	d->label.iov_base = "SMBC2SCipherKey";
+	d->label.iov_len = 16;
+	d->context.iov_base = sess->Preauth_HashValue;
+	d->context.iov_len = 64;
+
+	return generate_smb3encryptionkey(sess, &twin);
+}
+
+int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
+				     __u8 *pi_hash)
+{
+	int rc;
+	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
+	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
+	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
+	struct ksmbd_crypto_ctx *ctx = NULL;
+
+	if (conn->preauth_info->Preauth_HashId !=
+	    SMB2_PREAUTH_INTEGRITY_SHA512)
+		return -EINVAL;
+
+	ctx = ksmbd_crypto_ctx_find_sha512();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not alloc sha512\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_init(CRYPTO_SHA512(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "could not init shashn");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_SHA512(ctx), pi_hash, 64);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with n\n");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_SHA512(ctx), all_bytes_msg, msg_size);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with n\n");
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_SHA512(ctx), pi_hash);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hash err : %d\n", rc);
+		goto out;
+	}
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
+		      __u8 *pi_hash)
+{
+	int rc;
+	struct ksmbd_crypto_ctx *ctx = NULL;
+
+	ctx = ksmbd_crypto_ctx_find_sha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not alloc sha256\n");
+		return -ENOMEM;
+	}
+
+	rc = crypto_shash_init(CRYPTO_SHA256(ctx));
+	if (rc) {
+		ksmbd_debug(AUTH, "could not init shashn");
+		goto out;
+	}
+
+	rc = crypto_shash_update(CRYPTO_SHA256(ctx), sd_buf, len);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with n\n");
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_SHA256(ctx), pi_hash);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hash err : %d\n", rc);
+		goto out;
+	}
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+static int ksmbd_get_encryption_key(struct ksmbd_conn *conn, __u64 ses_id,
+				    int enc, u8 *key)
+{
+	struct ksmbd_session *sess;
+	u8 *ses_enc_key;
+
+	sess = ksmbd_session_lookup_all(conn, ses_id);
+	if (!sess)
+		return -EINVAL;
+
+	ses_enc_key = enc ? sess->smb3encryptionkey :
+		sess->smb3decryptionkey;
+	memcpy(key, ses_enc_key, SMB3_ENC_DEC_KEY_SIZE);
+
+	return 0;
+}
+
+static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
+				   unsigned int buflen)
+{
+	void *addr;
+
+	if (is_vmalloc_addr(buf))
+		addr = vmalloc_to_page(buf);
+	else
+		addr = virt_to_page(buf);
+	sg_set_page(sg, addr, buflen, offset_in_page(buf));
+}
+
+static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
+					 u8 *sign)
+{
+	struct scatterlist *sg;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
+
+	if (!nvec)
+		return NULL;
+
+	for (i = 0; i < nvec - 1; i++) {
+		unsigned long kaddr = (unsigned long)iov[i + 1].iov_base;
+
+		if (is_vmalloc_addr(iov[i + 1].iov_base)) {
+			nr_entries[i] = ((kaddr + iov[i + 1].iov_len +
+					PAGE_SIZE - 1) >> PAGE_SHIFT) -
+				(kaddr >> PAGE_SHIFT);
+		} else {
+			nr_entries[i]++;
+		}
+		total_entries += nr_entries[i];
+	}
+
+	/* Add two entries for transform header and signature */
+	total_entries += 2;
+
+	sg = kmalloc_array(total_entries, sizeof(struct scatterlist), GFP_KERNEL);
+	if (!sg)
+		return NULL;
+
+	sg_init_table(sg, total_entries);
+	smb2_sg_set_buf(&sg[sg_idx++], iov[0].iov_base + 24, assoc_data_len);
+	for (i = 0; i < nvec - 1; i++) {
+		void *data = iov[i + 1].iov_base;
+		int len = iov[i + 1].iov_len;
+
+		if (is_vmalloc_addr(data)) {
+			int j, offset = offset_in_page(data);
+
+			for (j = 0; j < nr_entries[i]; j++) {
+				unsigned int bytes = PAGE_SIZE - offset;
+
+				if (!len)
+					break;
+
+				if (bytes > len)
+					bytes = len;
+
+				sg_set_page(&sg[sg_idx++],
+					    vmalloc_to_page(data), bytes,
+					    offset_in_page(data));
+
+				data += bytes;
+				len -= bytes;
+				offset = 0;
+			}
+		} else {
+			sg_set_page(&sg[sg_idx++], virt_to_page(data), len,
+				    offset_in_page(data));
+		}
+	}
+	smb2_sg_set_buf(&sg[sg_idx], sign, SMB2_SIGNATURE_SIZE);
+	return sg;
+}
+
+int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+			unsigned int nvec, int enc)
+{
+	struct smb2_transform_hdr *tr_hdr =
+		(struct smb2_transform_hdr *)iov[0].iov_base;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	int rc;
+	struct scatterlist *sg;
+	u8 sign[SMB2_SIGNATURE_SIZE] = {};
+	u8 key[SMB3_ENC_DEC_KEY_SIZE];
+	struct aead_request *req;
+	char *iv;
+	unsigned int iv_len;
+	struct crypto_aead *tfm;
+	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	struct ksmbd_crypto_ctx *ctx;
+
+	rc = ksmbd_get_encryption_key(conn,
+				      le64_to_cpu(tr_hdr->SessionId),
+				      enc,
+				      key);
+	if (rc) {
+		pr_err("Could not get %scryption key\n", enc ? "en" : "de");
+		return rc;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+		ctx = ksmbd_crypto_ctx_find_gcm();
+	else
+		ctx = ksmbd_crypto_ctx_find_ccm();
+	if (!ctx) {
+		pr_err("crypto alloc failed\n");
+		return -ENOMEM;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+		tfm = CRYPTO_GCM(ctx);
+	else
+		tfm = CRYPTO_CCM(ctx);
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES256_CCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM)
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPTKEY_SIZE);
+	else
+		rc = crypto_aead_setkey(tfm, key, SMB3_GCM128_CRYPTKEY_SIZE);
+	if (rc) {
+		pr_err("Failed to set aead key %d\n", rc);
+		goto free_ctx;
+	}
+
+	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
+	if (rc) {
+		pr_err("Failed to set authsize %d\n", rc);
+		goto free_ctx;
+	}
+
+	req = aead_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto free_ctx;
+	}
+
+	if (!enc) {
+		memcpy(sign, &tr_hdr->Signature, SMB2_SIGNATURE_SIZE);
+		crypt_len += SMB2_SIGNATURE_SIZE;
+	}
+
+	sg = ksmbd_init_sg(iov, nvec, sign);
+	if (!sg) {
+		pr_err("Failed to init sg\n");
+		rc = -ENOMEM;
+		goto free_req;
+	}
+
+	iv_len = crypto_aead_ivsize(tfm);
+	iv = kzalloc(iv_len, GFP_KERNEL);
+	if (!iv) {
+		rc = -ENOMEM;
+		goto free_sg;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM ||
+	    conn->cipher_type == SMB2_ENCRYPTION_AES256_GCM) {
+		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES_GCM_NONCE);
+	} else {
+		iv[0] = 3;
+		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES_CCM_NONCE);
+	}
+
+	aead_request_set_crypt(req, sg, sg, crypt_len, iv);
+	aead_request_set_ad(req, assoc_data_len);
+	aead_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+
+	if (enc)
+		rc = crypto_aead_encrypt(req);
+	else
+		rc = crypto_aead_decrypt(req);
+	if (rc)
+		goto free_iv;
+
+	if (enc)
+		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
+
+free_iv:
+	kfree(iv);
+free_sg:
+	kfree(sg);
+free_req:
+	kfree(req);
+free_ctx:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
diff --git a/fs/ksmbd/auth.h b/fs/ksmbd/auth.h
new file mode 100644
index 000000000000..9c2d4badd05d
--- /dev/null
+++ b/fs/ksmbd/auth.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __AUTH_H__
+#define __AUTH_H__
+
+#include "ntlmssp.h"
+
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+#define AUTH_GSS_LENGTH		96
+#define AUTH_GSS_PADDING	0
+#else
+#define AUTH_GSS_LENGTH		74
+#define AUTH_GSS_PADDING	6
+#endif
+
+#define CIFS_HMAC_MD5_HASH_SIZE	(16)
+#define CIFS_NTHASH_SIZE	(16)
+
+/*
+ * Size of the ntlm client response
+ */
+#define CIFS_AUTH_RESP_SIZE		24
+#define CIFS_SMB1_SIGNATURE_SIZE	8
+#define CIFS_SMB1_SESSKEY_SIZE		16
+
+#define KSMBD_AUTH_NTLMSSP	0x0001
+#define KSMBD_AUTH_KRB5		0x0002
+#define KSMBD_AUTH_MSKRB5	0x0004
+#define KSMBD_AUTH_KRB5U2U	0x0008
+
+struct ksmbd_session;
+struct ksmbd_conn;
+struct kvec;
+
+int ksmbd_crypt_message(struct ksmbd_conn *conn, struct kvec *iov,
+			unsigned int nvec, int enc);
+void ksmbd_copy_gss_neg_header(void *buf);
+int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf);
+int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
+		      int blen, char *domain_name);
+int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
+				   int blob_len, struct ksmbd_session *sess);
+int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
+				  int blob_len, struct ksmbd_session *sess);
+unsigned int
+ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
+				   struct ksmbd_session *sess);
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess, char *in_blob,
+			    int in_len,	char *out_blob, int *out_len);
+int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			int n_vec, char *sig);
+int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn, char *key, struct kvec *iov,
+			int n_vec, char *sig);
+int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess,
+			       struct ksmbd_conn *conn);
+int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess,
+				struct ksmbd_conn *conn);
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess);
+int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
+				     __u8 *pi_hash);
+int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
+		      __u8 *pi_hash);
+#endif
diff --git a/fs/ksmbd/crypto_ctx.c b/fs/ksmbd/crypto_ctx.c
new file mode 100644
index 000000000000..5f4b1008d17e
--- /dev/null
+++ b/fs/ksmbd/crypto_ctx.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+#include "glob.h"
+#include "crypto_ctx.h"
+
+struct crypto_ctx_list {
+	spinlock_t		ctx_lock;
+	int			avail_ctx;
+	struct list_head	idle_ctx;
+	wait_queue_head_t	ctx_wait;
+};
+
+static struct crypto_ctx_list ctx_list;
+
+static inline void free_aead(struct crypto_aead *aead)
+{
+	if (aead)
+		crypto_free_aead(aead);
+}
+
+static void free_shash(struct shash_desc *shash)
+{
+	if (shash) {
+		crypto_free_shash(shash->tfm);
+		kfree(shash);
+	}
+}
+
+static struct crypto_aead *alloc_aead(int id)
+{
+	struct crypto_aead *tfm = NULL;
+
+	switch (id) {
+	case CRYPTO_AEAD_AES_GCM:
+		tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+		break;
+	case CRYPTO_AEAD_AES_CCM:
+		tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
+		break;
+	default:
+		pr_err("Does not support encrypt ahead(id : %d)\n", id);
+		return NULL;
+	}
+
+	if (IS_ERR(tfm)) {
+		pr_err("Failed to alloc encrypt aead : %ld\n", PTR_ERR(tfm));
+		return NULL;
+	}
+
+	return tfm;
+}
+
+static struct shash_desc *alloc_shash_desc(int id)
+{
+	struct crypto_shash *tfm = NULL;
+	struct shash_desc *shash;
+
+	switch (id) {
+	case CRYPTO_SHASH_HMACMD5:
+		tfm = crypto_alloc_shash("hmac(md5)", 0, 0);
+		break;
+	case CRYPTO_SHASH_HMACSHA256:
+		tfm = crypto_alloc_shash("hmac(sha256)", 0, 0);
+		break;
+	case CRYPTO_SHASH_CMACAES:
+		tfm = crypto_alloc_shash("cmac(aes)", 0, 0);
+		break;
+	case CRYPTO_SHASH_SHA256:
+		tfm = crypto_alloc_shash("sha256", 0, 0);
+		break;
+	case CRYPTO_SHASH_SHA512:
+		tfm = crypto_alloc_shash("sha512", 0, 0);
+		break;
+	case CRYPTO_SHASH_MD4:
+		tfm = crypto_alloc_shash("md4", 0, 0);
+		break;
+	case CRYPTO_SHASH_MD5:
+		tfm = crypto_alloc_shash("md5", 0, 0);
+		break;
+	default:
+		return NULL;
+	}
+
+	if (IS_ERR(tfm))
+		return NULL;
+
+	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
+			GFP_KERNEL);
+	if (!shash)
+		crypto_free_shash(tfm);
+	else
+		shash->tfm = tfm;
+	return shash;
+}
+
+static void ctx_free(struct ksmbd_crypto_ctx *ctx)
+{
+	int i;
+
+	for (i = 0; i < CRYPTO_SHASH_MAX; i++)
+		free_shash(ctx->desc[i]);
+	for (i = 0; i < CRYPTO_AEAD_MAX; i++)
+		free_aead(ctx->ccmaes[i]);
+	kfree(ctx);
+}
+
+static struct ksmbd_crypto_ctx *ksmbd_find_crypto_ctx(void)
+{
+	struct ksmbd_crypto_ctx *ctx;
+
+	while (1) {
+		spin_lock(&ctx_list.ctx_lock);
+		if (!list_empty(&ctx_list.idle_ctx)) {
+			ctx = list_entry(ctx_list.idle_ctx.next,
+					 struct ksmbd_crypto_ctx,
+					 list);
+			list_del(&ctx->list);
+			spin_unlock(&ctx_list.ctx_lock);
+			return ctx;
+		}
+
+		if (ctx_list.avail_ctx > num_online_cpus()) {
+			spin_unlock(&ctx_list.ctx_lock);
+			wait_event(ctx_list.ctx_wait,
+				   !list_empty(&ctx_list.idle_ctx));
+			continue;
+		}
+
+		ctx_list.avail_ctx++;
+		spin_unlock(&ctx_list.ctx_lock);
+
+		ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+		if (!ctx) {
+			spin_lock(&ctx_list.ctx_lock);
+			ctx_list.avail_ctx--;
+			spin_unlock(&ctx_list.ctx_lock);
+			wait_event(ctx_list.ctx_wait,
+				   !list_empty(&ctx_list.idle_ctx));
+			continue;
+		}
+		break;
+	}
+	return ctx;
+}
+
+void ksmbd_release_crypto_ctx(struct ksmbd_crypto_ctx *ctx)
+{
+	if (!ctx)
+		return;
+
+	spin_lock(&ctx_list.ctx_lock);
+	if (ctx_list.avail_ctx <= num_online_cpus()) {
+		list_add(&ctx->list, &ctx_list.idle_ctx);
+		spin_unlock(&ctx_list.ctx_lock);
+		wake_up(&ctx_list.ctx_wait);
+		return;
+	}
+
+	ctx_list.avail_ctx--;
+	spin_unlock(&ctx_list.ctx_lock);
+	ctx_free(ctx);
+}
+
+static struct ksmbd_crypto_ctx *____crypto_shash_ctx_find(int id)
+{
+	struct ksmbd_crypto_ctx *ctx;
+
+	if (id >= CRYPTO_SHASH_MAX)
+		return NULL;
+
+	ctx = ksmbd_find_crypto_ctx();
+	if (ctx->desc[id])
+		return ctx;
+
+	ctx->desc[id] = alloc_shash_desc(id);
+	if (ctx->desc[id])
+		return ctx;
+	ksmbd_release_crypto_ctx(ctx);
+	return NULL;
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacmd5(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_HMACMD5);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacsha256(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_HMACSHA256);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_CMACAES);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha256(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_SHA256);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_SHA512);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD4);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void)
+{
+	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD5);
+}
+
+static struct ksmbd_crypto_ctx *____crypto_aead_ctx_find(int id)
+{
+	struct ksmbd_crypto_ctx *ctx;
+
+	if (id >= CRYPTO_AEAD_MAX)
+		return NULL;
+
+	ctx = ksmbd_find_crypto_ctx();
+	if (ctx->ccmaes[id])
+		return ctx;
+
+	ctx->ccmaes[id] = alloc_aead(id);
+	if (ctx->ccmaes[id])
+		return ctx;
+	ksmbd_release_crypto_ctx(ctx);
+	return NULL;
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void)
+{
+	return ____crypto_aead_ctx_find(CRYPTO_AEAD_AES_GCM);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void)
+{
+	return ____crypto_aead_ctx_find(CRYPTO_AEAD_AES_CCM);
+}
+
+void ksmbd_crypto_destroy(void)
+{
+	struct ksmbd_crypto_ctx *ctx;
+
+	while (!list_empty(&ctx_list.idle_ctx)) {
+		ctx = list_entry(ctx_list.idle_ctx.next,
+				 struct ksmbd_crypto_ctx,
+				 list);
+		list_del(&ctx->list);
+		ctx_free(ctx);
+	}
+}
+
+int ksmbd_crypto_create(void)
+{
+	struct ksmbd_crypto_ctx *ctx;
+
+	spin_lock_init(&ctx_list.ctx_lock);
+	INIT_LIST_HEAD(&ctx_list.idle_ctx);
+	init_waitqueue_head(&ctx_list.ctx_wait);
+	ctx_list.avail_ctx = 1;
+
+	ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	list_add(&ctx->list, &ctx_list.idle_ctx);
+	return 0;
+}
diff --git a/fs/ksmbd/crypto_ctx.h b/fs/ksmbd/crypto_ctx.h
new file mode 100644
index 000000000000..ef11154b43df
--- /dev/null
+++ b/fs/ksmbd/crypto_ctx.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __CRYPTO_CTX_H__
+#define __CRYPTO_CTX_H__
+
+#include <crypto/hash.h>
+#include <crypto/aead.h>
+
+enum {
+	CRYPTO_SHASH_HMACMD5	= 0,
+	CRYPTO_SHASH_HMACSHA256,
+	CRYPTO_SHASH_CMACAES,
+	CRYPTO_SHASH_SHA256,
+	CRYPTO_SHASH_SHA512,
+	CRYPTO_SHASH_MD4,
+	CRYPTO_SHASH_MD5,
+	CRYPTO_SHASH_MAX,
+};
+
+enum {
+	CRYPTO_AEAD_AES_GCM = 16,
+	CRYPTO_AEAD_AES_CCM,
+	CRYPTO_AEAD_MAX,
+};
+
+enum {
+	CRYPTO_BLK_ECBDES	= 32,
+	CRYPTO_BLK_MAX,
+};
+
+struct ksmbd_crypto_ctx {
+	struct list_head		list;
+
+	struct shash_desc		*desc[CRYPTO_SHASH_MAX];
+	struct crypto_aead		*ccmaes[CRYPTO_AEAD_MAX];
+};
+
+#define CRYPTO_HMACMD5(c)	((c)->desc[CRYPTO_SHASH_HMACMD5])
+#define CRYPTO_HMACSHA256(c)	((c)->desc[CRYPTO_SHASH_HMACSHA256])
+#define CRYPTO_CMACAES(c)	((c)->desc[CRYPTO_SHASH_CMACAES])
+#define CRYPTO_SHA256(c)	((c)->desc[CRYPTO_SHASH_SHA256])
+#define CRYPTO_SHA512(c)	((c)->desc[CRYPTO_SHASH_SHA512])
+#define CRYPTO_MD4(c)		((c)->desc[CRYPTO_SHASH_MD4])
+#define CRYPTO_MD5(c)		((c)->desc[CRYPTO_SHASH_MD5])
+
+#define CRYPTO_HMACMD5_TFM(c)	((c)->desc[CRYPTO_SHASH_HMACMD5]->tfm)
+#define CRYPTO_HMACSHA256_TFM(c)\
+				((c)->desc[CRYPTO_SHASH_HMACSHA256]->tfm)
+#define CRYPTO_CMACAES_TFM(c)	((c)->desc[CRYPTO_SHASH_CMACAES]->tfm)
+#define CRYPTO_SHA256_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA256]->tfm)
+#define CRYPTO_SHA512_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA512]->tfm)
+#define CRYPTO_MD4_TFM(c)	((c)->desc[CRYPTO_SHASH_MD4]->tfm)
+#define CRYPTO_MD5_TFM(c)	((c)->desc[CRYPTO_SHASH_MD5]->tfm)
+
+#define CRYPTO_GCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_GCM])
+#define CRYPTO_CCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_CCM])
+
+void ksmbd_release_crypto_ctx(struct ksmbd_crypto_ctx *ctx);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacmd5(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacsha256(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha256(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void);
+void ksmbd_crypto_destroy(void);
+int ksmbd_crypto_create(void);
+
+#endif /* __CRYPTO_CTX_H__ */
diff --git a/fs/ksmbd/ksmbd_spnego_negtokeninit.asn1 b/fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
new file mode 100644
index 000000000000..0065f191b54b
--- /dev/null
+++ b/fs/ksmbd/ksmbd_spnego_negtokeninit.asn1
@@ -0,0 +1,31 @@
+GSSAPI ::=
+	[APPLICATION 0] IMPLICIT SEQUENCE {
+		thisMech
+			OBJECT IDENTIFIER ({ksmbd_gssapi_this_mech}),
+		negotiationToken
+			NegotiationToken
+	}
+
+MechType ::= OBJECT IDENTIFIER ({ksmbd_neg_token_init_mech_type})
+
+MechTypeList ::= SEQUENCE OF MechType
+
+NegTokenInit ::=
+	SEQUENCE {
+		mechTypes
+			[0] MechTypeList,
+		reqFlags
+			[1] BIT STRING OPTIONAL,
+		mechToken
+			[2] OCTET STRING OPTIONAL ({ksmbd_neg_token_init_mech_token}),
+		mechListMIC
+			[3] OCTET STRING OPTIONAL
+	}
+
+NegotiationToken ::=
+	CHOICE {
+		negTokenInit
+			[0] NegTokenInit,
+		negTokenTarg
+			[1] ANY
+	}
diff --git a/fs/ksmbd/ksmbd_spnego_negtokentarg.asn1 b/fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
new file mode 100644
index 000000000000..1151933e7b9c
--- /dev/null
+++ b/fs/ksmbd/ksmbd_spnego_negtokentarg.asn1
@@ -0,0 +1,19 @@
+GSSAPI ::=
+	CHOICE {
+		negTokenInit
+			[0] ANY,
+		negTokenTarg
+			[1] NegTokenTarg
+	}
+
+NegTokenTarg ::=
+	SEQUENCE {
+		negResult
+			[0] ENUMERATED OPTIONAL,
+		supportedMech
+			[1] OBJECT IDENTIFIER OPTIONAL,
+		responseToken
+			[2] OCTET STRING OPTIONAL ({ksmbd_neg_token_targ_resp_token}),
+		mechListMIC
+			[3] OCTET STRING OPTIONAL
+	}
diff --git a/fs/ksmbd/ntlmssp.h b/fs/ksmbd/ntlmssp.h
new file mode 100644
index 000000000000..adaf4c0cbe8f
--- /dev/null
+++ b/fs/ksmbd/ntlmssp.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   Copyright (c) International Business Machines  Corp., 2002,2007
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ */
+
+#ifndef __KSMBD_NTLMSSP_H
+#define __KSMBD_NTLMSSP_H
+
+#define NTLMSSP_SIGNATURE "NTLMSSP"
+
+/* Security blob target info data */
+#define TGT_Name        "KSMBD"
+
+/*
+ * Size of the crypto key returned on the negotiate SMB in bytes
+ */
+#define CIFS_CRYPTO_KEY_SIZE	(8)
+#define CIFS_KEY_SIZE	(40)
+
+/*
+ * Size of encrypted user password in bytes
+ */
+#define CIFS_ENCPWD_SIZE	(16)
+#define CIFS_CPHTXT_SIZE	(16)
+
+/* Message Types */
+#define NtLmNegotiate     cpu_to_le32(1)
+#define NtLmChallenge     cpu_to_le32(2)
+#define NtLmAuthenticate  cpu_to_le32(3)
+#define UnknownMessage    cpu_to_le32(8)
+
+/* Negotiate Flags */
+#define NTLMSSP_NEGOTIATE_UNICODE         0x01 /* Text strings are unicode */
+#define NTLMSSP_NEGOTIATE_OEM             0x02 /* Text strings are in OEM */
+#define NTLMSSP_REQUEST_TARGET            0x04 /* Srv returns its auth realm */
+/* define reserved9                       0x08 */
+#define NTLMSSP_NEGOTIATE_SIGN          0x0010 /* Request signing capability */
+#define NTLMSSP_NEGOTIATE_SEAL          0x0020 /* Request confidentiality */
+#define NTLMSSP_NEGOTIATE_DGRAM         0x0040
+#define NTLMSSP_NEGOTIATE_LM_KEY        0x0080 /* Use LM session key */
+/* defined reserved 8                   0x0100 */
+#define NTLMSSP_NEGOTIATE_NTLM          0x0200 /* NTLM authentication */
+#define NTLMSSP_NEGOTIATE_NT_ONLY       0x0400 /* Lanman not allowed */
+#define NTLMSSP_ANONYMOUS               0x0800
+#define NTLMSSP_NEGOTIATE_DOMAIN_SUPPLIED 0x1000 /* reserved6 */
+#define NTLMSSP_NEGOTIATE_WORKSTATION_SUPPLIED 0x2000
+#define NTLMSSP_NEGOTIATE_LOCAL_CALL    0x4000 /* client/server same machine */
+#define NTLMSSP_NEGOTIATE_ALWAYS_SIGN   0x8000 /* Sign. All security levels  */
+#define NTLMSSP_TARGET_TYPE_DOMAIN     0x10000
+#define NTLMSSP_TARGET_TYPE_SERVER     0x20000
+#define NTLMSSP_TARGET_TYPE_SHARE      0x40000
+#define NTLMSSP_NEGOTIATE_EXTENDED_SEC 0x80000 /* NB:not related to NTLMv2 pwd*/
+/* #define NTLMSSP_REQUEST_INIT_RESP     0x100000 */
+#define NTLMSSP_NEGOTIATE_IDENTIFY    0x100000
+#define NTLMSSP_REQUEST_ACCEPT_RESP   0x200000 /* reserved5 */
+#define NTLMSSP_REQUEST_NON_NT_KEY    0x400000
+#define NTLMSSP_NEGOTIATE_TARGET_INFO 0x800000
+/* #define reserved4                 0x1000000 */
+#define NTLMSSP_NEGOTIATE_VERSION    0x2000000 /* we do not set */
+/* #define reserved3                 0x4000000 */
+/* #define reserved2                 0x8000000 */
+/* #define reserved1                0x10000000 */
+#define NTLMSSP_NEGOTIATE_128       0x20000000
+#define NTLMSSP_NEGOTIATE_KEY_XCH   0x40000000
+#define NTLMSSP_NEGOTIATE_56        0x80000000
+
+/* Define AV Pair Field IDs */
+enum av_field_type {
+	NTLMSSP_AV_EOL = 0,
+	NTLMSSP_AV_NB_COMPUTER_NAME,
+	NTLMSSP_AV_NB_DOMAIN_NAME,
+	NTLMSSP_AV_DNS_COMPUTER_NAME,
+	NTLMSSP_AV_DNS_DOMAIN_NAME,
+	NTLMSSP_AV_DNS_TREE_NAME,
+	NTLMSSP_AV_FLAGS,
+	NTLMSSP_AV_TIMESTAMP,
+	NTLMSSP_AV_RESTRICTION,
+	NTLMSSP_AV_TARGET_NAME,
+	NTLMSSP_AV_CHANNEL_BINDINGS
+};
+
+/* Although typedefs are not commonly used for structure definitions */
+/* in the Linux kernel, in this particular case they are useful      */
+/* to more closely match the standards document for NTLMSSP from     */
+/* OpenGroup and to make the code more closely match the standard in */
+/* appearance */
+
+struct security_buffer {
+	__le16 Length;
+	__le16 MaximumLength;
+	__le32 BufferOffset;	/* offset to buffer */
+} __packed;
+
+struct target_info {
+	__le16 Type;
+	__le16 Length;
+	__u8 Content[0];
+} __packed;
+
+struct negotiate_message {
+	__u8 Signature[sizeof(NTLMSSP_SIGNATURE)];
+	__le32 MessageType;     /* NtLmNegotiate = 1 */
+	__le32 NegotiateFlags;
+	struct security_buffer DomainName;	/* RFC 1001 style and ASCII */
+	struct security_buffer WorkstationName;	/* RFC 1001 and ASCII */
+	/*
+	 * struct security_buffer for version info not present since we
+	 * do not set the version is present flag
+	 */
+	char DomainString[0];
+	/* followed by WorkstationString */
+} __packed;
+
+struct challenge_message {
+	__u8 Signature[sizeof(NTLMSSP_SIGNATURE)];
+	__le32 MessageType;   /* NtLmChallenge = 2 */
+	struct security_buffer TargetName;
+	__le32 NegotiateFlags;
+	__u8 Challenge[CIFS_CRYPTO_KEY_SIZE];
+	__u8 Reserved[8];
+	struct security_buffer TargetInfoArray;
+	/*
+	 * struct security_buffer for version info not present since we
+	 * do not set the version is present flag
+	 */
+} __packed;
+
+struct authenticate_message {
+	__u8 Signature[sizeof(NTLMSSP_SIGNATURE)];
+	__le32 MessageType;  /* NtLmsAuthenticate = 3 */
+	struct security_buffer LmChallengeResponse;
+	struct security_buffer NtChallengeResponse;
+	struct security_buffer DomainName;
+	struct security_buffer UserName;
+	struct security_buffer WorkstationName;
+	struct security_buffer SessionKey;
+	__le32 NegotiateFlags;
+	/*
+	 * struct security_buffer for version info not present since we
+	 * do not set the version is present flag
+	 */
+	char UserString[0];
+} __packed;
+
+struct ntlmv2_resp {
+	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
+	__le32 blob_signature;
+	__u32  reserved;
+	__le64  time;
+	__u64  client_chal; /* random */
+	__u32  reserved2;
+	/* array of name entries could follow ending in minimum 4 byte struct */
+} __packed;
+
+/* per smb session structure/fields */
+struct ntlmssp_auth {
+	/* whether session key is per smb session */
+	bool		sesskey_per_smbsess;
+	/* sent by client in type 1 ntlmsssp exchange */
+	__u32		client_flags;
+	/* sent by server in type 2 ntlmssp exchange */
+	__u32		conn_flags;
+	/* sent to server */
+	unsigned char	ciphertext[CIFS_CPHTXT_SIZE];
+	/* used by ntlmssp */
+	char		cryptkey[CIFS_CRYPTO_KEY_SIZE];
+};
+#endif /* __KSMBD_NTLMSSP_H */
-- 
2.17.1

