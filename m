Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1836D89EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjDEV6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 17:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbjDEV6t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:58:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001EB7DB6
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Apr 2023 14:58:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id pt5-20020a17090b3d0500b0023d3ffe542fso2549695pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Apr 2023 14:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680731925;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH39ss5xMXY6Gj7ki1Ay0DF53+qf6gIKCW6Lh2mhinY=;
        b=fl4rR6NjYHEvN26i5qIhp/k/+mnyLHXHU7i1ans1u8NvI4HueaIFWpA3AVY+kWpqlY
         +stxTYRLVOmZ3M7bgZqspbaxmUXimB5S0QWj6YfAyYP336LLt9g1tFm1ja7OeRIX4A4M
         Ag46kp5ZRpZeMtE7ri9m5g2Ar4T/7pM0T6dQNfwrmWF3ypbHoXNRhe1Mwrgm6OxGHY+f
         LtBhG7LwbIq8LrNHCL+4OT7px9kggF9jxd9G4PrhjjcFH3IasVJtbBJ+ValbH7Ijk0oq
         s5lInx/h+L/py4DQ0XPdO31iZmD9LXoL2zZCKSAQmZfXM2E7Dpzk6aiv7vJOfqCT79l3
         2NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731925;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IH39ss5xMXY6Gj7ki1Ay0DF53+qf6gIKCW6Lh2mhinY=;
        b=X7Wvf1BcgfmVdyzor9pYiSbjGKw8yqTu4huFbjStDpmqxVR6HmdtsTYdMC1ZI2C1Fy
         8qZAdLx4Aj6jJ9oiGmG91BNc8ixHY9SZyXRe6SXFVJLl797vro3EMuoHQlvPvlUVoY0u
         4aXy9V86rw5NQJ3jxfZv/obZY4voNsW0H2Z9z6j5uyPMPOQfCQ+6EL5N0nN7uL4QE6mw
         MV2G8U2+4FFA3CLY2A3XgciabJf44lbMyVr2mKznk31yqFkdL0k4kChPAxTKitFhp3G2
         UYkK+4+8ytvPUpXvjxdgXTqVGMsrX0oo7wAV34ynaKFtpnasJ99hDOON/LD6WJiDEw8c
         d40Q==
X-Gm-Message-State: AAQBX9dM/CUzHz8psbn0Ul9cwhLf5WPCdjK9aWncoJP59AIOGh38Y4U3
        soyXpgDo6/cMAU1Re/2gi8+IjGWApN8qVm8Sng==
X-Google-Smtp-Source: AKy350ZJUWZ5Rl/GpINT0zpkMK0Co9fgJF9D7GrDpVPU5XGGiprYOuPIu+FpLfj3UdpQyRl7vruHxGy0dempp9jmyA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:8c82:b0:1a1:c523:a9bd with
 SMTP id t2-20020a1709028c8200b001a1c523a9bdmr3229562plo.0.1680731925439; Wed,
 05 Apr 2023 14:58:45 -0700 (PDT)
Date:   Wed, 05 Apr 2023 21:58:44 +0000
In-Reply-To: <20230404-engraved-rumble-d871e0403f3b@brauner> (message from
 Christian Brauner on Tue, 4 Apr 2023 16:58:34 +0200)
