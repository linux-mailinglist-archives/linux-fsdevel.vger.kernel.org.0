Return-Path: <linux-fsdevel+bounces-59640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20140B3B809
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA33B5E360D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 10:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2308305E27;
	Fri, 29 Aug 2025 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="EbZvxIgI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012054.outbound.protection.outlook.com [40.107.75.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649214EC73;
	Fri, 29 Aug 2025 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461821; cv=fail; b=FEATNSbtJJkggnZcSjtPC00+P5vLmM3fwyjrPushdyRrFTluxRJMplUJJPxqHurKxqKXVxYTzNmWAZxIFABWXuWT0LpZiDtN2mTYyh9rUdDJlaovG60r3cr1YdEYdW/9GNiUn1vnX4Qj1dwUyxP+PxqYFFgsxFJTyvxRAt6O1lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461821; c=relaxed/simple;
	bh=mChF1eFPuDOseW8qSiYDpyJv+q+2f4A9tvzMBcWdUlY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=V6OLXb01k4MXaJxUh9TCh8u/JuVsWAvC2UEtpq8P/6BaaAffTDrLdpN4afsrE0xjlOTndOjmt3sOPAycMgH5Nl9ZeaskNfwouBe6ayqpT6GfO4i8mLQ+NBneCMoZGT9A4rk7SkYDc56cRkgrDPuFRI7hbsQ38yn6scUWE9X3br0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=EbZvxIgI; arc=fail smtp.client-ip=40.107.75.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HifHsIGgWV42HFjHBnvMIyAusUVGdaHi/6jfN3fu3k0zC4I+ieBhd0O+xxzAFCwGEBdmwSufI8C84HVpmFKpevU2AnSNiagv3X6fspjCNOM5r5RRDfjeLM0qbDUbYu/4BKB42mgzF9zRqtejOjIw4RstlkdoUDRMb0V2nxR2zWoBVSl1jU5Q7jCngOW9hXjHbDxFGw80JL7BrDp7k5vhqiwou6VT2u3gqEViczr/bTwPf29Y+Pr/2GMcP2hZrBludyQZT42xLHQm1nFg4ep4odpdaJ4+r3JhsSSj8uAEKJhzX05ctSD69JxAL9CLIAUN6AD1MZ6J5OSsg9hZwNph2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wOZ3fLWd5BOpG46EQz2X5L9F/xywNYo2WWfEsUbelI=;
 b=QY9aBlyH40henzkc5LcexcbEB1kaHC2VGY+pvd84+0pm9L2Zd50AyMtyN+JScYt3GWBsG1shqsWNF1zia/L6ZmiujEc8vck91HF9tD8PgKsN6YFHXCc5QIFFTYAdtdV6Oo6JGu4TYU2SFWxDLGkc9hJv/Yjoo09i28Ijwbrr3NmD92uQyzCPBDE63nHTXFMd1aRL8Eb9Q9vNCQ6yg05/mOJidRygySa92A8+Xa7jEcTsbol+U/aZaEEDrIsVvgE04bdNjKkRqnen6v72P7UlTRgfFJDRmGNK0uKwtE9qaTujGBpifFvAgtIhPzNt/MoiJq0/v6uI7MDp5EkDJk/gnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wOZ3fLWd5BOpG46EQz2X5L9F/xywNYo2WWfEsUbelI=;
 b=EbZvxIgImwFAK4sLatr4De7UAsi6skWsA4cncjib2H5HEWQj5z82G3mN4jLgrEqi/0xpvQWojLrtK3OudviKSEm8ulpkvW7exOAtndm5pnsR3hwFzDz9sp0pbN4rGSwXehhCTzTe9HuViqViaoGprQiNIa8MRfY4bH6sohOsoQURLBaUSqnkEmpsHM8t9crdLS1DFd3KXF5BXJjU7jpR7jcIIQIto0vvAhHsFFqJvyJSd0KnK67F/N+8QYQHJfebjpZnalLIBeKvoW1sCA6cTISlklw9tELmNFTVMAn5eAl/cYChMd1rlqudzCYoWnwboKBbHYFjSc47TQo2Ce+y1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com (2603:1096:405:a2::13)
 by TYZPR06MB5932.apcprd06.prod.outlook.com (2603:1096:400:341::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 10:03:36 +0000
Received: from TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3]) by TYZPR06MB7335.apcprd06.prod.outlook.com
 ([fe80::7b7a:484f:5ac8:29a3%4]) with mapi id 15.20.9073.017; Fri, 29 Aug 2025
 10:03:36 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] fs: Replace offsetof() with struct_size()
