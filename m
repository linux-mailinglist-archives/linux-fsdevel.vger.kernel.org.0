Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029BD219B9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGIJDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIJDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:03:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5FC061A0B
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 02:03:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so1426823iln.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3yS6k0SQ9o7Am/5CKe13gcW9V6NlU29ECQqYIpLGOy8=;
        b=YsOVU9txNTNRvowzl6cU8MdiVBy6t0AONl9DQWfLC9pJ2fu1U2/E/OVVgx9vvgsRpq
         fbDKUQAkUXudp+fTN+hgYcPUkxIFFzam/WLFZF2P7JMCiXzweRvkpqaSV1NhOOHde3/j
         eNZHqyfZS81lKKh9ayUs3wCHJ6uZsBprfm/d6MAA1lQ09Jz4bsc6LhReOMolF2ACP7dO
         eoE+dT+iaZRQH+XRk8DNZT30lPoHjEhGn7AijymaPxZxXZiIdHKlt4Bj81yNYNQBp8kq
         TYCph8R6Z9ENDiu8suK0ANHSwk7C/iL9wg4TIA2e2jDmIzQdA4Rt5vvKb5KtIY0iHF4d
         8lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yS6k0SQ9o7Am/5CKe13gcW9V6NlU29ECQqYIpLGOy8=;
        b=tFwUdQ36k4NHHe3MrGMcGxUpqcERMxYJry99SKMemuGQfbkT4HeLJsWk87qPEGprXU
         F6GNJgIXmHlLZqWOEEvuLM1sJJb+C0z99eP2tOrdPKMlegOaetQT/rD18zZg8YT4Qk4e
         vtEsd9QrVTGVWyCWmNE7J5kUYBQ/ZHlpxJAUI4MwILJ/tpjYDGhZjzxig0nTmvgvRbK3
         8vxjh/sPyFXzHlhq40S9+Qo/xQFxuqsYfmmrOZboMzRV2XwQp4S/aLKlCD1i4RR5R/UC
         BH7oloQXc8xQ+uu353YMJYWy+meqvKemJsRPnD6ROt3NcO563UgRP/3QutrO4B6mklBp
         62mA==
X-Gm-Message-State: AOAM531iMVX/sgyeuvRCIJUM8qMQoczu1P0wwYdkRyKCZbaBf9dmpWX/
        sF8obpEIvHEPcRZ7c0HHhpVD0sGkHurJTMXq8D0=
X-Google-Smtp-Source: ABdhPJzDL74bvpv5yiOcbKuv9fIt1x4SjL5PFKUqabmDEoHPmMN5w1Eqa9dMA1bxWKbvxCYgO76348yihKQtN6hlPx8=
X-Received: by 2002:a92:4983:: with SMTP id k3mr15420722ilg.275.1594285434311;
 Thu, 09 Jul 2020 02:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200708111156.24659-8-amir73il@gmail.com> <202007091516.gofG28uU%lkp@intel.com>
In-Reply-To: <202007091516.gofG28uU%lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 9 Jul 2020 12:03:43 +0300
Message-ID: <CAOQ4uxg9wEGwNB6mObvS+hBA_fboB_gg8NvvafwsbPFy80SAkg@mail.gmail.com>
Subject: Re: [PATCH v3 08/20] fanotify: break up fanotify_alloc_event()
To:     Jan Kara <jack@suse.cz>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 9, 2020 at 10:33 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Amir,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on ext3/fsnotify]
> [also build test WARNING on nfsd/nfsd-next driver-core/driver-core-testing linus/master v5.8-rc4 next-20200708]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Amir-Goldstein/fsnotify-Rearrange-fast-path-to-minimise-overhead-when-there-is-no-watcher/20200708-191525
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> fs/notify/fanotify/fanotify.c:347:24: warning: no previous prototype for function 'fanotify_alloc_path_event' [-Wmissing-prototypes]
>    struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
>                           ^
>    fs/notify/fanotify/fanotify.c:347:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
>    ^
>    static
> >> fs/notify/fanotify/fanotify.c:363:24: warning: no previous prototype for function 'fanotify_alloc_perm_event' [-Wmissing-prototypes]
>    struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>                           ^
>    fs/notify/fanotify/fanotify.c:363:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct fanotify_event *fanotify_alloc_perm_event(const struct path *path,
>    ^
>    static
> >> fs/notify/fanotify/fanotify.c:381:24: warning: no previous prototype for function 'fanotify_alloc_fid_event' [-Wmissing-prototypes]
>    struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
>                           ^
>    fs/notify/fanotify/fanotify.c:381:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct fanotify_event *fanotify_alloc_fid_event(struct inode *id,
>    ^
>    static
> >> fs/notify/fanotify/fanotify.c:398:24: warning: no previous prototype for function 'fanotify_alloc_name_event' [-Wmissing-prototypes]
>    struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>                           ^
>    fs/notify/fanotify/fanotify.c:398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    struct fanotify_event *fanotify_alloc_name_event(struct inode *id,
>    ^
>    static
>    4 warnings generated.

Jan,

I add 'static' rebased and pushed to fanotify_prep branch
Rebase had minor conflict in following patch (pass dir argument ...)
Also rebased and pushed fanotify_name_fid

Thanks,
Amir.
