Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E68609192
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Oct 2022 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiJWHMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJWHMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:12:20 -0400
X-Greylist: delayed 243 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Oct 2022 00:12:18 PDT
Received: from esa13.fujitsucc.c3s2.iphmx.com (esa13.fujitsucc.c3s2.iphmx.com [68.232.156.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3487481DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 00:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1666509139; x=1698045139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qNtA0KclKrr+BAmsS/+lrPX2gBVVtX5XLnb2ArKmi/g=;
  b=WTqf7V6f3JixFdErC5yZq2qBT9uBY4tHG/cxmfeeZ6UHAOfsge/zG5H5
   1Qa03A1IlHFDQDd5feLDJll8xmjB8vgAj/iffU8FlDYwvy2IbUcdNbDaC
   ZwkdgWNzeRKQiKkNiQ8onHD+ncKQynHvtK/a2kmqnRLjj+GNsH9dTWFo9
   uxog5MMYyXdsFENGPKENMR2O6FKm0y+fd2TKzZKytWWbe2hEzwxWLaDjj
   ttMe3OQlx8gVXsgau70MuqPSdCeMo9TQMquTOPnTt8RgY7tHCZyvnq74/
   RmIXMRqmieyXpXBDyEICVn0TdmPn/8gF0ftR9oo6zxxk25kH/XhHfuuVF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10508"; a="67935686"
X-IronPort-AV: E=Sophos;i="5.95,206,1661785200"; 
   d="scan'208";a="67935686"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2022 16:04:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6Yqu/WtnoGTNq1LJbtUTEsT1/0sw5+HOxDGjZxfjRm+cPSyHiNdLEanTorJU0pY1QutstKzr8edfzm45jnpS1OU2bDDVd4VYbbe2DnP5TFltAlKCKXrYQv90iaby4V2SDIFtAuIPb+pX6pFgFhwTPvwk6ugr45Jz/GWDhOVCd8tmTbU2DJgyag0Vn6T6db5AUrf3FxJaZKSi5p7z3lzWojLqCd8jB5bl6sp9Y3qetU1ONyvyqGrO1oN3lqVG3CquWCvptwNepquZuJnJyPN4DNC4H4jAjBbCUDldUXrID3JQ1cFgFIx66WoX1d05JMCY3eYcccXnL76JqKbm7kWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qNtA0KclKrr+BAmsS/+lrPX2gBVVtX5XLnb2ArKmi/g=;
 b=KkJqGoDUI4+IN+uYxYueVTFX4VDXzNKnHl2kf8Vfyq//GROzSFEiUC2tCrIH6pqzHzxeZwPEuIBHjmmr4FK2NDhwZqh49iXKQZ8zY3l6nx2mYAjmCJQhMxTKtfEQb7CDumn+xvQK9sqzHSU89nnlE0+llDxSu6W3nMs+0TuFYnv+3DIspESNzQj9oa5httNg7ILjyAlIb8MAtWCdqqPHg8eO7EkheNaGEMqvttU1utuzj3BhUW3aKWGz1X8pCvQ8+/gVZ9OKtjlcbGgT+9fqU+bLJBnoVjPMraTw5Vm8gvVHXlv2iaWqMVm+n5Puq5e1F7cPIH8qUr9Rx4J5VsxVtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSZPR01MB6309.jpnprd01.prod.outlook.com (2603:1096:604:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Sun, 23 Oct
 2022 07:04:54 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::339e:88a3:a24c:5f68%9]) with mapi id 15.20.5746.021; Sun, 23 Oct 2022
 07:04:54 +0000
From:   "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>
Subject: RE: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4forHNHCyS0U+LGZ2U8ockZa1oy6eAgG1PENKAAYW1gIAHcj8AgAAwlgCAADFJAIAAQWgAgAEpzwCAAQljgIAGUv0AgA+aw4CABj0IgIAAQxUAgADul4CAGN++gIACWZ4AgAB3MICAAWvlEA==
Date:   Sun, 23 Oct 2022 07:04:53 +0000
Message-ID: <OS3PR01MB9499BE1E2B3E1823B6F8F1C4832F9@OS3PR01MB9499.jpnprd01.prod.outlook.com>
References: <YyHKUhOgHdTKPQXL@bfoster> <YyIBMJzmbZsUBHpy@magnolia>
 <a6e7f4eb-0664-bbe8-98d2-f8386b226113@fujitsu.com>
 <e3d51a6b-12e9-2a19-1280-5fd9dd64117c@fujitsu.com>
 <deb54a77-90d3-df44-1880-61cce6e3f670@fujitsu.com>
 <1444b9b5-363a-163c-0513-55d1ea951799@fujitsu.com>
 <Yzt6eWLuX/RTjmjj@magnolia>
 <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <09f522cd-e846-12ee-d662-14f34a2977c4@fujitsu.com>
