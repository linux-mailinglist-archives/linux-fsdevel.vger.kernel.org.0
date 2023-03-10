Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E36B350E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 04:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCJDwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 22:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCJDv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 22:51:56 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2118.outbound.protection.outlook.com [40.107.255.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE88102B6E;
        Thu,  9 Mar 2023 19:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLxWzBWi4M0REgLTFT74eP2kAjAlneNaUiDPySBHgzWaZuN+XP7NA1wo5uMjioT8secySzgJYMS1+f/+ORfDakcOXgqrONThdmfQb0BzEfApBFEDCRwCi+3QGxpUx8pGq/lKJNi6cyQ8oIAKlTMo/FKurZrdyhUeDg9VNvTLVdH4H6QSm4iDsSlVpyCFDAVCfTgwLMGoTjZ7WLAHlfnD7ORnj5UT1ZtvLbrwmNCYGMd+yXszmTypxWCdhMevpyMmQEO3plNypdEu7ujO+NvIogVaiFsXc5gXKK9BosOW5JEec9HW6HAJBYkCQrOOj37igUxwRWPEEpzbbo2E/JPsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNaAin5rvfyFZdChOCBe7oxzl6tLuiG+uUVnz8hQOso=;
 b=j+ol55t/WoRpFiJyQAMYp7CVVCDGIvCxljcu/sriDqJWUsBoaYskfwGHEv9EDUbCj8V+UBoiwt//0ySwQNMhNb1NURj3OmN1ZrzXgEqBGVsCifk0jpjm6k9uCc0KsaDcIHqxkPIbnhqQK4nm17ivNg7u8foU+ahjMd8sf6iEeaFXnMp9E76kOK4HeSpWJxSsgJnSoQTfRecHG+rJIKnsZO17VdrVI+mxTFnRFaXs14WtuumKYxDp3WG+X3WJRMy052sT12dUYnEm0l8IhupiSoXGTZfRXcZWpz9a94nqI4I2AJumAA+3WH2dFS55Twv3f+tEeJ7LaxdZTocRBcnRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNaAin5rvfyFZdChOCBe7oxzl6tLuiG+uUVnz8hQOso=;
 b=hdItbUhXWN+9LtXlhcUaB2SIL11opTT0S4loPrs2xpbL4a9Er3oVzXbXQVfWqXOVPdGd4Gsz3y2enowKlxU40fkrbnA2WWMEvZWTYOsHwUj2MKNl7bU4gagqbOl1Rla04rto6q+/FZhUtVbwHPpfWE0C8sKKLO7C85lRE8WGPtEr1fH1M2HnSbf6tMmmzruJTJ4HH/d9vxya+zZ6lAHt9/fToH1kk+lT5lJ/7m9eVRmYGbP3QwBP1kMWO9RHlcbW9xiLwF5O2+f/fzKb42OU/7w4XUULo20Sy5KuiV6NwyfOquhko16ajdGcrQng8tXakZqit65Q4IlZuSWWMtj66A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR0601MB4212.apcprd06.prod.outlook.com (2603:1096:820:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 03:51:30 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 03:51:30 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org
Subject: Re: erofs: convert to use i_blockmask()
Date:   Fri, 10 Mar 2023 11:51:21 +0800
Message-Id: <20230310035121.56591-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310031547.GD3390869@ZenIV>
References: <20230310031547.GD3390869@ZenIV>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR0601MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: d3135a3c-96d4-47cc-e172-08db211abbaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yg8BVGjUFyhqms0sYq1Gh3qCmNMQSqDIwCypoMkqptYOpLlqfAMc0pD6yfYtzN9W8eCsSh1Y9sTHhlLXkP2vfGzcBGruHHQQMM4wS4APwkJd7qcGKtXgBwR5RsYT3ZQbvt66FEk6PF7+5RiL9VbjMQApbQg1PhPWzM4FC5ZfSX4w6KjUDZcEZ6cSZ4GLf7bKW/zMwZOG4mfD2lbqx/b7J3lT0o0wsiS0dHFXSzklFfALCbigFIDSLAvGjSButoKTAZMJwyijqFm8caAeHiIyzE5/YxehnEzKgLWcNiG8ejDIvRyFQ3E/5jpNRC0p9Q6KYrw471Qj/HR9PJAVtQ+BohQXe4Md7oc5EXPdirWLVpNJF7lSI+nSvJWB2oiq7bzNp8OcHHeVJnmlbsl2tby0um/BBtwnTAGM8XX3sCsD5M/UST0ACr/jgY9ugsU9lDCJxJF496KOLXXZtemMf9wm54T209AI5+Knr9mH4uh4OBkOZIq1wzrFwWkua/8tcLEOFstRugGPzQjDT69DJy9WAtDWm4udbnHYFYx+Y6s9ypZU175BmSaPAHtJT81A28xyKCDj+LE+RbkLvL6X94og6ggL6HXWodxfT41KQvKovOpw4OYiGbh33t+xAaRtVuYm97Q52/tsK+sm8gumkpmCqBJCZfHuQFE5Jl2YIwHhLttaBJRc7/C0w+lTb+BIsifNUinyx/svzFZBNkWNURDpGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199018)(7416002)(36756003)(5660300002)(83380400001)(966005)(186003)(6666004)(26005)(52116002)(6486002)(1076003)(6512007)(2616005)(6506007)(921005)(86362001)(478600001)(316002)(4326008)(8676002)(66946007)(8936002)(66556008)(41300700001)(66476007)(38350700002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0WADcUw11cEVwQB7tlEvN01FwCe8pz+KkR1nG5rG39gepYUDdPMgH6337Nqi?=
 =?us-ascii?Q?ShySlqfWOPjzOnU+OzxKBugEl/tGwUNqIaTPqujBXPA4f4I2qPh99WddX26D?=
 =?us-ascii?Q?iUD2f2/N9irt6RUmDBw7HEy/3YOmYy8qFCPGu1FVGzazMdFmMmDRxPYibk+s?=
 =?us-ascii?Q?D6Qo9fll10rHI8bvQ8nh80SYpE99I1doW7LuaEW8WVIyPViCAF3zu5vFeq7m?=
 =?us-ascii?Q?ypecLQKX4BHx3tSTfeTRnV6c3MC0u8Dyii2+FubC7UWcAub36E+dqhz1p+Eo?=
 =?us-ascii?Q?n1Ag3FO4AbH30c/Bqbg+xLlr7hJOw2CuWKK0++T+7Vy5hxrlR1zeB2t6X4LI?=
 =?us-ascii?Q?DLjoPW5n9X12o4OzYjNjmBiXU/kJMNOkNo5NWPgoRdaFC/UWFgUvacpX412E?=
 =?us-ascii?Q?ERHjpS+L2veaTGxnioK4/TtDQ4AAXWZPIYIrvgDRBdqUNwVpt39yp2EaQSvC?=
 =?us-ascii?Q?Xel6P1SFocKvmDDlF1ZWt1bogXm1bEHx2diytGg49kW/SLTNzSAGjct9pHS7?=
 =?us-ascii?Q?wZn3L3vJesvYgrjYueYtBgI7jsO2JFLQgIffKAEP/tfJUElUj3t4i5jUATvc?=
 =?us-ascii?Q?vKVb5bEWVx8jWXzCn+zIPpZRqxvcRll7iBsEaL+aFtzvP/IcjFLcIyiz6tjU?=
 =?us-ascii?Q?wgekBmc6urFZCUi6+b+u86zxaFLSKBovUJQDdbGi0WaDMr/k9kiKyRQ5bG2Z?=
 =?us-ascii?Q?exs6NtrTtqfY6nTN+/3Vevhxt8HvpG1HtIA7Y3Gpz+xRUvOvgeQIqjbaaR1S?=
 =?us-ascii?Q?77pTiIHBA3lzxWtOoOJRkLwcosPNEdacgFmOKLNRdBOU3sQcD2qx68V3kFCA?=
 =?us-ascii?Q?5ceePphUmbDLdMaTDxIBe0yvqOezHJSl65euNCn8saIhUttSom/88r6AXsdj?=
 =?us-ascii?Q?g5GKVRMApUxETrEKg9IZVFUaH8t8Rb/NrrkhAwWuNO6/Pcufa3NPWd2x/Ae5?=
 =?us-ascii?Q?VGQyBGpqBLG6/e0zMICXNDz/NptPOdG9BPwsvHVKbwj71/DjVVTN1WLn0wxp?=
 =?us-ascii?Q?hGTywryF+Sz1jtZZuaVj655dT+S4hHMl8nbOBP5pg8/nJrYWxt0GBtLx3nb0?=
 =?us-ascii?Q?mqMNrpmsjUTBW/cs0L07gL2L+5Lp+Ga5pXm8WxpTXND4X1rwBiQ6pPu2cfaV?=
 =?us-ascii?Q?+GtlHYxEa8CLcbugtXtZkoyjWa1AVHjg05QRgARgy98CFRBkKrCagK+wo+s9?=
 =?us-ascii?Q?5sAcOnVtE0VHXwcvrSskr5XWQ6gjlUFMsUc9zPczqSghcPl3Zqa4Lqhy73v1?=
 =?us-ascii?Q?lfO4K3WbBb0iMWy+EKvHCXNCTvDfuXfXiUp0FxslVW3WemmxVuTEDPGjgTfu?=
 =?us-ascii?Q?GIpRlHGtlWyd+91xcaOuhWtf3OMWFcwkDdrKJPHatrx3HOuyclWVBoOYWH6A?=
 =?us-ascii?Q?uxAt1gkXL0Tt4GeF+G+bRyDxzLSHSu3LgGe0AhBGrB02AU8t9jkL8h036/Wr?=
 =?us-ascii?Q?xmx/m+SYQJpuW76DobC8Rye7QBSfyzI9eqdz7yMBCdmFN+dgbKK7+TQ+IIBl?=
 =?us-ascii?Q?q457BkG7CVIq9D0zD9TwqrBwdhE/4vFmeUXvS2TNim08oj+nHPYQw1y+ke/x?=
 =?us-ascii?Q?uKbQ0MwO72EfRJJoNYS1ohc5liFX/zsrQgUe4p0H?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3135a3c-96d4-47cc-e172-08db211abbaa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 03:51:30.6648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD7LNWD1QfbA57WzobeXYoht1JD7BJL8fvC29uV4mt8louNa/xM9HOgM0FEH+284m6ANSYRGC/4NV3zf7eZ/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4212
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi AI,

> Umm...  What's the branchpoint for that series?
> Not the mainline - there we have i_blocksize() open-coded...

Sorry, I'm based on the latest branch of the erofs repository.

https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git/log/?h=dev-test

I think I can resend based on mainline.

> Umm...  That actually asks for DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))
> - compiler should bloody well be able to figure out that division by (1 << n)
> is shift down by n and it's easier to follow that way...

So it seems better to change to DIV_ROUND_UP(i_size_read_inode(), i_blocksize(inode))?

> And the fact that the value will be the same (i.e. that ->i_blkbits is never changed by ocfs2)
> is worth mentioning in commit message...

How about the following msg?

Use i_blockmask() to simplify code. BTW convert ocfs2_is_io_unaligned
to return bool type and the fact that the value will be the same
(i.e. that ->i_blkbits is never changed by ocfs2).



A small question, whether this series of changes will be merged
into each fs branch or all merged into vfs?

Thx,
Yangtao
