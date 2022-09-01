Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299765A95B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiIAL2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbiIAL2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 07:28:08 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AE13973B;
        Thu,  1 Sep 2022 04:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662031684; x=1693567684;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=k0QHj0qnA8mAq1rlzJYAMZCjrEf9jhzRtQzX47ua5fM=;
  b=X+o9AEAOgyQc5zEYZg2fyLKJiT5l25It9NOupVmQRuJUKIzdjCQ6YAVf
   5XhhRhTmCNnY+kYpSQirQCpLeG3NClI4YRMiawGN/MQhrglJzhBv0chJH
   Wnxx7UYKCGd3XxoKwNJAbpVz+6OTyOZ9xMnvrMRY65oEr9qeoUnAka1E6
   9Du90ftETuT5VyqvTqgs+NLSS4klAIXp1J7z8/le277MjeW5doSXSAE5g
   fJ6FnbjE6sZZGzZYXMulu1Z1FqF87S4krpFWUInepcsUCjwI+24IVg3Gs
   1dKwHCTmSeLSaz65CP+sGt7FhHc0fxfeXNSpVjuXIpzlqXMG5QU6yST7S
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="210220717"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 19:28:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBsHsQ9tWyN/hQG+PHVM1fQH4IEljR0cQrZ3aHtpEiB4PkqJzf1Aro1RTXv9V/zVThrnK1hh6sMkM/nmobmzEhh05QS5Zq5TxIuE4Zl7qkiRJojFIE2sL30SlOt/IaYMhUHxo+mldnXUIJBe1rtC5dQPvVTGJu3tW8ByUw+MFf2lwWDlxLApQFi4DhpFSNB561jY7lg0B+gGjovgNtdauhR+YfZQzKd4SzpHy7x6mVNYxYFx6pT1xm7/8hTolgY/Ysh41zerOxzz9QSZ/qnnGXCk1LVb9F53/77iZar6GXTUfr0nRI/wWDyQ/FPO+jkhfTTT/kQNkSt7mS9GrmgANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0QHj0qnA8mAq1rlzJYAMZCjrEf9jhzRtQzX47ua5fM=;
 b=EeggBONba5jUspHsxcNyjpsGjps3R8u4kqWMTKqEpLMrBLeDD5ulOSgJfoqUWPLlzFL3roJV58tk1x5+/XG/TzBFd8leiQ0nQi+DVmaVeX7ZWzhkC9BNFKGPZ4zsOBKqQSnPMPqPF1+i7IVWLjoMfpZGLmDqGSs5UeF+04ep7zu8qETFo3vc/pU6oMC7XR+ShtJvWH9wfQjF1RJNNqflNwZXPZsBpCbHkQTpmavsDn9DAJC8GqJVRiwnOyKl0HCmuM7zR9NlyeXCfeK2/BKaLPH1ZPWB+zgyArLdtzYn7/J2pz3+U4WoF6KsDtDbh3AxZW2sWMgtF1v4fkhuo9SVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0QHj0qnA8mAq1rlzJYAMZCjrEf9jhzRtQzX47ua5fM=;
 b=zQT0zmez/CRm1moD3V2isV7Ej6Vs9pOSuY095oKgkugcbBnZ1XAg5fCfQAVoLNLTBWo6Cg1HcRb66jdOseTsdcwf/6BpIR+2NyujvNJVBgKOV2wEoxJuA4yXBxMKaPqwImtP9tUyyffPM7tocpEedTzMjrYljYrk4hYe9JDBkuk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7109.namprd04.prod.outlook.com (2603:10b6:610:9e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 11:28:02 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%7]) with mapi id 15.20.5566.023; Thu, 1 Sep 2022
 11:28:02 +0000
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
Subject: Re: [PATCH 15/17] btrfs: calculate file system wide queue limit for
 zoned mode
Thread-Topic: [PATCH 15/17] btrfs: calculate file system wide queue limit for
 zoned mode