In-Reply-To: <09f522cd-e846-12ee-d662-14f34a2977c4@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: =?utf-8?B?TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2Uw?=
 =?utf-8?B?NTBfQWN0aW9uSWQ9ZTdkN2I3ZWMtZDU5Mi00ODExLTg3MmItNmVlZTAyOGNk?=
 =?utf-8?B?ZTZiO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF9hNzI5NWNjMS1kMjc5?=
 =?utf-8?B?LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRmZWNlMDUwX01ldGhv?=
 =?utf-8?B?ZD1TdGFuZGFyZDtNU0lQX0xhYmVsX2E3Mjk1Y2MxLWQyNzktNDJhYy1hYjRk?=
 =?utf-8?B?LTNiMGY0ZmVjZTA1MF9OYW1lPUZVSklUU1UtUkVTVFJJQ1RFRO+/ou++gA==?=
 =?utf-8?B?776LO01TSVBfTGFiZWxfYTcyOTVjYzEtZDI3OS00MmFjLWFiNGQtM2IwZjRm?=
 =?utf-8?B?ZWNlMDUwX1NldERhdGU9MjAyMi0xMC0yM1QwNzowMDowMlo7TVNJUF9MYWJl?=
 =?utf-8?B?bF9hNzI5NWNjMS1kMjc5LTQyYWMtYWI0ZC0zYjBmNGZlY2UwNTBfU2l0ZUlk?=
 =?utf-8?Q?=3Da19f121d-81e1-4858-a9d8-736e267fd4c7;?=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9499:EE_|OSZPR01MB6309:EE_
