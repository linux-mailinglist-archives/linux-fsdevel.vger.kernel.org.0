Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF148DA41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 15:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbiAMO6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jan 2022 09:58:23 -0500
Received: from mail-mw2nam12on2101.outbound.protection.outlook.com ([40.107.244.101]:35231
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232357AbiAMO6W (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZpT64ZQUidQdPhKQo8H4H3PyYbwRncWrxrulM7cGb8E9lDjFtl408Gp+BgWyURM4pUqkwrS5f88iOHYIQ5Rvd4FqJWQNfg+7/7tDHzVdmZ8CSQbPvoE37UXyPQ+YH9OSkIzbIKkkNSoSAiu3Q8vfZ7d1d1WQA4m0qyqTUDnfEDtYq+DKE4iF5okkn6GVMy5ood3sw+0y4gTRfCffFEfTaBxsl4SCOKTNR90mKWTicb23T4UrfFlf36MpbLO53N/6/jjrT8TZ1XUTaEz+k4x4kVDeY6rCxsmDd72f+LIVPMGY9eWQbjQh1QN93hqjPQlVb9yi982dmIS8WrsLRYf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9/SrZVMOLJEeliSVM3Opkj7s1H1cdHkZXiXkEd0Uk=;
 b=ZjI4kuAssj+z6syFEK3A8bOh6YQR98lOp6krwF+T6I+DKu/qTKF2Si1/THuoHj9FAUF4ykNYYSVaX0QqS0YCC2Tp24iyNEkSKYDwXAs8MHU5qLAA1rzVTNOl6DSWdLwwxlpHDa0Z1ESRK00X6BKhzx7xy/kfDgeTy9pv3aWVasm3zux6IrdWLkoOqmJIxTGk/G0Wa/v9NdqFl9oIFpcj4yJ70ph/hUurcJDJsj2mfHIZHHPCT1rVZaw7DKjgGySY3eA9UmrRKUaE9hDrjUViPZUVWlM/0vdkZbZOgjRDR7dUUWDzJXsYsaWmGttOCSIUVCwsuMc3JPOH0uLognZmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9/SrZVMOLJEeliSVM3Opkj7s1H1cdHkZXiXkEd0Uk=;
 b=dO2ZugAnyc1jdP/Z9vn1+lsxHgXS3PreJqqtCrXXexrQAApQWliEnYHmMEfOmaxghRCaaSE1GhlHNjEYdKyOqcyloMYPEU/r/DF5ORCoQHJ6JApP/JjRmwJS5VemeJN8JsCbrz/syHcfKOqu50+N7PyyBBsxrEp0WBJCPbi2Tw4=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MWHPR13MB1791.namprd13.prod.outlook.com (2603:10b6:300:13b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.2; Thu, 13 Jan
 2022 14:58:19 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::ecb4:77ee:a645:9bae%4]) with mapi id 15.20.4909.002; Thu, 13 Jan 2022
 14:58:19 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "jra@samba.org" <jra@samba.org>,
        "amir73il@gmail.com" <amir73il@gmail.com>
CC:     Lance Shelton <Lance.Shelton@hammerspace.com>,
        Richard Sharpe <Richard.Sharpe@hammerspace.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "hch@infradead.org" <hch@infradead.org>,
        "almaz.alexandrovich@paragon-software.com" 
        <almaz.alexandrovich@paragon-software.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Anna.Schumaker@netapp.com" <Anna.Schumaker@netapp.com>,
        "slow@samba.org" <slow@samba.org>,
        "sfrench@samba.org" <sfrench@samba.org>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Topic: [bug report] NFS: Support statx_get and statx_set ioctls
Thread-Index: AQHYBr7uESfB0KyML0ueAstOBZLgUaxdgnIAgAGESgCAAKN2gIAAqlUAgAAsOYCAAI3BAA==
Date:   Thu, 13 Jan 2022 14:58:19 +0000
Message-ID: <3cf76cc19f12f3e9da2eae7fe12e2719c8e499f8.camel@hammerspace.com>
References: <20220111074309.GA12918@kili> <Yd1ETmx/HCigOrzl@infradead.org>
         <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
         <20220112174301.GB19154@magnolia>
         <CAOQ4uxh7wpxx2H6Vpm26OdigXbWCCLO1xbFapupvLCn8xOiL=w@mail.gmail.com>
         <Yd/HIYsCBPH5jPmS@jeremy-acer>
In-Reply-To: <Yd/HIYsCBPH5jPmS@jeremy-acer>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 020b799d-bc8c-4362-5d87-08d9d6a5230a
x-ms-traffictypediagnostic: MWHPR13MB1791:EE_
x-microsoft-antispam-prvs: <MWHPR13MB17913D470FD02FDBCD85CE11B8539@MWHPR13MB1791.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Q0fLRIW7Q3SUrGFm7UVvUKlzpd4T45M+XZsfnBAPP7E8PuMNe+LYuzCYMhuoEOK83/ohRUNLVWVY1+nABrlEfFoEPSmnUctvLt7jPbUPyhm3gJMTlxXsoRmQiNuVWqxFQ/6KMzu5mqFpZtO0KdtMgmS6V1+pNKTdfyOBJkORfq+ceIhTBGMJvLnbQIlfNuIhuARN23U0ZeaEMepZMbqA5jduypv5ziIgRsv+zPbKHJJvj7GEGtpW54b2wk8KSKqaM6KPcLImNfHAzOUgy91bll3FFXMX6kvdwnEF/z0X5cuBqO0JwMw8eOS1n86V4CFLaWuU8FcJo3kZzqrstYChsWLxvjb0zvoRC8fG6Yd3GyW2xDK/gS81qkGFET3iSRCK2OeddLKZvMXygLN8iA4O57RoCKWyuhJx2fETqFphl9eoe1YmoxvQL7YyZRdX12kEkxYeMrC/+q8+C5CQpmCVuHflx6JdVCrHzRX5m6Q1fFOIRBAtRUqDRjGtBkoz9tPR4OqIIagdhWkiTxqLID6jY5kvtrltpc+mikkT7guS3b7kB+HXpV7D+xitTEpDll4mPn61fMIJrsJhaod/amB9V4hQ1U6V9qliuZLshtdwMyT5SjbvjTMTJ6zxlJ7IxNi0tVh24m7FrCu1rVb77nrp/HNahGc2BV0nxK8RhKNOj1OyIrJXb2V3rYKdXcypuFWkppTq9fNcAqoNKtazjNang==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(366004)(39830400003)(396003)(136003)(376002)(6486002)(6506007)(54906003)(76116006)(6512007)(316002)(66946007)(38070700005)(5660300002)(71200400001)(2906002)(26005)(122000001)(110136005)(7416002)(83380400001)(186003)(36756003)(2616005)(4326008)(64756008)(8676002)(8936002)(86362001)(66446008)(66556008)(66476007)(38100700002)(508600001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHFUMTVSaTZTMEtKeFNPMTBvZ2lnczNZUUhldGVTSDhNMXdmUk9LVmFWWkRh?=
 =?utf-8?B?TWR3LzNwRzJibUsvYk9oYUI5UzV2bnZqTmtBN0V5alVQVWRNSlY0Y2ZFYjM3?=
 =?utf-8?B?ZGZPQVRhUmNNZTNoMGdFVVBvbTFKQU1EOXY0bHNoSVNGU2E3UDhyYmRnbjdR?=
 =?utf-8?B?K05HMXFYdTE4eXg5MjB2NFMrOG5lRWt2MGdlTEduTHlqQSs4K2NyVXFvNUdw?=
 =?utf-8?B?WWduU0RwVDlFNkV0VTFseStLTnpibkVJWUxTdlY0QlNRSHVrQUo4QUg4T1Q3?=
 =?utf-8?B?WVgwdUJ3bm1ZUmEza2N4dWJ0dmNZa3o3QWIzVkw4QTdsTHNyNERXTFh1cHFI?=
 =?utf-8?B?ZVJ4ZWVVME1JRnduYlI2Nmk2K1k5eWNISlp6bytMVmVuZW9za1VhMmZubGFO?=
 =?utf-8?B?MlBiYXJrOEtWVWRlN09EVlZoM0tqL3pOenRPRFB1MzZWRnpoK0ZDV3RDWlVI?=
 =?utf-8?B?K2xEcWVEbThoR0xiYmpDSTQveGdTKzdhVGJ3aHhmTFNkNmc3cjdvM2RER1Nx?=
 =?utf-8?B?T2pZR2I5MGFNMThqdkVwUW94Ukc1eDN2OTJwR2Y1aEI0RGlaY2RaWmZ5T2RE?=
 =?utf-8?B?K1FZL2pZMHc0ZVVSRHdnZmQrMFRBeFFSbS96YmFTYUZ0U3dFdGk5ODZEVnpt?=
 =?utf-8?B?Y1d5N2Q1K1VrVGFvdVJaQVpXNCtBcjlTaVl4cjlndkZGRmtDQUJoZVk3Qjdj?=
 =?utf-8?B?K0JXTEZRYmg4TVFsS3NoUzlaejZsQ08xbkQvVXJyMXRoZ1RDaEJIVkprT2lP?=
 =?utf-8?B?V3VOM0NMOVVWSHhhNW9ITTlVM09xREFMOUlJUk9TYmNsNTVFNXpmbTRDa2Qv?=
 =?utf-8?B?K0dkenRmbUlZUS9CZ2J1aG9zQWw1TVBPR0NpQ1JUWUloZWhFMmUraDA4bGlp?=
 =?utf-8?B?MkdacEp6TjV0Y1VlNXVNaVdZZ3JSeWhScEgrNE0xMmloeWlab1J5YnFYMk8y?=
 =?utf-8?B?UFh2K3hZVThwMERTY0JEdW0vcTV4dXcvV1hVZ2d3L0pkdXplRFYxNjBNcU13?=
 =?utf-8?B?empXVE5qeHVybkRHVlpwdmJFU241UHhsZG96VFNXdFBJckN5TjhBckVjcUtJ?=
 =?utf-8?B?YlFZMW82L1RIL1NiTVJ4NlZIMEo5OE1nWU01bUgvK1MyMVAxL3Nic3l5TWQz?=
 =?utf-8?B?QUpQa05nYkRuTlo1eWE5em04MG1CbEowems2VEkxZDhiYVdWVXo2azBKQnVy?=
 =?utf-8?B?cWdiZFhzZlA5NjFTSjdEb2M2TlRUdUFDUEp6M3ZlRWJmUU1Xc01wQS9SaElC?=
 =?utf-8?B?YTBhNGQ4SHN3ajlZcUxsdTdpZ1ZQcVc1amhielhhQ0RiM3NwL3ptQ1VJeHRM?=
 =?utf-8?B?WFZXTFNBd2JpdElqYnYwVjlXckp6MjZsM3l0WUM0Wm5BcmFCcUpaeDc2MSty?=
 =?utf-8?B?WVd0cjFneGhYTmxhcTVrVzRRcWN3RCs1UjZCZnBFb1ZnLzlMUXBhWHdFZkJ4?=
 =?utf-8?B?enFac3VhWEJTWFJYb3BrNVFMT3pCb3p6aGdIRjVZMml4ZXVjUDdkTXJrODU5?=
 =?utf-8?B?OG1ZcWoya1V5RkVkdjhCaWtSR3JaS09sSXRQbHhQeS9lMEMxbkxxZTVNUHBQ?=
 =?utf-8?B?dWMvY3RqZ1ZBbXFSV3MwZEdJUkpjaFNtamg4S3YycEk5WUNXTy9vNVJVemU1?=
 =?utf-8?B?TUYxVklyL1V0TFN0Q2pwdU1PT0hVcW5xNG5ya3FYTDA1a1cyQy9yK1czUkJU?=
 =?utf-8?B?YWhTZ3hFakhuRE1BUTVXZTRoRGMxa1pNMnk0QjBEajRDTUxPZDBDT0krVHlE?=
 =?utf-8?B?eDB2c0I1Y0cvaGpsUFE0Y1doZWg3Mlo0TlNVVldINzErL3JuZmJNMmNZQVZI?=
 =?utf-8?B?ejBFWHU1emJ6T3hZcTJjZm01U0JaS1BvVjZCZ25ERFRydzdrZUpvTXRZbHBL?=
 =?utf-8?B?bXltcTE5Y3ZjbVU2TGFaZE1NTmc0ZmZGRnRWVmdLbWNac08vSUQ0bGpBMUk4?=
 =?utf-8?B?NzA3UjN2TWx0eFNqOGFaZ3h3b3hWb3Nqd01RU2Q3K2Y0OU9jbkNtWjM3Zmph?=
 =?utf-8?B?aTdDeEJ6OUlwcUYxNDdHTWErM2JSSE12L3pqRXVRNERlaXo5bmpEUHdrRHdu?=
 =?utf-8?B?SDg3QWo5WSs0ZmhCZlAvM21GMzVTOEsxdTRxaHVLR0pxNFJna1RBQnlIcGZ4?=
 =?utf-8?B?ZE1KQmtsY0JGVEpRWW5Pa0o0QU1VTThGb0FBK1pyM0lKYWpPdGdrcjhSdjln?=
 =?utf-8?Q?yRigJf9UQyEsKSWrMlj9ceA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBBA39D45729B0418ACEF04B58EA3938@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b799d-bc8c-4362-5d87-08d9d6a5230a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2022 14:58:19.3747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kg+KWlFernMzkE/LyMuE9MXDReGREJhwHLB6w6Npml1n3HjWfLhT7gvh2ecZOglbw+4vp9tm42AEhA5WRvIijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1791
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gV2VkLCAyMDIyLTAxLTEyIGF0IDIyOjMwIC0wODAwLCBKZXJlbXkgQWxsaXNvbiB3cm90ZToN
Cj4gT24gVGh1LCBKYW4gMTMsIDIwMjIgYXQgMDU6NTI6NDBBTSArMDIwMCwgQW1pciBHb2xkc3Rl
aW4gd3JvdGU6DQo+ID4gDQo+ID4gVG8gYWRkIG9uZSBtb3JlIHRlcm1pbm9sb2d5IHRvIHRoZSBt
aXggLSB3aGVuIFNhbWJhIG5lZWRlZCB0byBjb3BlDQo+ID4gd2l0aCB0aGVzZSB0d28gdGVybWlu
b2xvZ2llcyB0aGV5IGNhbWUgdXAgd2l0aCBpdGltZSBmb3INCj4gPiAiaW5zdGFudGlhdGlvbiB0
aW1lIg0KPiA+IChvbmUgbWF5IGFsc28gY29uc2lkZXIgaXQgImltbXV0YWJsZSB0aW1lIikuDQo+
IA0KPiBObywgdGhhdCdzIG5vdCB3aGF0IGl0aW1lIGlzLiBJdCdzIHVzZWQgYXMgdGhlIGJhc2lz
DQo+IGZvciB0aGUgZmlsZWlkIHJldHVybiBhcyBNYWNPU1ggY2xpZW50cyBpbnNpc3Qgb24gbm8t
cmV1c2UNCj4gb2YgaW5vZGUgbnVtYmVycyB3aGVuIGEgZmlsZSBpcyBkZWxldGVkIHRoZW4gcmUt
Y3JlYXRlZCwNCj4gYW5kIGV4dDQgd2lsbCByZS11c2UgdGhlIHNhbWUgaW5vZGUuDQoNClNvIGJh
c2ljYWxseSBpdCBzZXJ2ZXMgbW9yZSBvciBsZXNzIHRoZSBzYW1lIHB1cnBvc2UgYXMgdGhlIGdl
bmVyYXRpb24NCmNvdW50ZXIgdGhhdCBtb3N0IExpbnV4IGZpbGVzeXN0ZW1zIHVzZSBpbiB0aGUg
ZmlsZWhhbmRsZSB0byBwcm92aWRlDQpzaW1pbGFyIG9ubHktb25jZSBzZW1hbnRpY3M/DQoNCj4g
DQo+IFNhbWJhIHVzZXMgYnRpbWUgZm9yICJiaXJ0aCB0aW1lIiwgYW5kIHdpbGwgdXNlIHN0YXR4
DQo+IHRvIGdldCBpdCBmcm9tIHRoZSBmaWxlc3lzdGVtIGJ1dCB0aGVuIHN0b3JlIGl0IGluDQo+
IHRoZSBkb3MuYXR0cmlidXRlIEVBIHNvIGl0IGNhbiBiZSBtb2RpZmllZCBpZiB0aGUNCj4gY2xp
ZW50IHNldHMgaXQuDQoNClJpZ2h0LiBUaGF0IGFwcGVhcnMgdG8gYmUgYSBkaWZmZXJlbmNlIGJl
dHdlZW4gV2luZG93cyBhbmQgTGludXguIEluDQptb3N0IExpbnV4IGZpbGVzeXN0ZW1zLCB0aGUg
YnRpbWUgaXMgc2V0IGJ5IHRoZSBmaWxlc3lzdGVtIGF0IGZpbGUNCmNyZWF0aW9uIHRpbWUsIGhv
d2V2ZXIgV2luZG93cyBhbGxvd3MgaXQgdG8gYmUgc2V0IGJ5IHRoZSBhcHBsaWNhdGlvbiwNCnBy
ZXN1bWFibHkgZm9yIHRoZSBwdXJwb3NlIG9mIGJhY2t1cC9yZXN0b3JlPw0KDQpORlN2NCBzdXBw
b3J0cyBib3RoIG1vZGVzIGZvciB0aGUgYnRpbWUuDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpM
aW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RA
aGFtbWVyc3BhY2UuY29tDQoNCg0K