Thread-Index: AQHYvdaGhrMDZUd2SkCywmC4w368mw==
Date:   Thu, 1 Sep 2022 11:28:02 +0000
Message-ID: <PH0PR04MB7416325A65FAE8C9210F3F879B7B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65c00c5d-e1c7-43de-650b-08da8c0d07ff
x-ms-traffictypediagnostic: CH2PR04MB7109:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /MFyPKeDYaghyZfoevqXO/o/ek/ppu/finGiRvhglyDF73HmuNZb1hMk18mdEC6CoI6fZcJhnSBWWozYwzH9nG+sAyKZ5N70jElHyzJuhSVYMV47vMVbtDwuCWc9su7UJYR00b+C3dPEoI4x9GEi11Skyew9Nz2jhffeIiALDva/y6zOI6gSQOOCoPpEj9/tJBupeJrcVQfspcW12XLR+34LlxPt6hr2U7x1LC9ssQcrKJnc5Oa55I+Z8yQqGCPJK/2sOaqfgWSGBXvU8ukSjfzp5xAILvOSvkqcSn5skBm2GKdYXEqueCrLfol6rwXW9ScWWhiGc6OKHwvOB0YxAIxYsWwkTGLBtFQ6lC63gOabMLgUyH29f99OMNTfNsHvprRouGeJ732OcZb3BWMji9MZsRtMH/ZmnfF0lxl+VqMtW31xZoBhMkzaowdG4xpcJpIzEA1Mo51+I621ySvXhmoN6aoPSAhWSJsUhiv2hUkOxbqjlWzaMCis5zPGKbISbh8qarrDFEKnapBsgtYry5EpcAATqEDlJTRKWN2/1IlEW7japnJIBfaU5eDlw2lFrPWGId9e6uP7ULJLL0BHtqUV1G9XR1P0q+K5494ZgWbSDIKmr4jjKveVKb0/fErpe8aNYZZDE/6A7muLX4p5+4LNYbcEH2CGPKFLTnErHvaRkZ6GGtDwlcuzndvF/4WP56YrjHjKqIyjHWxwBv96VrhGgJDAlRhY40vGGWwrAHv5XuNgsRbcAjaHd2OH2PfH/ZJBv7PDD+I+pMb/MTZhaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(53546011)(9686003)(7696005)(6506007)(83380400001)(86362001)(186003)(38070700005)(82960400001)(38100700002)(26005)(122000001)(54906003)(66556008)(76116006)(66446008)(64756008)(8676002)(66476007)(110136005)(5660300002)(8936002)(316002)(4326008)(52536014)(2906002)(7416002)(4744005)(91956017)(55016003)(41300700001)(478600001)(71200400001)(33656002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RAuw9jqGCs3JKSDyaTrRzDNwfz6kohgZ4anMcHdGtp0gI2u1RmOqg9Iy6XKD?=
 =?us-ascii?Q?SAp/wlLxuHYepQCc6fYkHU1nlOd24nzcCLANRb8LzY8MHAVpVu0AmSCvuFss?=
 =?us-ascii?Q?QNBVaLBpNM6m+9EhQzIasJeSmgOuxonXMYSFDuy1VngO0r8N5zRlivIekVQm?=
 =?us-ascii?Q?LwOSxaEewFngSdUGPNwHAH8cKTYnohq2MZRvGhKf1x+lnYO5qzH2OW7HDJvR?=
 =?us-ascii?Q?YnmUlzeNBpQsfSlbk6PWoQWqBtN85d3I/cCAooxdDGPhPv5VIsu2UuBatqfd?=
 =?us-ascii?Q?z9KP0MWkWf/6Z8YO8pWLYQy54c24luRvsc4+LTfn+wBzbmDbxe8BMSZtAh8d?=
 =?us-ascii?Q?glYp/rNOg38kGNTgcAU6i1TBbiUGZQz+rWso2pd59F/dzUakMPoTKGjy9udh?=
 =?us-ascii?Q?7OyViAkwCZOJU/5JgXcRXuP9YuIPN1tLIVbVw/qJfs7Norkl/HBYgLGJTW/k?=
 =?us-ascii?Q?/6l2rAP8wdWRuzKIg/9BaYFG6TDJPzLVZPUYZtHB4NYzTiOaGRIKC3S505M8?=
 =?us-ascii?Q?IdJZ8WmyRmnm6YMxbYwsuzZUJ+J+dmgrRLVGqfqBJ8Yksj8tIRfpXfvzkIRp?=
 =?us-ascii?Q?h49YWZlsPZdui4yz3vQx/ypCGgr2ecnyB/sIxkOrqhU+erY7u03Ntx5aKY4W?=
 =?us-ascii?Q?5v7RlAMq4Zv7ztpZJ9RsJGlYSLKZU+olprgQRze5jlju6GtpwkWfOSVj8bCw?=
 =?us-ascii?Q?rxTEjPZpstREWqwwv2qCFxcMGk0AM3DU2pbVkO9cM87hy6S/SBy3Uir/c1pt?=
 =?us-ascii?Q?d3hg7wcjD36x+2IyxhOoHZxI4GmFNmr3yN/JzMV6T+KmIU7EHi+FA24jx7xY?=
 =?us-ascii?Q?gL1i1yPO5MmAtoNnselcV0g0rGTXdLfbvSg1yhPPgrfeQJDE2O+2sT19qw2N?=
 =?us-ascii?Q?ANNgnvsPrcxqoeq4F+2Y4VUgOH6QN7oWDnVSKBsdi2Z9ieL2Zu8fOpblbJbk?=
 =?us-ascii?Q?2GZBC1BXO5NU2RGAaCAUiaAMnWNnTYEOS7mVCh8Ax7xPiv0GZGy6Gm6lVM83?=
 =?us-ascii?Q?zj7Ekj8eYhWPxgrlOhHBjBUqIcoh8+6AoTubDNxhILwJmmi24R862mFe02YQ?=
 =?us-ascii?Q?0faLZLiUU3RR6thQ7Dpifh6xEldhq8TWDkJ5P4A4Hvnh4wYVUJfX+19Lvv/y?=
 =?us-ascii?Q?ZpPAqWMXsV3QEp7p/lzR8eFvkVkLV/MWQLm4byEl1wmWKqho/CPgZ1/uV7dH?=
 =?us-ascii?Q?zXquTM4vUHQuv5Hvw9brmqSd7XQJhiSrJS2dnrthWRcnapT+VIwFRG18pAlI?=
 =?us-ascii?Q?yekoFw/45aaop4IvCAS7BxdgjPUAdSUBaP/Zdz8gzRPBx3qmS7Q7qsftmlK4?=
 =?us-ascii?Q?q5SK6wSxA0wz4wP1qp46P3qyu5j0vwbChmLLp62GH7wj/KP0ECTiNpuQErFa?=
 =?us-ascii?Q?UcP9RuhJ7vw6A5wk52K47zriQ/BRmcUaamrCaXZ7JC8Lun1YdcSRGYnbuD3y?=
 =?us-ascii?Q?xIowhk5zNF/Pt0KhOUcm/D05qy5M7K9xUa0l082uysz5vv4adS5+OungzmJl?=
 =?us-ascii?Q?SE+eXCtHhLnKy/IEb705+AuarZa/hbxzqKmpI2kb+aComZbXQMYjYmGoEuQN?=
 =?us-ascii?Q?dpMaX152kcPrIHRM4AYE/MShsZq1w2GoLvEgp5zR5NJTY0WixAxI7kABOfaN?=
 =?us-ascii?Q?rL/iZ+5cBS5B4/aRXnw+vfM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c00c5d-e1c7-43de-650b-08da8c0d07ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 11:28:02.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DeOek7Gj9MH49oS672Ko+6/uTE8jlYXWIs/bxkdWMB9G8IipjXrVVS+MwDobN4CPPlnuPSlqv1DpX2xBwkg4XeQnfW6W+jaKZ0URCQ1rhlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7109
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.09.22 09:43, Christoph Hellwig wrote:=0A=
> To be able to split a write into properly sized zone append commands,=0A=
> we need a queue_limits structure that contains the least common=0A=
> denominator suitable for all devices.=0A=
> =0A=
=0A=
This patch conflicts with Shinichiro's patch restoring functionality =0A=
of the zone emulation mode.=0A=
