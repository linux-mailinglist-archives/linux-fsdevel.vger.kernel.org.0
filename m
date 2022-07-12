Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B175727A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiGLUss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 16:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiGLUsm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:48:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96558111C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v12so11606197edc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2xMjECo2L6Z5bab111C3XqU2WKD8LDF9sxV3g46vtE=;
        b=KC1n1dnuTb2rPj+h+DUtj/t3zCstygmOXWFgP8ycXaeJHcBPUyPB6u1AQaGRSI3PuV
         i8bgNBdguTONKpiBCmA/XD/cZSxLZcawnzecE0g5Mo1zVBH5iJ5jNxNofUgWCoFOCHfX
         eHsxRHvzGaVVN5mCseuA8N2mnhjQxP/3tc548=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P2xMjECo2L6Z5bab111C3XqU2WKD8LDF9sxV3g46vtE=;
        b=NWrKIYdjRBZKyBHdwOGkUF8lFF697qoBeldU2vz/68Au/OGlsK3ew0PZZS2WcHzO76
         oDfPGa8otf3fL/KQVFC5olJIJ9btqzzjZ0jsjKmN1DxrRy3KK0n0WWdZOhZjG6fmDekE
         AuPA5HMPlW4mfeIceUGeDS4cQPfAlsDjEETxPg4Rnm8rfYXNhTCDgtWD7/Tc1Gkmo7hi
         FrJHBk0b3MySY09V6YSmab7WUkU+azJpz8IR5ZLpr22EupoBC6CKqT04lZXo+2RJMDAe
         9aFs4STGOQeoovwjkZTlHB5bxJZNblz3gY98GD/kt+uO6UrLjsDRaCzgVNMFvnVLlfDI
         2cRw==
X-Gm-Message-State: AJIora/SzUVk3Z7PJz2/odSCeA4HozjtjjCToHiwlghf1QurnFa0WxdN
        v5Cc8obUu4UB5fsfEby0sYiImWyI86+wM00RY2Q=
X-Google-Smtp-Source: AGRyM1vMMs1OnfRPkrkdtgBGYu65RqOTpeFm7428U7Flcs9ME8y4+l4YPGHqD6NwXMKKh2yRXB6MLQ==
X-Received: by 2002:aa7:ce8a:0:b0:43a:7b0e:9950 with SMTP id y10-20020aa7ce8a000000b0043a7b0e9950mr34705706edv.58.1657658917865;
        Tue, 12 Jul 2022 13:48:37 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906169000b0072b13ac9ca3sm4166556ejd.183.2022.07.12.13.48.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 13:48:35 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id l22-20020a05600c4f1600b003a2e10c8cdeso1278860wmq.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 13:48:34 -0700 (PDT)
X-Received: by 2002:a05:600c:34c9:b0:3a0:5072:9abe with SMTP id
 d9-20020a05600c34c900b003a050729abemr5856957wmq.8.1657658914529; Tue, 12 Jul
 2022 13:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
 <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
 <CAEzrpqdweuZ2ufMKDJwSzP5W021F7mgS+7toSo6VDgvDzd0ZqA@mail.gmail.com>
 <CAHk-=wgEgAjX5gRntm0NutaNtjkzN+OaJVMaJAqved4dxPtAqw@mail.gmail.com> <Ys3TrAf95FpRgr+P@localhost.localdomain>
In-Reply-To: <Ys3TrAf95FpRgr+P@localhost.localdomain>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 13:48:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
Message-ID: <CAHk-=wi1-o-3iF09+PnNHq6_HLQhRn+32ow_f44to7_JuNCUoA@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: multipart/mixed; boundary="000000000000c299fd05e3a1caab"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000c299fd05e3a1caab
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 12, 2022 at 1:04 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Yeah I'm fine with removing the inode_permission(), I just want to make sure
> we're consistent across all of our IO related operations.  It looks like at the
> very least we're getting security_*_permission on things like
> read/write/fallocate, so perhaps switch to that here and call it good enough?

remap_verify_area() already does that, afaik.

The more I look at the remap_range stuff, the more I feel it is very
ad-hoc and nobody really thought deeply about it.

What about an append-only destination? Is that kind of write supposed
to be ok because it's just REMAP_FILE_DEDUP? The open side should
already have checked for IS_IMMUTABLE, but O_APPEND is a thing?

