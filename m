Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E31C618962
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 21:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiKCUKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 16:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiKCUJ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:09:59 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97E8222A4
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 13:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzFpWsOdk6uqFenQKdaZwvmXEsFsDKupL8EFjuBcLr6NVCBTT8ZrE1hptF9/Ln7hdDBiBsNC16WwsrZpr1cm5tQrjXIFIiAguoOdTQHyzIs7L2kPzRIQV45+LC3oC+orp8xQLD8lb/Mpinfyw60Q1ly4j3ER+w5BbAMvZXBsWN18Tkqi4jdyvfzojOee5W5DKR8yHZJ0OGm//YasRCNKPzWtHIWlW1PRxCsuY3DsrQZcCSSyxewL8AqC5uG0OCIfsjH8yH48XE5Pwe4kkSkSQEJZ8/oxxtXw3BLEtbrNwIEdBKFefjam/rEvx0JeI4Z9W0NJ0MpHO9rh3gLEKnCXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gty+6GHZnbYK/hPlWCsf8ANE60UTeDGYh0ivnaMUd00=;
 b=eg0AdwYbRc6LU7hngjV4v9f/2JhKq4H3Mq68Faxh5zMPiokCUd03f/gWaIZ/rEy6mP9sGfbr90dCpRwH85OGZJW26PXUppv/H89mMCataexO9ylo+TXQETbzowcgn5JJ0h1ca5fBKfWHZCnhgj4tUjltKoUTtWQI8BWUK1vMynTGJ3DTrC08gjnzdDajIPZPLHangI17XySSlH6kjJ6PvQ5/kYggOJlIWJSilmcQSGa2sPc0jDlOaQrr1OrLdU6POCWhObVexf8zaqxWm78mgNlWnowzbTprtY4+aw8j07ABgEfTkAx929AF/HLGURw58eFTbDPjCMdDHCfYvJOCEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gty+6GHZnbYK/hPlWCsf8ANE60UTeDGYh0ivnaMUd00=;
 b=J15mR6Fx41UFzwPismrcMCMIAVhrBQ92PlmZJVohY1RFvbHapSoo/T1kIa/GUqqN92F1VOfJDz2orMSSgBPlozoozZVZLLng4aS0WZfSen9k0XEqwmFZSJK0vBj+E0I9MND07Xh63irE7GlN7EwQsHPzIsJJYVgaSH1U87v6mIiaVHzW/AJsllmXei/9LZ6QyPhu9QYDvBcy9RzkMz80La8knA6WiAs9gXOpjRHoJH9iRHzNSJaR1W338i7Un7A6p89v0Gc0Vef5RZGGcPiqMUpUzf+B5XhRo/PG5bSyRaGyoIZKB/Pl1QuXmtnyJSrrxWErGLISQnJpjxdux58b8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 20:07:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Thu, 3 Nov 2022
 20:07:47 +0000
