Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3463D5EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 13:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiK3MsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 07:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiK3MsS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 07:48:18 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2112.outbound.protection.outlook.com [40.107.255.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615A82A413;
        Wed, 30 Nov 2022 04:48:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIUy4upHfxHwySKMhXu/uggaDwB505SZB3Exj/tUeSIBCs7NXqJIDJu+6uUSlfWtsdlc2AW2FK/k62TjMZOWN8HbRJKL5+0hWu7BucaThcglBrj5aSiN+27Mmm8U72KShfmr34SaSjIqI2HmTuoTgZF5YQrhb10c+cl5eJMEDXilWT7bM6WmvUuryUGMn85GWp6UIvm3HXLCBu+sEPNbgKRNTKOOOkwde0lgUh6kLHGwpjZhgI/sRc7KIDJvLf5D1ZIXU9aqZSi7rEJSuCLi4EJLUxMq1+ZkM0fjfxOLKPiLGT81b78RrNrt8I8MJRYERc3Yc3qK6eCpzhyiMAJqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3H7kcpKY7sxZiSAy9KXPHf7WoEKzm5kRZNIk7zIyE4=;
 b=I4VfxZ9dJk91VMtFqD7jRAJV1cwpeaeMKm6y3hpF38axq+W848VUqn5shj4ZCzQrHZ+Zow3KeGU/6zDHJ3gERuXW8EsWbknRXvnlmom6mx+Lhv4oI1y5Po3c96gP0lcRkray4WsGGe0nKmBqEPXdGihyJVZAX/UypVqs5ltqCCinTHwFii3g5lNOMEXl6qj75wQrXwY76EHoYVj6v6WzyXKiyfRSgqYXgr9dnYJ2je0Zo9eaVjt+V+brIvVGGwLn9V9+HoWw/s/4yzwNOLzQNEkQxyF67fCZu6fYhINneRJDruJcoq6LQh8Hq7EWJS+UbRC1+deRSCMpxyGIrYoPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3H7kcpKY7sxZiSAy9KXPHf7WoEKzm5kRZNIk7zIyE4=;
 b=GKd7w1x1xhVOBAjQ54Yh7G1wr8mJN8uM31vHdLIn+YekFChyDKePcNDgV5YtcJNVsO2wM9hOzA1TvPB+1zehDi+1rJFkFG5+4+cOCija2/nTPxyXSP4IrEqeD9rVGITIwTy34A67ya4LgbFgKwaKplbfPDFyXcbvGnr3P6KPyWCHRCQpSDmGUfUnyS4/dAx6m6DKGVzMbomhkqZzJdV4T5x2DnDHwT3Dzcs7gVFOvc/jNSs7sXDG5yN9ZdlmRUD9q2fpE3MphlF1xojt2r4DPB7yvVL3YgsomUh9tFQ4+M9MI3941hyz5TstfzHZvbmjOPGOAT2ROPWdxmGoMkb2vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5848.apcprd06.prod.outlook.com (2603:1096:400:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 12:48:14 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ef03:cbfb:f8ef:d88b%9]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 12:48:13 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     jaegeuk@kernel.org, chao@kernel.org, willy@infradead.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, fengnanchang@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        vishal.moola@gmail.com
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Date:   Wed, 30 Nov 2022 20:48:04 +0800
Message-Id: <20221130124804.79845-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <Y4ZaBd1r45waieQs@casper.infradead.org>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::10) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 74826231-e950-40c3-3f62-08dad2d124d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiRBBfq3Ledkkxvk1O2Ok3gpSwz1RcRM2whOPtF2gHVx0fnlynSmDrqMun0mxn6FBGMpo7CIxxquPMiYCO7O9VbBDJE85hB1KPHFBiNmn9mLrlVTU+c6a7GftnHnRaQtJAjfGuDDL4VQn48B4TN0mfTq4aTSFGS5wrsPMtIfBWZ+0A1KaEfViupT+Yzr1h68qRBzvuTqOw/O5UPUSI2oA8YuRssfzkByPAs6vCVSp81Qu1/hshz8NG2b/c0ELGqTBWNGFNHI4+cOQTrylN4clVzODvupcLNOs2VYipUEFIRwxd82i4mfZw7Oq4h8jDqD6xBelqls50uJQ6KUSK4uXkdy4NjUL1F/1xKDteKdKozZbDqdFkyeUqGrJ8nszQTMIfRkpwNelkqIQqXP/okW95NwW4bds38N5yNgN2S3l1vjQPntOZHc3EqDueCnAIzd8arCMIXQY2I1Y6LVv1qARXYtvZHZVgyUJkMp8CvZZPJW1jKjFzfJYJQBGvNAHwiGNdiyqDivA9vQ1sW9wg7qb05j7zONxDldq7xBrwdVGFrnw/fNC7MMwn8HE/IBd8nvvrocJoep/isza0Fl9g1m+5V47188OB587YPHQ2qo3Wl8mMDcrk6aBW8RqrURaNXMZ+h7PPPzmtqWkkYEeSR2M7eHzeIuuJBjSfzLWsEQrD4FclZ+XLqGm3IKnv4q3GB0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(1076003)(2906002)(66946007)(38100700002)(86362001)(38350700002)(4744005)(41300700001)(8936002)(5660300002)(26005)(52116002)(6506007)(6512007)(6666004)(186003)(4326008)(316002)(8676002)(66476007)(66556008)(6486002)(2616005)(478600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ENDJ7HFu1OW5rSWl4WzKOAWwN3YdUfmRXj3lR7B+BRvBZdhV3fKjgHizUVcp?=
 =?us-ascii?Q?zpeuW2+I0VbzYtLovJKLkCHWqYz6XLgM1FFIbHZBII9TTfabmjoDG48bmI+F?=
 =?us-ascii?Q?c+JMDIobxewE+0fPSvEB/vpOrtylnFd/mV2tiXNJF06lR17WKvizlrfXoJkQ?=
 =?us-ascii?Q?BMOBwA5cNVhDaELp1R/xea+71eJMyuCZquWpOgRij5bcjQVL6J9J41cjjVKz?=
 =?us-ascii?Q?X/3mJbHzATcNxX5adQBzjqzpmdCMamWR1LprWZckNLT5bK1mrZGlLurIqT/d?=
 =?us-ascii?Q?Joi7pLaGQ7hTfMZUY+xl2CsHEDErLF6RppRJZpiyVigXAQKorRtUVOaGv/sG?=
 =?us-ascii?Q?qJKUB5B96dHBob/DhDG4nrxRPhZsoGoJi2lv8cwUP+GYCjWeAsF/MfkzwxQZ?=
 =?us-ascii?Q?78TAX2jK53cJiZrh4VabHa5hXgpQzivpJfYcXdPhf7G3v7WryGH2fuHA7CgR?=
 =?us-ascii?Q?+caNXphVtFnAtPyZdgCM/+3E+TWI0H2nvyOFjR2Tr91G3lTGVBUEQ/yWSOel?=
 =?us-ascii?Q?oa52cuBGLtmb0ci6gKdHNjayhYQaZ/GkqVPXWbfNPP351+UQ9W9lRpOTc4AO?=
 =?us-ascii?Q?0lYViKdLp9+2nqUv0e33/bvKxVxbR331UMdvQ++TDV/nu6cDS6oj3GRTvE1U?=
 =?us-ascii?Q?BGmnxI7tYhKELrSG8rhKIliWpATI9NmGdbCeiccCvZFxvYjaqgdR3N5Dgdvh?=
 =?us-ascii?Q?cmRc518l9X+yHaPZDywN95gK3sj/RuFLrlfYXcdTSKSQTSbakmyfCeYspiwf?=
 =?us-ascii?Q?IOjlxRTKxmZE7nXegfYPOeO+lmjY5fGJQHwj/C6W2keGXR4LLoxcisN1rG8s?=
 =?us-ascii?Q?ktV86orpVmZF1eRGAax9Y6arzAtgY7oua5RvvWRvkHel3SjMIdcAPSq3pBiv?=
 =?us-ascii?Q?DBQSTy8TyxMGvj/J3jZlLlLR9pC9Yb6szXa45x7juTr4U4Ugu+XOpmKSbk5w?=
 =?us-ascii?Q?gJbZERAmy7v4L3jMt89F+wbXqIhmdyb+YgBdRDZe5fSrhS0pe6AvIjUoFJiI?=
 =?us-ascii?Q?SJ9PXxmJeYuzBrge+zML+y/9JdPB0JFzVDYQowTtwGCB7LBKh206JyUZzGOt?=
 =?us-ascii?Q?zRTvpsQGfaMylQbdKPpBTJ7ksd2wGsjwy4/3eIJmADa5eS/bKLKnWrxBdbmZ?=
 =?us-ascii?Q?bgpAjyPBOtuHKht/f6FIKPz6FE7GYEnpwVyCZOFCB//iKuvu/YNXEHO2k3qQ?=
 =?us-ascii?Q?8eP3eJQ3cBSi8U325vLtsB7oFRXjuBysvRgzVvxvSSrbwO/eJMvm3OxzipOq?=
 =?us-ascii?Q?pWXvc09crRcDCCNZETJ68n2r8B4qzXmNRyMD0HRX10dpiHdZaKRGpHDeUhEK?=
 =?us-ascii?Q?+nI8cLN62IyWrEKAZhfncn+GmkT5tjx6RUixwGoHpnS36P28jeWRhkVBWq70?=
 =?us-ascii?Q?3O21cys2QWEisdPhc3T2XcsCUOGVB8NbiC5Qq20H4cTNbwVfqWguJS9kUka1?=
 =?us-ascii?Q?Sn3Tr1uURIyGr9zas44RzpuHj71I+FCgTBUYCnQc8GT8qypJ7Mtm4ZySJuvl?=
 =?us-ascii?Q?T6PTUw3tjjoHPLpIuWVg4I/GWR5/Bb8eR2Hrd7+JwtBFlOx7NBKUhNiLBFd8?=
 =?us-ascii?Q?qByX4ddqdeKGvE9gx5XH9OVHGNb3zYROWAkYoUtw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74826231-e950-40c3-3f62-08dad2d124d6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 12:48:13.7190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmG6I/DG3N7S86f9d1dYa5MHhK8mXWyIGgu6EiAI8LnX0cR1tFX/nLRgCU+PfKwJT2tOhCh+YXUY8sT5fG7NIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5848
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
