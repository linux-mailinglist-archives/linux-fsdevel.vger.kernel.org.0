Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB144FA9C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Apr 2022 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiDIROn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Sat, 9 Apr 2022 13:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiDIROl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:14:41 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2041.outbound.protection.outlook.com [40.92.41.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518315A03;
        Sat,  9 Apr 2022 10:12:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jbwn0mhv+A3E2L0wHXIVNRTxR2n9lCdJr0yhaNB5F6IwyBfMCccwDdbwnVzUaDmNlJq9YzvY4ean52WYK0rp94rN/OkTN9kZdKQ90W5AdsyiJ7LSd8bQDdrLqSfaO8yeheaoAjvsNMyn4NmjxkS8W/IWMHdbCnF9/nIEbQT+ofYCfvmK9xDF+4jci3THwsfRESvj9rnmnzJvHljFmyLRwVDyOC0wVI+O2aJx2UrrB0jJY8GZOf4lVj6r9O12fdNTKAy4JD6Xe7isjH/qhEIL/HftSZmk8IbRZK3YoAKFnsfsHCpYd22ujBKSUBiW7cjbGaDfEOeLKPDPwh4h0PQN/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5Z3YUo6LdAzebv0bJfcNyGkaG+3835sb19u/J4ytOY=;
 b=EMN46z+c7QkOwACm3IIIn2zVdOoKQtgXSQ4m7IP1OfM6x6F6XuhPnIbIcUDi01hdt/pyoJer70rqSHD1/fc32Uoy9974bmvG4NSPZJBPoWfI2SZhmweCrtZIE1FMWiAqgCsgyz/jexIIpb0iCLrwos1hhEGI6MwAklUPyejSeR2HB4KNdXEHhxi2EdeIk9o5nVLfVNgUdCefiDl6fYnm36qjXwpsUDS20pjDwus8/hcFSokkzhOtRt6TIkaBr/X2xZay0haE5SgpWUFpWgGHyzbccKKznAxpGpALiyXPRALIYLm7HX0PvgFoU5HkkMK+4B3lew1dvDuQiOcVHIUvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by CY4PR20MB1624.namprd20.prod.outlook.com (2603:10b6:903:15d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Sat, 9 Apr
 2022 17:12:31 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::356d:2f6:6491:1391]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::356d:2f6:6491:1391%4]) with mapi id 15.20.5144.028; Sat, 9 Apr 2022
 17:12:31 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        "fdmanana@suse.com" <fdmanana@suse.com>
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Topic: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Index: AQHYPN5CzLbpGwv62Eyf/QOJSNQRSqzOeNCAgAWocgOAAJL+gIAKXisIgAbbsgCAAEinAIAAEbGAgAAPbICAAZdy0g==
Date:   Sat, 9 Apr 2022 17:12:31 +0000
Message-ID: <MN2PR20MB2512CEFB95106D91FD9F1717D2E89@MN2PR20MB2512.namprd20.prod.outlook.com>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
 <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
 <35b62998-e386-2032-5a7a-07e3413b3bc1@leemhuis.info>
 <MN2PR20MB251205164078C367C3FC4166D2E59@MN2PR20MB2512.namprd20.prod.outlook.com>
 <9163b8a9-e852-5786-24fa-d324e3118890@leemhuis.info>
 <20220408145222.GR15609@twin.jikos.cz> <YlBa/Rc0lvJCm5Rr@debian9.Home>
 <74e4cc73-f16d-3e79-9927-1de3beea4a11@leemhuis.info>
