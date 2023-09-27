Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23BE7B0B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjI0Rsp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 13:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Rsn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:48:43 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07FE5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:41 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c15463ddd4so132845161fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695836919; x=1696441719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVfo3IwQ/RTkqzINk2Et8vGqwK+wAQzTwLtlllfdR+g=;
        b=NWkaqTRvPuIJ1XiR1GDM4gQxE3IC2fSXo1u09TfkDUI7VXjlgLEIPOg59V6ljKlm4f
         4QTehWfgNac2YzoAAmcMYKdyHaHlZhxKjKPgNN6TjHTIZrk3fTRsNzutrbNE1FAPnpUD
         0jRAu5iflfDNE+VWOixhO9xfniAePa6iPPskM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695836919; x=1696441719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVfo3IwQ/RTkqzINk2Et8vGqwK+wAQzTwLtlllfdR+g=;
        b=oKt2QNKSQIxzQlF0U4nGwSlOz5QheT2wK9grAm9ePM54yIFcVcch2LrLeQLoCGGhGZ
         JwG7eW9eEyuyc6ge3pVErErNbreS3otLJBRnTa65CYs21khYyLFetFsJnY2hEr45Ajgt
         LDcUE3PD0q9wOi50Fs5HAt8lkNlNZhv3I7cbFU9p3lF3zdGXtDiGyvYL/9Zmd3yGcX3S
         5e4FeLOmvAqbs0uvB4HZnl1pxOVe75dvGt6Ltwjwv4eMzwsZrgcGFV1brQ97+8kfWCxn
         RXPM68kWA3kjgzQneDC3C5Uc99XQ4FkFCSWGfd/rfCv2gUgz3iCE1m39Y7yxYEVxLRpp
         xNSw==
X-Gm-Message-State: AOJu0Ywps+6fl3LXnWXIt/DPslaoqWuDm9hbvFS0Zk0ERlYIOipeGMiF
        HutlZtVNVtDCLb00QaRVJ1mZB+NbQC+s6Knzpbj51w==
X-Google-Smtp-Source: AGHT+IEZnnJ4084CHau1A67peMTTMLepZtC7OahzKmjFf2CjnlUe87VsxsOPajox8AcGtVKdhZsV/A==
X-Received: by 2002:a2e:8506:0:b0:2b9:e6a0:5c3a with SMTP id j6-20020a2e8506000000b002b9e6a05c3amr2609851lji.48.1695836919156;
        Wed, 27 Sep 2023 10:48:39 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id mh2-20020a170906eb8200b0099e12a49c8fsm9666183ejb.173.2023.09.27.10.48.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 10:48:37 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so13753427a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 10:48:37 -0700 (PDT)
X-Received: by 2002:aa7:c406:0:b0:52e:9eff:1e5f with SMTP id
 j6-20020aa7c406000000b0052e9eff1e5fmr2377804edq.15.1695836917305; Wed, 27 Sep
 2023 10:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230926162228.68666-1-mjguzik@gmail.com> <CAHk-=wjUCLfuKks-VGTG9hrFAORb5cuzqyC0gRXptYGGgL=YYg@mail.gmail.com>
 <CAGudoHGej+gmmv0OOoep2ENkf7hMBib-KL44Fu=Ym46j=r6VEA@mail.gmail.com> <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
In-Reply-To: <20230927-kosmetik-babypuppen-75bee530b9f0@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2023 10:48:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
Message-ID: <CAHk-=whLadznjNKZPYUjxVzAyCH-rRhb24_KaGegKT9E6A86Kg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: shave work on failed file open
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000dc77506065acdeb"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000000dc77506065acdeb
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Sept 2023 at 07:10, Christian Brauner <brauner@kernel.org> wrote:
>
> No need to resend I can massage this well enough in-tree.

Hmm. Please do, but here's some more food for thought for at least the
commit message.

Because there's more than the "__fput_sync()" issue at hand, we have
another delayed thing that this patch ends up short-circuiting, which
wasn't obvious from the original description.

I'm talking about the fact that our existing "file_free()" ends up
doing the actual release with

        call_rcu(&f->f_rcuhead, file_free_rcu);

and the patch under discussion avoids that part too.

And I actually like that it avoids it, I just think it should be
mentioned explicitly, because it wasn't obvious to me until I actually
looked at the old __fput() path. Particularly since it means that the
f_creds are free'd synchronously now.

