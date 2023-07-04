Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC00746C97
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 11:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjGDJAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjGDJAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 05:00:21 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7031D139;
        Tue,  4 Jul 2023 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688461219; x=1719997219;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3IULmexCWm/51EN9h+EPBMAZZRJT8PvLGXlENOwg880=;
  b=WJiA0FbD2Qb5PFnB9+j1dcFhnchukRGk4HjtonjleHxQTquagYpwXjZP
   ZHxxkfSGEeUbKljPuYp8NJFPxBjl9IrZ2LC1lu1usTQUU7y2R7IasAaKQ
   gLGQL9XwsaRtR8lYCz54Yx7XdcQE9cpAG2hXraQ/BghJvlh5mAqKM3o45
   WcpiF3d2LzcVxxJzhtKrr9KpjmucYpy6bGYMOIJhuKkTAbTFraBM5RO4M
   CXHTJTvHfMHXfi1Alp1Sn5CwugbK49FpwuuQpJcXPxEG+wDhDW8O05T+S
   WEbBjHoImJDA7Q/lwjPIsm6NXm7aiGGSMeeU+DDTNuzQxOoB9WS3d7HWC
   A==;
X-IronPort-AV: E=Sophos;i="6.01,180,1684771200"; 
   d="scan'208";a="237489372"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2023 17:00:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+zusHKxkHxfgOuJDmBFh5yEBc1vZQlbgj9yh7rAcp+aOcV3Nd7HvxTtKWWW9W8iS2eaYZfyWafEenG1rwueG+/AhrsFAsa/+snbuEcVAGCQIViWmtBnghChQcx92hG+81lYgTxHzTlFEfM4PmeMFhXlwL4VdjUm1nCGnIn1xPka0XjLqREIuWYl0NPeXSRkXt8pX4SOqYHovyIid7h57iloS2Pv2qg0VsUot69pePpK0lLV4/CpFtkOg3v2YvkZzw9uk05oG0RGDL6kZntzPw/miYzoMUCS7MDMDh3h/7+o3HpjMwleArnQdmXDTGZC0vLLG3yDgncsXlMFzUHX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IULmexCWm/51EN9h+EPBMAZZRJT8PvLGXlENOwg880=;
 b=b80vrCrXTghBcklsxRMJ6J/FQt0RNJbk7kpmLl/fW8UNKwhE4PpkyYAG/epSudEjoUToCkamXqM2GHA9l8cZkQ00PVEWAUo73FegfCmuJ6QQT3JeodADifW5rjJpnU2rh8sSmNPfIlRw9ZQfUsVuhjo/hqdZDIqLxoXKdjxGe0G2ZYtNwJ5EJq1U472T+gN8g+fgtPR/V0Pwxkvzk26EC0OdagoBW6UYC70CHUq96gbVKjUcEK0S8xY87ATglA1bJFX11Jnl/D09FX797AYZNZW/vDva7/GfOTw0kl1tcylzLTVJoDmCRRUi+MIzzeSXrhGrEq8iyi3/p5+cKt9j6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IULmexCWm/51EN9h+EPBMAZZRJT8PvLGXlENOwg880=;
 b=ogkTba24fl3LlIamBgm0ivyTITp6aBKqO3fdc85THzmiKGztlRphXxtcOoyBbVpX3dmt7jbepkM4fmNZJocrZ6nxeiFGHyNh1aRP1TO0p1Yk0IPjqKEozV9p9c9ewBxLEVVycO5PhlqNLKahC4bT7ThrJOGj6kit+ENavpJBeRo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6580.namprd04.prod.outlook.com (2603:10b6:208:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 09:00:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 09:00:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 10/23] btrfs: reduce the number of arguments to
 btrfs_run_delalloc_range
Thread-Topic: [PATCH 10/23] btrfs: reduce the number of arguments to
 btrfs_run_delalloc_range
