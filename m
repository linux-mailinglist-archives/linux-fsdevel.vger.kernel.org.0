Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F75F6482
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 12:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJFKsq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 06:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJFKsp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:48:45 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9521398CB0
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 03:48:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-DgXWoVwcNIW55WKjoHfY8Q-1; Thu, 06 Oct 2022 11:48:39 +0100
X-MC-Unique: DgXWoVwcNIW55WKjoHfY8Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 6 Oct
 2022 11:48:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Thu, 6 Oct 2022 11:48:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christian Brauner' <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
CC:     Eric Biederman <ebiederm@xmission.com>,
        Jorge Merlino <jorge.merlino@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "John Johansen" <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Todd Kjos <tkjos@google.com>,
        "Ondrej Mosnacek" <omosnace@redhat.com>,
        Prashanth Prahlad <pprahlad@redhat.com>,
        Micah Morton <mortonm@chromium.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "apparmor@lists.ubuntu.com" <apparmor@lists.ubuntu.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Thread-Topic: [PATCH 1/2] fs/exec: Explicitly unshare fs_struct on exec
Thread-Index: AQHY2WLGFfe2CPUaDEa6axdLVGgCBq4BLZlw
Date:   Thu, 6 Oct 2022 10:48:36 +0000
Message-ID: <cd4c600f91404387bb7be0d727c3c337@AcuMS.aculab.com>
References: <20221006082735.1321612-1-keescook@chromium.org>
 <20221006082735.1321612-2-keescook@chromium.org>
 <20221006090506.paqjf537cox7lqrq@wittgenstein>
In-Reply-To: <20221006090506.paqjf537cox7lqrq@wittgenstein>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQ2hyaXN0aWFuIEJyYXVuZXINCj4gU2VudDogMDYgT2N0b2JlciAyMDIyIDEwOjA1DQo+
IA0KPiBPbiBUaHUsIE9jdCAwNiwgMjAyMiBhdCAwMToyNzozNEFNIC0wNzAwLCBLZWVzIENvb2sg
d3JvdGU6DQo+ID4gVGhlIGNoZWNrX3Vuc2FmZV9leGVjKCkgY291bnRpbmcgb2Ygbl9mcyB3b3Vs
ZCBub3QgYWRkIHVwIHVuZGVyIGEgaGVhdmlseQ0KPiA+IHRocmVhZGVkIHByb2Nlc3MgdHJ5aW5n
IHRvIHBlcmZvcm0gYSBzdWlkIGV4ZWMsIGNhdXNpbmcgdGhlIHN1aWQgcG9ydGlvbg0KPiA+IHRv
IGZhaWwuIFRoaXMgY291bnRpbmcgZXJyb3IgYXBwZWFycyB0byBiZSB1bm5lZWRlZCwgYnV0IHRv
IGNhdGNoIGFueQ0KPiA+IHBvc3NpYmxlIGNvbmRpdGlvbnMsIGV4cGxpY2l0bHkgdW5zaGFyZSBm
c19zdHJ1Y3Qgb24gZXhlYywgaWYgaXQgZW5kcyB1cA0KPiANCj4gSXNuJ3QgdGhpcyBhIHBvdGVu
dGlhbCB1YXBpIGJyZWFrPyBBZmFpY3QsIGJlZm9yZSB0aGlzIGNoYW5nZSBhIGNhbGwgdG8NCj4g
Y2xvbmV7M30oQ0xPTkVfRlMpIGZvbGxvd2VkIGJ5IGFuIGV4ZWMgaW4gdGhlIGNoaWxkIHdvdWxk
IGhhdmUgdGhlDQo+IHBhcmVudCBhbmQgY2hpbGQgc2hhcmUgZnMgaW5mb3JtYXRpb24uIFNvIGlm
IHRoZSBjaGlsZCBlLmcuLCBjaGFuZ2VzIHRoZQ0KPiB3b3JraW5nIGRpcmVjdG9yeSBwb3N0IGV4
ZWMgaXQgd291bGQgYWxzbyBhZmZlY3QgdGhlIHBhcmVudC4gQnV0IGFmdGVyDQo+IHRoaXMgY2hh
bmdlIGhlcmUgdGhpcyB3b3VsZCBubyBsb25nZXIgYmUgdHJ1ZS4gU28gYSBjaGlsZCBjaGFuZ2lu
ZyBhDQo+IHdvcmtkaW5nIGRpcmVjdG9ybyB3b3VsZCBub3QgYWZmZWN0IHRoZSBwYXJlbnQgYW55
bW9yZS4gSU9XLCBhbiBleGVjIGlzDQo+IGFjY29tcGFuaWVkIGJ5IGFuIHVuc2hhcmUoQ0xPTkVf
RlMpLiBNaWdodCBzdGlsbCBiZSB3b3J0aCB0cnlpbmcgb2ZjIGJ1dA0KPiBpdCBzZWVtcyBsaWtl
IGEgbm9uLXRyaXZpYWwgdWFwaSBjaGFuZ2UgYnV0IHRoZXJlIG1pZ2h0IGJlIGZldyB1c2Vycw0K
PiB0aGF0IGRvIGNsb25lezN9KENMT05FX0ZTKSBmb2xsb3dlZCBieSBhbiBleGVjLg0KDQpUaGUg
dGhvdWdodCBvZiB0aGF0IGlzIGVudGlyZWx5IGhvcnJpZC4uLg0KDQpJIHByZXN1bWUgYSBzdWlk
IGV4ZWMgd2lsbCBmYWlsIGluIHRoYXQgY2FzZT8NCg0KSWYgdGhlIG9sZCBjb2RlIGlzIHRyeWlu
ZyB0byBjb21wYXJlIHRoZSBudW1iZXIgb2YgdGhyZWFkcw0Kd2l0aCB0aGUgbnVtYmVyIG9mIHVz
ZXJzIG9mIHRoZSBmcyB0YWJsZSBpc24ndCBpcyBqdXN0IGJ1Z2d5Pw0KSWYgYSB0aHJlYWQgdW5z
aGFyZXMgdGhlIGZzIHRhYmxlIHRoZXJlIGNhbiBiZSBhbm90aGVyDQpyZWZlcmVuY2Ugc29tZXdo
ZXJlIGVsc2UgLSB3aGljaCBpcyB3aGF0IChJIHByZXN1bWUpIGlzIGJlaW5nDQp0ZXN0ZWQgZm9y
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