In-Reply-To: <74e4cc73-f16d-3e79-9927-1de3beea4a11@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: ef6682fe-0908-adec-3e5e-cf086684f4c2
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4gy6QfkqIaeP2GYSC0IC90WNjp+QhtIg]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4924c5d-8e24-4211-ad26-08da1a4c21e1
x-ms-traffictypediagnostic: CY4PR20MB1624:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6vwGlFsCAD0zvRH4BM+TT0nePqTGLLtBPVvvk0CjCrzhkRDoCGNh8fWnKJpO38Q7wls7rbEM2ptAgGrLirGM5GmCJrKG0lcrPuoJWcF1GNzjZNuFLhs5aOeWLksqCz9Lva+PXdCl7PtbvWNsDBwKNLRS4qLHA32ZWrMJLA2uLfzeXHrp1XC/ph7vCVGEdFZSLfTe4fkVAJLQQ8zqZmBEy3qQ83aUaKrhxUFFZLCHcH7Dmu5rjHBXgZP9HyotMyX7/D4X3WR4XiU4edugOQk9U1JCO6DmLQ5iSy7jGR9mYfeBT1/Hsjww9VzxzmKQMi1bt36gxEB6SZnQKKDJ8c+wRdnkSfA1cPd4Te6CMpG64aZ7+ykWdnHz9LWFA1Br1RPAMb0yH75g7ef9gBcB2nKKFEjx06jKTsymMcN3QnWduJvrCAtxPZzy2gNm5k0Mv/7HNF6CGLQplJVu78ohAR54jHaky1cTPpg52tMb5xPnU0zfCYYDZfu1UhAwJxFynQcC8skGJ9yHroA84wNpFYyvUTE7BbqyVfsTpD7ec2KUi5fC7wUWyAwp16zmNgAmX0d38dw6jCj6y8svhGKWA1ytTnkaybIgIgPUAWJ/f5uHFJjo1GvFZNDRlVfywwUQOXBa
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sowuh1QqgARNSxhqldcouGdHiooGrpAnRFZUKnSEAR22MZ71vaSWxJOzw4?=
 =?iso-8859-1?Q?JWdhE6gDgbd1MjgZh/H0zmmx3/rMkpAfPNX1DW96RQqCaan9YypRQdm88W?=
 =?iso-8859-1?Q?NJDGAyN+MxQOyWnYFTJ9J9O4msUXDe9xyKJos4u+nEmgZY5eBc13rkMl4A?=
 =?iso-8859-1?Q?VS1li9xelW7NH1RxvApESWieCRjsSVBIDJWuMauh/aKzDQ2KXcspxME7Ps?=
 =?iso-8859-1?Q?h1Hef1lkageePFr5XHFN/knuI3NWwfNaDj5MqVLxu/bdEVrshHtW4wXni3?=
 =?iso-8859-1?Q?/oWpM2XxR5WadbDQcCPMtQXX8Y8L0SVFyQq/pnv/Srce7F4iatxfgIWZZt?=
 =?iso-8859-1?Q?/dAG5FXITqW7mmu45iTgisb8xvOCuXoiTQYxOLxJr91A81rT91SRWwzrAE?=
 =?iso-8859-1?Q?3TanTSzvgyWombyA9WFbZguJ8hpAQotirIJyFXhFDlyYO8MEyUVGxR+fEC?=
 =?iso-8859-1?Q?4jES8aamx9o5YvUBxZ/OynVtRCnT+JgSwXAVksM5CR058h9OYjMtEXQXeR?=
 =?iso-8859-1?Q?i3JknIKSFzJy0UZRLzmHzQMQCtXsqgCrbXEFzZwUz5nAcaVNIghgQRJX4c?=
 =?iso-8859-1?Q?JeTJj/oTgwewDOZMWEeO7r5nM3s0/Cp9fP/vkha0cp+Srw1jFOAmcc4O6i?=
 =?iso-8859-1?Q?k3z5Qi13eoReor0+2Ctvef5QuMxtxfzt602KoeWuxG3uGLBP9DgfV59AX4?=
 =?iso-8859-1?Q?SGijAvQmntaRHKhZ5x6Wq51FpLoSq+yeI8tJANRERyMDTdNcmIC93SzR7G?=
 =?iso-8859-1?Q?EnZ0gU4F0HeHwrlXtdmtRQ+5M4ZEr//4Z4XeHmnUAMOtLVni/bUXoILqtw?=
 =?iso-8859-1?Q?ElGKJ74q9vT+UCxIjqH6sGqMCgNWsbVttl6JVUXGncSHSnPNBs2K6RleJN?=
 =?iso-8859-1?Q?jN+Egy7900uOXUFvvPf/GKrJZN0KcP5eDHEwHfKjIEj7vY7QwO3zTXU/a+?=
 =?iso-8859-1?Q?idTiWcF8RC+QR8yVuxZrb7ieh2Kfl5Gyqn6dQSqsmjTHjZDX8GNKIoJ33e?=
 =?iso-8859-1?Q?SGNY8QTVKoJxT29LzB9J/Jdn5/ZcSitLPhh9GveED4TFwcgnbSJqvjcTsE?=
 =?iso-8859-1?Q?PcdDIDykn7YDOI9caIccgg2Ma+b1lcQLtvX14XIYn//fEPeYkoua55Zw4K?=
 =?iso-8859-1?Q?AHXjPsjIV3JgbuKh+ph/29ufUvYgiB54oJNrfjQTS7ZcmNInMTfd0BnMpM?=
 =?iso-8859-1?Q?BTNt3nko54DqUwDd/KP0WPNqFnrvg3Pe11Cjz6Y0h477pfSuORKwV5KHHl?=
 =?iso-8859-1?Q?iEU3MuRLawN1Jq3IPA/WBFL9wMxUnGhJs/ZVFsTYjoBckmu6Vwy1eg79bf?=
 =?iso-8859-1?Q?RuS/XAppcHzU+7WlMbUF3pO+4lnouVEvZR9CtvAuREgIw/vrKNWYA8nGxS?=
 =?iso-8859-1?Q?T/equWRo8cbw/DpnheN0jrn6YP7zJC2p8C3o47Vc2T20oThyYX/kuZwUTI?=
 =?iso-8859-1?Q?kR0U/GOXc4Rctmp97u1zc3V2PIGxdXomLJYLCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f4924c5d-8e24-4211-ad26-08da1a4c21e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2022 17:12:31.3840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR20MB1624
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.04.22 04:50, Thorsten Leemhuis wrote:
> First off: David, Filipe, many thx for your answers, that helped me a
> lot to get a better picture of the situation!
> 
> On 08.04.22 17:55, Filipe Manana wrote:
>> On Fri, Apr 08, 2022 at 04:52:22PM +0200, David Sterba wrote:
>>> On Fri, Apr 08, 2022 at 12:32:20PM +0200, Thorsten Leemhuis wrote:
>>>> Hi, this is your Linux kernel regression tracker. Top-posting for once,
>>>> to make this easily accessible to everyone.
>>>>
>>>> Btrfs maintainers, what's up here? Yes, this regression report was a bit
>>>> confusing in the beginning, but Bruno worked on it. And apparently it's
>>>> already fixed in 5.16, but still in 5.15. Is this caused by a change
>>>> that is to big to backport or something?
>>>
>>> I haven't identified possible fixes in 5.16 so I can't tell how much
>>> backport efforts it could be. As the report is related to performance on
>>> package updates, my best guess is that the patches fixing it are those
>>> from Filipe related to fsync/logging, and there are several of such
>>> improvements in 5.16. Or something else that fixes it indirectly.
>>
>> So there's a lot of confusion in the thread,
> 
> Yeah, definitely. That basically why I had hoped from a rough assessment
> from the btrfs maintainers.
> 
>> and the original openSUSE
>> bugzilla [1] is also a bit confusing and large to follow.
>>
>> Let me try to make it clear:
>>
>> 1) For some reason, outside btrfs' control, inode eviction is triggered
>>    a lot on 5.15 kernels in Bruno's test machine when doing package
>>    installations/updates with zypper.
> 
> So I assume there are no other reports like this? Great!

