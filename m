Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7A7520C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 14:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjGMMFm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjGMMFk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:05:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB722682;
        Thu, 13 Jul 2023 05:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4aIv+8mLscnrckBt9RyUwHpsv4hgwIrL3f74ix7gkaCKVUzk/TWn7FAmrSuZxMjIGrBF/teRD0HU2yMuSSOl65pqVqV1inq6xTo73Jy/8nSM6c0JhNjJg2RsClxVB77+J0IOHsa+iB073Iz+2/gKQDAVJo6EruJjFUDWpr4W8YPYesG2rg8axu2DZQd4mJCTcYRCvNDShJeUkjr125EBI+cm/kWdVejpfmXMSizR1iNcFNRcmQ+acIN+eWBv3Q871QRpamylDjmEVrPdwZyL253q4NrqjrrX1xzu+7485kPwwdzwoc2fstvAWXfQBB0GG+eSx4V5R26OV3hpIp0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46t1vpqH/2W2DPq5F+oiTqhgHdbG/OFg1FyDVd/HtuQ=;
 b=AhN/kp6FhNNdgaWyVpRc9KkZtDALVGmjgD0LD/re4bwrGjUdYJJnfQZc4/c2AcdrBjlJWVrc4Z/EfQkW0/rYzZc4korhTdWbQGg4Fg93kDmPz1N4KZop8fkYSXB8frI297YxrzXckVJwiYqcfrENSB5awHHmuz24CD3M3mSLFkk9BdG5YM8goJz8JuhYoBQ4AC83NxYYfVDEb3+lkGDwAJiyB24j5ktDq+dIYRuuJz9LprlAZ+Q7sh6y/EbzP/MWr0Q1SeGQrDog9FX4KsqcE6os6j9lJ2+g8l0NVou5wip25uzBJuOsicrH5obd08Fn0IuZ80OjXZ0/2tStCoJJTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46t1vpqH/2W2DPq5F+oiTqhgHdbG/OFg1FyDVd/HtuQ=;
 b=mPaRwqJvYW56HK/+G7XNOJMz7Hq94gemBGkz7C77GPehZwWokNkhhzjUwM+c5/AFjGAzb/5emmCaU8bSsYnF8ifM8T4WY9ukFwisS+StPQ8qS7VBglq3oT9XafdxZONutHR8TA1LMPgcCEFcK2PUVacN4iCYnBMGqDfZeDJ7KpbqT7rZiWW0UEpCTSy5u9GfrL0i3wqXqLxeoBuA9+cjxF6x6tcenuD0Cpf5qGGsVpETpY4JoteSQoAxK6647H5flmsTp1TO8xFX7Crm7C2FH0guBz/hqT0aJKf3xphyf2sVRuOHpcMvftdaLrBCxrXa64qT7R5LS0f8qDWWiatwBA==
Received: from SJ0PR03CA0337.namprd03.prod.outlook.com (2603:10b6:a03:39c::12)
 by PH7PR12MB9128.namprd12.prod.outlook.com (2603:10b6:510:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:05:33 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39c:cafe::91) by SJ0PR03CA0337.outlook.office365.com
 (2603:10b6:a03:39c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24 via Frontend
 Transport; Thu, 13 Jul 2023 12:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 12:05:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 05:05:16 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 05:05:14 -0700
References: <20230713-vfs-eventfd-signal-v1-0-7fda6c5d212b@kernel.org>
 <20230713-vfs-eventfd-signal-v1-2-7fda6c5d212b@kernel.org>
User-agent: mu4e 1.6.6; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] eventfd: simplify eventfd_signal_mask()
Date:   Thu, 13 Jul 2023 13:59:01 +0200
In-Reply-To: <20230713-vfs-eventfd-signal-v1-2-7fda6c5d212b@kernel.org>
Message-ID: <877cr4uidk.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|PH7PR12MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 00599237-2058-4671-d894-08db83997573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vVttLdahOmtF1a2ILkXv5hkl159lZMIP5DopN2km/xwNS7eQSUwkOKtsVWLQIeS4+jJwW3maOezHt2v2JBw/+sVj2JhXBu/YO+1lknF/N5qSt4SoGCbpgxv2rVbPfmw+C6gRCO1WWNorKugyk6VGQ8erI9DCGpoDxsQfXyu7gwsyECbTpuD6YToeU3xwNvvw58aAk/zaJCZ4sJHkO5YQfDmkkAzTiQpqKLVNi1JypOxd+mJYnSWx0kmieTOb0ZvlslR/3R3Sopo0Li4D/PPEvzFQjd8gYIAcbTwMGHQRZBjzmSs2psU9RnqlaoCca78BFueofyKU6WwbXNvmMbdyoi7D4vwGLc95JBQMpdQMIls7x3/7FQHY2TkwBxtR5OrW966aLYD9G/DhKl13pkscJ+0bwoBV2E+uT7u+sfQr+iR8NfVGkx/JMCSI5QSMMwYeKscudgBeaDNGthTid9eNAgHXWKi4/8R+op2KZAd1dZEg1NnMEjF9+ZPIXP5oR++eXV2wZJKFd1b9VLq7bTfoElbm6SbGD6O8cVpLZDQxcJXBMjUzfYw5p2ho91fx1M0PfnctQlP+JupBk7RVWUKA581ef/Qg9HfKx5zXQ5o1f6QoYhFm/4+RDWYQE052v4DPs7INWfQ2sT0geBY7ts26XI5PUmz+fohtmhXaAUBgyvoLYy20Kz+0fhvC9U+2F9lRNO5yvKv+xnYcXKWyXSp8BtbbRC88Dsdw4OH6oD8KQ+OnxnV5CPsS5hqDZtQyZuW6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(6916009)(336012)(70206006)(70586007)(426003)(2906002)(36860700001)(40480700001)(40460700003)(316002)(47076005)(4326008)(4744005)(41300700001)(5660300002)(36756003)(26005)(54906003)(356005)(82740400003)(8936002)(8676002)(86362001)(6666004)(82310400005)(478600001)(7636003)(186003)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:05:32.5256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00599237-2058-4671-d894-08db83997573
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christian Brauner <brauner@kernel.org> writes:

> @@ -82,9 +83,9 @@ __u64 eventfd_signal_mask(struct eventfd_ctx *ctx, __u64 n, __poll_t mask)
>   *
>   * Returns the amount by which the counter was incremented.

This should be reworded to reflect the fact that the function now
returns a bool.

>   */
> -__u64 eventfd_signal(struct eventfd_ctx *ctx)
> +bool eventfd_signal(struct eventfd_ctx *ctx)
>  {
> -	return eventfd_signal_mask(ctx, 1, 0);
> +	return eventfd_signal_mask(ctx, 0);
>  }
>  EXPORT_SYMBOL_GPL(eventfd_signal);
>  
