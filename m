Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA650243B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349691AbiDOFnX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiDOFnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:43:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86711A00;
        Thu, 14 Apr 2022 22:40:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f58Bsro6zu7Ss8dNVaTKQE+FQHwhPGehVpnj9W4B+slHL9fwI48rREnURxApH08AFOS6tetZWGpdhCs0aDbTMGYJzPElJ4+c81Me7S3iU0LalnON3f/MwnyeA4tzHtXmLMA/I2XIouVy2NxRb61XuGueE9VFwfToPkMr9xDxdzH17j9rK9J85AzlWpuDmGHh/I9oQxR7rfvI6JFIfE5CCc1ZrSa39xJjoWt1EcwYpRf2e+EXohU6ImQeF2oNZ66sVVKSvuGQYAxTWlR5bfT/fBoDrUhYcH8XOHU/WrWfdE0nNxLJxA2rb3Pg+hJH/x8TRvVCFdJLWenpTMw1yu9KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xPbQGHhQ4OpqliAE2ppXjst3khmyYefsmdMvrf0gYE=;
 b=jjOzoE+Vm/qlQokwddIlSUm8ecBKDholeBySBcVSLkkbCG6Hh3ZOr9CsALbekzKvEbtyNHWqFctTTgvkbiXVvtBB5d/PwNRe2+dceM1ubhtxP0NJpjH+YDmrlyv4rpkio3++V207NVXQ28d+r00G34PPi/vMyWfJbNslJNlrC1TS6/scheNPzT/3p3eo7XCfMAfusElPYz2XSjueoHOuQAqyqOwxYj0V6qX60d5Y7emoAdUhQQesmYJITbHdORrpIMQDk1+LdrH9LGEp69MrdSQFWlHD/ykfpSZftzMX4OlsMYJpkwBxUVwNzPQ//Sbz4ETDknpEVnpQuZm3zQb7vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xPbQGHhQ4OpqliAE2ppXjst3khmyYefsmdMvrf0gYE=;
 b=jm6qn2n01mei+/os+xEVde2HSiJOmUg3q2UrHEN9LjaywMdGQwJFt77WfC70RrylqIfeYNwzM3TMGodHOlZkAvg4lYloMyZ1DpLg869ufX2Y5nXmupQYG4w9ZvAK9mZlkd1+0lndelrlNYigERJuS01UMGYPMxdei2NImPnA7vKA1bz6Sm5r4C+crImloG6Ba2xeBfe8WqxpMFN8iAOZs9zr8x9oAuNvOOt/yRwOPLHtLe+IsLkTaS+LwmdWGwtfuGnOTPuhKv/4Kfu5EC0YHUxh5DDCLvJ/TUPmku9oaurCrlU+EyFlVLn4TA8SDJSgK9IyIMWA3cOO9m08nHQbXQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:40:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:40:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Thread-Topic: [PATCH 10/27] mm: use bdev_is_zoned in claim_swapfile
