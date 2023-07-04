Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17112746C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 10:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjGDIyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 04:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGDIyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 04:54:13 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19757115;
        Tue,  4 Jul 2023 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688460851; x=1719996851;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=eVbaU3ESehABr2S1LCCVJ0SUtANXAjfnRBnPzEXdItZwTJYlMOdb2i9D
   I2VJnZcHHvyauFXIOXKhvfS2MzZRZSsOq4AdReIUY582Y5z8X4MvujVSO
   xDIBTjmppOx/dVDLprNQq1C3FNyyXrF06AD5LCiGqo7D4jsKv64rCUqRY
   8tFMgFVns7ujcg0mjmRh04y0DXKX9ESEHhUPYt6I+HbLP2CcWdiM45SMj
   cZ06F/cd4dkrg+yuzsknoV8C9efvoCJbdfqBaxQrX/Rp2W7K266Y9vqZB
   1CpGh9WUOi7ejM6QKH43hYwzH2s2N0X1DPAyZaJ5dncW13P9FQNbXIJqk
   A==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="342232369"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 16:54:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJAN0z6uNgLd+nhiQ1qwHqc1sH0ReohfujM5TjTJN24r8yak0KLXnFracVLnIS31dFr5GpTqBEAKQ5yHBomrOnq9LDWwx59zbddc8/RvP6XnxI8mVZq0O3XOKhCD3ViwbWJVrcCxfABwjMlHfVEWva+pZb2m6AZat8jgeQWNNalg7OV9bF3GbvNsKHcmNtPOY7k42s+nQCdnsk2h2e8s9yMGz5Y2nweeTK2Tk14yJQvTMnbJpQaKN4zGiftdzJiPs+pw+oPRyMqszQF+DlX/DA+USle7zaKoRJyfZIrnJ/S7VsMjniX1s3NoJE3RVqLg0Zv5PzOzlbsxPp/T8J+3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Wa4CVJBXapyN3j+hbkV8ESBETCh7eGACZl2lvyPyMwWRZciqfv+humVB8lIoe11NbsRVuVux0oMkz78JxbrLaFNobDLvLo4pPXekTaL9coZKXKRoNe2qh9tnoBDbm0aIxJ6eXpIk+64nD3bdGowvU/UkU763ptLb6MFxyIt+qXqkCb549E8OJurXEHXGHOh1szqQ9XTSNeTbriSgLWnSXjwJQsy55dANIk3Jm8gUMkmubWDKPIN8I8wmyyT+VhVGw2esP2/srZ5k6h+5+7cqL0ej8u0sCrpbFN0oIfcoXnCHgYR4F69yF94vOUGuCwy4eb4NMmrAx6lZHw+8Wgvqtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=CcSSr7rral6DQ4CrSJeSBGV19DrDsGOTGiKLTjEeQpvALSdj/nwxqMkPRfySTHH3w7yQXa5ooAyrCALOB/y77JaYBfq0LUb5lcmDwD5Jj6xlM1L+JYmGY2RSe0cm5IC0K7yP3y/6sctA6wx0g5+bZxv9dpYJJclT2l09gIAFgqA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6580.namprd04.prod.outlook.com (2603:10b6:208:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 08:54:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 08:54:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 06/23] btrfs: reduce debug spam from
 submit_compressed_extents
Thread-Topic: [PATCH 06/23] btrfs: reduce debug spam from
 submit_compressed_extents
