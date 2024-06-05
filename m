Return-Path: <linux-fsdevel+bounces-21015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CED68FC31C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 07:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA662284525
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EF121C17E;
	Wed,  5 Jun 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCkxSv0I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A27946C;
	Wed,  5 Jun 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566603; cv=none; b=bVaz6CQtxTALQjufMDWA489WjdLhvgBSfxEq/hn5cMFEtmlLommPkMr8PsnS9tEGQgZ2CIUys4l3RUF4kA7NDRNy0JYG9kyML1QanpcjZubP4XsR1yX9G7jZ8ICafiekxiwGi77h6oVxCQ77KZ+Hu0O2iVk2DUkPAuZZ3SJtgS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566603; c=relaxed/simple;
	bh=nHmdFWQjtxBY0jisDmPVc/Bv7Dl46W7BMyEWWqcPcvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unw4LeNRDD8lbv9MZR04dT6UvPxPV5G1iP2Lam47UMpSzRae4snhw4IUYHeImQN2v4fs8C04OwIxI16omGhCOb8ptzr9GorNN9Tu2MtyGYeZAt0l6SU0kuY18PLWSN7ByAwm45iVIzszDq00OzcIIIfVlffjqs4Xv70bKkDHTYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCkxSv0I; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-795186ae3efso80435785a.1;
        Tue, 04 Jun 2024 22:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717566600; x=1718171400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr2WBNrHmUTP/4akueajoP+o69Bup6GqxHj8Jk3mdxE=;
        b=bCkxSv0IHT09ONVNYu+HYgusQ1NvG8dAiE7x6LBeplhO+O49b36g5HheivcEVTIjje
         X3C9YSAuAS4q4Z3H/fpk0VU1ZEUDtyA/DHzzVS4R5EN2LgK55jdUUMiAto9wwbgLim7q
         rqHZLsvhcr2mUpK+lSsm9hpRVbnwTu0wjSW4uLSxHxjBOcGKgfVYmfcmVpxUHfyiK6e1
         PprEmfmzb7GvdK/RRJUkutxxL6zD3KbtYnTEa+AdzSa97T8MqYG5RSvAHxoGEmxNfT8e
         5QP0LonPQsflS60EtbfYQ7YAIO8hR/nrf88bng2zzUGx4M27ISfXJ/FMxsxHFucDEd33
         /CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717566600; x=1718171400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr2WBNrHmUTP/4akueajoP+o69Bup6GqxHj8Jk3mdxE=;
        b=oFyBRVlEiatTcKtxW6cZF3bSkx5efbM0RiToKirqNb6ufYNwxatJUOtn6gPWlko9eJ
         3I9I8ZAc0w4DNF3OSmr86Ge/NaeRiVueeCFc/qyZ1bXqxfJct9x6FQjcBHygmVipkdoJ
         ShDfV/oMgXX/1F+PEM1z3m8coHQWTnMKAsFyH+j9Nb8i5z/GuGzvseZz6vWhp1jmf8Oc
         VTW4ibM3Vbbhjr5NysGMiY9KOYh9ESc0txLjiP4jjG6Ey7vrYg5AmCjhs74UpWOFEHUB
         piDzd6CyBT8kK2ggVW44voCE7/bYsoqLU1MCk4kSfQPQ/ekPCYylrR9hl/B9NfE3d3Ct
         WiRg==
X-Forwarded-Encrypted: i=1; AJvYcCWhFwmklDfAO3aTxUD210ohfcyEdrBYM/VI0LtkZU5O+TEvf4YgovQtkxy3INajj03wUp8cCzheAmFmBBl8Ct4DivOHitgwEecVGs3XFoFhL18BtUQN/ajD9pd+7dnYJOhSfd6J4bfoxm3w5A==
X-Gm-Message-State: AOJu0YzETNwS8INMwMff5NOGRdUvNKXv+SJEUy7ajSU2S3pXlYSseoiC
	P7P98fjaS6csDDYEuGgxSC3X6u5LpUy+PstNPaH9+qYAgkARBKZGx03vgQn5YbtXxn6+HiBpive
	r9yv1wULXiM8ELSNNZ8KzqToqdk8=
X-Google-Smtp-Source: AGHT+IGcQ1cPWxGbVNyd3pwcoakHuFvvgQuZ9N/5xFSdQxMvy0LV2gfCKQA3/ySDjUj4T5GP625izNpPx+rQJwWZXqY=
X-Received: by 2002:a05:620a:8d6:b0:795:219d:c68e with SMTP id
 af79cd13be357-79523d35d2dmr148351685a.14.1717566600473; Tue, 04 Jun 2024
 22:50:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67771830-977f-4fca-9d0b-0126abf120a5@fastmail.fm>
 <CAJfpeguts=V9KkBsMJN_WfdkLHPzB6RswGvumVHUMJ87zOAbDQ@mail.gmail.com>
 <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com> <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com> <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <21741978-a604-4054-8af9-793085925c82@fastmail.fm> <20240604165319.GG3413@localhost.localdomain>
 <6853a389-031b-4bd6-a300-dea878979d8c@fastmail.fm> <20240604221654.GA17503@localhost.localdomain>
