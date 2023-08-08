Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136D77745EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 20:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjHHSsl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 14:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHHSsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:48:23 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD01940F
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Aug 2023 09:57:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso9723694e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691513843; x=1692118643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0vkAwW5QpFto/3iZxXs952JhEe8qRWUMMxPi+R76PM=;
        b=Ti59RVScMXl0b2HRtWL9NR9N3UiedxQG42PHAAGR0PGFWlQQUt+tGNRI0X9mu+n40h
         G3Ndk39+FM1fHRD5fDeUqSdHgN56hQ+v26g+yWm8KCcZ/4WtnYhkDbL91yXA7zNfcOcr
         5m2DaGGEVY22xXcLuyTBDsgQ0bKK0PO8/2th4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513843; x=1692118643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0vkAwW5QpFto/3iZxXs952JhEe8qRWUMMxPi+R76PM=;
        b=ksOyVXbyfK9HbQGLylZC2sBIiCfgw/5dqJW60w5cUtmNl7RfTtSyFFAMVRxS3+a9B4
         s7/2XuomGOyTPvr2U29r6X9ZGACdkqp5Ehv476C7TEic5coPLgbMCzZJDFPzc9zOpVHJ
         TWDZG3MAnJe4aTGh9SlH7Mn7ayLTG5pxZ6tbDt3vmDiXoScRDf4RQCFf+5YfJzxf6HRR
         vVhME9Fr4G61YyiFdb8VhYDGzgBbNtkub9NCQmCiUsSkPJEQfURcJYhx0P3urzb6UDQ3
         jYPSJBXJ19QT30pHMyhu56/N/PnXxxxs3xbtzF4dQa6LcmXER7a/tm8qZqRXvTfayEYw
         hR0Q==
X-Gm-Message-State: AOJu0YyysDi6PMTNCxRBuRUveduj2ZgaBqFPYp4w+XNQrNFEgqeS3lSp
        0kxvQWaSr0NwRIqIItp/gnKD5SlPKrbedvG85ooitg==
X-Google-Smtp-Source: AGHT+IF6U9nMOxU+/nAFABVIJmzfilQYh4I8Hd8KWNwlBf8psEyYSNVftf3sOJ0pnZyxJOj2PkJa3A==
X-Received: by 2002:a05:6512:6cc:b0:4fd:f85d:f67a with SMTP id u12-20020a05651206cc00b004fdf85df67amr31362lff.61.1691513842521;
        Tue, 08 Aug 2023 09:57:22 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c24-20020ac25318000000b004fdd6b72bfdsm1940994lfh.117.2023.08.08.09.57.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:57:21 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe48a2801bso9723631e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Aug 2023 09:57:21 -0700 (PDT)
X-Received: by 2002:a05:6512:3b21:b0:4f8:e4e9:499e with SMTP id
 f33-20020a0565123b2100b004f8e4e9499emr79202lfv.12.1691513841300; Tue, 08 Aug
 2023 09:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230806230627.1394689-1-mjguzik@gmail.com> <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87o7jidqlg.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Aug 2023 09:57:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
Message-ID: <CAHk-=whk-8Pv5YXH4jNfyAf2xiQCGCUVyBWw71qJEafn4mT6vw@mail.gmail.com>
Subject: Re: [PATCH] fs: use __fput_sync in close(2)
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        oleg@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a6196606026c4195"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a6196606026c4195
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Aug 2023 at 22:57, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Taking a quick look at the history it appears that fput was always
> synchronous [..]

Indeed. Synchronous used to be the only case.

The reason it's async now is because several drivers etc do the final
close from nasty contexts, so 'fput()' needed to be async for the
general case.

> All 3 issues taken together says that a synchronous fput is a
> loaded foot gun that must be used very carefully.   That said
> close(2) does seem to be a reliably safe place to be synchronous.

Yes.

That said, I detest Mateusz' patch. I hate these kinds of "do
different things based on flags" interfaces. Particularly when it
spreads out like this.

So I do like having close() be synchronous, because we actually do
have correctness issues wrt the close having completed properly by the
time we return to user space, so we have that "task_work_add()" there
that will force the synchronization anyway before we return.

So the system call case is indeed a special case. Arguably
close_range() could be too, but honestly, once you start doing ranges
of file descriptors, you are (a) doint something fairly unusual, and
(b) the "queue them up on the task work" might actually be a *good*
thing.

It's definitely not a good thing for the single-fd-close case, though.

But even if we want to do this - and I have absolutely no objections
to it conceptually as per above - we need to be a lot more surgical
about it, and not pass stupid flags around.

Here's a TOTALLY UNTESTED(!) patch that I think effectively does what
Mateusz wants done, but does it all within just fs/open.c and only for
the obvious context of the close() system call itself.

