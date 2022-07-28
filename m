Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6785840BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jul 2022 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiG1OKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 10:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiG1OKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:10:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA75396;
        Thu, 28 Jul 2022 07:10:07 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SCZoSu016207;
        Thu, 28 Jul 2022 07:10:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=FCpx8j/U32BBLGRtAe6lQ0wlfVvB7DZ9frN+YQJUFoQ=;
 b=FWZmHhkEL/oMMmIje78KBYXqTX4JhBodre34DYq8wE41vCe75hvANfA3e0lIxDg2CIaa
 Fal533u7agdpEwULoEzt+BajOSY//sCFIBW2gB/9sZycqevvFEIl/mjEW7M2TQZBCTT/
 kWvwIbVkzv6FYTbbJ1EX0h/PjbrhsvaZSKY= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hks0ps3dw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APPx+VvMIaysKZlTMZT5nYLQgkz4i8lPt4L84Kt0W3URrC2Xo6mbwqOGLvnMHUaZZ8s0OjFIVaej8c2u3UJB6uE7ArRWrTlBk4BgAid7BuM9T+W4Rw5rLEofwds8tfK7Uslm158eY3sK9ViMVrMoTgkPkEAtIVofUOJoY67aUyi5dyvMkdVQsxBv9FmBbRohU5JWHhTQFVBKcafuNgyaGElmdkP57hzGN8PeqgnL1jimWAnfulswFoXD6spE7NtJcRKtgNsym5dRLmyCzz+S71xGTRb9vf/stSkygBkHAj+3c3ULUxg6aBSzPHj5ulr1f3/LtSh/Y0XUeE27Z9gVjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCpx8j/U32BBLGRtAe6lQ0wlfVvB7DZ9frN+YQJUFoQ=;
 b=X3z4KdtKASdwA1K9OZZ6GSrYNv1mY1vfW+9oco8Yp2yMF7F4s0FL1MP8/IbaxNUL0qfbc89LZeBC5h+cp8GGBAx2v3BgMVg5e5yZhJwa2XZ5oMNCSxvhrpWglBthtstSi7aV9hNQEdtfYg9Zn7PCjnu+NjnXN40rdn+BFTO73l9JzeCFaPN//x4XbnyOG/v4Rhi1T0AurCrcv0zv2bxwoGIR25DPBahc8DSBac2If9A0uGEDlnfE4Uam96p4OFP2ILYTWuMUJb3B9NXAyivJa/t0UrvuEopG5qtYb53OQH/E0o20+7qKGijPfsICo9clVKdBvJ7mxfRTgG/D4xJYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by MN2PR15MB4256.namprd15.prod.outlook.com (2603:10b6:208:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:09:56 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 14:09:56 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH v2 7/7] ima: Support measurement of kexec initramfs
 components
Thread-Topic: [RFC PATCH v2 7/7] ima: Support measurement of kexec initramfs
 components
Thread-Index: AQHYoou35xw0uKkOyEWRQ9fW+iCzLA==
Date:   Thu, 28 Jul 2022 14:09:56 +0000
Message-ID: <034c6e491e871e5902ca4d0af884adb07b37a39d.1659003817.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
 <cover.1659003817.git.noodles@fb.com>