Date:   Thu, 3 Nov 2022 17:07:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2QfkszbNaI297nl@nvidia.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Qd2dBqpOXuJm22@casper.infradead.org>
X-ClientProxiedBy: BL1PR13CA0447.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: 052dca33-0628-4d80-b565-08dabdd713fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umaxyXTmrwgBbUbAdORQHT7iBKxC3/mcKC7tpZ360NaSNNJI8CFWqbTwBAujLKE7DqKw6O8zj3/UdNzG79LfpLifwoeiZEvvluj7BH4RBf6I5DYaEvdgAhQM+adz/M4ZEx7YXEb7PJcxHzpA64UPxhgmVDKcZyFKUc3o/oAEGdAuwBkQJwKWx0B68mxDxwCzTsPn2f6RFRakAjD8xEuoBpWnqJfDs4IGlweBBzH2HQctxfqMCM0F3Yw3+IKhQxfp7QUUkuk9i0QxXPpQhlijFas1FWOSjnxo0KDn3BI9rNQo6GhQlA6yQQG3HYiH+vcRPDZQGRRNIMT+HifYP6ZLacL1qwX+kyOP1zeAuEuePVIivb+8S9BxE8nKzQd9mG7p+Ga0eYfFb+9tYNU1nCTl3BIsvA8wT7he5idURcYKdIOtfyLpBuucZHZx5GOXqcrtQ9FWP9ppESWztlOfM2pU0ITjG8yfwnNh5LfIauljdRVqIFfSB+ho11r/AiDXt8XpTR5B7ytbjsmknIKNbfYwc6Dvf3xhrZYWEaEpFJi3BWUCVHGc6NP2kDDU6NUDmYp/C9aZ6IR5QHTp0aqK7jcZ+86GQh6R72yLy2UpUx4qJcKoyWYgjun4ZrDVsUODju37eu5MmrRSYS9h0e60ICAdXZujf7dHa/bWh3VqewfoYM6tCQFpz7COC4bAGehgzptmB4Sz5hezGAXD0C4IKTWC8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199015)(26005)(41300700001)(36756003)(86362001)(8676002)(66476007)(66946007)(6512007)(66556008)(4326008)(186003)(8936002)(5660300002)(2616005)(478600001)(6506007)(6486002)(6916009)(316002)(38100700002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h++HkH98yu5rXQf/iY9Roi3h8O8zPghA1ojCw282gLQtIQz89jfR4p/r0oDl?=
 =?us-ascii?Q?Wv9e5FyT399QzOOeOURM/bAYm8o48qstrBZ5n64rhx8kp0M/wKPjbt5m1vmX?=
 =?us-ascii?Q?hu0rjpUZ210csyHrYvbSnKMatAaLE37ezKLebpxbwnD+YgI4nEySBTzuWAmO?=
 =?us-ascii?Q?uU6VscrQYReNouLhnsipLf3nKVliotAoAhxv7QkhU3TY8w6kTbBOD8+JFAcY?=
 =?us-ascii?Q?1K48tNfAIcablaZY5G4wWfTm2N9fNlMdIriCrOg6TeTMAQYRfN4USiAwUuDi?=
 =?us-ascii?Q?r6cPXilcgHUuDeLR5MuYuA1gfn35qOnrb0/tDZ3D9Au8tdDvQ4eSV87W5LN/?=
 =?us-ascii?Q?epP8ccP14wMI3sWRw/Lq8ff1BLlH+iZh2exJxCnyYu9uQaqNd/2UBkqUIRVH?=
 =?us-ascii?Q?skvLxR0Q+V7/0HW2H2dstwjU6ClgWCUPwa3HF1BNFaF0yDw306fPJ1EAUXPd?=
 =?us-ascii?Q?s/0xz9yzFKuWVQ0Xv97w//h4krf3g+87DvtjQP4hwjtg04aH5eE6e9qlzeMo?=
 =?us-ascii?Q?s9BZqanphayn7dc1PgR183LwTdXmoegMxFSqj33uP67xBCwwRGxWB0NTiEWe?=
 =?us-ascii?Q?xgK814YCmsYaNLXzNKy0u3HNs+kzb6EMzWf1eg/yvgXcuULeNPCi2DmVA3yw?=
 =?us-ascii?Q?lKgz9EETW6KQGynrCNWjrTSJnhRWVCd7TezDUA8+vygJdsZoSlSMHEjd6ij9?=
 =?us-ascii?Q?7DIziM4TazHSmHp1MZ9emnXrdq98mLIdMhSU7UVCfy5AtwhHq81B7RR27kti?=
 =?us-ascii?Q?qAevU/MqbfRZ652z8nJ2kPEoM4766Xc0aTZNaKqNz9w//qfT2zz+CWbkjd+j?=
 =?us-ascii?Q?GNpiyA4Y6K1T2CyV8cCFbuXhQ3X+wOkG/ENRfdrLnfD7yYvrgbCu3Dg0nVrp?=
 =?us-ascii?Q?60ZTyaeCy+bOoAWgEUdZdH7OzukiwkCWSKTjP4aLziGMfsYRgHfbeY4acGPa?=
 =?us-ascii?Q?oMwsytY6uFi4tx1dIkb3SlgeaF5k+U3E1tezDmd7VOMqIlLUpJBkZtpoGnu+?=
 =?us-ascii?Q?pap3qMRpd1DP9/kJCANwPt4euMInl8Qruq4UY/RApSXFEqygmOPpGPfm7luf?=
 =?us-ascii?Q?PK7ICVjPTCvpIv6eWDgi1doHixWhMRdXx9K3xiFWam90/UlKp0fSvngeVXWu?=
 =?us-ascii?Q?TIA4dSAQ0RaNLHZkW/XXN8QZL7x8qVX0/KlVK0r6kehJe9gIToB+RPvvokQ5?=
 =?us-ascii?Q?cRYjLODN+LUM+kOZ8yF7Ywi+fJRXZ33Ij8OdUQWNhNhf6+JeZh3qM1jthTLh?=
 =?us-ascii?Q?21O0fpWWqyoCXPKW3dY6z0IyOqZfnJ8HXFPyoTK1Hv0InB8r82UBiHQaEtze?=
 =?us-ascii?Q?G8QGLjB4PrLf2tboIq72tn/GWU9swnZX9QcdWJSED4Ae7LlzpH54Vkou3is5?=
 =?us-ascii?Q?EYYKGEDz66BWpk8JwUkk6cSPWTnzVwQ1HoePPbGylGaT//Vx98/xq+P45CJW?=
 =?us-ascii?Q?UI52cL8NboKi7UvkoLkLGFzr4hTjOsowPvVwquI6fMrGEBX+ne8os4TkKlkp?=
 =?us-ascii?Q?53Zx1WNmzBMQePKWcNF7xt+dTGTwU2wAtAjj32t6WyaFbeWChBuHQi92lnDG?=
 =?us-ascii?Q?0dNbkGbuys/NljOHm9w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052dca33-0628-4d80-b565-08dabdd713fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 20:07:47.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WrTuEhfrx0Eq71HW9fCBYZR3yDsTSoyksWj7/k7lVIMjE+WhOxqabvzo8BeFpz/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 08:00:25PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 03, 2022 at 04:09:04PM -0300, Jason Gunthorpe wrote:
> > Hi All,
> > 
> > I wonder if anyone has some thoughts on this - I have spent some time
> > setting up syzkaller for a new subsystem and I've noticed that nth
> > fault injection does not reliably cause things like xa_store() to
> > fail.
> > 
> > It seems the basic reason is that xarray will usually do two
> > allocations, one in an atomic context which fault injection does
> > reliably fail, but then it almost always follows up with a second
> > allocation in a non-atomic context that doesn't fail because nth has
> > become 0.
> 
> Hahaha.  I didn't intentionally set out to thwart memory allocation
> fault injection.  Realistically, do we want it to fail though?
> GFP_KERNEL allocations of small sizes are supposed to never fail.
> (for those not aware, node allocations are 576 bytes; typically the slab
> allocator bundles 28 of them into an order-2 allocation).

I don't know, I have code to handle these failures, I want to test it
:)

> I think a simple solution if we really do want to make allocations fail
> is to switch error injection from "fail one allocation per N" to "fail
> M allocations per N".  eg, 7 allocations succeed, 3 allocations fail,
> 7 succeed, 3 fail, ...  It's more realistic because you do tend to see
> memory allocation failures come in bursts.

The systemic testing I've setup just walks nth through the entire
range until it no longer triggers. This hits every injection point and
checks the failure path of it. This is also what syzkaller does
automatically from what I can tell

If we make it probabilistic it is harder to reliably trigger these
fault points.

Jason
