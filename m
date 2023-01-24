Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E316E6795F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 12:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAXLBo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 06:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjAXLBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:01:41 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23CC10AA9;
        Tue, 24 Jan 2023 03:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674558099; x=1706094099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TxPNpxOsN+oWVOqbR0tlRiON/Xyw8tvzPvX1eIoneVw=;
  b=ClvFJGlkczhqYh+5SHZIPcJppeXOgD2BtOpaE68VpyFcuWZ1hKpmUBnL
   FSfqnJgZ9fkJjmJ9VWeEBgpb03S6hx6KNfxo/3IdkB9lPGj4S51aZOAHG
   8zprtmvYkCeM2b4sUPoCbihxpk2OGMN6Gtthvj4bF4LShUF4g+kyDZ82V
   I/0LbhghBvV42VlGpq3f71mNEuKqUncbjvcZpLlfvJnN5HKct6FJ4m7p1
   o7ezGJFCHOM1hLdw6aQgL4eyJUbCcAyQcCXvnamw0lSF//8cgo8Wa9cPp
   9+8VKLgE75BQUICgG42eDtFE0doQLrmUwnqJz3eBQaPYkIMTnXZOLby3q
   g==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669046400"; 
   d="scan'208";a="333614331"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 19:01:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyFu7bhV0uNxHBS9bIxsK14Fwo3E0Nwyu4Elpdaa8QbFU+dEFX/fp0cv5S6Lo9olqfwQziAT1zF+XfhM1xZpfcohS11Pg99Nc8ambodgEhdcl2WEcgVqBzLN1zYgn2JNFmEI0Ip+fuqQVwslmROGGMHI2tPMbahP8MdkesJi8Eehc19IqHN2EpzN4JHUwEYBNtetlqwzN25TPefQ0PeOcEASlZdWOTGWkWbGsEztWNOn2ciDWDLoWV684WK8Yff7xQbd221xUgRg65D0Mb99fv9I4+ScKI14bUFbwBNKFAldLpYDCnqFcjGfF6gGhNZXFeEj66KJ1nLD3WB3TzrNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxPNpxOsN+oWVOqbR0tlRiON/Xyw8tvzPvX1eIoneVw=;
 b=NJQJylZRSl8zL6IAs1dGWh16S46pVibzDZewdsnem7+Crq9Y1UkNlW7fALFh60QoqR/EMKDnIZ6rSC0ENabpsQN4EuR61u+dV5aV8weDUTxGbBYC36VMXB83A7Mv1nIiC9v3uCqLBBi1LFZ1Xl1xCfRBZEjuiCgNalVjrvDbILNk8nvoV71V5GjOxVYKrnxAB06vimzNXZqpr5O4NM4XoX309TZe8iFz3C/gzmg0RhcgVKFmJs0EFmrPIZcW+miOYKBF6dCHKyKAO/Xfu8P0jJpb8SZy4bwqfeQ2PVE7HgiU4aIm+YYZSGYk3Ljb+QHpJwlnob4foSbMDiOFLEqluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxPNpxOsN+oWVOqbR0tlRiON/Xyw8tvzPvX1eIoneVw=;
 b=NWwKk8dH9LY2zarWub9iXoN9i+CYnzRVyEmfpiY0ECZ8q+22h1gtlduVoqwqjjN41jDthEdGKcOhKtIUlQ4eaYmxbPWdt2mNt504k28OioDalujRd2oiFEJr+3RPaSmVEIXIE9tdjyFrUzOEAHiUJ8trpVZQTr5ctmSua81GR2E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CY4PR04MB0488.namprd04.prod.outlook.com (2603:10b6:903:b7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:01:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:01:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 14/34] btrfs: remove the device field in struct btrfs_bio
