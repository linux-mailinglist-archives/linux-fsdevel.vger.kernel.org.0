Return-Path: <linux-fsdevel+bounces-21815-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC61290ACDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 13:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1C01C20C36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA972194AEA;
	Mon, 17 Jun 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2rIhrfb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF5194ADE;
	Mon, 17 Jun 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623484; cv=none; b=sm1gw2oXqIBUbWdpKzpt0rr6EsdkpuBrsrQU5Gz6cfN7pZnOg6R+JfxiqbFCxfCZ/jHxXdqgyTjq1/egIVjfARu6X26hn9xoi+mBvCcTea2HXKZIwCCE0/SJBN1NWO9xN11DTPaRCeW2KEjJ5Y7YeCN1OZAbMMUX424/RiOxR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623484; c=relaxed/simple;
	bh=eSVJenYg+Ov0lTGtltByPlRtrbUcU4mRc+K3naSiZCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULOLsIYW8zroURDGpkfHp+f33vsDUpovL0JBjmSFJYRNU81xJG4uYFZtQ1Rzkxn7Bx/39cbtyDE9IPImODyQeMNUr7lnJ6m6Jf9XHXq61uGPm5yK6JrMW68hzcVEpaoVLakBHza78NEVIXo4FHxfUiQ2zQtEUgzvdMOvGviC9NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2rIhrfb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so41693441fa.2;
        Mon, 17 Jun 2024 04:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718623481; x=1719228281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u+S5covs6tqmYHGnRdoyC4fZEq6n6k72rCqTj5o6f8=;
        b=C2rIhrfbaA/OUYnIXpeHcRCL+L+e3NxNKry0hLfeULmOOePwxUXHk0HdELGrtneXUq
         igr+/6VUKLVQb62iiRZOCMCXvErkkF15wlruVeygWfebMwUi3h6JJMpJEyr0Qbml/njI
         gviEDbvqWVQkflow+IreIuzFAyw/fzYplQ79HYIN96TT9cu8G0NDQI2pk3zi9wT0HYrr
         nTuByMD8FNmFJhvjnYxQKlj4Fsg56b+ZlT1x/2ZDFw/7vpvqtwr/o3u5IfZAIpablWxm
         h5U16ystikB9GfLE0tTd9KL0DQUqvxGxQmLiL/jPZmhtU//SbhPFIQq4HwGTWmskE+9j
         wr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718623481; x=1719228281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u+S5covs6tqmYHGnRdoyC4fZEq6n6k72rCqTj5o6f8=;
        b=DRW4r919NUlIZdWCOwAkkujqWldeMbWsMPmynKC10rUXUlZxYkt1JaDvQ3W4QxHDV5
         vpeCtS/bmW51EwCBVcWM6O5O/eS8zLybOVmbrYHijDf5qYoJxd/j9dUUfY+/rye+GmDO
         xh0gZmiqzliAqKthgVO4L/p3+6VdKG6aWzf+rx4c9r01KzGz4cRW7Q0Rr6GNXNT5goC4
         Bm8doAnoiOTDg0ZtTKRe+wYq0Jdakbow7aOK35LigFs6tQ///cir4FTmwSKx7wV32PmA
         II343rvzriG6tB0wBnbQqZPcMOjJ+d7+6s+Wy221vbRTphZSUeM+I1KrnTiS9hTFzKqp
         YeXg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5VZXB3s278Top4xM0Vm+8zfJtgt5xSLlHcnCVsehfrrDlAcBXKGyta8H42+UXVXGZRCBLlyBIE5FIhDF9Y1I2N6CEMgqeZ46YcthKO3M9a4hj+nIEx4r10TgOxAKVwx90ERSE5noBRziEgaDncwjwvMuEk/9HthlbHJ6Rs2f1hJrHJg6K9Bm
X-Gm-Message-State: AOJu0YzNUPzuwl5eDRBwOsTQV4GgXrfM6apvFtoFGH7bMwDSrtNw6apy
	i8Uy2wL3kUHAJN4VoWOvyBSa2BPB3vl9YoJN1TwF4F5x5jjrlPPjuv8dynvH6moX6KduEPXPTBS
	AbHzRqbKOGAxK1XhEKITWZ1/JNX8=
X-Google-Smtp-Source: AGHT+IGz6l+l2whi4KHsvt7QZn5lx+DKSwikD+nALNnvZcUbYjy+X2GiVSQjXpnGcwoJjxYhQDFCdsoQdYC2+brDzHc=
X-Received: by 2002:a2e:7311:0:b0:2eb:f2cf:1e49 with SMTP id
 38308e7fff4ca-2ec0e5b5228mr58253731fa.2.1718623480308; Mon, 17 Jun 2024
 04:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zm39RkZMjHdui8nh@casper.infradead.org> <20240616023951.1250-1-hdanton@sina.com>
 <20240617075758.wewhukbrjod5fp5o@quack3>
In-Reply-To: <20240617075758.wewhukbrjod5fp5o@quack3>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 17 Jun 2024 20:24:23 +0900
Message-ID: <CAKFNMo=rL0tv1eUqHJ-KZXwZRuaJ3yWfWU8jzZaAgR3FU1DO7w@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: truncate: flush lru cache for evicted inode
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+d79afb004be235636ee8@syzkaller.appspotmail.com, 
	linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 4:57=E2=80=AFPM Jan Kara wrote:
>
> On Sun 16-06-24 10:39:51, Hillf Danton wrote:
> > On Sat, 15 Jun 2024 21:44:54 +0100 Matthew Wilcox wrote:
> > >
> > > I suspect this would trigger:
> > >
> > > +++ b/fs/inode.c
> > > @@ -282,6 +282,7 @@ static struct inode *alloc_inode(struct super_blo=
ck *sb)
> > >  void __destroy_inode(struct inode *inode)
> > >  {
> > >         BUG_ON(inode_has_buffers(inode));
> > > +       BUG_ON(inode->i_data.nrpages);
> > >         inode_detach_wb(inode);
> > >         security_inode_free(inode);
> > >         fsnotify_inode_delete(inode);
> > >
> > Yes, it was triggered [1]
> >
> > [1] https://lore.kernel.org/lkml/00000000000084b401061af6ab80@google.co=
m/
> >
> > and given trigger after nrpages is checked in clear_inode(),
> >
> >       iput(inode)
> >       evict(inode)
> >       truncate_inode_pages_final(&inode->i_data);
> >       clear_inode(inode);
> >       destroy_inode(inode);
> >
> > why is folio added to exiting mapping?
> >
> > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git  83a7eefedc9b
>
> OK, so based on syzbot results this seems to be a bug in
> nilfs_evict_inode() (likely caused by corrupted filesystem so that root
> inode's link count was 0 and hence was getting deleted on iput()). I gues=
s
> nilfs maintainers need to address these with more consistency checks of
> metadata when loading them...
>
>                                                                         H=
onza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Sorry for my late response.

Also, thank you for pointing out that the problem seems to be caused
via nilfs_evict_inode() by a missing consistency check of the link
count.

I'll check it out and think about how to deal with it.

Thanks,
Ryusuke Konishi

