Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B56C74A628
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 23:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFV5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGFV5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:57:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195CE72
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jul 2023 14:57:06 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6ef9ed2fdso18666581fa.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688680624; x=1691272624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AVnhNg7qkZFpMTP0oagP3cgCf8IJ5Q1wLEIQcCh535o=;
        b=MvBMImMhdvHidhBzL6uqZxx6yzVRes6iV58FCq8wlDtFedCDMKFsPCQCW2bAVtyCr7
         KGD2noEW89s15OLBP5uyX8JKNqczU9IDts0LnmdUTC7F/MYgyD4obOqrl0YMeQUwLDYQ
         3DvDcCwBZCTVwplFebSInLXoGUMVQhbSnueYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688680624; x=1691272624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVnhNg7qkZFpMTP0oagP3cgCf8IJ5Q1wLEIQcCh535o=;
        b=LD6BMHGxgtwOQDjcdCZtBXSqtLXZDO7sUWgG7Y86mNABUWGOYaj/ZcymaARkoCxFcZ
         t/BlRhHt2hnsrLhWuSwXTqdp9Yk2VLoLBJVWDbKm6pllEJqLqaPUrvhtIS/kUcRRR56r
         cvL3qbgqH0iYqnFSzFsd4FiUaVPEe5fuh1avBXUsJphlLPnrwm6jd+iHYXOXxOVxVjsq
         2Ov7rbcyADq9tVEAhBaiITnBA7LKxENv0nf9b+9RRfW5AOV8ZyOgdgR5/hH8xqYjsqfA
         d9gbbkviCVPFNJzFZDkSwHuu+ElOJM+1fdQQLoDu7/OuIg0/FnzELFXvjMVbl6szGkqp
         o1nQ==
X-Gm-Message-State: ABy/qLbp6nET0hFca0TqlhfSwQW6jLWcvYoLqj5vBTD6U69A7I2CMlKB
        JSqzphqwjFaNBEYpO1o254fC4giM5pYvV4ujqRqjEDk+
X-Google-Smtp-Source: APBJJlH8HQwk9OQGpjYEjmUHAr/dCaLBqh5Vgms7jstSDBsy8wMNI+cXKvs7y8nrFYO/5R8faY+Vog==
X-Received: by 2002:a2e:8085:0:b0:2b6:d9b0:875d with SMTP id i5-20020a2e8085000000b002b6d9b0875dmr2328016ljg.34.1688680624471;
        Thu, 06 Jul 2023 14:57:04 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m15-20020a2e97cf000000b002b6e13fcedcsm487811ljj.122.2023.07.06.14.57.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 14:57:03 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b701e41cd3so18720371fa.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jul 2023 14:57:02 -0700 (PDT)
X-Received: by 2002:ac2:4c46:0:b0:4fb:85ad:b6e2 with SMTP id
 o6-20020ac24c46000000b004fb85adb6e2mr2691388lfk.50.1688680622427; Thu, 06 Jul
 2023 14:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner> <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner> <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
In-Reply-To: <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jul 2023 14:56:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
Message-ID: <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read side?)
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a4b41205ffd898be"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a4b41205ffd898be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Jun 2023 at 09:14, Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> And even if that was a working work-around, the fundamental problem of
> ./spl>fifo excluding all other access to fifo is quite unfortunate too.

So I already sent an earlier broken version of this patch to Ahelenia
and Christian, but here's an actually slightly tested version with the
obvious bugs fixed.

The keyword here being "obvious". It's probably broken in many
non-obvious ways, but I'm sending it out in case anybody wants to play
around with it.

It boots for me. It even changes behavior of programs that splice()
and used to keep the pipe lock over the IO and no longer do.

But it might do unspeakable things to your pets, so caveat emptor. It
"feels" right to me. But it's a rather quick hack, and really needs
more eyes and more thought. I mention O_NDELAY in the (preliminary)
commit message, but there are probably other issues that need thinking
about.

                Linus

--000000000000a4b41205ffd898be
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-splice-lock-the-pages-and-unlock-the-pipe-during-IO.patch"
Content-Disposition: attachment; 
	filename="0001-splice-lock-the-pages-and-unlock-the-pipe-during-IO.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ljrotv5r0>