I'm getting the feeling that somebody really needs to think about what
the semantics should be.

In the meantime, I think that requiring the block size alignment is
the important part here. The "check read permissions" is kind of a
non-issue, since we already have that mmap() case.

Strangely, it *does* check that the position is aligned for remapping
in .generic_remap_checks(). And not at all for dedupe.

And even for remapping, the size alignment is a bit strange. It takes
the "source EOF" into account, but what if the destination file is big
enough that that's not the end?

And the inode_permission() check is wrong, but at least it does have
the important check there (ie that FMODE_WRITE one). So doing the
inode_permissions() check at worst just makes it fail too often, but
since it's all a "optimistically dedupe" anyway, that kind of "fail in
odd situations" doesn't really matter.

So for allow_file_dedupe(), I'd suggest:

 (a) remove the inode_permission() check in allow_file_dedupe()

 (b) remove the uid_eq() check for the same reason (if you didn't open
the destination for write, you have no business deduping anything,
even if you're the owner)

 (c) add a "can't do it for APPEND_ONLY" (but let the CAP_SYS_ADMIN override it)

AND I'd add a "make sure it's all block-aligned" check for both the
source and each destination chunk.

Something like the attached, IOW. Entirely untested, this is not meant
to be applied as-is, this is meant to be the basis of discussion.

Btw, the generic_remap_file_range_prep() IS_IMMUTABLE check seems
bogus too. How could it possibly be immutable if we've opened the
target for writing?

So all of this seems a bit confused. It really smells like "filesystem
people wrote this with low-level filesystem rules in mind, rather than
any kind of high-level understanding or conceptual rules"

Hmm?

                 Linus

--000000000000c299fd05e3a1caab
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_l5inawrz0>
X-Attachment-Id: f_l5inawrz0

IGZzL3JlbWFwX3JhbmdlLmMgfCAyNyArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL3JlbWFwX3JhbmdlLmMgYi9mcy9yZW1hcF9yYW5nZS5jCmluZGV4IGUxMTJiNTQyNGNkYi4u
YmE3MWNlYjhkZGUzIDEwMDY0NAotLS0gYS9mcy9yZW1hcF9yYW5nZS5jCisrKyBiL2ZzL3JlbWFw
X3JhbmdlLmMKQEAgLTQwOSwxNyArNDA5LDEyIEBAIEVYUE9SVF9TWU1CT0wodmZzX2Nsb25lX2Zp
bGVfcmFuZ2UpOwogLyogQ2hlY2sgd2hldGhlciB3ZSBhcmUgYWxsb3dlZCB0byBkZWR1cGUgdGhl
IGRlc3RpbmF0aW9uIGZpbGUgKi8KIHN0YXRpYyBib29sIGFsbG93X2ZpbGVfZGVkdXBlKHN0cnVj
dCBmaWxlICpmaWxlKQogewotCXN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucyA9IGZp
bGVfbW50X3VzZXJfbnMoZmlsZSk7Ci0Jc3RydWN0IGlub2RlICppbm9kZSA9IGZpbGVfaW5vZGUo
ZmlsZSk7Ci0KIAlpZiAoY2FwYWJsZShDQVBfU1lTX0FETUlOKSkKIAkJcmV0dXJuIHRydWU7CisJ
aWYgKGZpbGUtPmZfZmxhZ3MgJiBPX0FQUEVORCkKKwkJcmV0dXJuIGZhbHNlOwogCWlmIChmaWxl
LT5mX21vZGUgJiBGTU9ERV9XUklURSkKIAkJcmV0dXJuIHRydWU7Ci0JaWYgKHVpZF9lcShjdXJy
ZW50X2ZzdWlkKCksIGlfdWlkX2ludG9fbW50KG1udF91c2VybnMsIGlub2RlKSkpCi0JCXJldHVy
biB0cnVlOwotCWlmICghaW5vZGVfcGVybWlzc2lvbihtbnRfdXNlcm5zLCBpbm9kZSwgTUFZX1dS
SVRFKSkKLQkJcmV0dXJuIHRydWU7CiAJcmV0dXJuIGZhbHNlOwogfQogCkBAIC00MjgsNiArNDIz
LDggQEAgbG9mZl90IHZmc19kZWR1cGVfZmlsZV9yYW5nZV9vbmUoc3RydWN0IGZpbGUgKnNyY19m
aWxlLCBsb2ZmX3Qgc3JjX3BvcywKIAkJCQkgbG9mZl90IGxlbiwgdW5zaWduZWQgaW50IHJlbWFw
X2ZsYWdzKQogewogCWxvZmZfdCByZXQ7CisJc3RydWN0IGlub2RlICpkc3Q7CisJdW5zaWduZWQg
bG9uZyBibG9ja3NpemU7CiAKIAlXQVJOX09OX09OQ0UocmVtYXBfZmxhZ3MgJiB+KFJFTUFQX0ZJ
TEVfREVEVVAgfAogCQkJCSAgICAgUkVNQVBfRklMRV9DQU5fU0hPUlRFTikpOwpAQCAtNDU3LDEw
ICs0NTQsMTcgQEAgbG9mZl90IHZmc19kZWR1cGVfZmlsZV9yYW5nZV9vbmUoc3RydWN0IGZpbGUg
KnNyY19maWxlLCBsb2ZmX3Qgc3JjX3BvcywKIAkJZ290byBvdXRfZHJvcF93cml0ZTsKIAogCXJl
dCA9IC1FSVNESVI7Ci0JaWYgKFNfSVNESVIoZmlsZV9pbm9kZShkc3RfZmlsZSktPmlfbW9kZSkp
CisJZHN0ID0gZmlsZV9pbm9kZShkc3RfZmlsZSk7CisJaWYgKFNfSVNESVIoZHN0LT5pX21vZGUp
KQogCQlnb3RvIG91dF9kcm9wX3dyaXRlOwogCiAJcmV0ID0gLUVJTlZBTDsKKwlibG9ja3NpemUg
PSAxdWwgPDwgZHN0LT5pX2Jsa2JpdHM7CisJaWYgKGRzdF9wb3MgJiAoYmxvY2tzaXplLTEpKQor
CQlnb3RvIG91dF9kcm9wX3dyaXRlOworCWlmIChsZW4gJiAoYmxvY2tzaXplLTEpKQorCQlnb3Rv
IG91dF9kcm9wX3dyaXRlOworCiAJaWYgKCFkc3RfZmlsZS0+Zl9vcC0+cmVtYXBfZmlsZV9yYW5n
ZSkKIAkJZ290byBvdXRfZHJvcF93cml0ZTsKIApAQCAtNDg4LDYgKzQ5Miw3IEBAIGludCB2ZnNf
ZGVkdXBlX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBmaWxlX2RlZHVwZV9y
YW5nZSAqc2FtZSkKIAlpbnQgcmV0OwogCXUxNiBjb3VudCA9IHNhbWUtPmRlc3RfY291bnQ7CiAJ
bG9mZl90IGRlZHVwZWQ7CisJdW5zaWduZWQgbG9uZyBibG9ja3NpemU7CiAKIAlpZiAoIShmaWxl
LT5mX21vZGUgJiBGTU9ERV9SRUFEKSkKIAkJcmV0dXJuIC1FSU5WQUw7CkBAIC01MDcsNiArNTEy
LDEyIEBAIGludCB2ZnNfZGVkdXBlX2ZpbGVfcmFuZ2Uoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVj
dCBmaWxlX2RlZHVwZV9yYW5nZSAqc2FtZSkKIAlpZiAoIWZpbGUtPmZfb3AtPnJlbWFwX2ZpbGVf
cmFuZ2UpCiAJCXJldHVybiAtRU9QTk9UU1VQUDsKIAorCWJsb2Nrc2l6ZSA9IDF1bCA8PCBzcmMt
PmlfYmxrYml0czsKKwlpZiAob2ZmICYgKGJsb2Nrc2l6ZS0xKSkKKwkJcmV0dXJuIC1FSU5WQUw7
CisJaWYgKGxlbiAmIChibG9ja3NpemUtMSkpCisJCXJldHVybiAtRUlOVkFMOworCiAJcmV0ID0g
cmVtYXBfdmVyaWZ5X2FyZWEoZmlsZSwgb2ZmLCBsZW4sIGZhbHNlKTsKIAlpZiAocmV0IDwgMCkK
IAkJcmV0dXJuIHJldDsK
--000000000000c299fd05e3a1caab--
