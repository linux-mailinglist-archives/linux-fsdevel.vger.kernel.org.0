Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E8336F21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhCKJqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 04:46:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41514 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232156AbhCKJps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:45:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-225-4UYgS0e5NKS5qbXrFZ57sA-1; Thu, 11 Mar 2021 09:45:44 +0000
X-MC-Unique: 4UYgS0e5NKS5qbXrFZ57sA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 11 Mar 2021 09:45:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 11 Mar 2021 09:45:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Eric W. Biederman'" <ebiederm@xmission.com>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "John Johansen" <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Subject: RE: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Thread-Topic: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
Thread-Index: AQHXFeMKfWlhWd9Z4UmL5GfL4v4dzap+ifLA
Date:   Thu, 11 Mar 2021 09:45:43 +0000
Message-ID: <e6baf7139fd14d0d82ff7be7eacccdca@AcuMS.aculab.com>
References: <20210310181857.401675-1-mic@digikod.net>
        <20210310181857.401675-2-mic@digikod.net>
 <m17dmeq0co.fsf@fess.ebiederm.org>
In-Reply-To: <m17dmeq0co.fsf@fess.ebiederm.org>
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

RnJvbTogRXJpYyBXLiBCaWVkZXJtYW4NCj4gU2VudDogMTAgTWFyY2ggMjAyMSAxOToyNA0KLi4u
DQo+IFRoZSBhY3R1YWwgY2xhc3NpYyBjaHJvb3QgZXNjYXBlIGlzLg0KPiBjaGRpcigiLyIpOw0K
PiBjaHJvb3QoIi9zb21lZGlyIik7DQo+IGNoZGlyKCIuLi8uLi8uLi8uLiIpOw0KDQpUaGF0IG9u
ZSBpcyBlYXNpbHkgY2hlY2tlZC4NCg0KSSB0aG91Z2h0IHNvbWV0aGluZyBsaWtlOg0KY2hyb290
KCIvc29tZWRpciIpOw0KY2hkaXIoIi9zb21lcGF0aCIpOw0KDQpGcmllbmRseSBwcm9jZXNzOg0K
bXZkaXIoIi9zb21lZGlyL3NvbWVfcGF0aCIsICIvYmFyIik7DQoNCndhcyB0aGUgYWN0dWFsIGVz
Y2FwZT8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

