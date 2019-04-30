Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3FDFF99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 20:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3SOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 14:14:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39504 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3SOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:14:35 -0400
Received: by mail-yw1-f68.google.com with SMTP id x204so634739ywg.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bse4S0Z7lUf/SmcUVMhmxnkZgM+H7sFlIuWL16fY2hs=;
        b=WPBSwm2V0oeuI+bplyqdGWE4RLVzulE0noF0etJZsE7TZccsrAjKH1+fPUa8IBFj1/
         3RZeVujhrkl2FmoxDwgroiXOjcRApCnE+Uuqqt7EOlLxPbIkJOWvOF8rWeR6XIPlKW9g
         eckn6b7lehgVJ0wG5jRpqcZ8GWsxzBmROvb8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bse4S0Z7lUf/SmcUVMhmxnkZgM+H7sFlIuWL16fY2hs=;
        b=Lar0XRHJo89lzAeNwhYJ2OIPolWbXNT6HGzaHL7hcG+20cRIaJ4MX0m/8AU24bMPaG
         l6Ox0tO7ntjGlh3NsJyjicrqGEoBkcu7S/9ePxMnYYK8oS+wtZqD/stUFM5JfXLCrzkQ
         SzEpdH9uKiEL467MW4UyJwtB+pvYU0Z1lJBxvEIBxXLMdyz5QAyOK77i16sAaXfstOx2
         F/uoeXh0QeaAyM18B6+NAqNuYZv1Ya49EaeUDC0abpcMN6BMSQGe6DgQ8GseOiJyXO32
         YJJl6n/DhAPyusPUYaYusTJf/a27Zy2It9MGMN0lTBp3xjGFB/wyT8aLEa7oISODpv3E
         u76w==
X-Gm-Message-State: APjAAAUg6R+RD4DwuVaP3Edz1EnwKIoZb/wG7LiulazB+kKgNeOJW9mh
        au8S1NYehduF75r2T1eyHi2VLAebmXk=
X-Google-Smtp-Source: APXvYqxu+IToeEAj6QXd1qWMVpxlzICRPVCBKllPUr0lc9IEXWIXuSXV4xKAjpA0aSGLWVTLKcer8A==
X-Received: by 2002:a81:8448:: with SMTP id u69mr46987900ywf.295.1556648074590;
        Tue, 30 Apr 2019 11:14:34 -0700 (PDT)
Received: from mail-yw1-f43.google.com (mail-yw1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id z123sm3176988ywz.82.2019.04.30.11.14.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 11:14:33 -0700 (PDT)
Received: by mail-yw1-f43.google.com with SMTP id t79so6608659ywc.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2019 11:14:33 -0700 (PDT)
X-Received: by 2002:a81:2e08:: with SMTP id u8mr52020872ywu.55.1556648072989;
 Tue, 30 Apr 2019 11:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190430180111.10688-1-mcroce@redhat.com>
In-Reply-To: <20190430180111.10688-1-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 11:14:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
Message-ID: <CAGXu5jJG1D6YvTaSY3hpB8_APmwe=rGn8FkyAfCGuQZ3O2j1Yg@mail.gmail.com>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:01 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
>
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
>
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
>
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     248
>
> Add a const int array containing the most commonly used values,
> some macros to refer more easily to the correct array member,
> and use them instead of creating a local one for every object file.
>
> This is the bloat-o-meter output comparing the old and new binary
> compiled with the default Fedora config:
>
>     # scripts/bloat-o-meter -d vmlinux.o.old vmlinux.o
>     add/remove: 2/2 grow/shrink: 0/2 up/down: 24/-188 (-164)
>     Data                                         old     new   delta
>     sysctl_vals                                    -      12     +12
>     __kstrtab_sysctl_vals                          -      12     +12
>     max                                           14      10      -4
>     int_max                                       16       -     -16
>     one                                           68       -     -68
>     zero                                         128      28    -100
>     Total: Before=20583249, After=20583085, chg -0.00%
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
