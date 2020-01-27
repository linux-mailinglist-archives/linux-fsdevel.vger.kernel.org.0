Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7E14A9E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 19:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgA0SiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 13:38:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37237 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0SiL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:38:11 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so11175739ioc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 10:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZkkEQpCnEMlrw0pzmYvJ/aSGVfgGEqcNRmHOEHYFfY=;
        b=bKhWX+Tn9vKu+3KDosqwMxXhml2vtPKlFNelMm1Ml/4uGB+aBj/1yTFKevF+086J3P
         pYz+/eN3iAxf0AtlT/VNEi0HI4tmGrDMDeB2bRm/LKJigLXdYiCDJH7JLeRWcAATMoCL
         ppIzcsg9SpCs40cEs6a6hXdKTnISXDZU1E9zHjjA9q0T7WT5/RhHDBcmpK8lHQ4eA/h+
         nEIpFVUcC9mkh2sshU0cKtPu2r9CkyjlJlQyDi0qMWPRuB6j4CXjvcru8mGfUbhPyqBx
         qex1VP/s5b1OPiTe2XbtNkjjSApl4aRi9WJn0F1LF2hmCLi73VWmWoNHAyBDKdLZVhI9
         TI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZkkEQpCnEMlrw0pzmYvJ/aSGVfgGEqcNRmHOEHYFfY=;
        b=RvsiW7m+YjfPUYFCU5FI6yvHC4l8x79kzDylO6HxYTkw0DVNbzaURd6jGgJ8InnlqF
         fX14CpmaiGzLzGQucd892wEonmgpsAclkILACuIkx6AGKLpMaRkQihmN42Hr1eVXHsPl
         hfZM8FlmzN83VEjNOVq6Hl5V2Fh1DJkmxump2XudNMlehIHzkGzcH0m2WqUOgjBLAM2G
         R0AKKVLmSoljdvLtNafpy0mSYMWXKnckoEQ9i7PfYp3969NAOeW6i2JcnaEtIxZJqh7L
         ngNaJPnNPEkqdSzx+kTFE0e4p3CtafCe8mBHc2AljKypASQjHAg4toLmycYTx6jf5unk
         nVIg==
X-Gm-Message-State: APjAAAXZGScWuapodXto7BO9Nn0E2L4g/R+rtEEORKisKnsCD/rBrPg3
        vJwbQndjzOSNY6My0GY0t+8W3LWz3eMJAdy51Rc=
X-Google-Smtp-Source: APXvYqxDagXUL+bcXUy0hwsQ9ABpKZYAuTKyY7qttp7IAjgC0C0rr/54RAtL1w+BuRn1wQlDUA6cTMjBAOW3/71ovKI=
X-Received: by 2002:a6b:f214:: with SMTP id q20mr14248759ioh.137.1580150291016;
 Mon, 27 Jan 2020 10:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20200126220800.32397-1-amir73il@gmail.com> <20200127173002.GD115624@pick.fieldses.org>
In-Reply-To: <20200127173002.GD115624@pick.fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 Jan 2020 20:38:00 +0200
Message-ID: <CAOQ4uxhqO5DtSwAtO950oGcnWVaVG+Vcdu6TYDfUKawVNGWEiA@mail.gmail.com>
Subject: Re: [PATCH] exportfs: fix handling of rename race in reconnect_one()
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 7:30 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> Thanks for spotting this!
>
> On Mon, Jan 27, 2020 at 12:08:00AM +0200, Amir Goldstein wrote:
> > If a disconnected dentry gets looked up and renamed between the
> > call to exportfs_get_name() and lookup_one_len_unlocked(), and if also
> > lookup_one_len_unlocked() returns ERR_PTR(-ENOENT), maybe because old
> > parent was deleted, we return an error, although dentry may be connected.
>
> A comment that -ENOENT means the parent's gone might be helpful.

It doesn't have to mean that, but that's the most obvious case.

>
> But are we sure -ENOENT is what every filesystem returns in the case the
> parent was deleted?

No, it's what __lookup_slow() returns if parent is dead.
Most filesystems do not return -ENOENT for lookup, but a negative
dentry on NULL. I am not sure which filesystems return -ENOENT.
A short survey of NFS exporting fs I didn't find any.

> And are we sure there aren't other cases that
> should be handled similarly to -ENOENT?
>

Not sure, but ENOENT is the most obvious one for rename race.

> > Commit 909e22e05353 ("exportfs: fix 'passing zero to ERR_PTR()'
> > warning") changes this behavior from always returning success,
> > regardless if dentry was reconnected by somoe other task, to always
> > returning a failure.
>
> I wonder whether it might be safest to take the out_reconnected case on
> any error, not just -ENOENT.
>

I wondered that as well, but preferred to follow the precedent.

> Looking further back through the history....  Looks like the missing
> PTR_ERR(tmp) was just a mistake, introduced in 2013 by my bbf7a8a3562f
> "exportfs: move most of reconnect_path to helper function".  So the
> historical behavior was always to bail on error.
>
> The old code still did a DCACHE_DISCONNECTED check on the target dentry
> in that case and returned success if it found that already cleared, but
> we can't necessarily rely on DCACHE_DISCONNECTED being cleared
> immediately, so the old code was probably still vulnerable to the race
> you saw.
>

Yeh, I started to try and document history, but since there seemed to be
no point where behavior looked sane I gave up.

> There's not much value in preserving the error as exportfs_decode_fh()
> ends up turning everything into ENOMEM or ESTALE for some reason.
>

You signed up on this reason...

Thanks,
Amir.

commit 09bb8bfffd29c3dffb72bc2c69a062dfb1ae624c
Author: NeilBrown <neilb@suse.com>
Date:   Thu Aug 4 10:19:06 2016 +1000

    exportfs: be careful to only return expected errors.

    When nfsd calls fh_to_dentry, it expect ESTALE or ENOMEM as errors.
    In particular it can be tempting to return ENOENT, but this is not
    handled well by nfsd.

    Rather than requiring strict adherence to error code code filesystems,
    treat all unexpected error codes the same as ESTALE.  This is safest.

    Signed-off-by: NeilBrown <neilb@suse.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
