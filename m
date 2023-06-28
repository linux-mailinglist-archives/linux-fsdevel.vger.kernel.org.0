Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F2740D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjF1Jrn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 05:47:43 -0400
Received: from mail-sgaapc01on2101.outbound.protection.outlook.com ([40.107.215.101]:60052
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236017AbjF1JhL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:37:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdDfkqR+/PF+cwiAUM/5BUMutgNMslzfb0oovB6FRwDMx9JwauVDhTdbkN93M2Rp3D3m1Na7IcW1dG1KsrfDt3nOBu2Ay351l0KktLnEWyz+c7BD8zT1swCcAaSZKyZ+zuBUsT1WfjbqzLHwmHaZlssD6BgtBOhbC5VEXQNuvcomseP6GtMTXOlU9xo24E7UroiwKWD8H5nYH2FuiaeEFXt1r2o7qlkmJc23X6nsSepXoM2Lo6azyu514YWcNXM6YxVwSPO/nVq6bWcXunZI2oIirVl+t/Gjrc5vt1c7RPxFYz+UH/Lwsqqd5/vqqySKe1C3ZoRWXy0tk2V2uohgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzEDgAEQVi5wCWL3HPqAmdNfo2Ud7DOfhWpTaRZRXCE=;
 b=M0J1iDfdFVjxFlwUOasiRY3uwwNUiq+MaB9pvNurN9GiMNSrQnPnqFr5e/ItbBadHAz3RSzkjw/btn0tYeSqMbNobI8beC75lJ0DNN2u+0O12fM+0omCQtEcg+ayRcE+4Ct4iR30s6TuhjlDW2aaS078yzg8AoV7wdy1Wb4N85VaN1jUYFSnHt5Ng3eEILAk3fBj5U3JuQu5qZxl+LgK8ii8pK1NFi6cw8PDx7aOqfsa3dgbE2UhyShAVmE1OST0t07gDuOAr46bojkz31RWHab803Lfy+wnbNL7/Hi0mPr55yOYLUaF/28Pr45XmvmDEBGk0VZJ0EAGnrNkvUtubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzEDgAEQVi5wCWL3HPqAmdNfo2Ud7DOfhWpTaRZRXCE=;
 b=PQaKbU9ggfeZOuu/ajFDfGC0xZTVyELlwf8KdR61iEbRPgzDfy/y+C78MtlTX108H47M4JB6TTLGRWsIc75BXJJyeBuEHHcrEfM2vElQhgJDw0Y2EbxvUAzNGNuOjCsZDiGyDSq7MlQELF7TaEaYGQ4mFgGEN2rnLB7AK+sxIdEKdhx8iDGikXpKyLqSuHn75d6S4pONpqojksLPpZE2q/q4gvuYMwSQhC8PbgE5Cl4Qt8GjSo1/lh2JHDbSvjqpDz1cVUHkaglEILE/bKD2hnWcRQwrHQjzGuoOZZXvIP6FCFpZbcR6/zWZU2Bwn/KcOd/pN018fAcvTC/9qkrG6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6144.apcprd06.prod.outlook.com (2603:1096:400:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 09:35:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 09:35:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 5/7] iomap: Convert to bdev_logical_block_mask()
Date:   Wed, 28 Jun 2023 17:34:58 +0800
Message-Id: <20230628093500.68779-5-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230628093500.68779-1-frank.li@vivo.com>
References: <20230628093500.68779-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: 72552399-3a38-49c0-4063-08db77bb037b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x4mB9eMHQh1osKUvbomwi/OQODyyX/HTXoSlBrVToMj8uK9zfYxmZs2JYG6RUVZccXspJpm9GkYnlM+AYVOj+lGl6zumow4ucC50t60QiQmJ2p2NigNYB4cG/eRTHINKRtzMfCKIdRnLxlyxDZR0OC5ulmw5vOiFz+lDr3r52zndpBWybYMCDud4SGv496ZbRTsTDgseVq2iMHLOc5kjMxRGPdub0lvCioTMlow1a3IEWKy6cK293XyfkiB3/U2ieEyVsmfUrLUkkGPlhm8n7akiBwQo/lyR+ZehUGH2PnnruXMkzqWDFvdnh9CjQkERGXy2OKBw82gVxqeu8hS27uHSYUFO0nupXjgGd8Kqg9bz++tn4le97uVe/23XsNiOMJ2K+v5Q5sIU8jDlAQRst1emaAmA9AQdOt0IuOKf1HWu0EBZ74YSCV8B/tm/yslMuo2U5cW9FBqO/Sb1KCLih8WtQ/vS+FCV96FKtEK1aiF28sixrjFYotuHL/qCuCEsf+Jzhm0ztorX/t7aZT9E0M2CV2P4JryGBW6HREuvtpaQAbO9wuiSDTKqf0R4TpY6puTJ9O7WjouupEwvgT2MCWVuGqT2EUYzOoG2LSmd1SIRO+3hIswrwXNk2rJyEyDdZ5I2kNLKUViW8v3wbtVtag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39850400004)(376002)(366004)(136003)(451199021)(1076003)(6506007)(7416002)(5660300002)(66556008)(316002)(66946007)(36756003)(478600001)(4326008)(66476007)(8676002)(8936002)(86362001)(4744005)(2906002)(6512007)(26005)(41300700001)(6666004)(6486002)(52116002)(186003)(107886003)(38350700002)(38100700002)(921005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cak2CMvly5wIUHeSoMUiuA03PAjSv/FsSOsWwYE1RvBwPecqtRphG3mPXUxf?=
 =?us-ascii?Q?/niRpghuoxuSFPJGvzp81A+WEiQ5ru4/2s929KeEhc7E+qpMuvZT9o+XTsF8?=
 =?us-ascii?Q?0HquA3V5WgTcbb8ZsxVrbo4LhOT1FqjWhgczrWR4SG1S4ev1mvDT9hkR3id+?=
 =?us-ascii?Q?v+/HZYoRTS9Sv/jt2UVme0Ag9yhU04bHmAffc0z64ZVkvLuUtvCRjZp2QyJP?=
 =?us-ascii?Q?ikpLXh99NBhug1x4kuU3Xg6Qko58no7hBcwdbJzl/SCp3l2nAjLU/gbK3tIl?=
 =?us-ascii?Q?Xh498rzxriIaFUG3dtRxBmgraBK6oCDpy+WXypnJG9XcGPQzcEnLE82gAAdd?=
 =?us-ascii?Q?WVL1HqOpg3weITmqyhIi4bCEdoWSEdKbBgolfK44SCIMTa5dmDQruCsMBU60?=
 =?us-ascii?Q?eI85jiCuE9iGpwA9Nn9X65Lk72aP1BLofxwpFWUIA1iWUIt31h5+xikoB+eu?=
 =?us-ascii?Q?u2EqeuRaddWdhrLCpmb4aA5dFpNrZ/9nTsoeBiaqD8b91L0Ub/Q3oq8m7B/M?=
 =?us-ascii?Q?0S2P8BxkR3tGPAzNsZCEwpWkd4KZ3LeMJqDk8VniCZPJu8q8NwvtitSp0VLZ?=
 =?us-ascii?Q?Qim3wjsePxtu2DfScN3tD2ySunBqefjdojh1z2+e8JluC1tlQpjobVCSNrtX?=
 =?us-ascii?Q?wxNPRawfeMgUlJIDBrEkKt16Teaj5Y5JGH/ihTTQX+IhEbbRfbyoQiKBLs08?=
 =?us-ascii?Q?N+Vdwaw7cmH837uf1ETfOTtWvFSFLFgCx7b/kqJieRMQeMZw9n/yx/Xs71KB?=
 =?us-ascii?Q?eKCxrL5Gw0hf5JqZwvZRKDIAD+7IAAEDxcRhpnEFkb93p6sQTvzb9kitp/6b?=
 =?us-ascii?Q?EwHs/Nxz4WpqjAYjyBgk6aL4K1d1OF4QYJC1WU8uY/kqdT0pIxA3KCQDSKnk?=
 =?us-ascii?Q?KcQ1OLAYhzjz8QqdP+UCCaIKG/vnb+FPJtWFGJcFN+Ime4wJtpWg3ETPq93s?=
 =?us-ascii?Q?9C87/oLKe0HG7iNP3iSuEqETIznzpYcD+uZE40Kqx/ACOJmzt2fu44CO3o53?=
 =?us-ascii?Q?Lch4KkoQDjgJvJFMPUBGfxdp1k/vo8Ap0yjFRF8yUO77RHvGUdETr9QtmdrX?=
 =?us-ascii?Q?wWy5kPx+GFKJGyL72cwzvgXhhEllzMeJkDM1PpcCO5PL9jLRDIDZ2KNOqUdq?=
 =?us-ascii?Q?/dMMjv5HxJkXq3DLTMBNuZjPPoKXoVYIkYHuckKV6FCOHKa5Kt57vWEXJQ47?=
 =?us-ascii?Q?PHS7FoLJghqVpRMn7BtOfTB787GJiRViizwU/WEnN6Gv4sU0NHuDVq1gvCE4?=
 =?us-ascii?Q?z9S/IxZYNo/E9Lsi8JNAhbAibxdkVI1EPapkLpXeurHQzpDzXEt5iUr4Isyd?=
 =?us-ascii?Q?kxjTKwxmiD/48MOBZk672orv2sGwznqNP27cc2/QiuzTbMyQVbmgqwCOBv1W?=
 =?us-ascii?Q?gOTm4K3lId3QRrOuR+VnPk7XNFnaiKfDrepQuw5yybnxxsbrDtwuOtVmxw1e?=
 =?us-ascii?Q?xgD3MxkI3X5+4lIJjb78iUmBYvBTGX29bT7bJMuBkv7oCiuEJdNHlBr/Ujq9?=
 =?us-ascii?Q?pExO6rAHb7KZ6RhokqBFevYFNcHyv6g6ZCLw4gK4fgEZauG86mtXHxwRLpFk?=
 =?us-ascii?Q?2xPdRWs9q7P+AsxXYgZmh5k84hA0j0rzFgoKXzj7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72552399-3a38-49c0-4063-08db77bb037b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 09:35:30.6164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9DFoRu9kk9yAVbGXZLkcZ1NwU/3GOdxkJlPf6DKckHcu6m7zFenNVGP3TnK9oIfAqyEjbq77dP5vA3O3wH1PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6144
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use bdev_logical_block_mask() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index ea3b868c8355..8d4a06bc14b3 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -238,7 +238,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
+	if ((pos | length) & bdev_logical_block_mask(iomap->bdev) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
 		return -EINVAL;
 
-- 
2.39.0

