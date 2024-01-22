Return-Path: <linux-fsdevel+bounces-8457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AED3836D65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D865728C361
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC271EEFB;
	Mon, 22 Jan 2024 16:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kG4h/RxI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BE1E481
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 16:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941035; cv=none; b=HutmfMCcgZxEewFOGg7ZiOxYzw3vFDn4qgGaBmmrJOPTdh7YzGF9DP2lCnxpeifGoDFR0Or0Rd+S/GiP2vhXlz6E+g8g7FMCjrnIOquvBClgjCIFPZjVxozlXtzEBJxFisNnAepOGZ1kURYJyMnumtQqDalh1vJsANDpLrSX4GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941035; c=relaxed/simple;
	bh=JVTLCUPB7iXC4eIrNg2d8NLxpE109zbJQBMJLtpUjg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHzvyQWi9ICdRJ+Tn1LxVN4cr8lxVbuLpbb8xfnWLfXT93wQrBVILV5JZp5EI845IOwyNQWT3TDoJG8eVA48Gbd+jdiFeFgBDcqAnqfBuimQIFx+1u8OuMyaNW2otBK2EW20uJ6DeR31enae66yICopRgyIDXfxP+wfV6FCBqgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kG4h/RxI; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-361b24d1a9eso334685ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jan 2024 08:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705941033; x=1706545833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjELHtowAv3ak1AQZT7BU/ZqYcvabtPwYrfG/ySOdno=;
        b=kG4h/RxIVSe/4lT08ILuhReiNqWS/9H4Q4YeuobortaYHj76Y69ShIbCPhUgg6A2U9
         kFOAsFBZ9ZCkOQPrGclTBFbaiZ+wcS3xIsj2l5vJW1+fiQyUGVR4BLyXgFb1uFqXUNrp
         +MremtFoPnPi8g0ngiBo7b9Xijugs5d9RNujzEWh+ULvYS9m/moYHZ8ZLKpBawjtZ1po
         iugryW2I5aZPO8y0aPaiJ0GwRvl/4uZ3JnHucnFH64rZPAAk6wbAEh3Hzd07DVn9jvpe
         233fU6+m7GweDBve6LcrRzeGMLvA6QazORYWL5zd1nCUQPlu7KtVkosIOIoUeKsqKZ27
         wnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705941033; x=1706545833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjELHtowAv3ak1AQZT7BU/ZqYcvabtPwYrfG/ySOdno=;
        b=VRnkOd7d3f91qeWsXPX/sjWRS1gaRMrOSw+ZDMzRHfLWTDsjKSigJeJy0ZNjsB6Yai
         DlaMLawPHST88rvrjxslOCr8rYV5RKlu/YXF27wZ9vp3pELEiycyFrEQQed8zj+K7BZi
         9e5a6pClLhGG7kWDruVuafyQdOePTKuylb7YY8EQJSZZoSceyLprrYM3kvFxloVDd6ZG
         0Q3r+UypNBam9pRA7K8YaHXI4yNEyGxKxYJFwsAlBTo7pQ/xlu23YfW81JOzKkLhmqTC
         yZEH4uXPMQ+sAcxCLgrzH+AkJj22RDX8XjDyolrNxYJN8uhbe9po7YYuKDLLWSUHauFK
         Aorg==
X-Gm-Message-State: AOJu0YxlzlvbCkHj6iNu8QAUjd4BA+e24oiNMyfmVgwiDr0T0p1vusUB
	khG5r2yrGf/5fZuR+AiVkh0jpXw+SsLWP4z7byHThqiSeTaD
X-Google-Smtp-Source: AGHT+IGC97gkTGATtf9M7kYTIQ90XsuuFjUZxJn7oFDh0SQFpWxPVfSenQKRQC4QLPOYii7BLctCq604l2+O3t2XXSA=
X-Received: by 2002:a05:6e02:1c2c:b0:361:8079:2843 with SMTP id
 m12-20020a056e021c2c00b0036180792843mr454962ilh.18.1705941033411; Mon, 22 Jan
 2024 08:30:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119092024.193066-1-zhangpeng362@huawei.com>
 <Zap7t9GOLTM1yqjT@casper.infradead.org> <5106a58e-04da-372a-b836-9d3d0bd2507b@huawei.com>
 <Za6SD48Zf0CXriLm@casper.infradead.org>
In-Reply-To: <Za6SD48Zf0CXriLm@casper.infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 17:30:18 +0100
Message-ID: <CANn89iL4qUXsVDRNGgBOweZbJ6ErWMsH+EpOj-55Lky8JEEhqQ@mail.gmail.com>
Subject: Re: SECURITY PROBLEM: Any user can crash the kernel with TCP ZEROCOPY
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhangpeng (AS)" <zhangpeng362@huawei.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, arjunroy@google.com, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:04=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> I'm disappointed to have no reaction from netdev so far.  Let's see if a
> more exciting subject line evinces some interest.

Hmm, perhaps some of us were enjoying their weekend ?

