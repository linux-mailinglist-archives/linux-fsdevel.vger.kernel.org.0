Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376D52CFC72
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Dec 2020 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgLESVu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Dec 2020 13:21:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725267AbgLESVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607192405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eJ3TlJLyB/D1p6iBoOSpxo7AX6033ynhX3Zy+9CpELA=;
        b=YVOSnSWGW0QRVfWEZg63Rglk6zYGeU23hWFIWvOlKju/EXWa26PZVk67LjZry7Sdj9+V3B
        uDh5Us2Q370jb5G5QwSS0DdlGOkNNfffhp5AOGCE0xZkSfA4BGtmVRP8Q4QqT27ATqtzOA
        BRDK9ByTB4flEJJc2/VVVQVaN2QbhfY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-nRaUJY0lMu-26YJsQU9Iaw-1; Sat, 05 Dec 2020 08:51:21 -0500
X-MC-Unique: nRaUJY0lMu-26YJsQU9Iaw-1
Received: by mail-qv1-f71.google.com with SMTP id b15so7463382qvm.10
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Dec 2020 05:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eJ3TlJLyB/D1p6iBoOSpxo7AX6033ynhX3Zy+9CpELA=;
        b=CUnHzAqEOaZHhosjeJjb5+PVFDpHWd+Bt3FN/jsEENkV4oloAbCIQpZ9+lvZw6IFfl
         sDT00QWa5D5tUkqgB3pNdkaO0N4aXuNfFKkMkdG70S5n2YM+pjPYdJM7mkktcabGZC4p
         c3ry/yZFsMLtEXN0GYBWEv+SVIpg4IRAP4dOU7Sc6ZzZ1fuPugGJMxA/RqVEgi5zDu07
         6B0C904oLrPoDpfRdobjiqGofiqhOqQ/CZw4EPKOfnSYUAZBk2sW7SDQZrfwDvG64Os7
         unP0wDT4ha6hD4AIXuCbU5A33lxxyKFaF8fn8DQMec2pk8kDoUPWfStCEHz9FUVQrIM5
         dwTg==
X-Gm-Message-State: AOAM533YBMHq7h+6BL6noGHtcb0X+tcWXW18UOVs/m2Zx73h/5q5RpIx
        YtLTjMOZ6GkS0RZD/VU1GtjAb1CYFaZEGFj7C21a9/JHtUGskb1dHTD4m5QMAt20AuoofzT82uK
        I0vddq31r8p7f9SZg5s9Jr1JPBQ==
X-Received: by 2002:ac8:1486:: with SMTP id l6mr14654699qtj.123.1607176280493;
        Sat, 05 Dec 2020 05:51:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzf0TX7HzWr+7ZlUNgaWDbTFRqjLfGWcFqjWR0uZ/edGk7MUPRmkFxWz347muqImSmgQQ8VbA==
X-Received: by 2002:ac8:1486:: with SMTP id l6mr14654671qtj.123.1607176280168;
        Sat, 05 Dec 2020 05:51:20 -0800 (PST)
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d11sm8800449qta.64.2020.12.05.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 05:51:19 -0800 (PST)
Message-ID: <5468a450ac7e9626af1a61a29ef17a6855d6692f.camel@redhat.com>
Subject: Re: [PATCH v2 4/4] overlay: Add rudimentary checking of writeback
 errseq on volatile remount
From:   Jeff Layton <jlayton@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sargun Dhillon <sargun@sargun.me>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Date:   Sat, 05 Dec 2020 08:51:18 -0500
In-Reply-To: <CAOQ4uxjeG4N7i95D+YFr0zo82nLOjUCdUhD8e1WABFtwtQYzrQ@mail.gmail.com>
References: <20201127092058.15117-1-sargun@sargun.me>
         <20201127092058.15117-5-sargun@sargun.me>
         <20201130191509.GC14328@redhat.com>
         <CAOQ4uxjeG4N7i95D+YFr0zo82nLOjUCdUhD8e1WABFtwtQYzrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2020-12-05 at 11:13 +0200, Amir Goldstein wrote:
> On Mon, Nov 30, 2020 at 9:15 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > On Fri, Nov 27, 2020 at 01:20:58AM -0800, Sargun Dhillon wrote:
> > > Volatile remounts validate the following at the moment:
> > >  * Has the module been reloaded / the system rebooted
> > >  * Has the workdir been remounted
> > > 
> > > This adds a new check for errors detected via the superblock's
> > > errseq_t. At mount time, the errseq_t is snapshotted to disk,
> > > and upon remount it's re-verified. This allows for kernel-level
> > > detection of errors without forcing userspace to perform a
> > > sync and allows for the hidden detection of writeback errors.
> > > 
> > > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > Cc: linux-fsdevel@vger.kernel.org
> > > Cc: linux-unionfs@vger.kernel.org
> > > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > > Cc: Amir Goldstein <amir73il@gmail.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/overlayfs/overlayfs.h | 1 +
> > >  fs/overlayfs/readdir.c   | 6 ++++++
> > >  fs/overlayfs/super.c     | 1 +
> > >  3 files changed, 8 insertions(+)
> > > 
> > > diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> > > index de694ee99d7c..e8a711953b64 100644
> > > --- a/fs/overlayfs/overlayfs.h
> > > +++ b/fs/overlayfs/overlayfs.h
> > > @@ -85,6 +85,7 @@ struct ovl_volatile_info {
> > >        */
> > >       uuid_t          ovl_boot_id;    /* Must stay first member */
> > >       u64             s_instance_id;
> > > +     errseq_t        errseq; /* Implemented as a u32 */
> > >  } __packed;
> > > 
> > >  /*
> > > diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> > > index 7b66fbb20261..5795b28bb4cf 100644
> > > --- a/fs/overlayfs/readdir.c
> > > +++ b/fs/overlayfs/readdir.c
> > > @@ -1117,6 +1117,12 @@ static int ovl_verify_volatile_info(struct ovl_fs *ofs,
> > >               return -EINVAL;
> > >       }
> > > 
> > > +     err = errseq_check(&volatiledir->d_sb->s_wb_err, info.errseq);
> > > +     if (err) {
> > > +             pr_debug("Workdir filesystem reports errors: %d\n", err);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > >       return 1;
> > >  }
> > > 
> > > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > > index a8ee3ba4ebbd..2e473f8c75dd 100644
> > > --- a/fs/overlayfs/super.c
> > > +++ b/fs/overlayfs/super.c
> > > @@ -1248,6 +1248,7 @@ static int ovl_set_volatile_info(struct ovl_fs *ofs, struct dentry *volatiledir)
> > >       int err;
> > >       struct ovl_volatile_info info = {
> > >               .s_instance_id = volatiledir->d_sb->s_instance_id,
> > > +             .errseq = errseq_sample(&volatiledir->d_sb->s_wb_err),
> > 
> > errse_sample() seems to return 0 if nobody has seen the error yet. That
> > means on remount we will fail. It is a false failure from our perspective
> > and we are not interested in knowing if somebody else has seen the
> > failure or not.
> > 
> > Maybe we need a flag in errseq_sample() to get us current value
> > irrespective of the fact whether anybody has seen the error or not?
> > 
> > If we end up making this change, then we probably will have to somehow
> > mask ERRSEQ_SEEN bit in errseq_check() comparison. Because if we
> > sampled ->s_wb_err when nobody saw it and later by the remount time
> > say ERRSEQ_SEEN is set, we don't want remount to fail.
> > 
> 
> Hopping back to this review, looks like for volatile mount we need
> something like (in this order):
> 1. check if re-use and get sampled errseq from volatiledir xattr
> 2. otherwise errseq_sample() upper_sb and store in volatiledir xattr

I'm not sure I follow. Why does this need to go into an xattr?

errseq_t is never persisted on stable storage. It's an entirely
in-memory thing.


> 3. errseq_check() since stored or sampled errseq (0 for fresh mount
> with unseen error)
> 4. fail volatile mount if errseq_check() failed
> 5. errseq_check() since stored errseq on fsync()/syncfs()
> 

I think this is simpler than that. You just need a new errseq_t helper
that only conditionally samples if the thing is 0 or if the error has
already been seen. Something like this (hopefully with a better name):

bool errseq_sample_no_unseen(errseq_t *eseq, errseq_t *sample)         
{                                                                      
        errseq_t old = READ_ONCE(*eseq);                               
                                                                       
        if (old && !(old & ERRSEQ_SEEN))                               
                return false;                                          
        *sample = old;                                                 
        return true;                                                   
}                                                                      
       
If that returns false, fail the mount. If it's true, then save off the
sample and proceed.

> For fresh volatile mount, syncfs can fix the temporary mount error.
> For re-used volatile mount, the mount error is permanent.
> 
> Did I miss anything?
> Is the mount safe for both seen and unseen error cases? no error case?
> Are we safe if a syncfs on upper_sb sneaks in between 2 and 3?
> 
> Thanks,
> Amir.
> 

-- 
Jeff Layton <jlayton@redhat.com>

