Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F009B50240E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348129AbiDOFki (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiDOFkd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:40:33 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3AB9BB85;
        Thu, 14 Apr 2022 22:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8hmcOadGSG92VaohQPg0VH/yBKeIFmAYk/Zr+21PC/zsBiQhRhbyPR0a4e2n3tkglp7kUW0hNWQ5z4NXi/iqJR03CLELttUibu/ydMNS7UZt5Gyhq00SLbC1MuB77PcmULeT83qXkBM/zvrvG747lPjJ1LEB4BxqVFNbIG/mA6RkC83PorDL/lMgcrecMQDhG4gSPtM45g5+9gp8E7vmcTq2Vt9Q1fJ4ELBD7OvidWdb4t2CCG8etTi8Cirx+26ELc0m54BTc9q/FM5iOEep7cFcHlVu32XDrkHIqoiEWZDwBWln2TDIX58CXAwvzQe9WoTh8RL2aJPE+IzQrcCGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+74sie7PTwpCtd24VFJpkgQyUHaJLy3D4yyRUD7Tn80=;
 b=lpe0WgIMb0UqK/OWlmTFAGEC8X0g9wNEJoAYOOhrab+4bOTMbbAP/8rySuZlqpgPjW0ox7R/Oj1VSZ3eS7pWDluv4BOQrTYTCDM2Jg9ZT9na5yuhVKZcfEAY8FWT9QhecI28cOEQOk726CMDnnenyon413rd6T8h0e9Ul/yyBIkF+uyDQyIezRlfhUGu+gh7IxEo25pDPiI4Y0Q3iQBQXHBgPOjFG2S1cGW56LVOvkC+WcJ1RIpRtrh5+XKZuw+HkQp07nCZ/GJwFDtzMZUMwAjpSNCMUpZlTMT/3HXrEfwh1n0o2AZPdlM6n1KulfAnWqfe2lFLotPZ0W2mT5S0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+74sie7PTwpCtd24VFJpkgQyUHaJLy3D4yyRUD7Tn80=;
 b=aX918WIKGvRh0tesQxl97U66xWhTmwqBIixj+qqe6353AASra41tNuWIdyvJ0vv9dQuICMgse/4m+4sEFOAgwqDdqDLbtuTg+2eqdw9cqypNegR5AKwfzSGQ1esrzo/wqwj0T/SF/5Xq3ZUMfv86VEhgFcm/d8HjvpV90yTcuZmGT9BoDQ2ZNEdaC6P5vnZpS5LndgKkG0xoHdwdJVgX4J23Vtg2C2BgtRzrm98UHRiTB9oXIc1fL1jKIbOl3x2UWtOsza1IaNuPOy5hW3xwiDsoHLYUJpQZUZi7kcn4K/DoR+forZO4IfXT1zGUDGyKDUdHsugwnYbNEZsknTQS8g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:38:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:38:03 +0000
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
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 02/27] target: pass a block_device to
 target_configure_unmap_from_queue
Thread-Topic: [PATCH 02/27] target: pass a block_device to
 target_configure_unmap_from_queue
