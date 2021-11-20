Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADE1457C59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Nov 2021 08:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhKTH5D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Nov 2021 02:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbhKTH5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Nov 2021 02:57:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1703BC06173E
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 23:53:57 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k37so54413020lfv.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Nov 2021 23:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwaFrItd0GqJ8n5YLBu2RWS98JzEweGxq8C32OjIx+k=;
        b=lD9/QU0GRm+RNNP8QcUlmNyYRKGkI1r73n2q+6beNMwspKDXBurqPeeyoBpteUnebW
         u4MoNlnn2blmhzoMsZyklRTODkARr92mhox55I1fReVD1QRBbfeaTN+rvnDZ/DZOQnsu
         VdkkW8ZB6ZkFcFwQiwB1fgJ0t7ySykCQqqgj9FekHsJ+Md2smWEL2dlqfZxyDfgZjMjz
         RXZTCblf/ETYedXvV39ZEcW9ySGUuUjTH+b8/cLC6ceFfx1kMaERA+ydo55ED9hD4j0W
         5EMx561TGUalhlBre7dZyI/hau8D4wHurPvE9SipfurJEP0rGpL/2GOFKuHteC3SQAVY
         V0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwaFrItd0GqJ8n5YLBu2RWS98JzEweGxq8C32OjIx+k=;
        b=a7f4onShZRj+XMBa7X6rn2NJnA31qYI8XTy5KVcuJzF7xK2c7XG2Y0D0C1eHJ5PTD7
         sskvGP65CVgP3YNJ2ORARTxORvCrnN4HxOU6C/9Q7CZOspDzVasRAZP62UPdiWD+xV5a
         18mGwOAC0PKxWCS2N6Dj4UQ64Tm6O9Bpoa6yvu32Ww+8M5s6DIP4D3becJ/LXOpC10R/
         Fp5ZQrK9yCNsvePzbN77MHhCp9dbiMvhwrNlzLfVALm+xYQfIBipMOr++2xQLnTu8h5Z
         A65d1vQ6CaaQv2P9FaNmBd//YzB29BJ+1y4y0ae8mYqL1zdpLD8rJH2cAzL0/w36Snbl
         bIYA==
X-Gm-Message-State: AOAM530+LwHHcLDGwdebA9jdghpyo4LAQ1aK1POEVngnoOHMr0rTH21v
        hms3NzqXCVBe1UrFNtP1uSI5S61Uz91Gs7CDUSoZkQ==
X-Google-Smtp-Source: ABdhPJwG8Y4LMabzkjP+uuwBNoerM5nlNrQdh6yQLOQ7+iGBwWpYMz7tUNyef4sT0fe3je9Llv/MLkzghbAt/MueFgk=
X-Received: by 2002:a2e:bc1b:: with SMTP id b27mr33705963ljf.91.1637394835107;
 Fri, 19 Nov 2021 23:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20211120045011.3074840-1-almasrymina@google.com> <20211120045011.3074840-2-almasrymina@google.com>
In-Reply-To: <20211120045011.3074840-2-almasrymina@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Nov 2021 23:53:43 -0800
Message-ID: <CALvZod7dFi=yL3nPLJ4XkFR+2qXaOVd9RSX_fpmacUiQdSvo4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: support deterministic memory charging of filesystems
To:     Mina Almasry <almasrymina@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 19, 2021 at 8:50 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Users can specify a memcg= mount option option at mount time and all

*option

> data page charges will be charged to the memcg supplied.  This is useful
> to deterministicly charge the memory of the file system or memory shared

*deterministically

> via tmpfs for example.
>
> Implementation notes:
> - Add memcg= option parsing to fs common code.
> - We attach the memcg to charge for this filesystem data pages to the
>   struct super_block. The memcg can be changed via a remount operation,
>   and all future memcg charges in this filesystem will be charged to
>   the new memcg.
> - We create a new interface mem_cgroup_charge_mapping(), which will
>   check if the super_block in the mapping has a memcg to charge. It
>   charges that, and falls back to the mm passed if there is no
>   super_block memcg.
> - On filesystem data memory allocation paths, we call the new interface
>   mem_cgroup_charge_mapping().
>
> Caveats:
> - Processes are only allowed to direct filesystem charges to a cgroup that

I don't think 'Processes' is the right terminology here. The
admin/user doing the mount operation with memcg option should have
access to move processes into the target memcg.

>   they themselves can enter and allocate memory in. This so that we do not
>   introduce an attack vector where processes can DoS any cgroup in the
>   system that they are not normally allowed to enter and allocate memory in.
> - In mem_cgroup_charge_mapping() we pay the cost of checking whether the
>   super_block has a memcg to charge, regardless of whether the mount
>   point was mounted with memcg=. This can be alleviated by putting the
>   memcg to charge in the struct address_space, but, this increases the
>   size of that struct and makes it difficult to support remounting the
>   memcg= option, although remounting is of dubious value.

