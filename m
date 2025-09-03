Return-Path: <linux-fsdevel+bounces-60163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C19BB424FA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B51188682B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8D22D795;
	Wed,  3 Sep 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYTYrpgs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2555622D4F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912762; cv=none; b=gR+UlFlTTk1MpnOoSAocsW/hNJhaWZmMZKUVLwuhLNWKquKxXzSCDgGGjOo49YZWvoThGKUE1wcShgJTYeEW5q67iCwYomyiccvLgU7FfPbsKCPpimVBC0UkVL5cn59999EAiWuyZRpY12E0NXQhM4Ptb8Owf57YZt1zHtXGzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912762; c=relaxed/simple;
	bh=S58EWpzS+6u8s5RJ4gmjAsV4nN25GmiHzuNrgIa3T68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV3NYoeYjJ6F//53gEMhjlDRaktr70J6Ndshn4pcURzhUIJKwzY8gI7+gbWQPfAVK8ZHPuGunW8Qdqogv6Dej/zDBzTt8FboExJ5wCsx0x8aFsqhRssCvMhv/R1JyeKlIGpD5QvuK/LhjF8BbzIR78ZKC2uXdPi6xcP4g4DuyxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYTYrpgs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so11018148a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756912758; x=1757517558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S58EWpzS+6u8s5RJ4gmjAsV4nN25GmiHzuNrgIa3T68=;
        b=cYTYrpgsR9xG+s+EZteJ/MncS4F6oB+SaH5fk4TJq77/0yUoWf97iC+3OIg5fdBCyA
         JaIhOuehTbdjfeZwx93fLoq5MY4z13Okuk8pk3wGBN6WEsct2qD88yztIMj0HXoto5Hy
         odtUCPNOXj1oE8WbHXiakbpngYXRt/ipkTMzDZSN/5vzbr0E5FVFjdgw6YP6DGqYjxI6
         RxBgPY1/BhKORbgvlQyKXCGBKGLb/l2wjLRXMmMNiWab4wHe10h1I6RnVv2+Y3x6Ad4G
         kmRp0SBkG9Us63UYwokFI+dVz/GguFOqDKAzzLZNSHG6fnPWVxf9zbHwlYu8AFppXBwv
         8A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912758; x=1757517558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S58EWpzS+6u8s5RJ4gmjAsV4nN25GmiHzuNrgIa3T68=;
        b=inQ/pB9YOzvXgElJERHSUZHs52m/yNOQsIS54z+9clRoyd93W97LhxK+vLGKCziLwX
         lxWQhRoPZh4nXBu7iIpesng6DdA2vMzGnfLIEv0TLhW90ajXGWYcVLrZAgJB02QwtjQ8
         IjnHJMztGL2o3OSv6JJXWG8bhTCBPUHGunyQlw/zzsUaUy3cJDq3HzcDRwGsic8LZLwi
         AYFCDaoaxAMqj5aKDpWL5qmYJ1va1khmw2XwF83WYFtf1whj+8bEmXfMEruFRlSHA9CE
         SyqudawRSbJbILm+07+KJiGYZxzVZmnMHJYXOhoM73WJ6rGod1E7L+B5dCTtCKUG+Pra
         D8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlOiBu8eO53g1CaccbQCmRbYqIukYiz7PtH/Ct1QSTZCQ0bBb6T5UKTCCJR9zmMUBx+R50AiHh+yHLp5qC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8CfJEVIwen/hSDMzF/53C/Beb9ItDx/NS7CoXAg7p+n5nb4Sn
	klwxK8u6hmsI0KqtsHnA4Ws8/XaJyp2kdTk9lnIYMg3QbRbba6Wbcv5Ey/87R9u6o7Bke9+jIbH
	9Fr6ky9SLxzGTosy+cJ6RLvspCbXw/gq/gQQK
X-Gm-Gg: ASbGnctJYbZI3vjRFWX5ydhBHF0JR4kL2GHgndUDakycMfXGmVFZWW//pVDVu52mFoE
	IvsFycdnSK7q2o/klGXLRhpKhnb0LAKnNMMxUKSSELbRGV2/Hw5TZAM1fuNDakRQtKngv+elwBB
	w3AR1EQl4Efe1rS2AM2erpqT7kEysX9GziOb5aTChVhY9zGbs0psqAkaIOseuoHtTF7Mo2INwkv
	4veWOMqRfppvEmWEQ==
