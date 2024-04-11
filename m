Return-Path: <linux-fsdevel+bounces-16636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FEE8A050D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 02:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF88C28578A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02731118D;
	Thu, 11 Apr 2024 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F08WxOof"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2124.outbound.protection.outlook.com [40.107.223.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98450EAFA;
	Thu, 11 Apr 2024 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797089; cv=fail; b=Y++taTYI5Ri/kAcFIyDEtqZlZ7IN+WjazEfflaGfP3ZBub59YVbz+bo1LoOPh6G28I1RSeJfGDvgnBdIiPNvMrLUB2NrvszmTNtV++iCij+05yUHnNtGLeFQ3a9/fx34zK6g4aJ3ZgqbI6aPyCYqsZz/JnRv7fbV7dpdx1nc604=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797089; c=relaxed/simple;
	bh=2dU7goaTm+Gl+rwkreOQVCzkuSRdD6gq7hPyboMhw8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4fKp4Mm89hIXHJS7ufdzttZnOZIGmcMN6psa4aPW+WV8C9c3LyOqvLSw8DImPq/PigtRJ7zM8RoFZJNF7oLi4RDWvWpPiu4yNhUi82RAlVcmfd1O2AydphpdCNqcLmKlhh+trBdhQY8VTVcG1Yx2SghSOcM29ZJLphJTSeLRqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F08WxOof; arc=fail smtp.client-ip=40.107.223.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2FaAxTUe3sHjY8WnDecl/Q8SwIfRVJO/PW1OqZ4YYuVO1KlLFzUrOnyR35kYWP8j1q37MMLydz3RUQQ+SR07SaKPbeMp7q2JVk6wFJiv2ASwxLyHwWv0gEx++nuDfdp8HOD5yhqdtLfJ+XgyWfwEQp3peShvEe4fYtEjiaeFgBJZ/elgTXpLc7gy9tahzK44X72A8/T86CYcbHa3TdWe8rqThu2ix7zsrbamB75lRdJl1crf6bCXNqSuRUXPSwc/152uC+HsGAXxzMhqqK7IV4W26Z4LlfRaY7to1KIwWk9mCmNa52llGxcOAPuG32Tp+T/kxdAJQ/ZE9lZz8P0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yZDNSwFmOleRmlQ9ijesy2TEv/PIC4tH282yyLCCCs=;
 b=MMSDR+uOX5857gLmXHcZ+Q1BGonH8lEpfXIj/vmISygjY4kuhyntP7Ox4p2+b4O3/yX7xde2eAzEyR7A0MIFEFn2hMAe48bjRX7N7lsVbvoUHTD97wSFMk5XQu2RkNi4Iqn/W8rLhJRgxnMc5jMASqceh0VOIAtxCPQFaMMhFK/aN7MyzvaBtFFr1M8Ab8wz6rVNlDs4rZ9B1ghKoIT7plMgj/bNk2hwBJwopMlfbMVeHiNExKjkEK+YeQ2GWLrAYkzjOu1FY1EtX+8esLK6YElDgwUuD3uqr9SqPYyFVexOabyBQ5Ouh7+VDJgHYwa/vfue4i9bjB30R1nlBSyNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yZDNSwFmOleRmlQ9ijesy2TEv/PIC4tH282yyLCCCs=;
 b=F08WxOofz41eUBFVf8o8sSI6JW9BnpM2C4nn/a55KP1+0qiK3tmMbxZ/Oyl74C+PwOjFWnAyvRMMKPD0BpxL4zGMFoATQRc0IeeihnxCUagkEm8kVz1G43A9atOx9fx7aE8oFsu0P07rQYAtREDirMXV+Nhy/qsy0NG9atZ9M9PRzTtVa5BqjPIV0ON3L6GAMQq3mpyG1MWg+YRHNSJFkMebHr08vm0A12Y3JzKGnP7UW9plDYE/sikk6qyV1JR6cN5U1CW4/u1Ug2ylmSgR1yj3YiERaK66X7MEjwfgN/ys0gDNWCz07Z9pHrQ10IRXqdisrEoFnpwhNSLGZJivmg==
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 00:58:04 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::c5de:1187:4532:de80%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 00:58:04 +0000
From: Alistair Popple <apopple@nvidia.com>
To: linux-mm@kvack.org
Cc: david@fromorbit.com,
	dan.j.williams@intel.com,
	jhubbard@nvidia.com,
	rcampbell@nvidia.com,
	willy@infradead.org,
	jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	djwong@kernel.org,
	hch@lst.de,
	david@redhat.com,
	ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	jglisse@redhat.com,
	Alistair Popple <apopple@nvidia.com>
