Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77873502493
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349589AbiDOFq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239201AbiDOFqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:46:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF05A120A1;
        Thu, 14 Apr 2022 22:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7V/a/shH/50ILjNRowsunIUKIrGOFQk4PtG3aqgLufUl3eo9FFXwRzTWPP0RHT9QEPFzVuAfsmM6PCRYN5uE0isK63LlyeHjOY0AhybDM7EYaEv313h0B8JQcoGkJ+P8ou4SSZ68myiiO2W/zAJlZIMyEJugOt6pa+EHrzzsdEdgeXfyQ2hrnQuoV+qMhRt7jvZWTcwHRViaer362s1SoSvXNtAczEOt7Su+OGs3u5WCNJHPDlWJpBlIIJWUsCudfYCIgJ86AtMcbg8PUDiz5JxKqcz1mVsoX3/ySLAnqbhQxP+XN7M+IT4v0LILgblyOpkIBzIt9jwEGjNnTbO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBkQBjRSn9XGMGFyMCBwAEJr7XdtAp3lo0AoSBJHgvo=;
 b=La4HVrWc+fl6CdBxWbYFJDk0OThR0snei0TmD5q5HBftn4TOFU0Sv30q9DPkrYRZP93DneBDXzStfiizo/VaGF5Dq/BIxFJF9Y3j/RLEXqPmQWS2xJmz76k+Je7dYfNX3BwNEwY3a5ns6xpYYd0JFRi/VQDGiSMFpWPLxr4FSqEsaLnl5xTh6/hI899c4xmOYJXwKh9mMzz4SGPWIaxNU9frp3hdE+4hCh/pRxbUAhElptvjZKAxwao31fVwnoZaSyHoiat4R6Zs54X3v5V2I4PIsfoCi8ET5ZJEeGoV2kMrdTpuWI2kHG6nXbcpIXbRvnlchf0h5R3iS4OKqP7Hsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBkQBjRSn9XGMGFyMCBwAEJr7XdtAp3lo0AoSBJHgvo=;
 b=TD25AIYRb8iwCA9fahL99Olp9+/Hgztmyc7Cke/aNxVFMkYqgPmEKIa0h9K26Lizf8FQtbpJ6ZrI43SRYXUa/IEilbPb/yWrsMWKkvVMTb5eGrmKtloM/HeeGoLG/okNV7PxpECiAiiYRo9oQlbfjDmkiuiTM6mgxRU4PVVmr6RXqlPoiVfxAOLCq44bzbjr04GIsU+i+wkYwmXqFd8z069t2I0ex/3qnxQewZ5y7zNzeShvVEPpwZo9kcCoprtQzOE532RcrC4q5AQc5fs0lnzBrqkQUccvapN4PmMnK+mDecb7Qq3G0+gQfrs7UHiuHRUHtlqVG0C/W5DVaZuTUQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY4PR12MB1815.namprd12.prod.outlook.com (2603:10b6:903:122::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:43:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:43:53 +0000
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
Subject: Re: [PATCH 16/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
Thread-Topic: [PATCH 16/27] block: use bdev_alignment_offset in
 part_alignment_offset_show
Thread-Index: AQHYUITgGyb6ZxOVoECvHtCH20IFIqzwdokA
Date:   Fri, 15 Apr 2022 05:43:53 +0000
Message-ID: <d4d70cec-aaef-27bd-4d29-7382a740f192@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-17-hch@lst.de>
In-Reply-To: <20220415045258.199825-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadb5741-c217-4402-81c7-08da1ea2ece5
x-ms-traffictypediagnostic: CY4PR12MB1815:EE_
x-microsoft-antispam-prvs: <CY4PR12MB181587392FBC362EB9BA46BDA3EE9@CY4PR12MB1815.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zPE7EFfZCRyhrUuJ8xZg9ucWLWFwJmvS3SCCy3Gaw/2yxq3SLG9KlcHIP+uThF51l80EN6TZSRiTdQYGcRu0jCdhuALoVMKwS8W0pRofsGVFS2xSGj41t91O6b3SGy+xBhR0pwJvhvExxhfgFMeJv0kf4NLE3kzDlCKkQiUSHe9UUFRHRiu71HiTj9048fpgx+LMHahpSNX93/a0NzTVZSI34Jnz76e3Zbz5izJ0Btbe01tt33GWjvGm9MTZSXMrbEGKj+kS7mHGob6GbOEfPMtU9msKPzYGpb02V1m4UiygUdR2JLzyHKmSZ+Qk2YRKEOWnH51jj8kUevfIc6zuDr6NdNQR2dBO4u/kxc3pW86qOc/ly7+l5ASnifdFRNBlGObIMk454XaCAJCG8Lb/FzQnENxr3ByAWVaZjA2UUOU54L09Sro2bC+uf2XcSeLQgrUF7ONhLnwI5Fijea+cZY8H4fztMTlN3TZ/uEd9ApUgyy5udU1p9XTYcxj++ua7g47w3aeX7Y5VzkSGbmquc4wRnCJBKrD/sHPCbPVgvd6yujzP41M6MslnU2d/EfCPWdTo3HBEEduFrUZjh+X7HW8TYgvVDdXfTH06HgyG4GnRRnI9J8fUjx0QN7t1TNLvC52WnAi765Nyg1VPPBrl3i21BYZ901pgAkXDGXI2t1yUM7IV7ny9/ixyZZKXV53DwJDjsiEuGwzKQpZYABsQLuZZnLaLSXEfn2lkfqCxswy/6XXTaLwC7+nDFr/m7bYPN/eTEB9T3cxQN1Vc4nNqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(8936002)(2906002)(91956017)(7406005)(5660300002)(4326008)(66556008)(86362001)(31686004)(508600001)(4744005)(38070700005)(6512007)(2616005)(186003)(53546011)(6506007)(36756003)(66946007)(66476007)(54906003)(110136005)(71200400001)(76116006)(6486002)(38100700002)(64756008)(66446008)(122000001)(8676002)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkhLTC9Hb1B6S3FOdlFHNnJDNWdpYy85WDdZZWFmTW9PalFZSXZBbGxNeDZR?=
 =?utf-8?B?OUI4WFg1M2twZmZuS0d5b3VmM0RJZm9KWGQ5V2VPUXlxNlFKa3VjZVVsUHRE?=
 =?utf-8?B?aE5KOUFKRXBHb00xSjAyUVhnUnJ4VzBlNlR2OTVqZTZCS2JlYkJaNXFmZk5W?=
 =?utf-8?B?QWtTS1E4ZWM0NkplMkNnSGJuYXEzYnZDRCt4UXpnN3QvYllydGZZS3JNUFJD?=
 =?utf-8?B?dzlya2l1cFROcHB0WG50YnRmOTUxZmtFcWJYYkFxR3IrTFJqTHFTbXdjd2pS?=
 =?utf-8?B?UHRhcFA5dTdGdTV4dGx3aGtwemlDbkxCYjJPY2Myc2tpYS9SdzdwWlBIc2pR?=
 =?utf-8?B?UDMxSUpKWE9qYzRmaTdKUXh3MjRyOWhXM2ZGNHdMajR0alRQYzc0eHNUekdm?=
 =?utf-8?B?Z1ZnRDVNUldxcm1xREFydEdSWnJJSitIZnpMMW9odGJPOEsrUFZKYUhGOTVT?=
 =?utf-8?B?WndnNG9hb0NPb1NTdjJwZDJNUGl2NUpSWUhoQjMxRDN2dzhOd0s1ckdvaDRP?=
 =?utf-8?B?OFZVQVRSUS8wVndOTytLcE8vYnZnQ244bGR1MHhvWGR5MFBoa0NVcm1DTVFH?=
 =?utf-8?B?MFBFWUhEeERFZmlINEpqV3ZPZ055cUVMcytyYWk4MEc4ZXpZUGtaa0l4YmFq?=
 =?utf-8?B?cVMycGhwREZhZXUyNkNqblZ1YnNMY0RBczd4djZJSlFCWmlNZGMreTVSL1l2?=
 =?utf-8?B?S3hDWElZaXZWYjJQQW1jWk5BTFN0VFhVQTRla1IrNWdKeTgwdTBIb3ZVOG9M?=
 =?utf-8?B?VFE2Tkp3VHV5S1ZPcXIwVUdwSDJ2bUhMMG9yTWk2VlEwQUpmVWVNNnJ3Rzd5?=
 =?utf-8?B?MjlzQlA4TVd3Y1ByVWZyKzZWQmQzdHp1V3kxNE5Zdm9EM0V4TjA0UVNoWmp2?=
 =?utf-8?B?czAvdUpiMERNeTU5UldlTlo5NEpHczJmcno5bGxaRXlzTklhV1lpVXU1T3JL?=
 =?utf-8?B?ZG90RzJKcHU2RCtwNDIxWWVqSjNCaFpNaXIvaHNZak9QOEVZVE5UT1kvTEpl?=
 =?utf-8?B?QUxhSlBNb3JUL3NWTHcwNG5OdU5haWdLd1BndU5MZTVkTUloRDU5aHNaeVZL?=
 =?utf-8?B?TEUzSkpaUEVTcThhdnI0dDVaKzhSckt2NkhJK25xSUZLbXhLVzdEcTJuQ1FB?=
 =?utf-8?B?ZWs3TFE5SXV0RXBWT3dXL2RLOGVVVFhEcklFbmRjU0NheHVadmRYSjc2VVRw?=
 =?utf-8?B?bHA5OVh6cmpEbjE5VnlncEE4UUgwemw0N2wrRSs0REp6L3o0bjNQRFRHYUlr?=
 =?utf-8?B?WGhqLzJJdlhoMUVjcTVVUm1WR3UvRDdra3BhZzQxK1VWTTd6d0ZiWDRhZjUr?=
 =?utf-8?B?NitvS2dtZExkZzVvL0prS0tPQkJtdnFjNlZ2cW85SzAwZS84dUhhR3NzT0VT?=
 =?utf-8?B?WWErM2hId0NrTkZ4QS84RVhBK2tnd0tmRXVsYjZrR3VwNWkzNGVmdUpFYTdl?=
 =?utf-8?B?NlpsVzBTbFlVYy9xMzBYUFB1a3JPRFl2QVJqRzFJWFl6ZjVSZ2VyQnZMYjlv?=
 =?utf-8?B?czhiZ3lZTmpzTXEvOFAwNldYb0FqYW9pWGVKZWkwckZOV2F4cFBCNnorcWxo?=
 =?utf-8?B?T3hxaC8xYW42SnFjbmJVZ3FaYXYrcjZiLy8vU0tLcXdTMzAwbUFhbGViMlhp?=
 =?utf-8?B?QjFaSVNhdXVvaUFvMWtDMnlJTG9HeHNkMXpXaStQOUpQY1RUbHpJN2UwM0lT?=
 =?utf-8?B?ZmcwcndhQS80SFZKY0t4SjVqWUpyNFJqU3BtMUVYM3ZjN1l4Tk5wWnZzYkxR?=
 =?utf-8?B?YlgxcTV1bWRMUEdMWWQ5MytFUHBsMXZSUXRwaENTaVEwL2pNOXNvYjJJOEZS?=
 =?utf-8?B?eHQ2dm1ySi8zZjd1eEtXWTFZOFFwdlVobitnUS9yaG9nNHR6eDA1Tm0xWkxt?=
 =?utf-8?B?SWt4Um9NMmc0WkFsTGFIbW5uWUY4Wnp4OGFCZ2tpMnQ2VmU3QVB0MVQrQ0l6?=
 =?utf-8?B?NUdmeVdPQndjQVRxWVlVUSttOE1CM2pyVDBoMGdObE00aDBxQ3hZNnMvRDgz?=
 =?utf-8?B?MGpCT3hNL1FPRkRJZEJOdlZZTXN3b0hSOC94VGYwa2lENDJLNzhsbkdycWtT?=
 =?utf-8?B?OFdFeldWWEpFN2s2Nk1wWTE1ZTZROXVPbWl2R0l2UEYrWUN2WkpaRG9Zbzlt?=
 =?utf-8?B?S3BzM3NmTjdreEFPMlIxQUh2dURrK3drbDZ6UzZUSUg2amNiZ2tLVGkya0d1?=
 =?utf-8?B?TDErRm1PTHNrbnRuQWc2M1BEU3hrSDNVQ0pyYzAyVFJZLy82ZHlrY09FOUR0?=
 =?utf-8?B?M2hTb2ZOUnh5UWN3c3cxK1o1dGpBMFFpdEpLZzJubGVDTGhsMEhPOXRTZEE4?=
 =?utf-8?B?ZDR5bkFrZWlMbEUwRHd1RFdybXdURFg5bGw1NFNvRzhEV29zTFZIL09qZnJY?=
 =?utf-8?Q?AYvHXapXcoGFw6Gj5LPtzLlzXjgd4w5ny2Ge1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <082F7C538FC35349BB8BF71526006F64@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadb5741-c217-4402-81c7-08da1ea2ece5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:43:53.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z89R72UQaC+/+ZifCAazwywTUZEAu78qSqfzKG51E0QeCoJkksyXq4ipp5lT82IG6zIQc23xZHHhe3Sr5hGvgA==
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

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFJlcGxhY2UgdGhl
IG9wZW4gY29kZWQgb2Zmc2V0IGNhbGN1bGF0aW9uIHdpdGggdGhlIHByb3BlciBoZWxwZXIuDQo+
IFRoaXMgaXMgYW4gQUJJIGNoYW5nZSBpbiB0aGF0IHRoZSAtMSBmb3IgYSBtaXNhbGlnbmVkIHBh
cnRpdGlvbiBpcw0KPiBwcm9wZXJseSBwcm9wYWdhdGVkLCB3aGljaCBjYW4gYmUgY29uc2lkZXJl
ZCBhIGJ1ZyBmaXggYW5kIG1hdGNoZXMNCj4gd2hhdCBpcyBkb25lIG9uIHRoZSB3aG9sZSBkZXZp
Y2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNs
ZS5jb20+DQo+IC0tLQ0KDQpOZWF0IQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
