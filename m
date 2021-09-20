Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C9E412827
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 23:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbhITVkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 17:40:12 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:39536 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhITViL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 17:38:11 -0400
Received: by mail-pj1-f50.google.com with SMTP id h3-20020a17090a580300b0019ce70f8243so436630pji.4;
        Mon, 20 Sep 2021 14:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tUvDrFJV0hIvR0FAKJySgQhotyp6SN23Xzoslz2iXJo=;
        b=rwZ8zwlOidTutGkQxGYrOqBF81JA94pO/u/nicLbi8TPvOZ0lWpHXtFWr08RN/wTrJ
         IiIRTTtidtb818tIxjG/sUl5qP6oemw3Jz7NH5ypuMD3jhsZtqgdq7nXaYmVlHPphAe6
         JpmYpsu8+zYOKlgCbMae/wIw0vaIS9E8dBUCPclWhDxMbd5eZyuMAIQra8GhouB3syxw
         OBARQGaw+56cXoXGnBWnkpDI96myiIfCgjYJZfOWdKGg0XEEZaPxNDGthq4sLqiMWIhn
         C5u9x8Dtl1q17tfaSXB4/8frZQnBZ9LqYhC++2BEzCj6ZaLvpFProu+dyeHa57B/KSaG
         lYuQ==
X-Gm-Message-State: AOAM530VxUgz86UupmG9CScevh7BcKZpOOC90kodH2IHniIoGjjidd6X
        ufdv9YGfPrYmJC0PgNlRyQ0=
X-Google-Smtp-Source: ABdhPJyw/FT9hwIaBUlZHvWR3+Hn3uHenYuvTL7vKPHQz+qO3v2aNVYX5WaGhiZkP6ICvrNNf+Ln6Q==
X-Received: by 2002:a17:90a:9a2:: with SMTP id 31mr1283242pjo.58.1632173803816;
        Mon, 20 Sep 2021 14:36:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6e2a:d64:7d9d:bd4a])
        by smtp.gmail.com with ESMTPSA id i5sm328287pjk.47.2021.09.20.14.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 14:36:42 -0700 (PDT)
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
To:     Luis Chamberlain <mcgrof@kernel.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org
Cc:     rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@ACULAB.COM,
        jolsa@kernel.org, andriy.shevchenko@linux.intel.com,
        trishalfonso@google.com, andreyknvl@gmail.com, jikos@kernel.org,
        mbenes@suse.com, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, reinette.chatre@intel.com,
        fenghua.yu@intel.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        daniel.vetter@ffwll.ch, bhelgaas@google.com, kw@linux.com,
        dan.j.williams@intel.com, senozhatsky@chromium.org, hch@lst.de,
        joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6db06c27-e3af-b0aa-6f38-9c31dd8194fa@acm.org>
Date:   Mon, 20 Sep 2021 14:36:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210918050430.3671227-10-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/17/21 10:04 PM, Luis Chamberlain wrote:
> A sketch of how this can happen follows:
> 
> CPU A                              CPU B
>                                     whatever_store()
> module_unload
>    mutex_lock(foo)
>                                     mutex_lock(foo)
>     del_gendisk(zram->disk);
>       device_del()
>         device_remove_groups()
> 
> In this situation whatever_store() is waiting for the mutex foo to
> become unlocked, but that won't happen until module removal is complete.
> But module removal won't complete until the sysfs file being poked
> completes which is waiting for a lock already held.

If I remember correctly I encountered the deadlock scenario described
above for the first time about ten years ago while working on the SCST
project. We solved this deadlock by removing the sysfs attributes from
the module unload code before grabbing mutex_lock(foo), e.g. by calling
sysfs_remove_file(). This works because calling sysfs_remove_file()
multiple times in a row is safe. Is that solution good enough for the
zram driver?

Thanks,

Bart.
