Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E15341869AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgCPLCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 07:02:15 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:6239
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730786AbgCPLCO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:02:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1dvmriuxBGyKehJu+KAxaRHXl2MnKiLLLsxZOLUL/pRJxG7HtcfvPZw7edTjrSJLI5NuAIpgbJD4EI+TRB8kWvzKBSxorvxb8j0PSeWghfzYupjeJPBV7wNDCxAMwUqrmMVKwvTSdBz4YVEfiPgkwgkwlOa5Y/vKOd8g8ZP7b6w6f5J2gL5lJkI8W97/rKr1+cFlV222k6qQ5Zz8UNTSFjzIwZHDdOM10sAGiuO+3K7JhDyiMnlSVr1GgmVAJt4QVyyDgIrxVRqla0JtXwx7Nu8Ca1+7rgL5V04iI/2gJG2JjEqJ9iWeqHe40r+LsyQ8BqrzBxS2rYEmvgpjMZ9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgT8cWhlrcejIYkiG+yi1ATcztTX1/y5+31CIdznRLA=;
 b=ToePkW5cj3jOmWO/Bs+GZG+VkuB+io/GQOn0XkTjRzkf/FWxF7+d8si8TYFCFup5w26Q3IRyc/9AbmOTA4pVOIQUnh42/Oti82a5I16kt8oXQK5DNeC5bJB8pR2f2JLDugLudwJXsedTlR2rgi6BOP9TR9RfsVR1jk1EpAuIulZt1BhmGEozIsyOppb/YAVK/GIwuk9CbxxfVJQEAFK0519M1do8HFayPSn2COAHfsjU1piMA2u+mcnBoY22m8e/rEpvgAa3F3fSNLADiI+kYhqnRKy78d5ieFBCTtpN7fSvOAC/jzfya1WkyzO2ypmHcZN+t19t0QztdSyOAZu/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgT8cWhlrcejIYkiG+yi1ATcztTX1/y5+31CIdznRLA=;
 b=lQPX3eD1Nt2y39cNqDpuMfSGIu6SQfeAeh6226imBt9u2SkFczOeBGFU1cbfaMMbHkesbRF/jLgn4PwprkJBLxmKSyst61dXhXq2wDYq1WU6IxWJ/fm5CATl7OZvSAXOoUnZ2ryuBHWgctC1qaNlPXz0GIkqgKpgl2aLwb7w8l8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Zhe.He@windriver.com; 
