Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF673626B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 19:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfFERZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 13:25:11 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:46357 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfFERZL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:25:11 -0400
Received: by mail-lj1-f169.google.com with SMTP id m15so15595975ljg.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dzrfT5QqLGh7VEyZ93DmM/B2JbZO0W27MdQC2tlHrw=;
        b=FKQTQdRiCtVECI1Ss50LEAri2FoYB4zuECl4MbKr7V1HG+/fgvFHO/XCFc4PclJL0f
         Wssk8CHwAJzxGg8oxI5A8N0uaT7yA0hPAHDf6vPUxygAINx56WVYQJa7UQsGrz55oPcZ
         ZbjDGAg20qL59d3Au7EHam6sThq+5CJLZeVEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dzrfT5QqLGh7VEyZ93DmM/B2JbZO0W27MdQC2tlHrw=;
        b=fdm6L95Zm/FB9p/fHVmOdZvGxt/BxdN8/sqX5jHKW7CMFo0vT7DUI3GkcC7CRPG/Tn
         vcnwP5Fw7IOuTKRyXhmPlM5ETxTQFSTCEgyb2ZuOofuH1FIaf8lxuDW3imPj5ZbircFw
         aBLcxEixg1Wf/2KUnsCGrhSRlrSwohN41H1hp/VY8P8xMFAv5Omj+BG5adZTsg/Yne1s
         kQsrSmyiN6vwzGp7p6+fWRuVqORQRhP/p7bG1t31HHjnL1WBWgGFt+UAthgem4Kqc2TX
         0PN0msM7KOPufhTWpZt6L87qGtoRfMLOCMkfMM7eIzeaFOsPpwFiTCbnbeeDRbWibjUu
         WHuw==
X-Gm-Message-State: APjAAAXGHwFW5uWG9Uat/l8LTr2Xwjoju1DJyMDie40OznrbTrKQp0U7
        BJWM2m9GYWyt/RN8zHmSSfw6xoOOECY=
X-Google-Smtp-Source: APXvYqxy1WU/sWfhxpEMOZ+hUcV6ZbcYTekHfgqG3AXRvVY4dCRMZpCnBIKSnzRWeEnUkI4l/aCSoA==
X-Received: by 2002:a2e:9112:: with SMTP id m18mr22646137ljg.181.1559755508549;
        Wed, 05 Jun 2019 10:25:08 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z17sm1681801ljc.37.2019.06.05.10.25.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:25:04 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id r15so19685963lfm.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2019 10:25:04 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr7944437lfd.106.1559755503740;
 Wed, 05 Jun 2019 10:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com>
 <20190529161157.GA27659@redhat.com> <20190604134117.GA29963@redhat.com> <20190605155801.GA25165@redhat.com>
In-Reply-To: <20190605155801.GA25165@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jun 2019 10:24:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkNx8u4Mcm5dfSQKYQmLQAv1Z1yGLDZvty7BVSj4eqBA@mail.gmail.com>
Message-ID: <CAHk-=wjkNx8u4Mcm5dfSQKYQmLQAv1Z1yGLDZvty7BVSj4eqBA@mail.gmail.com>
Subject: Re: [PATCH -mm 0/1] signal: simplify set_user_sigmask/restore_user_sigmask
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dbueso@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Davidlohr Bueso <dave@stgolabs.net>, e@80x24.org,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, omar.kilani@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        stable <stable@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Laight <David.Laight@aculab.com>
Content-Type: multipart/mixed; boundary="000000000000bcd942058a96e0bf"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000bcd942058a96e0bf
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 5, 2019 at 8:58 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> To simplify the review, please see the code with this patch applied.
> I am using epoll_pwait() as an example because it looks very simple.

I like it.

However.

I think I'd like it even more if we just said "we don't need
restore_saved_sigmask AT ALL".

Which would be fairly easy to do with something like the attached...

(Yes, this only does x86, which is a problem, but I'm bringing this up
as a RFC..)

Is it worth another TIF flag? This sure would simplify things, and it
really fits the concept too: this really is a do_signal() issue, and
fundamentally goes together with TIF_SIGPENDING.

                Linus

--000000000000bcd942058a96e0bf
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jwji3ph10>
X-Attachment-Id: f_jwji3ph10

