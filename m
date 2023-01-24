Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327AD6796FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 12:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjAXLtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 06:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjAXLtm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:49:42 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD2142BD3;
        Tue, 24 Jan 2023 03:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674560981; x=1706096981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=itKydkHbxYIfANfkeHAijkL+OK6YMyd1isRTJVW7eB2CGmkIhO7tCyZc
   N0VNZ66JuFpeCFdiXU/JYmqoTWQ2CxCsxKouie5dh8As08Zt1v5dkiYl4
   Xy2cm5P3BJWGoYNDwE6J9YSDEKB4lyHRBPeXfJyqCIfESg87rWCj3qEtz
   mZeGE1FIH9yBzW6Bz5HTbci9aRQZDOGzWzIP8mxNvZXZLwqbcu+BiD97e
   Ksby34bMGSXIspoUx/IJGVDiqNXApMXYJLxhhK3sH+INjeZunsLnnAvez
   tKMqFC/rqgtXTn7VhR3E3zg9gH4M5Bh7j/h53OzlGtKdMtVrilFwYhyLs
   w==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669046400"; 
   d="scan'208";a="221694792"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2023 19:49:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ygds0HWZ0Jdgcr7kMbViXvGonWg9d0JS7PxM977I1b5CJkUL4FPkMgGssHHLJtXM0F8XnD36pjJ3xV/CsQ04a2t2IIQ5cQEFA9FjgfACQPbMQBJUA+pW7Z49+cRauFlkun4BMoTfMRw+t5ytEzqIKXQCpB2x9fayYoB76EWSxEUeqfJIclWeicbb3CPyk5UHmIQcMy+bs4tmGwQs4bARyui+MRsJ+oQMswBKQzCxprPhgFnDuzOnUdnxqb+QaxuESPME+pFlzP8cwEOaCUvPyQETuH+k6AkR3JshwG5kVJf+e8P3JjKcZMWxla0REbtLoznp1c+XRl12EuGRijRE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=bJvJTGkPxcvqw2laY5fWpbKqmeptF6g11oX/VNGQXP6QVC0/0EOX2KXhoJujiALY8WEANjV3b4ADjwDy6K3W1jRfAcUgqY+TaitRlBih+Re5XE6Tv6YY+EWglTv0qet/xQKSel+Ru6nCKbyQUh8+pjHtmgU8xb2/pVLbqsrM2vpcA2gGP6fvBKUKYw4vvJBlTLZW13Q0YxEtVZA4X6cPZhiKpA8AWNMfspav4uqw7rdqukayZjfEl3EmcLErDO5bZ7DfUjJazfX5RFTIpkUJv6cZKDZSA4VK/n/z78728OwjIQu0pBDTN53SAfDExScU3voDYM9wLD5lZr3HdQXPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=W26m4o2E3aZVRUC9Xg01A20DVRHkgnpM2a7s8tJNGkfYGFmkbSHkwwp3yDGbgknwTIW6mTrTVnll0zrlIZIrL5i40f2E1+WRcOG3kgSgE3qgtyd6cC2mGnCK0Z0KJKZqpBeASHYZ7kg2Sc6B1NTEdBFAz7+ad7ZVDEyieaSg3+A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5773.namprd04.prod.outlook.com (2603:10b6:208:3a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 11:49:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 11:49:37 +0000
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
Subject: Re: [PATCH 18/34] btrfs: remove the submit_bio_start helpers
Thread-Topic: [PATCH 18/34] btrfs: remove the submit_bio_start helpers
Thread-Index: AQHZLWTMcsnSkW7BvUae/wWVbXIfTa6teRSA
Date:   Tue, 24 Jan 2023 11:49:37 +0000
Message-ID: <09bd8988-868e-3afa-b9c8-695a768e1a80@wdc.com>
References: <20230121065031.1139353-1-hch@lst.de>
 <20230121065031.1139353-19-hch@lst.de>
In-Reply-To: <20230121065031.1139353-19-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5773:EE_
x-ms-office365-filtering-correlation-id: 2b36448c-a0e5-43cf-3fe4-08dafe011205
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irzRQVbeRElNIheGgRwMe+JjuGddTcDz5sFae8j2OGYye1aaaawZd/nBI5eenrQXo1Hj729Nns+iP2Pdj4Llh6DBrOTeL+3Wmm2lSZBrBz6pngR96Warx8bOXMy/7sFMmqOxtm3PM6BHzWc8aIUTSryUqVAeNUp4LrxoTGyUvAHstvgDi8NI+9D6CZpjA+IPicv74V1vRDSVqPmYMm6W4VBadSei2Zu2vDZOYSO6ttWnKK5LXIorso3y4Fu8Xz01AFCZAuqqVnZXFWolD1yk0a4fSSbCet1mT6Y42AY0sSdJs8w1Z5jcFrQg/sc80/yfEAZ7gwOKo5l7UwGD32rvZPS3kg48vX5JnejNy5PnaB/LmivU/xFBjf/IzBB8HylbWFiL3TDX6InkTenRzf+pcI2s1b1tc8BNktrfUuCkP9dNUs3yhJ0ktO63+a638IL5LSs0smsuBEu+afInr2nr8uHBejL2Rr7jkqdRtANNQoknTBeQrkciyxfq3EopvVNQ69odk9UPp7SN9j3L1T9RkOcdZrckTZXtJWIsV/AFSZeKiRNfoLszhtWtC9FIAf3PqcMq2HzzvVo4xM/EoYBL+I6gIpszseovctsUuHVhOEJJM/bnKzycBx8XHAwbvqTpwBgSzEpcLKwOvVFaETfa3ghp/A9Hh4eU9GPfRskYpNT9PirAsJdvih8vFRMBKnWF7CHZu0APaZEAwAqs+q2cOAKI2Ko10xAPcLpsutMjkPz4g4v2V+tQS2Kg8nNUj2uaDUE96PK+NOfFW0jcsBbdXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199015)(38100700002)(122000001)(19618925003)(82960400001)(31686004)(36756003)(5660300002)(558084003)(66446008)(38070700005)(6506007)(110136005)(54906003)(316002)(66946007)(66556008)(64756008)(6512007)(86362001)(66476007)(31696002)(7416002)(2616005)(4270600006)(2906002)(8936002)(41300700001)(76116006)(26005)(186003)(91956017)(4326008)(8676002)(71200400001)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjR1aFA4dVZGeWcza2hibXJjTGdIYnhCVVlnaVRTcFZTN2d3WWVlVlZhMDhV?=
 =?utf-8?B?RHhPNHZTSEN2NG5Nekx2dmxCOXRCeFZMeHRHdHRMMVM4OHNhRHVzOW82YVMz?=
 =?utf-8?B?bzJMb2ZrSDJxRXFXL3RtVjJYRzJMbnhBUmZBM3RoWDgyN25Zd1ZTZFlJMGRD?=
 =?utf-8?B?TnN6eEh6UjVPWWZPTVVnZU1kVVFPbGd3SnhLaUxEWFBGd0JGenc2VldhVlJZ?=
 =?utf-8?B?TjBlenYyUGorOTlnTHRpbjFQcGlUZlBtUXYrQVpySTA5UWpGdmxEdTVjTkdz?=
 =?utf-8?B?VTNMUE1SRUVkaXl0YzhTSUxZNVpTSnltV0dBajJkZDc2ekVyZTZhYzhMbWpn?=
 =?utf-8?B?NDhpK2FHOGZhUkc5a0pIcUd3eXBvMWhQajc1Y3hjVTg1eHFsZTZOZUNBLzR3?=
 =?utf-8?B?bXA4M0NEdXc1MC9JMzI3d3dtWkV1L3kxQURPcWdQRnpBd01TSWFVVlNzVGMy?=
 =?utf-8?B?Q3ZLYWMvWnJzaUNQMHZ6YUw2ZG4rVEhHcFlnNm0rWmgrcFVvazhBcEFSVGdR?=
 =?utf-8?B?THYwWTRRVGJkV3N2Y1pVZ2pKZWU5Yzg5WUtZaTFUOGQzNzdSUGFYWk15ZHU2?=
 =?utf-8?B?UGovL0cwbFNQNVNvOVZxTy9tdnVEbHBENDhNNkRBK1ptcjBUNjlMN3RvUGdn?=
 =?utf-8?B?Y3p6MHloRzBvK1M5d2hmT0d1M05GbU5FY0E0a0drNWo3MW1KazI5cDdPRG0z?=
 =?utf-8?B?VThVcDN4K3Q2OTBJVXpkeDhlREtTeFY3bmtraXdTTHA1bWZRN0ZRa05HNmw0?=
 =?utf-8?B?K0Ryb0dJMHhFQzBSOW51bUF4U1ZvYkQ0U0tuM3JnZ21MWTMrdW03eVhITTJ1?=
 =?utf-8?B?UmR5Z1pnbklzSUNMbkhQZHFmNzlrNFBsRnAyMTdVVTQ0Q0V3ZXg0bUxwZ1gz?=
 =?utf-8?B?cm15REtjYTFJd2huSk15Q2J4eGtUdENxT0NBRWU2bzUwRHNkbWorbWtIT1VD?=
 =?utf-8?B?UEs0SnlUZlc3a3NnbDZwNUh0dmtzbUZESG0rcjR0bk5tVll1MHNGRS90blZu?=
 =?utf-8?B?YTArZVRCRU9KbG9lOUFLWjdVS0dLNXhkY0wzNjZYM0hhQXNQQm1qTE12ZS8z?=
 =?utf-8?B?SU82QUtFelduaHBWUVZUSUgxNGp2clhyYjZLTW8rcnZjTGMzNWZzYmlTVVpJ?=
 =?utf-8?B?RWEvOHlmWDJFTGlndzFOY0pOcnhiWXJlVjRaamhxVE1uMExaMzdETmFhTUpP?=
 =?utf-8?B?RTFsMitHVldZcy9yWHJhdGVRRnFzTVNVSHQzMUh3YndmUkY3ZjlPTlc4TGVq?=
 =?utf-8?B?L3pzdEoxTXB0TjltMzVjRmJJVHc3QXExNlRwWjFSOGhYOW9RaHF2bW5QVnRj?=
 =?utf-8?B?N2dxVkFlRzdaNDk5emZycGtCVkhQeEdQdXRNd05KeWdWcjhRUUxGWjkyK1J6?=
 =?utf-8?B?elIyZy8xSVcraUlobVY4R0hoaDlPVTRncTZyTzF6c3ZMb0dBendiZDBMN1Y2?=
 =?utf-8?B?UWFuclNsY2ZwRWJNUUpadzYzWjdJK1B6d2VncGs1S1RYWXRudWJUcWZaNkJ4?=
 =?utf-8?B?bTdpUmJjN1ZXN2hRNVNxNDJwOFZJVzd2aGlCUUMxYkxHOXFYNkttT0xQcVJJ?=
 =?utf-8?B?b0ZZdHFtZGJtMHhrblVSc2ZVYy9hKytpWlVRTzVmYUppdFJzUzR4YzQydi94?=
 =?utf-8?B?dHdYNVJpd3N3L1pZOXRHaUxDMG1KaldyNW5qdHFPYzZ4OHVPWVNpTERlcWVm?=
 =?utf-8?B?SVhIOFNESGRDZzZTNmMwbkQrZ1RNR3U3Wmcyam5CMGpaNzlIWE5hNlVLVURV?=
 =?utf-8?B?TFF5MFlwNndseDN3Mm5xOW5aSGY3YzZsSWRVMS9hMWhUeE9ZMGlrVFlpR0VR?=
 =?utf-8?B?WXFSSDhReHByMXgveWlERENkb2ZRL1NHeGk5RXV6Z3ZEaWh0TmtQdXdwS1Nu?=
 =?utf-8?B?VG1xS1cwc1ZpbExqdlQ1K2RuN0FHTWhtZHFUSGltY2o1bEp0bmVyaWo3NEVG?=
 =?utf-8?B?Szk4RzFHRm5KTzZmRWMxUmkvakJIb1FCSW93cCtRMXNObUdyQUtkSXVXQTlI?=
 =?utf-8?B?ckxYWExwTUt1NiszMDlHc0FTYVFxUHNtZXY5RjVpaTA0eWhGYmd1em5nZzFx?=
 =?utf-8?B?Q0hTVy9IbXd5STFmVTVRQlN5U3pQaGdNQUVzTXhNcFA0VUk2d3NqamxRejU0?=
 =?utf-8?B?eTg0LzlIaEZONWpnNmk0cnhVaTJsMHdSMjNRcTg3YlF5L1lJMHVpdUpqaWRX?=
 =?utf-8?Q?bVp5fBKajL4ANI3DGvqP7X8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1391F859E9CC2941B6D0B0DE3075ADF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?djQzVDQ3T2FvMHNBaDJTOXBMeDJOL1dza0Y1VHFKQzNkeDJXTTg1Y2cxY21j?=
 =?utf-8?B?Nmc2QnlaNG5jSXloVGgwcXN2cmh3b0lCQitISFFMZWxDYldISXBmc1ZaWndM?=
 =?utf-8?B?ZUxoZFFPRE45M1NyZzAzaDRYYjdjZjBCVkY0WU9LcWNBZWJiQXdlSFkvY00v?=
 =?utf-8?B?alJERFN3SXoxZkc1ZkgycXplUTdxck9NMjVpd1JaazQxaW5nUnBFRmo0SlNT?=
 =?utf-8?B?VWgyWi9wSWZrYUEwaUhQY2pjR29aTGtMNWR2TG4xSGw1K2VSYlhiTG0wWnMr?=
 =?utf-8?B?bzkvNHh4QXZvTFY1d3lOTEd1enpzeVBuQ1ZOa3k5V2tYbEFKenhGRGQzRTY1?=
 =?utf-8?B?bWpDS3ZxV25wT3NpMEc4TXBqVEh4b2JNWGhwVGhqSjhKSWJJWCtIYU5qMkNL?=
 =?utf-8?B?YXI0WS9BU1VJWFF4dUpHOVl6RUVLbjZUT2NveGNYVnNGNi9YdTYwT3ZNQ0Nk?=
 =?utf-8?B?K3VpOStPVU1za3ZGb2ZpZ3oxZXJLZk9hYWRCenVVYkRjU0w5T21ycnFXR3cr?=
 =?utf-8?B?R3F0ekdueDRPOXhlZGpUTGxOVjE3MXZUZUllMDF6ZGxCWWcybG9wbjBZZHlM?=
 =?utf-8?B?RXNyelpyRnl0Ujd4Vks4ZlhzcmN5NENUVE8xVDVZcjJGajkwYjl1dkdsZE1P?=
 =?utf-8?B?b3J3SkNzR2FaVnNtYVdxaUZtQmtrNXB6bXBEUTIzQWFYZXQrQ1k3K2FWNlNl?=
 =?utf-8?B?YjV2SHAvSDRlMlNON1crQU9JRVFRRFVoK0xFY2NuUUZxSWE1SUJ4am5iY2h2?=
 =?utf-8?B?TXVyWEM2aU9MSG5RR1RrdG9nNWFIbVlkcHJGQnJwZklESGdKcS9SUVI5YndL?=
 =?utf-8?B?UGtsSWVIb1B0NmtDNndoYXl1SVNIN0hXSnU2Tm81Sk93N3VuOHJWaWw5NGVI?=
 =?utf-8?B?Y3gzYTMxYlpxa2JVamQ5ZVJhYlpYbTZSKzFnL2hveWRqZm9pcDZJOG13V1N3?=
 =?utf-8?B?cDNNRDMvS0pWNXdmME5Za0NRZU4rbWhIQUhuRlNWSXd5RDZ6eDlZU1E3ekx0?=
 =?utf-8?B?Ymx3ZER5MkJwckJsbmF4NEJTNUxwd20vYzB3b0RIR1hLMGFnRUtIZ3FDWldv?=
 =?utf-8?B?UzJjTE0rN1JtcWtOOVg2VjAvbFk2TXI4ejQ0MTh6eWVjcGRZdWFyRHIxMVcx?=
 =?utf-8?B?U3FwTyszRWQyckcyMFNVZVl4Nyt4K0VQZUpWMm9KN1RsdmtCQllFS2VweXRW?=
 =?utf-8?B?UzRFNjJKaWtiT1J0TTlkUkg5V0dVSk56TUV3SytHbmUrUzNFejM4RWRjN3Z0?=
 =?utf-8?Q?zMArcYT/2It9s1l?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b36448c-a0e5-43cf-3fe4-08dafe011205
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2023 11:49:37.6790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 612yUNJJH2hDzucZc7oQDDQSq8asxTbmJqHS8oeDJ+nj7o9y1Sf+zlilASuvU5d3HpBwNPeEn7wKL58oaCRRJ9cqRDyQPAqJJhwEv8w8c1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5773
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
