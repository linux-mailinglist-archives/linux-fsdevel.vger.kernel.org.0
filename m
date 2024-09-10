Return-Path: <linux-fsdevel+bounces-29026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62507973A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB15AB229B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216A1957E1;
	Tue, 10 Sep 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="U8vDYEu4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2083.outbound.protection.outlook.com [40.107.215.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8B7197A9F;
	Tue, 10 Sep 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979203; cv=fail; b=YgjPtbDQ3ErTmzeP3tXDAEjY4CDgQqRoyxEiVBrRoaL+EcLgJeVSAmGF+q2CU6joESlRzj1EUPHeTVrjnEVwjEsTu46H3ShFdq1l0H89hVZql3epf5dFgRAaIdW/fIDUweBDMTUm6mogKMCWs44lKaBNqgF/mQP8Cr6QScZRRaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979203; c=relaxed/simple;
	bh=eQfBWRnpoa96UL/4xVMrGHPlGQ9e7BgCWan4GOMjKGg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SwSoONwzeTIe4mCEGGkwtDEqbTvGr4pgI/F1LDr9S7NUf0ijvgGhSd2e0VZFZahfQRmo51ByfFrzTpbTdfQDEpNJwNEdrEUKzJjgBbfOD2l+pCuZiAZwbngGIc1PYFzEyf+HZPLO2t11TmKUsaGfNm2luUYpx4r7ZmKev4mIgM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=U8vDYEu4; arc=fail smtp.client-ip=40.107.215.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmhiuBUdtvaCCBMLLPDHy47RnpN69meebLHR5FS0bh38SerfgK8Ofcpsi8vqBXSxkR+xg2bWOtR6q5syi7owlr4+wqXZnx1Vggyzt60q+0Gmn6MCIIqP1FqACmSzI/+Fr4X4cxCJHcoP5qbxFF0w2by0rrpzgliqoxmS3zF6Ctt7S3rtsNI3av2BnX5MNTxeXC0au3lUlmeMABE4aJRRdW8jZ1E2VBLNfi0U7dCjhvnp6h/Q6U/2ag/mGJtLo8EZgsUsDxWs4YkOy4d+6NQEoz3wx/kGNIL6S6ayMRIWLtWKxAKk6fMSyc6z8y8+eO1CSgEON9t4LNuqZ5VBNCc6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MU7ULVMcdGr+iJVS88z4uqzCHo03adAPGF+Q86N6kvU=;
 b=S8VklMGlnFZeiQ+wBh0UejD456IBfq78RJjiht2n+1+f+T8zZm8jHK9dDfEF5aTjCZhB/WdAzVCET/ksaW2avqJ+n0DUI1DYmnu8VmXCRwzwpKy48hyhFaepfimI73xMUsgvD/hO01ZhVPvmR5wqogHVE70ijVdRcopBx6Pdr/fn6UoQHPXAvhWlh+Cbgt7+KOVV32w5yr6fGI9PYIXLa1mLLFGdfmo7YDjwszpYE4aYVGh9A+5gkK2omHzsSEV85VBjFPP22ACGY6RiHYoKytr3gXNq/oqiVI5FLcMzLH6wKwlaBaJ275U21p/K1Lwu1c6mMPalbt72wPvsvaI3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MU7ULVMcdGr+iJVS88z4uqzCHo03adAPGF+Q86N6kvU=;
 b=U8vDYEu4wMvGWa56EPfSDC05WhODZ1hB27IUs1xOQYbjuKccgVyYBZtBkqlwGMzOzWwt6j0LA2o9XxzW2lTELxQw7DwXa3C2APfgKgBU3jisLWel2CaZVvX3vAHMvJEo+CysG1nBhMqPAAJjkF9QjBmRlLUl0HUCfU2WuaDkYpRTTWNHP7yiJJO5KEoYLeTBXVQDRpLagRPVqNJqtISEVHcVgX7iEsHkXMJWHY69kl6dKMFIF4OK8SXOef91b7HMyNrLqWC0vU/Twx2tZfC94YDlx2VreLw/fi9dfKq/ZhoTl5JnuAaNI1ow8a4cE54nuIYsRh5CLcKNY7yq4K9DUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5768.apcprd06.prod.outlook.com (2603:1096:101:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Tue, 10 Sep
 2024 14:39:53 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 14:39:53 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: remove redundant if overhead
Date: Tue, 10 Sep 2024 22:39:45 +0800
Message-ID: <20240910143945.1123-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a31517-36ab-44f3-8524-08dcd1a66f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Pk26gwVc0Dlxp3WLDnjZ6WFFvZH3TYNgE7G9xRh9gm8i+OYGMSpnEulsz2F?=
 =?us-ascii?Q?Mvj3pulEpXrhHkffruZGCGJfUrpEw1ONt3UceJ6urO4AskVUtDpcj9YYevbb?=
 =?us-ascii?Q?qXelkHddIEt+VkAwR6K3iDL6tehw1SdGOiVLAAH0k7pTrujfWupHxGOQXu3g?=
 =?us-ascii?Q?UlzGHPZ0nuxrr6ay7nQy10hAj5giBVVCf8JdI61AIsvc6BxEijC4KMI7m/Fj?=
 =?us-ascii?Q?qnMqphq+Ne+BYEzr6aUDWCBANqyVUD1LkoOkZTLzKiJA8ngN+h3ZO3juypxy?=
 =?us-ascii?Q?0vgGzEbwb4BjlYoSQBib7Fhla+9C7nEw3hOYGFACOE3Es+LVGRW0HYhp2yz8?=
 =?us-ascii?Q?+fEg4wh0AKiVUnmlBXy8p9UEow7H4ClEIe1YtyGw2sPJunB6JmZWmz0lzFtw?=
 =?us-ascii?Q?GblkQS4wJQEiuPeF8BRnWohFhYTNv2CPM1Wp+wvnVojWNu4PpwvPkYdogdYE?=
 =?us-ascii?Q?9s45UHf0HgqEXOI4z6NsZeumd6FDOGMNdh9i7QedXAA/JpU4I9nWKwwapSfG?=
 =?us-ascii?Q?cM+5bsZQsfHgU7/GFug649/h1cykBma6MP57zlt5QnSa3uD+6TtHtd5PaSSr?=
 =?us-ascii?Q?h70kVRwRm9ZES6lWihQbTdNDmium4zBVe9ccTOcysbR8K80rvBkoZQ6KnEbx?=
 =?us-ascii?Q?QLrMhwlqETDGGOX/GRmH4RvDV3WdLL9UVBmNDXtMiPlDVIm4NK5xCq0wiBip?=
 =?us-ascii?Q?8rsjFPq8towlVL62aGHw6XRjIU62ZLKUarqZsud7YAa1ufC0jjctW8gPQrRM?=
 =?us-ascii?Q?td8JocSypfWJDgDAzg/Ah3T7kpwmffJtFJ/hd66AvX9muHN3PtOF1UtQinAG?=
 =?us-ascii?Q?Y/R1wQnx6EJmA1XyMi1aV5hli5ekekt8mTraS8+mos4USTVW2c2inJbYvnAS?=
 =?us-ascii?Q?pFDgPOkVEOo8HVqj1IoB+0h+Ee7USA3jHc3Wgj87DrxoLrhqxz480URG7GdH?=
 =?us-ascii?Q?yKWuZoJY0sPz7MkgRSsU1uJwqjUp6OK9eye6UYFLyRjlaJjYWHWQh3m78CSg?=
 =?us-ascii?Q?zDaHVzBp1p5sQKkgpjPn9HpLdmnFK5TC1BWZ30noBIW9gaAriQ7FY7eXmTX2?=
 =?us-ascii?Q?t+iSk35juPKSHImn8O/UGadqwhxKeWMspQonTnd7UVKjMLsEvutx0dJh9bXN?=
 =?us-ascii?Q?b2AdK2nTcsJQfFWJ2wzQf11ZuzYe+OD3RcNqAQfI1pNHViOwnJnPSw/nV0P/?=
 =?us-ascii?Q?ajqKWY7cuDUKX2byoNNI0W/6yp5QgFJhwB/fxUIHdgnxOFOOUwLmLXlN4Riq?=
 =?us-ascii?Q?Y3LEH6mpr+dvuR7xoPfNBP53wGT1yTnM1qRj0nv7ByRVpLuSOX+7e7NmzoQp?=
 =?us-ascii?Q?816rBJCVChGam4yVgKO6KwSNGlQGfaC3LloQxB/hNHHddjcfVA9P4RkbsRqA?=
 =?us-ascii?Q?AJZ7SbzeMS/t3FogKOgHsyS/KNJXdZy1CeKw3pmiM/7LC+vo9w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blm403xNbX1J+J3fsc6FTf6iJ96fCBSJyutFSepbyN4ea2r7PrHh/DuIAsIy?=
 =?us-ascii?Q?EkPvWtHI2s9iKjnIQnnb27qmpaqgvXFKwvflaurVRBjiZic1q7/7YbMoeCRz?=
 =?us-ascii?Q?YtRVVcb8Ho5QoyTIqH1sHYndjJ4dRXIKp5fKb3J07qa/SGYonUo4TIQivBKY?=
 =?us-ascii?Q?yUNaLzTTls2cDnjGiSiqyRe8za9BiOjrngIO9VKE3MECJh9O8R0a9E2MHC6E?=
 =?us-ascii?Q?x3QnLeHsKEIUlIEdcle8d3osCeXZWdiP6Lkvvium446qecTyQ6iYae+ZeI7w?=
 =?us-ascii?Q?ZS1EnxOzgLWsiszLbq+Rg5ugFvThRGL49Blcw7mBXBkq2Rqs+ASDbdnFi/hJ?=
 =?us-ascii?Q?N0fDfjVIODta8dg3QHJ9Ee4eKSCkOBF4W/XsOv3pWxZn35pMpPIklnjp6fWq?=
 =?us-ascii?Q?2RajakihQ39J3KjeKPIqFPKpIZ4BvOZ00htS/s4bmH1ZWnp4Y7zf3618oXWy?=
 =?us-ascii?Q?hgY4Ysk1xO4jTSJ5nrKLkOzEXXRAW0PHW24wYVUARLe69JUosNO0cciXC4EM?=
 =?us-ascii?Q?WGJ33IdJI0/Gxsxql2Z0dE2AC6zBHk6jJc4eqYg648TIrk3vSt8UCuQn6pj4?=
 =?us-ascii?Q?cKGbEq1U2Sn6Gzq2j2/p5tWUph/v0mNis1N1aWgYKiPu1drS5oi85Lyk8ohj?=
 =?us-ascii?Q?/QNeIFLnJzwrRJFVYj5SyEVzLTs5mhpgjzTLcAGSKLvqtFGihHKuzcik4+AF?=
 =?us-ascii?Q?JZhR/drL6m+SAEJd7Iom+Ef3Djlsts/o6KuqdbNyIeK2SUTEg/VZaEYBZihW?=
 =?us-ascii?Q?WGfp2Sq50rpNeCdbr808g3jh1V6gh3Maff36J+jdmFxAVOM5QZ8E7DnnCM77?=
 =?us-ascii?Q?Dz9QdVia90gcxNsoMXmC/X17zbmlr7H1TWlLnMSm4Ma1qEzT2TSN4pagAUon?=
 =?us-ascii?Q?VbCTjPZGhOIdEyq3jxJ8vywSBq6EVUiSyuYdLRzVkrgrBlXkU1+6yj9syRUm?=
 =?us-ascii?Q?dX6IF6L9ewzDdKkayClEQgZtKRKksfEQLhS22l2E/ej02z64M5akeymWT3Ta?=
 =?us-ascii?Q?JJnoQgjL7Ih0pXOlDpq1K4UiWCBypP13iKAV7nR/ON7KdJzsso6Q8LW6b1GM?=
 =?us-ascii?Q?7LLv/Lr8McbsplAVY4bjYgXW2hj7AYtZZz+xQOeUPDnGv7M6pL5itZP2TTyM?=
 =?us-ascii?Q?buw3hJMnFmdOelOlpML1SE7Ft9aho0bHzGnUo8D45rtCdhD/EHidg+WOacHB?=
 =?us-ascii?Q?HeLRRm+IJsEALxxRpOfYbukYtsy3nBfgyW4MA83odcjBXAJudTsFbFDoVoX0?=
 =?us-ascii?Q?8YiLva5PdmmMjFCQtb2Qa+vT5GuBlstQpRsIEbfNmigRWTeh4S6JKuW1k7LO?=
 =?us-ascii?Q?EIx4yOVsDEeYkz5IF3kQKbyIV4cK01Rq0xtMub0UDVAotDIMHZtZNR8JMeqz?=
 =?us-ascii?Q?lSpJy6MmT8ch8k1x3hBdlGbNRvubXJuFnNx3O4q837pqOW4paeae+pg8Trsn?=
 =?us-ascii?Q?9/X8I7qAtOWIcRuWTse+Xqg5aWHPbc8OSijLlFm1eDWZ1AToLFOBYhlVY7hp?=
 =?us-ascii?Q?pN4sqZKwdXllWeG+/PA8Um6kCL8nWXRSwaGhUnpedQBcK3P/oHGrdsyYXacY?=
 =?us-ascii?Q?ossGbneggJv4jLz9bTuem511+/vMVWt7Pnju4E7V?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a31517-36ab-44f3-8524-08dcd1a66f01
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 14:39:53.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6BeCuds7Sd+/Avqg6OF77zoeSfDN7ZOKoJF31FcMRM6uTLMKhG1us5X0plkZaS+M0g64SCB8Lw3yD+VJaPOXww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5768

Remove redundant if judgment overhead.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/page-writeback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..2d2c3f4e640d
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2715,9 +2715,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
  */
 bool noop_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	if (!folio_test_dirty(folio))
-		return !folio_test_set_dirty(folio);
-	return false;
+	return !folio_test_set_dirty(folio);
 }
 EXPORT_SYMBOL(noop_dirty_folio);
 
-- 
2.39.0


