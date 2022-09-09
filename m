Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CC85B2B64
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 03:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIIBKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 21:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIIBKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:10:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2130.outbound.protection.outlook.com [40.107.93.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A379876B;
        Thu,  8 Sep 2022 18:10:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYXeAW4TPThRhkG0CgrBo/RTEH1kMd2BZ5yUdyNlx+/4c69f0mZtuiaIZ5yjWzBjAGxawFWojJX3c/oSr2CJ8K2EQ/El7PrNlO5JRLigZ0PrXLtH6TV3elRgvzL7B4hWCo671rWBi8Jdg/KQxMdDAqhLv48Wyyc1HemcI8upgiTsiY0GCSqKfar/xX5GKGSaRC2ivTv9fSCfSG/u2bpYtkHePKMCLqZdPwjxHS8fmA6BzO+2HVgfZesqxwaraGQEeOBdyGpikGZqvDTTeNek6SHsLmehAwGCwFMuMR6Jx+Rm2vQYN5WdEkG82RQFM4WJ214W3IadLGXhhxDLeUxKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcKR1Vj89ufioOAOMAHtLxTgIWHqlI+sgicqoMp1/vc=;
 b=Ja5nAH+39Aeoh/4OF2XxgwtOFvjKtWivKbBhQxwBtkSAgKcPDumEmxxhrmdyVB3C1IFpzZokqC7srcEmDsXxdUuFnY4VbXAUs6a+JbpvWSzQTXWa1ezT+1zZOCVqFnMvRI0XM+B8k/UtbuU9Ba3vcmFd82fD2EsLfWZ4jj9Ps2YlkwW3/PlnhMq2R8Z+/my2IUjbhBSh47VUhzsuAKGLho8ovb6UJKb21k9H0K8HGGdzI5CL+oGk2OuPGrYXR9gXuW4/V/AEQUpVQpkOorYI3flN4uOlTx+LcSBR6UjJ7X0zL3Q/uXz2Zl5M2TnNp8gBp4Diytng4ecC/5MdqieygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcKR1Vj89ufioOAOMAHtLxTgIWHqlI+sgicqoMp1/vc=;
 b=XUwwSiS9SXOyVzL8ah9MSfMHbD2qrK4ZvqYDVlJznFf1b99mxtFfklr/Mlb1MVhphIJFl3MA+qcNHnelK21fpYjhGvJhtVvr8rItYt1OWW20IkczPZ8UTFigoGD13efR1UWMzCUAPoBiXkmrFGpuLkDk8+SzuVajDnFL6K5k9Ss=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by DM6PR13MB3627.namprd13.prod.outlook.com (2603:10b6:5:243::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 01:10:50 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::f1c7:62d0:a63d:f5ca%3]) with mapi id 15.20.5612.012; Fri, 9 Sep 2022
 01:10:50 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "neilb@suse.de" <neilb@suse.de>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "xiubli@redhat.com" <xiubli@redhat.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "bfields@fieldses.org" <bfields@fieldses.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "lczerner@redhat.com" <lczerner@redhat.com>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Topic: [man-pages RFC PATCH v4] statx, inode: document the new
 STATX_INO_VERSION field
Thread-Index: AQHYwqs/evAHvn9kzUKFB4lWpvCB0q3T1xmAgAATgACAAAFbgIAABbEAgAAK/YCAALZNAIAAgw4AgAByGoCAAAZagIAAeIiAgAARsICAAA6CgIAABKSAgAAA1wA=
Date:   Fri, 9 Sep 2022 01:10:50 +0000
Message-ID: <29a6c2e78284e7947ddedf71e5cb9436c9330910.camel@hammerspace.com>
References: <20220907111606.18831-1-jlayton@kernel.org> ,
 <166255065346.30452.6121947305075322036@noble.neil.brown.name> ,
 <79aaf122743a295ddab9525d9847ac767a3942aa.camel@kernel.org>    ,
 <20220907125211.GB17729@fieldses.org>  ,
 <771650a814ab1ff4dc5473d679936b747d9b6cf5.camel@kernel.org>    ,
 <20220907135153.qvgibskeuz427abw@quack3>       ,
 <166259786233.30452.5417306132987966849@noble.neil.brown.name> ,
 <20220908083326.3xsanzk7hy3ff4qs@quack3>, <YxoIjV50xXKiLdL9@mit.edu>   ,
 <02928a8c5718590bea5739b13d6b6ebe66cac577.camel@kernel.org>    ,
 <166267775728.30452.17640919701924887771@noble.neil.brown.name>        ,
 <91e31d20d66d6f47fe12c80c34b1cffdfc202b6a.camel@hammerspace.com>       ,
 <166268467103.30452.1687952324107257676@noble.neil.brown.name>
         <166268566751.30452.13562507405746100242@noble.neil.brown.name>
