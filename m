Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF161D7954
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 15:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgERNIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 09:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNIy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 09:08:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C844C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 06:08:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j21so4072697ejy.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJYJ4o7t1pg9R2gIPcN4zzbpq0Q24iptjTl2i6ziRkM=;
        b=AMylTRptUKbeiRIYDdGQ4mTFyABaC5QVTJ2uTNrhVhLDVCmaX/DMIPuOfXkWLhBLgN
         V4wRgMgzWhTbcybXWmekeK+bElZSG/J9+dyyuMrXu5eHdsv94g0LCBGRXlsvW53h7a6L
         2/YqIVc9ksdwE3EDqEnpMq6h2cFXh1HXpzmvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJYJ4o7t1pg9R2gIPcN4zzbpq0Q24iptjTl2i6ziRkM=;
        b=LKf3kJo1/7X1wMJqcUq21v5J+HDhn/PqprHQQ0SeYszjXHGxnEx49bHaB37EHyFDTd
         QegXj0XGaYIn5Pv6dOZON3EF6wbXqrcvE9lIxYIhs/FD175uJPIrojuwidNFzKPNA8at
         vY8wZB2gYlWguyUsYouONL2phmXCbp7DCi3OOOe8LDcjYcO8Sdwf3+/82qYrn8oIwXkB
         LEEXNLTA4IkAHvOKJS811pgxBCRXscsy1fJPSzX+Csxd9jl46ayaR3Vi/ok29qxDXkv3
         C0t1GU1j/V/K3KDrNX+rJjs/QzVAOel74ycdcG3nGwZ0VfBcmdQZivazIC+UAMPsqJP+
         cOYw==
X-Gm-Message-State: AOAM531zWzrktqWkzxFNYW2M6b0oC2CPhC2trUGEwIChDVdT/eiNk3h2
        suDOoa7+K2L+PBVNKvhMfkE+rvqOR0oL27SWcufTLw==
X-Google-Smtp-Source: ABdhPJwlrzrmLdxmiju0e8yeti5vPEFsTaYPyacAxvEip/Bti0tJLAhOAKpb1VlbKd3tATjfXRjGGVwoJupSlVlLQSI=
X-Received: by 2002:a17:906:3e0d:: with SMTP id k13mr14196843eji.145.1589807331883;
 Mon, 18 May 2020 06:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <846ae13f-acd9-9791-3f1b-855e4945012a@9livesdata.com>
In-Reply-To: <846ae13f-acd9-9791-3f1b-855e4945012a@9livesdata.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 15:08:40 +0200
Message-ID: <CAJfpegs+auq0TQ4SaFiLb7w9E+ksWHCzgBoOhCCFGF6R9DMFdA@mail.gmail.com>
Subject: Re: fuse_notify_inval_inode() may be ineffective when getattr request
 is in progress
To:     Krzysztof Rusek <rusek@9livesdata.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000047764505a5ebdd89"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000047764505a5ebdd89
Content-Type: text/plain; charset="UTF-8"

On Mon, May 4, 2020 at 1:00 PM Krzysztof Rusek <rusek@9livesdata.com> wrote:
>
> Hello,
>
> I'm working on a user-space file system implementation utilizing fuse
> kernel module (and libfuse user-space library). This file system
> implementation provides a custom ioctl operation that uses
> fuse_lowlevel_notify_inval_inode() function (which translates to
> fuse_notify_inval_inode() in kernel) to notify the kernel that the file
> was changed by the ioctl. However, under certain circumstances,
> fuse_notify_inval_inode() call is ineffective, resulting in incorrect
> file attributes being cached by the kernel. The problem occurs when
> ioctl() is executed in parallel with getattr().
>
> I noticed this problem on RedHat 7.7 (3.10.0-1062.el7.x86_64), but I
> believe mainline kernel is affected as well.
>
> I think there is a bug in the way fuse_notify_inval_inode() invalidates
> file attributes. If getattr() started before fuse_notify_inval_inode()
> was called, then the attributes returned by user-space process may be
> out of date, and should not be cached. But fuse_notify_inval_inode()
> only clears attribute validity time, which does not prevent getattr()
> result from being cached.
>
> More precisely, this bug occurs in the following scenario:
>
> 1. kernel starts handling ioctl
> 2. file system process receives ioctl request
> 3. kernel starts handling getattr
> 4. file system process receives getattr request
> 5. file system process executes getattr
> 6. file system process executes ioctl, changing file state
> 7. file system process invokes fuse_lowlevel_notify_inval_inode(), which
> invalidates file attributes in kernel
> 8. file system process sends ioctl reply, ioctl handling ends
> 9. file system process sends getattr reply, attributes are incorrectly
> cached in the kernel
>
> (Note that this scenario assumes that file system implementation is
> multi-threaded, therefore allowing ioctl() and getattr() to be handled
> in parallel.)

Can you please try the attached patch?

Thanks,
Miklos

--00000000000047764505a5ebdd89
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="fuse-update-attr_version-counter-on-fuse_notify_inval_inode.patch"
Content-Disposition: attachment; 
	filename="fuse-update-attr_version-counter-on-fuse_notify_inval_inode.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kaci7jlk0>
X-Attachment-Id: f_kaci7jlk0

LS0tCiBmcy9mdXNlL2lub2RlLmMgfCAgICA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykKCi0tLSBhL2ZzL2Z1c2UvaW5vZGUuYworKysgYi9mcy9mdXNlL2lub2RlLmMK
QEAgLTMyMSw2ICszMjEsOCBAQCBzdHJ1Y3QgaW5vZGUgKmZ1c2VfaWdldChzdHJ1Y3Qgc3VwZXJf
YmxvCiBpbnQgZnVzZV9yZXZlcnNlX2ludmFsX2lub2RlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHU2NCBub2RlaWQsCiAJCQkgICAgIGxvZmZfdCBvZmZzZXQsIGxvZmZfdCBsZW4pCiB7CisJc3Ry
dWN0IGZ1c2VfY29ubiAqZmMgPSBnZXRfZnVzZV9jb25uX3N1cGVyKHNiKTsKKwlzdHJ1Y3QgZnVz
ZV9pbm9kZSAqZmk7CiAJc3RydWN0IGlub2RlICppbm9kZTsKIAlwZ29mZl90IHBnX3N0YXJ0Owog
CXBnb2ZmX3QgcGdfZW5kOwpAQCAtMzI5LDYgKzMzMSwxMSBAQCBpbnQgZnVzZV9yZXZlcnNlX2lu
dmFsX2lub2RlKHN0cnVjdCBzdXBlCiAJaWYgKCFpbm9kZSkKIAkJcmV0dXJuIC1FTk9FTlQ7CiAK
KwlmaSA9IGdldF9mdXNlX2lub2RlKGlub2RlKTsKKwlzcGluX2xvY2soJmZpLT5sb2NrKTsKKwlm
aS0+YXR0cl92ZXJzaW9uID0gYXRvbWljNjRfaW5jX3JldHVybigmZmMtPmF0dHJfdmVyc2lvbik7
CisJc3Bpbl91bmxvY2soJmZpLT5sb2NrKTsKKwogCWZ1c2VfaW52YWxpZGF0ZV9hdHRyKGlub2Rl
KTsKIAlmb3JnZXRfYWxsX2NhY2hlZF9hY2xzKGlub2RlKTsKIAlpZiAob2Zmc2V0ID49IDApIHsK
--00000000000047764505a5ebdd89--
