Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1614E33B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA3T2s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 14:28:48 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35298 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgA3T2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:28:48 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so2172279pgk.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2020 11:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWfrZ/xjnp4Ak3zEcjYTfRHaTAYKUcqb9pMEB5EKCt8=;
        b=IM7SwiKq1+WKnW7tzkjGOWGm7quhPQSUwZCtVZ+zyJSGAvSLHvqr/P9aTRY6yJTUam
         IuFDtAXfaJxv8V8DnZnGfhMc0nL9NXW6QJp4lDqOBK0AhZcY61+OCM7OuUf4LZUMmRvz
         uF64Ssb5/OxRKUZLOQ3gRuBRC7D8IA8NZAQ8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWfrZ/xjnp4Ak3zEcjYTfRHaTAYKUcqb9pMEB5EKCt8=;
        b=L0CqO55+b09vRJfU2GJ/5g2sBqjUg9Ij+/y1s8dc09ceYyt795eqW6Ad0pZS0Y6WgQ
         akxaqkPNHqUa8oC4a0Zuh8uHHdyg/81E3PqOJTEFYr7u8NbO1IR70z/wPdHaQzIS6Cf7
         fL8uJJk6l2tBuCcUv7E2K9bd/xkPujXlpiJF2vIN35T1lhSnq571DfIB4/VHcjeITmPv
         JL65UHzW0kMnd4tIqCGTWJSo/rHsOGdLxolYVYOuLX6fgSjhx9ruq26sKjfa8qYayK36
         redf8NgkedpWRs92lf6VEIn7MYegWWANrusN2KBuHwtJehKX1Cn0NV+/GNK46nC7w77q
         tvFw==
X-Gm-Message-State: APjAAAUIfIDhUpqQju/M/1V1MFroXSZlNNzjYFs07VlCO+Tv0T9TMPSP
        Zm4tuxrXHbi1pIizx8Zt8DPOhA==
X-Google-Smtp-Source: APXvYqy8iWU4ETKdPcgtnjQ1dePHwCv/Fs0E3cGiUhU9Pn9+s/NNubhU8Y96pkpWrUj3gw0/lS0VpA==
X-Received: by 2002:a63:c511:: with SMTP id f17mr6141537pgd.198.1580412527278;
        Thu, 30 Jan 2020 11:28:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm7197844pgn.86.2020.01.30.11.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:28:46 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:28:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Grzegorz Halat <ghalat@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, ssaner@redhat.com, atomlin@redhat.com,
        oleksandr@redhat.com, vbendel@redhat.com, kirill@shutemov.name,
        khlebnikov@yandex-team.ru, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 1/1] mm: sysctl: add panic_on_inconsistent_mm sysctl
Message-ID: <202001301128.1CBD1BA52@keescook>
References: <20200129180851.551109-1-ghalat@redhat.com>
 <d47a5f31-5862-b0a9-660c-48105f4f049b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47a5f31-5862-b0a9-660c-48105f4f049b@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 30, 2020 at 03:44:50PM +0100, Vlastimil Babka wrote:
> On 1/29/20 7:08 PM, Grzegorz Halat wrote:
> > Memory management subsystem performs various checks at runtime,
> > if an inconsistency is detected then such event is being logged and kernel
> > continues to run. While debugging such problems it is helpful to collect
> > memory dump as early as possible. Currently, there is no easy way to panic
> > kernel when such error is detected.
> > 
> > It was proposed[1] to panic the kernel if panic_on_oops is set but this
> > approach was not accepted. One of alternative proposals was introduction of
> > a new sysctl.
> > 
> > Add a new sysctl - panic_on_inconsistent_mm. If the sysctl is set then the
> > kernel will be crashed when an inconsistency is detected by memory
> > management. This currently means panic when bad page or bad PTE
> > is detected(this may be extended to other places in MM).
> 
> I wonder, should enabling the sysctl also effectively convert VM_WARN...
> to VM_BUG... ?

There is already panic_on_warn sysctl... wouldn't that be sufficient?

-- 
Kees Cook
