Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1728343848
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 06:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhCVFWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 01:22:51 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:46712 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCVFWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 01:22:13 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210322052210epoutp0324981713db35b06cac5dcef85ae8253c~ukp_eTYeV0298002980epoutp03C
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 05:22:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210322052210epoutp0324981713db35b06cac5dcef85ae8253c~ukp_eTYeV0298002980epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616390530;
        bh=F1p+2d+Q0uzckAYEjSgWmFULGcjWv9kqMpKxMca8NQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pyIMhdNQjelz6pbtmT+sn+oeVdfdULK+23kPBf0O9A+ASIcJLUQqVgUMJbuRlqPl2
         zW6WB4T/lhhruq7kfFEWCPlDNbWbtNWmPVi1rsSWFiP61Qwe2y8pUUrFIBe58VCqwE
         UhAjyTzuPu1Ou4cuM58KfmA1LbH7fusRygLRdy5k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210322052208epcas1p3573c38e1c945fefed5484c29c10d4edf~ukp8_rbST1492314923epcas1p3H;
        Mon, 22 Mar 2021 05:22:08 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.159]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F3jYC4wn2z4x9QC; Mon, 22 Mar
        2021 05:22:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.FF.10347.F7928506; Mon, 22 Mar 2021 14:22:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210322052206epcas1p438f15851216f07540537c5547a0a2c02~ukp64-_RL2035720357epcas1p4M;
        Mon, 22 Mar 2021 05:22:06 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210322052206epsmtrp1e9280f5b7585c86fe5da5dcfab2dc9da~ukp63SoC22013120131epsmtrp1M;
        Mon, 22 Mar 2021 05:22:06 +0000 (GMT)
X-AuditID: b6c32a39-15dff7000002286b-22-6058297f529d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F0.36.08745.E7928506; Mon, 22 Mar 2021 14:22:06 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.103.87]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210322052205epsmtip193246c5db15cc4e226a06d6502b359a4~ukp5sR0_c1797317973epsmtip1Q;
        Mon, 22 Mar 2021 05:22:05 +0000 (GMT)
From:   Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     linux-cifsd-devel@lists.sourceforge.net, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        viro@zeniv.linux.org.uk, hch@lst.de, hch@infradead.org,
        ronniesahlberg@gmail.com, aurelien.aptel@gmail.com,
        aaptel@suse.com, sandeen@sandeen.net, dan.carpenter@oracle.com,
        colin.king@canonical.com, rdunlap@infradead.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 2/5] cifsd: add server-side procedures for SMB3
Date:   Mon, 22 Mar 2021 14:13:41 +0900
Message-Id: <20210322051344.1706-3-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210322051344.1706-1-namjae.jeon@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzH59x7ufdibnNbUE7o8NjJiSUeuyyLB4RqRsfuYH9QYjXO4HKD
        O0Atu9suKyINYNMKMoLYHywPUaQSEpJHYDxkSHZoLZxQSFMyAaFcWdcHWy7Eq12uVv99z/d8
        fuf7Oy8aF18k/eksTQ6v13BqCbmOOG+RysILpe+lyooX/dEhxzCBrPZlCi02l5HIvmIm0HBF
        A4a+ah7C0PWJhxSyrfbiaGHVBdCF/h8INNZ7gkTz5kLkuOVmy8rnvJDp51DU195Aoq+d0xS6
        b7OQaPz4KRKNLFu9Xvdla4rKSLa26CrB9tT8RrHfNIWyffVOjO27WUSypu5lin38+zjBlnee
        BWzn51MY29p5jWCdHQFsx4wDSxLtVcdn8lw6rw/iNWna9CxNRoJk127VdpUyRiYPl8eirZIg
        DZfNJ0h2vJkUvjNL7d6sJGg/pza6rSTOYJBEvhqv1xpz+KBMrSEnQcLr0tU6uUwXYeCyDUZN
        RkSaNjtOLpNFKd1kqjpz9X4TpZutlx8w10UWgboyaSnwpiETDYec1UQpWEeLmW4Aq1vuUsJg
        DkDXZC3hocSME8CVE7HPKpyO25jg9wLo+CPu3wJrTz9eCmiaZF6BS50bPIwvkwJvdNtxD4Mz
        13Fora8Gngkf5jXYPdFBejTBbIHfDyzgHi1itsHhCy4ghAXC5rbv1nxvJh5WNh5ZaxUykzQs
        PVfl5QmDzA44Z48XeB84a+2kBO0P7x07TAlIPnw8gAt2CYA2V4KgFfBma9vaKjgjha29kYId
        DHsW69Y6wJnn4YO/jj4NEsGSw2IB2QLLRy2YoDfB0uJHT0NZ2DJ4FRdO5BiAxYsPsQoQUPNf
        Qj0AZ8FGXmfIzuANcp3y//fVAdbecmhsNzA7HkUMAowGgwDSuMRXdCktOVUsSufyDvJ6rUpv
        VPOGQaB0H91x3H9Dmtb9GTQ5KrkySqFQoOiYrTFKhcRP9L5sUiVmMrgc/kOe1/H6Z3UY7e1f
        hG3uYRPjQnL99M/lsYbcur1L27sGGirOORqhdGT+k0aRr9S0r2vbjylHC0/bk3MV4tGXxHmt
        Vl0wOHl7NDWP2rmiDSg4cm2hcs/c8pfo3rSXLCT0zpWq8o2mGdZe/CIxe/6FCV/9obtVKRe7
        btmk4+9cWTqVb22Optb3LwYH+gztqrK1j0cMNcmSfzpjfIBdbmkYsTXVHTRNlTBRSy/XqmJL
        HJcLTr5bYWkbNi2cdq6vKs671M6F1b7xy2al39zbYx/Zzfv/zkgMO2OJmdlTWdByYPed+WBv
        YvZJoTXrA5cl/8ZKou4z47d/0pso18f7Pv01EbNnh0x/8VZA4BOtz9TUWJiEMGRy8lBcb+D+
        AXQGXYZUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLLMWRmVeSWpSXmKPExsWy7bCSnG6dZkSCweSrohaNb0+zWBx//Zfd
        4vfqXjaL1/+ms1icnrCIyWLl6qNMFtfuv2e3ePF/F7PFz//fGS327D3JYnF51xw2ix/T6y3e
        3gGq7e37xGrRekXLYvfGRWwWaz8/Zrd48+Iwm8WtifPZLM7/Pc7qIOIxq6GXzWN2w0UWj52z
        7rJ7bF6h5bF7wWcmj903G9g8Wnf8Zff4+PQWi0ffllWMHlsWP2TyWL/lKovH501yHpuevGUK
        4I3isklJzcksSy3St0vgyvj/ZgV7wasFhhXT5+o3MM7t1exi5OSQEDCR+Pz2HlMXIxeHkMAO
        Ronz0w4zQSSkJY6dOMPcxcgBZAtLHD5cDFHzgVHidMM5dpA4m4C2xJ8toiDlIgLxEjcbbrOA
        1DALvGKWWLX2NNgcYQF7iR33N7GB2CwCqhLH9v9kBrF5BawlTu/5zgixS15i9YYDYHFOARuJ
        acs7WUBsIaCama33mSYw8i1gZFjFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcQ1pa
        Oxj3rPqgd4iRiYPxEKMEB7OSCO+J5JAEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmk
        J5akZqemFqQWwWSZODilGpimspUcmnnloY9w1V0G/mtWV1pZa459qwxfNsX0Vd3RrarbrZ88
        6VzAskRJIcK75RabtY18X9+MD7/sC/rtrnML3C9ieb/H4X7bNoY5NpZ7rhdKnFsxQYf30rW/
        Rs4fOlpKF+QfCVxk0Bqj9bVb+/dauUYX3bQ4llku83m2Bxlv6ug558ov52fFrtDzaZ/cj2fN
        05qf9Ul82fxL/lbOhM+CeepGOzy3KnzyT27NfRj6avXOfmZeU7+c6ysyVWs3FHRdWiiSOMNT
        iGVLuEybTap/+qqH2yd/FT/xJ0ckvNXnj6q+QEeu8l8HhVURqh8f3IiO/S3ko6ltteP4vcvT
        e87PmtsV09nV8We7Klv9TiWW4oxEQy3mouJEAGBMsHwQAwAA
X-CMS-MailID: 20210322052206epcas1p438f15851216f07540537c5547a0a2c02
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210322052206epcas1p438f15851216f07540537c5547a0a2c02
References: <20210322051344.1706-1-namjae.jeon@samsung.com>
        <CGME20210322052206epcas1p438f15851216f07540537c5547a0a2c02@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds smb3 engine, NTLM/NTLMv2/Kerberos authentication, oplock/lease
cache mechanism for cifsd.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifsd/asn1.c              |  702 +++
 fs/cifsd/asn1.h              |   29 +
 fs/cifsd/auth.c              | 1348 ++++++
 fs/cifsd/auth.h              |   90 +
 fs/cifsd/crypto_ctx.c        |  287 ++
 fs/cifsd/crypto_ctx.h        |   77 +
 fs/cifsd/mgmt/ksmbd_ida.c    |   69 +
 fs/cifsd/mgmt/ksmbd_ida.h    |   41 +
 fs/cifsd/mgmt/share_config.c |  238 +
 fs/cifsd/mgmt/share_config.h |   81 +
 fs/cifsd/mgmt/tree_connect.c |  128 +
 fs/cifsd/mgmt/tree_connect.h |   56 +
 fs/cifsd/mgmt/user_config.c  |   69 +
 fs/cifsd/mgmt/user_config.h  |   66 +
 fs/cifsd/mgmt/user_session.c |  344 ++
 fs/cifsd/mgmt/user_session.h |  105 +
 fs/cifsd/misc.c              |  296 ++
 fs/cifsd/misc.h              |   38 +
 fs/cifsd/ndr.c               |  344 ++
 fs/cifsd/ndr.h               |   21 +
 fs/cifsd/netmisc.c           |   46 +
 fs/cifsd/nterr.c             |  674 +++
 fs/cifsd/nterr.h             |  552 +++
 fs/cifsd/ntlmssp.h           |  169 +
 fs/cifsd/oplock.c            | 1681 +++++++
 fs/cifsd/oplock.h            |  138 +
 fs/cifsd/smb2misc.c          |  458 ++
 fs/cifsd/smb2ops.c           |  300 ++
 fs/cifsd/smb2pdu.c           | 8452 ++++++++++++++++++++++++++++++++++
 fs/cifsd/smb2pdu.h           | 1649 +++++++
 fs/cifsd/smb_common.c        |  667 +++
 fs/cifsd/smb_common.h        |  546 +++
 fs/cifsd/smbacl.c            | 1324 ++++++
 fs/cifsd/smbacl.h            |  202 +
 fs/cifsd/smberr.h            |  235 +
 fs/cifsd/smbfsctl.h          |   90 +
 fs/cifsd/smbstatus.h         | 1822 ++++++++
 fs/cifsd/time_wrappers.h     |   34 +
 fs/cifsd/unicode.c           |  391 ++
 fs/cifsd/unicode.h           |  374 ++
 fs/cifsd/uniupr.h            |  268 ++
 41 files changed, 24501 insertions(+)
 create mode 100644 fs/cifsd/asn1.c
 create mode 100644 fs/cifsd/asn1.h
 create mode 100644 fs/cifsd/auth.c
 create mode 100644 fs/cifsd/auth.h
 create mode 100644 fs/cifsd/crypto_ctx.c
 create mode 100644 fs/cifsd/crypto_ctx.h
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.c
 create mode 100644 fs/cifsd/mgmt/ksmbd_ida.h
 create mode 100644 fs/cifsd/mgmt/share_config.c
 create mode 100644 fs/cifsd/mgmt/share_config.h
 create mode 100644 fs/cifsd/mgmt/tree_connect.c
 create mode 100644 fs/cifsd/mgmt/tree_connect.h
 create mode 100644 fs/cifsd/mgmt/user_config.c
 create mode 100644 fs/cifsd/mgmt/user_config.h
 create mode 100644 fs/cifsd/mgmt/user_session.c
 create mode 100644 fs/cifsd/mgmt/user_session.h
 create mode 100644 fs/cifsd/misc.c
 create mode 100644 fs/cifsd/misc.h
 create mode 100644 fs/cifsd/ndr.c
 create mode 100644 fs/cifsd/ndr.h
 create mode 100644 fs/cifsd/netmisc.c
 create mode 100644 fs/cifsd/nterr.c
 create mode 100644 fs/cifsd/nterr.h
 create mode 100644 fs/cifsd/ntlmssp.h
 create mode 100644 fs/cifsd/oplock.c
 create mode 100644 fs/cifsd/oplock.h
 create mode 100644 fs/cifsd/smb2misc.c
 create mode 100644 fs/cifsd/smb2ops.c
 create mode 100644 fs/cifsd/smb2pdu.c
 create mode 100644 fs/cifsd/smb2pdu.h
 create mode 100644 fs/cifsd/smb_common.c
 create mode 100644 fs/cifsd/smb_common.h
 create mode 100644 fs/cifsd/smbacl.c
 create mode 100644 fs/cifsd/smbacl.h
 create mode 100644 fs/cifsd/smberr.h
 create mode 100644 fs/cifsd/smbfsctl.h
 create mode 100644 fs/cifsd/smbstatus.h
 create mode 100644 fs/cifsd/time_wrappers.h
 create mode 100644 fs/cifsd/unicode.c
 create mode 100644 fs/cifsd/unicode.h
 create mode 100644 fs/cifsd/uniupr.h

diff --git a/fs/cifsd/asn1.c b/fs/cifsd/asn1.c
new file mode 100644
index 000000000000..aa702b665849
--- /dev/null
+++ b/fs/cifsd/asn1.c
@@ -0,0 +1,702 @@
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
+
+#include "glob.h"
+
+#include "asn1.h"
+#include "connection.h"
+#include "auth.h"
+
+/*****************************************************************************
+ *
+ * Basic ASN.1 decoding routines (gxsnmp author Dirk Wisse)
+ *
+ *****************************************************************************/
+
+/* Class */
+#define ASN1_UNI	0	/* Universal */
+#define ASN1_APL	1	/* Application */
+#define ASN1_CTX	2	/* Context */
+#define ASN1_PRV	3	/* Private */
+
+/* Tag */
+#define ASN1_EOC	0	/* End Of Contents or N/A */
+#define ASN1_BOL	1	/* Boolean */
+#define ASN1_INT	2	/* Integer */
+#define ASN1_BTS	3	/* Bit String */
+#define ASN1_OTS	4	/* Octet String */
+#define ASN1_NUL	5	/* Null */
+#define ASN1_OJI	6	/* Object Identifier  */
+#define ASN1_OJD	7	/* Object Description */
+#define ASN1_EXT	8	/* External */
+#define ASN1_ENUM	10	/* Enumerated */
+#define ASN1_SEQ	16	/* Sequence */
+#define ASN1_SET	17	/* Set */
+#define ASN1_NUMSTR	18	/* Numerical String */
+#define ASN1_PRNSTR	19	/* Printable String */
+#define ASN1_TEXSTR	20	/* Teletext String */
+#define ASN1_VIDSTR	21	/* Video String */
+#define ASN1_IA5STR	22	/* IA5 String */
+#define ASN1_UNITIM	23	/* Universal Time */
+#define ASN1_GENTIM	24	/* General Time */
+#define ASN1_GRASTR	25	/* Graphical String */
+#define ASN1_VISSTR	26	/* Visible String */
+#define ASN1_GENSTR	27	/* General String */
+
+/* Primitive / Constructed methods*/
+#define ASN1_PRI	0	/* Primitive */
+#define ASN1_CON	1	/* Constructed */
+
+/*
+ * Error codes.
+ */
+#define ASN1_ERR_NOERROR		0
+#define ASN1_ERR_DEC_EMPTY		2
+#define ASN1_ERR_DEC_EOC_MISMATCH	3
+#define ASN1_ERR_DEC_LENGTH_MISMATCH	4
+#define ASN1_ERR_DEC_BADVALUE		5
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
+/*
+ * ASN.1 context.
+ */
+struct asn1_ctx {
+	int error;		/* Error condition */
+	unsigned char *pointer;	/* Octet just to be decoded */
+	unsigned char *begin;	/* First octet */
+	unsigned char *end;	/* Octet after last octet */
+};
+
+/*
+ * Octet string (not null terminated)
+ */
+struct asn1_octstr {
+	unsigned char *data;
+	unsigned int len;
+};
+
+static void
+asn1_open(struct asn1_ctx *ctx, unsigned char *buf, unsigned int len)
+{
+	ctx->begin = buf;
+	ctx->end = buf + len;
+	ctx->pointer = buf;
+	ctx->error = ASN1_ERR_NOERROR;
+}
+
+static unsigned char
+asn1_octet_decode(struct asn1_ctx *ctx, unsigned char *ch)
+{
+	if (ctx->pointer >= ctx->end) {
+		ctx->error = ASN1_ERR_DEC_EMPTY;
+		return 0;
+	}
+	*ch = *(ctx->pointer)++;
+	return 1;
+}
+
+static unsigned char
+asn1_tag_decode(struct asn1_ctx *ctx, unsigned int *tag)
+{
+	unsigned char ch;
+
+	*tag = 0;
+
+	do {
+		if (!asn1_octet_decode(ctx, &ch))
+			return 0;
+		*tag <<= 7;
+		*tag |= ch & 0x7F;
+	} while ((ch & 0x80) == 0x80);
+	return 1;
+}
+
+static unsigned char
+asn1_id_decode(struct asn1_ctx *ctx,
+	       unsigned int *cls, unsigned int *con, unsigned int *tag)
+{
+	unsigned char ch;
+
+	if (!asn1_octet_decode(ctx, &ch))
+		return 0;
+
+	*cls = (ch & 0xC0) >> 6;
+	*con = (ch & 0x20) >> 5;
+	*tag = (ch & 0x1F);
+
+	if (*tag == 0x1F) {
+		if (!asn1_tag_decode(ctx, tag))
+			return 0;
+	}
+	return 1;
+}
+
+static unsigned char
+asn1_length_decode(struct asn1_ctx *ctx, unsigned int *def, unsigned int *len)
+{
+	unsigned char ch, cnt;
+
+	if (!asn1_octet_decode(ctx, &ch))
+		return 0;
+
+	if (ch == 0x80)
+		*def = 0;
+	else {
+		*def = 1;
+
+		if (ch < 0x80)
+			*len = ch;
+		else {
+			cnt = (unsigned char) (ch & 0x7F);
+			*len = 0;
+
+			while (cnt > 0) {
+				if (!asn1_octet_decode(ctx, &ch))
+					return 0;
+				*len <<= 8;
+				*len |= ch;
+				cnt--;
+			}
+		}
+	}
+
+	/* don't trust len bigger than ctx buffer */
+	if (*len > ctx->end - ctx->pointer)
+		return 0;
+
+	return 1;
+}
+
+static unsigned char
+asn1_header_decode(struct asn1_ctx *ctx,
+		   unsigned char **eoc,
+		   unsigned int *cls, unsigned int *con, unsigned int *tag)
+{
+	unsigned int def = 0;
+	unsigned int len = 0;
+
+	if (!asn1_id_decode(ctx, cls, con, tag))
+		return 0;
+
+	if (!asn1_length_decode(ctx, &def, &len))
+		return 0;
+
+	/* primitive shall be definite, indefinite shall be constructed */
+	if (*con == ASN1_PRI && !def)
+		return 0;
+
+	if (def)
+		*eoc = ctx->pointer + len;
+	else
+		*eoc = NULL;
+	return 1;
+}
+
+static unsigned char
+asn1_eoc_decode(struct asn1_ctx *ctx, unsigned char *eoc)
+{
+	unsigned char ch;
+
+	if (!eoc) {
+		if (!asn1_octet_decode(ctx, &ch))
+			return 0;
+
+		if (ch != 0x00) {
+			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
+			return 0;
+		}
+
+		if (!asn1_octet_decode(ctx, &ch))
+			return 0;
+
+		if (ch != 0x00) {
+			ctx->error = ASN1_ERR_DEC_EOC_MISMATCH;
+			return 0;
+		}
+	} else {
+		if (ctx->pointer != eoc) {
+			ctx->error = ASN1_ERR_DEC_LENGTH_MISMATCH;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static unsigned char
+asn1_subid_decode(struct asn1_ctx *ctx, unsigned long *subid)
+{
+	unsigned char ch;
+
+	*subid = 0;
+
+	do {
+		if (!asn1_octet_decode(ctx, &ch))
+			return 0;
+
+		*subid <<= 7;
+		*subid |= ch & 0x7F;
+	} while ((ch & 0x80) == 0x80);
+	return 1;
+}
+
+static int
+asn1_oid_decode(struct asn1_ctx *ctx,
+		unsigned char *eoc, unsigned long **oid, unsigned int *len)
+{
+	unsigned long subid;
+	unsigned int size;
+	unsigned long *optr;
+
+	size = eoc - ctx->pointer + 1;
+
+	/* first subid actually encodes first two subids */
+	if (size < 2 || size > UINT_MAX/sizeof(unsigned long))
+		return 0;
+
+	*oid = kmalloc(size * sizeof(unsigned long), GFP_KERNEL);
+	if (!*oid)
+		return 0;
+
+	optr = *oid;
+
+	if (!asn1_subid_decode(ctx, &subid)) {
+		kfree(*oid);
+		*oid = NULL;
+		return 0;
+	}
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
+	*len = 2;
+	optr += 2;
+
+	while (ctx->pointer < eoc) {
+		if (++(*len) > size) {
+			ctx->error = ASN1_ERR_DEC_BADVALUE;
+			kfree(*oid);
+			*oid = NULL;
+			return 0;
+		}
+
+		if (!asn1_subid_decode(ctx, optr++)) {
+			kfree(*oid);
+			*oid = NULL;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int
+compare_oid(unsigned long *oid1, unsigned int oid1len,
+	    unsigned long *oid2, unsigned int oid2len)
+{
+	unsigned int i;
+
+	if (oid1len != oid2len)
+		return 0;
+
+	for (i = 0; i < oid1len; i++) {
+		if (oid1[i] != oid2[i])
+			return 0;
+	}
+	return 1;
+}
+
+/* BB check for endian conversion issues here */
+
+int
+ksmbd_decode_negTokenInit(unsigned char *security_blob, int length,
+		    struct ksmbd_conn *conn)
+{
+	struct asn1_ctx ctx;
+	unsigned char *end;
+	unsigned char *sequence_end;
+	unsigned long *oid = NULL;
+	unsigned int cls, con, tag, oidlen, rc, mechTokenlen;
+	unsigned int mech_type;
+
+	ksmbd_debug(AUTH, "Received SecBlob: length %d\n", length);
+
+	asn1_open(&ctx, security_blob, length);
+
+	/* GSSAPI header */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
+		return 0;
+	} else if ((cls != ASN1_APL) || (con != ASN1_CON)
+		   || (tag != ASN1_EOC)) {
+		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
+			tag);
+		return 0;
+	}
+
+	/* Check for SPNEGO OID -- remember to free obj->oid */
+	rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
+	if (rc) {
+		if ((tag == ASN1_OJI) && (con == ASN1_PRI) &&
+		    (cls == ASN1_UNI)) {
+			rc = asn1_oid_decode(&ctx, end, &oid, &oidlen);
+			if (rc) {
+				rc = compare_oid(oid, oidlen, SPNEGO_OID,
+						 SPNEGO_OID_LEN);
+				kfree(oid);
+			}
+		} else
+			rc = 0;
+	}
+
+	/* SPNEGO OID not present or garbled -- bail out */
+	if (!rc) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
+		return 0;
+	}
+
+	/* SPNEGO */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
+		   || (tag != ASN1_EOC)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* negTokenInit */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
+		   || (tag != ASN1_SEQ)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* sequence */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
+		   || (tag != ASN1_EOC)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* sequence of */
+	if (asn1_header_decode
+	    (&ctx, &sequence_end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
+		   || (tag != ASN1_SEQ)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* list of security mechanisms */
+	while (!asn1_eoc_decode(&ctx, sequence_end)) {
+		rc = asn1_header_decode(&ctx, &end, &cls, &con, &tag);
+		if (!rc) {
+			ksmbd_debug(AUTH,
+				"Error decoding negTokenInit hdr exit2\n");
+			return 0;
+		}
+		if ((tag == ASN1_OJI) && (con == ASN1_PRI)) {
+			if (asn1_oid_decode(&ctx, end, &oid, &oidlen)) {
+				if (compare_oid(oid, oidlen, MSKRB5_OID,
+						MSKRB5_OID_LEN))
+					mech_type = KSMBD_AUTH_MSKRB5;
+				else if (compare_oid(oid, oidlen, KRB5U2U_OID,
+						     KRB5U2U_OID_LEN))
+					mech_type = KSMBD_AUTH_KRB5U2U;
+				else if (compare_oid(oid, oidlen, KRB5_OID,
+						     KRB5_OID_LEN))
+					mech_type = KSMBD_AUTH_KRB5;
+				else if (compare_oid(oid, oidlen, NTLMSSP_OID,
+						     NTLMSSP_OID_LEN))
+					mech_type = KSMBD_AUTH_NTLMSSP;
+				else {
+					kfree(oid);
+					continue;
+				}
+
+				conn->auth_mechs |= mech_type;
+				if (conn->preferred_auth_mech == 0)
+					conn->preferred_auth_mech = mech_type;
+				kfree(oid);
+			}
+		} else {
+			ksmbd_debug(AUTH,
+				"Should be an oid what is going on?\n");
+		}
+	}
+
+	/* sequence */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
+		   || (tag != ASN1_INT)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* sequence of */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding 2nd part of negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_UNI) || (con != ASN1_PRI)
+		   || (tag != ASN1_OTS)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	mechTokenlen = ctx.end - ctx.pointer;
+	conn->mechToken = kmalloc(mechTokenlen + 1, GFP_KERNEL);
+	if (!conn->mechToken) {
+		ksmbd_err("memory allocation error\n");
+		return 0;
+	}
+
+	memcpy(conn->mechToken, ctx.pointer, mechTokenlen);
+	conn->mechToken[mechTokenlen] = '\0';
+
+	return 1;
+}
+
+int
+ksmbd_decode_negTokenTarg(unsigned char *security_blob, int length,
+		    struct ksmbd_conn *conn)
+{
+	struct asn1_ctx ctx;
+	unsigned char *end;
+	unsigned int cls, con, tag, mechTokenlen;
+
+	ksmbd_debug(AUTH, "Received Auth SecBlob: length %d\n", length);
+
+	asn1_open(&ctx, security_blob, length);
+
+	/* GSSAPI header */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit header\n");
+		return 0;
+	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
+		   || (tag != ASN1_BOL)) {
+		ksmbd_debug(AUTH, "cls = %d con = %d tag = %d\n", cls, con,
+			tag);
+		return 0;
+	}
+
+	/* SPNEGO */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_UNI) || (con != ASN1_CON)
+		   || (tag != ASN1_SEQ)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 0\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* negTokenTarg */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_CTX) || (con != ASN1_CON)
+		   || (tag != ASN1_INT)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	/* negTokenTarg */
+	if (asn1_header_decode(&ctx, &end, &cls, &con, &tag) == 0) {
+		ksmbd_debug(AUTH, "Error decoding negTokenInit\n");
+		return 0;
+	} else if ((cls != ASN1_UNI) || (con != ASN1_PRI)
+		   || (tag != ASN1_OTS)) {
+		ksmbd_debug(AUTH,
+			"cls = %d con = %d tag = %d end = %p (%d) exit 1\n",
+			cls, con, tag, end, *end);
+		return 0;
+	}
+
+	mechTokenlen = ctx.end - ctx.pointer;
+	conn->mechToken = kmalloc(mechTokenlen + 1, GFP_KERNEL);
+	if (!conn->mechToken) {
+		ksmbd_err("memory allocation error\n");
+		return 0;
+	}
+
+	memcpy(conn->mechToken, ctx.pointer, mechTokenlen);
+	conn->mechToken[mechTokenlen] = '\0';
+
+	return 1;
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
+static void encode_asn_tag(char *buf,
+			   unsigned int *ofs,
+			   char tag,
+			   char seq,
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
+	if (!hdr_len)
+		buf[index++] = len;
+	else {
+		buf[index++] = 0x80 | hdr_len;
+		for (i = hdr_len - 1; i >= 0; i--)
+			buf[index++] = (len >> (i * 8)) & 0xFF;
+	}
+
+	/* insert seq */
+	len = len - (index - *ofs);
+	buf[index++] = seq;
+
+	if (!hdr_len)
+		buf[index++] = len;
+	else {
+		buf[index++] = 0x80 | hdr_len;
+		for (i = hdr_len - 1; i >= 0; i--)
+			buf[index++] = (len >> (i * 8)) & 0xFF;
+	}
+
+	*ofs += (index - *ofs);
+}
+
+int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
+		char *ntlm_blob, int ntlm_blob_len)
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
+		int neg_result)
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
diff --git a/fs/cifsd/asn1.h b/fs/cifsd/asn1.h
new file mode 100644
index 000000000000..ff2692b502d6
--- /dev/null
+++ b/fs/cifsd/asn1.h
@@ -0,0 +1,29 @@
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
+int ksmbd_decode_negTokenInit(unsigned char *security_blob,
+			      int length,
+			      struct ksmbd_conn *conn);
+
+int ksmbd_decode_negTokenTarg(unsigned char *security_blob,
+			      int length,
+			      struct ksmbd_conn *conn);
+
+int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer,
+				  u16 *buflen,
+				  char *ntlm_blob,
+				  int ntlm_blob_len);
+
+int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer,
+				   u16 *buflen,
+				   int neg_result);
+#endif /* __ASN1_H__ */
diff --git a/fs/cifsd/auth.c b/fs/cifsd/auth.c
new file mode 100644
index 000000000000..0a49c67a69d6
--- /dev/null
+++ b/fs/cifsd/auth.c
@@ -0,0 +1,1348 @@
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
+#include "buffer_pool.h"
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
+	str_to_key(key, key2);
+
+	if (fips_enabled) {
+		ksmbd_debug(AUTH,
+			"FIPS compliance enabled: DES not permitted\n");
+		return -ENOENT;
+	}
+
+	des_expand_key(&ctx, key2, DES_KEY_SIZE);
+	des_encrypt(&ctx, out, in);
+	memzero_explicit(&ctx, sizeof(ctx));
+	return 0;
+}
+
+static int ksmbd_enc_p24(unsigned char *p21,
+			 const unsigned char *c8,
+			 unsigned char *p24)
+{
+	int rc;
+
+	rc = smbhash(p24, c8, p21);
+	if (rc)
+		return rc;
+	rc = smbhash(p24 + 8, c8, p21 + 7);
+	if (rc)
+		return rc;
+	rc = smbhash(p24 + 16, c8, p21 + 14);
+	return rc;
+}
+
+/* produce a md4 message digest from data of length n bytes */
+static int ksmbd_enc_md4(unsigned char *md4_hash,
+			 unsigned char *link_str,
+			 int link_len)
+{
+	int rc;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_md4();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "Crypto md4 allocation error\n");
+		return -EINVAL;
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
+static int ksmbd_enc_update_sess_key(unsigned char *md5_hash,
+				     char *nonce,
+				     char *server_challenge,
+				     int len)
+{
+	int rc;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_md5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "Crypto md5 allocation error\n");
+		return -EINVAL;
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
+static int ksmbd_gen_sess_key(struct ksmbd_session *sess,
+			      char *hash,
+			      char *hmac)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc = -EINVAL;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx)
+		goto out;
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
+		ksmbd_debug(AUTH, "Could not update with response error %d\n",
+			rc);
+		goto out;
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACMD5(ctx), sess->sess_key);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n",
+			rc);
+		goto out;
+	}
+
+out:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
+
+static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
+	char *dname)
+{
+	int ret = -EINVAL, len;
+	wchar_t *domain = NULL;
+	__le16 *uniname = NULL;
+	struct ksmbd_crypto_ctx *ctx;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "can't generate ntlmv2 hash\n");
+		goto out;
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
+	if (len) {
+		len = smb_strtoUTF16(uniname, user_name(sess->user), len,
+			sess->conn->local_nls);
+		UniStrupr(uniname);
+	}
+
+	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
+				  (char *)uniname,
+				  UNICODE_LEN(len));
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
+	len = smb_strtoUTF16((__le16 *)domain, dname, len,
+			     sess->conn->local_nls);
+
+	ret = crypto_shash_update(CRYPTO_HMACMD5(ctx),
+				  (char *)domain,
+				  UNICODE_LEN(len));
+	if (ret) {
+		ksmbd_debug(AUTH, "Could not update with domain\n");
+		goto out;
+	}
+
+	ret = crypto_shash_final(CRYPTO_HMACMD5(ctx), ntlmv2_hash);
+out:
+	if (ret)
+		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
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
+		ksmbd_err("password processing failed\n");
+		return rc;
+	}
+
+	ksmbd_enc_md4(sess->sess_key,
+			user_passkey(sess->user),
+			CIFS_SMB1_SESSKEY_SIZE);
+	memcpy(sess->sess_key + CIFS_SMB1_SESSKEY_SIZE, key,
+		CIFS_AUTH_RESP_SIZE);
+	sess->sequence_number = 1;
+
+	if (strncmp(pw_buf, key, CIFS_AUTH_RESP_SIZE) != 0) {
+		ksmbd_debug(AUTH, "ntlmv1 authentication failed\n");
+		rc = -EINVAL;
+	} else
+		ksmbd_debug(AUTH, "ntlmv1 authentication pass\n");
+
+	return rc;
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
+int ksmbd_auth_ntlmv2(struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2,
+		      int blen,
+		      char *domain_name)
+{
+	char ntlmv2_hash[CIFS_ENCPWD_SIZE];
+	char ntlmv2_rsp[CIFS_HMAC_MD5_HASH_SIZE];
+	struct ksmbd_crypto_ctx *ctx;
+	char *construct = NULL;
+	int rc = -EINVAL, len;
+
+	ctx = ksmbd_crypto_ctx_find_hmacmd5();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
+		goto out;
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
+	memcpy(construct + CIFS_CRYPTO_KEY_SIZE,
+		(char *)(&ntlmv2->blob_signature), blen);
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
+	rc = memcmp(ntlmv2->ntlmv2_hash, ntlmv2_rsp, CIFS_HMAC_MD5_HASH_SIZE);
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
+static int __ksmbd_auth_ntlmv2(struct ksmbd_session *sess,
+			       char *client_nonce,
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
+		ksmbd_err("password processing failed\n");
+		goto out;
+	}
+
+	memset(p21, '\0', 21);
+	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
+	rc = ksmbd_enc_p24(p21, sess_key, key);
+	if (rc) {
+		ksmbd_err("password processing failed\n");
+		goto out;
+	}
+
+	rc = memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE);
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
+				   int blob_len,
+				   struct ksmbd_session *sess)
+{
+	char *domain_name;
+	unsigned int lm_off, nt_off;
+	unsigned short nt_len;
+	int ret;
+
+	if (blob_len < sizeof(struct authenticate_message)) {
+		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
+			blob_len);
+		return -EINVAL;
+	}
+
+	if (memcmp(authblob->Signature, "NTLMSSP", 8)) {
+		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
+				authblob->Signature);
+		return -EINVAL;
+	}
+
+	lm_off = le32_to_cpu(authblob->LmChallengeResponse.BufferOffset);
+	nt_off = le32_to_cpu(authblob->NtChallengeResponse.BufferOffset);
+	nt_len = le16_to_cpu(authblob->NtChallengeResponse.Length);
+
+	/* process NTLM authentication */
+	if (nt_len == CIFS_AUTH_RESP_SIZE) {
+		if (le32_to_cpu(authblob->NegotiateFlags)
+			& NTLMSSP_NEGOTIATE_EXTENDED_SEC)
+			return __ksmbd_auth_ntlmv2(sess, (char *)authblob +
+				lm_off, (char *)authblob + nt_off);
+		else
+			return ksmbd_auth_ntlm(sess, (char *)authblob +
+				nt_off);
+	}
+
+	/* TODO : use domain name that imported from configuration file */
+	domain_name = smb_strndup_from_utf16(
+			(const char *)authblob +
+			le32_to_cpu(authblob->DomainName.BufferOffset),
+			le16_to_cpu(authblob->DomainName.Length), true,
+			sess->conn->local_nls);
+	if (IS_ERR(domain_name))
+		return PTR_ERR(domain_name);
+
+	/* process NTLMv2 authentication */
+	ksmbd_debug(AUTH, "decode_ntlmssp_authenticate_blob dname%s\n",
+			domain_name);
+	ret = ksmbd_auth_ntlmv2(sess,
+			(struct ntlmv2_resp *)((char *)authblob + nt_off),
+			nt_len - CIFS_ENCPWD_SIZE,
+			domain_name);
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
+				  int blob_len,
+				  struct ksmbd_session *sess)
+{
+	if (blob_len < sizeof(struct negotiate_message)) {
+		ksmbd_debug(AUTH, "negotiate blob len %d too small\n",
+			blob_len);
+		return -EINVAL;
+	}
+
+	if (memcmp(negblob->Signature, "NTLMSSP", 8)) {
+		ksmbd_debug(AUTH, "blob signature incorrect %s\n",
+				negblob->Signature);
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
+		struct ksmbd_session *sess)
+{
+	struct target_info *tinfo;
+	wchar_t *name;
+	__u8 *target_name;
+	unsigned int len, flags, blob_off, blob_len, type, target_info_len = 0;
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
+			NTLMSSP_NEGOTIATE_56);
+	}
+
+	if (cflags & NTLMSSP_NEGOTIATE_ALWAYS_SIGN)
+		flags |= NTLMSSP_NEGOTIATE_ALWAYS_SIGN;
+
+	if (cflags & NTLMSSP_REQUEST_TARGET)
+		flags |= NTLMSSP_REQUEST_TARGET;
+
+	if (sess->conn->use_spnego &&
+		(cflags & NTLMSSP_NEGOTIATE_EXTENDED_SEC))
+		flags |= NTLMSSP_NEGOTIATE_EXTENDED_SEC;
+
+	chgblob->NegotiateFlags = cpu_to_le32(flags);
+	len = strlen(ksmbd_netbios_name());
+	name = kmalloc(2 + (len * 2), GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	len = smb_strtoUTF16((__le16 *)name, ksmbd_netbios_name(), len,
+			sess->conn->local_nls);
+	len = UNICODE_LEN(len);
+
+	blob_off = sizeof(struct challenge_message);
+	blob_len = blob_off + len;
+
+	chgblob->TargetName.Length = cpu_to_le16(len);
+	chgblob->TargetName.MaximumLength = cpu_to_le16(len);
+	chgblob->TargetName.BufferOffset = cpu_to_le32(blob_off);
+
+	/* Initialize random conn challenge */
+	get_random_bytes(sess->ntlmssp.cryptkey, sizeof(__u64));
+	memcpy(chgblob->Challenge, sess->ntlmssp.cryptkey,
+		CIFS_CRYPTO_KEY_SIZE);
+
+	/* Add Target Information to security buffer */
+	chgblob->TargetInfoArray.BufferOffset = cpu_to_le32(blob_len);
+
+	target_name = (__u8 *)chgblob + blob_off;
+	memcpy(target_name, name, len);
+	tinfo = (struct target_info *)(target_name + len);
+
+	chgblob->TargetInfoArray.Length = 0;
+	/* Add target info list for NetBIOS/DNS settings */
+	for (type = NTLMSSP_AV_NB_COMPUTER_NAME;
+		type <= NTLMSSP_AV_DNS_DOMAIN_NAME; type++) {
+		tinfo->Type = cpu_to_le16(type);
+		tinfo->Length = cpu_to_le16(len);
+		memcpy(tinfo->Content, name, len);
+		tinfo = (struct target_info *)((char *)tinfo + 4 + len);
+		target_info_len += 4 + len;
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
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess,
+			char *in_blob, int in_len,
+			char *out_blob, int *out_len)
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
+				*out_len, resp->spnego_blob_len);
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
+			resp->spnego_blob_len);
+	*out_len = resp->spnego_blob_len;
+	retval = 0;
+out:
+	ksmbd_free(resp);
+	return retval;
+}
+#else
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess,
+			char *in_blob, int in_len,
+			char *out_blob, int *out_len)
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
+int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn,
+			char *key,
+			struct kvec *iov,
+			int n_vec,
+			char *sig)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc = -EINVAL;
+	int i;
+
+	ctx = ksmbd_crypto_ctx_find_hmacsha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
+		goto out;
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
+int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn,
+			char *key,
+			struct kvec *iov,
+			int n_vec,
+			char *sig)
+{
+	struct ksmbd_crypto_ctx *ctx;
+	int rc = -EINVAL;
+	int i;
+
+	ctx = ksmbd_crypto_ctx_find_cmacaes();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc cmac rc %d\n", rc);
+		goto out;
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
+	struct kvec context, __u8 *key, unsigned int key_size)
+{
+	unsigned char zero = 0x0;
+	__u8 i[4] = {0, 0, 0, 1};
+	__u8 L[4] = {0, 0, 0, 128};
+	int rc = -EINVAL;
+	unsigned char prfhash[SMB2_HMACSHA256_SIZE];
+	unsigned char *hashptr = prfhash;
+	struct ksmbd_crypto_ctx *ctx;
+
+	memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
+	memset(key, 0x0, key_size);
+
+	ctx = ksmbd_crypto_ctx_find_hmacsha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not crypto alloc hmacmd5 rc %d\n", rc);
+		goto smb3signkey_ret;
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
+	rc = crypto_shash_update(CRYPTO_HMACSHA256(ctx), L, 4);
+	if (rc) {
+		ksmbd_debug(AUTH, "could not update with L\n");
+		goto smb3signkey_ret;
+	}
+
+	rc = crypto_shash_final(CRYPTO_HMACSHA256(ctx), hashptr);
+	if (rc) {
+		ksmbd_debug(AUTH, "Could not generate hmacmd5 hash error %d\n",
+			rc);
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
+				   const struct derivation *signing)
+{
+	int rc;
+	struct channel *chann;
+	char *key;
+
+	chann = lookup_chann_list(sess);
+	if (!chann)
+		return 0;
+
+	if (sess->conn->dialect >= SMB30_PROT_ID && signing->binding)
+		key = chann->smb3signingkey;
+	else
+		key = sess->smb3signingkey;
+
+	rc = generate_key(sess, signing->label, signing->context, key,
+		SMB3_SIGN_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	if (!(sess->conn->dialect >= SMB30_PROT_ID && signing->binding))
+		memcpy(chann->smb3signingkey, key, SMB3_SIGN_KEY_SIZE);
+
+	ksmbd_debug(AUTH, "dumping generated AES signing keys\n");
+	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
+	ksmbd_debug(AUTH, "Session Key   %*ph\n",
+			SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
+	ksmbd_debug(AUTH, "Signing Key   %*ph\n",
+			SMB3_SIGN_KEY_SIZE, key);
+	return rc;
+}
+
+int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess)
+{
+	struct derivation d;
+
+	d.label.iov_base = "SMB2AESCMAC";
+	d.label.iov_len = 12;
+	d.context.iov_base = "SmbSign";
+	d.context.iov_len = 8;
+	d.binding = false;
+
+	return generate_smb3signingkey(sess, &d);
+}
+
+int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess)
+{
+	struct derivation d;
+
+	d.label.iov_base = "SMBSigningKey";
+	d.label.iov_len = 14;
+	d.context.iov_base = sess->Preauth_HashValue;
+	d.context.iov_len = 64;
+	d.binding = false;
+
+	return generate_smb3signingkey(sess, &d);
+}
+
+struct derivation_twin {
+	struct derivation encryption;
+	struct derivation decryption;
+};
+
+static int generate_smb3encryptionkey(struct ksmbd_session *sess,
+	const struct derivation_twin *ptwin)
+{
+	int rc;
+
+	rc = generate_key(sess, ptwin->encryption.label,
+			ptwin->encryption.context, sess->smb3encryptionkey,
+			SMB3_SIGN_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	rc = generate_key(sess, ptwin->decryption.label,
+			ptwin->decryption.context,
+			sess->smb3decryptionkey, SMB3_SIGN_KEY_SIZE);
+	if (rc)
+		return rc;
+
+	ksmbd_debug(AUTH, "dumping generated AES encryption keys\n");
+	ksmbd_debug(AUTH, "Session Id    %llu\n", sess->id);
+	ksmbd_debug(AUTH, "Session Key   %*ph\n",
+			SMB2_NTLMV2_SESSKEY_SIZE, sess->sess_key);
+	ksmbd_debug(AUTH, "ServerIn Key  %*ph\n",
+			SMB3_SIGN_KEY_SIZE, sess->smb3encryptionkey);
+	ksmbd_debug(AUTH, "ServerOut Key %*ph\n",
+			SMB3_SIGN_KEY_SIZE, sess->smb3decryptionkey);
+	return rc;
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
+int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn,
+				     char *buf,
+				     __u8 *pi_hash)
+{
+	int rc = -1;
+	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
+	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
+	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
+	struct ksmbd_crypto_ctx *ctx = NULL;
+
+	if (conn->preauth_info->Preauth_HashId ==
+			SMB2_PREAUTH_INTEGRITY_SHA512) {
+		ctx = ksmbd_crypto_ctx_find_sha512();
+		if (!ctx) {
+			ksmbd_debug(AUTH, "could not alloc sha512 rc %d\n", rc);
+			goto out;
+		}
+	} else
+		goto out;
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
+		__u8 *pi_hash)
+{
+	int rc = -1;
+	struct ksmbd_crypto_ctx *ctx = NULL;
+
+	ctx = ksmbd_crypto_ctx_find_sha256();
+	if (!ctx) {
+		ksmbd_debug(AUTH, "could not alloc sha256 rc %d\n", rc);
+		goto out;
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
+static int ksmbd_get_encryption_key(struct ksmbd_conn *conn,
+				    __u64 ses_id,
+				    int enc,
+				    u8 *key)
+{
+	struct ksmbd_session *sess;
+	u8 *ses_enc_key;
+
+	sess = ksmbd_session_lookup(conn, ses_id);
+	if (!sess)
+		return 1;
+
+	ses_enc_key = enc ? sess->smb3encryptionkey :
+		sess->smb3decryptionkey;
+	memcpy(key, ses_enc_key, SMB3_SIGN_KEY_SIZE);
+
+	return 0;
+}
+
+static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
+		unsigned int buflen)
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
+static struct scatterlist *ksmbd_init_sg(struct kvec *iov,
+					 unsigned int nvec,
+					 u8 *sign)
+{
+	struct scatterlist *sg;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
+
+	for (i = 0; i < nvec - 1; i++) {
+		unsigned long kaddr = (unsigned long)iov[i + 1].iov_base;
+
+		if (is_vmalloc_addr(iov[i + 1].iov_base)) {
+			nr_entries[i] = ((kaddr + iov[i + 1].iov_len +
+					PAGE_SIZE - 1) >> PAGE_SHIFT) -
+				(kaddr >> PAGE_SHIFT);
+		} else
+			nr_entries[i]++;
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
+				if (len <= 0)
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
+
+	}
+	smb2_sg_set_buf(&sg[sg_idx], sign, SMB2_SIGNATURE_SIZE);
+	return sg;
+}
+
+int ksmbd_crypt_message(struct ksmbd_conn *conn,
+			struct kvec *iov,
+			unsigned int nvec,
+			int enc)
+{
+	struct smb2_transform_hdr *tr_hdr =
+		(struct smb2_transform_hdr *)iov[0].iov_base;
+	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 24;
+	int rc = 0;
+	struct scatterlist *sg;
+	u8 sign[SMB2_SIGNATURE_SIZE] = {};
+	u8 key[SMB3_SIGN_KEY_SIZE];
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
+		ksmbd_err("Could not get %scryption key\n", enc ? "en" : "de");
+		return 0;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM)
+		ctx = ksmbd_crypto_ctx_find_gcm();
+	else
+		ctx = ksmbd_crypto_ctx_find_ccm();
+	if (!ctx) {
+		ksmbd_err("crypto alloc failed\n");
+		return -EINVAL;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM)
+		tfm = CRYPTO_GCM(ctx);
+	else
+		tfm = CRYPTO_CCM(ctx);
+
+	rc = crypto_aead_setkey(tfm, key, SMB3_SIGN_KEY_SIZE);
+	if (rc) {
+		ksmbd_err("Failed to set aead key %d\n", rc);
+		goto free_ctx;
+	}
+
+	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
+	if (rc) {
+		ksmbd_err("Failed to set authsize %d\n", rc);
+		goto free_ctx;
+	}
+
+	req = aead_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ksmbd_err("Failed to alloc aead request\n");
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
+		ksmbd_err("Failed to init sg\n");
+		rc = -ENOMEM;
+		goto free_req;
+	}
+
+	iv_len = crypto_aead_ivsize(tfm);
+	iv = kzalloc(iv_len, GFP_KERNEL);
+	if (!iv) {
+		ksmbd_err("Failed to alloc IV\n");
+		rc = -ENOMEM;
+		goto free_sg;
+	}
+
+	if (conn->cipher_type == SMB2_ENCRYPTION_AES128_GCM)
+		memcpy(iv, (char *)tr_hdr->Nonce, SMB3_AES128GCM_NONCE);
+	else {
+		iv[0] = 3;
+		memcpy(iv + 1, (char *)tr_hdr->Nonce, SMB3_AES128CCM_NONCE);
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
+	if (!rc && enc)
+		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
+
+	kfree(iv);
+free_sg:
+	kfree(sg);
+free_req:
+	kfree(req);
+free_ctx:
+	ksmbd_release_crypto_ctx(ctx);
+	return rc;
+}
diff --git a/fs/cifsd/auth.h b/fs/cifsd/auth.h
new file mode 100644
index 000000000000..6fcfad5e7e1f
--- /dev/null
+++ b/fs/cifsd/auth.h
@@ -0,0 +1,90 @@
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
+int ksmbd_crypt_message(struct ksmbd_conn *conn,
+			struct kvec *iov,
+			unsigned int nvec,
+			int enc);
+
+void ksmbd_copy_gss_neg_header(void *buf);
+
+int ksmbd_auth_ntlm(struct ksmbd_session *sess,
+		    char *pw_buf);
+
+int ksmbd_auth_ntlmv2(struct ksmbd_session *sess,
+		      struct ntlmv2_resp *ntlmv2,
+		      int blen,
+		      char *domain_name);
+
+int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
+				   int blob_len,
+				   struct ksmbd_session *sess);
+
+int ksmbd_decode_ntlmssp_neg_blob(struct negotiate_message *negblob,
+				  int blob_len,
+				  struct ksmbd_session *sess);
+
+unsigned int
+ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
+		struct ksmbd_session *sess);
+
+int ksmbd_krb5_authenticate(struct ksmbd_session *sess,
+			char *in_blob, int in_len,
+			char *out_blob, int *out_len);
+
+int ksmbd_sign_smb2_pdu(struct ksmbd_conn *conn,
+			char *key,
+			struct kvec *iov,
+			int n_vec,
+			char *sig);
+int ksmbd_sign_smb3_pdu(struct ksmbd_conn *conn,
+			char *key,
+			struct kvec *iov,
+			int n_vec,
+			char *sig);
+
+int ksmbd_gen_smb30_signingkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb311_signingkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb30_encryptionkey(struct ksmbd_session *sess);
+int ksmbd_gen_smb311_encryptionkey(struct ksmbd_session *sess);
+
+int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn,
+				     char *buf,
+				     __u8 *pi_hash);
+int ksmbd_gen_sd_hash(struct ksmbd_conn *conn, char *sd_buf, int len,
+		__u8 *pi_hash);
+#endif
diff --git a/fs/cifsd/crypto_ctx.c b/fs/cifsd/crypto_ctx.c
new file mode 100644
index 000000000000..15d7e2f7c3d7
--- /dev/null
+++ b/fs/cifsd/crypto_ctx.c
@@ -0,0 +1,287 @@
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
+#include <linux/version.h>
+
+#include "glob.h"
+#include "crypto_ctx.h"
+#include "buffer_pool.h"
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
+	case CRYPTO_AEAD_AES128_GCM:
+		tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+		break;
+	case CRYPTO_AEAD_AES128_CCM:
+		tfm = crypto_alloc_aead("ccm(aes)", 0, 0);
+		break;
+	default:
+		ksmbd_err("Does not support encrypt ahead(id : %d)\n", id);
+		return NULL;
+	}
+
+	if (IS_ERR(tfm)) {
+		ksmbd_err("Failed to alloc encrypt aead : %ld\n", PTR_ERR(tfm));
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
+static struct ksmbd_crypto_ctx *ctx_alloc(void)
+{
+	return ksmbd_alloc(sizeof(struct ksmbd_crypto_ctx));
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
+	ksmbd_free(ctx);
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
+					  struct ksmbd_crypto_ctx,
+					  list);
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
+		ctx = ctx_alloc();
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
+	return ____crypto_aead_ctx_find(CRYPTO_AEAD_AES128_GCM);
+}
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void)
+{
+	return ____crypto_aead_ctx_find(CRYPTO_AEAD_AES128_CCM);
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
+	ctx = ctx_alloc();
+	if (!ctx)
+		return -ENOMEM;
+	list_add(&ctx->list, &ctx_list.idle_ctx);
+	return 0;
+}
diff --git a/fs/cifsd/crypto_ctx.h b/fs/cifsd/crypto_ctx.h
new file mode 100644
index 000000000000..64a11dfd6c83
--- /dev/null
+++ b/fs/cifsd/crypto_ctx.h
@@ -0,0 +1,77 @@
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
+	CRYPTO_AEAD_AES128_GCM = 16,
+	CRYPTO_AEAD_AES128_CCM,
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
+#define CRYPTO_GCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES128_GCM])
+#define CRYPTO_CCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES128_CCM])
+
+void ksmbd_release_crypto_ctx(struct ksmbd_crypto_ctx *ctx);
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacmd5(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacsha256(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha256(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void);
+
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void);
+struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void);
+
+void ksmbd_crypto_destroy(void);
+int ksmbd_crypto_create(void);
+
+#endif /* __CRYPTO_CTX_H__ */
diff --git a/fs/cifsd/mgmt/ksmbd_ida.c b/fs/cifsd/mgmt/ksmbd_ida.c
new file mode 100644
index 000000000000..cbc9fd049852
--- /dev/null
+++ b/fs/cifsd/mgmt/ksmbd_ida.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include "ksmbd_ida.h"
+
+struct ksmbd_ida *ksmbd_ida_alloc(void)
+{
+	struct ksmbd_ida *ida;
+
+	ida = kmalloc(sizeof(struct ksmbd_ida), GFP_KERNEL);
+	if (!ida)
+		return NULL;
+
+	ida_init(&ida->map);
+	return ida;
+}
+
+void ksmbd_ida_free(struct ksmbd_ida *ida)
+{
+	if (!ida)
+		return;
+
+	ida_destroy(&ida->map);
+	kfree(ida);
+}
+
+static inline int __acquire_id(struct ksmbd_ida *ida, int from, int to)
+{
+	return ida_simple_get(&ida->map, from, to, GFP_KERNEL);
+}
+
+int ksmbd_acquire_smb2_tid(struct ksmbd_ida *ida)
+{
+	int id;
+
+	do {
+		id = __acquire_id(ida, 0, 0);
+	} while (id == 0xFFFF);
+
+	return id;
+}
+
+int ksmbd_acquire_smb2_uid(struct ksmbd_ida *ida)
+{
+	int id;
+
+	do {
+		id = __acquire_id(ida, 1, 0);
+	} while (id == 0xFFFE);
+
+	return id;
+}
+
+int ksmbd_acquire_async_msg_id(struct ksmbd_ida *ida)
+{
+	return __acquire_id(ida, 1, 0);
+}
+
+int ksmbd_acquire_id(struct ksmbd_ida *ida)
+{
+	return __acquire_id(ida, 0, 0);
+}
+
+void ksmbd_release_id(struct ksmbd_ida *ida, int id)
+{
+	ida_simple_remove(&ida->map, id);
+}
diff --git a/fs/cifsd/mgmt/ksmbd_ida.h b/fs/cifsd/mgmt/ksmbd_ida.h
new file mode 100644
index 000000000000..b075156adf23
--- /dev/null
+++ b/fs/cifsd/mgmt/ksmbd_ida.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_IDA_MANAGEMENT_H__
+#define __KSMBD_IDA_MANAGEMENT_H__
+
+#include <linux/slab.h>
+#include <linux/idr.h>
+
+struct ksmbd_ida {
+	struct ida	map;
+};
+
+struct ksmbd_ida *ksmbd_ida_alloc(void);
+void ksmbd_ida_free(struct ksmbd_ida *ida);
+
+/*
+ * 2.2.1.6.7 TID Generation
+ *    The value 0xFFFF MUST NOT be used as a valid TID. All other
+ *    possible values for TID, including zero (0x0000), are valid.
+ *    The value 0xFFFF is used to specify all TIDs or no TID,
+ *    depending upon the context in which it is used.
+ */
+int ksmbd_acquire_smb2_tid(struct ksmbd_ida *ida);
+
+/*
+ * 2.2.1.6.8 UID Generation
+ *    The value 0xFFFE was declared reserved in the LAN Manager 1.0
+ *    documentation, so a value of 0xFFFE SHOULD NOT be used as a
+ *    valid UID.<21> All other possible values for a UID, excluding
+ *    zero (0x0000), are valid.
+ */
+int ksmbd_acquire_smb2_uid(struct ksmbd_ida *ida);
+int ksmbd_acquire_async_msg_id(struct ksmbd_ida *ida);
+
+int ksmbd_acquire_id(struct ksmbd_ida *ida);
+
+void ksmbd_release_id(struct ksmbd_ida *ida, int id);
+#endif /* __KSMBD_IDA_MANAGEMENT_H__ */
diff --git a/fs/cifsd/mgmt/share_config.c b/fs/cifsd/mgmt/share_config.c
new file mode 100644
index 000000000000..9bc7f7555ee2
--- /dev/null
+++ b/fs/cifsd/mgmt/share_config.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/jhash.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+#include <linux/parser.h>
+#include <linux/namei.h>
+#include <linux/sched.h>
+
+#include "share_config.h"
+#include "user_config.h"
+#include "user_session.h"
+#include "../buffer_pool.h"
+#include "../transport_ipc.h"
+
+#define SHARE_HASH_BITS		3
+static DEFINE_HASHTABLE(shares_table, SHARE_HASH_BITS);
+static DECLARE_RWSEM(shares_table_lock);
+
+struct ksmbd_veto_pattern {
+	char			*pattern;
+	struct list_head	list;
+};
+
+static unsigned int share_name_hash(char *name)
+{
+	return jhash(name, strlen(name), 0);
+}
+
+static void kill_share(struct ksmbd_share_config *share)
+{
+	while (!list_empty(&share->veto_list)) {
+		struct ksmbd_veto_pattern *p;
+
+		p = list_entry(share->veto_list.next,
+			       struct ksmbd_veto_pattern,
+			       list);
+		list_del(&p->list);
+		kfree(p->pattern);
+		kfree(p);
+	}
+
+	if (share->path)
+		path_put(&share->vfs_path);
+	kfree(share->name);
+	kfree(share->path);
+	kfree(share);
+}
+
+void __ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	down_write(&shares_table_lock);
+	hash_del(&share->hlist);
+	up_write(&shares_table_lock);
+
+	kill_share(share);
+}
+
+static struct ksmbd_share_config *
+__get_share_config(struct ksmbd_share_config *share)
+{
+	if (!atomic_inc_not_zero(&share->refcount))
+		return NULL;
+	return share;
+}
+
+static struct ksmbd_share_config *__share_lookup(char *name)
+{
+	struct ksmbd_share_config *share;
+	unsigned int key = share_name_hash(name);
+
+	hash_for_each_possible(shares_table, share, hlist, key) {
+		if (!strcmp(name, share->name))
+			return share;
+	}
+	return NULL;
+}
+
+static int parse_veto_list(struct ksmbd_share_config *share,
+			   char *veto_list,
+			   int veto_list_sz)
+{
+	int sz = 0;
+
+	if (!veto_list_sz)
+		return 0;
+
+	while (veto_list_sz > 0) {
+		struct ksmbd_veto_pattern *p;
+
+		p = ksmbd_alloc(sizeof(struct ksmbd_veto_pattern));
+		if (!p)
+			return -ENOMEM;
+
+		sz = strlen(veto_list);
+		if (!sz)
+			break;
+
+		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		if (!p->pattern) {
+			ksmbd_free(p);
+			return -ENOMEM;
+		}
+
+		list_add(&p->list, &share->veto_list);
+
+		veto_list += sz + 1;
+		veto_list_sz -= (sz + 1);
+	}
+
+	return 0;
+}
+
+static struct ksmbd_share_config *share_config_request(char *name)
+{
+	struct ksmbd_share_config_response *resp;
+	struct ksmbd_share_config *share = NULL;
+	struct ksmbd_share_config *lookup;
+	int ret;
+
+	resp = ksmbd_ipc_share_config_request(name);
+	if (!resp)
+		return NULL;
+
+	if (resp->flags == KSMBD_SHARE_FLAG_INVALID)
+		goto out;
+
+	share = ksmbd_alloc(sizeof(struct ksmbd_share_config));
+	if (!share)
+		goto out;
+
+	share->flags = resp->flags;
+	atomic_set(&share->refcount, 1);
+	INIT_LIST_HEAD(&share->veto_list);
+	share->name = kstrdup(name, GFP_KERNEL);
+
+	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		share->path = kstrdup(KSMBD_SHARE_CONFIG_PATH(resp),
+				      GFP_KERNEL);
+		if (share->path)
+			share->path_sz = strlen(share->path);
+		share->create_mask = resp->create_mask;
+		share->directory_mask = resp->directory_mask;
+		share->force_create_mode = resp->force_create_mode;
+		share->force_directory_mode = resp->force_directory_mode;
+		share->force_uid = resp->force_uid;
+		share->force_gid = resp->force_gid;
+		ret = parse_veto_list(share,
+				      KSMBD_SHARE_CONFIG_VETO_LIST(resp),
+				      resp->veto_list_sz);
+		if (!ret && share->path) {
+			ret = kern_path(share->path, 0, &share->vfs_path);
+			if (ret) {
+				ksmbd_debug(SMB, "failed to access '%s'\n",
+					share->path);
+				/* Avoid put_path() */
+				kfree(share->path);
+				share->path = NULL;
+			}
+		}
+		if (ret || !share->name) {
+			kill_share(share);
+			share = NULL;
+			goto out;
+		}
+	}
+
+	down_write(&shares_table_lock);
+	lookup = __share_lookup(name);
+	if (lookup)
+		lookup = __get_share_config(lookup);
+	if (!lookup) {
+		hash_add(shares_table, &share->hlist, share_name_hash(name));
+	} else {
+		kill_share(share);
+		share = lookup;
+	}
+	up_write(&shares_table_lock);
+
+out:
+	ksmbd_free(resp);
+	return share;
+}
+
+static void strtolower(char *share_name)
+{
+	while (*share_name) {
+		*share_name = tolower(*share_name);
+		share_name++;
+	}
+}
+
+struct ksmbd_share_config *ksmbd_share_config_get(char *name)
+{
+	struct ksmbd_share_config *share;
+
+	strtolower(name);
+
+	down_read(&shares_table_lock);
+	share = __share_lookup(name);
+	if (share)
+		share = __get_share_config(share);
+	up_read(&shares_table_lock);
+
+	if (share)
+		return share;
+	return share_config_request(name);
+}
+
+bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
+			       const char *filename)
+{
+	struct ksmbd_veto_pattern *p;
+
+	list_for_each_entry(p, &share->veto_list, list) {
+		if (match_wildcard(p->pattern, filename))
+			return true;
+	}
+	return false;
+}
+
+void ksmbd_share_configs_cleanup(void)
+{
+	struct ksmbd_share_config *share;
+	struct hlist_node *tmp;
+	int i;
+
+	down_write(&shares_table_lock);
+	hash_for_each_safe(shares_table, i, tmp, share, hlist) {
+		hash_del(&share->hlist);
+		kill_share(share);
+	}
+	up_write(&shares_table_lock);
+}
diff --git a/fs/cifsd/mgmt/share_config.h b/fs/cifsd/mgmt/share_config.h
new file mode 100644
index 000000000000..49ca89667991
--- /dev/null
+++ b/fs/cifsd/mgmt/share_config.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __SHARE_CONFIG_MANAGEMENT_H__
+#define __SHARE_CONFIG_MANAGEMENT_H__
+
+#include <linux/workqueue.h>
+#include <linux/hashtable.h>
+#include <linux/path.h>
+
+struct ksmbd_share_config {
+	char			*name;
+	char			*path;
+
+	unsigned int		path_sz;
+	unsigned int		flags;
+	struct list_head	veto_list;
+
+	struct path		vfs_path;
+
+	atomic_t		refcount;
+	struct hlist_node	hlist;
+	unsigned short		create_mask;
+	unsigned short		directory_mask;
+	unsigned short		force_create_mode;
+	unsigned short		force_directory_mode;
+	unsigned short		force_uid;
+	unsigned short		force_gid;
+};
+
+#define KSMBD_SHARE_INVALID_UID	((__u16)-1)
+#define KSMBD_SHARE_INVALID_GID	((__u16)-1)
+
+static inline int share_config_create_mode(struct ksmbd_share_config *share,
+	umode_t posix_mode)
+{
+	if (!share->force_create_mode) {
+		if (!posix_mode)
+			return share->create_mask;
+		else
+			return posix_mode & share->create_mask;
+	}
+	return share->force_create_mode & share->create_mask;
+}
+
+static inline int share_config_directory_mode(struct ksmbd_share_config *share,
+	umode_t posix_mode)
+{
+	if (!share->force_directory_mode) {
+		if (!posix_mode)
+			return share->directory_mask;
+		else
+			return posix_mode & share->directory_mask;
+	}
+
+	return share->force_directory_mode & share->directory_mask;
+}
+
+static inline int test_share_config_flag(struct ksmbd_share_config *share,
+					 int flag)
+{
+	return share->flags & flag;
+}
+
+extern void __ksmbd_share_config_put(struct ksmbd_share_config *share);
+
+static inline void ksmbd_share_config_put(struct ksmbd_share_config *share)
+{
+	if (!atomic_dec_and_test(&share->refcount))
+		return;
+	__ksmbd_share_config_put(share);
+}
+
+struct ksmbd_share_config *ksmbd_share_config_get(char *name);
+bool ksmbd_share_veto_filename(struct ksmbd_share_config *share,
+			       const char *filename);
+void ksmbd_share_configs_cleanup(void);
+
+#endif /* __SHARE_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/cifsd/mgmt/tree_connect.c b/fs/cifsd/mgmt/tree_connect.c
new file mode 100644
index 000000000000..d5670f2596a3
--- /dev/null
+++ b/fs/cifsd/mgmt/tree_connect.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "../buffer_pool.h"
+#include "../transport_ipc.h"
+#include "../connection.h"
+
+#include "tree_connect.h"
+#include "user_config.h"
+#include "share_config.h"
+#include "user_session.h"
+
+struct ksmbd_tree_conn_status
+ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name)
+{
+	struct ksmbd_tree_conn_status status = {-EINVAL, NULL};
+	struct ksmbd_tree_connect_response *resp = NULL;
+	struct ksmbd_share_config *sc;
+	struct ksmbd_tree_connect *tree_conn = NULL;
+	struct sockaddr *peer_addr;
+
+	sc = ksmbd_share_config_get(share_name);
+	if (!sc)
+		return status;
+
+	tree_conn = ksmbd_alloc(sizeof(struct ksmbd_tree_connect));
+	if (!tree_conn) {
+		status.ret = -ENOMEM;
+		goto out_error;
+	}
+
+	tree_conn->id = ksmbd_acquire_tree_conn_id(sess);
+	if (tree_conn->id < 0) {
+		status.ret = -EINVAL;
+		goto out_error;
+	}
+
+	peer_addr = KSMBD_TCP_PEER_SOCKADDR(sess->conn);
+	resp = ksmbd_ipc_tree_connect_request(sess,
+					      sc,
+					      tree_conn,
+					      peer_addr);
+	if (!resp) {
+		status.ret = -EINVAL;
+		goto out_error;
+	}
+
+	status.ret = resp->status;
+	if (status.ret != KSMBD_TREE_CONN_STATUS_OK)
+		goto out_error;
+
+	tree_conn->flags = resp->connection_flags;
+	tree_conn->user = sess->user;
+	tree_conn->share_conf = sc;
+	status.tree_conn = tree_conn;
+
+	list_add(&tree_conn->list, &sess->tree_conn_list);
+
+	ksmbd_free(resp);
+	return status;
+
+out_error:
+	if (tree_conn)
+		ksmbd_release_tree_conn_id(sess, tree_conn->id);
+	ksmbd_share_config_put(sc);
+	ksmbd_free(tree_conn);
+	ksmbd_free(resp);
+	return status;
+}
+
+int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
+			       struct ksmbd_tree_connect *tree_conn)
+{
+	int ret;
+
+	ret = ksmbd_ipc_tree_disconnect_request(sess->id, tree_conn->id);
+	ksmbd_release_tree_conn_id(sess, tree_conn->id);
+	list_del(&tree_conn->list);
+	ksmbd_share_config_put(tree_conn->share_conf);
+	ksmbd_free(tree_conn);
+	return ret;
+}
+
+struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
+						  unsigned int id)
+{
+	struct ksmbd_tree_connect *tree_conn;
+	struct list_head *tmp;
+
+	list_for_each(tmp, &sess->tree_conn_list) {
+		tree_conn = list_entry(tmp, struct ksmbd_tree_connect, list);
+		if (tree_conn->id == id)
+			return tree_conn;
+	}
+	return NULL;
+}
+
+struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
+						 unsigned int id)
+{
+	struct ksmbd_tree_connect *tc;
+
+	tc = ksmbd_tree_conn_lookup(sess, id);
+	if (tc)
+		return tc->share_conf;
+	return NULL;
+}
+
+int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess)
+{
+	int ret = 0;
+
+	while (!list_empty(&sess->tree_conn_list)) {
+		struct ksmbd_tree_connect *tc;
+
+		tc = list_entry(sess->tree_conn_list.next,
+				struct ksmbd_tree_connect,
+				list);
+		ret |= ksmbd_tree_conn_disconnect(sess, tc);
+	}
+
+	return ret;
+}
diff --git a/fs/cifsd/mgmt/tree_connect.h b/fs/cifsd/mgmt/tree_connect.h
new file mode 100644
index 000000000000..4e40ec3f4774
--- /dev/null
+++ b/fs/cifsd/mgmt/tree_connect.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __TREE_CONNECT_MANAGEMENT_H__
+#define __TREE_CONNECT_MANAGEMENT_H__
+
+#include <linux/hashtable.h>
+
+#include "../ksmbd_server.h"
+
+struct ksmbd_share_config;
+struct ksmbd_user;
+
+struct ksmbd_tree_connect {
+	int				id;
+
+	unsigned int			flags;
+	struct ksmbd_share_config	*share_conf;
+	struct ksmbd_user		*user;
+
+	struct list_head		list;
+
+	int				maximal_access;
+	bool				posix_extensions;
+};
+
+struct ksmbd_tree_conn_status {
+	unsigned int			ret;
+	struct ksmbd_tree_connect	*tree_conn;
+};
+
+static inline int test_tree_conn_flag(struct ksmbd_tree_connect *tree_conn,
+				      int flag)
+{
+	return tree_conn->flags & flag;
+}
+
+struct ksmbd_session;
+
+struct ksmbd_tree_conn_status
+ksmbd_tree_conn_connect(struct ksmbd_session *sess, char *share_name);
+
+int ksmbd_tree_conn_disconnect(struct ksmbd_session *sess,
+			       struct ksmbd_tree_connect *tree_conn);
+
+struct ksmbd_tree_connect *ksmbd_tree_conn_lookup(struct ksmbd_session *sess,
+						  unsigned int id);
+
+struct ksmbd_share_config *ksmbd_tree_conn_share(struct ksmbd_session *sess,
+						 unsigned int id);
+
+int ksmbd_tree_conn_session_logoff(struct ksmbd_session *sess);
+
+#endif /* __TREE_CONNECT_MANAGEMENT_H__ */
diff --git a/fs/cifsd/mgmt/user_config.c b/fs/cifsd/mgmt/user_config.c
new file mode 100644
index 000000000000..a1a454bfb57b
--- /dev/null
+++ b/fs/cifsd/mgmt/user_config.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+
+#include "user_config.h"
+#include "../buffer_pool.h"
+#include "../transport_ipc.h"
+
+struct ksmbd_user *ksmbd_login_user(const char *account)
+{
+	struct ksmbd_login_response *resp;
+	struct ksmbd_user *user = NULL;
+
+	resp = ksmbd_ipc_login_request(account);
+	if (!resp)
+		return NULL;
+
+	if (!(resp->status & KSMBD_USER_FLAG_OK))
+		goto out;
+
+	user = ksmbd_alloc_user(resp);
+out:
+	ksmbd_free(resp);
+	return user;
+}
+
+struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp)
+{
+	struct ksmbd_user *user = NULL;
+
+	user = ksmbd_alloc(sizeof(struct ksmbd_user));
+	if (!user)
+		return NULL;
+
+	user->name = kstrdup(resp->account, GFP_KERNEL);
+	user->flags = resp->status;
+	user->gid = resp->gid;
+	user->uid = resp->uid;
+	user->passkey_sz = resp->hash_sz;
+	user->passkey = ksmbd_alloc(resp->hash_sz);
+	if (user->passkey)
+		memcpy(user->passkey, resp->hash, resp->hash_sz);
+
+	if (!user->name || !user->passkey) {
+		kfree(user->name);
+		ksmbd_free(user->passkey);
+		ksmbd_free(user);
+		user = NULL;
+	}
+	return user;
+}
+
+void ksmbd_free_user(struct ksmbd_user *user)
+{
+	ksmbd_ipc_logout_request(user->name);
+	kfree(user->name);
+	ksmbd_free(user->passkey);
+	ksmbd_free(user);
+}
+
+int ksmbd_anonymous_user(struct ksmbd_user *user)
+{
+	if (user->name[0] == '\0')
+		return 1;
+	return 0;
+}
diff --git a/fs/cifsd/mgmt/user_config.h b/fs/cifsd/mgmt/user_config.h
new file mode 100644
index 000000000000..b2bb074a0150
--- /dev/null
+++ b/fs/cifsd/mgmt/user_config.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __USER_CONFIG_MANAGEMENT_H__
+#define __USER_CONFIG_MANAGEMENT_H__
+
+#include "../glob.h"
+
+struct ksmbd_user {
+	unsigned short		flags;
+
+	unsigned int		uid;
+	unsigned int		gid;
+
+	char			*name;
+
+	size_t			passkey_sz;
+	char			*passkey;
+};
+
+static inline bool user_guest(struct ksmbd_user *user)
+{
+	return user->flags & KSMBD_USER_FLAG_GUEST_ACCOUNT;
+}
+
+static inline void set_user_flag(struct ksmbd_user *user, int flag)
+{
+	user->flags |= flag;
+}
+
+static inline int test_user_flag(struct ksmbd_user *user, int flag)
+{
+	return user->flags & flag;
+}
+
+static inline void set_user_guest(struct ksmbd_user *user)
+{
+}
+
+static inline char *user_passkey(struct ksmbd_user *user)
+{
+	return user->passkey;
+}
+
+static inline char *user_name(struct ksmbd_user *user)
+{
+	return user->name;
+}
+
+static inline unsigned int user_uid(struct ksmbd_user *user)
+{
+	return user->uid;
+}
+
+static inline unsigned int user_gid(struct ksmbd_user *user)
+{
+	return user->gid;
+}
+
+struct ksmbd_user *ksmbd_login_user(const char *account);
+struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp);
+void ksmbd_free_user(struct ksmbd_user *user);
+int ksmbd_anonymous_user(struct ksmbd_user *user);
+#endif /* __USER_CONFIG_MANAGEMENT_H__ */
diff --git a/fs/cifsd/mgmt/user_session.c b/fs/cifsd/mgmt/user_session.c
new file mode 100644
index 000000000000..afcdf76a3851
--- /dev/null
+++ b/fs/cifsd/mgmt/user_session.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/rwsem.h>
+
+#include "ksmbd_ida.h"
+#include "user_session.h"
+#include "user_config.h"
+#include "tree_connect.h"
+#include "../transport_ipc.h"
+#include "../connection.h"
+#include "../buffer_pool.h"
+#include "../vfs_cache.h"
+
+static struct ksmbd_ida *session_ida;
+
+#define SESSION_HASH_BITS		3
+static DEFINE_HASHTABLE(sessions_table, SESSION_HASH_BITS);
+static DECLARE_RWSEM(sessions_table_lock);
+
+struct ksmbd_session_rpc {
+	int			id;
+	unsigned int		method;
+	struct list_head	list;
+};
+
+static void free_channel_list(struct ksmbd_session *sess)
+{
+	struct channel *chann;
+	struct list_head *tmp, *t;
+
+	list_for_each_safe(tmp, t, &sess->ksmbd_chann_list) {
+		chann = list_entry(tmp, struct channel, chann_list);
+		if (chann) {
+			list_del(&chann->chann_list);
+			kfree(chann);
+		}
+	}
+}
+
+static void __session_rpc_close(struct ksmbd_session *sess,
+				struct ksmbd_session_rpc *entry)
+{
+	struct ksmbd_rpc_command *resp;
+
+	resp = ksmbd_rpc_close(sess, entry->id);
+	if (!resp)
+		pr_err("Unable to close RPC pipe %d\n", entry->id);
+
+	ksmbd_free(resp);
+	ksmbd_rpc_id_free(entry->id);
+	ksmbd_free(entry);
+}
+
+static void ksmbd_session_rpc_clear_list(struct ksmbd_session *sess)
+{
+	struct ksmbd_session_rpc *entry;
+
+	while (!list_empty(&sess->rpc_handle_list)) {
+		entry = list_entry(sess->rpc_handle_list.next,
+				   struct ksmbd_session_rpc,
+				   list);
+
+		list_del(&entry->list);
+		__session_rpc_close(sess, entry);
+	}
+}
+
+static int __rpc_method(char *rpc_name)
+{
+	if (!strcmp(rpc_name, "\\srvsvc") || !strcmp(rpc_name, "srvsvc"))
+		return KSMBD_RPC_SRVSVC_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "\\wkssvc") || !strcmp(rpc_name, "wkssvc"))
+		return KSMBD_RPC_WKSSVC_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "LANMAN") || !strcmp(rpc_name, "lanman"))
+		return KSMBD_RPC_RAP_METHOD;
+
+	if (!strcmp(rpc_name, "\\samr") || !strcmp(rpc_name, "samr"))
+		return KSMBD_RPC_SAMR_METHOD_INVOKE;
+
+	if (!strcmp(rpc_name, "\\lsarpc") || !strcmp(rpc_name, "lsarpc"))
+		return KSMBD_RPC_LSARPC_METHOD_INVOKE;
+
+	ksmbd_err("Unsupported RPC: %s\n", rpc_name);
+	return 0;
+}
+
+int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
+{
+	struct ksmbd_session_rpc *entry;
+	struct ksmbd_rpc_command *resp;
+	int method;
+
+	method = __rpc_method(rpc_name);
+	if (!method)
+		return -EINVAL;
+
+	entry = ksmbd_alloc(sizeof(struct ksmbd_session_rpc));
+	if (!entry)
+		return -EINVAL;
+
+	list_add(&entry->list, &sess->rpc_handle_list);
+	entry->method = method;
+	entry->id = ksmbd_ipc_id_alloc();
+	if (entry->id < 0)
+		goto error;
+
+	resp = ksmbd_rpc_open(sess, entry->id);
+	if (!resp)
+		goto error;
+
+	ksmbd_free(resp);
+	return entry->id;
+error:
+	list_del(&entry->list);
+	ksmbd_free(entry);
+	return -EINVAL;
+}
+
+void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
+{
+	struct ksmbd_session_rpc *entry;
+
+	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
+		if (entry->id == id) {
+			list_del(&entry->list);
+			__session_rpc_close(sess, entry);
+			break;
+		}
+	}
+}
+
+int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
+{
+	struct ksmbd_session_rpc *entry;
+
+	list_for_each_entry(entry, &sess->rpc_handle_list, list) {
+		if (entry->id == id)
+			return entry->method;
+	}
+	return 0;
+}
+
+void ksmbd_session_destroy(struct ksmbd_session *sess)
+{
+	if (!sess)
+		return;
+
+	if (!atomic_dec_and_test(&sess->refcnt))
+		return;
+
+	list_del(&sess->sessions_entry);
+
+	if (IS_SMB2(sess->conn)) {
+		down_write(&sessions_table_lock);
+		hash_del(&sess->hlist);
+		up_write(&sessions_table_lock);
+	}
+
+	if (sess->user)
+		ksmbd_free_user(sess->user);
+
+	ksmbd_tree_conn_session_logoff(sess);
+	ksmbd_destroy_file_table(&sess->file_table);
+	ksmbd_session_rpc_clear_list(sess);
+	free_channel_list(sess);
+	kfree(sess->Preauth_HashValue);
+	ksmbd_release_id(session_ida, sess->id);
+
+	ksmbd_ida_free(sess->tree_conn_ida);
+	ksmbd_free(sess);
+}
+
+static struct ksmbd_session *__session_lookup(unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	hash_for_each_possible(sessions_table, sess, hlist, id) {
+		if (id == sess->id)
+			return sess;
+	}
+	return NULL;
+}
+
+void ksmbd_session_register(struct ksmbd_conn *conn,
+			    struct ksmbd_session *sess)
+{
+	sess->conn = conn;
+	list_add(&sess->sessions_entry, &conn->sessions);
+}
+
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn)
+{
+	struct ksmbd_session *sess;
+
+	while (!list_empty(&conn->sessions)) {
+		sess = list_entry(conn->sessions.next,
+				  struct ksmbd_session,
+				  sessions_entry);
+
+		ksmbd_session_destroy(sess);
+	}
+}
+
+bool ksmbd_session_id_match(struct ksmbd_session *sess, unsigned long long id)
+{
+	return sess->id == id;
+}
+
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id)
+{
+	struct ksmbd_session *sess = NULL;
+
+	list_for_each_entry(sess, &conn->sessions, sessions_entry) {
+		if (ksmbd_session_id_match(sess, id))
+			return sess;
+	}
+	return NULL;
+}
+
+int get_session(struct ksmbd_session *sess)
+{
+	return atomic_inc_not_zero(&sess->refcnt);
+}
+
+void put_session(struct ksmbd_session *sess)
+{
+	if (atomic_dec_and_test(&sess->refcnt))
+		ksmbd_err("get/%s seems to be mismatched.", __func__);
+}
+
+struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id)
+{
+	struct ksmbd_session *sess;
+
+	down_read(&sessions_table_lock);
+	sess = __session_lookup(id);
+	if (sess) {
+		if (!get_session(sess))
+			sess = NULL;
+	}
+	up_read(&sessions_table_lock);
+
+	return sess;
+}
+
+static int __init_smb2_session(struct ksmbd_session *sess)
+{
+	int id = ksmbd_acquire_smb2_uid(session_ida);
+
+	if (id < 0)
+		return -EINVAL;
+	sess->id = id;
+	return 0;
+}
+
+static struct ksmbd_session *__session_create(int protocol)
+{
+	struct ksmbd_session *sess;
+	int ret;
+
+	sess = ksmbd_alloc(sizeof(struct ksmbd_session));
+	if (!sess)
+		return NULL;
+
+	if (ksmbd_init_file_table(&sess->file_table))
+		goto error;
+
+	set_session_flag(sess, protocol);
+	INIT_LIST_HEAD(&sess->sessions_entry);
+	INIT_LIST_HEAD(&sess->tree_conn_list);
+	INIT_LIST_HEAD(&sess->ksmbd_chann_list);
+	INIT_LIST_HEAD(&sess->rpc_handle_list);
+	sess->sequence_number = 1;
+	atomic_set(&sess->refcnt, 1);
+
+	switch (protocol) {
+	case CIFDS_SESSION_FLAG_SMB2:
+		ret = __init_smb2_session(sess);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto error;
+
+	sess->tree_conn_ida = ksmbd_ida_alloc();
+	if (!sess->tree_conn_ida)
+		goto error;
+
+	if (protocol == CIFDS_SESSION_FLAG_SMB2) {
+		down_read(&sessions_table_lock);
+		hash_add(sessions_table, &sess->hlist, sess->id);
+		up_read(&sessions_table_lock);
+	}
+	return sess;
+
+error:
+	ksmbd_session_destroy(sess);
+	return NULL;
+}
+
+struct ksmbd_session *ksmbd_smb2_session_create(void)
+{
+	return __session_create(CIFDS_SESSION_FLAG_SMB2);
+}
+
+int ksmbd_acquire_tree_conn_id(struct ksmbd_session *sess)
+{
+	int id = -EINVAL;
+
+	if (test_session_flag(sess, CIFDS_SESSION_FLAG_SMB2))
+		id = ksmbd_acquire_smb2_tid(sess->tree_conn_ida);
+
+	return id;
+}
+
+void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id)
+{
+	if (id >= 0)
+		ksmbd_release_id(sess->tree_conn_ida, id);
+}
+
+int ksmbd_init_session_table(void)
+{
+	session_ida = ksmbd_ida_alloc();
+	if (!session_ida)
+		return -ENOMEM;
+	return 0;
+}
+
+void ksmbd_free_session_table(void)
+{
+	ksmbd_ida_free(session_ida);
+}
diff --git a/fs/cifsd/mgmt/user_session.h b/fs/cifsd/mgmt/user_session.h
new file mode 100644
index 000000000000..0a6eb21647ab
--- /dev/null
+++ b/fs/cifsd/mgmt/user_session.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __USER_SESSION_MANAGEMENT_H__
+#define __USER_SESSION_MANAGEMENT_H__
+
+#include <linux/hashtable.h>
+
+#include "../smb_common.h"
+#include "../ntlmssp.h"
+
+#define CIFDS_SESSION_FLAG_SMB2		(1 << 1)
+
+#define PREAUTH_HASHVALUE_SIZE		64
+
+struct ksmbd_ida;
+struct ksmbd_file_table;
+
+struct channel {
+	__u8			smb3signingkey[SMB3_SIGN_KEY_SIZE];
+	struct ksmbd_conn	*conn;
+	struct list_head	chann_list;
+};
+
+struct preauth_session {
+	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
+	uint64_t		sess_id;
+	struct list_head	list_entry;
+};
+
+struct ksmbd_session {
+	uint64_t			id;
+
+	struct ksmbd_user		*user;
+	struct ksmbd_conn		*conn;
+	unsigned int			sequence_number;
+	unsigned int			flags;
+
+	bool				sign;
+	bool				enc;
+	bool				is_anonymous;
+
+	int				state;
+	__u8				*Preauth_HashValue;
+
+	struct ntlmssp_auth		ntlmssp;
+	char				sess_key[CIFS_KEY_SIZE];
+
+	struct hlist_node		hlist;
+	struct list_head		ksmbd_chann_list;
+	struct list_head		tree_conn_list;
+	struct ksmbd_ida		*tree_conn_ida;
+	struct list_head		rpc_handle_list;
+
+	__u8				smb3encryptionkey[SMB3_SIGN_KEY_SIZE];
+	__u8				smb3decryptionkey[SMB3_SIGN_KEY_SIZE];
+	__u8				smb3signingkey[SMB3_SIGN_KEY_SIZE];
+
+	struct list_head		sessions_entry;
+	struct ksmbd_file_table		file_table;
+	atomic_t			refcnt;
+};
+
+static inline int test_session_flag(struct ksmbd_session *sess, int bit)
+{
+	return sess->flags & bit;
+}
+
+static inline void set_session_flag(struct ksmbd_session *sess, int bit)
+{
+	sess->flags |= bit;
+}
+
+static inline void clear_session_flag(struct ksmbd_session *sess, int bit)
+{
+	sess->flags &= ~bit;
+}
+
+struct ksmbd_session *ksmbd_smb2_session_create(void);
+
+void ksmbd_session_destroy(struct ksmbd_session *sess);
+
+bool ksmbd_session_id_match(struct ksmbd_session *sess, unsigned long long id);
+struct ksmbd_session *ksmbd_session_lookup_slowpath(unsigned long long id);
+struct ksmbd_session *ksmbd_session_lookup(struct ksmbd_conn *conn,
+					   unsigned long long id);
+void ksmbd_session_register(struct ksmbd_conn *conn,
+			    struct ksmbd_session *sess);
+void ksmbd_sessions_deregister(struct ksmbd_conn *conn);
+
+int ksmbd_acquire_tree_conn_id(struct ksmbd_session *sess);
+void ksmbd_release_tree_conn_id(struct ksmbd_session *sess, int id);
+
+int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name);
+void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id);
+int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id);
+int get_session(struct ksmbd_session *sess);
+void put_session(struct ksmbd_session *sess);
+
+int ksmbd_init_session_table(void);
+void ksmbd_free_session_table(void);
+
+#endif /* __USER_SESSION_MANAGEMENT_H__ */
diff --git a/fs/cifsd/misc.c b/fs/cifsd/misc.c
new file mode 100644
index 000000000000..189b90414976
--- /dev/null
+++ b/fs/cifsd/misc.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/version.h>
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
+		(ch <= 0x1f ||
+		 ch == '?' || ch == '"' || ch == '<' ||
+		 ch == '>' || ch == '|' || ch == '*'))
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
+			ksmbd_err("Stream name validation failed: %c\n", c);
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
+				stream_type);
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
+	*conv_len = smbConvertToUTF16((__le16 *)conv,
+					d_info->name,
+					d_info->name_len,
+					local_nls,
+					0);
+	*conv_len *= 2;
+
+	/* We allocate buffer twice bigger than needed. */
+	conv[*conv_len] = 0x00;
+	conv[*conv_len + 1] = 0x00;
+	return conv;
+}
diff --git a/fs/cifsd/misc.h b/fs/cifsd/misc.h
new file mode 100644
index 000000000000..73b21709b6c9
--- /dev/null
+++ b/fs/cifsd/misc.h
@@ -0,0 +1,38 @@
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
+
+int ksmbd_validate_filename(char *filename);
+
+int parse_stream_name(char *filename, char **stream_name, int *s_type);
+
+char *convert_to_nt_pathname(char *filename, char *sharepath);
+
+int get_nlink(struct kstat *st);
+
+void ksmbd_conv_path_to_unix(char *path);
+void ksmbd_strip_last_slash(char *path);
+void ksmbd_conv_path_to_windows(char *path);
+
+char *ksmbd_extract_sharename(char *treename);
+
+char *convert_to_unix_name(struct ksmbd_share_config *share, char *name);
+
+#define KSMBD_DIR_INFO_ALIGNMENT	8
+
+struct ksmbd_dir_info;
+char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
+				  const struct nls_table *local_nls,
+				  int *conv_len);
+#endif /* __KSMBD_MISC_H__ */
diff --git a/fs/cifsd/ndr.c b/fs/cifsd/ndr.c
new file mode 100644
index 000000000000..aa0cb8fc555d
--- /dev/null
+++ b/fs/cifsd/ndr.c
@@ -0,0 +1,344 @@
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
+#define PAYLOAD_HEAD(d) ((d)->data + (d)->offset)
+
+#define KSMBD_ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
+
+#define KSMBD_ALIGN(x, a)							\
+	({									\
+		typeof(x) ret = (x);						\
+		if (((x) & ((typeof(x))(a) - 1)) != 0)				\
+			ret = KSMBD_ALIGN_MASK(x, (typeof(x))(a) - 1);		\
+		ret;								\
+	})
+
+static void align_offset(struct ndr *ndr, int n)
+{
+	ndr->offset = KSMBD_ALIGN(ndr->offset, n);
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
+	*(__le16 *)PAYLOAD_HEAD(n) = cpu_to_le16(value);
+	n->offset += sizeof(value);
+}
+
+static void ndr_write_int32(struct ndr *n, __u32 value)
+{
+	if (n->length <= n->offset + sizeof(value))
+		try_to_realloc_ndr_blob(n, sizeof(value));
+
+	*(__le32 *)PAYLOAD_HEAD(n) = cpu_to_le32(value);
+	n->offset += sizeof(value);
+}
+
+static void ndr_write_int64(struct ndr *n, __u64 value)
+{
+	if (n->length <= n->offset + sizeof(value))
+		try_to_realloc_ndr_blob(n, sizeof(value));
+
+	*(__le64 *)PAYLOAD_HEAD(n) = cpu_to_le64(value);
+	n->offset += sizeof(value);
+}
+
+static int ndr_write_bytes(struct ndr *n, void *value, size_t sz)
+{
+	if (n->length <= n->offset + sz)
+		try_to_realloc_ndr_blob(n, sz);
+
+	memcpy(PAYLOAD_HEAD(n), value, sz);
+	n->offset += sz;
+	return 0;
+}
+
+static int ndr_write_string(struct ndr *n, void *value, size_t sz)
+{
+	if (n->length <= n->offset + sz)
+		try_to_realloc_ndr_blob(n, sz);
+
+	strncpy(PAYLOAD_HEAD(n), value, sz);
+	sz++;
+	n->offset += sz;
+	align_offset(n, 2);
+	return 0;
+}
+
+static int ndr_read_string(struct ndr *n, void *value, size_t sz)
+{
+	int len = strnlen(PAYLOAD_HEAD(n), sz);
+
+	memcpy(value, PAYLOAD_HEAD(n), len);
+	len++;
+	n->offset += len;
+	align_offset(n, 2);
+	return 0;
+}
+
+static int ndr_read_bytes(struct ndr *n, void *value, size_t sz)
+{
+	memcpy(value, PAYLOAD_HEAD(n), sz);
+	n->offset += sz;
+	return 0;
+}
+
+static __u16 ndr_read_int16(struct ndr *n)
+{
+	__u16 ret;
+
+	ret = le16_to_cpu(*(__le16 *)PAYLOAD_HEAD(n));
+	n->offset += sizeof(__u16);
+	return ret;
+}
+
+static __u32 ndr_read_int32(struct ndr *n)
+{
+	__u32 ret;
+
+	ret = le32_to_cpu(*(__le32 *)PAYLOAD_HEAD(n));
+	n->offset += sizeof(__u32);
+	return ret;
+}
+
+static __u64 ndr_read_int64(struct ndr *n)
+{
+	__u64 ret;
+
+	ret = le64_to_cpu(*(__le64 *)PAYLOAD_HEAD(n));
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
+	} else
+		ndr_write_int64(n, da->itime);
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
+		ksmbd_err("v%d version is not supported\n", da->version);
+		return -EINVAL;
+	}
+
+	version2 = ndr_read_int32(n);
+	if (da->version != version2) {
+		ksmbd_err("ndr version mismatched(version: %d, version2: %d)\n",
+				da->version, version2);
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
+	align_offset(n, 8);
+	ndr_write_int32(n, acl->count);
+	ndr_write_int32(n, 0);
+
+	for (i = 0; i < acl->count; i++) {
+		align_offset(n, 8);
+		ndr_write_int16(n, acl->entries[i].type);
+		ndr_write_int16(n, acl->entries[i].type);
+
+		if (acl->entries[i].type == SMB_ACL_USER) {
+			align_offset(n, 8);
+			ndr_write_int64(n, acl->entries[i].uid);
+		} else if (acl->entries[i].type == SMB_ACL_GROUP) {
+			align_offset(n, 8);
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
+int ndr_encode_posix_acl(struct ndr *n, struct inode *inode,
+		struct xattr_smb_acl *acl, struct xattr_smb_acl *def_acl)
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
+	} else
+		ndr_write_int32(n, 0);
+
+	if (def_acl) {
+		/* DEFAULT ACL ACCESS */
+		ndr_write_int32(n, ref_id);
+		ref_id += 4;
+	} else
+		ndr_write_int32(n, 0);
+
+	ndr_write_int64(n, from_kuid(&init_user_ns, inode->i_uid));
+	ndr_write_int64(n, from_kgid(&init_user_ns, inode->i_gid));
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
+		ksmbd_err("v%d version is not supported\n", acl->version);
+		return -EINVAL;
+	}
+
+	version2 = ndr_read_int32(n);
+	if (acl->version != version2) {
+		ksmbd_err("ndr version mismatched(version: %d, version2: %d)\n",
+				acl->version, version2);
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
+		ksmbd_err("Invalid acl description : %s\n", acl->desc);
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
diff --git a/fs/cifsd/ndr.h b/fs/cifsd/ndr.h
new file mode 100644
index 000000000000..a9db968b78ac
--- /dev/null
+++ b/fs/cifsd/ndr.h
@@ -0,0 +1,21 @@
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
+int ndr_encode_posix_acl(struct ndr *n, struct inode *inode,
+		struct xattr_smb_acl *acl, struct xattr_smb_acl *def_acl);
+int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl);
+int ndr_encode_v3_ntacl(struct ndr *n, struct xattr_ntacl *acl);
+int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl);
diff --git a/fs/cifsd/netmisc.c b/fs/cifsd/netmisc.c
new file mode 100644
index 000000000000..6f7dd78348a3
--- /dev/null
+++ b/fs/cifsd/netmisc.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   fs/ksmbd/netmisc.c
+ *
+ *   Copyright (c) International Business Machines  Corp., 2002,2008
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ *   Error mapping routines from Samba libsmb/errormap.c
+ *   Copyright (C) Andrew Tridgell 2001
+ */
+
+#include "glob.h"
+#include "smberr.h"
+#include "nterr.h"
+#include "time_wrappers.h"
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
diff --git a/fs/cifsd/nterr.c b/fs/cifsd/nterr.c
new file mode 100644
index 000000000000..358a766375b4
--- /dev/null
+++ b/fs/cifsd/nterr.c
@@ -0,0 +1,674 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Unix SMB/Netbios implementation.
+ *  Version 1.9.
+ *  RPC Pipe client / server routines
+ *  Copyright (C) Luke Kenneth Casson Leighton 1997-2001.
+ */
+
+/* NT error codes - see nterr.h */
+#include <linux/types.h>
+#include <linux/fs.h>
+#include "nterr.h"
+
+const struct nt_err_code_struct nt_errs[] = {
+	{"NT_STATUS_OK", NT_STATUS_OK},
+	{"NT_STATUS_UNSUCCESSFUL", NT_STATUS_UNSUCCESSFUL},
+	{"NT_STATUS_NOT_IMPLEMENTED", NT_STATUS_NOT_IMPLEMENTED},
+	{"NT_STATUS_INVALID_INFO_CLASS", NT_STATUS_INVALID_INFO_CLASS},
+	{"NT_STATUS_INFO_LENGTH_MISMATCH", NT_STATUS_INFO_LENGTH_MISMATCH},
+	{"NT_STATUS_ACCESS_VIOLATION", NT_STATUS_ACCESS_VIOLATION},
+	{"NT_STATUS_BUFFER_OVERFLOW", NT_STATUS_BUFFER_OVERFLOW},
+	{"NT_STATUS_IN_PAGE_ERROR", NT_STATUS_IN_PAGE_ERROR},
+	{"NT_STATUS_PAGEFILE_QUOTA", NT_STATUS_PAGEFILE_QUOTA},
+	{"NT_STATUS_INVALID_HANDLE", NT_STATUS_INVALID_HANDLE},
+	{"NT_STATUS_BAD_INITIAL_STACK", NT_STATUS_BAD_INITIAL_STACK},
+	{"NT_STATUS_BAD_INITIAL_PC", NT_STATUS_BAD_INITIAL_PC},
+	{"NT_STATUS_INVALID_CID", NT_STATUS_INVALID_CID},
+	{"NT_STATUS_TIMER_NOT_CANCELED", NT_STATUS_TIMER_NOT_CANCELED},
+	{"NT_STATUS_INVALID_PARAMETER", NT_STATUS_INVALID_PARAMETER},
+	{"NT_STATUS_NO_SUCH_DEVICE", NT_STATUS_NO_SUCH_DEVICE},
+	{"NT_STATUS_NO_SUCH_FILE", NT_STATUS_NO_SUCH_FILE},
+	{"NT_STATUS_INVALID_DEVICE_REQUEST",
+	 NT_STATUS_INVALID_DEVICE_REQUEST},
+	{"NT_STATUS_END_OF_FILE", NT_STATUS_END_OF_FILE},
+	{"NT_STATUS_WRONG_VOLUME", NT_STATUS_WRONG_VOLUME},
+	{"NT_STATUS_NO_MEDIA_IN_DEVICE", NT_STATUS_NO_MEDIA_IN_DEVICE},
+	{"NT_STATUS_UNRECOGNIZED_MEDIA", NT_STATUS_UNRECOGNIZED_MEDIA},
+	{"NT_STATUS_NONEXISTENT_SECTOR", NT_STATUS_NONEXISTENT_SECTOR},
+	{"NT_STATUS_MORE_PROCESSING_REQUIRED",
+	 NT_STATUS_MORE_PROCESSING_REQUIRED},
+	{"NT_STATUS_NO_MEMORY", NT_STATUS_NO_MEMORY},
+	{"NT_STATUS_CONFLICTING_ADDRESSES",
+	 NT_STATUS_CONFLICTING_ADDRESSES},
+	{"NT_STATUS_NOT_MAPPED_VIEW", NT_STATUS_NOT_MAPPED_VIEW},
+	{"NT_STATUS_UNABLE_TO_FREE_VM", NT_STATUS_UNABLE_TO_FREE_VM},
+	{"NT_STATUS_UNABLE_TO_DELETE_SECTION",
+	 NT_STATUS_UNABLE_TO_DELETE_SECTION},
+	{"NT_STATUS_INVALID_SYSTEM_SERVICE",
+	 NT_STATUS_INVALID_SYSTEM_SERVICE},
+	{"NT_STATUS_ILLEGAL_INSTRUCTION", NT_STATUS_ILLEGAL_INSTRUCTION},
+	{"NT_STATUS_INVALID_LOCK_SEQUENCE",
+	 NT_STATUS_INVALID_LOCK_SEQUENCE},
+	{"NT_STATUS_INVALID_VIEW_SIZE", NT_STATUS_INVALID_VIEW_SIZE},
+	{"NT_STATUS_INVALID_FILE_FOR_SECTION",
+	 NT_STATUS_INVALID_FILE_FOR_SECTION},
+	{"NT_STATUS_ALREADY_COMMITTED", NT_STATUS_ALREADY_COMMITTED},
+	{"NT_STATUS_ACCESS_DENIED", NT_STATUS_ACCESS_DENIED},
+	{"NT_STATUS_BUFFER_TOO_SMALL", NT_STATUS_BUFFER_TOO_SMALL},
+	{"NT_STATUS_OBJECT_TYPE_MISMATCH", NT_STATUS_OBJECT_TYPE_MISMATCH},
+	{"NT_STATUS_NONCONTINUABLE_EXCEPTION",
+	 NT_STATUS_NONCONTINUABLE_EXCEPTION},
+	{"NT_STATUS_INVALID_DISPOSITION", NT_STATUS_INVALID_DISPOSITION},
+	{"NT_STATUS_UNWIND", NT_STATUS_UNWIND},
+	{"NT_STATUS_BAD_STACK", NT_STATUS_BAD_STACK},
+	{"NT_STATUS_INVALID_UNWIND_TARGET",
+	 NT_STATUS_INVALID_UNWIND_TARGET},
+	{"NT_STATUS_NOT_LOCKED", NT_STATUS_NOT_LOCKED},
+	{"NT_STATUS_PARITY_ERROR", NT_STATUS_PARITY_ERROR},
+	{"NT_STATUS_UNABLE_TO_DECOMMIT_VM",
+	 NT_STATUS_UNABLE_TO_DECOMMIT_VM},
+	{"NT_STATUS_NOT_COMMITTED", NT_STATUS_NOT_COMMITTED},
+	{"NT_STATUS_INVALID_PORT_ATTRIBUTES",
+	 NT_STATUS_INVALID_PORT_ATTRIBUTES},
+	{"NT_STATUS_PORT_MESSAGE_TOO_LONG",
+	 NT_STATUS_PORT_MESSAGE_TOO_LONG},
+	{"NT_STATUS_INVALID_PARAMETER_MIX",
+	 NT_STATUS_INVALID_PARAMETER_MIX},
+	{"NT_STATUS_INVALID_QUOTA_LOWER", NT_STATUS_INVALID_QUOTA_LOWER},
+	{"NT_STATUS_DISK_CORRUPT_ERROR", NT_STATUS_DISK_CORRUPT_ERROR},
+	{"NT_STATUS_OBJECT_NAME_INVALID", NT_STATUS_OBJECT_NAME_INVALID},
+	{"NT_STATUS_OBJECT_NAME_NOT_FOUND",
+	 NT_STATUS_OBJECT_NAME_NOT_FOUND},
+	{"NT_STATUS_OBJECT_NAME_COLLISION",
+	 NT_STATUS_OBJECT_NAME_COLLISION},
+	{"NT_STATUS_HANDLE_NOT_WAITABLE", NT_STATUS_HANDLE_NOT_WAITABLE},
+	{"NT_STATUS_PORT_DISCONNECTED", NT_STATUS_PORT_DISCONNECTED},
+	{"NT_STATUS_DEVICE_ALREADY_ATTACHED",
+	 NT_STATUS_DEVICE_ALREADY_ATTACHED},
+	{"NT_STATUS_OBJECT_PATH_INVALID", NT_STATUS_OBJECT_PATH_INVALID},
+	{"NT_STATUS_OBJECT_PATH_NOT_FOUND",
+	 NT_STATUS_OBJECT_PATH_NOT_FOUND},
+	{"NT_STATUS_OBJECT_PATH_SYNTAX_BAD",
+	 NT_STATUS_OBJECT_PATH_SYNTAX_BAD},
+	{"NT_STATUS_DATA_OVERRUN", NT_STATUS_DATA_OVERRUN},
+	{"NT_STATUS_DATA_LATE_ERROR", NT_STATUS_DATA_LATE_ERROR},
+	{"NT_STATUS_DATA_ERROR", NT_STATUS_DATA_ERROR},
+	{"NT_STATUS_CRC_ERROR", NT_STATUS_CRC_ERROR},
+	{"NT_STATUS_SECTION_TOO_BIG", NT_STATUS_SECTION_TOO_BIG},
+	{"NT_STATUS_PORT_CONNECTION_REFUSED",
+	 NT_STATUS_PORT_CONNECTION_REFUSED},
+	{"NT_STATUS_INVALID_PORT_HANDLE", NT_STATUS_INVALID_PORT_HANDLE},
+	{"NT_STATUS_SHARING_VIOLATION", NT_STATUS_SHARING_VIOLATION},
+	{"NT_STATUS_QUOTA_EXCEEDED", NT_STATUS_QUOTA_EXCEEDED},
+	{"NT_STATUS_INVALID_PAGE_PROTECTION",
+	 NT_STATUS_INVALID_PAGE_PROTECTION},
+	{"NT_STATUS_MUTANT_NOT_OWNED", NT_STATUS_MUTANT_NOT_OWNED},
+	{"NT_STATUS_SEMAPHORE_LIMIT_EXCEEDED",
+	 NT_STATUS_SEMAPHORE_LIMIT_EXCEEDED},
+	{"NT_STATUS_PORT_ALREADY_SET", NT_STATUS_PORT_ALREADY_SET},
+	{"NT_STATUS_SECTION_NOT_IMAGE", NT_STATUS_SECTION_NOT_IMAGE},
+	{"NT_STATUS_SUSPEND_COUNT_EXCEEDED",
+	 NT_STATUS_SUSPEND_COUNT_EXCEEDED},
+	{"NT_STATUS_THREAD_IS_TERMINATING",
+	 NT_STATUS_THREAD_IS_TERMINATING},
+	{"NT_STATUS_BAD_WORKING_SET_LIMIT",
+	 NT_STATUS_BAD_WORKING_SET_LIMIT},
+	{"NT_STATUS_INCOMPATIBLE_FILE_MAP",
+	 NT_STATUS_INCOMPATIBLE_FILE_MAP},
+	{"NT_STATUS_SECTION_PROTECTION", NT_STATUS_SECTION_PROTECTION},
+	{"NT_STATUS_EAS_NOT_SUPPORTED", NT_STATUS_EAS_NOT_SUPPORTED},
+	{"NT_STATUS_EA_TOO_LARGE", NT_STATUS_EA_TOO_LARGE},
+	{"NT_STATUS_NONEXISTENT_EA_ENTRY", NT_STATUS_NONEXISTENT_EA_ENTRY},
+	{"NT_STATUS_NO_EAS_ON_FILE", NT_STATUS_NO_EAS_ON_FILE},
+	{"NT_STATUS_EA_CORRUPT_ERROR", NT_STATUS_EA_CORRUPT_ERROR},
+	{"NT_STATUS_FILE_LOCK_CONFLICT", NT_STATUS_FILE_LOCK_CONFLICT},
+	{"NT_STATUS_LOCK_NOT_GRANTED", NT_STATUS_LOCK_NOT_GRANTED},
+	{"NT_STATUS_DELETE_PENDING", NT_STATUS_DELETE_PENDING},
+	{"NT_STATUS_CTL_FILE_NOT_SUPPORTED",
+	 NT_STATUS_CTL_FILE_NOT_SUPPORTED},
+	{"NT_STATUS_UNKNOWN_REVISION", NT_STATUS_UNKNOWN_REVISION},
+	{"NT_STATUS_REVISION_MISMATCH", NT_STATUS_REVISION_MISMATCH},
+	{"NT_STATUS_INVALID_OWNER", NT_STATUS_INVALID_OWNER},
+	{"NT_STATUS_INVALID_PRIMARY_GROUP",
+	 NT_STATUS_INVALID_PRIMARY_GROUP},
+	{"NT_STATUS_NO_IMPERSONATION_TOKEN",
+	 NT_STATUS_NO_IMPERSONATION_TOKEN},
+	{"NT_STATUS_CANT_DISABLE_MANDATORY",
+	 NT_STATUS_CANT_DISABLE_MANDATORY},
+	{"NT_STATUS_NO_LOGON_SERVERS", NT_STATUS_NO_LOGON_SERVERS},
+	{"NT_STATUS_NO_SUCH_LOGON_SESSION",
+	 NT_STATUS_NO_SUCH_LOGON_SESSION},
+	{"NT_STATUS_NO_SUCH_PRIVILEGE", NT_STATUS_NO_SUCH_PRIVILEGE},
+	{"NT_STATUS_PRIVILEGE_NOT_HELD", NT_STATUS_PRIVILEGE_NOT_HELD},
+	{"NT_STATUS_INVALID_ACCOUNT_NAME", NT_STATUS_INVALID_ACCOUNT_NAME},
+	{"NT_STATUS_USER_EXISTS", NT_STATUS_USER_EXISTS},
+	{"NT_STATUS_NO_SUCH_USER", NT_STATUS_NO_SUCH_USER},
+	{"NT_STATUS_GROUP_EXISTS", NT_STATUS_GROUP_EXISTS},
+	{"NT_STATUS_NO_SUCH_GROUP", NT_STATUS_NO_SUCH_GROUP},
+	{"NT_STATUS_MEMBER_IN_GROUP", NT_STATUS_MEMBER_IN_GROUP},
+	{"NT_STATUS_MEMBER_NOT_IN_GROUP", NT_STATUS_MEMBER_NOT_IN_GROUP},
+	{"NT_STATUS_LAST_ADMIN", NT_STATUS_LAST_ADMIN},
+	{"NT_STATUS_WRONG_PASSWORD", NT_STATUS_WRONG_PASSWORD},
+	{"NT_STATUS_ILL_FORMED_PASSWORD", NT_STATUS_ILL_FORMED_PASSWORD},
+	{"NT_STATUS_PASSWORD_RESTRICTION", NT_STATUS_PASSWORD_RESTRICTION},
+	{"NT_STATUS_LOGON_FAILURE", NT_STATUS_LOGON_FAILURE},
+	{"NT_STATUS_ACCOUNT_RESTRICTION", NT_STATUS_ACCOUNT_RESTRICTION},
+	{"NT_STATUS_INVALID_LOGON_HOURS", NT_STATUS_INVALID_LOGON_HOURS},
+	{"NT_STATUS_INVALID_WORKSTATION", NT_STATUS_INVALID_WORKSTATION},
+	{"NT_STATUS_PASSWORD_EXPIRED", NT_STATUS_PASSWORD_EXPIRED},
+	{"NT_STATUS_ACCOUNT_DISABLED", NT_STATUS_ACCOUNT_DISABLED},
+	{"NT_STATUS_NONE_MAPPED", NT_STATUS_NONE_MAPPED},
+	{"NT_STATUS_TOO_MANY_LUIDS_REQUESTED",
+	 NT_STATUS_TOO_MANY_LUIDS_REQUESTED},
+	{"NT_STATUS_LUIDS_EXHAUSTED", NT_STATUS_LUIDS_EXHAUSTED},
+	{"NT_STATUS_INVALID_SUB_AUTHORITY",
+	 NT_STATUS_INVALID_SUB_AUTHORITY},
+	{"NT_STATUS_INVALID_ACL", NT_STATUS_INVALID_ACL},
+	{"NT_STATUS_INVALID_SID", NT_STATUS_INVALID_SID},
+	{"NT_STATUS_INVALID_SECURITY_DESCR",
+	 NT_STATUS_INVALID_SECURITY_DESCR},
+	{"NT_STATUS_PROCEDURE_NOT_FOUND", NT_STATUS_PROCEDURE_NOT_FOUND},
+	{"NT_STATUS_INVALID_IMAGE_FORMAT", NT_STATUS_INVALID_IMAGE_FORMAT},
+	{"NT_STATUS_NO_TOKEN", NT_STATUS_NO_TOKEN},
+	{"NT_STATUS_BAD_INHERITANCE_ACL", NT_STATUS_BAD_INHERITANCE_ACL},
+	{"NT_STATUS_RANGE_NOT_LOCKED", NT_STATUS_RANGE_NOT_LOCKED},
+	{"NT_STATUS_DISK_FULL", NT_STATUS_DISK_FULL},
+	{"NT_STATUS_SERVER_DISABLED", NT_STATUS_SERVER_DISABLED},
+	{"NT_STATUS_SERVER_NOT_DISABLED", NT_STATUS_SERVER_NOT_DISABLED},
+	{"NT_STATUS_TOO_MANY_GUIDS_REQUESTED",
+	 NT_STATUS_TOO_MANY_GUIDS_REQUESTED},
+	{"NT_STATUS_GUIDS_EXHAUSTED", NT_STATUS_GUIDS_EXHAUSTED},
+	{"NT_STATUS_INVALID_ID_AUTHORITY", NT_STATUS_INVALID_ID_AUTHORITY},
+	{"NT_STATUS_AGENTS_EXHAUSTED", NT_STATUS_AGENTS_EXHAUSTED},
+	{"NT_STATUS_INVALID_VOLUME_LABEL", NT_STATUS_INVALID_VOLUME_LABEL},
+	{"NT_STATUS_SECTION_NOT_EXTENDED", NT_STATUS_SECTION_NOT_EXTENDED},
+	{"NT_STATUS_NOT_MAPPED_DATA", NT_STATUS_NOT_MAPPED_DATA},
+	{"NT_STATUS_RESOURCE_DATA_NOT_FOUND",
+	 NT_STATUS_RESOURCE_DATA_NOT_FOUND},
+	{"NT_STATUS_RESOURCE_TYPE_NOT_FOUND",
+	 NT_STATUS_RESOURCE_TYPE_NOT_FOUND},
+	{"NT_STATUS_RESOURCE_NAME_NOT_FOUND",
+	 NT_STATUS_RESOURCE_NAME_NOT_FOUND},
+	{"NT_STATUS_ARRAY_BOUNDS_EXCEEDED",
+	 NT_STATUS_ARRAY_BOUNDS_EXCEEDED},
+	{"NT_STATUS_FLOAT_DENORMAL_OPERAND",
+	 NT_STATUS_FLOAT_DENORMAL_OPERAND},
+	{"NT_STATUS_FLOAT_DIVIDE_BY_ZERO", NT_STATUS_FLOAT_DIVIDE_BY_ZERO},
+	{"NT_STATUS_FLOAT_INEXACT_RESULT", NT_STATUS_FLOAT_INEXACT_RESULT},
+	{"NT_STATUS_FLOAT_INVALID_OPERATION",
+	 NT_STATUS_FLOAT_INVALID_OPERATION},
+	{"NT_STATUS_FLOAT_OVERFLOW", NT_STATUS_FLOAT_OVERFLOW},
+	{"NT_STATUS_FLOAT_STACK_CHECK", NT_STATUS_FLOAT_STACK_CHECK},
+	{"NT_STATUS_FLOAT_UNDERFLOW", NT_STATUS_FLOAT_UNDERFLOW},
+	{"NT_STATUS_INTEGER_DIVIDE_BY_ZERO",
+	 NT_STATUS_INTEGER_DIVIDE_BY_ZERO},
+	{"NT_STATUS_INTEGER_OVERFLOW", NT_STATUS_INTEGER_OVERFLOW},
+	{"NT_STATUS_PRIVILEGED_INSTRUCTION",
+	 NT_STATUS_PRIVILEGED_INSTRUCTION},
+	{"NT_STATUS_TOO_MANY_PAGING_FILES",
+	 NT_STATUS_TOO_MANY_PAGING_FILES},
+	{"NT_STATUS_FILE_INVALID", NT_STATUS_FILE_INVALID},
+	{"NT_STATUS_ALLOTTED_SPACE_EXCEEDED",
+	 NT_STATUS_ALLOTTED_SPACE_EXCEEDED},
+	{"NT_STATUS_INSUFFICIENT_RESOURCES",
+	 NT_STATUS_INSUFFICIENT_RESOURCES},
+	{"NT_STATUS_DFS_EXIT_PATH_FOUND", NT_STATUS_DFS_EXIT_PATH_FOUND},
+	{"NT_STATUS_DEVICE_DATA_ERROR", NT_STATUS_DEVICE_DATA_ERROR},
+	{"NT_STATUS_DEVICE_NOT_CONNECTED", NT_STATUS_DEVICE_NOT_CONNECTED},
+	{"NT_STATUS_DEVICE_POWER_FAILURE", NT_STATUS_DEVICE_POWER_FAILURE},
+	{"NT_STATUS_FREE_VM_NOT_AT_BASE", NT_STATUS_FREE_VM_NOT_AT_BASE},
+	{"NT_STATUS_MEMORY_NOT_ALLOCATED", NT_STATUS_MEMORY_NOT_ALLOCATED},
+	{"NT_STATUS_WORKING_SET_QUOTA", NT_STATUS_WORKING_SET_QUOTA},
+	{"NT_STATUS_MEDIA_WRITE_PROTECTED",
+	 NT_STATUS_MEDIA_WRITE_PROTECTED},
+	{"NT_STATUS_DEVICE_NOT_READY", NT_STATUS_DEVICE_NOT_READY},
+	{"NT_STATUS_INVALID_GROUP_ATTRIBUTES",
+	 NT_STATUS_INVALID_GROUP_ATTRIBUTES},
+	{"NT_STATUS_BAD_IMPERSONATION_LEVEL",
+	 NT_STATUS_BAD_IMPERSONATION_LEVEL},
+	{"NT_STATUS_CANT_OPEN_ANONYMOUS", NT_STATUS_CANT_OPEN_ANONYMOUS},
+	{"NT_STATUS_BAD_VALIDATION_CLASS", NT_STATUS_BAD_VALIDATION_CLASS},
+	{"NT_STATUS_BAD_TOKEN_TYPE", NT_STATUS_BAD_TOKEN_TYPE},
+	{"NT_STATUS_BAD_MASTER_BOOT_RECORD",
+	 NT_STATUS_BAD_MASTER_BOOT_RECORD},
+	{"NT_STATUS_INSTRUCTION_MISALIGNMENT",
+	 NT_STATUS_INSTRUCTION_MISALIGNMENT},
+	{"NT_STATUS_INSTANCE_NOT_AVAILABLE",
+	 NT_STATUS_INSTANCE_NOT_AVAILABLE},
+	{"NT_STATUS_PIPE_NOT_AVAILABLE", NT_STATUS_PIPE_NOT_AVAILABLE},
+	{"NT_STATUS_INVALID_PIPE_STATE", NT_STATUS_INVALID_PIPE_STATE},
+	{"NT_STATUS_PIPE_BUSY", NT_STATUS_PIPE_BUSY},
+	{"NT_STATUS_ILLEGAL_FUNCTION", NT_STATUS_ILLEGAL_FUNCTION},
+	{"NT_STATUS_PIPE_DISCONNECTED", NT_STATUS_PIPE_DISCONNECTED},
+	{"NT_STATUS_PIPE_CLOSING", NT_STATUS_PIPE_CLOSING},
+	{"NT_STATUS_PIPE_CONNECTED", NT_STATUS_PIPE_CONNECTED},
+	{"NT_STATUS_PIPE_LISTENING", NT_STATUS_PIPE_LISTENING},
+	{"NT_STATUS_INVALID_READ_MODE", NT_STATUS_INVALID_READ_MODE},
+	{"NT_STATUS_IO_TIMEOUT", NT_STATUS_IO_TIMEOUT},
+	{"NT_STATUS_FILE_FORCED_CLOSED", NT_STATUS_FILE_FORCED_CLOSED},
+	{"NT_STATUS_PROFILING_NOT_STARTED",
+	 NT_STATUS_PROFILING_NOT_STARTED},
+	{"NT_STATUS_PROFILING_NOT_STOPPED",
+	 NT_STATUS_PROFILING_NOT_STOPPED},
+	{"NT_STATUS_COULD_NOT_INTERPRET", NT_STATUS_COULD_NOT_INTERPRET},
+	{"NT_STATUS_FILE_IS_A_DIRECTORY", NT_STATUS_FILE_IS_A_DIRECTORY},
+	{"NT_STATUS_NOT_SUPPORTED", NT_STATUS_NOT_SUPPORTED},
+	{"NT_STATUS_REMOTE_NOT_LISTENING", NT_STATUS_REMOTE_NOT_LISTENING},
+	{"NT_STATUS_DUPLICATE_NAME", NT_STATUS_DUPLICATE_NAME},
+	{"NT_STATUS_BAD_NETWORK_PATH", NT_STATUS_BAD_NETWORK_PATH},
+	{"NT_STATUS_NETWORK_BUSY", NT_STATUS_NETWORK_BUSY},
+	{"NT_STATUS_DEVICE_DOES_NOT_EXIST",
+	 NT_STATUS_DEVICE_DOES_NOT_EXIST},
+	{"NT_STATUS_TOO_MANY_COMMANDS", NT_STATUS_TOO_MANY_COMMANDS},
+	{"NT_STATUS_ADAPTER_HARDWARE_ERROR",
+	 NT_STATUS_ADAPTER_HARDWARE_ERROR},
+	{"NT_STATUS_INVALID_NETWORK_RESPONSE",
+	 NT_STATUS_INVALID_NETWORK_RESPONSE},
+	{"NT_STATUS_UNEXPECTED_NETWORK_ERROR",
+	 NT_STATUS_UNEXPECTED_NETWORK_ERROR},
+	{"NT_STATUS_BAD_REMOTE_ADAPTER", NT_STATUS_BAD_REMOTE_ADAPTER},
+	{"NT_STATUS_PRINT_QUEUE_FULL", NT_STATUS_PRINT_QUEUE_FULL},
+	{"NT_STATUS_NO_SPOOL_SPACE", NT_STATUS_NO_SPOOL_SPACE},
+	{"NT_STATUS_PRINT_CANCELLED", NT_STATUS_PRINT_CANCELLED},
+	{"NT_STATUS_NETWORK_NAME_DELETED", NT_STATUS_NETWORK_NAME_DELETED},
+	{"NT_STATUS_NETWORK_ACCESS_DENIED",
+	 NT_STATUS_NETWORK_ACCESS_DENIED},
+	{"NT_STATUS_BAD_DEVICE_TYPE", NT_STATUS_BAD_DEVICE_TYPE},
+	{"NT_STATUS_BAD_NETWORK_NAME", NT_STATUS_BAD_NETWORK_NAME},
+	{"NT_STATUS_TOO_MANY_NAMES", NT_STATUS_TOO_MANY_NAMES},
+	{"NT_STATUS_TOO_MANY_SESSIONS", NT_STATUS_TOO_MANY_SESSIONS},
+	{"NT_STATUS_SHARING_PAUSED", NT_STATUS_SHARING_PAUSED},
+	{"NT_STATUS_REQUEST_NOT_ACCEPTED", NT_STATUS_REQUEST_NOT_ACCEPTED},
+	{"NT_STATUS_REDIRECTOR_PAUSED", NT_STATUS_REDIRECTOR_PAUSED},
+	{"NT_STATUS_NET_WRITE_FAULT", NT_STATUS_NET_WRITE_FAULT},
+	{"NT_STATUS_PROFILING_AT_LIMIT", NT_STATUS_PROFILING_AT_LIMIT},
+	{"NT_STATUS_NOT_SAME_DEVICE", NT_STATUS_NOT_SAME_DEVICE},
+	{"NT_STATUS_FILE_RENAMED", NT_STATUS_FILE_RENAMED},
+	{"NT_STATUS_VIRTUAL_CIRCUIT_CLOSED",
+	 NT_STATUS_VIRTUAL_CIRCUIT_CLOSED},
+	{"NT_STATUS_NO_SECURITY_ON_OBJECT",
+	 NT_STATUS_NO_SECURITY_ON_OBJECT},
+	{"NT_STATUS_CANT_WAIT", NT_STATUS_CANT_WAIT},
+	{"NT_STATUS_PIPE_EMPTY", NT_STATUS_PIPE_EMPTY},
+	{"NT_STATUS_CANT_ACCESS_DOMAIN_INFO",
+	 NT_STATUS_CANT_ACCESS_DOMAIN_INFO},
+	{"NT_STATUS_CANT_TERMINATE_SELF", NT_STATUS_CANT_TERMINATE_SELF},
+	{"NT_STATUS_INVALID_SERVER_STATE", NT_STATUS_INVALID_SERVER_STATE},
+	{"NT_STATUS_INVALID_DOMAIN_STATE", NT_STATUS_INVALID_DOMAIN_STATE},
+	{"NT_STATUS_INVALID_DOMAIN_ROLE", NT_STATUS_INVALID_DOMAIN_ROLE},
+	{"NT_STATUS_NO_SUCH_DOMAIN", NT_STATUS_NO_SUCH_DOMAIN},
+	{"NT_STATUS_DOMAIN_EXISTS", NT_STATUS_DOMAIN_EXISTS},
+	{"NT_STATUS_DOMAIN_LIMIT_EXCEEDED",
+	 NT_STATUS_DOMAIN_LIMIT_EXCEEDED},
+	{"NT_STATUS_OPLOCK_NOT_GRANTED", NT_STATUS_OPLOCK_NOT_GRANTED},
+	{"NT_STATUS_INVALID_OPLOCK_PROTOCOL",
+	 NT_STATUS_INVALID_OPLOCK_PROTOCOL},
+	{"NT_STATUS_INTERNAL_DB_CORRUPTION",
+	 NT_STATUS_INTERNAL_DB_CORRUPTION},
+	{"NT_STATUS_INTERNAL_ERROR", NT_STATUS_INTERNAL_ERROR},
+	{"NT_STATUS_GENERIC_NOT_MAPPED", NT_STATUS_GENERIC_NOT_MAPPED},
+	{"NT_STATUS_BAD_DESCRIPTOR_FORMAT",
+	 NT_STATUS_BAD_DESCRIPTOR_FORMAT},
+	{"NT_STATUS_INVALID_USER_BUFFER", NT_STATUS_INVALID_USER_BUFFER},
+	{"NT_STATUS_UNEXPECTED_IO_ERROR", NT_STATUS_UNEXPECTED_IO_ERROR},
+	{"NT_STATUS_UNEXPECTED_MM_CREATE_ERR",
+	 NT_STATUS_UNEXPECTED_MM_CREATE_ERR},
+	{"NT_STATUS_UNEXPECTED_MM_MAP_ERROR",
+	 NT_STATUS_UNEXPECTED_MM_MAP_ERROR},
+	{"NT_STATUS_UNEXPECTED_MM_EXTEND_ERR",
+	 NT_STATUS_UNEXPECTED_MM_EXTEND_ERR},
+	{"NT_STATUS_NOT_LOGON_PROCESS", NT_STATUS_NOT_LOGON_PROCESS},
+	{"NT_STATUS_LOGON_SESSION_EXISTS", NT_STATUS_LOGON_SESSION_EXISTS},
+	{"NT_STATUS_INVALID_PARAMETER_1", NT_STATUS_INVALID_PARAMETER_1},
+	{"NT_STATUS_INVALID_PARAMETER_2", NT_STATUS_INVALID_PARAMETER_2},
+	{"NT_STATUS_INVALID_PARAMETER_3", NT_STATUS_INVALID_PARAMETER_3},
+	{"NT_STATUS_INVALID_PARAMETER_4", NT_STATUS_INVALID_PARAMETER_4},
+	{"NT_STATUS_INVALID_PARAMETER_5", NT_STATUS_INVALID_PARAMETER_5},
+	{"NT_STATUS_INVALID_PARAMETER_6", NT_STATUS_INVALID_PARAMETER_6},
+	{"NT_STATUS_INVALID_PARAMETER_7", NT_STATUS_INVALID_PARAMETER_7},
+	{"NT_STATUS_INVALID_PARAMETER_8", NT_STATUS_INVALID_PARAMETER_8},
+	{"NT_STATUS_INVALID_PARAMETER_9", NT_STATUS_INVALID_PARAMETER_9},
+	{"NT_STATUS_INVALID_PARAMETER_10", NT_STATUS_INVALID_PARAMETER_10},
+	{"NT_STATUS_INVALID_PARAMETER_11", NT_STATUS_INVALID_PARAMETER_11},
+	{"NT_STATUS_INVALID_PARAMETER_12", NT_STATUS_INVALID_PARAMETER_12},
+	{"NT_STATUS_REDIRECTOR_NOT_STARTED",
+	 NT_STATUS_REDIRECTOR_NOT_STARTED},
+	{"NT_STATUS_REDIRECTOR_STARTED", NT_STATUS_REDIRECTOR_STARTED},
+	{"NT_STATUS_STACK_OVERFLOW", NT_STATUS_STACK_OVERFLOW},
+	{"NT_STATUS_NO_SUCH_PACKAGE", NT_STATUS_NO_SUCH_PACKAGE},
+	{"NT_STATUS_BAD_FUNCTION_TABLE", NT_STATUS_BAD_FUNCTION_TABLE},
+	{"NT_STATUS_DIRECTORY_NOT_EMPTY", NT_STATUS_DIRECTORY_NOT_EMPTY},
+	{"NT_STATUS_FILE_CORRUPT_ERROR", NT_STATUS_FILE_CORRUPT_ERROR},
+	{"NT_STATUS_NOT_A_DIRECTORY", NT_STATUS_NOT_A_DIRECTORY},
+	{"NT_STATUS_BAD_LOGON_SESSION_STATE",
+	 NT_STATUS_BAD_LOGON_SESSION_STATE},
+	{"NT_STATUS_LOGON_SESSION_COLLISION",
+	 NT_STATUS_LOGON_SESSION_COLLISION},
+	{"NT_STATUS_NAME_TOO_LONG", NT_STATUS_NAME_TOO_LONG},
+	{"NT_STATUS_FILES_OPEN", NT_STATUS_FILES_OPEN},
+	{"NT_STATUS_CONNECTION_IN_USE", NT_STATUS_CONNECTION_IN_USE},
+	{"NT_STATUS_MESSAGE_NOT_FOUND", NT_STATUS_MESSAGE_NOT_FOUND},
+	{"NT_STATUS_PROCESS_IS_TERMINATING",
+	 NT_STATUS_PROCESS_IS_TERMINATING},
+	{"NT_STATUS_INVALID_LOGON_TYPE", NT_STATUS_INVALID_LOGON_TYPE},
+	{"NT_STATUS_NO_GUID_TRANSLATION", NT_STATUS_NO_GUID_TRANSLATION},
+	{"NT_STATUS_CANNOT_IMPERSONATE", NT_STATUS_CANNOT_IMPERSONATE},
+	{"NT_STATUS_IMAGE_ALREADY_LOADED", NT_STATUS_IMAGE_ALREADY_LOADED},
+	{"NT_STATUS_ABIOS_NOT_PRESENT", NT_STATUS_ABIOS_NOT_PRESENT},
+	{"NT_STATUS_ABIOS_LID_NOT_EXIST", NT_STATUS_ABIOS_LID_NOT_EXIST},
+	{"NT_STATUS_ABIOS_LID_ALREADY_OWNED",
+	 NT_STATUS_ABIOS_LID_ALREADY_OWNED},
+	{"NT_STATUS_ABIOS_NOT_LID_OWNER", NT_STATUS_ABIOS_NOT_LID_OWNER},
+	{"NT_STATUS_ABIOS_INVALID_COMMAND",
+	 NT_STATUS_ABIOS_INVALID_COMMAND},
+	{"NT_STATUS_ABIOS_INVALID_LID", NT_STATUS_ABIOS_INVALID_LID},
+	{"NT_STATUS_ABIOS_SELECTOR_NOT_AVAILABLE",
+	 NT_STATUS_ABIOS_SELECTOR_NOT_AVAILABLE},
+	{"NT_STATUS_ABIOS_INVALID_SELECTOR",
+	 NT_STATUS_ABIOS_INVALID_SELECTOR},
+	{"NT_STATUS_NO_LDT", NT_STATUS_NO_LDT},
+	{"NT_STATUS_INVALID_LDT_SIZE", NT_STATUS_INVALID_LDT_SIZE},
+	{"NT_STATUS_INVALID_LDT_OFFSET", NT_STATUS_INVALID_LDT_OFFSET},
+	{"NT_STATUS_INVALID_LDT_DESCRIPTOR",
+	 NT_STATUS_INVALID_LDT_DESCRIPTOR},
+	{"NT_STATUS_INVALID_IMAGE_NE_FORMAT",
+	 NT_STATUS_INVALID_IMAGE_NE_FORMAT},
+	{"NT_STATUS_RXACT_INVALID_STATE", NT_STATUS_RXACT_INVALID_STATE},
+	{"NT_STATUS_RXACT_COMMIT_FAILURE", NT_STATUS_RXACT_COMMIT_FAILURE},
+	{"NT_STATUS_MAPPED_FILE_SIZE_ZERO",
+	 NT_STATUS_MAPPED_FILE_SIZE_ZERO},
+	{"NT_STATUS_TOO_MANY_OPENED_FILES",
+	 NT_STATUS_TOO_MANY_OPENED_FILES},
+	{"NT_STATUS_CANCELLED", NT_STATUS_CANCELLED},
+	{"NT_STATUS_CANNOT_DELETE", NT_STATUS_CANNOT_DELETE},
+	{"NT_STATUS_INVALID_COMPUTER_NAME",
+	 NT_STATUS_INVALID_COMPUTER_NAME},
+	{"NT_STATUS_FILE_DELETED", NT_STATUS_FILE_DELETED},
+	{"NT_STATUS_SPECIAL_ACCOUNT", NT_STATUS_SPECIAL_ACCOUNT},
+	{"NT_STATUS_SPECIAL_GROUP", NT_STATUS_SPECIAL_GROUP},
+	{"NT_STATUS_SPECIAL_USER", NT_STATUS_SPECIAL_USER},
+	{"NT_STATUS_MEMBERS_PRIMARY_GROUP",
+	 NT_STATUS_MEMBERS_PRIMARY_GROUP},
+	{"NT_STATUS_FILE_CLOSED", NT_STATUS_FILE_CLOSED},
+	{"NT_STATUS_TOO_MANY_THREADS", NT_STATUS_TOO_MANY_THREADS},
+	{"NT_STATUS_THREAD_NOT_IN_PROCESS",
+	 NT_STATUS_THREAD_NOT_IN_PROCESS},
+	{"NT_STATUS_TOKEN_ALREADY_IN_USE", NT_STATUS_TOKEN_ALREADY_IN_USE},
+	{"NT_STATUS_PAGEFILE_QUOTA_EXCEEDED",
+	 NT_STATUS_PAGEFILE_QUOTA_EXCEEDED},
+	{"NT_STATUS_COMMITMENT_LIMIT", NT_STATUS_COMMITMENT_LIMIT},
+	{"NT_STATUS_INVALID_IMAGE_LE_FORMAT",
+	 NT_STATUS_INVALID_IMAGE_LE_FORMAT},
+	{"NT_STATUS_INVALID_IMAGE_NOT_MZ", NT_STATUS_INVALID_IMAGE_NOT_MZ},
+	{"NT_STATUS_INVALID_IMAGE_PROTECT",
+	 NT_STATUS_INVALID_IMAGE_PROTECT},
+	{"NT_STATUS_INVALID_IMAGE_WIN_16", NT_STATUS_INVALID_IMAGE_WIN_16},
+	{"NT_STATUS_LOGON_SERVER_CONFLICT",
+	 NT_STATUS_LOGON_SERVER_CONFLICT},
+	{"NT_STATUS_TIME_DIFFERENCE_AT_DC",
+	 NT_STATUS_TIME_DIFFERENCE_AT_DC},
+	{"NT_STATUS_SYNCHRONIZATION_REQUIRED",
+	 NT_STATUS_SYNCHRONIZATION_REQUIRED},
+	{"NT_STATUS_DLL_NOT_FOUND", NT_STATUS_DLL_NOT_FOUND},
+	{"NT_STATUS_OPEN_FAILED", NT_STATUS_OPEN_FAILED},
+	{"NT_STATUS_IO_PRIVILEGE_FAILED", NT_STATUS_IO_PRIVILEGE_FAILED},
+	{"NT_STATUS_ORDINAL_NOT_FOUND", NT_STATUS_ORDINAL_NOT_FOUND},
+	{"NT_STATUS_ENTRYPOINT_NOT_FOUND", NT_STATUS_ENTRYPOINT_NOT_FOUND},
+	{"NT_STATUS_CONTROL_C_EXIT", NT_STATUS_CONTROL_C_EXIT},
+	{"NT_STATUS_LOCAL_DISCONNECT", NT_STATUS_LOCAL_DISCONNECT},
+	{"NT_STATUS_REMOTE_DISCONNECT", NT_STATUS_REMOTE_DISCONNECT},
+	{"NT_STATUS_REMOTE_RESOURCES", NT_STATUS_REMOTE_RESOURCES},
+	{"NT_STATUS_LINK_FAILED", NT_STATUS_LINK_FAILED},
+	{"NT_STATUS_LINK_TIMEOUT", NT_STATUS_LINK_TIMEOUT},
+	{"NT_STATUS_INVALID_CONNECTION", NT_STATUS_INVALID_CONNECTION},
+	{"NT_STATUS_INVALID_ADDRESS", NT_STATUS_INVALID_ADDRESS},
+	{"NT_STATUS_DLL_INIT_FAILED", NT_STATUS_DLL_INIT_FAILED},
+	{"NT_STATUS_MISSING_SYSTEMFILE", NT_STATUS_MISSING_SYSTEMFILE},
+	{"NT_STATUS_UNHANDLED_EXCEPTION", NT_STATUS_UNHANDLED_EXCEPTION},
+	{"NT_STATUS_APP_INIT_FAILURE", NT_STATUS_APP_INIT_FAILURE},
+	{"NT_STATUS_PAGEFILE_CREATE_FAILED",
+	 NT_STATUS_PAGEFILE_CREATE_FAILED},
+	{"NT_STATUS_NO_PAGEFILE", NT_STATUS_NO_PAGEFILE},
+	{"NT_STATUS_INVALID_LEVEL", NT_STATUS_INVALID_LEVEL},
+	{"NT_STATUS_WRONG_PASSWORD_CORE", NT_STATUS_WRONG_PASSWORD_CORE},
+	{"NT_STATUS_ILLEGAL_FLOAT_CONTEXT",
+	 NT_STATUS_ILLEGAL_FLOAT_CONTEXT},
+	{"NT_STATUS_PIPE_BROKEN", NT_STATUS_PIPE_BROKEN},
+	{"NT_STATUS_REGISTRY_CORRUPT", NT_STATUS_REGISTRY_CORRUPT},
+	{"NT_STATUS_REGISTRY_IO_FAILED", NT_STATUS_REGISTRY_IO_FAILED},
+	{"NT_STATUS_NO_EVENT_PAIR", NT_STATUS_NO_EVENT_PAIR},
+	{"NT_STATUS_UNRECOGNIZED_VOLUME", NT_STATUS_UNRECOGNIZED_VOLUME},
+	{"NT_STATUS_SERIAL_NO_DEVICE_INITED",
+	 NT_STATUS_SERIAL_NO_DEVICE_INITED},
+	{"NT_STATUS_NO_SUCH_ALIAS", NT_STATUS_NO_SUCH_ALIAS},
+	{"NT_STATUS_MEMBER_NOT_IN_ALIAS", NT_STATUS_MEMBER_NOT_IN_ALIAS},
+	{"NT_STATUS_MEMBER_IN_ALIAS", NT_STATUS_MEMBER_IN_ALIAS},
+	{"NT_STATUS_ALIAS_EXISTS", NT_STATUS_ALIAS_EXISTS},
+	{"NT_STATUS_LOGON_NOT_GRANTED", NT_STATUS_LOGON_NOT_GRANTED},
+	{"NT_STATUS_TOO_MANY_SECRETS", NT_STATUS_TOO_MANY_SECRETS},
+	{"NT_STATUS_SECRET_TOO_LONG", NT_STATUS_SECRET_TOO_LONG},
+	{"NT_STATUS_INTERNAL_DB_ERROR", NT_STATUS_INTERNAL_DB_ERROR},
+	{"NT_STATUS_FULLSCREEN_MODE", NT_STATUS_FULLSCREEN_MODE},
+	{"NT_STATUS_TOO_MANY_CONTEXT_IDS", NT_STATUS_TOO_MANY_CONTEXT_IDS},
+	{"NT_STATUS_LOGON_TYPE_NOT_GRANTED",
+	 NT_STATUS_LOGON_TYPE_NOT_GRANTED},
+	{"NT_STATUS_NOT_REGISTRY_FILE", NT_STATUS_NOT_REGISTRY_FILE},
+	{"NT_STATUS_NT_CROSS_ENCRYPTION_REQUIRED",
+	 NT_STATUS_NT_CROSS_ENCRYPTION_REQUIRED},
+	{"NT_STATUS_DOMAIN_CTRLR_CONFIG_ERROR",
+	 NT_STATUS_DOMAIN_CTRLR_CONFIG_ERROR},
+	{"NT_STATUS_FT_MISSING_MEMBER", NT_STATUS_FT_MISSING_MEMBER},
+	{"NT_STATUS_ILL_FORMED_SERVICE_ENTRY",
+	 NT_STATUS_ILL_FORMED_SERVICE_ENTRY},
+	{"NT_STATUS_ILLEGAL_CHARACTER", NT_STATUS_ILLEGAL_CHARACTER},
+	{"NT_STATUS_UNMAPPABLE_CHARACTER", NT_STATUS_UNMAPPABLE_CHARACTER},
+	{"NT_STATUS_UNDEFINED_CHARACTER", NT_STATUS_UNDEFINED_CHARACTER},
+	{"NT_STATUS_FLOPPY_VOLUME", NT_STATUS_FLOPPY_VOLUME},
+	{"NT_STATUS_FLOPPY_ID_MARK_NOT_FOUND",
+	 NT_STATUS_FLOPPY_ID_MARK_NOT_FOUND},
+	{"NT_STATUS_FLOPPY_WRONG_CYLINDER",
+	 NT_STATUS_FLOPPY_WRONG_CYLINDER},
+	{"NT_STATUS_FLOPPY_UNKNOWN_ERROR", NT_STATUS_FLOPPY_UNKNOWN_ERROR},
+	{"NT_STATUS_FLOPPY_BAD_REGISTERS", NT_STATUS_FLOPPY_BAD_REGISTERS},
+	{"NT_STATUS_DISK_RECALIBRATE_FAILED",
+	 NT_STATUS_DISK_RECALIBRATE_FAILED},
+	{"NT_STATUS_DISK_OPERATION_FAILED",
+	 NT_STATUS_DISK_OPERATION_FAILED},
+	{"NT_STATUS_DISK_RESET_FAILED", NT_STATUS_DISK_RESET_FAILED},
+	{"NT_STATUS_SHARED_IRQ_BUSY", NT_STATUS_SHARED_IRQ_BUSY},
+	{"NT_STATUS_FT_ORPHANING", NT_STATUS_FT_ORPHANING},
+	{"NT_STATUS_PARTITION_FAILURE", NT_STATUS_PARTITION_FAILURE},
+	{"NT_STATUS_INVALID_BLOCK_LENGTH", NT_STATUS_INVALID_BLOCK_LENGTH},
+	{"NT_STATUS_DEVICE_NOT_PARTITIONED",
+	 NT_STATUS_DEVICE_NOT_PARTITIONED},
+	{"NT_STATUS_UNABLE_TO_LOCK_MEDIA", NT_STATUS_UNABLE_TO_LOCK_MEDIA},
+	{"NT_STATUS_UNABLE_TO_UNLOAD_MEDIA",
+	 NT_STATUS_UNABLE_TO_UNLOAD_MEDIA},
+	{"NT_STATUS_EOM_OVERFLOW", NT_STATUS_EOM_OVERFLOW},
+	{"NT_STATUS_NO_MEDIA", NT_STATUS_NO_MEDIA},
+	{"NT_STATUS_NO_SUCH_MEMBER", NT_STATUS_NO_SUCH_MEMBER},
+	{"NT_STATUS_INVALID_MEMBER", NT_STATUS_INVALID_MEMBER},
+	{"NT_STATUS_KEY_DELETED", NT_STATUS_KEY_DELETED},
+	{"NT_STATUS_NO_LOG_SPACE", NT_STATUS_NO_LOG_SPACE},
+	{"NT_STATUS_TOO_MANY_SIDS", NT_STATUS_TOO_MANY_SIDS},
+	{"NT_STATUS_LM_CROSS_ENCRYPTION_REQUIRED",
+	 NT_STATUS_LM_CROSS_ENCRYPTION_REQUIRED},
+	{"NT_STATUS_KEY_HAS_CHILDREN", NT_STATUS_KEY_HAS_CHILDREN},
+	{"NT_STATUS_CHILD_MUST_BE_VOLATILE",
+	 NT_STATUS_CHILD_MUST_BE_VOLATILE},
+	{"NT_STATUS_DEVICE_CONFIGURATION_ERROR",
+	 NT_STATUS_DEVICE_CONFIGURATION_ERROR},
+	{"NT_STATUS_DRIVER_INTERNAL_ERROR",
+	 NT_STATUS_DRIVER_INTERNAL_ERROR},
+	{"NT_STATUS_INVALID_DEVICE_STATE", NT_STATUS_INVALID_DEVICE_STATE},
+	{"NT_STATUS_IO_DEVICE_ERROR", NT_STATUS_IO_DEVICE_ERROR},
+	{"NT_STATUS_DEVICE_PROTOCOL_ERROR",
+	 NT_STATUS_DEVICE_PROTOCOL_ERROR},
+	{"NT_STATUS_BACKUP_CONTROLLER", NT_STATUS_BACKUP_CONTROLLER},
+	{"NT_STATUS_LOG_FILE_FULL", NT_STATUS_LOG_FILE_FULL},
+	{"NT_STATUS_TOO_LATE", NT_STATUS_TOO_LATE},
+	{"NT_STATUS_NO_TRUST_LSA_SECRET", NT_STATUS_NO_TRUST_LSA_SECRET},
+	{"NT_STATUS_NO_TRUST_SAM_ACCOUNT", NT_STATUS_NO_TRUST_SAM_ACCOUNT},
+	{"NT_STATUS_TRUSTED_DOMAIN_FAILURE",
+	 NT_STATUS_TRUSTED_DOMAIN_FAILURE},
+	{"NT_STATUS_TRUSTED_RELATIONSHIP_FAILURE",
+	 NT_STATUS_TRUSTED_RELATIONSHIP_FAILURE},
+	{"NT_STATUS_EVENTLOG_FILE_CORRUPT",
+	 NT_STATUS_EVENTLOG_FILE_CORRUPT},
+	{"NT_STATUS_EVENTLOG_CANT_START", NT_STATUS_EVENTLOG_CANT_START},
+	{"NT_STATUS_TRUST_FAILURE", NT_STATUS_TRUST_FAILURE},
+	{"NT_STATUS_MUTANT_LIMIT_EXCEEDED",
+	 NT_STATUS_MUTANT_LIMIT_EXCEEDED},
+	{"NT_STATUS_NETLOGON_NOT_STARTED", NT_STATUS_NETLOGON_NOT_STARTED},
+	{"NT_STATUS_ACCOUNT_EXPIRED", NT_STATUS_ACCOUNT_EXPIRED},
+	{"NT_STATUS_POSSIBLE_DEADLOCK", NT_STATUS_POSSIBLE_DEADLOCK},
+	{"NT_STATUS_NETWORK_CREDENTIAL_CONFLICT",
+	 NT_STATUS_NETWORK_CREDENTIAL_CONFLICT},
+	{"NT_STATUS_REMOTE_SESSION_LIMIT", NT_STATUS_REMOTE_SESSION_LIMIT},
+	{"NT_STATUS_EVENTLOG_FILE_CHANGED",
+	 NT_STATUS_EVENTLOG_FILE_CHANGED},
+	{"NT_STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT",
+	 NT_STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT},
+	{"NT_STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT",
+	 NT_STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT},
+	{"NT_STATUS_NOLOGON_SERVER_TRUST_ACCOUNT",
+	 NT_STATUS_NOLOGON_SERVER_TRUST_ACCOUNT},
+	{"NT_STATUS_DOMAIN_TRUST_INCONSISTENT",
+	 NT_STATUS_DOMAIN_TRUST_INCONSISTENT},
+	{"NT_STATUS_FS_DRIVER_REQUIRED", NT_STATUS_FS_DRIVER_REQUIRED},
+	{"NT_STATUS_NO_USER_SESSION_KEY", NT_STATUS_NO_USER_SESSION_KEY},
+	{"NT_STATUS_USER_SESSION_DELETED", NT_STATUS_USER_SESSION_DELETED},
+	{"NT_STATUS_RESOURCE_LANG_NOT_FOUND",
+	 NT_STATUS_RESOURCE_LANG_NOT_FOUND},
+	{"NT_STATUS_INSUFF_SERVER_RESOURCES",
+	 NT_STATUS_INSUFF_SERVER_RESOURCES},
+	{"NT_STATUS_INVALID_BUFFER_SIZE", NT_STATUS_INVALID_BUFFER_SIZE},
+	{"NT_STATUS_INVALID_ADDRESS_COMPONENT",
+	 NT_STATUS_INVALID_ADDRESS_COMPONENT},
+	{"NT_STATUS_INVALID_ADDRESS_WILDCARD",
+	 NT_STATUS_INVALID_ADDRESS_WILDCARD},
+	{"NT_STATUS_TOO_MANY_ADDRESSES", NT_STATUS_TOO_MANY_ADDRESSES},
+	{"NT_STATUS_ADDRESS_ALREADY_EXISTS",
+	 NT_STATUS_ADDRESS_ALREADY_EXISTS},
+	{"NT_STATUS_ADDRESS_CLOSED", NT_STATUS_ADDRESS_CLOSED},
+	{"NT_STATUS_CONNECTION_DISCONNECTED",
+	 NT_STATUS_CONNECTION_DISCONNECTED},
+	{"NT_STATUS_CONNECTION_RESET", NT_STATUS_CONNECTION_RESET},
+	{"NT_STATUS_TOO_MANY_NODES", NT_STATUS_TOO_MANY_NODES},
+	{"NT_STATUS_TRANSACTION_ABORTED", NT_STATUS_TRANSACTION_ABORTED},
+	{"NT_STATUS_TRANSACTION_TIMED_OUT",
+	 NT_STATUS_TRANSACTION_TIMED_OUT},
+	{"NT_STATUS_TRANSACTION_NO_RELEASE",
+	 NT_STATUS_TRANSACTION_NO_RELEASE},
+	{"NT_STATUS_TRANSACTION_NO_MATCH", NT_STATUS_TRANSACTION_NO_MATCH},
+	{"NT_STATUS_TRANSACTION_RESPONDED",
+	 NT_STATUS_TRANSACTION_RESPONDED},
+	{"NT_STATUS_TRANSACTION_INVALID_ID",
+	 NT_STATUS_TRANSACTION_INVALID_ID},
+	{"NT_STATUS_TRANSACTION_INVALID_TYPE",
+	 NT_STATUS_TRANSACTION_INVALID_TYPE},
+	{"NT_STATUS_NOT_SERVER_SESSION", NT_STATUS_NOT_SERVER_SESSION},
+	{"NT_STATUS_NOT_CLIENT_SESSION", NT_STATUS_NOT_CLIENT_SESSION},
+	{"NT_STATUS_CANNOT_LOAD_REGISTRY_FILE",
+	 NT_STATUS_CANNOT_LOAD_REGISTRY_FILE},
+	{"NT_STATUS_DEBUG_ATTACH_FAILED", NT_STATUS_DEBUG_ATTACH_FAILED},
+	{"NT_STATUS_SYSTEM_PROCESS_TERMINATED",
+	 NT_STATUS_SYSTEM_PROCESS_TERMINATED},
+	{"NT_STATUS_DATA_NOT_ACCEPTED", NT_STATUS_DATA_NOT_ACCEPTED},
+	{"NT_STATUS_NO_BROWSER_SERVERS_FOUND",
+	 NT_STATUS_NO_BROWSER_SERVERS_FOUND},
+	{"NT_STATUS_VDM_HARD_ERROR", NT_STATUS_VDM_HARD_ERROR},
+	{"NT_STATUS_DRIVER_CANCEL_TIMEOUT",
+	 NT_STATUS_DRIVER_CANCEL_TIMEOUT},
+	{"NT_STATUS_REPLY_MESSAGE_MISMATCH",
+	 NT_STATUS_REPLY_MESSAGE_MISMATCH},
+	{"NT_STATUS_MAPPED_ALIGNMENT", NT_STATUS_MAPPED_ALIGNMENT},
+	{"NT_STATUS_IMAGE_CHECKSUM_MISMATCH",
+	 NT_STATUS_IMAGE_CHECKSUM_MISMATCH},
+	{"NT_STATUS_LOST_WRITEBEHIND_DATA",
+	 NT_STATUS_LOST_WRITEBEHIND_DATA},
+	{"NT_STATUS_CLIENT_SERVER_PARAMETERS_INVALID",
+	 NT_STATUS_CLIENT_SERVER_PARAMETERS_INVALID},
+	{"NT_STATUS_PASSWORD_MUST_CHANGE", NT_STATUS_PASSWORD_MUST_CHANGE},
+	{"NT_STATUS_NOT_FOUND", NT_STATUS_NOT_FOUND},
+	{"NT_STATUS_NOT_TINY_STREAM", NT_STATUS_NOT_TINY_STREAM},
+	{"NT_STATUS_RECOVERY_FAILURE", NT_STATUS_RECOVERY_FAILURE},
+	{"NT_STATUS_STACK_OVERFLOW_READ", NT_STATUS_STACK_OVERFLOW_READ},
+	{"NT_STATUS_FAIL_CHECK", NT_STATUS_FAIL_CHECK},
+	{"NT_STATUS_DUPLICATE_OBJECTID", NT_STATUS_DUPLICATE_OBJECTID},
+	{"NT_STATUS_OBJECTID_EXISTS", NT_STATUS_OBJECTID_EXISTS},
+	{"NT_STATUS_CONVERT_TO_LARGE", NT_STATUS_CONVERT_TO_LARGE},
+	{"NT_STATUS_RETRY", NT_STATUS_RETRY},
+	{"NT_STATUS_FOUND_OUT_OF_SCOPE", NT_STATUS_FOUND_OUT_OF_SCOPE},
+	{"NT_STATUS_ALLOCATE_BUCKET", NT_STATUS_ALLOCATE_BUCKET},
+	{"NT_STATUS_PROPSET_NOT_FOUND", NT_STATUS_PROPSET_NOT_FOUND},
+	{"NT_STATUS_MARSHALL_OVERFLOW", NT_STATUS_MARSHALL_OVERFLOW},
+	{"NT_STATUS_INVALID_VARIANT", NT_STATUS_INVALID_VARIANT},
+	{"NT_STATUS_DOMAIN_CONTROLLER_NOT_FOUND",
+	 NT_STATUS_DOMAIN_CONTROLLER_NOT_FOUND},
+	{"NT_STATUS_ACCOUNT_LOCKED_OUT", NT_STATUS_ACCOUNT_LOCKED_OUT},
+	{"NT_STATUS_HANDLE_NOT_CLOSABLE", NT_STATUS_HANDLE_NOT_CLOSABLE},
+	{"NT_STATUS_CONNECTION_REFUSED", NT_STATUS_CONNECTION_REFUSED},
+	{"NT_STATUS_GRACEFUL_DISCONNECT", NT_STATUS_GRACEFUL_DISCONNECT},
+	{"NT_STATUS_ADDRESS_ALREADY_ASSOCIATED",
+	 NT_STATUS_ADDRESS_ALREADY_ASSOCIATED},
+	{"NT_STATUS_ADDRESS_NOT_ASSOCIATED",
+	 NT_STATUS_ADDRESS_NOT_ASSOCIATED},
+	{"NT_STATUS_CONNECTION_INVALID", NT_STATUS_CONNECTION_INVALID},
+	{"NT_STATUS_CONNECTION_ACTIVE", NT_STATUS_CONNECTION_ACTIVE},
+	{"NT_STATUS_NETWORK_UNREACHABLE", NT_STATUS_NETWORK_UNREACHABLE},
+	{"NT_STATUS_HOST_UNREACHABLE", NT_STATUS_HOST_UNREACHABLE},
+	{"NT_STATUS_PROTOCOL_UNREACHABLE", NT_STATUS_PROTOCOL_UNREACHABLE},
+	{"NT_STATUS_PORT_UNREACHABLE", NT_STATUS_PORT_UNREACHABLE},
+	{"NT_STATUS_REQUEST_ABORTED", NT_STATUS_REQUEST_ABORTED},
+	{"NT_STATUS_CONNECTION_ABORTED", NT_STATUS_CONNECTION_ABORTED},
+	{"NT_STATUS_BAD_COMPRESSION_BUFFER",
+	 NT_STATUS_BAD_COMPRESSION_BUFFER},
+	{"NT_STATUS_USER_MAPPED_FILE", NT_STATUS_USER_MAPPED_FILE},
+	{"NT_STATUS_AUDIT_FAILED", NT_STATUS_AUDIT_FAILED},
+	{"NT_STATUS_TIMER_RESOLUTION_NOT_SET",
+	 NT_STATUS_TIMER_RESOLUTION_NOT_SET},
+	{"NT_STATUS_CONNECTION_COUNT_LIMIT",
+	 NT_STATUS_CONNECTION_COUNT_LIMIT},
+	{"NT_STATUS_LOGIN_TIME_RESTRICTION",
+	 NT_STATUS_LOGIN_TIME_RESTRICTION},
+	{"NT_STATUS_LOGIN_WKSTA_RESTRICTION",
+	 NT_STATUS_LOGIN_WKSTA_RESTRICTION},
+	{"NT_STATUS_IMAGE_MP_UP_MISMATCH", NT_STATUS_IMAGE_MP_UP_MISMATCH},
+	{"NT_STATUS_INSUFFICIENT_LOGON_INFO",
+	 NT_STATUS_INSUFFICIENT_LOGON_INFO},
+	{"NT_STATUS_BAD_DLL_ENTRYPOINT", NT_STATUS_BAD_DLL_ENTRYPOINT},
+	{"NT_STATUS_BAD_SERVICE_ENTRYPOINT",
+	 NT_STATUS_BAD_SERVICE_ENTRYPOINT},
+	{"NT_STATUS_LPC_REPLY_LOST", NT_STATUS_LPC_REPLY_LOST},
+	{"NT_STATUS_IP_ADDRESS_CONFLICT1", NT_STATUS_IP_ADDRESS_CONFLICT1},
+	{"NT_STATUS_IP_ADDRESS_CONFLICT2", NT_STATUS_IP_ADDRESS_CONFLICT2},
+	{"NT_STATUS_REGISTRY_QUOTA_LIMIT", NT_STATUS_REGISTRY_QUOTA_LIMIT},
+	{"NT_STATUS_PATH_NOT_COVERED", NT_STATUS_PATH_NOT_COVERED},
+	{"NT_STATUS_NO_CALLBACK_ACTIVE", NT_STATUS_NO_CALLBACK_ACTIVE},
+	{"NT_STATUS_LICENSE_QUOTA_EXCEEDED",
+	 NT_STATUS_LICENSE_QUOTA_EXCEEDED},
+	{"NT_STATUS_PWD_TOO_SHORT", NT_STATUS_PWD_TOO_SHORT},
+	{"NT_STATUS_PWD_TOO_RECENT", NT_STATUS_PWD_TOO_RECENT},
+	{"NT_STATUS_PWD_HISTORY_CONFLICT", NT_STATUS_PWD_HISTORY_CONFLICT},
+	{"NT_STATUS_PLUGPLAY_NO_DEVICE", NT_STATUS_PLUGPLAY_NO_DEVICE},
+	{"NT_STATUS_UNSUPPORTED_COMPRESSION",
+	 NT_STATUS_UNSUPPORTED_COMPRESSION},
+	{"NT_STATUS_INVALID_HW_PROFILE", NT_STATUS_INVALID_HW_PROFILE},
+	{"NT_STATUS_INVALID_PLUGPLAY_DEVICE_PATH",
+	 NT_STATUS_INVALID_PLUGPLAY_DEVICE_PATH},
+	{"NT_STATUS_DRIVER_ORDINAL_NOT_FOUND",
+	 NT_STATUS_DRIVER_ORDINAL_NOT_FOUND},
+	{"NT_STATUS_DRIVER_ENTRYPOINT_NOT_FOUND",
+	 NT_STATUS_DRIVER_ENTRYPOINT_NOT_FOUND},
+	{"NT_STATUS_RESOURCE_NOT_OWNED", NT_STATUS_RESOURCE_NOT_OWNED},
+	{"NT_STATUS_TOO_MANY_LINKS", NT_STATUS_TOO_MANY_LINKS},
+	{"NT_STATUS_QUOTA_LIST_INCONSISTENT",
+	 NT_STATUS_QUOTA_LIST_INCONSISTENT},
+	{"NT_STATUS_FILE_IS_OFFLINE", NT_STATUS_FILE_IS_OFFLINE},
+	{"NT_STATUS_NO_MORE_ENTRIES", NT_STATUS_NO_MORE_ENTRIES},
+	{"NT_STATUS_MORE_ENTRIES", NT_STATUS_MORE_ENTRIES},
+	{"NT_STATUS_SOME_UNMAPPED", NT_STATUS_SOME_UNMAPPED},
+	{NULL, 0}
+};
diff --git a/fs/cifsd/nterr.h b/fs/cifsd/nterr.h
new file mode 100644
index 000000000000..9f5004b69d30
--- /dev/null
+++ b/fs/cifsd/nterr.h
@@ -0,0 +1,552 @@
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
+
+
+#ifndef _NTERR_H
+#define _NTERR_H
+
+struct nt_err_code_struct {
+	char *nt_errstr;
+	__u32 nt_errcode;
+};
+
+extern const struct nt_err_code_struct nt_errs[];
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
diff --git a/fs/cifsd/ntlmssp.h b/fs/cifsd/ntlmssp.h
new file mode 100644
index 000000000000..adaf4c0cbe8f
--- /dev/null
+++ b/fs/cifsd/ntlmssp.h
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
diff --git a/fs/cifsd/oplock.c b/fs/cifsd/oplock.c
new file mode 100644
index 000000000000..e56c938a8f7a
--- /dev/null
+++ b/fs/cifsd/oplock.c
@@ -0,0 +1,1681 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/moduleparam.h>
+
+#include "glob.h"
+#include "oplock.h"
+
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "mgmt/user_session.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+
+static LIST_HEAD(lease_table_list);
+static DEFINE_RWLOCK(lease_list_lock);
+
+/**
+ * alloc_opinfo() - allocate a new opinfo object for oplock info
+ * @work:	smb work
+ * @id:		fid of open file
+ * @Tid:	tree id of connection
+ *
+ * Return:      allocated opinfo object on success, otherwise NULL
+ */
+static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
+		uint64_t id, __u16 Tid)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct oplock_info *opinfo;
+
+	opinfo = kzalloc(sizeof(struct oplock_info), GFP_KERNEL);
+	if (!opinfo)
+		return NULL;
+
+	opinfo->sess = sess;
+	opinfo->conn = sess->conn;
+	opinfo->level = OPLOCK_NONE;
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	opinfo->pending_break = 0;
+	opinfo->fid = id;
+	opinfo->Tid = Tid;
+	INIT_LIST_HEAD(&opinfo->op_entry);
+	INIT_LIST_HEAD(&opinfo->interim_list);
+	init_waitqueue_head(&opinfo->oplock_q);
+	init_waitqueue_head(&opinfo->oplock_brk);
+	atomic_set(&opinfo->refcount, 1);
+	atomic_set(&opinfo->breaking_cnt, 0);
+
+	return opinfo;
+}
+
+static void lease_add_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb = opinfo->o_lease->l_lb;
+
+	spin_lock(&lb->lb_lock);
+	list_add_rcu(&opinfo->lease_entry, &lb->lease_list);
+	spin_unlock(&lb->lb_lock);
+}
+
+static void lease_del_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb = opinfo->o_lease->l_lb;
+
+	if (!lb)
+		return;
+
+	spin_lock(&lb->lb_lock);
+	if (list_empty(&opinfo->lease_entry)) {
+		spin_unlock(&lb->lb_lock);
+		return;
+	}
+
+	list_del_init(&opinfo->lease_entry);
+	opinfo->o_lease->l_lb = NULL;
+	spin_unlock(&lb->lb_lock);
+}
+
+static void lb_add(struct lease_table *lb)
+{
+	write_lock(&lease_list_lock);
+	list_add(&lb->l_entry, &lease_table_list);
+	write_unlock(&lease_list_lock);
+}
+
+static int alloc_lease(struct oplock_info *opinfo,
+	struct lease_ctx_info *lctx)
+{
+	struct lease *lease;
+
+	lease = kmalloc(sizeof(struct lease), GFP_KERNEL);
+	if (!lease)
+		return -ENOMEM;
+
+	memcpy(lease->lease_key, lctx->lease_key, SMB2_LEASE_KEY_SIZE);
+	lease->state = lctx->req_state;
+	lease->new_state = 0;
+	lease->flags = lctx->flags;
+	lease->duration = lctx->duration;
+	INIT_LIST_HEAD(&opinfo->lease_entry);
+	opinfo->o_lease = lease;
+
+	return 0;
+}
+
+static void free_lease(struct oplock_info *opinfo)
+{
+	struct lease *lease;
+
+	lease = opinfo->o_lease;
+	kfree(lease);
+}
+
+static void free_opinfo(struct oplock_info *opinfo)
+{
+	if (opinfo->is_lease)
+		free_lease(opinfo);
+	kfree(opinfo);
+}
+
+static inline void opinfo_free_rcu(struct rcu_head *rcu_head)
+{
+	struct oplock_info *opinfo;
+
+	opinfo = container_of(rcu_head, struct oplock_info, rcu_head);
+	free_opinfo(opinfo);
+}
+
+struct oplock_info *opinfo_get(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
+		opinfo = NULL;
+	rcu_read_unlock();
+
+	return opinfo;
+}
+
+static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
+{
+	struct oplock_info *opinfo;
+
+	if (list_empty(&ci->m_op_list))
+		return NULL;
+
+	rcu_read_lock();
+	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
+		op_entry);
+	if (opinfo && !atomic_inc_not_zero(&opinfo->refcount))
+		opinfo = NULL;
+	rcu_read_unlock();
+
+	return opinfo;
+}
+
+void opinfo_put(struct oplock_info *opinfo)
+{
+	if (!atomic_dec_and_test(&opinfo->refcount))
+		return;
+
+	call_rcu(&opinfo->rcu_head, opinfo_free_rcu);
+}
+
+static void opinfo_add(struct oplock_info *opinfo)
+{
+	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
+
+	write_lock(&ci->m_lock);
+	list_add_rcu(&opinfo->op_entry, &ci->m_op_list);
+	write_unlock(&ci->m_lock);
+}
+
+static void opinfo_del(struct oplock_info *opinfo)
+{
+	struct ksmbd_inode *ci = opinfo->o_fp->f_ci;
+
+	if (opinfo->is_lease) {
+		write_lock(&lease_list_lock);
+		lease_del_list(opinfo);
+		write_unlock(&lease_list_lock);
+	}
+	write_lock(&ci->m_lock);
+	list_del_rcu(&opinfo->op_entry);
+	write_unlock(&ci->m_lock);
+}
+
+static unsigned long opinfo_count(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_read(&fp->f_ci->sop_count);
+	else
+		return atomic_read(&fp->f_ci->op_count);
+}
+
+static void opinfo_count_inc(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_inc(&fp->f_ci->sop_count);
+	else
+		return atomic_inc(&fp->f_ci->op_count);
+}
+
+static void opinfo_count_dec(struct ksmbd_file *fp)
+{
+	if (ksmbd_stream_fd(fp))
+		return atomic_dec(&fp->f_ci->sop_count);
+	else
+		return atomic_dec(&fp->f_ci->op_count);
+}
+
+/**
+ * opinfo_write_to_read() - convert a write oplock to read oplock
+ * @opinfo:		current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_write_to_read(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!((opinfo->level == SMB2_OPLOCK_LEVEL_BATCH) ||
+	    (opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n", lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_II;
+
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * opinfo_read_handle_to_read() - convert a read/handle oplock to read oplock
+ * @opinfo:		current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_read_handle_to_read(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	lease->state = lease->new_state;
+	opinfo->level = SMB2_OPLOCK_LEVEL_II;
+	return 0;
+}
+
+/**
+ * opinfo_write_to_none() - convert a write oplock to none
+ * @opinfo:	current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_write_to_none(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!((opinfo->level == SMB2_OPLOCK_LEVEL_BATCH) ||
+	    (opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n",
+					lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * opinfo_read_to_none() - convert a write read to none
+ * @opinfo:	current oplock info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int opinfo_read_to_none(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (opinfo->level != SMB2_OPLOCK_LEVEL_II) {
+		ksmbd_err("bad oplock(0x%x)\n", opinfo->level);
+		if (opinfo->is_lease)
+			ksmbd_err("lease state(0x%x)\n", lease->state);
+		return -EINVAL;
+	}
+	opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	if (opinfo->is_lease)
+		lease->state = lease->new_state;
+	return 0;
+}
+
+/**
+ * lease_read_to_write() - upgrade lease state from read to write
+ * @opinfo:	current lease info
+ *
+ * Return:      0 on success, otherwise -EINVAL
+ */
+int lease_read_to_write(struct oplock_info *opinfo)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(lease->state & SMB2_LEASE_READ_CACHING_LE)) {
+		ksmbd_debug(OPLOCK, "bad lease state(0x%x)\n",
+				lease->state);
+		return -EINVAL;
+	}
+
+	lease->new_state = SMB2_LEASE_NONE_LE;
+	lease->state |= SMB2_LEASE_WRITE_CACHING_LE;
+	if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_BATCH;
+	else
+		opinfo->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	return 0;
+}
+
+/**
+ * lease_none_upgrade() - upgrade lease state from none
+ * @opinfo:	current lease info
+ * @new_state:	new lease state
+ *
+ * Return:	0 on success, otherwise -EINVAL
+ */
+static int lease_none_upgrade(struct oplock_info *opinfo,
+	__le32 new_state)
+{
+	struct lease *lease = opinfo->o_lease;
+
+	if (!(lease->state == SMB2_LEASE_NONE_LE)) {
+		ksmbd_debug(OPLOCK, "bad lease state(0x%x)\n",
+				lease->state);
+		return -EINVAL;
+	}
+
+	lease->new_state = SMB2_LEASE_NONE_LE;
+	lease->state = new_state;
+	if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+			opinfo->level = SMB2_OPLOCK_LEVEL_BATCH;
+		else
+			opinfo->level = SMB2_OPLOCK_LEVEL_II;
+	else if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	else if (lease->state & SMB2_LEASE_READ_CACHING_LE)
+		opinfo->level = SMB2_OPLOCK_LEVEL_II;
+
+	return 0;
+}
+
+/**
+ * close_id_del_oplock() - release oplock object at file close time
+ * @fp:		ksmbd file pointer
+ */
+void close_id_del_oplock(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo;
+
+	if (S_ISDIR(file_inode(fp->filp)->i_mode))
+		return;
+
+	opinfo = opinfo_get(fp);
+	if (!opinfo)
+		return;
+
+	opinfo_del(opinfo);
+
+	rcu_assign_pointer(fp->f_opinfo, NULL);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		opinfo->op_state = OPLOCK_CLOSING;
+		wake_up_interruptible_all(&opinfo->oplock_q);
+		if (opinfo->is_lease) {
+			atomic_set(&opinfo->breaking_cnt, 0);
+			wake_up_interruptible_all(&opinfo->oplock_brk);
+		}
+	}
+
+	opinfo_count_dec(fp);
+	atomic_dec(&opinfo->refcount);
+	opinfo_put(opinfo);
+}
+
+/**
+ * grant_write_oplock() - grant exclusive/batch oplock or write lease
+ * @opinfo_new:	new oplock info object
+ * @req_oplock: request oplock
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_write_oplock(struct oplock_info *opinfo_new, int req_oplock,
+	struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	if (req_oplock == SMB2_OPLOCK_LEVEL_BATCH)
+		opinfo_new->level = SMB2_OPLOCK_LEVEL_BATCH;
+	else
+		opinfo_new->level = SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+
+	if (lctx) {
+		lease->state = lctx->req_state;
+		memcpy(lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+/**
+ * grant_read_oplock() - grant level2 oplock or read lease
+ * @opinfo_new:	new oplock info object
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_read_oplock(struct oplock_info *opinfo_new,
+	struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	opinfo_new->level = SMB2_OPLOCK_LEVEL_II;
+
+	if (lctx) {
+		lease->state = SMB2_LEASE_READ_CACHING_LE;
+		if (lctx->req_state & SMB2_LEASE_HANDLE_CACHING_LE)
+			lease->state |= SMB2_LEASE_HANDLE_CACHING_LE;
+		memcpy(lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+/**
+ * grant_none_oplock() - grant none oplock or none lease
+ * @opinfo_new:	new oplock info object
+ * @lctx:	lease context information
+ *
+ * Return:      0
+ */
+static void grant_none_oplock(struct oplock_info *opinfo_new,
+	struct lease_ctx_info *lctx)
+{
+	struct lease *lease = opinfo_new->o_lease;
+
+	opinfo_new->level = SMB2_OPLOCK_LEVEL_NONE;
+
+	if (lctx) {
+		lease->state = 0;
+		memcpy(lease->lease_key, lctx->lease_key,
+			SMB2_LEASE_KEY_SIZE);
+	}
+}
+
+static inline int compare_guid_key(struct oplock_info *opinfo,
+		const char *guid1, const char *key1)
+{
+	const char *guid2, *key2;
+
+	guid2 = opinfo->conn->ClientGUID;
+	key2 = opinfo->o_lease->lease_key;
+	if (!memcmp(guid1, guid2, SMB2_CLIENT_GUID_SIZE) &&
+			!memcmp(key1, key2, SMB2_LEASE_KEY_SIZE))
+		return 1;
+
+	return 0;
+}
+
+/**
+ * same_client_has_lease() - check whether current lease request is
+ *		from lease owner of file
+ * @ci:		master file pointer
+ * @client_guid:	Client GUID
+ * @lctx:		lease context information
+ *
+ * Return:      oplock(lease) object on success, otherwise NULL
+ */
+static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
+	char *client_guid, struct lease_ctx_info *lctx)
+{
+	int ret;
+	struct lease *lease;
+	struct oplock_info *opinfo;
+	struct oplock_info *m_opinfo = NULL;
+
+	if (!lctx)
+		return NULL;
+
+	/*
+	 * Compare lease key and client_guid to know request from same owner
+	 * of same client
+	 */
+	read_lock(&ci->m_lock);
+	list_for_each_entry(opinfo, &ci->m_op_list, op_entry) {
+		if (!opinfo->is_lease)
+			continue;
+		read_unlock(&ci->m_lock);
+		lease = opinfo->o_lease;
+
+		ret = compare_guid_key(opinfo, client_guid, lctx->lease_key);
+		if (ret) {
+			m_opinfo = opinfo;
+			/* skip upgrading lease about breaking lease */
+			if (atomic_read(&opinfo->breaking_cnt)) {
+				read_lock(&ci->m_lock);
+				continue;
+			}
+
+			/* upgrading lease */
+			if ((atomic_read(&ci->op_count) +
+			     atomic_read(&ci->sop_count)) == 1) {
+				if (lease->state ==
+					(lctx->req_state & lease->state)) {
+					lease->state |= lctx->req_state;
+					if (lctx->req_state &
+						SMB2_LEASE_WRITE_CACHING_LE)
+						lease_read_to_write(opinfo);
+				}
+			} else if ((atomic_read(&ci->op_count) +
+				    atomic_read(&ci->sop_count)) > 1) {
+				if (lctx->req_state ==
+					(SMB2_LEASE_READ_CACHING_LE |
+					 SMB2_LEASE_HANDLE_CACHING_LE))
+					lease->state = lctx->req_state;
+			}
+
+			if (lctx->req_state && lease->state ==
+					SMB2_LEASE_NONE_LE)
+				lease_none_upgrade(opinfo, lctx->req_state);
+		}
+		read_lock(&ci->m_lock);
+	}
+	read_unlock(&ci->m_lock);
+
+	return m_opinfo;
+}
+
+static void wait_for_break_ack(struct oplock_info *opinfo)
+{
+	int rc = 0;
+
+	rc = wait_event_interruptible_timeout(opinfo->oplock_q,
+		opinfo->op_state == OPLOCK_STATE_NONE ||
+		opinfo->op_state == OPLOCK_CLOSING,
+		OPLOCK_WAIT_TIME);
+
+	/* is this a timeout ? */
+	if (!rc) {
+		if (opinfo->is_lease)
+			opinfo->o_lease->state = SMB2_LEASE_NONE_LE;
+		opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+		opinfo->op_state = OPLOCK_STATE_NONE;
+	}
+}
+
+static void wake_up_oplock_break(struct oplock_info *opinfo)
+{
+	clear_bit_unlock(0, &opinfo->pending_break);
+	/* memory barrier is needed for wake_up_bit() */
+	smp_mb__after_atomic();
+	wake_up_bit(&opinfo->pending_break, 0);
+}
+
+static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
+{
+	while (test_and_set_bit(0, &opinfo->pending_break)) {
+		wait_on_bit(&opinfo->pending_break, 0, TASK_UNINTERRUPTIBLE);
+
+		/* Not immediately break to none. */
+		opinfo->open_trunc = 0;
+
+		if (opinfo->op_state == OPLOCK_CLOSING)
+			return -ENOENT;
+		else if (!opinfo->is_lease && opinfo->level <= req_op_level)
+			return 1;
+	}
+
+	if (!opinfo->is_lease && opinfo->level <= req_op_level) {
+		wake_up_oplock_break(opinfo);
+		return 1;
+	}
+	return 0;
+}
+
+static inline int allocate_oplock_break_buf(struct ksmbd_work *work)
+{
+	work->response_buf = ksmbd_alloc_response(MAX_CIFS_SMALL_BUFFER_SIZE);
+	if (!work->response_buf)
+		return -ENOMEM;
+	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	return 0;
+}
+
+/**
+ * __smb2_oplock_break_noti() - send smb2 oplock break cmd from conn
+ * to client
+ * @wk:     smb work object
+ *
+ * There are two ways this function can be called. 1- while file open we break
+ * from exclusive/batch lock to levelII oplock and 2- while file write/truncate
+ * we break from levelII oplock no oplock.
+ * REQUEST_BUF(work) contains oplock_info.
+ */
+static void __smb2_oplock_break_noti(struct work_struct *wk)
+{
+	struct smb2_oplock_break *rsp = NULL;
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct ksmbd_conn *conn = work->conn;
+	struct oplock_break_info *br_info = REQUEST_BUF(work);
+	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_file *fp;
+
+	fp = ksmbd_lookup_durable_fd(br_info->fid);
+	if (!fp) {
+		atomic_dec(&conn->r_count);
+		ksmbd_free_work_struct(work);
+		return;
+	}
+
+	if (allocate_oplock_break_buf(work)) {
+		ksmbd_err("smb2_allocate_rsp_buf failed! ");
+		atomic_dec(&conn->r_count);
+		ksmbd_fd_put(work, fp);
+		ksmbd_free_work_struct(work);
+		return;
+	}
+
+	rsp_hdr = RESPONSE_BUF(work);
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length = cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(0);
+	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = cpu_to_le64(-1);
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+
+	rsp = RESPONSE_BUF(work);
+
+	rsp->StructureSize = cpu_to_le16(24);
+	if (!br_info->open_trunc &&
+			(br_info->level == SMB2_OPLOCK_LEVEL_BATCH ||
+			br_info->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_II;
+	else
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	rsp->Reserved = 0;
+	rsp->Reserved2 = 0;
+	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
+	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
+
+	inc_rfc1001_len(rsp, 24);
+
+	ksmbd_debug(OPLOCK,
+		"sending oplock break v_id %llu p_id = %llu lock level = %d\n",
+		rsp->VolatileFid, rsp->PersistentFid, rsp->OplockLevel);
+
+	ksmbd_fd_put(work, fp);
+	ksmbd_conn_write(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * smb2_oplock_break_noti() - send smb2 exclusive/batch to level2 oplock
+ *		break command from server to client
+ * @opinfo:		oplock info object
+ *
+ * Return:      0 on success, otherwise error
+ */
+static int smb2_oplock_break_noti(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn = opinfo->conn;
+	struct oplock_break_info *br_info;
+	int ret = 0;
+	struct ksmbd_work *work = ksmbd_alloc_work_struct();
+
+	if (!work)
+		return -ENOMEM;
+
+	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
+	if (!br_info) {
+		ksmbd_free_work_struct(work);
+		return -ENOMEM;
+	}
+
+	br_info->level = opinfo->level;
+	br_info->fid = opinfo->fid;
+	br_info->open_trunc = opinfo->open_trunc;
+
+	work->request_buf = (char *)br_info;
+	work->conn = conn;
+	work->sess = opinfo->sess;
+
+	atomic_inc(&conn->r_count);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		INIT_WORK(&work->work, __smb2_oplock_break_noti);
+		ksmbd_queue_work(work);
+
+		wait_for_break_ack(opinfo);
+	} else {
+		__smb2_oplock_break_noti(&work->work);
+		if (opinfo->level == SMB2_OPLOCK_LEVEL_II)
+			opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+	}
+	return ret;
+}
+
+/**
+ * __smb2_lease_break_noti() - send lease break command from server
+ * to client
+ * @wk:     smb work object
+ */
+static void __smb2_lease_break_noti(struct work_struct *wk)
+{
+	struct smb2_lease_break *rsp = NULL;
+	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
+	struct lease_break_info *br_info = REQUEST_BUF(work);
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp_hdr;
+
+	if (allocate_oplock_break_buf(work)) {
+		ksmbd_debug(OPLOCK, "smb2_allocate_rsp_buf failed! ");
+		ksmbd_free_work_struct(work);
+		atomic_dec(&conn->r_count);
+		return;
+	}
+
+	rsp_hdr = RESPONSE_BUF(work);
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length = cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(0);
+	rsp_hdr->Command = SMB2_OPLOCK_BREAK;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = cpu_to_le64(-1);
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+	rsp = RESPONSE_BUF(work);
+	rsp->StructureSize = cpu_to_le16(44);
+	rsp->Reserved = 0;
+	rsp->Flags = 0;
+
+	if (br_info->curr_state & (SMB2_LEASE_WRITE_CACHING_LE |
+			SMB2_LEASE_HANDLE_CACHING_LE))
+		rsp->Flags = SMB2_NOTIFY_BREAK_LEASE_FLAG_ACK_REQUIRED;
+
+	memcpy(rsp->LeaseKey, br_info->lease_key, SMB2_LEASE_KEY_SIZE);
+	rsp->CurrentLeaseState = br_info->curr_state;
+	rsp->NewLeaseState = br_info->new_state;
+	rsp->BreakReason = 0;
+	rsp->AccessMaskHint = 0;
+	rsp->ShareMaskHint = 0;
+
+	inc_rfc1001_len(rsp, 44);
+
+	ksmbd_conn_write(work);
+	ksmbd_free_work_struct(work);
+	atomic_dec(&conn->r_count);
+}
+
+/**
+ * smb2_lease_break_noti() - break lease when a new client request
+ *			write lease
+ * @opinfo:		conains lease state information
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_lease_break_noti(struct oplock_info *opinfo)
+{
+	struct ksmbd_conn *conn = opinfo->conn;
+	struct list_head *tmp, *t;
+	struct ksmbd_work *work;
+	struct lease_break_info *br_info;
+	struct lease *lease = opinfo->o_lease;
+
+	work = ksmbd_alloc_work_struct();
+	if (!work)
+		return -ENOMEM;
+
+	br_info = kmalloc(sizeof(struct lease_break_info), GFP_KERNEL);
+	if (!br_info) {
+		ksmbd_free_work_struct(work);
+		return -ENOMEM;
+	}
+
+	br_info->curr_state = lease->state;
+	br_info->new_state = lease->new_state;
+	memcpy(br_info->lease_key, lease->lease_key, SMB2_LEASE_KEY_SIZE);
+
+	work->request_buf = (char *)br_info;
+	work->conn = conn;
+	work->sess = opinfo->sess;
+
+	atomic_inc(&conn->r_count);
+	if (opinfo->op_state == OPLOCK_ACK_WAIT) {
+		list_for_each_safe(tmp, t, &opinfo->interim_list) {
+			struct ksmbd_work *in_work;
+
+			in_work = list_entry(tmp, struct ksmbd_work,
+				interim_entry);
+			setup_async_work(in_work, NULL, NULL);
+			smb2_send_interim_resp(in_work, STATUS_PENDING);
+			list_del(&in_work->interim_entry);
+		}
+		INIT_WORK(&work->work, __smb2_lease_break_noti);
+		ksmbd_queue_work(work);
+		wait_for_break_ack(opinfo);
+	} else {
+		__smb2_lease_break_noti(&work->work);
+		if (opinfo->o_lease->new_state == SMB2_LEASE_NONE_LE) {
+			opinfo->level = SMB2_OPLOCK_LEVEL_NONE;
+			opinfo->o_lease->state = SMB2_LEASE_NONE_LE;
+		}
+	}
+	return 0;
+}
+
+static void wait_lease_breaking(struct oplock_info *opinfo)
+{
+	if (!opinfo->is_lease)
+		return;
+
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+	if (atomic_read(&opinfo->breaking_cnt)) {
+		int ret = 0;
+
+		ret = wait_event_interruptible_timeout(
+			opinfo->oplock_brk,
+			atomic_read(&opinfo->breaking_cnt) == 0,
+			HZ);
+		if (!ret)
+			atomic_set(&opinfo->breaking_cnt, 0);
+	}
+}
+
+static int oplock_break(struct oplock_info *brk_opinfo, int req_op_level)
+{
+	int err = 0;
+
+	/* Need to break exclusive/batch oplock, write lease or overwrite_if */
+	ksmbd_debug(OPLOCK,
+		"request to send oplock(level : 0x%x) break notification\n",
+		brk_opinfo->level);
+
+	if (brk_opinfo->is_lease) {
+		struct lease *lease = brk_opinfo->o_lease;
+
+		atomic_inc(&brk_opinfo->breaking_cnt);
+
+		err = oplock_break_pending(brk_opinfo, req_op_level);
+		if (err)
+			return err < 0 ? err : 0;
+
+		if (brk_opinfo->open_trunc) {
+			/*
+			 * Create overwrite break trigger the lease break to
+			 * none.
+			 */
+			lease->new_state = SMB2_LEASE_NONE_LE;
+		} else {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE) {
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE |
+						SMB2_LEASE_HANDLE_CACHING_LE;
+				else
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE;
+			} else {
+				if (lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+					lease->new_state =
+						SMB2_LEASE_READ_CACHING_LE;
+				else
+					lease->new_state = SMB2_LEASE_NONE_LE;
+			}
+		}
+
+		if (lease->state & (SMB2_LEASE_WRITE_CACHING_LE |
+				SMB2_LEASE_HANDLE_CACHING_LE))
+			brk_opinfo->op_state = OPLOCK_ACK_WAIT;
+		else
+			atomic_dec(&brk_opinfo->breaking_cnt);
+	} else {
+		err = oplock_break_pending(brk_opinfo, req_op_level);
+		if (err)
+			return err < 0 ? err : 0;
+
+		if (brk_opinfo->level == SMB2_OPLOCK_LEVEL_BATCH ||
+			brk_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)
+			brk_opinfo->op_state = OPLOCK_ACK_WAIT;
+	}
+
+	if (brk_opinfo->is_lease)
+		err = smb2_lease_break_noti(brk_opinfo);
+	else
+		err = smb2_oplock_break_noti(brk_opinfo);
+
+	ksmbd_debug(OPLOCK, "oplock granted = %d\n", brk_opinfo->level);
+	if (brk_opinfo->op_state == OPLOCK_CLOSING)
+		err = -ENOENT;
+	wake_up_oplock_break(brk_opinfo);
+
+	wait_lease_breaking(brk_opinfo);
+
+	return err;
+}
+
+void destroy_lease_table(struct ksmbd_conn *conn)
+{
+	struct lease_table *lb, *lbtmp;
+	struct oplock_info *opinfo;
+
+	write_lock(&lease_list_lock);
+	if (list_empty(&lease_table_list)) {
+		write_unlock(&lease_list_lock);
+		return;
+	}
+
+	list_for_each_entry_safe(lb, lbtmp, &lease_table_list, l_entry) {
+		if (conn && memcmp(lb->client_guid, conn->ClientGUID,
+			SMB2_CLIENT_GUID_SIZE))
+			continue;
+again:
+		rcu_read_lock();
+		list_for_each_entry_rcu(opinfo, &lb->lease_list,
+				lease_entry) {
+			rcu_read_unlock();
+			lease_del_list(opinfo);
+			goto again;
+		}
+		rcu_read_unlock();
+		list_del(&lb->l_entry);
+		kfree(lb);
+	}
+	write_unlock(&lease_list_lock);
+}
+
+int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
+		struct lease_ctx_info *lctx)
+{
+	struct oplock_info *opinfo;
+	int err = 0;
+	struct lease_table *lb;
+
+	if (!lctx)
+		return err;
+
+	read_lock(&lease_list_lock);
+	if (list_empty(&lease_table_list)) {
+		read_unlock(&lease_list_lock);
+		return 0;
+	}
+
+	list_for_each_entry(lb, &lease_table_list, l_entry) {
+		if (!memcmp(lb->client_guid, sess->conn->ClientGUID,
+					SMB2_CLIENT_GUID_SIZE))
+			goto found;
+	}
+	read_unlock(&lease_list_lock);
+
+	return 0;
+
+found:
+	rcu_read_lock();
+	list_for_each_entry_rcu(opinfo, &lb->lease_list,
+			lease_entry) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			continue;
+		rcu_read_unlock();
+		if (opinfo->o_fp->f_ci == ci)
+			goto op_next;
+		err = compare_guid_key(opinfo,
+				sess->conn->ClientGUID,
+				lctx->lease_key);
+		if (err) {
+			err = -EINVAL;
+			ksmbd_debug(OPLOCK,
+				"found same lease key is already used in other files\n");
+			opinfo_put(opinfo);
+			goto out;
+		}
+op_next:
+		opinfo_put(opinfo);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+out:
+	read_unlock(&lease_list_lock);
+	return err;
+}
+
+static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
+{
+	struct lease *lease1 = op1->o_lease;
+	struct lease *lease2 = op2->o_lease;
+
+	op2->level = op1->level;
+	lease2->state = lease1->state;
+	memcpy(lease2->lease_key, lease1->lease_key,
+		SMB2_LEASE_KEY_SIZE);
+	lease2->duration = lease1->duration;
+	lease2->flags = lease1->flags;
+}
+
+static int add_lease_global_list(struct oplock_info *opinfo)
+{
+	struct lease_table *lb;
+
+	read_lock(&lease_list_lock);
+	list_for_each_entry(lb, &lease_table_list, l_entry) {
+		if (!memcmp(lb->client_guid, opinfo->conn->ClientGUID,
+			SMB2_CLIENT_GUID_SIZE)) {
+			opinfo->o_lease->l_lb = lb;
+			lease_add_list(opinfo);
+			read_unlock(&lease_list_lock);
+			return 0;
+		}
+	}
+	read_unlock(&lease_list_lock);
+
+	lb = kmalloc(sizeof(struct lease_table), GFP_KERNEL);
+	if (!lb)
+		return -ENOMEM;
+
+	memcpy(lb->client_guid, opinfo->conn->ClientGUID,
+			SMB2_CLIENT_GUID_SIZE);
+	INIT_LIST_HEAD(&lb->lease_list);
+	spin_lock_init(&lb->lb_lock);
+	opinfo->o_lease->l_lb = lb;
+	lease_add_list(opinfo);
+	lb_add(lb);
+	return 0;
+}
+
+static void set_oplock_level(struct oplock_info *opinfo, int level,
+	struct lease_ctx_info *lctx)
+{
+	switch (level) {
+	case SMB2_OPLOCK_LEVEL_BATCH:
+	case SMB2_OPLOCK_LEVEL_EXCLUSIVE:
+		grant_write_oplock(opinfo,
+			level, lctx);
+		break;
+	case SMB2_OPLOCK_LEVEL_II:
+		grant_read_oplock(opinfo, lctx);
+		break;
+	default:
+		grant_none_oplock(opinfo, lctx);
+		break;
+	}
+}
+
+/**
+ * smb_grant_oplock() - handle oplock/lease request on file open
+ * @work:		smb work
+ * @req_op_level:	oplock level
+ * @pid:		id of open file
+ * @fp:			ksmbd file pointer
+ * @tid:		Tree id of connection
+ * @lctx:		lease context information on file open
+ * @share_ret:		share mode
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb_grant_oplock(struct ksmbd_work *work,
+		     int req_op_level,
+		     uint64_t pid,
+		     struct ksmbd_file *fp,
+		     __u16 tid,
+		     struct lease_ctx_info *lctx,
+		     int share_ret)
+{
+	struct ksmbd_session *sess = work->sess;
+	int err = 0;
+	struct oplock_info *opinfo = NULL, *prev_opinfo = NULL;
+	struct ksmbd_inode *ci = fp->f_ci;
+	bool prev_op_has_lease;
+	__le32 prev_op_state = 0;
+
+	/* not support directory lease */
+	if (S_ISDIR(file_inode(fp->filp)->i_mode)) {
+		if (lctx)
+			lctx->dlease = 1;
+		return 0;
+	}
+
+	opinfo = alloc_opinfo(work, pid, tid);
+	if (!opinfo)
+		return -ENOMEM;
+
+	if (lctx) {
+		err = alloc_lease(opinfo, lctx);
+		if (err)
+			goto err_out;
+		opinfo->is_lease = 1;
+	}
+
+	/* ci does not have any oplock */
+	if (!opinfo_count(fp))
+		goto set_lev;
+
+	/* grant none-oplock if second open is trunc */
+	if (ATTR_FP(fp)) {
+		req_op_level = SMB2_OPLOCK_LEVEL_NONE;
+		goto set_lev;
+	}
+
+	if (lctx) {
+		struct oplock_info *m_opinfo;
+
+		/* is lease already granted ? */
+		m_opinfo = same_client_has_lease(ci, sess->conn->ClientGUID,
+			lctx);
+		if (m_opinfo) {
+			copy_lease(m_opinfo, opinfo);
+			if (atomic_read(&m_opinfo->breaking_cnt))
+				opinfo->o_lease->flags =
+					SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE;
+			goto out;
+		}
+	}
+	prev_opinfo = opinfo_get_list(ci);
+	if (!prev_opinfo ||
+	    (prev_opinfo->level == SMB2_OPLOCK_LEVEL_NONE && lctx))
+		goto set_lev;
+	prev_op_has_lease = prev_opinfo->is_lease;
+	if (prev_op_has_lease)
+		prev_op_state = prev_opinfo->o_lease->state;
+
+	if (share_ret < 0 &&
+		(prev_opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)) {
+		err = share_ret;
+		opinfo_put(prev_opinfo);
+		goto err_out;
+	}
+
+	if ((prev_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH) &&
+		(prev_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE)) {
+		opinfo_put(prev_opinfo);
+		goto op_break_not_needed;
+	}
+
+	list_add(&work->interim_entry, &prev_opinfo->interim_list);
+	err = oplock_break(prev_opinfo, SMB2_OPLOCK_LEVEL_II);
+	opinfo_put(prev_opinfo);
+	if (err == -ENOENT)
+		goto set_lev;
+	/* Check all oplock was freed by close */
+	else if (err < 0)
+		goto err_out;
+
+op_break_not_needed:
+	if (share_ret < 0) {
+		err = share_ret;
+		goto err_out;
+	}
+
+	if (req_op_level != SMB2_OPLOCK_LEVEL_NONE)
+		req_op_level = SMB2_OPLOCK_LEVEL_II;
+
+	/* grant fixed oplock on stacked locking between lease and oplock */
+	if (prev_op_has_lease && !lctx)
+		if (prev_op_state & SMB2_LEASE_HANDLE_CACHING_LE)
+			req_op_level = SMB2_OPLOCK_LEVEL_NONE;
+
+	if (!prev_op_has_lease && lctx) {
+		req_op_level = SMB2_OPLOCK_LEVEL_II;
+		lctx->req_state = SMB2_LEASE_READ_CACHING_LE;
+	}
+
+set_lev:
+	set_oplock_level(opinfo, req_op_level, lctx);
+
+out:
+	rcu_assign_pointer(fp->f_opinfo, opinfo);
+	opinfo->o_fp = fp;
+
+	opinfo_count_inc(fp);
+	opinfo_add(opinfo);
+	if (opinfo->is_lease) {
+		err = add_lease_global_list(opinfo);
+		if (err)
+			goto err_out;
+	}
+
+	return 0;
+err_out:
+	free_opinfo(opinfo);
+	return err;
+}
+
+/**
+ * smb_break_all_write_oplock() - break batch/exclusive oplock to level2
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ * @is_trunc:	truncate on open
+ */
+static void smb_break_all_write_oplock(struct ksmbd_work *work,
+	struct ksmbd_file *fp, int is_trunc)
+{
+	struct oplock_info *brk_opinfo;
+
+	brk_opinfo = opinfo_get_list(fp->f_ci);
+	if (!brk_opinfo)
+		return;
+	if (brk_opinfo->level != SMB2_OPLOCK_LEVEL_BATCH &&
+		brk_opinfo->level != SMB2_OPLOCK_LEVEL_EXCLUSIVE) {
+		opinfo_put(brk_opinfo);
+		return;
+	}
+
+	brk_opinfo->open_trunc = is_trunc;
+	list_add(&work->interim_entry, &brk_opinfo->interim_list);
+	oplock_break(brk_opinfo, SMB2_OPLOCK_LEVEL_II);
+	opinfo_put(brk_opinfo);
+}
+
+/**
+ * smb_break_all_levII_oplock() - send level2 oplock or read lease break command
+ *	from server to client
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ * @is_trunc:	truncate on open
+ */
+void smb_break_all_levII_oplock(struct ksmbd_work *work,
+	struct ksmbd_file *fp, int is_trunc)
+{
+	struct oplock_info *op, *brk_op;
+	struct ksmbd_inode *ci;
+	struct ksmbd_conn *conn = work->sess->conn;
+
+	if (!test_share_config_flag(work->tcon->share_conf,
+			KSMBD_SHARE_FLAG_OPLOCKS)) {
+		return;
+	}
+
+	ci = fp->f_ci;
+	op = opinfo_get(fp);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
+		if (!atomic_inc_not_zero(&brk_op->refcount))
+			continue;
+		rcu_read_unlock();
+		if (brk_op->is_lease && (brk_op->o_lease->state &
+		    (~(SMB2_LEASE_READ_CACHING_LE |
+				SMB2_LEASE_HANDLE_CACHING_LE)))) {
+			ksmbd_debug(OPLOCK, "unexpected lease state(0x%x)\n",
+					brk_op->o_lease->state);
+			goto next;
+		} else if (brk_op->level !=
+				SMB2_OPLOCK_LEVEL_II) {
+			ksmbd_debug(OPLOCK, "unexpected oplock(0x%x)\n",
+					brk_op->level);
+			goto next;
+		}
+
+		/* Skip oplock being break to none */
+		if (brk_op->is_lease && (brk_op->o_lease->new_state ==
+				SMB2_LEASE_NONE_LE) &&
+		    atomic_read(&brk_op->breaking_cnt))
+			goto next;
+
+		if (op && op->is_lease &&
+			brk_op->is_lease &&
+			!memcmp(conn->ClientGUID, brk_op->conn->ClientGUID,
+				SMB2_CLIENT_GUID_SIZE) &&
+			!memcmp(op->o_lease->lease_key,
+				brk_op->o_lease->lease_key,
+				SMB2_LEASE_KEY_SIZE))
+			goto next;
+		brk_op->open_trunc = is_trunc;
+		oplock_break(brk_op, SMB2_OPLOCK_LEVEL_NONE);
+next:
+		opinfo_put(brk_op);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+	if (op)
+		opinfo_put(op);
+}
+
+/**
+ * smb_break_all_oplock() - break both batch/exclusive and level2 oplock
+ * @work:	smb work
+ * @fp:		ksmbd file pointer
+ */
+void smb_break_all_oplock(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	if (!test_share_config_flag(work->tcon->share_conf,
+			KSMBD_SHARE_FLAG_OPLOCKS))
+		return;
+
+	smb_break_all_write_oplock(work, fp, 1);
+	smb_break_all_levII_oplock(work, fp, 1);
+}
+
+/**
+ * smb2_map_lease_to_oplock() - map lease state to corresponding oplock type
+ * @lease_state:     lease type
+ *
+ * Return:      0 if no mapping, otherwise corresponding oplock type
+ */
+__u8 smb2_map_lease_to_oplock(__le32 lease_state)
+{
+	if (lease_state == (SMB2_LEASE_HANDLE_CACHING_LE |
+		SMB2_LEASE_READ_CACHING_LE | SMB2_LEASE_WRITE_CACHING_LE))
+		return SMB2_OPLOCK_LEVEL_BATCH;
+	else if (lease_state != SMB2_LEASE_WRITE_CACHING_LE &&
+		lease_state & SMB2_LEASE_WRITE_CACHING_LE) {
+		if (!(lease_state & SMB2_LEASE_HANDLE_CACHING_LE))
+			return SMB2_OPLOCK_LEVEL_EXCLUSIVE;
+	} else if (lease_state & SMB2_LEASE_READ_CACHING_LE)
+		return SMB2_OPLOCK_LEVEL_II;
+	return 0;
+}
+
+/**
+ * create_lease_buf() - create lease context for open cmd response
+ * @rbuf:	buffer to create lease context response
+ * @lease:	buffer to stored parsed lease state information
+ */
+void create_lease_buf(u8 *rbuf, struct lease *lease)
+{
+	struct create_lease *buf = (struct create_lease *)rbuf;
+	char *LeaseKey = (char *)&lease->lease_key;
+
+	memset(buf, 0, sizeof(struct create_lease));
+	buf->lcontext.LeaseKeyLow = *((__le64 *)LeaseKey);
+	buf->lcontext.LeaseKeyHigh = *((__le64 *)(LeaseKey + 8));
+	buf->lcontext.LeaseFlags = lease->flags;
+	buf->lcontext.LeaseState = lease->state;
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+					(struct create_lease, lcontext));
+	buf->ccontext.DataLength = cpu_to_le32(sizeof(struct lease_context));
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+				(struct create_lease, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	buf->Name[0] = 'R';
+	buf->Name[1] = 'q';
+	buf->Name[2] = 'L';
+	buf->Name[3] = 's';
+}
+
+/**
+ * parse_lease_state() - parse lease context containted in file open request
+ * @open_req:	buffer containing smb2 file open(create) request
+ *
+ * Return:  oplock state, -ENOENT if create lease context not found
+ */
+struct lease_ctx_info *parse_lease_state(void *open_req)
+{
+	char *data_offset;
+	struct create_context *cc;
+	unsigned int next = 0;
+	char *name;
+	bool found = false;
+	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
+	struct lease_ctx_info *lreq = kzalloc(sizeof(struct lease_ctx_info),
+		GFP_KERNEL);
+	if (!lreq)
+		return NULL;
+
+	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	cc = (struct create_context *)data_offset;
+	do {
+		cc = (struct create_context *)((char *)cc + next);
+		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
+		if (le16_to_cpu(cc->NameLength) != 4 ||
+				strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+			next = le32_to_cpu(cc->Next);
+			continue;
+		}
+		found = true;
+		break;
+	} while (next != 0);
+
+	if (found) {
+		struct create_lease *lc = (struct create_lease *)cc;
+		*((__le64 *)lreq->lease_key) = lc->lcontext.LeaseKeyLow;
+		*((__le64 *)(lreq->lease_key + 8)) = lc->lcontext.LeaseKeyHigh;
+		lreq->req_state = lc->lcontext.LeaseState;
+		lreq->flags = lc->lcontext.LeaseFlags;
+		lreq->duration = lc->lcontext.LeaseDuration;
+		return lreq;
+	}
+
+	kfree(lreq);
+	return NULL;
+}
+
+/**
+ * smb2_find_context_vals() - find a particular context info in open request
+ * @open_req:	buffer containing smb2 file open(create) request
+ * @tag:	context name to search for
+ *
+ * Return:      pointer to requested context, NULL if @str context not found
+ */
+struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
+{
+	char *data_offset;
+	struct create_context *cc;
+	unsigned int next = 0;
+	char *name;
+	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
+
+	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	cc = (struct create_context *)data_offset;
+	do {
+		int val;
+
+		cc = (struct create_context *)((char *)cc + next);
+		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
+		val = le16_to_cpu(cc->NameLength);
+		if (val < 4)
+			return ERR_PTR(-EINVAL);
+
+		if (memcmp(name, tag, val) == 0)
+			return cc;
+		next = le32_to_cpu(cc->Next);
+	} while (next != 0);
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
+ * create_durable_rsp__buf() - create durable handle context
+ * @cc:	buffer to create durable context response
+ */
+void create_durable_rsp_buf(char *cc)
+{
+	struct create_durable_rsp *buf;
+
+	buf = (struct create_durable_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_durable_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Data));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_DURABLE_HANDLE_RESPONSE is "DHnQ" */
+	buf->Name[0] = 'D';
+	buf->Name[1] = 'H';
+	buf->Name[2] = 'n';
+	buf->Name[3] = 'Q';
+}
+
+/**
+ * create_durable_v2_rsp_buf() - create durable handle v2 context
+ * @cc:	buffer to create durable context response
+ * @fp: ksmbd file pointer
+ */
+void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
+{
+	struct create_durable_v2_rsp *buf;
+
+	buf = (struct create_durable_v2_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_durable_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Data));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_durable_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_DURABLE_HANDLE_RESPONSE_V2 is "DH2Q" */
+	buf->Name[0] = 'D';
+	buf->Name[1] = 'H';
+	buf->Name[2] = '2';
+	buf->Name[3] = 'Q';
+
+	buf->Timeout = cpu_to_le32(fp->durable_timeout);
+	if (fp->is_persistent)
+		buf->Flags = SMB2_FLAGS_REPLAY_OPERATIONS;
+}
+
+/**
+ * create_mxac_rsp_buf() - create query maximal access context
+ * @cc:			buffer to create maximal access context response
+ * @maximal_access:	maximal access
+ */
+void create_mxac_rsp_buf(char *cc, int maximal_access)
+{
+	struct create_mxac_rsp *buf;
+
+	buf = (struct create_mxac_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_mxac_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, QueryStatus));
+	buf->ccontext.DataLength = cpu_to_le32(8);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_QUERY_MAXIMAL_ACCESS_RESPONSE is "MxAc" */
+	buf->Name[0] = 'M';
+	buf->Name[1] = 'x';
+	buf->Name[2] = 'A';
+	buf->Name[3] = 'c';
+
+	buf->QueryStatus = STATUS_SUCCESS;
+	buf->MaximalAccess = cpu_to_le32(maximal_access);
+}
+
+void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id)
+{
+	struct create_disk_id_rsp *buf;
+
+	buf = (struct create_disk_id_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_disk_id_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_disk_id_rsp, DiskFileId));
+	buf->ccontext.DataLength = cpu_to_le32(32);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_mxac_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(4);
+	/* SMB2_CREATE_QUERY_ON_DISK_ID_RESPONSE is "QFid" */
+	buf->Name[0] = 'Q';
+	buf->Name[1] = 'F';
+	buf->Name[2] = 'i';
+	buf->Name[3] = 'd';
+
+	buf->DiskFileId = cpu_to_le64(file_id);
+	buf->VolumeId = cpu_to_le64(vol_id);
+}
+
+/**
+ * create_posix_rsp_buf() - create posix extension context
+ * @cc:	buffer to create posix on posix response
+ * @fp: ksmbd file pointer
+ */
+void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp)
+{
+	struct create_posix_rsp *buf;
+	struct inode *inode = FP_INODE(fp);
+
+	buf = (struct create_posix_rsp *)cc;
+	memset(buf, 0, sizeof(struct create_posix_rsp));
+	buf->ccontext.DataOffset = cpu_to_le16(offsetof
+			(struct create_posix_rsp, nlink));
+	buf->ccontext.DataLength = cpu_to_le32(52);
+	buf->ccontext.NameOffset = cpu_to_le16(offsetof
+			(struct create_posix_rsp, Name));
+	buf->ccontext.NameLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
+	buf->Name[0] = 0x93;
+	buf->Name[1] = 0xAD;
+	buf->Name[2] = 0x25;
+	buf->Name[3] = 0x50;
+	buf->Name[4] = 0x9C;
+	buf->Name[5] = 0xB4;
+	buf->Name[6] = 0x11;
+	buf->Name[7] = 0xE7;
+	buf->Name[8] = 0xB4;
+	buf->Name[9] = 0x23;
+	buf->Name[10] = 0x83;
+	buf->Name[11] = 0xDE;
+	buf->Name[12] = 0x96;
+	buf->Name[13] = 0x8B;
+	buf->Name[14] = 0xCD;
+	buf->Name[15] = 0x7C;
+
+	buf->nlink = cpu_to_le32(inode->i_nlink);
+	buf->reparse_tag = cpu_to_le32(fp->volatile_id);
+	buf->mode = cpu_to_le32(inode->i_mode);
+	id_to_sid(from_kuid(&init_user_ns, inode->i_uid),
+		SIDNFS_USER, (struct smb_sid *)&buf->SidBuffer[0]);
+	id_to_sid(from_kgid(&init_user_ns, inode->i_gid),
+		SIDNFS_GROUP, (struct smb_sid *)&buf->SidBuffer[20]);
+}
+
+/*
+ * Find lease object(opinfo) for given lease key/fid from lease
+ * break/file close path.
+ */
+/**
+ * lookup_lease_in_table() - find a matching lease info object
+ * @conn:	connection instance
+ * @lease_key:	lease key to be searched for
+ *
+ * Return:      opinfo if found matching opinfo, otherwise NULL
+ */
+struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
+	char *lease_key)
+{
+	struct oplock_info *opinfo = NULL, *ret_op = NULL;
+	struct lease_table *lt;
+	int ret;
+
+	read_lock(&lease_list_lock);
+	list_for_each_entry(lt, &lease_table_list, l_entry) {
+		if (!memcmp(lt->client_guid, conn->ClientGUID,
+			SMB2_CLIENT_GUID_SIZE))
+			goto found;
+	}
+
+	read_unlock(&lease_list_lock);
+	return NULL;
+
+found:
+	rcu_read_lock();
+	list_for_each_entry_rcu(opinfo, &lt->lease_list, lease_entry) {
+		if (!atomic_inc_not_zero(&opinfo->refcount))
+			continue;
+		rcu_read_unlock();
+		if (!opinfo->op_state ||
+			opinfo->op_state == OPLOCK_CLOSING)
+			goto op_next;
+		if (!(opinfo->o_lease->state &
+			(SMB2_LEASE_HANDLE_CACHING_LE |
+			 SMB2_LEASE_WRITE_CACHING_LE)))
+			goto op_next;
+		ret = compare_guid_key(opinfo, conn->ClientGUID,
+			lease_key);
+		if (ret) {
+			ksmbd_debug(OPLOCK, "found opinfo\n");
+			ret_op = opinfo;
+			goto out;
+		}
+op_next:
+		opinfo_put(opinfo);
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
+
+out:
+	read_unlock(&lease_list_lock);
+	return ret_op;
+}
+
+int smb2_check_durable_oplock(struct ksmbd_file *fp,
+	struct lease_ctx_info *lctx, char *name)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	int ret = 0;
+
+	if (opinfo && opinfo->is_lease) {
+		if (!lctx) {
+			ksmbd_err("open does not include lease\n");
+			ret = -EBADF;
+			goto out;
+		}
+		if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
+					SMB2_LEASE_KEY_SIZE)) {
+			ksmbd_err("invalid lease key\n");
+			ret = -EBADF;
+			goto out;
+		}
+		if (name && strcmp(fp->filename, name)) {
+			ksmbd_err("invalid name reconnect %s\n", name);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+out:
+	if (opinfo)
+		opinfo_put(opinfo);
+	return ret;
+}
diff --git a/fs/cifsd/oplock.h b/fs/cifsd/oplock.h
new file mode 100644
index 000000000000..b0e2e795f29a
--- /dev/null
+++ b/fs/cifsd/oplock.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_OPLOCK_H
+#define __KSMBD_OPLOCK_H
+
+#include "smb_common.h"
+
+#define OPLOCK_WAIT_TIME	(35*HZ)
+
+/* SMB Oplock levels */
+#define OPLOCK_NONE      0
+#define OPLOCK_EXCLUSIVE 1
+#define OPLOCK_BATCH     2
+#define OPLOCK_READ      3  /* level 2 oplock */
+
+/* SMB2 Oplock levels */
+#define SMB2_OPLOCK_LEVEL_NONE          0x00
+#define SMB2_OPLOCK_LEVEL_II            0x01
+#define SMB2_OPLOCK_LEVEL_EXCLUSIVE     0x08
+#define SMB2_OPLOCK_LEVEL_BATCH         0x09
+#define SMB2_OPLOCK_LEVEL_LEASE         0xFF
+
+/* Oplock states */
+#define OPLOCK_STATE_NONE	0x00
+#define OPLOCK_ACK_WAIT		0x01
+#define OPLOCK_CLOSING		0x02
+
+#define OPLOCK_WRITE_TO_READ		0x01
+#define OPLOCK_READ_HANDLE_TO_READ	0x02
+#define OPLOCK_WRITE_TO_NONE		0x04
+#define OPLOCK_READ_TO_NONE		0x08
+
+#define SMB2_LEASE_KEY_SIZE		16
+
+struct lease_ctx_info {
+	__u8	lease_key[SMB2_LEASE_KEY_SIZE];
+	__le32	req_state;
+	__le32	flags;
+	__le64	duration;
+	int dlease;
+};
+
+struct lease_table {
+	char			client_guid[SMB2_CLIENT_GUID_SIZE];
+	struct list_head	lease_list;
+	struct list_head	l_entry;
+	spinlock_t		lb_lock;
+};
+
+struct lease {
+	__u8			lease_key[SMB2_LEASE_KEY_SIZE];
+	__le32			state;
+	__le32			new_state;
+	__le32			flags;
+	__le64			duration;
+	struct lease_table	*l_lb;
+};
+
+struct oplock_info {
+	struct ksmbd_conn	*conn;
+	struct ksmbd_session	*sess;
+	struct ksmbd_work	*work;
+	struct ksmbd_file	*o_fp;
+	int                     level;
+	int                     op_state;
+	unsigned long		pending_break;
+	uint64_t                fid;
+	atomic_t		breaking_cnt;
+	atomic_t		refcount;
+	__u16                   Tid;
+	bool			is_lease;
+	bool			open_trunc;	/* truncate on open */
+	struct lease		*o_lease;
+	struct list_head        interim_list;
+	struct list_head        op_entry;
+	struct list_head        lease_entry;
+	wait_queue_head_t oplock_q; /* Other server threads */
+	wait_queue_head_t oplock_brk; /* oplock breaking wait */
+	struct rcu_head		rcu_head;
+};
+
+struct lease_break_info {
+	__le32			curr_state;
+	__le32			new_state;
+	char			lease_key[SMB2_LEASE_KEY_SIZE];
+};
+
+struct oplock_break_info {
+	int level;
+	int open_trunc;
+	int fid;
+};
+
+extern int smb_grant_oplock(struct ksmbd_work *work, int req_op_level,
+		uint64_t pid, struct ksmbd_file *fp, __u16 tid,
+		struct lease_ctx_info *lctx, int share_ret);
+extern void smb_break_all_levII_oplock(struct ksmbd_work *work,
+	struct ksmbd_file *fp, int is_trunc);
+
+int opinfo_write_to_read(struct oplock_info *opinfo);
+int opinfo_read_handle_to_read(struct oplock_info *opinfo);
+int opinfo_write_to_none(struct oplock_info *opinfo);
+int opinfo_read_to_none(struct oplock_info *opinfo);
+void close_id_del_oplock(struct ksmbd_file *fp);
+void smb_break_all_oplock(struct ksmbd_work *work, struct ksmbd_file *fp);
+struct oplock_info *opinfo_get(struct ksmbd_file *fp);
+void opinfo_put(struct oplock_info *opinfo);
+
+/* Lease related functions */
+void create_lease_buf(u8 *rbuf, struct lease *lease);
+struct lease_ctx_info *parse_lease_state(void *open_req);
+__u8 smb2_map_lease_to_oplock(__le32 lease_state);
+int lease_read_to_write(struct oplock_info *opinfo);
+
+/* Durable related functions */
+void create_durable_rsp_buf(char *cc);
+void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp);
+void create_mxac_rsp_buf(char *cc, int maximal_access);
+void create_disk_id_rsp_buf(char *cc, __u64 file_id, __u64 vol_id);
+void create_posix_rsp_buf(char *cc, struct ksmbd_file *fp);
+struct create_context *smb2_find_context_vals(void *open_req, const char *str);
+int ksmbd_durable_verify_and_del_oplock(struct ksmbd_session *curr_sess,
+					  struct ksmbd_session *prev_sess,
+					  int fid, struct file **filp,
+					  uint64_t sess_id);
+struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
+	char *lease_key);
+int find_same_lease_key(struct ksmbd_session *sess, struct ksmbd_inode *ci,
+	struct lease_ctx_info *lctx);
+void destroy_lease_table(struct ksmbd_conn *conn);
+int smb2_check_durable_oplock(struct ksmbd_file *fp,
+	struct lease_ctx_info *lctx, char *name);
+
+#endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/cifsd/smb2misc.c b/fs/cifsd/smb2misc.c
new file mode 100644
index 000000000000..485f431c776c
--- /dev/null
+++ b/fs/cifsd/smb2misc.c
@@ -0,0 +1,458 @@
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
+			(((struct smb2_err_rsp *)hdr)->StructureSize) ==
+			SMB2_ERROR_STRUCTURE_SIZE2_LE)
+		return NULL;
+
+	/*
+	 * Following commands have data areas so we have to get the location
+	 * of the data buffer offset and data buffer length for the particular
+	 * command.
+	 */
+	switch (hdr->Command) {
+	case SMB2_SESSION_SETUP:
+		*off = le16_to_cpu(
+		     ((struct smb2_sess_setup_req *)hdr)->SecurityBufferOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_sess_setup_req *)hdr)->SecurityBufferLength);
+		break;
+	case SMB2_TREE_CONNECT:
+		*off = le16_to_cpu(
+		     ((struct smb2_tree_connect_req *)hdr)->PathOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_tree_connect_req *)hdr)->PathLength);
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
+		*off = le16_to_cpu(
+		     ((struct smb2_create_req *)hdr)->NameOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_create_req *)hdr)->NameLength);
+		break;
+	}
+	case SMB2_QUERY_INFO:
+		*off = le16_to_cpu(
+		     ((struct smb2_query_info_req *)hdr)->InputBufferOffset);
+		*len = le32_to_cpu(
+		     ((struct smb2_query_info_req *)hdr)->InputBufferLength);
+		break;
+	case SMB2_SET_INFO:
+		*off = le16_to_cpu(
+		     ((struct smb2_set_info_req *)hdr)->BufferOffset);
+		*len = le32_to_cpu(
+		     ((struct smb2_set_info_req *)hdr)->BufferLength);
+		break;
+	case SMB2_READ:
+		*off = le16_to_cpu(
+		     ((struct smb2_read_req *)hdr)->ReadChannelInfoOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_read_req *)hdr)->ReadChannelInfoLength);
+		break;
+	case SMB2_WRITE:
+		if (((struct smb2_write_req *)hdr)->DataOffset) {
+			*off = le16_to_cpu(
+			     ((struct smb2_write_req *)hdr)->DataOffset);
+			*len = le32_to_cpu(
+				((struct smb2_write_req *)hdr)->Length);
+			break;
+		}
+
+		*off = le16_to_cpu(
+		     ((struct smb2_write_req *)hdr)->WriteChannelInfoOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_write_req *)hdr)->WriteChannelInfoLength);
+		break;
+	case SMB2_QUERY_DIRECTORY:
+		*off = le16_to_cpu(
+		     ((struct smb2_query_directory_req *)hdr)->FileNameOffset);
+		*len = le16_to_cpu(
+		     ((struct smb2_query_directory_req *)hdr)->FileNameLength);
+		break;
+	case SMB2_LOCK:
+	{
+		int lock_count;
+
+		/*
+		 * smb2_lock request size is 48 included single
+		 * smb2_lock_element structure size.
+		 */
+		lock_count = le16_to_cpu(
+			((struct smb2_lock_req *)hdr)->LockCount) - 1;
+		if (lock_count > 0) {
+			*off = __SMB2_HEADER_STRUCTURE_SIZE + 48;
+			*len = sizeof(struct smb2_lock_element) * lock_count;
+		}
+		break;
+	}
+	case SMB2_IOCTL:
+		*off = le32_to_cpu(
+		     ((struct smb2_ioctl_req *)hdr)->InputOffset);
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
+			*off);
+		*len = 0;
+		*off = 0;
+	} else if (*off < 0) {
+		ksmbd_debug(SMB,
+			"negative offset %d to data invalid ignore data area\n",
+			*off);
+		*off = 0;
+		*len = 0;
+	} else if (*len < 0) {
+		ksmbd_debug(SMB,
+			"negative data length %d invalid, data area ignored\n",
+			*len);
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
+		offset);
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
+				"data area offset %d overlaps SMB2 header %d\n",
+					offset + 1, len);
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
+	max_len = max(req_len, expect_resp_len);
+	calc_credit_num = DIV_ROUND_UP(max_len, SMB2_MAX_BUFFER_SIZE);
+	if (!credit_charge && max_len > SMB2_MAX_BUFFER_SIZE) {
+		ksmbd_err("credit charge is zero and payload size(%d) is bigger than 64K\n",
+			max_len);
+		return 1;
+	} else if (credit_charge < calc_credit_num) {
+		ksmbd_err("credit charge : %d, calc_credit_num : %d\n",
+			credit_charge, calc_credit_num);
+		return 1;
+	}
+
+	return 0;
+}
+
+int ksmbd_smb2_check_message(struct ksmbd_work *work)
+{
+	struct smb2_pdu *pdu = REQUEST_BUF(work);
+	struct smb2_hdr *hdr = &pdu->hdr;
+	int command;
+	__u32 clc_len;  /* calculated length */
+	__u32 len = get_rfc1002_len(pdu);
+
+	if (work->next_smb2_rcv_hdr_off) {
+		pdu = REQUEST_BUF_NEXT(work);
+		hdr = &pdu->hdr;
+	}
+
+	if (le32_to_cpu(hdr->NextCommand) > 0)
+		len = le32_to_cpu(hdr->NextCommand);
+	else if (work->next_smb2_rcv_hdr_off) {
+		len -= work->next_smb2_rcv_hdr_off;
+		len = round_up(len, 8);
+	}
+
+	if (check_smb2_hdr(hdr))
+		return 1;
+
+	if (hdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
+		ksmbd_debug(SMB, "Illegal structure size %u\n",
+			le16_to_cpu(hdr->StructureSize));
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
+		if (command != SMB2_OPLOCK_BREAK_HE && (hdr->Status == 0 ||
+		    pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
+			/* error packets have 9 byte structure size */
+			ksmbd_debug(SMB,
+				"Illegal request size %u for command %d\n",
+				le16_to_cpu(pdu->StructureSize2), command);
+			return 1;
+		} else if (command == SMB2_OPLOCK_BREAK_HE
+				&& (hdr->Status == 0)
+				&& (le16_to_cpu(pdu->StructureSize2) !=
+					OP_BREAK_STRUCT_SIZE_20)
+				&& (le16_to_cpu(pdu->StructureSize2) !=
+					OP_BREAK_STRUCT_SIZE_21)) {
+			/* special case for SMB2.1 lease break message */
+			ksmbd_debug(SMB,
+				"Illegal request size %d for oplock break\n",
+				le16_to_cpu(pdu->StructureSize2));
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
+				"cli req padded more than expected. Length %d not %d for cmd:%d mid:%llu\n",
+					len, clc_len, command,
+					le64_to_cpu(hdr->MessageId));
+			return 0;
+		}
+
+		if (command == SMB2_LOCK_HE && len == 88)
+			return 0;
+
+		ksmbd_debug(SMB,
+			"cli req too short, len %d not %d. cmd:%d mid:%llu\n",
+				len, clc_len, command,
+				le64_to_cpu(hdr->MessageId));
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
diff --git a/fs/cifsd/smb2ops.c b/fs/cifsd/smb2ops.c
new file mode 100644
index 000000000000..a47219ea3b80
--- /dev/null
+++ b/fs/cifsd/smb2ops.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/slab.h>
+#include "glob.h"
+#include "smb2pdu.h"
+
+#include "auth.h"
+#include "connection.h"
+#include "smb_common.h"
+#include "server.h"
+#include "ksmbd_server.h"
+
+static struct smb_version_values smb21_server_values = {
+	.version_string = SMB21_VERSION_STRING,
+	.protocol_id = SMB21_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB21_DEFAULT_IOSIZE,
+	.max_write_size = SMB21_DEFAULT_IOSIZE,
+	.max_trans_size = SMB21_DEFAULT_IOSIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb30_server_values = {
+	.version_string = SMB30_VERSION_STRING,
+	.protocol_id = SMB30_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb302_server_values = {
+	.version_string = SMB302_VERSION_STRING,
+	.protocol_id = SMB302_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_values smb311_server_values = {
+	.version_string = SMB311_VERSION_STRING,
+	.protocol_id = SMB311_PROT_ID,
+	.capabilities = SMB2_GLOBAL_CAP_LARGE_MTU,
+	.max_read_size = SMB3_DEFAULT_IOSIZE,
+	.max_write_size = SMB3_DEFAULT_IOSIZE,
+	.max_trans_size = SMB3_DEFAULT_TRANS_SIZE,
+	.large_lock_type = 0,
+	.exclusive_lock_type = SMB2_LOCKFLAG_EXCLUSIVE,
+	.shared_lock_type = SMB2_LOCKFLAG_SHARED,
+	.unlock_lock_type = SMB2_LOCKFLAG_UNLOCK,
+	.header_size = sizeof(struct smb2_hdr),
+	.max_header_size = MAX_SMB2_HDR_SIZE,
+	.read_rsp_size = sizeof(struct smb2_read_rsp) - 1,
+	.lock_cmd = SMB2_LOCK,
+	.cap_unix = 0,
+	.cap_nt_find = SMB2_NT_FIND,
+	.cap_large_files = SMB2_LARGE_FILES,
+	.create_lease_size = sizeof(struct create_lease),
+	.create_durable_size = sizeof(struct create_durable_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_mxac_size = sizeof(struct create_mxac_rsp),
+	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
+	.create_posix_size = sizeof(struct create_posix_rsp),
+};
+
+static struct smb_version_ops smb2_0_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb2_check_sign_req,
+	.set_sign_rsp		=	smb2_set_sign_rsp
+};
+
+static struct smb_version_ops smb3_0_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb3_check_sign_req,
+	.set_sign_rsp		=	smb3_set_sign_rsp,
+	.generate_signingkey	=	ksmbd_gen_smb30_signingkey,
+	.generate_encryptionkey	=	ksmbd_gen_smb30_encryptionkey,
+	.is_transform_hdr	=	smb3_is_transform_hdr,
+	.decrypt_req		=	smb3_decrypt_req,
+	.encrypt_resp		=	smb3_encrypt_resp
+};
+
+static struct smb_version_ops smb3_11_server_ops = {
+	.get_cmd_val		=	get_smb2_cmd_val,
+	.init_rsp_hdr		=	init_smb2_rsp_hdr,
+	.set_rsp_status		=	set_smb2_rsp_status,
+	.allocate_rsp_buf       =       smb2_allocate_rsp_buf,
+	.set_rsp_credits	=	smb2_set_rsp_credits,
+	.check_user_session	=	smb2_check_user_session,
+	.get_ksmbd_tcon		=	smb2_get_ksmbd_tcon,
+	.is_sign_req		=	smb2_is_sign_req,
+	.check_sign_req		=	smb3_check_sign_req,
+	.set_sign_rsp		=	smb3_set_sign_rsp,
+	.generate_signingkey	=	ksmbd_gen_smb311_signingkey,
+	.generate_encryptionkey	=	ksmbd_gen_smb311_encryptionkey,
+	.is_transform_hdr	=	smb3_is_transform_hdr,
+	.decrypt_req		=	smb3_decrypt_req,
+	.encrypt_resp		=	smb3_encrypt_resp
+};
+
+static struct smb_version_cmds smb2_0_server_cmds[NUMBER_OF_SMB2_COMMANDS] = {
+	[SMB2_NEGOTIATE_HE]	=	{ .proc = smb2_negotiate_request, },
+	[SMB2_SESSION_SETUP_HE] =	{ .proc = smb2_sess_setup, },
+	[SMB2_TREE_CONNECT_HE]  =	{ .proc = smb2_tree_connect,},
+	[SMB2_TREE_DISCONNECT_HE]  =	{ .proc = smb2_tree_disconnect,},
+	[SMB2_LOGOFF_HE]	=	{ .proc = smb2_session_logoff,},
+	[SMB2_CREATE_HE]	=	{ .proc = smb2_open},
+	[SMB2_QUERY_INFO_HE]	=	{ .proc = smb2_query_info},
+	[SMB2_QUERY_DIRECTORY_HE] =	{ .proc = smb2_query_dir},
+	[SMB2_CLOSE_HE]		=	{ .proc = smb2_close},
+	[SMB2_ECHO_HE]		=	{ .proc = smb2_echo},
+	[SMB2_SET_INFO_HE]      =       { .proc = smb2_set_info},
+	[SMB2_READ_HE]		=	{ .proc = smb2_read},
+	[SMB2_WRITE_HE]		=	{ .proc = smb2_write},
+	[SMB2_FLUSH_HE]		=	{ .proc = smb2_flush},
+	[SMB2_CANCEL_HE]	=	{ .proc = smb2_cancel},
+	[SMB2_LOCK_HE]		=	{ .proc = smb2_lock},
+	[SMB2_IOCTL_HE]		=	{ .proc = smb2_ioctl},
+	[SMB2_OPLOCK_BREAK_HE]	=	{ .proc = smb2_oplock_break},
+	[SMB2_CHANGE_NOTIFY_HE]	=	{ .proc = smb2_notify},
+};
+
+int init_smb2_0_server(struct ksmbd_conn *conn)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * init_smb2_1_server() - initialize a smb server connection with smb2.1
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb2_1_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb21_server_values;
+	conn->ops = &smb2_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+}
+
+/**
+ * init_smb3_0_server() - initialize a smb server connection with smb3.0
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb3_0_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb30_server_values;
+	conn->ops = &smb3_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
+		conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+}
+
+/**
+ * init_smb3_02_server() - initialize a smb server connection with smb3.02
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+void init_smb3_02_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb302_server_values;
+	conn->ops = &smb3_0_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION &&
+		conn->cli_cap & SMB2_GLOBAL_CAP_ENCRYPTION)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+}
+
+/**
+ * init_smb3_11_server() - initialize a smb server connection with smb3.11
+ *			command dispatcher
+ * @conn:	connection instance
+ */
+int init_smb3_11_server(struct ksmbd_conn *conn)
+{
+	conn->vals = &smb311_server_values;
+	conn->ops = &smb3_11_server_ops;
+	conn->cmds = smb2_0_server_cmds;
+	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
+	conn->max_credits = SMB2_MAX_CREDITS;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
+
+	if (conn->cipher_type)
+		conn->vals->capabilities |= SMB2_GLOBAL_CAP_ENCRYPTION;
+
+	INIT_LIST_HEAD(&conn->preauth_sess_table);
+	return 0;
+}
+
+void init_smb2_max_read_size(unsigned int sz)
+{
+	smb21_server_values.max_read_size = sz;
+	smb30_server_values.max_read_size = sz;
+	smb302_server_values.max_read_size = sz;
+	smb311_server_values.max_read_size = sz;
+}
+
+void init_smb2_max_write_size(unsigned int sz)
+{
+	smb21_server_values.max_write_size = sz;
+	smb30_server_values.max_write_size = sz;
+	smb302_server_values.max_write_size = sz;
+	smb311_server_values.max_write_size = sz;
+}
+
+void init_smb2_max_trans_size(unsigned int sz)
+{
+	smb21_server_values.max_trans_size = sz;
+	smb30_server_values.max_trans_size = sz;
+	smb302_server_values.max_trans_size = sz;
+	smb311_server_values.max_trans_size = sz;
+}
diff --git a/fs/cifsd/smb2pdu.c b/fs/cifsd/smb2pdu.c
new file mode 100644
index 000000000000..32816baa8a99
--- /dev/null
+++ b/fs/cifsd/smb2pdu.c
@@ -0,0 +1,8452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/inetdevice.h>
+#include <net/addrconf.h>
+#include <linux/syscalls.h>
+#include <linux/namei.h>
+#include <linux/statfs.h>
+#include <linux/ethtool.h>
+
+#include "glob.h"
+#include "smb2pdu.h"
+#include "smbfsctl.h"
+#include "oplock.h"
+#include "smbacl.h"
+
+#include "auth.h"
+#include "asn1.h"
+#include "buffer_pool.h"
+#include "connection.h"
+#include "transport_ipc.h"
+#include "vfs.h"
+#include "vfs_cache.h"
+#include "misc.h"
+
+#include "time_wrappers.h"
+#include "server.h"
+#include "smb_common.h"
+#include "smbstatus.h"
+#include "ksmbd_work.h"
+#include "mgmt/user_config.h"
+#include "mgmt/share_config.h"
+#include "mgmt/tree_connect.h"
+#include "mgmt/user_session.h"
+#include "mgmt/ksmbd_ida.h"
+#include "ndr.h"
+
+static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
+{
+	if (work->next_smb2_rcv_hdr_off) {
+		*req = REQUEST_BUF_NEXT(work);
+		*rsp = RESPONSE_BUF_NEXT(work);
+	} else {
+		*req = REQUEST_BUF(work);
+		*rsp = RESPONSE_BUF(work);
+	}
+}
+
+#define WORK_BUFFERS(w, rq, rs)	__wbuf((w), (void **)&(rq), (void **)&(rs))
+
+/**
+ * check_session_id() - check for valid session id in smb header
+ * @conn:	connection instance
+ * @id:		session id from smb header
+ *
+ * Return:      1 if valid session id, otherwise 0
+ */
+static inline int check_session_id(struct ksmbd_conn *conn, uint64_t id)
+{
+	struct ksmbd_session *sess;
+
+	if (id == 0 || id == -1)
+		return 0;
+
+	sess = ksmbd_session_lookup(conn, id);
+	if (sess)
+		return 1;
+	ksmbd_err("Invalid user session id: %llu\n", id);
+	return 0;
+}
+
+struct channel *lookup_chann_list(struct ksmbd_session *sess)
+{
+	struct channel *chann;
+	struct list_head *t;
+
+	list_for_each(t, &sess->ksmbd_chann_list) {
+		chann = list_entry(t, struct channel, chann_list);
+		if (chann && chann->conn == sess->conn)
+			return chann;
+	}
+
+	return NULL;
+}
+
+/**
+ * smb2_get_ksmbd_tcon() - get tree connection information for a tree id
+ * @work:	smb work
+ *
+ * Return:      matching tree connection on success, otherwise error
+ */
+int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = REQUEST_BUF(work);
+	int tree_id;
+
+	work->tcon = NULL;
+	if ((work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE) ||
+		(work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE) ||
+		(work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE)) {
+		ksmbd_debug(SMB, "skip to check tree connect request\n");
+		return 0;
+	}
+
+	if (list_empty(&work->sess->tree_conn_list)) {
+		ksmbd_debug(SMB, "NO tree connected\n");
+		return -1;
+	}
+
+	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
+	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
+	if (!work->tcon) {
+		ksmbd_err("Invalid tid %d\n", tree_id);
+		return -1;
+	}
+
+	return 1;
+}
+
+/**
+ * smb2_set_err_rsp() - set error response code on smb response
+ * @work:	smb work containing response buffer
+ */
+void smb2_set_err_rsp(struct ksmbd_work *work)
+{
+	struct smb2_err_rsp *err_rsp;
+
+	if (work->next_smb2_rcv_hdr_off)
+		err_rsp = RESPONSE_BUF_NEXT(work);
+	else
+		err_rsp = RESPONSE_BUF(work);
+
+	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
+		err_rsp->StructureSize = SMB2_ERROR_STRUCTURE_SIZE2_LE;
+		err_rsp->ErrorContextCount = 0;
+		err_rsp->Reserved = 0;
+		err_rsp->ByteCount = 0;
+		err_rsp->ErrorData[0] = 0;
+		inc_rfc1001_len(RESPONSE_BUF(work), SMB2_ERROR_STRUCTURE_SIZE2);
+	}
+}
+
+/**
+ * is_smb2_neg_cmd() - is it smb2 negotiation command
+ * @work:	smb work containing smb header
+ *
+ * Return:      1 if smb2 negotiation command, otherwise 0
+ */
+int is_smb2_neg_cmd(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = REQUEST_BUF(work);
+
+	/* is it SMB2 header ? */
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return 0;
+
+	/* make sure it is request not response message */
+	if (hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
+		return 0;
+
+	if (hdr->Command != SMB2_NEGOTIATE)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * is_smb2_rsp() - is it smb2 response
+ * @work:	smb work containing smb response buffer
+ *
+ * Return:      1 if smb2 response, otherwise 0
+ */
+int is_smb2_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = RESPONSE_BUF(work);
+
+	/* is it SMB2 header ? */
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return 0;
+
+	/* make sure it is response not request message */
+	if (!(hdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR))
+		return 0;
+
+	return 1;
+}
+
+/**
+ * get_smb2_cmd_val() - get smb command code from smb header
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      smb2 request command value
+ */
+uint16_t get_smb2_cmd_val(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rcv_hdr;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rcv_hdr = REQUEST_BUF_NEXT(work);
+	else
+		rcv_hdr = REQUEST_BUF(work);
+	return le16_to_cpu(rcv_hdr->Command);
+}
+
+/**
+ * set_smb2_rsp_status() - set error response code on smb2 header
+ * @work:	smb work containing response buffer
+ * @err:	error response code
+ */
+void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
+{
+	struct smb2_hdr *rsp_hdr;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp_hdr = RESPONSE_BUF_NEXT(work);
+	else
+		rsp_hdr = RESPONSE_BUF(work);
+	rsp_hdr->Status = err;
+	smb2_set_err_rsp(work);
+}
+
+/**
+ * init_smb2_neg_rsp() - initialize smb2 response for negotiate command
+ * @work:	smb work containing smb request buffer
+ *
+ * smb2 negotiate response is sent in reply of smb1 negotiate command for
+ * dialect auto-negotiation.
+ */
+int init_smb2_neg_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rsp_hdr;
+	struct smb2_negotiate_rsp *rsp;
+	struct ksmbd_conn *conn = work->conn;
+
+	if (conn->need_neg == false)
+		return -EINVAL;
+	if (!(conn->dialect >= SMB20_PROT_ID &&
+		conn->dialect <= SMB311_PROT_ID))
+		return -EINVAL;
+
+	rsp_hdr = RESPONSE_BUF(work);
+
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+
+	rsp_hdr->smb2_buf_length =
+		cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+
+	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->CreditRequest = cpu_to_le16(2);
+	rsp_hdr->Command = SMB2_NEGOTIATE;
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = 0;
+	rsp_hdr->Id.SyncId.ProcessId = 0;
+	rsp_hdr->Id.SyncId.TreeId = 0;
+	rsp_hdr->SessionId = 0;
+	memset(rsp_hdr->Signature, 0, 16);
+
+	rsp = RESPONSE_BUF(work);
+
+	WARN_ON(ksmbd_conn_good(work));
+
+	rsp->StructureSize = cpu_to_le16(65);
+	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
+	rsp->DialectRevision = cpu_to_le16(conn->dialect);
+	/* Not setting conn guid rsp->ServerGUID, as it
+	 * not used by client for identifying connection
+	 */
+	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	/* Default Max Message Size till SMB2.0, 64K*/
+	rsp->MaxTransactSize = cpu_to_le32(conn->vals->max_trans_size);
+	rsp->MaxReadSize = cpu_to_le32(conn->vals->max_read_size);
+	rsp->MaxWriteSize = cpu_to_le32(conn->vals->max_write_size);
+
+	rsp->SystemTime = cpu_to_le64(ksmbd_systime());
+	rsp->ServerStartTime = 0;
+
+	rsp->SecurityBufferOffset = cpu_to_le16(128);
+	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
+	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
+		sizeof(rsp->hdr.smb2_buf_length)) +
+		le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+		AUTH_GSS_LENGTH);
+	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
+	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
+		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+	conn->use_spnego = true;
+
+	ksmbd_conn_set_need_negotiate(work);
+	return 0;
+}
+
+static int smb2_consume_credit_charge(struct ksmbd_work *work,
+		unsigned short credit_charge)
+{
+	struct ksmbd_conn *conn = work->conn;
+	unsigned int rsp_credits = 1;
+
+	if (!conn->total_credits)
+		return 0;
+
+	if (credit_charge > 0)
+		rsp_credits = credit_charge;
+
+	conn->total_credits -= rsp_credits;
+	return rsp_credits;
+}
+
+/**
+ * smb2_set_rsp_credits() - set number of credits in response buffer
+ * @work:	smb work containing smb response buffer
+ */
+int smb2_set_rsp_credits(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = REQUEST_BUF_NEXT(work);
+	struct smb2_hdr *hdr = RESPONSE_BUF_NEXT(work);
+	struct ksmbd_conn *conn = work->conn;
+	unsigned short credits_requested = le16_to_cpu(req_hdr->CreditRequest);
+	unsigned short credit_charge = 1, credits_granted = 0;
+	unsigned short aux_max, aux_credits, min_credits;
+	int rsp_credit_charge;
+
+	if (hdr->Command == SMB2_CANCEL)
+		goto out;
+
+	/* get default minimum credits by shifting maximum credits by 4 */
+	min_credits = conn->max_credits >> 4;
+
+	if (conn->total_credits >= conn->max_credits) {
+		ksmbd_err("Total credits overflow: %d\n", conn->total_credits);
+		conn->total_credits = min_credits;
+	}
+
+	rsp_credit_charge = smb2_consume_credit_charge(work,
+		le16_to_cpu(req_hdr->CreditCharge));
+	if (rsp_credit_charge < 0)
+		return -EINVAL;
+
+	hdr->CreditCharge = cpu_to_le16(rsp_credit_charge);
+
+	if (credits_requested > 0) {
+		aux_credits = credits_requested - 1;
+		aux_max = 32;
+		if (hdr->Command == SMB2_NEGOTIATE)
+			aux_max = 0;
+		aux_credits = (aux_credits < aux_max) ? aux_credits : aux_max;
+		credits_granted = aux_credits + credit_charge;
+
+		/* if credits granted per client is getting bigger than default
+		 * minimum credits then we should wrap it up within the limits.
+		 */
+		if ((conn->total_credits + credits_granted) > min_credits)
+			credits_granted = min_credits -	conn->total_credits;
+		/*
+		 * TODO: Need to adjuct CreditRequest value according to
+		 * current cpu load
+		 */
+	} else if (conn->total_credits == 0) {
+		credits_granted = 1;
+	}
+
+	conn->total_credits += credits_granted;
+	work->credits_granted += credits_granted;
+
+	if (!req_hdr->NextCommand) {
+		/* Update CreditRequest in last request */
+		hdr->CreditRequest = cpu_to_le16(work->credits_granted);
+	}
+out:
+	ksmbd_debug(SMB,
+		"credits: requested[%d] granted[%d] total_granted[%d]\n",
+		credits_requested, credits_granted,
+		conn->total_credits);
+	return 0;
+}
+
+/**
+ * init_chained_smb2_rsp() - initialize smb2 chained response
+ * @work:	smb work containing smb response buffer
+ */
+static void init_chained_smb2_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req = REQUEST_BUF_NEXT(work);
+	struct smb2_hdr *rsp = RESPONSE_BUF_NEXT(work);
+	struct smb2_hdr *rsp_hdr;
+	struct smb2_hdr *rcv_hdr;
+	int next_hdr_offset = 0;
+	int len, new_len;
+
+	/* Len of this response = updated RFC len - offset of previous cmd
+	 * in the compound rsp
+	 */
+
+	/* Storing the current local FID which may be needed by subsequent
+	 * command in the compound request
+	 */
+	if (req->Command == SMB2_CREATE && rsp->Status == STATUS_SUCCESS) {
+		work->compound_fid =
+			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
+				VolatileFileId);
+		work->compound_pfid =
+			le64_to_cpu(((struct smb2_create_rsp *)rsp)->
+				PersistentFileId);
+		work->compound_sid = le64_to_cpu(rsp->SessionId);
+	}
+
+	len = get_rfc1002_len(RESPONSE_BUF(work)) - work->next_smb2_rsp_hdr_off;
+	next_hdr_offset = le32_to_cpu(req->NextCommand);
+
+	new_len = ALIGN(len, 8);
+	inc_rfc1001_len(RESPONSE_BUF(work), ((sizeof(struct smb2_hdr) - 4)
+			+ new_len - len));
+	rsp->NextCommand = cpu_to_le32(new_len);
+
+	work->next_smb2_rcv_hdr_off += next_hdr_offset;
+	work->next_smb2_rsp_hdr_off += new_len;
+	ksmbd_debug(SMB,
+		"Compound req new_len = %d rcv off = %d rsp off = %d\n",
+		new_len, work->next_smb2_rcv_hdr_off,
+		work->next_smb2_rsp_hdr_off);
+
+	rsp_hdr = RESPONSE_BUF_NEXT(work);
+	rcv_hdr = REQUEST_BUF_NEXT(work);
+
+	if (!(rcv_hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS)) {
+		ksmbd_debug(SMB, "related flag should be set\n");
+		work->compound_fid = KSMBD_NO_FID;
+		work->compound_pfid = KSMBD_NO_FID;
+	}
+	memset((char *)rsp_hdr + 4, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->Command = rcv_hdr->Command;
+
+	/*
+	 * Message is response. We don't grant oplock yet.
+	 */
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR |
+				SMB2_FLAGS_RELATED_OPERATIONS);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = rcv_hdr->MessageId;
+	rsp_hdr->Id.SyncId.ProcessId = rcv_hdr->Id.SyncId.ProcessId;
+	rsp_hdr->Id.SyncId.TreeId = rcv_hdr->Id.SyncId.TreeId;
+	rsp_hdr->SessionId = rcv_hdr->SessionId;
+	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
+}
+
+/**
+ * is_chained_smb2_message() - check for chained command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      true if chained request, otherwise false
+ */
+bool is_chained_smb2_message(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = REQUEST_BUF(work);
+	unsigned int len;
+
+	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
+		return false;
+
+	hdr = REQUEST_BUF_NEXT(work);
+	if (le32_to_cpu(hdr->NextCommand) > 0) {
+		ksmbd_debug(SMB, "got SMB2 chained command\n");
+		init_chained_smb2_rsp(work);
+		return true;
+	} else if (work->next_smb2_rcv_hdr_off) {
+		/*
+		 * This is last request in chained command,
+		 * align response to 8 byte
+		 */
+		len = ALIGN(get_rfc1002_len(RESPONSE_BUF(work)), 8);
+		len = len - get_rfc1002_len(RESPONSE_BUF(work));
+		if (len) {
+			ksmbd_debug(SMB, "padding len %u\n", len);
+			inc_rfc1001_len(RESPONSE_BUF(work), len);
+			if (HAS_AUX_PAYLOAD(work))
+				work->aux_payload_sz += len;
+		}
+	}
+	return false;
+}
+
+/**
+ * init_smb2_rsp_hdr() - initialize smb2 response
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0
+ */
+int init_smb2_rsp_hdr(struct ksmbd_work *work)
+{
+	struct smb2_hdr *rsp_hdr = RESPONSE_BUF(work);
+	struct smb2_hdr *rcv_hdr = REQUEST_BUF(work);
+	struct ksmbd_conn *conn = work->conn;
+
+	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
+	rsp_hdr->smb2_buf_length = cpu_to_be32(HEADER_SIZE_NO_BUF_LEN(conn));
+	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
+	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
+	rsp_hdr->Command = rcv_hdr->Command;
+
+	/*
+	 * Message is response. We don't grant oplock yet.
+	 */
+	rsp_hdr->Flags = (SMB2_FLAGS_SERVER_TO_REDIR);
+	rsp_hdr->NextCommand = 0;
+	rsp_hdr->MessageId = rcv_hdr->MessageId;
+	rsp_hdr->Id.SyncId.ProcessId = rcv_hdr->Id.SyncId.ProcessId;
+	rsp_hdr->Id.SyncId.TreeId = rcv_hdr->Id.SyncId.TreeId;
+	rsp_hdr->SessionId = rcv_hdr->SessionId;
+	memcpy(rsp_hdr->Signature, rcv_hdr->Signature, 16);
+
+	work->syncronous = true;
+	if (work->async_id) {
+		ksmbd_release_id(conn->async_ida, work->async_id);
+		work->async_id = 0;
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_allocate_rsp_buf() - allocate smb2 response buffer
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise -ENOMEM
+ */
+int smb2_allocate_rsp_buf(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr = REQUEST_BUF(work);
+	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
+	size_t large_sz = work->conn->vals->max_trans_size + MAX_SMB2_HDR_SIZE;
+	size_t sz = small_sz;
+	int cmd = le16_to_cpu(hdr->Command);
+
+	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE) {
+		sz = large_sz;
+		work->set_trans_buf = true;
+	}
+
+	if (cmd == SMB2_QUERY_INFO_HE) {
+		struct smb2_query_info_req *req;
+
+		req = REQUEST_BUF(work);
+		if (req->InfoType == SMB2_O_INFO_FILE &&
+			(req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
+				req->FileInfoClass == FILE_ALL_INFORMATION)) {
+			sz = large_sz;
+			work->set_trans_buf = true;
+		}
+	}
+
+	/* allocate large response buf for chained commands */
+	if (le32_to_cpu(hdr->NextCommand) > 0)
+		sz = large_sz;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_TBUF &&
+			work->set_trans_buf)
+		work->response_buf = ksmbd_find_buffer(sz);
+	else
+		work->response_buf = ksmbd_alloc_response(sz);
+
+	if (!RESPONSE_BUF(work)) {
+		ksmbd_err("Failed to allocate %zu bytes buffer\n", sz);
+		return -ENOMEM;
+	}
+
+	work->response_sz = sz;
+	return 0;
+}
+
+/**
+ * smb2_check_user_session() - check for valid session for a user
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_check_user_session(struct ksmbd_work *work)
+{
+	struct smb2_hdr *req_hdr = REQUEST_BUF(work);
+	struct ksmbd_conn *conn = work->conn;
+	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned long long sess_id;
+
+	work->sess = NULL;
+	/*
+	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
+	 * require a session id, so no need to validate user session's for
+	 * these commands.
+	 */
+	if (cmd == SMB2_ECHO_HE || cmd == SMB2_NEGOTIATE_HE ||
+			cmd == SMB2_SESSION_SETUP_HE)
+		return 0;
+
+	if (!ksmbd_conn_good(work))
+		return -EINVAL;
+
+	sess_id = le64_to_cpu(req_hdr->SessionId);
+	/* Check for validity of user session */
+	work->sess = ksmbd_session_lookup(conn, sess_id);
+	if (work->sess)
+		return 1;
+	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
+	return -EINVAL;
+}
+
+static void destroy_previous_session(struct ksmbd_user *user, uint64_t id)
+{
+	struct ksmbd_session *prev_sess = ksmbd_session_lookup_slowpath(id);
+	struct ksmbd_user *prev_user;
+
+	if (!prev_sess)
+		return;
+
+	prev_user = prev_sess->user;
+
+	if (strcmp(user->name, prev_user->name) ||
+	    user->passkey_sz != prev_user->passkey_sz ||
+	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz)) {
+		put_session(prev_sess);
+		return;
+	}
+
+	put_session(prev_sess);
+	ksmbd_session_destroy(prev_sess);
+}
+
+/**
+ * smb2_get_name() - get filename string from on the wire smb format
+ * @share:	ksmbd_share_config pointer
+ * @src:	source buffer
+ * @maxlen:	maxlen of source string
+ * @nls_table:	nls_table pointer
+ *
+ * Return:      matching converted filename on success, otherwise error ptr
+ */
+static char *
+smb2_get_name(struct ksmbd_share_config *share,
+	      const char *src,
+	      const int maxlen,
+	      struct nls_table *local_nls)
+{
+	char *name, *unixname;
+
+	name = smb_strndup_from_utf16(src, maxlen, 1,
+			local_nls);
+	if (IS_ERR(name)) {
+		ksmbd_err("failed to get name %ld\n", PTR_ERR(name));
+		return name;
+	}
+
+	/* change it to absolute unix name */
+	ksmbd_conv_path_to_unix(name);
+	ksmbd_strip_last_slash(name);
+
+	unixname = convert_to_unix_name(share, name);
+	kfree(name);
+	if (!unixname) {
+		ksmbd_err("can not convert absolute name\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ksmbd_debug(SMB, "absolute name = %s\n", unixname);
+	return unixname;
+}
+
+/**
+ * smb2_put_name() - free memory allocated for filename
+ * @name:	filename pointer to be freed
+ */
+static void smb2_put_name(void *name)
+{
+	if (!IS_ERR(name))
+		kfree(name);
+}
+
+int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
+{
+	struct smb2_hdr *rsp_hdr;
+	struct ksmbd_conn *conn = work->conn;
+	int id;
+
+	rsp_hdr = RESPONSE_BUF(work);
+	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
+
+	id = ksmbd_acquire_async_msg_id(conn->async_ida);
+	if (id < 0) {
+		ksmbd_err("Failed to alloc async message id\n");
+		return id;
+	}
+	work->syncronous = false;
+	work->async_id = id;
+	rsp_hdr->Id.AsyncId = cpu_to_le64(id);
+
+	ksmbd_debug(SMB,
+		"Send interim Response to inform async request id : %d\n",
+		work->async_id);
+
+	work->cancel_fn = fn;
+	work->cancel_argv = arg;
+
+	spin_lock(&conn->request_lock);
+	list_add_tail(&work->async_request_entry, &conn->async_requests);
+	spin_unlock(&conn->request_lock);
+
+	return 0;
+}
+
+void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
+{
+	struct smb2_hdr *rsp_hdr;
+
+	rsp_hdr = RESPONSE_BUF(work);
+	smb2_set_err_rsp(work);
+	rsp_hdr->Status = status;
+
+	work->multiRsp = 1;
+	ksmbd_conn_write(work);
+	rsp_hdr->Status = 0;
+	work->multiRsp = 0;
+}
+
+static __le32 smb2_get_reparse_tag_special_file(umode_t mode)
+{
+	if (S_ISDIR(mode) || S_ISREG(mode))
+		return 0;
+
+	if (S_ISLNK(mode))
+		return IO_REPARSE_TAG_LX_SYMLINK_LE;
+	else if (S_ISFIFO(mode))
+		return IO_REPARSE_TAG_LX_FIFO_LE;
+	else if (S_ISSOCK(mode))
+		return IO_REPARSE_TAG_AF_UNIX_LE;
+	else if (S_ISCHR(mode))
+		return IO_REPARSE_TAG_LX_CHR_LE;
+	else if (S_ISBLK(mode))
+		return IO_REPARSE_TAG_LX_BLK_LE;
+
+	return 0;
+}
+
+/**
+ * smb2_get_dos_mode() - get file mode in dos format from unix mode
+ * @stat:	kstat containing file mode
+ * @attribute:	attribute flags
+ *
+ * Return:      converted dos mode
+ */
+static int smb2_get_dos_mode(struct kstat *stat, int attribute)
+{
+	int attr = 0;
+
+	if (S_ISDIR(stat->mode))
+		attr = ATTR_DIRECTORY |
+			(attribute & (ATTR_HIDDEN | ATTR_SYSTEM));
+	else {
+		attr = (attribute & 0x00005137) | ATTR_ARCHIVE;
+		attr &= ~(ATTR_DIRECTORY);
+		if (S_ISREG(stat->mode) && (server_conf.share_fake_fscaps &
+				FILE_SUPPORTS_SPARSE_FILES))
+			attr |= ATTR_SPARSE;
+
+		if (smb2_get_reparse_tag_special_file(stat->mode))
+			attr |= ATTR_REPARSE;
+	}
+
+	return attr;
+}
+
+static void build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt,
+			       __le16 hash_id)
+{
+	pneg_ctxt->ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
+	pneg_ctxt->DataLength = cpu_to_le16(38);
+	pneg_ctxt->HashAlgorithmCount = cpu_to_le16(1);
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_SALT_SIZE);
+	get_random_bytes(pneg_ctxt->Salt, SMB311_SALT_SIZE);
+	pneg_ctxt->HashAlgorithms = hash_id;
+}
+
+static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
+			       __le16 cipher_type)
+{
+	pneg_ctxt->ContextType = SMB2_ENCRYPTION_CAPABILITIES;
+	pneg_ctxt->DataLength = cpu_to_le16(4);
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->CipherCount = cpu_to_le16(1);
+	pneg_ctxt->Ciphers[0] = cipher_type;
+}
+
+static void build_compression_ctxt(struct smb2_compression_ctx *pneg_ctxt,
+				   __le16 comp_algo)
+{
+	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
+	pneg_ctxt->DataLength =
+		cpu_to_le16(sizeof(struct smb2_compression_ctx)
+			- sizeof(struct smb2_neg_context));
+	pneg_ctxt->Reserved = cpu_to_le32(0);
+	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(1);
+	pneg_ctxt->Reserved1 = cpu_to_le32(0);
+	pneg_ctxt->CompressionAlgorithms[0] = comp_algo;
+}
+
+static void
+build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
+{
+	pneg_ctxt->ContextType = SMB2_POSIX_EXTENSIONS_AVAILABLE;
+	pneg_ctxt->DataLength = cpu_to_le16(POSIX_CTXT_DATA_LEN);
+	/* SMB2_CREATE_TAG_POSIX is "0x93AD25509CB411E7B42383DE968BCD7C" */
+	pneg_ctxt->Name[0] = 0x93;
+	pneg_ctxt->Name[1] = 0xAD;
+	pneg_ctxt->Name[2] = 0x25;
+	pneg_ctxt->Name[3] = 0x50;
+	pneg_ctxt->Name[4] = 0x9C;
+	pneg_ctxt->Name[5] = 0xB4;
+	pneg_ctxt->Name[6] = 0x11;
+	pneg_ctxt->Name[7] = 0xE7;
+	pneg_ctxt->Name[8] = 0xB4;
+	pneg_ctxt->Name[9] = 0x23;
+	pneg_ctxt->Name[10] = 0x83;
+	pneg_ctxt->Name[11] = 0xDE;
+	pneg_ctxt->Name[12] = 0x96;
+	pneg_ctxt->Name[13] = 0x8B;
+	pneg_ctxt->Name[14] = 0xCD;
+	pneg_ctxt->Name[15] = 0x7C;
+}
+
+static void
+assemble_neg_contexts(struct ksmbd_conn *conn,
+	struct smb2_negotiate_rsp *rsp)
+{
+	/* +4 is to account for the RFC1001 len field */
+	char *pneg_ctxt = (char *)rsp +
+			le32_to_cpu(rsp->NegotiateContextOffset) + 4;
+	int neg_ctxt_cnt = 1;
+	int ctxt_size;
+
+	ksmbd_debug(SMB,
+		"assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
+	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
+		conn->preauth_info->Preauth_HashId);
+	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
+	inc_rfc1001_len(rsp, AUTH_GSS_PADDING);
+	ctxt_size = sizeof(struct smb2_preauth_neg_context);
+	/* Round to 8 byte boundary */
+	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
+
+	if (conn->cipher_type) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			"assemble SMB2_ENCRYPTION_CAPABILITIES context\n");
+		build_encrypt_ctxt(
+			(struct smb2_encryption_neg_context *)pneg_ctxt,
+			conn->cipher_type);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_encryption_neg_context);
+		/* Round to 8 byte boundary */
+		pneg_ctxt +=
+			round_up(sizeof(struct smb2_encryption_neg_context),
+				 8);
+	}
+
+	if (conn->compress_algorithm) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			"assemble SMB2_COMPRESSION_CAPABILITIES context\n");
+		/* Temporarily set to SMB3_COMPRESS_NONE */
+		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
+					conn->compress_algorithm);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_compression_ctx);
+		/* Round to 8 byte boundary */
+		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx), 8);
+	}
+
+	if (conn->posix_ext_supported) {
+		ctxt_size = round_up(ctxt_size, 8);
+		ksmbd_debug(SMB,
+			"assemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
+		build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ctxt);
+		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
+		ctxt_size += sizeof(struct smb2_posix_neg_context);
+	}
+
+	inc_rfc1001_len(rsp, ctxt_size);
+}
+
+static __le32
+decode_preauth_ctxt(struct ksmbd_conn *conn,
+	struct smb2_preauth_neg_context *pneg_ctxt)
+{
+	__le32 err = STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP;
+
+	if (pneg_ctxt->HashAlgorithms ==
+			SMB2_PREAUTH_INTEGRITY_SHA512) {
+		conn->preauth_info->Preauth_HashId =
+			SMB2_PREAUTH_INTEGRITY_SHA512;
+		err = STATUS_SUCCESS;
+	}
+
+	return err;
+}
+
+static int decode_encrypt_ctxt(struct ksmbd_conn *conn,
+			       struct smb2_encryption_neg_context *pneg_ctxt)
+{
+	int i;
+	int cph_cnt = le16_to_cpu(pneg_ctxt->CipherCount);
+
+	conn->cipher_type = 0;
+
+	if (!(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION))
+		goto out;
+
+	for (i = 0; i < cph_cnt; i++) {
+		if (pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES128_GCM ||
+			pneg_ctxt->Ciphers[i] == SMB2_ENCRYPTION_AES128_CCM) {
+			ksmbd_debug(SMB, "Cipher ID = 0x%x\n",
+				pneg_ctxt->Ciphers[i]);
+			conn->cipher_type = pneg_ctxt->Ciphers[i];
+			break;
+		}
+	}
+
+out:
+	/*
+	 * Return encrypt context size in request.
+	 * So need to plus extra number of ciphers size.
+	 */
+	return sizeof(struct smb2_encryption_neg_context) +
+		((cph_cnt - 1) * 2);
+}
+
+static int decode_compress_ctxt(struct ksmbd_conn *conn,
+				struct smb2_compression_ctx *pneg_ctxt)
+{
+	int algo_cnt = le16_to_cpu(pneg_ctxt->CompressionAlgorithmCount);
+
+	conn->compress_algorithm = SMB3_COMPRESS_NONE;
+
+	/*
+	 * Return compression context size in request.
+	 * So need to plus extra number of CompressionAlgorithms size.
+	 */
+	return sizeof(struct smb2_encryption_neg_context) +
+		((algo_cnt - 1) * 2);
+}
+
+static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
+				   struct smb2_negotiate_req *req)
+{
+	int i = 0;
+	__le32 status = 0;
+	/* +4 is to account for the RFC1001 len field */
+	char *pneg_ctxt = (char *)req +
+			le32_to_cpu(req->NegotiateContextOffset) + 4;
+	__le16 *ContextType = (__le16 *)pneg_ctxt;
+	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
+	int ctxt_size;
+
+	ksmbd_debug(SMB, "negotiate context count = %d\n", neg_ctxt_cnt);
+	status = STATUS_INVALID_PARAMETER;
+	while (i++ < neg_ctxt_cnt) {
+		if (*ContextType == SMB2_PREAUTH_INTEGRITY_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				"deassemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
+			if (conn->preauth_info->Preauth_HashId)
+				break;
+
+			status = decode_preauth_ctxt(conn,
+				(struct smb2_preauth_neg_context *)pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(
+				sizeof(struct smb2_preauth_neg_context), 8) * 8;
+		} else if (*ContextType == SMB2_ENCRYPTION_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				"deassemble SMB2_ENCRYPTION_CAPABILITIES context\n");
+			if (conn->cipher_type)
+				break;
+
+			ctxt_size = decode_encrypt_ctxt(conn,
+				(struct smb2_encryption_neg_context *)
+				pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(ctxt_size, 8) * 8;
+		} else if (*ContextType == SMB2_COMPRESSION_CAPABILITIES) {
+			ksmbd_debug(SMB,
+				"deassemble SMB2_COMPRESSION_CAPABILITIES context\n");
+			if (conn->compress_algorithm)
+				break;
+
+			ctxt_size = decode_compress_ctxt(conn,
+						(struct smb2_compression_ctx *)
+						pneg_ctxt);
+			pneg_ctxt += DIV_ROUND_UP(ctxt_size, 8) * 8;
+		} else if (*ContextType == SMB2_NETNAME_NEGOTIATE_CONTEXT_ID) {
+			ksmbd_debug(SMB,
+				"deassemble SMB2_NETNAME_NEGOTIATE_CONTEXT_ID context\n");
+			ctxt_size = sizeof(struct smb2_netname_neg_context);
+			ctxt_size += DIV_ROUND_UP(
+				le16_to_cpu(((struct smb2_netname_neg_context *)
+					pneg_ctxt)->DataLength), 8) * 8;
+			pneg_ctxt += ctxt_size;
+		} else if (*ContextType == SMB2_POSIX_EXTENSIONS_AVAILABLE) {
+			ksmbd_debug(SMB,
+				"deassemble SMB2_POSIX_EXTENSIONS_AVAILABLE context\n");
+			conn->posix_ext_supported = true;
+			pneg_ctxt += DIV_ROUND_UP(
+				sizeof(struct smb2_posix_neg_context), 8) * 8;
+		}
+		ContextType = (__le16 *)pneg_ctxt;
+
+		if (status != STATUS_SUCCESS)
+			break;
+	}
+	return status;
+}
+
+/**
+ * smb2_handle_negotiate() - handler for smb2 negotiate command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0
+ */
+int smb2_handle_negotiate(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_negotiate_req *req = REQUEST_BUF(work);
+	struct smb2_negotiate_rsp *rsp = RESPONSE_BUF(work);
+	int rc = 0;
+	__le32 status;
+
+	ksmbd_debug(SMB, "Received negotiate request\n");
+	conn->need_neg = false;
+	if (ksmbd_conn_good(work)) {
+		ksmbd_err("conn->tcp_status is already in CifsGood State\n");
+		work->send_no_response = 1;
+		return rc;
+	}
+
+	if (req->DialectCount == 0) {
+		ksmbd_err("malformed packet\n");
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		rc = -EINVAL;
+		goto err_out;
+	}
+
+	conn->cli_cap = le32_to_cpu(req->Capabilities);
+	switch (conn->dialect) {
+	case SMB311_PROT_ID:
+		conn->preauth_info =
+			kzalloc(sizeof(struct preauth_integrity_info),
+			GFP_KERNEL);
+		if (!conn->preauth_info) {
+			rc = -ENOMEM;
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto err_out;
+		}
+
+		status = deassemble_neg_contexts(conn, req);
+		if (status != STATUS_SUCCESS) {
+			ksmbd_err("deassemble_neg_contexts error(0x%x)\n",
+					status);
+			rsp->hdr.Status = status;
+			rc = -EINVAL;
+			goto err_out;
+		}
+
+		rc = init_smb3_11_server(conn);
+		if (rc < 0) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto err_out;
+		}
+
+		ksmbd_gen_preauth_integrity_hash(conn,
+				REQUEST_BUF(work),
+				conn->preauth_info->Preauth_HashValue);
+		rsp->NegotiateContextOffset =
+				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
+		assemble_neg_contexts(conn, rsp);
+		break;
+	case SMB302_PROT_ID:
+		init_smb3_02_server(conn);
+		break;
+	case SMB30_PROT_ID:
+		init_smb3_0_server(conn);
+		break;
+	case SMB21_PROT_ID:
+		init_smb2_1_server(conn);
+		break;
+	case SMB20_PROT_ID:
+		rc = init_smb2_0_server(conn);
+		if (rc) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			goto err_out;
+		}
+		break;
+	case SMB2X_PROT_ID:
+	case BAD_PROT_ID:
+	default:
+		ksmbd_debug(SMB, "Server dialect :0x%x not supported\n",
+			conn->dialect);
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		rc = -EINVAL;
+		goto err_out;
+	}
+	rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+
+	/* For stats */
+	conn->connection_type = conn->dialect;
+
+	rsp->MaxTransactSize = cpu_to_le32(conn->vals->max_trans_size);
+	rsp->MaxReadSize = cpu_to_le32(conn->vals->max_read_size);
+	rsp->MaxWriteSize = cpu_to_le32(conn->vals->max_write_size);
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		memcpy(conn->ClientGUID, req->ClientGUID,
+				SMB2_CLIENT_GUID_SIZE);
+		conn->cli_sec_mode = le16_to_cpu(req->SecurityMode);
+	}
+
+	rsp->StructureSize = cpu_to_le16(65);
+	rsp->DialectRevision = cpu_to_le16(conn->dialect);
+	/* Not setting conn guid rsp->ServerGUID, as it
+	 * not used by client for identifying server
+	 */
+	memset(rsp->ServerGUID, 0, SMB2_CLIENT_GUID_SIZE);
+
+	rsp->SystemTime = cpu_to_le64(ksmbd_systime());
+	rsp->ServerStartTime = 0;
+	ksmbd_debug(SMB, "negotiate context offset %d, count %d\n",
+		le32_to_cpu(rsp->NegotiateContextOffset),
+		le16_to_cpu(rsp->NegotiateContextCount));
+
+	rsp->SecurityBufferOffset = cpu_to_le16(128);
+	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
+	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
+		sizeof(rsp->hdr.smb2_buf_length)) +
+		le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+		AUTH_GSS_LENGTH);
+	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
+	conn->use_spnego = true;
+
+	if ((server_conf.signing == KSMBD_CONFIG_OPT_AUTO ||
+			server_conf.signing == KSMBD_CONFIG_OPT_DISABLED) &&
+		req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED_LE)
+		conn->sign = true;
+	else if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY) {
+		server_conf.enforced_signing = true;
+		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+		conn->sign = true;
+	}
+
+	conn->srv_sec_mode = le16_to_cpu(rsp->SecurityMode);
+	ksmbd_conn_set_need_negotiate(work);
+
+err_out:
+	if (rc < 0)
+		smb2_set_err_rsp(work);
+
+	return rc;
+}
+
+static int alloc_preauth_hash(struct ksmbd_session *sess,
+			      struct ksmbd_conn *conn)
+{
+	if (sess->Preauth_HashValue)
+		return 0;
+
+	sess->Preauth_HashValue = ksmbd_alloc(PREAUTH_HASHVALUE_SIZE);
+	if (!sess->Preauth_HashValue)
+		return -ENOMEM;
+
+	memcpy(sess->Preauth_HashValue,
+	       conn->preauth_info->Preauth_HashValue,
+	       PREAUTH_HASHVALUE_SIZE);
+	return 0;
+}
+
+static int generate_preauth_hash(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+
+	if (conn->dialect != SMB311_PROT_ID)
+		return 0;
+
+	if (!sess->Preauth_HashValue) {
+		if (alloc_preauth_hash(sess, conn))
+			return -ENOMEM;
+	}
+
+	ksmbd_gen_preauth_integrity_hash(conn,
+					 REQUEST_BUF(work),
+					 sess->Preauth_HashValue);
+	return 0;
+}
+
+static int decode_negotiation_token(struct ksmbd_work *work,
+				    struct negotiate_message *negblob)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_sess_setup_req *req;
+	int sz;
+
+	if (!conn->use_spnego)
+		return -EINVAL;
+
+	req = REQUEST_BUF(work);
+	sz = le16_to_cpu(req->SecurityBufferLength);
+
+	if (!ksmbd_decode_negTokenInit((char *)negblob, sz, conn)) {
+		if (!ksmbd_decode_negTokenTarg((char *)negblob, sz, conn)) {
+			conn->auth_mechs |= KSMBD_AUTH_NTLMSSP;
+			conn->preferred_auth_mech = KSMBD_AUTH_NTLMSSP;
+			conn->use_spnego = false;
+		}
+	}
+	return 0;
+}
+
+static int ntlm_negotiate(struct ksmbd_work *work,
+			  struct negotiate_message *negblob)
+{
+	struct smb2_sess_setup_req *req = REQUEST_BUF(work);
+	struct smb2_sess_setup_rsp *rsp = RESPONSE_BUF(work);
+	struct challenge_message *chgblob;
+	unsigned char *spnego_blob = NULL;
+	u16 spnego_blob_len;
+	char *neg_blob;
+	int sz, rc;
+
+	ksmbd_debug(SMB, "negotiate phase\n");
+	sz = le16_to_cpu(req->SecurityBufferLength);
+	rc = ksmbd_decode_ntlmssp_neg_blob(negblob, sz, work->sess);
+	if (rc)
+		return rc;
+
+	sz = le16_to_cpu(rsp->SecurityBufferOffset);
+	chgblob =
+		(struct challenge_message *)((char *)&rsp->hdr.ProtocolId + sz);
+	memset(chgblob, 0, sizeof(struct challenge_message));
+
+	if (!work->conn->use_spnego) {
+		sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+		if (sz < 0)
+			return -ENOMEM;
+
+		rsp->SecurityBufferLength = cpu_to_le16(sz);
+		return 0;
+	}
+
+	sz = sizeof(struct challenge_message);
+	sz += (strlen(ksmbd_netbios_name()) * 2 + 1 + 4) * 6;
+
+	neg_blob = kzalloc(sz, GFP_KERNEL);
+	if (!neg_blob)
+		return -ENOMEM;
+
+	chgblob = (struct challenge_message *)neg_blob;
+	sz = ksmbd_build_ntlmssp_challenge_blob(chgblob, work->sess);
+	if (sz < 0) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	rc = build_spnego_ntlmssp_neg_blob(&spnego_blob,
+					  &spnego_blob_len,
+					  neg_blob,
+					  sz);
+	if (rc) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	sz = le16_to_cpu(rsp->SecurityBufferOffset);
+	memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
+	rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
+
+out:
+	kfree(spnego_blob);
+	kfree(neg_blob);
+	return rc;
+}
+
+static struct authenticate_message *user_authblob(struct ksmbd_conn *conn,
+					   struct smb2_sess_setup_req *req)
+{
+	int sz;
+
+	if (conn->use_spnego && conn->mechToken)
+		return (struct authenticate_message *)conn->mechToken;
+
+	sz = le16_to_cpu(req->SecurityBufferOffset);
+	return (struct authenticate_message *)((char *)&req->hdr.ProtocolId
+					       + sz);
+}
+
+static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
+				       struct smb2_sess_setup_req *req)
+{
+	struct authenticate_message *authblob;
+	struct ksmbd_user *user;
+	char *name;
+	int sz;
+
+	authblob = user_authblob(conn, req);
+	sz = le32_to_cpu(authblob->UserName.BufferOffset);
+	name = smb_strndup_from_utf16((const char *)authblob + sz,
+				      le16_to_cpu(authblob->UserName.Length),
+				      true,
+				      conn->local_nls);
+	if (IS_ERR(name)) {
+		ksmbd_err("cannot allocate memory\n");
+		return NULL;
+	}
+
+	ksmbd_debug(SMB, "session setup request for user %s\n", name);
+	user = ksmbd_login_user(name);
+	kfree(name);
+	return user;
+}
+
+static int ntlm_authenticate(struct ksmbd_work *work)
+{
+	struct smb2_sess_setup_req *req = REQUEST_BUF(work);
+	struct smb2_sess_setup_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct channel *chann = NULL;
+	struct ksmbd_user *user;
+	uint64_t prev_id;
+	int sz, rc;
+
+	ksmbd_debug(SMB, "authenticate phase\n");
+	if (conn->use_spnego) {
+		unsigned char *spnego_blob;
+		u16 spnego_blob_len;
+
+		rc = build_spnego_ntlmssp_auth_blob(&spnego_blob,
+						    &spnego_blob_len,
+						    0);
+		if (rc)
+			return -ENOMEM;
+
+		sz = le16_to_cpu(rsp->SecurityBufferOffset);
+		memcpy((char *)&rsp->hdr.ProtocolId + sz,
+			spnego_blob,
+			spnego_blob_len);
+		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
+		kfree(spnego_blob);
+		inc_rfc1001_len(rsp, spnego_blob_len - 1);
+	}
+
+	user = session_user(conn, req);
+	if (!user) {
+		ksmbd_debug(SMB, "Unknown user name or an error\n");
+		rsp->hdr.Status = STATUS_LOGON_FAILURE;
+		return -EINVAL;
+	}
+
+	/* Check for previous session */
+	prev_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_id && prev_id != sess->id)
+		destroy_previous_session(user, prev_id);
+
+	if (sess->state == SMB2_SESSION_VALID) {
+		/*
+		 * Reuse session if anonymous try to connect
+		 * on reauthetication.
+		 */
+		if (ksmbd_anonymous_user(user)) {
+			ksmbd_free_user(user);
+			return 0;
+		}
+		ksmbd_free_user(sess->user);
+	}
+
+	sess->user = user;
+	if (user_guest(sess->user)) {
+		if (conn->sign) {
+			ksmbd_debug(SMB,
+				"Guest login not allowed when signing enabled\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return -EACCES;
+		}
+
+		rsp->SessionFlags = SMB2_SESSION_FLAG_IS_GUEST_LE;
+	} else {
+		struct authenticate_message *authblob;
+
+		authblob = user_authblob(conn, req);
+		sz = le16_to_cpu(req->SecurityBufferLength);
+		rc = ksmbd_decode_ntlmssp_auth_blob(authblob, sz, sess);
+		if (rc) {
+			set_user_flag(sess->user, KSMBD_USER_FLAG_BAD_PASSWORD);
+			ksmbd_debug(SMB, "authentication failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return -EINVAL;
+		}
+
+		/*
+		 * If session state is SMB2_SESSION_VALID, We can assume
+		 * that it is reauthentication. And the user/password
+		 * has been verified, so return it here.
+		 */
+		if (sess->state == SMB2_SESSION_VALID)
+			return 0;
+
+		if ((conn->sign || server_conf.enforced_signing) ||
+		     (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+			sess->sign = true;
+
+		if (conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION &&
+				conn->ops->generate_encryptionkey) {
+			rc = conn->ops->generate_encryptionkey(sess);
+			if (rc) {
+				ksmbd_debug(SMB,
+					"SMB3 encryption key generation failed\n");
+				rsp->hdr.Status = STATUS_LOGON_FAILURE;
+				return rc;
+			}
+			sess->enc = true;
+			rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+			/*
+			 * signing is disable if encryption is enable
+			 * on this session
+			 */
+			sess->sign = false;
+		}
+	}
+
+	if (conn->dialect >= SMB30_PROT_ID) {
+		chann = lookup_chann_list(sess);
+		if (!chann) {
+			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			if (!chann)
+				return -ENOMEM;
+
+			chann->conn = conn;
+			INIT_LIST_HEAD(&chann->chann_list);
+			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+		}
+	}
+
+	if (conn->ops->generate_signingkey) {
+		rc = conn->ops->generate_signingkey(sess);
+		if (rc) {
+			ksmbd_debug(SMB,
+				"SMB3 signing key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return rc;
+		}
+	}
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		if (!ksmbd_conn_lookup_dialect(conn)) {
+			ksmbd_err("fail to verify the dialect\n");
+			rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+			return -EPERM;
+		}
+	}
+	return 0;
+}
+
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+static int krb5_authenticate(struct ksmbd_work *work)
+{
+	struct smb2_sess_setup_req *req = REQUEST_BUF(work);
+	struct smb2_sess_setup_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	char *in_blob, *out_blob;
+	struct channel *chann = NULL;
+	uint64_t prev_sess_id;
+	int in_len, out_len;
+	int retval;
+
+	in_blob = (char *)&req->hdr.ProtocolId +
+		le16_to_cpu(req->SecurityBufferOffset);
+	in_len = le16_to_cpu(req->SecurityBufferLength);
+	out_blob = (char *)&rsp->hdr.ProtocolId +
+		le16_to_cpu(rsp->SecurityBufferOffset);
+	out_len = work->response_sz -
+		offsetof(struct smb2_hdr, smb2_buf_length) -
+		le16_to_cpu(rsp->SecurityBufferOffset);
+
+	/* Check previous session */
+	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
+	if (prev_sess_id && prev_sess_id != sess->id)
+		destroy_previous_session(sess->user, prev_sess_id);
+
+	if (sess->state == SMB2_SESSION_VALID)
+		ksmbd_free_user(sess->user);
+
+	retval = ksmbd_krb5_authenticate(sess, in_blob, in_len,
+			out_blob, &out_len);
+	if (retval) {
+		ksmbd_debug(SMB, "krb5 authentication failed\n");
+		rsp->hdr.Status = STATUS_LOGON_FAILURE;
+		return retval;
+	}
+	rsp->SecurityBufferLength = cpu_to_le16(out_len);
+	inc_rfc1001_len(rsp, out_len - 1);
+
+	if ((conn->sign || server_conf.enforced_signing) ||
+			(req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
+		sess->sign = true;
+
+	if ((conn->vals->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION) &&
+			conn->ops->generate_encryptionkey) {
+		retval = conn->ops->generate_encryptionkey(sess);
+		if (retval) {
+			ksmbd_debug(SMB,
+				"SMB3 encryption key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return retval;
+		}
+		sess->enc = true;
+		rsp->SessionFlags = SMB2_SESSION_FLAG_ENCRYPT_DATA_LE;
+		sess->sign = false;
+	}
+
+	if (conn->dialect >= SMB30_PROT_ID) {
+		chann = lookup_chann_list(sess);
+		if (!chann) {
+			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			if (!chann)
+				return -ENOMEM;
+
+			chann->conn = conn;
+			INIT_LIST_HEAD(&chann->chann_list);
+			list_add(&chann->chann_list, &sess->ksmbd_chann_list);
+		}
+	}
+
+	if (conn->ops->generate_signingkey) {
+		retval = conn->ops->generate_signingkey(sess);
+		if (retval) {
+			ksmbd_debug(SMB,
+				"SMB3 signing key generation failed\n");
+			rsp->hdr.Status = STATUS_LOGON_FAILURE;
+			return retval;
+		}
+	}
+
+	if (conn->dialect > SMB20_PROT_ID) {
+		if (!ksmbd_conn_lookup_dialect(conn)) {
+			ksmbd_err("fail to verify the dialect\n");
+			rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+			return -EPERM;
+		}
+	}
+	return 0;
+}
+#else
+static int krb5_authenticate(struct ksmbd_work *work)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+int smb2_sess_setup(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_sess_setup_req *req = REQUEST_BUF(work);
+	struct smb2_sess_setup_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_session *sess;
+	struct negotiate_message *negblob;
+	int rc = 0;
+
+	ksmbd_debug(SMB, "Received request for session setup\n");
+
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->SessionFlags = 0;
+	rsp->SecurityBufferOffset = cpu_to_le16(72);
+	rsp->SecurityBufferLength = 0;
+	inc_rfc1001_len(rsp, 9);
+
+	if (!req->hdr.SessionId) {
+		sess = ksmbd_smb2_session_create();
+		if (!sess) {
+			rc = -ENOMEM;
+			goto out_err;
+		}
+		rsp->hdr.SessionId = cpu_to_le64(sess->id);
+		ksmbd_session_register(conn, sess);
+	} else {
+		sess = ksmbd_session_lookup(conn,
+				le64_to_cpu(req->hdr.SessionId));
+		if (!sess) {
+			rc = -ENOENT;
+			rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+			goto out_err;
+		}
+	}
+	work->sess = sess;
+
+	if (sess->state == SMB2_SESSION_EXPIRED)
+		sess->state = SMB2_SESSION_IN_PROGRESS;
+
+	negblob = (struct negotiate_message *)((char *)&req->hdr.ProtocolId +
+			le16_to_cpu(req->SecurityBufferOffset));
+
+	if (decode_negotiation_token(work, negblob) == 0) {
+		if (conn->mechToken)
+			negblob = (struct negotiate_message *)conn->mechToken;
+	}
+
+	if (server_conf.auth_mechs & conn->auth_mechs) {
+		if (conn->preferred_auth_mech &
+				(KSMBD_AUTH_KRB5 | KSMBD_AUTH_MSKRB5)) {
+			rc = generate_preauth_hash(work);
+			if (rc)
+				goto out_err;
+
+			rc = krb5_authenticate(work);
+			if (rc) {
+				rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+				goto out_err;
+			}
+
+			ksmbd_conn_set_good(work);
+			sess->state = SMB2_SESSION_VALID;
+			ksmbd_free(sess->Preauth_HashValue);
+			sess->Preauth_HashValue = NULL;
+		} else if (conn->preferred_auth_mech == KSMBD_AUTH_NTLMSSP) {
+			rc = generate_preauth_hash(work);
+			if (rc)
+				goto out_err;
+
+			if (negblob->MessageType == NtLmNegotiate) {
+				rc = ntlm_negotiate(work, negblob);
+				if (rc)
+					goto out_err;
+				rsp->hdr.Status =
+					STATUS_MORE_PROCESSING_REQUIRED;
+				/*
+				 * Note: here total size -1 is done as an
+				 * adjustment for 0 size blob
+				 */
+				inc_rfc1001_len(rsp,
+					le16_to_cpu(rsp->SecurityBufferLength)
+					- 1);
+
+			} else if (negblob->MessageType == NtLmAuthenticate) {
+				rc = ntlm_authenticate(work);
+				if (rc)
+					goto out_err;
+
+				ksmbd_conn_set_good(work);
+				sess->state = SMB2_SESSION_VALID;
+				ksmbd_free(sess->Preauth_HashValue);
+				sess->Preauth_HashValue = NULL;
+			}
+		} else {
+			/* TODO: need one more negotiation */
+			ksmbd_err("Not support the preferred authentication\n");
+			rc = -EINVAL;
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		}
+	} else {
+		ksmbd_err("Not support authentication\n");
+		rc = -EINVAL;
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	}
+
+out_err:
+	if (conn->use_spnego && conn->mechToken) {
+		kfree(conn->mechToken);
+		conn->mechToken = NULL;
+	}
+
+	if (rc < 0 && sess) {
+		ksmbd_session_destroy(sess);
+		work->sess = NULL;
+	}
+
+	return rc;
+}
+
+/**
+ * smb2_tree_connect() - handler for smb2 tree connect command
+ * @work:	smb work containing smb request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_tree_connect(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_tree_connect_req *req = REQUEST_BUF(work);
+	struct smb2_tree_connect_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_session *sess = work->sess;
+	char *treename = NULL, *name = NULL;
+	struct ksmbd_tree_conn_status status;
+	struct ksmbd_share_config *share;
+	int rc = -EINVAL;
+
+	treename = smb_strndup_from_utf16(req->Buffer,
+			le16_to_cpu(req->PathLength), true, conn->local_nls);
+	if (IS_ERR(treename)) {
+		ksmbd_err("treename is NULL\n");
+		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
+		goto out_err1;
+	}
+
+	name = ksmbd_extract_sharename(treename);
+	if (IS_ERR(name)) {
+		status.ret = KSMBD_TREE_CONN_STATUS_ERROR;
+		goto out_err1;
+	}
+
+	ksmbd_debug(SMB, "tree connect request for tree %s treename %s\n",
+		      name, treename);
+
+	status = ksmbd_tree_conn_connect(sess, name);
+	if (status.ret == KSMBD_TREE_CONN_STATUS_OK)
+		rsp->hdr.Id.SyncId.TreeId = cpu_to_le32(status.tree_conn->id);
+	else
+		goto out_err1;
+
+	share = status.tree_conn->share_conf;
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC share path request\n");
+		rsp->ShareType = SMB2_SHARE_TYPE_PIPE;
+		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
+			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE |
+			FILE_DELETE_LE | FILE_READ_CONTROL_LE |
+			FILE_WRITE_DAC_LE | FILE_WRITE_OWNER_LE |
+			FILE_SYNCHRONIZE_LE;
+	} else {
+		rsp->ShareType = SMB2_SHARE_TYPE_DISK;
+		rsp->MaximalAccess = FILE_READ_DATA_LE | FILE_READ_EA_LE |
+			FILE_EXECUTE_LE | FILE_READ_ATTRIBUTES_LE;
+		if (test_tree_conn_flag(status.tree_conn,
+					KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			rsp->MaximalAccess |= FILE_WRITE_DATA_LE |
+				FILE_APPEND_DATA_LE | FILE_WRITE_EA_LE |
+				FILE_DELETE_CHILD_LE | FILE_DELETE_LE |
+				FILE_WRITE_ATTRIBUTES_LE | FILE_DELETE_LE |
+				FILE_READ_CONTROL_LE | FILE_WRITE_DAC_LE |
+				FILE_WRITE_OWNER_LE | FILE_SYNCHRONIZE_LE;
+		}
+	}
+
+	status.tree_conn->maximal_access = le32_to_cpu(rsp->MaximalAccess);
+	if (conn->posix_ext_supported)
+		status.tree_conn->posix_extensions = true;
+
+out_err1:
+	rsp->StructureSize = cpu_to_le16(16);
+	rsp->Capabilities = 0;
+	rsp->Reserved = 0;
+	/* default manual caching */
+	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
+	inc_rfc1001_len(rsp, 16);
+
+	if (!IS_ERR(treename))
+		kfree(treename);
+	if (!IS_ERR(name))
+		kfree(name);
+
+	switch (status.ret) {
+	case KSMBD_TREE_CONN_STATUS_OK:
+		rsp->hdr.Status = STATUS_SUCCESS;
+		rc = 0;
+		break;
+	case KSMBD_TREE_CONN_STATUS_NO_SHARE:
+		rsp->hdr.Status = STATUS_BAD_NETWORK_PATH;
+		break;
+	case -ENOMEM:
+	case KSMBD_TREE_CONN_STATUS_NOMEM:
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		break;
+	case KSMBD_TREE_CONN_STATUS_ERROR:
+	case KSMBD_TREE_CONN_STATUS_TOO_MANY_CONNS:
+	case KSMBD_TREE_CONN_STATUS_TOO_MANY_SESSIONS:
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		break;
+	case -EINVAL:
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		break;
+	default:
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	}
+
+	return rc;
+}
+
+/**
+ * smb2_create_open_flags() - convert smb open flags to unix open flags
+ * @file_present:	is file already present
+ * @access:		file access flags
+ * @disposition:	file disposition flags
+ *
+ * Return:      file open flags
+ */
+static int smb2_create_open_flags(bool file_present, __le32 access,
+		__le32 disposition)
+{
+	int oflags = O_NONBLOCK | O_LARGEFILE;
+
+	if (access & FILE_READ_DESIRED_ACCESS_LE &&
+			access & FILE_WRITE_DESIRE_ACCESS_LE)
+		oflags |= O_RDWR;
+	else if (access & FILE_WRITE_DESIRE_ACCESS_LE)
+		oflags |= O_WRONLY;
+	else
+		oflags |= O_RDONLY;
+
+	if (access == FILE_READ_ATTRIBUTES_LE)
+		oflags |= O_PATH;
+
+	if (file_present) {
+		switch (disposition & FILE_CREATE_MASK_LE) {
+		case FILE_OPEN_LE:
+		case FILE_CREATE_LE:
+			break;
+		case FILE_SUPERSEDE_LE:
+		case FILE_OVERWRITE_LE:
+		case FILE_OVERWRITE_IF_LE:
+			oflags |= O_TRUNC;
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (disposition & FILE_CREATE_MASK_LE) {
+		case FILE_SUPERSEDE_LE:
+		case FILE_CREATE_LE:
+		case FILE_OPEN_IF_LE:
+		case FILE_OVERWRITE_IF_LE:
+			oflags |= O_CREAT;
+			break;
+		case FILE_OPEN_LE:
+		case FILE_OVERWRITE_LE:
+			oflags &= ~O_CREAT;
+			break;
+		default:
+			break;
+		}
+	}
+	return oflags;
+}
+
+/**
+ * smb2_tree_disconnect() - handler for smb tree connect request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0
+ */
+int smb2_tree_disconnect(struct ksmbd_work *work)
+{
+	struct smb2_tree_disconnect_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_tree_connect *tcon = work->tcon;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	inc_rfc1001_len(rsp, 4);
+
+	ksmbd_debug(SMB, "request\n");
+
+	if (!tcon) {
+		struct smb2_tree_disconnect_req *req = REQUEST_BUF(work);
+
+		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	ksmbd_close_tree_conn_fds(work);
+	ksmbd_tree_conn_disconnect(sess, tcon);
+	return 0;
+}
+
+/**
+ * smb2_session_logoff() - handler for session log off request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0
+ */
+int smb2_session_logoff(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_logoff_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_session *sess = work->sess;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	inc_rfc1001_len(rsp, 4);
+
+	ksmbd_debug(SMB, "request\n");
+
+	/* Got a valid session, set connection state */
+	WARN_ON(sess->conn != conn);
+
+	/* setting CifsExiting here may race with start_tcp_sess */
+	ksmbd_conn_set_need_reconnect(work);
+	ksmbd_close_session_fds(work);
+	ksmbd_conn_wait_idle(conn);
+
+	if (ksmbd_tree_conn_session_logoff(sess)) {
+		struct smb2_logoff_req *req = REQUEST_BUF(work);
+
+		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
+		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	ksmbd_destroy_file_table(&sess->file_table);
+	sess->state = SMB2_SESSION_EXPIRED;
+
+	ksmbd_free_user(sess->user);
+	sess->user = NULL;
+
+	/* let start_tcp_sess free connection info now */
+	ksmbd_conn_set_need_negotiate(work);
+	return 0;
+}
+
+/**
+ * create_smb2_pipe() - create IPC pipe
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+static noinline int create_smb2_pipe(struct ksmbd_work *work)
+{
+	struct smb2_create_rsp *rsp = RESPONSE_BUF(work);
+	struct smb2_create_req *req = REQUEST_BUF(work);
+	int id;
+	int err;
+	char *name;
+
+	name = smb_strndup_from_utf16(req->Buffer, le16_to_cpu(req->NameLength),
+			1, work->conn->local_nls);
+	if (IS_ERR(name)) {
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		err = PTR_ERR(name);
+		goto out;
+	}
+
+	id = ksmbd_session_rpc_open(work->sess, name);
+	if (id < 0)
+		ksmbd_err("Unable to open RPC pipe: %d\n", id);
+
+	rsp->StructureSize = cpu_to_le16(89);
+	rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
+	rsp->Reserved = 0;
+	rsp->CreateAction = cpu_to_le32(FILE_OPENED);
+
+	rsp->CreationTime = cpu_to_le64(0);
+	rsp->LastAccessTime = cpu_to_le64(0);
+	rsp->ChangeTime = cpu_to_le64(0);
+	rsp->AllocationSize = cpu_to_le64(0);
+	rsp->EndofFile = cpu_to_le64(0);
+	rsp->FileAttributes = ATTR_NORMAL_LE;
+	rsp->Reserved2 = 0;
+	rsp->VolatileFileId = cpu_to_le64(id);
+	rsp->PersistentFileId = 0;
+	rsp->CreateContextsOffset = 0;
+	rsp->CreateContextsLength = 0;
+
+	inc_rfc1001_len(rsp, 88); /* StructureSize - 1*/
+	kfree(name);
+	return 0;
+
+out:
+	smb2_set_err_rsp(work);
+	return err;
+}
+
+#define DURABLE_RECONN_V2	1
+#define DURABLE_RECONN		2
+#define DURABLE_REQ_V2		3
+#define DURABLE_REQ		4
+#define APP_INSTANCE_ID		5
+
+struct durable_info {
+	struct ksmbd_file *fp;
+	int type;
+	int reconnected;
+	int persistent;
+	int timeout;
+	char *CreateGuid;
+	char *app_id;
+};
+
+static int parse_durable_handle_context(struct ksmbd_work *work,
+	struct smb2_create_req *req, struct lease_ctx_info *lc,
+	struct durable_info *d_info)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct create_context *context;
+	int i, err = 0;
+	uint64_t persistent_id = 0;
+	int req_op_level;
+	static const char * const durable_arr[] = {"DH2C", "DHnC", "DH2Q",
+		"DHnQ", SMB2_CREATE_APP_INSTANCE_ID};
+
+	req_op_level = req->RequestedOplockLevel;
+	for (i = 1; i <= 5; i++) {
+		context = smb2_find_context_vals(req, durable_arr[i - 1]);
+		if (IS_ERR(context)) {
+			err = PTR_ERR(context);
+			if (err == -EINVAL) {
+				ksmbd_err("bad name length\n");
+				goto out;
+			}
+			err = 0;
+			continue;
+		}
+
+		switch (i) {
+		case DURABLE_RECONN_V2:
+		{
+			struct create_durable_reconn_v2_req *recon_v2;
+
+			recon_v2 =
+				(struct create_durable_reconn_v2_req *)context;
+			persistent_id = le64_to_cpu(
+					recon_v2->Fid.PersistentFileId);
+			d_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!d_info->fp) {
+				ksmbd_err("Failed to get Durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+
+			if (memcmp(d_info->fp->create_guid,
+				recon_v2->CreateGuid,
+				SMB2_CREATE_GUID_SIZE)) {
+				err = -EBADF;
+				goto out;
+			}
+			d_info->type = i;
+			d_info->reconnected = 1;
+			ksmbd_debug(SMB,
+				"reconnect v2 Persistent-id from reconnect = %llu\n",
+					persistent_id);
+			break;
+		}
+		case DURABLE_RECONN:
+		{
+			struct create_durable_reconn_req *recon;
+
+			if (d_info->type == DURABLE_RECONN_V2 ||
+				d_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			recon =
+				(struct create_durable_reconn_req *)context;
+			persistent_id = le64_to_cpu(
+					recon->Data.Fid.PersistentFileId);
+			d_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!d_info->fp) {
+				ksmbd_err("Failed to get Durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+			d_info->type = i;
+			d_info->reconnected = 1;
+			ksmbd_debug(SMB,
+				"reconnect Persistent-id from reconnect = %llu\n",
+					persistent_id);
+			break;
+		}
+		case DURABLE_REQ_V2:
+		{
+			struct create_durable_req_v2 *durable_v2_blob;
+
+			if (d_info->type == DURABLE_RECONN ||
+				d_info->type == DURABLE_RECONN_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			durable_v2_blob =
+				(struct create_durable_req_v2 *)context;
+			ksmbd_debug(SMB, "Request for durable v2 open\n");
+			d_info->fp = ksmbd_lookup_fd_cguid(
+					durable_v2_blob->CreateGuid);
+			if (d_info->fp) {
+				if (!memcmp(conn->ClientGUID,
+					d_info->fp->client_guid,
+					SMB2_CLIENT_GUID_SIZE)) {
+					if (!(req->hdr.Flags &
+						SMB2_FLAGS_REPLAY_OPERATIONS)) {
+						err = -ENOEXEC;
+						goto out;
+					}
+
+					d_info->fp->conn = conn;
+					d_info->reconnected = 1;
+					goto out;
+				}
+			}
+			if (((lc &&
+				(lc->req_state &
+					SMB2_LEASE_HANDLE_CACHING_LE)) ||
+				(req_op_level == SMB2_OPLOCK_LEVEL_BATCH))) {
+				d_info->CreateGuid =
+					durable_v2_blob->CreateGuid;
+				d_info->persistent =
+					le32_to_cpu(durable_v2_blob->Flags);
+				d_info->timeout =
+					le32_to_cpu(durable_v2_blob->Timeout);
+				d_info->type = i;
+			}
+			break;
+		}
+		case DURABLE_REQ:
+			if (d_info->type == DURABLE_RECONN)
+				goto out;
+			if (d_info->type == DURABLE_RECONN_V2 ||
+				d_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (((lc &&
+				(lc->req_state &
+					SMB2_LEASE_HANDLE_CACHING_LE)) ||
+				(req_op_level == SMB2_OPLOCK_LEVEL_BATCH))) {
+				ksmbd_debug(SMB, "Request for durable open\n");
+				d_info->type = i;
+			}
+			break;
+		case APP_INSTANCE_ID:
+		{
+			struct create_app_inst_id *inst_id;
+
+			inst_id = (struct create_app_inst_id *)context;
+			ksmbd_close_fd_app_id(work, inst_id->AppInstanceId);
+			d_info->app_id = inst_id->AppInstanceId;
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
+out:
+
+	return err;
+}
+
+/**
+ * smb2_set_ea() - handler for setting extended attributes using set
+ *		info command
+ * @eabuf:	set info command buffer
+ * @path:	dentry path for get ea
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
+{
+	char *attr_name = NULL, *value;
+	int rc = 0;
+	int next = 0;
+
+	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
+	if (!attr_name)
+		return -ENOMEM;
+
+	do {
+		if (!eabuf->EaNameLength)
+			goto next;
+
+		ksmbd_debug(SMB,
+			"name : <%s>, name_len : %u, value_len : %u, next : %u\n",
+				eabuf->name, eabuf->EaNameLength,
+				le16_to_cpu(eabuf->EaValueLength),
+				le32_to_cpu(eabuf->NextEntryOffset));
+
+		if (eabuf->EaNameLength >
+				(XATTR_NAME_MAX - XATTR_USER_PREFIX_LEN)) {
+			rc = -EINVAL;
+			break;
+		}
+
+		memcpy(attr_name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN);
+		memcpy(&attr_name[XATTR_USER_PREFIX_LEN], eabuf->name,
+				eabuf->EaNameLength);
+		attr_name[XATTR_USER_PREFIX_LEN + eabuf->EaNameLength] = '\0';
+		value = (char *)&eabuf->name + eabuf->EaNameLength + 1;
+
+		if (!eabuf->EaValueLength) {
+			rc = ksmbd_vfs_casexattr_len(path->dentry,
+						     attr_name,
+						     XATTR_USER_PREFIX_LEN +
+						     eabuf->EaNameLength);
+
+			/* delete the EA only when it exits */
+			if (rc > 0) {
+				rc = ksmbd_vfs_remove_xattr(path->dentry,
+							    attr_name);
+
+				if (rc < 0) {
+					ksmbd_debug(SMB,
+						"remove xattr failed(%d)\n",
+						rc);
+					break;
+				}
+			}
+
+			/* if the EA doesn't exist, just do nothing. */
+			rc = 0;
+		} else {
+			rc = ksmbd_vfs_setxattr(path->dentry, attr_name, value,
+					le16_to_cpu(eabuf->EaValueLength), 0);
+			if (rc < 0) {
+				ksmbd_debug(SMB,
+					"ksmbd_vfs_setxattr is failed(%d)\n",
+					rc);
+				break;
+			}
+		}
+
+next:
+		next = le32_to_cpu(eabuf->NextEntryOffset);
+		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
+	} while (next != 0);
+
+	kfree(attr_name);
+	return rc;
+}
+
+static inline int check_context_err(void *ctx, char *str)
+{
+	int err;
+
+	err = PTR_ERR(ctx);
+	ksmbd_debug(SMB, "find context %s err %d\n", str, err);
+
+	if (err == -EINVAL) {
+		ksmbd_err("bad name length\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static noinline int smb2_set_stream_name_xattr(struct path *path,
+					       struct ksmbd_file *fp,
+					       char *stream_name,
+					       int s_type)
+{
+	size_t xattr_stream_size;
+	char *xattr_stream_name;
+	int rc;
+
+	rc = ksmbd_vfs_xattr_stream_name(stream_name,
+					 &xattr_stream_name,
+					 &xattr_stream_size,
+					 s_type);
+	if (rc)
+		return rc;
+
+	fp->stream.name = xattr_stream_name;
+	fp->stream.size = xattr_stream_size;
+
+	/* Check if there is stream prefix in xattr space */
+	rc = ksmbd_vfs_casexattr_len(path->dentry,
+				     xattr_stream_name,
+				     xattr_stream_size);
+	if (rc >= 0)
+		return 0;
+
+	if (fp->cdoption == FILE_OPEN_LE) {
+		ksmbd_debug(SMB, "XATTR stream name lookup failed: %d\n", rc);
+		return -EBADF;
+	}
+
+	rc = ksmbd_vfs_setxattr(path->dentry, xattr_stream_name, NULL, 0, 0);
+	if (rc < 0)
+		ksmbd_err("Failed to store XATTR stream name :%d\n", rc);
+	return 0;
+}
+
+static int smb2_remove_smb_xattrs(struct dentry *dentry)
+{
+	char *name, *xattr_list = NULL;
+	ssize_t xattr_list_len;
+	int err = 0;
+
+	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	for (name = xattr_list; name - xattr_list < xattr_list_len;
+			name += strlen(name) + 1) {
+		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
+
+		if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
+			strncmp(&name[XATTR_USER_PREFIX_LEN],
+				DOS_ATTRIBUTE_PREFIX,
+				DOS_ATTRIBUTE_PREFIX_LEN) &&
+			strncmp(&name[XATTR_USER_PREFIX_LEN],
+				STREAM_PREFIX,
+				STREAM_PREFIX_LEN))
+			continue;
+
+		err = ksmbd_vfs_remove_xattr(dentry, name);
+		if (err)
+			ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
+	}
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return err;
+}
+
+static int smb2_create_truncate(struct path *path)
+{
+	int rc = vfs_truncate(path, 0);
+
+	if (rc) {
+		ksmbd_err("vfs_truncate failed, rc %d\n", rc);
+		return rc;
+	}
+
+	rc = smb2_remove_smb_xattrs(path->dentry);
+	if (rc == -EOPNOTSUPP)
+		rc = 0;
+	if (rc)
+		ksmbd_debug(SMB,
+			"ksmbd_truncate_stream_name_xattr failed, rc %d\n",
+				rc);
+	return rc;
+}
+
+static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon,
+			    struct path *path,
+			    struct ksmbd_file *fp)
+{
+	struct xattr_dos_attrib da = {0};
+	int rc;
+
+	if (!test_share_config_flag(tcon->share_conf,
+				    KSMBD_SHARE_FLAG_STORE_DOS_ATTRS))
+		return;
+
+	da.version = 4;
+	da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+	da.itime = da.create_time = fp->create_time;
+	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
+		XATTR_DOSINFO_ITIME;
+
+	rc = ksmbd_vfs_set_dos_attrib_xattr(path->dentry, &da);
+	if (rc)
+		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
+}
+
+static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
+			       struct path *path,
+			       struct ksmbd_file *fp)
+{
+	struct xattr_dos_attrib da;
+	int rc;
+
+	fp->f_ci->m_fattr &= ~(ATTR_HIDDEN_LE | ATTR_SYSTEM_LE);
+
+	/* get FileAttributes from XATTR_NAME_DOS_ATTRIBUTE */
+	if (!test_share_config_flag(tcon->share_conf,
+				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS))
+		return;
+
+	rc = ksmbd_vfs_get_dos_attrib_xattr(path->dentry, &da);
+	if (rc > 0) {
+		fp->f_ci->m_fattr = cpu_to_le32(da.attr);
+		fp->create_time = da.create_time;
+		fp->itime = da.itime;
+	}
+}
+
+static int smb2_creat(struct ksmbd_work *work,
+		      struct path *path,
+		      char *name,
+		      int open_flags,
+		      umode_t posix_mode,
+		      bool is_dir)
+{
+	struct ksmbd_tree_connect *tcon = work->tcon;
+	struct ksmbd_share_config *share = tcon->share_conf;
+	umode_t mode;
+	int rc;
+
+	if (!(open_flags & O_CREAT))
+		return -EBADF;
+
+	ksmbd_debug(SMB, "file does not exist, so creating\n");
+	if (is_dir == true) {
+		ksmbd_debug(SMB, "creating directory\n");
+
+		mode = share_config_directory_mode(share, posix_mode);
+		rc = ksmbd_vfs_mkdir(work, name, mode);
+		if (rc)
+			return rc;
+	} else {
+		ksmbd_debug(SMB, "creating regular file\n");
+
+		mode = share_config_create_mode(share, posix_mode);
+		rc = ksmbd_vfs_create(work, name, mode);
+		if (rc)
+			return rc;
+	}
+
+	rc = ksmbd_vfs_kern_path(name, 0, path, 0);
+	if (rc) {
+		ksmbd_err("cannot get linux path (%s), err = %d\n",
+				name, rc);
+		return rc;
+	}
+	return 0;
+}
+
+static int smb2_create_sd_buffer(struct ksmbd_work *work,
+		struct smb2_create_req *req, struct dentry *dentry)
+{
+	struct create_context *context;
+	int rc = -ENOENT;
+
+	if (!req->CreateContextsOffset)
+		return rc;
+
+	/* Parse SD BUFFER create contexts */
+	context = smb2_find_context_vals(req, SMB2_CREATE_SD_BUFFER);
+	if (context && !IS_ERR(context)) {
+		struct create_sd_buf_req *sd_buf;
+
+		ksmbd_debug(SMB,
+			"Set ACLs using SMB2_CREATE_SD_BUFFER context\n");
+		sd_buf = (struct create_sd_buf_req *)context;
+		rc = set_info_sec(work->conn, work->tcon, dentry, &sd_buf->ntsd,
+			le32_to_cpu(sd_buf->ccontext.DataLength), true);
+	}
+
+	return rc;
+}
+
+/**
+ * smb2_open() - handler for smb file open request
+ * @work:	smb work containing request buffer
+ *
+ * Return:      0 on success, otherwise error
+ */
+int smb2_open(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_tree_connect *tcon = work->tcon;
+	struct smb2_create_req *req;
+	struct smb2_create_rsp *rsp, *rsp_org;
+	struct path path;
+	struct ksmbd_share_config *share = tcon->share_conf;
+	struct ksmbd_file *fp = NULL;
+	struct file *filp = NULL;
+	struct kstat stat;
+	struct create_context *context;
+	struct lease_ctx_info *lc = NULL;
+	struct create_ea_buf_req *ea_buf = NULL;
+	struct oplock_info *opinfo;
+	__le32 *next_ptr = NULL;
+	int req_op_level = 0, open_flags = 0, file_info = 0;
+	int rc = 0, len = 0;
+	int contxt_cnt = 0, query_disk_id = 0;
+	int maximal_access_ctxt = 0, posix_ctxt = 0;
+	int s_type = 0;
+	int next_off = 0;
+	char *name = NULL;
+	char *stream_name = NULL;
+	bool file_present = false, created = false, already_permitted = false;
+	struct durable_info d_info;
+	int share_ret, need_truncate = 0;
+	u64 time;
+	umode_t posix_mode = 0;
+	__le32 daccess, maximal_access = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	if (req->hdr.NextCommand && !work->next_smb2_rcv_hdr_off &&
+			(req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)) {
+		ksmbd_debug(SMB, "invalid flag in chained command\n");
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		smb2_set_err_rsp(work);
+		return -EINVAL;
+	}
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe create request\n");
+		return create_smb2_pipe(work);
+	}
+
+	if (req->NameLength) {
+		if ((req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
+			*(char *)req->Buffer == '\\') {
+			ksmbd_err("not allow directory name included leading slash\n");
+			rc = -EINVAL;
+			goto err_out1;
+		}
+
+		name = smb2_get_name(share,
+				     req->Buffer,
+				     le16_to_cpu(req->NameLength),
+				     work->conn->local_nls);
+		if (IS_ERR(name)) {
+			rc = PTR_ERR(name);
+			if (rc != -ENOMEM)
+				rc = -ENOENT;
+			goto err_out1;
+		}
+
+		ksmbd_debug(SMB, "converted name = %s\n", name);
+		if (strchr(name, ':')) {
+			if (!test_share_config_flag(work->tcon->share_conf,
+					KSMBD_SHARE_FLAG_STREAMS)) {
+				rc = -EBADF;
+				goto err_out1;
+			}
+			rc = parse_stream_name(name, &stream_name, &s_type);
+			if (rc < 0)
+				goto err_out1;
+		}
+
+		rc = ksmbd_validate_filename(name);
+		if (rc < 0)
+			goto err_out1;
+
+		if (ksmbd_share_veto_filename(share, name)) {
+			rc = -ENOENT;
+			ksmbd_debug(SMB, "Reject open(), vetoed file: %s\n",
+				name);
+			goto err_out1;
+		}
+	} else {
+		len = strlen(share->path);
+		ksmbd_debug(SMB, "share path len %d\n", len);
+		name = kmalloc(len + 1, GFP_KERNEL);
+		if (!name) {
+			rsp->hdr.Status = STATUS_NO_MEMORY;
+			rc = -ENOMEM;
+			goto err_out1;
+		}
+
+		memcpy(name, share->path, len);
+		*(name + len) = '\0';
+	}
+
+	req_op_level = req->RequestedOplockLevel;
+	memset(&d_info, 0, sizeof(struct durable_info));
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE &&
+		req->CreateContextsOffset) {
+		lc = parse_lease_state(req);
+		rc = parse_durable_handle_context(work, req, lc, &d_info);
+		if (rc) {
+			ksmbd_err("error parsing durable handle context\n");
+			goto err_out1;
+		}
+
+		if (d_info.reconnected) {
+			fp = d_info.fp;
+			rc = smb2_check_durable_oplock(d_info.fp, lc, name);
+			if (rc)
+				goto err_out1;
+			rc = ksmbd_reopen_durable_fd(work, d_info.fp);
+			if (rc)
+				goto err_out1;
+			if (ksmbd_override_fsids(work)) {
+				rc = -ENOMEM;
+				goto err_out1;
+			}
+			file_info = FILE_OPENED;
+			fp = d_info.fp;
+			goto reconnected;
+		}
+	} else {
+		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+			lc = parse_lease_state(req);
+	}
+
+	if (le32_to_cpu(req->ImpersonationLevel) >
+			le32_to_cpu(IL_DELEGATE_LE)) {
+		ksmbd_err("Invalid impersonationlevel : 0x%x\n",
+			le32_to_cpu(req->ImpersonationLevel));
+		rc = -EIO;
+		rsp->hdr.Status = STATUS_BAD_IMPERSONATION_LEVEL;
+		goto err_out1;
+	}
+
+	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK)) {
+		ksmbd_err("Invalid create options : 0x%x\n",
+			le32_to_cpu(req->CreateOptions));
+		rc = -EINVAL;
+		goto err_out1;
+	} else {
+
+		if (req->CreateOptions & FILE_SEQUENTIAL_ONLY_LE &&
+			req->CreateOptions & FILE_RANDOM_ACCESS_LE)
+			req->CreateOptions = ~(FILE_SEQUENTIAL_ONLY_LE);
+
+		if (req->CreateOptions & (FILE_OPEN_BY_FILE_ID_LE |
+			CREATE_TREE_CONNECTION | FILE_RESERVE_OPFILTER_LE)) {
+			rc = -EOPNOTSUPP;
+			goto err_out1;
+		}
+
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
+			if (req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE) {
+				rc = -EINVAL;
+				goto err_out1;
+			} else if (req->CreateOptions & FILE_NO_COMPRESSION_LE)
+				req->CreateOptions = ~(FILE_NO_COMPRESSION_LE);
+		}
+	}
+
+	if (le32_to_cpu(req->CreateDisposition) >
+			le32_to_cpu(FILE_OVERWRITE_IF_LE)) {
+		ksmbd_err("Invalid create disposition : 0x%x\n",
+			le32_to_cpu(req->CreateDisposition));
+		rc = -EINVAL;
+		goto err_out1;
+	}
+
+	if (!(req->DesiredAccess & DESIRED_ACCESS_MASK)) {
+		ksmbd_err("Invalid desired access : 0x%x\n",
+			le32_to_cpu(req->DesiredAccess));
+		rc = -EACCES;
+		goto err_out1;
+	}
+
+	if (req->FileAttributes &&
+		!(req->FileAttributes & ATTR_MASK_LE)) {
+		ksmbd_err("Invalid file attribute : 0x%x\n",
+			le32_to_cpu(req->FileAttributes));
+		rc = -EINVAL;
+		goto err_out1;
+	}
+
+	if (req->CreateContextsOffset) {
+		/* Parse non-durable handle create contexts */
+		context = smb2_find_context_vals(req, SMB2_CREATE_EA_BUFFER);
+		if (IS_ERR(context)) {
+			rc = check_context_err(context, SMB2_CREATE_EA_BUFFER);
+			if (rc < 0)
+				goto err_out1;
+		} else {
+			ea_buf = (struct create_ea_buf_req *)context;
+			if (req->CreateOptions & FILE_NO_EA_KNOWLEDGE_LE) {
+				rsp->hdr.Status = STATUS_ACCESS_DENIED;
+				rc = -EACCES;
+				goto err_out1;
+			}
+		}
+
+		context = smb2_find_context_vals(req,
+				SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST);
+		if (IS_ERR(context)) {
+			rc = check_context_err(context,
+				SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST);
+			if (rc < 0)
+				goto err_out1;
+		} else {
+			ksmbd_debug(SMB,
+				"get query maximal access context\n");
+			maximal_access_ctxt = 1;
+		}
+
+		context = smb2_find_context_vals(req,
+				SMB2_CREATE_TIMEWARP_REQUEST);
+		if (IS_ERR(context)) {
+			rc = check_context_err(context,
+				SMB2_CREATE_TIMEWARP_REQUEST);
+			if (rc < 0)
+				goto err_out1;
+		} else {
+			ksmbd_debug(SMB, "get timewarp context\n");
+			rc = -EBADF;
+			goto err_out1;
+		}
+
+		if (tcon->posix_extensions) {
+			context = smb2_find_context_vals(req,
+				SMB2_CREATE_TAG_POSIX);
+			if (IS_ERR(context)) {
+				rc = check_context_err(context,
+						SMB2_CREATE_TAG_POSIX);
+				if (rc < 0)
+					goto err_out1;
+			} else {
+				struct create_posix *posix =
+					(struct create_posix *)context;
+				ksmbd_debug(SMB, "get posix context\n");
+
+				posix_mode = le32_to_cpu(posix->Mode);
+				posix_ctxt = 1;
+			}
+		}
+	}
+
+	if (ksmbd_override_fsids(work)) {
+		rc = -ENOMEM;
+		goto err_out1;
+	}
+
+	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
+		/*
+		 * On delete request, instead of following up, need to
+		 * look the current entity
+		 */
+		rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+		if (!rc) {
+			/*
+			 * If file exists with under flags, return access
+			 * denied error.
+			 */
+			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
+				req->CreateDisposition == FILE_OPEN_IF_LE) {
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+
+			if (!test_tree_conn_flag(tcon,
+			    KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+				ksmbd_debug(SMB,
+					"User does not have write permission\n");
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+		}
+	} else {
+		if (test_share_config_flag(work->tcon->share_conf,
+					KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS)) {
+			/*
+			 * Use LOOKUP_FOLLOW to follow the path of
+			 * symlink in path buildup
+			 */
+			rc = ksmbd_vfs_kern_path(name, LOOKUP_FOLLOW, &path, 1);
+			if (rc) { /* Case for broken link ?*/
+				rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+			}
+		} else {
+			rc = ksmbd_vfs_kern_path(name, 0, &path, 1);
+			if (!rc && d_is_symlink(path.dentry)) {
+				rc = -EACCES;
+				path_put(&path);
+				goto err_out;
+			}
+		}
+	}
+
+	if (rc) {
+		if (rc == -EACCES) {
+			ksmbd_debug(SMB,
+				"User does not have right permission\n");
+			goto err_out;
+		}
+		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
+				name, rc);
+		rc = 0;
+	} else {
+		file_present = true;
+		generic_fillattr(&init_user_ns, d_inode(path.dentry), &stat);
+	}
+	if (stream_name) {
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
+			if (s_type == DATA_STREAM) {
+				rc = -EIO;
+				rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+			}
+		} else {
+			if (S_ISDIR(stat.mode) && s_type == DATA_STREAM) {
+				rc = -EIO;
+				rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+			}
+		}
+
+		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE &&
+			req->FileAttributes & ATTR_NORMAL_LE) {
+			rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+			rc = -EIO;
+		}
+
+		if (rc < 0)
+			goto err_out;
+	}
+
+	if (file_present && req->CreateOptions & FILE_NON_DIRECTORY_FILE_LE
+		&& S_ISDIR(stat.mode) &&
+		!(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+		ksmbd_debug(SMB, "open() argument is a directory: %s, %x\n",
+			      name, req->CreateOptions);
+		rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+		rc = -EIO;
+		goto err_out;
+	}
+
+	if (file_present && (req->CreateOptions & FILE_DIRECTORY_FILE_LE) &&
+		!(req->CreateDisposition == FILE_CREATE_LE) &&
+		!S_ISDIR(stat.mode)) {
+		rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
+		rc = -EIO;
+		goto err_out;
+	}
+
+	if (!stream_name && file_present &&
+		(req->CreateDisposition == FILE_CREATE_LE)) {
+		rc = -EEXIST;
+		goto err_out;
+	}
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE &&
+		file_present)
+		file_present = ksmbd_close_inode_fds(work,
+						     d_inode(path.dentry));
+
+	daccess = smb_map_generic_desired_access(req->DesiredAccess);
+
+	if (file_present && !(req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
+		rc = smb_check_perm_dacl(conn, path.dentry, &daccess,
+				sess->user->uid);
+		if (rc)
+			goto err_out;
+	}
+
+	if (daccess & FILE_MAXIMAL_ACCESS_LE) {
+		if (!file_present) {
+			daccess = cpu_to_le32(GENERIC_ALL_FLAGS);
+		} else {
+			rc = ksmbd_vfs_query_maximal_access(path.dentry,
+							    &daccess);
+			if (rc)
+				goto err_out;
+			already_permitted = true;
+		}
+		maximal_access = daccess;
+	}
+
+	open_flags = smb2_create_open_flags(file_present,
+		daccess, req->CreateDisposition);
+
+	if (!test_tree_conn_flag(tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		if (open_flags & O_CREAT) {
+			ksmbd_debug(SMB,
+				"User does not have write permission\n");
+			rc = -EACCES;
+			goto err_out;
+		}
+	}
+
+	/*create file if not present */
+	if (!file_present) {
+		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+			req->CreateOptions & FILE_DIRECTORY_FILE_LE);
+		if (rc)
+			goto err_out;
+
+		created = true;
+		if (ea_buf) {
+			rc = smb2_set_ea(&ea_buf->ea, &path);
+			if (rc == -EOPNOTSUPP)
+				rc = 0;
+			else if (rc)
+				goto err_out;
+		}
+	} else if (!already_permitted) {
+		bool may_delete;
+
+		may_delete = daccess & FILE_DELETE_LE ||
+			req->CreateOptions & FILE_DELETE_ON_CLOSE_LE;
+
+		/* FILE_READ_ATTRIBUTE is allowed without inode_permission,
+		 * because execute(search) permission on a parent directory,
+		 * is already granted.
+		 */
+		if (daccess & ~(FILE_READ_ATTRIBUTES_LE |
+				FILE_READ_CONTROL_LE)) {
+			if (ksmbd_vfs_inode_permission(path.dentry,
+					open_flags & O_ACCMODE, may_delete)) {
+				rc = -EACCES;
+				goto err_out;
+			}
+		}
+	}
+
+	rc = ksmbd_query_inode_status(d_inode(path.dentry->d_parent));
+	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	rc = 0;
+	filp = dentry_open(&path, open_flags, current_cred());
+	if (IS_ERR(filp)) {
+		rc = PTR_ERR(filp);
+		ksmbd_err("dentry open for dir failed, rc %d\n", rc);
+		goto err_out;
+	}
+
+	if (file_present) {
+		if (!(open_flags & O_TRUNC))
+			file_info = FILE_OPENED;
+		else
+			file_info = FILE_OVERWRITTEN;
+
+		if ((req->CreateDisposition & FILE_CREATE_MASK_LE)
+				== FILE_SUPERSEDE_LE)
+			file_info = FILE_SUPERSEDED;
+	} else if (open_flags & O_CREAT)
+		file_info = FILE_CREATED;
+
+	ksmbd_vfs_set_fadvise(filp, req->CreateOptions);
+
+	/* Obtain Volatile-ID */
+	fp = ksmbd_open_fd(work, filp);
+	if (IS_ERR(fp)) {
+		fput(filp);
+		rc = PTR_ERR(fp);
+		fp = NULL;
+		goto err_out;
+	}
+
+	/* Get Persistent-ID */
+	ksmbd_open_durable_fd(fp);
+	if (!HAS_FILE_ID(fp->persistent_id)) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	fp->filename = name;
+	fp->cdoption = req->CreateDisposition;
+	fp->daccess = daccess;
+	fp->saccess = req->ShareAccess;
+	fp->coption = req->CreateOptions;
+
+	/* Set default windows and posix acls if creating new file */
+	if (created) {
+		int posix_acl_rc;
+		struct inode *inode = path.dentry->d_inode;
+
+		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(inode, path.dentry->d_parent->d_inode);
+		if (posix_acl_rc)
+			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
+
+		if (test_share_config_flag(work->tcon->share_conf,
+		    KSMBD_SHARE_FLAG_ACL_XATTR)) {
+			rc = smb_inherit_dacl(conn, path.dentry, sess->user->uid,
+					sess->user->gid);
+		}
+
+		if (rc) {
+			rc = smb2_create_sd_buffer(work, req, path.dentry);
+			if (rc) {
+				if (posix_acl_rc)
+					ksmbd_vfs_set_init_posix_acl(inode);
+
+				if (test_share_config_flag(work->tcon->share_conf,
+					    KSMBD_SHARE_FLAG_ACL_XATTR)) {
+					struct smb_fattr fattr;
+					struct smb_ntsd *pntsd;
+					int pntsd_size, ace_num;
+
+					fattr.cf_uid = inode->i_uid;
+					fattr.cf_gid = inode->i_gid;
+					fattr.cf_mode = inode->i_mode;
+					fattr.cf_dacls = NULL;
+
+					fattr.cf_acls = ksmbd_vfs_get_acl(inode, ACL_TYPE_ACCESS);
+					ace_num = fattr.cf_acls->a_count;
+					if (S_ISDIR(inode->i_mode)) {
+						fattr.cf_dacls =
+							ksmbd_vfs_get_acl(inode, ACL_TYPE_DEFAULT);
+						ace_num += fattr.cf_dacls->a_count;
+					}
+
+					pntsd = kmalloc(sizeof(struct smb_ntsd) +
+							sizeof(struct smb_sid)*3 +
+							sizeof(struct smb_acl) +
+							sizeof(struct smb_ace)*ace_num*2,
+							GFP_KERNEL);
+					if (!pntsd)
+						goto err_out;
+
+					rc = build_sec_desc(pntsd, NULL,
+						OWNER_SECINFO | GROUP_SECINFO | DACL_SECINFO,
+						&pntsd_size, &fattr);
+					posix_acl_release(fattr.cf_acls);
+					posix_acl_release(fattr.cf_dacls);
+
+					rc = ksmbd_vfs_set_sd_xattr(conn,
+						path.dentry, pntsd, pntsd_size);
+					if (rc)
+						ksmbd_err("failed to store ntacl in xattr : %d\n",
+								rc);
+				}
+			}
+		}
+		rc = 0;
+	}
+
+	if (stream_name) {
+		rc = smb2_set_stream_name_xattr(&path,
+						fp,
+						stream_name,
+						s_type);
+		if (rc)
+			goto err_out;
+		file_info = FILE_CREATED;
+	}
+
+	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
+			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
+	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC
+		&& !fp->attrib_only && !stream_name) {
+		smb_break_all_oplock(work, fp);
+		need_truncate = 1;
+	}
+
+	/* fp should be searchable through ksmbd_inode.m_fp_list
+	 * after daccess, saccess, attrib_only, and stream are
+	 * initialized.
+	 */
+	write_lock(&fp->f_ci->m_lock);
+	list_add(&fp->node, &fp->f_ci->m_fp_list);
+	write_unlock(&fp->f_ci->m_lock);
+
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc) {
+		generic_fillattr(&init_user_ns, d_inode(path.dentry), &stat);
+		rc = 0;
+	}
+
+	/* Check delete pending among previous fp before oplock break */
+	if (ksmbd_inode_pending_delete(fp)) {
+		rc = -EBUSY;
+		goto err_out;
+	}
+
+	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
+	if (!test_share_config_flag(work->tcon->share_conf,
+			KSMBD_SHARE_FLAG_OPLOCKS) ||
+		(req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
+		!(conn->vals->capabilities & SMB2_GLOBAL_CAP_LEASING))) {
+		if (share_ret < 0 && !S_ISDIR(FP_INODE(fp)->i_mode)) {
+			rc = share_ret;
+			goto err_out;
+		}
+	} else {
+		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			req_op_level = smb2_map_lease_to_oplock(lc->req_state);
+			ksmbd_debug(SMB,
+				"lease req for(%s) req oplock state 0x%x, lease state 0x%x\n",
+					name, req_op_level, lc->req_state);
+			rc = find_same_lease_key(sess, fp->f_ci, lc);
+			if (rc)
+				goto err_out;
+		} else if (open_flags == O_RDONLY &&
+			    (req_op_level == SMB2_OPLOCK_LEVEL_BATCH ||
+			     req_op_level == SMB2_OPLOCK_LEVEL_EXCLUSIVE))
+			req_op_level = SMB2_OPLOCK_LEVEL_II;
+
+		rc = smb_grant_oplock(work, req_op_level,
+				      fp->persistent_id, fp,
+				      le32_to_cpu(req->hdr.Id.SyncId.TreeId),
+				      lc, share_ret);
+		if (rc < 0)
+			goto err_out;
+	}
+
+	if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)
+		ksmbd_fd_set_delete_on_close(fp, file_info);
+
+	if (need_truncate) {
+		rc = smb2_create_truncate(&path);
+		if (rc)
+			goto err_out;
+	}
+
+	if (req->CreateContextsOffset) {
+		struct create_alloc_size_req *az_req;
+
+		az_req = (struct create_alloc_size_req *)
+				smb2_find_context_vals(req,
+				SMB2_CREATE_ALLOCATION_SIZE);
+		if (IS_ERR(az_req)) {
+			rc = check_context_err(az_req,
+				SMB2_CREATE_ALLOCATION_SIZE);
+			if (rc < 0)
+				goto err_out;
+		} else {
+			loff_t alloc_size = le64_to_cpu(az_req->AllocationSize);
+			int err;
+
+			ksmbd_debug(SMB,
+				"request smb2 create allocate size : %llu\n",
+				alloc_size);
+			err = ksmbd_vfs_alloc_size(work, fp, alloc_size);
+			if (err < 0)
+				ksmbd_debug(SMB,
+					"ksmbd_vfs_alloc_size is failed : %d\n",
+					err);
+		}
+
+		context = smb2_find_context_vals(req,
+				SMB2_CREATE_QUERY_ON_DISK_ID);
+		if (IS_ERR(context)) {
+			rc = check_context_err(context,
+				SMB2_CREATE_QUERY_ON_DISK_ID);
+			if (rc < 0)
+				goto err_out;
+		} else {
+			ksmbd_debug(SMB, "get query on disk id context\n");
+			query_disk_id = 1;
+		}
+	}
+
+	if (stat.result_mask & STATX_BTIME)
+		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
+	else
+		fp->create_time = ksmbd_UnixTimeToNT(stat.ctime);
+	if (req->FileAttributes || fp->f_ci->m_fattr == 0)
+		fp->f_ci->m_fattr = cpu_to_le32(smb2_get_dos_mode(&stat,
+			le32_to_cpu(req->FileAttributes)));
+
+	if (!created)
+		smb2_update_xattrs(tcon, &path, fp);
+	else
+		smb2_new_xattrs(tcon, &path, fp);
+
+	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
+
+	if (d_info.type) {
+		if (d_info.type == DURABLE_REQ_V2 &&
+			d_info.persistent)
+			fp->is_persistent = 1;
+		else
+			fp->is_durable = 1;
+
+		if (d_info.type == DURABLE_REQ_V2) {
+			memcpy(fp->create_guid, d_info.CreateGuid,
+				SMB2_CREATE_GUID_SIZE);
+			if (d_info.timeout)
+				fp->durable_timeout = d_info.timeout;
+			else
+				fp->durable_timeout = 1600;
+			if (d_info.app_id)
+				memcpy(fp->app_instance_id,
+					d_info.app_id, 16);
+		}
+	}
+
+reconnected:
+	generic_fillattr(&init_user_ns, FP_INODE(fp), &stat);
+
+	rsp->StructureSize = cpu_to_le16(89);
+	rcu_read_lock();
+	opinfo = rcu_dereference(fp->f_opinfo);
+	rsp->OplockLevel = opinfo != NULL ? opinfo->level : 0;
+	rcu_read_unlock();
+	rsp->Reserved = 0;
+	rsp->CreateAction = cpu_to_le32(file_info);
+	rsp->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	rsp->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	rsp->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	rsp->ChangeTime = cpu_to_le64(time);
+	rsp->AllocationSize = S_ISDIR(stat.mode) ? 0 :
+		cpu_to_le64(stat.blocks << 9);
+	rsp->EndofFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	rsp->FileAttributes = fp->f_ci->m_fattr;
+
+	rsp->Reserved2 = 0;
+
+	rsp->PersistentFileId = cpu_to_le64(fp->persistent_id);
+	rsp->VolatileFileId = cpu_to_le64(fp->volatile_id);
+
+	rsp->CreateContextsOffset = 0;
+	rsp->CreateContextsLength = 0;
+	inc_rfc1001_len(rsp_org, 88); /* StructureSize - 1*/
+
+	/* If lease is request send lease context response */
+	if (opinfo && opinfo->is_lease) {
+		struct create_context *lease_ccontext;
+
+		ksmbd_debug(SMB, "lease granted on(%s) lease state 0x%x\n",
+				name, opinfo->o_lease->state);
+		rsp->OplockLevel = SMB2_OPLOCK_LEVEL_LEASE;
+
+		lease_ccontext = (struct create_context *)rsp->Buffer;
+		contxt_cnt++;
+		create_lease_buf(rsp->Buffer, opinfo->o_lease);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_lease_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_lease_size);
+		next_ptr = &lease_ccontext->Next;
+		next_off = conn->vals->create_lease_size;
+	}
+
+	if (d_info.type == DURABLE_REQ || d_info.type == DURABLE_REQ_V2) {
+		struct create_context *durable_ccontext;
+
+		durable_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		if (d_info.type == DURABLE_REQ) {
+			create_durable_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+			le32_add_cpu(&rsp->CreateContextsLength,
+				     conn->vals->create_durable_size);
+			inc_rfc1001_len(rsp_org,
+				conn->vals->create_durable_size);
+		} else {
+			create_durable_v2_rsp_buf(rsp->Buffer +
+					le32_to_cpu(rsp->CreateContextsLength),
+					fp);
+			le32_add_cpu(&rsp->CreateContextsLength,
+				     conn->vals->create_durable_v2_size);
+			inc_rfc1001_len(rsp_org,
+				conn->vals->create_durable_v2_size);
+		}
+
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &durable_ccontext->Next;
+		next_off = conn->vals->create_durable_size;
+	}
+
+	if (maximal_access_ctxt) {
+		struct create_context *mxac_ccontext;
+
+		if (maximal_access == 0)
+			ksmbd_vfs_query_maximal_access(path.dentry,
+						       &maximal_access);
+		mxac_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		create_mxac_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				le32_to_cpu(maximal_access));
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_mxac_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_mxac_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &mxac_ccontext->Next;
+		next_off = conn->vals->create_mxac_size;
+	}
+
+	if (query_disk_id) {
+		struct create_context *disk_id_ccontext;
+
+		disk_id_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		create_disk_id_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				stat.ino, tcon->id);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_disk_id_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_disk_id_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &disk_id_ccontext->Next;
+		next_off = conn->vals->create_disk_id_size;
+	}
+
+	if (posix_ctxt) {
+		contxt_cnt++;
+		create_posix_rsp_buf(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength),
+				fp);
+		le32_add_cpu(&rsp->CreateContextsLength,
+			     conn->vals->create_posix_size);
+		inc_rfc1001_len(rsp_org, conn->vals->create_posix_size);
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+	}
+
+	if (contxt_cnt > 0) {
+		rsp->CreateContextsOffset =
+			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer)
+			- 4);
+	}
+
+err_out:
+	if (file_present || created)
+		path_put(&path);
+	ksmbd_revert_fsids(work);
+err_out1:
+	if (rc) {
+		if (rc == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else if (rc == -EOPNOTSUPP)
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		else if (rc == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (rc == -ENOENT)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_INVALID;
+		else if (rc == -EPERM)
+			rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+		else if (rc == -EBUSY)
+			rsp->hdr.Status = STATUS_DELETE_PENDING;
+		else if (rc == -EBADF)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+		else if (rc == -ENOEXEC)
+			rsp->hdr.Status = STATUS_DUPLICATE_OBJECTID;
+		else if (rc == -ENXIO)
+			rsp->hdr.Status = STATUS_NO_SUCH_DEVICE;
+		else if (rc == -EEXIST)
+			rsp->hdr.Status = STATUS_OBJECT_NAME_COLLISION;
+		else if (rc == -EMFILE)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		if (!rsp->hdr.Status)
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+
+		if (!fp || !fp->filename)
+			kfree(name);
+		if (fp)
+			ksmbd_fd_put(work, fp);
+		smb2_set_err_rsp(work);
+		ksmbd_debug(SMB, "Error response: %x\n", rsp->hdr.Status);
+	}
+
+	kfree(lc);
+
+	return 0;
+}
+
+static int readdir_info_level_struct_sz(int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+		return sizeof(struct file_full_directory_info);
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+		return sizeof(struct file_both_directory_info);
+	case FILE_DIRECTORY_INFORMATION:
+		return sizeof(struct file_directory_info);
+	case FILE_NAMES_INFORMATION:
+		return sizeof(struct file_names_info);
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+		return sizeof(struct file_id_full_dir_info);
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+		return sizeof(struct file_id_both_directory_info);
+	case SMB_FIND_FILE_POSIX_INFO:
+		return sizeof(struct smb2_posix_info);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(ffdinfo->NextEntryOffset);
+		d_info->name = ffdinfo->FileName;
+		d_info->name_len = le32_to_cpu(ffdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fbdinfo->NextEntryOffset);
+		d_info->name = fbdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fbdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fdinfo->NextEntryOffset);
+		d_info->name = fdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fdinfo->FileNameLength);
+		return 0;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fninfo->NextEntryOffset);
+		d_info->name = fninfo->FileName;
+		d_info->name_len = le32_to_cpu(fninfo->FileNameLength);
+		return 0;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(dinfo->NextEntryOffset);
+		d_info->name = dinfo->FileName;
+		d_info->name_len = le32_to_cpu(dinfo->FileNameLength);
+		return 0;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(fibdinfo->NextEntryOffset);
+		d_info->name = fibdinfo->FileName;
+		d_info->name_len = le32_to_cpu(fibdinfo->FileNameLength);
+		return 0;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+
+		posix_info = (struct smb2_posix_info *)d_info->rptr;
+		d_info->rptr += le32_to_cpu(posix_info->NextEntryOffset);
+		d_info->name = posix_info->name;
+		d_info->name_len = le32_to_cpu(posix_info->name_len);
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * smb2_populate_readdir_entry() - encode directory entry in smb2 response
+ * buffer
+ * @conn:	connection instance
+ * @info_level:	smb information level
+ * @d_info:	structure included variables for query dir
+ * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
+ *
+ * if directory has many entries, find first can't read it fully.
+ * find next might be called multiple times to read remaining dir entries
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_populate_readdir_entry(struct ksmbd_conn *conn,
+				       int info_level,
+				       struct ksmbd_dir_info *d_info,
+				       struct ksmbd_kstat *ksmbd_kstat)
+{
+	int next_entry_offset = 0;
+	char *conv_name;
+	int conv_len;
+	void *kstat;
+	int struct_sz;
+
+	conv_name = ksmbd_convert_dir_info_name(d_info,
+						conn->local_nls,
+						&conv_len);
+	if (!conv_name)
+		return -ENOMEM;
+
+	/* Somehow the name has only terminating NULL bytes */
+	if (conv_len < 0) {
+		kfree(conv_name);
+		return -EINVAL;
+	}
+
+	struct_sz = readdir_info_level_struct_sz(info_level);
+	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+				  KSMBD_DIR_INFO_ALIGNMENT);
+
+	if (next_entry_offset > d_info->out_buf_len) {
+		d_info->out_buf_len = 0;
+		return -ENOSPC;
+	}
+
+	kstat = d_info->wptr;
+	if (info_level != FILE_NAMES_INFORMATION)
+		kstat = ksmbd_vfs_init_kstat(&d_info->wptr, ksmbd_kstat);
+
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)kstat;
+		ffdinfo->FileNameLength = cpu_to_le32(conv_len);
+		ffdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (ffdinfo->EaSize)
+			ffdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			ffdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(ffdinfo->FileName, conv_name, conv_len);
+		ffdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)kstat;
+		fbdinfo->FileNameLength = cpu_to_le32(conv_len);
+		fbdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (fbdinfo->EaSize)
+			fbdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		fbdinfo->ShortNameLength = 0;
+		fbdinfo->Reserved = 0;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fbdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fbdinfo->FileName, conv_name, conv_len);
+		fbdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)kstat;
+		fdinfo->FileNameLength = cpu_to_le32(conv_len);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fdinfo->FileName, conv_name, conv_len);
+		fdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)kstat;
+		fninfo->FileNameLength = cpu_to_le32(conv_len);
+		memcpy(fninfo->FileName, conv_name, conv_len);
+		fninfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)kstat;
+		dinfo->FileNameLength = cpu_to_le32(conv_len);
+		dinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (dinfo->EaSize)
+			dinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		dinfo->Reserved = 0;
+		dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			dinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(dinfo->FileName, conv_name, conv_len);
+		dinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)kstat;
+		fibdinfo->FileNameLength = cpu_to_le32(conv_len);
+		fibdinfo->EaSize =
+			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
+		if (fibdinfo->EaSize)
+			fibdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+		fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		fibdinfo->ShortNameLength = 0;
+		fibdinfo->Reserved = 0;
+		fibdinfo->Reserved2 = cpu_to_le16(0);
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			fibdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+		memcpy(fibdinfo->FileName, conv_name, conv_len);
+		fibdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+		u64 time;
+
+		posix_info = (struct smb2_posix_info *)kstat;
+		posix_info->Ignored = 0;
+		posix_info->CreationTime = cpu_to_le64(ksmbd_kstat->create_time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->ctime);
+		posix_info->ChangeTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->atime);
+		posix_info->LastAccessTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(ksmbd_kstat->kstat->mtime);
+		posix_info->LastWriteTime = cpu_to_le64(time);
+		posix_info->EndOfFile = cpu_to_le64(ksmbd_kstat->kstat->size);
+		posix_info->AllocationSize = cpu_to_le64(ksmbd_kstat->kstat->blocks << 9);
+		posix_info->DeviceId = cpu_to_le32(ksmbd_kstat->kstat->rdev);
+		posix_info->HardLinks = cpu_to_le32(ksmbd_kstat->kstat->nlink);
+		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode);
+		posix_info->Inode = cpu_to_le64(ksmbd_kstat->kstat->ino);
+		posix_info->DosAttributes =
+			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
+		if (d_info->hide_dot_file && d_info->name[0] == '.')
+			posix_info->DosAttributes |= ATTR_HIDDEN_LE;
+		id_to_sid(from_kuid(&init_user_ns, ksmbd_kstat->kstat->uid),
+				SIDNFS_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
+		id_to_sid(from_kgid(&init_user_ns, ksmbd_kstat->kstat->gid),
+				SIDNFS_GROUP, (struct smb_sid *)&posix_info->SidBuffer[20]);
+		memcpy(posix_info->name, conv_name, conv_len);
+		posix_info->name_len = cpu_to_le32(conv_len);
+		posix_info->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+
+	} /* switch (info_level) */
+
+	d_info->last_entry_offset = d_info->data_count;
+	d_info->data_count += next_entry_offset;
+	d_info->wptr += next_entry_offset;
+	kfree(conv_name);
+
+	ksmbd_debug(SMB,
+		"info_level : %d, buf_len :%d, next_offset : %d, data_count : %d\n",
+		info_level, d_info->out_buf_len,
+		next_entry_offset, d_info->data_count);
+
+	return 0;
+}
+
+struct smb2_query_dir_private {
+	struct ksmbd_work	*work;
+	char			*search_pattern;
+	struct ksmbd_file	*dir_fp;
+
+	struct ksmbd_dir_info	*d_info;
+	int			info_level;
+};
+
+static void lock_dir(struct ksmbd_file *dir_fp)
+{
+	struct dentry *dir = dir_fp->filp->f_path.dentry;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+}
+
+static void unlock_dir(struct ksmbd_file *dir_fp)
+{
+	struct dentry *dir = dir_fp->filp->f_path.dentry;
+
+	inode_unlock(d_inode(dir));
+}
+
+static int process_query_dir_entries(struct smb2_query_dir_private *priv)
+{
+	struct kstat		kstat;
+	struct ksmbd_kstat	ksmbd_kstat;
+	int			rc;
+	int			i;
+
+	for (i = 0; i < priv->d_info->num_entry; i++) {
+		struct dentry *dent;
+
+		if (dentry_name(priv->d_info, priv->info_level))
+			return -EINVAL;
+
+		lock_dir(priv->dir_fp);
+		dent = lookup_one_len(priv->d_info->name,
+				      priv->dir_fp->filp->f_path.dentry,
+				      priv->d_info->name_len);
+		unlock_dir(priv->dir_fp);
+
+		if (IS_ERR(dent)) {
+			ksmbd_debug(SMB, "Cannot lookup `%s' [%ld]\n",
+				     priv->d_info->name,
+				     PTR_ERR(dent));
+			continue;
+		}
+		if (unlikely(d_is_negative(dent))) {
+			dput(dent);
+			ksmbd_debug(SMB, "Negative dentry `%s'\n",
+				    priv->d_info->name);
+			continue;
+		}
+
+		ksmbd_kstat.kstat = &kstat;
+		if (priv->info_level != FILE_NAMES_INFORMATION)
+			ksmbd_vfs_fill_dentry_attrs(priv->work,
+						    dent,
+						    &ksmbd_kstat);
+
+		rc = smb2_populate_readdir_entry(priv->work->conn,
+						 priv->info_level,
+						 priv->d_info,
+						 &ksmbd_kstat);
+		dput(dent);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static int reserve_populate_dentry(struct ksmbd_dir_info *d_info,
+				   int info_level)
+{
+	int struct_sz;
+	int conv_len;
+	int next_entry_offset;
+
+	struct_sz = readdir_info_level_struct_sz(info_level);
+	if (struct_sz == -EOPNOTSUPP)
+		return -EOPNOTSUPP;
+
+	conv_len = (d_info->name_len + 1) * 2;
+	next_entry_offset = ALIGN(struct_sz - 1 + conv_len,
+				  KSMBD_DIR_INFO_ALIGNMENT);
+
+	if (next_entry_offset > d_info->out_buf_len) {
+		d_info->out_buf_len = 0;
+		return -ENOSPC;
+	}
+
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_full_directory_info *ffdinfo;
+
+		ffdinfo = (struct file_full_directory_info *)d_info->wptr;
+		memcpy(ffdinfo->FileName, d_info->name, d_info->name_len);
+		ffdinfo->FileName[d_info->name_len] = 0x00;
+		ffdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		ffdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_both_directory_info *fbdinfo;
+
+		fbdinfo = (struct file_both_directory_info *)d_info->wptr;
+		memcpy(fbdinfo->FileName, d_info->name, d_info->name_len);
+		fbdinfo->FileName[d_info->name_len] = 0x00;
+		fbdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fbdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_DIRECTORY_INFORMATION:
+	{
+		struct file_directory_info *fdinfo;
+
+		fdinfo = (struct file_directory_info *)d_info->wptr;
+		memcpy(fdinfo->FileName, d_info->name, d_info->name_len);
+		fdinfo->FileName[d_info->name_len] = 0x00;
+		fdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILE_NAMES_INFORMATION:
+	{
+		struct file_names_info *fninfo;
+
+		fninfo = (struct file_names_info *)d_info->wptr;
+		memcpy(fninfo->FileName, d_info->name, d_info->name_len);
+		fninfo->FileName[d_info->name_len] = 0x00;
+		fninfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fninfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	{
+		struct file_id_full_dir_info *dinfo;
+
+		dinfo = (struct file_id_full_dir_info *)d_info->wptr;
+		memcpy(dinfo->FileName, d_info->name, d_info->name_len);
+		dinfo->FileName[d_info->name_len] = 0x00;
+		dinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		dinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	{
+		struct file_id_both_directory_info *fibdinfo;
+
+		fibdinfo = (struct file_id_both_directory_info *)d_info->wptr;
+		memcpy(fibdinfo->FileName, d_info->name, d_info->name_len);
+		fibdinfo->FileName[d_info->name_len] = 0x00;
+		fibdinfo->FileNameLength = cpu_to_le32(d_info->name_len);
+		fibdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
+		break;
+	}
+	case SMB_FIND_FILE_POSIX_INFO:
+	{
+		struct smb2_posix_info *posix_info;
+
+		posix_info = (struct smb2_posix_info *)d_info->wptr;
+		memcpy(posix_info->name, d_info->name, d_info->name_len);
+		posix_info->name[d_info->name_len] = 0x00;
+		posix_info->name_len = cpu_to_le32(d_info->name_len);
+		posix_info->NextEntryOffset =
+			cpu_to_le32(next_entry_offset);
+		break;
+	}
+	} /* switch (info_level) */
+
+	d_info->num_entry++;
+	d_info->out_buf_len -= next_entry_offset;
+	d_info->wptr += next_entry_offset;
+	return 0;
+}
+
+static int __query_dir(struct dir_context *ctx,
+		       const char *name,
+		       int namlen,
+		       loff_t offset,
+		       u64 ino,
+		       unsigned int d_type)
+{
+	struct ksmbd_readdir_data	*buf;
+	struct smb2_query_dir_private	*priv;
+	struct ksmbd_dir_info		*d_info;
+	int				rc;
+
+	buf	= container_of(ctx, struct ksmbd_readdir_data, ctx);
+	priv	= buf->private;
+	d_info	= priv->d_info;
+
+	/* dot and dotdot entries are already reserved */
+	if (!strcmp(".", name) || !strcmp("..", name))
+		return 0;
+	if (ksmbd_share_veto_filename(priv->work->tcon->share_conf, name))
+		return 0;
+	if (!match_pattern(name, namlen, priv->search_pattern))
+		return 0;
+
+	d_info->name		= name;
+	d_info->name_len	= namlen;
+	rc = reserve_populate_dentry(d_info, priv->info_level);
+	if (rc)
+		return rc;
+	if (d_info->flags & SMB2_RETURN_SINGLE_ENTRY) {
+		d_info->out_buf_len = 0;
+		return 0;
+	}
+	return 0;
+}
+
+static void restart_ctx(struct dir_context *ctx)
+{
+	ctx->pos = 0;
+}
+
+static int verify_info_level(int info_level)
+{
+	switch (info_level) {
+	case FILE_FULL_DIRECTORY_INFORMATION:
+	case FILE_BOTH_DIRECTORY_INFORMATION:
+	case FILE_DIRECTORY_INFORMATION:
+	case FILE_NAMES_INFORMATION:
+	case FILEID_FULL_DIRECTORY_INFORMATION:
+	case FILEID_BOTH_DIRECTORY_INFORMATION:
+	case SMB_FIND_FILE_POSIX_INFO:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+int smb2_query_dir(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_query_directory_req *req;
+	struct smb2_query_directory_rsp *rsp, *rsp_org;
+	struct ksmbd_share_config *share = work->tcon->share_conf;
+	struct ksmbd_file *dir_fp = NULL;
+	struct ksmbd_dir_info d_info;
+	int rc = 0;
+	char *srch_ptr = NULL;
+	unsigned char srch_flag;
+	int buffer_sz;
+	struct smb2_query_dir_private query_dir_private = {NULL, };
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	if (ksmbd_override_fsids(work)) {
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+		smb2_set_err_rsp(work);
+		return -ENOMEM;
+	}
+
+	rc = verify_info_level(req->FileInformationClass);
+	if (rc) {
+		rc = -EFAULT;
+		goto err_out2;
+	}
+
+	dir_fp = ksmbd_lookup_fd_slow(work,
+			le64_to_cpu(req->VolatileFileId),
+			le64_to_cpu(req->PersistentFileId));
+	if (!dir_fp) {
+		rc = -EBADF;
+		goto err_out2;
+	}
+
+	if (!(dir_fp->daccess & FILE_LIST_DIRECTORY_LE) ||
+			inode_permission(&init_user_ns, file_inode(dir_fp->filp),
+			MAY_READ | MAY_EXEC)) {
+		ksmbd_err("no right to enumerate directory (%s)\n",
+			FP_FILENAME(dir_fp));
+		rc = -EACCES;
+		goto err_out2;
+	}
+
+	if (!S_ISDIR(file_inode(dir_fp->filp)->i_mode)) {
+		ksmbd_err("can't do query dir for a file\n");
+		rc = -EINVAL;
+		goto err_out2;
+	}
+
+	srch_flag = req->Flags;
+	srch_ptr = smb_strndup_from_utf16(req->Buffer,
+			le16_to_cpu(req->FileNameLength), 1,
+			conn->local_nls);
+	if (IS_ERR(srch_ptr)) {
+		ksmbd_debug(SMB, "Search Pattern not found\n");
+		rc = -EINVAL;
+		goto err_out2;
+	} else
+		ksmbd_debug(SMB, "Search pattern is %s\n", srch_ptr);
+
+	ksmbd_debug(SMB, "Directory name is %s\n", dir_fp->filename);
+
+	if (srch_flag & SMB2_REOPEN || srch_flag & SMB2_RESTART_SCANS) {
+		ksmbd_debug(SMB, "Restart directory scan\n");
+		generic_file_llseek(dir_fp->filp, 0, SEEK_SET);
+		restart_ctx(&dir_fp->readdir_data.ctx);
+	}
+
+	memset(&d_info, 0, sizeof(struct ksmbd_dir_info));
+	d_info.wptr = (char *)rsp->Buffer;
+	d_info.rptr = (char *)rsp->Buffer;
+	d_info.out_buf_len = (work->response_sz -
+				(get_rfc1002_len(rsp_org) + 4));
+	d_info.out_buf_len = min_t(int, d_info.out_buf_len,
+				le32_to_cpu(req->OutputBufferLength)) -
+				sizeof(struct smb2_query_directory_rsp);
+	d_info.flags = srch_flag;
+
+	/*
+	 * reserve dot and dotdot entries in head of buffer
+	 * in first response
+	 */
+	rc = ksmbd_populate_dot_dotdot_entries(work, req->FileInformationClass,
+		dir_fp,	&d_info, srch_ptr, smb2_populate_readdir_entry);
+	if (rc == -ENOSPC)
+		rc = 0;
+	else if (rc)
+		goto err_out;
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_HIDE_DOT_FILES))
+		d_info.hide_dot_file = true;
+
+	buffer_sz				= d_info.out_buf_len;
+	d_info.rptr				= d_info.wptr;
+	query_dir_private.work			= work;
+	query_dir_private.search_pattern	= srch_ptr;
+	query_dir_private.dir_fp		= dir_fp;
+	query_dir_private.d_info		= &d_info;
+	query_dir_private.info_level		= req->FileInformationClass;
+	dir_fp->readdir_data.private		= &query_dir_private;
+	set_ctx_actor(&dir_fp->readdir_data.ctx, __query_dir);
+
+	rc = ksmbd_vfs_readdir(dir_fp->filp, &dir_fp->readdir_data);
+	if (rc == 0)
+		restart_ctx(&dir_fp->readdir_data.ctx);
+	if (rc == -ENOSPC)
+		rc = 0;
+	if (rc)
+		goto err_out;
+
+	d_info.wptr = d_info.rptr;
+	d_info.out_buf_len = buffer_sz;
+	rc = process_query_dir_entries(&query_dir_private);
+	if (rc)
+		goto err_out;
+
+	if (!d_info.data_count && d_info.out_buf_len >= 0) {
+		if (srch_flag & SMB2_RETURN_SINGLE_ENTRY && !is_asterisk(srch_ptr))
+			rsp->hdr.Status = STATUS_NO_SUCH_FILE;
+		else {
+			dir_fp->dot_dotdot[0] = dir_fp->dot_dotdot[1] = 0;
+			rsp->hdr.Status = STATUS_NO_MORE_FILES;
+		}
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(0);
+		rsp->OutputBufferLength = cpu_to_le32(0);
+		rsp->Buffer[0] = 0;
+		inc_rfc1001_len(rsp_org, 9);
+	} else {
+		((struct file_directory_info *)
+		((char *)rsp->Buffer + d_info.last_entry_offset))
+		->NextEntryOffset = 0;
+
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(72);
+		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
+		inc_rfc1001_len(rsp_org, 8 + d_info.data_count);
+	}
+
+	kfree(srch_ptr);
+	ksmbd_fd_put(work, dir_fp);
+	ksmbd_revert_fsids(work);
+	return 0;
+
+err_out:
+	ksmbd_err("error while processing smb2 query dir rc = %d\n", rc);
+	kfree(srch_ptr);
+
+err_out2:
+	if (rc == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else if (rc == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (rc == -ENOENT)
+		rsp->hdr.Status = STATUS_NO_SUCH_FILE;
+	else if (rc == -EBADF)
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+	else if (rc == -ENOMEM)
+		rsp->hdr.Status = STATUS_NO_MEMORY;
+	else if (rc == -EFAULT)
+		rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+	if (!rsp->hdr.Status)
+		rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, dir_fp);
+	ksmbd_revert_fsids(work);
+	return 0;
+}
+
+/**
+ * buffer_check_err() - helper function to check buffer errors
+ * @reqOutputBufferLength:	max buffer length expected in command response
+ * @rsp:		query info response buffer contains output buffer length
+ * @infoclass_size:	query info class response buffer size
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int buffer_check_err(int reqOutputBufferLength,
+	struct smb2_query_info_rsp *rsp, int infoclass_size)
+{
+	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
+		if (reqOutputBufferLength < infoclass_size) {
+			ksmbd_err("Invalid Buffer Size Requested\n");
+			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
+			rsp->hdr.smb2_buf_length = cpu_to_be32(
+						sizeof(struct smb2_hdr) - 4);
+			return -EINVAL;
+		}
+
+		ksmbd_debug(SMB, "Buffer Overflow\n");
+		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+		rsp->hdr.smb2_buf_length = cpu_to_be32(
+					sizeof(struct smb2_hdr) - 4
+					+ reqOutputBufferLength);
+		rsp->OutputBufferLength = cpu_to_le32(
+						reqOutputBufferLength);
+	}
+	return 0;
+}
+
+static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
+{
+	struct smb2_file_standard_info *sinfo;
+
+	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
+
+	sinfo->AllocationSize = cpu_to_le64(4096);
+	sinfo->EndOfFile = cpu_to_le64(0);
+	sinfo->NumberOfLinks = cpu_to_le32(1);
+	sinfo->DeletePending = 1;
+	sinfo->Directory = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_file_standard_info));
+}
+
+static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp,
+	uint64_t num)
+{
+	struct smb2_file_internal_info *file_info;
+
+	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
+
+	/* any unique number */
+	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp, sizeof(struct smb2_file_internal_info));
+}
+
+static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
+	struct smb2_query_info_req *req, struct smb2_query_info_rsp *rsp)
+{
+	uint64_t id;
+	int rc;
+
+	/*
+	 * Windows can sometime send query file info request on
+	 * pipe without opening it, checking error condition here
+	 */
+	id = le64_to_cpu(req->VolatileFileId);
+	if (!ksmbd_session_rpc_method(sess, id))
+		return -ENOENT;
+
+	ksmbd_debug(SMB, "FileInfoClass %u, FileId 0x%llx\n",
+		     req->FileInfoClass, le64_to_cpu(req->VolatileFileId));
+
+	switch (req->FileInfoClass) {
+	case FILE_STANDARD_INFORMATION:
+		get_standard_info_pipe(rsp);
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+			rsp, FILE_STANDARD_INFORMATION_SIZE);
+		break;
+	case FILE_INTERNAL_INFORMATION:
+		get_internal_info_pipe(rsp, id);
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+			rsp, FILE_INTERNAL_INFORMATION_SIZE);
+		break;
+	default:
+		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
+			req->FileInfoClass);
+		rc = -EOPNOTSUPP;
+	}
+	return rc;
+}
+
+/**
+ * smb2_get_ea() - handler for smb2 get extended attribute command
+ * @work:	smb work containing query info command buffer
+ * @fp:		ksmbd_file pointer
+ * @req:	get extended attribute request
+ * @rsp:	response buffer pointer
+ * @rsp_org:	base response buffer pointer in case of chained response
+ *
+ * Return:	0 on success, otherwise error
+ */
+static int smb2_get_ea(struct ksmbd_work *work,
+		       struct ksmbd_file *fp,
+		       struct smb2_query_info_req *req,
+		       struct smb2_query_info_rsp *rsp,
+		       void *rsp_org)
+{
+	struct smb2_ea_info *eainfo, *prev_eainfo;
+	char *name, *ptr, *xattr_list = NULL, *buf;
+	int rc, name_len, value_len, xattr_list_len, idx;
+	ssize_t buf_free_len, alignment_bytes, next_offset, rsp_data_cnt = 0;
+	struct smb2_ea_info_req *ea_req = NULL;
+	struct path *path;
+
+	if (!(fp->daccess & FILE_READ_EA_LE)) {
+		ksmbd_err("Not permitted to read ext attr : 0x%x\n",
+			  fp->daccess);
+		return -EACCES;
+	}
+
+	path = &fp->filp->f_path;
+	/* single EA entry is requested with given user.* name */
+	if (req->InputBufferLength)
+		ea_req = (struct smb2_ea_info_req *)req->Buffer;
+	else {
+		/* need to send all EAs, if no specific EA is requested*/
+		if (le32_to_cpu(req->Flags) & SL_RETURN_SINGLE_ENTRY)
+			ksmbd_debug(SMB,
+				"All EAs are requested but need to send single EA entry in rsp flags 0x%x\n",
+				le32_to_cpu(req->Flags));
+	}
+
+	buf_free_len = work->response_sz -
+			(get_rfc1002_len(rsp_org) + 4) -
+			sizeof(struct smb2_query_info_rsp);
+
+	if (le32_to_cpu(req->OutputBufferLength) < buf_free_len)
+		buf_free_len = le32_to_cpu(req->OutputBufferLength);
+
+	rc = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
+	if (rc < 0) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		goto out;
+	} else if (!rc) { /* there is no EA in the file */
+		ksmbd_debug(SMB, "no ea data in the file\n");
+		goto done;
+	}
+	xattr_list_len = rc;
+
+	ptr = (char *)rsp->Buffer;
+	eainfo = (struct smb2_ea_info *)ptr;
+	prev_eainfo = eainfo;
+	idx = 0;
+
+	while (idx < xattr_list_len) {
+		name = xattr_list + idx;
+		name_len = strlen(name);
+
+		ksmbd_debug(SMB, "%s, len %d\n", name, name_len);
+		idx += name_len + 1;
+
+		/*
+		 * CIFS does not support EA other than user.* namespace,
+		 * still keep the framework generic, to list other attrs
+		 * in future.
+		 */
+		if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			continue;
+
+		if (!strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
+					STREAM_PREFIX_LEN))
+			continue;
+
+		if (req->InputBufferLength &&
+				(strncmp(&name[XATTR_USER_PREFIX_LEN],
+					 ea_req->name, ea_req->EaNameLength)))
+			continue;
+
+		if (!strncmp(&name[XATTR_USER_PREFIX_LEN],
+			DOS_ATTRIBUTE_PREFIX, DOS_ATTRIBUTE_PREFIX_LEN))
+			continue;
+
+		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
+			name_len -= XATTR_USER_PREFIX_LEN;
+
+		ptr = (char *)(&eainfo->name + name_len + 1);
+		buf_free_len -= (offsetof(struct smb2_ea_info, name) +
+				name_len + 1);
+		/* bailout if xattr can't fit in buf_free_len */
+		value_len = ksmbd_vfs_getxattr(path->dentry, name, &buf);
+		if (value_len <= 0) {
+			rc = -ENOENT;
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+			goto out;
+		}
+
+		buf_free_len -= value_len;
+		if (buf_free_len < 0) {
+			ksmbd_free(buf);
+			break;
+		}
+
+		memcpy(ptr, buf, value_len);
+		ksmbd_free(buf);
+
+		ptr += value_len;
+		eainfo->Flags = 0;
+		eainfo->EaNameLength = name_len;
+
+		if (!strncmp(name, XATTR_USER_PREFIX,
+			XATTR_USER_PREFIX_LEN))
+			memcpy(eainfo->name, &name[XATTR_USER_PREFIX_LEN],
+					name_len);
+		else
+			memcpy(eainfo->name, name, name_len);
+
+		eainfo->name[name_len] = '\0';
+		eainfo->EaValueLength = cpu_to_le16(value_len);
+		next_offset = offsetof(struct smb2_ea_info, name) +
+			name_len + 1 + value_len;
+
+		/* align next xattr entry at 4 byte bundary */
+		alignment_bytes = ((next_offset + 3) & ~3) - next_offset;
+		if (alignment_bytes) {
+			memset(ptr, '\0', alignment_bytes);
+			ptr += alignment_bytes;
+			next_offset += alignment_bytes;
+			buf_free_len -= alignment_bytes;
+		}
+		eainfo->NextEntryOffset = cpu_to_le32(next_offset);
+		prev_eainfo = eainfo;
+		eainfo = (struct smb2_ea_info *)ptr;
+		rsp_data_cnt += next_offset;
+
+		if (req->InputBufferLength) {
+			ksmbd_debug(SMB, "single entry requested\n");
+			break;
+		}
+	}
+
+	/* no more ea entries */
+	prev_eainfo->NextEntryOffset = 0;
+done:
+	rc = 0;
+	if (rsp_data_cnt == 0)
+		rsp->hdr.Status = STATUS_NO_EAS_ON_FILE;
+	rsp->OutputBufferLength = cpu_to_le32(rsp_data_cnt);
+	inc_rfc1001_len(rsp_org, rsp_data_cnt);
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+	return rc;
+}
+
+static void get_file_access_info(struct smb2_query_info_rsp *rsp,
+				 struct ksmbd_file *fp,
+				 void *rsp_org)
+{
+	struct smb2_file_access_info *file_info;
+
+	file_info = (struct smb2_file_access_info *)rsp->Buffer;
+	file_info->AccessFlags = fp->daccess;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_access_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_access_info));
+}
+
+static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
+			       struct ksmbd_file *fp,
+			       void *rsp_org)
+{
+	struct smb2_file_all_info *basic_info;
+	struct kstat stat;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		ksmbd_err("no right to read the attributes : 0x%x\n",
+			   fp->daccess);
+		return -EACCES;
+	}
+
+	basic_info = (struct smb2_file_all_info *)rsp->Buffer;
+	generic_fillattr(&init_user_ns, FP_INODE(fp), &stat);
+	basic_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	basic_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	basic_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	basic_info->ChangeTime = cpu_to_le64(time);
+	basic_info->Attributes = fp->f_ci->m_fattr;
+	basic_info->Pad1 = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(offsetof(struct smb2_file_all_info,
+						AllocationSize));
+	inc_rfc1001_len(rsp_org, offsetof(struct smb2_file_all_info,
+					  AllocationSize));
+	return 0;
+}
+
+static unsigned long long get_allocation_size(struct inode *inode,
+		struct kstat *stat)
+{
+	unsigned long long alloc_size = 0;
+
+	if (!S_ISDIR(stat->mode)) {
+		if ((inode->i_blocks << 9) <= stat->size)
+			alloc_size = stat->size;
+		else
+			alloc_size = inode->i_blocks << 9;
+
+	}
+
+	return alloc_size;
+}
+
+static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp,
+				   void *rsp_org)
+{
+	struct smb2_file_standard_info *sinfo;
+	unsigned int delete_pending;
+	struct inode *inode;
+	struct kstat stat;
+
+	inode = FP_INODE(fp);
+	generic_fillattr(&init_user_ns, inode, &stat);
+
+	sinfo = (struct smb2_file_standard_info *)rsp->Buffer;
+	delete_pending = ksmbd_inode_pending_delete(fp);
+
+	sinfo->AllocationSize = cpu_to_le64(get_allocation_size(inode, &stat));
+	sinfo->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	sinfo->NumberOfLinks = cpu_to_le32(get_nlink(&stat) - delete_pending);
+	sinfo->DeletePending = delete_pending;
+	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp_org,
+			sizeof(struct smb2_file_standard_info));
+}
+
+static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
+				    void *rsp_org)
+{
+	struct smb2_file_alignment_info *file_info;
+
+	file_info = (struct smb2_file_alignment_info *)rsp->Buffer;
+	file_info->AlignmentRequirement = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_alignment_info));
+	inc_rfc1001_len(rsp_org,
+			sizeof(struct smb2_file_alignment_info));
+}
+
+static int get_file_all_info(struct ksmbd_work *work,
+			     struct smb2_query_info_rsp *rsp,
+			     struct ksmbd_file *fp,
+			     void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_all_info *file_info;
+	unsigned int delete_pending;
+	struct inode *inode;
+	struct kstat stat;
+	int conv_len;
+	char *filename;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		ksmbd_debug(SMB, "no right to read the attributes : 0x%x\n",
+				fp->daccess);
+		return -EACCES;
+	}
+
+	filename = convert_to_nt_pathname(fp->filename,
+					  work->tcon->share_conf->path);
+	if (!filename)
+		return -ENOMEM;
+
+	inode = FP_INODE(fp);
+	generic_fillattr(&init_user_ns, inode, &stat);
+
+	ksmbd_debug(SMB, "filename = %s\n", filename);
+	delete_pending = ksmbd_inode_pending_delete(fp);
+	file_info = (struct smb2_file_all_info *)rsp->Buffer;
+
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->Attributes = fp->f_ci->m_fattr;
+	file_info->Pad1 = 0;
+	file_info->AllocationSize =
+		cpu_to_le64(get_allocation_size(inode, &stat));
+	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	file_info->NumberOfLinks =
+			cpu_to_le32(get_nlink(&stat) - delete_pending);
+	file_info->DeletePending = delete_pending;
+	file_info->Directory = S_ISDIR(stat.mode) ? 1 : 0;
+	file_info->Pad2 = 0;
+	file_info->IndexNumber = cpu_to_le64(stat.ino);
+	file_info->EASize = 0;
+	file_info->AccessFlags = fp->daccess;
+	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
+	file_info->Mode = fp->coption;
+	file_info->AlignmentRequirement = 0;
+	conv_len = smbConvertToUTF16((__le16 *)file_info->FileName,
+					     filename,
+					     PATH_MAX,
+					     conn->local_nls,
+					     0);
+	conv_len *= 2;
+	file_info->FileNameLength = cpu_to_le32(conv_len);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_all_info) + conv_len - 1);
+	kfree(filename);
+	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
+	return 0;
+}
+
+static void get_file_alternate_info(struct ksmbd_work *work,
+				    struct smb2_query_info_rsp *rsp,
+				    struct ksmbd_file *fp,
+				    void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_alt_name_info *file_info;
+	int conv_len;
+	char *filename;
+
+	filename = (char *)FP_FILENAME(fp);
+	file_info = (struct smb2_file_alt_name_info *)rsp->Buffer;
+	conv_len = ksmbd_extract_shortname(conn,
+					   filename,
+					   file_info->FileName);
+	file_info->FileNameLength = cpu_to_le32(conv_len);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
+	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
+}
+
+static void get_file_stream_info(struct ksmbd_work *work,
+				 struct smb2_query_info_rsp *rsp,
+				 struct ksmbd_file *fp,
+				 void *rsp_org)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_file_stream_info *file_info;
+	char *stream_name, *xattr_list = NULL, *stream_buf;
+	struct kstat stat;
+	struct path *path = &fp->filp->f_path;
+	ssize_t xattr_list_len;
+	int nbytes = 0, streamlen, stream_name_len, next, idx = 0;
+
+	generic_fillattr(&init_user_ns, FP_INODE(fp), &stat);
+	file_info = (struct smb2_file_stream_info *)rsp->Buffer;
+
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
+	if (xattr_list_len < 0) {
+		goto out;
+	} else if (!xattr_list_len) {
+		ksmbd_debug(SMB, "empty xattr in the file\n");
+		goto out;
+	}
+
+	while (idx < xattr_list_len) {
+		stream_name = xattr_list + idx;
+		streamlen = strlen(stream_name);
+		idx += streamlen + 1;
+
+		ksmbd_debug(SMB, "%s, len %d\n", stream_name, streamlen);
+
+		if (strncmp(&stream_name[XATTR_USER_PREFIX_LEN],
+			STREAM_PREFIX, STREAM_PREFIX_LEN))
+			continue;
+
+		stream_name_len = streamlen - (XATTR_USER_PREFIX_LEN +
+				STREAM_PREFIX_LEN);
+		streamlen = stream_name_len;
+
+		/* plus : size */
+		streamlen += 1;
+		stream_buf = kmalloc(streamlen + 1, GFP_KERNEL);
+		if (!stream_buf)
+			break;
+
+		streamlen = snprintf(stream_buf, streamlen + 1,
+				":%s", &stream_name[XATTR_NAME_STREAM_LEN]);
+
+		file_info = (struct smb2_file_stream_info *)
+			&rsp->Buffer[nbytes];
+		streamlen  = smbConvertToUTF16((__le16 *)file_info->StreamName,
+						stream_buf,
+						streamlen,
+						conn->local_nls,
+						0);
+		streamlen *= 2;
+		kfree(stream_buf);
+		file_info->StreamNameLength = cpu_to_le32(streamlen);
+		file_info->StreamSize = cpu_to_le64(stream_name_len);
+		file_info->StreamAllocationSize = cpu_to_le64(stream_name_len);
+
+		next = sizeof(struct smb2_file_stream_info) + streamlen;
+		nbytes += next;
+		file_info->NextEntryOffset = cpu_to_le32(next);
+	}
+
+	if (nbytes) {
+		file_info = (struct smb2_file_stream_info *)
+			&rsp->Buffer[nbytes];
+		streamlen = smbConvertToUTF16((__le16 *)file_info->StreamName,
+			"::$DATA", 7, conn->local_nls, 0);
+		streamlen *= 2;
+		file_info->StreamNameLength = cpu_to_le32(streamlen);
+		file_info->StreamSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.size);
+		file_info->StreamAllocationSize = S_ISDIR(stat.mode) ? 0 :
+			cpu_to_le64(stat.size);
+		nbytes += sizeof(struct smb2_file_stream_info) + streamlen;
+	}
+
+	/* last entry offset should be 0 */
+	file_info->NextEntryOffset = 0;
+out:
+	ksmbd_vfs_xattr_free(xattr_list);
+
+	rsp->OutputBufferLength = cpu_to_le32(nbytes);
+	inc_rfc1001_len(rsp_org, nbytes);
+}
+
+static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp,
+				   void *rsp_org)
+{
+	struct smb2_file_internal_info *file_info;
+	struct kstat stat;
+
+	generic_fillattr(&init_user_ns, FP_INODE(fp), &stat);
+	file_info = (struct smb2_file_internal_info *)rsp->Buffer;
+	file_info->IndexNumber = cpu_to_le64(stat.ino);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
+}
+
+static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
+				      struct ksmbd_file *fp,
+				      void *rsp_org)
+{
+	struct smb2_file_ntwrk_info *file_info;
+	struct inode *inode;
+	struct kstat stat;
+	u64 time;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		ksmbd_err("no right to read the attributes : 0x%x\n",
+			  fp->daccess);
+		return -EACCES;
+	}
+
+	file_info = (struct smb2_file_ntwrk_info *)rsp->Buffer;
+
+	inode = FP_INODE(fp);
+	generic_fillattr(&init_user_ns, inode, &stat);
+
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(stat.atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(stat.ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->Attributes = fp->f_ci->m_fattr;
+	file_info->AllocationSize =
+		cpu_to_le64(get_allocation_size(inode, &stat));
+	file_info->EndOfFile = S_ISDIR(stat.mode) ? 0 : cpu_to_le64(stat.size);
+	file_info->Reserved = cpu_to_le32(0);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_ntwrk_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ntwrk_info));
+	return 0;
+}
+
+static void get_file_ea_info(struct smb2_query_info_rsp *rsp,
+			     void *rsp_org)
+{
+	struct smb2_file_ea_info *file_info;
+
+	file_info = (struct smb2_file_ea_info *)rsp->Buffer;
+	file_info->EASize = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_ea_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ea_info));
+}
+
+static void get_file_position_info(struct smb2_query_info_rsp *rsp,
+				   struct ksmbd_file *fp,
+				   void *rsp_org)
+{
+	struct smb2_file_pos_info *file_info;
+
+	file_info = (struct smb2_file_pos_info *)rsp->Buffer;
+	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_pos_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_pos_info));
+}
+
+static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
+			       struct ksmbd_file *fp,
+			       void *rsp_org)
+{
+	struct smb2_file_mode_info *file_info;
+
+	file_info = (struct smb2_file_mode_info *)rsp->Buffer;
+	file_info->Mode = fp->coption & FILE_MODE_INFO_MASK;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_mode_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_mode_info));
+}
+
+static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
+				      struct ksmbd_file *fp,
+				      void *rsp_org)
+{
+	struct smb2_file_comp_info *file_info;
+	struct kstat stat;
+
+	generic_fillattr(&init_user_ns, FP_INODE(fp), &stat);
+
+	file_info = (struct smb2_file_comp_info *)rsp->Buffer;
+	file_info->CompressedFileSize = cpu_to_le64(stat.blocks << 9);
+	file_info->CompressionFormat = COMPRESSION_FORMAT_NONE;
+	file_info->CompressionUnitShift = 0;
+	file_info->ChunkShift = 0;
+	file_info->ClusterShift = 0;
+	memset(&file_info->Reserved[0], 0, 3);
+
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_comp_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_comp_info));
+}
+
+static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
+					struct ksmbd_file *fp,
+					void *rsp_org)
+{
+	struct smb2_file_attr_tag_info *file_info;
+
+	if (!(fp->daccess & FILE_READ_ATTRIBUTES_LE)) {
+		ksmbd_err("no right to read the attributes : 0x%x\n",
+			  fp->daccess);
+		return -EACCES;
+	}
+
+	file_info = (struct smb2_file_attr_tag_info *)rsp->Buffer;
+	file_info->FileAttributes = fp->f_ci->m_fattr;
+	file_info->ReparseTag = 0;
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb2_file_attr_tag_info));
+	inc_rfc1001_len(rsp_org,
+		sizeof(struct smb2_file_attr_tag_info));
+	return 0;
+}
+
+static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
+					struct ksmbd_file *fp,
+					void *rsp_org)
+{
+	struct smb311_posix_qinfo *file_info;
+	struct inode *inode = FP_INODE(fp);
+	u64 time;
+
+	file_info = (struct smb311_posix_qinfo *)rsp->Buffer;
+	file_info->CreationTime = cpu_to_le64(fp->create_time);
+	time = ksmbd_UnixTimeToNT(inode->i_atime);
+	file_info->LastAccessTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(inode->i_mtime);
+	file_info->LastWriteTime = cpu_to_le64(time);
+	time = ksmbd_UnixTimeToNT(inode->i_ctime);
+	file_info->ChangeTime = cpu_to_le64(time);
+	file_info->DosAttributes = fp->f_ci->m_fattr;
+	file_info->Inode = cpu_to_le64(inode->i_ino);
+	file_info->EndOfFile = cpu_to_le64(inode->i_size);
+	file_info->AllocationSize = cpu_to_le64(inode->i_blocks << 9);
+	file_info->HardLinks = cpu_to_le32(inode->i_nlink);
+	file_info->Mode = cpu_to_le32(inode->i_mode);
+	file_info->DeviceId = cpu_to_le32(inode->i_rdev);
+	rsp->OutputBufferLength =
+		cpu_to_le32(sizeof(struct smb311_posix_qinfo));
+	inc_rfc1001_len(rsp_org,
+		sizeof(struct smb311_posix_qinfo));
+	return 0;
+}
+
+static int smb2_get_info_file(struct ksmbd_work *work,
+			      struct smb2_query_info_req *req,
+			      struct smb2_query_info_rsp *rsp,
+			      void *rsp_org)
+{
+	struct ksmbd_file *fp;
+	int fileinfoclass = 0;
+	int rc = 0;
+	int file_infoclass_size;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				KSMBD_SHARE_FLAG_PIPE)) {
+		/* smb2 info file called for pipe */
+		return smb2_get_info_file_pipe(work->sess, req, rsp);
+	}
+
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!HAS_FILE_ID(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %u\n",
+					work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	}
+
+	if (!HAS_FILE_ID(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp)
+		return -ENOENT;
+
+	fileinfoclass = req->FileInfoClass;
+
+	switch (fileinfoclass) {
+	case FILE_ACCESS_INFORMATION:
+		get_file_access_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
+		break;
+
+	case FILE_BASIC_INFORMATION:
+		rc = get_file_basic_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
+		break;
+
+	case FILE_STANDARD_INFORMATION:
+		get_file_standard_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALIGNMENT_INFORMATION:
+		get_file_alignment_info(rsp, rsp_org);
+		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALL_INFORMATION:
+		rc = get_file_all_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
+		break;
+
+	case FILE_ALTERNATE_NAME_INFORMATION:
+		get_file_alternate_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
+		break;
+
+	case FILE_STREAM_INFORMATION:
+		get_file_stream_info(work, rsp, fp, rsp_org);
+		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
+		break;
+
+	case FILE_INTERNAL_INFORMATION:
+		get_file_internal_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
+		break;
+
+	case FILE_NETWORK_OPEN_INFORMATION:
+		rc = get_file_network_open_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
+		break;
+
+	case FILE_EA_INFORMATION:
+		get_file_ea_info(rsp, rsp_org);
+		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
+		break;
+
+	case FILE_FULL_EA_INFORMATION:
+		rc = smb2_get_ea(work, fp, req, rsp, rsp_org);
+		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
+		break;
+
+	case FILE_POSITION_INFORMATION:
+		get_file_position_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
+		break;
+
+	case FILE_MODE_INFORMATION:
+		get_file_mode_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
+		break;
+
+	case FILE_COMPRESSION_INFORMATION:
+		get_file_compression_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
+		break;
+
+	case FILE_ATTRIBUTE_TAG_INFORMATION:
+		rc = get_file_attribute_tag_info(rsp, fp, rsp_org);
+		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
+		break;
+	case SMB_FIND_FILE_POSIX_INFO:
+		if (!work->tcon->posix_extensions) {
+			ksmbd_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
+			rc = -EOPNOTSUPP;
+		} else {
+			rc = find_file_posix_info(rsp, fp, rsp_org);
+			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
+		}
+		break;
+	default:
+		ksmbd_debug(SMB, "fileinfoclass %d not supported yet\n",
+			    fileinfoclass);
+		rc = -EOPNOTSUPP;
+	}
+	if (!rc)
+		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+				      rsp,
+				      file_infoclass_size);
+	ksmbd_fd_put(work, fp);
+	return rc;
+}
+
+static int smb2_get_info_filesystem(struct ksmbd_work *work,
+				    struct smb2_query_info_req *req,
+				    struct smb2_query_info_rsp *rsp,
+				    void *rsp_org)
+{
+	struct ksmbd_session *sess = work->sess;
+	struct ksmbd_conn *conn = sess->conn;
+	struct ksmbd_share_config *share = work->tcon->share_conf;
+	int fsinfoclass = 0;
+	struct kstatfs stfs;
+	struct path path;
+	int rc = 0, len;
+	int fs_infoclass_size = 0;
+
+	rc = ksmbd_vfs_kern_path(share->path, LOOKUP_FOLLOW, &path, 0);
+	if (rc) {
+		ksmbd_err("cannot create vfs path\n");
+		return -EIO;
+	}
+
+	rc = vfs_statfs(&path, &stfs);
+	if (rc) {
+		ksmbd_err("cannot do stat of path %s\n", share->path);
+		path_put(&path);
+		return -EIO;
+	}
+
+	fsinfoclass = req->FileInfoClass;
+
+	switch (fsinfoclass) {
+	case FS_DEVICE_INFORMATION:
+	{
+		struct filesystem_device_info *info;
+
+		info = (struct filesystem_device_info *)rsp->Buffer;
+
+		info->DeviceType = cpu_to_le32(stfs.f_type);
+		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
+		rsp->OutputBufferLength = cpu_to_le32(8);
+		inc_rfc1001_len(rsp_org, 8);
+		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_ATTRIBUTE_INFORMATION:
+	{
+		struct filesystem_attribute_info *info;
+		size_t sz;
+
+		info = (struct filesystem_attribute_info *)rsp->Buffer;
+		info->Attributes = cpu_to_le32(FILE_SUPPORTS_OBJECT_IDS |
+					       FILE_PERSISTENT_ACLS |
+					       FILE_UNICODE_ON_DISK |
+					       FILE_CASE_PRESERVED_NAMES |
+					       FILE_CASE_SENSITIVE_SEARCH);
+
+		info->Attributes |= cpu_to_le32(server_conf.share_fake_fscaps);
+
+		info->MaxPathNameComponentLength = cpu_to_le32(stfs.f_namelen);
+		len = smbConvertToUTF16((__le16 *)info->FileSystemName,
+					"NTFS", PATH_MAX, conn->local_nls, 0);
+		len = len * 2;
+		info->FileSystemNameLen = cpu_to_le32(len);
+		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
+		rsp->OutputBufferLength = cpu_to_le32(sz);
+		inc_rfc1001_len(rsp_org, sz);
+		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_VOLUME_INFORMATION:
+	{
+		struct filesystem_vol_info *info;
+		size_t sz;
+
+		info = (struct filesystem_vol_info *)(rsp->Buffer);
+		info->VolumeCreationTime = 0;
+		/* Taking dummy value of serial number*/
+		info->SerialNumber = cpu_to_le32(0xbc3ac512);
+		len = smbConvertToUTF16((__le16 *)info->VolumeLabel,
+					share->name, PATH_MAX,
+					conn->local_nls, 0);
+		len = len * 2;
+		info->VolumeLabelSize = cpu_to_le32(len);
+		info->Reserved = 0;
+		sz = sizeof(struct filesystem_vol_info) - 2 + len;
+		rsp->OutputBufferLength = cpu_to_le32(sz);
+		inc_rfc1001_len(rsp_org, sz);
+		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
+		break;
+	}
+	case FS_SIZE_INFORMATION:
+	{
+		struct filesystem_info *info;
+		unsigned short logical_sector_size;
+
+		info = (struct filesystem_info *)(rsp->Buffer);
+		logical_sector_size =
+			ksmbd_vfs_logical_sector_size(d_inode(path.dentry));
+
+		info->TotalAllocationUnits = cpu_to_le64(stfs.f_blocks);
+		info->FreeAllocationUnits = cpu_to_le64(stfs.f_bfree);
+		info->SectorsPerAllocationUnit = cpu_to_le32(stfs.f_bsize >> 9);
+		info->BytesPerSector = cpu_to_le32(logical_sector_size);
+		rsp->OutputBufferLength = cpu_to_le32(24);
+		inc_rfc1001_len(rsp_org, 24);
+		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_FULL_SIZE_INFORMATION:
+	{
+		struct smb2_fs_full_size_info *info;
+		unsigned short logical_sector_size;
+
+		info = (struct smb2_fs_full_size_info *)(rsp->Buffer);
+		logical_sector_size =
+			ksmbd_vfs_logical_sector_size(d_inode(path.dentry));
+
+		info->TotalAllocationUnits = cpu_to_le64(stfs.f_blocks);
+		info->CallerAvailableAllocationUnits =
+					cpu_to_le64(stfs.f_bavail);
+		info->ActualAvailableAllocationUnits =
+					cpu_to_le64(stfs.f_bfree);
+		info->SectorsPerAllocationUnit = cpu_to_le32(stfs.f_bsize >> 9);
+		info->BytesPerSector = cpu_to_le32(logical_sector_size);
+		rsp->OutputBufferLength = cpu_to_le32(32);
+		inc_rfc1001_len(rsp_org, 32);
+		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_OBJECT_ID_INFORMATION:
+	{
+		struct object_id_info *info;
+
+		info = (struct object_id_info *)(rsp->Buffer);
+
+		if (!user_guest(sess->user))
+			memcpy(info->objid, user_passkey(sess->user), 16);
+		else
+			memset(info->objid, 0, 16);
+
+		info->extended_info.magic = cpu_to_le32(EXTENDED_INFO_MAGIC);
+		info->extended_info.version = cpu_to_le32(1);
+		info->extended_info.release = cpu_to_le32(1);
+		info->extended_info.rel_date = 0;
+		memcpy(info->extended_info.version_string,
+			"1.1.0",
+			strlen("1.1.0"));
+		rsp->OutputBufferLength = cpu_to_le32(64);
+		inc_rfc1001_len(rsp_org, 64);
+		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
+		break;
+	}
+	case FS_SECTOR_SIZE_INFORMATION:
+	{
+		struct smb3_fs_ss_info *info;
+		struct ksmbd_fs_sector_size fs_ss;
+
+		info = (struct smb3_fs_ss_info *)(rsp->Buffer);
+		ksmbd_vfs_smb2_sector_size(d_inode(path.dentry), &fs_ss);
+
+		info->LogicalBytesPerSector =
+				cpu_to_le32(fs_ss.logical_sector_size);
+		info->PhysicalBytesPerSectorForAtomicity =
+				cpu_to_le32(fs_ss.physical_sector_size);
+		info->PhysicalBytesPerSectorForPerf =
+				cpu_to_le32(fs_ss.optimal_io_size);
+		info->FSEffPhysicalBytesPerSectorForAtomicity =
+				cpu_to_le32(fs_ss.optimal_io_size);
+		info->Flags = cpu_to_le32(SSINFO_FLAGS_ALIGNED_DEVICE |
+				    SSINFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE);
+		info->ByteOffsetForSectorAlignment = 0;
+		info->ByteOffsetForPartitionAlignment = 0;
+		rsp->OutputBufferLength = cpu_to_le32(28);
+		inc_rfc1001_len(rsp_org, 28);
+		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
+		break;
+	}
+	case FS_CONTROL_INFORMATION:
+	{
+		/*
+		 * TODO : The current implementation is based on
+		 * test result with win7(NTFS) server. It's need to
+		 * modify this to get valid Quota values
+		 * from Linux kernel
+		 */
+		struct smb2_fs_control_info *info;
+
+		info = (struct smb2_fs_control_info *)(rsp->Buffer);
+		info->FreeSpaceStartFiltering = 0;
+		info->FreeSpaceThreshold = 0;
+		info->FreeSpaceStopFiltering = 0;
+		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
+		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->Padding = 0;
+		rsp->OutputBufferLength = cpu_to_le32(48);
+		inc_rfc1001_len(rsp_org, 48);
+		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
+		break;
+	}
+	case FS_POSIX_INFORMATION:
+	{
+		struct filesystem_posix_info *info;
+		unsigned short logical_sector_size;
+
+		if (!work->tcon->posix_extensions) {
+			ksmbd_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
+			rc = -EOPNOTSUPP;
+		} else {
+			info = (struct filesystem_posix_info *)(rsp->Buffer);
+			logical_sector_size =
+				ksmbd_vfs_logical_sector_size(d_inode(path.dentry));
+			info->OptimalTransferSize = cpu_to_le32(logical_sector_size);
+			info->BlockSize = cpu_to_le32(stfs.f_bsize);
+			info->TotalBlocks = cpu_to_le64(stfs.f_blocks);
+			info->BlocksAvail = cpu_to_le64(stfs.f_bfree);
+			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
+			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
+			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			rsp->OutputBufferLength = cpu_to_le32(56);
+			inc_rfc1001_len(rsp_org, 56);
+			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
+		}
+		break;
+	}
+	default:
+		path_put(&path);
+		return -EOPNOTSUPP;
+	}
+	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
+			      rsp,
+			      fs_infoclass_size);
+	path_put(&path);
+	return rc;
+}
+
+static int smb2_get_info_sec(struct ksmbd_work *work,
+	struct smb2_query_info_req *req, struct smb2_query_info_rsp *rsp,
+	void *rsp_org)
+{
+	struct ksmbd_file *fp;
+	struct smb_ntsd *pntsd = (struct smb_ntsd *)rsp->Buffer, *ppntsd = NULL;
+	struct smb_fattr fattr = {{0}};
+	struct inode *inode;
+	__u32 secdesclen;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+	int addition_info = le32_to_cpu(req->AdditionalInformation);
+	int rc;
+
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!HAS_FILE_ID(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %u\n",
+					work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	}
+
+	if (!HAS_FILE_ID(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp)
+		return -ENOENT;
+
+	inode = FP_INODE(fp);
+	fattr.cf_uid = inode->i_uid;
+	fattr.cf_gid = inode->i_gid;
+	fattr.cf_mode = inode->i_mode;
+	fattr.cf_dacls = NULL;
+
+	fattr.cf_acls = ksmbd_vfs_get_acl(inode, ACL_TYPE_ACCESS);
+	if (S_ISDIR(inode->i_mode))
+		fattr.cf_dacls = ksmbd_vfs_get_acl(inode, ACL_TYPE_DEFAULT);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+	    KSMBD_SHARE_FLAG_ACL_XATTR))
+		ksmbd_vfs_get_sd_xattr(work->conn, fp->filp->f_path.dentry, &ppntsd);
+
+	rc = build_sec_desc(pntsd, ppntsd, addition_info, &secdesclen, &fattr);
+	posix_acl_release(fattr.cf_acls);
+	posix_acl_release(fattr.cf_dacls);
+	kfree(ppntsd);
+	ksmbd_fd_put(work, fp);
+	if (rc)
+		return rc;
+
+	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
+	inc_rfc1001_len(rsp_org, secdesclen);
+	return 0;
+}
+
+/**
+ * smb2_query_info() - handler for smb2 query info command
+ * @work:	smb work containing query info request buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_query_info(struct ksmbd_work *work)
+{
+	struct smb2_query_info_req *req;
+	struct smb2_query_info_rsp *rsp, *rsp_org;
+	int rc = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	ksmbd_debug(SMB, "GOT query info request\n");
+
+	switch (req->InfoType) {
+	case SMB2_O_INFO_FILE:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
+		rc = smb2_get_info_file(work, req, rsp, (void *)rsp_org);
+		break;
+	case SMB2_O_INFO_FILESYSTEM:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILESYSTEM\n");
+		rc = smb2_get_info_filesystem(work, req, rsp, (void *)rsp_org);
+		break;
+	case SMB2_O_INFO_SECURITY:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
+		rc = smb2_get_info_sec(work, req, rsp, (void *)rsp_org);
+		break;
+	default:
+		ksmbd_debug(SMB, "InfoType %d not supported yet\n",
+			req->InfoType);
+		rc = -EOPNOTSUPP;
+	}
+
+	if (rc < 0) {
+		if (rc == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (rc == -ENOENT)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		else if (rc == -EIO)
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+		smb2_set_err_rsp(work);
+
+		ksmbd_debug(SMB, "error while processing smb2 query rc = %d\n",
+			      rc);
+		return rc;
+	}
+	rsp->StructureSize = cpu_to_le16(9);
+	rsp->OutputBufferOffset = cpu_to_le16(72);
+	inc_rfc1001_len(rsp_org, 8);
+	return 0;
+}
+
+/**
+ * smb2_close_pipe() - handler for closing IPC pipe
+ * @work:	smb work containing close request buffer
+ *
+ * Return:	0
+ */
+static noinline int smb2_close_pipe(struct ksmbd_work *work)
+{
+	uint64_t id;
+	struct smb2_close_req *req = REQUEST_BUF(work);
+	struct smb2_close_rsp *rsp = RESPONSE_BUF(work);
+
+	id = le64_to_cpu(req->VolatileFileId);
+	ksmbd_session_rpc_close(work->sess, id);
+
+	rsp->StructureSize = cpu_to_le16(60);
+	rsp->Flags = 0;
+	rsp->Reserved = 0;
+	rsp->CreationTime = 0;
+	rsp->LastAccessTime = 0;
+	rsp->LastWriteTime = 0;
+	rsp->ChangeTime = 0;
+	rsp->AllocationSize = 0;
+	rsp->EndOfFile = 0;
+	rsp->Attributes = 0;
+	inc_rfc1001_len(rsp, 60);
+	return 0;
+}
+
+/**
+ * smb2_close() - handler for smb2 close file command
+ * @work:	smb work containing close request buffer
+ *
+ * Return:	0
+ */
+int smb2_close(struct ksmbd_work *work)
+{
+	unsigned int volatile_id = KSMBD_NO_FID;
+	uint64_t sess_id;
+	struct smb2_close_req *req;
+	struct smb2_close_rsp *rsp;
+	struct smb2_close_rsp *rsp_org;
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_file *fp;
+	struct inode *inode;
+	u64 time;
+	int err = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe close request\n");
+		return smb2_close_pipe(work);
+	}
+
+	sess_id = le64_to_cpu(req->hdr.SessionId);
+	if (req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)
+		sess_id = work->compound_sid;
+
+	work->compound_sid = 0;
+	if (check_session_id(conn, sess_id))
+		work->compound_sid = sess_id;
+	else {
+		rsp->hdr.Status = STATUS_USER_SESSION_DELETED;
+		if (req->hdr.Flags & SMB2_FLAGS_RELATED_OPERATIONS)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		err = -EBADF;
+		goto out;
+	}
+
+	if (work->next_smb2_rcv_hdr_off &&
+			!HAS_FILE_ID(le64_to_cpu(req->VolatileFileId))) {
+		if (!HAS_FILE_ID(work->compound_fid)) {
+			/* file already closed, return FILE_CLOSED */
+			ksmbd_debug(SMB, "file already closed\n");
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+			err = -EBADF;
+			goto out;
+		} else {
+			ksmbd_debug(SMB, "Compound request set FID = %u:%u\n",
+					work->compound_fid,
+					work->compound_pfid);
+			volatile_id = work->compound_fid;
+
+			/* file closed, stored id is not valid anymore */
+			work->compound_fid = KSMBD_NO_FID;
+			work->compound_pfid = KSMBD_NO_FID;
+		}
+	} else {
+		volatile_id = le64_to_cpu(req->VolatileFileId);
+	}
+	ksmbd_debug(SMB, "volatile_id = %u\n", volatile_id);
+
+	rsp->StructureSize = cpu_to_le16(60);
+	rsp->Reserved = 0;
+
+	if (req->Flags == SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB) {
+		fp = ksmbd_lookup_fd_fast(work, volatile_id);
+		if (!fp) {
+			err = -ENOENT;
+			goto out;
+		}
+
+		inode = FP_INODE(fp);
+		rsp->Flags = SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB;
+		rsp->AllocationSize = S_ISDIR(inode->i_mode) ? 0 :
+			cpu_to_le64(inode->i_blocks << 9);
+		rsp->EndOfFile = cpu_to_le64(inode->i_size);
+		rsp->Attributes = fp->f_ci->m_fattr;
+		rsp->CreationTime = cpu_to_le64(fp->create_time);
+		time = ksmbd_UnixTimeToNT(inode->i_atime);
+		rsp->LastAccessTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(inode->i_mtime);
+		rsp->LastWriteTime = cpu_to_le64(time);
+		time = ksmbd_UnixTimeToNT(inode->i_ctime);
+		rsp->ChangeTime = cpu_to_le64(time);
+		ksmbd_fd_put(work, fp);
+	} else {
+		rsp->Flags = 0;
+		rsp->AllocationSize = 0;
+		rsp->EndOfFile = 0;
+		rsp->Attributes = 0;
+		rsp->CreationTime = 0;
+		rsp->LastAccessTime = 0;
+		rsp->LastWriteTime = 0;
+		rsp->ChangeTime = 0;
+	}
+
+	err = ksmbd_close_fd(work, volatile_id);
+out:
+	if (err) {
+		if (rsp->hdr.Status == 0)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		smb2_set_err_rsp(work);
+	} else {
+		inc_rfc1001_len(rsp_org, 60);
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_echo() - handler for smb2 echo(ping) command
+ * @work:	smb work containing echo request buffer
+ *
+ * Return:	0
+ */
+int smb2_echo(struct ksmbd_work *work)
+{
+	struct smb2_echo_rsp *rsp = RESPONSE_BUF(work);
+
+	rsp->StructureSize = cpu_to_le16(4);
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp, 4);
+	return 0;
+}
+
+static int smb2_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
+		       struct smb2_file_rename_info *file_info,
+		       struct nls_table *local_nls)
+{
+	struct ksmbd_share_config *share = fp->tcon->share_conf;
+	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
+	char *pathname = NULL;
+	struct path path;
+	bool file_present = true;
+	int rc;
+
+	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+
+	abs_oldname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(abs_oldname)) {
+		rc = -EINVAL;
+		goto out;
+	}
+	old_name = strrchr(abs_oldname, '/');
+	if (old_name && old_name[1] != '\0')
+		old_name++;
+	else {
+		ksmbd_debug(SMB, "can't get last component in path %s\n",
+				abs_oldname);
+		rc = -ENOENT;
+		goto out;
+	}
+
+	new_name = smb2_get_name(share,
+				 file_info->FileName,
+				 le32_to_cpu(file_info->FileNameLength),
+				 local_nls);
+	if (IS_ERR(new_name)) {
+		rc = PTR_ERR(new_name);
+		goto out;
+	}
+
+	if (strchr(new_name, ':')) {
+		int s_type;
+		char *xattr_stream_name, *stream_name = NULL;
+		size_t xattr_stream_size;
+		int len;
+
+		rc = parse_stream_name(new_name, &stream_name, &s_type);
+		if (rc < 0)
+			goto out;
+
+		len = strlen(new_name);
+		if (new_name[len - 1] != '/') {
+			ksmbd_err("not allow base filename in rename\n");
+			rc = -ESHARE;
+			goto out;
+		}
+
+		rc = ksmbd_vfs_xattr_stream_name(stream_name,
+						 &xattr_stream_name,
+						 &xattr_stream_size,
+						 s_type);
+		if (rc)
+			goto out;
+
+		rc = ksmbd_vfs_setxattr(fp->filp->f_path.dentry,
+					xattr_stream_name,
+					NULL, 0, 0);
+		if (rc < 0) {
+			ksmbd_err("failed to store stream name in xattr: %d\n",
+				   rc);
+			rc = -EINVAL;
+			goto out;
+		}
+
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "new name %s\n", new_name);
+	rc = ksmbd_vfs_kern_path(new_name, 0, &path, 1);
+	if (rc)
+		file_present = false;
+	else
+		path_put(&path);
+
+	if (ksmbd_share_veto_filename(share, new_name)) {
+		rc = -ENOENT;
+		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
+		goto out;
+	}
+
+	if (file_info->ReplaceIfExists) {
+		if (file_present) {
+			rc = ksmbd_vfs_remove_file(work, new_name);
+			if (rc) {
+				if (rc != -ENOTEMPTY)
+					rc = -EINVAL;
+				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
+						new_name, rc);
+				goto out;
+			}
+		}
+	} else {
+		if (file_present &&
+				strncmp(old_name, path.dentry->d_name.name,
+					strlen(old_name))) {
+			rc = -EEXIST;
+			ksmbd_debug(SMB,
+				"cannot rename already existing file\n");
+			goto out;
+		}
+	}
+
+	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+out:
+	kfree(pathname);
+	if (!IS_ERR(new_name))
+		smb2_put_name(new_name);
+	return rc;
+}
+
+static int smb2_create_link(struct ksmbd_work *work,
+			    struct ksmbd_share_config *share,
+			    struct smb2_file_link_info *file_info,
+			    struct file *filp,
+			    struct nls_table *local_nls)
+{
+	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
+	struct path path;
+	bool file_present = true;
+	int rc;
+
+	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -ENOMEM;
+
+	link_name = smb2_get_name(share,
+				  file_info->FileName,
+				  le32_to_cpu(file_info->FileNameLength),
+				  local_nls);
+	if (IS_ERR(link_name) || S_ISDIR(file_inode(filp)->i_mode)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "link name is %s\n", link_name);
+	target_name = d_path(&filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(target_name)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "target name is %s\n", target_name);
+	rc = ksmbd_vfs_kern_path(link_name, 0, &path, 0);
+	if (rc)
+		file_present = false;
+	else
+		path_put(&path);
+
+	if (file_info->ReplaceIfExists) {
+		if (file_present) {
+			rc = ksmbd_vfs_remove_file(work, link_name);
+			if (rc) {
+				rc = -EINVAL;
+				ksmbd_debug(SMB, "cannot delete %s\n",
+					link_name);
+				goto out;
+			}
+		}
+	} else {
+		if (file_present) {
+			rc = -EEXIST;
+			ksmbd_debug(SMB, "link already exists\n");
+			goto out;
+		}
+	}
+
+	rc = ksmbd_vfs_link(work, target_name, link_name);
+	if (rc)
+		rc = -EINVAL;
+out:
+	if (!IS_ERR(link_name))
+		smb2_put_name(link_name);
+	kfree(pathname);
+	return rc;
+}
+
+static bool is_attributes_write_allowed(struct ksmbd_file *fp)
+{
+	return fp->daccess & FILE_WRITE_ATTRIBUTES_LE;
+}
+
+static int set_file_basic_info(struct ksmbd_file *fp,
+			       char *buf,
+			       struct ksmbd_share_config *share)
+{
+	struct smb2_file_all_info *file_info;
+	struct iattr attrs;
+	struct iattr temp_attrs;
+	struct file *filp;
+	struct inode *inode;
+	int rc;
+
+	if (!is_attributes_write_allowed(fp))
+		return -EACCES;
+
+	file_info = (struct smb2_file_all_info *)buf;
+	attrs.ia_valid = 0;
+	filp = fp->filp;
+	inode = file_inode(filp);
+
+	if (file_info->CreationTime)
+		fp->create_time = le64_to_cpu(file_info->CreationTime);
+
+	if (file_info->LastAccessTime) {
+		attrs.ia_atime = ksmbd_NTtimeToUnix(file_info->LastAccessTime);
+		attrs.ia_valid |= (ATTR_ATIME | ATTR_ATIME_SET);
+	}
+
+	if (file_info->ChangeTime) {
+		temp_attrs.ia_ctime = ksmbd_NTtimeToUnix(file_info->ChangeTime);
+		attrs.ia_ctime = temp_attrs.ia_ctime;
+		attrs.ia_valid |= ATTR_CTIME;
+	} else
+		temp_attrs.ia_ctime = inode->i_ctime;
+
+	if (file_info->LastWriteTime) {
+		attrs.ia_mtime = ksmbd_NTtimeToUnix(file_info->LastWriteTime);
+		attrs.ia_valid |= (ATTR_MTIME | ATTR_MTIME_SET);
+	}
+
+	if (file_info->Attributes) {
+		if (!S_ISDIR(inode->i_mode) &&
+				file_info->Attributes & ATTR_DIRECTORY_LE) {
+			ksmbd_err("can't change a file to a directory\n");
+			return -EINVAL;
+		}
+
+		if (!(S_ISDIR(inode->i_mode) && file_info->Attributes == ATTR_NORMAL_LE))
+			fp->f_ci->m_fattr = file_info->Attributes |
+				(fp->f_ci->m_fattr & ATTR_DIRECTORY_LE);
+	}
+
+	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
+	    (file_info->CreationTime || file_info->Attributes)) {
+		struct xattr_dos_attrib da = {0};
+
+		da.version = 4;
+		da.itime = fp->itime;
+		da.create_time = fp->create_time;
+		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
+			XATTR_DOSINFO_ITIME;
+
+		rc = ksmbd_vfs_set_dos_attrib_xattr(filp->f_path.dentry, &da);
+		if (rc)
+			ksmbd_debug(SMB,
+				"failed to restore file attribute in EA\n");
+		rc = 0;
+	}
+
+	/*
+	 * HACK : set ctime here to avoid ctime changed
+	 * when file_info->ChangeTime is zero.
+	 */
+	attrs.ia_ctime = temp_attrs.ia_ctime;
+	attrs.ia_valid |= ATTR_CTIME;
+
+	if (attrs.ia_valid) {
+		struct dentry *dentry = filp->f_path.dentry;
+		struct inode *inode = d_inode(dentry);
+
+		if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+			return -EACCES;
+
+		rc = setattr_prepare(&init_user_ns, dentry, &attrs);
+		if (rc)
+			return -EINVAL;
+
+		inode_lock(inode);
+		setattr_copy(&init_user_ns, inode, &attrs);
+		attrs.ia_valid &= ~ATTR_CTIME;
+		rc = notify_change(&init_user_ns, dentry, &attrs, NULL);
+		inode_unlock(inode);
+	}
+	return 0;
+}
+
+static int set_file_allocation_info(struct ksmbd_work *work,
+				    struct ksmbd_file *fp,
+				    char *buf)
+{
+	/*
+	 * TODO : It's working fine only when store dos attributes
+	 * is not yes. need to implement a logic which works
+	 * properly with any smb.conf option
+	 */
+
+	struct smb2_file_alloc_info *file_alloc_info;
+	loff_t alloc_blks;
+	struct inode *inode;
+	int rc;
+
+	if (!is_attributes_write_allowed(fp))
+		return -EACCES;
+
+	file_alloc_info = (struct smb2_file_alloc_info *)buf;
+	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
+	inode = file_inode(fp->filp);
+
+	if (alloc_blks > inode->i_blocks) {
+		rc = ksmbd_vfs_alloc_size(work, fp, alloc_blks * 512);
+		if (rc && rc != -EOPNOTSUPP) {
+			ksmbd_err("ksmbd_vfs_alloc_size is failed : %d\n", rc);
+			return rc;
+		}
+	} else if (alloc_blks < inode->i_blocks) {
+		loff_t size;
+
+		/*
+		 * Allocation size could be smaller than original one
+		 * which means allocated blocks in file should be
+		 * deallocated. use truncate to cut out it, but inode
+		 * size is also updated with truncate offset.
+		 * inode size is retained by backup inode size.
+		 */
+		size = i_size_read(inode);
+		rc = ksmbd_vfs_truncate(work, NULL, fp, alloc_blks * 512);
+		if (rc) {
+			ksmbd_err("truncate failed! filename : %s, err %d\n",
+				  fp->filename, rc);
+			return rc;
+		}
+		if (size < alloc_blks * 512)
+			i_size_write(inode, size);
+	}
+	return 0;
+}
+
+static int set_end_of_file_info(struct ksmbd_work *work,
+				struct ksmbd_file *fp,
+				char *buf)
+{
+	struct smb2_file_eof_info *file_eof_info;
+	loff_t newsize;
+	struct inode *inode;
+	int rc;
+
+	if (!is_attributes_write_allowed(fp))
+		return -EACCES;
+
+	file_eof_info = (struct smb2_file_eof_info *)buf;
+	newsize = le64_to_cpu(file_eof_info->EndOfFile);
+	inode = file_inode(fp->filp);
+
+	/*
+	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
+	 * on FAT32 shared device, truncate execution time is too long
+	 * and network error could cause from windows client. because
+	 * truncate of some filesystem like FAT32 fill zero data in
+	 * truncated range.
+	 */
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
+		ksmbd_debug(SMB, "filename : %s truncated to newsize %lld\n",
+				fp->filename, newsize);
+		rc = ksmbd_vfs_truncate(work, NULL, fp, newsize);
+		if (rc) {
+			ksmbd_debug(SMB,
+				"truncate failed! filename : %s err %d\n",
+					fp->filename, rc);
+			if (rc != -EAGAIN)
+				rc = -EBADF;
+			return rc;
+		}
+	}
+	return 0;
+}
+
+static int set_rename_info(struct ksmbd_work *work,
+			   struct ksmbd_file *fp,
+			   char *buf)
+{
+	struct ksmbd_file *parent_fp;
+
+	if (!(fp->daccess & FILE_DELETE_LE)) {
+		ksmbd_err("no right to delete : 0x%x\n", fp->daccess);
+		return -EACCES;
+	}
+
+	if (ksmbd_stream_fd(fp))
+		goto next;
+
+	parent_fp = ksmbd_lookup_fd_inode(PARENT_INODE(fp));
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			ksmbd_err("parent dir is opened with delete access\n");
+			return -ESHARE;
+		}
+	}
+next:
+	return smb2_rename(work, fp,
+			   (struct smb2_file_rename_info *)buf,
+			   work->sess->conn->local_nls);
+}
+
+static int set_file_disposition_info(struct ksmbd_file *fp,
+				     char *buf)
+{
+	struct smb2_file_disposition_info *file_info;
+	struct inode *inode;
+
+	if (!(fp->daccess & FILE_DELETE_LE)) {
+		ksmbd_err("no right to delete : 0x%x\n", fp->daccess);
+		return -EACCES;
+	}
+
+	inode = file_inode(fp->filp);
+	file_info = (struct smb2_file_disposition_info *)buf;
+	if (file_info->DeletePending) {
+		if (S_ISDIR(inode->i_mode) &&
+				ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
+			return -EBUSY;
+		ksmbd_set_inode_pending_delete(fp);
+	} else {
+		ksmbd_clear_inode_pending_delete(fp);
+	}
+	return 0;
+}
+
+static int set_file_position_info(struct ksmbd_file *fp,
+				  char *buf)
+{
+	struct smb2_file_pos_info *file_info;
+	loff_t current_byte_offset;
+	unsigned short sector_size;
+	struct inode *inode;
+
+	inode = file_inode(fp->filp);
+	file_info = (struct smb2_file_pos_info *)buf;
+	current_byte_offset = le64_to_cpu(file_info->CurrentByteOffset);
+	sector_size = ksmbd_vfs_logical_sector_size(inode);
+
+	if (current_byte_offset < 0 ||
+			(fp->coption == FILE_NO_INTERMEDIATE_BUFFERING_LE &&
+			 current_byte_offset & (sector_size-1))) {
+		ksmbd_err("CurrentByteOffset is not valid : %llu\n",
+			current_byte_offset);
+		return -EINVAL;
+	}
+
+	fp->filp->f_pos = current_byte_offset;
+	return 0;
+}
+
+static int set_file_mode_info(struct ksmbd_file *fp,
+			      char *buf)
+{
+	struct smb2_file_mode_info *file_info;
+	__le32 mode;
+
+	file_info = (struct smb2_file_mode_info *)buf;
+	mode = file_info->Mode;
+
+	if ((mode & (~FILE_MODE_INFO_MASK)) ||
+			(mode & FILE_SYNCHRONOUS_IO_ALERT_LE &&
+			 mode & FILE_SYNCHRONOUS_IO_NONALERT_LE)) {
+		ksmbd_err("Mode is not valid : 0x%x\n", le32_to_cpu(mode));
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO : need to implement consideration for
+	 * FILE_SYNCHRONOUS_IO_ALERT and FILE_SYNCHRONOUS_IO_NONALERT
+	 */
+	ksmbd_vfs_set_fadvise(fp->filp, mode);
+	fp->coption = mode;
+	return 0;
+}
+
+/**
+ * smb2_set_info_file() - handler for smb2 set info command
+ * @work:	smb work containing set info command buffer
+ * @fp:		ksmbd_file pointer
+ * @info_class:	smb2 set info class
+ * @share:	ksmbd_share_config pointer
+ *
+ * Return:	0 on success, otherwise error
+ * TODO: need to implement an error handling for STATUS_INFO_LENGTH_MISMATCH
+ */
+static int smb2_set_info_file(struct ksmbd_work *work,
+			      struct ksmbd_file *fp,
+			      int info_class,
+			      char *buf,
+			      struct ksmbd_share_config *share)
+{
+	switch (info_class) {
+	case FILE_BASIC_INFORMATION:
+		return set_file_basic_info(fp, buf, share);
+
+	case FILE_ALLOCATION_INFORMATION:
+		return set_file_allocation_info(work, fp, buf);
+
+	case FILE_END_OF_FILE_INFORMATION:
+		return set_end_of_file_info(work, fp, buf);
+
+	case FILE_RENAME_INFORMATION:
+		if (!test_tree_conn_flag(work->tcon,
+		    KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				"User does not have write permission\n");
+			return -EACCES;
+		}
+		return set_rename_info(work, fp, buf);
+
+	case FILE_LINK_INFORMATION:
+		return smb2_create_link(work, work->tcon->share_conf,
+			(struct smb2_file_link_info *)buf, fp->filp,
+				work->sess->conn->local_nls);
+
+	case FILE_DISPOSITION_INFORMATION:
+		if (!test_tree_conn_flag(work->tcon,
+		    KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				"User does not have write permission\n");
+			return -EACCES;
+		}
+		return set_file_disposition_info(fp, buf);
+
+	case FILE_FULL_EA_INFORMATION:
+	{
+		if (!(fp->daccess & FILE_WRITE_EA_LE)) {
+			ksmbd_err("Not permitted to write ext  attr: 0x%x\n",
+				  fp->daccess);
+			return -EACCES;
+		}
+
+		return smb2_set_ea((struct smb2_ea_info *)buf,
+				   &fp->filp->f_path);
+	}
+
+	case FILE_POSITION_INFORMATION:
+		return set_file_position_info(fp, buf);
+
+	case FILE_MODE_INFORMATION:
+		return set_file_mode_info(fp, buf);
+	}
+
+	ksmbd_err("Unimplemented Fileinfoclass :%d\n", info_class);
+	return -EOPNOTSUPP;
+}
+
+static int smb2_set_info_sec(struct ksmbd_file *fp,
+			     int addition_info,
+			     char *buffer,
+			     int buf_len)
+{
+	struct smb_ntsd *pntsd = (struct smb_ntsd *)buffer;
+
+	fp->saccess |= FILE_SHARE_DELETE_LE;
+
+	return set_info_sec(fp->conn, fp->tcon, fp->filp->f_path.dentry, pntsd,
+			buf_len, false);
+}
+
+/**
+ * smb2_set_info() - handler for smb2 set info command handler
+ * @work:	smb work containing set info request buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_set_info(struct ksmbd_work *work)
+{
+	struct smb2_set_info_req *req;
+	struct smb2_set_info_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp;
+	int rc = 0;
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+
+	ksmbd_debug(SMB, "Received set info request\n");
+
+	rsp_org = RESPONSE_BUF(work);
+	if (work->next_smb2_rcv_hdr_off) {
+		req = REQUEST_BUF_NEXT(work);
+		rsp = RESPONSE_BUF_NEXT(work);
+		if (!HAS_FILE_ID(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %u\n",
+					work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	} else {
+		req = REQUEST_BUF(work);
+		rsp = RESPONSE_BUF(work);
+	}
+
+	if (!HAS_FILE_ID(id)) {
+		id = le64_to_cpu(req->VolatileFileId);
+		pid = le64_to_cpu(req->PersistentFileId);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
+	if (!fp) {
+		ksmbd_debug(SMB, "Invalid id for close: %u\n", id);
+		rc = -ENOENT;
+		goto err_out;
+	}
+
+	switch (req->InfoType) {
+	case SMB2_O_INFO_FILE:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
+		rc = smb2_set_info_file(work, fp, req->FileInfoClass,
+					req->Buffer, work->tcon->share_conf);
+		break;
+	case SMB2_O_INFO_SECURITY:
+		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
+		rc = smb2_set_info_sec(fp,
+			le32_to_cpu(req->AdditionalInformation), req->Buffer,
+			le32_to_cpu(req->BufferLength));
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+	}
+
+	if (rc < 0)
+		goto err_out;
+
+	rsp->StructureSize = cpu_to_le16(2);
+	inc_rfc1001_len(rsp_org, 2);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+err_out:
+	if (rc == -EACCES || rc == -EPERM)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (rc == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else if (rc == -ESHARE)
+		rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+	else if (rc == -ENOENT)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_INVALID;
+	else if (rc == -EBUSY || rc == -ENOTEMPTY)
+		rsp->hdr.Status = STATUS_DIRECTORY_NOT_EMPTY;
+	else if (rc == -EAGAIN)
+		rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+	else if (rc == -EBADF)
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+	else if (rc == -EEXIST)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_COLLISION;
+	else if (rsp->hdr.Status == 0 || rc == -EOPNOTSUPP)
+		rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	ksmbd_debug(SMB, "error while processing smb2 query rc = %d\n",
+			rc);
+	return rc;
+}
+
+/**
+ * smb2_read_pipe() - handler for smb2 read from IPC pipe
+ * @work:	smb work containing read IPC pipe command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+static noinline int smb2_read_pipe(struct ksmbd_work *work)
+{
+	int nbytes = 0, err;
+	uint64_t id;
+	struct ksmbd_rpc_command *rpc_resp;
+	struct smb2_read_req *req = REQUEST_BUF(work);
+	struct smb2_read_rsp *rsp = RESPONSE_BUF(work);
+
+	id = le64_to_cpu(req->VolatileFileId);
+
+	inc_rfc1001_len(rsp, 16);
+	rpc_resp = ksmbd_rpc_read(work->sess, id);
+	if (rpc_resp) {
+		if (rpc_resp->flags != KSMBD_RPC_OK) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		work->aux_payload_buf =
+			ksmbd_alloc_response(rpc_resp->payload_sz);
+		if (!work->aux_payload_buf) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		memcpy(work->aux_payload_buf, rpc_resp->payload,
+			rpc_resp->payload_sz);
+
+		nbytes = rpc_resp->payload_sz;
+		work->resp_hdr_sz = get_rfc1002_len(rsp) + 4;
+		work->aux_payload_sz = nbytes;
+		ksmbd_free(rpc_resp);
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 80;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp, nbytes);
+	return 0;
+
+out:
+	rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+	smb2_set_err_rsp(work);
+	ksmbd_free(rpc_resp);
+	return err;
+}
+
+static ssize_t smb2_read_rdma_channel(struct ksmbd_work *work,
+				struct smb2_read_req *req,
+				void *data_buf, size_t length)
+{
+	struct smb2_buffer_desc_v1 *desc =
+		(struct smb2_buffer_desc_v1 *)&req->Buffer[0];
+	int err;
+
+	if (work->conn->dialect == SMB30_PROT_ID
+			&& req->Channel != SMB2_CHANNEL_RDMA_V1)
+		return -EINVAL;
+
+	if (req->ReadChannelInfoOffset == 0
+		|| le16_to_cpu(req->ReadChannelInfoLength) < sizeof(*desc))
+		return -EINVAL;
+
+	work->need_invalidate_rkey =
+		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+	work->remote_key = le32_to_cpu(desc->token);
+
+	err = ksmbd_conn_rdma_write(work->conn,
+				data_buf, length,
+				le32_to_cpu(desc->token),
+				le64_to_cpu(desc->offset),
+				le32_to_cpu(desc->length));
+	if (err)
+		return err;
+
+	return length;
+}
+
+/**
+ * smb2_read() - handler for smb2 read from file
+ * @work:	smb work containing read command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_read(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_read_req *req;
+	struct smb2_read_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp;
+	loff_t offset;
+	size_t length, mincount;
+	ssize_t nbytes = 0, remain_bytes = 0;
+	int err = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe read request\n");
+		return smb2_read_pipe(work);
+	}
+
+	fp = ksmbd_lookup_fd_slow(work,
+			le64_to_cpu(req->VolatileFileId),
+			le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		return -ENOENT;
+	}
+
+	if (!(fp->daccess & (FILE_READ_DATA_LE | FILE_READ_ATTRIBUTES_LE))) {
+		ksmbd_err("Not permitted to read : 0x%x\n", fp->daccess);
+		err = -EACCES;
+		goto out;
+	}
+
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+	mincount = le32_to_cpu(req->MinimumCount);
+
+	if (length > conn->vals->max_read_size) {
+		ksmbd_debug(SMB, "limiting read size to max size(%u)\n",
+			    conn->vals->max_read_size);
+		err = -EINVAL;
+		goto out;
+	}
+
+	ksmbd_debug(SMB, "filename %s, offset %lld, len %zu\n", FP_FILENAME(fp),
+		offset, length);
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_RBUF) {
+		work->aux_payload_buf =
+			ksmbd_find_buffer(conn->vals->max_read_size);
+		work->set_read_buf = true;
+	} else {
+		work->aux_payload_buf = ksmbd_alloc_response(length);
+	}
+	if (!work->aux_payload_buf) {
+		err = nbytes;
+		goto out;
+	}
+
+	nbytes = ksmbd_vfs_read(work, fp, length, &offset);
+	if (nbytes < 0) {
+		err = nbytes;
+		goto out;
+	}
+
+	if ((nbytes == 0 && length != 0) || nbytes < mincount) {
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_RBUF)
+			ksmbd_release_buffer(AUX_PAYLOAD(work));
+		else
+			ksmbd_free_response(AUX_PAYLOAD(work));
+		INIT_AUX_PAYLOAD(work);
+		rsp->hdr.Status = STATUS_END_OF_FILE;
+		smb2_set_err_rsp(work);
+		ksmbd_fd_put(work, fp);
+		return 0;
+	}
+
+	ksmbd_debug(SMB, "nbytes %zu, offset %lld mincount %zu\n",
+						nbytes, offset, mincount);
+
+	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
+			req->Channel == SMB2_CHANNEL_RDMA_V1) {
+		/* write data to the client using rdma channel */
+		remain_bytes = smb2_read_rdma_channel(work, req,
+						AUX_PAYLOAD(work), nbytes);
+		if (server_conf.flags & KSMBD_GLOBAL_FLAG_CACHE_RBUF)
+			ksmbd_release_buffer(AUX_PAYLOAD(work));
+		else
+			ksmbd_free_response(AUX_PAYLOAD(work));
+		INIT_AUX_PAYLOAD(work);
+
+		nbytes = 0;
+		if (remain_bytes < 0) {
+			err = (int)remain_bytes;
+			goto out;
+		}
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 80;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = cpu_to_le32(remain_bytes);
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp_org, 16);
+	work->resp_hdr_sz = get_rfc1002_len(rsp_org) + 4;
+	work->aux_payload_sz = nbytes;
+	inc_rfc1001_len(rsp_org, nbytes);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+out:
+	if (err) {
+		if (err == -EISDIR)
+			rsp->hdr.Status = STATUS_INVALID_DEVICE_REQUEST;
+		else if (err == -EAGAIN)
+			rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+		else if (err == -ENOENT)
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+		else if (err == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		else if (err == -ESHARE)
+			rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+		else if (err == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+
+		smb2_set_err_rsp(work);
+	}
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * smb2_write_pipe() - handler for smb2 write on IPC pipe
+ * @work:	smb work containing write IPC pipe command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+static noinline int smb2_write_pipe(struct ksmbd_work *work)
+{
+	struct smb2_write_req *req = REQUEST_BUF(work);
+	struct smb2_write_rsp *rsp = RESPONSE_BUF(work);
+	struct ksmbd_rpc_command *rpc_resp;
+	uint64_t id = 0;
+	int err = 0, ret = 0;
+	char *data_buf;
+	size_t length;
+
+	length = le32_to_cpu(req->Length);
+	id = le64_to_cpu(req->VolatileFileId);
+
+	if (le16_to_cpu(req->DataOffset) ==
+			(offsetof(struct smb2_write_req, Buffer) - 4)) {
+		data_buf = (char *)&req->Buffer[0];
+	} else {
+		if ((le16_to_cpu(req->DataOffset) > get_rfc1002_len(req)) ||
+				(le16_to_cpu(req->DataOffset) +
+				 length > get_rfc1002_len(req))) {
+			ksmbd_err("invalid write data offset %u, smb_len %u\n",
+					le16_to_cpu(req->DataOffset),
+					get_rfc1002_len(req));
+			err = -EINVAL;
+			goto out;
+		}
+
+		data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+				le16_to_cpu(req->DataOffset));
+	}
+
+	rpc_resp = ksmbd_rpc_write(work->sess, id, data_buf, length);
+	if (rpc_resp) {
+		if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			ksmbd_free(rpc_resp);
+			smb2_set_err_rsp(work);
+			return -EOPNOTSUPP;
+		}
+		if (rpc_resp->flags != KSMBD_RPC_OK) {
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+			smb2_set_err_rsp(work);
+			ksmbd_free(rpc_resp);
+			return ret;
+		}
+		ksmbd_free(rpc_resp);
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 0;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(length);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp, 16);
+	return 0;
+out:
+	if (err) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		smb2_set_err_rsp(work);
+	}
+
+	return err;
+}
+
+static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
+			struct smb2_write_req *req, struct ksmbd_file *fp,
+			loff_t offset, size_t length, bool sync)
+{
+	struct smb2_buffer_desc_v1 *desc;
+	char *data_buf;
+	int ret;
+	ssize_t nbytes;
+
+	desc = (struct smb2_buffer_desc_v1 *)&req->Buffer[0];
+
+	if (work->conn->dialect == SMB30_PROT_ID &&
+			req->Channel != SMB2_CHANNEL_RDMA_V1)
+		return -EINVAL;
+
+	if (req->Length != 0 || req->DataOffset != 0)
+		return -EINVAL;
+
+	if (req->WriteChannelInfoOffset == 0
+		|| le16_to_cpu(req->WriteChannelInfoLength) < sizeof(*desc))
+		return -EINVAL;
+
+	work->need_invalidate_rkey =
+		(req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE);
+	work->remote_key = le32_to_cpu(desc->token);
+
+	data_buf = ksmbd_alloc_response(length);
+	if (!data_buf)
+		return -ENOMEM;
+
+	ret = ksmbd_conn_rdma_read(work->conn, data_buf, length,
+				le32_to_cpu(desc->token),
+				le64_to_cpu(desc->offset),
+				le32_to_cpu(desc->length));
+
+	if (ret < 0) {
+		ksmbd_free_response(data_buf);
+		return ret;
+	}
+
+	ret = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
+				sync, &nbytes);
+
+	ksmbd_free_response(data_buf);
+	if (ret < 0)
+		return ret;
+
+	return nbytes;
+}
+
+/**
+ * smb2_write() - handler for smb2 write from file
+ * @work:	smb work containing write command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_write(struct ksmbd_work *work)
+{
+	struct smb2_write_req *req;
+	struct smb2_write_rsp *rsp, *rsp_org;
+	struct ksmbd_file *fp = NULL;
+	loff_t offset;
+	size_t length;
+	ssize_t nbytes;
+	char *data_buf;
+	bool writethrough = false;
+	int err = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	if (test_share_config_flag(work->tcon->share_conf,
+				   KSMBD_SHARE_FLAG_PIPE)) {
+		ksmbd_debug(SMB, "IPC pipe write request\n");
+		return smb2_write_pipe(work);
+	}
+
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		err = -EACCES;
+		goto out;
+	}
+
+	fp = ksmbd_lookup_fd_slow(work,
+				le64_to_cpu(req->VolatileFileId),
+				le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		return -ENOENT;
+	}
+
+	if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_READ_ATTRIBUTES_LE))) {
+		ksmbd_err("Not permitted to write : 0x%x\n", fp->daccess);
+		err = -EACCES;
+		goto out;
+	}
+
+	offset = le64_to_cpu(req->Offset);
+	length = le32_to_cpu(req->Length);
+
+	if (length > work->conn->vals->max_write_size) {
+		ksmbd_debug(SMB, "limiting write size to max size(%u)\n",
+			    work->conn->vals->max_write_size);
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
+		writethrough = true;
+
+	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
+			req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
+
+		if (le16_to_cpu(req->DataOffset) ==
+				(offsetof(struct smb2_write_req, Buffer) - 4)) {
+			data_buf = (char *)&req->Buffer[0];
+		} else {
+			if ((le16_to_cpu(req->DataOffset) >
+					get_rfc1002_len(req)) ||
+					(le16_to_cpu(req->DataOffset) +
+					 length > get_rfc1002_len(req))) {
+				ksmbd_err("invalid write data offset %u, smb_len %u\n",
+						le16_to_cpu(req->DataOffset),
+						get_rfc1002_len(req));
+				err = -EINVAL;
+				goto out;
+			}
+
+			data_buf = (char *)(((char *)&req->hdr.ProtocolId) +
+					le16_to_cpu(req->DataOffset));
+		}
+
+		ksmbd_debug(SMB, "flags %u\n", le32_to_cpu(req->Flags));
+		if (le32_to_cpu(req->Flags) & SMB2_WRITEFLAG_WRITE_THROUGH)
+			writethrough = true;
+
+		ksmbd_debug(SMB, "filename %s, offset %lld, len %zu\n",
+			FP_FILENAME(fp), offset, length);
+		err = ksmbd_vfs_write(work, fp, data_buf, length, &offset,
+				      writethrough, &nbytes);
+		if (err < 0)
+			goto out;
+	} else {
+		/* read data from the client using rdma channel, and
+		 * write the data.
+		 */
+		nbytes = smb2_write_rdma_channel(work, req, fp, offset,
+					le32_to_cpu(req->RemainingBytes),
+					writethrough);
+		if (nbytes < 0) {
+			err = (int)nbytes;
+			goto out;
+		}
+	}
+
+	rsp->StructureSize = cpu_to_le16(17);
+	rsp->DataOffset = 0;
+	rsp->Reserved = 0;
+	rsp->DataLength = cpu_to_le32(nbytes);
+	rsp->DataRemaining = 0;
+	rsp->Reserved2 = 0;
+	inc_rfc1001_len(rsp_org, 16);
+	ksmbd_fd_put(work, fp);
+	return 0;
+
+out:
+	if (err == -EAGAIN)
+		rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+	else if (err == -ENOSPC || err == -EFBIG)
+		rsp->hdr.Status = STATUS_DISK_FULL;
+	else if (err == -ENOENT)
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+	else if (err == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (err == -ESHARE)
+		rsp->hdr.Status = STATUS_SHARING_VIOLATION;
+	else if (err == -EINVAL)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	else
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	return err;
+}
+
+/**
+ * smb2_flush() - handler for smb2 flush file - fsync
+ * @work:	smb work containing flush command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_flush(struct ksmbd_work *work)
+{
+	struct smb2_flush_req *req;
+	struct smb2_flush_rsp *rsp, *rsp_org;
+	int err;
+
+	rsp_org = RESPONSE_BUF(work);
+	WORK_BUFFERS(work, req, rsp);
+
+	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
+			le64_to_cpu(req->VolatileFileId));
+
+	err = ksmbd_vfs_fsync(work,
+			      le64_to_cpu(req->VolatileFileId),
+			      le64_to_cpu(req->PersistentFileId));
+	if (err)
+		goto out;
+
+	rsp->StructureSize = cpu_to_le16(4);
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp_org, 4);
+	return 0;
+
+out:
+	if (err) {
+		rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		smb2_set_err_rsp(work);
+	}
+
+	return err;
+}
+
+/**
+ * smb2_cancel() - handler for smb2 cancel command
+ * @work:	smb work containing cancel command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_cancel(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *hdr = REQUEST_BUF(work);
+	struct smb2_hdr *chdr;
+	struct ksmbd_work *cancel_work = NULL;
+	struct list_head *tmp;
+	int canceled = 0;
+	struct list_head *command_list;
+
+	ksmbd_debug(SMB, "smb2 cancel called on mid %llu, async flags 0x%x\n",
+		hdr->MessageId, hdr->Flags);
+
+	if (hdr->Flags & SMB2_FLAGS_ASYNC_COMMAND) {
+		command_list = &conn->async_requests;
+
+		spin_lock(&conn->request_lock);
+		list_for_each(tmp, command_list) {
+			cancel_work = list_entry(tmp, struct ksmbd_work,
+					async_request_entry);
+			chdr = REQUEST_BUF(cancel_work);
+
+			if (cancel_work->async_id !=
+					le64_to_cpu(hdr->Id.AsyncId))
+				continue;
+
+			ksmbd_debug(SMB,
+				"smb2 with AsyncId %llu cancelled command = 0x%x\n",
+				le64_to_cpu(hdr->Id.AsyncId),
+				le16_to_cpu(chdr->Command));
+			canceled = 1;
+			break;
+		}
+		spin_unlock(&conn->request_lock);
+	} else {
+		command_list = &conn->requests;
+
+		spin_lock(&conn->request_lock);
+		list_for_each(tmp, command_list) {
+			cancel_work = list_entry(tmp, struct ksmbd_work,
+					request_entry);
+			chdr = REQUEST_BUF(cancel_work);
+
+			if (chdr->MessageId != hdr->MessageId ||
+				cancel_work == work)
+				continue;
+
+			ksmbd_debug(SMB,
+				"smb2 with mid %llu cancelled command = 0x%x\n",
+				le64_to_cpu(hdr->MessageId),
+				le16_to_cpu(chdr->Command));
+			canceled = 1;
+			break;
+		}
+		spin_unlock(&conn->request_lock);
+	}
+
+	if (canceled) {
+		cancel_work->state = KSMBD_WORK_CANCELLED;
+		if (cancel_work->cancel_fn)
+			cancel_work->cancel_fn(cancel_work->cancel_argv);
+	}
+
+	/* For SMB2_CANCEL command itself send no response*/
+	work->send_no_response = 1;
+	return 0;
+}
+
+struct file_lock *smb_flock_init(struct file *f)
+{
+	struct file_lock *fl;
+
+	fl = locks_alloc_lock();
+	if (!fl)
+		goto out;
+
+	locks_init_lock(fl);
+
+	fl->fl_owner = f;
+	fl->fl_pid = current->tgid;
+	fl->fl_file = f;
+	fl->fl_flags = FL_POSIX;
+	fl->fl_ops = NULL;
+	fl->fl_lmops = NULL;
+
+out:
+	return fl;
+}
+
+static int smb2_set_flock_flags(struct file_lock *flock, int flags)
+{
+	int cmd = -EINVAL;
+
+	/* Checking for wrong flag combination during lock request*/
+	switch (flags) {
+	case SMB2_LOCKFLAG_SHARED:
+		ksmbd_debug(SMB, "received shared request\n");
+		cmd = F_SETLKW;
+		flock->fl_type = F_RDLCK;
+		flock->fl_flags |= FL_SLEEP;
+		break;
+	case SMB2_LOCKFLAG_EXCLUSIVE:
+		ksmbd_debug(SMB, "received exclusive request\n");
+		cmd = F_SETLKW;
+		flock->fl_type = F_WRLCK;
+		flock->fl_flags |= FL_SLEEP;
+		break;
+	case SMB2_LOCKFLAG_SHARED|SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
+		ksmbd_debug(SMB,
+			"received shared & fail immediately request\n");
+		cmd = F_SETLK;
+		flock->fl_type = F_RDLCK;
+		break;
+	case SMB2_LOCKFLAG_EXCLUSIVE|SMB2_LOCKFLAG_FAIL_IMMEDIATELY:
+		ksmbd_debug(SMB,
+			"received exclusive & fail immediately request\n");
+		cmd = F_SETLK;
+		flock->fl_type = F_WRLCK;
+		break;
+	case SMB2_LOCKFLAG_UNLOCK:
+		ksmbd_debug(SMB, "received unlock request\n");
+		flock->fl_type = F_UNLCK;
+		cmd = 0;
+		break;
+	}
+
+	return cmd;
+}
+
+static struct ksmbd_lock *smb2_lock_init(struct file_lock *flock,
+	unsigned int cmd, int flags, struct list_head *lock_list)
+{
+	struct ksmbd_lock *lock;
+
+	lock = kzalloc(sizeof(struct ksmbd_lock), GFP_KERNEL);
+	if (!lock)
+		return NULL;
+
+	lock->cmd = cmd;
+	lock->fl = flock;
+	lock->start = flock->fl_start;
+	lock->end = flock->fl_end;
+	lock->flags = flags;
+	if (lock->start == lock->end)
+		lock->zero_len = 1;
+	INIT_LIST_HEAD(&lock->llist);
+	INIT_LIST_HEAD(&lock->glist);
+	list_add_tail(&lock->llist, lock_list);
+
+	return lock;
+}
+
+static void smb2_remove_blocked_lock(void **argv)
+{
+	struct file_lock *flock = (struct file_lock *)argv[0];
+
+	ksmbd_vfs_posix_lock_unblock(flock);
+	wake_up(&flock->fl_wait);
+}
+
+static inline bool lock_defer_pending(struct file_lock *fl)
+{
+	/* check pending lock waiters */
+	return waitqueue_active(&fl->fl_wait);
+}
+
+/**
+ * smb2_lock() - handler for smb2 file lock command
+ * @work:	smb work containing lock command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_lock(struct ksmbd_work *work)
+{
+	struct smb2_lock_req *req = REQUEST_BUF(work);
+	struct smb2_lock_rsp *rsp = RESPONSE_BUF(work);
+	struct smb2_lock_element *lock_ele;
+	struct ksmbd_file *fp = NULL;
+	struct file_lock *flock = NULL;
+	struct file *filp = NULL;
+	int lock_count;
+	int flags = 0;
+	int cmd = 0;
+	int err = 0, i;
+	uint64_t lock_length;
+	struct ksmbd_lock *smb_lock = NULL, *cmp_lock, *tmp;
+	int nolock = 0;
+	LIST_HEAD(lock_list);
+	LIST_HEAD(rollback_list);
+	int prior_lock = 0;
+
+	ksmbd_debug(SMB, "Received lock request\n");
+	fp = ksmbd_lookup_fd_slow(work,
+				le64_to_cpu(req->VolatileFileId),
+				le64_to_cpu(req->PersistentFileId));
+	if (!fp) {
+		ksmbd_debug(SMB, "Invalid file id for lock : %llu\n",
+				le64_to_cpu(req->VolatileFileId));
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		goto out2;
+	}
+
+	filp = fp->filp;
+	lock_count = le16_to_cpu(req->LockCount);
+	lock_ele = req->locks;
+
+	ksmbd_debug(SMB, "lock count is %d\n", lock_count);
+	if (!lock_count)  {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		goto out2;
+	}
+
+	for (i = 0; i < lock_count; i++) {
+		flags = le32_to_cpu(lock_ele[i].Flags);
+
+		flock = smb_flock_init(filp);
+		if (!flock) {
+			rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+			goto out;
+		}
+
+		cmd = smb2_set_flock_flags(flock, flags);
+
+		flock->fl_start = le64_to_cpu(lock_ele[i].Offset);
+		if (flock->fl_start > OFFSET_MAX) {
+			ksmbd_err("Invalid lock range requested\n");
+			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			goto out;
+		}
+
+		lock_length = le64_to_cpu(lock_ele[i].Length);
+		if (lock_length > 0) {
+			if (lock_length >
+					OFFSET_MAX - flock->fl_start) {
+				ksmbd_debug(SMB,
+					"Invalid lock range requested\n");
+				lock_length = OFFSET_MAX - flock->fl_start;
+				rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+				goto out;
+			}
+		} else
+			lock_length = 0;
+
+		flock->fl_end = flock->fl_start + lock_length;
+
+		if (flock->fl_end < flock->fl_start) {
+			ksmbd_debug(SMB,
+				"the end offset(%llx) is smaller than the start offset(%llx)\n",
+				flock->fl_end, flock->fl_start);
+			rsp->hdr.Status = STATUS_INVALID_LOCK_RANGE;
+			goto out;
+		}
+
+		/* Check conflict locks in one request */
+		list_for_each_entry(cmp_lock, &lock_list, llist) {
+			if (cmp_lock->fl->fl_start <= flock->fl_start &&
+					cmp_lock->fl->fl_end >= flock->fl_end) {
+				if (cmp_lock->fl->fl_type != F_UNLCK &&
+					flock->fl_type != F_UNLCK) {
+					ksmbd_err("conflict two locks in one request\n");
+					rsp->hdr.Status =
+						STATUS_INVALID_PARAMETER;
+					goto out;
+				}
+			}
+		}
+
+		smb_lock = smb2_lock_init(flock, cmd, flags, &lock_list);
+		if (!smb_lock) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+	}
+
+	list_for_each_entry_safe(smb_lock, tmp, &lock_list, llist) {
+		if (smb_lock->cmd < 0) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		if (!(smb_lock->flags & SMB2_LOCKFLAG_MASK)) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		if ((prior_lock & (SMB2_LOCKFLAG_EXCLUSIVE |
+				SMB2_LOCKFLAG_SHARED) &&
+			smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) ||
+			(prior_lock == SMB2_LOCKFLAG_UNLOCK &&
+				 !(smb_lock->flags & SMB2_LOCKFLAG_UNLOCK))) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		prior_lock = smb_lock->flags;
+
+		if (!(smb_lock->flags & SMB2_LOCKFLAG_UNLOCK) &&
+			!(smb_lock->flags & SMB2_LOCKFLAG_FAIL_IMMEDIATELY))
+			goto no_check_gl;
+
+		nolock = 1;
+		/* check locks in global list */
+		list_for_each_entry(cmp_lock, &global_lock_list, glist) {
+			if (file_inode(cmp_lock->fl->fl_file) !=
+				file_inode(smb_lock->fl->fl_file))
+				continue;
+
+			if (smb_lock->fl->fl_type == F_UNLCK) {
+				if (cmp_lock->fl->fl_file ==
+					smb_lock->fl->fl_file &&
+					cmp_lock->start == smb_lock->start &&
+					cmp_lock->end == smb_lock->end &&
+					!lock_defer_pending(cmp_lock->fl)) {
+					nolock = 0;
+					locks_free_lock(cmp_lock->fl);
+					list_del(&cmp_lock->glist);
+					kfree(cmp_lock);
+					break;
+				}
+				continue;
+			}
+
+			if (cmp_lock->fl->fl_file == smb_lock->fl->fl_file) {
+				if (smb_lock->flags & SMB2_LOCKFLAG_SHARED)
+					continue;
+			} else {
+				if (cmp_lock->flags & SMB2_LOCKFLAG_SHARED)
+					continue;
+			}
+
+			/* check zero byte lock range */
+			if (cmp_lock->zero_len && !smb_lock->zero_len &&
+				cmp_lock->start > smb_lock->start &&
+				cmp_lock->start < smb_lock->end) {
+				ksmbd_err("previous lock conflict with zero byte lock range\n");
+				rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+					goto out;
+			}
+
+			if (smb_lock->zero_len && !cmp_lock->zero_len &&
+				smb_lock->start > cmp_lock->start &&
+				smb_lock->start < cmp_lock->end) {
+				ksmbd_err("current lock conflict with zero byte lock range\n");
+				rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+					goto out;
+			}
+
+			if (((cmp_lock->start <= smb_lock->start &&
+				cmp_lock->end > smb_lock->start) ||
+				(cmp_lock->start < smb_lock->end &&
+				cmp_lock->end >= smb_lock->end)) &&
+				!cmp_lock->zero_len && !smb_lock->zero_len) {
+				ksmbd_err("Not allow lock operation on exclusive lock range\n");
+				rsp->hdr.Status =
+					STATUS_LOCK_NOT_GRANTED;
+				goto out;
+			}
+		}
+
+		if (smb_lock->fl->fl_type == F_UNLCK && nolock) {
+			ksmbd_err("Try to unlock nolocked range\n");
+			rsp->hdr.Status = STATUS_RANGE_NOT_LOCKED;
+			goto out;
+		}
+
+no_check_gl:
+		if (smb_lock->zero_len) {
+			err = 0;
+			goto skip;
+		}
+
+		flock = smb_lock->fl;
+		list_del(&smb_lock->llist);
+retry:
+		err = ksmbd_vfs_lock(filp, smb_lock->cmd, flock);
+skip:
+		if (flags & SMB2_LOCKFLAG_UNLOCK) {
+			if (!err)
+				ksmbd_debug(SMB, "File unlocked\n");
+			else if (err == -ENOENT) {
+				rsp->hdr.Status = STATUS_NOT_LOCKED;
+				goto out;
+			}
+			locks_free_lock(flock);
+			kfree(smb_lock);
+		} else {
+			if (err == FILE_LOCK_DEFERRED) {
+				void **argv;
+
+				ksmbd_debug(SMB,
+					"would have to wait for getting lock\n");
+				list_add_tail(&smb_lock->glist,
+					&global_lock_list);
+				list_add(&smb_lock->llist, &rollback_list);
+
+				argv = kmalloc(sizeof(void *), GFP_KERNEL);
+				if (!argv) {
+					err = -ENOMEM;
+					goto out;
+				}
+				argv[0] = flock;
+
+				err = setup_async_work(work,
+					smb2_remove_blocked_lock, argv);
+				if (err) {
+					rsp->hdr.Status =
+					   STATUS_INSUFFICIENT_RESOURCES;
+					goto out;
+				}
+				spin_lock(&fp->f_lock);
+				list_add(&work->fp_entry, &fp->blocked_works);
+				spin_unlock(&fp->f_lock);
+
+				smb2_send_interim_resp(work, STATUS_PENDING);
+
+				err = ksmbd_vfs_posix_lock_wait(flock);
+
+				if (!WORK_ACTIVE(work)) {
+					list_del(&smb_lock->llist);
+					list_del(&smb_lock->glist);
+					locks_free_lock(flock);
+
+					if (WORK_CANCELLED(work)) {
+						spin_lock(&fp->f_lock);
+						list_del(&work->fp_entry);
+						spin_unlock(&fp->f_lock);
+						rsp->hdr.Status =
+							STATUS_CANCELLED;
+						kfree(smb_lock);
+						smb2_send_interim_resp(work,
+							STATUS_CANCELLED);
+						work->send_no_response = 1;
+						goto out;
+					}
+					init_smb2_rsp_hdr(work);
+					smb2_set_err_rsp(work);
+					rsp->hdr.Status =
+						STATUS_RANGE_NOT_LOCKED;
+					kfree(smb_lock);
+					goto out2;
+				}
+
+				list_del(&smb_lock->llist);
+				list_del(&smb_lock->glist);
+				spin_lock(&fp->f_lock);
+				list_del(&work->fp_entry);
+				spin_unlock(&fp->f_lock);
+				goto retry;
+			} else if (!err) {
+				list_add_tail(&smb_lock->glist,
+					&global_lock_list);
+				list_add(&smb_lock->llist, &rollback_list);
+				ksmbd_debug(SMB, "successful in taking lock\n");
+			} else {
+				rsp->hdr.Status = STATUS_LOCK_NOT_GRANTED;
+				goto out;
+			}
+		}
+	}
+
+	if (atomic_read(&fp->f_ci->op_count) > 1)
+		smb_break_all_oplock(work, fp);
+
+	rsp->StructureSize = cpu_to_le16(4);
+	ksmbd_debug(SMB, "successful in taking lock\n");
+	rsp->hdr.Status = STATUS_SUCCESS;
+	rsp->Reserved = 0;
+	inc_rfc1001_len(rsp, 4);
+	ksmbd_fd_put(work, fp);
+	return err;
+
+out:
+	list_for_each_entry_safe(smb_lock, tmp, &lock_list, llist) {
+		locks_free_lock(smb_lock->fl);
+		list_del(&smb_lock->llist);
+		kfree(smb_lock);
+	}
+
+	list_for_each_entry_safe(smb_lock, tmp, &rollback_list, llist) {
+		struct file_lock *rlock = NULL;
+
+		rlock = smb_flock_init(filp);
+		rlock->fl_type = F_UNLCK;
+		rlock->fl_start = smb_lock->start;
+		rlock->fl_end = smb_lock->end;
+
+		err = ksmbd_vfs_lock(filp, 0, rlock);
+		if (err)
+			ksmbd_err("rollback unlock fail : %d\n", err);
+		list_del(&smb_lock->llist);
+		list_del(&smb_lock->glist);
+		locks_free_lock(smb_lock->fl);
+		locks_free_lock(rlock);
+		kfree(smb_lock);
+	}
+out2:
+	ksmbd_debug(SMB, "failed in taking lock(flags : %x)\n", flags);
+	smb2_set_err_rsp(work);
+	ksmbd_fd_put(work, fp);
+	return 0;
+}
+
+static int fsctl_copychunk(struct ksmbd_work *work,
+				struct smb2_ioctl_req *req,
+				struct smb2_ioctl_rsp *rsp)
+{
+	struct copychunk_ioctl_req *ci_req;
+	struct copychunk_ioctl_rsp *ci_rsp;
+	struct ksmbd_file *src_fp = NULL, *dst_fp = NULL;
+	struct srv_copychunk *chunks;
+	unsigned int i, chunk_count, chunk_count_written = 0;
+	unsigned int chunk_size_written = 0;
+	loff_t total_size_written = 0;
+	int ret, cnt_code;
+
+	cnt_code = le32_to_cpu(req->CntCode);
+	ci_req = (struct copychunk_ioctl_req *)&req->Buffer[0];
+	ci_rsp = (struct copychunk_ioctl_rsp *)&rsp->Buffer[0];
+
+	rsp->VolatileFileId = req->VolatileFileId;
+	rsp->PersistentFileId = req->PersistentFileId;
+	ci_rsp->ChunksWritten = cpu_to_le32(
+			ksmbd_server_side_copy_max_chunk_count());
+	ci_rsp->ChunkBytesWritten = cpu_to_le32(
+			ksmbd_server_side_copy_max_chunk_size());
+	ci_rsp->TotalBytesWritten = cpu_to_le32(
+			ksmbd_server_side_copy_max_total_size());
+
+	chunks = (struct srv_copychunk *)&ci_req->Chunks[0];
+	chunk_count = le32_to_cpu(ci_req->ChunkCount);
+	total_size_written = 0;
+
+	/* verify the SRV_COPYCHUNK_COPY packet */
+	if (chunk_count > ksmbd_server_side_copy_max_chunk_count() ||
+			le32_to_cpu(req->InputCount) <
+			offsetof(struct copychunk_ioctl_req, Chunks) +
+			chunk_count * sizeof(struct srv_copychunk)) {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		return -EINVAL;
+	}
+
+	for (i = 0; i < chunk_count; i++) {
+		if (le32_to_cpu(chunks[i].Length) == 0 ||
+				le32_to_cpu(chunks[i].Length) >
+				ksmbd_server_side_copy_max_chunk_size())
+			break;
+		total_size_written += le32_to_cpu(chunks[i].Length);
+	}
+	if (i < chunk_count || total_size_written >
+			ksmbd_server_side_copy_max_total_size()) {
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		return -EINVAL;
+	}
+
+	src_fp = ksmbd_lookup_foreign_fd(work,
+			le64_to_cpu(ci_req->ResumeKey[0]));
+	dst_fp = ksmbd_lookup_fd_slow(work,
+				 le64_to_cpu(req->VolatileFileId),
+				 le64_to_cpu(req->PersistentFileId));
+
+	ret = -EINVAL;
+	if (!src_fp || src_fp->persistent_id !=
+			le64_to_cpu(ci_req->ResumeKey[1])) {
+		rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+		goto out;
+	}
+	if (!dst_fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		goto out;
+	}
+
+	/*
+	 * FILE_READ_DATA should only be included in
+	 * the FSCTL_COPYCHUNK case
+	 */
+	if (cnt_code == FSCTL_COPYCHUNK && !(dst_fp->daccess &
+			(FILE_READ_DATA_LE | FILE_GENERIC_READ_LE))) {
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		goto out;
+	}
+
+	ret = ksmbd_vfs_copy_file_ranges(work, src_fp, dst_fp,
+			chunks, chunk_count,
+			&chunk_count_written, &chunk_size_written,
+			&total_size_written);
+	if (ret < 0) {
+		if (ret == -EACCES)
+			rsp->hdr.Status = STATUS_ACCESS_DENIED;
+		if (ret == -EAGAIN)
+			rsp->hdr.Status = STATUS_FILE_LOCK_CONFLICT;
+		else if (ret == -EBADF)
+			rsp->hdr.Status = STATUS_INVALID_HANDLE;
+		else if (ret == -EFBIG || ret == -ENOSPC)
+			rsp->hdr.Status = STATUS_DISK_FULL;
+		else if (ret == -EINVAL)
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		else if (ret == -EISDIR)
+			rsp->hdr.Status = STATUS_FILE_IS_A_DIRECTORY;
+		else if (ret == -E2BIG)
+			rsp->hdr.Status = STATUS_INVALID_VIEW_SIZE;
+		else
+			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+	}
+
+	ci_rsp->ChunksWritten = cpu_to_le32(chunk_count_written);
+	ci_rsp->ChunkBytesWritten = cpu_to_le32(chunk_size_written);
+	ci_rsp->TotalBytesWritten = cpu_to_le32(total_size_written);
+out:
+	ksmbd_fd_put(work, src_fp);
+	ksmbd_fd_put(work, dst_fp);
+	return ret;
+}
+
+static __be32 idev_ipv4_address(struct in_device *idev)
+{
+	__be32 addr = 0;
+
+	struct in_ifaddr *ifa;
+
+	rcu_read_lock();
+	in_dev_for_each_ifa_rcu(ifa, idev) {
+		if (ifa->ifa_flags & IFA_F_SECONDARY)
+			continue;
+
+		addr = ifa->ifa_address;
+		break;
+	}
+	rcu_read_unlock();
+	return addr;
+}
+
+static int fsctl_query_iface_info_ioctl(struct ksmbd_conn *conn,
+				  struct smb2_ioctl_req *req,
+				  struct smb2_ioctl_rsp *rsp)
+{
+	struct network_interface_info_ioctl_rsp *nii_rsp = NULL;
+	int nbytes = 0;
+	struct net_device *netdev;
+	struct sockaddr_storage_rsp *sockaddr_storage;
+	unsigned int flags;
+	unsigned long long speed;
+
+	rtnl_lock();
+	for_each_netdev(&init_net, netdev) {
+		if (unlikely(!netdev)) {
+			rtnl_unlock();
+			return -EINVAL;
+		}
+
+		if (netdev->type == ARPHRD_LOOPBACK)
+			continue;
+
+		flags = dev_get_flags(netdev);
+		if (!(flags & IFF_RUNNING))
+			continue;
+
+		nii_rsp = (struct network_interface_info_ioctl_rsp *)
+				&rsp->Buffer[nbytes];
+		nii_rsp->IfIndex = cpu_to_le32(netdev->ifindex);
+
+		/* TODO: specify the RDMA capabilities */
+		if (netdev->num_tx_queues > 1)
+			nii_rsp->Capability = cpu_to_le32(RSS_CAPABLE);
+		else
+			nii_rsp->Capability = 0;
+
+		nii_rsp->Next = cpu_to_le32(152);
+		nii_rsp->Reserved = 0;
+
+		if (netdev->ethtool_ops->get_link_ksettings) {
+			struct ethtool_link_ksettings cmd;
+
+			netdev->ethtool_ops->get_link_ksettings(netdev, &cmd);
+			speed = cmd.base.speed;
+		} else {
+			ksmbd_err("%s %s %s\n",
+				  netdev->name,
+				  "speed is unknown,",
+				  "defaulting to 1Gb/sec");
+			speed = SPEED_1000;
+		}
+
+		speed *= 1000000;
+		nii_rsp->LinkSpeed = cpu_to_le64(speed);
+
+		sockaddr_storage = (struct sockaddr_storage_rsp *)
+					nii_rsp->SockAddr_Storage;
+		memset(sockaddr_storage, 0, 128);
+
+		if (conn->peer_addr.ss_family == PF_INET) {
+			struct in_device *idev;
+
+			sockaddr_storage->Family = cpu_to_le16(INTERNETWORK);
+			sockaddr_storage->addr4.Port = 0;
+
+			idev = __in_dev_get_rtnl(netdev);
+			if (!idev)
+				continue;
+			sockaddr_storage->addr4.IPv4address =
+						idev_ipv4_address(idev);
+		} else {
+			struct inet6_dev *idev6;
+			struct inet6_ifaddr *ifa;
+			__u8 *ipv6_addr = sockaddr_storage->addr6.IPv6address;
+
+			sockaddr_storage->Family = cpu_to_le16(INTERNETWORKV6);
+			sockaddr_storage->addr6.Port = 0;
+			sockaddr_storage->addr6.FlowInfo = 0;
+
+			idev6 = __in6_dev_get(netdev);
+			if (!idev6)
+				continue;
+
+			list_for_each_entry(ifa, &idev6->addr_list, if_list) {
+				if (ifa->flags & (IFA_F_TENTATIVE |
+							IFA_F_DEPRECATED))
+					continue;
+				memcpy(ipv6_addr, ifa->addr.s6_addr, 16);
+				break;
+			}
+			sockaddr_storage->addr6.ScopeId = 0;
+		}
+
+		nbytes += sizeof(struct network_interface_info_ioctl_rsp);
+	}
+	rtnl_unlock();
+
+	/* zero if this is last one */
+	if (nii_rsp)
+		nii_rsp->Next = 0;
+
+	if (!nbytes) {
+		rsp->hdr.Status = STATUS_BUFFER_TOO_SMALL;
+		return -EINVAL;
+	}
+
+	rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
+	rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+	return nbytes;
+}
+
+
+static int fsctl_validate_negotiate_info(struct ksmbd_conn *conn,
+	struct validate_negotiate_info_req *neg_req,
+	struct validate_negotiate_info_rsp *neg_rsp)
+{
+	int ret = 0;
+	int dialect;
+
+	dialect = ksmbd_lookup_dialect_by_id(neg_req->Dialects,
+			neg_req->DialectCount);
+	if (dialect == BAD_PROT_ID || dialect != conn->dialect) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (strncmp(neg_req->Guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (le16_to_cpu(neg_req->SecurityMode) != conn->cli_sec_mode) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (le32_to_cpu(neg_req->Capabilities) != conn->cli_cap) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	neg_rsp->Capabilities = cpu_to_le32(conn->vals->capabilities);
+	memset(neg_rsp->Guid, 0, SMB2_CLIENT_GUID_SIZE);
+	neg_rsp->SecurityMode = cpu_to_le16(conn->srv_sec_mode);
+	neg_rsp->Dialect = cpu_to_le16(conn->dialect);
+err_out:
+	return ret;
+}
+
+static int fsctl_query_allocated_ranges(struct ksmbd_work *work, uint64_t id,
+	struct file_allocated_range_buffer *qar_req,
+	struct file_allocated_range_buffer *qar_rsp,
+	int in_count, int *out_count)
+{
+	struct ksmbd_file *fp;
+	loff_t start, length;
+	int ret = 0;
+
+	*out_count = 0;
+	if (in_count == 0)
+		return -EINVAL;
+
+	fp = ksmbd_lookup_fd_fast(work, id);
+	if (!fp)
+		return -ENOENT;
+
+	start = le64_to_cpu(qar_req->file_offset);
+	length = le64_to_cpu(qar_req->length);
+
+	ret = ksmbd_vfs_fqar_lseek(fp, start, length,
+			qar_rsp, in_count, out_count);
+	if (ret && ret != -E2BIG)
+		*out_count = 0;
+
+	ksmbd_fd_put(work, fp);
+	return ret;
+}
+
+static int fsctl_pipe_transceive(struct ksmbd_work *work, uint64_t id,
+	int out_buf_len, struct smb2_ioctl_req *req, struct smb2_ioctl_rsp *rsp)
+{
+	struct ksmbd_rpc_command *rpc_resp;
+	char *data_buf = (char *)&req->Buffer[0];
+	int nbytes = 0;
+
+	rpc_resp = ksmbd_rpc_ioctl(work->sess, id,
+			data_buf,
+			le32_to_cpu(req->InputCount));
+	if (rpc_resp) {
+		if (rpc_resp->flags == KSMBD_RPC_SOME_NOT_MAPPED) {
+			/*
+			 * set STATUS_SOME_NOT_MAPPED response
+			 * for unknown domain sid.
+			 */
+			rsp->hdr.Status = STATUS_SOME_NOT_MAPPED;
+		} else if (rpc_resp->flags == KSMBD_RPC_ENOTIMPLEMENTED) {
+			rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+			goto out;
+		} else if (rpc_resp->flags != KSMBD_RPC_OK) {
+			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+			goto out;
+		}
+
+		nbytes = rpc_resp->payload_sz;
+		if (rpc_resp->payload_sz > out_buf_len) {
+			rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+			nbytes = out_buf_len;
+		}
+
+		if (!rpc_resp->payload_sz) {
+			rsp->hdr.Status =
+				STATUS_UNEXPECTED_IO_ERROR;
+			goto out;
+		}
+
+		memcpy((char *)rsp->Buffer, rpc_resp->payload, nbytes);
+	}
+out:
+	ksmbd_free(rpc_resp);
+	return nbytes;
+}
+
+static inline int fsctl_set_sparse(struct ksmbd_work *work, uint64_t id,
+	struct file_sparse *sparse)
+{
+	struct ksmbd_file *fp;
+	int ret = 0;
+	__le32 old_fattr;
+
+	fp = ksmbd_lookup_fd_fast(work, id);
+	if (!fp)
+		return -ENOENT;
+
+	old_fattr = fp->f_ci->m_fattr;
+	if (sparse->SetSparse)
+		fp->f_ci->m_fattr |= ATTR_SPARSE_FILE_LE;
+	else
+		fp->f_ci->m_fattr &= ~ATTR_SPARSE_FILE_LE;
+
+	if (fp->f_ci->m_fattr != old_fattr &&
+			test_share_config_flag(work->tcon->share_conf,
+				KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		struct xattr_dos_attrib da;
+
+		ret = ksmbd_vfs_get_dos_attrib_xattr(fp->filp->f_path.dentry, &da);
+		if (ret <= 0)
+			goto out;
+
+		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		ret = ksmbd_vfs_set_dos_attrib_xattr(fp->filp->f_path.dentry, &da);
+		if (ret)
+			fp->f_ci->m_fattr = old_fattr;
+	}
+
+out:
+	ksmbd_fd_put(work, fp);
+	return ret;
+}
+
+static int fsctl_request_resume_key(struct ksmbd_work *work,
+	struct smb2_ioctl_req *req, struct resume_key_ioctl_rsp *key_rsp)
+{
+	struct ksmbd_file *fp;
+
+	fp = ksmbd_lookup_fd_slow(work,
+			le64_to_cpu(req->VolatileFileId),
+			le64_to_cpu(req->PersistentFileId));
+	if (!fp)
+		return -ENOENT;
+
+	memset(key_rsp, 0, sizeof(*key_rsp));
+	key_rsp->ResumeKey[0] = req->VolatileFileId;
+	key_rsp->ResumeKey[1] = req->PersistentFileId;
+	ksmbd_fd_put(work, fp);
+
+	return 0;
+}
+
+/**
+ * smb2_ioctl() - handler for smb2 ioctl command
+ * @work:	smb work containing ioctl command buffer
+ *
+ * Return:	0 on success, otherwise error
+ */
+int smb2_ioctl(struct ksmbd_work *work)
+{
+	struct smb2_ioctl_req *req;
+	struct smb2_ioctl_rsp *rsp, *rsp_org;
+	int cnt_code, nbytes = 0;
+	int out_buf_len;
+	uint64_t id = KSMBD_NO_FID;
+	struct ksmbd_conn *conn = work->conn;
+	int ret = 0;
+
+	rsp_org = RESPONSE_BUF(work);
+	if (work->next_smb2_rcv_hdr_off) {
+		req = REQUEST_BUF_NEXT(work);
+		rsp = RESPONSE_BUF_NEXT(work);
+		if (!HAS_FILE_ID(le64_to_cpu(req->VolatileFileId))) {
+			ksmbd_debug(SMB, "Compound request set FID = %u\n",
+					work->compound_fid);
+			id = work->compound_fid;
+		}
+	} else {
+		req = REQUEST_BUF(work);
+		rsp = RESPONSE_BUF(work);
+	}
+
+	if (!HAS_FILE_ID(id))
+		id = le64_to_cpu(req->VolatileFileId);
+
+	if (req->Flags != cpu_to_le32(SMB2_0_IOCTL_IS_FSCTL)) {
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+		goto out;
+	}
+
+	cnt_code = le32_to_cpu(req->CntCode);
+	out_buf_len = le32_to_cpu(req->MaxOutputResponse);
+	out_buf_len = min(KSMBD_IPC_MAX_PAYLOAD, out_buf_len);
+
+	switch (cnt_code) {
+	case FSCTL_DFS_GET_REFERRALS:
+	case FSCTL_DFS_GET_REFERRALS_EX:
+		/* Not support DFS yet */
+		rsp->hdr.Status = STATUS_FS_DRIVER_REQUIRED;
+		goto out;
+	case FSCTL_CREATE_OR_GET_OBJECT_ID:
+	{
+		struct file_object_buf_type1_ioctl_rsp *obj_buf;
+
+		nbytes = sizeof(struct file_object_buf_type1_ioctl_rsp);
+		obj_buf = (struct file_object_buf_type1_ioctl_rsp *)
+			&rsp->Buffer[0];
+
+		/*
+		 * TODO: This is dummy implementation to pass smbtorture
+		 * Need to check correct response later
+		 */
+		memset(obj_buf->ObjectId, 0x0, 16);
+		memset(obj_buf->BirthVolumeId, 0x0, 16);
+		memset(obj_buf->BirthObjectId, 0x0, 16);
+		memset(obj_buf->DomainId, 0x0, 16);
+
+		break;
+	}
+	case FSCTL_PIPE_TRANSCEIVE:
+		nbytes = fsctl_pipe_transceive(work, id, out_buf_len, req, rsp);
+		break;
+	case FSCTL_VALIDATE_NEGOTIATE_INFO:
+		if (conn->dialect < SMB30_PROT_ID) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		ret = fsctl_validate_negotiate_info(conn,
+			(struct validate_negotiate_info_req *)&req->Buffer[0],
+			(struct validate_negotiate_info_rsp *)&rsp->Buffer[0]);
+		if (ret < 0)
+			goto out;
+
+		nbytes = sizeof(struct validate_negotiate_info_rsp);
+		rsp->PersistentFileId = cpu_to_le64(SMB2_NO_FID);
+		rsp->VolatileFileId = cpu_to_le64(SMB2_NO_FID);
+		break;
+	case FSCTL_QUERY_NETWORK_INTERFACE_INFO:
+		nbytes = fsctl_query_iface_info_ioctl(conn, req, rsp);
+		if (nbytes < 0)
+			goto out;
+		break;
+	case FSCTL_REQUEST_RESUME_KEY:
+		if (out_buf_len < sizeof(struct resume_key_ioctl_rsp)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = fsctl_request_resume_key(work, req,
+			(struct resume_key_ioctl_rsp *)&rsp->Buffer[0]);
+		if (ret < 0)
+			goto out;
+		rsp->PersistentFileId = req->PersistentFileId;
+		rsp->VolatileFileId = req->VolatileFileId;
+		nbytes = sizeof(struct resume_key_ioctl_rsp);
+		break;
+	case FSCTL_COPYCHUNK:
+	case FSCTL_COPYCHUNK_WRITE:
+		if (!test_tree_conn_flag(work->tcon,
+		    KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				"User does not have write permission\n");
+			ret = -EACCES;
+			goto out;
+		}
+
+		if (out_buf_len < sizeof(struct copychunk_ioctl_rsp)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		nbytes = sizeof(struct copychunk_ioctl_rsp);
+		fsctl_copychunk(work, req, rsp);
+		break;
+	case FSCTL_SET_SPARSE:
+		ret = fsctl_set_sparse(work, id,
+			(struct file_sparse *)&req->Buffer[0]);
+		if (ret < 0)
+			goto out;
+		break;
+	case FSCTL_SET_ZERO_DATA:
+	{
+		struct file_zero_data_information *zero_data;
+		struct ksmbd_file *fp;
+		loff_t off, len;
+
+		if (!test_tree_conn_flag(work->tcon,
+		    KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+			ksmbd_debug(SMB,
+				"User does not have write permission\n");
+			ret = -EACCES;
+			goto out;
+		}
+
+		zero_data =
+			(struct file_zero_data_information *)&req->Buffer[0];
+
+		fp = ksmbd_lookup_fd_fast(work, id);
+		if (!fp) {
+			ret = -ENOENT;
+			goto out;
+		}
+
+		off = le64_to_cpu(zero_data->FileOffset);
+		len = le64_to_cpu(zero_data->BeyondFinalZero) - off;
+
+		ret = ksmbd_vfs_zero_data(work, fp, off, len);
+		ksmbd_fd_put(work, fp);
+		if (ret < 0)
+			goto out;
+		break;
+	}
+	case FSCTL_QUERY_ALLOCATED_RANGES:
+		ret = fsctl_query_allocated_ranges(work, id,
+			(struct file_allocated_range_buffer *)&req->Buffer[0],
+			(struct file_allocated_range_buffer *)&rsp->Buffer[0],
+			out_buf_len /
+			sizeof(struct file_allocated_range_buffer), &nbytes);
+		if (ret == -E2BIG) {
+			rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
+		} else if (ret < 0) {
+			nbytes = 0;
+			goto out;
+		}
+
+		nbytes *= sizeof(struct file_allocated_range_buffer);
+		break;
+	case FSCTL_GET_REPARSE_POINT:
+	{
+		struct reparse_data_buffer *reparse_ptr;
+		struct ksmbd_file *fp;
+
+		reparse_ptr = (struct reparse_data_buffer *)&rsp->Buffer[0];
+		fp = ksmbd_lookup_fd_fast(work, id);
+		if (!fp) {
+			ksmbd_err("not found fp!!\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		reparse_ptr->ReparseTag =
+			smb2_get_reparse_tag_special_file(FP_INODE(fp)->i_mode);
+		reparse_ptr->ReparseDataLength = 0;
+		ksmbd_fd_put(work, fp);
+		nbytes = sizeof(struct reparse_data_buffer);
+		break;
+	}
+	default:
+		ksmbd_debug(SMB, "not implemented yet ioctl command 0x%x\n",
+				cnt_code);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rsp->CntCode = cpu_to_le32(cnt_code);
+	rsp->InputCount = cpu_to_le32(0);
+	rsp->InputOffset = cpu_to_le32(112);
+	rsp->OutputOffset = cpu_to_le32(112);
+	rsp->OutputCount = cpu_to_le32(nbytes);
+	rsp->StructureSize = cpu_to_le16(49);
+	rsp->Reserved = cpu_to_le16(0);
+	rsp->Flags = cpu_to_le32(0);
+	rsp->Reserved2 = cpu_to_le32(0);
+	inc_rfc1001_len(rsp_org, 48 + nbytes);
+
+	return 0;
+
+out:
+	if (ret == -EACCES)
+		rsp->hdr.Status = STATUS_ACCESS_DENIED;
+	else if (ret == -ENOENT)
+		rsp->hdr.Status = STATUS_OBJECT_NAME_NOT_FOUND;
+	else if (ret == -EOPNOTSUPP)
+		rsp->hdr.Status = STATUS_NOT_SUPPORTED;
+	else if (ret < 0 || rsp->hdr.Status == 0)
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+	smb2_set_err_rsp(work);
+	return 0;
+}
+
+/**
+ * smb20_oplock_break_ack() - handler for smb2.0 oplock break command
+ * @work:	smb work containing oplock break command buffer
+ *
+ * Return:	0
+ */
+static void smb20_oplock_break_ack(struct ksmbd_work *work)
+{
+	struct smb2_oplock_break *req = REQUEST_BUF(work);
+	struct smb2_oplock_break *rsp = RESPONSE_BUF(work);
+	struct ksmbd_file *fp;
+	struct oplock_info *opinfo = NULL;
+	__le32 err = 0;
+	int ret = 0;
+	uint64_t volatile_id, persistent_id;
+	char req_oplevel = 0, rsp_oplevel = 0;
+	unsigned int oplock_change_type;
+
+	volatile_id = le64_to_cpu(req->VolatileFid);
+	persistent_id = le64_to_cpu(req->PersistentFid);
+	req_oplevel = req->OplockLevel;
+	ksmbd_debug(OPLOCK, "v_id %llu, p_id %llu request oplock level %d\n",
+		    volatile_id, persistent_id, req_oplevel);
+
+	fp = ksmbd_lookup_fd_slow(work, volatile_id, persistent_id);
+	if (!fp) {
+		rsp->hdr.Status = STATUS_FILE_CLOSED;
+		smb2_set_err_rsp(work);
+		return;
+	}
+
+	opinfo = opinfo_get(fp);
+	if (!opinfo) {
+		ksmbd_err("unexpected null oplock_info\n");
+		rsp->hdr.Status = STATUS_INVALID_OPLOCK_PROTOCOL;
+		smb2_set_err_rsp(work);
+		ksmbd_fd_put(work, fp);
+		return;
+	}
+
+	if (opinfo->level == SMB2_OPLOCK_LEVEL_NONE) {
+		rsp->hdr.Status = STATUS_INVALID_OPLOCK_PROTOCOL;
+		goto err_out;
+	}
+
+	if (opinfo->op_state == OPLOCK_STATE_NONE) {
+		ksmbd_debug(SMB, "unexpected oplock state 0x%x\n", opinfo->op_state);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	if (((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) ||
+			(opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)) &&
+			((req_oplevel != SMB2_OPLOCK_LEVEL_II) &&
+			 (req_oplevel != SMB2_OPLOCK_LEVEL_NONE))) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		oplock_change_type = OPLOCK_WRITE_TO_NONE;
+	} else if ((opinfo->level == SMB2_OPLOCK_LEVEL_II) &&
+			(req_oplevel != SMB2_OPLOCK_LEVEL_NONE)) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		oplock_change_type = OPLOCK_READ_TO_NONE;
+	} else if ((req_oplevel == SMB2_OPLOCK_LEVEL_II) ||
+			(req_oplevel == SMB2_OPLOCK_LEVEL_NONE)) {
+		err = STATUS_INVALID_DEVICE_STATE;
+		if (((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE) ||
+			(opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)) &&
+			(req_oplevel == SMB2_OPLOCK_LEVEL_II)) {
+			oplock_change_type = OPLOCK_WRITE_TO_READ;
+		} else if (((opinfo->level == SMB2_OPLOCK_LEVEL_EXCLUSIVE)
+			|| (opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)) &&
+			(req_oplevel == SMB2_OPLOCK_LEVEL_NONE)) {
+			oplock_change_type = OPLOCK_WRITE_TO_NONE;
+		} else if ((opinfo->level == SMB2_OPLOCK_LEVEL_II) &&
+				(req_oplevel == SMB2_OPLOCK_LEVEL_NONE)) {
+			oplock_change_type = OPLOCK_READ_TO_NONE;
+		} else
+			oplock_change_type = 0;
+	} else
+		oplock_change_type = 0;
+
+	switch (oplock_change_type) {
+	case OPLOCK_WRITE_TO_READ:
+		ret = opinfo_write_to_read(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_II;
+		break;
+	case OPLOCK_WRITE_TO_NONE:
+		ret = opinfo_write_to_none(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_NONE;
+		break;
+	case OPLOCK_READ_TO_NONE:
+		ret = opinfo_read_to_none(opinfo);
+		rsp_oplevel = SMB2_OPLOCK_LEVEL_NONE;
+		break;
+	default:
+		ksmbd_err("unknown oplock change 0x%x -> 0x%x\n",
+				opinfo->level, rsp_oplevel);
+	}
+
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
+	opinfo_put(opinfo);
+	ksmbd_fd_put(work, fp);
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+
+	rsp->StructureSize = cpu_to_le16(24);
+	rsp->OplockLevel = rsp_oplevel;
+	rsp->Reserved = 0;
+	rsp->Reserved2 = 0;
+	rsp->VolatileFid = cpu_to_le64(volatile_id);
+	rsp->PersistentFid = cpu_to_le64(persistent_id);
+	inc_rfc1001_len(rsp, 24);
+	return;
+
+err_out:
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+
+	opinfo_put(opinfo);
+	ksmbd_fd_put(work, fp);
+	smb2_set_err_rsp(work);
+}
+
+static int check_lease_state(struct lease *lease, __le32 req_state)
+{
+	if ((lease->new_state ==
+		(SMB2_LEASE_READ_CACHING_LE | SMB2_LEASE_HANDLE_CACHING_LE))
+		&& !(req_state & SMB2_LEASE_WRITE_CACHING_LE)) {
+		lease->new_state = req_state;
+		return 0;
+	}
+
+	if (lease->new_state == req_state)
+		return 0;
+
+	return 1;
+}
+
+/**
+ * smb21_lease_break_ack() - handler for smb2.1 lease break command
+ * @work:	smb work containing lease break command buffer
+ *
+ * Return:	0
+ */
+static void smb21_lease_break_ack(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_lease_ack *req = REQUEST_BUF(work);
+	struct smb2_lease_ack *rsp = RESPONSE_BUF(work);
+	struct oplock_info *opinfo;
+	__le32 err = 0;
+	int ret = 0;
+	unsigned int lease_change_type;
+	__le32 lease_state;
+	struct lease *lease;
+
+	ksmbd_debug(OPLOCK, "smb21 lease break, lease state(0x%x)\n",
+			le32_to_cpu(req->LeaseState));
+	opinfo = lookup_lease_in_table(conn, req->LeaseKey);
+	if (!opinfo) {
+		ksmbd_debug(OPLOCK, "file not opened\n");
+		smb2_set_err_rsp(work);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		return;
+	}
+	lease = opinfo->o_lease;
+
+	if (opinfo->op_state == OPLOCK_STATE_NONE) {
+		ksmbd_err("unexpected lease break state 0x%x\n",
+				opinfo->op_state);
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	if (check_lease_state(lease, req->LeaseState)) {
+		rsp->hdr.Status = STATUS_REQUEST_NOT_ACCEPTED;
+		ksmbd_debug(OPLOCK,
+			"req lease state: 0x%x, expected state: 0x%x\n",
+				req->LeaseState, lease->new_state);
+		goto err_out;
+	}
+
+	if (!atomic_read(&opinfo->breaking_cnt)) {
+		rsp->hdr.Status = STATUS_UNSUCCESSFUL;
+		goto err_out;
+	}
+
+	/* check for bad lease state */
+	if (req->LeaseState & (~(SMB2_LEASE_READ_CACHING_LE |
+					SMB2_LEASE_HANDLE_CACHING_LE))) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+			lease_change_type = OPLOCK_WRITE_TO_NONE;
+		else
+			lease_change_type = OPLOCK_READ_TO_NONE;
+		ksmbd_debug(OPLOCK, "handle bad lease state 0x%x -> 0x%x\n",
+			le32_to_cpu(lease->state),
+			le32_to_cpu(req->LeaseState));
+	} else if ((lease->state == SMB2_LEASE_READ_CACHING_LE) &&
+			(req->LeaseState != SMB2_LEASE_NONE_LE)) {
+		err = STATUS_INVALID_OPLOCK_PROTOCOL;
+		lease_change_type = OPLOCK_READ_TO_NONE;
+		ksmbd_debug(OPLOCK, "handle bad lease state 0x%x -> 0x%x\n",
+			le32_to_cpu(lease->state),
+			le32_to_cpu(req->LeaseState));
+	} else {
+		/* valid lease state changes */
+		err = STATUS_INVALID_DEVICE_STATE;
+		if (req->LeaseState == SMB2_LEASE_NONE_LE) {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+				lease_change_type = OPLOCK_WRITE_TO_NONE;
+			else
+				lease_change_type = OPLOCK_READ_TO_NONE;
+		} else if (req->LeaseState & SMB2_LEASE_READ_CACHING_LE) {
+			if (lease->state & SMB2_LEASE_WRITE_CACHING_LE)
+				lease_change_type = OPLOCK_WRITE_TO_READ;
+			else
+				lease_change_type = OPLOCK_READ_HANDLE_TO_READ;
+		} else
+			lease_change_type = 0;
+	}
+
+	switch (lease_change_type) {
+	case OPLOCK_WRITE_TO_READ:
+		ret = opinfo_write_to_read(opinfo);
+		break;
+	case OPLOCK_READ_HANDLE_TO_READ:
+		ret = opinfo_read_handle_to_read(opinfo);
+		break;
+	case OPLOCK_WRITE_TO_NONE:
+		ret = opinfo_write_to_none(opinfo);
+		break;
+	case OPLOCK_READ_TO_NONE:
+		ret = opinfo_read_to_none(opinfo);
+		break;
+	default:
+		ksmbd_debug(OPLOCK, "unknown lease change 0x%x -> 0x%x\n",
+			le32_to_cpu(lease->state),
+			le32_to_cpu(req->LeaseState));
+	}
+
+	lease_state = lease->state;
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+	atomic_dec(&opinfo->breaking_cnt);
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+	opinfo_put(opinfo);
+
+	if (ret < 0) {
+		rsp->hdr.Status = err;
+		goto err_out;
+	}
+
+	rsp->StructureSize = cpu_to_le16(36);
+	rsp->Reserved = 0;
+	rsp->Flags = 0;
+	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
+	rsp->LeaseState = lease_state;
+	rsp->LeaseDuration = 0;
+	inc_rfc1001_len(rsp, 36);
+	return;
+
+err_out:
+	opinfo->op_state = OPLOCK_STATE_NONE;
+	wake_up_interruptible_all(&opinfo->oplock_q);
+	atomic_dec(&opinfo->breaking_cnt);
+	wake_up_interruptible_all(&opinfo->oplock_brk);
+
+	opinfo_put(opinfo);
+	smb2_set_err_rsp(work);
+}
+
+/**
+ * smb2_oplock_break() - dispatcher for smb2.0 and 2.1 oplock/lease break
+ * @work:	smb work containing oplock/lease break command buffer
+ *
+ * Return:	0
+ */
+int smb2_oplock_break(struct ksmbd_work *work)
+{
+	struct smb2_oplock_break *req = REQUEST_BUF(work);
+	struct smb2_oplock_break *rsp = RESPONSE_BUF(work);
+
+	switch (le16_to_cpu(req->StructureSize)) {
+	case OP_BREAK_STRUCT_SIZE_20:
+		smb20_oplock_break_ack(work);
+		break;
+	case OP_BREAK_STRUCT_SIZE_21:
+		smb21_lease_break_ack(work);
+		break;
+	default:
+		ksmbd_debug(OPLOCK, "invalid break cmd %d\n",
+			le16_to_cpu(req->StructureSize));
+		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
+		smb2_set_err_rsp(work);
+	}
+
+	return 0;
+}
+
+/**
+ * smb2_notify() - handler for smb2 notify request
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:      0
+ */
+int smb2_notify(struct ksmbd_work *work)
+{
+	struct smb2_notify_req *req;
+	struct smb2_notify_rsp *rsp;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	if (work->next_smb2_rcv_hdr_off && req->hdr.NextCommand) {
+		rsp->hdr.Status = STATUS_INTERNAL_ERROR;
+		smb2_set_err_rsp(work);
+		return 0;
+	}
+
+	smb2_set_err_rsp(work);
+	rsp->hdr.Status = STATUS_NOT_IMPLEMENTED;
+	return 0;
+}
+
+/**
+ * smb2_is_sign_req() - handler for checking packet signing status
+ * @work:	smb work containing notify command buffer
+ * @command:	SMB2 command id
+ *
+ * Return:	true if packed is signed, false otherwise
+ */
+bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
+{
+	struct smb2_hdr *rcv_hdr2 = REQUEST_BUF(work);
+
+	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
+			command != SMB2_NEGOTIATE_HE &&
+			command != SMB2_SESSION_SETUP_HE &&
+			command != SMB2_OPLOCK_BREAK_HE)
+		return true;
+
+	return 0;
+}
+
+/**
+ * smb2_check_sign_req() - handler for req packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:	1 on success, 0 otherwise
+ */
+int smb2_check_sign_req(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr, *hdr_org;
+	char signature_req[SMB2_SIGNATURE_SIZE];
+	char signature[SMB2_HMACSHA256_SIZE];
+	struct kvec iov[1];
+	size_t len;
+
+	hdr_org = hdr = REQUEST_BUF(work);
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = REQUEST_BUF_NEXT(work);
+
+	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
+		len = be32_to_cpu(hdr_org->smb2_buf_length);
+	else if (hdr->NextCommand)
+		len = le32_to_cpu(hdr->NextCommand);
+	else
+		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+			work->next_smb2_rcv_hdr_off;
+
+	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, 1,
+		signature))
+		return 0;
+
+	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+		ksmbd_err("bad smb2 signature\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * smb2_set_sign_rsp() - handler for rsp packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ */
+void smb2_set_sign_rsp(struct ksmbd_work *work)
+{
+	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *req_hdr;
+	char signature[SMB2_HMACSHA256_SIZE];
+	struct kvec iov[2];
+	size_t len;
+	int n_vec = 1;
+
+	hdr_org = hdr = RESPONSE_BUF(work);
+	if (work->next_smb2_rsp_hdr_off)
+		hdr = RESPONSE_BUF_NEXT(work);
+
+	req_hdr = REQUEST_BUF_NEXT(work);
+
+	if (!work->next_smb2_rsp_hdr_off) {
+		len = get_rfc1002_len(hdr_org);
+		if (req_hdr->NextCommand)
+			len = ALIGN(len, 8);
+	} else {
+		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = ALIGN(len, 8);
+	}
+
+	if (req_hdr->NextCommand)
+		hdr->NextCommand = cpu_to_le32(len);
+
+	hdr->Flags |= SMB2_FLAGS_SIGNED;
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (HAS_AUX_PAYLOAD(work)) {
+		iov[0].iov_len -= AUX_PAYLOAD_SIZE(work);
+
+		iov[1].iov_base = AUX_PAYLOAD(work);
+		iov[1].iov_len = AUX_PAYLOAD_SIZE(work);
+		n_vec++;
+	}
+
+	if (!ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, n_vec,
+		signature))
+		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+}
+
+/**
+ * smb3_check_sign_req() - handler for req packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ * Return:	1 on success, 0 otherwise
+ */
+int smb3_check_sign_req(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn;
+	char *signing_key;
+	struct smb2_hdr *hdr, *hdr_org;
+	struct channel *chann;
+	char signature_req[SMB2_SIGNATURE_SIZE];
+	char signature[SMB2_CMACAES_SIZE];
+	struct kvec iov[1];
+	size_t len;
+
+	hdr_org = hdr = REQUEST_BUF(work);
+	if (work->next_smb2_rcv_hdr_off)
+		hdr = REQUEST_BUF_NEXT(work);
+
+	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
+		len = be32_to_cpu(hdr_org->smb2_buf_length);
+	else if (hdr->NextCommand)
+		len = le32_to_cpu(hdr->NextCommand);
+	else
+		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+			work->next_smb2_rcv_hdr_off;
+
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+		signing_key = work->sess->smb3signingkey;
+		conn = work->sess->conn;
+	} else {
+		chann = lookup_chann_list(work->sess);
+		if (!chann)
+			return 0;
+		signing_key = chann->smb3signingkey;
+		conn = chann->conn;
+	}
+
+	if (!signing_key) {
+		ksmbd_err("SMB3 signing key is not generated\n");
+		return 0;
+	}
+
+	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+
+	if (ksmbd_sign_smb3_pdu(conn, signing_key, iov, 1, signature))
+		return 0;
+
+	if (memcmp(signature, signature_req, SMB2_SIGNATURE_SIZE)) {
+		ksmbd_err("bad smb2 signature\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/**
+ * smb3_set_sign_rsp() - handler for rsp packet sign processing
+ * @work:   smb work containing notify command buffer
+ *
+ */
+void smb3_set_sign_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn;
+	struct smb2_hdr *req_hdr;
+	struct smb2_hdr *hdr, *hdr_org;
+	struct channel *chann;
+	char signature[SMB2_CMACAES_SIZE];
+	struct kvec iov[2];
+	int n_vec = 1;
+	size_t len;
+	char *signing_key;
+
+	hdr_org = hdr = RESPONSE_BUF(work);
+	if (work->next_smb2_rsp_hdr_off)
+		hdr = RESPONSE_BUF_NEXT(work);
+
+	req_hdr = REQUEST_BUF_NEXT(work);
+
+	if (!work->next_smb2_rsp_hdr_off) {
+		len = get_rfc1002_len(hdr_org);
+		if (req_hdr->NextCommand)
+			len = ALIGN(len, 8);
+	} else {
+		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = ALIGN(len, 8);
+	}
+
+	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
+		signing_key = work->sess->smb3signingkey;
+		conn = work->sess->conn;
+	} else {
+		chann = lookup_chann_list(work->sess);
+		if (!chann)
+			return;
+		signing_key = chann->smb3signingkey;
+		conn = chann->conn;
+	}
+
+	if (!signing_key)
+		return;
+
+	if (req_hdr->NextCommand)
+		hdr->NextCommand = cpu_to_le32(len);
+
+	hdr->Flags |= SMB2_FLAGS_SIGNED;
+	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
+	iov[0].iov_base = (char *)&hdr->ProtocolId;
+	iov[0].iov_len = len;
+	if (HAS_AUX_PAYLOAD(work)) {
+		iov[0].iov_len -= AUX_PAYLOAD_SIZE(work);
+		iov[1].iov_base = AUX_PAYLOAD(work);
+		iov[1].iov_len = AUX_PAYLOAD_SIZE(work);
+		n_vec++;
+	}
+
+	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature))
+		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+}
+
+/**
+ * smb3_preauth_hash_rsp() - handler for computing preauth hash on response
+ * @work:   smb work containing response buffer
+ *
+ */
+void smb3_preauth_hash_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess = work->sess;
+	struct smb2_hdr *req, *rsp;
+
+	if (conn->dialect != SMB311_PROT_ID)
+		return;
+
+	WORK_BUFFERS(work, req, rsp);
+
+	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE)
+		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+			conn->preauth_info->Preauth_HashValue);
+
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE &&
+			sess && sess->state == SMB2_SESSION_IN_PROGRESS) {
+		__u8 *hash_value;
+
+		hash_value = sess->Preauth_HashValue;
+		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+				hash_value);
+	}
+}
+
+static void fill_transform_hdr(struct smb2_transform_hdr *tr_hdr,
+			       char *old_buf,
+			       __le16 cipher_type)
+{
+	struct smb2_hdr *hdr = (struct smb2_hdr *)old_buf;
+	unsigned int orig_len = get_rfc1002_len(old_buf);
+
+	memset(tr_hdr, 0, sizeof(struct smb2_transform_hdr));
+	tr_hdr->ProtocolId = SMB2_TRANSFORM_PROTO_NUM;
+	tr_hdr->OriginalMessageSize = cpu_to_le32(orig_len);
+	tr_hdr->Flags = cpu_to_le16(0x01);
+	if (cipher_type == SMB2_ENCRYPTION_AES128_GCM)
+		get_random_bytes(&tr_hdr->Nonce, SMB3_AES128GCM_NONCE);
+	else
+		get_random_bytes(&tr_hdr->Nonce, SMB3_AES128CCM_NONCE);
+	memcpy(&tr_hdr->SessionId, &hdr->SessionId, 8);
+	inc_rfc1001_len(tr_hdr, sizeof(struct smb2_transform_hdr) - 4);
+	inc_rfc1001_len(tr_hdr, orig_len);
+}
+
+int smb3_encrypt_resp(struct ksmbd_work *work)
+{
+	char *buf = RESPONSE_BUF(work);
+	struct smb2_transform_hdr *tr_hdr;
+	struct kvec iov[3];
+	int rc = -ENOMEM;
+	int buf_size = 0, rq_nvec = 2 + (HAS_AUX_PAYLOAD(work) ? 1 : 0);
+
+	if (ARRAY_SIZE(iov) < rq_nvec)
+		return -ENOMEM;
+
+	tr_hdr = ksmbd_alloc_response(sizeof(struct smb2_transform_hdr));
+	if (!tr_hdr)
+		return rc;
+
+	/* fill transform header */
+	fill_transform_hdr(tr_hdr, buf, work->conn->cipher_type);
+
+	iov[0].iov_base = tr_hdr;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
+	buf_size += iov[0].iov_len - 4;
+
+	iov[1].iov_base = buf + 4;
+	iov[1].iov_len = get_rfc1002_len(buf);
+	if (HAS_AUX_PAYLOAD(work)) {
+		iov[1].iov_len = RESP_HDR_SIZE(work) - 4;
+
+		iov[2].iov_base = AUX_PAYLOAD(work);
+		iov[2].iov_len = AUX_PAYLOAD_SIZE(work);
+		buf_size += iov[2].iov_len;
+	}
+	buf_size += iov[1].iov_len;
+	work->resp_hdr_sz = iov[1].iov_len;
+
+	rc = ksmbd_crypt_message(work->conn, iov, rq_nvec, 1);
+	if (rc)
+		return rc;
+
+	memmove(buf, iov[1].iov_base, iov[1].iov_len);
+	tr_hdr->smb2_buf_length = cpu_to_be32(buf_size);
+	work->tr_buf = tr_hdr;
+
+	return rc;
+}
+
+int smb3_is_transform_hdr(void *buf)
+{
+	struct smb2_transform_hdr *trhdr = buf;
+
+	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
+}
+
+int smb3_decrypt_req(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct ksmbd_session *sess;
+	char *buf = REQUEST_BUF(work);
+	struct smb2_hdr *hdr;
+	unsigned int pdu_length = get_rfc1002_len(buf);
+	struct kvec iov[2];
+	unsigned int buf_data_size = pdu_length + 4 -
+		sizeof(struct smb2_transform_hdr);
+	struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
+	unsigned int orig_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
+	int rc = 0;
+
+	sess = ksmbd_session_lookup(conn, le64_to_cpu(tr_hdr->SessionId));
+	if (!sess) {
+		ksmbd_err("invalid session id(%llx) in transform header\n",
+		le64_to_cpu(tr_hdr->SessionId));
+		return -ECONNABORTED;
+	}
+
+	if (pdu_length + 4 < sizeof(struct smb2_transform_hdr) +
+			sizeof(struct smb2_hdr)) {
+		ksmbd_err("Transform message is too small (%u)\n",
+				pdu_length);
+		return -ECONNABORTED;
+	}
+
+	if (pdu_length + 4 < orig_len + sizeof(struct smb2_transform_hdr)) {
+		ksmbd_err("Transform message is broken\n");
+		return -ECONNABORTED;
+	}
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = sizeof(struct smb2_transform_hdr);
+	iov[1].iov_base = buf + sizeof(struct smb2_transform_hdr);
+	iov[1].iov_len = buf_data_size;
+	rc = ksmbd_crypt_message(conn, iov, 2, 0);
+	if (rc)
+		return rc;
+
+	memmove(buf + 4, iov[1].iov_base, buf_data_size);
+	hdr = (struct smb2_hdr *)buf;
+	hdr->smb2_buf_length = cpu_to_be32(buf_data_size);
+
+	return rc;
+}
+
+bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp = RESPONSE_BUF(work);
+
+	if (conn->dialect < SMB30_PROT_ID)
+		return false;
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp = RESPONSE_BUF_NEXT(work);
+
+	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE &&
+		rsp->Status == STATUS_SUCCESS)
+		return true;
+	return false;
+}
diff --git a/fs/cifsd/smb2pdu.h b/fs/cifsd/smb2pdu.h
new file mode 100644
index 000000000000..deb3d7444c2a
--- /dev/null
+++ b/fs/cifsd/smb2pdu.h
@@ -0,0 +1,1649 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2016 Namjae Jeon <linkinjeon@kernel.org>
+ *   Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef _SMB2PDU_H
+#define _SMB2PDU_H
+
+#include "ntlmssp.h"
+#include "smbacl.h"
+
+/*
+ * Note that, due to trying to use names similar to the protocol specifications,
+ * there are many mixed case field names in the structures below.  Although
+ * this does not match typical Linux kernel style, it is necessary to be
+ * able to match against the protocol specfication.
+ *
+ * SMB2 commands
+ * Some commands have minimal (wct=0,bcc=0), or uninteresting, responses
+ * (ie no useful data other than the SMB error code itself) and are marked such.
+ * Knowing this helps avoid response buffer allocations and copy in some cases.
+ */
+
+/* List of commands in host endian */
+#define SMB2_NEGOTIATE_HE	0x0000
+#define SMB2_SESSION_SETUP_HE	0x0001
+#define SMB2_LOGOFF_HE		0x0002 /* trivial request/resp */
+#define SMB2_TREE_CONNECT_HE	0x0003
+#define SMB2_TREE_DISCONNECT_HE	0x0004 /* trivial req/resp */
+#define SMB2_CREATE_HE		0x0005
+#define SMB2_CLOSE_HE		0x0006
+#define SMB2_FLUSH_HE		0x0007 /* trivial resp */
+#define SMB2_READ_HE		0x0008
+#define SMB2_WRITE_HE		0x0009
+#define SMB2_LOCK_HE		0x000A
+#define SMB2_IOCTL_HE		0x000B
+#define SMB2_CANCEL_HE		0x000C
+#define SMB2_ECHO_HE		0x000D
+#define SMB2_QUERY_DIRECTORY_HE	0x000E
+#define SMB2_CHANGE_NOTIFY_HE	0x000F
+#define SMB2_QUERY_INFO_HE	0x0010
+#define SMB2_SET_INFO_HE	0x0011
+#define SMB2_OPLOCK_BREAK_HE	0x0012
+
+/* The same list in little endian */
+#define SMB2_NEGOTIATE		cpu_to_le16(SMB2_NEGOTIATE_HE)
+#define SMB2_SESSION_SETUP	cpu_to_le16(SMB2_SESSION_SETUP_HE)
+#define SMB2_LOGOFF		cpu_to_le16(SMB2_LOGOFF_HE)
+#define SMB2_TREE_CONNECT	cpu_to_le16(SMB2_TREE_CONNECT_HE)
+#define SMB2_TREE_DISCONNECT	cpu_to_le16(SMB2_TREE_DISCONNECT_HE)
+#define SMB2_CREATE		cpu_to_le16(SMB2_CREATE_HE)
+#define SMB2_CLOSE		cpu_to_le16(SMB2_CLOSE_HE)
+#define SMB2_FLUSH		cpu_to_le16(SMB2_FLUSH_HE)
+#define SMB2_READ		cpu_to_le16(SMB2_READ_HE)
+#define SMB2_WRITE		cpu_to_le16(SMB2_WRITE_HE)
+#define SMB2_LOCK		cpu_to_le16(SMB2_LOCK_HE)
+#define SMB2_IOCTL		cpu_to_le16(SMB2_IOCTL_HE)
+#define SMB2_CANCEL		cpu_to_le16(SMB2_CANCEL_HE)
+#define SMB2_ECHO		cpu_to_le16(SMB2_ECHO_HE)
+#define SMB2_QUERY_DIRECTORY	cpu_to_le16(SMB2_QUERY_DIRECTORY_HE)
+#define SMB2_CHANGE_NOTIFY	cpu_to_le16(SMB2_CHANGE_NOTIFY_HE)
+#define SMB2_QUERY_INFO		cpu_to_le16(SMB2_QUERY_INFO_HE)
+#define SMB2_SET_INFO		cpu_to_le16(SMB2_SET_INFO_HE)
+#define SMB2_OPLOCK_BREAK	cpu_to_le16(SMB2_OPLOCK_BREAK_HE)
+
+/*Create Action Flags*/
+#define FILE_SUPERSEDED                0x00000000
+#define FILE_OPENED            0x00000001
+#define FILE_CREATED           0x00000002
+#define FILE_OVERWRITTEN       0x00000003
+
+/*
+ * Size of the session key (crypto key encrypted with the password
+ */
+#define SMB2_NTLMV2_SESSKEY_SIZE	16
+#define SMB2_SIGNATURE_SIZE		16
+#define SMB2_HMACSHA256_SIZE		32
+#define SMB2_CMACAES_SIZE		16
+
+/*
+ * Size of the smb3 signing key
+ */
+#define SMB3_SIGN_KEY_SIZE		16
+
+#define CIFS_CLIENT_CHALLENGE_SIZE	8
+#define SMB_SERVER_CHALLENGE_SIZE	8
+
+/* SMB2 Max Credits */
+#define SMB2_MAX_CREDITS		8192
+
+#define SMB2_CLIENT_GUID_SIZE		16
+#define SMB2_CREATE_GUID_SIZE		16
+
+/* Maximum buffer size value we can send with 1 credit */
+#define SMB2_MAX_BUFFER_SIZE 65536
+
+#define NUMBER_OF_SMB2_COMMANDS	0x0013
+
+/* BB FIXME - analyze following length BB */
+#define MAX_SMB2_HDR_SIZE 0x78 /* 4 len + 64 hdr + (2*24 wct) + 2 bct + 2 pad */
+
+#define SMB2_PROTO_NUMBER cpu_to_le32(0x424d53fe) /* 'B''M''S' */
+#define SMB2_TRANSFORM_PROTO_NUM cpu_to_le32(0x424d53fd)
+
+#define SMB21_DEFAULT_IOSIZE	(1024 * 1024)
+#define SMB3_DEFAULT_IOSIZE	(4 * 1024 * 1024)
+#define SMB3_DEFAULT_TRANS_SIZE	(1024 * 1024)
+
+/*
+ * SMB2 Header Definition
+ *
+ * "MBZ" :  Must be Zero
+ * "BB"  :  BugBug, Something to check/review/analyze later
+ * "PDU" :  "Protocol Data Unit" (ie a network "frame")
+ *
+ */
+
+#define __SMB2_HEADER_STRUCTURE_SIZE	64
+#define SMB2_HEADER_STRUCTURE_SIZE				\
+	cpu_to_le16(__SMB2_HEADER_STRUCTURE_SIZE)
+
+struct smb2_hdr {
+	__be32 smb2_buf_length;	/* big endian on wire */
+				/*
+				 * length is only two or three bytes - with
+				 * one or two byte type preceding it that MBZ
+				 */
+	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
+	__le16 StructureSize;	/* 64 */
+	__le16 CreditCharge;	/* MBZ */
+	__le32 Status;		/* Error from server */
+	__le16 Command;
+	__le16 CreditRequest;	/* CreditResponse */
+	__le32 Flags;
+	__le32 NextCommand;
+	__le64 MessageId;
+	union {
+		struct {
+			__le32 ProcessId;
+			__le32  TreeId;
+		} __packed SyncId;
+		__le64  AsyncId;
+	} __packed Id;
+	__le64  SessionId;
+	__u8   Signature[16];
+} __packed;
+
+struct smb2_pdu {
+	struct smb2_hdr hdr;
+	__le16 StructureSize2; /* size of wct area (varies, request specific) */
+} __packed;
+
+#define SMB3_AES128CCM_NONCE 11
+#define SMB3_AES128GCM_NONCE 12
+
+struct smb2_transform_hdr {
+	__be32 smb2_buf_length; /* big endian on wire */
+	/*
+	 * length is only two or three bytes - with
+	 * one or two byte type preceding it that MBZ
+	 */
+	__le32 ProtocolId;      /* 0xFD 'S' 'M' 'B' */
+	__u8   Signature[16];
+	__u8   Nonce[16];
+	__le32 OriginalMessageSize;
+	__u16  Reserved1;
+	__le16 Flags; /* EncryptionAlgorithm */
+	__le64  SessionId;
+} __packed;
+
+/*
+ *	SMB2 flag definitions
+ */
+#define SMB2_FLAGS_SERVER_TO_REDIR	cpu_to_le32(0x00000001)
+#define SMB2_FLAGS_ASYNC_COMMAND	cpu_to_le32(0x00000002)
+#define SMB2_FLAGS_RELATED_OPERATIONS	cpu_to_le32(0x00000004)
+#define SMB2_FLAGS_SIGNED		cpu_to_le32(0x00000008)
+#define SMB2_FLAGS_DFS_OPERATIONS	cpu_to_le32(0x10000000)
+#define SMB2_FLAGS_REPLAY_OPERATIONS	cpu_to_le32(0x20000000)
+
+/*
+ *	Definitions for SMB2 Protocol Data Units (network frames)
+ *
+ *  See MS-SMB2.PDF specification for protocol details.
+ *  The Naming convention is the lower case version of the SMB2
+ *  command code name for the struct. Note that structures must be packed.
+ *
+ */
+
+#define SMB2_ERROR_STRUCTURE_SIZE2	9
+#define SMB2_ERROR_STRUCTURE_SIZE2_LE	cpu_to_le16(SMB2_ERROR_STRUCTURE_SIZE2)
+
+struct smb2_err_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;
+	__u8   ErrorContextCount;
+	__u8   Reserved;
+	__le32 ByteCount;  /* even if zero, at least one byte follows */
+	__u8   ErrorData[1];  /* variable length */
+} __packed;
+
+struct smb2_negotiate_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 36 */
+	__le16 DialectCount;
+	__le16 SecurityMode;
+	__le16 Reserved;	/* MBZ */
+	__le32 Capabilities;
+	__u8   ClientGUID[SMB2_CLIENT_GUID_SIZE];
+	/* In SMB3.02 and earlier next three were MBZ le64 ClientStartTime */
+	__le32 NegotiateContextOffset; /* SMB3.1.1 only. MBZ earlier */
+	__le16 NegotiateContextCount;  /* SMB3.1.1 only. MBZ earlier */
+	__le16 Reserved2;
+	__le16 Dialects[1]; /* One dialect (vers=) at a time for now */
+} __packed;
+
+/* SecurityMode flags */
+#define SMB2_NEGOTIATE_SIGNING_ENABLED_LE	cpu_to_le16(0x0001)
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED		0x0002
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED_LE	cpu_to_le16(0x0002)
+/* Capabilities flags */
+#define SMB2_GLOBAL_CAP_DFS		0x00000001
+#define SMB2_GLOBAL_CAP_LEASING		0x00000002 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_LARGE_MTU	0X00000004 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_MULTI_CHANNEL	0x00000008 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_PERSISTENT_HANDLES 0x00000010 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_DIRECTORY_LEASING  0x00000020 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_ENCRYPTION	0x00000040 /* New to SMB3 */
+/* Internal types */
+#define SMB2_NT_FIND			0x00100000
+#define SMB2_LARGE_FILES		0x00200000
+
+#define SMB311_SALT_SIZE			32
+/* Hash Algorithm Types */
+#define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
+
+#define PREAUTH_HASHVALUE_SIZE		64
+
+struct preauth_integrity_info {
+	/* PreAuth integrity Hash ID */
+	__le16			Preauth_HashId;
+	/* PreAuth integrity Hash Value */
+	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
+};
+
+/* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
+#ifdef CONFIG_SMB_SERVER_KERBEROS5
+/* sizeof(struct smb2_negotiate_rsp) - 4 =
+ * header(64) + response(64) + GSS_LENGTH(96) + GSS_PADDING(0)
+ */
+#define OFFSET_OF_NEG_CONTEXT	0xe0
+#else
+/* sizeof(struct smb2_negotiate_rsp) - 4 =
+ * header(64) + response(64) + GSS_LENGTH(74) + GSS_PADDING(6)
+ */
+#define OFFSET_OF_NEG_CONTEXT	0xd0
+#endif
+
+#define SMB2_PREAUTH_INTEGRITY_CAPABILITIES	cpu_to_le16(1)
+#define SMB2_ENCRYPTION_CAPABILITIES		cpu_to_le16(2)
+#define SMB2_COMPRESSION_CAPABILITIES		cpu_to_le16(3)
+#define SMB2_NETNAME_NEGOTIATE_CONTEXT_ID	cpu_to_le16(5)
+#define SMB2_POSIX_EXTENSIONS_AVAILABLE		cpu_to_le16(0x100)
+
+struct smb2_neg_context {
+	__le16  ContextType;
+	__le16  DataLength;
+	__le32  Reserved;
+	/* Followed by array of data */
+} __packed;
+
+struct smb2_preauth_neg_context {
+	__le16	ContextType; /* 1 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	HashAlgorithmCount; /* 1 */
+	__le16	SaltLength;
+	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
+	__u8	Salt[SMB311_SALT_SIZE];
+} __packed;
+
+/* Encryption Algorithms Ciphers */
+#define SMB2_ENCRYPTION_AES128_CCM	cpu_to_le16(0x0001)
+#define SMB2_ENCRYPTION_AES128_GCM	cpu_to_le16(0x0002)
+
+struct smb2_encryption_neg_context {
+	__le16	ContextType; /* 2 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	CipherCount; /* AES-128-GCM and AES-128-CCM */
+	__le16	Ciphers[1]; /* Ciphers[0] since only one used now */
+} __packed;
+
+#define SMB3_COMPRESS_NONE	cpu_to_le16(0x0000)
+#define SMB3_COMPRESS_LZNT1	cpu_to_le16(0x0001)
+#define SMB3_COMPRESS_LZ77	cpu_to_le16(0x0002)
+#define SMB3_COMPRESS_LZ77_HUFF	cpu_to_le16(0x0003)
+
+struct smb2_compression_ctx {
+	__le16	ContextType; /* 3 */
+	__le16  DataLength;
+	__le32	Reserved;
+	__le16	CompressionAlgorithmCount;
+	__u16	Padding;
+	__le32	Reserved1;
+	__le16	CompressionAlgorithms[1];
+} __packed;
+
+#define POSIX_CTXT_DATA_LEN     16
+struct smb2_posix_neg_context {
+	__le16	ContextType; /* 0x100 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
+} __packed;
+
+struct smb2_netname_neg_context {
+	__le16	ContextType; /* 0x100 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	NetName[0]; /* hostname of target converted to UCS-2 */
+} __packed;
+
+struct smb2_negotiate_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 65 */
+	__le16 SecurityMode;
+	__le16 DialectRevision;
+	__le16 NegotiateContextCount; /* Prior to SMB3.1.1 was Reserved & MBZ */
+	__u8   ServerGUID[16];
+	__le32 Capabilities;
+	__le32 MaxTransactSize;
+	__le32 MaxReadSize;
+	__le32 MaxWriteSize;
+	__le64 SystemTime;	/* MBZ */
+	__le64 ServerStartTime;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+/* Flags */
+#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
+#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
+
+#define SMB2_SESSION_EXPIRED		(0)
+#define SMB2_SESSION_IN_PROGRESS	(1 << 0)
+#define SMB2_SESSION_VALID		(1 << 1)
+
+/* Flags */
+#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
+#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
+
+struct smb2_sess_setup_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 25 */
+	__u8   Flags;
+	__u8   SecurityMode;
+	__le32 Capabilities;
+	__le32 Channel;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__le64 PreviousSessionId;
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+/* Flags/Reserved for SMB3.1.1 */
+#define SMB2_SHAREFLAG_CLUSTER_RECONNECT	0x0001
+
+/* Currently defined SessionFlags */
+#define SMB2_SESSION_FLAG_IS_GUEST_LE		cpu_to_le16(0x0001)
+#define SMB2_SESSION_FLAG_IS_NULL_LE		cpu_to_le16(0x0002)
+#define SMB2_SESSION_FLAG_ENCRYPT_DATA_LE	cpu_to_le16(0x0004)
+struct smb2_sess_setup_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 SessionFlags;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+struct smb2_logoff_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_logoff_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_tree_connect_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 9 */
+	__le16 Reserved;	/* Flags in SMB3.1.1 */
+	__le16 PathOffset;
+	__le16 PathLength;
+	__u8   Buffer[1];	/* variable length */
+} __packed;
+
+struct smb2_tree_connect_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 16 */
+	__u8   ShareType;  /* see below */
+	__u8   Reserved;
+	__le32 ShareFlags; /* see below */
+	__le32 Capabilities; /* see below */
+	__le32 MaximalAccess;
+} __packed;
+
+/* Possible ShareType values */
+#define SMB2_SHARE_TYPE_DISK	0x01
+#define SMB2_SHARE_TYPE_PIPE	0x02
+#define	SMB2_SHARE_TYPE_PRINT	0x03
+
+/*
+ * Possible ShareFlags - exactly one and only one of the first 4 caching flags
+ * must be set (any of the remaining, SHI1005, flags may be set individually
+ * or in combination.
+ */
+#define SMB2_SHAREFLAG_MANUAL_CACHING			0x00000000
+#define SMB2_SHAREFLAG_AUTO_CACHING			0x00000010
+#define SMB2_SHAREFLAG_VDO_CACHING			0x00000020
+#define SMB2_SHAREFLAG_NO_CACHING			0x00000030
+#define SHI1005_FLAGS_DFS				0x00000001
+#define SHI1005_FLAGS_DFS_ROOT				0x00000002
+#define SHI1005_FLAGS_RESTRICT_EXCLUSIVE_OPENS		0x00000100
+#define SHI1005_FLAGS_FORCE_SHARED_DELETE		0x00000200
+#define SHI1005_FLAGS_ALLOW_NAMESPACE_CACHING		0x00000400
+#define SHI1005_FLAGS_ACCESS_BASED_DIRECTORY_ENUM	0x00000800
+#define SHI1005_FLAGS_FORCE_LEVELII_OPLOCK		0x00001000
+#define SHI1005_FLAGS_ENABLE_HASH			0x00002000
+
+/* Possible share capabilities */
+#define SMB2_SHARE_CAP_DFS	cpu_to_le32(0x00000008)
+
+struct smb2_tree_disconnect_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_tree_disconnect_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+#define ATTR_READONLY_LE	cpu_to_le32(ATTR_READONLY)
+#define ATTR_HIDDEN_LE		cpu_to_le32(ATTR_HIDDEN)
+#define ATTR_SYSTEM_LE		cpu_to_le32(ATTR_SYSTEM)
+#define ATTR_DIRECTORY_LE	cpu_to_le32(ATTR_DIRECTORY)
+#define ATTR_ARCHIVE_LE		cpu_to_le32(ATTR_ARCHIVE)
+#define ATTR_NORMAL_LE		cpu_to_le32(ATTR_NORMAL)
+#define ATTR_TEMPORARY_LE	cpu_to_le32(ATTR_TEMPORARY)
+#define ATTR_SPARSE_FILE_LE	cpu_to_le32(ATTR_SPARSE)
+#define ATTR_REPARSE_POINT_LE	cpu_to_le32(ATTR_REPARSE)
+#define ATTR_COMPRESSED_LE	cpu_to_le32(ATTR_COMPRESSED)
+#define ATTR_OFFLINE_LE		cpu_to_le32(ATTR_OFFLINE)
+#define ATTR_NOT_CONTENT_INDEXED_LE	cpu_to_le32(ATTR_NOT_CONTENT_INDEXED)
+#define ATTR_ENCRYPTED_LE	cpu_to_le32(ATTR_ENCRYPTED)
+#define ATTR_INTEGRITY_STREAML_LE	cpu_to_le32(0x00008000)
+#define ATTR_NO_SCRUB_DATA_LE	cpu_to_le32(0x00020000)
+#define ATTR_MASK_LE		cpu_to_le32(0x00007FB7)
+
+/* Oplock levels */
+#define SMB2_OPLOCK_LEVEL_NONE		0x00
+#define SMB2_OPLOCK_LEVEL_II		0x01
+#define SMB2_OPLOCK_LEVEL_EXCLUSIVE	0x08
+#define SMB2_OPLOCK_LEVEL_BATCH		0x09
+#define SMB2_OPLOCK_LEVEL_LEASE		0xFF
+/* Non-spec internal type */
+#define SMB2_OPLOCK_LEVEL_NOCHANGE	0x99
+
+/* Desired Access Flags */
+#define FILE_READ_DATA_LE		cpu_to_le32(0x00000001)
+#define FILE_LIST_DIRECTORY_LE		cpu_to_le32(0x00000001)
+#define FILE_WRITE_DATA_LE		cpu_to_le32(0x00000002)
+#define FILE_ADD_FILE_LE		cpu_to_le32(0x00000002)
+#define FILE_APPEND_DATA_LE		cpu_to_le32(0x00000004)
+#define FILE_ADD_SUBDIRECTORY_LE	cpu_to_le32(0x00000004)
+#define FILE_READ_EA_LE			cpu_to_le32(0x00000008)
+#define FILE_WRITE_EA_LE		cpu_to_le32(0x00000010)
+#define FILE_EXECUTE_LE			cpu_to_le32(0x00000020)
+#define FILE_TRAVERSE_LE		cpu_to_le32(0x00000020)
+#define FILE_DELETE_CHILD_LE		cpu_to_le32(0x00000040)
+#define FILE_READ_ATTRIBUTES_LE		cpu_to_le32(0x00000080)
+#define FILE_WRITE_ATTRIBUTES_LE	cpu_to_le32(0x00000100)
+#define FILE_DELETE_LE			cpu_to_le32(0x00010000)
+#define FILE_READ_CONTROL_LE		cpu_to_le32(0x00020000)
+#define FILE_WRITE_DAC_LE		cpu_to_le32(0x00040000)
+#define FILE_WRITE_OWNER_LE		cpu_to_le32(0x00080000)
+#define FILE_SYNCHRONIZE_LE		cpu_to_le32(0x00100000)
+#define FILE_ACCESS_SYSTEM_SECURITY_LE	cpu_to_le32(0x01000000)
+#define FILE_MAXIMAL_ACCESS_LE		cpu_to_le32(0x02000000)
+#define FILE_GENERIC_ALL_LE		cpu_to_le32(0x10000000)
+#define FILE_GENERIC_EXECUTE_LE		cpu_to_le32(0x20000000)
+#define FILE_GENERIC_WRITE_LE		cpu_to_le32(0x40000000)
+#define FILE_GENERIC_READ_LE		cpu_to_le32(0x80000000)
+#define DESIRED_ACCESS_MASK		cpu_to_le32(0xF21F01FF)
+
+/* ShareAccess Flags */
+#define FILE_SHARE_READ_LE		cpu_to_le32(0x00000001)
+#define FILE_SHARE_WRITE_LE		cpu_to_le32(0x00000002)
+#define FILE_SHARE_DELETE_LE		cpu_to_le32(0x00000004)
+#define FILE_SHARE_ALL_LE		cpu_to_le32(0x00000007)
+
+/* CreateDisposition Flags */
+#define FILE_SUPERSEDE_LE		cpu_to_le32(0x00000000)
+#define FILE_OPEN_LE			cpu_to_le32(0x00000001)
+#define FILE_CREATE_LE			cpu_to_le32(0x00000002)
+#define	FILE_OPEN_IF_LE			cpu_to_le32(0x00000003)
+#define FILE_OVERWRITE_LE		cpu_to_le32(0x00000004)
+#define FILE_OVERWRITE_IF_LE		cpu_to_le32(0x00000005)
+#define FILE_CREATE_MASK_LE		cpu_to_le32(0x00000007)
+
+#define FILE_READ_DESIRED_ACCESS_LE	(FILE_READ_DATA_LE |		\
+					FILE_READ_EA_LE |		\
+					FILE_GENERIC_READ_LE)
+#define FILE_WRITE_DESIRE_ACCESS_LE	(FILE_WRITE_DATA_LE |		\
+					FILE_APPEND_DATA_LE |		\
+					FILE_WRITE_EA_LE |		\
+					FILE_WRITE_ATTRIBUTES_LE |	\
+					FILE_GENERIC_WRITE_LE)
+
+/* Impersonation Levels */
+#define IL_ANONYMOUS_LE		cpu_to_le32(0x00000000)
+#define IL_IDENTIFICATION_LE	cpu_to_le32(0x00000001)
+#define IL_IMPERSONATION_LE	cpu_to_le32(0x00000002)
+#define IL_DELEGATE_LE		cpu_to_le32(0x00000003)
+
+/* Create Context Values */
+#define SMB2_CREATE_EA_BUFFER			"ExtA" /* extended attributes */
+#define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
+#define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
+#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
+#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
+#define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
+#define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
+#define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
+#define SMB2_CREATE_REQUEST_LEASE		"RqLs"
+#define SMB2_CREATE_DURABLE_HANDLE_REQUEST_V2   "DH2Q"
+#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT_V2 "DH2C"
+#define SMB2_CREATE_APP_INSTANCE_ID     "\x45\xBC\xA6\x6A\xEF\xA7\xF7\x4A\x90\x08\xFA\x46\x2E\x14\x4D\x74"
+ #define SMB2_CREATE_APP_INSTANCE_VERSION	"\xB9\x82\xD0\xB7\x3B\x56\x07\x4F\xA0\x7B\x52\x4A\x81\x16\xA0\x10"
+#define SVHDX_OPEN_DEVICE_CONTEXT       0x83CE6F1AD851E0986E34401CC9BCFCE9
+#define SMB2_CREATE_TAG_POSIX		"\x93\xAD\x25\x50\x9C\xB4\x11\xE7\xB4\x23\x83\xDE\x96\x8B\xCD\x7C"
+
+struct smb2_create_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 57 */
+	__u8   SecurityFlags;
+	__u8   RequestedOplockLevel;
+	__le32 ImpersonationLevel;
+	__le64 SmbCreateFlags;
+	__le64 Reserved;
+	__le32 DesiredAccess;
+	__le32 FileAttributes;
+	__le32 ShareAccess;
+	__le32 CreateDisposition;
+	__le32 CreateOptions;
+	__le16 NameOffset;
+	__le16 NameLength;
+	__le32 CreateContextsOffset;
+	__le32 CreateContextsLength;
+	__u8   Buffer[0];
+} __packed;
+
+struct smb2_create_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 89 */
+	__u8   OplockLevel;
+	__u8   Reserved;
+	__le32 CreateAction;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;
+	__le64 EndofFile;
+	__le32 FileAttributes;
+	__le32 Reserved2;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 CreateContextsOffset;
+	__le32 CreateContextsLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct create_context {
+	__le32 Next;
+	__le16 NameOffset;
+	__le16 NameLength;
+	__le16 Reserved;
+	__le16 DataOffset;
+	__le32 DataLength;
+	__u8 Buffer[0];
+} __packed;
+
+struct create_durable_req_v2 {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 Timeout;
+	__le32 Flags;
+	__u8 Reserved[8];
+	__u8 CreateGuid[16];
+} __packed;
+
+struct create_durable_reconn_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[16];
+		struct {
+			__le64 PersistentFileId;
+			__le64 VolatileFileId;
+		} Fid;
+	} Data;
+} __packed;
+
+struct create_durable_reconn_v2_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct {
+		__le64 PersistentFileId;
+		__le64 VolatileFileId;
+	} Fid;
+	__u8 CreateGuid[16];
+	__le32 Flags;
+} __packed;
+
+struct create_app_inst_id {
+	struct create_context ccontext;
+	__u8 Name[8];
+	__u8 Reserved[8];
+	__u8 AppInstanceId[16];
+} __packed;
+
+struct create_app_inst_id_vers {
+	struct create_context ccontext;
+	__u8 Name[8];
+	__u8 Reserved[2];
+	__u8 Padding[4];
+	__le64 AppInstanceVersionHigh;
+	__le64 AppInstanceVersionLow;
+} __packed;
+
+struct create_mxac_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 Timestamp;
+} __packed;
+
+struct create_alloc_size_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 AllocationSize;
+} __packed;
+
+struct create_posix {
+	struct create_context ccontext;
+	__u8    Name[16];
+	__le32  Mode;
+	__u32   Reserved;
+} __packed;
+
+struct create_durable_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[8];
+		__u64 data;
+	} Data;
+} __packed;
+
+struct create_durable_v2_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 Timeout;
+	__le32 Flags;
+} __packed;
+
+struct create_mxac_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le32 QueryStatus;
+	__le32 MaximalAccess;
+} __packed;
+
+struct create_disk_id_rsp {
+	struct create_context ccontext;
+	__u8   Name[8];
+	__le64 DiskFileId;
+	__le64 VolumeId;
+	__u8  Reserved[16];
+} __packed;
+
+/* equivalent of the contents of SMB3.1.1 POSIX open context response */
+struct create_posix_rsp {
+	struct create_context ccontext;
+	__u8    Name[16];
+	__le32 nlink;
+	__le32 reparse_tag;
+	__le32 mode;
+	u8 SidBuffer[40];
+} __packed;
+
+#define SMB2_LEASE_NONE_LE			cpu_to_le32(0x00)
+#define SMB2_LEASE_READ_CACHING_LE		cpu_to_le32(0x01)
+#define SMB2_LEASE_HANDLE_CACHING_LE		cpu_to_le32(0x02)
+#define SMB2_LEASE_WRITE_CACHING_LE		cpu_to_le32(0x04)
+
+#define SMB2_LEASE_FLAG_BREAK_IN_PROGRESS_LE	cpu_to_le32(0x02)
+
+struct lease_context {
+	__le64 LeaseKeyLow;
+	__le64 LeaseKeyHigh;
+	__le32 LeaseState;
+	__le32 LeaseFlags;
+	__le64 LeaseDuration;
+} __packed;
+
+struct create_lease {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct lease_context lcontext;
+} __packed;
+
+/* Currently defined values for close flags */
+#define SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB	cpu_to_le16(0x0001)
+struct smb2_close_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 24 */
+	__le16 Flags;
+	__le32 Reserved;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+} __packed;
+
+struct smb2_close_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* 60 */
+	__le16 Flags;
+	__le32 Reserved;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
+	__le64 EndOfFile;
+	__le32 Attributes;
+} __packed;
+
+struct smb2_flush_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 24 */
+	__le16 Reserved1;
+	__le32 Reserved2;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+} __packed;
+
+struct smb2_flush_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;
+	__le16 Reserved;
+} __packed;
+
+struct smb2_buffer_desc_v1 {
+	__le64 offset;
+	__le32 token;
+	__le32 length;
+} __packed;
+
+#define SMB2_CHANNEL_NONE		cpu_to_le32(0x00000000)
+#define SMB2_CHANNEL_RDMA_V1		cpu_to_le32(0x00000001)
+#define SMB2_CHANNEL_RDMA_V1_INVALIDATE cpu_to_le32(0x00000002)
+
+struct smb2_read_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__u8   Padding; /* offset from start of SMB2 header to place read */
+	__u8   Reserved;
+	__le32 Length;
+	__le64 Offset;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 MinimumCount;
+	__le32 Channel; /* Reserved MBZ */
+	__le32 RemainingBytes;
+	__le16 ReadChannelInfoOffset; /* Reserved MBZ */
+	__le16 ReadChannelInfoLength; /* Reserved MBZ */
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_read_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 17 */
+	__u8   DataOffset;
+	__u8   Reserved;
+	__le32 DataLength;
+	__le32 DataRemaining;
+	__u32  Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+/* For write request Flags field below the following flag is defined: */
+#define SMB2_WRITEFLAG_WRITE_THROUGH 0x00000001
+
+struct smb2_write_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__le16 DataOffset; /* offset from start of SMB2 header to write data */
+	__le32 Length;
+	__le64 Offset;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 Channel; /* Reserved MBZ */
+	__le32 RemainingBytes;
+	__le16 WriteChannelInfoOffset; /* Reserved MBZ */
+	__le16 WriteChannelInfoLength; /* Reserved MBZ */
+	__le32 Flags;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_write_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 17 */
+	__u8   DataOffset;
+	__u8   Reserved;
+	__le32 DataLength;
+	__le32 DataRemaining;
+	__u32  Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+#define SMB2_0_IOCTL_IS_FSCTL 0x00000001
+
+struct smb2_ioctl_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 57 */
+	__le16 Reserved; /* offset from start of SMB2 header to write data */
+	__le32 CntCode;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 InputOffset; /* Reserved MBZ */
+	__le32 InputCount;
+	__le32 MaxInputResponse;
+	__le32 OutputOffset;
+	__le32 OutputCount;
+	__le32 MaxOutputResponse;
+	__le32 Flags;
+	__le32 Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_ioctl_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 49 */
+	__le16 Reserved; /* offset from start of SMB2 header to write data */
+	__le32 CntCode;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le32 InputOffset; /* Reserved MBZ */
+	__le32 InputCount;
+	__le32 OutputOffset;
+	__le32 OutputCount;
+	__le32 Flags;
+	__le32 Reserved2;
+	__u8   Buffer[1];
+} __packed;
+
+struct validate_negotiate_info_req {
+	__le32 Capabilities;
+	__u8   Guid[SMB2_CLIENT_GUID_SIZE];
+	__le16 SecurityMode;
+	__le16 DialectCount;
+	__le16 Dialects[1]; /* dialect (someday maybe list) client asked for */
+} __packed;
+
+struct validate_negotiate_info_rsp {
+	__le32 Capabilities;
+	__u8   Guid[SMB2_CLIENT_GUID_SIZE];
+	__le16 SecurityMode;
+	__le16 Dialect; /* Dialect in use for the connection */
+} __packed;
+
+struct smb_sockaddr_in {
+	__be16 Port;
+	__be32 IPv4address;
+	__u8 Reserved[8];
+} __packed;
+
+struct smb_sockaddr_in6 {
+	__be16 Port;
+	__be32 FlowInfo;
+	__u8 IPv6address[16];
+	__be32 ScopeId;
+} __packed;
+
+#define INTERNETWORK	0x0002
+#define INTERNETWORKV6	0x0017
+
+struct sockaddr_storage_rsp {
+	__le16 Family;
+	union {
+		struct smb_sockaddr_in addr4;
+		struct smb_sockaddr_in6 addr6;
+	};
+} __packed;
+
+#define RSS_CAPABLE	0x00000001
+#define RDMA_CAPABLE	0x00000002
+
+struct network_interface_info_ioctl_rsp {
+	__le32 Next; /* next interface. zero if this is last one */
+	__le32 IfIndex;
+	__le32 Capability; /* RSS or RDMA Capable */
+	__le32 Reserved;
+	__le64 LinkSpeed;
+	char	SockAddr_Storage[128];
+} __packed;
+
+struct file_object_buf_type1_ioctl_rsp {
+	__u8 ObjectId[16];
+	__u8 BirthVolumeId[16];
+	__u8 BirthObjectId[16];
+	__u8 DomainId[16];
+} __packed;
+
+struct resume_key_ioctl_rsp {
+	__le64 ResumeKey[3];
+	__le32 ContextLength;
+	__u8 Context[4]; /* ignored, Windows sets to 4 bytes of zero */
+} __packed;
+
+struct copychunk_ioctl_req {
+	__le64 ResumeKey[3];
+	__le32 ChunkCount;
+	__le32 Reserved;
+	__u8 Chunks[1]; /* array of srv_copychunk */
+} __packed;
+
+struct srv_copychunk {
+	__le64 SourceOffset;
+	__le64 TargetOffset;
+	__le32 Length;
+	__le32 Reserved;
+} __packed;
+
+struct copychunk_ioctl_rsp {
+	__le32 ChunksWritten;
+	__le32 ChunkBytesWritten;
+	__le32 TotalBytesWritten;
+} __packed;
+
+struct file_sparse {
+	__u8	SetSparse;
+} __packed;
+
+struct file_zero_data_information {
+	__le64	FileOffset;
+	__le64	BeyondFinalZero;
+} __packed;
+
+struct file_allocated_range_buffer {
+	__le64	file_offset;
+	__le64	length;
+} __packed;
+
+struct reparse_data_buffer {
+	__le32	ReparseTag;
+	__le16	ReparseDataLength;
+	__u16	Reserved;
+	__u8	DataBuffer[]; /* Variable Length */
+} __packed;
+
+/* Completion Filter flags for Notify */
+#define FILE_NOTIFY_CHANGE_FILE_NAME	0x00000001
+#define FILE_NOTIFY_CHANGE_DIR_NAME	0x00000002
+#define FILE_NOTIFY_CHANGE_NAME		0x00000003
+#define FILE_NOTIFY_CHANGE_ATTRIBUTES	0x00000004
+#define FILE_NOTIFY_CHANGE_SIZE		0x00000008
+#define FILE_NOTIFY_CHANGE_LAST_WRITE	0x00000010
+#define FILE_NOTIFY_CHANGE_LAST_ACCESS	0x00000020
+#define FILE_NOTIFY_CHANGE_CREATION	0x00000040
+#define FILE_NOTIFY_CHANGE_EA		0x00000080
+#define FILE_NOTIFY_CHANGE_SECURITY	0x00000100
+#define FILE_NOTIFY_CHANGE_STREAM_NAME	0x00000200
+#define FILE_NOTIFY_CHANGE_STREAM_SIZE	0x00000400
+#define FILE_NOTIFY_CHANGE_STREAM_WRITE	0x00000800
+
+/* Flags */
+#define SMB2_WATCH_TREE	0x0001
+
+struct smb2_notify_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 32 */
+	__le16 Flags;
+	__le32 OutputBufferLength;
+	__le64 PersistentFileId;
+	__le64 VolatileFileId;
+	__u32 CompletionFileter;
+	__u32 Reserved;
+} __packed;
+
+struct smb2_notify_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8 Buffer[1];
+} __packed;
+
+/* SMB2 Notify Action Flags */
+#define FILE_ACTION_ADDED		0x00000001
+#define FILE_ACTION_REMOVED		0x00000002
+#define FILE_ACTION_MODIFIED		0x00000003
+#define FILE_ACTION_RENAMED_OLD_NAME	0x00000004
+#define FILE_ACTION_RENAMED_NEW_NAME	0x00000005
+#define FILE_ACTION_ADDED_STREAM	0x00000006
+#define FILE_ACTION_REMOVED_STREAM	0x00000007
+#define FILE_ACTION_MODIFIED_STREAM	0x00000008
+#define FILE_ACTION_REMOVED_BY_DELETE	0x00000009
+
+#define SMB2_LOCKFLAG_SHARED		0x0001
+#define SMB2_LOCKFLAG_EXCLUSIVE		0x0002
+#define SMB2_LOCKFLAG_UNLOCK		0x0004
+#define SMB2_LOCKFLAG_FAIL_IMMEDIATELY	0x0010
+#define SMB2_LOCKFLAG_MASK		0x0007
+
+struct smb2_lock_element {
+	__le64 Offset;
+	__le64 Length;
+	__le32 Flags;
+	__le32 Reserved;
+} __packed;
+
+struct smb2_lock_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 48 */
+	__le16 LockCount;
+	__le32 Reserved;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	/* Followed by at least one */
+	struct smb2_lock_element locks[1];
+} __packed;
+
+struct smb2_lock_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 4 */
+	__le16 Reserved;
+} __packed;
+
+struct smb2_echo_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__u16  Reserved;
+} __packed;
+
+struct smb2_echo_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 4 */
+	__u16  Reserved;
+} __packed;
+
+/* search (query_directory) Flags field */
+#define SMB2_RESTART_SCANS		0x01
+#define SMB2_RETURN_SINGLE_ENTRY	0x02
+#define SMB2_INDEX_SPECIFIED		0x04
+#define SMB2_REOPEN			0x10
+
+struct smb2_query_directory_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 33 */
+	__u8   FileInformationClass;
+	__u8   Flags;
+	__le32 FileIndex;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__le16 FileNameOffset;
+	__le16 FileNameLength;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_query_directory_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+/* Possible InfoType values */
+#define SMB2_O_INFO_FILE	0x01
+#define SMB2_O_INFO_FILESYSTEM	0x02
+#define SMB2_O_INFO_SECURITY	0x03
+#define SMB2_O_INFO_QUOTA	0x04
+
+/* Security info type additionalinfo flags. See MS-SMB2 (2.2.37) or MS-DTYP */
+#define OWNER_SECINFO   0x00000001
+#define GROUP_SECINFO   0x00000002
+#define DACL_SECINFO   0x00000004
+#define SACL_SECINFO   0x00000008
+#define LABEL_SECINFO   0x00000010
+#define ATTRIBUTE_SECINFO   0x00000020
+#define SCOPE_SECINFO   0x00000040
+#define BACKUP_SECINFO   0x00010000
+#define UNPROTECTED_SACL_SECINFO   0x10000000
+#define UNPROTECTED_DACL_SECINFO   0x20000000
+#define PROTECTED_SACL_SECINFO   0x40000000
+#define PROTECTED_DACL_SECINFO   0x80000000
+
+struct smb2_query_info_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 41 */
+	__u8   InfoType;
+	__u8   FileInfoClass;
+	__le32 OutputBufferLength;
+	__le16 InputBufferOffset;
+	__u16  Reserved;
+	__le32 InputBufferLength;
+	__le32 AdditionalInformation;
+	__le32 Flags;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_query_info_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 9 */
+	__le16 OutputBufferOffset;
+	__le32 OutputBufferLength;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_set_info_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 33 */
+	__u8   InfoType;
+	__u8   FileInfoClass;
+	__le32 BufferLength;
+	__le16 BufferOffset;
+	__u16  Reserved;
+	__le32 AdditionalInformation;
+	__le64  PersistentFileId;
+	__le64  VolatileFileId;
+	__u8   Buffer[1];
+} __packed;
+
+struct smb2_set_info_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 2 */
+} __packed;
+
+
+/* FILE Info response size */
+#define FILE_DIRECTORY_INFORMATION_SIZE       1
+#define FILE_FULL_DIRECTORY_INFORMATION_SIZE  2
+#define FILE_BOTH_DIRECTORY_INFORMATION_SIZE  3
+#define FILE_BASIC_INFORMATION_SIZE           40
+#define FILE_STANDARD_INFORMATION_SIZE        24
+#define FILE_INTERNAL_INFORMATION_SIZE        8
+#define FILE_EA_INFORMATION_SIZE              4
+#define FILE_ACCESS_INFORMATION_SIZE          4
+#define FILE_NAME_INFORMATION_SIZE            9
+#define FILE_RENAME_INFORMATION_SIZE          10
+#define FILE_LINK_INFORMATION_SIZE            11
+#define FILE_NAMES_INFORMATION_SIZE           12
+#define FILE_DISPOSITION_INFORMATION_SIZE     13
+#define FILE_POSITION_INFORMATION_SIZE        14
+#define FILE_FULL_EA_INFORMATION_SIZE         15
+#define FILE_MODE_INFORMATION_SIZE            4
+#define FILE_ALIGNMENT_INFORMATION_SIZE       4
+#define FILE_ALL_INFORMATION_SIZE             104
+#define FILE_ALLOCATION_INFORMATION_SIZE      19
+#define FILE_END_OF_FILE_INFORMATION_SIZE     20
+#define FILE_ALTERNATE_NAME_INFORMATION_SIZE  8
+#define FILE_STREAM_INFORMATION_SIZE          32
+#define FILE_PIPE_INFORMATION_SIZE            23
+#define FILE_PIPE_LOCAL_INFORMATION_SIZE      24
+#define FILE_PIPE_REMOTE_INFORMATION_SIZE     25
+#define FILE_MAILSLOT_QUERY_INFORMATION_SIZE  26
+#define FILE_MAILSLOT_SET_INFORMATION_SIZE    27
+#define FILE_COMPRESSION_INFORMATION_SIZE     16
+#define FILE_OBJECT_ID_INFORMATION_SIZE       29
+/* Number 30 not defined in documents */
+#define FILE_MOVE_CLUSTER_INFORMATION_SIZE    31
+#define FILE_QUOTA_INFORMATION_SIZE           32
+#define FILE_REPARSE_POINT_INFORMATION_SIZE   33
+#define FILE_NETWORK_OPEN_INFORMATION_SIZE    56
+#define FILE_ATTRIBUTE_TAG_INFORMATION_SIZE   8
+
+
+/* FS Info response  size */
+#define FS_DEVICE_INFORMATION_SIZE     8
+#define FS_ATTRIBUTE_INFORMATION_SIZE  16
+#define FS_VOLUME_INFORMATION_SIZE     24
+#define FS_SIZE_INFORMATION_SIZE       24
+#define FS_FULL_SIZE_INFORMATION_SIZE  32
+#define FS_SECTOR_SIZE_INFORMATION_SIZE 28
+#define FS_OBJECT_ID_INFORMATION_SIZE 64
+#define FS_CONTROL_INFORMATION_SIZE 48
+#define FS_POSIX_INFORMATION_SIZE 56
+
+/* FS_ATTRIBUTE_File_System_Name */
+#define FS_TYPE_SUPPORT_SIZE   44
+struct fs_type_info {
+	char		*fs_name;
+	long		magic_number;
+} __packed;
+
+struct smb2_oplock_break {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 24 */
+	__u8   OplockLevel;
+	__u8   Reserved;
+	__le32 Reserved2;
+	__le64  PersistentFid;
+	__le64  VolatileFid;
+} __packed;
+
+#define SMB2_NOTIFY_BREAK_LEASE_FLAG_ACK_REQUIRED cpu_to_le32(0x01)
+
+struct smb2_lease_break {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 44 */
+	__le16 Reserved;
+	__le32 Flags;
+	__u8   LeaseKey[16];
+	__le32 CurrentLeaseState;
+	__le32 NewLeaseState;
+	__le32 BreakReason;
+	__le32 AccessMaskHint;
+	__le32 ShareMaskHint;
+} __packed;
+
+struct smb2_lease_ack {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 36 */
+	__le16 Reserved;
+	__le32 Flags;
+	__u8   LeaseKey[16];
+	__le32 LeaseState;
+	__le64 LeaseDuration;
+} __packed;
+
+/*
+ *	PDU infolevel structure definitions
+ *	BB consider moving to a different header
+ */
+
+/* File System Information Classes */
+#define FS_VOLUME_INFORMATION		1 /* Query */
+#define FS_LABEL_INFORMATION		2 /* Set */
+#define FS_SIZE_INFORMATION		3 /* Query */
+#define FS_DEVICE_INFORMATION		4 /* Query */
+#define FS_ATTRIBUTE_INFORMATION	5 /* Query */
+#define FS_CONTROL_INFORMATION		6 /* Query, Set */
+#define FS_FULL_SIZE_INFORMATION	7 /* Query */
+#define FS_OBJECT_ID_INFORMATION	8 /* Query, Set */
+#define FS_DRIVER_PATH_INFORMATION	9 /* Query */
+#define FS_SECTOR_SIZE_INFORMATION	11 /* SMB3 or later. Query */
+#define FS_POSIX_INFORMATION		100 /* SMB3.1.1 POSIX. Query */
+
+struct smb2_fs_full_size_info {
+	__le64 TotalAllocationUnits;
+	__le64 CallerAvailableAllocationUnits;
+	__le64 ActualAvailableAllocationUnits;
+	__le32 SectorsPerAllocationUnit;
+	__le32 BytesPerSector;
+} __packed;
+
+#define SSINFO_FLAGS_ALIGNED_DEVICE		0x00000001
+#define SSINFO_FLAGS_PARTITION_ALIGNED_ON_DEVICE 0x00000002
+#define SSINFO_FLAGS_NO_SEEK_PENALTY		0x00000004
+#define SSINFO_FLAGS_TRIM_ENABLED		0x00000008
+
+/* sector size info struct */
+struct smb3_fs_ss_info {
+	__le32 LogicalBytesPerSector;
+	__le32 PhysicalBytesPerSectorForAtomicity;
+	__le32 PhysicalBytesPerSectorForPerf;
+	__le32 FSEffPhysicalBytesPerSectorForAtomicity;
+	__le32 Flags;
+	__le32 ByteOffsetForSectorAlignment;
+	__le32 ByteOffsetForPartitionAlignment;
+} __packed;
+
+/* File System Control Information */
+struct smb2_fs_control_info {
+	__le64 FreeSpaceStartFiltering;
+	__le64 FreeSpaceThreshold;
+	__le64 FreeSpaceStopFiltering;
+	__le64 DefaultQuotaThreshold;
+	__le64 DefaultQuotaLimit;
+	__le32 FileSystemControlFlags;
+	__le32 Padding;
+} __packed;
+
+/* partial list of QUERY INFO levels */
+#define FILE_DIRECTORY_INFORMATION	1
+#define FILE_FULL_DIRECTORY_INFORMATION 2
+#define FILE_BOTH_DIRECTORY_INFORMATION 3
+#define FILE_BASIC_INFORMATION		4
+#define FILE_STANDARD_INFORMATION	5
+#define FILE_INTERNAL_INFORMATION	6
+#define FILE_EA_INFORMATION	        7
+#define FILE_ACCESS_INFORMATION		8
+#define FILE_NAME_INFORMATION		9
+#define FILE_RENAME_INFORMATION		10
+#define FILE_LINK_INFORMATION		11
+#define FILE_NAMES_INFORMATION		12
+#define FILE_DISPOSITION_INFORMATION	13
+#define FILE_POSITION_INFORMATION	14
+#define FILE_FULL_EA_INFORMATION	15
+#define FILE_MODE_INFORMATION		16
+#define FILE_ALIGNMENT_INFORMATION	17
+#define FILE_ALL_INFORMATION		18
+#define FILE_ALLOCATION_INFORMATION	19
+#define FILE_END_OF_FILE_INFORMATION	20
+#define FILE_ALTERNATE_NAME_INFORMATION 21
+#define FILE_STREAM_INFORMATION		22
+#define FILE_PIPE_INFORMATION		23
+#define FILE_PIPE_LOCAL_INFORMATION	24
+#define FILE_PIPE_REMOTE_INFORMATION	25
+#define FILE_MAILSLOT_QUERY_INFORMATION 26
+#define FILE_MAILSLOT_SET_INFORMATION	27
+#define FILE_COMPRESSION_INFORMATION	28
+#define FILE_OBJECT_ID_INFORMATION	29
+/* Number 30 not defined in documents */
+#define FILE_MOVE_CLUSTER_INFORMATION	31
+#define FILE_QUOTA_INFORMATION		32
+#define FILE_REPARSE_POINT_INFORMATION	33
+#define FILE_NETWORK_OPEN_INFORMATION	34
+#define FILE_ATTRIBUTE_TAG_INFORMATION	35
+#define FILE_TRACKING_INFORMATION	36
+#define FILEID_BOTH_DIRECTORY_INFORMATION 37
+#define FILEID_FULL_DIRECTORY_INFORMATION 38
+#define FILE_VALID_DATA_LENGTH_INFORMATION 39
+#define FILE_SHORT_NAME_INFORMATION	40
+#define FILE_SFIO_RESERVE_INFORMATION	44
+#define FILE_SFIO_VOLUME_INFORMATION	45
+#define FILE_HARD_LINK_INFORMATION	46
+#define FILE_NORMALIZED_NAME_INFORMATION 48
+#define FILEID_GLOBAL_TX_DIRECTORY_INFORMATION 50
+#define FILE_STANDARD_LINK_INFORMATION	54
+
+#define OP_BREAK_STRUCT_SIZE_20		24
+#define OP_BREAK_STRUCT_SIZE_21		36
+
+struct smb2_file_access_info {
+	__le32 AccessFlags;
+} __packed;
+
+struct smb2_file_alignment_info {
+	__le32 AlignmentRequirement;
+} __packed;
+
+struct smb2_file_internal_info {
+	__le64 IndexNumber;
+} __packed; /* level 6 Query */
+
+struct smb2_file_rename_info { /* encoding of request for level 10 */
+	__u8   ReplaceIfExists; /* 1 = replace existing target with new */
+				/* 0 = fail if target already exists */
+	__u8   Reserved[7];
+	__u64  RootDirectory;  /* MBZ for network operations (why says spec?) */
+	__le32 FileNameLength;
+	char   FileName[0];     /* New name to be assigned */
+} __packed; /* level 10 Set */
+
+struct smb2_file_link_info { /* encoding of request for level 11 */
+	__u8   ReplaceIfExists; /* 1 = replace existing link with new */
+				/* 0 = fail if link already exists */
+	__u8   Reserved[7];
+	__u64  RootDirectory;  /* MBZ for network operations (why says spec?) */
+	__le32 FileNameLength;
+	char   FileName[0];     /* Name to be assigned to new link */
+} __packed; /* level 11 Set */
+
+/*
+ * This level 18, although with struct with same name is different from cifs
+ * level 0x107. Level 0x107 has an extra u64 between AccessFlags and
+ * CurrentByteOffset.
+ */
+struct smb2_file_all_info { /* data block encoding of response to level 18 */
+	__le64 CreationTime;	/* Beginning of FILE_BASIC_INFO equivalent */
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le32 Attributes;
+	__u32  Pad1;		/* End of FILE_BASIC_INFO_INFO equivalent */
+	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
+	__le64 EndOfFile;	/* size ie offset to first free byte in file */
+	__le32 NumberOfLinks;	/* hard links */
+	__u8   DeletePending;
+	__u8   Directory;
+	__u16  Pad2;		/* End of FILE_STANDARD_INFO equivalent */
+	__le64 IndexNumber;
+	__le32 EASize;
+	__le32 AccessFlags;
+	__le64 CurrentByteOffset;
+	__le32 Mode;
+	__le32 AlignmentRequirement;
+	__le32 FileNameLength;
+	char   FileName[1];
+} __packed; /* level 18 Query */
+
+struct smb2_file_alt_name_info {
+	__le32 FileNameLength;
+	char FileName[0];
+} __packed;
+
+struct smb2_file_stream_info {
+	__le32  NextEntryOffset;
+	__le32  StreamNameLength;
+	__le64 StreamSize;
+	__le64 StreamAllocationSize;
+	char   StreamName[0];
+} __packed;
+
+struct smb2_file_eof_info { /* encoding of request for level 10 */
+	__le64 EndOfFile; /* new end of file value */
+} __packed; /* level 20 Set */
+
+struct smb2_file_ntwrk_info {
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 AllocationSize;
+	__le64 EndOfFile;
+	__le32 Attributes;
+	__le32 Reserved;
+} __packed;
+
+struct smb2_file_standard_info {
+	__le64 AllocationSize;
+	__le64 EndOfFile;
+	__le32 NumberOfLinks;	/* hard links */
+	__u8   DeletePending;
+	__u8   Directory;
+	__le16 Reserved;
+} __packed; /* level 18 Query */
+
+struct smb2_file_ea_info {
+	__le32 EASize;
+} __packed;
+
+struct smb2_file_alloc_info {
+	__le64 AllocationSize;
+} __packed;
+
+struct smb2_file_disposition_info {
+	__u8 DeletePending;
+} __packed;
+
+struct smb2_file_pos_info {
+	__le64 CurrentByteOffset;
+} __packed;
+
+#define FILE_MODE_INFO_MASK cpu_to_le32(0x0000103e)
+
+struct smb2_file_mode_info {
+	__le32 Mode;
+} __packed;
+
+#define COMPRESSION_FORMAT_NONE 0x0000
+#define COMPRESSION_FORMAT_LZNT1 0x0002
+
+struct smb2_file_comp_info {
+	__le64 CompressedFileSize;
+	__le16 CompressionFormat;
+	__u8 CompressionUnitShift;
+	__u8 ChunkShift;
+	__u8 ClusterShift;
+	__u8 Reserved[3];
+} __packed;
+
+struct smb2_file_attr_tag_info {
+	__le32 FileAttributes;
+	__le32 ReparseTag;
+} __packed;
+
+#define SL_RESTART_SCAN	0x00000001
+#define SL_RETURN_SINGLE_ENTRY	0x00000002
+#define SL_INDEX_SPECIFIED	0x00000004
+
+struct smb2_ea_info_req {
+	__le32 NextEntryOffset;
+	__u8   EaNameLength;
+	char name[1];
+} __packed; /* level 15 Query */
+
+struct smb2_ea_info {
+	__le32 NextEntryOffset;
+	__u8   Flags;
+	__u8   EaNameLength;
+	__le16 EaValueLength;
+	char name[1];
+	/* optionally followed by value */
+} __packed; /* level 15 Query */
+
+struct create_ea_buf_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct smb2_ea_info ea;
+} __packed;
+
+struct create_sd_buf_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	struct smb_ntsd ntsd;
+} __packed;
+
+/* Find File infolevels */
+#define SMB_FIND_FILE_POSIX_INFO	0x064
+
+/* Level 100 query info */
+struct smb311_posix_qinfo {
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 DosAttributes;
+	__le64 Inode;
+	__le32 DeviceId;
+	__le32 Zero;
+	/* beginning of POSIX Create Context Response */
+	__le32 HardLinks;
+	__le32 ReparseTag;
+	__le32 Mode;
+	u8     Sids[];
+	/*
+	 * var sized owner SID
+	 * var sized group SID
+	 * le32 filenamelength
+	 * u8  filename[]
+	 */
+} __packed;
+
+struct smb2_posix_info {
+	__le32 NextEntryOffset;
+	__u32 Ignored;
+	__le64 CreationTime;
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le64 EndOfFile;
+	__le64 AllocationSize;
+	__le32 DosAttributes;
+	__le64 Inode;
+	__le32 DeviceId;
+	__le32 Zero;
+	/* beginning of POSIX Create Context Response */
+	__le32 HardLinks;
+	__le32 ReparseTag;
+	__le32 Mode;
+	u8 SidBuffer[40];
+	__le32 name_len;
+	u8 name[1];
+	/*
+	 * var sized owner SID
+	 * var sized group SID
+	 * le32 filenamelength
+	 * u8  filename[]
+	 */
+} __packed;
+
+/* functions */
+
+extern int init_smb2_0_server(struct ksmbd_conn *conn);
+extern void init_smb2_1_server(struct ksmbd_conn *conn);
+extern void init_smb3_0_server(struct ksmbd_conn *conn);
+extern void init_smb3_02_server(struct ksmbd_conn *conn);
+extern int init_smb3_11_server(struct ksmbd_conn *conn);
+
+extern void init_smb2_max_read_size(unsigned int sz);
+extern void init_smb2_max_write_size(unsigned int sz);
+extern void init_smb2_max_trans_size(unsigned int sz);
+
+extern int is_smb2_neg_cmd(struct ksmbd_work *work);
+extern int is_smb2_rsp(struct ksmbd_work *work);
+
+extern uint16_t get_smb2_cmd_val(struct ksmbd_work *work);
+extern void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err);
+extern int init_smb2_rsp_hdr(struct ksmbd_work *work);
+extern int smb2_allocate_rsp_buf(struct ksmbd_work *work);
+extern bool is_chained_smb2_message(struct ksmbd_work *work);
+extern int init_smb2_neg_rsp(struct ksmbd_work *work);
+extern void smb2_set_err_rsp(struct ksmbd_work *work);
+extern int smb2_check_user_session(struct ksmbd_work *work);
+extern int smb2_get_ksmbd_tcon(struct ksmbd_work *work);
+extern bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command);
+extern int smb2_check_sign_req(struct ksmbd_work *work);
+extern void smb2_set_sign_rsp(struct ksmbd_work *work);
+extern int smb3_check_sign_req(struct ksmbd_work *work);
+extern void smb3_set_sign_rsp(struct ksmbd_work *work);
+extern int find_matching_smb2_dialect(int start_index, __le16 *cli_dialects,
+	__le16 dialects_count);
+extern struct file_lock *smb_flock_init(struct file *f);
+extern int setup_async_work(struct ksmbd_work *work, void (*fn)(void **),
+	void **arg);
+extern void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status);
+extern struct channel *lookup_chann_list(struct ksmbd_session *sess);
+extern void smb3_preauth_hash_rsp(struct ksmbd_work *work);
+extern int smb3_is_transform_hdr(void *buf);
+extern int smb3_decrypt_req(struct ksmbd_work *work);
+extern int smb3_encrypt_resp(struct ksmbd_work *work);
+extern bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work);
+extern int smb2_set_rsp_credits(struct ksmbd_work *work);
+
+/* smb2 misc functions */
+extern int ksmbd_smb2_check_message(struct ksmbd_work *work);
+
+/* smb2 command handlers */
+extern int smb2_handle_negotiate(struct ksmbd_work *work);
+extern int smb2_negotiate_request(struct ksmbd_work *work);
+extern int smb2_sess_setup(struct ksmbd_work *work);
+extern int smb2_tree_connect(struct ksmbd_work *work);
+extern int smb2_tree_disconnect(struct ksmbd_work *work);
+extern int smb2_session_logoff(struct ksmbd_work *work);
+extern int smb2_open(struct ksmbd_work *work);
+extern int smb2_query_info(struct ksmbd_work *work);
+extern int smb2_query_dir(struct ksmbd_work *work);
+extern int smb2_close(struct ksmbd_work *work);
+extern int smb2_echo(struct ksmbd_work *work);
+extern int smb2_set_info(struct ksmbd_work *work);
+extern int smb2_read(struct ksmbd_work *work);
+extern int smb2_write(struct ksmbd_work *work);
+extern int smb2_flush(struct ksmbd_work *work);
+extern int smb2_cancel(struct ksmbd_work *work);
+extern int smb2_lock(struct ksmbd_work *work);
+extern int smb2_ioctl(struct ksmbd_work *work);
+extern int smb2_oplock_break(struct ksmbd_work *work);
+extern int smb2_notify(struct ksmbd_work *ksmbd_work);
+
+#endif	/* _SMB2PDU_H */
diff --git a/fs/cifsd/smb_common.c b/fs/cifsd/smb_common.c
new file mode 100644
index 000000000000..2f58ef003238
--- /dev/null
+++ b/fs/cifsd/smb_common.c
@@ -0,0 +1,667 @@
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
+#define MANGLE_BASE       (sizeof(basechars)/sizeof(char)-1)
+#define MAGIC_CHAR '~'
+#define PERIOD '.'
+#define mangle(V) ((char)(basechars[(V) % MANGLE_BASE]))
+#define KSMBD_MIN_SUPPORTED_HEADER_SIZE	(sizeof(struct smb2_hdr))
+
+LIST_HEAD(global_lock_list);
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
+					smb_protos[offt].prot, offt);
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
+	struct smb2_hdr *smb2_hdr = REQUEST_BUF(work);
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
+			idx <= server_conf.max_protocol);
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
+				dialect);
+			if (!strcmp(dialect, smb_protos[i].name)) {
+				if (supported_protocol(smb_protos[i].index)) {
+					ksmbd_debug(SMB,
+						"selected %s dialect\n",
+						smb_protos[i].name);
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
+				le16_to_cpu(cli_dialects[count]));
+			if (le16_to_cpu(cli_dialects[count]) !=
+					smb_protos[i].prot_id)
+				continue;
+
+			if (supported_protocol(smb_protos[i].index)) {
+				ksmbd_debug(SMB, "selected %s dialect\n",
+					smb_protos[i].name);
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
+int ksmbd_populate_dot_dotdot_entries(struct ksmbd_work *work,
+				      int info_level,
+				      struct ksmbd_file *dir,
+				      struct ksmbd_dir_info *d_info,
+				      char *search_pattern,
+				      int (*fn)(struct ksmbd_conn *,
+						int,
+						struct ksmbd_dir_info *,
+						struct ksmbd_kstat *))
+{
+	int i, rc = 0;
+	struct ksmbd_conn *conn = work->conn;
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
+					search_pattern)) {
+				dir->dot_dotdot[i] = 1;
+				continue;
+			}
+
+			ksmbd_kstat.kstat = &kstat;
+			ksmbd_vfs_fill_dentry_attrs(work,
+				dir->filp->f_path.dentry->d_parent,
+				&ksmbd_kstat);
+			rc = fn(conn, info_level, d_info, &ksmbd_kstat);
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
+int ksmbd_extract_shortname(struct ksmbd_conn *conn,
+			    const char *longname,
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
+		if (p != NULL) {
+			p++;
+			while (*p && extlen < 3) {
+				if (*p != '.')
+					extension[extlen++] = toupper(*p);
+				p++;
+			}
+			extension[extlen] = '\0';
+		} else
+			dot_present = false;
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
+	memcpy(out, base, baselen+1);
+
+	ptr = longname;
+	len = strlen(longname);
+	for (; len > 0; len--, ptr++)
+		csum += *ptr;
+
+	csum = csum % (MANGLE_BASE * MANGLE_BASE);
+	out[baselen+1] = mangle(csum/MANGLE_BASE);
+	out[baselen+2] = mangle(csum);
+	out[baselen+3] = PERIOD;
+
+	if (dot_present)
+		memcpy(&out[baselen+4], extension, 4);
+	else
+		out[baselen+4] = '\0';
+	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
+			conn->local_nls, 0);
+	len = strlen(out) * 2;
+	return len;
+}
+
+static int __smb2_negotiate(struct ksmbd_conn *conn)
+{
+	return (conn->dialect >= SMB20_PROT_ID &&
+			conn->dialect <= SMB311_PROT_ID);
+}
+
+static int smb_handle_negotiate(struct ksmbd_work *work)
+{
+	struct smb_negotiate_rsp *neg_rsp = RESPONSE_BUF(work);
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
+	conn->dialect = ksmbd_negotiate_smb_dialect(REQUEST_BUF(work));
+	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
+
+	if (command == SMB2_NEGOTIATE_HE) {
+		struct smb2_hdr *smb2_hdr = REQUEST_BUF(work);
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
+	ksmbd_err("Unknown SMB negotiation command: %u\n", command);
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
+static void smb_shared_mode_error(int error,
+				  struct ksmbd_file *prev_fp,
+				  struct ksmbd_file *curr_fp)
+{
+	ksmbd_debug(SMB, "%s\n", shared_mode_errors[error]);
+	ksmbd_debug(SMB, "Current mode: 0x%x Desired mode: 0x%x\n",
+		  prev_fp->saccess, curr_fp->daccess);
+}
+
+int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
+{
+	int rc = 0;
+	struct ksmbd_file *prev_fp;
+	struct list_head *cur;
+
+	/*
+	 * Lookup fp in master fp list, and check desired access and
+	 * shared mode between previous open and current open.
+	 */
+	read_lock(&curr_fp->f_ci->m_lock);
+	list_for_each(cur, &curr_fp->f_ci->m_fp_list) {
+		prev_fp = list_entry(cur, struct ksmbd_file, node);
+		if (file_inode(filp) != FP_INODE(prev_fp))
+			continue;
+
+		if (filp == prev_fp->filp)
+			continue;
+
+		if (ksmbd_stream_fd(prev_fp) && ksmbd_stream_fd(curr_fp))
+			if (strcmp(prev_fp->stream.name, curr_fp->stream.name))
+				continue;
+
+		if (prev_fp->is_durable) {
+			prev_fp->is_durable = 0;
+			continue;
+		}
+
+		if (prev_fp->attrib_only != curr_fp->attrib_only)
+			continue;
+
+		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE) &&
+				curr_fp->daccess & FILE_DELETE_LE) {
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
+				curr_fp->daccess & (FILE_EXECUTE_LE |
+					FILE_READ_DATA_LE)) {
+			smb_shared_mode_error(SHARE_READ_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (!(prev_fp->saccess & FILE_SHARE_WRITE_LE) &&
+				curr_fp->daccess & (FILE_WRITE_DATA_LE |
+					FILE_APPEND_DATA_LE)) {
+			smb_shared_mode_error(SHARE_WRITE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & (FILE_EXECUTE_LE |
+					FILE_READ_DATA_LE) &&
+				!(curr_fp->saccess & FILE_SHARE_READ_LE)) {
+			smb_shared_mode_error(FILE_READ_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & (FILE_WRITE_DATA_LE |
+					FILE_APPEND_DATA_LE) &&
+				!(curr_fp->saccess & FILE_SHARE_WRITE_LE)) {
+			smb_shared_mode_error(FILE_WRITE_ERROR,
+					      prev_fp,
+					      curr_fp);
+			rc = -EPERM;
+			break;
+		}
+
+		if (prev_fp->daccess & FILE_DELETE_LE &&
+				!(curr_fp->saccess & FILE_SHARE_DELETE_LE)) {
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
+	WARN_ON(work->saved_cred != NULL);
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
+	WARN_ON(work->saved_cred == NULL);
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
diff --git a/fs/cifsd/smb_common.h b/fs/cifsd/smb_common.h
new file mode 100644
index 000000000000..ec954e6bc4ae
--- /dev/null
+++ b/fs/cifsd/smb_common.h
@@ -0,0 +1,546 @@
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
+#define SMB_ECHO_INTERVAL	(60*HZ)
+
+#define CIFS_DEFAULT_IOSIZE	(64 * 1024)
+#define MAX_CIFS_SMALL_BUFFER_SIZE 448 /* big enough for most */
+
+extern struct list_head global_lock_list;
+
+#define IS_SMB2(x)		((x)->vals->protocol_id != SMB10_PROT_ID)
+
+#define HEADER_SIZE(conn)		((conn)->vals->header_size)
+#define HEADER_SIZE_NO_BUF_LEN(conn)	((conn)->vals->header_size - 4)
+#define MAX_HEADER_SIZE(conn)		((conn)->vals->max_header_size)
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
+	uint16_t (*get_cmd_val)(struct ksmbd_work *swork);
+	int (*init_rsp_hdr)(struct ksmbd_work *swork);
+	void (*set_rsp_status)(struct ksmbd_work *swork, __le32 err);
+	int (*allocate_rsp_buf)(struct ksmbd_work *work);
+	int (*set_rsp_credits)(struct ksmbd_work *work);
+	int (*check_user_session)(struct ksmbd_work *work);
+	int (*get_ksmbd_tcon)(struct ksmbd_work *work);
+	bool (*is_sign_req)(struct ksmbd_work *work, unsigned int command);
+	int (*check_sign_req)(struct ksmbd_work *work);
+	void (*set_sign_rsp)(struct ksmbd_work *work);
+	int (*generate_signingkey)(struct ksmbd_session *sess);
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
+
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
diff --git a/fs/cifsd/smbacl.c b/fs/cifsd/smbacl.c
new file mode 100644
index 000000000000..7f6d5313a02c
--- /dev/null
+++ b/fs/cifsd/smbacl.c
@@ -0,0 +1,1324 @@
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
+#include "ksmbd_server.h"
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
+int
+compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
+{
+	int i;
+	int num_subauth, num_sat, num_saw;
+
+	if ((!ctsid) || (!cwsid))
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
+					le32_to_cpu(cwsid->sub_auth[i]))
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
+static void
+smb_copy_sid(struct smb_sid *dst, const struct smb_sid *src)
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
+		int type)
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
+	if ((flags & GENERIC_READ) ||
+			(flags & FILE_READ_RIGHTS))
+		mode = 0444;
+	if ((flags & GENERIC_WRITE) ||
+			(flags & FILE_WRITE_RIGHTS)) {
+		mode |= 0222;
+		if (S_ISDIR(fattr->cf_mode))
+			mode |= 0111;
+	}
+	if ((flags & GENERIC_EXECUTE) ||
+			(flags & FILE_EXEC_RIGHTS))
+		mode |= 0111;
+
+	if (type == ACCESS_DENIED_ACE_TYPE ||
+			type == ACCESS_DENIED_OBJECT_ACE_TYPE)
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
+		__u32 *pace_flags)
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
+		 mode, *pace_flags);
+}
+
+static __u16 fill_ace_for_sid(struct smb_ace *pntace,
+		const struct smb_sid *psid, int type, int flags,
+		umode_t mode, umode_t bits)
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
+static int sid_to_id(struct smb_sid *psid, uint sidtype,
+		struct smb_fattr *fattr)
+{
+	int rc = -EINVAL;
+
+	/*
+	 * If we have too many subauthorities, then something is really wrong.
+	 * Just return an error.
+	 */
+	if (unlikely(psid->num_subauth > SID_MAX_SUB_AUTHORITIES)) {
+		ksmbd_err("%s: %u subauthorities is too many!\n",
+			 __func__, psid->num_subauth);
+		return -EIO;
+	}
+
+	if (sidtype == SIDOWNER) {
+		kuid_t uid;
+		uid_t id;
+
+		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
+		if (id > 0) {
+			uid = make_kuid(&init_user_ns, id);
+			if (uid_valid(uid) &&
+				kuid_has_mapping(&init_user_ns, uid)) {
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
+			gid = make_kgid(&init_user_ns, id);
+			if (gid_valid(gid) &&
+				kgid_has_mapping(&init_user_ns, gid)) {
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
+		struct posix_acl_entry *pace)
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
+		+ cnt*sizeof(struct posix_user_ace_state);
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
+static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
+		struct smb_sid *pownersid, struct smb_sid *pgrpsid,
+		struct smb_fattr *fattr)
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
+		ksmbd_err("ACL too small to parse DACL\n");
+		return;
+	}
+
+	ksmbd_debug(SMB, "DACL revision %d size %d num aces %d\n",
+		 le16_to_cpu(pdacl->revision), le16_to_cpu(pdacl->size),
+		 le32_to_cpu(pdacl->num_aces));
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
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *),
+			GFP_KERNEL);
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
+		ppace[i] = (struct smb_ace *) (acl_base + acl_size);
+		acl_base = (char *)ppace[i];
+		acl_size = le16_to_cpu(ppace[i]->size);
+		ppace[i]->access_req =
+			smb_map_generic_desired_access(ppace[i]->access_req);
+
+		if (!(compare_sids(&(ppace[i]->sid), &sid_unix_NFS_mode))) {
+			fattr->cf_mode =
+				le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+			break;
+		} else if (!compare_sids(&(ppace[i]->sid), pownersid)) {
+			acl_mode = access_flags_to_mode(fattr,
+				ppace[i]->access_req, ppace[i]->type);
+			acl_mode &= 0700;
+
+			if (!owner_found) {
+				mode &= ~(0700);
+				mode |= acl_mode;
+			}
+			owner_found = true;
+		} else if (!compare_sids(&(ppace[i]->sid), pgrpsid) ||
+				ppace[i]->sid.sub_auth[ppace[i]->sid.num_subauth - 1] ==
+				DOMAIN_USER_RID_LE) {
+			acl_mode = access_flags_to_mode(fattr,
+				ppace[i]->access_req, ppace[i]->type);
+			acl_mode &= 0070;
+			if (!group_found) {
+				mode &= ~(0070);
+				mode |= acl_mode;
+			}
+			group_found = true;
+		} else if (!compare_sids(&(ppace[i]->sid), &sid_everyone)) {
+			acl_mode = access_flags_to_mode(fattr,
+				ppace[i]->access_req, ppace[i]->type);
+			acl_mode &= 0007;
+			if (!others_found) {
+				mode &= ~(0007);
+				mode |= acl_mode;
+			}
+			others_found = true;
+		} else if (!compare_sids(&(ppace[i]->sid), &creator_owner))
+			continue;
+		else if (!compare_sids(&(ppace[i]->sid), &creator_group))
+			continue;
+		else if (!compare_sids(&(ppace[i]->sid), &sid_authusers))
+			continue;
+		else {
+			struct smb_fattr temp_fattr;
+
+			acl_mode = access_flags_to_mode(fattr, ppace[i]->access_req,
+					ppace[i]->type);
+			temp_fattr.cf_uid = INVALID_UID;
+			ret = sid_to_id(&ppace[i]->sid, SIDOWNER, &temp_fattr);
+			if (ret || uid_eq(temp_fattr.cf_uid, INVALID_UID)) {
+				ksmbd_err("%s: Error %d mapping Owner SID to uid\n",
+						__func__, ret);
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
+		fattr->cf_acls = ksmbd_vfs_posix_acl_alloc(acl_state.users->n +
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
+			ksmbd_vfs_posix_acl_alloc(default_acl_state.users->n +
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
+static void set_posix_acl_entries_dacl(struct smb_ace *pndace,
+		struct smb_fattr *fattr, u32 *num_aces, u16 *size, u32 nt_aces_num)
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
+			uid = from_kuid(&init_user_ns, pace->e_uid);
+			if (!uid)
+				sid_type = SIDUNIX_USER;
+			id_to_sid(uid, sid_type, sid);
+		} else if (pace->e_tag == ACL_GROUP) {
+			gid_t gid;
+
+			gid = from_kgid(&init_user_ns, pace->e_gid);
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
+		ntace = (struct smb_ace *) ((char *)pndace + *size);
+		*size += fill_ace_for_sid(ntace, sid, ACCESS_ALLOWED, flags,
+				pace->e_perm, 0777);
+		(*num_aces)++;
+		if (pace->e_tag == ACL_USER)
+			ntace->access_req |=
+				FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+
+		if (S_ISDIR(fattr->cf_mode) &&
+				(pace->e_tag == ACL_USER || pace->e_tag == ACL_GROUP)) {
+			ntace = (struct smb_ace *) ((char *)pndace + *size);
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
+			uid = from_kuid(&init_user_ns, pace->e_uid);
+			id_to_sid(uid, SIDCREATOR_OWNER, sid);
+		} else if (pace->e_tag == ACL_GROUP) {
+			gid_t gid;
+
+			gid = from_kgid(&init_user_ns, pace->e_gid);
+			id_to_sid(gid, SIDCREATOR_GROUP, sid);
+		} else {
+			kfree(sid);
+			continue;
+		}
+
+		ntace = (struct smb_ace *) ((char *)pndace + *size);
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
+static void set_ntacl_dacl(struct smb_acl *pndacl, struct smb_acl *nt_dacl,
+		const struct smb_sid *pownersid, const struct smb_sid *pgrpsid,
+		struct smb_fattr *fattr)
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
+	set_posix_acl_entries_dacl(pndace, fattr, &num_aces, &size, nt_num_aces);
+	pndacl->num_aces = cpu_to_le32(num_aces);
+	pndacl->size = cpu_to_le16(le16_to_cpu(pndacl->size) + size);
+}
+
+static void set_mode_dacl(struct smb_acl *pndacl, struct smb_fattr *fattr)
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
+		set_posix_acl_entries_dacl(pndace, fattr, &num_aces, &size, num_aces);
+		goto out;
+	}
+
+	/* owner RID */
+	uid = from_kuid(&init_user_ns, fattr->cf_uid);
+	if (uid)
+		sid = &server_conf.domain_sid;
+	else
+		sid = &sid_unix_users;
+	ace_size = fill_ace_for_sid(pace, sid, ACCESS_ALLOWED, 0,
+			fattr->cf_mode, 0700);
+	pace->sid.sub_auth[pace->sid.num_subauth++] = cpu_to_le32(uid);
+	pace->access_req |= FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+	pace->size = cpu_to_le16(ace_size + 4);
+	size += le16_to_cpu(pace->size);
+	pace = (struct smb_ace *)((char *)pndace + size);
+
+	/* Group RID */
+	ace_size = fill_ace_for_sid(pace, &sid_unix_groups,
+			ACCESS_ALLOWED, 0, fattr->cf_mode, 0070);
+	pace->sid.sub_auth[pace->sid.num_subauth++] =
+		cpu_to_le32(from_kgid(&init_user_ns, fattr->cf_gid));
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
+				0x0b, fattr->cf_mode, 0700);
+		pace->access_req |= FILE_DELETE_LE | FILE_DELETE_CHILD_LE;
+		pace = (struct smb_ace *)((char *)pndace + size);
+
+		/* creator group */
+		size += fill_ace_for_sid(pace, &creator_group, ACCESS_ALLOWED,
+				0x0b, fattr->cf_mode, 0070);
+		pace = (struct smb_ace *)((char *)pndace + size);
+		num_aces = 5;
+	}
+
+	/* other */
+	size += fill_ace_for_sid(pace, &sid_everyone, ACCESS_ALLOWED, 0,
+			fattr->cf_mode, 0007);
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
+		ksmbd_err("ACL too small to parse SID %p\n", psid);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/* Convert CIFS ACL to POSIX form */
+int parse_sec_desc(struct smb_ntsd *pntsd, int acl_len,
+		struct smb_fattr *fattr)
+{
+	int rc = 0;
+	struct smb_sid *owner_sid_ptr, *group_sid_ptr;
+	struct smb_acl *dacl_ptr; /* no need for SACL ptr */
+	char *end_of_acl = ((char *)pntsd) + acl_len;
+	__u32 dacloffset;
+	int pntsd_type;
+
+	if (pntsd == NULL)
+		return -EIO;
+
+	owner_sid_ptr = (struct smb_sid *)((char *)pntsd +
+			le32_to_cpu(pntsd->osidoffset));
+	group_sid_ptr = (struct smb_sid *)((char *)pntsd +
+			le32_to_cpu(pntsd->gsidoffset));
+	dacloffset = le32_to_cpu(pntsd->dacloffset);
+	dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
+	ksmbd_debug(SMB,
+		"revision %d type 0x%x ooffset 0x%x goffset 0x%x sacloffset 0x%x dacloffset 0x%x\n",
+		 pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoffset),
+		 le32_to_cpu(pntsd->gsidoffset),
+		 le32_to_cpu(pntsd->sacloffset), dacloffset);
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
+			ksmbd_err("%s: Error %d parsing Owner SID\n", __func__, rc);
+			return rc;
+		}
+
+		rc = sid_to_id(owner_sid_ptr, SIDOWNER, fattr);
+		if (rc) {
+			ksmbd_err("%s: Error %d mapping Owner SID to uid\n",
+					__func__, rc);
+			owner_sid_ptr = NULL;
+		}
+	}
+
+	if (pntsd->gsidoffset) {
+		rc = parse_sid(group_sid_ptr, end_of_acl);
+		if (rc) {
+			ksmbd_err("%s: Error %d mapping Owner SID to gid\n",
+					__func__, rc);
+			return rc;
+		}
+		rc = sid_to_id(group_sid_ptr, SIDUNIX_GROUP, fattr);
+		if (rc) {
+			ksmbd_err("%s: Error %d mapping Group SID to gid\n",
+					__func__, rc);
+			group_sid_ptr = NULL;
+		}
+	}
+
+	if ((pntsd_type &
+	     (DACL_AUTO_INHERITED | DACL_AUTO_INHERIT_REQ)) ==
+	    (DACL_AUTO_INHERITED | DACL_AUTO_INHERIT_REQ))
+		pntsd->type |= cpu_to_le16(DACL_AUTO_INHERITED);
+	if (pntsd_type & DACL_PROTECTED)
+		pntsd->type |= cpu_to_le16(DACL_PROTECTED);
+
+	if (dacloffset) {
+		parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr, group_sid_ptr,
+				fattr);
+	}
+
+	return 0;
+}
+
+/* Convert permission bits from mode to equivalent CIFS ACL */
+int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
+		int addition_info, __u32 *secdesclen, struct smb_fattr *fattr)
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
+	uid = from_kuid(&init_user_ns, fattr->cf_uid);
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
+	gid = from_kgid(&init_user_ns, fattr->cf_gid);
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
+		if (!ppntsd)
+			set_mode_dacl(dacl_ptr, fattr);
+		else if (!ppntsd->dacloffset)
+			goto out;
+		else {
+			struct smb_acl *ppdacl_ptr;
+
+			ppdacl_ptr = (struct smb_acl *)((char *)ppntsd +
+						le32_to_cpu(ppntsd->dacloffset));
+			set_ntacl_dacl(dacl_ptr, ppdacl_ptr, nowner_sid_ptr,
+				       ngroup_sid_ptr, fattr);
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
+		u8 flags, __le32 access_req)
+{
+	ace->type = type;
+	ace->flags = flags;
+	ace->access_req = access_req;
+	smb_copy_sid(&ace->sid, sid);
+	ace->size = cpu_to_le16(1 + 1 + 2 + 4 + 1 + 1 + 6 + (sid->num_subauth * 4));
+}
+
+int smb_inherit_dacl(struct ksmbd_conn *conn, struct dentry *dentry,
+		unsigned int uid, unsigned int gid)
+{
+	const struct smb_sid *psid, *creator = NULL;
+	struct smb_ace *parent_aces, *aces;
+	struct smb_acl *parent_pdacl;
+	struct smb_ntsd *parent_pntsd = NULL;
+	struct smb_sid owner_sid, group_sid;
+	struct dentry *parent = dentry->d_parent;
+	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0;
+	int rc = -ENOENT, num_aces, dacloffset, pntsd_type, acl_len;
+	char *aces_base;
+	bool is_dir = S_ISDIR(dentry->d_inode->i_mode);
+
+	acl_len = ksmbd_vfs_get_sd_xattr(conn, parent, &parent_pntsd);
+	if (acl_len <= 0)
+		return rc;
+	dacloffset = le32_to_cpu(parent_pntsd->dacloffset);
+	if (!dacloffset)
+		goto out;
+
+	parent_pdacl = (struct smb_acl *)((char *)parent_pntsd + dacloffset);
+	num_aces = le32_to_cpu(parent_pdacl->num_aces);
+	pntsd_type = le16_to_cpu(parent_pntsd->type);
+
+	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, GFP_KERNEL);
+	if (!aces_base)
+		goto out;
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
+		} else
+			flags = 0;
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
+					parent_aces->access_req);
+			nt_size += le16_to_cpu(aces->size);
+			ace_cnt++;
+			aces = (struct smb_ace *)((char *)aces + le16_to_cpu(aces->size));
+			flags |= INHERIT_ONLY_ACE;
+			psid = creator;
+		} else if (is_dir && !(parent_aces->flags & NO_PROPAGATE_INHERIT_ACE))
+			psid = &parent_aces->sid;
+
+		smb_set_ace(aces, psid, parent_aces->type, flags | inherited_flags,
+				parent_aces->access_req);
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
+			goto out;
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
+		ksmbd_vfs_set_sd_xattr(conn, dentry, pntsd, pntsd_size);
+		kfree(pntsd);
+		rc = 0;
+	}
+
+	kfree(aces_base);
+out:
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
+int smb_check_perm_dacl(struct ksmbd_conn *conn, struct dentry *dentry,
+		__le32 *pdaccess, int uid)
+{
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
+	acl_size = ksmbd_vfs_get_sd_xattr(conn, dentry, &pntsd);
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
+			ace = (struct smb_ace *) ((char *)ace + le16_to_cpu(ace->size));
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
+		ace = (struct smb_ace *) ((char *)ace + le16_to_cpu(ace->size));
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
+	posix_acls = ksmbd_vfs_get_acl(dentry->d_inode, ACL_TYPE_ACCESS);
+	if (posix_acls && !found) {
+		unsigned int id = -1;
+
+		pa_entry = posix_acls->a_entries;
+		for (i = 0; i < posix_acls->a_count; i++, pa_entry++) {
+			if (pa_entry->e_tag == ACL_USER)
+				id = from_kuid(&init_user_ns, pa_entry->e_uid);
+			else if (pa_entry->e_tag == ACL_GROUP)
+				id = from_kgid(&init_user_ns, pa_entry->e_gid);
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
+		if (others_ace)
+			ace = others_ace;
+		else {
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
+	if (granted & ~(access_bits | FILE_READ_ATTRIBUTES |
+		READ_CONTROL | WRITE_DAC | DELETE)) {
+		ksmbd_debug(SMB, "Access denied with winACL, granted : %x, access_req : %x\n",
+				granted, le32_to_cpu(ace->access_req));
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
+		struct dentry *dentry, struct smb_ntsd *pntsd, int ntsd_len,
+		bool type_check)
+{
+	int rc;
+	struct smb_fattr fattr = {{0}};
+	struct inode *inode = dentry->d_inode;
+
+	fattr.cf_uid = INVALID_UID;
+	fattr.cf_gid = INVALID_GID;
+	fattr.cf_mode = inode->i_mode;
+
+	rc = parse_sec_desc(pntsd, ntsd_len, &fattr);
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
+	ksmbd_vfs_remove_acl_xattrs(dentry);
+	/* Update posix acls */
+	if (fattr.cf_dacls) {
+		rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_ACCESS,
+				fattr.cf_acls);
+		if (S_ISDIR(inode->i_mode) && fattr.cf_dacls)
+			rc = ksmbd_vfs_set_posix_acl(inode, ACL_TYPE_DEFAULT,
+					fattr.cf_dacls);
+	}
+
+	/* Check it only calling from SD BUFFER context */
+	if (type_check && !(le16_to_cpu(pntsd->type) & DACL_PRESENT))
+		goto out;
+
+	if (test_share_config_flag(tcon->share_conf,
+	    KSMBD_SHARE_FLAG_ACL_XATTR)) {
+		/* Update WinACL in xattr */
+		ksmbd_vfs_remove_sd_xattrs(dentry);
+		ksmbd_vfs_set_sd_xattr(conn, dentry, pntsd, ntsd_len);
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
diff --git a/fs/cifsd/smbacl.h b/fs/cifsd/smbacl.h
new file mode 100644
index 000000000000..9b22bff4191f
--- /dev/null
+++ b/fs/cifsd/smbacl.h
@@ -0,0 +1,202 @@
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
+#define ACCESS_ALLOWED	0
+#define ACCESS_DENIED	1
+
+#define SIDOWNER 1
+#define SIDGROUP 2
+#define SIDCREATOR_OWNER 3
+#define SIDCREATOR_GROUP 4
+#define SIDUNIX_USER 5
+#define SIDUNIX_GROUP 6
+#define SIDNFS_USER 7
+#define SIDNFS_GROUP 8
+#define SIDNFS_MODE 9
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
+int parse_sec_desc(struct smb_ntsd *pntsd, int acl_len,
+		struct smb_fattr *fattr);
+int build_sec_desc(struct smb_ntsd *pntsd, struct smb_ntsd *ppntsd,
+		int addition_info, __u32 *secdesclen, struct smb_fattr *fattr);
+int init_acl_state(struct posix_acl_state *state, int cnt);
+void free_acl_state(struct posix_acl_state *state);
+void posix_state_to_acl(struct posix_acl_state *state,
+		struct posix_acl_entry *pace);
+int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid);
+bool smb_inherit_flags(int flags, bool is_dir);
+int smb_inherit_dacl(struct ksmbd_conn *conn, struct dentry *dentry,
+		unsigned int uid, unsigned int gid);
+int smb_check_perm_dacl(struct ksmbd_conn *conn, struct dentry *dentry,
+		__le32 *pdaccess, int uid);
+int store_init_posix_acl(struct inode *inode, umode_t perm);
+int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
+		struct dentry *dentry, struct smb_ntsd *pntsd, int ntsd_len,
+		bool type_check);
+void id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid);
+void ksmbd_init_domain(u32 *sub_auth);
+#endif /* _SMBACL_H */
diff --git a/fs/cifsd/smberr.h b/fs/cifsd/smberr.h
new file mode 100644
index 000000000000..ce842303ae1f
--- /dev/null
+++ b/fs/cifsd/smberr.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/*
+ *   Copyright (c) International Business Machines  Corp., 2002,2004
+ *   Author(s): Steve French (sfrench@us.ibm.com)
+ *
+ *   See Error Codes section of the SNIA CIFS Specification
+ *   for more information
+ */
+#ifndef __KSMBD_SMBERR_H
+#define __KSMBD_SMBERR_H
+
+#define SUCCESS	0x00	/* The request was successful. */
+#define ERRDOS	0x01	/* Error is from the core DOS operating system set */
+#define ERRSRV	0x02	/* Error is generated by the file server daemon */
+#define ERRHRD	0x03	/* Error is a hardware error. */
+#define ERRCMD	0xFF	/* Command was not in the "SMB" format. */
+
+/* The following error codes may be generated with the SUCCESS error class.*/
+
+/*#define SUCCESS	0	The request was successful. */
+
+/* The following error codes may be generated with the ERRDOS error class.*/
+
+#define ERRbadfunc		1	/*
+					 * Invalid function. The server did not
+					 * recognize or could not perform a
+					 * system call generated by the server,
+					 * e.g., set the DIRECTORY attribute on
+					 * a data file, invalid seek mode.
+					 */
+#define ERRbadfile		2	/*
+					 * File not found. The last component
+					 * of a file's pathname could not be
+					 * found.
+					 */
+#define ERRbadpath		3	/*
+					 * Directory invalid. A directory
+					 * component in a pathname could not be
+					 * found.
+					 */
+#define ERRnofids		4	/*
+					 * Too many open files. The server has
+					 * no file handles available.
+					 */
+#define ERRnoaccess		5	/*
+					 * Access denied, the client's context
+					 * does not permit the requested
+					 * function. This includes the
+					 * following conditions: invalid rename
+					 * command, write to Fid open for read
+					 * only, read on Fid open for write
+					 * only, attempt to delete a non-empty
+					 * directory
+					 */
+#define ERRbadfid		6	/*
+					 * Invalid file handle. The file handle
+					 * specified was not recognized by the
+					 * server.
+					 */
+#define ERRbadmcb		7	/* Memory control blocks destroyed. */
+#define ERRnomem		8	/*
+					 * Insufficient server memory to
+					 * perform the requested function.
+					 */
+#define ERRbadmem		9	/* Invalid memory block address. */
+#define ERRbadenv		10	/* Invalid environment. */
+#define ERRbadformat		11	/* Invalid format. */
+#define ERRbadaccess		12	/* Invalid open mode. */
+#define ERRbaddata		13	/*
+					 * Invalid data (generated only by
+					 * IOCTL calls within the server).
+					 */
+#define ERRbaddrive		15	/* Invalid drive specified. */
+#define ERRremcd		16	/*
+					 * A Delete Directory request attempted
+					 * to remove the server's current
+					 * directory.
+					 */
+#define ERRdiffdevice		17	/*
+					 * Not same device (e.g., a cross
+					 * volume rename was attempted
+					 */
+#define ERRnofiles		18	/*
+					 * A File Search command can find no
+					 * more files matching the specified
+					 * criteria.
+					 */
+#define ERRwriteprot		19	/* media is write protected */
+#define ERRgeneral		31
+#define ERRbadshare		32	/*
+					 * The sharing mode specified for an
+					 * Open conflicts with existing FIDs on
+					 * the file.
+					 */
+#define ERRlock			33	/*
+					 * A Lock request conflicted with an
+					 * existing lock or specified an
+					 * invalid mode, or an Unlock requested
+					 * attempted to remove a lock held by
+					 * another process.
+					 */
+#define ERRunsup		50
+#define ERRnosuchshare		67
+#define ERRfilexists		80	/*
+					 * The file named in the request
+					 * already exists.
+					 */
+#define ERRinvparm		87
+#define ERRdiskfull		112
+#define ERRinvname		123
+#define ERRinvlevel		124
+#define ERRdirnotempty		145
+#define ERRnotlocked		158
+#define ERRcancelviolation	173
+#define ERRnoatomiclocks	174
+#define ERRalreadyexists	183
+#define ERRbadpipe		230
+#define ERRpipebusy		231
+#define ERRpipeclosing		232
+#define ERRnotconnected		233
+#define ERRmoredata		234
+#define ERReasnotsupported	282
+#define ErrQuota		0x200	/*
+					 * The operation would cause a quota
+					 * limit to be exceeded.
+					 */
+#define ErrNotALink		0x201	/*
+					 * A link operation was performed on a
+					 * pathname that was not a link.
+					 */
+
+/*
+ * Below errors are used internally (do not come over the wire) for passthrough
+ * from STATUS codes to POSIX only
+ */
+#define ERRsymlink              0xFFFD
+#define ErrTooManyLinks         0xFFFE
+
+/* Following error codes may be generated with the ERRSRV error class.*/
+
+#define ERRerror		1	/*
+					 * Non-specific error code. It is
+					 * returned under the following
+					 * conditions: resource other than disk
+					 * space exhausted (e.g. TIDs), first
+					 * SMB command was not negotiate,
+					 * multiple negotiates attempted, and
+					 * internal server error.
+					 */
+#define ERRbadpw		2	/*
+					 * Bad password - name/password pair in
+					 * a TreeConnect or Session Setup are
+					 * invalid.
+					 */
+#define ERRbadtype		3	/*
+					 * used for indicating DFS referral
+					 * needed
+					 */
+#define ERRaccess		4	/*
+					 * The client does not have the
+					 * necessary access rights within the
+					 * specified context for requested
+					 * function.
+					 */
+#define ERRinvtid		5	/*
+					 * The Tid specified in a command was
+					 * invalid.
+					 */
+#define ERRinvnetname		6	/*
+					 * Invalid network name in tree
+					 * connect.
+					 */
+#define ERRinvdevice		7	/*
+					 * Invalid device - printer request
+					 * made to non-printer connection or
+					 * non-printer request made to printer
+					 * connection.
+					 */
+#define ERRqfull		49	/*
+					 * Print queue full (files) -- returned
+					 * by open print file.
+					 */
+#define ERRqtoobig		50	/* Print queue full -- no space. */
+#define ERRqeof			51	/* EOF on print queue dump */
+#define ERRinvpfid		52	/* Invalid print file FID. */
+#define ERRsmbcmd		64	/*
+					 * The server did not recognize the
+					 * command received.
+					 */
+#define ERRsrverror		65	/*
+					 * The server encountered an internal
+					 * error, e.g., system file
+					 * unavailable.
+					 */
+#define ERRbadBID		66	/* (obsolete) */
+#define ERRfilespecs		67	/*
+					 * The Fid and pathname parameters
+					 * contained an invalid combination of
+					 * values.
+					 */
+#define ERRbadLink		68	/* (obsolete) */
+#define ERRbadpermits		69	/*
+					 * The access permissions specified for
+					 * a file or directory are not a valid
+					 * combination.
+					 */
+#define ERRbadPID		70
+#define ERRsetattrmode		71	/* attribute (mode) is invalid */
+#define ERRpaused		81	/* Server is paused */
+#define ERRmsgoff		82	/* reserved - messaging off */
+#define ERRnoroom		83	/* reserved - no room for message */
+#define ERRrmuns		87	/* reserved - too many remote names */
+#define ERRtimeout		88	/* operation timed out */
+#define ERRnoresource		89	/* No resources available for request */
+#define ERRtoomanyuids		90	/*
+					 * Too many UIDs active on this session
+					 */
+#define ERRbaduid		91	/*
+					 * The UID is not known as a valid user
+					 */
+#define ERRusempx		250	/* temporarily unable to use raw */
+#define ERRusestd		251	/*
+					 * temporarily unable to use either raw
+					 * or mpx
+					 */
+#define ERR_NOTIFY_ENUM_DIR	1024
+#define ERRnoSuchUser		2238	/* user account does not exist */
+#define ERRaccountexpired	2239
+#define ERRbadclient		2240	/* can not logon from this client */
+#define ERRbadLogonTime		2241	/* logon hours do not allow this */
+#define ERRpasswordExpired	2242
+#define ERRnetlogonNotStarted	2455
+#define ERRnosupport		0xFFFF
+
+#endif /* __KSMBD_SMBERR_H */
diff --git a/fs/cifsd/smbfsctl.h b/fs/cifsd/smbfsctl.h
new file mode 100644
index 000000000000..908c4e68a479
--- /dev/null
+++ b/fs/cifsd/smbfsctl.h
@@ -0,0 +1,90 @@
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
diff --git a/fs/cifsd/smbstatus.h b/fs/cifsd/smbstatus.h
new file mode 100644
index 000000000000..108a8b6ed24a
--- /dev/null
+++ b/fs/cifsd/smbstatus.h
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
diff --git a/fs/cifsd/time_wrappers.h b/fs/cifsd/time_wrappers.h
new file mode 100644
index 000000000000..a702ca96947e
--- /dev/null
+++ b/fs/cifsd/time_wrappers.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *   Copyright (C) 2019 Samsung Electronics Co., Ltd.
+ */
+
+#ifndef __KSMBD_TIME_WRAPPERS_H
+#define __KSMBD_TIME_WRAPPERS_H
+
+/*
+ * A bunch of ugly hacks to workaoround all the API differences
+ * between different kernel versions.
+ */
+
+#define NTFS_TIME_OFFSET	((u64)(369*365 + 89) * 24 * 3600 * 10000000)
+
+/* Convert the Unix UTC into NT UTC. */
+static inline u64 ksmbd_UnixTimeToNT(struct timespec64 t)
+{
+	/* Convert to 100ns intervals and then add the NTFS time offset. */
+	return (u64) t.tv_sec * 10000000 + t.tv_nsec / 100 + NTFS_TIME_OFFSET;
+}
+
+struct timespec64 ksmbd_NTtimeToUnix(__le64 ntutc);
+
+#define KSMBD_TIME_TO_TM	time64_to_tm
+
+static inline long long ksmbd_systime(void)
+{
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+	return ksmbd_UnixTimeToNT(ts);
+}
+#endif /* __KSMBD_TIME_WRAPPERS_H */
diff --git a/fs/cifsd/unicode.c b/fs/cifsd/unicode.c
new file mode 100644
index 000000000000..22a4d10a2000
--- /dev/null
+++ b/fs/cifsd/unicode.c
@@ -0,0 +1,391 @@
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
+static int smb_utf16_bytes(const __le16 *from,
+			   int maxbytes,
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
+		(*ch <= 0x1f ||
+		 *ch == '?' || *ch == '"' || *ch == '<' ||
+		 *ch == '>' || *ch == '|'))
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
+static int smb_from_utf16(char *to,
+			  const __le16 *from,
+			  int tolen,
+			  int fromlen,
+			  const struct nls_table *codepage,
+			  bool mapchar)
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
+int
+smb_strtoUTF16(__le16 *to, const char *from, int len,
+	      const struct nls_table *codepage)
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
+				       (wchar_t *) to, len);
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
+char *
+smb_strndup_from_utf16(const char *src, const int maxlen,
+			const bool is_unicode, const struct nls_table *codepage)
+{
+	int len, ret;
+	char *dst;
+
+	if (is_unicode) {
+		len = smb_utf16_bytes((__le16 *) src, maxlen, codepage);
+		len += nls_nullsize(codepage);
+		dst = kmalloc(len, GFP_KERNEL);
+		if (!dst)
+			return ERR_PTR(-ENOMEM);
+		ret = smb_from_utf16(dst, (__le16 *) src, len, maxlen, codepage,
+			       false);
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
+int
+smbConvertToUTF16(__le16 *target, const char *source, int srclen,
+		 const struct nls_table *cp, int mapchars)
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
diff --git a/fs/cifsd/unicode.h b/fs/cifsd/unicode.h
new file mode 100644
index 000000000000..7135d62bf9b0
--- /dev/null
+++ b/fs/cifsd/unicode.h
@@ -0,0 +1,374 @@
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
+#define UNI_ASTERISK    ((__u16) ('*' + 0xF000))
+#define UNI_QUESTION    ((__u16) ('?' + 0xF000))
+#define UNI_COLON       ((__u16) (':' + 0xF000))
+#define UNI_GRTRTHAN    ((__u16) ('>' + 0xF000))
+#define UNI_LESSTHAN    ((__u16) ('<' + 0xF000))
+#define UNI_PIPE        ((__u16) ('|' + 0xF000))
+#define UNI_SLASH       ((__u16) ('\\' + 0xF000))
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
+	const struct nls_table *codepage);
+char *smb_strndup_from_utf16(const char *src, const int maxlen,
+		const bool is_unicode,
+		const struct nls_table *codepage);
+extern int smbConvertToUTF16(__le16 *target, const char *source, int srclen,
+		const struct nls_table *cp, int mapchars);
+extern char *ksmbd_extract_sharename(char *treename);
+#endif
+
+wchar_t cifs_toupper(wchar_t in);
+
+/*
+ * UniStrcat:  Concatenate the second string to the first
+ *
+ * Returns:
+ *     Address of the first string
+ */
+	static inline wchar_t *
+UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
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
+	static inline wchar_t *
+UniStrchr(const wchar_t *ucs, wchar_t uc)
+{
+	while ((*ucs != uc) && *ucs)
+		ucs++;
+
+	if (*ucs == uc)
+		return (wchar_t *) ucs;
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
+	static inline int
+UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
+{
+	while ((*ucs1 == *ucs2) && *ucs1) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int) *ucs1 - (int) *ucs2;
+}
+
+/*
+ * UniStrcpy:  Copy a string
+ */
+	static inline wchar_t *
+UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
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
+	static inline size_t
+UniStrlen(const wchar_t *ucs1)
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
+	static inline size_t
+UniStrnlen(const wchar_t *ucs1, int maxlen)
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
+	static inline wchar_t *
+UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
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
+	static inline int
+UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int) *ucs1 - (int) *ucs2;
+}
+
+/*
+ * UniStrncmp_le:  Compare length limited string - native to little-endian
+ */
+	static inline int
+UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2, size_t n)
+{
+	if (!n)
+		return 0;	/* Null strings are equal */
+	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
+		ucs1++;
+		ucs2++;
+	}
+	return (int) *ucs1 - (int) __le16_to_cpu(*ucs2);
+}
+
+/*
+ * UniStrncpy:  Copy length limited string with pad
+ */
+	static inline wchar_t *
+UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
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
+	static inline wchar_t *
+UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
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
+	static inline wchar_t *
+UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
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
+				return (wchar_t *) anchor1;
+			ucs1 = ++anchor1;	/* No match */
+			ucs2 = anchor2;
+		}
+	}
+
+	if (!*ucs2)		/* Both end together */
+		return (wchar_t *) anchor1;	/* Match found */
+	return NULL;		/* No match */
+}
+
+#ifndef UNIUPR_NOUPPER
+/*
+ * UniToupper:  Convert a unicode character to upper case
+ */
+	static inline wchar_t
+UniToupper(register wchar_t uc)
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
+	static inline __le16 *
+UniStrupr(register __le16 *upin)
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
+	static inline wchar_t
+UniTolower(register wchar_t uc)
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
+	static inline wchar_t *
+UniStrlwr(register wchar_t *upin)
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
diff --git a/fs/cifsd/uniupr.h b/fs/cifsd/uniupr.h
new file mode 100644
index 000000000000..26583b776897
--- /dev/null
+++ b/fs/cifsd/uniupr.h
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

