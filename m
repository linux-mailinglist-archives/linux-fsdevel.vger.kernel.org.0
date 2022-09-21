Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4225D2C9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIUSIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 14:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiIUSIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:08:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4357AC37
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 11:08:48 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h194so5724083iof.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 11:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zgcz1Ul6i9PXeI/P/ZQ+OncdDs4YJohaTrFfyIJlyi8=;
        b=L/CajF85H6Pe/cI6xZHVxuCazlHeSVvBa8AG8BJwImFT1Tn1aTR82LT0SiIB63rS6+
         qYanS79/LnMDGbFgcT/4tubGjl6RAoflXl+ztralKVSwtWVbJcyK2WOVUi6EqPsvmqv8
         DEqSEtEbzw8qj+FsGdugIgMq8hWPAYmAWeH7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zgcz1Ul6i9PXeI/P/ZQ+OncdDs4YJohaTrFfyIJlyi8=;
        b=VBylRsE3NQC6AgJBpNvssQNpoNl9ff0liGv1dfGt4EQDBFenTDDRzEdkPQ/RUJz3YE
         c8xbxKK6Zob/Bz1dx9b+JElEQJdzwt/0U6Hw/p3VEE7IFT8yo7hgv9+O3vzi/n+NiMiw
         URmzhl3i4ti0JF9QRkcEf9tn2s5fyI668shc6oNb9gnYeIvHO1bNH2WFt9gl4SAuPgau
         HarsyqXgBh4gAZSjPhU6ZSCIwdMNTj5kIqqYei2x59SXY6pkM/rblIXev075j+BC7BDF
         iuZK/R47wlOjSz8H4e9GfoB0MccMtBEC+HuIZXW5+L6hAnI7OcXtFeivBNDBOKepjbEW
         H/kQ==
X-Gm-Message-State: ACrzQf01rbVbKjVlZyPhBkdeSPukR/n4ekQuPNfvuwRUTkuKdEp2/hea
        WYi048bcoE7HoGi+P4/yBf72ArOE7zSKfaD5Wacxjw==
X-Google-Smtp-Source: AMsMyM691nV87AVQASfKNBWi3Ophm3NA6FDzejuedQw6Z9f9ySuzMcOF42M6fueIQaOxEbKvmDe0TiEvzVBd+oAM9Ds=
X-Received: by 2002:a02:1d08:0:b0:35b:9c9:f8ff with SMTP id
 8-20020a021d08000000b0035b09c9f8ffmr3425999jaj.281.1663783728026; Wed, 21 Sep
 2022 11:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220920190617.2539-1-ivan@cloudflare.com> <b6aa0151527a4ee39ae85dfd34e71864@AcuMS.aculab.com>
In-Reply-To: <b6aa0151527a4ee39ae85dfd34e71864@AcuMS.aculab.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 21 Sep 2022 11:08:37 -0700
Message-ID: <CABWYdi2QrsVNngD1ypp+WPg_56DRVk01HuBDjOAKBaav8KJncQ@mail.gmail.com>
Subject: Re: [PATCH] proc: report open files as size in stat() for /proc/pid/fd
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mike Rapoport <rppt@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 3:21 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Ivan Babrou
> > Sent: 20 September 2022 20:06
> ...
> >
> > +static int proc_readfd_count(struct inode *inode)
> > +{
> > +     struct task_struct *p = get_proc_task(inode);
> > +     struct fdtable *fdt;
> > +     unsigned int i, size, open_fds = 0;
> > +
> > +     if (!p)
> > +             return -ENOENT;
> > +
> > +     if (p->files) {
> > +             fdt = files_fdtable(p->files);
> > +             size = fdt->max_fds;
> > +
> > +             for (i = size / BITS_PER_LONG; i > 0;)
> > +                     open_fds += hweight64(fdt->open_fds[--i]);
> > +     }

I'm missing put_task_struct(p) here.

> > +
> > +     return open_fds;
> > +}
> > +
>
> Doesn't that need (at least) rcu protection?

Should I enclose the "if" in rcu_read_lock() / rcu_read_unlock()?

files_fdtable() is this:

* https://elixir.bootlin.com/linux/v6.0-rc6/source/include/linux/fdtable.h#L77

#define files_fdtable(files) \
    rcu_dereference_check_fdtable((files), (files)->fdt)

And rcu_dereference_check_fdtable() is

#define rcu_dereference_check_fdtable(files, fdtfd) \
  rcu_dereference_check((fdtfd), lockdep_is_held(&(files)->file_lock))

I definitely need some help with locking here.

> There might also be issues reading p->files twice.

This block for reading twice:

if (p->files) {
    fdt = files_fdtable(p->files);

Already exists in fs/proc/array.c in task_state():

* https://elixir.bootlin.com/linux/v6.0-rc6/source/fs/proc/array.c#L173

There's task_lock(p) there, so maybe that's why it's allowed.

Should I run files_fdtable(p->files) unconditionally and then check
the result instead? I'm happy to change it to something else if you
can tell me what it should be.

If there are kernel options I should enable for testing this, I'd be
happy to hear them. So far we've tried running with KASAN with no
issues.