We can start simple with no remount option or maybe follow the memcg
v2 semantics of process migrating from one memcg to another. The older
memory of the process will remain charged to the older memcg and after
migration, the new memory will be charged to the newer memcg.

Similarly the older inode/mappings will still be linked to the older
memcg and after remount the newer mappings will be linked with newer
memcg. You would need to find out if each mapping should hold a memcg
reference.

[...]
>
> +static int parse_param_memcg(struct fs_context *fc, struct fs_parameter *param)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       if (strcmp(param->key, "memcg") != 0)
> +               return -ENOPARAM;
> +
> +       if (param->type != fs_value_is_string)
> +               return invalf(fc, "Non-string source");
> +
> +       if (fc->memcg)
> +               return invalf(fc, "Multiple memcgs specified");
> +
> +       memcg = mem_cgroup_get_from_path(param->string);

You need to drop this reference in put_fs_context() and give the
super_block its own memcg reference.

> +       if (IS_ERR(memcg))
> +               return invalf(fc, "Bad value for memcg");
> +
> +       fc->memcg = memcg;
> +       param->string = NULL;
> +       return 0;
> +}
> +
>  /**
>   * vfs_parse_fs_param - Add a single parameter to a superblock config
>   * @fc: The filesystem context to modify
> @@ -148,6 +171,10 @@ int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
>                         return ret;
>         }
>
> +       ret = parse_param_memcg(fc, param);

You might need to call this before fs specific handling (i.e.
fc->ops->parse_param).

> +       if (ret != -ENOPARAM)
> +               return ret;
> +
>         /* If the filesystem doesn't take any arguments, give it the
>          * default handling of source.
>          */

[...]

> +
> +void mem_cgroup_put_name_in_seq(struct seq_file *m, struct super_block *sb)
> +{
> +       struct mem_cgroup *memcg;
> +       int ret = 0;
> +       char *buf = __getname();
> +       int len = PATH_MAX;
> +
> +       if (!buf)
> +               return;
> +
> +       buf[0] = '\0';
> +
> +       rcu_read_lock();
> +       memcg = rcu_dereference(sb->s_memcg_to_charge);
> +       if (memcg && !css_tryget_online(&memcg->css))

No need to get an explicit reference. You can call cgroup_path within rcu.

> +               memcg = NULL;
> +       rcu_read_unlock();
> +
> +       if (!memcg)
> +               return;
> +
> +       ret = cgroup_path(memcg->css.cgroup, buf + len / 2, len / 2);
> +       if (ret >= len / 2)
> +               strcpy(buf, "?");
> +       else {
> +               char *p = mangle_path(buf, buf + len / 2, " \t\n\\");
> +
> +               if (p)
> +                       *p = '\0';
> +               else
> +                       strcpy(buf, "?");
> +       }
> +
> +       css_put(&memcg->css);
> +       if (buf[0] != '\0')
> +               seq_printf(m, ",memcg=%s", buf);
> +
> +       __putname(buf);
> +}
> +
> +/*
> + * Set or clear (if @memcg is NULL) charge association from file system to
> + * memcg.  If @memcg != NULL, then a css reference must be held by the caller to
> + * ensure that the cgroup is not deleted during this operation, this reference
> + * is dropped after this operation.

The given reference is not really dropped after this operation but
rather the reference is being stolen here.

> + */
> +void mem_cgroup_set_charge_target(struct super_block *sb,
> +                                 struct mem_cgroup *memcg)
> +{
> +       memcg = xchg(&sb->s_memcg_to_charge, memcg);

Don't borrow the reference, get a new one for sb.

> +       if (memcg)
> +               css_put(&memcg->css);
> +}
> +
> +/*
> + * Returns the memcg to charge for inode pages.  If non-NULL is returned, caller
> + * must drop reference with css_put().  NULL indicates that the inode does not
> + * have a memcg to charge,

* or the attached memcg is offline.

> so the default process based policy should be used.
> + */
> +static struct mem_cgroup *
> +mem_cgroup_mapping_get_charge_target(struct address_space *mapping)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       if (!mapping)
> +               return NULL;
> +
> +       rcu_read_lock();
> +       memcg = rcu_dereference(mapping->host->i_sb->s_memcg_to_charge);
> +       if (memcg && !css_tryget_online(&memcg->css))
> +               memcg = NULL;
> +       rcu_read_unlock();
> +
> +       return memcg;
> +}
> +