Received: from SN6PR11MB3360.namprd11.prod.outlook.com (2603:10b6:805:c8::30)
 by SN6PR11MB3504.namprd11.prod.outlook.com (2603:10b6:805:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Mon, 16 Mar
 2020 11:02:12 +0000
Received: from SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d]) by SN6PR11MB3360.namprd11.prod.outlook.com
 ([fe80::d852:181d:278b:ba9d%5]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 11:02:12 +0000
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
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <3315bffe-80d2-ca43-9d24-05a827483fce@windriver.com>
Date:   Mon, 16 Mar 2020 19:02:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <47735babf2f02ce85e9201df403bf3e1ec5579d6.camel@suse.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:202:16::15) To SN6PR11MB3360.namprd11.prod.outlook.com
 (2603:10b6:805:c8::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by HK2PR02CA0131.apcprd02.prod.outlook.com (2603:1096:202:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.13 via Frontend Transport; Mon, 16 Mar 2020 11:02:08 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83613402-f04c-40f1-927a-08d7c9997a7a
X-MS-TrafficTypeDiagnostic: SN6PR11MB3504:
X-Microsoft-Antispam-PRVS: <SN6PR11MB35040F422411197775C074598FF90@SN6PR11MB3504.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39850400004)(396003)(199004)(31686004)(36756003)(6666004)(110136005)(7416002)(478600001)(186003)(5660300002)(16526019)(2906002)(966005)(6486002)(16576012)(316002)(8676002)(26005)(81166006)(6706004)(81156014)(53546011)(2616005)(66946007)(66476007)(66556008)(86362001)(8936002)(31696002)(52116002)(956004)(78286006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR11MB3504;H:SN6PR11MB3360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: windriver.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6srsXvehYyV1M27+WfARX9o59hR1jjbxQ3mtKhR9vaJifTLXfo8lnDVdcDciDflLoF5L1VKcCWWpmerDAL3JALXspbt949caPxWZcdNHiRDbCgQUGYa09Lgkaeqgv6O3Z/rIczL00gYHVAMGQqyFgLpidylT7U7XtQg3jf+2V+azXudy7goxkWKiuGF0/Qc5olU45KUWvytmf5GUUozhoNekSjdG215Z86zeT7eXbbctggJoYmuRwRTLtk99sbff841w/rqYjlaCyhRloYvMTP2mMximpSFmxENhHx/y52VzYKgcuNzVOfNAkntJlCkzoAnufw7yOPPxQuFFKcnzvG8NMxPb2RmzG3WLyleWTIXNBG5lF9k2TsN+MIylPhCnupgs8hT2vIsJushZ7PyTvu8ql0vQM1S2wF2u6mTJUWHd5xX6ODoUL2vEmeHozTjKc5BuSIG58Q0Q2Q/Xo8+Tgi/l7jaxSE6/tv5hMexHRbc45VnzofReQPEMvHGCTcGDKt7jrIz+ZgqX3c0ZZXlawSSSGolEEhQcEKpM0jccfqcXS8DiAgnugSE2jX/xm8Re0W09oS2fx8iRvG5PsSfr1v8FkfqX9//210FA1Gcl5Rm017wIXrjMzXXvPpuIujxrRU5QeQN2y0f8I0rcRuIynw==
X-MS-Exchange-AntiSpam-MessageData: fJkWSLv/F+rdDd/GbpYN6v3lJyecuk2schJ0uL19acuHjKRIljchzGcmFeZ78m7cAHFQfE/F/PIlUI9IcDudC/k8PTNu1uhQgBHWJDaYpg03m1s26TEc3PQg5UrWjyl6pAOvOqHRdPpGJ7XilOkhMA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83613402-f04c-40f1-927a-08d7c9997a7a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 11:02:11.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG9IK9VJKuys87iAALQrDl2mdwmz7cDIoR4b6cpNd5toYY87Nmv/PZw8M3teXLp184BfU8WYDx7RlUWnFki16A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3504
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/11/20 11:11 PM, Martin Wilck wrote:
> On Wed, 2020-03-11 at 11:29 +0100, Martin Wilck wrote:
>> On Mon, 2020-03-02 at 11:55 +0800, He Zhe wrote:
>>> Hi,
>>>
>>> Since the following commit
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.5/disk-revalidate&id=6917d0689993f46d97d40dd66c601d0fd5b1dbdd
>>> until now(v5.6-rc4),
>>>
>>> If we start udisksd service of systemd(v244), systemd-udevd will
>>> scan
>>> /dev/hdc
>>> (the cdrom device created by default in qemu(v4.2.0)). systemd-
>>> udevd
>>> will
>>> endlessly run and cause OOM.
>> I've tried to reproduce this, but so far I haven't been able to.
>> Perhaps because the distro 5.5.7 kernel I've tried (which contains
>> the
>> offending commit 142fe8f) has no IDE support - the qemu IDE CD shows
>> up
>> as sr0, with the ata_piix driver. I have systemd-udevd 244. Enabling
>> udisksd makes no difference, the system runs stably. ISO images can
>> be "ejected" and loaded, single uevents are received and processed.
>>
>> Does this happen for you if you use ata_piix?
> I have enabled the ATA drivers on my test system now, and I still don't
> see the issue. "hd*" for CDROM devices has been marked deprecated in
> udev since 2009 (!).
>
> Is it possible that you have the legacy udisksd running, and didn't
> disable CD-ROM polling?

Thanks for the suggestion, I'll try this ASAP.

Zhe

>
> Martin
>
>

