Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3B51D47AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEOIEY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726694AbgEOIEY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:04:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50342C05BD09
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:04:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 23so604342pfy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LC42tQWSVKcPTd0vfct9nXEP5yPluiMsV+/dal56l40=;
        b=nye9VDABcDWL9gKYaE40k1ONvXp/eBIpP0OHIwwaZ+eKb4bOiLnjaYBbq56KRBcgdG
         /x/Vu5n5nDX/ojuh95Ko0Zhr0LPhSoHkx44TbRdq3mejTC1sIWroMupPgsKqafO/mvle
         e/ZfFneXBldriWjrwMroEVj5pMpOhNo6FH0a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LC42tQWSVKcPTd0vfct9nXEP5yPluiMsV+/dal56l40=;
        b=lo+SWR4EvqOlqHoJzBFyfKTi8Kolmr//9KVQsif+E8lQKttM+4QmNcF5rcPNfCYoBZ
         7AG2oIzRTJVmYAzHI/5FizstCY1b/AoIiSJRCaJDyjo7tdxDdpMGBwYQ+l0M2xFrgTQo
         3jeDDGC6wxeCPYVV/e6fOti/MTpiF3zBt9e6SRBXJi1X/4/dTSDPmuTP10Q3yxYS3ts1
         nxge05WU/Wn42XY7WlIiWPy9Kt/5m0qgIzNC3BFF//VTIHg1bYjwJ9wwI11CFDRDtmil
         w9JBrZdKp3DCUt3h5exLHzB7v8HxwxLZIzXJyEka0sDNtC0Feivp3mt5Q2Hm13XA8/5O
         qWsw==
X-Gm-Message-State: AOAM532RwbeA7loWJc3hV+TG1D5DXlhRo6khUi5cHQYaUYcIcEKGQ5KF
        jREOkOFC3W+E6iXtpKwDp7wwGA==
X-Google-Smtp-Source: ABdhPJzXrdopWQZaKiXr0V4m/XkQq+2GMH38/b4FSyLAHwIGW63nncfVYJvxNIvccBvhCbUdH+pjww==
X-Received: by 2002:a63:1f62:: with SMTP id q34mr1949396pgm.197.1589529863766;
        Fri, 15 May 2020 01:04:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h64sm1302263pfe.42.2020.05.15.01.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:04:22 -0700 (PDT)
Date:   Fri, 15 May 2020 01:04:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 1/4] hung_task: Move hung_task sysctl interface to
 hung_task_sysctl.c
Message-ID: <202005150103.6DD6F07@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-2-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:41PM +0800, Xiaoming Ni wrote:
> Move hung_task sysctl interface to hung_task_sysctl.c.
> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the same time.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  include/linux/sched/sysctl.h |  8 +----
>  kernel/Makefile              |  4 ++-
>  kernel/hung_task.c           |  6 ++--
>  kernel/hung_task.h           | 21 ++++++++++++
>  kernel/hung_task_sysctl.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++

Why a separate file? That ends up needing changes to Makefile, the
creation of a new header file, etc. Why not just put it all into
hung_task.c directly?

-Kees

-- 
Kees Cook
