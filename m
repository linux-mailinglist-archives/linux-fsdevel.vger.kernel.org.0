Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9633D7AF9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhG0QcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhG0QcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 12:32:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C16C061757;
        Tue, 27 Jul 2021 09:32:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c16so10795111plh.7;
        Tue, 27 Jul 2021 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XnS7wGZkaUxUxBZzeIMFzrqtlFgUpVB9JFi7oU+kz1o=;
        b=inkbtFcEAo4u9yojc/TIlxlnH2aBE6NspFb61m++w6vZ7IurjQrC7tNFN79v6tSijC
         xaWgmiXGsYMkgsGBgokfIS1K/GKKgx0wlfPj6D9yFhOqhBkQElMoPOFes37ElCCRLNau
         YCbj234wAO6gg6ftw1DnuhGmqgOFYR8DvZekesH/Oy1KOf0SHI1StnAbuhlFKXazlPeb
         TWVX7epjbQySXXVsipN39I9ZzBMUBnvHjELkRONfj3vK1I3Vd/Dz5vOlTd3rEueUKLhT
         /j7MzAmKWjHFHvKIRwPiMhR42xDYiWVYquRgJnoZ0cjnMH2/oax7x/OLTiKaATysBI6K
         8bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XnS7wGZkaUxUxBZzeIMFzrqtlFgUpVB9JFi7oU+kz1o=;
        b=M2GorkuEr5QzLyxA4b4iMlL09wmw0P4h4BT+6aEpyfq62gT0dB6YJAWmzfMPVPdFf0
         FdoohgTVH642oEBKhbId0+59+X2YzmMPSnz+Zywk/Xl7ok9zkaXfjrkrd2KRLYo/wTAu
         G1p0m9LgBQ7bcqGldN6CBlIeP03qvUQYKm3/9GXadRF8QbN7YD//spNb74o6JckgXiFz
         Wsk5iIj9c0zqGVPU6wWyAx0HSH6l8B0SaUyn6FpFJe0513dy6mWEYBbGmjNZG6CBqiJf
         F5ouQ7UE5Fpsz1gw0bc/NnzRq+l9R4AK5PGDcb2tKBAnTkwC9WWxZDEmiYgxfB1WBZk/
         2r8A==
X-Gm-Message-State: AOAM532RfADtK+gfx/TPChuoAEt25XvNjdX+tHR8EWh+63uWhoMnV8Ls
        2Fh3z43EhAdY6fXYXWceUYc=
X-Google-Smtp-Source: ABdhPJx0d7ZZWtjJIILVKYS4nXUt5hGghooKeSQHOhY3DYsW1p1pmc6dJL0N2mcEcDedMkmWK9Hm3A==
X-Received: by 2002:a65:654c:: with SMTP id a12mr24563952pgw.118.1627403539876;
        Tue, 27 Jul 2021 09:32:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7502])
        by smtp.gmail.com with ESMTPSA id z21sm3216582pjh.19.2021.07.27.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 09:32:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 06:32:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
Message-ID: <YQA1D1GRiF9+px/s@mtj.duckdns.org>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
 <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Tue, Jul 27, 2021 at 11:18:00AM +0800, brookxu wrote:
> According to files_maxfiles_init(), we only allow about 10% of free memory to
> create filps, and each filp occupies about 1K of cache. In this way, on a 16G
> memory machine, the maximum usable filp is about 1,604,644. In general
> scenarios, this may not be a big problem, but if the task is abnormal, it will
> very likely become a bottleneck and affect other modules. 

Yeah but that can be configured trivially through sysfs. The reason why the
default limit is lowered is because we wanna prevent a part of system to
consume all the memory through fds. With cgroups, we already have that
protection and at least some systems already configure file-max to maximum,
so I don't see a point in adding another interface to subdivide the
artificial limit.

Thanks.

-- 
tejun
