Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2DC62BEB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 13:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKPMxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 07:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiKPMxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:53:37 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB2B7E7;
        Wed, 16 Nov 2022 04:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=xBAeCVptFbtzjwGJPhdVosR+Dozmcafc15UMBTFJB5Q=; b=08zLYLTPYx4yVriV/Ko5T/ZyrA
        8e7qBKmzmlOuvWuW7cdSOfXh2eP/WjqK3CR2vqCr9VyJwqrycX1iQNWhoMIgE8C/S1Onq0kIZuC+C
        OOsuBSypuotD+7oGELLb5ThdaeYh/7qy+CBac456p9C5wDeK5AsXilIb9k25nPRa6i5tFyTGaJbBI
        zoBEFhj20zPSicM8V/YQoUe+/rMZW8s6doIniWIXaHHx5Tb2J7ONQzJdlXzSnc4edF5vNMgcdBnPB
        srWRgne2vaLFi0eLrGQX6it7ohd5Fkqk0Kmh+3ss1+q09bGD6RKYlUxGRKum9EOgPaTjnT5yfN5lm
        46H3gajCqldfl0dsSWJte9V7G/j5zILMd2Yh0n5GVucYQQCWWA+6g97ZLXSIRUuQKJSxtaJI1G3wS
        4E5wSICvQOIrdwKzCztM/EXhNGJcPJdzm6127gm8S/HX01OIJLeDiK2ZAlwRmfSZ2vQX7e7FstOQz
        4k2JVCBgA4o3pG+EAw4t/Erp;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1ovHv1-008sHO-Ci; Wed, 16 Nov 2022 12:53:31 +0000
Message-ID: <34140d2f-4f1f-0d58-c0ca-eb181ca9fde3@samba.org>
Date:   Wed, 16 Nov 2022 13:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, tom@talpey.com, Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <88b441af-d6ae-4d46-aae5-0b649e76031d@samba.org>
 <3609b064-175c-fc18-cd1a-e177d0349c58@samba.org>
 <166855224228.1998592.2212551359609792175.stgit@warthog.procyon.org.uk>
 <2147870.1668582019@warthog.procyon.org.uk>
 <2780586.1668600891@warthog.procyon.org.uk>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2780586.1668600891@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QW0gMTYuMTEuMjIgdW0gMTM6MTQgc2NocmllYiBEYXZpZCBIb3dlbGxzOg0KPiBTdGVmYW4g