Thread-Index: AQHZqdYaDmCaoKUrz0yVcoTy1YkPTK+pVoMA
Date:   Tue, 4 Jul 2023 08:54:09 +0000
Message-ID: <631b2389-e853-9abc-c48a-211b03a57ac7@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-7-hch@lst.de>
In-Reply-To: <20230628153144.22834-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6580:EE_
x-ms-office365-filtering-correlation-id: 4c1de2ee-7e32-4e69-7f31-08db7c6c3b17
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fSVXdFgbIpAXcQ+tzmwSV2PeH/jAtHbaqP6fN7+crO/esVv0Ra9DOWJf798fzLDV9hAOmhsefnGBM045BW9WJcSELXiCM4oP5GPOFk4rTUoQfofvpCkbfcdY0I9GGoBCCTBw/Myu8XokaTn3eykiQpwib9DvnGUybq6dBtWwXi/liw4YKGm0MZwVVkvjWiUytPsimoo+FZfgMCfjpd/dtVi7HCdtIsS8loDrBfkcxfbR7Do9BUV6Q3oGR1W5bdXwgGXhoGsnKqbkBCdQKcIdS+XR5l4R74HGmZ/Yjnv1LNo62QljCaQNWrUC9OMFCzp8yRrKEqnqkl+sXdOgDpoFa8wj1M6CN3lqLenvwGe/I6Vtayme4bZACZ844f4krD/JQvYDCKYYI8xSmd64HYzfLPADCLtpw22V+/N5TX7kqVunV0wg+e1825sjV+Tp5HPQQEDmIkqdO6nM04Q+hQ6vtswKiJyvR3oXhNje1C7BmVt/5SdGswlu78dZZnf0+7m+mXHJjUOmO0QnsbMB6gyzhWSU9nkTFFlgr1D4EMkv2UKNnfvpl+aDMU77SN9WfPokO0AUxhlnJ5LoJCWXYaI1554aiw7IpJvSHtmMdamiHbEJ8JJrNi7+uiBJ/MfH+kCxO2Td7rCpdkz+5qJND4Su+HZUoNFh86jqvgI0x5/3hROJcBALIVfQvLrtqp1QtGh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(64756008)(66476007)(316002)(66556008)(110136005)(8676002)(41300700001)(19618925003)(76116006)(54906003)(91956017)(4326008)(82960400001)(8936002)(66946007)(38100700002)(122000001)(38070700005)(6506007)(478600001)(31686004)(5660300002)(6512007)(186003)(6486002)(71200400001)(558084003)(31696002)(4270600006)(86362001)(36756003)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEhGZHIvdW54YVRGcjY1b1EzTlZRQ1FydzZYQ0gyR3Zramh2dTNXZHJVZHlt?=
 =?utf-8?B?TVNPeVpKVjB0MGRhVFNtaFFFSEdMQUJKNmFKUmJTNm9VMzRNbUF1N0pMYytu?=
 =?utf-8?B?V095bWtwdk5yRGh1ckt6ejloWnpkaHNDcW43WXdXeWFmTVNVV2U3YVZUZWpI?=
 =?utf-8?B?bGd1SXIxOG1hMTlDUjZOM2ZWREtpbEFxd1VsS1pMU1lrMElZcVc4Nm4rbGp4?=
 =?utf-8?B?dExhU0JNMWJ1THAwb2tDQUVrdFlDWGUrbnZIbjFrZzVwMnBxQ0Vza083OC93?=
 =?utf-8?B?RG9LNGxZNlVIMUM2bzhyVlM1WE8zQW1GaVNkSmZBbG0remxXaDZ3WlAwb0dM?=
 =?utf-8?B?bzUxMUp4V0hkV0cxekFyYlNmeUcxZGFySzhQa3I0cSt4eFNtNnIxNkl5TTQ3?=
 =?utf-8?B?VG1zbnloT2dYQUtsMTBqdU9TVmxpbHNGN1ZnT2FtVkFsQ09VT2JpTXErYnpP?=
 =?utf-8?B?N09mTU9POU9ZMEpCWTg2dFZ4S3d6SzF4bEZRcFdURXR5eTB3REtDU0w2c011?=
 =?utf-8?B?QzRjSHl0YWhwWEVYUldxY2NrRTBNWE5uNVdHKzBHbWVGQmN2M29SMThGRXhX?=
 =?utf-8?B?YisvWjdRN1ZXOWtrcXpPcmNpZ2w5SHBZY1BybnF2VmhPSnNIOHlDTXZqR1dO?=
 =?utf-8?B?aWF5NUtvckJXQndERi85bW83S3BjMDd1ZktYeWtvbnMrQ2xoR2lzUTlJeVpE?=
 =?utf-8?B?cTB6dTltU3d3ZWlXVnFmMThWbnV3RDhsWCticWdjUnFTYnQ5UTdES1lsL3lu?=
 =?utf-8?B?T1I2SElyblF3M2orN2xsZjFxc1RyY1lxUUVMODVSMjkvNzJhejdLd011M1JR?=
 =?utf-8?B?aDVpTTU4czJoS2xNekpYd082VWg4cStmTVQ0UlJoU1pqZUtyYnBGb2d5TkJD?=
 =?utf-8?B?Qk5oS3pqNXNXbDd1SDBqZzZCcmVINzdRQUNZZ0prb3hZKzM5VVNjM0o1MUha?=
 =?utf-8?B?ZkJXVHF5akhDT2dQL25HMmhudFU5bDIwS2p1dXVQcUJBSzVzalZWbVJMbnVV?=
 =?utf-8?B?NWdDMURFWFU4UjY1ZS9oQ3VqSmZXNHVWRzhMWkhmdjJYTFlxUy9oVDNtVGEv?=
 =?utf-8?B?NVRCVzl4ZmlMb2E3djhldGRmdHdNdVpzcGxYeVRScmx5YXNJdHBXQWNnNCtE?=
 =?utf-8?B?WUxORDRjYnNGL205OEhRWjVXQXRYRHVlM1JaZzFqQ2tVSVdwbHY0RnpmR3Fi?=
 =?utf-8?B?dDZUZTF2WnRaMnV5WlRPV29QaVVrVEJzZVNqd2thY2lnY2pUT3dJL3VMRVJ3?=
 =?utf-8?B?cFBXbGE4V0RmQUVpMHJTYVlTcmpTK0F4NDJuWDlyRFJoc2dWcUtJQnhHa05M?=
 =?utf-8?B?cnJ5YzAzU1NISGhzd0U2M0p2WnRZYnpOVWVHN1IzR3h5QTJNVmJrYnNCT1Zp?=
 =?utf-8?B?M3c5S3lzbDFCQTV4NDJMelQzVEtvNTFYRG5PME93NlJJYlkwcUJHUUVDSStX?=
 =?utf-8?B?K3ZLRTlzM0d0ZERkMkErbzlvQjVmeVBKR21TNVUwa0VleHNRTmUwWGNWM2xX?=
 =?utf-8?B?a0QzSmwvRVNGaTdLQi9ocTRHZUN5U3UweUpVcW10MXd4MW5nYVFYVDZjS1d6?=
 =?utf-8?B?a09acGtNb1RVaVRTcndxL3U2d3ZES2FPNW5SN1p2b09XYnBlaEVBSGgrS3c5?=
 =?utf-8?B?cGdoOEg2RTRrVzhPMnRtRDc0WHcvYlVjLzN1Z1FFaHFvWHRqY3U2akt3TXox?=
 =?utf-8?B?L3REWUdHcTVrMlhoakFubEJJWXFYMFMveUZuTnVLQ2xUcS9JQ3VnV09yUUdT?=
 =?utf-8?B?WGhyYmhNckNNZGkzWDhNTTBFNDM1b2dLT0dOcExWMnc0d0h3byt0UTdvMWFM?=
 =?utf-8?B?SkdDODExZ1AvZ2Y0eU9ZTlpjalREOVNWMmtFUDNmYnozcUVTMGlCaEI4QzNy?=
 =?utf-8?B?aGNHZVRsUWxkR0QxYmRGK2t5VkRscTlidjJJcUsvM0pJNVpkd2RUVS91WUsz?=
 =?utf-8?B?by9jVmphOU91dURkZlhnNWZwNHFCU25qeDFWK2x1bzN2Z3FkOGFqekRtSU4y?=
 =?utf-8?B?ZWZBWW4zVVBOazlPMi9rdmNBdTVrSCt4V05VVkZJcUdxWWZMZzN2akdSZWV2?=
 =?utf-8?B?bmxpci9lWXUvTWF1TmZKYjNsMGQ0VE9tTUNJNU0wbnB1NGhmL1BSeXg5SEF0?=
 =?utf-8?B?VndwdTk3SHZJYmdWRzBlQ1VxOWhSK3lKQnhvK3B6RHRxdGhWWHNuOHJhYWRm?=
 =?utf-8?B?dW41c05NMjRvaklsOVp3YWRlQlBrK3d3cEp6eW1Ha0ZqK2NUUzJzSGx5MWsw?=
 =?utf-8?B?NFlNUHRoZjQ2Q0hSOWpmL05oejV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C21C4723EEC4ED4A89B36CFE1659EC92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7MIU7KlQGckJ37+rjJP7YuXTB05/VTwskmJJNa5+dQ05JU0qigZ8dZYBPxPdlzchkuFDdR97BAyg0dUzjmLmevHJZKMhkjzLORJ+3pNZG1ULawo8e+hGgs7M4aZbcObTmYF7lKji4WmzWtc3icRCuQRZytig89oK8iQ4Dkp4IPnSwtYAwMnu7XESD6ERIBuId5R6yWRVEPwtKdpjOrCv6EuvQ3My+S1LTs3XJbZNx8O7npzEilgCmHCB7EA7W7WiXPIDXp5whp7XoeH3ESi9BYcN+UKCSX746nV92nqVwapT1Bi+6cHdRo8GGON2xLVYSUaG00E5FAuH83st5B6IZPP2WQmYsyyKL0hCuPrOnmaCUmhm632rOkoBvln9tYYoW8hcgGG1oEPtO+/a2FooICo9cw4iaGkR/4FPGg+NZU2M/4+/Egs51c12ygFmobXc1MBe0Ca3jDj+OIrEaECcYycfNkkbznNu1rM/WUbkDFQyNwCJRWYd1H/f5qN6b4X6ONXyQG1PIscvfKuPz7ZxgHwsKxy2hvFWbEo64j3HZFn5xIv59kq7zndt3uSJpBuW7S2jx6zX2Lg4NPRtXwn3Janh3mln96ZCFpEcBxvVC791+fT/za8N0QqqcVWtX9DdqebCWlmRQxCL3IXt5yQdLDvLYwsGK0Oqf4a8GEnr13z2hQ0Q56rHZvJKL3LEw2NeJh5iZbri2B5wNXYf7xhqPYhBhg8OKewCOEQ3OwqD2OKbci+wbZPkDoG9ZYPmurRA6jj79vehQw+OhscRGlPzK9kQ9PUDuT4S5FCXXgOIwflYOarNTYc4dTRPQD5n8nM999+d9lrL9KB3dTJinlPObR4Q3vkirNG8VCaDkMW1WfRy+xRlFNuH2qcZi6OXcXOxuYL7OsdgF7QR5KffNF/gNZCET0BhtCJLwctmzDylBpc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1de2ee-7e32-4e69-7f31-08db7c6c3b17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 08:54:09.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvFK6Q4xI49Zanxe6DpXpIrSWSVKG6Dra6vIygaUnG49GiuuIFsfCHbjefqaXaoH85KVSxfe+6txwZlwovwLZ88PL9A1bKzxBPdNwlsfIDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6580
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
