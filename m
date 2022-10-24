Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F389609DD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJXJTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJXJSs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:18:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B9646238;
        Mon, 24 Oct 2022 02:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666603092;
        bh=yNUX2bsks83FyVFR2JEe9rsSO5eyOcOjP7RNl97IWTQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ATMuU4gYMAIefm+FPIuMHVD5Y0OpPBO73fFYmPdCcVG/3D3xs1FY/JunV1fc/7Lt/
         Y4OWKo44dJWJ3MUeECYHkBmJ7bFRowqm06brB/tWa+1Z3/mHyzsfmmGo0ONFDXEOVD
         V8EFOXfofZ5qYdziD2a7DDSXzmeZQ88Dzt7GpJ+s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeCpb-1pKrdU0GgR-00bJZS; Mon, 24
 Oct 2022 11:18:11 +0200
Message-ID: <c957a7cd-3642-c520-fee5-ddc5f5720ffd@gmx.com>
Date:   Mon, 24 Oct 2022 17:18:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <de4337f4-3157-c4a3-0ec3-dba845d4f145@gmx.com>
 <00e0cbbf-8090-7da1-22a7-a10bf4c090f2@wdc.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <00e0cbbf-8090-7da1-22a7-a10bf4c090f2@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kDryvdCS4y0rcSTJgT9FLuA+kRk7w6/gg6Ite6xIFUoaAzX30rV
 lY42DJ3llKG1E25Lj6d/XUFi7zeqaBDNCV8/Sly0Tkp8Yui5PgPKVXs3BO63+T8p2KKw2F0
 XQ6KTvmJu0Ulsr0DUgfU1kSHCD7Qhnwr0LkHLydh1w19XyV7iWKqnTDdaos9HZR1TuRAwFb
 z5qns0ll7S98ad4WAiTwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:klgEpFFZ244=:Qj4ou/M7zBYZOgGRh2SxBW
 E5BINZnWAD2iA91n8TfMupDAUWBJgqhCzbqAsIMpgTW1bVtVmPfVDtESP0uilngZlbZ8UQbc3
 X2Gi9RpSWkWNqKNiIm+RYKmp+d61u9NHCv1zPeoix85IL+oh1kkSfa/uz8w1xVs6myjst0BLh
 idHiPyIsJRKYPq+s+WgpdMGj4LzXdeBEqLU/FRnWh7V03KdS+QahxEGhBQcHgqoOk1grj1ATB
 kpU1MiV8YHHrF5BF1vh7jp0L4B3Va44BkWYmpuxqULd/9sv8aT/WnqU+G4tHqk8CQ/wEHxyMv
 o/dhEcRvTDnFhsGK89dboBfIUCPDcuKVT0fNj4EMG78DnEaR/SwZnjvFndart7k4YQ9AhfyM7
 KO0aPJbVkLt25pSpi6KDA9hm99NDTsQ/Jo710eYJlfql2jtb47szzNk6biZnPYr4FBdOQuUmT
 LrFDzrlGtFq0jQmDIQYhdZIf67bifK4F/MdWU5lMmIdMutUAa7khE0AacflL5HSEQK1ff3/uK
 7e+LAdYDKbb2Y0k1wBRjVVuREIlQNbGvGQTaXCYhUT6a3VWpuQg4nE3L5I0I/2w/T7rLDvCiM
 BK2plXj1uMK30WCKXlSjptfq8OpuYTQzb8WzSo6djDSRcnerqbn9nexRBUTGe8ffBw5L8Ldv6
 pUB9mPvmLJ/oi8AHuhcKYZJHMrOn/gM+0LIvAV+pXYcL31EGUfrVIGfdO1LnlxLQLfMEmean8
 E04VFPo7cKA2zH2+OCtkkMB3dbt7FQ2ipi12Tr+ZrSgo7S0LzJhcbCJiq3o3ANK7S+QRbcOXT
 zHDdsavRJ++eUbGBIOPjnT0UHLerV8GUc5mJdU7Zg48iGiVS+L2UeZCAfDTXMT0d8I9nEr35D
 i+lLw5sz+/MKznbKu/kcaZqvcI9pRhAWEPi3zC5uRPDhSvljzqwZfEUbYJxGB4RpgensAJz1m
 putcBCpR/1395YEe+Kt0vKnx9wrWhK94m/rjrjECcGPAZMw0cMrPrNjuxM+XAjcU9s1UZUQG4
 q/S5vGOKYigoAYQEZs0nILAwxjgX5URE8ylV/qtd/oj/4Dg7Prak7TPCVfJKYZhePSaWvsD21
 nYRCcniCo6ocNF1+myxpTaH5yE5VE4ABaw/Q8bA3IbyyHu0/GcRfQppdEPtocwqbmVfH05TT5
 EDVcA9vG+hZ0H/UTqarJdNFzoxN6nRnuI9xxvDU5S2otj/pMNGTh6bkOFkmZt8ytWc42Z04Lg
 A7HCkGrcr+PK6F4fbn+Ly7m4Km3zTNUfUaG/x6eXNIpDjQb2VGRmWMJAPubWTFoPdi6bnRW7y
 um1XVz92bHH5QTmfZ/qPdd4n/RMgi63shFVdvg6gPAio4hsmHUKGx+BKDy3+4yVU8Hk/8iHuB
 yq+VXib3WXADh5mopbXuLTpF/k9dofZp+CjdIDXE+PUrQxPHXfGy6AmBjnYn23N2/14QUmBxz
 gT149287CVazeCpY5PUYxQmUIT1x1TfMSz6uMdXIl6ITYc45q8l1Aq+t6d1bFbbthWMmyHh3m
 Fsfxd4FlBEsptW1wDpl0gXpDXEGxTB7yPMQdAdt6LcH5oe1ZJ0BdjabulM7Ko4thgH+97RH8+
 tUkSeX/KrnKnelIifRmhBHgytMIPOiL3Z0O73kHTClzxnqqo80PDm2iAR1fl4duJgOxRwnu5L
 7l4xm226+jiAZDeqhdvW9cLAX92VJBmvgbqeks7Q28xJM3QFw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/10/24 17:07, Johannes Thumshirn wrote:
> On 24.10.22 10:20, Qu Wenruo wrote:
>>
>>
>> On 2022/10/24 16:12, Johannes Thumshirn wrote:
>>> David, what's your plan to progress with this series?
>>>
>>
>> Initially David wants me to do some fixup in my spare time, but I know
>> your RST feature is depending on this.
>>
>> If you're urgent on this series, I guess I can put it with more priorit=
y.
>
> What's the fixups needed there? I haven't seen a mail from David about i=
t.

Mostly to fixup some comments/commit messages.

Sorry, that's an off list talk, thus not in the mailing list.

>
> I've quickly skimmed over the comments and it seems like Josef is mostly=
 fine
> with it.
>
> I can continue working on it as well, but as this series contains code f=
rom both
> you and Christoph I don't think I should be the 3rd person working on it=
.
>
> But if it's needed, I can of cause do.

That would be very kind, as I'm still fighting with raid56 code, and
won't be able to work on this series immediately.

Thanks,
Qu

>
> Byte,
> 	Johannes
