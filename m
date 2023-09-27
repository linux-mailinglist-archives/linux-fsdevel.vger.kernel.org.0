Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADE47B0D6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjI0U2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjI0U2P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 16:28:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CC310E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 13:28:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9adb9fa7200so2654886466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695846491; x=1696451291; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5tY2gwDez0Qf3DHOTXDYMh4745U3+Wh/mJcDvesXVQ=;
        b=QbgzPV21eemJ0abhYY6R5cvLm5+4Z0x7TuZ1NiXd27JtBgI9OQY8qzUTHObhvYrAPH
         vb+2JxvqhnVPdDI/qGAeBAHlTyOdPdD8kh5ZLodmpEeTGAfFd4CUnWnpaOPCT+LOfEvZ
         6Dn0dzrgsNH3XLBM0I+4zxd6jBuCxQTLVrRrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695846491; x=1696451291;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5tY2gwDez0Qf3DHOTXDYMh4745U3+Wh/mJcDvesXVQ=;
        b=l9AXeeTI1Dgzc5/qhCt83cxnWR7oRt1qCvyZ+6nhN3vyOLFTOWdEDYQhPqg81gBFsw
         S7+g7caQyA/NgDQSd4z5e2Q8JOAP3NEv77c4Hy883DgkVVcLRF+3HTq1zMQx/InVtE/5
         CultMa6QTqTt4n3pxF2Z3jKuBQ3814w2KOGRArTWdR05sCcANOOQb48dQ4LkCbt2Xfbp
         hDxbSaRSWusvjJNV3QXGzLos6qx6+B0KW9HKESYbELQpY+Ytv6GWIe7xIX8k7J4l+uln
         9T8L73i248bKMe0AQjvCPr3HY8WR8ZkaayIzZ2+acDjxrTVB6gF6iceX9tQqdigMKs0/
         EOBA==
X-Gm-Message-State: AOJu0YxVpGBDDwwxL4Q17tqYnnUbge9CnuXNnMsR9t9B1B2QHM2udH+M
        c9PNiGTVgOl50ViS8ZDjhATK9yrstMwVovxObkgsWQ==
X-Google-Smtp-Source: AGHT+IG712Uvl/7P7RpK0uczZckwiQm0Q51VEn7ktYJN7S3fDs4TCIVt9TecEQaVrnnSe/2Owg0FqQ==
X-Received: by 2002:a17:906:6a21:b0:9ae:5879:78dd with SMTP id qw33-20020a1709066a2100b009ae587978ddmr10195829ejc.1.1695846491467;
        Wed, 27 Sep 2023 13:28:11 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id z17-20020a1709067e5100b0099bc80d5575sm9720432ejr.200.2023.09.27.13.28.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 13:28:10 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so28687209a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 13:28:10 -0700 (PDT)
X-Received: by 2002:aa7:c549:0:b0:533:dd4d:2941 with SMTP id
 s9-20020aa7c549000000b00533dd4d2941mr4099814edr.16.1695846490123; Wed, 27 Sep
 2023 13:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com>
 <20230927-kosmetik-babypuppen-75bee530b9f0@brauner> <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
 <CAGudoHH2mvfjfKt+nOCEOfvOrQ+o1pqX63tN2r_1+bLZ4OqHNA@mail.gmail.com>
 <CAHk-=wjmgord99A-Gwy3dsiG1YNeXTCbt+z6=3RH_je5PP41Zw@mail.gmail.com> <ZRR1Kc/dvhya7ME4@f>