Thread-Index: AQHZqdY8RZ6M/FDozUq+oEDy0wdrvK+pWDUA
Date:   Tue, 4 Jul 2023 09:00:13 +0000
Message-ID: <dd0d7f20-cf95-8535-b473-e2909d11ecd6@wdc.com>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-11-hch@lst.de>
In-Reply-To: <20230628153144.22834-11-hch@lst.de>
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
x-ms-office365-filtering-correlation-id: e6802248-e0c4-4de8-f419-08db7c6d13fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ktUG+KRQyQlSv6ZrrYAUWlNW9lKEwU1MrgDM95wufOhyeivGAVXB4o9jeCV9oyIuDxeZpP3EmyLGyujirV6YTqk8t3/9hHieINlg058SZ3mNDjYzvS2FvaoaPjyN7ceia1gaXSEu92QZ4raXLKoae/SHRyhFQKUzKY854a1/des4dhfU3sONxlcpU6kh60sbCUJoeZU8hRJv8uMGuqTe1XdJmEkGYw5Ey3XV91n01uoB0ViYSr/8nqex3yifVxZTFNGy8X/173bYH6vW18gtp8ljqQ0u3eWKQ7pvbfX3GYbNd0H/9i8FASp3zdXo01Aojkg+9l/qJQ8S8duXdyZ93XmehU3UNox/dHKKkh9aZmtUu7ZrpxEDiyaTPlFmbvuGyI9g2pqi6X+/ywz9jPDGQsGnFP8GXdxujFFt2oO6OcB6Du24seg59zSJcwSnKnUvHndcVaaF5puy+ZcmpARl6kk/lgSmDSln0ScyRjQAO9tIbJxxyZ1eRteMh1eDtnfFi5H1YxUlVTrfJPbZtCDYqBljbzlqyiTlLms5VZd44nlCHNmL0yKsHUMAJFTTLGEaNsBTgbYozWoPDKzGw0iQokQKFaIzMeFefv+TQrVQDl6h802Y0GQrZQCDKRkAWLaTALbasBgtuiOTUf8f09sxNr4cfYp4cjYiTVmug4tBLNm58Heerxebs3NXeYp2CtuE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199021)(66446008)(64756008)(66476007)(316002)(66556008)(53546011)(110136005)(8676002)(41300700001)(76116006)(54906003)(91956017)(4326008)(82960400001)(8936002)(66946007)(38100700002)(122000001)(38070700005)(6506007)(478600001)(31686004)(5660300002)(6512007)(186003)(6486002)(71200400001)(558084003)(31696002)(86362001)(36756003)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2hrNlRhL2dENzJQVDJ3QzlHSXlqdFhIZzZzVytVb0lsc0l3TTU5TjF3czN5?=
 =?utf-8?B?dlhxdnlkL0lWbWVDTVJKeUJJUXplVTJYRXRnYStJQk12MGVnQ2JERXQzMDVx?=
 =?utf-8?B?NFJDbHRUaDdzaVY4cWZHbllGUHlOWFVWY2ZvYVo2emh3STV6K05RMm1TdkIw?=
 =?utf-8?B?WlJvN1hubFE0OTBnR3A1cmNzeUhKVTY1aHZPTVdrbEYyeW1yT2U3R053d3lE?=
 =?utf-8?B?cTBGdGFsNlZYMzVPakZBVUxEMG9DeWZWd09DTGZlZmpZQ0hsOTkvTnhpdzNF?=
 =?utf-8?B?aklQUUEwUmlDVWZBOUhOdzNWbTVUdG15dzc0UEZXTGRuS3g2MEJEenhKUTFI?=
 =?utf-8?B?UGxpUGJtV1RwemtIdHF2SXhKdE5kcUF2eURJMmpZS3hVa0pKNWFVM09HeUdy?=
 =?utf-8?B?Y005WEFJMkRGNzM1TXI5aGFtdHNQRlFmQTZJY3AzU0FYU3NtMDFqWU5BWURz?=
 =?utf-8?B?VVV2Z3FRaU1Kb2xHVHRYeTFUelF3UjB3d2lGa251U3o3Q0V2a29zYWR3dHhD?=
 =?utf-8?B?S2gvRXVwdjlUM1BCRUJqSDZ2enRZd1E5bnFtMitDQVRlU2o0eTdORm1kb2dk?=
 =?utf-8?B?cXZBbjdCL0c5RnFnVU1YYVFqU2ZxZ29KVE9NRG1ieGlDQWxoTjc2RTV5Rjdv?=
 =?utf-8?B?RmR1aDNUNzUyaXFmSUJobDhFdE8zVEk4bWVNWXFCelAxbjdFYU5kZlAydE0x?=
 =?utf-8?B?b05VM2dqWndwMVZ3U2s4VUZKV0JqQ1pHQ1piUGhUSkoxaVgwZ21uYktVV2pL?=
 =?utf-8?B?YTFhbFNSZUdqRGk1aEdIOERocFdVRFhZUVdNaGs4K09jY0tQbHlINEt3S3B0?=
 =?utf-8?B?TE95TFNWeVNURkg2WjBMcEVidXpzZXdPWldvSmUzWVl3dUY3c1NOSkg5TXBo?=
 =?utf-8?B?UFQrWG1nOEpUcElJMU5lcm9rWlRVUCtTZUx2UmdNaWcxZ0Q3QVh3N2V3UnZx?=
 =?utf-8?B?WkFuK0w3Z2duWDQ2VW5ZeWVYRHErQzRSYzVHVnl1QVIvTkNWdlF4Nkc5TVR5?=
 =?utf-8?B?UTRxbzlndEhXWTBkNW1pdzJ4SU9GRER2bHBrZHZCamhPOWZ6Uy92ZjEycFFJ?=
 =?utf-8?B?UE5IZENHWERRVS9aY010OUtJTVNmTTJIclJ0MmFCMHcwZFZEU3N0WFI0NVRT?=
 =?utf-8?B?ZDhCTDdsWk42VVliK0N3OGxqUkZLTngzUUJMRVVOTm9NaFZwVFNkRHhONmVW?=
 =?utf-8?B?dUZZZUtBWjIvR2hVaDR0b3dkSkpnNUk3MFMydHZ3K0NhMkx0eEVEWmNzMHRU?=
 =?utf-8?B?SUNKTlN5Um04bWJiUnk3SFFJcERuSDJDMmxMNmVDVXc3NDRVeUJydVZkUklr?=
 =?utf-8?B?S1p0dDdNQldNYTdwT2R5TDJlN2hSWWh0NFRXK1YrdFZqNDFWUCt0YlRhRUUw?=
 =?utf-8?B?TXFsS0FhbUtCZ1YzaFhpSUZLem5rRStmQVExT2E5UGR2aVZSYmYxL2tMbHdn?=
 =?utf-8?B?QU1vdkFSZXd1Q0p5OU11VEc0RGUzdS9qQ1FSUXBkeHZPUjZGRFlKVXU0VU1U?=
 =?utf-8?B?cUdoNThzRFM4aTV6cGdkbnVrWTVFbGhTVDhudUhUR2RLc2RyY3pWK2MxUmR1?=
 =?utf-8?B?MWw0dHIvN3NSbXNraE8vbitDQTZiWS9hNGJ5S0U1SXB0cm82Z0lhVzRCZU9C?=
 =?utf-8?B?a1V1eEZxVUZxcm9EeGoxZkpjV0I0REF6K0czRXlVbmRaZDBrNHhQazlMZXpj?=
 =?utf-8?B?K3YyODJ1d08vS2tTSjNFVndIbzVJR0lUZysxV3dyTWIwMzVrREVTZUQ5TEtJ?=
 =?utf-8?B?d0JSSmJWUktyb0ovTDNSbUwvWDZldG9kSVhZTFNvY1JiQnZnK1RoODR2cnBF?=
 =?utf-8?B?SXhYMDJVL2FvQVVVeEJrNUc5K21pMjdwcVFzUVkyNWVJVHBEMGJOdmtxSThm?=
 =?utf-8?B?VDc0QlFjZHdXbzV3UmlROVlpZEVmY0xVTkJaaUwwY3dSM043VjZJV1hhb3Rs?=
 =?utf-8?B?SjRSck4xZVo5Y0l6UHVBMXA1K2s1elRvU3BGRXMzTWlvVlA4TXhaSnFGb3Fz?=
 =?utf-8?B?bEY5UEJYZVllNmp2QTdTQUxCZnduSlZwdFZ2Nkd5M3BjUVVCR1FVRkQvVUhY?=
 =?utf-8?B?bTlWUkdXVnlLcEEzRWFOaFVGYXlrMi9ZVURyaUxQYnFOWDBKcFZJY2wvVUhP?=
 =?utf-8?B?Nk9Ib1MySk00TVM1bGU1cS9iTkZkaHMzMzdOSHhTR0pTWjJQSGhlTkFnUUJj?=
 =?utf-8?B?S2IzeFhnS0FOQWF6T29RWmFnQkJXWi9vRVMzUUZ1NTV2RzhMcEhjUXhKZlU5?=
 =?utf-8?B?dFFXampNVEY1TTNvQ1NLTXo5d1NRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7872001ADBA75498A8FC2B64AA9AC1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C5szufYVRG03u+2/JlAtYmVDUtZueVel/yOEQz97nVvdmlC38FgF8TVuuoQv8uc+Vud1UTnOVFoNzJxCjVAgueIAtUx59mWTD2s4CMnHWoyxH4aXrrmUxyCl5daDKHIGrtBwjgt4IKTYf3XSUGe6sVwjYP2mlCY3AMq3hQ7f3ENpj060d/OZ2aMDDEjDYdBzGrpomYAE+tcAqVT/FXsqSeTfkfgh1tWVcWZxs+ZwgJ01Q8KZ97huO6fDtzqoFp9eoT96rDLGtA5XclFDoLRXwxWhVGFNN5KDDsfWL3nlf1JfzZD+oIzRG3frGzmeBfUqEKf8AWIcRBXuhkO30qgqtrNRhhpC73Gi8rqtVEMjIO5YqNrJmxesKl3pDkr1hL+4ARqq+LMAcQGsM+cIY8qxX4Zm/fXZiWTlCQBlYwYU9dpShn13xwldQ6WAfJfQcYkpJZ8faPeGvPp0mK113XUJCezjJqldzh+4ubbd7UpXDMzlr1Xw4jpHI6IIzRqObL2nRfewpy23oV6VG6uf+35dxwTN6+va++FKiPARfjR1mvPlV+1Meb1pDxJ9l55WAfSRrkvkY5gvavD8U4TeFhoW1LR8iIpcstd8HXfj/NtCfFNqaweIMclp7h0S5vYTeCupQs69vDKvg6YdeGKHkUm06OkZOX/rDth1+phyLmCWs4KWqyDLtveag00GsNiO1fcKsV7b89sXwPukWyMW0B0tvoYInO3T6ID7b7CchPkqUGr1kyU4y2ItDQ1+XTx92SQxjOConayAeR6fQXsDndpj/bl9liTVQ067iTlQop0lrC/QQYRtRgDhVY4VEbYo2WdBJnEuho8iivL9HHmnkrhNtUvKYFmzcPUE8X1QNmPg6SukUQ/r+7AeGmvXPDjvbd4nQ4ewipgRS3cAoKMruWvUbv4bp0nOv78vYs1ZkBp32q0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6802248-e0c4-4de8-f419-08db7c6d13fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 09:00:13.1283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ryo10WqIl3ppFLy6lylxkiXKlWsXnFbQjvqrbKXkAWULXrlDBzQjfKqIQQ3kgz3hSQwTJTOo77o8o4unL3q35m4eDDUaL1qw8xAYQmeXpeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6580
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjguMDYuMjMgMTc6MzUsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBidHJmc19ydW5f
ZGVsYWxsb2NfcmFuZ2UgYWxyZWFkeSBzdGFydGVkIHdyaXRlYmFjayBieSBpdHNlbGYsIG92ZXJs
b2FkDQo+IHRoZSByZXR1cm4gdmFsdWUgd2l0aCBhIHBvc2l0aXZlIDEgaW4gYWRkaXRpbyB0byAw
IGFuZCBhIG5lZ2F0aXZlIGVycm9yICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZGl0
aW9uIH5eDQoNCkZvciB0aGUgcmVzdCBvZiB0aGUgcGF0Y2gsIEkgZG9uJ3QgZmVlbCBjb21wZXRl
bnQgZW5vdWdoLCBJJ20gc29ycnkNCg==
