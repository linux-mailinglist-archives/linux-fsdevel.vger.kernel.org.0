Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A33613F32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 21:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJaUqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJaUqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:46:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B23A12AC9;
        Mon, 31 Oct 2022 13:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IieUE7mQ1okaOYeTQHP9EiF6iVKm2SHGedupPlttH3SpqwMy58WUIkDRES7F8Jst9Iy4jAqN+5zqEDLRVAGt0IXz6AC/H1AlEkeHH5TrETxxYUc+Fra2ZwVnw8lIbCFF2ZsfUcZWNQaiN6wcKRDPTWl46FpS2a4mNSVZFExi/ILPHK389TKpMfSfRSUgollIC+2RDxpjSg+6W1U/TP5LodguxcdnXzD2lAKMaMjPh9DIwM3NjM5w/9dYDKq6zNcJSLHMxc2iWM+KJsUCdDJssPgtCzZjHn41IP6lbM/4sLN57bO3+kWNAVqCIg1jDHNttJlFux2MQxGi9I6TY7KAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMQ/maLueqLebjkcaSryhozMqUAdICMFcpHGf9wDFIg=;
 b=EiVZ6OhbbvTjXabyN7o70nAQ5ViO9lvAGDfqrquaGaB7CwR2dQvtZudWLJVsokkxP93AsNoVb4UJSmjgeFh1Dl8Eo9GrA7Qy+SXKTwz1jUuZugTjIDWgZcxMx9T0OFczg5WqAw7Gm6nNE2Ygfgt3IYE7n2jTrhxnjhqeFocZQfG2duUDZhV4Yt42eFr5LEU8Ll1QwWGF4j+q5xvD/SoGntgCd0ykgsIUw9Y8bj28r2qONKSYFQ2bVPXXGFON0P+ogXhtTQKqd/ZzxXqcIu1p0gVnLIbWTqis9pohgONRCUfi2XotERmbcR3EbRuT3AwSAIbvc60iMTEiIKmmHJ/V1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQ/maLueqLebjkcaSryhozMqUAdICMFcpHGf9wDFIg=;
 b=Wnes3hrUfMlCrCYBZv7zuLbHn7SDGVQHVM+b/hFf0coXxa6clUWPZn+Pjs7zLr5IRf9v0LbPRgNTYW5bSXsbFDgsw1V0baV1LlInvsfgm24h5RoZKYcWaqGDuls8TfefDvFBjI6cgN5WoOl3zEVICcN0A2LbMKHQL4mr7Bre+RQVa+O9/lTDJ91wtQU9oyZlZVYuxkt+R03YTEg3W+Zz28NqSVtbdamUWtbnZ5C0SiTz/onRgXF1Cb0rDTmNJSeoTmXSiOYAf9F5a6GyNlzFcbZSaGr9X7XwvTl6YpBoi6sKU42HsdRx98k4nHfC23WtDsyBoa4pn50MG2GEisc9vQ==
Received: from DS7PR03CA0226.namprd03.prod.outlook.com (2603:10b6:5:3ba::21)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 20:46:21 +0000
Received: from DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::e2) by DS7PR03CA0226.outlook.office365.com
 (2603:10b6:5:3ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 20:46:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT074.mail.protection.outlook.com (10.13.173.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 20:46:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 31 Oct
 2022 13:46:08 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 31 Oct
 2022 13:46:08 -0700
Message-ID: <61e7810f-97e2-1185-312a-d096b5b2bced@nvidia.com>
Date:   Mon, 31 Oct 2022 13:46:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC PATCH 0/2] iov_iter: Provide a function to extract/pin/get
 pages from an iteraor
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
CC:     <viro@zeniv.linux.org.uk>, <linux-mm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        <smfrench@gmail.com>, <torvalds@linux-foundation.org>,
        <linux-cifs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <166722777223.2555743.162508599131141451.stgit@warthog.procyon.org.uk>
 <Y1/hSO+7kAJhGShG@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <Y1/hSO+7kAJhGShG@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT074:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f57956-bd88-4a5d-b789-08dabb80f757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L3FCBZWxu1rdySWGq1ozj1kG66DgGElXhTXH+dqLFM2z4FDud0l3n/aDuNhZzWbVblIfahJTjXGmI38UeZqJYRQQlJd+S3pYDrcQ9YpbbUevcAE0LpF3nd9oXU2s5HNcWpFHgTvDvOOhUG7sKbE1HxVF2kt+t4dRREBO2x2bZ4r+4dps9Z7znXAER8wNYGyPWfD5WQ6fBVrjWz6x7Mn0YCvIgGIbUCW59RfroyFRT+M30hKvlyMBJZjs2HBBsbBA4BNTcJqmc4CxlXfF99yQiEYx+PybG/EiJ0r7ZhX9JNJOY4yvBGUI0IAPCM/m5NZzFFvuith7zroXKea/04ykvNi8+mgo0YthQpIThZFlR9JHCN28RXv7JHz6xRX1UXdG3DBrNbG6oxP5ybI1eCAJ3nt5QJPBtrut3JIAx92o6W9XaNAPhHecRMgzhygaa9mnn6/bSWZvz8uV4Er5B3Eux8SXTm1KehlTjZJ3eCViBteQSMtmhUifPBVr1QET7C3zgqlyxXw1d+4C/VEoWjTfjkxNUdcLI70eiro0ra5YOSlrrjR7MMSb+MZ6WshdBEWbP7ZKx9e2HZBilEhx5UVQDYE01OCWZw8sH2XgonqhljKWBmwbbM5zjmfbr5SDJqdLoHre87GamenwspwgRRTdOi6kfqDSaj4BMnkeqat4c9sxsKaE0VovGdT/VgXlYNZBa+NUHIEKG50ubPKLjFLa8o0cjgPORtvpMFh+pjRwYqvNGZF9DdGM3YOBYKTj6oD0ElfzegaSl5qCGmZ0Mvmpqj76gsxF5m3f5owF7NRPvFg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(31686004)(36756003)(47076005)(2906002)(31696002)(86362001)(336012)(40480700001)(316002)(426003)(4744005)(8936002)(7636003)(7416002)(356005)(41300700001)(5660300002)(186003)(36860700001)(70206006)(8676002)(70586007)(82740400003)(54906003)(110136005)(4326008)(16576012)(26005)(53546011)(40460700003)(2616005)(478600001)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 20:46:20.4713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f57956-bd88-4a5d-b789-08dabb80f757
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/31/22 07:52, Matthew Wilcox wrote:
> On Mon, Oct 31, 2022 at 02:49:32PM +0000, David Howells wrote:
>> I added a macro by which you can query an iterator to find out how the
>> extraction function will treat the pages (it returns 0, FOLL_GET or FOLL_PIN
>> as appropriate).  Note that it's a macro to avoid #inclusion of linux/mm.h in
>> linux/uio.h.
> 
> I'd support moving FOLL_* definitions to mm_types.h along with
> FAULT_FLAG_* and VM_FAULT_*.

+1, great idea. The use of FOLL_* without including it's .h directly was
the first thing that jumped out at me when I just started looking at
this. And these really are mm types, so yes.

thanks,
-- 
John Hubbard
NVIDIA