Subject: [RFC 05/10] fs/dax: Refactor wait for dax idle page
Date: Thu, 11 Apr 2024 10:57:26 +1000
Message-ID: <db13f495fc0addcff12b6b065b7a6b25f09c4be7.1712796818.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0131.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:209::12) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e0ET+aGVLefGTWYo30JnMXEE3u800qBxVAayq/C7mz8dmKGyv83S0FYL97C12/LBQVbTea7kLaIO5CBGbchodsVr3czTOmJUrSZyNPIGtIULJ56iBWeCyw2H9K78oauJ17TVB8gI0DK0lMTVzZoNw7CLOr18W6GtIG7OtXqT1ITBud+ufcUilegNiItWXkO1GPJ9TEgGq8OfEvYeKXbuuPP7fWKf3WLtc9rXHmDIUruwAwQ6aXnejsBBOHO3GWtIDKgn0DgmpyqxevoNrdzZDnoutEIs0diUSN0/BZ6h6yjkBYptMt9RZFnT5N+tC7P2qXvI6ltqsd1x2FxuKJr0QXzHp1xJtuhyBjYGN/aTZ6lOIlg+jpXxhaZgZFcYEMELQV0cSMl+5SZcE9PFhpNLOjfI8vmy5WmxA8xlXCmAqiXxDoNS/vyMZtKFuC2UDdGmdD/ifhwqYwnT3WIcGZl1n9+EQQ2joGkFtPxapEAHR1iC35xxVGjcb2wrONGpfJZRQzIe01JbvL/E9FeGiwaHE4GRFVZLKPwUBKG5j4cX4KsOUoqLs2iimgwbY/F0k0vBn8baR6c8HrJfrNw6WwkCAXy+FaFltG4Ue2KLq7WoX/2KcQVSa77SN4/DpbZ0L/+5D4wynQQEIgdfKQexmzf6HPXKEucmY14TmMeOoMCR83U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o7kg0CV6A59ijmy/CoOAddz7eDQhDfTEMHPkhbdQG/BdGJOTvLJv5qAJWXxQ?=
 =?us-ascii?Q?smoytrzn7i8hn/KiHoMsYDHdKprJzPzgF9MKmkCLsNRbdgQC7NPhbDaDtGKj?=
 =?us-ascii?Q?EtPHcsDLq60W5q7iD397uTuFz04F+gIBFAv4fe0xPveQmr+FGvTZH4EIKLrY?=
 =?us-ascii?Q?IFJypKeH7mJO5pASPpWH55nMIyYA+3QvoaM7sMGpiy6eRpqwZsXOqhMsKwww?=
 =?us-ascii?Q?jagv9Hjb/tMGp4G20GTeDFX+FWg+BvHPMl7JwZ4wbvgPL/sHgEjC1QT7ewe2?=
 =?us-ascii?Q?iKqdmQmyH2G3qBaUcu+SHuzUlO2nJtSvYTxlz+Jr/Fix/Mx+gVMhyRq6gE31?=
 =?us-ascii?Q?95lDio8BxFTzP9r9+ZwFqmkNcE/rHvLFaklIm2uplcIlj2li7yGaoksogQI9?=
 =?us-ascii?Q?XQthF5jsunix6cCUqkbLMot+eWqINM9hn/MHma7818clEVGZlpHdK7uaSMyl?=
 =?us-ascii?Q?/ehEhZ3mfbxWuhus3QMXhO6MZEQndIbQcNkIzL7EVhCqOMjGhlq7LQquDyPK?=
 =?us-ascii?Q?2LK643lISsTCMYjO41Iz+9TaJ0B1iq4n3skoD3m2s9yN+x9gVzVK/xP+QKbA?=
 =?us-ascii?Q?gFUF9i3W7rouQE5xJW3IAo/PLvjSrTpbH/yCzGWLDnc07eOZxR/zvl3Be8c5?=
 =?us-ascii?Q?wGKB98hhqbYbfkEfZYnoezjDsb+Dl2f7p4sdwGYaHH9vcQHd2RdCYnDqltaq?=
 =?us-ascii?Q?2jV7uxjQOnbxJC+jMD2eAPHTfsDqEzL36cyWbpIOE3s4wVwERr/Xu5iSDlZf?=
 =?us-ascii?Q?0oBjNk6MoXxrnPypBE225Tx64XD5L7nDOv/h1KEY+KL8YOJTNHtsVjDxtXAo?=
 =?us-ascii?Q?U+FpO/Kbm0Op6ptjN/FVXKN7p3dslYy4DKDtcFBEge2M0OnEU8yhgMVbC5gU?=
 =?us-ascii?Q?BCnBEf+UsHrsRy+44l9mYszuPoOcibrIQ8ea9zanfcBFwaZpAOrZXJC4Oy8O?=
 =?us-ascii?Q?8D1LeczMtLT7yvTNNCvfrKbYFWWaGUyFAz8bGy0Vsq5aSn+bG+8sTMFTCvRr?=
 =?us-ascii?Q?M5XdDePmxg8eY5uoyTOemb9sLjXEkOzg7rrURhumfnOswD2PM5PrXBRyI38Y?=
 =?us-ascii?Q?dmMJjNpIMqByhdCTVCic/vV76Q+lmKtlZxZdWC+KBk14+qJ1sItNt2eZuZoQ?=
 =?us-ascii?Q?FwvJTv3Yw/YxpPCiMHtpWvPUSm4D30YIGhUvcTd4+zO1pscBbTikafZTL2Cb?=
 =?us-ascii?Q?HLVgKDmsvUvic0YKOQulAo0Ue+Q4En5IEsNU27aNltcWChiS9Cz4rV77386N?=
 =?us-ascii?Q?pMXSDJpuBIC/Vu7wglqDZxORQ6HBWnAB/fN9Fr+IrA7XuUHGRTbH79EcNtut?=
 =?us-ascii?Q?s7h8X3l219us2M6jaANucS8uaaVnAg1NRCHPa742NJ0lKDdvvZiCm5SrGgBq?=
 =?us-ascii?Q?x5Ur8VOCvxxRSZP9rfMQwo454uoJ7UIhyYVntF913dOU6HQxLUFruYO5pDOl?=
 =?us-ascii?Q?oRrwWYEIxBf7yEliN1181Kwo04keJnhuTrQNj1t0SHeanMD/4xD32HbdyUnH?=
 =?us-ascii?Q?7vd/flDNsVkQMVLjDbxDUiOfvAUl+9teC2YNaXW9r/YiJIduJzVIU0wSfJLl?=
 =?us-ascii?Q?GgTDohJkYgvfYlSLgjgAdpbNCWTMwXraY03OcAcC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8845a362-aa4f-42d9-b2f1-08dc59c27159
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 00:58:04.1629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihpSG2u9CwbxReOsE/Nisc4VreTaEN7fccFZPhwjYo2DpMdmBiXDOn/nyYht2enfcHoHxToIvEwXuz8ny671tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

