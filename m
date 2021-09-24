Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA441694A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 03:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbhIXBRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243687AbhIXBRv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:17:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9FFC061757
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so8259677pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=fk/zXO6APsjQP2fh5wykxBplb9piOvz3CNMHFIPkMPwFt20Rurof4KpK+RCED8KfWg
         awr2VaO0bwCNMi6PCTnWMa1XeV3bxdLEGfMljXtedJWuUaehsap1a9+fq0dBtHOHqhrd
         VG1ySMWoZXdd4KZu0XVMzt+HO6rkK8NokbFFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5B8w4boy04cb2C9FnPWt5iQ9AQtwNvlUApWzI3TT6E=;
        b=MPX4DK0+Xb6lryP3uJMXJLTPU+2U1d2XUPt/la8x5HnsZcL/JhL9K52B22DIZfYY9q
         xU1vv4aS85UPbYnffFdx1Ad1XXSd8IBSaCnTBpOWdXG/UlAHfz2KhSJrBBG+UByYeRmZ
         vJ45t7kW/iZc5nkZtPrCs28vSnA/I/uEcfWdYvbmYcFgMkcmxkswhwf4+PZK6A4gOPyp
         mnWWye9WCPDG0JLmVp8dNwrlFNIPtjqmlOjzNt9+muKr8C7SSDR6JQcz7TN+jfcNCMjJ
         hhI2NjDBqySAw/BCosO4t2ElZfaC8Ol3aVS15g29zk3bD29gyf5xpxoYTGRwIntWUwpx
         RaMg==
X-Gm-Message-State: AOAM532jq2yCc+aiLjcUTMsg3I9EpDM/5us1RQppWt+c4Y9Z9JVRwbh6
        vyBi8B4/Ew+VrVkh5xa9RroFpw==
X-Google-Smtp-Source: ABdhPJxoF8k/yHeE9qADjZViLo/daJ+jbNYuOpCagSw2t25LlmK7gyi40AMK5wwRJHKxrmnGmfYBDw==
X-Received: by 2002:a17:902:e153:b0:13b:63ba:7288 with SMTP id d19-20020a170902e15300b0013b63ba7288mr6270393pla.33.1632446178067;
        Thu, 23 Sep 2021 18:16:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e14sm6519648pfv.127.2021.09.23.18.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:16:17 -0700 (PDT)
Date:   Thu, 23 Sep 2021 18:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <202109231814.FD09DBAD3@keescook>
References: <20210923233105.4045080-1-keescook@chromium.org>
 <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 05:22:30PM -0700, Vito Caputo wrote:
> Instead of unwinding stacks maybe the kernel should be sticking an
> entrypoint address in the current task struct for get_wchan() to
> access, whenever userspace enters the kernel?

wchan is supposed to show where the kernel is at the instant the
get_wchan() happens. (i.e. recording it at syscall entry would just
always show syscall entry.)

-- 
Kees Cook