Thread-Topic: [PATCH 14/34] btrfs: remove the device field in struct btrfs_bio
Thread-Index: AQHZLWTEtD+uavH5WkadqzOjqbF8QK6ta6aA
Date:   Tue, 24 Jan 2023 11:01:34 +0000
Message-ID: <a158cf83-0a4b-6153-7a72-fba4df3f9051@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-15-hch@lst.de>
In-Reply-To: <20230121065031.1139353-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CY4PR04MB0488:EE_
x-ms-office365-filtering-correlation-id: b68e480d-7bc3-4977-e4e6-08dafdfa5b56
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wzAhrLtTuXz7grKq/G5VERweFgmSN8AvI7quMH7f2Z+Jlv09ZFEuPgwFiR9cY1LHM+BHqv73UQjfmKCZ0Xma/F6dMWGU9Jr5eq/uilb1wydDWK3wPdCzD9HP02OsWRwFwCdsU3Gd3Tpx0xuQvdkOAkkkK5My8EQ2BowPHXZT/tYWtflRUQsauySf4vu18xbKUxcKGFqsmW2j7ZoOJgrv/3Nj2DDTuVVZDwfB3MKVdD2D4uunS9vn8jSA3ZM+UN3/JQdf1rJMbpBRaurAZgPD99H+HC8pZu5XXNXfz0ltiDvtH1O1dyi2vkHtvcIyKjg+ZA85+JpyX1PscdEd/9RpQKaoKhJgfulw1SMNnjcUEXkCt3F2Tb/Xr767gmOjuv5GrX6K9S3jjBHB6yeJnoOwj3dLPSlsmXjAFpogOoI6EPo/+BVtsweQkfzaG7HKmKCQzNK9q5SPmJ2xy6iQKv+glgEbCi7IzKyYAM4+0vvewP7Du3JwJTtSeaS/UsFQvn9fLUoUxV8vg/aPVxZu8Tl4jCNZrq7FdXmiYlZyYGsoWcexrcqF4NNqJbiN49Z977aT5KEUuEO/jVsFlzxM+7AeXHUREdJ3IQc5rWXZ8UfpjvxHl0Xx6jU69zynGEzxD+npppVO9AEvrBGVXR5QmPm1KLwftGQNgWxxId+7wvuMpv5zOhf2PoXGHdrqV6axwqvga6Ugc7XveuVHVXDSFlwdI0/+RVB4dZezcOjEK7rYLcmf9vjITyhxt4Au06W1ee9fXx7uqrDMGPLLHgEmWa1/Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(31686004)(478600001)(86362001)(31696002)(2906002)(91956017)(7416002)(8936002)(38100700002)(122000001)(82960400001)(4744005)(36756003)(5660300002)(110136005)(54906003)(6506007)(71200400001)(38070700005)(186003)(53546011)(316002)(6486002)(26005)(6512007)(76116006)(4326008)(66446008)(41300700001)(66946007)(66556008)(8676002)(64756008)(66476007)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zm9tSFJTTHhrUGtYK2RKVEV4U0tmZnFPSVd2bkthQXFJQ3M0bGZHQ2dGdnRT?=
 =?utf-8?B?OVJDaFIxWk5LeDhLWEFDQmpqSDlJOTluK3FERHJmd3gxUmZqbnpKSzFPd2tS?=
 =?utf-8?B?cVRLdFZXQzlXeTZFbGxWODZrMXlZSTh5ZTc2aGd0TmJ4WGZneU9oZ2FCbWNP?=
 =?utf-8?B?OHhBTFBuNFBTbkdMTWVSYmF5RkFzVUYwS01BS09TZWFDRUh1b2RWWW1Kc2Ri?=
 =?utf-8?B?NGdhTFJXbjNvVS9qQWxYWElTV0liRFJmeGRUM1hmL1hRSThKMStENzFuUWpp?=
 =?utf-8?B?Y0tIQlU4cTZHdzE0R3l0OW9aV1FXaGttcmJmYktDMzFEMkxSVHFHNmg3ZGtv?=
 =?utf-8?B?QTYxNE9ueTh3clFyaXhLYUFsclRSTldya2llOFpxUW5PY1pUcU9GOFoxeUNh?=
 =?utf-8?B?M3ZjbzJRMGNNOWQ5WUhsa0pabVUvaFZpcFAyTnU2K0JQMWtGUU51THhrcStW?=
 =?utf-8?B?WGIvbkFia1dvVGhlekxCTVZRMXJiamJGODR1V1R6TVQyZ3BYSnZYTWlhQUxF?=
 =?utf-8?B?QnhzOXhyakNUa2ZlVWxpMnpNY3dQRlNpQXRNRVFScEU1MnJzVmx0clF0enpD?=
 =?utf-8?B?MW95YVQwRTFtWWRKZS8xNmczMzdnalJZTHpPR0t6TEZrMmVoT0dIVWhsZUls?=
 =?utf-8?B?bGR3NmZJT2NLNGU5SXcyeVlzR2Z6ME1tMGhiTG9nVXNHK0l5M0t4bkdubE0y?=
 =?utf-8?B?TE5RT2xyRTJhY0ltQmdnVlJvUmFicitkOUJNcE1GQnpGbmVmS3M2Nll0MGJS?=
 =?utf-8?B?d0VTUTN2N0RzT0RkQ2YrVzJzZU9VeUFYTzZRbTdnYWxsQjJVSUNoc3dYZXNK?=
 =?utf-8?B?eXNOVzZ6ZHcxN0pGL2I0TllqRmx4R1ZONEFRVG1aSDhtVWlkRVREdFQzWXV2?=
 =?utf-8?B?MS9xVmUvY2duSDh4YXV3bDB1TjdTcnhodGx0V0h4N3pXTHA2c3RZamJnVmN3?=
 =?utf-8?B?YzZUT3hNeFBNYlJKR05EeWtxZUJtUkNTcFdLMnNUUlZPRSt1Ynh5dkJkcGIr?=
 =?utf-8?B?Y3pnQXVJTVp0WlI3bVltVVRsb1k3WFJpdjdkWThzSTVpNDlzYW5ma2FtMllQ?=
 =?utf-8?B?WDlFbUpuVG0vQ3BLTGlXN0ZDR2NGeGg0TUxrRGxLUXo5RkxDWmx6bDV0bmUx?=
 =?utf-8?B?ZVpBUnFGY01Wc3JQU3U3MU1NTzFjVFpWT1RDbVNlRDRvNDJBWkxRRHlGNEQ3?=
 =?utf-8?B?aUlGK2NzamZMRmJ1UG8zVVlYL0cyNml4Y041K0V6V2xMekVacnJWcUJsb2x3?=
 =?utf-8?B?U09LbnR4Z01KTEZVWnMyMGZ6VmpTZGR0enlTMDlHN1V2TDFaKzYrL0MxSzdp?=
 =?utf-8?B?NmgrUzBldDlDYXhTbERucTJyZTJRMG50UmdoK3Zsbnlub2pkMjNPU1dHVHR0?=
 =?utf-8?B?dkpTRzdDeUlzZ29kd2ZFcEhFNit1bjlOaGhOQ0pFNnRyM3hQeUxMU3VtSEpv?=
 =?utf-8?B?bTBZSmJmZGw0Q3hrMlpWMkZVTllQY1hqTFdBNGxUNmsyRG0xVlJwUERLbm9u?=
 =?utf-8?B?WE9QUnA3V2twY1psQk9YWDI5eE1DZkRFMHAyS3NzRVVIUjdIMks0ZzdsQVoz?=
 =?utf-8?B?YzR4QnFqbmtRS1QxcVNpSmRMeDR4SlViZVNyVWNzcEFzbTJnQnRWRm5ycVdh?=
 =?utf-8?B?Wmo1MEk3TGZyZjVXWFVmZWJLL1lKbGlsOXNVc2RKaW02THpHZDVMdGxFcjJY?=
 =?utf-8?B?RzZPVm8xd2NGK2s2VEV1RDVvMHN0ZmxiOUFFSTJ4Q2JROVd4OWM0OHJrT3lz?=
 =?utf-8?B?RExXNEVuMk9aMEM2elNYVUJjbE1DOWR3Mm9KRFVmbkRmZW8xN2Z3eXM4eERj?=
 =?utf-8?B?b2xhWWVDMHFtU2NOOFZ6ZDZ0Nkx5ekxvL1k3OHJJK3ZKQld0K0orUlRDb1F5?=
 =?utf-8?B?MzlRaUJoN24xTkw1YjliR0RpcnBqeWZ6S2laOHJkMGZXcnk5SFBrcnJDdndE?=
 =?utf-8?B?c3dXNDhRTzBlR043eUdNQllreGd1aDF5Vk9neU5pYUxYc2FNNHUvNHh0R2Z3?=
 =?utf-8?B?akx1M0NOcFhuOWhjSTJ1TzczdmE4eWMxeEt4TnB6Y0d4Sktrc2lBZDhTdklk?=
 =?utf-8?B?UzRVZlFMUGQybXdSZmV4QjY5UnlGL2N1SUZJU3hxbWwybjFybFd2aW9URnor?=
 =?utf-8?B?djNycE15UTRQcGFDY0NiMWFrUkJnUlNIVWFMYlpSM0x1VlYyUjVmMGkvZDNI?=
 =?utf-8?Q?mVuST6eb3S+iRKgPd4ZpDRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB75180F0202184491AF8D31186F0285@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ejdENjhxYmR3d2FyckhYNTJFK2owcHJZcWcyY0pNZWp1UC8wOEh0S1Jvb0JR?=
 =?utf-8?B?YVFXa1FVNnRKQmorU1dkZG43T3VjbU15eGZWRnd6Y2I3OUoySWhGazUvdVJB?=
 =?utf-8?B?MWFyZnp0YXU0RjJhWll2ZVRLblMvb2FQSnpjQ1JjNnBIbnp4YnNVTFY4SG5i?=
 =?utf-8?B?eW90K2ZjU0wzUlR6VWxKTDJrc3VsMndBNFVlRlhWVGUxZWxKQ2lwcS8yNkRI?=
 =?utf-8?B?R0IzRzZyKzF6RjluNk5MT3RDT2JhWkdhWDNZMnhRTHNYRHNEdUNIZEhLUSs1?=
 =?utf-8?B?ZnVKdjVNTjgvUFRndVFDNUFPN1F2RmdUaittUnF2WHAwSWp4WlBRVU5TM25R?=
 =?utf-8?B?Q28yc29meHlKUmt0ekliM2NXempQaVovWFVJeXJSWTZkMGNIeTFKK1Q4anI5?=
 =?utf-8?B?VGVSdXdZQ1JUYlFOQ0Rhb2VYdWtMRzFJYW04amwvckVUK08zSTQ0WW8zcXBp?=
 =?utf-8?B?V2pOR0liR1pjWjUzaVJ0L01PbjVxcDRDLzU4RnRBTFVJUlFqREpSMGtVOU5z?=
 =?utf-8?B?U0I5SDA0NFBybitNZmc3b1hIZUFHVHdneFVjK0VZMDVpZURIVnpNN3hRMWpG?=
 =?utf-8?B?K0hHa2tWTy8zeisweFk3MWROcGpMRWpwelNJY1A5c2hFeVBnTEtqczdHZ3lm?=
 =?utf-8?B?eEFhTTFuMHVWWWw4QjVOSFN2ZzM0TnJ0K0V5SnRMUVRDNU85QXZUYld6Z1E2?=
 =?utf-8?B?b0tQS3l4OTNweUcrbEpLb1E0Q2tWQkhxaU5zM0dWWTdBNjZ2V1NQTm5tNzk3?=
 =?utf-8?B?VU1ZWVNQS0dRUmxVenFQUVl3WllycWVyQWtiRGl6MmZScDZ3c2tKZWIybFNv?=
 =?utf-8?B?UjlDcitxak41bFYzL09LZXdhMWFzaDJ2YXhjYzJubTVIazRCc2NyaTdVRXRK?=
 =?utf-8?B?VDRTWXBKb1FEM1d1aWQ4dkRKbHhYZ1N2VE9Kc2d0K3ZmZkh3OC9pdktoU3Nk?=
 =?utf-8?B?bWY4SDRMV01BclVVeE82T3lNcmxUN3NwRHkvZ3FHUFZlcnY4bURGSG5BbE5w?=
 =?utf-8?B?RktQcFgvNkIyK0hSUEhIUlZhaWZwWkFLMUtENWpkbzBkc05iRXRSSTdhRVpX?=
 =?utf-8?B?bHVUTjhsT1U4bU54bkV5YlJFVElRQXlWandHTS9yUFRySlZWOSs1Qk1kN0xC?=
 =?utf-8?B?RWF6UFJhUkd4ZCtiRWJlOExSK3Qvc0tDQUlTL0tQZHQxVHRDUUl1MlFIaEdQ?=
 =?utf-8?B?VUtyelFSamoyNlF2YUZTcVZVYU5EL2wzSVc5QytDVGFpNG5maTlmdjBPZU43?=
 =?utf-8?Q?IjrrgFvDHdBf18/?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68e480d-7bc3-4977-e4e6-08dafdfa5b56
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 11:01:34.2106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwhaadHo5/w+WpVspaWnk5JHpcibcgH2ShOVgm6GxGkSd+tRDdchQu6v43ZqJN7Yia18vcRjT/NA+rrn25krzIXaKn4c8rLaD/TIn+pxGD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0488
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjEuMDEuMjMgMDc6NTEsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgZGV2aWNl
IGZpZWxkIGlzIG9ubHkgdXNlZCBieSB0aGUgc2ltcGxlIGVuZCBJL08gaGFuZGxlciwgYW5kIGZv
cg0KPiB0aGF0IGl0IGNhbiBzaW1wbHkgYmUgc3RvcmVkIGluIHRoZSBiaV9wcml2YXRlIGZpZWxk
IG9mIHRoZSBiaW8sDQo+IHdoaWNoIGlzIGN1cnJlbnRseSB1c2VkIGZvciB0aGUgZnNfaW5mbyB0
aGF0IGNhbiBiZSByZXRyZWl2ZWQgdGhyb3VnaA0KDQogcy9yZXRyZWl2ZWQvcmV0cmlldmVkLw0K
DQpPdGhlciB0aGFuIHRoYXQsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==
