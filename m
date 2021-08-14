Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02293EC4D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhHNTwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 15:52:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:36976 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232356AbhHNTwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 15:52:38 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-41-zR9RdrimPfW8ySEk10pv2Q-1; Sat, 14 Aug 2021 20:52:05 +0100
X-MC-Unique: zR9RdrimPfW8ySEk10pv2Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Sat, 14 Aug 2021 20:52:02 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Sat, 14 Aug 2021 20:52:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Mike Rapoport" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Jann Horn <jannh@google.com>, Feng Tang <feng.tang@intel.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Shawn Anastasio" <shawn@anastas.io>,
        Steven Price <steven.price@arm.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Marco Elver <elver@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Nicolas Viennot" <Nicolas.Viennot@twosigma.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Collin Fijalkovich <cfijalkovich@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Chengguang Xu <cgxu519@mykernel.net>,
        =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= 
        <ckoenig.leichtzumerken@gmail.com>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "Florian Weimer" <fweimer@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: RE: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Thread-Topic: [PATCH v1 0/7] Remove in-tree usage of MAP_DENYWRITE
Thread-Index: AQHXj6qO2FP1eIrarUmjR9CxLZPkE6txIhrAgAEMnaiAATj0kA==
Date:   Sat, 14 Aug 2021 19:52:02 +0000
Message-ID: <bff636739a5141b0a9ee0c8da734b707@AcuMS.aculab.com>
References: <20210812084348.6521-1-david@redhat.com> <87o8a2d0wf.fsf@disp2133>
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>
 <87lf56bllc.fsf@disp2133>
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>
 <87eeay8pqx.fsf@disp2133> <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>
 <87h7ft2j68.fsf@disp2133>
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>
 <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
In-Reply-To: <CAHk-=wiJ0u33h2CXAO4b271Diik=z4jRt64=Gt6YV2jV4ef27g@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTQgQXVndXN0IDIwMjEgMDE6NTUNCj4gDQo+
IE9uIEZyaSwgQXVnIDEzLCAyMDIxIGF0IDI6NDkgUE0gQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSeKAmWxsIGJpdGUuICBIb3cgYWJvdXQgd2UgYXR0
YWNrIHRoaXMgaW4gdGhlIG9wcG9zaXRlIGRpcmVjdGlvbjogcmVtb3ZlIHRoZSBkZW55IHdyaXRl
IG1lY2hhbmlzbQ0KPiBlbnRpcmVseS4NCj4gDQo+IEkgdGhpbmsgdGhhdCB3b3VsZCBiZSBvaywg
ZXhjZXB0IEkgY2FuIHNlZSBzb21lYm9keSByZWx5aW5nIG9uIGl0Lg0KPiANCj4gSXQncyBicm9r
ZW4sIGl0J3Mgc3R1cGlkLCBidXQgd2UndmUgZG9uZSB0aGF0IEVUWFRCVVNZIGZvciBhIF9sb29u
Z18gdGltZS4NCg0KSSB0aGluayBFVFhUQlVTWSBwcmVkYXRlcyBMaW51eCBpdHNlbGYuDQpCdXQg
SSBjYW4ndCByZW1lbWJlciB3aGV0aGVyIHRoZSBlbGYgdmVyc2lvbnMgb2Ygc3Vub3Mgb3Igc3Zy
NA0KaW1wbGVtZW50ZWQgaXQgZm9yIHNoYXJlZCBsaWJyYXJpZXMuDQpJIGRvbid0IHJlbWVtYmVy
IGhpdHRpbmcgaXQsIHNvIHRoZXkgbWF5IG5vdCBoYXZlLg0KDQpJJ20gYWN0dWFsbHkgc3VycHJp
c2VkIGl0IGlhIGFuIG1tYXAoKSBmbGFnIHJhdGhlciB0aGFuIGFuIG9wZW4oKSBvbmUuDQpCZWlu
ZyBhYmxlIHRvIG9wZW4gYSBmaWxlIGFuZCBndWFyYW50ZWUgaXQgY2FuJ3QgYmUgY2hhbmdlZCBz
ZWVtcyBhIHNhbmUgaWRlYS4NCkFuZCBub3QganVzdCBmb3IgcHJvZ3JhbXMvbGlicmFyaWVzLg0K
DQpCeSB0aGUgc291bmQgb2YgaXQgJ2ltbXV0YWJsZScgaXMgbm8gdXNlLg0KWW91IG5lZWQgdG8g
YmUgYWJsZSB0byB1bmxpbmsgdGhlIGZpbGUgLSBvdGhlcndpc2UgeW91IGdldCBpbnRvIHRoZQ0K
d2luZG93J3MgZmlhc2NvIG9mIG5vdCBiZWluZyBhYmxlIHRvIHVwZGF0ZSB3aXRob3V0IDE3IHJl
Ym9vdHMuDQoNCkZXSVcgTUFQX0NPUFkgd291bGQgb25seSBuZWVkIHRvIHRha2Ugb25lIGNvcHkg
b2YgdGhlIHBhZ2UgLSBhbGwgdGhlDQp1c2VycyBjb3VsZCBzaGFyZSB0aGUgc2FtZSBwYWdlIChi
YWNrZWQgYnkgYSBzaW5nbGUgcGFnZSBvZiBzd2FwKS4NCk5vdCB0aGF0IEknbSBzdWdnZXN0aW5n
IGl0IGlzIGEgZ29vZCBpZGVhIGF0IGFsbC4NCg0KSSBkbyB3b25kZXIgYWJvdXQgL3Byb2Mvc2Vs
Zi9leGUgdGhvdWdoLg0KSXQgZ2F2ZSB0aGUgTmV0QlNEIExpbnV4IGVtdWxhdGlvbiBhIHRlcnJp
YmxlIHByb2JsZW0uDQpCZWluZyBhYmxlIHRvIG9wZW4gdGhlIGlub2RlIG9mIHRoZSBwcm9ncmFt
IGlzIGZpbmUuDQpUaGUgcHJvYmxlbSBpcyB0aGUgd2hhdCByZWFkbGluaygpIHJldHVybnMgLSBp
dCBpcyBiYXNpY2FsbHkgc3RhbGUuDQpJZiBhIHByb2dyYW0gb3BlbiB0aGUgbGluayBjb250ZW50
cyBpdCBjb3VsZCBnZXQgYW55dGhpbmcgYXQgYWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

