Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE273653A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 10:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhDTIAy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 04:00:54 -0400
Received: from mail-eopbgr700073.outbound.protection.outlook.com ([40.107.70.73]:53601
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229475AbhDTIAx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ss7W9dzoLMZ31OKIgMWxxB8meMXr0OVYFS5aEAQRyXnbaGHIVEBLYyI+WBE982TXknYORaOewH9AjsuueXcGvALIqJWX6EzZnxBnmjVsE+gxlKCYlsFuXsWF1/zhDs5NsIxybqpX55yWelVvu0HNYeKtCzTSDouy/1WkLW2l4vJUwDH+caj0YGY5Z80t8b4bSECuirVY9+gXeROYbA9DcVDVCWwnjaCPWflqDSRsnzjLujXeqaUV0NA7+IS+ovDCnsVWL6LyKRjSkZ2AyRJMN0Ie/a7RGCw305N1NeYozObGwHzZfMKsuBYfoSmEo9OSDJywZopDpQd6OAzMFyvt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unetsYrIyBHV0OKTihLJefJBc/6TtEl4DzNzm53Re8g=;
 b=NBpvjvfOtK45ohx3nT/6b+SW4APcZHmceVfxOjKbMmJyykDW6EuKVcIar0DHH98nj4pnjK+KFAv9mflrc4U5rvDcPG5BsB+7ZrjugYngWUxZogCDtdcHns5WZoiPYw+SabOyQRlO4f0owsWgTjw+jDN0SiCcsgZQG0IBq2eVD4hdljFND7R6qLnOy2+n/WqSbNtlK4RUa9GMFk905zzQwINiYTwopL4+q20JyJo0v4TsxfeyfA90hvWTYWAMPsXvyi9jqTMUG6Y4uIuJuVEW3nOKtuYmTSusDxwUNTL79ADgL+iYrIFK6hmFWdagk5LHoURtZ9OLaT0JqUFuPJ2UpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unetsYrIyBHV0OKTihLJefJBc/6TtEl4DzNzm53Re8g=;
 b=juNy+DpihjBx8l8yzE6KV+/pmpvXptrtS1ZbraXuNj+br9hJJigQyBkh9cWyyBJOjgO2kOcH74FGBPjrhfr+kkvxEK+fsKSXKfrdCRETwDjBfZaGyHYgNzxFV5DR3CX3WPIDwMmkSGzZMprmp/GR44UWlDzJnxEf4l53Grqt0YE=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4360.namprd12.prod.outlook.com (2603:10b6:208:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 08:00:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:00:16 +0000
Subject: Re: [PATCH v4] dma-buf: Add DmaBufTotal counter in meminfo
To:     Michal Hocko <mhocko@suse.com>
Cc:     Peter.Enderborg@sony.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sumit.semwal@linaro.org,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
References: <20210417104032.5521-1-peter.enderborg@sony.com>
 <YH10s/7MjxBBsjVL@dhcp22.suse.cz>
 <c3f0da9c-d127-5edf-dd21-50fd5298acef@sony.com>
 <YH2a9YfRBlfNnF+u@dhcp22.suse.cz>
 <23aa041b-0e7c-6f82-5655-836899973d66@sony.com>
 <d70efba0-c63d-b55a-c234-eb6d82ae813f@amd.com>
 <YH2ru642wYfqK5ne@dhcp22.suse.cz>
 <07ed1421-89f8-8845-b254-21730207c185@amd.com>
 <YH59E15ztpTTUKqS@dhcp22.suse.cz>
 <b89c84da-65d2-35df-7249-ea8edc0bee9b@amd.com>
 <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2d0e3c44-832b-f297-90da-e2c3280eff32@amd.com>
Date:   Tue, 20 Apr 2021 10:00:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <YH6GyThr2mPrM6h5@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:3caf:a441:2498:1468]
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:3caf:a441:2498:1468] (2a02:908:1252:fb60:3caf:a441:2498:1468) by FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:49::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Tue, 20 Apr 2021 08:00:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc0dbc15-934c-4e94-c52b-08d903d25533
X-MS-TrafficTypeDiagnostic: MN2PR12MB4360:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4360B74E02FBB3D9E40C509E83489@MN2PR12MB4360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PM1g+5wpo9TfcUJnpIJqb60aGEpbhXorRPb2yCAl8g67eCcsx0xNzXr5rbl3TTXFccriNEUp5psvdMAvGGrvSZ9O0c5c6xCWWI6picDnER0Fs8d1OUIIdWHW7EW80p8Y9WLTPsKLomAQZethUiyifT6mCm9pCPJ/N6A0bxobBhwMZK72x3G6Cc1cirgdSlDewY4sqh8YeaDTGjOzR0ncKSr21zDbRgypz4ZM5Z7tez+YrOn/B7W5UB9CnxgriWqssEVQ5j3z2g/gn30zfv7RmySOXQ4MhHD8IMXMNGPCNDlylmyGqzpMcM4ZX1Tk6jNSxD2qN38a+t03O7CsgL3Dshyz2wXEJbq1Zt34iR64hvnbErc2S2MUgcFsrGsEYVv89S6W3ycl4qnSEgCSqAkTaPeMuYsUCIVXmxkDCCA5t3E1SypVlt2n4bc+zpRO/AEpmIm8j8ZjGjTcFs4alDmg+9GS5twGXId5Jd40+w63h62dreHZHYqNZupXa+1Py3d0X0+PT/hpuQHFGEYjDU0AJpnrpxZ4sVtpKokyR7kDpjx9T1pXdPlwRJsrEqBx0zfz4sdbGrspUC8D4L1wPZM0z/DTqZFJPbX6xMh7ZgyDLkHdDM0Mxjm/bKWme8+W1tyw4YNCA95GhiNI2retvwJZbxdcEJwTcRH+wWdLUJMERS/hKcVRwy7bkVL33weg0Lol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(2906002)(6666004)(316002)(186003)(16526019)(2616005)(8936002)(52116002)(8676002)(5660300002)(66476007)(66946007)(38100700002)(4326008)(66556008)(478600001)(6916009)(31686004)(7416002)(31696002)(86362001)(83380400001)(6486002)(66574015)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OWpzKzlGZitxYXExejZBNGlUT0dqTGt6U2lsNmtIT1N1M1pRTkRVN1dtdG02?=
 =?utf-8?B?aHhJb2NzeDdMZit1UEVrUndxL1Q3VHI3SWJrUjZBZm9kcmloUS9TNXh5MzVR?=
 =?utf-8?B?NXA5aytmbnhlV1V6Zi85K1E1Vld1cjRyNGZqcjE2dEJFTmRzb0xjNjhROUlM?=
 =?utf-8?B?Y2VGRzdEcUxoV0pLSWhqWHFLVWtNc2ZSWmJmdXRpUGlFTFRmYkJVRXM3NXhk?=
 =?utf-8?B?UmR6R09jdE15QThPTGtGVFJjUCtHYW9Fd0F4UmlaelpiRkkvM3dTYVRpdWZ1?=
 =?utf-8?B?ZEFhY3lzemVnRTVPNFVNbGJlbUJWSVFLa1JLUkRyUU4rbDhCRjhDS2J1UmVp?=
 =?utf-8?B?VjdWUTJVbnhxWURwaGYzTHNZYkswaFN5dTdkUU96c3dJNzRpMEJTUGFzV2tH?=
 =?utf-8?B?L0drQk44bUdiaWFzOENlaDkvZ2xGQzhoYlpYOGVVbFUvbko1UjB0VlJxVU9H?=
 =?utf-8?B?QjRWeW53TDQzN1BIcHRNUE93ZGx1dnU4bGd1K0VxN3FmSU5CNXNNZWJLVGpr?=
 =?utf-8?B?MjZrRExqK0JOSWZYcEdrK3YwMGlsZ0N5ZDdaRWhtam5lYldmeTlJblBxbng4?=
 =?utf-8?B?bHUxUCtiZlRJRHphRU1acUpPNVNEcmZvLzFhZHkzMW1oTU0vZXdxZGpKa2dX?=
 =?utf-8?B?KzNSZHpWZklsZEwzUHBiSk8xQnFpRWk0SVBGNWJGaWFqaFFiaE9aSFdleGVS?=
 =?utf-8?B?R2FnZU82RE1xYm1JaDhodGFFckg2Nndpa2I4UWxSNmwxdUpzU3lHd1dKSTBa?=
 =?utf-8?B?Y0U4Y242MVJCMmE5Tk1vYzJ0aVdmcDZhZTR4YlR0bDJzTjZqZk40K1NzYmx6?=
 =?utf-8?B?dTZ4L0pwNkhkekc4L3NmVGpLQitwQzBKa21JcVdUVy9BRlJkZVZYQVN0MUls?=
 =?utf-8?B?Q3QzTlBJc2NBNE9xbVUzdkhZbGZ4N3NSVTljQ29HWGdNcUtBMnU4RURsNUZp?=
 =?utf-8?B?bWxlT1JteEFQUUhRcmtFRUlYckZmOXlrZUFnek14eVVyNDhzNmNxTVRJQlpJ?=
 =?utf-8?B?ZXlmaXhlME1RNzJMQmVEaVlscGZxNkhGZ2dPb3pWaHB3cHZRM25KQmYrSmla?=
 =?utf-8?B?S1R3dDh5bHBodWt0UUsrMjRHNm0vaUlQNlhzNFd1NE5jNldOTGkwM0kxNFhC?=
 =?utf-8?B?R3FBOHBwZndGR1BybGNIb2lTUkFZUkppQUs2QjJWYVhScHNoQ0NpZUZFVS9t?=
 =?utf-8?B?d2xBUHFxTmVhSUhWbVh1SU5UQTBXZXRMUTVQY1RndU9XUzJiRWRLa2tDdU9z?=
 =?utf-8?B?OUZiMUh3OUpvUXJ2RUVkOUZtbHp4ajFrLzMyVmZuRGQydXgyQmFmT2QwUG1m?=
 =?utf-8?B?eGlhTnAzeHB3RlJXcTdBbXJ0Zk5tRWxIODZEWTkxcmduKzFMbTdBRGtEbUZF?=
 =?utf-8?B?cUcxVHJ0MFZOT3ljRm5CTTRtc3ZHNGF3bjhlazltaVo5NWtBTHQ2Q2xBbUhY?=
 =?utf-8?B?N3dmd0hRc3UrTnZuYnlzbWlGZlJtb040QW5rNlJpRlYwMnJycU9aVEVZOEEw?=
 =?utf-8?B?ZG1KbnVjV0w2U2VEREhTU3UvZ0FHbEJCWjhYK2QyekpBNGZlMHJZMy9tNk14?=
 =?utf-8?B?ZTB0b1FBby9wY1EyZmVFeFcwRHhWSTIrbnVxbFFHbnJ5T3Z5TTZHbTlyTEtp?=
 =?utf-8?B?SldRb2NUTHJ0bWMwVVI4WEJYMUg4a1ZYMHBoMkh4T0pBOXo1bmRSNElTTk9x?=
 =?utf-8?B?QkJQcCt0RTBRcDYyR1h0TVI3Qm1pdWRucnl2ZWx5V3NEZE9KM0ZzYTVlOW1E?=
 =?utf-8?B?UlRQVEVzMFB3SEY2THNELzYybFZuWmt3SWdxcmRpUjV3di8xaTVYNERiMkxS?=
 =?utf-8?B?K2huSC9GSnZXcGViV3FWcndWc0F1NnN4TE9lOTkvSWk3TlorUnpZRWdwTyt1?=
 =?utf-8?Q?H8+6hLbfAcMg/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0dbc15-934c-4e94-c52b-08d903d25533
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:00:15.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orxYepxKD6PsS5fJfTqDFCFWa+T8HYSzuFGZgqnKRZ+oc7H7ksk/2POqfseYeCYi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4360
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 20.04.21 um 09:46 schrieb Michal Hocko:
> On Tue 20-04-21 09:32:14, Christian König wrote:
>> Am 20.04.21 um 09:04 schrieb Michal Hocko:
>>> On Mon 19-04-21 18:37:13, Christian König wrote:
>>>> Am 19.04.21 um 18:11 schrieb Michal Hocko:
> [...]
>>> What I am trying to bring up with NUMA side is that the same problem can
>>> happen on per-node basis. Let's say that some user consumes unexpectedly
>>> large amount of dma-buf on a certain node. This can lead to observable
>>> performance impact on anybody on allocating from that node and even
>>> worse cause an OOM for node bound consumers. How do I find out that it
>>> was dma-buf that has caused the problem?
>> Yes, that is the direction my thinking goes as well, but also even further.
>>
>> See DMA-buf is also used to share device local memory between processes as
>> well. In other words VRAM on graphics hardware.
>>
>> On my test system here I have 32GB of system memory and 16GB of VRAM. I can
>> use DMA-buf to allocate that 16GB of VRAM quite easily which then shows up
>> under /proc/meminfo as used memory.
> This is something that would be really interesting in the changelog. I
> mean the expected and extreme memory consumption of this memory. Ideally
> with some hints on what to do when the number is really high (e.g. mount
> debugfs and have a look here and there to check whether this is just too
> many users or an unexpected pattern to be reported).
>
>> But that isn't really system memory at all, it's just allocated device
>> memory.
> OK, that was not really clear to me. So this is not really accounted to
> MemTotal?

It depends. In a lot of embedded systems you only have system memory and 
in this case that value here is indeed really useful.

> If that is really the case then reporting it into the oom
> report is completely pointless and I am not even sure /proc/meminfo is
> the right interface either. It would just add more confusion I am
> afraid.

I kind of agree. As I said a DMA-buf could be backed by system memory or 
device memory.

In the case when it is backed by system memory it does make sense to 
report this in an OOM dump.

But only the exporting driver knows what the DMA-buf handle represents, 
the framework just provides the common ground for inter driver 
communication.

>>> See where I am heading?
>> Yeah, totally. Thanks for pointing this out.
>>
>> Suggestions how to handle that?
> As I've pointed out in previous reply we do have an API to account per
> node memory but now that you have brought up that this is not something
> we account as a regular memory then this doesn't really fit into that
> model. But maybe I am just confused.

Well does that API also has a counter for memory used by device drivers?

If yes then the device driver who exported the DMA-buf should probably 
use that API. If no we might want to create one.

I mean the author of this patch seems to have an use case where this is 
needed and I also see that we have some hole in how we account memory.

Christian.
