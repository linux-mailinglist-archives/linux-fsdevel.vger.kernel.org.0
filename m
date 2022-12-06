Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3386441EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 12:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbiLFLQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 06:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiLFLQJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:16:09 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EA226578;
        Tue,  6 Dec 2022 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1670325368; x=1701861368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SizgxCwzj4eXm2sNL3c/C5wOv38vCjp/a66xiXXHXzwgq1Dc2OxhHw0p
   s6a28lkoR6j/+cZRgxA1lPjmMcpCeMAIafBwIMUVzNDkuIxfoGEA5wqdt
   xN9eAbTeKWB6rLWHcZN5Rm6hJSbc1QWPkHzWYG/eUcGOdwKVt8dFgqE7X
   GHWb3kqGb65cR45ykr1lRIfV1QGO0xemtrGpLSJRXkdLFJKE7NiWzY7yf
   WoUJcj6chOJ+08eyL3fJACz4oc3yah9yKQUWq+dHslU5RTjTum+pvgfyw
   Jgq+AiABdxikA/fpkN5kJdRxRd1MncsmGAGWxadeQ3BTV8mj7SCjD3swW
   A==;
X-IronPort-AV: E=Sophos;i="5.96,222,1665417600"; 
   d="scan'208";a="218269586"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2022 19:16:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UinuO0OoxrD8GUQhs+FWTIIlVInYN5ia37mA+UNtTwWf7rq1s+Nk28fCbnoBOgmqWTD3IazMSez6MBOIa3N7A2AQ6VGBPPh8UwuuLkCUr/aDcisQY9sD3ikXDamleDiCDUsDG5bRCXMfWHdBpQeomgXpx2PL0Gm4LTPnk4aevUiukC9hNIntglJoLuV6naybzh+N0dEnipqlADr149X2cbndR/UemgvX34jD8lSVdJ9sexmJTU1V7NLUEgw+SMnSbVSu0GWv/Z8YPXrlbe7VWSLmOXxqDnE5DrNbAgbbJzmZw49szIYtmO+GGtuGQu03erseXbHArUhmA+CKzJRRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fNNb+Mm2zYwJVVlYVYwENUJVSOQRceUpT1jJt7fegU6Mly/oy2lSyJ//RBQxQRBgcTJFojN41raXSkuwpgN0sT0YkuiIxBljgxgETyQQDWdWk4QhTMMkmSFYfI1nyjBr2sZOe0YA5zKiIUlLSIMycgvvfBBGd8bFWtbOYH3S9Tk0Fpadn7ZUINVMH+8Kv20dubMtMw65wCnGi2O5rr4y15eEyo2uMxOo6y8V2ZYzoG3J/t6lCeW80qqu7+yvVVYepxPvF7ETfLQ1Y9zIXwOfw6LpKt/uarM8yFBGQ9N3hnkEjklxbdu0oANCQlQ+5m7DZDykR1Mjldk0BGxqXWVcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VkL/PAV9zsi3B8hZzINZZhbCXs1TU6knytrCFIToEFUFQdrY/TQlQgJeMR5mBFv5xKtq+Y874GI99TIoj9lF5tQiWclfm8PPxJWY+PfIgh1HHk+n/gJZatVmfexMA/UtJA5ra5cWtHBqG/SxOHEn5kSuWzbkZO9tF5o8su4tmjA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7979.namprd04.prod.outlook.com (2603:10b6:208:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 11:16:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81b2:90e4:d6ec:d0c6%5]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 11:16:05 +0000
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
Subject: Re: [PATCH 04/19] btrfs: simplify the btrfs_csum_one_bio calling
 convention
Thread-Topic: [PATCH 04/19] btrfs: simplify the btrfs_csum_one_bio calling
 convention
