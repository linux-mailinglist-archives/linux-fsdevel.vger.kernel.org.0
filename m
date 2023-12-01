Return-Path: <linux-fsdevel+bounces-4569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB7800B13
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5984E28159E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64925569
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF651730
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 04:11:29 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-SHaZSo6eNKOq97Qy2N8DLw-1; Fri, 01 Dec 2023 12:11:23 +0000
X-MC-Unique: SHaZSo6eNKOq97Qy2N8DLw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 12:11:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 12:11:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Benno Lossin' <benno.lossin@proton.me>, Theodore Ts'o <tytso@mit.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alice Ryhl
	<aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
	<alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?=
	<arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen
	<maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
	<cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams
	<dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox
	<willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu
	<dxu@dxuuu.xyz>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Thread-Topic: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Thread-Index: AQHaI6grPX7M7xYYCUW0jSY5A3gIgLCUVnoA
Date: Fri, 1 Dec 2023 12:11:16 +0000
Message-ID: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
 <2023113041-bring-vagrancy-a417@gregkh>
 <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
 <20231130155846.GA534667@mit.edu>
 <25TYokAJ6urAw9GygDDgCcp2mDZT42AF6l8v_u5y-0XZONnHa9kr4Tz_zh30URNuaT-8Q0JnTXgZqeAiinxPEZqzS8StBKyjizZ9e5mysS8=@proton.me>
In-Reply-To: <25TYokAJ6urAw9GygDDgCcp2mDZT42AF6l8v_u5y-0XZONnHa9kr4Tz_zh30URNuaT-8Q0JnTXgZqeAiinxPEZqzS8StBKyjizZ9e5mysS8=@proton.me>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiA+IEkgZG9uJ3Qga25vdyBhYm91dCBSdXN0IG5hbWVzcGFjaW5nLCBidXQgaW4gb3RoZXIgbGFu
Z3VhZ2VzLCBob3cgeW91DQo+ID4gaGF2ZSB0byBlc3BlY2lmeSBuYW1lc3BhY2VzIHRlbmQgdG8g
YmUgKioqZmFyKioqIG1vcmUgdmVyYm9zZSB0aGFuDQo+ID4ganVzdCBhZGRpbmcgYW4gT18gcHJl
Zml4Lg0KPiANCj4gSW4gdGhpcyBjYXNlIHdlIGFscmVhZHkgaGF2ZSB0aGUgYGZsYWdzYCBuYW1l
c3BhY2UsIHNvIEkgdGhvdWdodCBhYm91dA0KPiBqdXN0IGRyb3BwaW5nIHRoZSBgT19gIHByZWZp
eCBhbHRvZ2V0aGVyLg0KDQpEb2VzIHJ1c3QgaGF2ZSBhICd1c2luZyBuYW1lc3BhY2UnIChvciBz
aW1pbGFyKSBzbyB0aGF0IG5hbWVzcGFjZSBkb2Vzbid0DQpoYXZlIHRvIGJlIGV4cGxpY2l0bHkg
c3BlY2lmaWVkIGVhY2ggdGltZSBhIHZhbHVlIGlzIHVzZWQ/DQpJZiBzbyB5b3Ugc3RpbGwgbmVl
ZCBhIGhpbnQgYWJvdXQgd2hpY2ggc2V0IG9mIHZhbHVlcyBpdCBpcyBmcm9tLg0KDQpPdGhlcndp
c2UgeW91IGdldCBpbnRvIHRoZSBzYW1lIG1lc3MgYXMgQysrIGNsYXNzIG1lbWJlcnMgKEkgdGhp
bmsNCnRoZXkgc2hvdWxkIGhhdmUgYmVlbiAubWVtYmVyIGZyb20gdGhlIHN0YXJ0KS4NCk9yLCB3
b3JzZSBzdGlsbCwgUGFzY2FsIGFuZCBtdWx0aXBsZSAnd2l0aCcgYmxvY2tzLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K


