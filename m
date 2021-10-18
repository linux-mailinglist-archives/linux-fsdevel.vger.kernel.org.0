Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC474317BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhJRLsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhJRLsJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:48:09 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E195EC061714
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 04:45:58 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id r17so580929uaf.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 04:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVr2X8Nj20JjIMTBk+fLD1T6meS5FDSG/blTfX6AM6s=;
        b=UfaW+ObwCIYfOTB1EvgeCeOtZ0/eTvf+d9n5KZgAyYJpRpqVHPAhmNDuc+Owm9SDW8
         PVnrV9eCem5UispgIr0NcElB0LpnoTAPexFiLVvwZ1mq4SP+w2fCZJTY+up/t4xuZEpw
         dW71tx0lv/XkJ4tT7EhqfTgUQfpxNRebu+yOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVr2X8Nj20JjIMTBk+fLD1T6meS5FDSG/blTfX6AM6s=;
        b=byE6nuBcpwoWVbAAvEUnldiiozTuYo3Nb4IEFInPnFOktzGQbjSrpvNCoVqU2qVcEc
         Zh1zcEEtxDbVr3TeUP03yXdtUriBXa5V601AsGYfRF/IykrMwiSKKZnhSSBIOa6lQmt+
         dNkYqLh5PR57N19Ghs81ejo2QslReHvTOnnwEgVLTwm+VLsTY6oEAiAhKzGrMGfe+viq
         adGGhavYcOtdtV+XAj3ZBdz0v6kKfm9C4JL2ixDh8W0zYdrk7Erv/wTWpK+Jshz4llZm
         IniA2riW1X6qY7IPfcM4XpToOHxeTGC0PTh947uXxeMRdzKtjhB5aKGdTwV1N0REA2Vc
         pypg==
X-Gm-Message-State: AOAM530shaUFf2iH8PGEhlRSpAQgm0z80X/H+5SvNJY3Ikzt6Q0byy9E
        5GMTH7RRTFPn5Sn9jtqduHwWYJi88VJq9vFFyey3TQ==
X-Google-Smtp-Source: ABdhPJxH0mEle46xQu+ztKdo3qwchwzxWZObK70qkVAaI3Ee2i9J3gv/Ut2TVOtxBTP6hHWjYUs64FAbrFka86iJhJE=
X-Received: by 2002:a67:d316:: with SMTP id a22mr26203833vsj.19.1634557557902;
 Mon, 18 Oct 2021 04:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com> <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
 <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com>
 <CAJfpeguaRjQ9Fd1S4NHx5XVF89PGgFBxW3Xf=XNrb1QQRbDbYQ@mail.gmail.com> <CACycT3s=aC6eWfo0LHMuE6sVVErjkZPScsgaBGn4QABbZE2a9g@mail.gmail.com>