In-Reply-To: <cover.1659003817.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73fe3d37-e215-40de-63f4-08da70a2d9e7
x-ms-traffictypediagnostic: MN2PR15MB4256:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iM4Jbz3zwv1hmERU+MOQ6vPtcVMntUApmHOaeXkT7cC1ShaDrJaSO0mN19yPQrmYoz/46RmsfATxG+Etpzt7LxGF9dFMn1AuLmNLFbwBZaZxWp9XB23s6EvFEPZQZKt/ftu9cJwFsfINDoyAD1uEilEb9SUzIZUiKw6k3SFaFZx4APdtqtc6+gBkUgmr/QeJOt2naAYrSgmB/XgUIWATt3DXqYYT1MMdnGCJkUOSxUBwLbyU+TyJ3hEj2J964p/6Ux+psn4b9AsTF1osOsNOA38AdfLavOtmBJMgJJ58BYAZY0/K8BYvqzG8y6fx798lFuv2SPspU8uCtk2PYDcdxm/9Ft+1lKcggjWW+Xxag2SEBfibRoQASRPnEDnMeTLwgTvTdERgGMZZq4J9Vm73fbxRBNTFU8WZQ8ASfWsciHDEMRP8DCYG1c+x2wSlMC4dbLxxK8btiLDM1elWiyM2bli0Owa8hTFn3Kn6KH90njDet8JgnEfrkIRPXnV9hwz0aT+U0It3suIbTcEdung4gynh8a/BsJByvY9QrMHT+n3lmg/HtxdJGEMkQ6ygPhmPEgQrxxEyQePOriCoCnWIGju/YWDwaQC8XGBXOtxBZbTXoCe4lVqrc+xUaTRG0BrnRGiEpbPGgJ8gNnVsk0lgdNAxAkBJ8K9Hdz1rwH6m03emLL8Z05fjXwCb6oGkxJ6qAMpuv9qenQWmHVM6onQc+Ma5Hj5IfjONgoYISpSBO7RIHHdYueSIsUUdo+ksDkCnpLarHrwnpFR9QAdF45TDG6RN4Pi1zlEwOXrayd9zimzNbVl2Kc403/tuv41ARUWP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(7416002)(2616005)(2906002)(478600001)(122000001)(41300700001)(6506007)(86362001)(316002)(36756003)(186003)(5660300002)(38070700005)(38100700002)(66476007)(4326008)(83380400001)(6486002)(6512007)(91956017)(110136005)(54906003)(26005)(71200400001)(76116006)(66946007)(8676002)(8936002)(64756008)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ljOMfeIr6/I7qXBJmrll6TskcDGlVWQTHInuboZS2CeGRHXHOVH42B1/7BBl?=
 =?us-ascii?Q?dFuES3FEowA32HEblgsug3GahwzdiyTINoEBJ5Jl/IsCTExSxFz1emdoqTAL?=
 =?us-ascii?Q?iNNDzIoeUTlG1OZF2Woi/ZX6FoyNIEYnSc3UnMoxagwoTJDP1Vet5050nwgk?=
 =?us-ascii?Q?Bnlef6HgjqR2PEytndzoH1ydnxt3sXG1BfKfgoBz4ZXexokQXcCjhVQl9Jnh?=
 =?us-ascii?Q?zn+cuLie/CMqtGbJa7swDnXybHCD+elsoEnACkwfk4Vjpyc5xVi621VvZWM3?=
 =?us-ascii?Q?Xi0AxjUchiz1r5/fYgnM5nqDKJD0KZvRxNWGDgFahna5bR6q4ktt8XB5WiaU?=
 =?us-ascii?Q?/W3aYR49jPKwUrPsTC5ELUa90JQ0f76nCVOAz8cKLxFNUE2bdRLTaTaAjq8i?=
 =?us-ascii?Q?5af/uGl5sHOeihMSlxZMAXDtI93ua9PGSW7sY3LYpRxUf7f5jUoM8ecPfkM6?=
 =?us-ascii?Q?+c54u+Zz9dYxRbUdxmxdmqwTKzmr3cHflpWVko2AXJ/TSqmstoRIiDw801f6?=
 =?us-ascii?Q?+uip2bq3QhlIvmx5G7s9M3au/FSln14M5QlxnNSFy5ZZmsOwJbLNz24qOhmT?=
 =?us-ascii?Q?v2qbO0EWN6sIf0ynj9HhHiCjTL/z6/BeFxi+lyplEd+H/T8YAI+ena1P03I9?=
 =?us-ascii?Q?Mrzn4pt9hY/k0xmUEawM8tuns1BSsujFy3ZhEfVdDXhuJygJJ3QtD3URuKZt?=
 =?us-ascii?Q?u/Lyj/ovgL5jMBsS6HVU8Q7czFtOZTUYJEWpkB5B2NRa9vF5sHmm+yLW5X9u?=
 =?us-ascii?Q?sqQfIpqn3+QmY8waROmUd4IiPZR/ImWaqdiWx4PMIIQ9EpUJjblItdX+tiAO?=
 =?us-ascii?Q?UeLfpuZ8JfO5XgjJ8ZXNEHvS1hChYIUCwRNuZodA/BQ5yGmf7Pgk3RrEokBM?=
 =?us-ascii?Q?vWzabpf3WOCFY+fn+ZlcoZkMivEROvjyzQyjI+zhgH93NViRFATw0d8y1WIS?=
 =?us-ascii?Q?aX5rwuNcSqNPObVpi+9pnBby0fdnLv/+zW6OoF5GaCMIy40QgTgv645U2VZi?=
 =?us-ascii?Q?0DWlFu25FR4eciUGQ5wC1spEbbDQCAfJx6oYn7UJjbWXZadB4zYj9MSSC92/?=
 =?us-ascii?Q?q5WVzY0vC4iK+UQD8KZUfNfsmz60ICqnVMN7kuOlH87UHNRL1xgejUn/4VXe?=
 =?us-ascii?Q?mSM20I781ZkjjVXP4Q7XBoljvXjW7lxauItChX2WYy4CaVkYrL/PfjDNuyuK?=
 =?us-ascii?Q?aRVsf6JxNT0S2OsYf7FVdYAlbAPTAiTlcRQGAsFPHQAC3I1pT7xJSCc6h4ma?=
 =?us-ascii?Q?HFB7Y+OIApMa6N3VguX5iZKFv1hDzxEqrbpZ3IUJU4NXsHpcaTEiRvUhUk+F?=
 =?us-ascii?Q?2W5NxSzrVatFjoXvP1t/JiRWjEm6zpYTodHjSyIT2p7Z9Se9zMFkL3Uot+lX?=
 =?us-ascii?Q?/zDENIwKnpCvfvaVE00Xd3lL9iXa/B2EiYNV6ATuj8WysJ/F3mO5JghOXgmL?=
 =?us-ascii?Q?NZC+L7ZRRO/VFHW7yezuDmEZex87xqx5ug+IbumEBfLWZiToWlpzRWmMaPiy?=
 =?us-ascii?Q?c69FaB1czbanuLp0Wek7bN91KHKsllM0TdnPfsTqC5vRPJU2qZRQ6IBWQQuJ?=
 =?us-ascii?Q?71EOYY7W8RKJ1EypFwfDCRO9oWRhd98wW2XL7pYx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <744B632D9353E045ACBFF77931B179B7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fe3d37-e215-40de-63f4-08da70a2d9e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 14:09:56.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v9RElZ3wfk1H4UTKqrL+3cTGyOV+EtJ7XfDXa9MavCmaThQph4wY/IdJKMgzQoeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4256
