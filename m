Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6861F97BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgFONCJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 09:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbgFONBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:01:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5EC05BD1E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 06:01:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c35so11455836edf.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvCe0HbqQ4BzGml+0DuV0nSjSHUXH/a7GtKAihE8SRE=;
        b=AXJhM/hKmiZBel7yqZsPLh+qR48DiuSWw+gN6NwcjxGonGBBT4xZNIhnQoUZBfpJfH
         1NZAFJQspIVoZmiDPMW/zVKEpYy92CPJhP1ryw7noohJnifYPJFtPAPipclcRU51LyVJ
         aFmGcX6C+7O0dfinR4r59frhdDr+6ymq5ln90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvCe0HbqQ4BzGml+0DuV0nSjSHUXH/a7GtKAihE8SRE=;
        b=j1Ghs6ZYmbkhwjfb5939XJy/ixfiCMz18LAjCDbebFhHxPPWB9HjcXYUgnP363pgR8
         OWcilErghCt4RktqN3KGpWOiTXoT7QxrX5bfMBnKz+c8/NYJr2x7X/ItSUOfyBEOInMN
         po7VMLoFB02ZfU5ujUJE4oD7BsiKD5gyUc31GatBSRUeKPD0a7GIr0+a5Dhx9atTRg2B
         euqxINnWhrgbPSFy52kdFtFKfvG+4psNHbygkuaYij1PpbdqP6xfZOcYlg35ZjFTOftV
         3cVbOCN3pv/T5Q0XKhmVWXtYR8I1vi4Sb0IllOb1rrC84/fGdQOQjOvXj8++6rOQbZ2B
         Q9Og==
X-Gm-Message-State: AOAM531NspJatstQdYJVS6/aKzHzhyC6Jo4/obJPWB9yUkBrhS82unaQ
        WIxhQKrDHBb/dFLAdUpgeoQuRvkw2lWfoC+pZjqLew==
X-Google-Smtp-Source: ABdhPJw5bS2bqPFdNiYWV2UphtcYunDkac05QqFEUWlRJ3HITjBAcbh0ivLoUAsUyrpP21XvFyU3Zn5XsOsK+kRq7j8=
X-Received: by 2002:aa7:d9d3:: with SMTP id v19mr22985359eds.364.1592226108717;
 Mon, 15 Jun 2020 06:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200612004644.255692-1-mike.kravetz@oracle.com>
 <20200612015842.GC23230@ZenIV.linux.org.uk> <b1756da5-4e91-298f-32f1-e5642a680cbf@oracle.com>
 <CAOQ4uxg=o2SVbfUiz0nOg-XHG8irvAsnXzFWjExjubk2v_6c_A@mail.gmail.com>
 <6e8924b0-bfc4-eaf5-1775-54f506cdf623@oracle.com> <CAJfpegsugobr8LnJ7e3D1+QFHCdYkW1swtSZ_hKouf_uhZreMg@mail.gmail.com>
 <CAOQ4uxgA+_4_UtVz17_eJL6m0CsDEVuiriBj1ZOkho+Ub1yuSA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgA+_4_UtVz17_eJL6m0CsDEVuiriBj1ZOkho+Ub1yuSA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 15 Jun 2020 15:01:37 +0200
Message-ID: <CAJfpegs-Ch5ua658UD5s4u6ynKGpMzdiY31G-c4Fdu_=ZCV_uA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hugetlb: use f_mode & FMODE_HUGETLBFS to identify
 hugetlbfs files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:05 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Mon, Jun 15, 2020 at 10:53 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Sat, Jun 13, 2020 at 9:12 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > >
> > > On 6/12/20 11:53 PM, Amir Goldstein wrote:
> >
> > > As a hugetlbfs developer, I do not know of a use case for interoperability
> > > with overlayfs.  So yes, I am not too interested in making them work well
> > > together.  However, if there was an actual use case I would be more than
> > > happy to consider doing the work.  Just hate to put effort into fixing up
> > > two 'special' filesystems for functionality that may not be used.
> > >
> > > I can't speak for overlayfs developers.
> >
> > As I said, I only know of tmpfs being upper layer as a valid use case.
> >    Does that work with hugepages?  How would I go about testing that?
>
> Simple, after enabling CONFIG_HUGETLBFS:
>
> diff --git a/mount_union.py b/mount_union.py
> index fae8899..4070c70 100644
> --- a/mount_union.py
> +++ b/mount_union.py
> @@ -15,7 +15,7 @@ def mount_union(ctx):
>          snapshot_mntroot = cfg.snapshot_mntroot()
>          if cfg.should_mount_upper():
>              system("mount " + upper_mntroot + " 2>/dev/null"
> -                    " || mount -t tmpfs upper_layer " + upper_mntroot)
> +                    " || mount -t hugetlbfs upper_layer " + upper_mntroot)
>          layer_mntroot = upper_mntroot + "/" + ctx.curr_layer()
>          upperdir = layer_mntroot + "/u"
>          workdir = layer_mntroot + "/w"
>
> It fails colossally, because hugetlbfs, does not have write_iter().
> It is only meant as an interface to create named maps of huge pages.
> So I don't really see the use case for using it as upper.

Right.

I was actually asking about the tmpfs+hugepages, not the hugetlbfs case.

In the tmpfs case it looks like the lack of ->get_unmapped_area() in
overlayfs could still be an issue.   But I'm not sure how to trigger
that.

Thanks,
Miklos
