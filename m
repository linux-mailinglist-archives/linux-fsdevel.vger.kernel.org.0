Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8D17D388
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Mar 2020 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHLAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Mar 2020 07:00:37 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:56032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbgCHLAg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Mar 2020 07:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUiKG5YI1j/1X1V7IuE/tOkZrlRh/IEs9SrM9u7FRMBsh6tuQXnH+v6rfGuw8IkgRx7YiOENa1oth0DqWpzUBfzA1+Jpz/ZNdHEkgvOzXozR0+kz8mdAIjU4yyYWKh5Ufm7NQyEGJsVknoKZksMrP1/vyrfaHeRwwj0SGQXzEndHcRpWkXOoKMh0u+TMdFixzHBmuqJ+hA42JqGTYyWEMyjj2wfdvao3P1uKGoY97hZqbX+bLW3mJqH08LId6rd8lmUEfaq+zLdZalrTzKoMFL+BSnrjQM/KXTuQ7IWatLEzAdfjpJncJMrC/rNrxcKsU7EvXEBhX6JLyYrAJvhipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuZG5yLy5hkqrG2+ryYDLstFKB0BZli946FwuMowuk4=;
 b=B8Hbcgtv5gz/Rw9T28wh0tfV6FCaqU6KCgG1MWTvC1rj06hukYK0+gZ5IKxKxOOTG2J59c5RB4PbpOEtGBmyBoM64v/IeFc9jY4cxsvkHtr6PPZ45KZV0rk9n/sO+JIqfcvmGaFEYqcG9DCNTY4OE7dKs91DxLvHS4TaT3QDUpVWJxXbzfxmHcpGvaIjRRon1ChXNcgxpx9/4dD0x6xCouxuG6dz2Q/3a5WIAd8UVuxMAQVoXICB2MVhgrXToklRih17ZNg+ouHunq/KYdzi6qQpr8gu6EHd2Q0SIdvWJmwny5s9Z00gonDcJORmONpGQrvAxtFLLCikIEle2gZ76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuZG5yLy5hkqrG2+ryYDLstFKB0BZli946FwuMowuk4=;
 b=PhS0lJ0+bm8Svz1cB9rhyPwE/dkTHAelrVV8H2YhZ7ApwkMev13hppjjgDtokaR8tn1eb05V6agYnUTEaVFQKdyhGuMEc9Bd8fmBT+oKi4rvNEsk9fmVwrjsxIgxGjjy2/B2F87Z7xOgrxacu0a9pa0Ry+lm3IvBFSrdYga/dzw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3437.namprd11.prod.outlook.com (2603:10b6:805:db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Sun, 8 Mar
 2020 11:00:33 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2772.019; Sun, 8 Mar 2020
 11:00:32 +0000
Subject: Re: disk revalidation updates and OOM
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <20200304133738.GF21048@quack2.suse.cz> <20200304162625.GA11616@lst.de>
 <20200307142950.GA26325@lst.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <071c4f38-df7b-b094-1bd0-436fcdb05767@windriver.com>
Date:   Sun, 8 Mar 2020 19:00:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200307142950.GA26325@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0134.apcprd02.prod.outlook.com (2603:1096:202:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Sun, 8 Mar 2020 11:00:28 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe39727a-faef-42d4-f457-08d7c34fec07
X-MS-TrafficTypeDiagnostic: SN6PR11MB3437:
X-Microsoft-Antispam-PRVS: <SN6PR11MB343709C7D2538599CB7AA9288FE10@SN6PR11MB3437.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03361FCC43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(66556008)(66946007)(31686004)(2906002)(31696002)(8676002)(66476007)(81166006)(498600001)(2616005)(53546011)(16576012)(4326008)(956004)(81156014)(110136005)(6486002)(7416002)(5660300002)(26005)(52116002)(36756003)(16526019)(6666004)(186003)(86362001)(8936002)(4744005)(6706004)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3437;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EMV6psR3ME9wCJHdQH0h+AQczgriakLmBcI1QX/TfLFhemnWM+CoblgJaBSluRhk6B+Tmf+35EHP5E0TBCga4LTYjGuOuyCB8WDqnYaeLRhnEqlEdQ/AUUT5Ut74vhRPCbMZwrWnhb3m5da1ccQh9zFcduHkXdkWc90V/rdtXOrQm8mLa9h4xpbcCzHA4/5+MG7yr72QI8lgwzi7YJD1aUlyoDZlCjkb4lsxxV1chBrq+atOIwzqxBCJTxssw1fW7jDPlTsm27AIsh/ogvLmXtiXOXxc4s0pTZRoMZe38KTZoZJvp5q1ttO2Ho9opcS9VzuHijifPQcvgMzY82qp+moK0jaAcG7nac2xdB+aklaDe9hiMbCgrpSyeIVEOoHTlcH4ekep878xky7Fsb/QwpLpuSXvhjCLP1S0eevZTaOHH4P08IMDmVB3r6P6T+Br5sYQSv50rKuWVAedQ+QDpzYs+Tsky6kk7itBdJ+HCSdKMPwV0XwvOV6lU9VITAJVUXLi0A24wd1HOE1+LC+PMsWogdVu5c+qEoEmEZE3XeE=
X-MS-Exchange-AntiSpam-MessageData: pmnz9DZOeEGRVSefxRD64iFVL9fYPQnmNEHMBZbBVg1/KoyDqG9G5m0V/fvffdS3gBuRkS0ZcfdhpTEvOiR6TDe6x6T4UYoZ/5PAFl5BRzrM1RGfOJUT0Ews9YBs9kYnJpA+cucMZEnhKnENQdi6OA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe39727a-faef-42d4-f457-08d7c34fec07
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2020 11:00:32.7290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ThtOb61jj6gVJ7W+0dHau3OpiBZqArKG4bWjQgsHUgGBemXSqTlwXDInCIcdqEvwREjxhuiydr3tBQJ5UNpvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3437
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/7/20 10:29 PM, Christoph Hellwig wrote:
> So I looked into this, and if it was just the uevent this
> should have been fixed in:
>
> "block: don't send uevent for empty disk when not invalidating"
>
> from Eric Biggers in December.  Does the problem still occur with that
> patch applied?

Yes, it occurs with that patch. The patch that introduces the issue and the one
you mentioned above both went in in v5.5-rc1. I found this issue in v5.5
release.

Thanks,
Zhe