I do think that's fine, although I forget what path it was that
required that rcu-delayed cred freeing. Worth mentioning, and maybe
worth thinking about.

However, when I *did* look at it, it strikes me that we could do this
differently.

Something like this (ENTIRELY UNTESTED) patch, which just moves this
logic into fput() itself.

Again: ENTIRELY UNTESTED, and I might easily have screwed up. But it
looks simpler and more straightforward to me. But again: that may be
because I missed something.

             Linus

--0000000000000dc77506065acdeb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_ln21i4ht0>
X-Attachment-Id: f_ln21i4ht0

IGZzL2ZpbGVfdGFibGUuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMv
ZmlsZV90YWJsZS5jCmluZGV4IGVlMjFiM2RhOWQwOC4uNGZiODdhMDM4MmQ5IDEwMDY0NAotLS0g
YS9mcy9maWxlX3RhYmxlLmMKKysrIGIvZnMvZmlsZV90YWJsZS5jCkBAIC00MzAsMTEgKzQzMCwz
MyBAQCBFWFBPUlRfU1lNQk9MX0dQTChmbHVzaF9kZWxheWVkX2ZwdXQpOwogCiBzdGF0aWMgREVD
TEFSRV9ERUxBWUVEX1dPUksoZGVsYXllZF9mcHV0X3dvcmssIGRlbGF5ZWRfZnB1dCk7CiAKKy8q
CisgKiBDYWxsZWQgZm9yIGZpbGVzIHRoYXQgd2VyZSBuZXZlciBmdWxseSBvcGVuZWQsIGFuZAor
ICogZG9uJ3QgbmVlZCB0aGUgUkNVLWRlbGF5ZWQgZnJlZWluZzogdGhleSBoYXZlIG5ldmVyCisg
KiBiZWVuIGFjY2Vzc2VkIGluIGFueSBvdGhlciBjb250ZXh0LgorICovCitzdGF0aWMgdm9pZCBm
cHV0X2ltbWVkaWF0ZShzdHJ1Y3QgZmlsZSAqZikKK3sKKwlzZWN1cml0eV9maWxlX2ZyZWUoZik7
CisJcHV0X2NyZWQoZi0+Zl9jcmVkKTsKKwlpZiAobGlrZWx5KCEoZi0+Zl9tb2RlICYgRk1PREVf
Tk9BQ0NPVU5UKSkpCisJCXBlcmNwdV9jb3VudGVyX2RlYygmbnJfZmlsZXMpOworCWlmICh1bmxp
a2VseShmLT5mX21vZGUgJiBGTU9ERV9CQUNLSU5HKSkgeworCQlwYXRoX3B1dChiYWNraW5nX2Zp
bGVfcmVhbF9wYXRoKGYpKTsKKwkJa2ZyZWUoYmFja2luZ19maWxlKGYpKTsKKwl9IGVsc2Ugewor
CQlrbWVtX2NhY2hlX2ZyZWUoZmlscF9jYWNoZXAsIGYpOworCX0KK30KKwogdm9pZCBmcHV0KHN0
cnVjdCBmaWxlICpmaWxlKQogewogCWlmIChhdG9taWNfbG9uZ19kZWNfYW5kX3Rlc3QoJmZpbGUt
PmZfY291bnQpKSB7CiAJCXN0cnVjdCB0YXNrX3N0cnVjdCAqdGFzayA9IGN1cnJlbnQ7CiAKKwkJ
aWYgKHVubGlrZWx5KCEoZmlsZS0+Zl9tb2RlICYgRk1PREVfT1BFTkVEKSkpCisJCQlyZXR1cm4g
ZnB1dF9pbW1lZGlhdGUoZmlsZSk7CisKIAkJaWYgKGxpa2VseSghaW5faW50ZXJydXB0KCkgJiYg
ISh0YXNrLT5mbGFncyAmIFBGX0tUSFJFQUQpKSkgewogCQkJaW5pdF90YXNrX3dvcmsoJmZpbGUt
PmZfcmN1aGVhZCwgX19fX2ZwdXQpOwogCQkJaWYgKCF0YXNrX3dvcmtfYWRkKHRhc2ssICZmaWxl
LT5mX3JjdWhlYWQsIFRXQV9SRVNVTUUpKQo=
--0000000000000dc77506065acdeb--