Well, "inode eviction is triggered a lot on 5.15 kernels in Bruno's test
machine when doing package installations/updates with zypper" is a little
misleading IMHO. While this was true at the very beginning it became more
than that. Now the high inode eviction is already know to be 100%
reproducible on:
- at least one real workload (opensuse package update).
- 3 different bare metal machines with different hardware configuration.
- 3 different cpus from 2 different cpu manufactures.
- one synthetic worklod (the scripts I provided).
- 4 different distributions on virtual machines.
- all 5.15 kernels that I tried on.

About the lack of reports, my only guess is that most users must choose the
compress mount option instead of manually setting the compression property:
- the compress mount option doesn't trigger the regression.
- the compression property does trigger the regression.

>> [...]
> 
>> 6) In short, it is not known what causes the excessive evictions on 5.15
>>    on his machine for that specific workload - we don't have a commit to
>>    point at and say it caused a regression. [...]
> 
> Bruno, under these circumstances I'd say you need to bisect this to get
> us closer to the root of the problem (and a fix for it). Sadly that how
> it is sometimes, as briefly explained here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/admin-guide/reporting-regressions.rst#n140

Ok Thorsten.

It's not sad at all: I had a great time researching this regression and
gained a lot of knowledge while doing so. The problem is that I am just a
simple user at its limits here and additional bisection is probably beyond my
abilities. I can only hope some kernel developer feels motivated to further
investigate this subject.

Again, sorry for the confusion and thanks a lot for your patience and for the
directions.

>> This thread is also basically a revamp of an older thread [3].
>>
>> [1] https://bugzilla.opensuse.org/show_bug.cgi?id=1193549
>> [2] https://lore.kernel.org/linux-btrfs/cover.1642676248.git.fdmanana@suse.com/
>> [3] https://lore.kernel.org/linux-fsdevel/MN2PR20MB251235DDB741CD46A9DD5FAAD24E9@MN2PR20MB2512.namprd20.prod.outlook.com/
> 
> Yeah, but it was this thread that made me aware of the issue -- and just
> like [3] it didn't get a single reply from a btrfs maintainer, so I had
> to assume the report was ignored. A quick "we have no idea what my cause
> this issue and it's the only report with such symptoms so far; could you
> please bisect" would have made me happy already. :-D
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> reports on my table. I can only look briefly into most of them and lack
> knowledge about most of the areas they concern. I thus unfortunately
> will sometimes get things wrong or miss something important. I hope
> that's not the case here; if you think it is, don't hesitate to tell me
> in a public reply, it's in everyone's interest to set the public record
> straight.
> 

Grazie, Bruno.
