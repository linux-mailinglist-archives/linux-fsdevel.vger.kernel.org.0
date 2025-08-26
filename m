Return-Path: <linux-fsdevel+bounces-59158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF15AB35247
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 05:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB6166FA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 03:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43022D59FA;
	Tue, 26 Aug 2025 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OVFg10kd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4F2D47F5;
	Tue, 26 Aug 2025 03:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756179465; cv=fail; b=q+3q2KvH7FwNZ9cCbXWRJ+P0oa8FApUVKgjzK+Blr3INGNitaya0937wZA16fCm64DiMPAcwgtMae/YAryQEdEbEYYU0A+oceDRdiwnStSr9BFAlaNKAfPkptzurgEnDkTvO1HWsI/HK9YB7HNFDV/YhN/P9NCo4jLj7ncc2+0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756179465; c=relaxed/simple;
	bh=z8OikXUVWHUfcLDTzniicmJ4H4lZp01TsfxteW4Pxk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2QR9ujhUPfq/4P49wifSCNygEOjYd8NAJmhREnsbBuvJGFzsbSW/eZ/amMR02+s7C4otfle5lt4oMfVrsH0c9PBLr7VUDTJp15nAAEguAxQ5O9kVgz38tKX54RnzrIw1a/U0nwyYuLgoRI2OgJffqdmJvYchbqxXjyvZsijGGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OVFg10kd; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIGKvl4dMW4P6iFm1bafxkLSKYpanHckrVbD41MYRidcvEJAwjLeBLhpjXOkureprNMF7OvCV/lnbh6udSUzczABLVNfUwtLeYinT44E8kDEO1s7F3fNRhcqiOsDukDx3QJlmJ1qtuCy6n0HMyKqOVmV7dkneUsA4xBNGFXDkW31vo4W1kmJBIyog9MRTw0LnB/MN3r6C1z2SxN+qGgC3E3WXP3HerlyMLWUfkg8gHdToGshRoEJVcmRTmeUDXpwXan8QHE88EHlHrZM7+OHJ1mL5unukdtZRhjh+7y7Y1xovzNVhKdybYHmLHLTTJPg8bRQba80kXB7sL6HUpOf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4yQ+GMFSLYB46RLcXWm6mdmzhwhqr1gZWpV76GGgW4=;
 b=QPLhElZhlM8RcRdLP6xwOg4yOaD/bPBROW7vhfA0VeyfiBybvDWQ6iIKHJwSIgmCvWdG4Sp2+GfLHyXCO49jolCfcQkZFZk8XDZ6F11KTk9eOFyusiWx99rNI0zxO3ZyNdTHPJ+SzCNJRq+fQ9yPf4IQpe2Ja4PpeTmtg2s0iPa0VhvM9Jc50xO7Y0HiyL99XE9SomFXoRDvgZTw6UoTMkyvjSRQSZkkfJQheUkJVKDJP+/fii+FAQ7dF7HXjHIpWIYlkk/eHMw1MWUmY9y4IGV2basHJb/Vp48BrhVaS6p3yZ+A/ltLqqQ6W0Wsn7IzGBs3NIuu2eDD0tN2vHQ7nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4yQ+GMFSLYB46RLcXWm6mdmzhwhqr1gZWpV76GGgW4=;
 b=OVFg10kdS85cuJ+ZcCWB/euxUYsYIBANuDyINRx7d2d0m4dmOOw/raAr2qXVkFtpn2TUnPGYsN6oq1tYgRtCGuMblZVIlPUaG1H7GRfOUnnXFT2fubmeeJA7fEdc6CXeQL45Ypa6zfizBhnumofdcUXpB5rMmxoFkGR6vJxOlC3Eab0P7clYITzjJ2YtHfXQ3AsV31OFlALMDvQRMyDIF7539Wh9IST/xca2qS3YWe0NKTTYsNs9ALY1EG1o/AH7tZMtBWfGqF78HSxCSUsvcxu71QUQ2a2g7JJuD0Ehqo6Crl61wbiAhs+4sdESZ1dss5z5CEt4iRKfTnbByp045A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com (2603:1096:408::78f)
 by TYUPR06MB6027.apcprd06.prod.outlook.com (2603:1096:400:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Tue, 26 Aug
 2025 03:37:40 +0000
Received: from TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9]) by TY2PPF5421A6930.apcprd06.prod.outlook.com
 ([fe80::6370:9e0a:c891:a1a9%8]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 03:37:40 +0000
From: Chenzhi Yang <yang.chenzhi@vivo.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Chenzhi <yang.chenzhi@vivo.com>
Subject: [RFC PATCH 4/4] hfs: restructure hfs_brec_lenoff into a returned-value version
Date: Tue, 26 Aug 2025 11:35:57 +0800
Message-Id: <20250826033557.127367-5-yang.chenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826033557.127367-1-yang.chenzhi@vivo.com>
References: <20250826033557.127367-1-yang.chenzhi@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To TY2PPF5421A6930.apcprd06.prod.outlook.com
 (2603:1096:408::78f)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PPF5421A6930:EE_|TYUPR06MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: e88cc202-c346-4c14-0720-08dde451e8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/FFTzDaUzoNU4NPfoIRTizGTQHR0VpHG8L7hv277xjXpc/o2erhlZocSN2/Z?=
 =?us-ascii?Q?LSoiyVrP22iH+Ww4+/HWzAD5DDE8baW9qqHc0c33WrZFi2D8HLlE90iFig34?=
 =?us-ascii?Q?RLoQaMYgJgkFNXrZjTT9U4QFalFkZY9snwB2rKZcNJSmJ9/R5MiM+Uni5SZn?=
 =?us-ascii?Q?QT8kXIeZayt0ziHdVFm5hutY5aZewgVJZUghEepV7H0eBLg6VS2DMCGoskHO?=
 =?us-ascii?Q?aKTSu7g4p6mmO8bN8VSqID1gATFDgerbVxReialq2YynlthHaC9o9f9gU5ju?=
 =?us-ascii?Q?KtCUUysG6uBAn3+5pJGQxJ3tBY17mrv1jMGBbcA8cvm46VsP+aV1NREw90nN?=
 =?us-ascii?Q?OLn/a0hCd6Kf2rnO21oS2LJuORv0RGyxBxOezFxFs83+34Km1rY6pJ1Pl1or?=
 =?us-ascii?Q?9t+jOEtK1Mfjai2hF3ki0B2kc5dbKR5HmPZnvs/RGPsKb+fG4sO7qIvS4VvG?=
 =?us-ascii?Q?Iqz/yyNdThX+Mmzhr5bXknuD3qejmchOTlatsT1Du+CB0ZALYw6xq+33oYBr?=
 =?us-ascii?Q?+nlxRO5sJ76GwbCo70c+Z/VEzBnvZafFB/t/GK6TtNn+PQEFzoqw25k4wORI?=
 =?us-ascii?Q?nICYltU6dStPfBLTX/JMpHy9N3mDsDqzjsoTwtWjMNpdZPaMRMPrV3LPZN09?=
 =?us-ascii?Q?Bv6zPK+ylKhPVoZ+mAFxovbhohFsl1ToU4flUU/s5ClzhCTnakZlzhXXKRa/?=
 =?us-ascii?Q?FHQt0DMRBGzangnqo08YiE49f4WaRSGgt5/YCdBw5Nb9sD/BA3gMKUvnkCwq?=
 =?us-ascii?Q?ZDL6PBSvc20rP6behRtZAbHcTLkfegdm3FhXBUOkCe3v425CjIDXZvRHDGa3?=
 =?us-ascii?Q?qJ+d7/fGjZYOaDCsQ9KxCOYlvO2GX1IIVvpLjFejonHc28vX8EjSc0TCFf5y?=
 =?us-ascii?Q?I3ADS0fhJ5zpBT7M2jX0N4WIUZWE+p31BP3i495HcWmjM0GXngf7MH+7U3Ua?=
 =?us-ascii?Q?quvvdaLT0x5We9qLM78r+K6OWwt5cRteO2Thuqq3Q8+jJhKy+jK9+vFKoQ7D?=
 =?us-ascii?Q?zow9xOoRjSm/pWxw6v/a4kUtyfFoeYpahAV0+9W7EhdfdAMfO1I9Q4BiWn8+?=
 =?us-ascii?Q?GkzKB4e42d3K5HIlyM8MU+El3pgy6VTK8cAn1hNMfWUEkggiZ5nBOq1s03pR?=
 =?us-ascii?Q?iDp9v0dF3pnD5CbcSBKujkn6MGZOspMgvBa5j6v6zDr0Z/WsZ6C56WiEK2iz?=
 =?us-ascii?Q?JiQRpIZRWaqRAZiugR1dhhXfEzVRsIFWeTcj0GHmwLgassZHunLHisCUTsMH?=
 =?us-ascii?Q?rJy0POcw03ig71aK0bnnp1d5wECglKdHal+/lOAviKTAmgsqT+OGmmArPUMU?=
 =?us-ascii?Q?Q4hutfxsjTx4amNfuDfYYHM10OY5GmBa/lWwX6oz6ZdkdEXbH3TWTGFxJ2en?=
 =?us-ascii?Q?sb08ZoKpijQuRiGbpOvoKBnOsFWlKJppvyouUzLITGLiEa81DcD1oAn4aUI8?=
 =?us-ascii?Q?RLCbgw8hW0KkDYHwIdPXLurd+lGyl221rYy5Fo+4kBqoEk7aYknn9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5421A6930.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEpLHzu7OiHTCUwG2yyGM7jPhViJr9Ho4HVikna3lgwpONb9KIEQOz6PLwYy?=
 =?us-ascii?Q?7XHCvN6dBIubn/rCJhWT0wd/yVedP1AWNmHjVrh7bLOFzxTFDuayd8JWctYM?=
 =?us-ascii?Q?Yl6TSMcQ7XoZPB8NbWCpPS2BZdZXqtQ3rpftRh83nwtuEAQkoZfrU7A6GhUW?=
 =?us-ascii?Q?itz171LRNgvzJsYz45xgH5x6+/WxKtIBPfzzUrAFzmVkjEGiAbpdjf6Pw81M?=
 =?us-ascii?Q?+xxNhwyjjOt0hI0M1QpS2TiDAa+jfQo3+/5OIiHBEDc3Br5wTJp5GdoJ4CHI?=
 =?us-ascii?Q?hLvKxu5XjzB/Oo93xeUeaeZaSxiO5OI4XcAvIzHo85u3E2Wb6yWo+L1muMme?=
 =?us-ascii?Q?jDFkgC54RqD0djtbE9jDUW3YEGXEVCa7sZwxymsi08Wvhd44AyUo/oatL/0s?=
 =?us-ascii?Q?wxi9PcA82iJ0ufo6ymfnRPFYKFsDgGQrSgv82J1IRqkJ7bmD/SDMOdMsdQbX?=
 =?us-ascii?Q?CzGdCwYVhFxEKwNu5C27MVcbRPrKWLzEwigyBKO82POZyeyGLEA2K4tem2iK?=
 =?us-ascii?Q?pkos7IXjU5sOY3+JyFx1cbwyEaG5RKWTs/AsMrWeRzJCV6G+zbrTnWboomAy?=
 =?us-ascii?Q?g7AINlkypFU0k6LVAW0AYeuXTrqnSr6GlDrPIlBJ4Jjo8HvNTgNXukZ9yrYY?=
 =?us-ascii?Q?SsbhpwYBBlrDH5PAFUv8I+eKbUW0fxhx3mV5hSWf104hV3l9CtX7oUSgg8Ji?=
 =?us-ascii?Q?qJfizgvhj39F6ge1POfTYpt9nfOZd0+u1Z3825iPB7LaAVrwda3s2P0kIZyI?=
 =?us-ascii?Q?dm8pys3qvMBvHwJ+ZP1Ms8oGeFWxWqG0gKpKEq2GqITY6/j1uw511Ehb/6+N?=
 =?us-ascii?Q?av1UNcgm+0Q8TLd06x4DYFwCmPlJUGPcE7wxDsMGsV0uxiXmtXI39hZRzifW?=
 =?us-ascii?Q?LSh0RU+YH7N5RGpyp3NTriEUBYBFAlV1gvOI5/5rU0ILsgCgTtuUjZFI54r2?=
 =?us-ascii?Q?z8ARxAj/VS0nsyLqVxIx878iUmBOnmpoekEx/Y3nj9jH06UUOq8fnYQaIho6?=
 =?us-ascii?Q?vwRLygocSgkfHemYT/PICRXHo/vK4OGxJAqqTfykSy/QQ/gOMLQ554w2pN/F?=
 =?us-ascii?Q?3dnIpkpEcHrnAbDGCgZKVoKLPNhXfvEPOwWQhkEYh372te27lCSWc6kAKVLu?=
 =?us-ascii?Q?ZbawZzqIMtm0x+3nMGvwPqIpO5Wpe59ljZspCuI0I75K9b0SAcFU0MeoZx3+?=
 =?us-ascii?Q?/8QDteFKOqov7Q8hSE51TMewejPkN5BtZ1mIwWUxIMqEd4UnDbyaD0M+U37f?=
 =?us-ascii?Q?eb/zjfp6bPgmg1IxM6khchcGfkO69GT9fqlVV/zAuCeHxjNmg7w7YNqNoQcM?=
 =?us-ascii?Q?yGE7HfDMxQwog1li/+uFo2c9oXSHixy7lMqQqPLbLJZf5Nm8auU17+uA4fkl?=
 =?us-ascii?Q?Fu7GTh7J1kBlWLL9wGzxGNwY5zwdgDTMQdkabi6/mTO72gM0cbDt+1HZB0gr?=
 =?us-ascii?Q?azMpokuWSh8u6onFrkl3xz5qoyI6IZ6obl2n7XT8GRb5E2hgdq9bYhrNiM98?=
 =?us-ascii?Q?nWLChBvZrUXuif0d5sUqNK16QueAGXcWw7srQEbB3Dwvq1+MTFBeLwGGaMTp?=
 =?us-ascii?Q?/4W+7ABXpjsSnoWVQuH/68ufTzzCcQtVWk1HnZ7e?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88cc202-c346-4c14-0720-08dde451e8b3
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5421A6930.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:37:40.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tbc7N90w//nMCefbTUk03aSPr0p9KkoJp3a+MPQT5lPkSQQQM2F8TwX0cqdqoJ54/kWBDLkPYS+GY+EAQFgtaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6027

From: Yang Chenzhi <yang.chenzhi@vivo.com>

Restructure hfs_brec_lenoff into a function that validates
both offset and length. This function now returns an error code
to indicate whether the execution is correct.

This helps fix slab out-of-bounds issues in hfs_bmap_alloc

Replace the old hfs_brec_lenoff interface with the new
version.

Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
---
 fs/hfs/bfind.c | 14 +++++++-------
 fs/hfs/brec.c  | 13 ++++++++++---
 fs/hfs/btree.c | 21 +++++++++++++++++----
 fs/hfs/btree.h |  2 +-
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..aea6edd4d830 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -61,16 +61,16 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd)
 	u16 off, len, keylen;
 	int rec;
 	int b, e;
