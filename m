Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B58824E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 20:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407480AbfHISWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 14:22:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:40070 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfHISWM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 14:22:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 11:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="186739728"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 09 Aug 2019 11:22:10 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 11:22:10 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 9 Aug 2019 11:22:10 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.115]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.51]) with mapi id 14.03.0439.000;
 Fri, 9 Aug 2019 12:22:08 -0600
From:   "Weiny, Ira" <ira.weiny@intel.com>
To:     John Hubbard <jhubbard@nvidia.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: RE: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Thread-Topic: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
Thread-Index: AQHVS9wAqKeuPoXzZkyLXp0tqoyMNKbv6+CAgADRpQCAAHJ+gIAAUE4AgACJIACAAD05gP//ln8AgAB54ICAAM5HUA==
Date:   Fri, 9 Aug 2019 18:22:07 +0000
Message-ID: <2807E5FD2F6FDA4886F6618EAC48510E79E7F453@CRSMSX101.amr.corp.intel.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
 <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
 <d1ecb0d4-ea6a-637d-7029-687b950b783f@nvidia.com>
 <20190808234138.GA15908@iweiny-DESK2.sc.intel.com>
 <5713cc2b-b41c-142a-eb52-f5cda999eca7@nvidia.com>
In-Reply-To: <5713cc2b-b41c-142a-eb52-f5cda999eca7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmYwZDM5MDEtOTVmNS00YzJjLTk3OTMtNTgzN2EzOWFmOWE2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSHhuMlcydnYrT1htcHFmMllmYkFuREc0YU1BRVRSdHVlUjUxU0hydDk4SVZtY3dPYUZKdVloWUFCM0NQVVZYTiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.18.205.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiANCj4gT24gOC84LzE5IDQ6NDEgUE0sIElyYSBXZWlueSB3cm90ZToNCj4gPiBPbiBUaHUsIEF1
ZyAwOCwgMjAxOSBhdCAwMzo1OToxNVBNIC0wNzAwLCBKb2huIEh1YmJhcmQgd3JvdGU6DQo+ID4+
IE9uIDgvOC8xOSAxMjoyMCBQTSwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPiA+Pj4gT24gOC84LzE5
IDQ6MDkgQU0sIFZsYXN0aW1pbCBCYWJrYSB3cm90ZToNCj4gPj4+PiBPbiA4LzgvMTkgODoyMSBB
TSwgTWljaGFsIEhvY2tvIHdyb3RlOg0KPiA+Pj4+PiBPbiBXZWQgMDctMDgtMTkgMTY6MzI6MDgs
IEpvaG4gSHViYmFyZCB3cm90ZToNCj4gPj4+Pj4+IE9uIDgvNy8xOSA0OjAxIEFNLCBNaWNoYWwg
SG9ja28gd3JvdGU6DQo+ID4+Pj4+Pj4gT24gTW9uIDA1LTA4LTE5IDE1OjIwOjE3LCBqb2huLmh1
YmJhcmRAZ21haWwuY29tIHdyb3RlOg0KPiAuLi4NCj4gPj4gT2gsIGFuZCBtZWFud2hpbGUsIEkn
bSBsZWFuaW5nIHRvd2FyZCBhIGNoZWFwIGZpeDoganVzdCB1c2UNCj4gPj4gZ3VwX2Zhc3QoKSBp
bnN0ZWFkIG9mIGdldF9wYWdlKCksIGFuZCBhbHNvIGZpeCB0aGUgcmVsZWFzaW5nIGNvZGUuIFNv
DQo+ID4+IHRoaXMgaW5jcmVtZW50YWwgcGF0Y2gsIG9uIHRvcCBvZiB0aGUgZXhpc3Rpbmcgb25l
LCBzaG91bGQgZG8gaXQ6DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9tbS9tbG9jay5jIGIvbW0v
bWxvY2suYw0KPiA+PiBpbmRleCBiOTgwZTYyNzBlOGEuLjJlYTI3MmM2ZmVlMyAxMDA2NDQNCj4g
Pj4gLS0tIGEvbW0vbWxvY2suYw0KPiA+PiArKysgYi9tbS9tbG9jay5jDQo+ID4+IEBAIC0zMTgs
MTggKzMxOCwxNCBAQCBzdGF0aWMgdm9pZCBfX211bmxvY2tfcGFnZXZlYyhzdHJ1Y3QgcGFnZXZl
Yw0KPiAqcHZlYywgc3RydWN0IHpvbmUgKnpvbmUpDQo+ID4+ICAgICAgICAgICAgICAgICAvKg0K
PiA+PiAgICAgICAgICAgICAgICAgICogV2Ugd29uJ3QgYmUgbXVubG9ja2luZyB0aGlzIHBhZ2Ug
aW4gdGhlIG5leHQgcGhhc2UNCj4gPj4gICAgICAgICAgICAgICAgICAqIGJ1dCB3ZSBzdGlsbCBu
ZWVkIHRvIHJlbGVhc2UgdGhlIGZvbGxvd19wYWdlX21hc2soKQ0KPiA+PiAtICAgICAgICAgICAg
ICAgICogcGluLiBXZSBjYW5ub3QgZG8gaXQgdW5kZXIgbHJ1X2xvY2sgaG93ZXZlci4gSWYgaXQn
cw0KPiA+PiAtICAgICAgICAgICAgICAgICogdGhlIGxhc3QgcGluLCBfX3BhZ2VfY2FjaGVfcmVs
ZWFzZSgpIHdvdWxkIGRlYWRsb2NrLg0KPiA+PiArICAgICAgICAgICAgICAgICogcGluLg0KPiA+
PiAgICAgICAgICAgICAgICAgICovDQo+ID4+IC0gICAgICAgICAgICAgICBwYWdldmVjX2FkZCgm
cHZlY19wdXRiYWNrLCBwdmVjLT5wYWdlc1tpXSk7DQo+ID4+ICsgICAgICAgICAgICAgICBwdXRf
dXNlcl9wYWdlKHBhZ2VzW2ldKTsNCj4gDQo+IGNvcnJlY3Rpb24sIG1ha2UgdGhhdDoNCj4gICAg
ICAgICAgICAgICAgICAgIHB1dF91c2VyX3BhZ2UocHZlYy0+cGFnZXNbaV0pOw0KPiANCj4gKFRo
aXMgaXMgbm90IGZ1bGx5IHRlc3RlZCB5ZXQuKQ0KPiANCj4gPj4gICAgICAgICAgICAgICAgIHB2
ZWMtPnBhZ2VzW2ldID0gTlVMTDsNCj4gPj4gICAgICAgICB9DQo+ID4+ICAgICAgICAgX19tb2Rf
em9uZV9wYWdlX3N0YXRlKHpvbmUsIE5SX01MT0NLLCBkZWx0YV9tdW5sb2NrZWQpOw0KPiA+PiAg
ICAgICAgIHNwaW5fdW5sb2NrX2lycSgmem9uZS0+em9uZV9wZ2RhdC0+bHJ1X2xvY2spOw0KPiA+
Pg0KPiA+PiAtICAgICAgIC8qIE5vdyB3ZSBjYW4gcmVsZWFzZSBwaW5zIG9mIHBhZ2VzIHRoYXQg
d2UgYXJlIG5vdCBtdW5sb2NraW5nICovDQo+ID4+IC0gICAgICAgcGFnZXZlY19yZWxlYXNlKCZw
dmVjX3B1dGJhY2spOw0KPiA+PiAtDQo+ID4NCj4gPiBJJ20gbm90IGFuIGV4cGVydCBidXQgdGhp
cyBza2lwcyBhIGNhbGwgdG8gbHJ1X2FkZF9kcmFpbigpLiAgSXMgdGhhdCBvaz8NCj4gDQo+IFll
czogdW5sZXNzIEknbSBtaXNzaW5nIHNvbWV0aGluZywgdGhlcmUgaXMgbm8gcmVhc29uIHRvIGdv
IHRocm91Z2gNCj4gbHJ1X2FkZF9kcmFpbiBpbiB0aGlzIGNhc2UuIFRoZXNlIGFyZSBndXAnZCBw
YWdlcyB0aGF0IGFyZSBub3QgZ29pbmcgdG8gZ2V0DQo+IGFueSBmdXJ0aGVyIHByb2Nlc3Npbmcu
DQo+IA0KPiA+DQo+ID4+ICAgICAgICAgLyogUGhhc2UgMjogcGFnZSBtdW5sb2NrICovDQo+ID4+
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IG5yOyBpKyspIHsNCj4gPj4gICAgICAgICAgICAgICAg
IHN0cnVjdCBwYWdlICpwYWdlID0gcHZlYy0+cGFnZXNbaV07IEBAIC0zOTQsNiArMzkwLDgNCj4g
Pj4gQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgX19tdW5sb2NrX3BhZ2V2ZWNfZmlsbChzdHJ1Y3Qg
cGFnZXZlYyAqcHZlYywNCj4gPj4gICAgICAgICBzdGFydCArPSBQQUdFX1NJWkU7DQo+ID4+ICAg
ICAgICAgd2hpbGUgKHN0YXJ0IDwgZW5kKSB7DQo+ID4+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
cGFnZSAqcGFnZSA9IE5VTEw7DQo+ID4+ICsgICAgICAgICAgICAgICBpbnQgcmV0Ow0KPiA+PiAr
DQo+ID4+ICAgICAgICAgICAgICAgICBwdGUrKzsNCj4gPj4gICAgICAgICAgICAgICAgIGlmIChw
dGVfcHJlc2VudCgqcHRlKSkNCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgcGFnZSA9IHZt
X25vcm1hbF9wYWdlKHZtYSwgc3RhcnQsICpwdGUpOyBAQA0KPiA+PiAtNDExLDcgKzQwOSwxMyBA
QCBzdGF0aWMgdW5zaWduZWQgbG9uZyBfX211bmxvY2tfcGFnZXZlY19maWxsKHN0cnVjdA0KPiBw
YWdldmVjICpwdmVjLA0KPiA+PiAgICAgICAgICAgICAgICAgaWYgKFBhZ2VUcmFuc0NvbXBvdW5k
KHBhZ2UpKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPj4NCj4gPj4g
LSAgICAgICAgICAgICAgIGdldF9wYWdlKHBhZ2UpOw0KPiA+PiArICAgICAgICAgICAgICAgLyoN
Cj4gPj4gKyAgICAgICAgICAgICAgICAqIFVzZSBnZXRfdXNlcl9wYWdlc19mYXN0KCksIGluc3Rl
YWQgb2YgZ2V0X3BhZ2UoKSBzbyB0aGF0IHRoZQ0KPiA+PiArICAgICAgICAgICAgICAgICogcmVs
ZWFzaW5nIGNvZGUgY2FuIHVuY29uZGl0aW9uYWxseSBjYWxsIHB1dF91c2VyX3BhZ2UoKS4NCj4g
Pj4gKyAgICAgICAgICAgICAgICAqLw0KPiA+PiArICAgICAgICAgICAgICAgcmV0ID0gZ2V0X3Vz
ZXJfcGFnZXNfZmFzdChzdGFydCwgMSwgMCwgJnBhZ2UpOw0KPiA+PiArICAgICAgICAgICAgICAg
aWYgKHJldCAhPSAxKQ0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPg0K
PiA+IEkgbGlrZSB0aGUgaWRlYSBvZiBtYWtpbmcgdGhpcyBhIGdldC9wdXQgcGFpciBidXQgSSdt
IGZlZWxpbmcgdW5lYXN5DQo+ID4gYWJvdXQgaG93IHRoaXMgaXMgcmVhbGx5IHN1cHBvc2VkIHRv
IHdvcmsuDQo+ID4NCj4gPiBGb3Igc3VyZSB0aGUgR1VQL1BVUCB3YXMgc3VwcG9zZWQgdG8gYmUg
c2VwYXJhdGUgZnJvbSBbZ2V0fHB1dF1fcGFnZS4NCj4gPg0KPiANCj4gQWN0dWFsbHksIHRoZXkg
Ym90aCB0YWtlIHJlZmVyZW5jZXMgb24gdGhlIHBhZ2UuIEFuZCBpdCBpcyBhYnNvbHV0ZWx5IE9L
IHRvIGNhbGwNCj4gdGhlbSBib3RoIG9uIHRoZSBzYW1lIHBhZ2UuDQo+IA0KPiBCdXQgYW55d2F5
LCB3ZSdyZSBub3QgbWl4aW5nIHRoZW0gdXAgaGVyZS4gSWYgeW91IGZvbGxvdyB0aGUgY29kZSBw
YXRocywNCj4gZWl0aGVyIGd1cCBvciBmb2xsb3dfcGFnZV9tYXNrKCkgaXMgdXNlZCwgYW5kIHRo
ZW4gcHV0X3VzZXJfcGFnZSgpDQo+IHJlbGVhc2VzLg0KPiANCj4gU28uLi55b3UgaGF2ZW4ndCBh
Y3R1YWxseSBwb2ludGVkIHRvIGEgYnVnIGhlcmUsIHJpZ2h0PyA6KQ0KDQpOby4uLiAgbm8gYnVn
Lg0KDQpzb3JyeSB0aGlzIHdhcyBqdXN0IGEgZ2VuZXJhbCBjb21tZW50IG9uIHNlbWFudGljcy4g
IEJ1dCBpbiBrZWVwaW5nIHdpdGggdGhlIHNlbWFudGljcyBkaXNjdXNzaW9uIGl0IGlzIGZ1cnRo
ZXIgY29uZnVzaW5nIHRoYXQgZm9sbG93X3BhZ2VfbWFzaygpIGlzIGFsc28gbWl4ZWQgaW4gaGVy
ZS4uLg0KDQpXaGljaCBpcyB3aGVyZSBteSBjb21tZW50IHdhcyBkcml2aW5nIHRvd2FyZC4gIElm
IHlvdSBjYWxsIEdVUCB0aGVyZSBzaG91bGQgYmUgYSBQVVAuICBHZXRfcGFnZS9wdXRfcGFnZS4u
LiAgZm9sbG93X3BhZ2UvdW5mb2xsb3dfcGFnZS4uLiAgPz8/ICA7LSkgIE9rIG5vdyBJJ20gb2Zm
IHRoZSByYWlscy4uLiAgYnV0IHRoYXQgd2FzIHRoZSBwb2ludC4uLg0KDQpJIHRoaW5rIEphbiBh
bmQgTWljaGFsIGFyZSBvbnRvIHNvbWV0aGluZyBoZXJlIFdSVCBpbnRlcm5hbCB2cyBleHRlcm5h
bCBpbnRlcmZhY2VzLg0KDQpJcmENCg0K
