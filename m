Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DE36FE788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEJWv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjEJWv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 18:51:57 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BEA4488;
        Wed, 10 May 2023 15:51:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f139de8cefso42789897e87.0;
        Wed, 10 May 2023 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683759113; x=1686351113;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ohs3T3NdbbBRfBPZoviqythlTyCVKHR7HNnzdiYYugg=;
        b=UZcIdCcS9GRr82mG/CdB3huJwhDoxQIzvsmnyFbvvmquGJg4EQuA2UEmpC49ODEitw
         9vAgM6uM3DM7uSpET+bjLVEqgrLIaFrHLgV6tEYyjN8qLYwRgPkoC7JddtTcss2iSn+N
         O4Ic6SZzG/SJ6mFkVy7Y0kHE49H8ECiJBGW8quvIQTrBVC0YAyJb9SkrzNfENLbL3TeY
         O9c3LRdhg18EZ7YMdJfHUi/1wnXsl9wNMDVDKXVPoUwS8Ry7klVlPUU3FVKsBHlo4nfK
         nNQuv2lX7qaQeap8/ZF0KD+c3nXN6fBBoY585/0v9PCIq7xZk6Lp7ExMDTnvLSAK2+RC
         Fevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683759113; x=1686351113;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ohs3T3NdbbBRfBPZoviqythlTyCVKHR7HNnzdiYYugg=;
        b=fnFoHsww106QeMPSZB/ZXBujYJxQskHgzYX3LgWlS9olFXgVrc3VcKjMBzhSoW2f/E
         dUWvzDhQgBmzxBFj2hWFL+lxzW2/ZASHVxVin3AZngrh0eh2g2gOY0lZVqBYdGWmJ9KG
         Rsjii6tpjOAA+BMaATXIjxGDj3pAlldmWvPj6ntzC1VDalUuKyI8l3O9tVoD8a8B5AA1
         NSmtY4jMzGtuiMwxO1lZCi+hzEiEP1IA0e8VoQt25vuT0PzAA+mMU5YcVG9glWXHryRX
         qZaiyn6rr8CU4XU8gpybX1SUJh6Oi/jq19HzIlFk+begBt8g6fwJtIUPwA9iGEuqGcoW
         0j+w==
X-Gm-Message-State: AC+VfDz7kdFLCHBfCy7OhneP51dzkr8bHDmdq8UbfrRCo106gA5STdIi
        kPrtq0uIGTFODeKM2zAqxFAvZkMKuNQiT3Xb6SCahfDBNkcb/eJR
X-Google-Smtp-Source: ACHHUZ6pFQA0UQwdD2HgKoqbtWxg3G+c05xilomwWIM3CxOrp3RcYZSBfnwod4YVRpJnf3J/cH3r1pgeRS3YN/Dz05k=
X-Received: by 2002:a05:6512:2806:b0:4eb:4258:bf62 with SMTP id
 cf6-20020a056512280600b004eb4258bf62mr1882701lfb.8.1683759113049; Wed, 10 May
 2023 15:51:53 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 10 May 2023 17:51:41 -0500
Message-ID: <CAH2r5mtcjLkmWqRTZnZaXzvXZWHka_73nN1nSq0a=KQZ4hA4eA@mail.gmail.com>
Subject: [PATCH] cifs: release leases for deferred close handles when freezing
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d22d8205fb5eb705"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000d22d8205fb5eb705
Content-Type: text/plain; charset="UTF-8"

We should not be caching closed files when freeze is invoked on an fs
so we can release resources more gracefully).

Fixes xfstests generic/068 generic/390 generic/491

See attached.




-- 
Thanks,

Steve

--000000000000d22d8205fb5eb705
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-release-leases-for-deferred-close-handles-when-.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-release-leases-for-deferred-close-handles-when-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lhiaozqt0>
X-Attachment-Id: f_lhiaozqt0

RnJvbSBkMzlmYzU5MmVmOGFlOWE4OWM1ZTg1YzhkOWY3NjA5MzdhNTdkNWJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMTAgTWF5IDIwMjMgMTc6NDI6MjEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiByZWxlYXNlIGxlYXNlcyBmb3IgZGVmZXJyZWQgY2xvc2UgaGFuZGxlcyB3aGVuIGZyZWV6
aW5nCgpXZSBzaG91bGQgbm90IGJlIGNhY2hpbmcgY2xvc2VkIGZpbGVzIHdoZW4gZnJlZXplIGlz
IGludm9rZWQgb24gYW4gZnMKKHNvIHdlIGNhbiByZWxlYXNlIHJlc291cmNlcyBtb3JlIGdyYWNl
ZnVsbHkpLgoKRml4ZXMgeGZzdGVzdHMgZ2VuZXJpYy8wNjggZ2VuZXJpYy8zOTAgZ2VuZXJpYy80
OTEKClJldmlld2VkLWJ5OiBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPgpDYzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3Rm
cmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNmcy5jIHwgMTUgKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2Zz
L2NpZnMvY2lmc2ZzLmMgYi9mcy9jaWZzL2NpZnNmcy5jCmluZGV4IDhiNmIzYjY5ODVmMy4uNDNh
NGQ4NjAzZGIzIDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNmcy5jCisrKyBiL2ZzL2NpZnMvY2lm
c2ZzLmMKQEAgLTc2MCw2ICs3NjAsMjAgQEAgc3RhdGljIHZvaWQgY2lmc191bW91bnRfYmVnaW4o
c3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAlyZXR1cm47CiB9CiAKK3N0YXRpYyBpbnQgY2lmc19m
cmVlemUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKK3sKKwlzdHJ1Y3QgY2lmc19zYl9pbmZvICpj
aWZzX3NiID0gQ0lGU19TQihzYik7CisJc3RydWN0IGNpZnNfdGNvbiAqdGNvbjsKKworCWlmIChj
aWZzX3NiID09IE5VTEwpCisJCXJldHVybiAwOworCisJdGNvbiA9IGNpZnNfc2JfbWFzdGVyX3Rj
b24oY2lmc19zYik7CisKKwljaWZzX2Nsb3NlX2FsbF9kZWZlcnJlZF9maWxlcyh0Y29uKTsKKwly
ZXR1cm4gMDsKK30KKwogI2lmZGVmIENPTkZJR19DSUZTX1NUQVRTMgogc3RhdGljIGludCBjaWZz
X3Nob3dfc3RhdHMoc3RydWN0IHNlcV9maWxlICpzLCBzdHJ1Y3QgZGVudHJ5ICpyb290KQogewpA
QCAtNzk4LDYgKzgxMiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc3VwZXJfb3BlcmF0aW9ucyBj
aWZzX3N1cGVyX29wcyA9IHsKIAlhcyBvcGVucyAqLwogCS5zaG93X29wdGlvbnMgPSBjaWZzX3No
b3dfb3B0aW9ucywKIAkudW1vdW50X2JlZ2luICAgPSBjaWZzX3Vtb3VudF9iZWdpbiwKKwkuZnJl
ZXplX2ZzICAgICAgPSBjaWZzX2ZyZWV6ZSwKICNpZmRlZiBDT05GSUdfQ0lGU19TVEFUUzIKIAku
c2hvd19zdGF0cyA9IGNpZnNfc2hvd19zdGF0cywKICNlbmRpZgotLSAKMi4zNC4xCgo=
--000000000000d22d8205fb5eb705--