-	int res;
+	int res, ret;
 
 	b = 0;
 	e = bnode->num_recs - 1;
 	res = -ENOENT;
 	do {
 		rec = (e + b) / 2;
-		len = hfs_brec_lenoff(bnode, rec, &off);
+		ret = hfs_brec_lenoff(bnode, rec, &off, &len);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		if (keylen == 0 || ret) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -87,9 +87,9 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd)
 			e = rec - 1;
 	} while (b <= e);
 	if (rec != e && e >= 0) {
-		len = hfs_brec_lenoff(bnode, e, &off);
+		ret = hfs_brec_lenoff(bnode, e, &off, &len);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (keylen == 0 || ret) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -223,9 +223,9 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 		fd->record += cnt;
 	}
 
-	len = hfs_brec_lenoff(bnode, fd->record, &off);
+	res = hfs_brec_lenoff(bnode, fd->record, &off, &len);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (keylen == 0 || res) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 896396554bcc..d7026a3ffeea 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -16,15 +16,22 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd);
 static int hfs_btree_inc_height(struct hfs_btree *tree);
 
 /* Get the length and offset of the given record in the given node */
-u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
+int hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off, u16 *len)
 {
 	__be16 retval[2];
 	u16 dataoff;
+	int res;
 
 	dataoff = node->tree->node_size - (rec + 2) * 2;
-	hfs_bnode_read(node, retval, dataoff, 4);
+	res = __hfs_bnode_read(node, retval, dataoff, 4);
+	if (res)
+		return -EINVAL;
 	*off = be16_to_cpu(retval[1]);
-	return be16_to_cpu(retval[0]) - *off;
+	*len = be16_to_cpu(retval[0]) - *off;
+	if (!hfs_off_and_len_is_valid(node, *off, *len) ||
+			*off < sizeof(struct hfs_bnode_desc))
+		return -EINVAL;
+	return 0;
 }
 
 /* Get the length of the key from a keyed record */
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index e86e1e235658..b13582dcc27a 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -301,7 +301,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
+	res = hfs_brec_lenoff(node, 2, &off16, &len);
+	if (res)
+		return ERR_PTR(res);
 	off = off16;
 
 	off += node->page_offset;