In-Reply-To: <CACycT3s=aC6eWfo0LHMuE6sVVErjkZPScsgaBGn4QABbZE2a9g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Oct 2021 13:45:47 +0200
Message-ID: <CAJfpegv51cbjkD6BQ6wUZSbaTpnB1-827G++HQnWX7zGA5fmmA@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Content-Type: multipart/mixed; boundary="0000000000009ac49605ce9f16be"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--0000000000009ac49605ce9f16be
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Oct 2021 at 13:25, Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Oct 13, 2021 at 9:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Mon, 11 Oct 2021 at 16:45, Yongji Xie <xieyongji@bytedance.com> wrote:
> > >
> > > On Mon, Oct 11, 2021 at 9:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
> > > > >
> > > > > Recently we found the performance of small direct writes is bad
> > > > > when writeback_cache enabled. This is because we need to get
> > > > > attrs from userspace in fuse_update_get_attr() on each write.
> > > > > The timeout for the attributes doesn't work since every direct write
> > > > > will invalidate the attrs in fuse_direct_IO().
> > > > >
> > > > > To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> > > > > is enabled since we should trust local size/ctime/mtime in this case.
> > > >
> > > > Hi,
> > > >
> > > > Thanks for the patch.
> > > >
> > > > Just pushed an update to
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
> > > > (9ca3f8697158 ("fuse: selective attribute invalidation")) that should
> > > > fix this behavior.
> > > >
> > >
> > > Looks like fuse_update_get_attr() will still get attrs from userspace
> > > each time with this commit applied.
> > >
> > > > Could you please test?
> > > >
> > >
> > > I applied the commit 9ca3f8697158 ("fuse: selective attribute
> > > invalidation")  and tested it. But the issue still exists.
> >
> > Yeah, my bad.  Pushed a more complete set of fixes to #for-next ending with
> >
> > e15a9a5fca6c ("fuse: take cache_mask into account in getattr")
> >
> > You should pull or cherry pick the complete branch.
> >
>
> I tested this branch, but it still doesn't fix this issue. The
> inval_mask = 0x6C0 and cache_mask = 0x2C0, so we still need to get
> attrs from userspace. Should we add STATX_BLOCKS to cache_mask?

Does the attach incremental ~/gupatch solve this?  Or is the
fuse_update_get_attr() coming from a stat* syscall?

Thanks,
Miklos

--0000000000009ac49605ce9f16be
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-only-update-necessary-attributes.patch"
Content-Disposition: attachment; 
	filename="fuse-only-update-necessary-attributes.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kuwlcg6w0>
X-Attachment-Id: f_kuwlcg6w0

SW5kZXg6IGxpbnV4L2ZzL2Z1c2UvZGlyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgub3JpZy9mcy9m
dXNlL2Rpci5jCTIwMjEtMTAtMTggMTM6NDA6MjcuMzgxODAxMDMyICswMjAwCisrKyBsaW51eC9m
cy9mdXNlL2Rpci5jCTIwMjEtMTAtMTggMTM6Mzc6MjYuNzk4NTY5NDk2ICswMjAwCkBAIC0xMDU1
LDExICsxMDU1LDkgQEAgc3RhdGljIGludCBmdXNlX3VwZGF0ZV9nZXRfYXR0cihzdHJ1Y3QgaQog
CXJldHVybiBlcnI7CiB9CiAKLWludCBmdXNlX3VwZGF0ZV9hdHRyaWJ1dGVzKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQoraW50IGZ1c2VfdXBkYXRlX2F0dHJpYnV0ZXMo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUsIHUzMiBtYXNrKQogewotCS8q
IERvICpub3QqIG5lZWQgdG8gZ2V0IGF0aW1lIGZvciBpbnRlcm5hbCBwdXJwb3NlcyAqLwotCXJl
dHVybiBmdXNlX3VwZGF0ZV9nZXRfYXR0cihpbm9kZSwgZmlsZSwgTlVMTCwKLQkJCQkgICAgU1RB
VFhfQkFTSUNfU1RBVFMgJiB+U1RBVFhfQVRJTUUsIDApOworCXJldHVybiBmdXNlX3VwZGF0ZV9n
ZXRfYXR0cihpbm9kZSwgZmlsZSwgTlVMTCwgbWFzaywgMCk7CiB9CiAKIGludCBmdXNlX3JldmVy
c2VfaW52YWxfZW50cnkoc3RydWN0IGZ1c2VfY29ubiAqZmMsIHU2NCBwYXJlbnRfbm9kZWlkLApJ
bmRleDogbGludXgvZnMvZnVzZS9maWxlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgub3JpZy9mcy9m
dXNlL2ZpbGUuYwkyMDIxLTEwLTE4IDEzOjQwOjI3LjM4MjgwMTA0NCArMDIwMAorKysgbGludXgv
ZnMvZnVzZS9maWxlLmMJMjAyMS0xMC0xOCAxMzo0MDoxNC41MDQ2NDE5MDQgKzAyMDAKQEAgLTk5
Niw3ICs5OTYsNyBAQCBzdGF0aWMgc3NpemVfdCBmdXNlX2NhY2hlX3JlYWRfaXRlcihzdHJ1CiAJ
aWYgKGZjLT5hdXRvX2ludmFsX2RhdGEgfHwKIAkgICAgKGlvY2ItPmtpX3BvcyArIGlvdl9pdGVy
X2NvdW50KHRvKSA+IGlfc2l6ZV9yZWFkKGlub2RlKSkpIHsKIAkJaW50IGVycjsKLQkJZXJyID0g
ZnVzZV91cGRhdGVfYXR0cmlidXRlcyhpbm9kZSwgaW9jYi0+a2lfZmlscCk7CisJCWVyciA9IGZ1
c2VfdXBkYXRlX2F0dHJpYnV0ZXMoaW5vZGUsIGlvY2ItPmtpX2ZpbHAsIFNUQVRYX1NJWkUpOwog
CQlpZiAoZXJyKQogCQkJcmV0dXJuIGVycjsKIAl9CkBAIC0xMjgyLDcgKzEyODIsOCBAQCBzdGF0
aWMgc3NpemVfdCBmdXNlX2NhY2hlX3dyaXRlX2l0ZXIoc3RyCiAKIAlpZiAoZmMtPndyaXRlYmFj
a19jYWNoZSkgewogCQkvKiBVcGRhdGUgc2l6ZSAoRU9GIG9wdGltaXphdGlvbikgYW5kIG1vZGUg
KFNVSUQgY2xlYXJpbmcpICovCi0JCWVyciA9IGZ1c2VfdXBkYXRlX2F0dHJpYnV0ZXMobWFwcGlu
Zy0+aG9zdCwgZmlsZSk7CisJCWVyciA9IGZ1c2VfdXBkYXRlX2F0dHJpYnV0ZXMobWFwcGluZy0+
aG9zdCwgZmlsZSwKKwkJCQkJICAgICBTVEFUWF9TSVpFIHwgU1RBVFhfTU9ERSk7CiAJCWlmIChl
cnIpCiAJCQlyZXR1cm4gZXJyOwogCkBAIC0yNjMzLDcgKzI2MzQsNyBAQCBzdGF0aWMgbG9mZl90
IGZ1c2VfbHNlZWsoc3RydWN0IGZpbGUgKmZpCiAJcmV0dXJuIHZmc19zZXRwb3MoZmlsZSwgb3V0
YXJnLm9mZnNldCwgaW5vZGUtPmlfc2ItPnNfbWF4Ynl0ZXMpOwogCiBmYWxsYmFjazoKLQllcnIg
PSBmdXNlX3VwZGF0ZV9hdHRyaWJ1dGVzKGlub2RlLCBmaWxlKTsKKwllcnIgPSBmdXNlX3VwZGF0
ZV9hdHRyaWJ1dGVzKGlub2RlLCBmaWxlLCBTVEFUWF9TSVpFKTsKIAlpZiAoIWVycikKIAkJcmV0
dXJuIGdlbmVyaWNfZmlsZV9sbHNlZWsoZmlsZSwgb2Zmc2V0LCB3aGVuY2UpOwogCWVsc2UKQEAg
LTI2NTMsNyArMjY1NCw3IEBAIHN0YXRpYyBsb2ZmX3QgZnVzZV9maWxlX2xsc2VlayhzdHJ1Y3Qg
ZmkKIAkJYnJlYWs7CiAJY2FzZSBTRUVLX0VORDoKIAkJaW5vZGVfbG9jayhpbm9kZSk7Ci0JCXJl
dHZhbCA9IGZ1c2VfdXBkYXRlX2F0dHJpYnV0ZXMoaW5vZGUsIGZpbGUpOworCQlyZXR2YWwgPSBm
dXNlX3VwZGF0ZV9hdHRyaWJ1dGVzKGlub2RlLCBmaWxlLCBTVEFUWF9TSVpFKTsKIAkJaWYgKCFy
ZXR2YWwpCiAJCQlyZXR2YWwgPSBnZW5lcmljX2ZpbGVfbGxzZWVrKGZpbGUsIG9mZnNldCwgd2hl
bmNlKTsKIAkJaW5vZGVfdW5sb2NrKGlub2RlKTsKSW5kZXg6IGxpbnV4L2ZzL2Z1c2UvZnVzZV9p
LmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gbGludXgub3JpZy9mcy9mdXNlL2Z1c2VfaS5oCTIwMjEtMTAtMTgg
MTM6NDA6MjcuMzgyODAxMDQ0ICswMjAwCisrKyBsaW51eC9mcy9mdXNlL2Z1c2VfaS5oCTIwMjEt
MTAtMTggMTM6Mzc6NDMuNzc4Nzc5MzI3ICswMjAwCkBAIC0xMTYxLDcgKzExNjEsNyBAQCB1NjQg
ZnVzZV9sb2NrX293bmVyX2lkKHN0cnVjdCBmdXNlX2Nvbm4KIHZvaWQgZnVzZV9mbHVzaF90aW1l
X3VwZGF0ZShzdHJ1Y3QgaW5vZGUgKmlub2RlKTsKIHZvaWQgZnVzZV91cGRhdGVfY3RpbWUoc3Ry
dWN0IGlub2RlICppbm9kZSk7CiAKLWludCBmdXNlX3VwZGF0ZV9hdHRyaWJ1dGVzKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKTsKK2ludCBmdXNlX3VwZGF0ZV9hdHRyaWJ1
dGVzKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlLCB1MzIgbWFzayk7CiAK
IHZvaWQgZnVzZV9mbHVzaF93cml0ZXBhZ2VzKHN0cnVjdCBpbm9kZSAqaW5vZGUpOwogCkluZGV4
OiBsaW51eC9mcy9mdXNlL3JlYWRkaXIuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC5vcmlnL2ZzL2Z1
c2UvcmVhZGRpci5jCTIwMjEtMTAtMTggMTM6NDE6MDIuMzY1MjMzMzM2ICswMjAwCisrKyBsaW51
eC9mcy9mdXNlL3JlYWRkaXIuYwkyMDIxLTEwLTE4IDEzOjM4OjAzLjQxMzAyMTk1NCArMDIwMApA
QCAtNDU0LDcgKzQ1NCw3IEBAIHN0YXRpYyBpbnQgZnVzZV9yZWFkZGlyX2NhY2hlZChzdHJ1Y3Qg
ZmkKIAkgKiBjYWNoZTsgYm90aCBjYXNlcyByZXF1aXJlIGFuIHVwLXRvLWRhdGUgbXRpbWUgdmFs
dWUuCiAJICovCiAJaWYgKCFjdHgtPnBvcyAmJiBmYy0+YXV0b19pbnZhbF9kYXRhKSB7Ci0JCWlu
dCBlcnIgPSBmdXNlX3VwZGF0ZV9hdHRyaWJ1dGVzKGlub2RlLCBmaWxlKTsKKwkJaW50IGVyciA9
IGZ1c2VfdXBkYXRlX2F0dHJpYnV0ZXMoaW5vZGUsIGZpbGUsIFNUQVRYX01USU1FKTsKIAogCQlp
ZiAoZXJyKQogCQkJcmV0dXJuIGVycjsK
--0000000000009ac49605ce9f16be--