Date: Fri, 29 Aug 2025 18:03:28 +0800
Message-Id: <20250829100328.618903-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To TYZPR06MB7335.apcprd06.prod.outlook.com
 (2603:1096:405:a2::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7335:EE_|TYZPR06MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0a9e51-f95f-4070-bdcf-08dde6e351f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uAKQRfAuCr0M/I7d10mrKEbFwFtoBe2LIKSUAlQx8aEbq6oEK1qFHPpvnU0O?=
 =?us-ascii?Q?K4vWhAEpc+KjNKEzNX237V16cyXo2bEulv6msgxoOFGM83Bd3QqtxMk+Ab8q?=
 =?us-ascii?Q?S+ikqqoB7LQLj7r8kLzospK8s+n4EpgKlwuBS5xaR7vdKw85ZZMq08Z7AIwH?=
 =?us-ascii?Q?qyWokervemRtfK+8KMNQ/eGioL9N9wkhEN1OyoEJKI3k/Ag541OOPhaDkAvt?=
 =?us-ascii?Q?eNrriiKSNd8foVKU0yH3xCA6zNQtFyPJUibehGEtvp7fF9nYWRdLHRtqtWjV?=
 =?us-ascii?Q?IjDeXwJ9l27VbqhratfqFOuaDV6c6lt47bWdTALt6MkrOEyd5TR16A1X81Bq?=
 =?us-ascii?Q?06DTMhZSOUmxnPUuyY9FTh7ywQdjFnhhJDy2LDfnUa78oYP4FU83pR1e63sO?=
 =?us-ascii?Q?VCXfkinlZp2j0mRx4RgnYvNaEYScP56Dr6EKOB+oEzx5VBvj+hDYywYaCiy9?=
 =?us-ascii?Q?bHkXfDbgrHSiWP6szaooQEJMzc0+vAv6Uemlqw9Kq7HlDwLGI4aFgq+d09P8?=
 =?us-ascii?Q?WgPDfaNGH3B23kNGVH8zyNQrtmmWoBZ0O8DZKew6DXhGEdf9+TGhMhw73tnJ?=
 =?us-ascii?Q?YYmePK/6ULqU3rZCRNjOACoH2JpzHfJ+4EHdhq9iNha+8KaYu0VvEplhKqhJ?=
 =?us-ascii?Q?jv2YMMTdEQI/AzJY3RF1OMH7oN5R4Vtd6cSyriB3Ga/E8cc+hTvSjfL8gOog?=
 =?us-ascii?Q?33Tja+gcSM6QxlyCkAz1YuxOh4XWGvFA2t8xcbX5zI7KZiv6dFgF8LjOryZK?=
 =?us-ascii?Q?MSgrsE3/fXoEjsFVtLTrmaQCQ57iDmAsfanqrrwu8lVFXcFnWz1qXy2nRV1m?=
 =?us-ascii?Q?fOudurvQdaRjyfQoRENDvsAk17hSxS3nt2H7If/iyc+VwX00KjmdEICDkczD?=
 =?us-ascii?Q?8+SSsIDZ0009gBmsjjjEhM56/kQgv/jQw3rUNtkqnJoiWtJQ/iQfoPo10yrQ?=
 =?us-ascii?Q?H1ebK+CBSNpCM5U38nwpeHTpJyo6/07ElPAwEPUzWy9m6AsWoalLQzSZAE7T?=
 =?us-ascii?Q?TEi7EwMMo4WL5TOqPB9COHeHfZENqgaWGWwJ2fwsHdWjAH8HBdllp9uaQ5AA?=
 =?us-ascii?Q?xzZ2WtrAUaSymyq/aKpf+DsR6wl1GMd7e7cQrX3NaY/Hqf5zW+4cR0qiLuFW?=
 =?us-ascii?Q?kae8ua7ZZwO1RSQmSZIlFcQ0YSlBM+dbjK5AtOcuJccSQbtn9qu+TdIyi4IQ?=
 =?us-ascii?Q?3t8w5zmBZUYY7weQ0JeLKH9IMMVUxsM1eYthEPxnYv+6Rlu/hyjoOWd8n1jS?=
 =?us-ascii?Q?AGmZ9QzMH9zp0qF68wrZ2qQ/pDeng+5W7ORmelEspH8MD6ceXeSbaeQjQM8f?=
 =?us-ascii?Q?i7gOu5DTiXiDqnRKXJIEaaClSoy/VXlOn0D6eb6uOGgbovlaQvrQn5Kh7Jdf?=
 =?us-ascii?Q?tiJvtnQQZFDWoYmzj1JriiRMgsyyeqmd0rM3kNszHfkzfB4p6ohHtOXWPLP8?=
 =?us-ascii?Q?Z7avLNDcGw4zOdGrrDil55KB8SZQcccngQOCvexZ8OhbGHXEmkZmsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7335.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBsp82xlEggiVBL1JNN/Nbro4NPOqwjZ0VSMdUT2ljaI0kqhIlPOigubGdTk?=
 =?us-ascii?Q?HEept9cmW297cg6xvb0H18q/BNfUG2CsIWgIVUaahxYQUA3kTirvq3Tq+Ibq?=
 =?us-ascii?Q?uowjB6/v7LyxgWq96Io6tQq5c1+gqBUBEgPXQJre2m0kdYOUrpTfTP0qRYzF?=
 =?us-ascii?Q?3rjACWflwE3teXa0AT3qlxhuBkgURW3tBfPSk92DE7ClxCu96yqzKSq+3j5S?=
 =?us-ascii?Q?BvKk+Rs2S5tBzmUoX1/NXBY59tGSUNsqBQXWPimbGMk8cYjKPHow/O1cEm4J?=
 =?us-ascii?Q?406TL3fXKCdIcx2KMAV2HbkaUNbfKtNBvHmBJX4iR4uRQq7N4OsqhYiST9di?=
 =?us-ascii?Q?EIfYHhK5J5KIcBpLHpRxuU9Kbvm4MZtJS3fmU6PC8M1JugwB9Wkck3UPdekt?=
 =?us-ascii?Q?ZAYIcBQEvH2qkOheUHf5mYppWi+tfeQHJOJRcNBbByvS5shuz75hLGS3VuQY?=
 =?us-ascii?Q?uChTalTaQNQlWo790/HG6CKtM/HQJnJirkdFIJyGBWRHZynyzckKA7sDyipG?=
 =?us-ascii?Q?4t8jaa4VGFaWjN4TIqcsZ8mO2kydRPTTrJll92aH5StSwTIo/MFyAc35/Vdf?=
 =?us-ascii?Q?KJj1V2G+QnIqeLMi552KhkZtsOFyQB7Ls95FKAUhfRtoNIpSEtr1SamYoov1?=
 =?us-ascii?Q?BG9At72s00Z3pLH355cdK5X+XY34kUaIHbyW+rBJz5npQnG286w4qDbAL4H9?=
 =?us-ascii?Q?hyzd1poDT5+aur5F9zuUVZmEpzSArfEnwrx+qgmd5Itijl01ccnwWNtNU9F4?=
 =?us-ascii?Q?SkVuooALnZTi8sSE38zZr9frdRbiUQ9hJUtEYclpa8grw8BmiAPyJC59ObrR?=
 =?us-ascii?Q?dBF4mjCW/9kffAI/Rbb1Wdm3hkVKbAeFXp4RiO5IF5PHrgT9dMZ8Sw6Mn5PR?=
 =?us-ascii?Q?yNfTLwafd7fvn7Vh+iEetwMeFG9mDI013mQSUla6OrUrRBTM72k+fu6QB27h?=
 =?us-ascii?Q?8LkxbhlUF4++/btyCfMTVazE1XCljDVDjBqNycjfWLiNdvG3SfaS6vZJn1D3?=
 =?us-ascii?Q?0N2DNJvWWY6rxhgixKKDI23XREPd3Lc0RYhO63VdRL7fATHl8nOBL1bQf3Ax?=
 =?us-ascii?Q?EsIQ/U7/1UYTNeiiaHjHNWkxMGcoemgn9kH40DOF0jHnMn0fyzzlG5NJ2NZN?=
 =?us-ascii?Q?lyZv0wfQzQQ4K+gTB7AmtJ6xXj5y1AgjSS4m0kNxFjkvae3Fya0TvWujKw2q?=
 =?us-ascii?Q?U420VhEIlonmU8Hl7A7Cd1j+WoyZqQE3BndU8Gymzt/9k4l/Pyav/6fDlzIl?=
 =?us-ascii?Q?a1RCPLUEmEoOr40SpDDMwR4wplsiGF2/3ZLS+h5UX1O0wz1PunRx2P70Zg9L?=
 =?us-ascii?Q?RC3fmD1XRBZutxjNs1+pmf4li5AksOs/qQWGAb1hShIT0QC4+NBW9rKDnCAG?=
 =?us-ascii?Q?k3r2voT8hAoPsrWx586rWaUIBgpPFo4+SG3LqY81sZhKQBm3dIrh2g8BiyJC?=
 =?us-ascii?Q?LvJHippvMeZ36CrwwkMi2tDByrExy6z4PlL3m/hUEVtB7Q7kcfTosZJvp/kV?=
 =?us-ascii?Q?WQo9QcWBIuNEvdS4HARMSel6c78W7NeTEG5y+wl4RZsjuh3rTK1Lxhj/zX+e?=
 =?us-ascii?Q?Dm1vz7vrLRuyVMOOkMWKiZxHojSaJ8Ajp35rrnJ2?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0a9e51-f95f-4070-bdcf-08dde6e351f7
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7335.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:03:36.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ukL5oRigh6nTBHH19NKxcxibXhCSlhwQBPEgOnS6NOLKIAKdWZZn0cVSIXWi4CTKcdgGeTLzFwKYtUuKVLyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5932

When dealing with structures containing flexible arrays, struct_size()
provides additional compile-time checks compared to offsetof(). This
enhances code robustness and reduces the risk of potential errors.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 10f7caff7f0f..70a71b1b8abc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -178,7 +178,7 @@ getname_flags(const char __user *filename, int flags)
 	 * userland.
 	 */
 	if (unlikely(len == EMBEDDED_NAME_MAX)) {
-		const size_t size = offsetof(struct filename, iname[1]);
+		const size_t size = struct_size(result, iname, 1);
 		kname = (char *)result;
 
 		/*
@@ -253,7 +253,7 @@ struct filename *getname_kernel(const char * filename)
 	if (len <= EMBEDDED_NAME_MAX) {
 		result->name = (char *)result->iname;
 	} else if (len <= PATH_MAX) {
-		const size_t size = offsetof(struct filename, iname[1]);
+		const size_t size = struct_size(result, iname, 1);
 		struct filename *tmp;
 
 		tmp = kmalloc(size, GFP_KERNEL);
-- 
2.34.1


