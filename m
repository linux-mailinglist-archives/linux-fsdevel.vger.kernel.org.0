Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34034630CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhK3KSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 05:18:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:54675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231407AbhK3KSO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638267276;
        bh=CMXfuKcLXjGPWdeqSaOhdOOASlp/euZJFVIobOJQNL4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=lSZw8P4yIh1Mgn7GNXW8ieJwhkFUbYhc/SWPB7+MdIksfONJlrnFOTsSQwm36PpRC
         8mIVeGt1pBvWsc7D3Q3LWPlvMnZtLJ6yz4VpMA3BNgEVogVk5W45KUkBO6AmNMb9tI
         utrPr6xTb4uU1QdWI9O+LFYLB0mA2LG3eJ5lYc80=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.50.175]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1maCDs1OMK-00qwWe; Tue, 30
 Nov 2021 11:14:36 +0100
Message-ID: <a20f17c4b1b5fdfade3f48375d148e97bd162dd6.camel@gmx.de>
Subject: Re: [PATCH 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Alexey Avramov <hakavlad@inbox.lv>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Darrick Wong <djwong@kernel.org>, regressions@lists.linux.dev,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 30 Nov 2021 11:14:32 +0100
In-Reply-To: <20211129150117.GO3366@techsingularity.net>
References: <20211125151853.8540-1-mgorman@techsingularity.net>
         <20211127011246.7a8ac7b8@mail.inbox.lv>
         <20211129150117.GO3366@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:sytcikg7p1xG3fNmhiGZL7NBY2K9XUyGYavCjYpY2QegNfOTUGd
 MYc+6pI02R2B89qVs2Qu5cNCBH4Cw8Az4HxrukT6H9IYYmGQqKRj/gBnf9pzd4ku48TDWQ9
 cYBN+TGa1+g9yy1jYk4iiLf5xW4798Z8xdoF86Yt/Cff7MDwphKngEa8J+FuRemUzaOqcEx
 D2iHP0oFPfVNMG02Ei6Cg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ff7RvvjqUTU=:ZiHJf8Tty843FB013Jywaf
 ckHZ7D6y32XvUacpdjCrlAjoIfGLYSEQnjsPw5G5y+QmlkX/l4PVMOreHfhvihFcqpaprtuRN
 T3W9phRZe4uB/aiWVDiiggTCdcQ1jXdf0u7SzlkoF6443n/xjy1hOt7ymgpG32Ie41MRozlR6
 ItZuufxllAWnqWCJ/bUWI+x0r9US9b/54uZKdwRJt4M7+MBfcgxwh13iK/a8e/WlfNHk76fu9
 Mncs6rN42AeJyBro7glctCfa/gVPMj6D7iOArLSAAmf9DgDrAP3QmItC2oRzzZ2HfkzUGqZ0K
 vpOd88l0c16t//fJBMYdhMVFcaao8Vsy5+HxzdLpHu3hMkq8cU61JykLhJdcg2oQMjQKSLKyj
 9VRcu2EFcxtVifV4kjmN+vdqbug24KmLOqp4SFONf2TkAAOmqTCakifSobYvkWFAD/bJidjoj
 QLbJpSj0FSax9xwaCK0NleJsAyRD5nOFcjSAchd0i6wPcqxjn1GWBJTza4bZNYfYFpleA1gsS
 NMshmVG6wjFJDJFdiLY6/GhPjhClLV0bq5vL+vxRDSIF3Khttfkw4pjmjtTfrJYdhJzZgBZB2
 ozJ0MlyYFBJGR0JqLl7MUeeOZYTBbWNaQX+12LfG/qdm60tujI5lB4OqTkTqTuT6kx5GsYe69
 iKxF/cD8o/9vuqtqsRhhlOYv/3eF31zEcCQwMJmKOTD4yk6/qBzWyaei9zc4b594Lsle7yqHt
 3OAr13o6so1erXptTjzhtjnnCYheesTyBO4s2OdCvw85IPdX005Tw9KxGWr2CFzKjZ/U7KVHi
 VreGwe05kf7tV5Q6aUJrurepyZQjgw+w1iHdeAI8VOf4efqYNT1O8zlEuLfflkvRMX6xoZqXR
 rvDisbaaUnSK86CLDo1Gcm97t9a/TKTPaIbycaX4tJXneewkYbwgXMwEgPTzn8pMTIsc7W0es
 1CtujsFQccTLgHhdSWYGLE3RPzoOrcNaIzwq38DbRHPJ1f+CtpahpaNALMqV8KuwOkMgPgMgK
 TMFX/HCRY99vr5vYfntQaU7Y3AORQitrrbO+0t3DqYVz4g3CMYJePj6QqYO8HrOPJGSYf4MKR
 62eNISEwSyhk6M=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTI5IGF0IDE1OjAxICswMDAwLCBNZWwgR29ybWFuIHdyb3RlOg0KPiBP
biBTYXQsIE5vdiAyNywgMjAyMSBhdCAwMToxMjo0NkFNICswOTAwLCBBbGV4ZXkgQXZyYW1vdiB3
cm90ZToNCj4gPiA+IEFmdGVyIHRoZSBwYXRjaCwgdGhlIHRlc3QgZ2V0cyBraWxsZWQgYWZ0ZXIg
cm91Z2hseSAxNSBzZWNvbmRzIHdoaWNoIGlzDQo+ID4gPiB0aGUgc2FtZSBsZW5ndGggb2YgdGlt
ZSB0YWtlbiBpbiA1LjE1Lg0KPiA+IA0KPiA+IEluIG15IHRlc3RzLCB0aGUgNS4xNSBzdGlsbCBw
ZXJmb3JtcyBtdWNoIGJldHRlci4NCj4gPiANCj4gPiBOZXcgcXVlc3Rpb246IGlzIHRpbWVvdXQ9
MSBoYXMgc2Vuc2U/IFdpbGwgaXQgc2F2ZSBDUFU/DQo+IA0KPiBPaywgdGhlIGZvbGxvd2luZyBv
biB0b3Agb2YgNS4xNi1yYzEgc3Vydml2ZWQgOCBtaW51dGVzIG9mIHdhdGNoaW5nIHlvdXR1YmUN
Cj4gb24gYSBsYXB0b3Agd2hpbGUgInRhaWwgL2Rldi96ZXJvIiB3YXMgcnVubmluZyB3aXRoaW4g
dGhlIGJhY2tncm91bmQuIFdoaWxlDQo+IHRoZXJlIHdlcmUgc29tZSB2ZXJ5IHNob3J0IGdsaXRj
aGVzLCB0aGV5IHdlcmUgbm8gd29yc2UgdGhhbiA1LjE1LiBJJ3ZlDQo+IG5vdCByZXByb2R1Y2Vk
IHlvdXIgZXhhY3QgdGVzdCBjYXNlIHlldCBvciB0aGUgbWVtY2cgb25lcyB5ZXQgYnV0IHNlbmRp
bmcNCj4gbm93IGluIGNhc2UgSSBkb24ndCBjb21wbGV0ZSB0aGVtIGJlZm9yZSB0aGUgZW5kIG9m
IHRoZSBkYXkuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vdm1zY2FuLmMgYi9tbS92bXNjYW4uYw0K
PiBpbmRleCBmYjk1ODQ2NDFhYzcuLjFhZjEyMDcyZjQwZSAxMDA2NDQNCj4gLS0tIGEvbW0vdm1z
Y2FuLmMNCj4gKysrIGIvbW0vdm1zY2FuLmMNCj4gQEAgLTEwMjEsNiArMTAyMSwzOSBAQCBzdGF0
aWMgdm9pZCBoYW5kbGVfd3JpdGVfZXJyb3Ioc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcs
DQo+IMKgwqDCoMKgwqDCoMKgwqB1bmxvY2tfcGFnZShwYWdlKTsNCj4gwqB9DQo+IMKgDQo+ICti
b29sIHNraXBfdGhyb3R0bGVfbm9wcm9ncmVzcyhwZ19kYXRhX3QgKnBnZGF0KQ0KPiArew0KPiAr
wqDCoMKgwqDCoMKgwqBpbnQgcmVjbGFpbWFibGUgPSAwLCB3cml0ZV9wZW5kaW5nID0gMDsNCj4g
K8KgwqDCoMKgwqDCoMKgaW50IGk7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgLyoNCj4gK8KgwqDC
oMKgwqDCoMKgICogSWYga3N3YXBkIGlzIGRpc2FibGVkLCByZXNjaGVkdWxlIGlmIG5lY2Vzc2Fy
eSBidXQgZG8gbm90DQo+ICvCoMKgwqDCoMKgwqDCoCAqIHRocm90dGxlIGFzIHRoZSBzeXN0ZW0g
aXMgbGlrZWx5IG5lYXIgT09NLg0KPiArwqDCoMKgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKHBnZGF0LT5rc3dhcGRfZmFpbHVyZXMgPj0gTUFYX1JFQ0xBSU1fUkVUUklFUykNCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOw0KPiArDQo+ICvCoMKg
wqDCoMKgwqDCoC8qDQo+ICvCoMKgwqDCoMKgwqDCoCAqIElmIHRoZXJlIGFyZSBhIGxvdCBvZiBk
aXJ0eS93cml0ZWJhY2sgcGFnZXMgdGhlbiBkbyBub3QNCj4gK8KgwqDCoMKgwqDCoMKgICogdGhy
b3R0bGUgYXMgdGhyb3R0bGluZyB3aWxsIG9jY3VyIHdoZW4gdGhlIHBhZ2VzIGN5Y2xlDQo+ICvC
oMKgwqDCoMKgwqDCoCAqIHRvd2FyZHMgdGhlIGVuZCBvZiB0aGUgTFJVIGlmIHN0aWxsIHVuZGVy
IHdyaXRlYmFjay4NCj4gK8KgwqDCoMKgwqDCoMKgICovDQo+ICvCoMKgwqDCoMKgwqDCoGZvciAo
aSA9IDA7IGkgPCBNQVhfTlJfWk9ORVM7IGkrKykgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgc3RydWN0IHpvbmUgKnpvbmUgPSBwZ2RhdC0+bm9kZV96b25lcyArIGk7DQo+ICsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmICghcG9wdWxhdGVkX3pvbmUoem9u
ZSkpDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29u
dGludWU7DQo+ICsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlY2xhaW1hYmxl
ICs9IHpvbmVfcmVjbGFpbWFibGVfcGFnZXMoem9uZSk7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqB3cml0ZV9wZW5kaW5nICs9IHpvbmVfcGFnZV9zdGF0ZV9zbmFwc2hvdCh6b25l
LA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5SX1pPTkVfV1JJ
VEVfUEVORElORyk7DQo+ICvCoMKgwqDCoMKgwqDCoH0NCj4gK8KgwqDCoMKgwqDCoMKgaWYgKDIg
KiB3cml0ZV9wZW5kaW5nIDw9IHJlY2xhaW1hYmxlKQ0KDQpUaGF0IGlzIGFsd2F5cyB0cnVlIGhl
cmUuLi4NCg0KCS1NaWtlDQoNCg==