X-Google-Smtp-Source: AGHT+IFuctW9BP/uDSAJiqvSGSIsgxexFixfjemcmIpgKvR7o0tUjM8qK2Rj3xAcon+GVuvvjWZFIa6af4NLgSa2XSY=
X-Received: by 2002:a05:6402:1941:b0:61c:4c77:cb8 with SMTP id
 4fb4d7f45d1cf-61d2698786emr13654778a12.15.1756912758212; Wed, 03 Sep 2025
 08:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902145428.456510-1-mjguzik@gmail.com> <aLe5tIMaTOPEUaWe@casper.infradead.org>
 <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com> <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
In-Reply-To: <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 3 Sep 2025 17:19:04 +0200
X-Gm-Features: Ac12FXwvyfe20gyT4wZSs_XlAryf5deG2Ca_IKdYDIFbG-8FYCg8sV_xSwDcDoI
Message-ID: <CAGudoHFKmXJGRPedZ9Fq6jnfbiHzSwezd3Lr0uCbP7izs4dhGw@mail.gmail.com>
Subject: Re: [External] : Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, ocfs2-devel@lists.linux.dev, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 5:16=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Wed, Sep 3, 2025 at 4:03=E2=80=AFPM Mark Tinguely <mark.tinguely@oracl=
e.com> wrote:
> >
> > On 9/2/25 10:44 PM, Matthew Wilcox wrote:
> > > On Tue, Sep 02, 2025 at 04:54:28PM +0200, Mateusz Guzik wrote:
> > >> Following up on my response to the refcount patchset, here is a chur=
n
> > >> patch to retire I_WILL_FREE.
> > >>
> > >> The only consumer is the drop inode routine in ocfs2.
> > >
> > > If the only consumer is ocfs2 ... then you should cc the ocfs2 people=
,
> > > right?
> > >
>
> Fair point, I just copy pasted the list from the patchset, too sloppy.
>
> > >> For the life of me I could not figure out if write_inode_now() is le=
gal
> > >> to call in ->evict_inode later and have no means to test, so I devis=
ed a
> > >> hack: let the fs set I_FREEING ahead of time. Also note iput_final()
> > >> issues write_inode_now() anyway but only for the !drop case, which i=
s the
> > >> opposite of what is being returned.
> > >>
> > >> One could further hack around it by having ocfs2 return *DON'T* drop=
 but
> > >> also set I_DONTCACHE, which would result in both issuing the write i=
n
> > >> iput_final() and dropping. I think the hack I did implement is clean=
er.
> > >> Preferred option is ->evict_inode from ocfs handling the i/o, but pe=
r
> > >> the above I don't know how to do it.
> >
> > I am a lurker in this series and ocfs2. My history has been mostly in
> > XFS/CXFS/DMAPI. I removed the other CC entries because I did not want
> > to blast my opinion unnecessaially.
> >
>
> Hello Mark,
>
> This needs the opinion of the vfs folk though, so I'm adding some of
> the cc list back. ;)
>
> > The flushing in ocfs2_drop_inode() predates the I_DONTCACHE addition.
> > IMO, it would be safest and best to maintain to let ocfs2_drop_inode()
> > return 0 and set I_DONTCACHE and let iput_final() do the correct thing.
> >
>

wow, I'm sorry for really bad case of engrish in the mail. some of it
gets slightly corrected below.

> For now that would indeed work in the sense of providing the expected
> behavior, but there is the obvious mismatch of the filesystem claiming
> the inode should not be dropped (by returning 0) and but using a side
> indicator to drop it anyway. This looks like a split-brain scenario
> and sooner or later someone is going to complain about it when they do
> other work in iput_final(). If I was maintaining the layer I would
> reject the idea, but if the actual gatekeepers are fine with it...
>
> The absolute best thing to do long run is to move the i/o in
> ->evict_inode, but someone familiar with the APIs here would do the
> needful(tm) and that's not me.

I mean the best thing to do in the long run is to move the the write
to ->evict_inode, but I don't know how to do it and don't have any
means to test ocfs2 anyway. Hopefully the ocfs2 folk will be willing
to sort this out?

--=20
Mateusz Guzik <mjguzik gmail.com>

