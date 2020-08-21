Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0933A24D910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 17:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgHUPte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgHUPtc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:49:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F377C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:49:21 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o23so2862898ejr.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 08:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iwh7S13BqAayBPIntA8Y+X+VaiA0gIrEFaBR/4csWJ4=;
        b=Asd8g/6BSFAVDBuJLha48rolzKk4qhvN4yINj4+61Eh3G7kssKwHDQjoOLiU9WxiPW
         QS30jqbecxoSUOueK2U/wx49J0jCe//yp6+Mq8U6k/J0YrBjSBeB/siunGy3vmgbloyh
         osQ+aXevHHvgQR3CVaC2B+W+gqlyKbJi9/ymE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iwh7S13BqAayBPIntA8Y+X+VaiA0gIrEFaBR/4csWJ4=;
        b=gXOBWPlluVCF7OR/GzurwFBolznmDSTHkYMBep6xj+1fhSaYKvxq+aDsjPmGM/q2H1
         8GBE9JumwAIjvqOR2ZO9riHakw02h2k/2aiHEeGXfEY5/5TipMBcsD5QtU+3bsFWOirb
         TmqYkXvGt9+4riuLvmWdtgllAdt72AWNT/pezEFqb/pluZ+s5oOqiQ0mb9p5J/ZakPan
         AQ2IKNWVTlYgkjMcoK5hKJiK/c4CGnvWRdzyIdCsQHAaET77Sa5cR5ynUx5fsA9TfwfV
         MG70L6VXVGtbMmNLJZ59dIpaTrN/kWS1zv9pRhsG9xKlWSwqk6iaKsMGbVv8YMVnRIVV
         qoyQ==
X-Gm-Message-State: AOAM5324uZGFDyDl0SKXYBvHu6Ju/Ot175w+WLYSICdx8Q1SU0SV6YvV
        bd1psnmkye5eBne1eGX0VSUPBh9RFGn1fcusBour6A==
X-Google-Smtp-Source: ABdhPJzszRhYcaYzu5Mt8df4qWiI96mayuFr3EouecomKk8Gme4UDfTCVMjhhIYhReJxRJLDtzaoO7gQpfcL8baGYds=
X-Received: by 2002:a17:907:4003:: with SMTP id nj3mr3427330ejb.320.1598024959789;
 Fri, 21 Aug 2020 08:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33857B8B2E49DF0DD0C4F950DD5D0@DM6PR12MB3385.namprd12.prod.outlook.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 17:49:08 +0200
Message-ID: <CAJfpegu6-hKCdEiZxb9KrZUrMT_UozjaWC5qY00xwqqopb=1SA@mail.gmail.com>
Subject: Re: [fuse-devel] Cross-host entry caching and file open/create
To:     Ken Schalk <kschalk@nvidia.com>
Cc:     "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000124ced05ad652e0c"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000124ced05ad652e0c
Content-Type: text/plain; charset="UTF-8"

On Thu, Aug 20, 2020 at 12:24 AM Ken Schalk <kschalk@nvidia.com> wrote:
>

> If the open flags include O_EXCL, then we're seeing a failure with
> EEXIST without any call to our FUSE filesystem's create operation (or
> any other FUSE operations).  The kernel makes this failure decision
> based on its cached information about the previously accessed (now
> deleted) file.  If the open flags do not include O_EXCL, then we're
> seeing a failure with ENOENT from our open operation (because the file
> does not actually exist anymore), with no call to our create operation
> (because the kernel believed that the file existed, causing it to make
> a FUSE open request rather than a FUSE create request).

Does the attached patch fix it?

Thanks,
Miklos

--000000000000124ced05ad652e0c
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-reval-exclusive-create.patch"
Content-Disposition: attachment; 
	filename="fuse-reval-exclusive-create.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ke4ermf80>
X-Attachment-Id: f_ke4ermf80

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZGlyLmMgYi9mcy9mdXNlL2Rpci5jCmluZGV4IDI2ZjAyOGJj
NzYwYi4uZWM1NTUyZmY5ODI2IDEwMDY0NAotLS0gYS9mcy9mdXNlL2Rpci5jCisrKyBiL2ZzL2Z1
c2UvZGlyLmMKQEAgLTIwNCw3ICsyMDQsNyBAQCBzdGF0aWMgaW50IGZ1c2VfZGVudHJ5X3JldmFs
aWRhdGUoc3RydWN0IGRlbnRyeSAqZW50cnksIHVuc2lnbmVkIGludCBmbGFncykKIAlpZiAoaW5v
ZGUgJiYgaXNfYmFkX2lub2RlKGlub2RlKSkKIAkJZ290byBpbnZhbGlkOwogCWVsc2UgaWYgKHRp
bWVfYmVmb3JlNjQoZnVzZV9kZW50cnlfdGltZShlbnRyeSksIGdldF9qaWZmaWVzXzY0KCkpIHx8
Ci0JCSAoZmxhZ3MgJiBMT09LVVBfUkVWQUwpKSB7CisJCSAoZmxhZ3MgJiAoTE9PS1VQX0VYQ0wg
fCBMT09LVVBfUkVWQUwpKSkgewogCQlzdHJ1Y3QgZnVzZV9lbnRyeV9vdXQgb3V0YXJnOwogCQlG
VVNFX0FSR1MoYXJncyk7CiAJCXN0cnVjdCBmdXNlX2ZvcmdldF9saW5rICpmb3JnZXQ7Cg==
--000000000000124ced05ad652e0c--
