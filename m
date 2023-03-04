Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A73D6AAC73
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 21:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjCDUfE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Mar 2023 15:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDUfC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Mar 2023 15:35:02 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F7125B8
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Mar 2023 12:35:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g3so23620212eda.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 12:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677962099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aAi+YCsVpKPnnzk0GnBiyjXJvy2HaVhZpZv9ygT8fMA=;
        b=hlcdibQc35MC/9bpJuEHSP3ivmkl0TtV6fHtd196r+07BWTuBE7Gsq2qPN9gAa3XKr
         wnQd8s0+kGP4cveRUM1nTRgtxVSkPBiAe3yaNxaRWLwf551m57oGGb313c6zK346hrss
         Pp5BIjBJB5POXKtM5zco/u3n6YW6K+YZU+qQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677962099;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aAi+YCsVpKPnnzk0GnBiyjXJvy2HaVhZpZv9ygT8fMA=;
        b=7X0z4JhcYQnWmld56sZyTGkXemD41WrBOHVprlrH06ua0BC9uZe85A6TyXhrJtfoo+
         cnwXI5t/AiYRas8PhUcaabQVRa0rGVrTmcztGq9DKgqehDDFnYYtavcArXcf1frB0mtE
         IqBr9+HQGXsY0lZo8mNfG1+4J5clgGR9baIheVAoHgBtXkzKqLZQkRQu3IYojW6qwVmW
         lOhX4FAFqAvh2qDo/9pEjNtYWfY7/O3RFZuqb+IxG7ELOYEwmLojf3dHoq7mi5qOxerP
         3VdcC7HxvTepX/pEerAi/vVYlW/9GKpO0/THzGGByDqisez1GHpt3WH79vjPGuyvKBqi
         QlSA==
X-Gm-Message-State: AO0yUKUzOSRJIhzsyc0S1x9Ct2rpcPEE/rNCVbz0QZBFlEQRXupxyF5u
        dDvWH6KK+L5U1cSE5SVriAV90b55Mmtd/qwXNYgOOw==
X-Google-Smtp-Source: AK7set/UjWP7IJKS/9eYzeRZTLB/fr7QbiT+VHTXuhCblt8I0N5N9lcwgMdzNvH2DS+1pn4s37ZopQ==
X-Received: by 2002:a17:906:ee82:b0:8b1:304e:589e with SMTP id wt2-20020a170906ee8200b008b1304e589emr8149924ejb.53.1677962098753;
        Sat, 04 Mar 2023 12:34:58 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id gu21-20020a170906f29500b008e8e9859905sm2379192ejb.184.2023.03.04.12.34.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 12:34:58 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x3so23413274edb.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Mar 2023 12:34:57 -0800 (PST)
X-Received: by 2002:a17:906:4997:b0:877:7480:c75d with SMTP id
 p23-20020a170906499700b008777480c75dmr2812536eju.0.1677962097474; Sat, 04 Mar
 2023 12:34:57 -0800 (PST)
MIME-Version: 1.0
References: <ZAEC3LN6oUe6BKSN@ZenIV> <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
 <ZAK6Duaf4mlgpZPP@yury-laptop> <CAHk-=wh1r3KfATA-JSdt3qt2y3sC=5U9+wZsbabW+dvPsqRCvA@mail.gmail.com>
 <ZALcbQoKA7K8k2gJ@yury-laptop> <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjit4tstX3q4DkiYLTD6zet_7j=CfjbvTMqtnOwmY7jzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 12:34:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=r90oceVeUyso_5rf=U3UUjY+7WdByLZkR4iAnsuMYg@mail.gmail.com>
Message-ID: <CAHk-=wg=r90oceVeUyso_5rf=U3UUjY+7WdByLZkR4iAnsuMYg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c4a89e05f618fe23"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000c4a89e05f618fe23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 4, 2023 at 11:19=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Rather than commit aa47a7c215e7, we should just have fixed 'setall()'
> and 'for_each_cpu()' to use nr_cpu_ids, and then the rest would
> continue to use nr_cpumask_bits.

Looking around, there's a few more "might set high bits in the
bitmask" cases - notably cpumask_complement(). It uses
bitmap_complement(), which in turn can set bits past the end of the
bit range.

Of course, that function is then used in exactly one place (ia64 ACPI):

        cpumask_complement(&tmp_map, cpu_present_mask);
        cpu =3D cpumask_first(&tmp_map);

it's basically a nasty way or writing

        cpu =3D cpumask_first_zero(cpu_present_mask);