@@ -347,7 +349,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			return next_node;
 		node = next_node;
 
-		len = hfs_brec_lenoff(node, 0, &off16);
+		res = hfs_brec_lenoff(node, 0, &off16, &len);
+		if (res)
+			return ERR_PTR(res);
 		off = off16;
 		off += node->page_offset;
 		pagep = node->page + (off >> PAGE_SHIFT);
@@ -363,6 +367,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	u16 off, len;
 	u32 nidx;
 	u8 *data, byte, m;
+	int res;
 
 	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
 	tree = node->tree;
@@ -370,7 +375,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	node = hfs_bnode_find(tree, 0);
 	if (IS_ERR(node))
 		return;
-	len = hfs_brec_lenoff(node, 2, &off);
+	res = hfs_brec_lenoff(node, 2, &off, &len);
+	if (res)
+		goto fail;
 	while (nidx >= len * 8) {
 		u32 i;
 
@@ -394,7 +401,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			hfs_bnode_put(node);
 			return;
 		}
-		len = hfs_brec_lenoff(node, 0, &off);
+		res = hfs_brec_lenoff(node, 0, &off, &len);
+		if (res)
+			goto fail;
 	}
 	off += node->page_offset + nidx / 8;
 	page = node->page[off >> PAGE_SHIFT];
@@ -415,4 +424,8 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	hfs_bnode_put(node);
 	tree->free_nodes++;
 	mark_inode_dirty(tree->inode);
+	return;
+fail:
+	hfs_bnode_put(node);
+	pr_err("fail to free a bnode due to invalid off or len\n");
 }
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index bf780bf4a016..78f228e62a86 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -117,7 +117,7 @@ extern void hfs_bnode_get(struct hfs_bnode *);
 extern void hfs_bnode_put(struct hfs_bnode *);
 
 /* brec.c */
-extern u16 hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *);
+extern int hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *, u16 *);
 extern u16 hfs_brec_keylen(struct hfs_bnode *, u16);
 extern int hfs_brec_insert(struct hfs_find_data *, void *, int);
 extern int hfs_brec_remove(struct hfs_find_data *);
-- 
2.43.0


