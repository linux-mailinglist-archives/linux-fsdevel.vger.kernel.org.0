Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF648D6AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 12:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiAML3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 06:29:34 -0500
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:58688
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbiAML3d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:29:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTpA2aKqy2btyU0HsU4NPb/TDWONyKTfwQwUkD3cEAsIOpTvAI3mZTxCRCvJGw312XoUtSKJrPi5en/EBmCQR8CRgAvJ2me/MLBA4PUh37mxJrpPJfKW/CIRvrvylFikl+fwWJnGePjLnezATaeEC0rokRMHRz/ZulF+HCf34P8XQKZIohRmmUS0YvWQizeW2l0Q5qCwKV9f+H6ai+EC2YBCUJ9ZI8nmXYZyIdD+DPsbKRt36VaQaLjfg2QLloZ+c1gL3cDcS/t+5mqSGjOXllu5jvP57qTN+mcnqoxTfbBbjSTnL67hcaRJmJquiGTC62Tna1+vfFy4WwXClyVJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zQJtQCz1slynjgDpMEJuH+kSbJ1lQtsqF0cyitXh1c=;
 b=nzVQG/SEq4cY/SxRkYgG4na5AIqpeV6JpYW8jFfkDSfGkEFBIWvBasCqF9EQg0DV7Y6a2pDNbam3SFujjtpUUhJrfhcfHG8tK+QmWeQ5nezz/b1hBnvATonoGqLYvga4DiXQSec7JsJ95vN0hgz4BuQrINoSD6CAx9R7jCniPNevuIPEvzGmZeRXbRpUoHe5aKurFQArBEUmklKJ083lm4VQn9j9DVYvzsnaEyRjUJuXfpdNWvcAjoVsEb4vHPdrswgpAL3da7ZMCIdlMAM62xengk7xhGTm0LmsUxEFLX20M5no5k2+VxY5qVv2930VW+pyNvKJRVgBQOzAZf3MoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zQJtQCz1slynjgDpMEJuH+kSbJ1lQtsqF0cyitXh1c=;
 b=mTz4aqatQUv/W0ZarboBvj13KmnTHfricCw+GbnE//MhWWPwu95ljjbVTUXhJNCkUfxORZCGv5woq/4QbY7C8yrX8eACVxDKSFmqXcUJriJV/wNfDp22/ijlMLLASsxcUd62UiJpqJVZpDlBhgNKqWzyxQOiWSjITcSx17P3uKf0PEm0sszU2CAdgdPszT9Oo+PPncllVZtO3wr8DZvLPQJ28+ObJ3Y8v9qagOmK8KB2WQP3wLR657CbpvKaxyqMenbi481qFMWDFuTz1RTSSmbIX33cQEaQwFXAlSlqybihitIb9nsRSYsmfUzf9xIlrdEZwN3kKnOZ+hiOO7VOwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Thu, 13 Jan 2022 11:29:31 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b120:5877:dc4b:1a7e%7]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 11:29:31 +0000
