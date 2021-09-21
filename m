Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E98413679
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 17:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbhIUPul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 11:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhIUPuk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B3B061183;
        Tue, 21 Sep 2021 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632239352;
        bh=SYPIsUeB0QpNl9iOqz8TrUCBGO94e+noRg1ECZdTJME=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UaaVRIqswzz+NS3S8fQEaKMO9RtdOXsyeprnTEIheXJKQGHNj08P7eyrd/PQOFBCR
         AN5tBBs86O+nP3GdbvOj2N+vfIACcMw2gY7GyzZmcnfLHUMHWEqqTO8tVeryaAcPBC
         wa3PUemimJFndCXNOCuGMsRHqw57UEYG+Vl8QmekwFARdVX0/7ufVsMqf8T+9g7Szp
         diWZkbbph3gXn35UaYmr5cUyleLHlYXnKdZMqMkRG/D9zQZoy6oFBj2a59MNnxAHRK
         YIYKWUHNZvNhOBYpWGFXq5g7hiH0GMlpMxwr02jYDVngebiKxCzBjK5YB3wvzgzdsQ
         QI6X04sAKlF5w==
Received: by mail-qt1-f178.google.com with SMTP id x9so6771427qtv.0;
        Tue, 21 Sep 2021 08:49:12 -0700 (PDT)
X-Gm-Message-State: AOAM530DTdfrLatLheUDRErjR0q716Etht84WYtht7AKXxWF0VYHTMnt
        NVdMaemE2/1nYxdiR7t9kXytp6X1M9drt3Q8/zI=
X-Google-Smtp-Source: ABdhPJxkbOxqy1A7fvfdyNFD5npSBw9ZclgHN9SR+lhraCwiqhyTzn8pzClLHqd6Gjl1VdDdZRtbIZxWA0QsI3m+TXk=
X-Received: by 2002:ac8:4113:: with SMTP id q19mr29065258qtl.108.1632239341024;
 Tue, 21 Sep 2021 08:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210917194709.3562413-1-mcgrof@kernel.org> <20210917194709.3562413-10-mcgrof@kernel.org>
 <c70dcb03e27e43c5b5311e184357df39@AcuMS.aculab.com>
In-Reply-To: <c70dcb03e27e43c5b5311e184357df39@AcuMS.aculab.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 21 Sep 2021 08:48:49 -0700
X-Gmail-Original-Message-ID: <CAB=NE6WjupsJFwsj94sC_j3gcYn2Qo0sx1=tMv=WUZ83jq_DFw@mail.gmail.com>
Message-ID: <CAB=NE6WjupsJFwsj94sC_j3gcYn2Qo0sx1=tMv=WUZ83jq_DFw@mail.gmail.com>
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
To:     David Laight <David.Laight@aculab.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "yzaikin@google.com" <yzaikin@google.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "vitor@massaru.org" <vitor@massaru.org>,
        "elver@google.com" <elver@google.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "glider@google.com" <glider@google.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "trishalfonso@google.com" <trishalfonso@google.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "mbenes@suse.com" <mbenes@suse.com>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "kw@linux.com" <kw@linux.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "hch@lst.de" <hch@lst.de>, "joe@perches.com" <joe@perches.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "copyleft-next@lists.fedorahosted.org" 
        <copyleft-next@lists.fedorahosted.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 21, 2021 at 1:24 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Luis Chamberlain
> > Sent: 17 September 2021 20:47
> >
> > When sysfs attributes use a lock also used on module removal we can
> > race to deadlock. This happens when for instance a sysfs file on
> > a driver is used, then at the same time we have module removal call
> > trigger. The module removal call code holds a lock, and then the sysfs
> > file entry waits for the same lock. While holding the lock the module
> > removal tries to remove the sysfs entries, but these cannot be removed
> > yet as one is waiting for a lock. This won't complete as the lock is
> > already held. Likewise module removal cannot complete, and so we deadlock.
>
> Isn't the real problem the race between a sysfs file action and the
> removal of the sysfs node?

Nope, that is taken care of by kernfs.

> This isn't really related to module unload - except that may
> well remove some sysfs nodes.

Nope, the issue is a deadlock that can happen due to a shared lock on
module removal and a driver sysfs operation.

> This is the same problem as removing any other kind of driver callback.
> There are three basic solutions:
> 1) Use a global lock - not usually useful.
> 2) Have the remove call sleep until any callbacks are complete.
> 3) Have the remove just request removal and have a final
>    callback (from a different context).

Kernfs already does a sort of combination of 1) and 2) but 1) is using
atomic reference counts.

> If the remove can sleep (as in 2) then there is a requirement
> on the driver code to not hold any locks across the 'remove'
> that can be acquired during the callbacks.

And this is the part that kernfs has no control over since the removal
and sysfs operation are implementation specific.

> Now, for sysfs, you probably only want to sleep the remove code
> while a read/write is in progress - not just because the node
> is open.
> That probably requires marking an open node 'invalid' and
> deferring delete to close.

This is already done by kernfs.

> None of this requires a reference count on the module.

You are missing the point to the other aspect of the try_module_get(),
it lets you also check if module exit has been entered. By using
try_module_get() you let the module exit trump proceeding with an
operation, therefore also preventing any potential use of a shared
lock on module exit and the driver specific sysfs operation.

  Luis
