Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44222744146
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjF3RcT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjF3RcO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:32:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20729.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE63AB6;
        Fri, 30 Jun 2023 10:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY+0lxre64vpZzcniM6C2rg5CYkZVtg7sa+g3pat+0V3R8wv0XaV5hRnH5+C3fusIfYHGwNn4a2IqMQ4FDIjrkCynXMxqxg6bP6juqarvAkdoD08X8nzWH7+NmLI345sUtOxWqeY+Escy+bprB6uQFfIPkUPtuVarFeFATZhcoraWyjxFMeuoQjHFpA/gwly7vIYsHF3PoPYvcxANi4FBI8H3Mxkux6jOX4mPqR4lxY4/pIsBhr3/7ws43SiANTmx18WCSax8DI19k+0PY6kOQzNj8ZCR3injSVxfOnebMIKEwzygijrYK59mkf70ItG7H0etWbJ80QpRPuKuiofww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR/tk9OjlXf62UjgTR+WCe7pAajztS+TQkgrNXxondw=;
 b=M1aF1hNEDVmNUiZN67pVCBCq63lL+WuBu03isPmz3VyXHUkfVtit8Ltbq8O+t5V55fgSygEqC82MpNRVQDcTk/RnElBneHllHGDnAIlRi2juBYEO5shILOdVsFfEQIUHErLdeVBTqP0seW13LIOa6kakc59Cls035Jv/uG4INu/XdBGhf4rX95jxU5KHupna5SyxOXdHjWuehtKxtKSwx26C6LdUHSzTwJwNYAZap7LSnUISd0RmC2iqOjL5oXg05+lJ7F08DsUvg5u2z5Z6s7Syq3uVqSgDlr4Aui0cUddb0M9wZItY7APN992P5UcOlr2DIyg8GBmWLWU/G5KWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UR/tk9OjlXf62UjgTR+WCe7pAajztS+TQkgrNXxondw=;
 b=rybXyzm2P4qZaGfJgepqeEoaiC9J/P8F2ZwB9CtuVAVLnpUWS/3r92mEv3g5wGoP00lRZJmtuQfYoIprmnkFq20E2SWMr5RkBVlzGVMDuL5pOJWbHQUXBb3vMtqUaTP5mkftCUFxDNC0tI4rYUnNXagBEK1JrS7LjgtDoDy/1do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6295.namprd13.prod.outlook.com (2603:10b6:510:236::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 17:32:07 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 17:32:07 +0000
Date:   Fri, 30 Jun 2023 19:32:00 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Matt Whitlock <kernel@mattwhitlock.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] splice: Make vmsplice() steal or copy
Message-ID: <ZJ8RkKCLYxvEiRq5@corigine.com>
References: <ZJ7cQ8Wdiyb0Ax/r@corigine.com>
 <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-3-dhowells@redhat.com>
 <661360.1688138974@warthog.procyon.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <661360.1688138974@warthog.procyon.org.uk>
