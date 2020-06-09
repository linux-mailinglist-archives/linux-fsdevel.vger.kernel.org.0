Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945E91F408A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgFIQTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgFIQTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:19:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01350C03E97C
        for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2020 09:19:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o6so10534178pgh.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2020 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ueyMjrt+cVmVw+FUtBmPoU2yNggdKKN+3InYLsTempU=;
        b=RZa4k0gdX/BrdYRuu5UbU3mCtRg5M7tITfvtIafMhGK1/7W6JOMfDwmDndeL2mMC31
         yNzF44u98E7F1ppN0a4sYDU8qBATLfUt2Vty8tAEUAUccnACIfrgaxemDDEGfchcknaB
         393Rn4PtQDLfi9We9ITW6jDW26mZCgdYJxzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ueyMjrt+cVmVw+FUtBmPoU2yNggdKKN+3InYLsTempU=;
        b=JEZy9jUXKbJpGTu58XJ9YrcTvssElKKjEsgpii5IdkK6wvMcupWrRLTsGQ4+Pg6/7k
         dmFWsSvwmslj/iXoeJ2etLwx+gLFL2t2oeYEGAVi1ud2KX/tvVWacM6lIsVYswHRJhRh
         5qexD3pFpbvEd24M6qnql6xzcUBPNqa1XonWTGxrUish5q9kinuGE/g8wl/Ci68GvsWD
         DyJpuqDN9XDxcjE2SsBBtB6iAdvg2otgxuf+2uNFvaRGAZU4ZzBsBrBb/oBVm77JiE5K
         tqG8ESIXdyVVUbwB2VADIj40XDCR+B6IsZklxO36lJpmBDGvcGREOX/DkXjvJRtBkXAQ
         so/w==
X-Gm-Message-State: AOAM532yQdlx0/DY48p1qd/xpsMFhx53f66ltOBbp0MpLfEfzjp+0+ld
        jfB8l0RH5penwwgQkmalXD9zuQ==
X-Google-Smtp-Source: ABdhPJzE6yGQaAHR9+5KrWHmMMPB2+bwupzZamf+a74907NKzb6ugUkxgWCFch7ofwWEXhGReam42Q==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr24710834pgf.140.1591719558589;
        Tue, 09 Jun 2020 09:19:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2sm10367405pfb.73.2020.06.09.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:19:17 -0700 (PDT)
Date:   Tue, 9 Jun 2020 09:19:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] afs: Fix use of BUG()
Message-ID: <202006090919.3FAC6C7A@keescook>
References: <159171918506.3038039.10915051218779105094.stgit@warthog.procyon.org.uk>
 <159171920664.3038039.18059422273265286162.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159171920664.3038039.18059422273265286162.stgit@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:13:26PM +0100, David Howells wrote:
> Fix afs_compare_addrs() to use WARN_ON(1) instead of BUG() and return 1
> (ie. srx_a > srx_b).
> 
> There's no point trying to put actual error handling in as this should not
> occur unless a new transport address type is allowed by AFS.  And even if
> it does, in this particular case, it'll just never match unknown types of
> addresses.  This BUG() was more of a 'you need to add a case here'
> indicator.
> 
> Reported-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-- 
Kees Cook
