Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D105127BB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 04:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgI2ClL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 22:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgI2CkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:40:22 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED611C0613CE;
        Mon, 28 Sep 2020 19:40:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q123so3100235pfb.0;
        Mon, 28 Sep 2020 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fbc1lcCGDpp0UFtSs8QzYlmJsm/rD/UeMz9MAOm88nE=;
        b=TMIcx72oBWxWulPh+5N4DaXnvovBcrq64S9WiPND81r4UL8MT4XAYHYznl/k84SMCg
         5QSAXYUDFWa8z2Ad9gH73bqOxp6RYHso6hMdp89472zKAMl9B6M4sQddlZrrkrnigqS4
         AzyiJzAbwVKoYJw0npojJXkTWP7b3YDYO71WbtPRKGYFqXC/xPF+31jb5JrWzCi0qO4K
         Do0V8vKC8DlyKgCvdrhnP6tw6iyYQNKMnO//sen/PaMaOLIjsihnrCx5dkcyqMuQ0u4H
         apRSIz8gQlcbqdgF19jmi5i1fq4CUQSbuUhzBXlSq04mvUjGZsr83tsHMO9PMG1L8J/E
         AG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fbc1lcCGDpp0UFtSs8QzYlmJsm/rD/UeMz9MAOm88nE=;
        b=HcRwnLWAxzElVAeeMDu4e0wxdHBgCn/uMH+alDd6MYOLXPvum9zL/9mXXAigNpr7M/
         HVSzdaYHPpGgDmEfk6I2eBiFdxK+CgU9TlOpvL21CVccbMk//bDbx065zLXFb2gYRHOL
         rM3/wuiJB5y4rYfG9aVXLMIzpW+df4BHdk3+xvHDj94Usz5kRWedocwOjqaNd/1/9pD/
         3V92VW0tIMKw0TgNC/JWhjqwn1s9B3o57oz/+ePkDkI1gWKz2zLoIomtvAOti5SkrMj8
         evKEFie/L8lEx9itv2T3Q1Jq5TV5L593jX5cUjvGb4R827go37cQLE+Jjpv1Bvgl3b/Z
         ibnA==
X-Gm-Message-State: AOAM531Lf2ycAI67PSeapi9ScDlT8qR2NbIOcQTZBJHOsO9zZjBa8jit
        +c0YlBVl2EFjEzV829FOyag=
X-Google-Smtp-Source: ABdhPJwh0eLpQVTib/cNBvX/dqfbdHDsmZocu814QYUOi9mLXGH41ET1i1sb2Sd9YXCl0zbCSuTR6g==
X-Received: by 2002:a63:1620:: with SMTP id w32mr1537645pgl.73.1601347221373;
        Mon, 28 Sep 2020 19:40:21 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id k24sm3106966pfg.148.2020.09.28.19.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 19:40:20 -0700 (PDT)
Date:   Tue, 29 Sep 2020 11:40:18 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] process /proc/PID/smaps vs /proc/PID/smaps_rollup
Message-ID: <20200929024018.GA529@jagdpanzerIV.localdomain>
References: <20200929020520.GC871730@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929020520.GC871730@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On (20/09/29 11:05), Sergey Senozhatsky wrote:
> Hello,
> 
> One of our unprivileged daemon process needs process PSS info. That
> info is usually available in /proc/PID/smaps on per-vma basis, on
> in /proc/PID/smaps_rollup as a bunch of accumulated per-vma values.
> The latter one is much faster and simpler to get, but, unlike smaps,
> smaps_rollup requires PTRACE_MODE_READ, which we don't want to
> grant to our unprivileged daemon.
> 
> So the question is - can we get, somehow, accumulated PSS info from
> a non-privileged process? (Iterating through all process' smaps
> vma-s consumes quite a bit of CPU time). This is related to another
> question - why do smaps and smaps_rollup have different permission
> requirements?

Hold on, seems that I misread something, /proc/PID/smaps is also
unavailable. So the question is, then, how do we get PSS info of
a random user-space process from an unprivileged daemon?

	-ss