Thread-Index: AQHYUITD/OVlel93skeY5tfftzV30KzwdOmA
Date:   Fri, 15 Apr 2022 05:38:03 +0000
Message-ID: <c440aaea-6617-c26d-e2a1-2107bcc4559e@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-3-hch@lst.de>
In-Reply-To: <20220415045258.199825-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 850d74d7-2e5d-4ff4-4b90-08da1ea21c8b
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1815493E0F03732F323B43A3A3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A3hCZAZY5NLfauwUgZEygmJFzH+z9vEj9n5IHzXfUjAwOC7aY1NJ+fWONw+VhzISBKRT2kQd6RuEDYrytmrA3RqmZ96M0fmdbvUv8BbTmduTkUmofW7negpKepAE+Ih/ChrWBUxejTUY7+Qxkoyc8lMrls4PSOllylTxV8/EYp8cnkL+QF8VgBdTSBQPWrJHiK0TUCOgxHTAGD95g8RCpPY8jILgIqicd+ajjlOREo1PkeOgtowBQZnohbI6RXFPxlcgKTqU3oyQhXr5nyI5WOeIPv/cq7hPAQyBs+rVkm/ayUPqwbRYkOAgXVHW1QUw23XpdxjhRA1mSgUVHc7MaVoFQqcjRUsbwpj15Dkr1h2QgnQXjZKbXkOQuYoS+cS/8F95ekll0/wBcUiqPz9Md9H1XyNxYBurzLUekup30HLbT9b/g6By62MakJsyZiuygt1HzGUg8bSDPoBhGLvlLwfrW6FFaMWiLPE7RWp62HQCN5NfP/QbUc1S/bmqVlHvoyOgf6f4XlPvy7F4tIVTKpAMXDBLhnMzdlsD3WmsPeZdWh2LJHFu0VZ7UT7gn2YECdBx1lO+vvqaCWjJxOcDVuDneKW8hNzii48GgqXOMzFGPo6dGWRrWvWqJy6Dr81PttER/FV0TGZL8HUDcGuuDtTcJru/5nGIBepAzvzrK67Zas8joPvndBwvywdfGi5I3BWR4fYJ57JUn8CxkzVbR9eXvXjkRtiRSQykI+8KpStctDb6EcjAJuRnFF320MhFDh7wNe36Vbk8VoHcUI7sZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(83380400001)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dERYQXI3VmVSUVIyZlJVbGZsRHRpczdjTVpJZ1ZwbmNWRFQrQUsyOVRCYngy?=
 =?utf-8?B?akpSUFEvSXhtQ0k2Q3VRaHNZN0hQRVRESmJ5alFPVC93VmpZNVVaZFBxd1pJ?=
 =?utf-8?B?R1VPRTBleHNmb0U3S2dRYkdZQkhtcDQ2bGRiTDdpd2ZxbGdtTDNYN3doZmtm?=
 =?utf-8?B?UEZsTkVXSGM5dGVXVVVWN1Q5TDhPZy9mMms4dzVVcDFMNFAwbDRSeTJMeTFj?=
 =?utf-8?B?MDd6SnJ2cDFnSHFPdks1dEJ5MzFmbGtSRkNQMWJ1djl3SnY0TjYwd1pudWkx?=
 =?utf-8?B?blFQT2gyd3pzLzM3YWZwOXJ2bmFlYjBIY1ozUUNQVEU4NWV6bkZyenh6aitE?=
 =?utf-8?B?dDFNRlRpemdDeUxHWlY4QUptYVg5R25PaWJVWUM2a2lJSnd1VkFBZFBDRWJl?=
 =?utf-8?B?NjdXK3ppb1ZUNmo3bk1yNFJtMjRIa3FFQUo2djZVQXNod2paUzUyTm5IZExM?=
 =?utf-8?B?bXUzV1VKNFA0MjFhcnNXNGN0NnJ5cTQ2VWczeEFZUmdGdWwyd0FpaUFGSDlR?=
 =?utf-8?B?UHdCWnJUaUdzcmxFUmtFMzZjbGNyTGJ4YmlqZDRSczNFUXFWOWxnOXJEdXdw?=
 =?utf-8?B?UGs5cE5DUWFSWGtkQWovR0ZXQWR0cFNNRi9VYW10TU9OSTZVN1B1YkhlNUxv?=
 =?utf-8?B?N0Q5akZJSDVTRW9lQW1kbkdIeXpnaWF2eGxYVUFLVkk0dm1YNmFqaEVXa0Yy?=
 =?utf-8?B?TkR0Q1JER0pxd2VwWDVrWFp3SEowbnRORFZpTEhyKy9KSmlWMlI0OEU5V3lv?=
 =?utf-8?B?S2dCUzBPOGkzSlJaeTEzcWFObmw1Y240M3AvejJ6QUJHNGNNaU5hUTkzN3h4?=
 =?utf-8?B?SlRWYkZ2VWZhSzcxT1ZDbnpYWHRLY0JtZktCdnNRb2owQXN6MW81QkdRNjZj?=
 =?utf-8?B?TDc3WDBWR3ZnYmhXYWxEczNicVBGZ2J5OFRoMmd6SVA5N2xIdHFsSmo3dlVK?=
 =?utf-8?B?YXBBckwzZmFQZ2Fjckg2bnVkcEZWSXpTbW5vNXZWbVdVYWZHbVJvNkg0UGdP?=
 =?utf-8?B?blhndFNrQ2wrZ3lFckdicDJhNUJlTE9SeGM1R1BXeGY0ZHl0bXRDOXE5MGZx?=
 =?utf-8?B?ekNZYnYvNUxuYVlMNlNJWSs4RTRpRWxRaGRlKzBEcnZ1dnl2cVNxUXhjcnh6?=
 =?utf-8?B?LzB3bjlSMHVpYlFrZ05JTTl5RkJVUm5lcEp1cGtLMVJadldESmI2bEo0KzFB?=
 =?utf-8?B?cS9URm5IbkdWUzZhZlRYajFLNWlEc051WE1HT2xOa0dRTEJYZitGbm1zbFRQ?=
 =?utf-8?B?WHRPdjhVbUFVVDJxVTNCRDFXbnZRclYzR1E5T3VzTEdGWEgxQWV1T1I0Ritj?=
 =?utf-8?B?VWp1Zy9IUlhaR3BnbDJpckZDTll1d2ZrOXdKVmdqaDNoUTZxdk1sL2o1elNj?=
 =?utf-8?B?OFVBM1NoTzE4bmFzbnhudHFhYit6WGF3Sm1tRVpCWDlDM283YzI2YWs2NHZD?=
 =?utf-8?B?UUJzSi9UVEdza1BEUEhhdXRmbis5b2Ivclc5WndvVFVCYVA1RkZ6cVRINUo3?=
 =?utf-8?B?a0FrcEMwM0c3ZUI3c2F5TzdWV1kvdXNNSFVzbkw0TFV4L28vMzF0RUprKy8x?=
 =?utf-8?B?YVc3dlc2V2tHOVFFMVdZQkpSTlArU3h5NS9XMGlVSzFGRUFUK0ZFb3dEbktS?=
 =?utf-8?B?Y3hGNHdHTUtrV0tHN1Z2aHBaUjZwWndrRElQSS9xWklnZlcrM1k2THNDR0t6?=
 =?utf-8?B?NFA2Q1Y5U2V4OE5yeVdYOHpkbCtOK0dQOXlGVTROOUVaZ1Z6eEo2N2hlWmhI?=
 =?utf-8?B?bGF2ejF0c3AxaFNqK09oajVFbVNIbEhUMmJuNDRLb3dsNWhNdEZQVlNnejkw?=
 =?utf-8?B?NHNnc3dESWF2RUxJVnNYSndJcmlmTEk3eDdHYjBnSTFKK0t0K2V1K3ZHZmxL?=
 =?utf-8?B?c09jeGUwNE5NRnRFb1AzQy9RQkx3OFNXdU40aCs2eG03bkl4OTROR3p5VWdh?=
 =?utf-8?B?VXlSQlhQZFkwdDRqUFdFQ3AyTUFlZjB1T2xDY0JxaWJUeXBmcnlTL0FDNjZh?=
 =?utf-8?B?MGU0eUVJMHhveGZiSVRHcEdYSHZzVmtpMmRTZVBxamIwYW04blI4N3MyN08w?=
 =?utf-8?B?bEVXVllvcjUxTFEyVE9RQU9XdnVqbVRJRnFpZFFidzB2Q0Jjakszbi9GRVBT?=
 =?utf-8?B?ejh5VU00dXV6bWdjM2dpWkJpc1haOGpoaG13bGN6YmVBdFV1M1ZGVWI0Q3ho?=
 =?utf-8?B?WG5vaXRYSC9Ba2lVQkNFYWwxdEhHb05KWVg2M3pRcWh5dTB1WlZ0bW5Eb25r?=
 =?utf-8?B?bUdNbDRHWGJicDlJaVROV3N0cFU5MFFMcXc0eHUybkZSRXBNa21RT2Q2bko3?=
 =?utf-8?B?QzJ6SXRTYlBNT0poWnA0eWI1RUcvNXBKODVQRkE0SThmUWFyMGduY2tBY1dT?=
 =?utf-8?Q?m/yCMP1qLjJIhtJQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98CD87A15D6DAE479794C1E9643FCF3A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850d74d7-2e5d-4ff4-4b90-08da1ea21c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:38:03.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6CruZ+VHjGIkpw05IbkgEleUtBoACM2V9uU26iGSHl9Se6QjDKl3Po1E2i8YHFl3OKgmwiWmrBRrYL/qLnKXw==
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBTQ1NJIHRh
cmdldCBkcml2ZXJzIGlzIGEgY29uc3VtZXIgb2YgdGhlIGJsb2NrIGxheWVyIGFuZCBzaG91bA0K
PiBkIGdlbmVyYWxseSB3b3JrIG9uIHN0cnVjdCBibG9ja19kZXZpY2UuDQo+ICA+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXZpZXdlZC1ieTogTWFy
dGluIEsuIFBldGVyc2VuIDxtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbT4NCg0KRXhjZXB0IGZy
b20gc3BsaXQgd29yZCBpbiBsb2cgInNob3VsZCIsIGxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
