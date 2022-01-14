Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF6748E7AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jan 2022 10:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiANJk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jan 2022 04:40:29 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:17985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbiANJk2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jan 2022 04:40:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5DFEDsSswtNRslgi+Nt7RbAdf2wAQJw5pLBFAzAxDwjp59cd1x0RGXYB8i3wKvUHaI23WeIYQV+nuOx9VAwyjNoAwZ64TZFqNrMyTwFjSPtkLgrIc/rLSoOixddy5hGtSiRdDwq93IT6a0uHQAkecqaNLUIlyepgYr94r5GYIBPD1QMnQjC4PNmCYR18H5FXKc+gpCfNR1IwmarOdRvs91tMocKoJtqVjhIRDQY94umNoGBDWmOzpzYdObWywsEjyPrDW0HUjkT/Z7ZUXEuieCyHHN9LUAERA1wITX4/ZObapctH4hHnVxf702m1ni4tUIpkyThY5ZNfqc1oGIwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJsh1GHG8Y0rSzleOsDiY978kXJGT7wzcc2NDiow/os=;
 b=T4WZAIAMKtnyERk7rKezE2rcENCi1aNRGIJKZ4BeOkjKdp6qNmZVSaeoKc8LL/rFkTehst2y5/z8U9ExtA1+6RsWkdi31HXMTGA8gSi3I5jygqrXXMrPJcBssdvl+PtL7jX74DNDcR2gl1ARdrVQZ0Pcj4LUnGwOo/Ftq7G5idwF7S3gEtSZhRoWncFs4IbJzYKWo2CqENeNer941TD4OQiQSSUKJv7RXKCoAKoYLk3A2xEWoe7x0U+Occ7Kf+wnpwbItW+gdrDG/1vVQnVFi2rVHgM8UWkl0GoYBMh0AKw1Fja/OXOOPp3LENapee8pQKyPGM/opLWQXtgdnM+UeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJsh1GHG8Y0rSzleOsDiY978kXJGT7wzcc2NDiow/os=;
 b=R/MQNFYiBoNYoGdlZs3Uoxo43q96MWtksq+6Q+Z20amduFX3es1zhZXLvj7+b2DmlPvsSHki/hfA35dV4DIzNuAPeZ28OETy8j6iGLKLfbXsVZ2UPl35rsvd99n7Y+nYkiVlqj4SmQied1e7RyKiXrJN5pGuYnJd/Bq66YBPb03BRbs0ltqs4Ai0e2vqLV7V3bcF3fPBWyfFP3vK+AujKlZAnOXIFdpZm5u4ZG13fBnI7KjyoWDN0dcCyBjgTCYs4qLQo7XEOgfbjeyTuxYXGmaOXmlanD4DRjxwo4ylj/zpV8OwFKdbHW0wiiy5EorOvfHq/175pUSCyLsX/6Vi9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 09:40:26 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 09:40:26 +0000
Subject: Re: [PATCH v3 12/13] ext4: switch to the new mount api
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-13-lczerner@redhat.com>
 <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
 <20220113120807.xlyg4wmbbhajuftu@work>
 <0535c04a-db7c-fa10-149e-91110eb18804@nvidia.com>
 <afa501e4-802d-e8a2-4272-4b67572c6d14@nvidia.com>