X-Attachment-Id: f_ljrotv5r0

RnJvbSAzNDc1ZTRkNTZjZWZhYjlmOGIwNjFkYzgyNGRiNGUzMTRkMDc2YTU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgNiBKdWwgMjAyMyAxMToyMzowNyAtMDcwMApTdWJqZWN0OiBb
UEFUQ0hdIHNwbGljZTogbG9jayB0aGUgcGFnZXMgYW5kIHVubG9jayB0aGUgcGlwZSBkdXJpbmcg
SU8KClRoaXMgaXMgYWxyZWFkeSB3aGF0IHdlIGRvIGZvciBwYWdlIGNhY2hlIHBhZ2VzLCB3aGVy
ZSB3ZSBjYW4gYWRkIHJhdwpwYWdlcyB0aGF0IGFyZSBub3QgdXAtdG8tZGF0ZSB5ZXQgdG8gdGhl
IHBpcGUsIGFuZCB0aGUgcmVhZGVycyBjYWxsIHRoZQpwaXBlIGJ1ZmZlciAnLT5jb25maXJtKCkn
IGZ1bmN0aW9uIHRvIHdhaXQgZm9yIHRoZSBkYXRhIHRvIGJlIHJlYWR5LgoKU28ganVzdCBkbyB0
aGUgc2FtZSBmb3Igc3BsaWNlIHJlYWRpbmcsIGFsbG93aW5nIHVzIHRvIHVubG9jayB0aGUgcGlw
ZQpkdXJpbmcgdGhlIHJlYWQuICBUaGF0IHRoZW4gYXZvaWRzIHByb2JsZW1zIHdpdGggdXNlcnMg
dGhhdCBnZXQgYmxvY2tlZApvbiB0aGUgcGlwZSBsb2NrLgoKTm93IHRoZXkgZ2V0IGJsb2NrZWQg
b24gdGhlIHBpcGUgYnVmZmVyIC0+Y29uZmlybSgpIGluc3RlYWQuCgpUT0RPOiB0ZWFjaCAnT19O
REVMQVknIGFuZCBzZWxlY3QvcG9sbCBhYm91dCB0aGlzIHRvby4KClNpZ25lZC1vZmYtYnk6IExp
bnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KLS0tCiBmcy9waXBl
LmMgICAgICAgICAgICAgICB8ICAxOCArKystLS0KIGZzL3NwbGljZS5jICAgICAgICAgICAgIHwg
MTIyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KIGluY2x1ZGUvbGlu
dXgvcGFnZW1hcC5oIHwgICAxICsKIG1tL2ZpbGVtYXAuYyAgICAgICAgICAgIHwgICA2ICsrCiA0
IGZpbGVzIGNoYW5nZWQsIDEwNSBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9mcy9waXBlLmMgYi9mcy9waXBlLmMKaW5kZXggMmQ4OGY3M2Y1ODVhLi43MTk0MmQy
NDBjOTggMTAwNjQ0Ci0tLSBhL2ZzL3BpcGUuYworKysgYi9mcy9waXBlLmMKQEAgLTI4NCwxMCAr
Mjg0LDE3IEBAIHBpcGVfcmVhZChzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAq
dG8pCiAKIAkJaWYgKCFwaXBlX2VtcHR5KGhlYWQsIHRhaWwpKSB7CiAJCQlzdHJ1Y3QgcGlwZV9i
dWZmZXIgKmJ1ZiA9ICZwaXBlLT5idWZzW3RhaWwgJiBtYXNrXTsKLQkJCXNpemVfdCBjaGFycyA9
IGJ1Zi0+bGVuOwotCQkJc2l6ZV90IHdyaXR0ZW47CisJCQlzaXplX3QgY2hhcnMsIHdyaXR0ZW47
CiAJCQlpbnQgZXJyb3I7CiAKKwkJCWVycm9yID0gcGlwZV9idWZfY29uZmlybShwaXBlLCBidWYp
OworCQkJaWYgKGVycm9yKSB7CisJCQkJaWYgKCFyZXQpCisJCQkJCXJldCA9IGVycm9yOworCQkJ
CWJyZWFrOworCQkJfQorCisJCQljaGFycyA9IGJ1Zi0+bGVuOwogCQkJaWYgKGNoYXJzID4gdG90
YWxfbGVuKSB7CiAJCQkJaWYgKGJ1Zi0+ZmxhZ3MgJiBQSVBFX0JVRl9GTEFHX1dIT0xFKSB7CiAJ
CQkJCWlmIChyZXQgPT0gMCkKQEAgLTI5NywxMyArMzA0LDYgQEAgcGlwZV9yZWFkKHN0cnVjdCBr
aW9jYiAqaW9jYiwgc3RydWN0IGlvdl9pdGVyICp0bykKIAkJCQljaGFycyA9IHRvdGFsX2xlbjsK
IAkJCX0KIAotCQkJZXJyb3IgPSBwaXBlX2J1Zl9jb25maXJtKHBpcGUsIGJ1Zik7Ci0JCQlpZiAo
ZXJyb3IpIHsKLQkJCQlpZiAoIXJldCkKLQkJCQkJcmV0ID0gZXJyb3I7Ci0JCQkJYnJlYWs7Ci0J
CQl9Ci0KIAkJCXdyaXR0ZW4gPSBjb3B5X3BhZ2VfdG9faXRlcihidWYtPnBhZ2UsIGJ1Zi0+b2Zm
c2V0LCBjaGFycywgdG8pOwogCQkJaWYgKHVubGlrZWx5KHdyaXR0ZW4gPCBjaGFycykpIHsKIAkJ
CQlpZiAoIXJldCkKZGlmZiAtLWdpdCBhL2ZzL3NwbGljZS5jIGIvZnMvc3BsaWNlLmMKaW5kZXgg
MDA0ZWIxYzRjZTMxLi41MDNmN2VmZjQxYjYgMTAwNjQ0Ci0tLSBhL2ZzL3NwbGljZS5jCisrKyBi
L2ZzL3NwbGljZS5jCkBAIC0zMDAsNiArMzAwLDQyIEBAIHZvaWQgc3BsaWNlX3Nocmlua19zcGQo
c3RydWN0IHNwbGljZV9waXBlX2Rlc2MgKnNwZCkKIAlrZnJlZShzcGQtPnBhcnRpYWwpOwogfQog
CitzdGF0aWMgdm9pZCBmaW5hbGl6ZV9waXBlX2J1ZihzdHJ1Y3QgcGlwZV9idWZmZXIgKmJ1Ziwg
dW5zaWduZWQgaW50IGNodW5rKQoreworCWJ1Zi0+bGVuID0gY2h1bms7CisJYnVmLT5vcHMgPSAm
ZGVmYXVsdF9waXBlX2J1Zl9vcHM7CisJdW5sb2NrX3BhZ2UoYnVmLT5wYWdlKTsKK30KKworc3Rh
dGljIGludCBidXN5X3BpcGVfYnVmX2NvbmZpcm0oc3RydWN0IHBpcGVfaW5vZGVfaW5mbyAqcGlw
ZSwKKwkJCQkgc3RydWN0IHBpcGVfYnVmZmVyICpidWYpCit7CisJc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBidWYtPnBhZ2U7CisKKwlpZiAoZm9saW9fd2FpdF9iaXRfaW50ZXJydXB0aWJsZShwYWdlX2Zv
bGlvKHBhZ2UpLCBQR19sb2NrZWQpKQorCQlyZXR1cm4gLUVJTlRSOworCXJldHVybiAwOworfQor
CisvKgorICogVGhlc2UgYXJlIHRoZSBzYW1lIGFzIHRoZSBkZWZhdWx0IHBpcGUgYnVmIG9wZXJh
dGlvbnMsCisgKiBidXQgdGhlICcuY29uZmlybSgpJyBmdW5jdGlvbiByZXF1aXJlcyB0aGF0IGFu
eSB1c2VyCisgKiB3YWl0IGZvciB0aGUgcGFnZSB0byB1bmxvY2sgYmVmb3JlIHVzZS4KKyAqCisg
KiBJIGd1ZXNzIHdlIGNvdWxkIHVzZSB0aGUgd2hvbGUgUEdfdXB0b2RhdGUgbG9naWMgdG9vLAor
ICogYW5kIHRyZWF0IHRoZXNlIGFzIHNvbWUga2luZCBvZiBzcGVjaWFsIHBhZ2UgdGFibGUgcGFn
ZXMuCisgKgorICogUElQRV9CVUZfRkxBR19DQU5fTUVSR0UgbXVzdCBvYnZpb3VzbHkgbm90IGJl
IHNldCB3aGVuCisgKiB1c2luZyB0aGVzZSwgYW5kIGl0J3MgaW1wb3J0YW50IHRoYXQgYW55IHBp
cGUgcmVhZGVyCisgKiBsb29rIGF0IGJ1Zi0+bGVuIG9ubHkgX2FmdGVyXyBjb25maXJtaW5nIHRo
ZSBidWZmZXIhCisgKi8KK2NvbnN0IHN0cnVjdCBwaXBlX2J1Zl9vcGVyYXRpb25zIGJ1c3lfcGlw
ZV9idWZfb3BzID0geworCS5jb25maXJtCT0gYnVzeV9waXBlX2J1Zl9jb25maXJtLAorCS5yZWxl
YXNlCT0gZ2VuZXJpY19waXBlX2J1Zl9yZWxlYXNlLAorCS50cnlfc3RlYWwJPSBnZW5lcmljX3Bp
cGVfYnVmX3RyeV9zdGVhbCwKKwkuZ2V0CQk9IGdlbmVyaWNfcGlwZV9idWZfZ2V0LAorfTsKKwog
LyoqCiAgKiBjb3B5X3NwbGljZV9yZWFkIC0gIENvcHkgZGF0YSBmcm9tIGEgZmlsZSBhbmQgc3Bs
aWNlIHRoZSBjb3B5IGludG8gYSBwaXBlCiAgKiBAaW46IFRoZSBmaWxlIHRvIHJlYWQgZnJvbQpA
QCAtMzI4LDYgKzM2NCw3IEBAIHNzaXplX3QgY29weV9zcGxpY2VfcmVhZChzdHJ1Y3QgZmlsZSAq
aW4sIGxvZmZfdCAqcHBvcywKIAlzdHJ1Y3QgYmlvX3ZlYyAqYnY7CiAJc3RydWN0IGtpb2NiIGtp
b2NiOwogCXN0cnVjdCBwYWdlICoqcGFnZXM7CisJc3RydWN0IHBpcGVfYnVmZmVyICoqYnVmczsK
IAlzc2l6ZV90IHJldDsKIAlzaXplX3QgdXNlZCwgbnBhZ2VzLCBjaHVuaywgcmVtYWluLCBrZWVw
ID0gMDsKIAlpbnQgaTsKQEAgLTMzOSwxMSArMzc2LDEzIEBAIHNzaXplX3QgY29weV9zcGxpY2Vf
cmVhZChzdHJ1Y3QgZmlsZSAqaW4sIGxvZmZfdCAqcHBvcywKIAlucGFnZXMgPSBESVZfUk9VTkRf
VVAobGVuLCBQQUdFX1NJWkUpOwogCiAJYnYgPSBremFsbG9jKGFycmF5X3NpemUobnBhZ2VzLCBz
aXplb2YoYnZbMF0pKSArCi0JCSAgICAgYXJyYXlfc2l6ZShucGFnZXMsIHNpemVvZihzdHJ1Y3Qg
cGFnZSAqKSksIEdGUF9LRVJORUwpOworCQkgICAgIGFycmF5X3NpemUobnBhZ2VzLCBzaXplb2Yo
c3RydWN0IHBhZ2UgKikpICsKKwkJICAgICBhcnJheV9zaXplKG5wYWdlcywgc2l6ZW9mKHN0cnVj
dCBwaXBlX2J1ZmZlciAqKSksIEdGUF9LRVJORUwpOwogCWlmICghYnYpCiAJCXJldHVybiAtRU5P
TUVNOwogCiAJcGFnZXMgPSAoc3RydWN0IHBhZ2UgKiopKGJ2ICsgbnBhZ2VzKTsKKwlidWZzID0g
KHN0cnVjdCBwaXBlX2J1ZmZlciAqKikocGFnZXMgKyBucGFnZXMpOwogCW5wYWdlcyA9IGFsbG9j
X3BhZ2VzX2J1bGtfYXJyYXkoR0ZQX1VTRVIsIG5wYWdlcywgcGFnZXMpOwogCWlmICghbnBhZ2Vz
KSB7CiAJCWtmcmVlKGJ2KTsKQEAgLTM1MiwxNCArMzkxLDM0IEBAIHNzaXplX3QgY29weV9zcGxp
Y2VfcmVhZChzdHJ1Y3QgZmlsZSAqaW4sIGxvZmZfdCAqcHBvcywKIAogCXJlbWFpbiA9IGxlbiA9
IG1pbl90KHNpemVfdCwgbGVuLCBucGFnZXMgKiBQQUdFX1NJWkUpOwogCisJLyogUHVzaCB0aGVt
IGludG8gdGhlIHBpcGUgYW5kIGJ1aWxkIHVwIHRoZSBiaW9fdmVjICovCiAJZm9yIChpID0gMDsg
aSA8IG5wYWdlczsgaSsrKSB7CisJCXN0cnVjdCBwaXBlX2J1ZmZlciAqYnVmID0gcGlwZV9oZWFk
X2J1ZihwaXBlKTsKKwkJc3RydWN0IHBhZ2UgKnBhZ2UgPSBwYWdlc1tpXTsKKworCQlwaXBlLT5o
ZWFkKys7CisJCWxvY2tfcGFnZShwYWdlKTsKKwkJKmJ1ZiA9IChzdHJ1Y3QgcGlwZV9idWZmZXIp
IHsKKwkJCS5vcHMJPSAmYnVzeV9waXBlX2J1Zl9vcHMsCisJCQkucGFnZQk9IHBhZ2UsCisJCQku
b2Zmc2V0CT0gMCwKKwkJCS5sZW4JPSBjaHVuaywKKwkJfTsKKwkJYnVmc1tpXSA9IGJ1ZjsKKwog
CQljaHVuayA9IG1pbl90KHNpemVfdCwgUEFHRV9TSVpFLCByZW1haW4pOwotCQlidltpXS5idl9w
YWdlID0gcGFnZXNbaV07CisJCWJ2W2ldLmJ2X3BhZ2UgPSBwYWdlOwogCQlidltpXS5idl9vZmZz
ZXQgPSAwOwogCQlidltpXS5idl9sZW4gPSBjaHVuazsKIAkJcmVtYWluIC09IGNodW5rOwogCX0K
IAorCS8qCisJICogV2UgaGF2ZSBub3cgcmVzZXJ2ZWQgdGhlIHNwYWNlIHdpdGggbG9ja2VkIHBh
Z2VzLAorCSAqIGFuZCBjYW4gdW5sb2NrIHRoZSBwaXBlIGR1cmluZyB0aGUgSU8uCisJICovCisJ
cGlwZV91bmxvY2socGlwZSk7CisKIAkvKiBEbyB0aGUgSS9PICovCiAJaW92X2l0ZXJfYnZlYygm
dG8sIElURVJfREVTVCwgYnYsIG5wYWdlcywgbGVuKTsKIAlpbml0X3N5bmNfa2lvY2IoJmtpb2Ni
LCBpbik7CkBAIC0zNzgsMjYgKzQzNywyMiBAQCBzc2l6ZV90IGNvcHlfc3BsaWNlX3JlYWQoc3Ry
dWN0IGZpbGUgKmluLCBsb2ZmX3QgKnBwb3MsCiAJaWYgKHJldCA9PSAtRUZBVUxUKQogCQlyZXQg
PSAtRUFHQUlOOwogCi0JLyogRnJlZSBhbnkgcGFnZXMgdGhhdCBkaWRuJ3QgZ2V0IHRvdWNoZWQg
YXQgYWxsLiAqLwotCWlmIChrZWVwIDwgbnBhZ2VzKQotCQlyZWxlYXNlX3BhZ2VzKHBhZ2VzICsg
a2VlcCwgbnBhZ2VzIC0ga2VlcCk7Ci0KLQkvKiBQdXNoIHRoZSByZW1haW5pbmcgcGFnZXMgaW50
byB0aGUgcGlwZS4gKi8KKwkvKiBVcGRhdGUgdGhlIHBhZ2Ugc3RhdGUgaW4gdGhlIHBpcGUgKi8K
IAlyZW1haW4gPSByZXQ7Ci0JZm9yIChpID0gMDsgaSA8IGtlZXA7IGkrKykgewotCQlzdHJ1Y3Qg
cGlwZV9idWZmZXIgKmJ1ZiA9IHBpcGVfaGVhZF9idWYocGlwZSk7CisJZm9yIChpID0gMDsgaSA8
IG5wYWdlczsgaSsrKSB7CisJCXN0cnVjdCBwaXBlX2J1ZmZlciAqYnVmID0gYnVmc1tpXTsKIAog
CQljaHVuayA9IG1pbl90KHNpemVfdCwgcmVtYWluLCBQQUdFX1NJWkUpOwotCQkqYnVmID0gKHN0
cnVjdCBwaXBlX2J1ZmZlcikgewotCQkJLm9wcwk9ICZkZWZhdWx0X3BpcGVfYnVmX29wcywKLQkJ
CS5wYWdlCT0gYnZbaV0uYnZfcGFnZSwKLQkJCS5vZmZzZXQJPSAwLAotCQkJLmxlbgk9IGNodW5r
LAotCQl9OwotCQlwaXBlLT5oZWFkKys7CiAJCXJlbWFpbiAtPSBjaHVuazsKKworCQkvKgorCQkg
KiBOT1RFISBUaGUgc2l6ZSBtaWdodCBoYXZlIGNoYW5nZWQsIGFuZAorCQkgKiBjaHVuayBtYXkg
YmUgc21hbGxlciBvciB6ZXJvIQorCQkgKi8KKwkJZmluYWxpemVfcGlwZV9idWYoYnVmLCBjaHVu
ayk7CiAJfQogCisJcGlwZV9sb2NrKHBpcGUpOwogCWtmcmVlKGJ2KTsKIAlyZXR1cm4gcmV0Owog
fQpAQCAtNDU1LDEwICs1MTAsNiBAQCBzdGF0aWMgaW50IHNwbGljZV9mcm9tX3BpcGVfZmVlZChz
dHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLCBzdHJ1Y3Qgc3BsaWNlX2RlcwogCXdoaWxlICgh
cGlwZV9lbXB0eShoZWFkLCB0YWlsKSkgewogCQlzdHJ1Y3QgcGlwZV9idWZmZXIgKmJ1ZiA9ICZw
aXBlLT5idWZzW3RhaWwgJiBtYXNrXTsKIAotCQlzZC0+bGVuID0gYnVmLT5sZW47Ci0JCWlmIChz
ZC0+bGVuID4gc2QtPnRvdGFsX2xlbikKLQkJCXNkLT5sZW4gPSBzZC0+dG90YWxfbGVuOwotCiAJ
CXJldCA9IHBpcGVfYnVmX2NvbmZpcm0ocGlwZSwgYnVmKTsKIAkJaWYgKHVubGlrZWx5KHJldCkp
IHsKIAkJCWlmIChyZXQgPT0gLUVOT0RBVEEpCkBAIC00NjYsNiArNTE3LDEwIEBAIHN0YXRpYyBp
bnQgc3BsaWNlX2Zyb21fcGlwZV9mZWVkKHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsIHN0
cnVjdCBzcGxpY2VfZGVzCiAJCQlyZXR1cm4gcmV0OwogCQl9CiAKKwkJc2QtPmxlbiA9IGJ1Zi0+
bGVuOworCQlpZiAoc2QtPmxlbiA+IHNkLT50b3RhbF9sZW4pCisJCQlzZC0+bGVuID0gc2QtPnRv
dGFsX2xlbjsKKwogCQlyZXQgPSBhY3RvcihwaXBlLCBidWYsIHNkKTsKIAkJaWYgKHJldCA8PSAw
KQogCQkJcmV0dXJuIHJldDsKQEAgLTcxNSwxMiArNzcwLDcgQEAgaXRlcl9maWxlX3NwbGljZV93
cml0ZShzdHJ1Y3QgcGlwZV9pbm9kZV9pbmZvICpwaXBlLCBzdHJ1Y3QgZmlsZSAqb3V0LAogCQls
ZWZ0ID0gc2QudG90YWxfbGVuOwogCQlmb3IgKG4gPSAwOyAhcGlwZV9lbXB0eShoZWFkLCB0YWls
KSAmJiBsZWZ0ICYmIG4gPCBuYnVmczsgdGFpbCsrKSB7CiAJCQlzdHJ1Y3QgcGlwZV9idWZmZXIg
KmJ1ZiA9ICZwaXBlLT5idWZzW3RhaWwgJiBtYXNrXTsKLQkJCXNpemVfdCB0aGlzX2xlbiA9IGJ1
Zi0+bGVuOwotCi0JCQkvKiB6ZXJvLWxlbmd0aCBidmVjcyBhcmUgbm90IHN1cHBvcnRlZCwgc2tp
cCB0aGVtICovCi0JCQlpZiAoIXRoaXNfbGVuKQotCQkJCWNvbnRpbnVlOwotCQkJdGhpc19sZW4g
PSBtaW4odGhpc19sZW4sIGxlZnQpOworCQkJc2l6ZV90IHRoaXNfbGVuOwogCiAJCQlyZXQgPSBw
aXBlX2J1Zl9jb25maXJtKHBpcGUsIGJ1Zik7CiAJCQlpZiAodW5saWtlbHkocmV0KSkgewpAQCAt
NzI5LDYgKzc3OSwxMiBAQCBpdGVyX2ZpbGVfc3BsaWNlX3dyaXRlKHN0cnVjdCBwaXBlX2lub2Rl
X2luZm8gKnBpcGUsIHN0cnVjdCBmaWxlICpvdXQsCiAJCQkJZ290byBkb25lOwogCQkJfQogCisJ
CQkvKiB6ZXJvLWxlbmd0aCBidmVjcyBhcmUgbm90IHN1cHBvcnRlZCwgc2tpcCB0aGVtICovCisJ
CQl0aGlzX2xlbiA9IGJ1Zi0+bGVuOworCQkJaWYgKCF0aGlzX2xlbikKKwkJCQljb250aW51ZTsK
KwkJCXRoaXNfbGVuID0gbWluKHRoaXNfbGVuLCBsZWZ0KTsKKwogCQkJYnZlY19zZXRfcGFnZSgm
YXJyYXlbbl0sIGJ1Zi0+cGFnZSwgdGhpc19sZW4sCiAJCQkJICAgICAgYnVmLT5vZmZzZXQpOwog
CQkJbGVmdCAtPSB0aGlzX2xlbjsKQEAgLTg0NywxMyArOTAzLDYgQEAgc3NpemVfdCBzcGxpY2Vf
dG9fc29ja2V0KHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUsIHN0cnVjdCBmaWxlICpvdXQs
CiAJCQlzdHJ1Y3QgcGlwZV9idWZmZXIgKmJ1ZiA9ICZwaXBlLT5idWZzW3RhaWwgJiBtYXNrXTsK
IAkJCXNpemVfdCBzZWc7CiAKLQkJCWlmICghYnVmLT5sZW4pIHsKLQkJCQl0YWlsKys7Ci0JCQkJ
Y29udGludWU7Ci0JCQl9Ci0KLQkJCXNlZyA9IG1pbl90KHNpemVfdCwgcmVtYWluLCBidWYtPmxl
bik7Ci0KIAkJCXJldCA9IHBpcGVfYnVmX2NvbmZpcm0ocGlwZSwgYnVmKTsKIAkJCWlmICh1bmxp
a2VseShyZXQpKSB7CiAJCQkJaWYgKHJldCA9PSAtRU5PREFUQSkKQEAgLTg2MSw2ICs5MTAsMTMg
QEAgc3NpemVfdCBzcGxpY2VfdG9fc29ja2V0KHN0cnVjdCBwaXBlX2lub2RlX2luZm8gKnBpcGUs
IHN0cnVjdCBmaWxlICpvdXQsCiAJCQkJYnJlYWs7CiAJCQl9CiAKKwkJCWlmICghYnVmLT5sZW4p
IHsKKwkJCQl0YWlsKys7CisJCQkJY29udGludWU7CisJCQl9CisKKwkJCXNlZyA9IG1pbl90KHNp
emVfdCwgcmVtYWluLCBidWYtPmxlbik7CisKIAkJCWJ2ZWNfc2V0X3BhZ2UoJmJ2ZWNbYmMrK10s
IGJ1Zi0+cGFnZSwgc2VnLCBidWYtPm9mZnNldCk7CiAJCQlyZW1haW4gLT0gc2VnOwogCQkJaWYg
KHJlbWFpbiA9PSAwIHx8IGJjID49IEFSUkFZX1NJWkUoYnZlYykpCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L3BhZ2VtYXAuaCBiL2luY2x1ZGUvbGludXgvcGFnZW1hcC5oCmluZGV4IDcxNjk1
M2VlMWViZC4uY2M1MWVhOTEwYTkxIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L3BhZ2VtYXAu
aAorKysgYi9pbmNsdWRlL2xpbnV4L3BhZ2VtYXAuaApAQCAtMTAxOCw2ICsxMDE4LDcgQEAgc3Rh
dGljIGlubGluZSBib29sIGZvbGlvX2xvY2tfb3JfcmV0cnkoc3RydWN0IGZvbGlvICpmb2xpbywK
ICAqLwogdm9pZCBmb2xpb193YWl0X2JpdChzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQgYml0X25y
KTsKIGludCBmb2xpb193YWl0X2JpdF9raWxsYWJsZShzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQg
Yml0X25yKTsKK2ludCBmb2xpb193YWl0X2JpdF9pbnRlcnJ1cHRpYmxlKHN0cnVjdCBmb2xpbyAq
Zm9saW8sIGludCBiaXRfbnIpOwogCiAvKiAKICAqIFdhaXQgZm9yIGEgZm9saW8gdG8gYmUgdW5s
b2NrZWQuCmRpZmYgLS1naXQgYS9tbS9maWxlbWFwLmMgYi9tbS9maWxlbWFwLmMKaW5kZXggOWU0
NGE0OWJiZDc0Li5lMzZlMDUyYmI5OTEgMTAwNjQ0Ci0tLSBhL21tL2ZpbGVtYXAuYworKysgYi9t
bS9maWxlbWFwLmMKQEAgLTE0NTAsNiArMTQ1MCwxMiBAQCBpbnQgZm9saW9fd2FpdF9iaXRfa2ls
bGFibGUoc3RydWN0IGZvbGlvICpmb2xpbywgaW50IGJpdF9ucikKIH0KIEVYUE9SVF9TWU1CT0wo
Zm9saW9fd2FpdF9iaXRfa2lsbGFibGUpOwogCitpbnQgZm9saW9fd2FpdF9iaXRfaW50ZXJydXB0
aWJsZShzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQgYml0X25yKQoreworCXJldHVybiBmb2xpb193
YWl0X2JpdF9jb21tb24oZm9saW8sIGJpdF9uciwgVEFTS19JTlRFUlJVUFRJQkxFLCBTSEFSRUQp
OworfQorRVhQT1JUX1NZTUJPTChmb2xpb193YWl0X2JpdF9pbnRlcnJ1cHRpYmxlKTsKKwogLyoq
CiAgKiBmb2xpb19wdXRfd2FpdF9sb2NrZWQgLSBEcm9wIGEgcmVmZXJlbmNlIGFuZCB3YWl0IGZv
ciBpdCB0byBiZSB1bmxvY2tlZAogICogQGZvbGlvOiBUaGUgZm9saW8gdG8gd2FpdCBmb3IuCi0t
IAoyLjQxLjAuMjAzLmdhNGYyY2QzMmJiLmRpcnR5Cgo=
--000000000000a4b41205ffd898be--
