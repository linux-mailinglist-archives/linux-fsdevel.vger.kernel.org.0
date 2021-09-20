Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830874129CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhIUAGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 20:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhIUAEi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 20:04:38 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E44C06121D;
        Mon, 20 Sep 2021 10:53:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e7so18168031pgk.2;
        Mon, 20 Sep 2021 10:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+/BuCVjaN7HPzmC7myyJXzlUqKvf/I929USDd6fV7g=;
        b=n2GX8jSPxbkZ1xvB8BkjDvmfvLRoaGx/L8DK7Yizh16ZwZutGklps3rdNQcyW2wlcE
         WTbymYI2YYMfs6YG9PxpSVvBpY+MVK1joh8rgyZur5GDKpN1aHV4ri/DLLqGJQwU7ky8
         vcKO8VRVYskXez8XRgLxJmVB+sOMjmKcSYO4KsRBzOxT8UOTpBV6xv6+Vh8jL7kXZkzd
         1lErsAicH4t4aGOLX5bvIyVg7YtwDdEqb9IMj4JcrNIKKTje3aMWd8OZVPRQQrK0DBII
         9hYF6shA6nMg2BtGSJb6eQI3/M+V81scjHP3HU2ks+AsbE1jeO5w671e8QtBmfndWqlE
         +L2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=d+/BuCVjaN7HPzmC7myyJXzlUqKvf/I929USDd6fV7g=;
        b=ZT4cH12w37/HHqGm8C33VDzOMI3iRwc3/NeKcyupSLh7hwthU7q4pVn6PrfHiECGVq
         pMiyZPvkLMWLTIBvgqu5MSo1LIvBz9Zekk87N2H6L9QrRYWfsuxdWpM9CnsnMu5VP9WQ
         Zx+VuktO7MN/rDG9dO9HFdyve7OOjsLi6KGqebPZ16G71sArgfiwQaDbMKkN9C+wrw16
         s02PAKASFr9c9FN33O7Yqckanw5FbTMXzr3jcJ6ePwFUEa7zyU8UBHKavPSKTJQHRCp1
         Bn6dWfw3dh37w4Y676MzqWqLiFPhbVZyCRWfuZxhrCw6Pw6P8bmcAEhIa/EgXoBBk1yc
         9fDA==
X-Gm-Message-State: AOAM533XhZu0V5LcK0W7Mf9swTofQE8mH982V6R+w9HSosky4y+0SUEL
        RLxD0atDA6Z1MGC3Lqus/Vc=
X-Google-Smtp-Source: ABdhPJwILNsmiBihNdmI+KOaMEYSRY2KlxbnrExPecCoSE4eeeBmyyC3gmr4JptmLFq8o0YFemwJXw==
X-Received: by 2002:a62:7997:0:b0:43d:f9e1:939c with SMTP id u145-20020a627997000000b0043df9e1939cmr26229103pfc.2.1632160398453;
        Mon, 20 Sep 2021 10:53:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e14sm14357841pfv.127.2021.09.20.10.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:53:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Sep 2021 07:53:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        rdunlap@infradead.org, rafael@kernel.org, masahiroy@kernel.org,
        ndesaulniers@google.com, yzaikin@google.com, nathan@kernel.org,
        ojeda@kernel.org, penguin-kernel@i-love.sakura.ne.jp,
        vitor@massaru.org, elver@google.com, jarkko@kernel.org,
        glider@google.com, rf@opensource.cirrus.com,
        stephen@networkplumber.org, David.Laight@aculab.com,
        bvanassche@acm.org, jolsa@kernel.org,
        andriy.shevchenko@linux.intel.com, trishalfonso@google.com,
        andreyknvl@gmail.com, jikos@kernel.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, daniel.vetter@ffwll.ch, bhelgaas@google.com,
        kw@linux.com, dan.j.williams@intel.com, senozhatsky@chromium.org,
        hch@lst.de, joe@perches.com, hkallweit1@gmail.com, axboe@kernel.dk,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, peterz@infradead.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, copyleft-next@lists.fedorahosted.org
Subject: Re: [PATCH v7 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YUjKjLzqpcxjRyit@slm.duckdns.org>
References: <20210918050430.3671227-1-mcgrof@kernel.org>
 <20210918050430.3671227-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918050430.3671227-10-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Fri, Sep 17, 2021 at 10:04:27PM -0700, Luis Chamberlain wrote:
> If try_module_get() fails we fail the operation on the kernfs node.
> 
> We use a try method as a full lock means we'd then make our sysfs
> attributes busy us out from possible module removal, and so userspace
> could force denying module removal, a silly form of "DOS" against module
> removal. A try lock on the module removal ensures we give priority to
> module removal and interacting with sysfs attributes only comes second.
> Using a full lock could mean for instance that if you don't stop poking
> at sysfs files you cannot remove a module.

I find this explanation odd because there's no real equivalent to locking
the module (as opposed to try locking) because you can't wait for the
removal to finish and then grant the lock, so any operation which increases
the reference *has* to be a try method unless the caller already holds a
reference to the same module and thus knows that the module is already
pinned. The code isn't wrong, so maybe just drop the related paragraphs in
the commit message?

>  static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
>  					     struct kernfs_node *parent,
>  					     const char *name, umode_t mode,
> +					     struct module *owner,
>  					     kuid_t uid, kgid_t gid,
>  					     unsigned flags)

Is there a particular reason why @owner is added between @mode and @uid?
Sitting between two fs attributes seems a bit awkward. Maybe it can just be
the last one?

Thanks.

-- 
tejun