I also see '[RFC PATCH] filemap: add mapping_mapped check in
filemap_unaccount_folio()',
and during the merge window, network maintainers tend to prioritize
their work based on tags.

If a stack trace was added, perhaps our attention would have been caught.

I don't really know what changed recently, all I know is that TCP zero
copy is for real network traffic.

Real trafic uses order-0 pages, 4K at a time.

If can_map_frag() needs to add another safety check, let's add it.

syzbot is usually quite good at bisections, was a bug origin found ?


>
> On Sat, Jan 20, 2024 at 02:46:49PM +0800, zhangpeng (AS) wrote:
> > On 2024/1/19 21:40, Matthew Wilcox wrote:
> >
> > > On Fri, Jan 19, 2024 at 05:20:24PM +0800, Peng Zhang wrote:
> > > > Recently, we discovered a syzkaller issue that triggers
> > > > VM_BUG_ON_FOLIO in filemap_unaccount_folio() with CONFIG_DEBUG_VM
> > > > enabled, or bad page without CONFIG_DEBUG_VM.
> > > >
> > > > The specific scenarios are as follows:
> > > > (1) mmap: Use socket fd to create a TCP VMA.
> > > > (2) open(O_CREAT) + fallocate + sendfile: Read the ext4 file and cr=
eate
> > > > the page cache. The mapping of the page cache is ext4 inode->i_mapp=
ing.
> > > > Send the ext4 page cache to the socket fd through sendfile.
> > > > (3) getsockopt TCP_ZEROCOPY_RECEIVE: Receive the ext4 page cache an=
d use
> > > > vm_insert_pages() to insert the ext4 page cache to the TCP VMA. In =
this
> > > > case, mapcount changes from - 1 to 0. The page cache mapping is ext=
4
> > > > inode->i_mapping, but the VMA of the page cache is the TCP VMA and
> > > > folio->mapping->i_mmap is empty.
> > > I think this is the bug.  We shouldn't be incrementing the mapcount
> > > in this scenario.  Assuming we want to support doing this at all and
> > > we don't want to include something like ...
> > >
> > >     if (folio->mapping) {
> > >             if (folio->mapping !=3D vma->vm_file->f_mapping)
> > >                     return -EINVAL;
> > >             if (page_to_pgoff(page) !=3D linear_page_index(vma, addre=
ss))
> > >                     return -EINVAL;
> > >     }
> > >
> > > But maybe there's a reason for networking needing to map pages in thi=
s
> > > scenario?
> >
> > Agreed, and I'm also curious why.
> >
> > > > (4) open(O_TRUNC): Deletes the ext4 page cache. In this case, the p=
age
> > > > cache is still in the xarray tree of mapping->i_pages and these pag=
e
> > > > cache should also be deleted. However, folio->mapping->i_mmap is em=
pty.
> > > > Therefore, truncate_cleanup_folio()->unmap_mapping_folio() can't un=
map
> > > > i_mmap tree. In filemap_unaccount_folio(), the mapcount of the foli=
o is
> > > > 0, causing BUG ON.
> > > >
> > > > Syz log that can be used to reproduce the issue:
> > > > r3 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> > > > mmap(&(0x7f0000ff9000/0x4000)=3Dnil, 0x4000, 0x0, 0x12, r3, 0x0)
> > > > r4 =3D socket$inet_tcp(0x2, 0x1, 0x0)
> > > > bind$inet(r4, &(0x7f0000000000)=3D{0x2, 0x4e24, @multicast1}, 0x10)
> > > > connect$inet(r4, &(0x7f00000006c0)=3D{0x2, 0x4e24, @empty}, 0x10)
> > > > r5 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\=
x00',
> > > > 0x181e42, 0x0)
> > > > fallocate(r5, 0x0, 0x0, 0x85b8)
> > > > sendfile(r4, r5, 0x0, 0x8ba0)
> > > > getsockopt$inet_tcp_TCP_ZEROCOPY_RECEIVE(r4, 0x6, 0x23,
> > > > &(0x7f00000001c0)=3D{&(0x7f0000ffb000/0x3000)=3Dnil, 0x3000, 0x0, 0=
x0, 0x0,
> > > > 0x0, 0x0, 0x0, 0x0}, &(0x7f0000000440)=3D0x40)
> > > > r6 =3D openat$dir(0xffffffffffffff9c, &(0x7f00000000c0)=3D'./file0\=
x00',
> > > > 0x181e42, 0x0)
> > > >
> > > > In the current TCP zerocopy scenario, folio will be released normal=
ly .
> > > > When the process exits, if the page cache is truncated before the
> > > > process exits, BUG ON or Bad page occurs, which does not meet the
> > > > expectation.
> > > > To fix this issue, the mapping_mapped() check is added to
> > > > filemap_unaccount_folio(). In addition, to reduce the impact on
> > > > performance, no lock is added when mapping_mapped() is checked.
> > > NAK this patch, you're just preventing the assertion from firing.
> > > I think there's a deeper problem here.
> >
> > --
> > Best Regards,
> > Peng
> >
> >

