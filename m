Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793AD231691
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgG2ADf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 20:03:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44821 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730203AbgG2ADf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:03:35 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so7452298iow.11;
        Tue, 28 Jul 2020 17:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXFD10Rv0JjmKa9mG+dTSJx3WQvF526rNjwfbt0NjXM=;
        b=ANDpmPiTaSs5jNscq58ZL65K393RdyRbCs9EBeDZzf16wocbx+Y/XBabj/zE67JZRq
         UVQbGVGUJTEmrI+V227ge1oi7cjVGtpSohrF2axYjH0GCUwC1SXC0g+GRLHrBkv25gBr
         aDECyVWRS8Z+gC2MJ97XIphpDNz+AifkrPMe8fqx0y7FstXVrYrb9uxuHbdZey/aHnb1
         ohmMV3iMgsgzaH5MgQzvWXyTlzu4t72Ld5xyeAgWWx96ZME8i2g7DxFXzbIJwBMbf4EH
         PBI/nPHv8NGhH04KdJQUGDxUJfVYnfliaVth29uCa24FpXex0BwcD3IUHWX9Q3u7ubSD
         eGFg==
X-Gm-Message-State: AOAM531YlaIOAgVLAXIFq9PAUqm5hM/Q12LJV0z6wYRD4QDR/SVJGWwi
        B8ge8jsTz7AuCze7m0BpB1c=
X-Google-Smtp-Source: ABdhPJyq/gYnInd7DJmO9UKPCgu93jZ8qEVsvuBCvut/ojTyuY6YfLYQG5pz5kGlUv8BXEFqcuvKmw==
X-Received: by 2002:a05:6602:160b:: with SMTP id x11mr24882338iow.52.1595981014221;
        Tue, 28 Jul 2020 17:03:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 4sm218492ilt.6.2020.07.28.17.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 17:03:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 5796340945; Wed, 29 Jul 2020 00:03:32 +0000 (UTC)
Date:   Wed, 29 Jul 2020 00:03:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Julius Hemanth Pitti <jpitti@cisco.com>, mingo@elte.hu,
        akpm@linux-foundation.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, xe-linux-external@cisco.com,
        jannh@google.com
Subject: Re: [PATCH] proc/sysctl: make protected_* world readable
Message-ID: <20200729000332.GJ4332@42.do-not-panic.com>
References: <20200709235115.56954-1-jpitti@cisco.com>
 <202007092122.782EE053@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007092122.782EE053@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 09:31:37PM -0700, Kees Cook wrote:
> On Thu, Jul 09, 2020 at 04:51:15PM -0700, Julius Hemanth Pitti wrote:
> > protected_* files have 600 permissions which prevents
> > non-superuser from reading them.
> > 
> > Container like "AWS greengrass" refuse to launch unless
> > protected_hardlinks and protected_symlinks are set. When
> > containers like these run with "userns-remap" or "--user"
> > mapping container's root to non-superuser on host, they
> > fail to run due to denied read access to these files.
> > 
> > As these protections are hardly a secret, and do not
> > possess any security risk, making them world readable.
> > 
> > Though above greengrass usecase needs read access to
> > only protected_hardlinks and protected_symlinks files,
> > setting all other protected_* files to 644 to keep
> > consistency.
> > 
> > Fixes: 800179c9b8a1 ("fs: add link restrictions")
> > Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> I had originally proposed it as 0644, but Ingo asked that it have
> a more conservative default value[1]. I figured that given the settings
> can be discovered easily, it's not worth much. And if there are legit
> cases where things are improved, I don't have a problem switching this
> back.

If we're going to to do this, can we please document why these are
"protected" then?

  Luis

> 
> Ingo, any thoughts on this now, 8 years later in the age of containers?
> :)
> 
> (One devil's advocate question: as a workaround, you are able to just
> change those files to 0644 after mounting /proc, yes? But regardless,
> why get in people's way for no justifiable reason.)
> 
> -Kees
> 
> [1] https://lore.kernel.org/lkml/20120105091704.GB3249@elte.hu/
> 
> -- 
> Kees Cook
