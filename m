Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17521869A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 12:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgCPLBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 07:01:23 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:29376
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730529AbgCPLBX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yic8bWbd6r4KWu6mcklpARP26qccSQV6C9qM2R+GTsYSqU5s5L5fUm0D135dxu7fqPlD/kcELrahms+zN+lk8iycDSruAnaSMWZdpjDMopYakOLunoqToX/Sy5afJO46CELcIQkSNAQM/74PbcJvdgxVPApvfBQfjViaIeMOlcFniOuvE66B7qcg7Jm0Qg+ppGJG038JeiUM0HHzXN/fTGn78hUkt4jD3NMICFHd9fpLypuVDb7G1nOmnvW5IdR3m6Zqdgj57mscA4VjS3DDwhnTnfWUhEqSqrSerShKzBkTfOURxyxplGMn6vrR4RiMzT/gr8HMW2iqTamRPvC9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSGvJbXM33xPSnnkeaBqQ1Ol9q4oCZWy3ZPh3UQmYF0=;
 b=Fy6iQ0OhdjQYFV+0F1Sawqjah7tq4iRgcEjuLzJeUrGFMqcKaBCJWSkzGr8nQ6stfavLAUTpahzYi7yfwMM7heGygWyjdQe4nSZSF5dEAkRymzLadYgtZwjnw2PeJHPxtd0tLPRqz9oNUvaeb+rmZgYuPjsQawzZc9p37YKzEmOev20ftrFjYbXY+lDvq16DHjSQ3s2eSwWk/Kpf1iKsK0AzhzSHbcRUUS4w3xx+vJwnJHDcRo4yZ1jitm6b/6MZhea3U/Jo91BaxqB97CH6sj9gCKiBCd2Nm7iE2Rn4Z5AQb5BTuKUD3An5rn26LrUN6eATENYD8x615ibn722/Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSGvJbXM33xPSnnkeaBqQ1Ol9q4oCZWy3ZPh3UQmYF0=;
 b=hLFzca+6/IhVV15WDSwQgzE7WtwjHohomWxAiedOcPGXvZOgdLuuI4WkzioubVxodD4G+IlbNaKcaFHF4rOnkR3rdsHheAtLDvNGS3VeyexhMe79UW6GdhLT4stAXZhWMvTj/la3Wvd3iVSkaO+AbbIUWzFnXz1JT1JSWAVZ98Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3504.namprd11.prod.outlook.com (2603:10b6:805:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 16 Mar
 2020 11:01:19 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 11:01:19 +0000
Subject: Re: disk revalidation updates and OOM
To:     Christoph Hellwig <hch@lst.de>
Cc:     jack@suse.cz, Jens Axboe <axboe@kernel.dk>,
        viro@zeniv.linux.org.uk, bvanassche@acm.org, keith.busch@intel.com,
        tglx@linutronix.de, mwilck@suse.com, yuyufen@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com>
 <20200310074018.GB26381@lst.de>
 <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com>
 <20200310162647.GA6361@lst.de>
 <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com>
 <20200311155458.GA24376@lst.de>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <18bbb6cd-578e-5ead-f2cd-a8a01db17e29@windriver.com>
Date:   Mon, 16 Mar 2020 19:01:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200311155458.GA24376@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0146.apcprd02.prod.outlook.com
 (2603:1096:202:16::30) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0146.apcprd02.prod.outlook.com (2603:1096:202:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 11:01:15 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d904ece3-2459-439c-ba3c-08d7c9995b3f
X-MS-TrafficTypeDiagnostic: SN6PR11MB3504:
X-Microsoft-Antispam-PRVS: <SN6PR11MB350484B8EEDE2CB87907CA4E8FF90@SN6PR11MB3504.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39850400004)(396003)(199004)(31686004)(4326008)(36756003)(6666004)(7416002)(478600001)(186003)(5660300002)(16526019)(2906002)(6486002)(16576012)(316002)(8676002)(26005)(81166006)(6706004)(81156014)(53546011)(2616005)(66946007)(66476007)(66556008)(86362001)(8936002)(31696002)(52116002)(6916009)(956004)(78286006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3504;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eBmOEcDepPr3tU3FnqpbpCAyXpOHgr9r0W8J5Qo6vc3+ycCbdCKsVV8Nxc9P34BhwnngYM6Tfoe8wIhbxRvrMp7BKScnBh7zaMFwRSZTqk4TP0WH7V5JJprJ+N9/xYyQfUGL3BfEQpEW8mEHPhKeAslctifdzBy+rOiG+zxS69lJHougzyWCDGF/hi9JpazMX58h4KC5PiwpY+AW4Fo64kjvPXYpIT+EWFNKAYJFgN6ZsXoJoQIPrVYFJnPKXXH0kGOkDNLzIaKGn1+MCZCV4wWh2B9ai1CEx/+6l4D1Elak1dsZngfIUWhp0l1Zpm6LWs5Djq3/I6d4BXdWSXRI5g1UI5HuMr9wQ1U4YJU/CC11WfiLT8OO3VGqyijzmZ4oIZyvhSG0UXbGY8k9DKNN2G5PcVRRWsjX0oUbA37vWzEcVXoCrbcVbY2qCNjismuC7Hy2XBaT4T8PEtNlcmq1Ljp3W5Ld6IiOgOpMl+0vvIwqv2EBRRC5BietA0/E2g3kVoHwI+uFGNcX4ViX/wumsjsgIVRaI+LRl3OjIf6uDoI=
X-MS-Exchange-AntiSpam-MessageData: AD3zQnz9QSrZUDzL+8Oyc5goDOgeP6J1GlSdpWeC4fCDldtM8kiLEvTmBckJ4qQ6D08qy7FOYpsrZOmisjxqXEvGB+NXnDut8jCD8kybYVJx0wdy5MTnwdW0fed9ZTDgHJBKFN5g6FDkoX1N5lU+fA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d904ece3-2459-439c-ba3c-08d7c9995b3f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 11:01:19.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvXwwcoyfs8EhRtIMSvg4teBwbDSXqfbNFnTaA2B8pZaJhomavJzqIEWtcZZ6OdcRqxp8dUp4osq8rN+kGVkig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3504
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/11/20 11:54 PM, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 12:03:43PM +0800, He Zhe wrote:
>>>> 979c690d block: move clearing bd_invalidated into check_disk_size_change
>>>> f0b870d block: remove (__)blkdev_reread_part as an exported API
>>>> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
>>>> a1548b6 block: move rescan_partitions to fs/block_dev.c
>>> Just to make sure we are on the same page:  if you revert all four it
>>> works, if you rever all but
>>>
>>> a1548b6 block: move rescan_partitions to fs/block_dev.c
>>>
>>> it doesn't?
>> After reverting 142fe8f, rescan_partitions would be called in block/ioctl.c
>> and cause a build failure. So I need to also revert a1548b6 to provide
>> rescan_partitions.
>>
>> OR if I manually add the following diff instead of reverting a1548b6, then yes,
>> it works too.
> Ok, so 142fe8f is good except for the build failure.
>
> Do 142fe8f and 979c690d work with the build fix applied? (f0b870d
> shouldn't be interesting for this case).

Sorry for slow reply.

With my build fix applied, the issue is triggered since 142fe8f.
And I can see the endless loop of invalidate and revalidate...

Zhe