In-Reply-To: <166268566751.30452.13562507405746100242@noble.neil.brown.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|DM6PR13MB3627:EE_
x-ms-office365-filtering-correlation-id: ca517749-9242-4ed4-3842-08da920022cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kYLi4PDO1dT/QgOrq6vfdMz03vJewQuaWE55wYVWhUlYrOILx3TydyLGMMV3mJr7JzgA8lgx2nqEWuthMesd1Od5IWvF21Lb7qQvYdehDgtFq942ui6E+GYxg1Nt7YYr3u0hhDDY4DZ9bR8EM0G+nFVLVZkpSDpJWDGWNJFst3q/okuBjlSW+AhqVIUJ+qebzGPmNN/4dN4A5nkXtsxf3VYSXJNIde7cNvb7bX+wVRA9lucrUQjNvFRHAkkFUF9TXwsBGV9QD6GPsJNFUhk/BM4NUl9v9oInMPsOs0W0/NEwanMZcIxtOpaiFa4QnIOFCBncEv5c4VcwHMULdRuXkZCbV2iNEsBLOW6lp3AvGnbrL4/7bHmpT0JXw2xTO0WnBB1Si0YY3eTSSm8Ad3byhh3F7zu0GXkzCwK+I4hcZ+B/8X3icSkbF9Wu2dh7g3nsnnXIi9DAIFQRgcAXkB22wvPPxwq0LBxSzpPuZKkFPzicQF+hi1IZ08wCwfx6cWXN6pKTGdiTaMXLBjJXYvoYGreNllSzRSmd3j+Y/XLU01kEkFOmi/X2Uv69ILyXVPyNfkDtrjpbnzdVNLxBTzPFRgOlU2mgAU9d1MEtfKVzIMRqKBla8peYj/WwfzZqNaRis1Av5Ks1aQVMyNAkFy7eMWMSFD9zVh44Qmf6c7YDLjH3v8Kgzp2O64S0e8Qm1cDOWYRp8YAva97+/T2/l9GLSg1pJ5pf7MyujszosZ7r94aUUJSm4Rr4R3RIRY0bBtcZHlELFnZ626b5X1M0IF9cC9/rqegFv1/Gf0OPfwQGsg6+uhIPDb8zx6h2LQXjQVwf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(136003)(376002)(396003)(346002)(366004)(186003)(38100700002)(122000001)(2616005)(83380400001)(8936002)(64756008)(5660300002)(8676002)(6506007)(478600001)(66476007)(66556008)(76116006)(66446008)(7416002)(41300700001)(71200400001)(6512007)(26005)(6486002)(2906002)(316002)(66946007)(36756003)(4326008)(38070700005)(6916009)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?angyeDZGS2ZKN0k5MTVwK0ZNK2FnQnBIWXFQWFB3dHc5dXJ1SEo0dXZWOXNV?=
 =?utf-8?B?V2NUV3lyekFMWWZRVFNBMEp0VGRGWTY4YXNpeVhzNXJEM28yN09MQnczbzUw?=
 =?utf-8?B?VEtYaWpDdmFnNWJlMlI3bkdTNmpwZjFoTUtxREVyd29EUlRKZlJ2SkI4Q1JW?=
 =?utf-8?B?MXNYM3ZTWVQxVWdCUEc2UC9rRldlWlBzU2xEVUFBOFZXdnZZVjBlK2o2bUU4?=
 =?utf-8?B?dXQ2RmtpMVR2NFUvaUNOZkJkRSs5eFViNXk1S2RuNTRFZ2FjU2IyY2RSM0Q5?=
 =?utf-8?B?QXR2N2syYkU4L29ZQXBVVkI0bTVhYnJmaG05WStlZVNZNGpwdEhUTzJ6YzBs?=
 =?utf-8?B?WlVDNkV4MzQveEdQN1hiT2FUWGVheTVTVjVOd1YwQ0lPVkw4cXFzREY5RFRt?=
 =?utf-8?B?WGc2Q3Z2QUplbCsxWnJMM0o4RGxRSnI4UlZES3A2ZEhWcGFwSmRRQjVBNXRP?=
 =?utf-8?B?NUJhcTZRWmNWMWhyZVlTNDJ2RjFWWC9qN3l1YTVHV3VodzgvSWlpWWFISGho?=
 =?utf-8?B?WkZWU0s2b3BoSXhhNHcrTVlNUHJSdnB1Z05uOGhsb0g1OHFOa0pJWGNBUk42?=
 =?utf-8?B?WEcyQ1hDUlZUQ21LR1Y1ZXgrMzN5ekJkeVg5ZFB3UTRINlBMMmYrL0VPZGlx?=
 =?utf-8?B?WjY2cFNjcy9naitxb2srMytFZ25WWFpkelA3YnR3MTFjTHNKbysvc1Qvb0Zx?=
 =?utf-8?B?ek1ENmhsMXE3SGJtazl1N3RHckRQWElselhPVWNxY3IyTXNEa3lpZ2dFZC95?=
 =?utf-8?B?VkNUVytNVGNXSDBCdzdjSzRtUk1hc2VsZUV0S3I2c3JqZWY0K0U4Q2QvTFVK?=
 =?utf-8?B?R28vUTIraHAzVjFNN0pQbzNLekZZd3pwcDdlb241S3F3RUEvVXB0MERtOVNF?=
 =?utf-8?B?M3h2dVI5M0FweFNMZnFZY2sxR1ErZDFYaWcreWoxUkpnQThEbVl6eFZhTEIz?=
 =?utf-8?B?MTNMUFVyOTN2OUlTMWJPZ3BaNXE1amdEQmpkclZpdlFGbW1ObUwySlJSS1pq?=
 =?utf-8?B?NEJZeDRTbVlwa0ttbkNWUnI0T1U5YXZGY2c1aE82NkhHaUZmMElZaXJ3cTMr?=
 =?utf-8?B?U1I4NXNUZ3Z1djQ2R3llU1VkUkVEWFF5aDVDTHlZY0JxVnNmMXcvRkU3Ym1t?=
 =?utf-8?B?OUJUdDhLREYwQVc0eVhvR1g1UDRJNXFXeDA5aW54V2xPK3FCZ1RuVXJhWDdt?=
 =?utf-8?B?azRZYnYvN2lJRUJ4K1RTb2pWb3QwODMyY05ibmcwRUxYbHdUNy9CelpzSlF0?=
 =?utf-8?B?cnZvSzkwb1pPa2JQQmEwNzFIaXpNeW0vMWpxZWxhT0djSjBXaWlRZENWNzJR?=
 =?utf-8?B?NVlTc21ZbFNURzkrYS9PREVqZitRZGhRYll1RExiSVNIOHVyTmxLb0N0bnB2?=
 =?utf-8?B?QTFqYnA4MHZKdjJHQzZnTFMyMnJBRk15bGpmdFc2eENpNGthbVVsdm54cG1B?=
 =?utf-8?B?S1BWay9SNFM0UWd1QXU2ZGp1VlpHZkdNYmxNcnVhbkRPeDVRV21oVXdEaG5B?=
 =?utf-8?B?b1p4L28wZTZ2N3hUeGpMM0ZGbmdJSnJLUWtUS0NwNEJtV1pTNFVMTExFbm93?=
 =?utf-8?B?L1NSK2hiTUJlajg1Um1SbFpvcGVrVzIvQlR4ZGxxRjhqaS9LMVVrdjRWVVVq?=
 =?utf-8?B?TG5MSWtvUWcxZ3NQWmE4RGMzYjdpVGhkWTltY2VLYldwVGVJK0VoamRrelpr?=
 =?utf-8?B?VXBPYnV3REZLQ1I4a3ZVdEJldVlxWjNLb2FtSVMzTG9QRUNiL0FyTlMzTEJM?=
 =?utf-8?B?QW9qRFlXcGsrTzQxeFYxdkhOSmpvOEVLejFYY0xLSzltRzZzYk1RUFROZFpp?=
 =?utf-8?B?ZEtQbWpWT21EeHJnUUVsMXBsRWthOHRrZlVGNStiVDllUDBFbEwwRllyLzJp?=
 =?utf-8?B?cnR3TFJBVDd4T2dsMDRnRGFQNm5ueUdvVjhLY1AvZVIrMkw5Nkw2OTA0aUJp?=
 =?utf-8?B?SXhwQVZZSlVmbElubnBobE5WRFg5RTFuRmUwNVFmMXN2VDVteTlSOElGT0NP?=
 =?utf-8?B?cE9Vb3Ziak9BSXRRYmZSbTVLUGFUdjJuY2NxZ3hBT2w3T2NjWmhMUFlOK1Ry?=
 =?utf-8?B?ajJnSGswUGMzRXhIYlFCSXlHd0ZZYldWcHkyZGVkWGhYZFNuejV6QS96elho?=
 =?utf-8?B?THhvcGlWY0ZTd2ZscXMveU1nQ3lVeThUYkFHVDIvOWhwS1ZLWkUvUmhSZTlJ?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F57F8B082E44041A92D321B4EB604AE@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gRnJpLCAyMDIyLTA5LTA5IGF0IDExOjA3ICsxMDAwLCBOZWlsQnJvd24gd3JvdGU6Cj4gT24g
