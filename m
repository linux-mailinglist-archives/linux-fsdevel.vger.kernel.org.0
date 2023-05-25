Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448FE710AB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239801AbjEYLTF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjEYLTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:19:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A1A10B;
        Thu, 25 May 2023 04:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685013542; x=1716549542;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=NIIkflf/uIdwVObreTKaERxvKRnOHD10zCD1YWa4MeXQAMJcmPUoHK6R
   Hxl+HZDqu9mffTxMLdyn8Hbin1dWaYYfV18c5GMePCERWvma2qm2EMusd
   aQXoHtZgn2emcwPaSaV1ZyE0xBfS0H0shrOq5bHeZ3OaSKKXZ2FOPFTaj
   RmE4TNos+hqCGIgAlHQte5eW4QlGsPPjH1NLJzyHpRXksGs4U851Sh6jg
   sfcvMpDoTXPPGzXtLiEF3iFgv1zspQlzgkDsZ4v+OS+dVoc/3NW2+dNfz
   4FnX+dkq+QFzR6spWW/6zjPidY7tPT2XhvcMdnaLBZb0ZvEqLSu1PRYr1
   g==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681142400"; 
   d="scan'208";a="236563289"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2023 19:19:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bjvm7x1Oh8m350uOkMwTJAD4VoFwHyODzAZvbgEHtpJ3J3kd0/+KKxK+4VNLHdbiwPCNuO9nE5RejZJGjgkISz8ZAVH8cHrr23yYdxFd1vf8Fk3/kgOxOUn51nzBsqrv6MybRt5fEotu/aU+yZ4k2UX5kh79tL18OuQjpoIGe3ljsttJytfXoaVd9tMVTmRwO9N1h9+99CLwgg93rdW7MPc0UzkrtoN2kgaVgCOeeVt68nfK2R07WnmV7e96ZVMgKAAQKQm5JyFGdTqn/5dC9jdhcR9HGAIk9RpcAxVevBWOv77eQrsjztMUVBslfEEpRzq18rzLgQOWRtjkYEuhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FTW8zAOL87Ktmjytm9oJvApRIin7iYqzbN2K4+ga+A2936K/9AVmcIT3mGg0qoQzf3bQqiXzM3GXGzwN0SDTWik9to0K3DYkc9/UJ7B98l8Uh6HeleOU7OS9W8/LJCepUpA15NkZSnRVYERjR7pURQYopVzpuw9H2QwFPjTMk3D1R+xjc+5glKjlnpT6Fy0LPPBGCWTrVNP6WW6nK9UZW1cYVzRUj5YjVDxRrTJYH1Hmih/aKHEp8pGIkjsv54+pkTbdgG+btbiyhEpsm4UNaz33v41szL2/3QJ9AME5aa4DJJYKAQtCuFSE5rXEB9pvlcz6jGouXVVMZeSxqyKGRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=WESA5j3F34NEb2KLTfOJKrU7hmL/ejMqrJ3UFkFGTxP8DNzSuQ/sDrpYU9irhUIllgYD1qR9CDX73BJ3OWxrpXroJ2eKIpT0Uu8TsoBlojP/ePb76W0ZdViZKH8BZRHHwurZHTiGLeiMcl5yjJ+DZxY6BonHDkQQ8rHZLxoss0w=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7454.namprd04.prod.outlook.com (2603:10b6:a03:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.16; Thu, 25 May
 2023 11:18:58 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.017; Thu, 25 May 2023
 11:18:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Howells <dhowells@redhat.com>,
        Damien Le Moal <dlemoal@kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@kvack.org" <linux-kernel@kvack.org>
Subject: Re: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
Thread-Topic: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
Thread-Index: AQHZjuSTu6O3Xd/gPUiYENMZPzTD7K9q15uA
Date:   Thu, 25 May 2023 11:18:58 +0000
Message-ID: <e94f2cb0-c9e1-076f-a1af-1d3236a6bd55@wdc.com>
References: <3788353.1685003937@warthog.procyon.org.uk>
In-Reply-To: <3788353.1685003937@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7454:EE_
x-ms-office365-filtering-correlation-id: 82ca65f8-cde7-4993-2501-08db5d11d584
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qdJ3B/AYBcY2pizcaiYOkDasOIfrucS/EnaOk3OKInroOrjzL+GPsNAZjTEjiGET7s59GxF8pW0sqa6yEMyuom6jCszGdsGC6drFJWu7hYUOMW4zOuQ0sclqTCpG2fp1dB/LvECfaSxT8lWdYESI4mN3YIyHT2OytvlJu1LHZR4cTfElek4yJONpOc8GgWsbSh5pT1z2xio9COaRc7fBxp++vl7FRWGxr/ZSCtbQHDZP1+brk5qnOgXRiJt132NYz8nyD8LRsttV/YfATCxcnx+sdA2+mbgpiJSPWUY9HUaxego8bzuUbFAfwjW8SKyTsAhqRA3a5gbjYRtGRi24JxsMKEehYKQI/985S0jstNXGiwGe5RN12pYXbR0xqah2x5gmYoq8Zn8ORuDRcnpNvsl9WAnONq9WN7RmXUVzhWak/vO1SPledOIdiYf0xLw1iFQ1NBiSU2LqGvlaa1B/LwFw/x15hBHbnRc6ipvJAQpImtxJhFzROloQFWy/a4JteVFbaEjZ9wBSTAw6tZosf6WFOUN4QSB8d61Yvp+ihoAXKbEjgm60cQ3TgIsCsZXm0efWlMkmuqGL5i7htScihZI2qEKl2hTe8yCb7Cy9kxLE7/D63TgaLXNDbpnAjYJQHCGNFE/jqmU7Yru9yDjeEFoV6SQ3EVt81IADefNosc9Qwy1hZmsHQOrEcrmxNlkL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(451199021)(4326008)(36756003)(558084003)(86362001)(8676002)(8936002)(41300700001)(6506007)(6512007)(186003)(26005)(7416002)(2616005)(4270600006)(110136005)(5660300002)(316002)(54906003)(76116006)(38070700005)(66556008)(64756008)(66476007)(66946007)(66446008)(31696002)(71200400001)(19618925003)(6486002)(91956017)(82960400001)(122000001)(38100700002)(478600001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlpsdHFMcktPcU5YVTNXdWJDOGhOV0hGeFlROXZTSkJyT0puQzF4ZFpZWVkz?=
 =?utf-8?B?MFZSTnlmMi9vT0Z3OUlWcGcxWnEvVEpoV1F4ZTBNWklCaUxjZ0x2blpwL3kr?=
 =?utf-8?B?c0x4NW15MTh0MG4yU2FWOCt0ZzZOQWRjZDB3WTlWYk41L0IrcWVPcStvODJm?=
 =?utf-8?B?SzZCdnJhaklNMy9Wd1RyVGZLb0RGN1AzRmZGNTF6bXhSK1krK0U1WjMyWjhD?=
 =?utf-8?B?c1ZXMERxMFhqNDgvSXBVajJtV3hYNVY0eHpyVDZHUlhkVjRqc0c5aW14bVdG?=
 =?utf-8?B?aWU1MWM2WWgzNzQwclRoeDBqeUh2WXRZZk4wQ2FzOEg0T0svMTBNSGJtUjJm?=
 =?utf-8?B?SThLK1daUHNxRkYvcnFNZlJINHVrMlVYVldidDVQaU1MOURGVmxkdVdiQXdX?=
 =?utf-8?B?NEEzL2ZRa0pzcmF0bnlBY1hMeXZzdkFzT0pjMVR0cDRCNVNrQmhPU1g5MFla?=
 =?utf-8?B?OFp1WFlRZGJub0FZRGZjSStESXVZV1BrUTNZM2tIdGpxbWphTWdOT1JrbW1Q?=
 =?utf-8?B?MEZWcHVveU13SFlTRnU4OENoWFpGdXFURm0zSWJ3UDZiaXF2bkd4UUJoY3E4?=
 =?utf-8?B?VGFQMUN1RlVZOVFaUXdoNCtkTXR0ZTFjOVRSNThicDRQRE90bm5TY0xhY1NW?=
 =?utf-8?B?L0VNYVBjVUJYcFRGUUZ2czhMWVhjQ21wOXNGcUplLzdxS25MT0ZEa2F4dFV3?=
 =?utf-8?B?Z09iaWtzNXJkaldyMHRNN2gyV3d2UVUrdVNJOTdQNHVRYVY1dE00L3dZSGpW?=
 =?utf-8?B?NW52NENNTnQyUDZuNDRSa0UrMk1FZi93RDFVTUZ1ZW9Oc0N4NnJ6YUhHaE1q?=
 =?utf-8?B?K3l4UVhyZlVRNUFFRktmVExFcHhwSmlxbW9HMXVURDVJdTBhbys1TGdnT1dF?=
 =?utf-8?B?OGFCWUpVY3o2amNPMFJMOE5mR2tCVlUyK1QxSEovSm1ha2xvMitKWXBsYUZN?=
 =?utf-8?B?TzJvdWlTZ2tKdm04ZnF1NlFBdXpMbGREWU5YS3lDcXFhb25aVHIxZlJaalRh?=
 =?utf-8?B?M3JLNkVlY0IzYzkyZDZvRUlJVitCeWRkL1B0a0cvUG8yOEVjdm5jVFcxeHc3?=
 =?utf-8?B?WEJCc3U5VWFIcjFiS2RxNUI5dmJBU3VSdk1qWFlNdktYTys3RURNNzBDZVZK?=
 =?utf-8?B?THZxNGxPdWdBN05USVFITTZtVVQxbnpjNDhFTXFTMy81aDhKSTdEWEZWRXFE?=
 =?utf-8?B?SERYdUpNYTB1VDVvNXZNTUFNYkFCMWM3WTZOclpSNHhmaHhhUXJqTVZFTHJ4?=
 =?utf-8?B?ZzJpU3c0bTJnNWI4VWxQeUVIcjRyL0JkRHY4TXNNaWRrT0lKNW50dURxUUF3?=
 =?utf-8?B?eThRM0dNYkpMN1dLcmVMNVphM3BWV20zY3RCS3F5NEpXQ1Zid0w5NmsvMUl1?=
 =?utf-8?B?KzUrSnIycFpDOHRiU3EzcWxSM1IvdmlwdHpHRWI0bWZjcXROTklJb1RxMVFn?=
 =?utf-8?B?UGJ6dWV0SDJkckczQXhLVCtUMHdXVkw5TWlrUUNXN0h3RE1MdVZnU3ZiaHl1?=
 =?utf-8?B?Y1c3MkhGYTQrYk4rKytzREFzaFFUUi9XUTR5ak1scG5pdkcyVUZjUitSVVM1?=
 =?utf-8?B?T09sYjgrd0ROYURlNmNFN2FTTktadFJRV2RpRkZiY2VFWFhxZ2xmUHBrQVZD?=
 =?utf-8?B?YlFFNWdRRzBqUFk1NFJxdHk2UHVNTE84ZDlIUlZvRjVjYlFkajNNRUZvZmty?=
 =?utf-8?B?MGxoeGR6SWFFTWhDRHlUMk1aNXFuWTk3R0czQXdXTWNUZTQ2a2NvZ0QzUVo3?=
 =?utf-8?B?ckhTVW80cko2cVFxNUxiRG5jUkdzS0NGTGZLQ1RmN0JmTlpYYWo5UGQ4MVd0?=
 =?utf-8?B?YkFtY01qN0grUlpvV1BqV3Z2UTM0UHdvQUsrTnpGNm9PZEsrTkJVSk1JT1JR?=
 =?utf-8?B?eDdVelpEWkJwR3FaK0dDK3EvWmhJN215aGt4QXJtMDlIeG5wY0hmN3J6Wm1l?=
 =?utf-8?B?ajEyS0Vqd2FISkRqOHE3OVRsRDVTUjBLTTNpSFZzZkk3b29JL3Znblo2SkRC?=
 =?utf-8?B?V0lIaFQwQXE5UTdad2pVbnUyeXhlUllmV2l3bWZEcVFXVXNnOVd1TzNyZE9T?=
 =?utf-8?B?WXpucHFJNWllaFRmODNRMGZlVCtQZkdZWGthdldpcit6Yng4SGFMajczRVFh?=
 =?utf-8?B?VmwvYVZyQlhPK3M2Z2doVGtCc2ZxRU12Y29MQ01TU1JGMVN0TWN4K1YzTTYr?=
 =?utf-8?Q?XpjKZxJcUz6DgVKRL4/kzbA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89AB8EFF7C6A154280BE95C5D970B375@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WldLaFJ3SHd0NVU0d2s1R0oxbnpub2N2enE0cUt3bzZOcUxIbWdsZjN4RWRx?=
 =?utf-8?B?NWx0elVIZEc5dkFLcFpkbGNtV1RiUUdzbE14VHFaQXlPeUpoaHdhZU5maVgy?=
 =?utf-8?B?UkJRd20xQWdMM0RSTVV0WlJVQUNsZEJiekVVZENaZjBWbDNLM3R0VEVmenJ6?=
 =?utf-8?B?UHNIU3FLUXYxT1hEWnVVYTVMYm1SdThxVnBQVFZSbGp4YmtaWmtYclRvbFY2?=
 =?utf-8?B?eGdpMFdudWNKYmZWYituZzFLSHM1Z3Q0RlZ1SFlkelpyd3dwaWgrSVB1VHRJ?=
 =?utf-8?B?MTV4SlJiaWJPZitsYUFqT2lVb1Y1b0NmamJsT0drclVnaEl2RnZZbzd4VWpw?=
 =?utf-8?B?L3YwM0tqSWNhOFZIaXBTRXBGVkFwMkl4Z0JPU3NnM3p5MWNML1VTNXRucWlH?=
 =?utf-8?B?R2RiOUU3T1ZqRUtHZmlNZmlmUDk4dUt0cTJzaVdCWU05RVRZYXNXRnFJT29N?=
 =?utf-8?B?L2hMem5EdnBPSnVuSnhxL0pQSU1JODEybE4yMkNCVTVNQUJOdHpHWFhJRkx3?=
 =?utf-8?B?NjMzclk2WTl2S3YyenJsTVdXejROUUFKaUhSZWtHTVpIU2lFL0R5cXd6ajkr?=
 =?utf-8?B?MWlsTnpWa2hXS3N1aGZYSytMSDR0VzRtR1JKZU1Ob1J4MHhPcmJ4cmFRUGtN?=
 =?utf-8?B?TEpIa0o0bnFlMGFKRE5UdWJzUEg2RVdvUlZZNGpraktKbmdVYzVVU2VESXNh?=
 =?utf-8?B?YnlpY0VpMkxMK3MyUzAwZVltbkp0WjQzSldBZkZnTEc3YnNJMVQ1S21WajE3?=
 =?utf-8?B?NG5DbDBUL2F5UWlGc3NDOFhXb3NTMUZHOWdDR25Rc0lRNCtPb0JWYXJzWGFX?=
 =?utf-8?B?a3RWekNIRFhMRTlmblZTVkxqRmtVZk9HcFpKU24yWU5PUGpJWDkzRm9XSm9K?=
 =?utf-8?B?UDRHRmhkZDVJVURHb1VsNFlWdFdRd0pRemN2aytQcmJYckR4ZnJZYk45dDhF?=
 =?utf-8?B?MXQxVlVXSzRVaENsUDlTV0xYWWpNR1lmd0xUWENkZzhJUHFPUDJsbXRsTU1j?=
 =?utf-8?B?ekdGYmNhV0J3aU0vbGdiUjU4UHJhMnZHc0RTMXJkcTVVNlpQQWRRYXJ4bmJI?=
 =?utf-8?B?TENsSDJuWitEY3JhYmkySVdoM1UwcXFuV3FPOVY5MFRIMG1jY1NkS0NGU29S?=
 =?utf-8?B?ZWVVVmk5bFBHcGkxSEhXcThWanhJU2p6L25DWVhZVStkV25CckF1L1NKR0VQ?=
 =?utf-8?B?cmtLb3RPSDBBQVZMQnFaMGtoODhwc0xIdElhbFowNmFmOVBwcHl6RndhcTRO?=
 =?utf-8?B?akp3KzI0WU9ZZWVxaTVGbENibDNZYnZ0eFg1TDVFSnc3ai9zZz09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ca65f8-cde7-4993-2501-08db5d11d584
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 11:18:58.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 95lxPwZnUN/SwzAWLEdP641t3lhOBv5Qjq4b1Q2fbBHKVGyXVM3v3yUrgCnAXDKxtPD9dtwpc45YrnTU+AzhFh600WUDC9qcxyDIhOXHnuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7454
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