All it needs is to just split out the "flush" part from filp_close(),
and we already had all the other infrastructure for this operation.

Mateusz, two questions:

 (a) does this patch work for you?

 (b) do you have numbers for this all?

and if it all looks good I have no problems with this kind of much
more targeted and obvious patch.

Again: TOTALLY UNTESTED. It looks completely obvious, but mistakes happen.

             Linus

--000000000000a6196606026c4195
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ll2jn96d0>
X-Attachment-Id: f_ll2jn96d0

IGZzL29wZW4uYyB8IDIyICsrKysrKysrKysrKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL29wZW4uYyBi
L2ZzL29wZW4uYwppbmRleCBlNmVhZDBmMTk5NjQuLjVmZTQyN2U4Njg1YyAxMDA2NDQKLS0tIGEv
ZnMvb3Blbi5jCisrKyBiL2ZzL29wZW4uYwpAQCAtMTUwMyw3ICsxNTAzLDcgQEAgU1lTQ0FMTF9E
RUZJTkUyKGNyZWF0LCBjb25zdCBjaGFyIF9fdXNlciAqLCBwYXRobmFtZSwgdW1vZGVfdCwgbW9k
ZSkKICAqICJpZCIgaXMgdGhlIFBPU0lYIHRocmVhZCBJRC4gV2UgdXNlIHRoZQogICogZmlsZXMg
cG9pbnRlciBmb3IgdGhpcy4uCiAgKi8KLWludCBmaWxwX2Nsb3NlKHN0cnVjdCBmaWxlICpmaWxw
LCBmbF9vd25lcl90IGlkKQorc3RhdGljIGludCBmaWxwX2ZsdXNoKHN0cnVjdCBmaWxlICpmaWxw
LCBmbF9vd25lcl90IGlkKQogewogCWludCByZXR2YWwgPSAwOwogCkBAIC0xNTIwLDEwICsxNTIw
LDE1IEBAIGludCBmaWxwX2Nsb3NlKHN0cnVjdCBmaWxlICpmaWxwLCBmbF9vd25lcl90IGlkKQog
CQlkbm90aWZ5X2ZsdXNoKGZpbHAsIGlkKTsKIAkJbG9ja3NfcmVtb3ZlX3Bvc2l4KGZpbHAsIGlk
KTsKIAl9Ci0JZnB1dChmaWxwKTsKIAlyZXR1cm4gcmV0dmFsOwogfQogCitpbnQgZmlscF9jbG9z
ZShzdHJ1Y3QgZmlsZSAqZmlscCwgZmxfb3duZXJfdCBpZCkKK3sKKwlpbnQgcmV0dmFsID0gZmls
cF9mbHVzaChmaWxwLCBpZCk7CisJZnB1dChmaWxwKTsKKwlyZXR1cm4gcmV0dmFsOworfQogRVhQ
T1JUX1NZTUJPTChmaWxwX2Nsb3NlKTsKIAogLyoKQEAgLTE1MzMsNyArMTUzOCwxOCBAQCBFWFBP
UlRfU1lNQk9MKGZpbHBfY2xvc2UpOwogICovCiBTWVNDQUxMX0RFRklORTEoY2xvc2UsIHVuc2ln
bmVkIGludCwgZmQpCiB7Ci0JaW50IHJldHZhbCA9IGNsb3NlX2ZkKGZkKTsKKwlzdHJ1Y3QgZmls
ZSAqZmlsZSA9IGNsb3NlX2ZkX2dldF9maWxlKGZkKTsKKwlpbnQgcmV0dmFsOworCisJaWYgKCFm
aWxlKQorCQlyZXR1cm4gLUVCQURGOworCXJldHZhbCA9IGZpbHBfZmx1c2goZmlsZSwgY3VycmVu
dC0+ZmlsZXMpOworCisJLyoKKwkgKiBXZSdyZSByZXR1cm5pbmcgdG8gdXNlciBzcGFjZS4gRG9u
J3QgYm90aGVyCisJICogd2l0aCBhbnkgZGVsYXllZCBmcHV0KCkgY2FzZXMuCisJICovCisJX19m
cHV0X3N5bmMoZmlsZSk7CiAKIAkvKiBjYW4ndCByZXN0YXJ0IGNsb3NlIHN5c2NhbGwgYmVjYXVz
ZSBmaWxlIHRhYmxlIGVudHJ5IHdhcyBjbGVhcmVkICovCiAJaWYgKHVubGlrZWx5KHJldHZhbCA9
PSAtRVJFU1RBUlRTWVMgfHwK
--000000000000a6196606026c4195--