In-Reply-To: <20240604221654.GA17503@localhost.localdomain>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 5 Jun 2024 08:49:48 +0300
Message-ID: <CAOQ4uxjTb=ja-fe6qqKjEo96m_AU6ikpERh1putSM9e_-6Y01g@mail.gmail.com>
Subject: Re: [HELP] FUSE writeback performance bottleneck
To: Josef Bacik <josef@toxicpanda.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lege.wang@jaguarmicro.com, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 1:17=E2=80=AFAM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Tue, Jun 04, 2024 at 11:39:17PM +0200, Bernd Schubert wrote:
> >
> >
> > On 6/4/24 18:53, Josef Bacik wrote:
> > > On Tue, Jun 04, 2024 at 04:13:25PM +0200, Bernd Schubert wrote:
> > >>
> > >>
> > >> On 6/4/24 12:02, Miklos Szeredi wrote:
> > >>> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmai=
l.fm> wrote:
> > >>>
> > >>>> Back to the background for the copy, so it copies pages to avoid
> > >>>> blocking on memory reclaim. With that allocation it in fact increa=
ses
> > >>>> memory pressure even more. Isn't the right solution to mark those =
pages
> > >>>> as not reclaimable and to avoid blocking on it? Which is what the =
tmp
> > >>>> pages do, just not in beautiful way.
> > >>>
> > >>> Copying to the tmp page is the same as marking the pages as
> > >>> non-reclaimable and non-syncable.
> > >>>
> > >>> Conceptually it would be nice to only copy when there's something
> > >>> actually waiting for writeback on the page.
> > >>>
> > >>> Note: normally the WRITE request would be copied to userspace along
> > >>> with the contents of the pages very soon after starting writeback.
> > >>> After this the contents of the page no longer matter, and we can ju=
st
> > >>> clear writeback without doing the copy.
> > >>>
> > >>> But if the request gets stuck in the input queue before being copie=
d
> > >>> to userspace, then deadlock can still happen if the server blocks o=
n
> > >>> direct reclaim and won't continue with processing the queue.   And
> > >>> sync(2) will also block in that case.>
> > >>> So we'd somehow need to handle stuck WRITE requests.   I don't see =
an
> > >>> easy way to do this "on demand", when something actually starts
> > >>> waiting on PG_writeback.  Alternatively the page copy could be done
> > >>> after a timeout, which is ugly, but much easier to implement.
> > >>
> > >> I think the timeout method would only work if we have already alloca=
ted
> > >> the pages, under memory pressure page allocation might not work well=
.
> > >> But then this still seems to be a workaround, because we don't take =
any
> > >> less memory with these copied pages.
> > >> I'm going to look into mm/ if there isn't a better solution.
> > >
> > > I've thought a bit about this, and I still don't have a good solution=
, so I'm
> > > going to throw out my random thoughts and see if it helps us get to a=
 good spot.
> > >
> > > 1. Generally we are moving away from GFP_NOFS/GFP_NOIO to instead use
> > >    memalloc_*_save/memalloc_*_restore, so instead the process is mark=
ed being in
> > >    these contexts.  We could do something similar for FUSE, tho this =
gets hairy
> > >    with things that async off request handling to other threads (whic=
h is all of
> > >    the FUSE file systems we have internally).  We'd need to have some=
 way to
> > >    apply this to an entire process group, but this could be a workabl=
e solution.
> > >
> >
> > I'm not sure how either of of both (GFP_ and memalloc_) would work for
> > userspace allocations.
> > Wouldn't we basically need to have a feature to disable memory
> > allocations for fuse userspace tasks? Hmm, maybe through mem_cgroup.
> > Although even then, the file system might depend on other kernel
> > resources (backend file system or block device or even network) that
> > might do allocations on their own without the knowledge of the fuse ser=
ver.
> >
>
> Basically that only in the case that we're handling a request from memory
> pressure we would invoke this, and then any allocation would automaticall=
y have
> gfp_nofs protection because it's flagged at the task level.
>
> Again there's a lot of problems with this, like how do we set it for the =
task,
> how does it work for threads etc.
>
> > > 2. Per-request timeouts.  This is something we're planning on tacklin=
g for other
> > >    reasons, but it could fit nicely here to say "if this fuse fs has =
a
> > >    per-request timeout, skip the copy".  That way we at least know we=
're upper
> > >    bound on how long we would be "deadlocked".  I don't love this app=
roach
> > >    because it's still a deadlock until the timeout elapsed, but it's =
an idea.
> >
> > Hmm, how do we know "this fuse fs has a per-request timeout"? I don't
> > think we could trust initialization flags set by userspace.
> >
>
> It would be controlled by the kernel.  So at init time the fuse file syst=
em says
> "my command timeout is 30 minutes."  Then the kernel enforces this by hav=
ing a
> per-request timeout, and once that 30 minutes elapses we cancel the reque=
st and
> EIO it.  User space doesn't do anything beyond telling the kernel what it=
's
> timeout is, so this would be safe.
>

Maybe that would be better to configure by mounter, similar to nfs -otimeo
and maybe consider opt-in to returning ETIMEDOUT in this case.
At least nfsd will pass that error to nfs client and nfs client will retry.

Different applications (or network protocols) handle timeouts differently,
so the timeout and error seems like a decision for the admin/mounter not
for the fuse server, although there may be a fuse fs that would want to
set the default timeout, as if to request the kernel to be its watchdog
(i.e. do not expect me to take more than 30 min to handle any request).

Thanks,
Amir.

