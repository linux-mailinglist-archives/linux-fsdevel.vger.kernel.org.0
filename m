Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54E35187B8C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 09:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgCQIvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 04:51:20 -0400
Received: from mail-dm6nam11on2084.outbound.protection.outlook.com ([40.107.223.84]:6220
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgCQIvU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 04:51:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T522SExmIjkhyFivE8yZxHTFvhVhSA4frE/GDHt2xDIxcIThDUr4Te/sZoIT9lbvCC95CDDnR06i7wQdp4mak8UDAHk0XKLM6IIPKon4zjzPTebeZWQfP/qLex27ghEXyYXuhSwkvIzek67AeJAah0KA85A1uQ4lYW2XXpY3EhVesXrLweuRIxzcRWQzYwFElvVcCfDY/VdGieX547Q6xC3xLTnNLnHzJN+6VornsTOCs05fpGcGRTeqm8xIqDi7x3uoHNYQxcX1mu+JWCvwo0MEzzPMh5N4LJ1ze0FmccdCVcOdTtX7mAuIycSNWXsysyvD527w+0YFcGMFCJKqWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WugqhJajJHze7/v3UNlcdp44ts/ljA9OUhriXEl4FQ=;
 b=QNTkoWs7f8Yv3h4uez5D11E/r/1VjmI/fDxhYFgZtsFZQKnnNDdzNh8lJCraSiOgt3Y0wDBtoDkqRY3SNPH8MSQ/1dCxjj0Cedrl3BmViKVkwZjEoK3PyH4gs2RWf/BqfCbXVk+iwPxRpgfLA2FKBRTS2CgomBMl11u8KELP8ACzheEB3T93fkWM3gwWKKdM6RZz16jaSmqxvVq4XkwQOhwawgih/DyrXEyc4hcleYTXfu5Px3VGP58j5/8jE9CzsLoow5Zhy+LcRqEPBNWLy2a5zSH/LmOW9bYEupcP06qMIsRu2MPN+jBaNx/PCOVUKIepwqR1810CnDQdvldfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WugqhJajJHze7/v3UNlcdp44ts/ljA9OUhriXEl4FQ=;
 b=J0YtZAQvH/k+7Wb8TmcxtnrWRxC7Q40PxDEGIwkyS1VOIpVWdxEh5NXvLezeDnJMetIKTwuPHb6x95DKloa4OYuQJQucjTcsa6C2TlW3dmEDqWiRDlvihf1G01VqO74mQE8vhFuD2P5R5gAxKrvMjPsXvgpJzFkp79XzhHwSOJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB2880.namprd11.prod.outlook.com (2603:10b6:805:58::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Tue, 17 Mar
 2020 08:51:18 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 08:51:18 +0000
Subject: Re: disk revalidation updates and OOM
To:     Martin Wilck <mwilck@suse.com>, Christoph Hellwig <hch@lst.de>,
        jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <209f06496c1ef56b52b0ec67c503838e402c8911.camel@suse.com>
 <47735babf2f02ce85e9201df403bf3e1ec5579d6.camel@suse.com>
 <3315bffe-80d2-ca43-9d24-05a827483fce@windriver.com>
 <34bb7fc55efb7231ba51c6e3ff539701d2dbd28a.camel@suse.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <b915a52d-95a2-e2db-8661-e47001b684ee@windriver.com>
Date:   Tue, 17 Mar 2020 16:51:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <34bb7fc55efb7231ba51c6e3ff539701d2dbd28a.camel@suse.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Tue, 17 Mar 2020 08:51:15 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa1a335-470c-492b-499b-08d7ca505bc7
X-MS-TrafficTypeDiagnostic: SN6PR11MB2880:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2880437EFE3D4C7E75AC70FD8FF60@SN6PR11MB2880.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39850400004)(136003)(366004)(199004)(956004)(2616005)(478600001)(6486002)(2906002)(5660300002)(31686004)(7416002)(52116002)(53546011)(8676002)(6706004)(81166006)(8936002)(81156014)(31696002)(86362001)(26005)(66946007)(186003)(16526019)(4744005)(66476007)(6666004)(66556008)(36756003)(110136005)(16576012)(316002)(78286006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB2880;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCGHVyKYzt1LOlxHSu91qAGMhEy11UgioARS2OFHpqthIBoZ4DZBDm3C9qfbDp2N1fYDNPufCsUEVccDdQltJ5ZDOomcfJYzcH1OnBHeErT022EeW9Lcoii2DLhxuicaaKLkDfcVkpzOHmf36SNcWTxPqgje64Vn6wUIbyis0HT/6OhZh6cxysuIohfBq2ujpZUtor5ELUoPXTbwEasTlCG4Bhv7fJmdFqGSUR2gnk6SMDJrXboduw6GdQFIXCQ550uXRGooHZyOZ2LYNiJIUvYWovzGWT6fjm4CVSaDxYPjLeFr2ktpgJbX4e0q6i26yLVJ5UqlnKL/vEI/cYpz7xZlIADFBU6h3iLWLJFj9yh1VAc0EQpxYD0qIEqBiO3StBdiUkuRlfqxsJTrBB/QERTYFIMwSL+2OqprvkvuGO9KAgBv/esAEoNubxNy/2vWGcwRBw3JSRfvP+2TMy2LMyJ75TMpJDWMSBRe7LjBl+gVtjGTUDeaDznU9HZqklHGtVAAKwgHZTFX2A6MvEovJo8GBuAXJYEsvuntAox+qZEosgRGq9utsJq8GJjB/OfVhhHgf073G5RKksQGYK1DWw==
X-MS-Exchange-AntiSpam-MessageData: M6PSU9f7ZI/FuJliPAw6Yp//aDttZAqRvONXXCy44RI5ePhMHdTC0G5mxlhn+bwbp0iQJJt88WC6aaUaAtSq1pzLECYBqUbdQ+OuNN6XN/4coqyHKdgzvLgZEW/F2rN21NmEU7PJBk+zHYI7Y9LcHw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa1a335-470c-492b-499b-08d7ca505bc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 08:51:18.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opF7l+kH5OHuwRd2mHza4nHe0AxZhGyphqOyJIT6jwGfRD2201vfdkA3fYr90bMgM36XC1G7f2QpW1PXPMuc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2880
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/16/20 7:17 PM, Martin Wilck wrote:
> Hello Zhe,
>
> On Mon, 2020-03-16 at 19:02 +0800, He Zhe wrote:
>>> Is it possible that you have the legacy udisksd running, and didn't
>>> disable CD-ROM polling?
>> Thanks for the suggestion, I'll try this ASAP.
> Since this is difficult to reproduce and you said this happens in a VM,
> would you mind uploading the image and qemu settings somewhere, so that
> others could have a look?

Christoph's diff on the other thread has fixed this issue.

Thank you very much.

Zhe

>
> Regards,
> Martin
>
>