Thread-Index: AQHY/N5RYIqudTqRq0iLOhwUfawoDK5gzoaA
Date:   Tue, 6 Dec 2022 11:16:05 +0000
Message-ID: <61f3e1e0-4944-811d-8be3-87b152f57ed9@wdc.com>
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-5-hch@lst.de>
In-Reply-To: <20221120124734.18634-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7979:EE_
x-ms-office365-filtering-correlation-id: fbeffb58-8fc7-4201-e2ab-08dad77b4496
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLyuMF/OSw1Rz7Orx+iaB8Kw5yJiGxkrRcQLMZ6sMmXy737QIEDmmFNZOFVT0UiRovy28XIEswi48U18KS/jVOnhy1INDBiLTyqouVvg5Lp7GAu+B/Ku2pjcTmpwaZg3ajmF1cQlFYU84Qehk4SXay0OXVX6q7NzK0jhTpmkjdfJo7GVhFt/eu+Shc8GCDOky+k64xPG4ESwW0E5Rm6W2LhQ27+V61STkBQ2ue2Um17JebknpWiraAwsq915z5pZ7u+vFHwLUoT62rh6U9zMxpT0YwzckOkU5ucsROygr2oUPxyduwmd46BY9D9hmDWKiOv4EhWIjaJMLUvVXmp+EFhDd9LnVIkO6i7V5X3SL88v2zLH6m8mETiqwg4Sjplp95QI2ApcoBoLyWFFbgkVbxGBZymVKMMaT0NkKgRMfwWbjc5rY0SvlXrPQvmqLQO0YT+8C8KB8i2kRnPiCft//iowqgJN7yONxMpJ3QbSfIKbeHg+sdXB23wEyfR+FyIN51okXyPxupICUmjsVtxIJuPpprsTLchF8JvHzOfiAkcIp3Wxc6ieMyAJ5lYVaBVFk3QcKoqNqJimUF9HGoVINe6pE0mKqf193YiBgIUq5/yXZ40hD5CtsTIcJ/x2LwOdiPti1/tyBA794jczgrfaOaTmC+b2ea8dnZ3n/E4wbItL0MZn4Y0ELIQrwvHmzZP8ev2kjXVv9pWNBUaneEOXqYrd6DwAhdycd6Pu/IHapM9L/gLdEnVx7Hj0TH+J1ECTmhaPqHSFOfuzyftpRGy+zw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(122000001)(558084003)(86362001)(31696002)(8936002)(82960400001)(5660300002)(38070700005)(7416002)(4326008)(2906002)(19618925003)(41300700001)(478600001)(8676002)(186003)(64756008)(6506007)(6512007)(110136005)(66946007)(2616005)(66556008)(66446008)(6486002)(91956017)(54906003)(4270600006)(316002)(76116006)(66476007)(38100700002)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWZtOGFDTjh0bWxNQ2QyREFDQzl3UG1vS2xhTXZvck9xcVJubDJjWkcvNCtn?=
 =?utf-8?B?dHNjdllScVRiYkx3VndNN3ZVQWVGMW5kSnNMcEZHbFJBNVcwMmhiTExRMnpu?=
 =?utf-8?B?aG1lY25RWk5paVZLY0FFVXMyMitHN0Y3SmE2YTdnbER1L010N1pUMVVrR090?=
 =?utf-8?B?anpvalprc2I2aDRqSWhadHUwYkIxSzRjTFZHYm15bWtSbWJrWTdSekZqRXdm?=
 =?utf-8?B?K2VhWFYwUlh1VXg3RFlsUGZZYjVzaXhWN2lHdTRPWmNYc1NlUGhCc2pzRHZm?=
 =?utf-8?B?VWM4blAzekRSK002MlQ2azlqYy9vZzJjc3BobUJlaE1IbEJLNnZ6eTcxTnVS?=
 =?utf-8?B?Tk9qbERKeHpKbnVLOFpiNlNVcXJvbVZJdzBRZG1wNFBOSWlwZUc5S3I4MEdI?=
 =?utf-8?B?K0dSYWFhM1BHMzFIYy9MckpGRHdXNjY0NkZjSVozVGhLVTBRa1BYaTZHTWVK?=
 =?utf-8?B?allaYWhxYlQ4S0U1SXI5K0krZnFXR1dmTi9LR1NFcXJEVUtYRExUSENCZHJ2?=
 =?utf-8?B?VlFMTjRoRUZlUWJsajhMaEIwUDcrekIzd1B4cld5TmdWRk52dlZlMjhiY3l1?=
 =?utf-8?B?ZHo0cXpTOHY5RUlHVzJZOUVyYWxqNS8vUE5xb3UrTDFaNERKblJvMXNXNld2?=
 =?utf-8?B?MXRIYlZEa2NreVNWNlVnUHN4OTdFeUNzZ3oxWlEzRU82YTFoT2J4OHVIWURt?=
 =?utf-8?B?eVRVekJoQ1VCZEM0ZkxtcklCNkpmbUxLNHFYZmc1M3lEeWs3N2RrMkNjc1Zq?=
 =?utf-8?B?VWlSbHpyMFg1c1VydkFKNEErM0RZZkk2dm1razhvN0lPN2Z3WGdOVFVvc0hJ?=
 =?utf-8?B?V2RQeUpOSU5leEVYNjlkY0VXRWRyUWx1S0drZHZJNzEweGZQTVNsWlFCdy9V?=
 =?utf-8?B?ellmaXM1WHNFUDNmSnFKQUg1bFBWdzB4dEJIYjRta0orNzhPYXI1cE9tQmlH?=
 =?utf-8?B?cE9qQ2tWUEJxTzNNd2c1UlUrMXRhOU5yQ0JMS2pxelNWdHVLcXhZYmtsT2tu?=
 =?utf-8?B?NUQ3Z010a1lHNWUxamk5UE9sVHZoTG01anpzVjN6cXVobzJrVlJqdHRQY1Zm?=
 =?utf-8?B?NXNtMW8xMmEyY1pvOWZ6REFjU3JCMDIweGtDY0pJRlNOTGxJSFF4VktaUWZw?=
 =?utf-8?B?TUVxOFdhTzJlOUhGcnFhRVJFSTEyUE44U1lWeEJWYWMybjY5akJoWUhFSWpS?=
 =?utf-8?B?TDNCVjF5TXpITzJoM0dNcUdLOEJadGpwbHFBdkxNK1Z6bHVjRjhlbCtmd1VU?=
 =?utf-8?B?Q1k2RGRDeXJmbnFOWjZJSFFDSSs1MGE0NTVrSnJObWZqNm4rdUw0V0pLWm5E?=
 =?utf-8?B?bTcvYXhTUDM0Tms1L0w1c2lXd1lpL2Y0L0tscTdBcldIcURSSHN6T0JpRkdJ?=
 =?utf-8?B?YmdaNTVyTkhNRVpJQjBLMDVHRDJ4cEdtbHRKRGFyaDdLVk4xSEg1VUZrOS9J?=
 =?utf-8?B?Q2tiM3RCUDAyajdzNFV2T1QyS1RRcWFVNnBURzZtK3prWEJwYWpnT2ZUcEtJ?=
 =?utf-8?B?andlVWRFemxGbklacmkzNmcwVkpVOU9mc0hVS0tubUNaMEpVZkFCcTNLQTA3?=
 =?utf-8?B?MzV0d3pPb3g3QXFINkhHUGFSbU5DckpSK0Q2c3hCaWs1ZWNzWkl2dlFadTZK?=
 =?utf-8?B?QTd3amkxdGpib1d2blBVbVZ1YkZlTGo3UUl5Z2FBUy9mZG41SFJDN2R5VVc2?=
 =?utf-8?B?RXBOR1N6ZXZMQWxWamxZUFpxYm04VXlrSlo1SHNXNWRtZDZnYyt2a1hMN1Yr?=
 =?utf-8?B?TDlDU1liU0t3aktqVnZpQXNHOWIydThEcjNzbVFHQzA0Z05sMXErNXA5VFFE?=
 =?utf-8?B?OFI2SnAzMmtFbEZ2RFIzS1ZrU2RXUUg3Qklwd1cvM3g3TFgvbGh4emJ3dVQz?=
 =?utf-8?B?OVRqZWlUUS9RN3Y3Tk9GVmlOVE40S1ZzMWVBSEJpQytRVEpQTUxyUTloTU1U?=
 =?utf-8?B?bGFuTDN1L2ZKQUp3OElhM0xqT1p1djlqbXIzRGFSdUM1aDJ3MXRJbVUwT0hX?=
 =?utf-8?B?U3YzRHlJTktKK0dlMFY5QTRKVVE2UzcxQ0s1V2E0aWVPTjVJVFJrRW1hSVpN?=
 =?utf-8?B?QnJSRVIvciticERBc0FsSkUrS1pDcjhGOGFncU04eXdHV2toZlAxQ2VSbjdW?=
 =?utf-8?B?dVI1T2JKd25SZzRtajJ6anc1RCsrS2grSVh2enJHMncvcjY2WjREQUJnYnNL?=
 =?utf-8?B?aFR1VzhBTnFXS1BERVVJV0ZFL2l4akVUR01JWnBNTjNjRmhWc3FmMnlUUXRv?=
 =?utf-8?Q?fBcnSt9QR+OC9Cc20qZ2BMWK7bTl0fLD/MJK893GM4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B950F95A88862A459CBF08125473F172@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QkJCZEIxRkpoMTVGQ2ZiUC80enpRQkFiOHZGc2kvTXVjSEcxMzk2TEpTTFNh?=
 =?utf-8?B?akdOV0xCYlBEQ3NOUnpaY3dZUHdOUFBucFZLNUZMRXBnVmlzdUU1RmVEWCtr?=
 =?utf-8?B?N0FjaUE1V3B6ZnpaQXVBSlI4U3lVYnpjSmcydWhmVmY1N2VpdVMrVEZrMWZI?=
 =?utf-8?B?NERYbThOY2llK0JmSUxscTUyazByNWYxZE5GbkhnQXpsWEorR2tWbThHRDNS?=
 =?utf-8?B?RE5xTU9OSm5qcTM3eFU2Kyt5ZVA3dFBJc1c4V1RKSisxNXNBZDhkM0ZQZld0?=
 =?utf-8?B?ZzBMMDZWYWNGTnBsVmRZb3BpL2VSNlZZbUxIWEo0Y3pFQU1qc2J6UFlXRXJp?=
 =?utf-8?B?NEl5d2gzbTBLVmp6QVJDdk1UbStNQm00Y1RNYzkzZWR4bFBCd1hjemtkWVFu?=
 =?utf-8?B?ZEdFYmxJYk5QY0JidmxYVkU1aGxETWRLMUFQWEI0cCtSaVBrUDErajQxbFpM?=
 =?utf-8?B?aFBCc0FDSk1YWnd1bVlZVDkvSE5ZNnNtVFJHQjMvZFBtdlpTdU4zMlp4UUkz?=
 =?utf-8?B?TGtUWEl6b1hxVlBjWkxIQmtJejRXV3FvdnFwZkpDaDV0bkxiTzRmQ1ZqSjdp?=
 =?utf-8?B?Ky9IeEt3SE9hckIyby8wd0tUYTFZYWVQbHBSRk5ZM1lIbjVYa0JmRWxrcW14?=
 =?utf-8?B?WVVldzJrbkJUTm1KMENyaFVCRDBsSzg5bnV6dDIrVVQ1a0JqUjJrdUR5Vndu?=
 =?utf-8?B?TE1FQjdlREFHcDBSK0s5QUkrdVFNRmV4YTRiVjZ5Z0dTUVdseVl1VVJHdnNp?=
 =?utf-8?B?VjlCVmxsQUxGYXFYaW9DNloyWGJGRERWUXgzSnFBdTJNTjl5NTdHYlRWc0l4?=
 =?utf-8?B?UEYvVGN6alYwVWxObXo2WjM1YkdjM2l1UTJ6VTloTmFOSXBDOG9NcEdxSVpa?=
 =?utf-8?B?eUlwR045NWRSVUtoZlZ0eTVpTnZyRG9RdTRoTktoZXNyZTZMRDgwVmhYK2hl?=
 =?utf-8?B?Q0V2SVR0WllDZHIxZTljeVRQV3VYUE01UEV6NHhoWlV6bFY0dW5EZnRNK0FI?=
 =?utf-8?B?b0Q4VkNxaDhPdkd5VUIwREYyWW9hK0FuYWwvOTlwTWprUkMyeFJpSCtxVUtn?=
 =?utf-8?B?ZTkwdUpMbGNYRHFjUmtHU1dVNU5WVkxTeWwrdGc3bGlwbnBLbmh2czhrNDZO?=
 =?utf-8?B?WHp4MXpqbUxWS1FFQ0JUeDZ1R0R3UlBsMmdZNWtZeE8vdFplMTVGa0MyNmFR?=
 =?utf-8?B?aTZTcGUvenMyVGNGSGsyZ2VLbmxKbHlnM1pTNDljZTNnTXdibWg2SXkwL1ZS?=
 =?utf-8?B?STRiL1JIajJiUDNlWXZXWWVwcEZGRUp4NEFTcTd4T3cyOGl0U2E2ZTdEMU5C?=
 =?utf-8?B?d0FMSTV1aGl3QndoMmVaT2xqd1kwMkpOZmpTZURrbWJQeWtZeGUyMXY1cWZv?=
 =?utf-8?Q?2kJh0Zt0hgVLEQxe9DgEePIAbH7K1VMs=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbeffb58-8fc7-4201-e2ab-08dad77b4496
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 11:16:05.7409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XrDi/+kjNAz4SYkLSDceUZ7aYooPBi+dLqahn4J7KESgwt2Ri54proU4M5qVBPaQtCukoaepDsYoeX2VDXzQXVaUvvTZYHIIEk8M3Q2fERI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7979
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