Thread-Index: AQHYUITaaZIEEJsgKUC+wO3WwWQ60azwdbIA
Date:   Fri, 15 Apr 2022 05:40:52 +0000
Message-ID: <0da96aad-412b-9afa-c42d-92ca2a650d1e@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-11-hch@lst.de>
In-Reply-To: <20220415045258.199825-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aea663ee-d1f2-4514-a72a-08da1ea28110
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB18159DA5D8FC0199C25F222EA3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M34dFIzT0LV588aq6aIAGcgbjFXRluuYfXVQM6iNXvjdMwoeKeFBKBg1bghEe7k9t8y6Z5AyNBw/oD320Tio0S1m8PgrMXdIhntJtODQdLBnIhKAP28tJkRREQtszuGfbWFxqsBpClX5b2CNwWfFcyZOV9iU1D/FDauDeXl45/gWrS6a4h16M6rbfnLLgI4wBd7UwkvXcP1DTEPisunfwUMy4+wCC3eFpvjkbARACjDrUJTgMZFs5TZokIc6JnZnMKzIupFEqnhD0hcHJBAwuu4ucObPeA7ecyuz4+4sEG74G+2F036CTLI3jKSw7bGTOTJCwzzuZO9U2uwikGT7hbW77Dta8N6jnvi6E5eZVARMdmJO5CD8pvslNQvIcAte5bqUZzg+j6SHYsvaxhM/Zzv8pK8jbup781PwaxLUuGeVChY22kcWzr3RBW2x0g5ZRh7Nh0ipfISoWUnD/hRIU8LP9ftilHK4Oyib3ov5IjNleB9l17sxDKoEZ1iNpdf+UK5spUg5UA67pmlowjfw2IaOWzLbcrsQpuSy2gM5fQ2jPiG2CcXZi6RgmNoMsvXeWwmbP2uGJTlDhNWSflSWcOBe/1gX5IZU/hZGYfCwiJETf2A7vLRzSUCxSzIiTsWu3J3zSqXmTlN7p/QdH0bmT4GNBdyJOtdsp0a7Z07Og+b+Wy0yNNubVjqJAv6islzQqCPzpMffELFiAH3SFUjlpVM3o3SYWA4Zptgo86P/qGFflXN2rtVGKcZevr3CvF9Us9LApcqQqt8taqJvFLfk8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(5660300002)(4326008)(66556008)(86362001)(31686004)(508600001)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(558084003)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REtnQjB2b2dibWFRdnVXaDF4OXJNTDVZaGFnQzd1ZHp3azVzbUZKL1JDdG5N?=
 =?utf-8?B?TGg3V05zc0dYUGJTSWNnZVNaSVFwK2JhSC9GNlMzQkVvenZZaWdFK2I5ay8w?=
 =?utf-8?B?dDl4V3U2dm5qQ1BTRlpQeVBRWVhFRjcyeFBheWVITk5nRklPNDhDcDhZRll5?=
 =?utf-8?B?cVRzQVVSeWZiY3dvdFBUaWtVOUU0UmhUY3dOZkpCTHB2S2M2NmkzVnc3U0V2?=
 =?utf-8?B?d1lUMmRRdnVKS3p4UUVDaDJtSFYrNlBkT1RFZVJZU0h2K09SM2paQUdJSGpl?=
 =?utf-8?B?aGxDZGF1ekJ5Z1pZVjBoM0tGdmJtcko2NWlBd1JDZXNSYlJCY3hWMlBVZ0lu?=
 =?utf-8?B?eldoK2xmK1NhZkR3THpQUHNOd3MwdmJROTVSSXlqNWFJRnNFdGNDRENCRFBN?=
 =?utf-8?B?aDRTazUxbUVEM3EvUmU1RG0wUGhadU1pdWFpWFppZXBBZ3RFYjNWZTl3bFRY?=
 =?utf-8?B?eDZDMjEyYVh1WlZRQUpkSllRMmttKzVxTyszYWR2bFcwTlppbXJBd25weUtH?=
 =?utf-8?B?UHVKdTBmbUlVRE1QZk1XSlpURUQ0UWtVY1RsSzh3N0k2S2czZkgwYlJ5cERa?=
 =?utf-8?B?RldrellCR2hCV2cyL1dMeDJkRE9tdUpSdUV0ZnY4enlBSVdTZTVIb3NkUHlU?=
 =?utf-8?B?L0dNU2dIOFlBTEc2K1RyRkxaQnVOTUpFQVNxNkQ2bXFBbGhkMVB5bnQyc2ln?=
 =?utf-8?B?UnI0Vkx1MFFNOWp5eEdlWnk1V0EzK1FGZHlVV3RJeXNpMDI1aWl4Ulc5US82?=
 =?utf-8?B?WFZXbWxaSXdPdk1keFBWMEcxUHpWb2s0MGx4TWtTdUoxOTRLMWI3RUEyUGFP?=
 =?utf-8?B?dmEySHh0bjdqNjNIVjlNMXFnL0d2ZWhZaDBMNzZCV2NNdDJtSURCbXIrZVVl?=
 =?utf-8?B?Y01RNndva3phZ3dRSU1LR1pkRlhVNW11Vk9tYnM2cGZOcHN4L0RXdC94VDBw?=
 =?utf-8?B?K09zNlhVRUY4TW12dUZlNU9QQTZwOTZ3YVhieWdkbkFjUHJ3dHJMK0ZsWjV4?=
 =?utf-8?B?MDJDY2ZUUmV5ZUVwRTlrZittdWdDMXU0Mks5SnZiSFFNellQZTFFVDNGejBZ?=
 =?utf-8?B?RTMybExHSXMwUXkrRmhIdXdmYXN6YmlhQmJxNThweWJhRFZSTUgxOVpCd0ln?=
 =?utf-8?B?R2RMZVFEK3QwQlg3MjRGTjk2Z3VMSC9Mem5Sbkg0SHVucklQWWE1aFQxc2I3?=
 =?utf-8?B?emJyakE3dHRmQ0FaUjJaTU9TUzIwVllKUlRKN3RKNFlzSXBUd1l0ak9RZUp1?=
 =?utf-8?B?Vm1CZFdoTmVGN1orYnRzZ04zMXhZMHFOdTdkWXJkbmh5YndZakZHc0VURWoy?=
 =?utf-8?B?RXhxclpvZ2N1Nk1tTFM0c0RsclJBTjVSdXBoYW1WdmdtdlNjbEpDK3BqWk5F?=
 =?utf-8?B?NFpYWWo5cUM3ZDVzZDh5L3B1WDhoTi9sbm9SK29Ma3FOUEpWd1crelMrQngx?=
 =?utf-8?B?YWtGblNiem9uVll1N2NtaXlaMVpLTHdWd3piUUpKZTEzbTlqTFordlJhSWdM?=
 =?utf-8?B?RThIQ3RzZW1FOUs0SGVaRkVPaDRkTU8vUnB6cktqY3Qra09MYUVoWHJlTzNI?=
 =?utf-8?B?ZVR0Q0tXRFFYemVGcXI3bGoyZThnSzdBSDM0K3dHcFNNUXZqbGZyYWpkcDhy?=
 =?utf-8?B?QllKQXRCZ05FbjV3MTNqV1BXZzg0VmkyeS9UZ2tYdlRSODRrL1BrRXBzV3hW?=
 =?utf-8?B?V2dQTkJKM2hzRlNLZkNHUUgwOFhZZ01HVW5nOUxnYTh3UWErMFNwZmFIWnds?=
 =?utf-8?B?b0xGM0NOUEEybmRNWGlXdWJLRS9PMEhmL3lPV0Rsd3laZE91clVlRm5MNkJp?=
 =?utf-8?B?ZmRDV2ExeGw2bkhFc1A0Y25CMUZ4ejhOOFhqeFV1TzJBUDlSWGZIamtsV2JW?=
 =?utf-8?B?a0NLU1RlSEQ1NW43TzVkM1piOHdvdjMxVm90V0RhLzEwK0pKcndYNTU3cFk3?=
 =?utf-8?B?TzBEYXhKbEpXVlNkcXVtcThOSFdwbTYvTTJWdGVPaUpzV1NYRjVVSkx4aWZu?=
 =?utf-8?B?QXBRbVA0SitHQ2s0c1AzdEZQK29BUURISmIzZWtSNjlFOW53THo3TkwyRGNR?=
 =?utf-8?B?MGRPYytuM3JPTUUwbWZSamxxZFpEVE02aGxLM3JSK1diTGRzN0QrclBoeWIr?=
 =?utf-8?B?S2VtWWtXMnRnRCtaTFM0blV1bDlHWG5GU0hYODFmeFU1ZG9YRmNaeW9vVUdF?=
 =?utf-8?B?QnQ3eDJlZk5WelYvcGU2VUlROGoxMGE5RDk2OVZvWHVGVVRnbnB2bWJmQ0Fz?=
 =?utf-8?B?R215U0tORSs1ZXVSS0Vjd09ySzRSNXM2Y0M2OW9OVEZFcXJRYU80cXhWcEVL?=
 =?utf-8?B?YVlSS0JRcWRhNi9lREtiT0Z3TEw4Q1lTUkk4RjRvOU94NlZYUFJqNDBud09j?=
 =?utf-8?Q?fNzSH1XXej3O0JvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <807FABDDF8F92345AAFE5DF5D2053FEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aea663ee-d1f2-4514-a72a-08da1ea28110
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:40:52.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRHw2otjvuGwsDds8CNzFbeFzIULc5OPanDRop/gKBwt/QQI0D4jISCjUFC3clY67udtv5Wb1eK47vFOJyX3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1815
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFVzZSB0aGUgYmRl
diBiYXNlZCBoZWxwZXIgaW5zdGVhZCBvZiBwb2tpbmcgaW50byB0aGUgcXVldWUuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoNCkxv
b2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEu
Y29tPg0KDQotY2sNCg0KDQo=