Message-ID: <2d22b1b7-0091-260a-b86e-ad55a26e320e@nvidia.com>
Date:   Fri, 14 Jan 2022 09:40:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <afa501e4-802d-e8a2-4272-4b67572c6d14@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0202CA0002.eurprd02.prod.outlook.com
 (2603:10a6:200:89::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f260c436-bd03-4a61-3c6f-08d9d741e501
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203EF5E9BF4B1A35C7D2266D9549@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/dQPik6Bvwe0MScDoLlJ6AHfaLDL/FahhaSg1xQcaKgeK3YT3SfSxLdVmryNeCdXzjQV4cJYZHY54O9xrgbGUzn/rWfsiVFTGVAvwHXrLTrukdiuZ4++TKGkSyQD8fLS56gItkuBW2CF7t+CSJl4TC1iIbKc2qXmrRadbJ9ZyR3iyQoF9pTXkEmQwAnQmGtjph9V8tmt69Fxz1jE/t1+gt8EkP9GwJG4dJd6hYA+IXz0lsw5Tm74TUSOo0mHxHSu299nbrlvybMTKd1gYPpEcABJNDe/iXxXAm5H+867BHVE8rnkW7dZ7PaYUmjWYB3vM0dEWiT0TFbvE5StXObaSKoeW4a1CMaIfE4TefCDcO3MIcu+rpjZn4/Jmk/u78biOntoB1xjclwE+EKmzZLuSNmBj9LR/1f3mvN5yE2ccKPgVfR/O64Q5GvCvfCM8O51h7AuNh3z2tkXoE36t6mm8072uwi9Vu51smuXn/OxxYxdqa73VUUI5LD4C8QPwn2x+xjMwg4qPO381pVCpq5vR5leYb+qR6kaprVNbAzrC/4yLcylly8lscPUP5tighHxvvPIH9jYL6s8CQbIsCz2PkDm2fzMQBHlCrwe9K88ptThH68fUEEtE1S1YPdBeSS/trnIDQL0F2rUNu8odgT3KyrktuGiBH+zSg81BHu+3GQtiIpeMrRmFL2n9dSwkLfRCNKqjGhBOpQ355n70biUf0vIPu38Ig90JdRa8ZzaQSffbj+9wpVZvmuEnxxoFba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8676002)(53546011)(38100700002)(36756003)(66946007)(55236004)(2616005)(83380400001)(8936002)(26005)(6666004)(4326008)(6512007)(5660300002)(6486002)(186003)(316002)(66556008)(6916009)(6506007)(31686004)(508600001)(2906002)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1dJZnQvS0VMdUh2K2w3UHVuWUJ4dWVLOExraHVkOHQzbXpkaGtaUHVtUW5t?=
 =?utf-8?B?dmdZb1NvQzBTaVNxczJDMlhWNmR2cEljUDlZYTFDL2VPcUk0d1BsZGpkQi9s?=
 =?utf-8?B?VVlMOVJweDU2c2YxYU1WTXlXdlYzckM1Q3pDS1ZxSWRQVkY4d3Qyclc0UENv?=
 =?utf-8?B?cGFqYm1ZTVpVRWhTb1hTVUZSVUpESW9sOTVFcUxuY1FwQlllR3grNjF0eUx2?=
 =?utf-8?B?L3R3WVlHWEZvRjlFbHFZN0pnQ0VtWWhUMTZweTJ6UWtiaEExZ00xbFgraEFF?=
 =?utf-8?B?L0lCSXE5NFNlU1I5SzFSTkgrZ0JCM1l3RmFLQi81Z0h3ZittUHhySUZRZjkv?=
 =?utf-8?B?d2FnZCtzWGNSditFbWlOK2ErOUZ2MmRsSmNLRHRJMWRSOWtFTkNwRk1oNFVv?=
 =?utf-8?B?ZUFhSyswOVRaeHkrNzQrSldlQ1RoNjVIdG9LK29KWE10eUxOdmlXU3BoS2tk?=
 =?utf-8?B?UFduWnNra2hqK1dNemxjVjJTcTJWeUlRZjNWVGRDQnlXYjRNNkpKeEYyaTVi?=
 =?utf-8?B?c3lVcXNlSzR3bHdjUUs3RndpOTVoNndzemhCMnJwd3dyQloyekd4bXRxSkFq?=
 =?utf-8?B?MkQ1ekJveTNCZjdSdXdIaTNERHhjVXRabEQwUVhRbHlvWFVVcmVGYXlDUEN1?=
 =?utf-8?B?YVpxazZXT1g5VHliVHlSVTFPaUx2NVJmcmthQ1NDbWhaZ1l2QVIvTzdhbzI5?=
 =?utf-8?B?TFVnbDRsdzRpSUYzOUU2V2tnZ2pTT1JBNDIrUG9VNVQvMXZsbXZoZDNVWU9m?=
 =?utf-8?B?T1ZOeGh5OHp6ZFd4STAvSWJoWVRKREx3MkEwQjM0a0RFdzJjZEVmcFQ3NGY1?=
 =?utf-8?B?SXN4QnhKQ3NYV0xMRFlCVTNqYnA1dGk3N1p2V1BSNCtOSjAraFE4QjFqbVJv?=
 =?utf-8?B?YUFyV0pTTlBTaSt4TUVZSEpOcis1aXc5aFpwMlJQblhLY3FQUnNhdFErR3lK?=
 =?utf-8?B?RHFjWXdZYlp1N053L3g5MXBsaDdtZ0paSUU2RzlPNk1BOFBmQ1ZWa3o0b2o4?=
 =?utf-8?B?N1R2cEJzVlIvRHZxa2lmc3BXVVlkZU5zQTNsWlBoeDlFM21OUmNFWU91SHlu?=
 =?utf-8?B?SDdqcVFjaVVFUkkxOUZHdldVTkxLVWxGNWx1SmM1RG5VOE55d0RNdFliNWpr?=
 =?utf-8?B?TmUramdqNzZ5Q0YxSktQdU9GMUQ5QlU5SnRSdXpIQ2JQdXRaSVdVamNUUlY3?=
 =?utf-8?B?THlXN1VQSmw4endOUnFudTg0MkFpTWtKZE9kT0tKWVF3SVpNR0JVNGpaeGZ2?=
 =?utf-8?B?MTBhYWhDQnc3d2JkZElTOHlIbm1sZXBFWGR3SkJaOHp0eklySVptRVR1Mlkz?=
 =?utf-8?B?RUJSRDJhUU5XaG4rTWErSkJXalYrZ2JnVStnZytCRksxckR4cFZVQ0RjSnI2?=
 =?utf-8?B?RXFRN0lwcnJQSFE4Q3dxdTYrSHFUQUxWU05GVFVud0lhWGxkaExoSERzUUcy?=
 =?utf-8?B?WGRXNE1pbEhUbUFYZ2xrOW5zSkp0MWNzRmpmc0Y1TWFoeTBFN1A5Wm4xT3FM?=
 =?utf-8?B?MnpkRllqd2F0c2lEV2VzZ2RCRnBpTUdWb0lhcTNWYzVydXFyVlhZQlBRYmdz?=
 =?utf-8?B?QXFKT29xOW42VDZGbEhoRnZtMXBTaUFFY0VnZ2l6WVpNbnozNzdFcXU3M0hO?=
 =?utf-8?B?RGFMMmtBMmVVcEhueFdTRm9OK201T1AxTnE1NTgyT1lTdnQwM2N1b1BoSlZk?=
 =?utf-8?B?YWpNQmhQK1BTQ29YQzVDOGRiZkQ3c1k1a24vVG5wdHVhZUdKakNsd3ZoaE8w?=
 =?utf-8?B?VW9uSzFkZjBCS2p3ZjM0RHBGQ1haSGN0ZUlpcERwR2R0K085OUllOGIzV2p2?=
 =?utf-8?B?R2EyNWdLRjZPTzdESXB4dU9nalRVSFprK0h5STg2WFpVbXBjbzhuTTI5cXRQ?=
 =?utf-8?B?cTBISGpWYURpSGFzajBFWVZ5MHo1NHQwL3liTmlicE1UZGR4R0pIWHhKalJ1?=
 =?utf-8?B?NjVVbzJiazlKU1BoWkZCRC9UNUxwK0ZDYU9PdXNKbjQyN1NyMlRNR2hHUm96?=
 =?utf-8?B?NmhOT0NPK0hLUDFYSzc4VmxLN2ZmeUlHTFRBWWJNV3lFRk54akpTVUFZcFND?=
 =?utf-8?B?UU9TRzdOdy9WTzB2WFpaallWaG5NY1pDVkFQWXkyMU5RaWxLZUQ3bTdoWDlh?=
 =?utf-8?B?a1p1aDFSODY4aUprbjR6eUYvTlZYNW9lRmwwS2NGNHR0Y3VQK0NlSnd3M081?=
 =?utf-8?Q?u4OAC9pK8DC2fojaGjyeSbk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f260c436-bd03-4a61-3c6f-08d9d741e501
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 09:40:26.5638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELy8PmWR7Uc5vQ7OOoVX+oiVTPPvUch59J32H0EU5G5+/R9p6B0aS2oMbrxIJJnNv5w1+T0VHO7JYPrLGuNCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 13/01/2022 16:10, Jon Hunter wrote:

...

> OK, I see what is happening. It appears that our test harness always 
> tries to mount a device called /dev/mmcblk1. Prior to this change there 
> was not kernel error generated and looking at the logs I would see ...
> 
> mount: /mnt: special device /dev/mmcblk1 does not exist.
> 
> Following this change, now a kernel warning is generated and I see ...
> 
> [  137.078994] /dev/mmcblk1: Can't open blockdev
> mount: /mnt: special device /dev/mmcblk1 does not exist.
> 
> So there is a change in behaviour but at the same time the error looks 
> correct. So sorry for the false-positive.


Looking some more, previously, mount_bdev was being called and this has ...

         bdev = blkdev_get_by_path(dev_name, mode, fs_type);
         if (IS_ERR(bdev))
                 return ERR_CAST(bdev);

And now we are calling get_tree_bdev() and this has ...

         bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type);
         if (IS_ERR(bdev)) {
                 errorf(fc, "%s: Can't open blockdev", fc->source);
                 return PTR_ERR(bdev);
         }

Hence, the difference. I was interested to know what had changed.

Cheers
Jon

-- 
nvpublic
