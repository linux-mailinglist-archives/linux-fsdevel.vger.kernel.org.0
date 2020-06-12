Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E531F7438
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 08:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFLG6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 02:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgFLG6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:58:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3D8C03E96F
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 23:58:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id jz3so3285811pjb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 23:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbBTPedvojIPOHUOPrzkvqJhdMTFZotSf6yPfyzcSVc=;
        b=VEv60SuR1xOiTK9xkgyJTKlyILo0gJSwdIeMlGuiTetR5wFnYj6YsL3yI5plGAsZg/
         OMWGwHmJ43PaYQmc4gd+GLuzIVpWUsVLdppG1kCQK4jIBzjwWXGw0RM5BZd3bMh5g6Op
         5zaycbbMBN8Yc9oPnkdOTIpZ4v5cFWgsPof1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbBTPedvojIPOHUOPrzkvqJhdMTFZotSf6yPfyzcSVc=;
        b=hfV/XlzuirPOz7CVNIzahLTXFpqhCwqo8NAkRy4Ue2PMNLmpphnS1qoo+a0WYudfYo
         Ye81wPRkaESwqNbNd5dM+IO5YaTt4yXGe6pjJYx36rH2OeUCTQmxYTyNcEJKEUDpiDJ9
         hLMkKe39WQKVQdu51peUTfUsYYQpFSFdz7G1l6gRbaOhs3yps+TkHi25t1M3WwQexetb
         L90doXDYatAHzX4pPKL/5QQ+0eg/BuTRNPzqQenxB7PVs6yoxIzBzF1hGf4Di3dLZ4mv
         BY/TZBgR/pZNIVf8SvkFpmmq7SSK/9MAsxaLje7ktPI/JjpgBHt4MqJ+gJeqWe2p+sYI
         BL+A==
X-Gm-Message-State: AOAM530P7m7hOS9qQY/6ntVUl4epp/4CYrXNZbXEVkFqarpE1GdnccK0
        57OTCnxyaArRSi8pcfjfBxj2LQ==
X-Google-Smtp-Source: ABdhPJzFarvRyhjwA03KJI+npCqldj7tRexddeTWqnuMNZdeX8tlh9W+3uGOuYbwK6XOUnTfUmmkPQ==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr10294486pla.40.1591945093613;
        Thu, 11 Jun 2020 23:58:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t201sm5206590pfc.104.2020.06.11.23.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 23:58:12 -0700 (PDT)
Date:   Thu, 11 Jun 2020 23:58:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Sargun Dhillon' <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matt Denton <mpdenton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006112355.932D0AD@keescook>
References: <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
 <202006092227.D2D0E1F8F@keescook>
 <20200610081237.GA23425@ircssh-2.c.rugged-nimbus-611.internal>
 <202006101953.899EFB53@keescook>
 <20200611100114.awdjswsd7fdm2uzr@wittgenstein>
 <20200611110630.GB30103@ircssh-2.c.rugged-nimbus-611.internal>
 <067f494d55c14753a31657f958cb0a6e@AcuMS.aculab.com>
 <202006111634.8237E6A5C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006111634.8237E6A5C6@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 11, 2020 at 04:49:37PM -0700, Kees Cook wrote:
> I think I prefer the last one.

Here's where I am with things:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/seccomp/addfd/v3.3

If we can agree on the ioctl numbering solution, I can actually send the
series for email review...

-- 
Kees Cook
