Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F06A00A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 02:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjBWBcE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 20:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjBWBcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:32:02 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ED93E621
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 17:31:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id v24-20020a631518000000b00502e6bfe335so1715604pgl.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Feb 2023 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Say+6a1ZyYr+UuCKdaAjxZI4dgG3bJdQNiusmWUgqvk=;
        b=ZftMo2Jr/MYc+TnSUI/NqHqeLeV4TeeVWH0yMAlI85IeiLcuVkcU0Xi9yTYAL4Ti4N
         Pcptnd77UOE+Ubfxn8QRWMdZmWSY4akFCQf6v1PFTzO870zP5UiH0CvKAUAI60rjhMim
         A2kOh6/xUtroxJBIX+ZIQDEuJ2pVebSSpDtdCRhVuxII0dGn+QairZ/42WYH8onaX3sW
         VTadd7UYWVbVvmpPJT8zKlqq4fO8PhGLg1iNudHVb3yTAkso/TczAQYjur3wkh3ATGMq
         V9iE2XTX1+ukTikznIFKOxl8ReNuuDE+7TSPpoSVLKtc3hqyAmK9WjjTQq/mdtnRLNoK
         xRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Say+6a1ZyYr+UuCKdaAjxZI4dgG3bJdQNiusmWUgqvk=;
        b=ACZK16I6rW2c2vh6pNDsmNtSx1VOpwpQ3gCqOLt6vUf2SQ6YI5Yd4Se5jQeAswHgA8
         V9bV3Y9GMHd3ENya5eAjVWB2GTpfJLd5j6xk0N8O0AlpTZAEtQjhxqmBndm9XvEFeCgo
         +K8MtKvyJV1n8Iwvu30VLgMg9T6/mIDK06UJUeYh0YwWLzcvSEJXt/v/DBP9cUR/iddj
         GS4rExQxmIrFX7aZNAFXmCZ6/NVcbHGvgR6Eyp0kE5Ud6XTMDOAnSOSZcg62XMm6zDtJ
         aIixPO5NaJt5RLGoXaxAFz90JSAgTXVfvF0fQ6Oev/ClgScqVmGIFBnbDtRoPZJGLL/1
         X8iw==
X-Gm-Message-State: AO0yUKWvIPDdzBvBpdTregpgGgjmV0ZvOFzuTxGJulJn9CVOKUa+dGw8
        EwgLGb84EO/Yl2JqIYYO24ckHKxAgH1b8P39eg==
X-Google-Smtp-Source: AK7set8In7pASIkwc5RmcKGC5gPhzEpeOqmjGbH5z8/aZP8m2bTicadsvcxB91Z6rAsHkHh1dfvaP8X5FauAcxQlUQ==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a17:90a:49ca:b0:231:1d90:7b1b with
 SMTP id l10-20020a17090a49ca00b002311d907b1bmr79634pjm.2.1677115915638; Wed,
 22 Feb 2023 17:31:55 -0800 (PST)
Date:   Thu, 23 Feb 2023 01:31:54 +0000
In-Reply-To: <20230220030412.fgh3f5qzgihz4f4x@yy-desk-7060> (message from Yuan
 Yao on Mon, 20 Feb 2023 11:04:12 +0800)
Mime-Version: 1.0
Message-ID: <diqzk0099ng5.fsf@ackerleytng-cloudtop.c.googlers.com>
Subject: Re: [RFC PATCH 0/2] Add flag as THP allocation hint for
 memfd_restricted() syscall
