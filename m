Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB28743CF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 15:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjF3No5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 09:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjF3Nor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:44:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2121.outbound.protection.outlook.com [40.107.212.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554C1FFA;
        Fri, 30 Jun 2023 06:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moRPJTKc2Y5cilVUFPCI0P003aIO+UZQlseZYuxTuFDrQ+pZkjTM+46BbMs31RHPRUvvUpieeIxD1H/jQQU2mzXrOfWHtLF7PmLtfYEpgQxKuStXs8s4HlPJKuYhk4dT3dyF7lFd6rr1HZEPKUYwvxaG49OZME5xN6CCjIWc6IhZHt4zVnQkWXWt9Gp91OJLPKUhEZgB2KJ/xC5R1kFp9yK4NhGpE+lUiU+PhWNQugkpooklGTOvavY/7ONYDndHkiR1SKWyUtXAzBdV0yNUagnMo8MUoxjOltTtDg4q1Cw7yodQFp9wBc5jB6Vp5jiEA8Kgol7Nnf90qdwniXxPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eTX4hL4GyCgk/o8nU8+Gn3ArxGCsGFeKt+5FkHsSTg=;
 b=i+1iMTAuNeXaMHao/xEJUivQ2PTCjRBP7oWK8G2/5yIgGIeHhJCAQVmOsmwvgZW9pEQ08j7jqRcep1BLpp4qPVbBCO6N/K+a63Wgmem18WzQCU0pgNr95R0iLmbwhGxSbDGYgzctJEeUCV4HDvsV09g6Pq8BwQZTYlCUY0llNiMlJw7OrRDnITHbKDx68xvzarEy73yzwnUQeHeDQao/7kAcCf5+D3u2F2X4fjyadQVMbzce+ZIf5catbSs98N27xhyakMZd1N2+uS8GWaj9MBNMuttomoDv71D/KC2gNCk4uE5e8vWZ+q+O95JpmZPXCL7ovKWBeCYHTjoWljI07A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eTX4hL4GyCgk/o8nU8+Gn3ArxGCsGFeKt+5FkHsSTg=;
 b=ArqQR/sgvoJiHuey72JCDrU4bDD4b2TmQgorYuwpskuX81Mbw6bbh05Ig3lBOrBpMRQJU2T3snCaMZl2uwpRPiTTyyC4M3lOqYU47wFBw2pzzwHi+3BvhQd8pLT6O5dOQ9v3YybtlYnz1duCKubK3yXMZTKAcTkbmkOVdWDHb2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA1PR13MB4928.namprd13.prod.outlook.com (2603:10b6:806:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 13:44:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:44:42 +0000
Date:   Fri, 30 Jun 2023 15:44:35 +0200
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
Message-ID: <ZJ7cQ8Wdiyb0Ax/r@corigine.com>
References: <20230629155433.4170837-1-dhowells@redhat.com>
 <20230629155433.4170837-3-dhowells@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629155433.4170837-3-dhowells@redhat.com>
X-ClientProxiedBy: AS4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::14) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA1PR13MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa56558-d481-4b48-02ab-08db7970281e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1UYuAtM531XHWg+6oIV5iUg5QqVzqpeIh5KDCsLfLjVEDz5ZvSamvxwQqYeBJZsWrQciC2Urp8rH+457Wp4lQmAiEdU/TzbCncgHBOAliorpFmQMThHWHuGKhnLQu3e++ZC6j1otpJXeCEJpYbvHjRh1CG2u4MhvZ0QvfL3r6TCsePdACYINA/dSOrbF/dMy2P7P6mAJnd7xN+Xz5DggK+rNuU6eHUojk76lsRPETPQsfD/RHMIOwB8XWtyVTKWYgLydPBKuCR92V7xy7Z6XtQirkZgmdQxPO8YDa8mKntEVr8zC0OVEOKcYYZCtZxVoioWniRwZ7/mYw6QWp7zSentqVQi87VWt6GFWbnlVMo3ZXI9hFemX3TTn2UUTXL42oMrOUuhO8UaH1Ggjpx36pq1DEfphsKB/fn8GgGK8aeRndSJoY4BuPNi6XQyPvUo95dkgfMXXOGDHwjHsdxCNC7Qb/JpwNY/aSufrwVIWLkoIqa/mrJG25zF2TSlzhacKA48IfmfzQKoL51KJcz0HfCRregBYr85dkgqC2XHaX84zqEwIlWWF4tIbBW9PPAVI95tROp9x6wq6mOyX8BnOYs84K3xwNN7xnlu/8YeOkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(39840400004)(136003)(451199021)(86362001)(54906003)(8936002)(8676002)(5660300002)(7416002)(6506007)(44832011)(6486002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(4744005)(36756003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yB1nDa6TZUSPqz1oO9nhTLUQWpcxjubFKuJEHxi3CPFfuxdH0VM2RthzdRob?=
 =?us-ascii?Q?r2daUWJCmuwZxjQAB3/S+zN9Kq/yEQU7fNOJPT1Ba5AfQV+TbTkoXvFEOY1q?=
 =?us-ascii?Q?Uo54OGSLJFjr1sqNfWQxR6SufE23TYwHqshHCZ4j0844S8qaq28rzqvT0XZs?=
 =?us-ascii?Q?DfYpWsLkBhlXCUTfHu6xa+p1rbnbb/2C6Tgo1zeMrdVqeLVuolkWaNv4znXa?=
 =?us-ascii?Q?qsySnUpAKuW5EQpJuPgVXVIsblZvysoWUe0CzEb0Y5fXsOJW1iJBYCdQ37bf?=
 =?us-ascii?Q?8Km6TGmIqEmwg1nzVUnSZg78GI+sofV5pfMoK2FCWRF6q/c4C5i4ntqgAZaH?=
 =?us-ascii?Q?+IuO/KUiivGfFA8Zte0ZyPo9tInLibZ9SAgNzejGUEABZrMHl8qwk+YdxIz2?=
 =?us-ascii?Q?YDVkjZtzpvizXCrkHk8hTfYMngW5dJf9Qf6TP7pS1rV7xQNFxSjUXFUmxTJA?=
 =?us-ascii?Q?Vj8n6Dsh5kbtuU2oKLV6Lf8L6y1r64A1UvUHccvCzcc7Il/dxroZrJW0fqO1?=
 =?us-ascii?Q?9JkhxZQaEhL7goEC2f5TTMl5+q8kkHLe7Ho9E0zYjNpm3LvpNjkyHOppkNue?=
 =?us-ascii?Q?xnR6CJ7a9JKvlst3ow4A9PSGWF2Bfc96zZGqwJU7SSMpVwRmOS/pmGbJNDv4?=
 =?us-ascii?Q?E5B2/DND7hEDJ7hpVhBfbaRS3CsuZNAaUauMxfvDxOBGUbN6BLWwmc9TEjvn?=
 =?us-ascii?Q?LwfK2iNc11p8QFmFsL4m0dVuhNhz/IKMVnXhfozHa+cDP0jm2fJ0ZiSktufO?=
 =?us-ascii?Q?L8y2JAaiGRZUfFncdcL8OGwjKS6L3jg9dFl2J1RYFhbbXa3VIeyPCxfwQpyG?=
 =?us-ascii?Q?CsvF3/gYkMO73bDNWJvY2j4a7AxOrcoPRIDh86JYHxu54Svob5yGhf1aSm/2?=
 =?us-ascii?Q?2KyxK7tJh/EGRPVyYrpgZ5QzxyCjaDhUjlZD6AiwzxJFzNKmjp2PzUAT/yH+?=
 =?us-ascii?Q?Wmw75xD03zbP29SBy7Ft00agu2dDCAQwVf/nRAmsM/lN0emxkAnd3syxTa7K?=
 =?us-ascii?Q?vM8GivHcY05F0FrEi929gt+hXNHGjcFm1S71LVhZNFKI5wn+uliDsXg3Rxps?=
 =?us-ascii?Q?WG7dWAyHDe3pgK0kRvDAaUJx/2uKQeQtfzI9b1fdVybtEvftzors890KhN4d?=
 =?us-ascii?Q?/+ZNZzjOON4zE0cDUvirXJs8W8h+g0qH1piZXsTGYzQHK/bAHFE3D6jeD8wk?=
 =?us-ascii?Q?nlyE9aI7Ut0AjtNIIB+rgApifPD/ozNPY9hHsl8HGfD3dxNBGJMG101YZCIe?=
 =?us-ascii?Q?0zrEZaEwQyNmDLgiskJ8Yb7OGy4rL2iC0G9A989IsjlzKfOFldkzJ1xKdRXs?=
 =?us-ascii?Q?Ja2qH5SCZPiPQkM4oA4IxusfsAkb4EV47zP8pChb+x0h1jZwX1VneWLkL4yo?=
 =?us-ascii?Q?uM83ubPniCEhfeWzpne//IX0dOqs4N7hsEwX2x0aKZY0wSP5AoYl5hmkAqpW?=
 =?us-ascii?Q?8vTyfBUYZ6NoiIVGK6GUWZQFgfEHYZAdfnVOAurp3a1Oh++JOEhcztzQDHKT?=
 =?us-ascii?Q?TIFYvZYIRm2VP0Uj2aTx7B/N9NNgiikWYWd5FLaH1M15R+wuzSaZ4DdywMiC?=
 =?us-ascii?Q?a8CuKr75rP/VvtOYIq1hv+J+7jkP2225jw2z7NRT2dzQ1IO0NrFdDGD4V9cj?=
 =?us-ascii?Q?AxbeD5HE8KR2apdmlIz4PiW6xb98BYdhTZlihULuCiG805HBE8ntEjOPEGuS?=
 =?us-ascii?Q?uUqCjw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa56558-d481-4b48-02ab-08db7970281e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:44:42.1473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue+Nby+rVc2c45BHGOs48EegBC6amvgSgBU9WFoyLO+D2zfiSXxjWmDVLy7ntAwKYqsGIKfldPNptnl+NWYGcFgOPnWct+Y4yvfs1pnxL7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR13MB4928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:54:31PM +0100, David Howells wrote:

...

>  static int iter_to_pipe(struct iov_iter *from,
>  			struct pipe_inode_info *pipe,
>  			unsigned flags)
>  {
> -	struct pipe_buffer buf = {
> -		.ops = &user_page_pipe_buf_ops,

Hi David,

perhaps this patchset will change somewhat based on discussion
elsewhere in this thread.

But, on a more mundane level, GCC reports that user_page_pipe_buf_ops is
(now) unused.  I guess this was the last user, and user_page_pipe_buf_ops
can be removed as part of this patch.

...
