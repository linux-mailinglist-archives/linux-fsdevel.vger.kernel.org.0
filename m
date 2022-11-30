Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2863D5FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 13:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiK3MvW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 07:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiK3MvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:51:13 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2103.outbound.protection.outlook.com [40.107.215.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690570DDC;
        Wed, 30 Nov 2022 04:51:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhUtVMNvfRSlThOrl1MQ8IS0/Bz0bvs56IGz3kLCNVFF+ad/T0g/3D3RR1XoUT8f/4fiXfHTdEXh3qzwLNdLaz7XylfdwGfp/2zu9S85f4XtR0LVeEE6o6p5L+wMhBEsP/CJzNO0cqAB5Tla3w8t8OAlKM3CmLalq9EYKWov6kHBBibi5V4D6VrMpKWxaA1CM5KH2HUUqOhx1y33FoOTIzX5pT6ptm2FmPknnR0wL/XPrTrgSVZYfBIcoyqBNoG9pk+oxcv1q1EI/GlPMxoag97H9Mc98VVB1sRBgI6FsRnmQCSCNKUS1Gc2/WgsZuTx95SD356ggT7p+LNFFsDREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3H7kcpKY7sxZiSAy9KXPHf7WoEKzm5kRZNIk7zIyE4=;
 b=ksHMGPmAJsdoxQXTg+5G6liEVekSPg4iCjWaEZV1+pxI77tYHna6YNG4H5ETtbLEOxHhcY7bMchZzYTQkqHshw/Q1A1TeSEH+RS+KR6h1kHmqzMhBZBlAB14Msv7xXlXU1PBwL+ffQLG2bpihhKoSdr0Hm+JywVqVkEIYWoK49GuulYs5mv8dpHqp2Uhpc8zPnK+BVO49g7yerPNqr9IC73UL6CQfW8wlI8bwhnLxZccyARUQN5iIrKPA028IFChRb7VhDkF0DtAERq8ldnQdzyN9CcNcmtf35IIreJ7JU9te9x7DW5HTm7jeiK6djzTEZb16RdvP7qpAskb7BuE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3H7kcpKY7sxZiSAy9KXPHf7WoEKzm5kRZNIk7zIyE4=;
 b=nSvdbCQXXqERvzBia8hmecgF0VH9dptXb/HMGNUfPDcYcWSKsYnQiy/QI3YH4VDpq8CPk+7fsStg36ydJWooNKqcq2ZcUt2JxxuioxyCcBhyA2/ccjuFNUpP2iKwKDzLpWJwUQY5GV1LGX+N9O9nbACB4lZLvHfQbyWSSUcCflL06pgI1hJ+8WnqxDotYEJuHfPFQCWu/KbdLWfpsK8Z0BwQgbh0thWYcw/WGjGvYtWkDED8UB3YjzI/pluNr5kyrClzGF/IKG4+gMG7ehBFpqCV7LRDOs+VMjK2W7UKGIoCuTnNM04jooOF9tKEWlgxb90BpzhpO+9cWPGezt4y5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5514.apcprd06.prod.outlook.com (2603:1096:101:b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 12:51:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 12:51:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     willy@infradead.org
Cc:     chao@kernel.org, fengnanchang@gmail.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vishal.moola@gmail.com
Subject: Re: [PATCH]f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed, 30 Nov 2022 20:51:00 +0800
Message-Id: <20221130125100.80449-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y4ZaBd1r45waieQs@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0204.apcprd06.prod.outlook.com (2603:1096:4:1::36)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5514:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea88094-c0f4-43f1-f5e7-08dad2d18d65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yerj0npsAGpC3C5HQyUpQPkLNkzptwUEPVmMK2C7bXvbshJVRlU3nwEOTNJhItBakpjT2tf74b8aoIxFJv7EWEn0OgykCYSKORxflA1R3gPZl/4B5RmuKzSP/EToJuh7QWFgXqA14XOzWU43XZgQywOQasQMp1MFb7zC2Lhui06rUILYz/Gn4DTq4netuF0XN3VHd+5iN6KwkNMHAL3/Tgt0QLIx/hFIg4qfuDLAOAh35MTksMMc4susFnSfoFGW1A33dYBa30KNs+4ornpscXFNDgYC3T9Mi92kZ9VJ0cY5MrT3W4xJP3DlzWu2JOjxJMYLcIYDZay+OoeBozez7BYYTcAspAmT/++BL6RcbVrphzsjA5H6nc1ZWDuXCVft/8ZWk5rgTsXbXOgM8/TKx8/BXI/T540DfC6rGXuDFZLUPXHh5faYT+snj2Svt1QJMQaC7fZzL0EGzYZqB5KTFmnrIoQZnM1GEOzzqH472zz6Wp/B+JDBrG+iZ/L//v/kkeIb0jQOh/dQFnRxH9pDQYhR/hOgRPbtLjrL8vB4HXcz8704G5qNPBJDGKC/0Xm992cgr8uDjndu1vncoTBV32hjmvUYBZoA35jDY92P81a/cmeUds+las4Lz1ENKpg8+uvmCiQLjJG7zfAa3WHdR5R6BZP2jsLe51NcOyjXyVvwdsmikoEAu7RsinDIPrvv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(478600001)(6666004)(6486002)(6506007)(66476007)(2616005)(8676002)(36756003)(66556008)(4326008)(1076003)(52116002)(5660300002)(8936002)(26005)(6512007)(316002)(38350700002)(41300700001)(6916009)(186003)(4744005)(86362001)(2906002)(66946007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qj+JCBkZkkWaRcvazj2q0Fz6JPeLdA63d4OpKM3zMHOBXEFe0FIwWqD+mZyo?=
 =?us-ascii?Q?eU8Oevnone9LGdHbdxQefL4EEfgPUWDfVij9pRHp/2a9Xd69E2B4FCwCVk5r?=
 =?us-ascii?Q?7KlamatH4TjeWZ7eE1IYo7kkCjl3iTYAOFSu0bnY5cLMCZmHBBblj9I93Txi?=
 =?us-ascii?Q?A19CQfmehx58JjI5dZGVA65whyzESpnhlYvRZ5dYEd2J8nR7Nww6NvKa/5Lj?=
 =?us-ascii?Q?MFMsSJLPe5PYzp450459wi40f7fmtTJm+ZTfASGQ3mDKw1EHTlJaLm+0MQO8?=
 =?us-ascii?Q?BY8bryuH3GIvGw9V8CkZ8UAA5p7F6/ZlR+2bV3V4CopDG1cSyRb/8gHEN4fm?=
 =?us-ascii?Q?Mi6orC40u/p0R7WHAavmUNrCrgJrU4PqdJdb8rMeefi3/XJpdgclWQzAQ+N/?=
 =?us-ascii?Q?cbDddFmdsBMM5zaEWrgJx9/MrAPamG5XoBf8gXpcDyv8igJL86jdgj3Npni8?=
 =?us-ascii?Q?4wFxEB4Z6ixw55/IqpYTy/gx3/N/+LckXyr4KBzVqtR72pw5UHQwpByl8xK4?=
 =?us-ascii?Q?3LvXPKZNPArfLlKRT6PF3gAhICU14j/GyE+AUl5L34ZSRiqkEDsp+s8IY+wb?=
 =?us-ascii?Q?HZLI/H03Bccycf8sv2KyMFFgEslg+z7QmGHLW6fxywMnPhfgJ98Nc/Mr+CoU?=
 =?us-ascii?Q?RGITtAyvHHaXlM3VajX++IobHE61psflN0PJ2xhgBcsPo8hc5G5kIw0BdObC?=
 =?us-ascii?Q?rNWeopS301KczGTeOw42l4XkyuvaY+bjaykjOaokFAVbspQFQLRop4smwDw7?=
 =?us-ascii?Q?zpz6a9pTP0zMLKJxQKzgTxWNw1caoma9CwLtcp+QHxEpb9LoRy2FenBIbirZ?=
 =?us-ascii?Q?eFRnfmxFEg8q9Hydx7YPHyETdjqS/xO0CAmYLVqV4TANcufU8XYoNRoUn7wq?=
 =?us-ascii?Q?Oh/K7AnFcM2Cex+1fdoJJumPoE+F3GeQeL25qc+tKRZ2LTyT1s3HqR/smsQA?=
 =?us-ascii?Q?+FMh3QpMrWlJbmDE8KuoEpQEInqq9vTfzjbHwl58aIkXdEiZkLoW4AxXYWI4?=
 =?us-ascii?Q?r93CpzEe82hXbYtDAK+j01GD2vLDOED2RIC1E21KSJyTDFvyblJIfgrXTWXa?=
 =?us-ascii?Q?fg932yt5xT9SzNH8DHqjAYctVVip3tNR8RUy790WrASGica+pH1An99o8nvQ?=
 =?us-ascii?Q?xj5Ozw3Lj81n8F+1En00RzwvXb9QYcL4ujr5W9qozJP2AnYznKXZ4pYISz5e?=
 =?us-ascii?Q?sdVoJLjtSD4wX7KksRHjNo7WgadQbeyKcgWlXgzspoDCyBMG+NyyMaTNoT8d?=
 =?us-ascii?Q?uL5E8SQ7zrauhfWKXYOwv/Eo25841SKaozGOgdsvGvXNCvihevdI5tT7igHa?=
 =?us-ascii?Q?+3sYdIUOl/LG7J5GVruuicJHfKV9vDamxRs632k9c/BWkvjiPk5TeLF7jHML?=
 =?us-ascii?Q?QRfz8GmVHNN0Lg7Zi/8ImhS15HtohgdE9EZjdOYa4jmkALM3INe4M79Z3qR+?=
 =?us-ascii?Q?oJl0SMER1RPDNPO/kr9YklQbFLseMiN1gkjht+Tbgw1eFpgYAvMocd/OYB95?=
 =?us-ascii?Q?uTFdGqBbEIVVDKX4B0bu71RBYA9pq1OE7jhniFIiJiSga4f8RiZh7l8KQNxy?=
 =?us-ascii?Q?0ozKhpYhmAeCW+VEhxSUhnjmCopoN0JHZDqgzLGH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea88094-c0f4-43f1-f5e7-08dad2d18d65
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 12:51:09.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BB8bXitGeeQ6stPSWJWFrtdJSGfAnbSUtID3RQ3/tzaPxWyj1WUFApP1jdVl73iJanVB7GMYxbrZBr7diIDKaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

> Thanks for reviewing this.  I think the real solution to this is
> that f2fs should be using large folios.  That way, the page cache
> will keep track of dirtiness on a per-folio basis, and if your folios
> are at least as large as your cluster size, you won't need to do the
> f2fs_prepare_compress_overwrite() dance.  And you'll get at least fifteen
> dirty folios per call instead of fifteen dirty pages, so your costs will
> be much lower.
>
> Is anyone interested in doing the work to convert f2fs to support
> large folios?  I can help, or you can look at the work done for XFS,
> AFS and a few other filesystems.

Seems like an interesting job. Not sure if I can be of any help.
What needs to be done currently to support large folio?

Are there any roadmaps and reference documents.

Thx,
Yangtao