From:   Ackerley Tng <ackerleytng@google.com>
To:     Yuan Yao <yuan.yao@linux.intel.com>
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WXVhbiBZYW8gPHl1YW4ueWFvQGxpbnV4LmludGVsLmNvbT4gd3JpdGVzOg0KDQo+IE9uIFNhdCwg
RmViIDE4LCAyMDIzIGF0IDEyOjQzOjAwQU0gKzAwMDAsIEFja2VybGV5IFRuZyB3cm90ZToNCj4+
IEhlbGxvLA0KDQo+PiBUaGlzIHBhdGNoc2V0IGJ1aWxkcyB1cG9uIHRoZSBtZW1mZF9yZXN0cmlj
dGVkKCkgc3lzdGVtIGNhbGwgdGhhdCBoYXMNCj4+IGJlZW4gZGlzY3Vzc2VkIGluIHRoZSDigJhL
Vk06IG1tOiBmZC1iYXNlZCBhcHByb2FjaCBmb3Igc3VwcG9ydGluZyBLVk3igJkNCj4+IHBhdGNo
IHNlcmllcywgYXQNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjEyMDIwNjEz
NDcuMTA3MDI0Ni0xLWNoYW8ucC5wZW5nQGxpbnV4LmludGVsLmNvbS9ULyNtN2U5NDRkNzg5MmFm
ZGQxZDYyYTAzYTI4N2JkNDg4YzU2ZTM3N2IwYw0KDQo+PiBUaGUgdHJlZSBjYW4gYmUgZm91bmQg
YXQ6DQo+PiBodHRwczovL2dpdGh1Yi5jb20vZ29vZ2xlcHJvZGtlcm5lbC9saW51eC1jYy90cmVl
L3Jlc3RyaWN0ZWRtZW0tcm1mZC1odWdlcGFnZQ0KDQo+PiBGb2xsb3dpbmcgdGhlIFJGQyB0byBw
cm92aWRlIG1vdW50IGZvciBtZW1mZF9yZXN0cmljdGVkKCkgc3lzY2FsbCBhdA0KPj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9jb3Zlci4xNjc2NTA3NjYzLmdpdC5hY2tlcmxleXRuZ0Bn
b29nbGUuY29tL1QvI3UsDQo+PiB0aGlzIHBhdGNoc2V0IGFkZHMgdGhlIFJNRkRfSFVHRVBBR0Ug
ZmxhZyB0byB0aGUgbWVtZmRfcmVzdHJpY3RlZCgpDQo+PiBzeXNjYWxsLCB3aGljaCB3aWxsIGhp
bnQgdGhlIGtlcm5lbCB0byB1c2UgVHJhbnNwYXJlbnQgSHVnZVBhZ2VzIHRvDQo+PiBiYWNrIHJl
c3RyaWN0ZWRtZW0gcGFnZXMuDQoNCj4+IFRoaXMgc3VwcGxlbWVudHMgdGhlIGludGVyZmFjZSBw
cm9wb3NlZCBlYXJsaWVyLCB3aGljaCByZXF1aXJlcyB0aGUNCj4+IGNyZWF0aW9uIG9mIGEgdG1w
ZnMgbW91bnQgdG8gYmUgcGFzc2VkIHRvIG1lbWZkX3Jlc3RyaWN0ZWQoKSwgd2l0aCBhDQo+PiBt
b3JlIGRpcmVjdCBwZXItZmlsZSBoaW50Lg0KDQo+PiBEZXBlbmRlbmNpZXM6DQoNCj4+ICsgU2Vh
buKAmXMgaXRlcmF0aW9uIG9mIHRoZSDigJhLVk06IG1tOiBmZC1iYXNlZCBhcHByb2FjaCBmb3Ig
c3VwcG9ydGluZw0KPj4gICAgS1ZN4oCZIHBhdGNoIHNlcmllcyBhdA0KPj4gICAgaHR0cHM6Ly9n
aXRodWIuY29tL3NlYW4tamMvbGludXgvdHJlZS94ODYvdXBtX2Jhc2Vfc3VwcG9ydA0KPj4gKyBQ
cm9wb3NlZCBmaXggZm9yIHJlc3RyaWN0ZWRtZW1fZ2V0YXR0cigpIGFzIG1lbnRpb25lZCBvbiB0
aGUgbWFpbGluZw0KPj4gICAgbGlzdCBhdA0KPj4gICAgIA0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC9kaXF6emdhMGZ2OTYuZnNmQGFja2VybGV5dG5nLWNsb3VkdG9wLXNnLmMuZ29v
Z2xlcnMuY29tLw0KPj4gKyBIdWdo4oCZcyBwYXRjaDoNCj4+ICAgICANCj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvYzE0MGY1NmEtMWFhMy1mN2FlLWI3ZDEtOTNkYTdkNWEzNTcyQGdv
b2dsZS5jb20vLA0KPj4gICAgd2hpY2ggcHJvdmlkZXMgZnVuY3Rpb25hbGl0eSBpbiBzaG1lbSB0
aGF0IHJlYWRzIHRoZSBWTV9IVUdFUEFHRQ0KPj4gICAgZmxhZyBpbiBrZXkgZnVuY3Rpb25zIHNo
bWVtX2lzX2h1Z2UoKSBhbmQgc2htZW1fZ2V0X2lub2RlKCkNCg0KPiBXaWxsIEh1Z2gncyBwYXRj
aCBiZSBtZXJnZWQgaW50byA2LjMgPyBJIGRpZG4ndCBmaW5kIGl0IGluIDYuMi1yYzguDQo+IElN
SE8gdGhpcyBwYXRjaCB3b24ndCB3b3JrIHdpdGhvdXQgSHVnaCdzIHBhdGNoLCBvciBhdCBsZWFz
dCBuZWVkDQo+IGFub3RoZXIgd2F5LCBlLmcuIEhNRU1fU0IoaW5vZGUtPmlfc2IpLT5odWdlLg0K
DQoNCkh1Z2gncyBwYXRjaCBpcyBzdGlsbCBwZW5kaW5nIGRpc2N1c3Npb24gYW5kIG1heSBub3Qg
YmUgbWVyZ2VkIHNvDQpzb29uLiBUaGVzZSBwYXRjaGVzIHdpbGwgbm90IHdvcmsgd2l0aG91dCBI
dWdoJ3MgcGF0Y2guDQoNCkkgd291bGQgbGlrZSB0byB1bmRlcnN0YW5kIHdoYXQgdGhlIGNvbW11
bml0eSB0aGlua3Mgb2YgdGhlIHByb3Bvc2VkDQppbnRlcmZhY2UgKFJNRkRfSFVHRVBBR0UgZmxh
ZywgcGFzc2VkIHRvIHRoZSBtZW1mZF9yZXN0cmljdGVkKCkNCnN5c2NhbGwpLiBJZiB0aGlzIGlu
dGVyZmFjZSBpcyBmYXZvcmFibHkgcmVjZWl2ZWQsIHdlIGNhbiBkZWZpbml0ZWx5DQpmaW5kIGFu
b3RoZXIgd2F5IGZvciBzaG1lbSB0byBzdXBwb3J0IHRoaXMgaW50ZXJmYWNlLg0KDQpJZiBJIHVu
ZGVyc3RhbmQgY29ycmVjdGx5LCBTSE1FTV9TQihpbm9kZS0+aV9zYiktPmh1Z2UgY2hlY2tzIHRo
ZSBzdGF0ZQ0Kb2YgaHVnZXBhZ2UtbmVzcyBmb3IgdGhlIHN1cGVyYmxvY2suIFNpbmNlIHRoZSBw
cm9wb3NlZCBpbnRlcmZhY2Ugd2lsbA0Kb25seSBhZmZlY3QgYSBzaW5nbGUgZmlsZSwgd2Ugd2ls
bCBuZWVkIHNvbWV0aGluZyBjbG9zZXIgdG8NCg0KICAgICBib29sIHNobWVtX2lzX2h1Z2Uoc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogICAgICAgICAg
ICAgICAgICAgICAgICBwZ29mZl90IGluZGV4LCBib29sIHNobWVtX2h1Z2VfZm9yY2UpDQogICAg
IHsNCiAgICAgICAgICAgICAuLi4NCg0KICAgICAgICAgICAgIGlmIChTSE1FTV9JKGlub2RlKS0+
ZmxhZ3MgJiBWTV9IVUdFUEFHRSkNCiAgICAgICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0K
DQogICAgICAgICAgICAgLi4uDQogICAgIH0NCg0KZnJvbSBIdWdoJ3MgcGF0Y2guDQo=