X-ClientProxiedBy: AM0PR06CA0080.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 3187091d-8e91-4f59-5f95-08db798fed4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rnmld5CXyKSSLWmftZ2KZz7oImAF5+NsyyAgiexVVNk1eG1gV5faqAhtWukbiYFfdn6UMsYZAEUy/z39GSeyaqn8ECk1eMFQc118QaAMW339/p519Tws/7Nr5slvdOAbsooP249fclB6ccGqcnmUspiHi5iOcnm0uxRmLoOqaOy92v7swr1xISALHSf7wBX1es2s1XbbuuAob9TIlrzK5XJspxyLaenuprpPKqQWFl/t4M8fUkBAlc0PSGU/BGqRtugEtoR8R73fH9EMMvymL2YB/rkft3jOBqygs6FaNn6oQJ96IXV7da43LdPWrQ5LtC4V7UIKgffzxdFg87d6GZvVqltv4DW/FPAoUWavdw7l1X+3/CYhCHkHmykONY7Fb5n8dA+d6WJEcXsZyAoTsgc3wx5N4jmb5Qehazen21+mdjNYYMLm9dDWi9UwUQzVfESeuIA5/ybuQNyva0EWIeud2ZX2w9lebcgzGS3aERhIifO8rhHLTIY62fwiQA2uWuXk/mN82XmdmeH57sEpTXFyTdLDBZhrM6lGjQWeTWdytkMwsSCSMx4fDJBh6nVXQP4feh4bxHuckOZ1kAeHLKxcTX9kO88Farstl4DUv4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(396003)(366004)(346002)(376002)(136003)(451199021)(2616005)(2906002)(4744005)(38100700002)(36756003)(8936002)(8676002)(5660300002)(86362001)(54906003)(6512007)(41300700001)(66556008)(66476007)(6916009)(4326008)(66946007)(6666004)(316002)(6486002)(478600001)(186003)(44832011)(6506007)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91EbAinSusLh0w2HVdFInHY8cQZkA+fHtSD4XfVo/oV8FrEWQqZqsC11JM0+?=
 =?us-ascii?Q?KrILmFP7Wc1xhrauDpzC6hhk/gemymOtUdUACR2orXs2mdmGCpBRd/oKfwtg?=
 =?us-ascii?Q?fcTHPno232ivTs2QH2SVM0r1/vjHwH8gnMxePuNjMD4o92OybUH8z0f3aMog?=
 =?us-ascii?Q?ERrzEvhw+jNEFxXsYuZ8hyef8Zgs7Da2U4o363yfdYHQ30GGATmsN6/Nz7KR?=
 =?us-ascii?Q?8+9L6FMH8xzdhWdFi3dYu9Q87csGmAISaYiIX1k1rdjcLfypi1FPTKWrWx+d?=
 =?us-ascii?Q?Zzk1vPdbLZ0omOPys8HTUUWkfvIrNGtouPl30xU72pd8EFyWjTzFldCfjG3W?=
 =?us-ascii?Q?so+mUZLD3xAYnQ1ZEMKoWA94NDP1QNf1/jXtICdjIXPcOhpNIiovVy8nDmxw?=
 =?us-ascii?Q?ZVPBIQnbxPf2a4poc2JLFnycCA32EuYhHNs0WJ/ZAyDVKbeJMv5nn86PlUWG?=
 =?us-ascii?Q?7RWabbkoy5KkbppLAbQ1+0ugtGCFfdVef/5Mjn5rtFaQUTZ9k3oBwjgDupSv?=
 =?us-ascii?Q?cyE2RNmLapfsCRyVbO7MM1eDtliUdo8pRRphjMjwJu/rCzr/PNihTo5biVO+?=
 =?us-ascii?Q?zWxdIcwlXAaf6XjxNBIXxTFXJ9vgZ0RjVaJyzycUdSH6VpTJGhV5Oa9wOhnH?=
 =?us-ascii?Q?eEkCesCNqoYw4uFSTKA6P7uuz1dVKiPol5r/Q2PENAUG0IgHVeq0/xWzOT5X?=
 =?us-ascii?Q?B0OPOxzclr2CK2cV5lnAYXm8qqbitHrwMdFbvzT5qHjWJYFcN2VwsV25YyX7?=
 =?us-ascii?Q?sSBhxhhhP5TJuNOi85LxlZrkO7dy1T7HfSsItPueLV2YTo3CyAwxqP5hfZBd?=
 =?us-ascii?Q?fvmnLYCzNjXPyAUH3BUxbh0Aj2pkHP/96PEp5w2bdrBWhwqgiIGAFtb/8zK3?=
 =?us-ascii?Q?BdJJLWWXozQiKjGkrVP+tTUNownpYSDTeD6Lh7DmQZCmlTGTOaHNepnDxaVT?=
 =?us-ascii?Q?LmPRLDzaGVA5rCd8YfE6zfPDX4w+21Cj01tW2/OYQvaJARojzMRz+AS9VTb+?=
 =?us-ascii?Q?V3UW9hnmyz3Lg3ENUnLsdCKh9bJ9IFxIH3V5QSVU6c6jHUVEbnhqjNbzYOI7?=
 =?us-ascii?Q?IscB3EeXMpF3UBxYfderHWByUV6okZlEyWvREBi8VAKSa0yPlusZpwK9mbar?=
 =?us-ascii?Q?IrIDCAwafCCRqZ094FbaoE1bM1EUcrrtrl6VdIm5nnQWr3GZVhZFmyBGxG9q?=
 =?us-ascii?Q?bJGd0voJ2W8pdAS/vlOebRQmMV1KbBKQj/ddYqlldW/wcPvrLwGls5Hr6Hp4?=
 =?us-ascii?Q?f7DELv9cFgBeaOVOUnixXc6ZxalC+zvlIlLXRvt1bvfjC/8UBezwEc2OT/6n?=
 =?us-ascii?Q?DE8w6ajjQ2fmtdM9lPSIAneabxcXPIyLQ2LBkS4kgFCKoT80SZxv5ie7NJ3K?=
 =?us-ascii?Q?zygOVdAV0G34YHFOI5lBUKSEmayVLPhSWd4xDTVvuAHpTactm/LWiGp8dLig?=
 =?us-ascii?Q?mlamUwQujYWZ663FvznnVEdnVUZHHPoNkELiWg7SrCBlEmmDYSr1dnJiSIoU?=
 =?us-ascii?Q?wehsGw3nGiBprvQeHVMuJAOU/qi7h0BWv1i0aZgyl1bPxnx68G/Fv9nCz650?=
 =?us-ascii?Q?8KKSMOKsC1/2hWnsKoG4EZDeTGPyFCt5Nfifj40Ld23T2Jcal9AxcWUyKy0x?=
 =?us-ascii?Q?7Pobh15VOhwen0vj4SRiN72y1vsQib5O21U4mAHhysQdWIif63EvIdmSiZDP?=
 =?us-ascii?Q?I91/aw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3187091d-8e91-4f59-5f95-08db798fed4c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:32:07.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLh3DfDJCQxrG/fX6gYAabLUQobDkjLZfuRdh0Fm9aVpKtX21YSG49Xtje7VaQXbf94pbWi4Zz1T227JUhQIjWeoplNNykP2/SuIHD0AUhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6295
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 30, 2023 at 04:29:34PM +0100, David Howells wrote:
> Simon Horman <simon.horman@corigine.com> wrote:
> 
> > But, on a more mundane level, GCC reports that user_page_pipe_buf_ops is
> > (now) unused.  I guess this was the last user, and user_page_pipe_buf_ops
> > can be removed as part of this patch.
> 
> See patch 3.

Thanks, I do see that now.
But as thing stand, bisection is broken.