A FS DAX page is considered idle when its refcount drops to one. This
is currently open-coded in all file systems supporting FS DAX. Move
the idle detection to a common function to make future changes easier.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
---
 fs/ext4/inode.c     |  5 +----
 fs/fuse/dax.c       |  4 +---
 fs/xfs/xfs_file.c   |  4 +---
 include/linux/dax.h | 11 +++++++++++
 4 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4ce35f1..e9cef7d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3868,10 +3868,7 @@ int ext4_break_layouts(struct inode *inode)
 		if (!page)
 			return 0;
 
-		error = ___wait_var_event(&page->_refcount,
-				atomic_read(&page->_refcount) == 1,
-				TASK_INTERRUPTIBLE, 0, 0,
-				ext4_wait_dax_page(inode));
+		error = dax_wait_page_idle(page, ext4_wait_dax_page, inode);
 	} while (error == 0);
 
 	return error;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 23904a6..8a62483 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -676,9 +676,7 @@ static int __fuse_dax_break_layouts(struct inode *inode, bool *retry,
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, fuse_wait_dax_page(inode));
+	return dax_wait_page_idle(page, fuse_wait_dax_page, inode);
 }
 
 /* dmap_end == 0 leads to unmapping of whole file */
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2037002..099cd70 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -849,9 +849,7 @@ xfs_break_dax_layouts(
 		return 0;
 
 	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
+	return dax_wait_page_idle(page, xfs_wait_dax_page, inode);
 }
 
 int
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 22cd990..bced4d4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -212,6 +212,17 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops);
 
+static inline int dax_wait_page_idle(struct page *page,
+				void (cb)(struct inode *),
+				struct inode *inode)
+{
+	int ret;
+
+	ret = ___wait_var_event(page, page_ref_count(page) == 1,
+				TASK_INTERRUPTIBLE, 0, 0, cb(inode));
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
 void dax_read_unlock(int id);
-- 
git-series 0.9.1

