Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522DF352F78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 21:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBTBL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhDBTBJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:01:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36362C0613E6
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Apr 2021 12:01:07 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h25so4092860pgm.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Apr 2021 12:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BwKai1Z1q1tHkMJ9YrsZG4bHQkDjyUiaOSqIthmyIo=;
        b=RgkoEa5FSuxCd//qvqnFqTLEAAucy8uoKkNxWxkH6m7312AlJvZhHdS5bNwpiezFzw
         +x1xptGRKcijwvf+W93wK4R08RQ2Yzpu98dsWbA7KpLFxnAdLtFFSbd+fuYuHvy/Vvnp
         lhuFlIW5GEantTu4ESS3GLUjFBA8SA7l4rsPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BwKai1Z1q1tHkMJ9YrsZG4bHQkDjyUiaOSqIthmyIo=;
        b=SjyxWPKBMK431K4xWhNx8JNb6oG9zA0jhhxHio3z1wtB0bz7aXObgmbnYcpo33BuCq
         4BSYZFai5czDk4Kw4NwiNC/tMvxvE6RWxKfaP+P/7c5VSxyy64ZcItugmceKfiSTCIt4
         PnQYFMcwDmCmueFnjLXTUPO6KZd7UIkkDcUVJunPGEcpm+FXGXXKQm7EIZ4QDYaQ8FFC
         h3tQM8A7XIXUAflQBVbTDCvqtmP3w9hxduIWMM+A2ehGUoVH5mpIzPXRoqX/jFEj0h2V
         ukOEkApP+L8oJ40ghVQ4G2HofLSHXX8HhFFgdQf+vhEqD3AJoDUpjyUpUOXFM650F7mK
         8zxg==
X-Gm-Message-State: AOAM532OSFLRBtqQO7it9PjdmPPVAULdd49H23Fudv0EiENYYpPHGPzz
        HTksLfBxoqFj5JS02Tlu2bw0i13GxKREnA==
X-Google-Smtp-Source: ABdhPJwuIimBVh8dl4suQh/XQVy8sUEBZHTPSnhdnQ2Tfc/3kBT2QXUbi4CMuJP4U7cPZmOjljwYqQ==
X-Received: by 2002:a63:5a55:: with SMTP id k21mr12819957pgm.312.1617390066707;
        Fri, 02 Apr 2021 12:01:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d1sm8984094pjc.24.2021.04.02.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 12:01:06 -0700 (PDT)
Date:   Fri, 2 Apr 2021 12:01:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] fs: split receive_fd_replace from __receive_fd
Message-ID: <202104021157.7B388D1B2@keescook>
References: <20210325082209.1067987-1-hch@lst.de>
 <20210325082209.1067987-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325082209.1067987-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 09:22:09AM +0100, Christoph Hellwig wrote:
> receive_fd_replace shares almost no code with the general case, so split
> it out.  Also remove the "Bump the sock usage counts" comment from
> both copies, as that is now what __receive_sock actually does.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I'm okay with repeating code in fs/file.c. What I wanted to avoid was
open coded combinations in various callers.

So, sure, this can be split, but as-is the patch breaks SECCOMP_IOCTL_NOTIF_ADDFD:
https://lore.kernel.org/linux-fsdevel/20210329071939.GC3633@xsang-OptiPlex-9020/

-Kees

-- 
Kees Cook
