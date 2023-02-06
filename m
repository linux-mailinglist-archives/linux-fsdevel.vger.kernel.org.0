Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B74168BFF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Feb 2023 15:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjBFOYd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Feb 2023 09:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjBFOYb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:24:31 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E92707
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Feb 2023 06:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1675693470; x=1707229470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4I1xdvD7W1bk+S12g2r6mppriWw4IDV+BvN0UaC2kRc=;
  b=HXh+eQj361cKUnihYY9NfvpJbPbpw4fsyVQoHQOOvqO0LWlCtUYzliNz
   qJtNJQI6Zyl4h0VJcY0sGRqhTUGQuG5h1+HgqQzTKSq4xtToZV0z9e11R
   g7ScnoNYPuw/mSwD9UImSHX7Tlu39IfsCDLy5kzfTmiC4+0dQzsfts7tG
   wDAXyYtp5C0Rx45aDCYdY5mkbBhM9NKLnnIfZk0yKwG3Jb4HDoTJXPZeq
   +zyUR88uIPHFUaIlpPaxyhYxVh3T2VIZX9Go6zgjyS9KvmMeCxDBa8Qr4
   WNQXWKJCx0dxloQxTd8oF7ug2ia5QfZHN1whPw+k7K7n3iYZlXOw5td/N
   w==;
X-IronPort-AV: E=Sophos;i="5.97,276,1669046400"; 
   d="scan'208";a="222418861"
Received: from mail-dm6nam04lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2023 22:24:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRvGyaaSkzr/Q+BPzacX/ras2afhsLa2EwvVaX8zGfvCp9ZAH6YRRNwsLtGtCUpaDQch+L22bZ7vaii6GdI7gG3Yb98WVxnrwAo3DKyYtK3ntiyUHn+dPcIpuUpLGEOaqrfTL7MhbRphDVrk5k1aCr+ySFfaWHRfpsX3FDq0bX8GhtwZiaeDiH0IXFQNga36MsjRNsVgVnIPmVnDWN5LMwvwV92PulS2f13F+1JWjBLteW6Vt5c1zABc1CvG/AM0VPX2pEDwG+ezVlmT84pJoSSeaz1YmUfc0nisS1+SPF1oLqudBSGA5cJerIxa5cpk2DY0W6VDH27FqzxkV1vcmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4I1xdvD7W1bk+S12g2r6mppriWw4IDV+BvN0UaC2kRc=;
 b=aOtEwil9ZDWn/oXPCTYJReyU1xpHClSPDLxx8ow9Z2V8pA+UAvz0UA55w86lHtWc5WhF6pvB/bndL941Y9kJjrKhjgH+AIA7iKaeCoXKriUqcPozgLo0htr5nP7T5g5v58AjrXj9Kb4D//q9A4NdCbwBS1cknj+8e/1qWY6PBHee6DLTHhDnMD0f4CxCn3V63qlL3vVHZqIOS0LsB46owSiPbC+s/tEVyQw/2NYlkSJXVDJkOWmGlR1EAqKSdf14J31Ur3q2+ysRHjHnHRZJg1n9yuE5RlHxPcpyMY9NDVVbQz9zufXyi2WfgyL+qluz+7dgopHDpRSK45lbolherA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4I1xdvD7W1bk+S12g2r6mppriWw4IDV+BvN0UaC2kRc=;
 b=ianrV0iVMIsv0H7QVomJiDOjZy/TWFSLn6EM6Pq8jq9kWUeo59XhwJ1lqKThpv0dDDEKLWk3q+vx4+IbE1bdyH1F7qT/R3Lvgg2MLhTQYrNMaVL+l6nRDOl1ePmHI+4TLOBJR7mn+F1c9wkNfW8z8OiCX5YdECYh7NdMYgDFMlc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3890.namprd04.prod.outlook.com (2603:10b6:406:bf::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Mon, 6 Feb
 2023 14:24:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%6]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 14:24:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Dennis Maisenbacher <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>,
        Boris Burkov <boris@bur.io>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Topic: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Index: AQHZOjDDUZpAXLX4TUqlcfdOqdocu67B+QaA
