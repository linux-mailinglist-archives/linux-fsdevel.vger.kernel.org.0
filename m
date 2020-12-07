Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060672D0E2D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 11:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLGKkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 05:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgLGKkG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:40:06 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B88EC0613D0;
        Mon,  7 Dec 2020 02:39:26 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id l23so7202637pjg.1;
        Mon, 07 Dec 2020 02:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDci9LEkbZBuld4sW/fQVQolVRaWQo6HEweIao+YO5I=;
        b=ZcYZM8qLWwwsLC8hP8jseED2i9g/3K17WRfv36ZEDTVlHxnP2B19wHuIxrT7AXAQYP
         NUoWGZkNsIR8bFc/bhVkIsmR57dMMChFY8NImwRQTWM4ztHy/gAXNYbRIJikc9+ZlQ5O
         mPvcMDmiesW9uloNu4nbOTCZg9F/Mc8Zr45Ha3zGkKC3DBP7gO8YUiHEXorbuIWdo4mS
         ZBeDoYkaEp31tMi5bbosCpp1Y5VN5sqFpb40mjSXdYuMeXq3XeFhb/z3JDm7EaAhwA21
         Fe1jP9KXpI4EOBjJCFu68QUn2CdNAn3LupiE3giSVt0bYYiSIMCGiYKxr1HWEAjs6sYE
         FwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDci9LEkbZBuld4sW/fQVQolVRaWQo6HEweIao+YO5I=;
        b=EVLb19UkKLKMEUFUlhEfDBCjCwfv0K3+xmoajw8zsTT2xfeqbYqGd2RTGeNbLOZOqH
         QQb2B8z2uks+bYbkVxKTq61ngarzMj2RVBrRSz1cnZDq4NKIsCdn+q1IR54MFwmDcVv5
         mhfHNirncsnse8jyDFyNroP/cOSUWDRa3oZeclw6InYLbqajBddn5kPualSh7jsQsc63
         7w3Ao693tKNfYlqIh3hoKYQqLzGE+yXs4A08vRCBpg5rc5XvU1FFe/DMDm0R1rv9LqZq
         +kPKZ3FeJxWWo0JJtj/G3+PlJOV+I2I7fzwLxEC4z6usQZEZ0QbOvaV012T2GSZ3Q5mb
         hm/Q==
X-Gm-Message-State: AOAM532IycZnOolOop9zA0bizhBBrbayXcTU3w6iZEuLLqVXKbsQ+wOs
        sVLy72PT/y1h6d0g3427hL2j31sVdP0+M3dQabo=
X-Google-Smtp-Source: ABdhPJw4iT57I8S8JLy3wVMNjx+Vglg02f7unXFwxHibyGY1fqiWXm5Eh4YsMrH5xubVzFTdNjqZfJeIuycCKGx6Jik=
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr16140877pjf.181.1607337565811;
 Mon, 07 Dec 2020 02:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20201206131036.3780898-1-vladimir.kondratiev@intel.com>
In-Reply-To: <20201206131036.3780898-1-vladimir.kondratiev@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Dec 2020 12:40:14 +0200
Message-ID: <CAHp75Vef910QkY6114a_3+AAM8-WXjwYdncgcCJDP9z6+UMirA@mail.gmail.com>
Subject: Re: [PATCH] do_exit(): panic() when double fault detected
To:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kars Mulder <kerneldev@karsmulder.nl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joe Perches <joe@perches.com>,
        Rafael Aquini <aquini@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michel Lespinasse <walken@google.com>,
        Jann Horn <jannh@google.com>, chenqiwu <chenqiwu@xiaomi.com>,
        Minchan Kim <minchan@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 6, 2020 at 3:16 PM Vladimir Kondratiev
<vladimir.kondratiev@intel.com> wrote:

> ---------------------------------------------------------------------
> Intel Israel (74) Limited
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.

You have a problematic footer. No one will apply or touch this material anyway.

-- 
With Best Regards,
Andy Shevchenko
