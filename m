Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4798E5BA6CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIPG2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIPG2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 02:28:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00781A2621
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 23:28:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q21so30057295edc.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Sep 2022 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=T+2kwqDBuKfdTc4n+FantwhYrLVjI20chlaW9Gl+bdI=;
        b=GY3Rkf9Vg0zritTXiXxxt0b1tViADEs3tl1pbw7NGIGAuYYFQuC+nm0hNR8kunCKs/
         GGBzWoTOKkwTfX2s2wPXbtqfNuT9HJd4WC0YM1maum6QMaBOPtd2M7k0b1Itj56UGZ8X
         XI2aqeblsvEyaDHKlCqnNvwCw21vo3kRKWUW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=T+2kwqDBuKfdTc4n+FantwhYrLVjI20chlaW9Gl+bdI=;
        b=ENOb4TvV3VDFski9158QhvviVOTqByQB0rI6yUDXMd1FifRX0yv1NnmssufPcmpFq/
         vDKeBPlx8PkY48FWN8emI+qGRiP2lRIE1tH8a+JfPoKobIMjz9qYp9M9+26a6MUKlEn3
         u429ZlLc2omU4RrkbN933qQMcu1sqZjRliUoa9+zIdTM57WJeJWds+Lotb5WHuB853LG
         UXF8h+dMjJgbjOoPlmNQ522tV/OIQAZd3zpwWuCU9nvLEy7PsxN8hhJSl9TRc6uBU0p9
         0UXF7y/3ERzdtJBNgT3jpH3UgD5e9cGBWGoSKeCH8bGpp9MqZ7R7aTfzVCfhFIrN3kmj
         UUXw==
X-Gm-Message-State: ACrzQf3i/c/a1F/ThHlkbD6G5D2i8vtSKbOf/oCWmLSXUfzxdiD6/2hO
        eVr7zDvrB41pw/H5wNDt9YIoTfH3Ex/CHEmiYwA7+5uORIg=
X-Google-Smtp-Source: AMsMyM7AfEA8bl7zdCg2hp/HcFnKDnZv95mHwmxzN0cFEGq5wiwe3rRB5Cg3rEmWKmI+hcAZU8V/nV21RYXM+jCbdKc=
X-Received: by 2002:a05:6402:4517:b0:443:7fe1:2d60 with SMTP id
 ez23-20020a056402451700b004437fe12d60mr2694809edb.133.1663309697545; Thu, 15
 Sep 2022 23:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220221082002.508392-1-mszeredi@redhat.com> <166304411168.30452.12018495245762529070@noble.neil.brown.name>
 <YyATCgxi9Ovi8mYv@ZenIV> <166311315747.20483.5039023553379547679@noble.neil.brown.name>
 <YyEcqxthoso9SGI2@ZenIV> <166330881189.15759.13499931397891560275@noble.neil.brown.name>
In-Reply-To: <166330881189.15759.13499931397891560275@noble.neil.brown.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 16 Sep 2022 08:28:06 +0200
Message-ID: <CAJfpeguwtADz8D1eUp4JVY-7-WKcf8giiiyvvdv4jccGtxcJKw@mail.gmail.com>
Subject: Re: [PATCH RFC] VFS: lock source directory for link to avoid rename race.
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Xavier Roche <xavier.roche@algolia.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 16 Sept 2022 at 08:13, NeilBrown <neilb@suse.de> wrote:

> @@ -4554,44 +4590,83 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
>         if (flags & AT_SYMLINK_FOLLOW)
>                 how |= LOOKUP_FOLLOW;
>  retry:
> -       error = filename_lookup(olddfd, old, how, &old_path, NULL);
> +       err2 = 0;
> +       error = filename_parentat(olddfd, old, how, &old_path,
> +                                 &old_last, &old_type);
>         if (error)
>                 goto out_putnames;
> +       error = -EISDIR;
> +       if (old_type != LAST_NORM && !(flags & AT_EMPTY_PATH))
> +               goto out_putnames;
> +       error = filename_parentat(newdfd, new, (how & LOOKUP_REVAL), &new_path,
> +                                 &new_last, &new_type);
> +       if (error)
> +               goto out_putoldpath;
>
> -       new_dentry = filename_create(newdfd, new, &new_path,
> -                                       (how & LOOKUP_REVAL));
> -       error = PTR_ERR(new_dentry);
> -       if (IS_ERR(new_dentry))
> -               goto out_putpath;
> +       err2 = mnt_want_write(new_path.mnt);
>
>         error = -EXDEV;
>         if (old_path.mnt != new_path.mnt)
> -               goto out_dput;
> +               goto out_putnewpath;
> +       lock_link(new_path.dentry, old_path.dentry, flags);
> +
> +       new_dentry = __lookup_hash(&new_last, new_path.dentry, how & LOOKUP_REVAL);
> +       error = PTR_ERR(new_dentry);
> +       if (IS_ERR(new_dentry))
> +               goto out_unlock;
> +       error = -EEXIST;
> +       if (d_is_positive(new_dentry))
> +               goto out_dput_new;
> +       if (new_type != LAST_NORM)
> +               goto out_dput_new;
> +
> +       error = err2;
> +       if (error)
> +               goto out_dput_new;
> +
> +       if (flags & AT_EMPTY_PATH)
> +               old_dentry = dget(old_path.dentry);
> +       else
> +               old_dentry = __lookup_hash(&old_last, old_path.dentry, how);

This will break AT_SYMLINK_FOLLOW.

And yes, we can add all the lookup logic to do_linkat() at which point
it will about 10x more complex than it was.

Thanks,
Miklos