TWV0em1hY2hlciA8bWV0emVAc2FtYmEub3JnPiB3cm90ZToNCj4gDQo+Pj4gU3RlZmFuIE1l
dHptYWNoZXIgPG1ldHplQHNhbWJhLm9yZz4gd3JvdGU6DQo+Pj4NCj4+Pj4gSSdtIG5vdCBz
dXJlIEkgdW5kZXJzdGFuZCB3aHkgdGhpcyB3b3VsZCBmaXggYW55dGhpbmcgd2hlbiBlbmNy
eXB0aW9uIGlzDQo+Pj4+IGVuYWJsZWQuDQo+Pj4+DQo+Pj4+IElzIHRoZSBwYXlsb2FkIHN0
aWxsIGJlIG9mZmxvYWRlZCBhcyBwbGFpbnRleHQ/IE90aGVyd2lzZSB3ZSB3b3VsZG4ndCBo
YXZlDQo+Pj4+IHVzZV9yZG1hX21yLi4uICBTbyB0aGlzIHJhdGhlciBsb29rcyBsaWtlIGEg
Zml4IGZvciB0aGUgbm9uIGVuY3J5cHRlZCBjYXNlLg0KPj4+IFRoZSAiaW5saW5lIlsqXSBQ
RFVzIGFyZSBlbmNyeXB0ZWQsIGJ1dCB0aGUgZGlyZWN0IFJETUEgZGF0YSB0cmFuc21pc3Np
b24gaXMNCj4+PiBub3QuICBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBhIGJ1ZyBpbiBrc21i
ZC4NCj4+DQo+PiBJdCdzIGEgYnVnIGluIHRoZSBjbGllbnQhDQo+IA0KPiBXZWxsLCBpZiB5
b3UgY2FuIGZpeCBpdCB0aGUgcmlnaHQgd2F5LCBJIGNhbiB0ZXN0IHRoZSBwYXRjaC4gIEkn
bSBub3Qgc3VyZQ0KPiB3aGF0IHRoYXQgd291bGQgYmUgaWYgbm90IHdoYXQgSSBzdWdnZXN0
ZWQuDQoNCkFzIHdyaXR0ZW4gaW4gdGhlIG90aGVyIG1haWwgc29tZXRoaW5nIGxpa2UgdGhp
czoNCg0KICBmcy9jaWZzL3NtYjJwZHUuYyB8IDYgKysrLS0tDQogIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9j
aWZzL3NtYjJwZHUuYyBiL2ZzL2NpZnMvc21iMnBkdS5jDQppbmRleCBhNTY5NTc0OGE4OWIu
LmQ0NzhiMGE4OTg5MCAxMDA2NDQNCi0tLSBhL2ZzL2NpZnMvc21iMnBkdS5jDQorKysgYi9m
cy9jaWZzL3NtYjJwZHUuYw0KQEAgLTQwOTAsNyArNDA5MCw3IEBAIHNtYjJfbmV3X3JlYWRf
cmVxKHZvaWQgKipidWYsIHVuc2lnbmVkIGludCAqdG90YWxfbGVuLA0KICAJICogSWYgd2Ug
d2FudCB0byBkbyBhIFJETUEgd3JpdGUsIGZpbGwgaW4gYW5kIGFwcGVuZA0KICAJICogc21i
ZF9idWZmZXJfZGVzY3JpcHRvcl92MSB0byB0aGUgZW5kIG9mIHJlYWQgcmVxdWVzdA0KICAJ
ICovDQotCWlmIChzZXJ2ZXItPnJkbWEgJiYgcmRhdGEgJiYgIXNlcnZlci0+c2lnbiAmJg0K
KwlpZiAoc2VydmVyLT5yZG1hICYmIHJkYXRhICYmICFzZXJ2ZXItPnNpZ24gJiYgIXNtYjNf
ZW5jcnlwdGlvbl9yZXF1aXJlZChpb19wYXJtcy0+dGNvbikgJiYNCiAgCQlyZGF0YS0+Ynl0
ZXMgPj0gc2VydmVyLT5zbWJkX2Nvbm4tPnJkbWFfcmVhZHdyaXRlX3RocmVzaG9sZCkgew0K
DQogIAkJc3RydWN0IHNtYmRfYnVmZmVyX2Rlc2NyaXB0b3JfdjEgKnYxOw0KQEAgLTQ1MTcs
OCArNDUxNyw4IEBAIHNtYjJfYXN5bmNfd3JpdGV2KHN0cnVjdCBjaWZzX3dyaXRlZGF0YSAq
d2RhdGEsDQogIAkgKiBJZiB3ZSB3YW50IHRvIGRvIGEgc2VydmVyIFJETUEgcmVhZCwgZmls
bCBpbiBhbmQgYXBwZW5kDQogIAkgKiBzbWJkX2J1ZmZlcl9kZXNjcmlwdG9yX3YxIHRvIHRo
ZSBlbmQgb2Ygd3JpdGUgcmVxdWVzdA0KICAJICovDQotCWlmIChzZXJ2ZXItPnJkbWEgJiYg
IXNlcnZlci0+c2lnbiAmJiB3ZGF0YS0+Ynl0ZXMgPj0NCi0JCXNlcnZlci0+c21iZF9jb25u
LT5yZG1hX3JlYWR3cml0ZV90aHJlc2hvbGQpIHsNCisJaWYgKHNlcnZlci0+cmRtYSAmJiAh
c2VydmVyLT5zaWduICYmICFzbWIzX2VuY3J5cHRpb25fcmVxdWlyZWQodGNvbikgJiYNCisJ
CXdkYXRhLT5ieXRlcyA+PSBzZXJ2ZXItPnNtYmRfY29ubi0+cmRtYV9yZWFkd3JpdGVfdGhy
ZXNob2xkKSB7DQoNCiAgCQlzdHJ1Y3Qgc21iZF9idWZmZXJfZGVzY3JpcHRvcl92MSAqdjE7
DQogIAkJYm9vbCBuZWVkX2ludmFsaWRhdGUgPSBzZXJ2ZXItPmRpYWxlY3QgPT0gU01CMzBf
UFJPVF9JRDsNCg0KDQo=
