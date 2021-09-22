Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387FE414B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbhIVOCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234272AbhIVOC3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 10:02:29 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74980C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 07:00:59 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id o124so3059221vsc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/PFaCHE2WPQbR8drQXuuWr5Eu0qa3Smkwzq6UOruVoI=;
        b=XmOBm56HjqwB5qD9VVdHzC/i8Edr+mLRECUuTTW3RVWZW26D1FuP0VcRWWRx7bB25l
         DRDY76/ZERZ8y1/wnstMEheh5w6tN7bqeMdkj3ssQxSWpnqX5VDNT1Lz40Tc4DqOY4PR
         mCH5FG+dkzmz+C4mIegeKS1PI6bZRNlhhWfEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/PFaCHE2WPQbR8drQXuuWr5Eu0qa3Smkwzq6UOruVoI=;
        b=eF4iAN6BIHkACg1PKil0lHgEFPoNVaiGQhShISPXK6VK88sJiy6LV83LbXrqUqP8qe
         V2dHE0c6oOHjJOcAw+8aRuCrWogWb+WqU5/KcYsYvRUwBF6w+kWQiUpL3i1xc0B6IxXc
         CjGLvzEGgUn98mHPkgiZrMw/jEwPY/BUchtYnG5qS/Sb44vnn63ZZN2DL/wFimlmisa+
         2KfLhnONlnHelVuE32suRi7t7QNNRRRQ5hEeMR5wk9Y11DaIKm4klMIPh+Zzla9ZAMdl
         Q+SqjkfYy+Azh5TaIzJGfMnin9yoFr2xailhqA3yfihrk3v69Ups/n9FnRi3Ha+VJJL0
         BUCQ==
X-Gm-Message-State: AOAM532kh5gjLdWqUUddgRL1Z/5VNG9ZZ8UfGTl0LXWTpSy5Tit99Qt3
        m5pK440PXeNui/eZZMc1+j7ShSXduMSHJ8en0DtLHw==
X-Google-Smtp-Source: ABdhPJzLFDP6oHPM8O+TCnOQ2tcicQwVUQ05DQqQP1jodQ+V7vyRWUcwn6ifv4Zj61RXNiYgu/wXWpvU6BF987IT/pQ=
X-Received: by 2002:a05:6102:40f:: with SMTP id d15mr18784743vsq.51.1632319258613;
 Wed, 22 Sep 2021 07:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com> <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com> <314324e7-02d7-dc43-b270-fb8117953549@139.com>
In-Reply-To: <314324e7-02d7-dc43-b270-fb8117953549@139.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 22 Sep 2021 16:00:47 +0200
Message-ID: <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: fix null pointer when filesystemdoesn'tsupportdirect
 IO
To:     Chengguang Xu <cgxu519@139.com>
Cc:     Huang Jianan <huangjianan@oppo.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 Sept 2021 at 15:21, Chengguang Xu <cgxu519@139.com> wrote:
>
> =E5=9C=A8 2021/9/22 16:24, Huang Jianan =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2021/9/22 16:06, Chengguang Xu =E5=86=99=E9=81=93:
> >> =E5=9C=A8 2021/9/22 15:23, Huang Jianan =E5=86=99=E9=81=93:
> >>> From: Huang Jianan <huangjianan@oppo.com>
> >>>
> >>> At present, overlayfs provides overlayfs inode to users. Overlayfs
> >>> inode provides ovl_aops with noop_direct_IO to avoid open failure
> >>> with O_DIRECT. But some compressed filesystems, such as erofs and
> >>> squashfs, don't support direct_IO.
> >>>
> >>> Users who use f_mapping->a_ops->direct_IO to check O_DIRECT support,
> >>> will read file through this way. This will cause overlayfs to access
> >>> a non-existent direct_IO function and cause panic due to null pointer=
:
> >>
> >> I just looked around the code more closely, in open_with_fake_path(),
> >>
> >> do_dentry_open() has already checked O_DIRECT open flag and
> >> a_ops->direct_IO of underlying real address_space.
> >>
> >> Am I missing something?
> >>
> >>
> >
> > It seems that loop_update_dio will set lo->use_dio after open file
> > without set O_DIRECT.
> > loop_update_dio will check f_mapping->a_ops->direct_IO but it deal
> > with ovl_aops with
> > noop _direct_IO.
> >
> > So I think we still need a new aops?
>
>
> It means we should only set ->direct_IO for overlayfs inodes whose
> underlying fs has DIRECT IO ability.

First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
return -EINVAL if not.

To fix the loop -> overlay -> squashfs case your suggestion of having
separate aops depending on the real inode's ->direct_IO sounds good.

Thanks,
Miklos
