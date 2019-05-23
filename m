Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC69E2779C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 10:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfEWIFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 04:05:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33569 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 04:05:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id c66so6480287wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LkPnFtYpyLkj70RFjcw8TCN+fI+dWnCKWpxfIn/z7iU=;
        b=EXxFPOQxgS97GV3G38NtKxjZ1TLntF/5IIj2bD+1xz3KIwKQ7Avh7WZtPzu9ap9he9
         rjOiEgilOdI9WKrQ9M10/V0ncbTQPP8xuOuDu9M8zbTdNAmJH9i4Jz6MSLYJL36CAnnJ
         u92d6b0UpH5c4v3pEq2UTptWNP5PUdK2yksxTEIam6PTElwy8f+QlB2HUu+0lYjJ2idF
         7EQA4D4fI4xbWVB9mXerHYDwn20m7NzAzX4FgSIPgTIfp9YqSJLvMysnW+l2OG2F1vVK
         urN3dAhTKMMlW7L/zcWxtzBBCwBe1Lg/UmeqnlXCWwPY7EKG6LQceU/ip4zkdsWaikYk
         9RmA==
X-Gm-Message-State: APjAAAUSLgUf0kzyszhpQOZ0nE317z0WV73UsIpYloXMgfgMXMUAzNjT
        DOt4g6E0Nsmo0663va9S7l1l
X-Google-Smtp-Source: APXvYqxITmMxSX8uME9UdPACUAgC7iQj9jnQEo6XGQeTkpXlqJwcuGF4Z5vNg0khkQCg+bTy4sed0w==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr10775600wmf.132.1558598707627;
        Thu, 23 May 2019 01:05:07 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id k63sm9304944wmf.35.2019.05.23.01.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 01:05:06 -0700 (PDT)
Date:   Thu, 23 May 2019 09:05:06 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
Message-ID: <20190523080506.imvtj5ve2iwatdbn@atomlin.usersys.com>
References: <20190430180111.10688-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430180111.10688-1-mcroce@redhat.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2019-04-30 20:01 +0200, Matteo Croce wrote:
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
> ---

Nice idea.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
