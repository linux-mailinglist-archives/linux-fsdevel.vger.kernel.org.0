Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AAA1E98DF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 May 2020 18:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEaQfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 May 2020 12:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQfd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 May 2020 12:35:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A88C061A0E;
        Sun, 31 May 2020 09:35:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so3262336plb.11;
        Sun, 31 May 2020 09:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bYF+Q99ElfhGxFFkQVu4J74caB7UVLnUUGkn2xhZvNA=;
        b=V4+pO9hY7PBtYFNR/HeVRVLjqMlg+a5Il8WotYghrxc8f35IyOLDmK92jUf1Wz2MTU
         sqBzcEKhmDeYa7gJbKm7fgW3bwsfY0110QevtFMghE5kd5uditaaMNguyuZfZZ16jdte
         0Xts+hXWt88Gax3NEJxaokVx9kPk/VKK5p9BqtL2n0Gusye99en7hKhJGxz6CMAcII6g
         paJzgm4G6NE7kDWO9fwdX7P2gNnhDwoicgAXjHo/xhnq6IABqTUEj4Whm9Pvk/KALB75
         7tmU+uByCBjBNXscYIxBUgFaGYAicAp1OioxIE6gtA6Kegr6SJSwtubqGHBdIM7WJtvb
         rDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bYF+Q99ElfhGxFFkQVu4J74caB7UVLnUUGkn2xhZvNA=;
        b=QYX4kF4oGlDNwdtUE2jbWIObaPhrJchErvhfLWMJJjqXuvkmvnD3RwrxUUW3NfthR5
         V0AUlzBAyjwCev9fL+QXV3WIu3MgEhGzaJlsQ2djTYw5QjYvkxnnSS7sZB1LUOQfbHpT
         jnf1mX5gSOY7nMDz71aFUrM5J4ry5buOzuxQzgPKW/mRtFnxopCcgMv/mFrhmfkeSgVP
         Ncl1Js929nA8qoYRyno3fY7odtWPKeeOWFMXWXd538yjrB6MZvCWgdpoyPoa6G3paybf
         dNqCa4Q44arbjEO0hXKoShd6e38U41yjn61giYdeINm5+k7lnIQFUjasUDZy7inFz1pV
         RC4w==
X-Gm-Message-State: AOAM532NDHyH/No+ltnyix0m+ZpK9hQRPoSnjxQaWDmX7bS0/+tUEBNK
        WDKhF7eKyRXcw6FYvO1m1a8=
X-Google-Smtp-Source: ABdhPJzilMH0KdTIkABYJL/ZbIsizAsgALCv5FKGDNH0EQLaGvpAccNy9pFmDKLs9QSd4ucIP823fg==
X-Received: by 2002:a17:902:6902:: with SMTP id j2mr17169545plk.2.1590942931516;
        Sun, 31 May 2020 09:35:31 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:6ddc])
        by smtp.gmail.com with ESMTPSA id o27sm11385878pgd.18.2020.05.31.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 09:35:30 -0700 (PDT)
Date:   Sun, 31 May 2020 09:35:28 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 9/9] bpf: make bpf_check_uarg_tail_zero() use
 check_zeroed_user()
Message-ID: <20200531163528.uzdziatmpglluls4@ast-mbp.dhcp.thefacebook.com>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232814.45149-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529232814.45149-1-viro@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 30, 2020 at 12:28:14AM +0100, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> ... rather than open-coding it, and badly, at that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  kernel/bpf/syscall.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

lgtm
Acked-by: Alexei Starovoitov <ast@kernel.org>