Date:   Mon, 6 Feb 2023 14:24:22 +0000
Message-ID: <22843ea8-1668-85db-3ba3-f5b4386bba38@wdc.com>
References: <20230206134148.GD6704@gsv>
In-Reply-To: <20230206134148.GD6704@gsv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB3890:EE_
x-ms-office365-filtering-correlation-id: 5aa60cc3-8d08-4717-a8d7-08db084dd77b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: foJEF1FYu5pBAGaKUnW1HN5fWlPlOghWMgIdZK1jMTn5wwadAQskEDVqrld1P1vzDE7lqd4us9la1wXkqIA7DF4jXm0P/mgedPNbzNpKC1619NKA2yxZrGruRoB2k8tMH+ZsZp/1odx4k68sGm1Pn/ZxSJ7ykaetVre+o3VvrWlpeikdZSfLlJ4/8W/pojHwjTWDH0DQ9vRBlLI4ZMfr0g/IavPxlMA52sq8hT3KETM7kFDyOl9KcLHhYKo4i9ojS5WsA8FaixtDpIj9ANkvPFNzxai2KzepSH8mCUAz81VIQ06zqvnf55gEBmYhue4B4K/2QyT/otF1bSaSEfqyzGqYnF0Xib5TlBRqOUyF/3QuC0xQKFA2G16TuH/bZhYnx5dcWRi4WASWWX4K9teOOCB3VpQFxf8uJSNf03lCBRSl+HUJmQaU247SK9YYR8hGvxKFgLzQQbuxZso1B9HkeS9blmh9gym4IIMYE+qIqaDKZI0zhtgRf8KS0vORnZw1UcwAvxdli7Un2Fyye0SxX5hXQXOobVROjsipYxTYLQaIVqzb7WIiUKn/VixGEA71RtcGoBLZUIMr3F/aWYeU+ivtb/77CM3SuxOHkcZTBHgCww71Fs84j5EGbWxpT54ArLXBUWQYegCAcrnlKp+GNe2Usf2qutJj7MmUaOIhbp9Je1X/kLR0lgQRevbDVoIYgf56XNJxPWVqC8zdIa/HcU2equRr7iqf6ikmBWJJ7UMFngL/Wi3ErgEU/WCxLKmV7ErM/d4ctrBtHfgwByZGv8eXkhJvGHt81PFtoiFhCeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199018)(66446008)(478600001)(36756003)(76116006)(2906002)(66946007)(5660300002)(966005)(4326008)(91956017)(122000001)(64756008)(41300700001)(8676002)(316002)(54906003)(82960400001)(110136005)(66476007)(2616005)(6512007)(186003)(71200400001)(4744005)(6506007)(7416002)(38070700005)(6486002)(53546011)(38100700002)(83380400001)(8936002)(66556008)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0xpeGJyNmpQYzF2b3lwRy8xTEdJZEZTdk1Mc1NVdEhUaWxnVVFZVG9PcnN0?=
 =?utf-8?B?RUZYaVdIRVJxNnpwcWdRUjMyVE1qUkFnanFXR3JWT2daNHVNYTlPUXFlRTU4?=
 =?utf-8?B?WnErYXJBUmk2VGNnamlTVTJicWhxSmduWGFKZi82UzNYZTBGUTJZREhVOVgz?=
 =?utf-8?B?b0lJZmJqK1RyZWZpVEpYQzg1WURVV0pmL1BUWnN5ODZ5MU9DUUV1SG9zRzFX?=
 =?utf-8?B?dXV3eTc2U21NdUtYTnQrdEZka3pvYWl4S1BWZDU4ZDR2MXVid2d1WEs3eS9X?=
 =?utf-8?B?WWM2TWRES1AzdGF3ditPMWRCUDRqbjlLY01ZTUJtb0QyWkYyOEZhRk5rU1FC?=
 =?utf-8?B?KzM5QTJBdnpqOW5PMlJuRmFiM0Njd0Mxdnl4dFRQdHBMaVF5S2lRczFyaGUw?=
 =?utf-8?B?bHV4WnIrZC91SjNHT1F6SmZkWHkwREpLY29MRHN1a0xMK3Q1SjBuNWRoRjIy?=
 =?utf-8?B?SGRHMmZFek5DLzlVUG95WkFTK0NMNXRTQktNLzNpTzdQMVZseUhHTFg0Lzl2?=
 =?utf-8?B?bFdqZWwvZUt4NEE1aFRYWHNQeFd3blpSUWF2eHpyWk5UbVBFbW5MTTZ0WU9t?=
 =?utf-8?B?c1hFQzFFTlFydkdXTVBicEZsbWhUSGJ1QUxGSDl2UWl4KzQzcThhS0lrTUNZ?=
 =?utf-8?B?ZjFtL1VhUVdOMzc2ZEd2eHpyRUtjeWxNMytrQmVmOHo1dW83UjM4Y3oxMVV3?=
 =?utf-8?B?SjlNcHB6dGlNU3hCWUlrQ0FqS0loU0NCS2FQSGZWQmpXZ3doTmZQY2FjOW5z?=
 =?utf-8?B?NVRDeVBISnV3MmZ5d2FHNDFreDdNYVJFYmF1UGxOc0lyQVJDQ1p4NURVZ1lo?=
 =?utf-8?B?Y0djRTQvOVR2a2V3QkJLR04xN2wvdFcrbWJHUDgydm5icnphUWo3bUhQYUdn?=
 =?utf-8?B?TTlmMjFNUGtoaWxuZzVaVXBFaVYwWWFMUE5ld1dLVlM1eEJWYW5NRURHeGRM?=
 =?utf-8?B?Qzh3NnBPRHM5RERhUWtBWFFwcFJ5aWVSVG1qNmRVMTZac2N6cUtmUHE0cTlT?=
 =?utf-8?B?OVFCNmZaa3AwS1cwaGZzdzJVUTFxemFrMmp5cXVIR3lidi9mMTREcEQ4WWwz?=
 =?utf-8?B?dFJOdU12czJJMVJ3TFdJVlNvNFlSUDQ1a2tuQWQzRGpDL2ZycWdIQ00vSEYw?=
 =?utf-8?B?MlFpOVpjZmlRUWZtTUZIbW14MFpzc1hGcjJwWE1zUksxakxBenJYZWliVGF4?=
 =?utf-8?B?VDJ3NG83cWtkSHcxeVl4V200dlJyWlA0cHAvbEhzRmhLcHBvalBVY3Q4cEZK?=
 =?utf-8?B?Y2ZydXI3MkFsdGxTNks4UGFRcXJWQjYyOGFDbTZGeFp6MUN6TnZkTVczL2I3?=
 =?utf-8?B?ajBSSmhsOTZ0b0U1c1U3c3ZVNC9abzY2cHJBb0VLUkpkRkRQQXhjeEUrbmhk?=
 =?utf-8?B?ZEVTMitMczhwSGxocTh0eDJheHNXVGgyV0VOeW1hNkJwUGRvUi9mRk4zZnd3?=
 =?utf-8?B?eStPUGVuWUZJclAyektmZER1WmRtdG03Yk5ZK1NlNWw1WVFCNHR6T0ZJeTFT?=
 =?utf-8?B?WFJSWjExTVhWZ0RXUEQwakhlT01qcHZRVGpoQmtXWWFEbUoxMUJQZlJPdVd6?=
 =?utf-8?B?R0RnNS8vbWxTREcxa2l5aEs2MlkzckNMRW9ReGdqMjBaRndad0w2YXMvNjAz?=
 =?utf-8?B?Tjc4QTFaRGk5Y0FMYVJYUzVqSXBGWlJCRFlObjczVGwrcjVSc2ZLRldFZmIy?=
 =?utf-8?B?dUk2cWtleGVINk5LVkdkTlRQNk9DQ3liWUZyR3ZFU3pYRG42UjBGeXpXVml4?=
 =?utf-8?B?Wnh5UFZ2RW00NDhXSjB2Y3hnZkFmZFRORUo0c1AzdVFjYlZwTW1EOEVqWjJh?=
 =?utf-8?B?OHRyU2ZFSDMwbVVsTTBiUjlZMWVCNTdrdXg1SncyVWROY3RWa0lmaGZoclh0?=
 =?utf-8?B?cTJWNTdmZE9YMGY0SVVYLytoVEFzNnFITThtQTBpaDJoR2ZleHFmZW83SEwz?=
 =?utf-8?B?a0lCaklzRkFiaEZVekw5N0dVRkE1b0hmRURZcERWcTJiakhuSXUxK2NHa1gz?=
 =?utf-8?B?a3JpQ0dXRUVCOUtPc1IvdG45VzNHekR6bWM5ZVdZTmtKTmt0eEVZNmMveU9D?=
 =?utf-8?B?NEdGS1o2M2JRMEt6T0o2M1ZNdk85N2dDbFVXTy9OMGl4WWgySFN0czdaZllX?=
 =?utf-8?B?RjIrWGlseitmUUsrNWVrOXRTZjE2aUJuTlJQdDdRMWl0QWg2N2RHNGdlaTdZ?=
 =?utf-8?B?VC80a1RBZ1JwcXE2T2F3Q1JTdllEOWdsRWhCQzFyUnV6dVNLZkl0cEVxUFZh?=
 =?utf-8?Q?v+itx3kGALcJdEkzW1pMi4UvxIFi0jnIN+qwR0D4p0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <072AA2946923054EB697361922CDDFDF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?L3pXZmR6UElLdUF1VFNnSmJQaDhqaStRRS81Ti9WY3RPelpSZUoyQUZQZWp6?=
 =?utf-8?B?RDIxQjFRNTlFbDBIbzVEM3Z2VEJNODRGdnpyMmNwNXlOUUdnUWtpbDJFTVV5?=
 =?utf-8?B?d2NFbkZsNTJLT25kcUVGSDJ1QlRxYy9vV2d0M3MrdTZwYzNxS1kreWZJV2Za?=
 =?utf-8?B?MU1BaTh3Um1lZTBKdVVMTVNBVUNsU0c2OUVibWNYbmd2aG9SclA0UGRLanp5?=
 =?utf-8?B?bzF3UHFrb2lueHhib3lZUm1XT0tNNVJXWnVFOTJaQ1hQMTVSckZUZW5wc3g3?=
 =?utf-8?B?VzNhbkNnZC9hWk5RZ2w4OXI2TVJBdzVWaWszVjhIbHBJRm95T2k5LzFvb0Zj?=
 =?utf-8?B?ZVdGSHhuYzRRN2E2YnkveGdpbzR2K2RQbTJyV1F4cVdEZGwzL1ZQY1k1MDhG?=
 =?utf-8?B?d1JJODhjNGFqbHh3OW9lYW5JRGRsUk5YUE1hN08vRlhWVGZSUzd6RjlZaEZB?=
 =?utf-8?B?dEtwRU52R0Z0c3kzS2h0K21BLy9lVVc5azFuT245S2l5WEh5KzF4dTN4Nncw?=
 =?utf-8?B?L3dTdzRoampObkVMLzZmV0haUXhLbytUK2RrYzNCNFU2MmttUUNFTHM2VjEx?=
 =?utf-8?B?Q1M4YmljL1E0bXNBbG1CZ1g5KzQreWZ4RlRTODNLWllhYTMwbk5QL0FUTjBQ?=
 =?utf-8?B?QUgrVnJBczdPOUlSRU81NlU0Um1Yd1ZmMWYrTVFQZ01oYzgzN3h2VHpsbGJJ?=
 =?utf-8?B?aUhDNGVXZjRYNm5BSHhnVnpLTXZvYXBObGFoZmwwQ3pMVEQ1UTBha1J0QklQ?=
 =?utf-8?B?UGh4U3NFajBrRTRQL09wY1JLUGRSek8yeWVHQXl5M2NBcnlPUVZibE9HMHdJ?=
 =?utf-8?B?WVdEVkV2czlzbEJkeXF3anpBcGdBZGg4ZElSaU5PVVR4TTJFN2JxTXpxMENT?=
 =?utf-8?B?RkZIU2ZrMW9GQVRFUXQyT0FRd0lFa0VkVWZhQWI3cSt5THFLUVN3enpuT1ZT?=
 =?utf-8?B?bGlUN2R2VEszaGUrbmJFK05wMStTcHkwYzZ3YkhmUEk5OTdFTE1VY2VNU3Q2?=
 =?utf-8?B?Nm4ybUJ6UlhqTWVURXh3YWZXTVF1V2JhUGZpbHluMTZvd3BPaUtQblZIMnN0?=
 =?utf-8?B?dHZoNVBPbUo1TzZsVUYrcUFoSGV0OGVrY2hLZ3JJM3ZXdjJIWmlNUmJQYmpU?=
 =?utf-8?B?dkNKYnVTdkd5V1c0Q3VMRkR4NkNGcEVpTms5S2R6a0tVQjA3YTVRM0N5V05n?=
 =?utf-8?B?akJLR2trOWlvV0c1N084UCtKYWZHZGtTSHd3VHRRSWh5UHZmSHRBc2w4dDQv?=
 =?utf-8?B?M2JiQUdTVHVOaTVETjdTNzZhdjg1Vy8yb3A5azBrclpkajlPelh2blNrWkt3?=
 =?utf-8?Q?6Or2kI3hFYZ3A=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa60cc3-8d08-4717-a8d7-08db084dd77b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2023 14:24:22.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyBQNEhVChe2hy7xT7WoIBgEPn2mVo2G8GMcgc5bGZuwyCdXC0BKhTfqEiTLn6PFW6Rvh0jY1xIKlBgm7Jro1oGwsKjoPJNWCukeEjV5iVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3890
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDYuMDIuMjMgMTQ6NDEsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+IE91dCBvZiB0aGUgdXBz
dHJlYW0gZmlsZSBzeXN0ZW1zLCBidHJmcyBhbmQgZjJmcyBzdXBwb3J0cw0KPiB0aGUgem9uZWQg
YmxvY2sgZGV2aWNlIG1vZGVsLiBGMmZzIHN1cHBvcnRzIGFjdGl2ZSBkYXRhIHBsYWNlbWVudA0K
PiBieSBzZXBhcmF0aW5nIGNvbGQgZnJvbSBob3QgZGF0YSB3aGljaCBoZWxwcyBpbiByZWR1Y2lu
ZyBnYywNCj4gYnV0IHRoZXJlIGlzIHJvb20gZm9yIGltcHJvdmVtZW50Lg0KDQpGWUksIHRoZXJl
J3MgYSBwYXRjaHNldCBbMV0gZnJvbSBCb3JpcyBmb3IgYnRyZnMgd2hpY2ggdXNlcyBkaWZmZXJl
bnQNCnNpemUgY2xhc3NlcyB0byBmdXJ0aGVyIHBhcmFsbGVsaXplIHBsYWNlbWVudC4gQXMgb2Yg
bm93IGl0IGxlYXZlcyBvdXQNClpOUyBkcml2ZXMsIGFzIHRoaXMgY2FuIGNsYXNoIHdpdGggdGhl
IE1PWi9NQVogbGltaXRzIGJ1dCBvbmNlIGFjdGl2ZQ0Kem9uZSB0cmFja2luZyBpcyBmdWxseSBi
dWcgZnJlZV5UTSB3ZSBzaG91bGQgbG9vayBpbnRvIHVzaW5nIHRoZXNlIA0KYWxsb2NhdG9yIGhp
bnRzIGZvciBaTlMgYXMgd2VsbC4gDQoNClRoZSBob3QvY29sZCBkYXRhIGNhbiBiZSBhIDJuZCBw
bGFjZW1lbnQgaGludCwgb2YgY2F1c2UsIG5vdCBqdXN0IHRoZQ0KZGlmZmVyZW50IHNpemUgY2xh
c3NlcyBvZiBhbiBleHRlbnQuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1i
dHJmcy9jb3Zlci4xNjY4Nzk1OTkyLmdpdC5ib3Jpc0BidXIuaW8NCg0KQnl0ZSwNCglKb2hhbm5l
cw0K
