Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE43E50341
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfFXHZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:25:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43529 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfFXHZM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:25:12 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so122801ios.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d06Pia/4lguTSyfVaEUkJGeGzpj48WO3rGAQAMd0JI0=;
        b=rJKBNWS/CBTy5/iFxgr+p/i6UK2GzCu06m4babw4ksvR9H8XBN7Jz7JwzofgpjmuTs
         Bk+7hgADEaxcUjCveN8zvoIz5AJPfaxQPdn9xY8iwK3UphdlI9FOxUvbGouCd3mgAZi0
         A+jX5TEKN6abHFboRaB9AbJwa8n/jXJPoHd7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d06Pia/4lguTSyfVaEUkJGeGzpj48WO3rGAQAMd0JI0=;
        b=pGwWDsgpk5VZPGH7I8PsEs2LG7SQO37v5w6MPUTE+c7nLgEfw31qcDS/NYzZzd5pPo
         +ys1SdhaWVPHiG4FuargyKSCmr6uuwpIH/x8vs4qHj/nXxmYvdbiDD+ynEGTm7Iq+Lbf
         YNlJ2+MIExyyrzRSCOVW71v4vc/usNAs1+InsxgXVCFY9Ega9N469cLrH2CrL27Q8AxA
         0WPVwOdZu6p0O5DL0Po3V7VfRYl3pnIfMQuG51uBEcs142nuXR8b2lvZaRGJfqEI24Yv
         mgkPSn0FHfHaAR6WlLS8+kyHfyWhA+sm/wH/P5kgFfUy/8VoiL5a5ppnuEt35k5OkBBs
         kLDw==
X-Gm-Message-State: APjAAAUlY4cYdYh87mz6ZDRcvRdBZ2FZNXzsodpdDbnvv6JuUiETSo2b
        p0UE1hOy8wn9A/Bu00qCE6tEOaPGRX+jYAOGZaaaEw==
X-Google-Smtp-Source: APXvYqzSFVYqgkEMUYRR/hMSf4R0JOiOzdzfQKcoXcpVZ2cUWIBSIsXogNHRPZg/mu51W1Q8ppk6FXK6bX3yJdvx55k=
X-Received: by 2002:a5e:da4b:: with SMTP id o11mr8462865iop.212.1561361111479;
 Mon, 24 Jun 2019 00:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CANQeFDCCGED3BR0oTpzQ75gtGpdGCw8FLf+kspBYytw3YteXAw@mail.gmail.com>
 <20190620083628.GH13630@quack2.suse.cz> <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
In-Reply-To: <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 24 Jun 2019 09:25:00 +0200
Message-ID: <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com>
Subject: Re: a few questions about pagevc_lookup_entries
To:     Liu Bo <obuil.liubo@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        dan.j.williams@intel.com, Fengguang Wu <fengguang.wu@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc: vivek, stefan, dgilbert]

On Fri, Jun 21, 2019 at 12:04 AM Liu Bo <obuil.liubo@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 1:36 AM Jan Kara <jack@suse.cz> wrote:
> >
> > [added some relevant lists to CC - this can safe some people debugging by
> > being able to google this discussion]
> >
> > On Wed 19-06-19 15:57:38, Liu Bo wrote:
> > > I found a weird dead loop within invalidate_inode_pages2_range, the
> > > reason being that  pagevec_lookup_entries(index=1) returns an indices
> > > array which has only one entry storing value 0, and this has led
> > > invalidate_inode_pages2_range() to a dead loop, something like,
> > >
> > > invalidate_inode_pages2_range()
> > >   -> while (pagevec_lookup_entries(index=1, indices))
> > >     ->  for (i = 0; i < pagevec_count(&pvec); i++) {
> > >       -> index = indices[0]; // index is set to 0
> > >       -> if (radix_tree_exceptional_entry(page)) {
> > >           -> if (!invalidate_exceptional_entry2()) //
> > >                   ->__dax_invalidate_mapping_entry // return 0
> > >                      -> // entry marked as PAGECACHE_TAG_DIRTY/TOWRITE
> > >                  ret = -EBUSY;
> > >           ->continue;
> > >           } // end of if (radix_tree_exceptional_entry(page))
> > >     -> index++; // index is set to 1
> > >
> > > The following debug[1] proved the above analysis,  I was wondering if
> > > this was a corner case that  pagevec_lookup_entries() allows or a
> > > known bug that has been fixed upstream?
> > >
> > > ps: the kernel in use is 4.19.30 (LTS).
> >
> > Hum, the above trace suggests you are using DAX. Are you really? Because the
> > stacktrace below shows we are working on fuse inode so that shouldn't
> > really be DAX inode...
> >
>
> So I was running tests against virtiofs[1] which adds dax support to
> fuse, with dax, fuse provides posix stuff while dax provides data
> channel.
>
> [1]: https://virtio-fs.gitlab.io/
> https://gitlab.com/virtio-fs/linux
>
> thanks,
> liubo
>
> >                                                                 Honza
> >
> > > [1]:
> > > $git diff
> > > diff --git a/mm/truncate.c b/mm/truncate.c
> > > index 71b65aab8077..82bfeeb53135 100644
> > > --- a/mm/truncate.c
> > > +++ b/mm/truncate.c
> > > @@ -692,6 +692,7 @@ int invalidate_inode_pages2_range(struct
> > > address_space *mapping,
> > >                         struct page *page = pvec.pages[i];
> > >
> > >                         /* We rely upon deletion not changing page->index */
> > > +                       WARN_ONCE(index > indices[i], "index = %d
> > > indices[%d]=%d\n", index, i, indices[i]);
> > >                         index = indices[i];
> > >                         if (index > end)
> > >                                 break;
> > >
> > > [  129.095383] ------------[ cut here ]------------
> > > [  129.096164] index = 1 indices[0]=0
> > > [  129.096786] WARNING: CPU: 0 PID: 3022 at mm/truncate.c:695
> > > invalidate_inode_pages2_range+0x471/0x500
> > > [  129.098234] Modules linked in:
> > > [  129.098717] CPU: 0 PID: 3022 Comm: doio Not tainted 4.19.30+ #4
> > > ...
> > > [  129.101288] RIP: 0010:invalidate_inode_pages2_range+0x471/0x500
> > > ...
> > > [  129.114162] Call Trace:
> > > [  129.114623]  ? __schedule+0x2ad/0x860
> > > [  129.115214]  ? prepare_to_wait_event+0x80/0x140
> > > [  129.115903]  ? finish_wait+0x3f/0x80
> > > [  129.116452]  ? request_wait_answer+0x13d/0x210
> > > [  129.117128]  ? remove_wait_queue+0x60/0x60
> > > [  129.117757]  ? make_kgid+0x13/0x20
> > > [  129.118277]  ? fuse_change_attributes_common+0x7d/0x130
> > > [  129.119057]  ? fuse_change_attributes+0x8d/0x120
> > > [  129.119754]  fuse_dentry_revalidate+0x2c5/0x300
> > > [  129.120456]  lookup_fast+0x237/0x2b0
> > > [  129.121018]  path_openat+0x15f/0x1380
> > > [  129.121614]  ? generic_update_time+0x6b/0xd0
> > > [  129.122316]  do_filp_open+0x91/0x100
> > > [  129.122876]  do_sys_open+0x126/0x210
> > > [  129.123453]  do_syscall_64+0x55/0x180
> > > [  129.124036]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  129.124820] RIP: 0033:0x7fbe0cd75e80
> > > ...
> > > [  129.134574] ---[ end trace c0fc0bbc5aebf0dc ]---
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
