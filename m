Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2167E1F91A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfEORGM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 13:06:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40877 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfEORGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 13:06:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id d30so86517pgm.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2019 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/OpXwq79Evc4sZPZsH7EP6mB6R7H40Pg4ObnVmwED1Y=;
        b=BCsDd0gwJ2R9zgCKXphnkmwcLOc+F3oC/qlyy0hPLKDQ+nZc9dxJDlV5jCN/mxQUTY
         TiS2qP0nJT2+gEZzgxYlSGRaz13AgCIsHXO+Fm3tuPk2rwUwzd6gFceGSWUq6omsIQoF
         v0Hni5yqDtfUX/f8E1GBHGynxj728J11Yz6io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/OpXwq79Evc4sZPZsH7EP6mB6R7H40Pg4ObnVmwED1Y=;
        b=XvLaIn5vNW068Zs2TWoIECfZFK70FdtD+UhG6eWqpjg5mtSqEv7t5t7wqWDNezumYV
         hP8SietnpHDp99sj8wjyZBAIEahE96IH+FHIKsqFcys4B5ccFhvsLRnkc0VnFYuWEMyB
         rn/BqqtiV05afMpmrPYMnhq5/dlhU9I0EDUUapreP2kjJgZxxnuGyYFCoWRXwFcI8v4/
         SIzIdRcCFQkp4seDaJD6nxWcqXsqldmR/GTB47wWqENMFQE+QUPs8RZaC1zwDyLGIAPx
         Y/EThPMVImmjK/XVdWMQwCTHNm3b0U/CPu0IBhA5DZQPPMtEY0uEM8fDXPbGm0KloRbG
         L8Lg==
X-Gm-Message-State: APjAAAUvJ37ZU7symniXRqX1BMXQyGR4csHgfP9FsnAL80ICytI9Rtyy
        36HDUIjZ22k0woTyvOrRWBPUJw==
X-Google-Smtp-Source: APXvYqwXXWl1fEnyKxxNDYyXc7XBFaa07x9vjWp5eNzPe4i6FNK5Iga6srIqWZfEA3QJR+FitDiYaQ==
X-Received: by 2002:a63:4342:: with SMTP id q63mr44719536pga.435.1557939971271;
        Wed, 15 May 2019 10:06:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b63sm5310681pfj.54.2019.05.15.10.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 10:06:10 -0700 (PDT)
Date:   Wed, 15 May 2019 10:06:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ebiederm@xmission.com,
        pbonzini@redhat.com, viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        mingfangsen@huawei.com, wangxiaogang3@huawei.com,
        "Zhoukang (A)" <zhoukang7@huawei.com>, netdev@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH next] sysctl: add proc_dointvec_jiffies_minmax to limit
 the min/max write value
Message-ID: <201905150945.C9D1F811F@keescook>
References: <032e024f-2b1b-a980-1b53-d903bc8db297@huawei.com>
 <3e421384-a9cb-e534-3370-953c56883516@huawei.com>
 <d5138655-41a8-0177-ae0d-c4674112bf56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5138655-41a8-0177-ae0d-c4674112bf56@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 15, 2019 at 10:53:55PM +0800, Zhiqiang Liu wrote:
> Friendly ping...
> 
> 在 2019/4/24 12:04, Zhiqiang Liu 写道:
> > 
> > Friendly ping...

Hi!

(Please include akpm on CC for next versions of this, as he's likely
the person to take this patch.)

> > 
> >> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> >>
> >> In proc_dointvec_jiffies func, the write value is only checked
> >> whether it is larger than INT_MAX. If the write value is less
> >> than zero, it can also be successfully writen in the data.

This appears to be "be design", but I see many "unsigned int" users
that might be tricked into giant values... (for example, see
net/netfilter/nf_conntrack_standalone.c)

Should proc_dointvec_jiffies() just be fixed to disallow negative values
entirely? Looking at the implementation, it seems to be very intentional
about accepting negative values.

However, when I looked through a handful of proc_dointvec_jiffies()
users, it looks like they're all expecting a positive value. Many in the
networking subsystem are, in fact, writing to unsigned long variables,
as I mentioned.

Are there real-world cases of wanting to set a negative jiffie value
via proc_dointvec_jiffies()?

> >>
> >> However, in some scenarios, users would adopt the data to
> >> set timers or check whether time is expired. Generally, the data
> >> will be cast to an unsigned type variable, then the negative data
> >> becomes a very large unsigned value, which leads to long waits
> >> or other unpredictable problems.
> >>
> >> Here, we add a new func, proc_dointvec_jiffies_minmax, to limit the
> >> min/max write value, which is similar to the proc_dointvec_minmax func.
> >>
> >> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> >> Reported-by: Qiang Ning <ningqiang1@huawei.com>
> >> Reviewed-by: Jie Liu <liujie165@huawei.com>

If proc_dointvec_jiffies() can't just be fixed, where will the new
function get used? It seems all the "unsigned int" users could benefit.

-- 
Kees Cook
