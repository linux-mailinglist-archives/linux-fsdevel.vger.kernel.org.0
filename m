Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBEF70BF93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjEVNWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjEVNWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:22:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E3CB7;
        Mon, 22 May 2023 06:22:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbSYU/+FramAK9dzYR62EB4nIl6NCM+sj9un+7SPRPxMxDTCajpxlxgMyMlCCIFbYiwLBfTMTCdZXfeOimbtywnTYZxANngMBi97Qi1CWqgN9AxOTaW1PT9oSqpD5IhEAnvXh5cu9WTPLYzJwTq+xlbKkLT74uOZRVqdcPC3glaAzqZS66aW8Dp3wTZYAmLJ0oXMN5qJiw5jonL+dsMiQXX+Y8WYqrXQ03Njd5rvDQpeJsfPUsbMqo2WLT55/UVoQGpQCSPkBV2tG8frBusBV3okET7rFeguJvo0hlzjU/VfuWgxvSkysJAMBQGMI0KeBtKrJDwVS/NgMs0EfKtx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+mTYWvUoXssUEs/BweIB9jrM/rR7G5env8HfTLIdO0=;
 b=UXtUM1xm9PXlAsQI7aNmUS2A+a1R6bod3zEGvQjtpnKOQ0B7liN+1WpRTx5/FN7FTnMmzkHBZDOCwOPheo4t7OQPU3ALtsAcFqIP991aGIRASaY1BYmQZI2AMDDKWRMQxQcMzuJmVEnEFmP7AiEJeAu3gS8EMhS0H8YyAwsJ27PVfJ42m2ARoPxvMsAhiYdc7TA/9kY6hzEMmXbPYNlhfGuEacCSj1HGjQ1x6z8wFUMMtRnJutXhU/q8cCdu0hnYyzKE74EfzipriFDydrLgb1kN7jk4K5Jw8KUa1wgCeeDATmn8xdD+Frxr9BFDAFhSKCARgnNb54fPmseAVCd3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+mTYWvUoXssUEs/BweIB9jrM/rR7G5env8HfTLIdO0=;
 b=TjpSSv40qt4t0LpNceoKXNgJjGIL0BBvNUNp5ShX8tSbq7ga67+0hFo24GySfyxL6T9oGEcdF+DuAGnKa1fX2K9Ww08uIhyEXFwarEodMuSVWV4mNM5XBfL8c5OepAlDeTYC7kb9RqPuM80seSZ+9jpwL4dDKW96W2zpaWiWmc9fHf7shFpMkdyr0EviH05jszPVNjEF0qk3pQgmP6doJYZIpukTrZXO3rv9lkYtigcOolRRGglwJw4MkWYpExj8xH6gQWtYEXP49dpvA1aXGbWA+sIIhG04YgxMQQB9zNcJv52Q9GE4lwVq3XM1r44diFzRFX1c4d/JAYCY3H7gtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com (2603:10a6:800:126::9)
 by DB8PR04MB6892.eurprd04.prod.outlook.com (2603:10a6:10:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 13:22:48 +0000
Received: from VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc]) by VI1PR04MB7104.eurprd04.prod.outlook.com
 ([fe80::6c14:307b:6fd3:3bfc%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 13:22:48 +0000
Message-ID: <b604e39a-9f0c-15b2-1460-7e0bb7e75d19@suse.com>
Date:   Mon, 22 May 2023 15:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [syzbot] [fs?] [usb?] INFO: rcu detected stall in vfs_readlink
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+24d1639a31b024b125bd@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000c9c7fa05fc177edf@google.com>
 <20230522-antennen-eislauf-4b5a69a167e3@brauner>
From:   Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20230522-antennen-eislauf-4b5a69a167e3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::22) To VI1PR04MB7104.eurprd04.prod.outlook.com
 (2603:10a6:800:126::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB7104:EE_|DB8PR04MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 37928fca-7120-49e7-f6bc-08db5ac7a2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AmEJ6HA7chFoD+iG7rrXTA9OGaZl2gfiY8RpWG/h73EsF9ospfbvMo1sN2qKtevFeVfCbwEpgNJv46E8YPv/drCDIXTTcZRAi7gk/Oe0OimChufqiVX3I4e6/VZr+Z7ANEdmN3dBNLHqw4ltHPLB9ampbfr4a1P6KTgbNTx/YPyaA40s1ir1Yx/VP3YQDWycxnQpjV58J4y3MSJKbchlhWkxN6Y/Ck6UOzDNdCaJAdY2jaqt7CcUnQin4BJ0FKYXs4wpTPmeTLVlrRWxFLZV9RNYknzA5t2ehbb/uWzgmsqM0WgCjTySP6o8aeaHm5ic7MatbIYgu8fnwXh6zhKpcVfoR3+buh0ggO0KNVjnwQKkgMWqhUrSE56w7B7Mn/642vqNNgesHSwFBFv5ZEN+q1YdLncmVJ9D/AMz1IotzGn6vWIhY6Z26d1KDPZxswCUt0z5ASbhmpEDWVGj/WywPjNQzoenXB/GeY1NNf1J84E46OO7EnS6ZNkFByNyO/0+XZcUwTtS8p1U2INHH8JgkQZl2OIFEhGnpcGxIX1Oirnzdn1NjhCJIinksDQ3zuk5OulLv/r1Sh7asp5PkNWGgZJiSZUgnLpPa1/TtkO1awmTm7JHrlZGFO8dBglGtDQnth+chL5g+6g9lW/DHQRamSL1ziG/czpfR8VRRCqwPKw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7104.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(38100700002)(86362001)(31696002)(36756003)(31686004)(66899021)(8676002)(8936002)(53546011)(966005)(5660300002)(6506007)(6512007)(2616005)(186003)(2906002)(83380400001)(41300700001)(6486002)(316002)(6666004)(66476007)(66946007)(66556008)(110136005)(478600001)(4326008)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFcwS0U3MUwvYnNHSWx3UFRVeEZlRHhnQTZqb202T25TWWUrRlRvaUZ3TjMy?=
 =?utf-8?B?cXVEeXhCYkIzQ3FhdXRVZWVhbitqQUUxdmRDZFpBcHZvaGNIT2RObGRzejBT?=
 =?utf-8?B?WERHRXZZN29wbXowWmErSTZTdmhBYnQ2N0R4SC9QQklXWEg0aXFRUDdZTWo2?=
 =?utf-8?B?anFUSkxaSVVyT2R4NjBzdmpMTGxzbDJseVBtSVlZSCtQaUNMUEltMWFmdFdQ?=
 =?utf-8?B?eHowQmNMSTVwOVNEdUFVQzloeUdPR05Ubzk5cFdqaTBQNXJoL1lOdC92Ym83?=
 =?utf-8?B?bmF2K25ZSGFlSHQzcUMwaFQ4b3FoaWhHbkxES0x3aTVJaTN6Nk9JWER1anBM?=
 =?utf-8?B?YU9rUExydWs2RGZqNjQ1QkZWNHZ0VHg0V01VeHFVTnFUSkdYajZQeCtjU1NG?=
 =?utf-8?B?eHZ1c2Q1b21JRmdEVlUvQ2NOWURzZXBIaUR0Qkl3K1NzaWN1U1B5VFdCQnJh?=
 =?utf-8?B?Uzd6YUdLbDByZmV3bTMwNmVNdFUzRzlQTmVLSjRPUW92cHN3TnAvcWQycUJq?=
 =?utf-8?B?R2thM2dEcFo2eFNxOHpkNVhrcjBnRDZFdEVncjNybjJFRUIwMlUxelRYTWtv?=
 =?utf-8?B?Wm5taC9QY3RoSDJwUzdNeHRLNlcwZktaVE96bkZBTzhtK0JKUFJyM3BZaUo2?=
 =?utf-8?B?emI4TktUN1VXWnA1OENHeHdXeC80TjFZTnNQa241MzRLMVkxbnpoMTNuSFYw?=
 =?utf-8?B?MTkxdW5ocHRiejBIblNmVHpNeTlsNysxWm42aUFEUGk4VEtzZStQblU3ckdD?=
 =?utf-8?B?dHBXSi9sUnZkcTFmWmJHakc1NHliVXluSTNEdlFwQWFBRXpGaWJFZmQ1dzZ4?=
 =?utf-8?B?SVViamdkMFVrN1IraDdPZjB1MndFNTZweVVDek1sRFQxanlZVTgxVUo3UWNZ?=
 =?utf-8?B?QUhTZlQ0RlVRempJajFpZzB2YVRQUzRhRmhrRDZ4MkR0RnNqUXNQaEpnYjVx?=
 =?utf-8?B?NGQxMVNvNmRQSksvM00rTHZ2QkxUWFF3eDNqMFdXV2FZekNOVlRWNlVKbmlm?=
 =?utf-8?B?eVVPUWczRGlxcXZBWkw5VStpNkgvQkpIcEljWERzVE5RQVZWeFJjdzhqUEw4?=
 =?utf-8?B?Y0NQR3RHWFN2ellMeU1ORGZXd1BjSVhJMlZqV0tQNFZpYWgwTFRRN0tWdmpi?=
 =?utf-8?B?SzdxMENRanJ0NVJiaUpRT002OUJxaEEzQ0FWRXZRdXVKTUxQMzlUYy84eVAv?=
 =?utf-8?B?amgwQit2WGtXQTRYKzhLOU1MUm5uRGZObnJkcUVQMTBXcU9kdDlYWVF4UFZw?=
 =?utf-8?B?VXdqNjlPcHlaV2l6RnJzMHBkbWorREhVUDNlcENnTUhucVljSks0QVlSd2No?=
 =?utf-8?B?bWdBSmVaY1EwQkg0MmhOSEJUcWt2LzZacmVQK09EbXg3K0FLZ29nMDI3b1cx?=
 =?utf-8?B?ZU4wZTAya3lXcCtaVVlBZURyYWorOGgyNTFNK2FDNytFSGNTTFRTM0ZiZ1BG?=
 =?utf-8?B?cnM3QjJoMTZTZHNlY0JNVGZtd0dKWUpkNTRQVytBakxETmdNK21WNDJvNEF5?=
 =?utf-8?B?Zjlud3ZIYWt4TTI2a2hUVXhmUE83WitLN3dCc0Ywb1VkMTA5WmhXUUlKUUlD?=
 =?utf-8?B?eUhBUE5FRVJLaHN3R3BEYVBnMk1WK1pISEN1YmFNNDEwdTBvUUszeXpBYnhD?=
 =?utf-8?B?bjBxZUlKT2J3aWppQTVFOUpXbWk0R0RZVERoekRsOTgxOCtLZytCTE10aHpI?=
 =?utf-8?B?dHdISjJaaTdmMk9rLzhXMUtMT2grcXZoQUJvSlRIOEtOUTZ1aEZ1NUcyRDlq?=
 =?utf-8?B?QUFSVjZaaGhZOGNRL09Xem54MmpHa3RqTzNleFZqWG1XUWpla1RvSFhHVmtw?=
 =?utf-8?B?dWRXdkM4RklXOU40T3lhNkI4a1Q3SENna0cyVERTcjZTVmk1UlNnSWk3STl6?=
 =?utf-8?B?SkhobEdGOVFqZnU2b1p0ZWt5N2NNVEV3TDdadGJiRzdFS3Z6emt0RFpUZ2ZO?=
 =?utf-8?B?TzVqM1RZU3FXbE9na1plMUFZWm9Tc2ZWZkpNc0VnMXJ1WFlFVi9PSFRBb1U1?=
 =?utf-8?B?REhtUTAxQndOVlhyUWFQNHBuM1hlRXFrLzdjbzJqNWxuZDZFMytOUGZab3pE?=
 =?utf-8?B?T2I2R1B0ZTQrdm5BNk9ScXFLU2R0em1UTVpzTUc4aVE5QWVTT1pDLzBjR3Uw?=
 =?utf-8?B?TFZ1d2RvT1NqdGZpRGo4bG1RMGZtMlBEMFUrbjU0Qml3dWlFRWxLZGYvclpt?=
 =?utf-8?Q?74OX/VXf9aBFr08c8U8RG24=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37928fca-7120-49e7-f6bc-08db5ac7a2b1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7104.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 13:22:47.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XxEpOO/WIN9yIf5mgNx7VNowy75xDZr7wJyPRezNj4m4Bis1nUHGALy90z+Ssx9gEVaSOK25wllZh1T+IXGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6892
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 22.05.23 15:01, Christian Brauner wrote:
> On Fri, May 19, 2023 at 08:18:45PM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    a4422ff22142 usb: typec: qcom: Add Qualcomm PMIC Type-C dr..
>> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
>> console output: https://syzkaller.appspot.com/x/log.txt?x=10ce218e280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=2414a945e4542ec1
>> dashboard link: https://syzkaller.appspot.com/bug?extid=24d1639a31b024b125bd
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137d4c06280000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17b758a1280000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/414817142fb7/disk-a4422ff2.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/448dba0d344e/vmlinux-a4422ff2.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/d0ad9fe848e2/bzImage-a4422ff2.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+24d1639a31b024b125bd@syzkaller.appspotmail.com
>>
>> imon 1-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
>> imon 5-1:0.0: imon usb_rx_callback_intf0: status(-71): ignored
> 
> I have the strong suspicion that the usb drive is removed or some such
> nonsense. Doesn't seem an fs bug.


It hasn't been removed. On a real system it would likely be.
The device keeps returning only -EPROTO. As we are dealing with virtual
hardware that is fast enough to cause a livelock from the error
handling retrying the IO without delay.

Handling this nicely would need a real error handler with a workqueue
and some delays and evetually more drastic action like resetting the
device.

	Regards
		Oliver