x-ms-office365-filtering-correlation-id: 5822ad2d-ce5e-4506-5ef3-08dab4c4e2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: shAC7Sb0qDnf7msp/29n39n7X6dFdGv1eWRiv/Ca8jlDQn6fcO869pScEau/qvz8/RoTd8Nw73kyPvFM20eC14exljvdgStW70+rZaT9WRCNtxZIpjv65L0XGQm+TEEhx0CGk2zXDwaz+WzhsqcV2plWNddL5P//FDXcyt9F/PohQ1SAkAivxUAMZfKr4CtCAuSy4TR51z/ltfx/9/SWuYFQdVEmqFjnE2uR1Osb4Kn4D7qNBraVSgL9WfKc1SNNZPvTREXQ8V6wQ3Yoha5RN/OvU7/6mqzJp8Kt6sZlIg/RT7Sfplffji7lFvpoOx/2XSS/IMcgHlZ91J7CJa+/yYgEuTC4j92EFXLvJE6du7V6/Sn0oUuAHVRnSUPbonCBuBiwLCMZ1NIiE1MmlvQmW3A+JVA7x60H+n143tlYO+wOev0VfRAqQWnxQP3DF/zV8tBMBkumkX+eszq3PdcagW9y2I7/X3s0iz2x7OeLRH0bePcgq7WGLj4E+L00a/NeLj6MQ1EH/7Kit38sU4DyMKEpK5YltzWrLrPDVmTVQQpEnDBYjdxNQRarVGSK6WYEeaKO/xsvJIV86TqE+s1dOGb/NOcgRQ4cJ9gefYbY9IqS9djH3qaobb5RfqaWg4l1y4ovSJjc6qYWc0winyAUpqPgv21clmwKiaQXlhcb4VQ0pvxmoZ0C8vMbzJEDBGW97z/nyuf123r4cWhHitcxaUJGJoVPFsjkvz/qnNx/dXPTr/sEJ8ZOYNwx0AZL2Y/zBGqsQ/3bwX76KoQYhAC0pm97yfyQfQVJUU2ieUTk3LATrprpGynm4uM66i7FlFVd50L1QhWCXq6WfMUhcPGzQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9499.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(1590799012)(1580799009)(2906002)(5660300002)(7416002)(85182001)(52536014)(55016003)(33656002)(41300700001)(83380400001)(122000001)(38100700002)(38070700005)(82960400001)(71200400001)(6916009)(54906003)(966005)(478600001)(8936002)(86362001)(316002)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(4326008)(76116006)(186003)(26005)(9686003)(7696005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRSQno3eHUxVVpneEZwZ3lVQVI1SGRmK1k4cnVlaTlLNjNVRnJwdlNNMCs5?=
 =?utf-8?B?YWkvb201OG9oQkhNekdROENUUkJLY3hTSlBsQ3lpeFB1amQySHRWRlQxUTNL?=
 =?utf-8?B?aGRJVk9jT1UrVGlkRnJSeTdhWGJ5WnlNVDF4ZlYxd1V6aUxnY0ZLRCtidVVT?=
 =?utf-8?B?ajF0WldUWDZWc0g4VllhQ0JSQVlGcEE1K3MzenkzN1hiYllnVm1XRjRtVXhC?=
 =?utf-8?B?NjMxd0prS1BJZW5DNldtN0ZXZk1SeHptNWF4OUtYNTdlaVVNNDlic3F0OEZD?=
 =?utf-8?B?VVQ4Qm9nSlh3WTFUWGtqSFBSQlh1RXFUbGVhU1NEMU1xKzlPT3ZVSk5EUUpM?=
 =?utf-8?B?SWczakV6NHlxemp0VTFqRGxIT29SNVJKRHJtOFhYenhFNW9iNkVVem9XQldR?=
 =?utf-8?B?NWE1VU9pMXU1dG9ONzlvODlUNGE2dEFveWFVNzBtUTkrbjNUVHV4QzVqUHdT?=
 =?utf-8?B?QXcvTDNUQjRrVGJHWG4vS2svelFIMy9OT0lYMS84VStSOE1xMG1FNE1OaTRx?=
 =?utf-8?B?VDFyb0ZKWldzRk00VW9abVVlYXQ1blJXZ0IxZEZCc3lUaGlscGpJVVZ6RFBR?=
 =?utf-8?B?MzVaek04TVdneVRBb2NaRFZhMHUrRlNBYVNCWVhUOTlIY0hiYVdSdE9nd1RR?=
 =?utf-8?B?QldybHdtR0lNeUdLZkc0Y29Hd05xN2J1dk4ySTlaZFAxWnJHUUhTdFdZSERV?=
 =?utf-8?B?eDN5aTZQUkxEQU5OelAwTFdTbDhRRWU2WE4vQlVhRzJUMjFraURJZEVTOStE?=
 =?utf-8?B?VUdpUUR3L0E3YkZHa0VjV3pXcnJtZmxuVWlLb3d5T2FiMEVTYVVPVVVPMmhi?=
 =?utf-8?B?TE1XdEpnVG1tdmFSL3QvbUtqWVVvallIbnRwNFZaSTVXU2NsdkJ0R2l3d2k0?=
 =?utf-8?B?MDk4ME53RUJuWnJQYnVsWFJWTHcvd2RHMTZSSkhTM3hVN3VTTFh2S0I3SDFN?=
 =?utf-8?B?MHMvU0RDb2JOQldmbEtlTWYzbHBidUt1NDhrYkcxVjE0TWFhUHdsZmgrYXZJ?=
 =?utf-8?B?N1oyZ2tvbndOLzZIakhNK1JYbDhmL0Z2bGREekRBSWtzMmQxL3Y2cEhaQjcw?=
 =?utf-8?B?b2xjNzFaaE56NFBWcGowSW96aFlNdG95azk5aTlPSkxSMWJKRzJvVHNXYmkw?=
 =?utf-8?B?WGo1SGJmaDR5bmVtZDJEK1RYb05LUFZUTXVZWjgyamFSMXdMQUZmZ2tXVGhE?=
 =?utf-8?B?bTZBMWVRcmVxeXJMN282MUIxUmNKSHh6Y0hKY2JlTHc2Z3YrNlp3VnloZ21I?=
 =?utf-8?B?QnJYTlJrNVJpRVlQQWxjV2RnTkVneTd4TSswWk9PeW5MeG9pZ3Q4SVJoNWFa?=
 =?utf-8?B?Y0ExQjYydDZDR1FKeXhUUVdWNDZPTXc2Y0hEdVd2K2Zid3ZXSi92dTg1L1Ey?=
 =?utf-8?B?R2lNY3Jzb09WVzNzeDF1NHk4TEFRMzArUWU2dkZCNVRQUkkrN3IrT0gyNUZm?=
 =?utf-8?B?amZzR05EaldZdzVBc0k1Um05OVhWUFdScTh1SHBDRzNJVEVkNEdubWxIM2FG?=
 =?utf-8?B?b2RZR0ozd3lTck9VQlZqSS90SlNtVTRtWWx5Njl6RHRoQ1V5enJNS2hVelRB?=
 =?utf-8?B?dDlFcHY5akdEY29MUURZRnVRaWg2UXRFRFhsSGFpUGd2WUgvQkF3UmlTenZh?=
 =?utf-8?B?T1FxNWR5bXdJUEJuYzVSYWVabTRpNEY5R2ZiWDlTbnFYU2NlblRKWGJNcmtw?=
 =?utf-8?B?UDJ2T3FGS3VMQ2JIV0toRWV3alJQM2w3QVdiT3VVNWxURXRZdzYrUmJCOGhN?=
 =?utf-8?B?RkNxRnhiT0YyS3orNkVIUDBhUEorNjFndG05Ni9kN29UTXNUUHgyVE5XMUVs?=
 =?utf-8?B?clJzSmJNbDM4d0JOMzRCVUpVUXo2a01MQ3RnSXgrbnVYMmF6UW9GaE1kYzFZ?=
 =?utf-8?B?ZFpCL3NacGpnc290dHVDK3A0M3NLT3FxMWw1MXgxYnFXa0lqSUhkL1VpeW1F?=
 =?utf-8?B?WkFMS3QzNkI5NjVBT211Mm5zSkZDZnJHR0xBclBmSnpkV1lyNnRyZnZlWXN6?=
 =?utf-8?B?S1NwZUI5VEYyV3lXRFQxUnZEU2ppaDdqVlkrdTc3MG1YbGhYaW8vVTIwVFow?=
 =?utf-8?B?Q0laNkpRSkVKRU9iMUhWSWlLTHF5VGdBTDYrNkhhMmdCTlhIRTV0aHZ0Q0Zh?=
 =?utf-8?Q?m/zsZx5ya4Ystw8cc+kOyfuDc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5822ad2d-ce5e-4506-5ef3-08dab4c4e2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2022 07:04:53.6775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9Gsx5rO1/hDr1ZL1tHYrm7W7JirKzZyLnK8FlXJ1EodrNalNl3UDCR4dJ9czFIjAi8gcYEW7Be2SBID86KgFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6309
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi8xMC8yMiAxMDoxMSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPj4gV2UgbmVlZCB0
byBmaXggdGhlIGlzc3VlIGJ5IGRpc2NhcmRpbmcgWEZTIGxvZyBvbiB0aGUgYmxvY2sgZGV2aWNl
Lg0KPj4gbWtmcy54ZnMgd2lsbCB0cnkgdG8gZGlzY2FyZCB0aGUgYmxvY2tzIGluY2x1ZGluZyBY
RlMgbG9nIGJ5IGNhbGxpbmcNCj4+IGlvY3RsKEJMS0RJU0NBUkQpICBidXQgaXQgd2lsbCBpZ25v
cmUgZXJyb3Igc2lsZW50bHkgd2hlbiB0aGUgYmxvY2sgDQo+PiBkZXZpY2UgZG9lc24ndCBzdXBw
b3J0IGlvY3RsKEJMS0RJU0NBUkQpLg0KPiAuLi5idXQgSSB0aGluayBoZXJlJ3Mgd2hlcmUgSSB0
aGluayB5b3VyIHVuZGVyc3RhbmRpbmcgaXNuJ3QgY29ycmVjdC4NCj4gSXQgbWlnaHQgaGVscCB0
byBzaG93IGhvdyB0aGUgbmVzdGVkIGxvZ2dpbmcgY3JlYXRlcyBpdHMgb3duIHByb2JsZW1zLg0K
PiANCj4gRmlyc3QsIGxldCdzIHNheSB0aGVyZSdzIGEgYmxvY2sgQiB0aGF0IGNvbnRhaW5zIHNv
bWUgc3RhbGUgZ2FyYmFnZSANCj4gQUFBQS4NCj4gDQo+IFhGUyB3cml0ZXMgYSBibG9jayBpbnRv
IHRoZSBYRlMgbG9nIChjYWxsIHRoZSBibG9jayBMKSB3aXRoIHRoZSANCj4gaW5zdHJ1Y3Rpb25z
ICJhbGxvY2F0ZSBibG9jayBCIGFuZCB3cml0ZSBDQ0NDIHRvIGJsb2NrIEIiLiAgDQo+IGRtLWxv
Z3dyaXRlcyBkb2Vzbid0IGtub3cgb3IgY2FyZSBhYm91dCB0aGUgY29udGVudHMgb2YgdGhlIGJs
b2NrcyANCj4gdGhhdCBpdCBpcyB0b2xkIHRvIHdyaXRlOyBpdCBvbmx5IGtub3dzIHRoYXQgWEZT
IHRvbGQgaXQgdG8gd3JpdGUgc29tZSANCj4gZGF0YSAodGhlDQo+IGluc3RydWN0aW9ucykgdG8g
YmxvY2sgTC4gIFNvIGl0IHJlbWVtYmVycyB0aGUgZmFjdCB0aGF0IHNvbWUgZGF0YSBnb3QgDQo+
IHdyaXR0ZW4gdG8gTCwgYnV0IGl0IGRvZXNuJ3Qga25vdyBhYm91dCBCIGF0IGFsbC4NCj4gDQo+
IEF0IHRoZSBwb2ludCB3aGVyZSB3ZSBjcmVhdGUgdGhlIGRtLWxvZ3dyaXRlcyBwcmV1bm1hcCBt
YXJrLCBpdCdzIG9ubHkNCj4gdHJhY2tpbmcgTC4gIEl0IGlzIG5vdCB0cmFja2luZyBCLiAgIEFm
dGVyIHRoZSBtYXJrIGlzIHRha2VuLCB0aGUgWEZTDQo+IEFJTCB3cml0ZXMgQ0NDQyB0byBCLCBh
bmQgb25seSB0aGVuIGRvZXMgZG0tbG9nd3JpdGVzIGJlZ2luIHRyYWNraW5nIEIuDQo+IEhlbmNl
IEIgaXMgbm90IGluY2x1ZGVkIGluIHRoZSBwcmV1bm1hcCBtYXJrLiAgVGhlIHByZS11bm1vdW50
IHByb2Nlc3MgDQo+IGluIFhGUyB3cml0ZXMgdG8gdGhlIFhGUyBsb2cgIndyaXRlIEREREQgdG8g
YmxvY2sgQiIgYW5kIHRoZSB1bm1vdW50IA0KPiBwcm9jZXNzIGNoZWNrcG9pbnRzIHRoZSBsb2cg
Y29udGVudHMsIHNvIG5vdyBibG9jayBCIGNvbnRhaW5zIGNvbnRhaW5zIA0KPiBERERELg0KPiAN
Cj4gTm93IHRoZSB0ZXN0IHdhbnRzIHRvIHJvbGwgdG8gdGhlIHByZXVubWFwIG1hcmsuICBVbmZv
cnR1bmF0ZWx5LCANCj4gZG0tbG9nd3JpdGVzIGRvZXNuJ3QgcmVjb3JkIGZvcm1lciBibG9jayBj
b250ZW50cywgd2hpY2ggbWVhbnMgdGhhdCANCj4gdGhlIGxvZyByZXBsYXkgdG9vbHMgY2Fubm90
IHJvbGwgYmFja3dhcmRzIGZyb20gInVtb3VudCIgdG8gInByZXVubWFwIiANCj4gLS0gdGhleSBj
YW4gb25seSByb2xsIGZvcndhcmQgZnJvbSB0aGUgYmVnaW5uaW5nLiAgU28gdGhlcmUncyBubyB3
YXkgDQo+IHRvIHVuZG8gd3JpdGluZyBEREREIG9yIENDQ0MgdG8gQi4gIElPV3MsIHRoZXJlJ3Mg
bm8gd2F5IHRvIHJldmVydCBCJ3MgDQo+IHN0YXRlIGJhY2sgdG8gQUFBQSB3aGVuIGRvaW5nIGRt
LWxvZ3dyaXRlcyByZWNvdmVyeS4NCj4gDQo+IE5vdyBYRlMgbG9nIHJlY292ZXJ5IHN0YXJ0cy4g
IEl0IHNlZXMgImFsbG9jYXRlIGJsb2NrIEIgYW5kIHdyaXRlIENDQ0MgDQo+IHRvIGJsb2NrIEIi
LiAgSG93ZXZlciwgaXQgcmVhZHMgYmxvY2sgQiwgc2VlcyB0aGF0IGl0IGNvbnRhaW5zIEREREQs
IA0KPiBhbmQgaXQgc2tpcHMgd3JpdGluZyBDQ0NDLiAgSW5jb3JyZWN0bHkuICBUaGUgb25seSB3
YXkgdG8gYXZvaWQgdGhpcyANCj4gaXMgdG8gemVybyBCIGJlZm9yZSByZXBsYXlpbmcgdGhlIGRt
LWxvZ3dyaXRlcy4NCj4gDQo+IFNvIHlvdSBjb3VsZCBzb2x2ZSB0aGUgcHJvYmxlbSB2aWEgQkxL
RElTQ0FSRCwgb3Igd3JpdGluZyB6ZXJvZXMgdG8gDQo+IHRoZSBlbnRpcmUgYmxvY2sgZGV2aWNl
LCBvciBzY2FubmluZyB0aGUgbWV0YWRhdGEgYW5kIHdyaXRpbmcgemVyb2VzIA0KPiB0byBqdXN0
IHRob3NlIGJsb2Nrcywgb3IgYnkgYWRkaW5nIHVuZG8gYnVmZmVyIHJlY29yZHMgdG8gZG0tbG9n
d3JpdGVzIA0KPiBhbmQgdGVhY2hpbmcgaXQgdG8gZG8gYSBwcm9wZXIgcm9sbGJhY2suDQoNCkhp
IERhcnJpY2ssDQoNClRoYW5rcyBmb3IgeW91ciBwYXRpZW50IGV4cGxhbmF0aW9uLg0KDQpEbyB5
b3Uga25vdyBpZiBYRlMgbG9nIHJlY29yZHMgc3RpbGwgdXNlIGJ1ZmZlciB3cml0ZT8gSW4gb3Ro
ZXIgd29yZHMsIHRoZXkgY2Fubm90IGJlIHdyaXR0ZW4gaW50byB0aGUgYmxvY2sgZGV2aWNlIGlu
IERBWCBtb2RlLCByaWdodD8NCg0KSW4gZmFjdCwgSSBjYW4gcmVwcm9kdWNlIHRoZSBpbmNvbnNp
c3RlbnQgZmlsZXN5c3RlbSBpc3N1ZSBvbg0KZ2VuZXJpYy80ODIgYnV0IGNhbm5vdCByZXByb2R1
Y2UgdGhlIGlzc3VlIG9uIGdlbmVyaWMvNDcwLg0KDQo+IA0KPj4gRGlzY2FyZGluZyBYRlMgbG9n
IGlzIHdoYXQgeW91IHNhaWQgInJlaW5pdGlhbGl6ZSB0aGUgZW50aXJlIGJsb2NrIA0KPj4gZGV2
aWNlIiwgcmlnaHQ/DQo+IE5vLCBJIHJlYWxseSBtZWFudCB0aGUvZW50aXJlLyAgYmxvY2sgZGV2
aWNlLg0KPiANCj4+PiBJIHRoaW5rIHRoZSBvbmx5IHdheSB0byBmaXggdGhpcyB0ZXN0IGlzIChh
KSByZXZlcnQgYWxsIG9mIA0KPj4+IENocmlzdG9waCdzIGNoYW5nZXMgc28gZmFyIGFuZCBzY3V0
dGxlIHRoZSBkaXZvcmNlOyBvciAoYikgY2hhbmdlIHRoaXMgdGVzdCBsaWtlIHNvOg0KPj4gU29y
cnksIEkgZGlkbid0IGtub3cgd2hpY2ggQ2hyaXN0b3BoJ3MgcGF0Y2hlcyBuZWVkIHRvIGJlIHJl
dmVydGVkPw0KPj4gQ291bGQgeW91IHRlbGwgbWUgdGhlIFVSTCBhYm91dCBDaHJpc3RvcGgncyBw
YXRjaGVzPw0KPiBFaCwgaXQncyBhIHdob2xlIGxvbmcgc2VyaWVzIG9mIHBhdGNoZXMgc2N1dHRs
aW5nIHZhcmlvdXMgcGFydHMgd2hlcmUgDQo+IHBtZW0gY291bGQgdGFsayB0byB0aGUgYmxvY2sg
bGF5ZXIuICBJIGRvdWJ0IGhlJ2xsIGFjY2VwdCB5b3UgDQo+IHJldmVydGluZyBoaXMgcmVtb3Zh
bCBjb2RlLg0KDQpXaGVyZSBjYW4gSSBmaW5kIHRoZSBDaHJpc3RvcGgncyBwYXRjaCBzZXQgeW91
IG1lbnRpb25lZC4NCkkganVzdCB3YW50IHRvIGtub3cgdGhlIGNvbnRlbnQgb2YgQ2hyaXN0b3Bo
J3MgcGF0Y2ggc2V0Lg0KDQo+IA0KPj4+ICAgIDEuIENyZWF0ZSBhIGxhcmdlIHNwYXJzZSBmaWxl
IG9uICRURVNUX0RJUiBhbmQgbG9zZXR1cCB0aGF0IHNwYXJzZQ0KPj4+ICAgICAgIGZpbGUuICBU
aGUgcmVzdWx0aW5nIGxvb3AgZGV2aWNlIHdpbGwgbm90IGhhdmUgZGF4IGNhcGFiaWxpdHkuDQo+
Pj4NCj4+PiAgICAyLiBTZXQgdXAgdGhlIGRtdGhpbi9kbWxvZ3dyaXRlcyBzdGFjayBvbiB0b3Ag
b2YgdGhpcyBsb29wIGRldmljZS4NCj4+Pg0KPj4+ICAgIDMuIENhbGwgbWtmcy54ZnMgd2l0aCB0
aGUgU0NSQVRDSF9ERVYgKHdoaWNoIGhvcGVmdWxseSBpcyBhIHBtZW0NCj4+PiAgICAgICBkZXZp
Y2UpIGFzIHRoZSByZWFsdGltZSBkZXZpY2UsIGFuZCBzZXQgdGhlIGRheGluaGVyaXQgYW5kIHJ0
aW5oZXJpdA0KPj4+ICAgICAgIGZsYWdzIG9uIHRoZSByb290IGRpcmVjdG9yeS4gIFRoZSByZXN1
bHQgaXMgYSBmaWxlc3lzdGVtIHdpdGggYSBkYXRhDQo+Pj4gICAgICAgc2VjdGlvbiB0aGF0IHRo
ZSBrZXJuZWwgd2lsbCB0cmVhdCBhcyBhIHJlZ3VsYXIgYmxvY2sgZGV2aWNlLCBhDQo+Pj4gICAg
ICAgcmVhbHRpbWUgc2VjdGlvbiBiYWNrZWQgYnkgcG1lbSwgYW5kIHRoZSBuZWNlc3NhcnkgZmxh
Z3MgdG8gbWFrZQ0KPj4+ICAgICAgIHN1cmUgdGhhdCB0aGUgdGVzdCBmaWxlIHdpbGwgYWN0dWFs
bHkgZ2V0IGZzZGF4IG1vZGUuDQo+Pj4NCj4+PiAgICA0LiBBY2tub3dsZWRnZSB0aGF0IHdlIG5v
IGxvbmdlciBoYXZlIGFueSB3YXkgdG8gdGVzdCBNQVBfU1lOQw0KPj4+ICAgICAgIGZ1bmN0aW9u
YWxpdHkgb24gZXh0NCwgd2hpY2ggbWVhbnMgdGhhdCBnZW5lcmljLzQ3MCBoYXMgdG8gbW92ZSB0
bw0KPj4+ICAgICAgIHRlc3RzL3hmcy8uDQo+PiBTb3JyeSwgSSBkaWRuJ3QgdW5kZXJzdGFuZCB3
aHkgdGhlIGFib3ZlIHRlc3QgY2hhbmdlIGNhbiBmaXggdGhlIGlzc3VlLg0KPiBYRlMgc3VwcG9y
dHMgdHdvLWRldmljZSBmaWxlc3lzdGVtcyAtLSB0aGUgInJlYWx0aW1lIiBzZWN0aW9uLCBhbmQg
dGhlIA0KPiAiZGF0YSIgc2VjdGlvbi4gIEZTIG1ldGFkYXRhIGFuZCBsb2cgYWxsIGxpdmUgaW4g
dGhlICJkYXRhIiBzZWN0aW9uLg0KPiANCj4gU28gd2UgY2hhbmdlIHRoZSB0ZXN0IHRvIHNldCB1
cCBzb21lIHJlZ3VsYXIgZmlsZXMsIGxvb3AtbW91bnQgdGhlIA0KPiBmaWxlcywgc2V0IHVwIHRo
ZSByZXF1aXNpdGUgZG0tbG9nd3JpdGVzIHN0dWZmIGF0b3AgdGhlIGxvb3AgZGV2aWNlcywgDQo+
IGFuZCBmb3JtYXQgdGhlIFhGUyB3aXRoIHRoZSBkYXRhIHNlY3Rpb24gYmFja2VkIGJ5IHRoZSBk
bS1sb2d3cml0ZXMgDQo+IGRldmljZSwgYW5kIG1ha2UgdGhlIHJlYWx0aW1lIHNlY3Rpb24gYmFj
a2VkIGJ5IHRoZSBwbWVtLg0KPiANCj4gVGhpcyB3YXkgdGhlIGxvZyByZXBsYXkgcHJvZ3JhbSBj
YW4gYWN0dWFsbHkgZGlzY2FyZCB0aGUgZGF0YSBkZXZpY2UgDQo+IChiZWNhdXNlIGl0J3MgYSBy
ZWd1bGFyIGZpbGUpIGFuZCByZXBsYXkgdGhlIGxvZyBmb3J3YXJkIHRvIHRoZSANCj4gcHJldW5t
YXAgbWFyay4gIFRoZSBwbWVtIGRldmljZSBpcyBub3QgaW52b2x2ZWQgaW4gdGhlIHJlcGxheSBh
dCBhbGwsIA0KPiBzaW5jZSBjaGFuZ2VzIHRvIGZpbGUgZGF0YSBhcmUgbmV2ZXIgbG9nZ2VkLiAg
SXQgbm93IGJlY29tZXMgDQo+IGlycmVsZXZhbnQgdGhhdCBwbWVtIG5vIGxvbmdlciBzdXBwb3J0
cyBkZXZpY2UgbWFwcGVyLg0KPiANCj4+IENvdWxkIHlvdSB0ZWxsIG1lIHdoaWNoIHN0ZXAgY2Fu
IGRpc2NhcmQgWEZTIGxvZz8NCj4gKE5vbmUgb2YgdGhlIHN0ZXBzIGRvIHRoYXQuKQ0KPiANCj4+
IEluIGFkZGl0aW9uLCBJIGRvbid0IGxpa2UgeW91ciBpZGVhIGFib3V0IHRoZSB0ZXN0IGNoYW5n
ZSBiZWNhdXNlIGl0IA0KPj4gd2lsbCBtYWtlIGdlbmVyaWMvNDcwIGJlY29tZSB0aGUgc3BlY2lh
bCB0ZXN0IGZvciBYRlMuIERvIHlvdSBrbm93IGlmIA0KPj4gd2UgY2FuIGZpeCB0aGUgaXNzdWUg
YnkgY2hhbmdpbmcgdGhlIHRlc3QgaW4gYW5vdGhlciB3YXk/IGJsa2Rpc2NhcmQgDQo+PiAteiBj
YW4gZml4IHRoZSBpc3N1ZSBiZWNhdXNlIGl0IGRvZXMgemVyby1maWxsIHJhdGhlciB0aGFuIGRp
c2NhcmQgb24gdGhlIGJsb2NrIGRldmljZS4NCj4+IEhvd2V2ZXIsIGJsa2Rpc2NhcmQgLXogd2ls
bCB0YWtlIGEgbG90IG9mIHRpbWUgd2hlbiB0aGUgYmxvY2sgZGV2aWNlIA0KPj4gaXMgbGFyZ2Uu
DQo+IFdlbGwgd2UvY291bGQvICBqdXN0IGRvIHRoYXQgdG9vLCBidXQgdGhhdCB3aWxsIHN1Y2sg
aWYgeW91IGhhdmUgMlRCIA0KPiBvZg0KPiBwbWVtLjspDQo+IA0KPiBNYXliZSBhcyBhbiBhbHRl
cm5hdGl2ZSBwYXRoIHdlIGNvdWxkIGp1c3QgY3JlYXRlIGEgdmVyeSBzbWFsbCANCj4gZmlsZXN5
c3RlbSBvbiB0aGUgcG1lbSBhbmQgdGhlbiBibGtkaXNjYXJkIC16IGl0Pw0KDQpHb29kIGlkZWEs
IEkgaGF2ZSBzZW50IGEgcGF0Y2ggc2V0IHRvIGRvIGl0Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvZnN0ZXN0cy8yMDIyMTAyMzA2NDgxMC44NDcxMTAtMS15YW5neC5qeUBmdWppdHN1LmNvbS9U
LyN0DQoNCj4gDQo+IFRoYXQgc2FpZCAtLSBkb2VzIHBlcnNpc3RlbnQgbWVtb3J5IGFjdHVhbGx5
IGhhdmUgYSBmdXR1cmU/ICBJbnRlbCANCj4gc2N1dHRsZWQgdGhlIGVudGlyZSBPcHRhbmUgcHJv
ZHVjdCwgY3hsLm1lbSBzb3VuZHMgbGlrZSBleHBhbnNpb24gDQo+IGNoYXNzaXMgZnVsbCBvZiBE
UkFNLCBhbmQgZnNkYXggaXMgaG9ycmlibHkgYnJva2VuIGluIDYuMCAod2VpcmQgDQo+IGtlcm5l
bCBhc3NlcnRzIGV2ZXJ5d2hlcmUpIGFuZCA2LjEgKGV2ZXJ5IHRpbWUgSSBydW4gZnN0ZXN0cyBu
b3cgSSBzZWUgDQo+IG1hc3NpdmUgZGF0YSBjb3JydXB0aW9uKS4NCg0KQXMgZmFyIGFzIEkga25v
dywgY3hsLm1lbSB3aWxsIHRha2UgdXNlIG9mIG52ZGltbSBkcml2ZXIgYW5kIGNhbiBiZSB1c2Vk
IGJ5IG1hbnkgZXhpc3RpbmcgYXBwbGljYXRpb25zLg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlh
bmcNCg==