X-Proofpoint-GUID: Mqzn7b5VR2b22hOjRSevXS4YFpqrQW0s
X-Proofpoint-ORIG-GUID: Mqzn7b5VR2b22hOjRSevXS4YFpqrQW0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_05,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

An initramfs can be made up of multiple components that are concatenated
together e.g. an early uncompressed cpio archive containing early
firmware followed by a gziped cpio archive containing the actual
userspace initramfs. Add a Kconfig option to allow the IMA subsystem to
measure these components separately rather than as a single blob,
allowing for easier reasoning about system state when checking TPM PCR
values or the IMA integrity log.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 security/integrity/ima/Kconfig    |  16 +++
 security/integrity/ima/ima_main.c | 191 ++++++++++++++++++++++++++++--
 2 files changed, 199 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 7249f16257c7..b75da44a32f2 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -41,6 +41,22 @@ config IMA_KEXEC
 	   Depending on the IMA policy, the measurement list can grow to
 	   be very large.
 
+config IMA_MEASURE_INITRAMFS_COMPONENTS
+	bool "Enable measurement of individual kexec initramfs components"
+	depends on IMA
+	select CPIO
+	default n
+	help
+	   initramfs images can be made up of multiple separate components,
+	   e.g. an early uncompressed cpio archive containing early firmware
+	   followed by a gziped cpio archive containing the actual userspace
+	   initramfs. More complex systems might involve a firmware archive,
+	   a userspace archive and then a kernel module archive, allowing for
+	   only the piece that needs changed to vary between boots.
+
+	   This option tells IMA to measure each individual component of the
+	   initramfs separately, rather than as a single blob.
+
 config IMA_MEASURE_PCR_IDX
 	int
 	depends on IMA
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 040b03ddc1c7..be7f446df4f2 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,8 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <linux/cpio.h>
+#include <linux/decompress/generic.h>
 
 #include "ima.h"
 
@@ -198,6 +200,169 @@ void ima_file_free(struct file *file)
 	ima_check_last_writer(iint, inode, file);
 }
 
