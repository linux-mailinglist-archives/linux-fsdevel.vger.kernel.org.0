Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BF418234B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 21:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgCKUad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 16:30:33 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com ([40.107.7.113]:32739
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgCKUad (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:30:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcDHzljmYiuqp8O7LBA+zCo+oUFYbd3J1K4Mvzj6yojfPMwsw87TZ9LagYXYG2lfkyokMzXXkodYsQ5suPR955waN89RMfRKvNj4e9NtE978xntCmTRvS5yyIvWg6o1yBkzZXlxswL4PZKyRag1MQ6qNcrZkrTFQEnzRfxgU+vC78tQojBVEMbOgMJ1A7Kb25lBxJtrcSbttjsbIgmt93PcV7GPZ/+yn/D/8+6CJGn9nKnFnLGwzCtZVSroVEFZLzCh3lojK0LOZOMeMZrDduBHYIt4WTgDjnePiqoCJVqsCY9hfAW+jg1K1R/mEKuf46YAinb/RrSmsCML7YR++VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0yl7zRlyMlmgoGfqsSMtYXEC9jwdZkegJeEM5qfq9c=;
 b=MeQmh9n0FzoGvKIJA3OOqEeTbP4ba6Y0sD9LplxFPVq7d4m2gljoQ7kj5ZKQJjHvIYuu6g+JP30IlDJ/U4quWWAfaNS0Emy+j1bDJWPEBEYElTB7hHXVSWNuW9CxI+lu5fxRXTtwdPnYm2Kvs+pnTSABXNm+ml0Qg6L9AHDYI33bOpboxS8AiG8aL599fjmxbKc1GRlYhYGBlV62vaIvcHuv920xk/3IjdkEWFpcGP/EGNVRJie/cXzfyCNfRq6uSSZmA/agimg7ybXK7EjklsMElaDkvlozZhMoOtySwf3Vad1fTeKfgFpERDqge+Cxixhs43FTpQWXbVs/P7SLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0yl7zRlyMlmgoGfqsSMtYXEC9jwdZkegJeEM5qfq9c=;
 b=cX1tvW0W02nchJuhnLOvqVEIxmHESxUFOc5V3Lj8fzjHjsT0I4SvKU8h96Xvwgu8YSlgpz2UkznxXRVmPfhHh37ikmRMy85xA9YSRuSEkXYmJ9sp0Dt7BXW1VY64pKB4v0ckZx+EzR/aPY1pet6MesIV4NDyLqsJYPfdou8j4ck=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (52.135.128.26) by
 DB7PR08MB3321.eurprd08.prod.outlook.com (52.134.111.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Wed, 11 Mar 2020 20:30:29 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::5cbb:db23:aa64:5a91%3]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 20:30:29 +0000
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com,
        Dmitry Monakhov <dmonakhov@gmail.com>,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
 <C4175F35-E9D4-4B79-B1A0-047A51DE3287@dilger.ca>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <46c1ed68-ba2f-5738-1257-8fd1b6b87023@virtuozzo.com>
Date:   Wed, 11 Mar 2020 23:29:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <C4175F35-E9D4-4B79-B1A0-047A51DE3287@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20)
 To DB7PR08MB3276.eurprd08.prod.outlook.com (2603:10a6:5:21::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.14.212.145) by HE1P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 20:30:26 +0000
X-Originating-IP: [176.14.212.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f73dc87-1d5c-4a24-8aae-08d7c5fb0a12
X-MS-TrafficTypeDiagnostic: DB7PR08MB3321:
X-Microsoft-Antispam-PRVS: <DB7PR08MB3321F2636224796328F0B471CDFC0@DB7PR08MB3321.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(396003)(39850400004)(346002)(199004)(6916009)(6486002)(6506007)(478600001)(53546011)(36756003)(2906002)(31686004)(81156014)(8676002)(81166006)(8936002)(86362001)(54906003)(316002)(6512007)(52116002)(16526019)(66476007)(2616005)(956004)(186003)(66946007)(66556008)(5660300002)(26005)(4326008)(7416002)(6666004)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3321;H:DB7PR08MB3276.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3/v+7kh7T3makMNH8m+HR/wdVLpPNdvmjNT76doQ52iEZ3IZrBU9Fs66vkPKOVsGdBiXzN1EQ/IPvFtmheOw1rJVHpi8ovTW4j2GMckRdoItuZkLexWEoT2vP6x68ceItoRsN8tl0wPE1cRHdEBTvadJywW/Ru0BRoI1v1dtiqtgTTICnLgtf7Anx1PhiYtvlqWVbj97v0HPGwM7+ATuOuXybmkE/PljNODe/cKaiiDnSD6KzTQNOpD6i1D+qJHa1PQslBQAxlkMCKQ+urOtkMMZFXRCVXTHXmTgeLgddlbhv6Lt1xhtkEmEOz1qxse++GYMehF3xIpyKOF7sYbSe01VbHedgR4XYwmFuLErguOiVCgt9brcKBJKk2QDVebK5tEGr3QQgqm1azQfSqutfcTQeOJeXrRdqs9UcIqAXRZ4u3b24WkzxbpwTdVveod
X-MS-Exchange-AntiSpam-MessageData: fDeyh5lPegIvSmGjPdzCQPqNMuT72Ws5ZnTOJo1mS/TxT7ciD3oX2bva4zsev6YqYdUdUYhjeh2MVP08GuylhYIP0AYZ/d6Da1KQ9ly2HiPEAue7mE0CSwyiTFfG76WUp+Ez+jyUt3kwI2T0PD5Bcg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f73dc87-1d5c-4a24-8aae-08d7c5fb0a12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 20:30:29.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FpP9bUNiJHPX/C2ZD4s2I9cUS1yRTuVOZztD2ojnwOkdHXDzxDp6TIabHHyXLJj1j0M469FE4c0CQuVLlz8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3321
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11.03.2020 22:26, Andreas Dilger wrote:
> On Mar 3, 2020, at 2:57 AM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
>> On 02.03.2020 19:56, Theodore Y. Ts'o wrote:
>>> Kirill,
>>>
>>> In a couple of your comments on this patch series, you mentioned
>>> "defragmentation".  Is that because you're trying to use this as part
>>> of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?
>>>
>>> If that's the case, you should note that input parameter for that
>>> ioctl is:
>>>
>>> struct move_extent {
>>> 	__u32 reserved;		/* should be zero */
>>> 	__u32 donor_fd;		/* donor file descriptor */
>>> 	__u64 orig_start;	/* logical start offset in block for orig */
>>> 	__u64 donor_start;	/* logical start offset in block for donor */
>>> 	__u64 len;		/* block length to be moved */
>>> 	__u64 moved_len;	/* moved block length */
>>> };
>>>
>>> Note that the donor_start is separate from the start of the file that
>>> is being defragged.  So you could have the userspace application
>>> fallocate a large chunk of space for that donor file, and then use
>>> that donor file to defrag multiple files if you want to close pack
>>> them.
>>
>> The practice shows it's not so. Your suggestion was the first thing we tried,
>> but it works bad and just doubles/triples IO.
>>
>> Let we have two files of 512Kb, and they are placed in separate 1Mb clusters:
>>
>> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
>>
>> We want to pack both of files in the same 1Mb cluster. Packed together on block
>> device, they will be in the same server of underlining distributed storage file
>> system. This gives a big performance improvement, and this is the price I aimed.
>>
>> In case of I fallocate a large hunk for both of them, I have to move them
>> both to this new hunk. So, instead of moving 512Kb of data, we will have to move
>> 1Mb of data, i.e. double size, which is counterproductive.
>>
>> Imaging another situation, when we have
>> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
>>
>> Here we may just move [4Kb file] into [4Kb free]. But your suggestion again
>> forces us to move 1Mb instead of 4Kb, which makes IO 256 times worse! This is
>> terrible! And this is the thing I try prevent with finding a new interface.
> 
> One idea I had, which may work for your use case, is to run fallocate() on
> the *1MB-4KB file* to allocate the last 4KB in that hunk, then use that block
> as the donor file for the 1MB+4KB file.  The ext4 allocation algorithms should
> always give you that 4KB chunk if it is free, and that avoids the need to try
> and force the allocator to select that block through some other method.

Do you mean the following:

1)fallocate() 4K at the end of *1MB-4KB* the first file (==> this increases the file length).
2)EXT4_IOC_MOVE_EXT *4KB* the second file in that new hunk.
3)truncate 4KB at the end of the first file.

?

If so, this can't be an online defrag, since some process may want to increase *1MB-4KB*
file in between. This will just bring to data corruption.
Another problem is that power lose between 1 and 3 will result in that file length remain
*1MB* instead of *1MB-4KB*.

So, we still need some kernel support to implement this.
