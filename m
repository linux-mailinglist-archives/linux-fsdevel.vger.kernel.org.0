Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48404412A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhIUBoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 21:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhIUBlJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3C6C06EAB5
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 13:52:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a7so3261264plm.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Sep 2021 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqRJNowvS30DA449VJOT4nm+AVZU/Om+Rqqdzurt050=;
        b=iNAgLEI2/KhgFVKx72MAqTdpftvJ0aSwNn3Ejh2yEcwAEjl6yoUfTnx7YEE5xxLLuP
         1vGxRNVkPSZajZSlr8Z++4xK6MAUHC1hmL5Id1qonAbXlE3/B+ITv3TcdqeZXgF72TRn
         4mGdKsRJPPWvKJHSRyo74FHrclds73dk7pRuX3CP2b8e/4WSGZ1Bq4cr1ZIziuehan85
         Ibn/f5om/hzTPFJ53Rr+YajWSeJ7r/pZP6MkvHev6u5k9zJZtMW+MjXYotZIebVMDL9X
         pWqDSK819z2UFpUUjUM2uNFjNrF6D0bjnx9OQJsvR13XORAUQ5lu6dSGmtpqaJqXNUyn
         bwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqRJNowvS30DA449VJOT4nm+AVZU/Om+Rqqdzurt050=;
        b=6KmJnWTeAdWS6OpjrkfgcwzUJPhC5ZAp88eIfNWM/9qVjak4GTdq0KwQAqKvLwgg3x
         u8wrJAHTun6zCx90yKiSizC2OHhSwdDMgdpOFcJyfaQZ0mKarZ0TdOEVIdGJwmOqQ9AB
         4zS0BtDwj4tryczTDbL13pzC+lN6wniKWRryMpYR87757zw1cZpSSmyW8KEb+fed9Z+v
         b61tSmwQugmmrnYNiFQK3ZQSx5vcee6aupBKS/2r4KZ9eD/v3fjVoT9HlO87cTg/wxpi
         JfefqjipjBHkpnlqg/eBGs5FQxQ9IoOBnSz1/MpEaOPR+rrpN9U/jkaNGs6iDz5C5Ne3
         +ymA==
X-Gm-Message-State: AOAM533NAr8bk2pNXYQSVabOCNCzQqCZjHUqaLls9TRgXRsXNrZS5et8
        gqLG0mIsb3QEjLjNyk13X+DUdSLeyMYZoGyZHtwOJA==
X-Google-Smtp-Source: ABdhPJwlOxFidW4+VBTQpNvruOpSKqqJGpGW/zs/xSMhXjo23UCn9pLxSfuB7PpqCI2xw1rI4wP5aIJglQCCa+lha/0=
X-Received: by 2002:a17:902:bd8d:b0:13a:8c8:a2b2 with SMTP id
 q13-20020a170902bd8d00b0013a08c8a2b2mr24412734pls.89.1632171152630; Mon, 20
 Sep 2021 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210918050430.3671227-1-mcgrof@kernel.org> <20210918050430.3671227-10-mcgrof@kernel.org>
In-Reply-To: <20210918050430.3671227-10-mcgrof@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 13:52:21 -0700
Message-ID: <CAPcyv4i0xEwMQ5kSK-xGroV7aZr3j1YNrGMVLiLMr3U8nFCMKA@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, jeyu@kernel.org,
        shuah <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>, yzaikin@google.com,
        Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        vitor@massaru.org, elver@google.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        rf@opensource.cirrus.com,
        Stephen Hemminger <stephen@networkplumber.org>,
        David Laight <David.Laight@aculab.com>, bvanassche@acm.org,
        jolsa@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        trishalfonso@google.com, andreyknvl@gmail.com,
        Jiri Kosina <jikos@kernel.org>, mbenes@suse.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, lizefan.x@bytedance.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        senozhatsky@chromium.org, Christoph Hellwig <hch@lst.de>,
        Joe Perches <joe@perches.com>, hkallweit1@gmail.com,
        Jens Axboe <axboe@kernel.dk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-spdx@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        copyleft-next@lists.fedorahosted.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 10:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> When sysfs attributes use a lock also used on module removal we can
> race to deadlock. This happens when for instance a sysfs file on
> a driver is used, then at the same time we have module removal call
> trigger. The module removal call code holds a lock, and then the sysfs
> file entry waits for the same lock. While holding the lock the module
> removal tries to remove the sysfs entries, but these cannot be removed
> yet as one is waiting for a lock. This won't complete as the lock is
> already held. Likewise module removal cannot complete, and so we deadlock.
>
> This can now be easily reproducible with our sysfs selftest as follows:
>
> ./tools/testing/selftests/sysfs/sysfs.sh -t 0027
>
> To fix this we extend the struct kernfs_node with a module reference and
> use the try_module_get() after kernfs_get_active() is called which
> protects integrity and the existence of the kernfs node during the
> operation.
>
> So long as the kernfs node is protected with kernfs_get_active() we know
> we can rely on its contents. And, as now just documented in the previous
> patch, we also now know that once kernfs_get_active() is called the module
> is also guarded to exist and cannot be removed.
>
> If try_module_get() fails we fail the operation on the kernfs node.
>
> We use a try method as a full lock means we'd then make our sysfs
> attributes busy us out from possible module removal, and so userspace
> could force denying module removal, a silly form of "DOS" against module
> removal. A try lock on the module removal ensures we give priority to
> module removal and interacting with sysfs attributes only comes second.
> Using a full lock could mean for instance that if you don't stop poking
> at sysfs files you cannot remove a module.
>
> Races between removal of sysfs files and the module are not possible
> given sysfs files are created by the same module, and when a sysfs file
> is being used kernfs prevents removal of the sysfs file. So if module
> removal is actually happening the removal would have to wait until
> the sysfs file operation is complete.
>
> This deadlock was first reported with the zram driver, however the live
> patching folks have acknowledged they have observed this as well with
> live patching, when a live patch is removed. I was then able to
> reproduce easily by creating a dedicated selftests.
>
> A sketch of how this can happen follows:
>
> CPU A                              CPU B
>                                    whatever_store()
> module_unload
>   mutex_lock(foo)
>                                    mutex_lock(foo)
>    del_gendisk(zram->disk);
>      device_del()
>        device_remove_groups()

This flow seems possible to trigger with:

   echo $dev > /sys/bus/$bus/drivers/$driver/unbind

I am missing why module pinning is part of the solution when it's the
device_del() path that is racing? Module removal is just a more coarse
grained way to trigger unbind => device_del(). Isn't the above a bug
in the driver, not missing synchronization in kernfs? Forgive me if
the unbind question was asked and answered elsewhere, this is my first
time taking a look at this series.