so the "fix" is to just do that cleanup, and get rid of
"cpumask_complement()" entirely.

So I would suggest we simply do something like the attached patch.

NOTE! This is *entirely* untested. See the _intent_ behind the patch
in the big comment above the 'nr_cpumask_bits' #define.

So this patch is more of a "maybe something like this?"

And no, nothing here helps the MAXSMP case. I don't think it's
entirely unfixable, but it's close. Some very involved static jump
infrastructure *might* make the MAXSMP case be something we could
generate good code for too, but the whole "we potentially have
thousands of CPUs" case really shouldn't have ever been used on normal
machines.

It is what it is. I think the best we can do is to try to generate
good code for a distribution that cares about good code. Once the
distro maintainers go "let's enable MAXSMP even though the kernel
Kconfig help file tells us not to", there's very little we as kernel
maintainers can do.

                   Linus

--000000000000c4a89e05f618fe23
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_leuf7qia0>
X-Attachment-Id: f_leuf7qia0

IGFyY2gvaWE2NC9rZXJuZWwvYWNwaS5jIHwgIDQgKy0tLQogaW5jbHVkZS9saW51eC9jcHVtYXNr
LmggfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
CiAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDI2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2FyY2gvaWE2NC9rZXJuZWwvYWNwaS5jIGIvYXJjaC9pYTY0L2tlcm5lbC9hY3Bp
LmMKaW5kZXggOTZkMTNjYjdjMTlmLi4xNWY2Y2ZkZGNjMDggMTAwNjQ0Ci0tLSBhL2FyY2gvaWE2
NC9rZXJuZWwvYWNwaS5jCisrKyBiL2FyY2gvaWE2NC9rZXJuZWwvYWNwaS5jCkBAIC03ODMsMTEg
Kzc4Myw5IEBAIF9faW5pdCB2b2lkIHByZWZpbGxfcG9zc2libGVfbWFwKHZvaWQpCiAKIHN0YXRp
YyBpbnQgX2FjcGlfbWFwX2xzYXBpYyhhY3BpX2hhbmRsZSBoYW5kbGUsIGludCBwaHlzaWQsIGlu
dCAqcGNwdSkKIHsKLQljcHVtYXNrX3QgdG1wX21hcDsKIAlpbnQgY3B1OwogCi0JY3B1bWFza19j
b21wbGVtZW50KCZ0bXBfbWFwLCBjcHVfcHJlc2VudF9tYXNrKTsKLQljcHUgPSBjcHVtYXNrX2Zp
cnN0KCZ0bXBfbWFwKTsKKwljcHUgPSBjcHVtYXNrX2ZpcnN0X3plcm8oY3B1X3ByZXNlbnRfbWFz
ayk7CiAJaWYgKGNwdSA+PSBucl9jcHVfaWRzKQogCQlyZXR1cm4gLUVJTlZBTDsKIApkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9jcHVtYXNrLmggYi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaApp
bmRleCAxMGM5MmJkOWI4MDcuLjliNzViYTE5MWYzOSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51
eC9jcHVtYXNrLmgKKysrIGIvaW5jbHVkZS9saW51eC9jcHVtYXNrLmgKQEAgLTUwLDggKzUwLDMw
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBzZXRfbnJfY3B1X2lkcyh1bnNpZ25lZCBpbnQgbnIpCiAj
ZW5kaWYKIH0KIAotLyogRGVwcmVjYXRlZC4gQWx3YXlzIHVzZSBucl9jcHVfaWRzLiAqLwotI2Rl
ZmluZSBucl9jcHVtYXNrX2JpdHMJbnJfY3B1X2lkcworLyoKKyAqIFRoZSBkaWZmZXJlbmNlIGJl
dHdlZW4gbnJfY3B1bWFza19iaXRzIGFuZCBucl9jcHVfaWRzIGlzIHRoYXQKKyAqICducl9jcHVf
aWRzJyBpcyB0aGUgYWN0dWFsIG51bWJlciBvZiBDUFUgaWRzIGluIHRoZSBzeXN0ZW0sIHdoaWxl
CisgKiBucl9jcHVtYXNrX2JpdHMgaXMgYSAicmVhc29uYWJsZSB1cHBlciB2YWx1ZSIgdGhhdCBp
cyBvZnRlbiBtb3JlCisgKiBlZmZpY2llbnQgYmVjYXVzZSBpdCBjYW4gYmUgYSBmaXhlZCBjb25z
dGFudC4KKyAqCisgKiBTbyB3aGVuIGNsZWFyaW5nIG9yIHRyYXZlcnNpbmcgYSBjcHVtYXNrLCB1
c2UgJ25yX2NwdW1hc2tfYml0cycsCisgKiBidXQgd2hlbiBjaGVja2luZyBleGFjdCBsaW1pdHMg
KGFuZCB3aGVuIF9zZXR0aW5nXyBiaXRzKSwgdXNlIHRoZQorICogdGlnaHRlciBleGFjdCBsaW1p
dCBvZiAnbnJfY3B1X2lkcycuCisgKgorICogTk9URSEgVGhlIGNvZGUgZGVwZW5kcyBvbiBhbnkg
ZXh5dGEgYml0cyBpbiBucl9jcHVtYXNrX2JpdHMgYSBhbHdheXMKKyAqIGJlaW5nIChhKSBhbGxv
Y2F0ZWQgYW5kIChiKSB6ZXJvLCBzbyB0aGF0IHRoZSBvbmx5IGVmZmVjdCBvZiB1c2luZworICog
J25yX2NwdW1hc2tfYml0cycgaXMgdGhhdCB3ZSBtaWdodCByZXR1cm4gYSBoaWdoZXIgbWF4aW11
bSBDUFUgdmFsdWUKKyAqICh3aGljaCBpcyB3aHkgd2UgaGF2ZSB0aGF0IHBhdHRlcm4gb2YKKyAq
CisgKiAgIFJldHVybnMgPj0gbnJfY3B1X2lkcyBpZiBubyBjcHVzIHNldC4KKyAqCisgKiBmb3Ig
bWFueSBvZiB0aGUgZnVuY3Rpb25zIC0gdGhleSBjYW4gcmV0dXJuIHRoYXQgaGlnaGVyIHZhbHVl
KS4KKyAqLworI2lmZGVmIENPTkZJR19DUFVNQVNLX09GRlNUQUNLCisgI2RlZmluZSBucl9jcHVt
YXNrX2JpdHMgKCh1bnNpZ25lZCBpbnQpTlJfQ1BVUykKKyNlbHNlCisgI2RlZmluZSBucl9jcHVt
YXNrX2JpdHMJbnJfY3B1X2lkcworI2VuZGlmCiAKIC8qCiAgKiBUaGUgZm9sbG93aW5nIHBhcnRp
Y3VsYXIgc3lzdGVtIGNwdW1hc2tzIGFuZCBvcGVyYXRpb25zIG1hbmFnZQpAQCAtMTE0LDcgKzEz
Niw3IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBjcHVfbWF4X2JpdHNfd2Fybih1bnNp
Z25lZCBpbnQgY3B1LCB1bnNpZ25lZCBpbnQgYml0CiAvKiB2ZXJpZnkgY3B1IGFyZ3VtZW50IHRv
IGNwdW1hc2tfKiBvcGVyYXRvcnMgKi8KIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdW5zaWduZWQg
aW50IGNwdW1hc2tfY2hlY2sodW5zaWduZWQgaW50IGNwdSkKIHsKLQljcHVfbWF4X2JpdHNfd2Fy
bihjcHUsIG5yX2NwdW1hc2tfYml0cyk7CisJY3B1X21heF9iaXRzX3dhcm4oY3B1LCBucl9jcHVf
aWRzKTsKIAlyZXR1cm4gY3B1OwogfQogCkBAIC0yNTQsOSArMjc2LDEyIEBAIHVuc2lnbmVkIGlu
dCBjcHVtYXNrX25leHRfYW5kKGludCBuLCBjb25zdCBzdHJ1Y3QgY3B1bWFzayAqc3JjMXAsCiAg
KiBAbWFzazogdGhlIGNwdW1hc2sgcG9pbnRlcgogICoKICAqIEFmdGVyIHRoZSBsb29wLCBjcHUg
aXMgPj0gbnJfY3B1X2lkcy4KKyAqCisgKiBOb3RlIHRoYXQgc2luY2Ugd2UgaXRlcmF0ZSBvdmVy
IHplcm9lcywgd2UgaGF2ZSB0byB1c2UgdGhlIHRpZ2h0ZXIKKyAqICducl9jcHVfaWRzJyBsaW1p
dCB0byBub3QgaXRlcmF0ZSBwYXN0IHRoZSBlbmQuCiAgKi8KICNkZWZpbmUgZm9yX2VhY2hfY3B1
X25vdChjcHUsIG1hc2spCQkJCVwKLQlmb3JfZWFjaF9jbGVhcl9iaXQoY3B1LCBjcHVtYXNrX2Jp
dHMobWFzayksIG5yX2NwdW1hc2tfYml0cykKKwlmb3JfZWFjaF9jbGVhcl9iaXQoY3B1LCBjcHVt
YXNrX2JpdHMobWFzayksIG5yX2NwdV9pZHMpCiAKICNpZiBOUl9DUFVTID09IDEKIHN0YXRpYyBp
bmxpbmUKQEAgLTQ5NSwxMCArNTIwLDE0IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgYm9vbCBj
cHVtYXNrX3Rlc3RfYW5kX2NsZWFyX2NwdShpbnQgY3B1LCBzdHJ1Y3QgY3B1bWFzayAqCiAvKioK
ICAqIGNwdW1hc2tfc2V0YWxsIC0gc2V0IGFsbCBjcHVzICg8IG5yX2NwdV9pZHMpIGluIGEgY3B1
bWFzawogICogQGRzdHA6IHRoZSBjcHVtYXNrIHBvaW50ZXIKKyAqCisgKiBOb3RlOiBzaW5jZSB3
ZSBzZXQgYml0cywgd2Ugc2hvdWxkIHVzZSB0aGUgdGlnaHRlciAnYml0bWFwX3NldCgpJyB3aXRo
CisgKiB0aGUgZWFjdCBudW1iZXIgb2YgYml0cywgbm90ICdiaXRtYXBfZmlsbCgpJyB0aGF0IHdp
bGwgZmlsbCBwYXN0IHRoZQorICogZW5kLgogICovCiBzdGF0aWMgaW5saW5lIHZvaWQgY3B1bWFz
a19zZXRhbGwoc3RydWN0IGNwdW1hc2sgKmRzdHApCiB7Ci0JYml0bWFwX2ZpbGwoY3B1bWFza19i
aXRzKGRzdHApLCBucl9jcHVtYXNrX2JpdHMpOworCWJpdG1hcF9zZXQoY3B1bWFza19iaXRzKGRz
dHApLCAwLCBucl9jcHVfaWRzKTsKIH0KIAogLyoqCkBAIC01NjksMTggKzU5OCw2IEBAIHN0YXRp
YyBpbmxpbmUgYm9vbCBjcHVtYXNrX2FuZG5vdChzdHJ1Y3QgY3B1bWFzayAqZHN0cCwKIAkJCQkJ
ICBjcHVtYXNrX2JpdHMoc3JjMnApLCBucl9jcHVtYXNrX2JpdHMpOwogfQogCi0vKioKLSAqIGNw
dW1hc2tfY29tcGxlbWVudCAtICpkc3RwID0gfipzcmNwCi0gKiBAZHN0cDogdGhlIGNwdW1hc2sg
cmVzdWx0Ci0gKiBAc3JjcDogdGhlIGlucHV0IHRvIGludmVydAotICovCi1zdGF0aWMgaW5saW5l
IHZvaWQgY3B1bWFza19jb21wbGVtZW50KHN0cnVjdCBjcHVtYXNrICpkc3RwLAotCQkJCSAgICAg
IGNvbnN0IHN0cnVjdCBjcHVtYXNrICpzcmNwKQotewotCWJpdG1hcF9jb21wbGVtZW50KGNwdW1h
c2tfYml0cyhkc3RwKSwgY3B1bWFza19iaXRzKHNyY3ApLAotCQkJCQkgICAgICBucl9jcHVtYXNr
X2JpdHMpOwotfQotCiAvKioKICAqIGNwdW1hc2tfZXF1YWwgLSAqc3JjMXAgPT0gKnNyYzJwCiAg
KiBAc3JjMXA6IHRoZSBmaXJzdCBpbnB1dApAQCAtNjQ4LDcgKzY2NSw3IEBAIHN0YXRpYyBpbmxp
bmUgYm9vbCBjcHVtYXNrX2VtcHR5KGNvbnN0IHN0cnVjdCBjcHVtYXNrICpzcmNwKQogICovCiBz
dGF0aWMgaW5saW5lIGJvb2wgY3B1bWFza19mdWxsKGNvbnN0IHN0cnVjdCBjcHVtYXNrICpzcmNw
KQogewotCXJldHVybiBiaXRtYXBfZnVsbChjcHVtYXNrX2JpdHMoc3JjcCksIG5yX2NwdW1hc2tf
Yml0cyk7CisJcmV0dXJuIGJpdG1hcF9mdWxsKGNwdW1hc2tfYml0cyhzcmNwKSwgbnJfY3B1X2lk
cyk7CiB9CiAKIC8qKgpAQCAtNjk0LDcgKzcxMSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVt
YXNrX3NoaWZ0X2xlZnQoc3RydWN0IGNwdW1hc2sgKmRzdHAsCiAJCQkJICAgICAgY29uc3Qgc3Ry
dWN0IGNwdW1hc2sgKnNyY3AsIGludCBuKQogewogCWJpdG1hcF9zaGlmdF9sZWZ0KGNwdW1hc2tf
Yml0cyhkc3RwKSwgY3B1bWFza19iaXRzKHNyY3ApLCBuLAotCQkJCQkgICAgICBucl9jcHVtYXNr
X2JpdHMpOworCQkJCQkgICAgICBucl9jcHVfaWRzKTsKIH0KIAogLyoqCkBAIC03NDIsNyArNzU5
LDcgQEAgc3RhdGljIGlubGluZSB2b2lkIGNwdW1hc2tfY29weShzdHJ1Y3QgY3B1bWFzayAqZHN0
cCwKIHN0YXRpYyBpbmxpbmUgaW50IGNwdW1hc2tfcGFyc2VfdXNlcihjb25zdCBjaGFyIF9fdXNl
ciAqYnVmLCBpbnQgbGVuLAogCQkJCSAgICAgc3RydWN0IGNwdW1hc2sgKmRzdHApCiB7Ci0JcmV0
dXJuIGJpdG1hcF9wYXJzZV91c2VyKGJ1ZiwgbGVuLCBjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2Nw
dW1hc2tfYml0cyk7CisJcmV0dXJuIGJpdG1hcF9wYXJzZV91c2VyKGJ1ZiwgbGVuLCBjcHVtYXNr
X2JpdHMoZHN0cCksIG5yX2NwdV9pZHMpOwogfQogCiAvKioKQEAgLTc1Nyw3ICs3NzQsNyBAQCBz
dGF0aWMgaW5saW5lIGludCBjcHVtYXNrX3BhcnNlbGlzdF91c2VyKGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsIGludCBsZW4sCiAJCQkJICAgICBzdHJ1Y3QgY3B1bWFzayAqZHN0cCkKIHsKIAlyZXR1
cm4gYml0bWFwX3BhcnNlbGlzdF91c2VyKGJ1ZiwgbGVuLCBjcHVtYXNrX2JpdHMoZHN0cCksCi0J
CQkJICAgICBucl9jcHVtYXNrX2JpdHMpOworCQkJCSAgICAgbnJfY3B1X2lkcyk7CiB9CiAKIC8q
KgpAQCAtNzY5LDcgKzc4Niw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNwdW1hc2tfcGFyc2VsaXN0
X3VzZXIoY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwgaW50IGxlbiwKICAqLwogc3RhdGljIGlubGlu
ZSBpbnQgY3B1bWFza19wYXJzZShjb25zdCBjaGFyICpidWYsIHN0cnVjdCBjcHVtYXNrICpkc3Rw
KQogewotCXJldHVybiBiaXRtYXBfcGFyc2UoYnVmLCBVSU5UX01BWCwgY3B1bWFza19iaXRzKGRz
dHApLCBucl9jcHVtYXNrX2JpdHMpOworCXJldHVybiBiaXRtYXBfcGFyc2UoYnVmLCBVSU5UX01B
WCwgY3B1bWFza19iaXRzKGRzdHApLCBucl9jcHVfaWRzKTsKIH0KIAogLyoqCkBAIC03ODEsNyAr
Nzk4LDcgQEAgc3RhdGljIGlubGluZSBpbnQgY3B1bWFza19wYXJzZShjb25zdCBjaGFyICpidWYs
IHN0cnVjdCBjcHVtYXNrICpkc3RwKQogICovCiBzdGF0aWMgaW5saW5lIGludCBjcHVsaXN0X3Bh
cnNlKGNvbnN0IGNoYXIgKmJ1Ziwgc3RydWN0IGNwdW1hc2sgKmRzdHApCiB7Ci0JcmV0dXJuIGJp
dG1hcF9wYXJzZWxpc3QoYnVmLCBjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2NwdW1hc2tfYml0cyk7
CisJcmV0dXJuIGJpdG1hcF9wYXJzZWxpc3QoYnVmLCBjcHVtYXNrX2JpdHMoZHN0cCksIG5yX2Nw
dV9pZHMpOwogfQogCiAvKioK
--000000000000c4a89e05f618fe23--
