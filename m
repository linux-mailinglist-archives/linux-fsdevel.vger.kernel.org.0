Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED2C618837
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 20:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKCTJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 15:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKCTJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:09:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912A9100D
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 12:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hifGfusrMqMIr2vOP/JuMxRrZ3TAiyb+jcb0CmLLEX8+XfEgjkd2Z9YZ8TfTsrdMjly0QQvWZ426nhS+CV6fT1SdSb7bAhcgXn6kvpoHHa4nu+ReiBYxm5pjCUUwoO0NFPL96L2iQiiQdM23k3IyjmXbrHFKq507OEP/+KTKwBwnBVHrrq6PyvB3B7AtIZFjm9AuO+kV0t+b0WzeH1rXn98f6Exv8Ynr/0bHhQ9SAfqzT23Me7KxWnicjqMkIZd4bfQYJ0bJLF/oAvMZ8OuP8c/3wG9tevOzAmjeK8zV8oQlsHWpv0K6BmxkQ3SLLKneBUWf+2pOIGRlo949+Et+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T6KxnDjkDuSyUHNgiYd0Vlkr0jRifPTXsohMMnxMT4=;
 b=QU/rsmxo+CtsNE4ADtoUdvy/Bzr7w9cW5rEVhVnyS6Nu9BY93BW3KuEKtu1OJeWZDDJ0LjF6MiRyARX41+KDNksalJk45c34mH0L4H4570/KS9mAy20ah3hojWufpclfLM+nwU+KKHWl/KGcPcS7zStQlyVreRM9BGKPii/tYlbFkX8/KAEF3gz5sJyb2FmXhrRwDiltReaHjCLhKdHRQi649tRnUQGXeCqW1whTOe6qcOqbdjOzJZ42GIh1aj6khSmrbYkQxjaKQ29g4B5v8kDTf336Vs6OEdoukK89i+OPTlhMqYiHTO3mgA7WuSEJOA/sId+do7ds9C3tb6lS/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6KxnDjkDuSyUHNgiYd0Vlkr0jRifPTXsohMMnxMT4=;
 b=GoFJGUd2K+EOq2FiiNhHDpIxg/MplFerxv+4vKCxdSfj8SUtp1rnEbYr/i38xHFz8CUm/8asSXalpW4SztgezUHPgXo3eCxoe7iF0+lHVhwZa2W7jrWjVkc626qYnXZi3iBIqz91mUrxeOAtXYxgOgxg12RJ+ry+JDD5UAQHWnY4bRz3gZ4Nk+yQUQdNTTDInJ4RoTcCeqcfA7FjA3urcPhNjReAfuKHwOrfEjEQ5PYlOr0LYxol08BzmXeDbaQeRD924KB3aS4bXIOmzLn9D5tatKSAlSqieGYJQyLDFvFL5hWS9o7mtz2oR88Kup9TtFENr87DjQfxWjaKed6HAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6269.namprd12.prod.outlook.com (2603:10b6:208:3c3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Thu, 3 Nov
 2022 19:09:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Thu, 3 Nov 2022
 19:09:06 +0000
Date:   Thu, 3 Nov 2022 16:09:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: xarray, fault injection and syzkaller
Message-ID: <Y2QR0EDvq7p9i1xw@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: BL1PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:208:2be::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7b0beb-4699-440b-ceea-08dabdcee11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQdA5OJsrDIg2y1OUeZ8o4ilKH1c46UGWPF0oZVMIyBF018AkiCNLdsOatpSUtYPv63HU5aT9ZRLiQ1UGPmk/MPcl3OdFaVNAOP2BeCr2lhSo1YcigJ1C6j06cJetEvjj3CfIENOukLaD9FAVOxjzXlSOI1JBsqiZ1HWj+4DraS++KvEpRmZ27DXa71FZZE08dq1nBenBvcBauXoGH8cp7M9baUSXLoHFFFXIRXc6c/mp1xxtL/bZUZy3SJiVOq6d9PVVweLQ6/jKmJRCccy9kiRFqq/pqNffTpqPl/0/6pcJ3IwiKX3hoPMLLm+UBkCMwsvd86UUL4dadmCocmYQ7A1fgZg20ujV5V8kvhdUi7D6fNkCtPg8WnYuDWDCxs+ts2rDdELdiMNizGmFJiYgZr29P9ulvIAGSaH9hYiAeYKrehMTtsvtukGd/BrqLzFa/rkcnoNUFzC+Dgy/i9OYNdUgnCdcvRaFD8Wl0tFkQoXu/dXhopZ4wfE+TopYJo4+iWrSkbr99eB8x+Her6L8wmWtKkJ5XFhpgXWwUbZ5of3FZFuKrFQKgLOasQuZenibaH4ZqwOo0nfOHMyH1fdvnQYygXVWqUp991k/BeVb5sNZH19TtZwa9sUMGiKRDit8onhjH2105D+LS8DygxGX0lzN4RbKO9d7NzxTnBHT78iXoIhTRhUlU7G/9zn4B6oOiScwsFjE6Y0WXLFP4te2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(2906002)(66556008)(41300700001)(86362001)(316002)(110136005)(36756003)(6512007)(2616005)(66946007)(186003)(26005)(6486002)(6506007)(66476007)(8676002)(478600001)(83380400001)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FiG8LVCS9zMfFpllBScshWyEOc22QAiotKD9mIHcwjJJFg9Rr8CXeUZOpAAA?=
 =?us-ascii?Q?C/V0/rt2gK7pWXF/Z78xByhBDO/TTcDdeP+G9rPwryzAfhHQcm8OEUV1XaxV?=
 =?us-ascii?Q?cdOBhUQ30ziB+BdcV8FzzG+sdl8IO/MTDti9XFOD059QJ7/fm5Kd9/JMBt+H?=
 =?us-ascii?Q?O9m68jVxn/0Yc50gs1K1BW9pg7ud+U0udCkTWy0VooYxW0hCKahGrh85vU01?=
 =?us-ascii?Q?FDmEnFuNeEgQzpal0UIXpOUQjUV4I6aA/KucrP3Qh1sY+Jz7mO2GP7ucSlvd?=
 =?us-ascii?Q?z5317nb1GCfFzV3Bm7s1JFuxkOeXTsZ/jl2bbWIrrbRT+bd1euD60eqtw0in?=
 =?us-ascii?Q?i9rSA0U1HdbMDtg/EHj3LTZR5SFaY+LZBNOlYol3hQ4mONacvmYcmlaWDFeJ?=
 =?us-ascii?Q?i3gp6wg3RPbyHY2mC8P+ubIMcXNnv7ruk1TL15v7uJbwLm9bwTbCmNa6aYag?=
 =?us-ascii?Q?OysOqMml5BA9fGZYn2ip80+VJIW6zxwVQ4brwWXQ9lriFvSRxm4EPN4vysr/?=
 =?us-ascii?Q?BVDrfnbl7ML+ztn58AMPCo8CwhoKz2aTAQGGypR6cpnhR4qibYuySkj5Uzxf?=
 =?us-ascii?Q?M5dZ/N0gjya5J48VIY+ja9nLncrjQ1yz7yHQxDhRX31QoN9R/0pPMc6zYMjl?=
 =?us-ascii?Q?KGnbafH15DFymQHd4730wyt/ibBPMEaNoU6BIzdSoYy4BG8FMO7g0hb3c2FZ?=
 =?us-ascii?Q?q6oS6aZJqQpvIddKbVzA2k4O95vOMCOGw/U9Mk6z1xNLyQO5HPu7zQ0IYCn+?=
 =?us-ascii?Q?VCSigihaAGG+3HoODkvVd/K2W30csrAJO+6Qj48n/fO7dzbdCyLCCH3xMqml?=
 =?us-ascii?Q?vqOTdVgnqYJeZjRLR72TF7zv6aw4q6zXOJ5qtzYh4Tbdninu4sSLqMVFP56Q?=
 =?us-ascii?Q?Jw1a+GRGFfpkfdaMvkpaopKl4+T6dtkzAlD6RV8BulmQIVXkq2CJz38gIDO/?=
 =?us-ascii?Q?89Et1UkTZEHl4+rhK8l/tmN57o9IfovkWF7u+vCVSi5nF9rqNr7UZJhhi2Ih?=
 =?us-ascii?Q?xDPvk2oLZWAz4KsXenNpmmY6WGN4+ue29Kof6mNsd8mAieGBoo95OHVf3dnX?=
 =?us-ascii?Q?HxhwN2e5cgd4ZbNEf/5Pd22PR1h+ecJpOgthtRzLVudIhAr/y3qP/CYEMGYO?=
 =?us-ascii?Q?T6GquBdTJTuhgPjojB10qwfg5bfi4X9YzjcRuZtwRym4pV7+YRZyl03g09dz?=
 =?us-ascii?Q?PMPNRoxFP4rSnh7qVbx4g3NJkBPvqS2Ygl+XFjB3j1pTA8jayf/xiXwPBkT7?=
 =?us-ascii?Q?W0MAPRJ0VDxgS3iJlS6ojLkrBxbzPK+vRb9QdZizHwczWBs5wdgn22C2wMI8?=
 =?us-ascii?Q?EHtYYBMu8R75tnkSpZ1x8rPZFAfcy3UiXbrC3gic0WueUicuMaSkSZaKvvQs?=
 =?us-ascii?Q?QQlnFbX06xxqYo8bjJvfJ0LYo/XiVV44KGVzDQM5q7PWvUXeMkpLDVxfBq2Q?=
 =?us-ascii?Q?8K1T4+KlR07SgXE6m/yfCqb5KQkqU1J572quittoi8UHajURSl83JeZnKN2f?=
 =?us-ascii?Q?BhHfyCL1RzGE1VlSPrq7iU5N8G4nXE+oXr97eGs6DY8gW9l/miGO+bpBR2K/?=
 =?us-ascii?Q?1l1UHCqa7dNxqw6goeI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7b0beb-4699-440b-ceea-08dabdcee11d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 19:09:06.6273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiFM7lfpUNdbNL2IqyXvsoPCPKPxaEIu892RIa4C2Agp40HutKUtlkYhm8HPcgmd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6269
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

I wonder if anyone has some thoughts on this - I have spent some time
setting up syzkaller for a new subsystem and I've noticed that nth
fault injection does not reliably cause things like xa_store() to
fail.

It seems the basic reason is that xarray will usually do two
allocations, one in an atomic context which fault injection does
reliably fail, but then it almost always follows up with a second
allocation in a non-atomic context that doesn't fail because nth has
become 0.

This reduces the available coverage that syzkaller can achieve by
randomizing fault injections. It does very rarely provoke a failure,
which I guess is because the atomic allocation fails naturally
sometimes with low probability and the nth takes out the non-atomic
allocation.. But it is rare and very annoying to reproduce.

Does anyone have some thoughts on what is an appropriate way to cope
with this? It seems like some sort of general problem with these sorts
of fallback allocations, so perhaps a GFP_ flag of some sort that
causes allows the fault injection to fail but not decrement nth?

Thanks,
Jason