+#ifdef CONFIG_IMA_MEASURE_INITRAMFS_COMPONENTS
+static void initrd_error(char *x)
+{
+	pr_err("measure initrd: error from decompressor: %s\n", x);
+}
+
+static long initrd_flush(void *buf, unsigned long size)
+{
+	return size;
+}
+
+static int process_initrd_measurement(struct integrity_iint_cache *iint,
+				      struct file *file, char *buf,
+				      loff_t size, const char *pathname,
+				      struct modsig *modsig, int pcr,
+				      struct evm_ima_xattr_data *xattr_value,
+				      int xattr_len,
+				      struct ima_template_desc *template_desc)
+{
+	struct cpio_context cpio_ctx;
+	const char *compress_name;
+	enum hash_algo hash_algo;
+	decompress_fn decompress;
+	long consumed, written;
+	char *start, *cur;
+	char *component;
+	int buf_len;
+	bool in_cpio;
+	int rc = 0;
+	int part;
+
+	/*
+	 * We collect this once, over the whole buffer.
+	 */
+	if (modsig)
+		ima_collect_modsig(modsig, buf, size);
+
+	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
+
+	/*
+	 * Pathname, compression name, 2 : separators, single digit part
+	 * and a trailing NUL.
+	 */
+	buf_len = strlen(pathname) + 5 + 2 + 2;
+	component = kmalloc(buf_len, GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+
+	memset(&cpio_ctx, 0, sizeof(cpio_ctx));
+	cpio_ctx.parse_only = true;
+	rc = cpio_start(&cpio_ctx);
+	if (rc)
+		goto out;
+	in_cpio = false;
+	start = buf;
+	cur = buf;
+	part = 0;
+
+	while (rc == 0 && size) {
+		loff_t saved_offset = cpio_ctx.this_header;
+
+		/* It's a CPIO archive, process it */
+		if (*buf == '0' && !(cpio_ctx.this_header & 3)) {
+			in_cpio = true;
+			cpio_ctx.state = CPIO_START;
+			written = cpio_write_buffer(&cpio_ctx, buf, size);
+
+			if (written < 0) {
+				pr_err("Failed to process archive: %ld\n",
+				       written);
+				break;
+			}
+
+			buf += written;
+			size -= written;
+			continue;
+		}
+		if (!*buf) {
+			buf++;
+			size--;
+			cpio_ctx.this_header++;
+			continue;
+		}
+
+		if (in_cpio) {
+			iint->flags &= ~(IMA_COLLECTED);
+			iint->measured_pcrs &= ~(0x1 << pcr);
+			rc = ima_collect_measurement(iint, file, cur,
+						     buf - cur, hash_algo,
+						     NULL);
+			if (rc == -ENOMEM)
+				return rc;
+
+			snprintf(component, buf_len, "%s:%s:%d",
+				 pathname, "cpio", part);
+
+			ima_store_measurement(iint, file, component,
+					      xattr_value, xattr_len, NULL, pcr,
+					      template_desc);
+			part++;
+
+			in_cpio = false;
+		}
+
+		decompress = decompress_method(buf, size, &compress_name);
+		if (decompress) {
+			rc = decompress(buf, size, NULL, initrd_flush, NULL,
+					&consumed, initrd_error);
+			if (rc) {
+				pr_err("Failed to decompress archive\n");
+				break;
+			}
+		} else if (compress_name) {
+			pr_info("Compression method %s not configured.\n", compress_name);
+			break;
+		}
+
+		iint->flags &= ~(IMA_COLLECTED);
+		iint->measured_pcrs &= ~(0x1 << pcr);
+		rc = ima_collect_measurement(iint, file, buf,
+					     consumed, hash_algo, NULL);
+		if (rc == -ENOMEM)
+			goto out;
+
+		snprintf(component, buf_len, "%s:%s:%d", pathname,
+			 compress_name, part);
+
+		ima_store_measurement(iint, file, component,
+				      xattr_value, xattr_len, NULL, pcr,
+				      template_desc);
+		part++;
+
+		cpio_ctx.this_header = saved_offset + consumed;
+		buf += consumed;
+		size -= consumed;
+		cur = buf;
+	}
+	cpio_finish(&cpio_ctx);
+
+	/* Measure anything that remains */
+	if (size != 0) {
+		iint->flags &= ~(IMA_COLLECTED);
+		iint->measured_pcrs &= ~(0x1 << pcr);
+		rc = ima_collect_measurement(iint, file, buf, size, hash_algo,
+					     NULL);
+		if (rc == -ENOMEM)
+			goto out;
+
+		snprintf(component, buf_len, "%s:left:%d",
+			 pathname,
+			 part);
+
+		ima_store_measurement(iint, file, component,
+				      xattr_value, xattr_len, NULL, pcr,
+				      template_desc);
+	}
+
+out:
+	kfree(component);
+	return rc;
+}
+#endif
+
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
@@ -334,17 +499,27 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
-	if (rc == -ENOMEM)
-		goto out_locked;
-
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
-	if (action & IMA_MEASURE)
-		ima_store_measurement(iint, file, pathname,
-				      xattr_value, xattr_len, modsig, pcr,
-				      template_desc);
+	if (IS_ENABLED(CONFIG_IMA_MEASURE_INITRAMFS_COMPONENTS) &&
+	    (action & IMA_MEASURE) && func == KEXEC_INITRAMFS_CHECK) {
+		rc = process_initrd_measurement(iint, file, buf, size,
+						pathname, modsig, pcr,
+						xattr_value, xattr_len,
+						template_desc);
+	} else {
+		rc = ima_collect_measurement(iint, file, buf, size, hash_algo,
+					     modsig);
+		if (rc == -ENOMEM)
+			goto out_locked;
+
+		if (action & IMA_MEASURE)
+			ima_store_measurement(iint, file, pathname,
+					      xattr_value, xattr_len, modsig,
+					      pcr, template_desc);
+	}
+
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
 		rc = ima_check_blacklist(iint, modsig, pcr);
 		if (rc != -EPERM) {
-- 
2.30.2
