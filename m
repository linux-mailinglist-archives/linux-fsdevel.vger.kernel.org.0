Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE241AF43C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 21:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgDRTYM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726086AbgDRTYL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 15:24:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12165C061A0C
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 12:24:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q8so4327636eja.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5L2K70fxOQxP+uWdRM/yMA+3xinlowUvRSVTNSTLNw=;
        b=VUI+VnT1NDQO7RfejypC/A0x1WOF6JlDgQOx4uVj0o8myo36afYqYoAB1bDh9hMclE
         y2579x/RBIr7L8eyYz+tWMdcXNGl1k4dVtK8zltRzr1OvNlhqXGfw7OPYoGf+9sgrfJ0
         nPVwr3eWFbVskZYoGSYtK1N/R40NufLSxc2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5L2K70fxOQxP+uWdRM/yMA+3xinlowUvRSVTNSTLNw=;
        b=KWx4HLNlCYkEqogck5S1fK/nVbSkeqogBWZ0/THDz/IDpUyHNV1Do06/nvkzCEJeNS
         Gt5TtGWvDIm+0Xa027R48063F31Kb9zZOy/8h+L15L72r5l5lSDt6Sod8Ql8hV4f91mN
         erfTFkNfDTPxvTOtHdWR60Zejpb/qcEn0jYzvUx3iKYsW624bM9lSDH6mjWc0wCpC5FS
         BMIyHK9OnDt0fbH5eV6DOWCo0KWEaYTOteqsPHTutyr6qllkBNtSRgDYl7CLsJtkJ9yU
         e9LINx5GkMi2u1JDWyMyb3uHM7m2jGgTJthFatXuaD0xmP9ZlfUXjXqsl/VW0/WLWslr
         MtBg==
X-Gm-Message-State: AGi0PuYTB0Uaw6wI9/iVG7E+6lP/v5gKQqQSV9KfleWcJt5BDO5irvsO
        q05LcI1zzKFNaQei6NGWl/qOWAoeV4I=
X-Google-Smtp-Source: APiQypIifcwiSMBbrp6uut/EwCyfLKPKowcs/1IuYUBdSddNtMciyzva3pWvDYYMKakHfMtI+vNFzA==
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr8752184ejm.317.1587237848375;
        Sat, 18 Apr 2020 12:24:08 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id u6sm4000183ejb.68.2020.04.18.12.24.08
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 12:24:08 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id u13so7060957wrp.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2020 12:24:08 -0700 (PDT)
X-Received: by 2002:a2e:1418:: with SMTP id u24mr5613429ljd.265.1587237373258;
 Sat, 18 Apr 2020 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200418184111.13401-1-rdunlap@infradead.org> <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org> <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
 <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
In-Reply-To: <d018321b0f281ff29efb04dd1496c8e6499812fb.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 12:15:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
Message-ID: <CAHk-=wi4QU90W1j1VVUrqdrkrq-0XPA06sjGUm-g1VHRB-35YA@mail.gmail.com>
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in devcoredump.c
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:57 AM Joe Perches <joe@perches.com> wrote:
>
> sysfs_create_link is __must_check

The way to handle __must_check if you really really don't want to test
and have good reasons is

 (a) add a big comment about why this case ostensibly doesn't need the check

 (b) cast a test of it to '(void)' or something (I guess we could add
a helper for this). So something like

        /* We will always clean up, we don't care whether this fails
or succeeds */
        (void)!!sysfs_create_link(...)

There are other alternatives (like using WARN_ON_ONCE() instead, for
example). So it depends on the code. Which is why that comment is
important to show why the code chose that option.

However, I wonder if in this case we should just remove the
__must_check. Greg? It goes back a long long time.

Particularly for the "nowarn" version of that function. I'm not seeing
why you'd have to care, particularly if you don't even care about the
link already existing..

            Linus
