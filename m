Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A656C523D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 18:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCVRTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCVRTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:19:40 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAF6703A;
        Wed, 22 Mar 2023 10:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StLk3IfSRpge1dCIU42uHu2HPg48tvWt7pPpD0CSY4renFf85kTKo6QvMbZjZ1Vm2LYCmKuQEPZX2JCsd2Oz7uk0p2BT7coQL8mFqvEHZfC8O5NDXaBzxlvmXuE4r/wZ+zM+5+F7PrF47OoPRABnm/kuB+o235evTaGurvqwkv+VoQRD79L60Xbee7OKxuwSRiTustjr89y8SsYZqaG3ufVulieHatkNPTFW6zPezh0crGbVO+Az2MFkw/z+5jYwJRQDTIiBpyDiw/Pf2oaN3yNmO4wHOMC5GRcHTyCwtCt+xiMCM/EkrqHwh/oRR5CFh1/Ak0d2uRS34W5gdmlqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRurLv1Ed3kltUm4si+KO32XsTsoEFyabeSF7dJIWPc=;
 b=XjuD05cF4r0lAGqJcNuwgkAYXT/v7VCz6WdAjXlxUL6+HYqR3bynNB6QH8Ey9RUyzYv/1pUaWBz824FchpuN17h8cVB15FwgFOEDI0g3Hljl0F7RMSQVdGFrNtxbkF0EUnPeCDkR7f0QO9k4qhw1/MrA3rtr7xeM/sBM9gPxBZi4r4DiBpEMKdHrQ74ycGgAmGXuD76ywAjhImR1VGGCcnwxP3If/4becbgo8cWWKPh2xRi98XG0VwDp9vFjtTRIdr9+GbaabwOzSaI9LDee9ILXMXWmZeCLlK07TjAtXQFKuxxFUzm72BYurojmRCBcTdLUEF7ttce3qLYN6MUJNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRurLv1Ed3kltUm4si+KO32XsTsoEFyabeSF7dJIWPc=;
 b=XLwFGV9Um3Rg9yCKSv/3lGYYOfjPtRRtRQdYFQuYwBkiE2l3E4lrh+HXOhy8jMT22SaedAz6aSJqJTMFVXTTxRWtNvEQo5puHYQbj7UqGtYnhMQAFPOoBk3eOCxn0/rTEuqfYED8eM4sIMyQzgHJyT9yrbaBi1BvvrOAaXOscSPbsFFrXu7bGls8HZmbLbTXXd6fxTRFeZuoT1gXDQDlJUhqhHUU1RRxx1zA3a2fZcFEMeOdyterd+qYQrhboTTtuvHzMcOiqna5xR9dSB8q6PsfddrzuyQdZ6B9N2w4w6X/kh5/56sfhowPLC1GMYoWS9lJYQqP9oSOgY/65+c17g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB5654.apcprd06.prod.outlook.com (2603:1096:820:b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 17:19:18 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 17:19:18 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     gregkh@linuxfoundation.org
Cc:     frank.li@vivo.com, linux-kernel@vger.kernel.org, code@tyhicks.com,
        ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mark ecryptfs as orphan state
Date:   Thu, 23 Mar 2023 01:19:10 +0800
Message-Id: <20230322171910.60755-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZBlQT2Os/hB2Rxqh@kroah.com>
References: <ZBlQT2Os/hB2Rxqh@kroah.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0142.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 29eea57e-1584-45f8-b532-08db2af9915f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSVjcCeUlICcqL0mQ7t1gkxnPWGAYGw89lQec4UrxvLULLki2LbgWlHPArPEMgMefvLgCYJiGfWE3e402WLCkWBT9hZredPDuNd78bvGglUXifVDWc0TP607chdw7mblUEa9hX7/Rc8RVyzKDxxoDrVW0nD14KPiFR5xqh6XrH5Fc3QDwy3lLoKkpXtk8gU5dfIsS8CB524QmtFiTnKdbYdscWiwvtQnZy5CwQbwXDUHNNWwFVOaMtTSP/98+HcrC29aByE6QiqXhMdNaozRju3pwyWPeijpLIvQqwK8n4QEe136E1UI9VFzgav65wHl4pHKwwKUSRRTmpIEszW7G4OF3EceKOGaJ1mS9+zOmIuIZlDHFJehH4MKJzD4tbKaL/VR6uG5/vZo8AP1Kw21U0neJKiUkAagIxQG1g11CyUNf2g5Yl6ZPIeZJc1bN6z3Txqr9j8czWFTpO5Mi1kQ1KwWs5f7tdCYFNWlSsPWmlaT77JvprldcBynHe86j5XaecAwUEJ0ObQW7fvo+qwnG3KXw421mkzZqrbCBMTO7LHRGlrCMTjo43sYTWa4IPfKa7tU/X4TRCN9M9yacUOmF5dTQtN7Bq1Ul+6cCE7Y4vMuA09PNJ+6aE99BYQl3XnSUJSrvEYoKLBOit5+nc27R6y2LWoZyh+bBFwq/IXHFojPwAGyEfuzcuHpcc4gbIo9V7eznghcM7Oho4byGcjswA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199018)(2616005)(6506007)(6666004)(6486002)(6512007)(1076003)(66556008)(478600001)(316002)(4326008)(26005)(186003)(8676002)(52116002)(66946007)(6916009)(2906002)(8936002)(41300700001)(5660300002)(66476007)(38350700002)(38100700002)(86362001)(36756003)(558084003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fm3xyNyRoQb7WrBncVRaWkmbsdFrWrVkJfEwJL5QGk7bkrOEaqaW/kTTclxx?=
 =?us-ascii?Q?yzDIyr8UzFa0+PMbgXoGbZIPc9a9JJUb+1Lu8E3f6L0VNNuizLrLQrbfxY+P?=
 =?us-ascii?Q?WISW1luavcDfdHj80wN3TCtyDFleqy5u+HyYFX2iICwSPnCyclS/JtzArI3s?=
 =?us-ascii?Q?D6BItOdM2vH5ccrjc8gd3R9SX/xPHp4MXzuf6EojuRG3vRKuYFwc+WFhVJeL?=
 =?us-ascii?Q?kytNPFHyhkjUmiyFuvm5U6Tj2/inVE4kcHbCgK3qx0D3Pc31TrI9MxPjHuAQ?=
 =?us-ascii?Q?ZUD3yf4YmHdr1cVqtxeLaJCfMHry9alt9zw4aIL5hO+cfeFc03oFjov9lL3L?=
 =?us-ascii?Q?2oWl5rC3Xl9xNg+b3xN49R/Ed26JxgLRBnyc3xB1QhTXcaEadb8miwhD35w/?=
 =?us-ascii?Q?0erlX+Q77Tj+MUKPqLy1MNL8JEKhPr0aTr+S9XIDEQ0TtinYPJ4cUuiq7695?=
 =?us-ascii?Q?STcqmofcmDzR0CzqywwnTSvHT+bMDY9EYrMsECKd7cupwI3/DhfcXdPQWLmw?=
 =?us-ascii?Q?ZrSoSzezVYeoLO472WfnXW2u2JPhYqCQj3SL6D9sZrjR39s/Jq/kVoOkHtHm?=
 =?us-ascii?Q?UwhTJ0bPWfXhdeprhSI8UBtrhNT9yyy4YrxIBIkbMJsrXWXckuexZ+jBZjil?=
 =?us-ascii?Q?WGpyvHaRZ/mOC8M3JNbblfrVpbIIT9mh3qCrqFGV67UZPIzmoX3Be5za0deN?=
 =?us-ascii?Q?t7032WZiKsOcp74dp2Ob+szqlM9pjuMfYA+yYOMKrMQ3sB9P/FSVk55iC24A?=
 =?us-ascii?Q?ICShsmsMBFLrtUAfbbSkLh1KRmG1YNZmRHixUoDglMRPGnyBSy2ZLTndpMan?=
 =?us-ascii?Q?UQtw4QfxjV0QTcdh/2TJtcxrnSxOi8xdD+yYmORw0/lxdgO9IGiKvCs6p+H9?=
 =?us-ascii?Q?w6Wdh89ReR9NuC4CKh8FEnKPf/f5Ll2aCznpdmDOdhSzvfKf4spDW4TjhOGr?=
 =?us-ascii?Q?Ue8uecJmYjU8PTSOOxP7IIRxoyjEVnmPcmkeq1Sxp9jvhya2bcJ2gKpM84/l?=
 =?us-ascii?Q?ZuEvT2xudOj1VLWVJfflMeIvU1LjXRUbRRG/nt2XFosBe5PiKhwPypCgEUOX?=
 =?us-ascii?Q?mQSKyjOdBlgvDhykYi4vbTuamNFQ9/5Ps9m87fZhkafx7t8HZkGNejEGs5LY?=
 =?us-ascii?Q?Fd6Rz2rQ0EilwO62FZeVpFZXln0XxmSieO/v3mzo/tS2rp7s4pyWE1eU/Jzm?=
 =?us-ascii?Q?DHSVGgcbiC99lZZ1X+Fye0OP6gwRwB/5lojL4FZWFox45YgtARmvwISrIafu?=
 =?us-ascii?Q?12ugaGCJjRDId4SpSn6tNyx2R2RFa1L+dFYtkom/BlelCVTG0bhUQsnGI7DC?=
 =?us-ascii?Q?HQ5hycbSF7fRSJGi8OaF4FiGSEhz5TvMScvD74DjfH/fzKs5a0az0XkH38fH?=
 =?us-ascii?Q?3khtPnwdf/z+2CqqqGzi5drzZC0AuVxgQIPu5e2ljTejJhCT/puwfRB5dNZk?=
 =?us-ascii?Q?WHjv2pg0Hzzkv29sTv1jwQRL5PixWcgED9vY+R80icYxrmN3gY0r/1+Q1aFZ?=
 =?us-ascii?Q?TXEbESnGHup4re7N6/AuVvlE/iW0PC4AWvCfMqr2QQnt4h4RLYmUQ5r+kDMP?=
 =?us-ascii?Q?GozFklHPe9YC9GmqM9vSOg3TMJeHe36BD87mj1aB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29eea57e-1584-45f8-b532-08db2af9915f
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 17:19:18.0373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Xaf3Gzsm1ZJyq0SsRqn3wCeNZtoGhd5WvNjWTvlomv+H1VrkI2MRp8zBdvMFK11194VjFYmbm9VnIx99wjrNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5654
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+cc code@tyhicks.com, ecryptfs@vger.kernel.org, linux-fsdevel@vger.kernel.org

Thx,
Yangtao
