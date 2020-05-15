Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A582C1D5AAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgEOU1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 16:27:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43785 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOU1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 16:27:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id v63so1515480pfb.10;
        Fri, 15 May 2020 13:26:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BjLEoH1/onS9gWc/WGPUDHWQzqwo7CrmGrZOV7KWi24=;
        b=UamxaYbhgmj4ujJONx9S2X0l7P6wumcxE4lCGY7L+hC75LuNCGzJEMVPtzKi3tAkm0
         ZjNsthL6BZX6hgsdieTZuM9UDtBXG8JjW+SzW2IK6F79BYnh925FesrYfzhtQncTuhal
         scZM6DgFKImNeRAgxcq4e2L0t6eq6+ttNwcm4DENzstvSE2jVtnucOitxtaEUsIgt5Uo
         nv4EHBREXpcwTKl9VfV9+oZbIT1y9pUpMPCJBFAVewlTHeyEMsUp384i7UGYKPzllDHK
         UHfopQlU+IticbbiN9Q5dwMZfEKeJZN8Jr4rDW0PpF3dl2H/Gg/IJjFoIQwg7yDLaarJ
         +Hzg==
X-Gm-Message-State: AOAM531FQfaSSrvtxOHnfCYDpvINMx4IMb4Bzn63zur9rX2DuWdGAeY+
        X4bQZPds47HkgnQFgaml8rE=
X-Google-Smtp-Source: ABdhPJw55POBvLJW1yTqamx/YQ9pJ9208HAhysD6+dQoHJdWvvegvrWWTUXGJdA6DaxsTXI4n7DFIw==
X-Received: by 2002:a65:608c:: with SMTP id t12mr4951599pgu.46.1589574418563;
        Fri, 15 May 2020 13:26:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id d18sm2638767pfq.177.2020.05.15.13.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:26:57 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B49A240246; Fri, 15 May 2020 20:26:56 +0000 (UTC)
Date:   Fri, 15 May 2020 20:26:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net,
        keescook@chromium.org, akpm@linux-foundation.org, cai@lca.pw,
        rdunlap@infradead.org, tytso@mit.edu, bunk@kernel.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        labbott@redhat.com, jeffm@suse.com, jikos@kernel.org, jeyu@suse.de,
        tiwai@suse.de, AnDavis@suse.com, rpalethorpe@suse.de
Subject: Re: [PATCH v5] kernel: add panic_on_taint
Message-ID: <20200515202656.GZ11244@42.do-not-panic.com>
References: <20200515175502.146720-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515175502.146720-1-aquini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 01:55:02PM -0400, Rafael Aquini wrote:
> Analogously to the introduction of panic_on_warn, this patch introduces a kernel
> option named panic_on_taint in order to provide a simple and generic way to stop
> execution and catch a coredump when the kernel gets tainted by any given flag.
> 
> This is useful for debugging sessions as it avoids having to rebuild the kernel
> to explicitly add calls to panic() into the code sites that introduce the taint
> flags of interest. For instance, if one is interested in proceeding with a
> post-mortem analysis at the point a given code path is hitting a bad page
> (i.e. unaccount_page_cache_page(), or slab_bug()), a coredump can be collected
> by rebooting the kernel with 'panic_on_taint=0x20' amended to the command line.
> 
> Another, perhaps less frequent, use for this option would be as a mean for
> assuring a security policy case where only a subset of taints, or no single
> taint (in paranoid mode), is allowed for the running system.
> The optional switch 'nousertaint' is handy in this particular scenario,
> as it will avoid userspace induced crashes by writes to sysctl interface
> /proc/sys/kernel/tainted causing false positive hits for such policies.
> 
> Suggested-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