RnJpLCAwOSBTZXAgMjAyMiwgTmVpbEJyb3duIHdyb3RlOgo+ID4gT24gRnJpLCAwOSBTZXAgMjAy
MiwgVHJvbmQgTXlrbGVidXN0IHdyb3RlOgo+ID4gCj4gPiA+IAo+ID4gPiBJT1c6IHRoZSBtaW5p
bWFsIGNvbmRpdGlvbiBuZWVkcyB0byBiZSB0aGF0IGZvciBhbGwgY2FzZXMgYmVsb3csCj4gPiA+
IHRoZQo+ID4gPiBhcHBsaWNhdGlvbiByZWFkcyAnc3RhdGUgQicgYXMgaGF2aW5nIG9jY3VycmVk
IGlmIGFueSBkYXRhIHdhcwo+ID4gPiBjb21taXR0ZWQgdG8gZGlzayBiZWZvcmUgdGhlIGNyYXNo
Lgo+ID4gPiAKPiA+ID4gQXBwbGljYXRpb27CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgRmlsZXN5c3RlbQo+ID4gPiA9PT09PT09PT09PcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9
PT09PT09PT0KPiA+ID4gcmVhZCBjaGFuZ2UgYXR0ciA8LSAnc3RhdGUgQScKPiA+ID4gcmVhZCBk
YXRhIDwtICdzdGF0ZSBBJwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHdyaXRlIGRhdGEg
LT4gJ3N0YXRlIEInCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPGNyYXNoPis8cmVib290
Pgo+ID4gPiByZWFkIGNoYW5nZSBhdHRyIDwtICdzdGF0ZSBCJwo+ID4gCj4gPiBUaGUgaW1wb3J0
YW50IHRoaW5nIGhlcmUgaXMgdG8gbm90IHNlZSAnc3RhdGUgQScuwqAgU2VlaW5nICdzdGF0ZSBD
Jwo+ID4gc2hvdWxkIGJlIGFjY2VwdGFibGUuwqAgV29yc3QgY2FzZSB3ZSBjb3VsZCBtZXJnZSBp
biB3YWxsLWNsb2NrIHRpbWUKPiA+IG9mCj4gPiBzeXN0ZW0gYm9vdCwgYnV0IHRoZSBmaWxlc3lz
dGVtIHNob3VsZCBiZSBhYmxlIHRvIGJlIG1vcmUgaGVscGZ1bAo+ID4gdGhhbgo+ID4gdGhhdC4K
PiA+IAo+IAo+IEFjdHVhbGx5LCB3aXRob3V0IHRoZSBjcmFzaCtyZWJvb3QgaXQgd291bGQgc3Rp
bGwgYmUgYWNjZXB0YWJsZSB0bwo+IHNlZQo+ICJzdGF0ZSBBIiBhdCB0aGUgZW5kIHRoZXJlIC0g
YnV0IHByZWZlcmFibHkgbm90IGZvciBsb25nLgo+IEZyb20gdGhlIE5GUyBwZXJzcGVjdGl2ZSwg
dGhlIGNoYW5nZWlkIG5lZWRzIHRvIHVwZGF0ZSBieSB0aGUgdGltZSBvZgo+IGEKPiBjbG9zZSBv
ciB1bmxvY2sgKHNvIGl0IGlzIHZpc2libGUgdG8gb3BlbiBvciBsb2NrKSwgYnV0IGJlZm9yZSB0
aGF0Cj4gaXQKPiBpcyBqdXN0IGJlc3QtZWZmb3J0LgoKTm9wZS4gVGhhdCB3aWxsIGluZXZpdGFi
bHkgbGVhZCB0byBkYXRhIGNvcnJ1cHRpb24sIHNpbmNlIHRoZQphcHBsaWNhdGlvbiBtaWdodCBk
ZWNpZGUgdG8gdXNlIHRoZSBkYXRhIGZyb20gc3RhdGUgQSBpbnN0ZWFkIG9mCnJldmFsaWRhdGlu
ZyBpdC4KCi0tIApUcm9uZCBNeWtsZWJ1c3QKTGludXggTkZTIGNsaWVudCBtYWludGFpbmVyLCBI
YW1tZXJzcGFjZQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tCgoK