Subject: Re: [PATCH v3 12/13] ext4: switch to the new mount api
To:     Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-13-lczerner@redhat.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <286d36c9-e9ab-b896-e23c-2a95c6385817@nvidia.com>
Date:   Thu, 13 Jan 2022 11:29:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211021114508.21407-13-lczerner@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0149.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::16) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ac075d5-88b3-4e8c-8d28-08d9d687f765
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5460AB9AC5734263BD78C6B8D9539@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dAxuTTAsFmp2JmFeF+zsaoD7kKm1GJsqPxYgf5IsYCNn1M5MU1cZhGt7xkdLz2gWL9sBgGVfBMTWXsjshIkltjC3kQkcysCRg+TSkbLch0HQF8C91QHmzdR3SVe/BlIvkrpTmBo1lhHke0Y6GXl9nOqpTwu3pPtXxbahYIuBmMs6K1i7jhqmK4Q2gp/08SAhL8yBzukmVgOhyBuCMFfrbGTyu0Q2/0ZyfVfqwg9BAqunNEvLWRsRKs3OnI0Ywun0tXiUjx0mNpwPxrmGPhO5M6BhI2N8SNa7SHtesYVO0GdrkItQW67sUpUJf+zLtg1Y8ZtuQmFo+Lu57D0igWtzITLyJofh4m9EsX1XtlAiW/wpUlVVJXEzeUEtz2VLiqy1GjZ1z9xdzJPTTkNO9vyTLyEKDdq2DWk2H8XG2Fel78JDqNfn57hujWFwHoBbjZT77ju9Ioyeu9QIe5wvHChIYMY+ELc2juTpgwEKFL131IiDkkL862jjDXzfby5GyUzXLINTcJjW2F07u1pvR/CdITxu2QNxWwH2TdSJ32FWmBXrYfyICIVZD7clzgE/SMPP74cBoeU4nitrSFyg2+QIFnj3CWrk30ANvbF7dC2f5Y9KrvwzMbq8cnIFl0m39dTVzVlwOzVgcXM73ovZBomsdp3b5L3qQsNlg4xO9pApkXorExoFreCQBbkp8aml94729PoJMt+ElEA8P8KunUVykuiJBJJR9x3C0YeD96JUGkCzprqenn9gNk4ofUwLal7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(66476007)(66556008)(53546011)(4744005)(8676002)(508600001)(6666004)(36756003)(6512007)(186003)(6506007)(31696002)(4326008)(38100700002)(8936002)(86362001)(2906002)(316002)(83380400001)(26005)(55236004)(31686004)(66946007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlRYSFZXZ085emYvTkc4a2xYU1U2YlN2eFBsOFdnaUthQWFFSC8ycVNtbFlt?=
 =?utf-8?B?WU81L2dNdFJzVnUzblh3UkN5M2RDaXlwbWc2TG9DWGphL0U0NzN2Qyt0cXNN?=
 =?utf-8?B?dkNXcldOMUtUcUp1eU1LREpXSVl2UkR6RzYwQkZacTJKWGkybW1oUE5HSHdW?=
 =?utf-8?B?WXVHMjhwdjFZNU12eXZjS1EwTnhJRjlEbU9Ya0NlUDNMd1VuemZ2UjloTk9x?=
 =?utf-8?B?dmhTQW9JSmpTTzBrRE1tdkwzZG5RMm5NaGN6T3VKL2VkUHdxZUVLMFVZMGVX?=
 =?utf-8?B?cXlQb0VXcC9HMHEyQUNwZmc1OE81RkViQkNzUWR4TzVlYmprbkFxYkxSSDA1?=
 =?utf-8?B?ckVGU0hTdWV3ZTA0STF6SEQ5cGN2TVFtellRTHcxQS9tMXBwV0dKejhJTXR0?=
 =?utf-8?B?SjV2clhhNXkzNDh5eEY5clFKQTVQTU51ZUJ3SXlIUHRudXNRcjFDTE9ValJ0?=
 =?utf-8?B?Z1lJS3gwTG5lRWR6Zi9VUFJEMXZ5djNYYmswZDBqRWhKYTJ5ejNNR00ySHNY?=
 =?utf-8?B?cStBWC9VOXRrNVRWR1Nkbm5HR0lCMm5lYW5yTDV3NDJRQmtIZVA2ekJoa2Vp?=
 =?utf-8?B?MGVwZEE3YmpocC90ZlQzbzBEeXUzenVla2xMSGtZdUpMUk9NbE1ISzJPYURG?=
 =?utf-8?B?bXNtRVljaGVBMFg0S1MxV3BmczVRRjhQc05rNVIwQWlMTnAvZDBqL3VGc2Ft?=
 =?utf-8?B?ZDhZbmR4a1d0TEpLMXpvaUhBUXlPQTZXdEdsK0VURG1ib3oxRCsrVU9LWVlz?=
 =?utf-8?B?amNnY3BOaUdzM3NibFVEVTZ1dmowOWtDUVlSL29UVThZKzEyRFNNa1NmOWdt?=
 =?utf-8?B?VEJPWVp6bkRNdlVFdHpxSkpxbERvZEt3TjVveGVTMEZ3Z3JJZ3dZT1g1K0Zi?=
 =?utf-8?B?UVlJTVlaUWREakVTSURtT2hYNDJyaTR1a1pwNE0vOG0veGlSbGxhd3ZFaTFj?=
 =?utf-8?B?Q0tUTG9BZWduZ01BYW5jNjlZNUE4WVdpd0xMejBWWlpaZTI5d0NuVnlIRVk0?=
 =?utf-8?B?RjBwMzREZWdYT2JBckp4aGlUcURzMXdMcmxZTTBadVZ3SEIxMUxNcWJtOUhw?=
 =?utf-8?B?a3l4NTk3SzZSSHRLc3RqeFFXQ09JZXBCTDM5WTdzWkROcXByZmpvSXhaLzZ4?=
 =?utf-8?B?QWxHR2xvTTBnVzNWci93V1k3bHBMOEdXaUZDWjgrWVFtUDJtRVhEbVEzbWc4?=
 =?utf-8?B?YndlYzF2RmpGQ29LNzAraC8ySkwxeC8wV09Sak1wQjVFY0wyWUNHc1dIYnpR?=
 =?utf-8?B?MWZGV3EyNXFwb056eG16UE9HZ3pXbThIQ1hIWURZY21TUGFKMC81MlFLQlYr?=
 =?utf-8?B?MG5BR00zYzZvUTVyZUtRYWJQMHFoNkttL2ZPM0p3ZCtLQWI1L01ZVldEQTNk?=
 =?utf-8?B?cWJEUmc4UkkrUjJaV0VUTUQ4S2NZUDd0Ny8zMGdqTGo3dVc2WUJJeHo4aEdK?=
 =?utf-8?B?RzdGcmtXVHE5NzN4TU9ZamtRQk1obW5UTDN1c3JMUGhuQm1OQVVPbitMZzV3?=
 =?utf-8?B?M2NaVDF0R0VMQ0pmWW9XODNabSsxMGRtVWt5ekdBTjZwK0V5SllHTEFPVHJa?=
 =?utf-8?B?eDFTZnhJNDJtWWVEMmlSVXZoVTZWWGFrUjdKYm90eUREK1RUejR3RzIyUmVT?=
 =?utf-8?B?SXg1dVYwLzNyaW5LOC9SajMvU1pOaDU3TE1YMTdPYnNUTVpxdU9EQWN4VXNa?=
 =?utf-8?B?Y2NueWMzTnQzWFhtZ2pwT1B2Z2RJMm54RjB4MEVhUG4xQ21MNkFJSGhZWmR1?=
 =?utf-8?B?WWt6TmZrOWtwVDQ1V2haUGo3RlQzNVN1VjhEb2NaZ3NoR2t6aW5PYVN5SUlY?=
 =?utf-8?B?cFJiM05SZUtwc1NvTUVwbTc4UEw4RWdkLy9ZYXBPTWZISkw2bDZ5T1o2ZkpE?=
 =?utf-8?B?TWd1MHRFTEMyMk9oZEZGTDR6REt6ZFdFUS9HaWF4eERpY3RZUitqUGlvdmtx?=
 =?utf-8?B?THEzZUxUUTZYdTNra1R6WXZYbHdxRThjUk1GSmxHRXVxTkZtdTBCRTNGd29Z?=
 =?utf-8?B?YjBKVTQzcUpnY3J4b05kWFNmeHdYVmJoNnVLaTBBdGovSEowNmZkcEROVVd4?=
 =?utf-8?B?WktvQnM2Tm14L3o3VjE4cDc4elFvZWlkOTV3VVBxR3RyVk0ralQvT0VSaytK?=
 =?utf-8?B?ZFNBZlNGMWozbVZKd1BXdkJ3Z1JieVh4ZmhTVW9hdkc5OU5HYmJMQWtrY3dW?=
 =?utf-8?Q?dkkGibVkCLa3s1pZeTR15U0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac075d5-88b3-4e8c-8d28-08d9d687f765
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 11:29:31.0598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHo27faIY+V9j8b8vWeUBs1YqX4WAoTYrUVAN5zGDzqAn8xfbZUqhVARMQoMrqvy9sa8OUb1p9xYk6GVcwyfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Lukas,

On 21/10/2021 12:45, Lukas Czerner wrote:
> Add the necessary functions for the fs_context_operations. Convert and
> rename ext4_remount() and ext4_fill_super() to ext4_get_tree() and
> ext4_reconfigure() respectively and switch the ext4 to use the new api.
> 
> One user facing change is the fact that we no longer have access to the
> entire string of mount options provided by mount(2) since the mount api
> does not store it anywhere. As a result we can't print the options to
> the log as we did in the past after the successful mount.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>


I have noticed the following error on -next on various ARM64 platforms 
that we have ...

  ERR KERN /dev/mmcblk1: Can't open blockdev

I have bisected this, to see where this was introduced and bisect is 
pointing to this commit. I have not looked any further so far, but 
wanted to see if you had any ideas/suggestions?

Cheers
Jon

-- 
nvpublic