In-Reply-To: <ZRR1Kc/dvhya7ME4@f>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 13:27:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
Message-ID: <CAHk-=wibs_xBP2BGG4UHKhiP2B=7KJnx_LL18O0bGK8QkULLHg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a3607f06065d07b1"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a3607f06065d07b1
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Sept 2023 at 11:32, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> put_cred showed up in file_free_rcu in d76b0d9b2d87 ("CRED: Use creds in
> file structs"). Commit message does not claim any dependency on this
> being in an rcu callback already and it looks like it was done this way
> because this was the ony spot with kmem_cache_free(filp_cachep, f)

Yes, that looks about right. So the rcu-freeing is almost an accident.

Btw, I think we could get rid of the RCU freeing of 'struct file *' entirely.

The way to fix it is

 (a) make sure all f_count accesses are atomic ops (the one special
case is the "0 -> X" initialization, which is ok)

 (b) make filp_cachep be SLAB_TYPESAFE_BY_RCU

because then get_file_rcu() can do the atomic_long_inc_not_zero()
knowing it's still a 'struct file *' while holding the RCU read lock
even if it was just free'd.

And __fget_files_rcu() will then re-check that it's the *right*
'struct file *' and do a fput() on it and re-try if it isn't. End
result: no need for any RCU freeing.

But the difference is that a *new* 'struct file *' might see a
temporary atomic increment / decrement of the file pointer because
another CPU is going through that __fget_files_rcu() dance.

Which is why "0 -> X" is ok to do as a "atomic_long_set()", but
everything else would need to be done as "atomic_long_inc()" etc.

Which all seems to be the case already, so with the put_cred() not
needing the RCU delay, I thing we really could do this patch (note:
independent of other issues, but makes your patch require that
"atomic_long_cmpxchg()" and the WARN_ON() should probably go away,
because it can actually happen).

That should help the normal file open/close case a bit, in that it
doesn't cause that extra RCU work.

Of course, on some loads it might be advantageous to do a delayed
de-allocation in some other RCU context, so ..

What do you think?

             Linus

PS. And as always: ENTIRELY UNTESTED.

--000000000000a3607f06065d07b1
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ln277b020>
X-Attachment-Id: f_ln277b020

IGZzL2ZpbGVfdGFibGUuYyB8IDE5ICsrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCAxMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2ZpbGVf
dGFibGUuYyBiL2ZzL2ZpbGVfdGFibGUuYwppbmRleCBlZTIxYjNkYTlkMDguLjdiMzhmZjczODVj
YyAxMDA2NDQKLS0tIGEvZnMvZmlsZV90YWJsZS5jCisrKyBiL2ZzL2ZpbGVfdGFibGUuYwpAQCAt
NjUsMjEgKzY1LDIxIEBAIHN0YXRpYyB2b2lkIGZpbGVfZnJlZV9yY3Uoc3RydWN0IHJjdV9oZWFk
ICpoZWFkKQogewogCXN0cnVjdCBmaWxlICpmID0gY29udGFpbmVyX29mKGhlYWQsIHN0cnVjdCBm
aWxlLCBmX3JjdWhlYWQpOwogCi0JcHV0X2NyZWQoZi0+Zl9jcmVkKTsKLQlpZiAodW5saWtlbHko
Zi0+Zl9tb2RlICYgRk1PREVfQkFDS0lORykpCi0JCWtmcmVlKGJhY2tpbmdfZmlsZShmKSk7Ci0J
ZWxzZQotCQlrbWVtX2NhY2hlX2ZyZWUoZmlscF9jYWNoZXAsIGYpOworCWtmcmVlKGJhY2tpbmdf
ZmlsZShmKSk7CiB9CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBmaWxlX2ZyZWUoc3RydWN0IGZpbGUg
KmYpCiB7CiAJc2VjdXJpdHlfZmlsZV9mcmVlKGYpOwotCWlmICh1bmxpa2VseShmLT5mX21vZGUg
JiBGTU9ERV9CQUNLSU5HKSkKLQkJcGF0aF9wdXQoYmFja2luZ19maWxlX3JlYWxfcGF0aChmKSk7
CiAJaWYgKGxpa2VseSghKGYtPmZfbW9kZSAmIEZNT0RFX05PQUNDT1VOVCkpKQogCQlwZXJjcHVf
Y291bnRlcl9kZWMoJm5yX2ZpbGVzKTsKLQljYWxsX3JjdSgmZi0+Zl9yY3VoZWFkLCBmaWxlX2Zy
ZWVfcmN1KTsKKwlwdXRfY3JlZChmLT5mX2NyZWQpOworCWlmICh1bmxpa2VseShmLT5mX21vZGUg
JiBGTU9ERV9CQUNLSU5HKSkgeworCQlwYXRoX3B1dChiYWNraW5nX2ZpbGVfcmVhbF9wYXRoKGYp
KTsKKwkJY2FsbF9yY3UoJmYtPmZfcmN1aGVhZCwgZmlsZV9mcmVlX3JjdSk7CisJfSBlbHNlIHsK
KwkJa21lbV9jYWNoZV9mcmVlKGZpbHBfY2FjaGVwLCBmKTsKKwl9CiB9CiAKIC8qCkBAIC00NzEs
NyArNDcxLDggQEAgRVhQT1JUX1NZTUJPTChfX2ZwdXRfc3luYyk7CiB2b2lkIF9faW5pdCBmaWxl
c19pbml0KHZvaWQpCiB7CiAJZmlscF9jYWNoZXAgPSBrbWVtX2NhY2hlX2NyZWF0ZSgiZmlscCIs
IHNpemVvZihzdHJ1Y3QgZmlsZSksIDAsCi0JCQlTTEFCX0hXQ0FDSEVfQUxJR04gfCBTTEFCX1BB
TklDIHwgU0xBQl9BQ0NPVU5ULCBOVUxMKTsKKwkJCVNMQUJfVFlQRVNBRkVfQllfUkNVIHwgU0xB
Ql9IV0NBQ0hFX0FMSUdOCisJCQl8IFNMQUJfUEFOSUMgfCBTTEFCX0FDQ09VTlQsIE5VTEwpOwog
CXBlcmNwdV9jb3VudGVyX2luaXQoJm5yX2ZpbGVzLCAwLCBHRlBfS0VSTkVMKTsKIH0KIAo=
--000000000000a3607f06065d07b1--
