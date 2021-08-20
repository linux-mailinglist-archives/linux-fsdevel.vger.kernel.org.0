Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAD33F2865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhHTI0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:30444 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234924AbhHTI0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:30 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-50-1lwXgCl5MSC7hSZT66iCNQ-1; Fri, 20 Aug 2021 09:25:49 +0100
X-MC-Unique: 1lwXgCl5MSC7hSZT66iCNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Fri, 20 Aug 2021 09:25:47 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Fri, 20 Aug 2021 09:25:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'NeilBrown' <neilb@suse.de>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
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
        Nicholas Piggin <npiggin@gmail.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Marco Elver" <elver@google.com>,
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
Thread-Index: AQHXj6qO2FP1eIrarUmjR9CxLZPkE6txIhrAgAqqIaSAAEsGQA==
Date:   Fri, 20 Aug 2021 08:25:47 +0000
Message-ID: <aacb44aad4064d4b84dca97c38d0b6a0@AcuMS.aculab.com>
References: <20210812084348.6521-1-david@redhat.com>,
 <87o8a2d0wf.fsf@disp2133>,
 <60db2e61-6b00-44fa-b718-e4361fcc238c@www.fastmail.com>,
 <87lf56bllc.fsf@disp2133>,
 <CAHk-=wgru1UAm3kAKSOdnbewPXQMOxYkq9PnAsRadAC6pXCCMQ@mail.gmail.com>,
 <87eeay8pqx.fsf@disp2133>,
 <5b0d7c1e73ca43ef9ce6665fec6c4d7e@AcuMS.aculab.com>,
 <87h7ft2j68.fsf@disp2133>,
 <CAHk-=whmXTiGUzVrTP=mOPQrg-XOi3R-45hC4dQOqW4JmZdFUQ@mail.gmail.com>,
 <b629cda1-becd-4725-b16c-13208ff478d3@www.fastmail.com>,
 <20210818154217.GB24115@fieldses.org>
 <162943109106.9892.7426782042253067338@noble.neil.brown.name>
In-Reply-To: <162943109106.9892.7426782042253067338@noble.neil.brown.name>
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

RnJvbTogTmVpbEJyb3duDQo+IFNlbnQ6IDIwIEF1Z3VzdCAyMDIxIDA0OjQ1DQouLi4NCj4gT19E
RU5ZUkVBRCBpcyBhbiBpbnNhbmUgZmxhZy4gIElmIGEgcHJvY2VzcyByZWFkcyBhIGZpbGUgdGhh
dCBzb21lIG90aGVyDQo+IHByb2Nlc3MgaXMgd29ya2luZyBvbiwgdGhlbiB0aGUgb25seSB3aGlj
aCBjb3VsZCBiZSBodXJ0IGlzIHRoZSByZWFkZXIuDQo+IFNvIGFsbG93aW5nIGEgcHJvY2VzcyB0
byBhc2sgZm9yIHRoZSBvcGVuIHRvIGZhaWwgaWYgc29tZW9uZSBpcyB3cml0aW5nDQo+IG1pZ2h0
IG1ha2Ugc2Vuc2UuICBJbnNpc3RpbmcgdGhhdCBhbGwgb3BlbnMgZmFpbCBkb2VzIG5vdC4NCj4g
QW55IGNvZGUgd2FudGluZyBPX0RFTllSRUFEICpzaG91bGQqIHVzZSBhZHZpc29yeSBsb2NraW5n
LCBhbmQgYW55IGNvZGUNCj4gd2FudGluZyB0byBrbm93IGFib3V0IHJlYWQgZGVuaWFsIHNob3Vs
ZCB0b28uDQoNCkl0IG1pZ2h0IG1ha2Ugc2Vuc2UgaWYgT19ERU5ZUkVBRCB8IE9fREVOWVdSSVRF
IHwgT19SRFdSIGFyZSBhbGwgc2V0Lg0KVGhhdCB3b3VsZCBiZSB3aGF0IE9fRVhDTCBvdWdodCB0
byBtZWFuIGZvciBhIG5vcm1hbCBmaWxlLg0KU28gd291bGQgYmUgdXNlZnVsIGZvciBhIHByb2dy
YW0gdGhhdCB3YW50cyB0byB1cGRhdGUgYSBjb25maWcgZmlsZS4NCg0KLi4uDQo+IEl0IHdvdWxk
IGJlIG5pY2UgdG8gYmUgYWJsZSB0byBjb21iaW5lIE9fREVOWVdSSVRFIHdpdGggT19SRFdSLiAg
VGhpcw0KPiBjb21iaW5hdGlvbiBpcyBleGFjdGx5IHdoYXQgdGhlIGtlcm5lbCAqc2hvdWxkKiBk
byBmb3Igc3dhcCBmaWxlcy4NCg0KSSBzdXNwZWN0IHRoYXQgaXMgYSBjb21tb24gdXNhZ2UgLSBl
ZyBmb3IgdXBkYXRpbmcgYSBmaWxlIHRoYXQgY29udGFpbnMNCmEgbG9nIGZpbGUgc2VxdWVuY2Ug
bnVtYmVyLg0KDQouLi4NCj4gSSdtIG5vdCBzdXJlIGFib3V0IE9fREVOWURFTEVURS4gIEl0IGlz
IGEgbG9jayBvbiB0aGUgbmFtZS4gIFVuaXggaGFzDQo+IHRyYWRpdGlvbmFsbHkgdXNlZCBsb2Nr
LWZpbGVzIHRvIGxvY2sgYSBuYW1lLiAgVGhlIGZ1bmN0aW9uYWxpdHkgbWFrZXMNCj4gc2Vuc2Ug
Zm9yIHByb2Nlc3NlcyB3aXRoIHdyaXRlLWFjY2VzcyB0byB0aGUgZGlyZWN0b3J5Li4uDQoNCkkn
bSBub3Qgc3VyZSBpdCBtYWtlcyBhbnkgc2Vuc2Ugb24gZmlsZXN5c3RlbXMgdGhhdCB1c2UgaW5v
ZGUgbnVtYmVycy4NCldoaWNoIG5hbWUgd291bGQgeW91IHByb3RlY3QsIGFuZCBob3cgd291bGQg
eW91IG1hbmFnZSB0byBkbyB0aGUgdGVzdC4NCk9uIHdpbmRvd3MgT19ERU5ZREVMRVRFIGlzIHBy
ZXR0eSBtdWNoIHRoZSBkZWZhdWx0Lg0KV2hpY2ggaXMgd2h5IHNvZnR3YXJlIHVwZGF0ZXMgYXJl
IHN1Y2ggYSBQSVRBLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