IGFyY2gveDg2L2VudHJ5L2NvbW1vbi5jICAgICAgICAgICAgfCAyICstCiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS90aHJlYWRfaW5mby5oIHwgMiArKwoga2VybmVsL3NpZ25hbC5jICAgICAgICAgICAg
ICAgICAgICB8IDEgKwogMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYyBiL2FyY2gveDg2L2Vu
dHJ5L2NvbW1vbi5jCmluZGV4IGE5ODZiM2M4Mjk0Yy4uZWI1MzhlY2Q2NjAzIDEwMDY0NAotLS0g
YS9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYworKysgYi9hcmNoL3g4Ni9lbnRyeS9jb21tb24uYwpA
QCAtMTYwLDcgKzE2MCw3IEBAIHN0YXRpYyB2b2lkIGV4aXRfdG9fdXNlcm1vZGVfbG9vcChzdHJ1
Y3QgcHRfcmVncyAqcmVncywgdTMyIGNhY2hlZF9mbGFncykKIAkJCWtscF91cGRhdGVfcGF0Y2hf
c3RhdGUoY3VycmVudCk7CiAKIAkJLyogZGVhbCB3aXRoIHBlbmRpbmcgc2lnbmFsIGRlbGl2ZXJ5
ICovCi0JCWlmIChjYWNoZWRfZmxhZ3MgJiBfVElGX1NJR1BFTkRJTkcpCisJCWlmIChjYWNoZWRf
ZmxhZ3MgJiAoX1RJRl9TSUdQRU5ESU5HIHwgX1RJRl9SRVNUT1JFX1NJR01BU0spKQogCQkJZG9f
c2lnbmFsKHJlZ3MpOwogCiAJCWlmIChjYWNoZWRfZmxhZ3MgJiBfVElGX05PVElGWV9SRVNVTUUp
IHsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oCmluZGV4IGY5NDUzNTM2ZjliYi4uZDc3YTlm
ODQxNDU1IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oCisr
KyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RocmVhZF9pbmZvLmgKQEAgLTkyLDYgKzkyLDcgQEAg
c3RydWN0IHRocmVhZF9pbmZvIHsKICNkZWZpbmUgVElGX05PQ1BVSUQJCTE1CS8qIENQVUlEIGlz
IG5vdCBhY2Nlc3NpYmxlIGluIHVzZXJsYW5kICovCiAjZGVmaW5lIFRJRl9OT1RTQwkJMTYJLyog
VFNDIGlzIG5vdCBhY2Nlc3NpYmxlIGluIHVzZXJsYW5kICovCiAjZGVmaW5lIFRJRl9JQTMyCQkx
NwkvKiBJQTMyIGNvbXBhdGliaWxpdHkgcHJvY2VzcyAqLworI2RlZmluZSBUSUZfUkVTVE9SRV9T
SUdNQVNLCTE4CS8qIFJlc3RvcmUgc2F2ZWQgc2lnbWFzayBvbiByZXR1cm4gdG8gdXNlciBzcGFj
ZSAqLwogI2RlZmluZSBUSUZfTk9IWgkJMTkJLyogaW4gYWRhcHRpdmUgbm9oeiBtb2RlICovCiAj
ZGVmaW5lIFRJRl9NRU1ESUUJCTIwCS8qIGlzIHRlcm1pbmF0aW5nIGR1ZSB0byBPT00ga2lsbGVy
ICovCiAjZGVmaW5lIFRJRl9QT0xMSU5HX05SRkxBRwkyMQkvKiBpZGxlIGlzIHBvbGxpbmcgZm9y
IFRJRl9ORUVEX1JFU0NIRUQgKi8KQEAgLTEyMiw2ICsxMjMsNyBAQCBzdHJ1Y3QgdGhyZWFkX2lu
Zm8gewogI2RlZmluZSBfVElGX05PQ1BVSUQJCSgxIDw8IFRJRl9OT0NQVUlEKQogI2RlZmluZSBf
VElGX05PVFNDCQkoMSA8PCBUSUZfTk9UU0MpCiAjZGVmaW5lIF9USUZfSUEzMgkJKDEgPDwgVElG
X0lBMzIpCisjZGVmaW5lIF9USUZfUkVTVE9SRV9TSUdNQVNLCSgxIDw8IFRJRl9SRVNUT1JFX1NJ
R01BU0spCiAjZGVmaW5lIF9USUZfTk9IWgkJKDEgPDwgVElGX05PSFopCiAjZGVmaW5lIF9USUZf
UE9MTElOR19OUkZMQUcJKDEgPDwgVElGX1BPTExJTkdfTlJGTEFHKQogI2RlZmluZSBfVElGX0lP
X0JJVE1BUAkJKDEgPDwgVElGX0lPX0JJVE1BUCkKZGlmZiAtLWdpdCBhL2tlcm5lbC9zaWduYWwu
YyBiL2tlcm5lbC9zaWduYWwuYwppbmRleCAzMjhhMDFlMWEyZjAuLmEzMzQ2ZGExYTRmNSAxMDA2
NDQKLS0tIGEva2VybmVsL3NpZ25hbC5jCisrKyBiL2tlcm5lbC9zaWduYWwuYwpAQCAtMjg3Nyw2
ICsyODc3LDcgQEAgaW50IHNldF91c2VyX3NpZ21hc2soY29uc3Qgc2lnc2V0X3QgX191c2VyICp1
c2lnbWFzaywgc2lnc2V0X3QgKnNldCwKIAogCSpvbGRzZXQgPSBjdXJyZW50LT5ibG9ja2VkOwog
CXNldF9jdXJyZW50X2Jsb2NrZWQoc2V0KTsKKwlzZXRfdGhyZWFkX2ZsYWcoVElGX1JFU1RPUkVf
U0lHTUFTSyk7CiAKIAlyZXR1cm4gMDsKIH0K
--000000000000bcd942058a96e0bf--