Mime-Version: 1.0
Message-ID: <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
From:   Ackerley Tng <ackerleytng@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQpUaGFua3MgYWdhaW4gZm9yIHlvdXIgcmV2aWV3IQ0KDQpDaHJpc3RpYW4gQnJhdW5lciA8YnJh
dW5lckBrZXJuZWwub3JnPiB3cml0ZXM6DQo+IE9uIFR1ZSwgQXByIDA0LCAyMDIzIGF0IDAzOjUz
OjEzUE0gKzAyMDAsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPj4gT24gRnJpLCBNYXIgMzEs
IDIwMjMgYXQgMTE6NTA6MzlQTSArMDAwMCwgQWNrZXJsZXkgVG5nIHdyb3RlOg0KPj4gPg0KPj4g
PiAuLi4NCj4+ID4NCj4+ID4gLVNZU0NBTExfREVGSU5FMShtZW1mZF9yZXN0cmljdGVkLCB1bnNp
Z25lZCBpbnQsIGZsYWdzKQ0KPj4gPiArc3RhdGljIGludCByZXN0cmljdGVkbWVtX2NyZWF0ZShz
dHJ1Y3QgdmZzbW91bnQgKm1vdW50KQ0KPj4gPiAgew0KPj4gPiAgCXN0cnVjdCBmaWxlICpmaWxl
LCAqcmVzdHJpY3RlZF9maWxlOw0KPj4gPiAgCWludCBmZCwgZXJyOw0KPj4gPg0KPj4gPiAtCWlm
IChmbGFncykNCj4+ID4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+PiA+IC0NCj4+ID4gIAlmZCA9IGdl
dF91bnVzZWRfZmRfZmxhZ3MoMCk7DQoNCj4+IEFueSByZWFzb25zIHRoZSBmaWxlIGRlc2NyaXB0
b3JzIGFyZW4ndCBPX0NMT0VYRUMgYnkgZGVmYXVsdD8gSSBkb24ndA0KPj4gc2VlIGFueSByZWFz
b25zIHdoeSB3ZSBzaG91bGQgaW50cm9kdWNlIG5ldyBmZHR5cGVzIHRoYXQgYXJlbid0DQo+PiBP
X0NMT0VYRUMgYnkgZGVmYXVsdC4gVGhlICJkb24ndCBtaXgtYW5kLW1hdGNoIiB0cmFpbiBoYXMg
YWxyZWFkeSBsZWZ0DQo+PiB0aGUgc3RhdGlvbiBhbnl3YXkgYXMgd2UgZG8gaGF2ZSBzZWNjb21w
IG5vaXRpZmVyIGZkcyBhbmQgcGlkZmRzIGJvdGggb2YNCj4+IHdoaWNoIGFyZSBPX0NMT0VYRUMg
YnkgZGVmYXVsdC4NCg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIGFncmVlIHdp
dGggdXNpbmcgT19DTE9FWEVDLCBidXQgZGlkbuKAmXQNCm5vdGljZSB0aGlzIGJlZm9yZS4gTGV0
IHVzIGRpc2N1c3MgdGhpcyB1bmRlciB0aGUgb3JpZ2luYWwgc2VyaWVzIGF0DQpbMV0uDQoNCj4+
ID4gIAlpZiAoZmQgPCAwKQ0KPj4gPiAgCQlyZXR1cm4gZmQ7DQo+PiA+DQo+PiA+IC0JZmlsZSA9
IHNobWVtX2ZpbGVfc2V0dXAoIm1lbWZkOnJlc3RyaWN0ZWRtZW0iLCAwLCBWTV9OT1JFU0VSVkUp
Ow0KPj4gPiArCWlmIChtb3VudCkNCj4+ID4gKwkJZmlsZSA9IHNobWVtX2ZpbGVfc2V0dXBfd2l0
aF9tbnQobW91bnQsICJtZW1mZDpyZXN0cmljdGVkbWVtIiwgMCwgIA0KPj4gVk1fTk9SRVNFUlZF
KTsNCj4+ID4gKwllbHNlDQo+PiA+ICsJCWZpbGUgPSBzaG1lbV9maWxlX3NldHVwKCJtZW1mZDpy
ZXN0cmljdGVkbWVtIiwgMCwgVk1fTk9SRVNFUlZFKTsNCj4+ID4gKw0KPj4gPiAgCWlmIChJU19F
UlIoZmlsZSkpIHsNCj4+ID4gIAkJZXJyID0gUFRSX0VSUihmaWxlKTsNCj4+ID4gIAkJZ290byBl
cnJfZmQ7DQo+PiA+IEBAIC0yMjMsNiArMjI1LDY2IEBAIFNZU0NBTExfREVGSU5FMShtZW1mZF9y
ZXN0cmljdGVkLCB1bnNpZ25lZCBpbnQsICANCj4+IGZsYWdzKQ0KPj4gPiAgCXJldHVybiBlcnI7
DQo+PiA+ICB9DQo+PiA+DQo+PiA+ICtzdGF0aWMgYm9vbCBpc19zaG1lbV9tb3VudChzdHJ1Y3Qg
dmZzbW91bnQgKm1udCkNCj4+ID4gK3sNCj4+ID4gKwlyZXR1cm4gbW50ICYmIG1udC0+bW50X3Ni
ICYmIG1udC0+bW50X3NiLT5zX21hZ2ljID09IFRNUEZTX01BR0lDOw0KDQo+PiBUaGlzIGNhbiBq
dXN0IGJlIGlmIChtbnQtPm1udF9zYi0+c19tYWdpYyA9PSBUTVBGU19NQUdJQykuDQoNCg0KV2ls
bCBzaW1wbGlmeSB0aGlzIGluIHRoZSBuZXh0IHJldmlzaW9uLg0KDQo+PiA+ICt9DQo+PiA+ICsN
Cj4+ID4gK3N0YXRpYyBib29sIGlzX21vdW50X3Jvb3Qoc3RydWN0IGZpbGUgKmZpbGUpDQo+PiA+
ICt7DQo+PiA+ICsJcmV0dXJuIGZpbGUtPmZfcGF0aC5kZW50cnkgPT0gZmlsZS0+Zl9wYXRoLm1u
dC0+bW50X3Jvb3Q7DQoNCj4+IG1vdW50IC10IHRtcGZzIHRtcGZzIC9tbnQNCj4+IHRvdWNoIC9t
bnQvYmxhDQo+PiB0b3VjaCAvbW50L2JsZQ0KPj4gbW91bnQgLS1iaW5kIC9tbnQvYmxhIC9tbnQv
YmxlDQo+PiBmZCA9IG9wZW4oIi9tbnQvYmxlIikNCj4+IGZkX3Jlc3RyaWN0ZWQgPSBtZW1mZF9y
ZXN0cmljdGVkKGZkKQ0KDQo+PiBJT1csIHRoaXMgZG9lc24ndCByZXN0cmljdCBpdCB0byB0aGUg
dG1wZnMgcm9vdC4gSXQgb25seSByZXN0cmljdHMgaXQgdG8NCj4+IHBhdGhzIHRoYXQgcmVmZXIg
dG8gdGhlIHJvb3Qgb2YgYW55IHRtcGZzIG1vdW50LiBUbyBleGNsdWRlIGJpbmQtbW91bnRzDQo+
PiB0aGF0IGFyZW4ndCBiaW5kLW1vdW50cyBvZiB0aGUgd2hvbGUgZmlsZXN5c3RlbSB5b3Ugd2Fu
dDoNCg0KPj4gcGF0aC0+ZGVudHJ5ID09IHBhdGgtPm1udC0+bW50X3Jvb3QgJiYNCj4+IHBhdGgt
Pm1udC0+bW50X3Jvb3QgPT0gcGF0aC0+bW50LT5tbnRfc2ItPnNfcm9vdA0KDQoNCldpbGwgYWRv
cHQgdGhpcyBpbiB0aGUgbmV4dCByZXZpc2lvbiBhbmQgYWRkIGEgc2VsZnRlc3QgdG8gY2hlY2sN
CnRoaXMuIFRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQhDQoNCj4+ID4gK30NCj4+ID4gKw0K
Pj4gPiArc3RhdGljIGludCByZXN0cmljdGVkbWVtX2NyZWF0ZV9vbl91c2VyX21vdW50KGludCBt
b3VudF9mZCkNCj4+ID4gK3sNCj4+ID4gKwlpbnQgcmV0Ow0KPj4gPiArCXN0cnVjdCBmZCBmOw0K
Pj4gPiArCXN0cnVjdCB2ZnNtb3VudCAqbW50Ow0KPj4gPiArDQo+PiA+ICsJZiA9IGZkZ2V0X3Jh
dyhtb3VudF9mZCk7DQo+PiA+ICsJaWYgKCFmLmZpbGUpDQo+PiA+ICsJCXJldHVybiAtRUJBREY7
DQo+PiA+ICsNCj4+ID4gKwlyZXQgPSAtRUlOVkFMOw0KPj4gPiArCWlmICghaXNfbW91bnRfcm9v
dChmLmZpbGUpKQ0KPj4gPiArCQlnb3RvIG91dDsNCj4+ID4gKw0KPj4gPiArCW1udCA9IGYuZmls
ZS0+Zl9wYXRoLm1udDsNCj4+ID4gKwlpZiAoIWlzX3NobWVtX21vdW50KG1udCkpDQo+PiA+ICsJ
CWdvdG8gb3V0Ow0KPj4gPiArDQo+PiA+ICsJcmV0ID0gZmlsZV9wZXJtaXNzaW9uKGYuZmlsZSwg
TUFZX1dSSVRFIHwgTUFZX0VYRUMpOw0KDQo+PiBXaXRoIHRoZSBjdXJyZW50IHNlbWFudGljcyB5
b3UncmUgYXNraW5nIHdoZXRoZXIgeW91IGhhdmUgd3JpdGUNCj4+IHBlcm1pc3Npb25zIG9uIHRo
ZSAvbW50L2JsZSBmaWxlIGluIG9yZGVyIHRvIGdldCBhbnN3ZXIgdG8gdGhlIHF1ZXN0aW9uDQo+
PiB3aGV0aGVyIHlvdSdyZSBhbGxvd2VkIHRvIGNyZWF0ZSBhbiB1bmxpbmtlZCByZXN0cmljdGVk
IG1lbW9yeSBmaWxlLg0KPj4gVGhhdCBkb2Vzbid0IG1ha2UgbXVjaCBzZW5zZSBhZmFpY3QuDQoN
Cg0KVGhhdCdzIHRydWUuIFNpbmNlIG1udF93YW50X3dyaXRlKCkgYWxyZWFkeSBjaGVja3MgZm9y
IHdyaXRlIHBlcm1pc3Npb25zDQphbmQgdGhpcyBzeXNjYWxsIGNyZWF0ZXMgYW4gdW5saW5rZWQg
ZmlsZSBvbiB0aGUgbW91bnQsIHdlIGRvbid0IGhhdmUgdG8NCmNoZWNrIHBlcm1pc3Npb25zIG9u
IHRoZSBmaWxlIHRoZW4uIFdpbGwgcmVtb3ZlIHRoaXMgaW4gdGhlIG5leHQNCnJldmlzaW9uIQ0K
DQo+PiA+ICsJaWYgKHJldCkNCj4+ID4gKwkJZ290byBvdXQ7DQo+PiA+ICsNCj4+ID4gKwlyZXQg
PSBtbnRfd2FudF93cml0ZShtbnQpOw0KPj4gPiArCWlmICh1bmxpa2VseShyZXQpKQ0KPj4gPiAr
CQlnb3RvIG91dDsNCj4+ID4gKw0KPj4gPiArCXJldCA9IHJlc3RyaWN0ZWRtZW1fY3JlYXRlKG1u
dCk7DQo+PiA+ICsNCj4+ID4gKwltbnRfZHJvcF93cml0ZShtbnQpOw0KPj4gPiArb3V0Og0KPj4g
PiArCWZkcHV0KGYpOw0KPj4gPiArDQo+PiA+ICsJcmV0dXJuIHJldDsNCj4+ID4gK30NCj4+ID4g
Kw0KPj4gPiArU1lTQ0FMTF9ERUZJTkUyKG1lbWZkX3Jlc3RyaWN0ZWQsIHVuc2lnbmVkIGludCwg
ZmxhZ3MsIGludCwgbW91bnRfZmQpDQo+PiA+ICt7DQo+PiA+ICsJaWYgKGZsYWdzICYgflJNRkRf
VVNFUk1OVCkNCj4+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+PiA+ICsNCj4+ID4gKwlpZiAoZmxh
Z3MgPT0gUk1GRF9VU0VSTU5UKSB7DQoNCj4+IFdoeSBkbyB5b3UgZXZlbiBuZWVkIHRoaXMgZmxh
Zz8gSXQgc2VlbXMgdGhhdCBAbW91bnRfZmQgYmVpbmcgPCAwIGlzDQo+PiBzdWZmaWNpZW50IHRv
IGluZGljYXRlIHRoYXQgYSBuZXcgcmVzdHJpY3RlZCBtZW1vcnkgZmQgaXMgc3VwcG9zZWQgdG8g
YmUNCj4+IGNyZWF0ZWQgaW4gdGhlIHN5c3RlbSBpbnN0YW5jZS4NCg0KDQpJJ20gaG9waW5nIHRv
IGhhdmUgdGhpcyBwYXRjaCBzZXJpZXMgbWVyZ2VkIGFmdGVyIENoYW8ncyBwYXRjaCBzZXJpZXMN
CmludHJvZHVjZXMgdGhlIG1lbWZkX3Jlc3RyaWN0ZWQoKSBzeXNjYWxsIFsxXS4NCg0KVGhpcyBm
bGFnIGlzIG5lY2Vzc2FyeSB0byBpbmRpY2F0ZSB0aGUgdmFsaWRpdHkgb2YgdGhlIHNlY29uZCBh
cmd1bWVudC4NCg0KV2l0aCB0aGlzIGZsYWcsIHdlIGNhbiBkZWZpbml0aXZlbHkgcmV0dXJuIGFu
IGVycm9yIGlmIHRoZSBmZCBpcw0KaW52YWxpZCwgd2hpY2ggSSB0aGluayBpcyBhIGJldHRlciBl
eHBlcmllbmNlIGZvciB0aGUgdXNlcnNwYWNlDQpwcm9ncmFtbWVyIHRoYW4gaWYgd2UganVzdCBz
aWxlbnRseSBkZWZhdWx0IHRvIHRoZSBrZXJuZWwgbW91bnQgd2hlbiB0aGUNCmZkIHByb3ZpZGVk
IGlzIGludmFsaWQuDQoNCj4+ID4gKwkJaWYgKG1vdW50X2ZkIDwgMCkNCj4+ID4gKwkJCXJldHVy
biAtRUlOVkFMOw0KPj4gPiArDQo+PiA+ICsJCXJldHVybiByZXN0cmljdGVkbWVtX2NyZWF0ZV9v
bl91c2VyX21vdW50KG1vdW50X2ZkKTsNCj4+ID4gKwl9IGVsc2Ugew0KPj4gPiArCQlyZXR1cm4g
cmVzdHJpY3RlZG1lbV9jcmVhdGUoTlVMTCk7DQo+PiA+ICsJfQ0KPj4gPiArfQ0KDQo+PiBJIGhh
dmUgdG8gc2F5IHRoYXQgSSdtIHZlcnkgY29uZnVzZWQgYnkgYWxsIG9mIHRoaXMgdGhlIG1vcmUg
SSBsb29rIGF0ICANCj4+IGl0Lg0KDQo+PiBFZmZlY3RpdmVseSBtZW1mZCByZXN0cmljdGVkIGZ1
bmN0aW9ucyBhcyBhIHdyYXBwZXIgZmlsZXN5c3RlbSBhcm91bmQNCj4+IHRoZSB0bXBmcyBmaWxl
c3lzdGVtLiBUaGlzIGlzIGJhc2ljYWxseSBhIHdlaXJkIG92ZXJsYXkgZmlsZXN5c3RlbS4NCj4+
IFlvdSdyZSBhbGxvY2F0aW5nIHRtcGZzIGZpbGVzIHRoYXQgeW91IHN0YXNoIGluIHJlc3RyaWN0
ZWRtZW0gZmlsZXMuDQo+PiBJIGhhdmUgdG8gc2F5IHRoYXQgdGhpcyBzZWVtcyB2ZXJ5IGhhY2t5
LiBJIGRpZG4ndCBnZXQgdGhpcyBhdCBhbGwgYXQNCj4+IGZpcnN0Lg0KDQo+PiBTbyB3aGF0IGRv
ZXMgdGhlIGNhbGxlciBnZXQgaWYgdGhleSBjYWxsIHN0YXR4KCkgb24gYSByZXN0cmljdGVkIG1l
bWZkPw0KPj4gRG8gdGhleSBnZXQgdGhlIGRldmljZSBudW1iZXIgb2YgdGhlIHRtcGZzIG1vdW50
IGFuZCB0aGUgaW5vZGUgbnVtYmVycw0KPj4gb2YgdGhlIHRtcGZzIG1vdW50PyBCZWNhdXNlIGl0
IGxvb2tzIGxpa2UgdGhleSB3b3VsZDoNCg0KPj4gc3RhdGljIGludCByZXN0cmljdGVkbWVtX2dl
dGF0dHIoc3RydWN0IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLA0KPj4gCQkJCSBjb25zdCBz
dHJ1Y3QgcGF0aCAqcGF0aCwgc3RydWN0IGtzdGF0ICpzdGF0LA0KPj4gCQkJCSB1MzIgcmVxdWVz
dF9tYXNrLCB1bnNpZ25lZCBpbnQgcXVlcnlfZmxhZ3MpDQo+PiB7DQo+PiAJc3RydWN0IGlub2Rl
ICppbm9kZSA9IGRfaW5vZGUocGF0aC0+ZGVudHJ5KTsNCj4+IAlzdHJ1Y3QgcmVzdHJpY3RlZG1l
bSAqcm0gPSBpbm9kZS0+aV9tYXBwaW5nLT5wcml2YXRlX2RhdGE7DQo+PiAJc3RydWN0IGZpbGUg
Km1lbWZkID0gcm0tPm1lbWZkOw0KDQo+PiAJcmV0dXJuIG1lbWZkLT5mX2lub2RlLT5pX29wLT5n
ZXRhdHRyKG1udF91c2VybnMsIHBhdGgsIHN0YXQsDQoNCj4gVGhpcyBpcyBwcmV0dHkgYnJva2Vu
IGJ0dywgYmVjYXVzZSBAcGF0aCByZWZlcnMgdG8gYSByZXN0cmljdGVkbWVtIHBhdGgNCj4gd2hp
Y2ggeW91J3JlIHBhc3NpbmcgdG8gYSB0bXBmcyBpb3AuLi4NCg0KPiBJIHNlZSB0aGF0IGluDQoN
Cj4gCXJldHVybiBtZW1mZC0+Zl9pbm9kZS0+aV9vcC0+Z2V0YXR0cihtbnRfdXNlcm5zLCAmbWVt
ZmQtPmZfcGF0aCwgc3RhdCwNCj4gCQkJCQkgICAgIHJlcXVlc3RfbWFzaywgcXVlcnlfZmxhZ3Mp
Ow0KDQo+IHRoaXMgaWYgZml4ZWQgYnV0IHN0aWxsLCB0aGlzIGlzLi4uIG5vdCBncmVhdC4NCg0K
DQpUaGFua3MsIHRoaXMgd2lsbCBiZSBmaXhlZCBpbiB0aGUgbmV4dCByZXZpc2lvbiBieSByZWJh
c2luZyBvbiBDaGFvJ3MNCmxhdGVzdCBjb2RlLg0KDQo+PiAJCQkJCSAgICAgcmVxdWVzdF9tYXNr
LCBxdWVyeV9mbGFncyk7DQoNCj4+IFRoYXQgQG1lbWZkIHdvdWxkIGJlIGEgc3RydWN0IGZpbGUg
YWxsb2NhdGVkIGluIGEgdG1wZnMgaW5zdGFuY2UsIG5vPyBTbw0KPj4geW91J2QgYmUgY2FsbGlu
ZyB0aGUgaW5vZGUgb3BlcmF0aW9uIG9mIHRoZSB0bXBmcyBmaWxlIG1lYW5pbmcgdGhhdA0KPj4g
c3RydWN0IGtzdGF0IHdpbGwgYmUgZmlsbGVkIHVwIHdpdGggdGhlIGluZm8gZnJvbSB0aGUgdG1w
ZnMgaW5zdGFuY2UuDQoNCj4+IEJ1dCB0aGVuIGlmIEkgY2FsbCBzdGF0ZnMoKSBhbmQgY2hlY2sg
dGhlIGZzdHlwZSBJIHdvdWxkIGdldA0KPj4gUkVTVFJJQ1RFRE1FTV9NQUdJQywgbm8/IFRoaXMg
aXMuLi4gdW5vcnRob2RveD8NCg0KPj4gSSdtIGhvbmVzdGx5IHB1enpsZWQgYW5kIHRoaXMgc291
bmRzIHJlYWxseSBzdHJhbmdlLiBUaGVyZSBtdXN0IGJlIGENCj4+IGJldHRlciB3YXkgdG8gaW1w
bGVtZW50IGFsbCBvZiB0aGlzLg0KDQo+PiBTaG91bGRuJ3QgeW91IHRyeSBhbmQgbWFrZSB0aGlz
IGEgcGFydCBvZiB0bXBmcyBwcm9wZXI/IE1ha2UgYSByZWFsbHkNCj4+IHNlcGFyYXRlIGZpbGVz
eXN0ZW0gYW5kIGFkZCBhIG1lbWZzIGxpYnJhcnkgdGhhdCBib3RoIHRtcGZzIGFuZA0KPj4gcmVz
dHJpY3RlZG1lbWZzIGNhbiB1c2U/IEFkZCBhIG1vdW50IG9wdGlvbiB0byB0bXBmcyB0aGF0IG1h
a2VzIGl0IGENCj4+IHJlc3RyaWN0ZWQgdG1wZnM/DQoNClRoaXMgd2FzIGRpc2N1c3NlZCBlYXJs
aWVyIGluIHRoZSBwYXRjaCBzZXJpZXMgaW50cm9kdWNpbmcNCm1lbWZkX3Jlc3RyaWN0ZWQgYW5k
IHRoaXMgYXBwcm9hY2ggd2FzIHRha2VuIHRvIGJldHRlciBtYW5hZ2Ugb3duZXJzaGlwDQpvZiBy
ZXF1aXJlZCBmdW5jdGlvbmFsaXRpZXMgYmV0d2VlbiB0d28gc3Vic3lzdGVtcy4gUGxlYXNlIHNl
ZQ0KZGlzY3Vzc2lvbiBiZWdpbm5pbmcgWzJdDQoNClsxXSAtPiAgDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjIxMjAyMDYxMzQ3LjEwNzAyNDYtMS1jaGFvLnAucGVuZ0BsaW51eC5p
bnRlbC5jb20vVC8uDQpbMl0gLT4gIA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9mZjVj
NWI5Ny1hY2RmLTk3NDUtZWJlNS1jNjYwOWRkNjMyMmVAZ29vZ2xlLmNvbS8NCg==
