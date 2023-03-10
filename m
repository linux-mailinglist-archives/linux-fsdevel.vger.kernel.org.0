Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42216B36D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 07:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCJGu5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 01:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJGuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 01:50:55 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2116.outbound.protection.outlook.com [40.107.215.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67075F209F;
        Thu,  9 Mar 2023 22:50:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ezbdg+W3b9vNhUcY5aduDnZEdzkxNfjiXr7xKG4kSmMj2vlvwDp/ji1vuUHDd2aYOMqfOcHcqXkaYuOMwVVSS1EtXgEIMZo0LiOjXOZDfg+Egw07wXjM3Tuti1jHfYaF4uq+VwQgFTP1urvj+Meg6iuM/2sjODm3j//laG1h6OUEdKQvPH541hzw4Q+MWiHVMy58fT6zztqCkyBzOXAV6DQCt8VE2A1wlTeQEGn/RTmQt2cXW8N2r89lzHBHuMKrrSi7YNNA1JoW9vORYLU1qZB0CM0YyBJm7J09q6TvFh0q0jMa7+BItH7X4z+FoSzXuvI3bTR19CY+SBxEuKrMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pex9aEt2J/rXn68Q7Mhe+oUcnvnN1Kkk+C785IQtocg=;
 b=mSG3wnzLjliIU9PdHI0E19DQb7dOwzaBxQR7/GDOA8B3kQPPGUjGjclqbOuC6NYIklgtMMfq888QBRqxZrj52kN5phjKUc3tfsrPdHiJ7fLdFwcaM/k2bY8maRW6Qlwrj3Bw3FnP8znoLkHIenteNXzF/KpeXig4e39akDKq7F6WiU1jHvrNqa9jzdq+ncS/rgT+VJC47QdVFk/A6pjmyO1ONRJ69+M96lRkB1YqhTlJXVUcQZSi1Nxk2R/lq0w632jkR1ArZ6FVwg3Mvk9OrPXH5Y1I3yPElMvUWP4/iBt8Qq50V8yFFNunLL+Aqne/hDSOKD4TE9lsOybHkSqn2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pex9aEt2J/rXn68Q7Mhe+oUcnvnN1Kkk+C785IQtocg=;
 b=aQ33MwahQWbbBn2++ZkGngd7GAzn9+SpCsNs2abi33tNUAQq46qbaAGDPAVDsZ6slSgqcjpL5uZABFvALN3fq8IF7RjO5almr6Jv/5I3KBcmQaeOEYCYLmo6MsRBIlDGG87jzGQj6bXYFvitNcLaFQGAapgRYnEF9wJcm/RSslNxHtOlrHWGpAZstrrblQE0rKnQy1lxmBTeQnPEj4c2axJXUscY4jW0gUVYrquSw9pirtkkJH/qDW/z76DTP0uiE8+o9xmHiYDJU+Q1tFQnJ9dzTEXj4cjbfEoWeifOcYSh0uM6kZ2jPGJgmPovMwjO4wU4EaRYJjJ+Uu+B/hy6Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SEYPR06MB5327.apcprd06.prod.outlook.com (2603:1096:101:6a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 06:50:45 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 06:50:45 +0000
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
Date:   Fri, 10 Mar 2023 14:50:34 +0800
Message-Id: <20230310065034.62340-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230310040508.GN3390869@ZenIV>
References: <20230310040508.GN3390869@ZenIV>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SEYPR06MB5327:EE_
X-MS-Office365-Filtering-Correlation-Id: 203119cc-15b1-4f75-5403-08db2133c5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgJbj/huh9APjUupHDrNv+G6xx3b3bGJmK88sf3xYGB5e8nOK7WSfjJ+GTEr/gsoEFlpwXo0EK0+AdiV94/m9bIw2JGWfWKwI4zjTIy7v2LEEnSKVtrrwib7vNQHzdKSAEt4JDlip9upoF9kxt+/nYzJ9g75oPRDu4olaU7NtSU/HnYDCZ0KnibOaIqkhKcKCV2RjHl85Q72AQrZeEG1sTHEMukEtzu6g/RcObh/UFxYJfC8HaAZj/iJ5WgCUBogudchs0yBuKUqDGu9P9H3uHRMW20IXqvj3ouRxtQMOMo4QAqL63Y0YrPkvRv42WCj4AoGMI1JsI5xIUR6MY928+NW2Nw2RKNLGKqXAvr6uTx0EDKhaxN1Wt2ovpUVJ3usFdcMVG2Wno2zUQz42qZ/DSTOSRwCTaBlO1Ww67K9L6YqIU1plmF10bhVUGVHDGctWTi7C9M0dvPXehJu5ZoSbyyU27UznKEa/f9CfIu06Eu/gDDpysXnR5f+L1LT0xmgB06PF7lwOczBwWEdcCGVuHqW8VICryHP6QudTDinIXYN/HKtdClh+N0flxvvNxyOybzZvjpNkzWntja0DFOrOHxFG5f0NtwfEG9BEpiAw85UL4LbFjBl3CZ9qOgHAkq3Ga1pZ5s3qs13K+wDrw6LVLMaNRvKxCS5gQKX3h49HDjoMSk4eF0ye3WTPWe2+iEao20pshGj+mKbbmKYlL3CDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(2906002)(5660300002)(7416002)(26005)(8936002)(36756003)(66476007)(8676002)(41300700001)(66556008)(4326008)(558084003)(66946007)(316002)(86362001)(52116002)(478600001)(921005)(966005)(6486002)(38100700002)(6666004)(1076003)(38350700002)(6506007)(6512007)(186003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I6Vq5WUZhkZFCYCL6wFKVPQhhOoRsvYiiu9qvv0ekAqFgXpvKw59OjYKykI/?=
 =?us-ascii?Q?dIZ9VT5TJCkR3uHr1lfoFZgxcPgR2YwUcR38Xjmcb2Niqgn09j4bznyNcqRF?=
 =?us-ascii?Q?aJnobe/5Kdz2YNjIy5xKN/TSKyhUBQFQeanWatH0TKeb+RgTK5czo/PDPB6J?=
 =?us-ascii?Q?e02rednEDTX01XjU8Di1U9vA+PElbY6yngSM7SL8LhaIich+1K3x9a6Gy0Sh?=
 =?us-ascii?Q?wDXcQLkNLpy8ROzfXkl9ndni8UNHY11P9A5KtvaB+mXniiyw3m9Mc8sIiT2I?=
 =?us-ascii?Q?o/Lxpq+U7OugrQGspV8snqUx3wpKHW9ibaOllwCaXHctqTLF31Y+a+oQIVkO?=
 =?us-ascii?Q?iZZ5yX9M2F4nbFducQcMGxoj5cv7vMT306NHH5Y2xmR170A8jgsIJO6nTF/C?=
 =?us-ascii?Q?8MdUCkLqDoNAP7LQaHI4agkNUwV3rXgkjhx147otDxxMgewonFuk6YSXRlab?=
 =?us-ascii?Q?ylC1yFV1juolTFk9tjqeTTJ4LyQ0PnLKEyvr5CPpaIzESYViZT0TGmgkuS/m?=
 =?us-ascii?Q?CNnUJ3Zmpu9EXFD671x+E77qY4XUH9E0+Dvf2RhTtChdBzPzQjCR9el3QOBf?=
 =?us-ascii?Q?RaWAthdU5PXwcQmpjKnXPMPmz12/3P6l0XoNhoMzhrz+kQ/8Tg7SbMrpDTW0?=
 =?us-ascii?Q?h8Wejyx+dvkJ199P85Ngk+RWm9eaQEL0s1XrnQEJQZXReK+FB2sgAhOrGxy3?=
 =?us-ascii?Q?Lm36yLZqvZC+J25+7evH2qpMBxKj4OAswOT+KdpCVehce7/Ha8c//09rEBy4?=
 =?us-ascii?Q?nB5dYQVAOs16vj0QfZutcBw3Kjt1nsrAylCoRELEMA/50gUDgcWonlQAN6DE?=
 =?us-ascii?Q?mvKsOAs6dWVq2B+JI+nVqF+t3lFMuRfJubT7EMNZr4lbEwbJ6M+2xzGUC1c9?=
 =?us-ascii?Q?XooEDUX0w1ZUmBQZwGAyty9lwYrwvAd7Rpz+Goyal+fmyyx6BIbEHo6uxqyr?=
 =?us-ascii?Q?QgtqiAs4qlewCr0Uksjvv512cd4Zdrr8hBPXvFe7U4cPOn5FIZDFg0GZd6Uf?=
 =?us-ascii?Q?jq1KYqLbnvJyVC5vIio6bBrXxJo/WB1B6De8kw+9B2GydAviWw95vggiOcNl?=
 =?us-ascii?Q?3SeJVzIQGvz5ysGB6CX8rNALrHPONr3PLn++AgE5mPwdi2sFu4Ucqt/0q+vP?=
 =?us-ascii?Q?R+WAo1Y5fPTWOAh5/C5zo5Ex+6br6toXA4+zQHP8N7Bx3AqOALvZroXs5x/9?=
 =?us-ascii?Q?/GqCS5emv1aH9exuSXBnRG3ePep4bDSOLvLf/qKzBTmVBvrDikFz0zvQlzFL?=
 =?us-ascii?Q?j5z37DiH6BOcJfGSfrBQFaIuiZUxgTGduMfujpcd2jN9b0GxAVlY4IoILvx8?=
 =?us-ascii?Q?ppP3PwoqahMJBnvjHkvWSwaGl340b88fwBn/5j+fDwGj8BKvSf1l86wbTpJR?=
 =?us-ascii?Q?J/1xRW0v8jV4oRTSdYxBp3uBtYIqNFnGVVQK9OT88eeqmMyWFoVo0rnGlRBH?=
 =?us-ascii?Q?OOuKZbmIRFP/smp32LI5eO8GdT6V7OtpbA3GfWs9Q/Y13FqUtNRWXm2Bs8ni?=
 =?us-ascii?Q?hJwRLT7++A18wofqK+ml4OX6ykhdMOVs0nTbkFztDEIMrjOgngR4E93HS/LP?=
 =?us-ascii?Q?uAqMZkToYtDNPgGQuV14kMeKXhdRzI5opia3Y+kz?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203119cc-15b1-4f75-5403-08db2133c5d1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 06:50:45.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Q0ck/xcFXaRje+KC1xWYIwFMs8gx5V3IcVYhhp2PWIritf1xxrCfwe5WtKAZkqjSAVMxDWvxR5DXfmyxXOYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5327
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> I can pick the stuff in the areas that don't have active development.

Could you please consider helping to pick this
patch("ecryptfs: make splice write available again")?
ecryptfs seems to be unmaintained.

https://lore.kernel.org/lkml/20220831033505.23178-1-frank.li@vivo.com/

Thx,
Yangtao
