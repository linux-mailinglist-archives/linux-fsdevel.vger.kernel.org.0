Return-Path: <linux-fsdevel+bounces-64556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA6BEBFD0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEB6A4E2E3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 23:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9527510E;
	Fri, 17 Oct 2025 23:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgsJNx1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC487354AE7
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743369; cv=none; b=eKmvv9w5uPK37jIASIAZO8mg3UQydqENkwuD+KPLBQjJNZjaaA2A/imCGQae61to4mnD7VTHIqrC3dFT4y8/kq+cJF1EBBCV9MXZ/wOuuwwwT2MyLYvRsYJ3mQXuUKeIGhgXy0p8oF1L69A+VLia+M3GID6smui2NlzKRIJZrc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743369; c=relaxed/simple;
	bh=/WttdGqGY9V3g6a3ii7tz8fiJAARn0a6JLZBKnKYPAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOfj1oyUVl6W9zMK2BJNFMrr1OWkXd8+jG5J9uOB1sbmU9EGgoX3t3B/z1Yf3NVBA65tUusWoSQpSm/mumiTpDek8zyLdOkkITBJj+UvRkN2pHCsiqBXbQkfBRWibBfFHqJdy3jdjJaHcAwkm6htaVK7vYIcujCO8xXq19LVARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgsJNx1l; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-890521c116fso249614885a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760743366; x=1761348166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJ/9HZs6oaKBLQmId3tESw8p2ayjQ4JxW24JVkgMNoA=;
        b=LgsJNx1l1z28gKHkQqk7KvYw0BBoyaiLTjMx7s2SHzvv7AepLmViD4PDSwvEI+ODcZ
         vC9H3aBvA7TUuuX5gL4W5xYsJs77z/mQ7r9HdaqJifh//BQZvpSk203xVFFpOoC8wGgT
         HroHTXk/F0PPnMiEPMbG3b4yIuh955taOndAeGx/lRu757LnTxPp/6MTVmZrpRSLi3jk
         BH1arFcwtF+RHvH8nOcGXWckIv43gDvpgDvz9EY3MSHS6uINxcEQN+rzSxLlC9uVVdi4
         wF/AwC3HRQd38qozhK7hp0Q2oIJQGgChJ1XA8kuyVMzy1HP0/8OMXfDA43wwvaTw/ubw
         MePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760743366; x=1761348166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ/9HZs6oaKBLQmId3tESw8p2ayjQ4JxW24JVkgMNoA=;
        b=Z3HyBRIzBuqeHSOpcnozlfE8zqsvqjZ+u8gzib9nYfG+Kbbbn156HPSQTRzohTgh0E
         +QrO3QuI+0SmODdTJ9KFEFjcl+2ZgAs6DHAFZOhqtsmXLrjd1jVY5J2M/IYfXanMAiz/
         ePTW7jTAzq8rCYPyxEjiV9vlJZyd5FjSsAaYJakbTjElIHLs6JH4hYszvGjX/eu4/ect
         W6i13YxiuovC7fNDTmE1ISdb0hD9yy+lhEzrYA8IvEgd7SGUy8cCN81UNAJB/hn+HitF
         zLRX13xkkdU7txfYcn2RTWyQqKaZJGXntvP3cCEdDqUsfdOyBezTcujXUCWGO0uPbkFU
         CsAg==
X-Forwarded-Encrypted: i=1; AJvYcCWMd6QKa+uJdCNzZ2rceKpKRlZyiT0F/0qaexXA/Xnxm3NKFL9ukXL6oL1z/L1CNY5oEGrmZgA8Yx1FAXqj@vger.kernel.org
X-Gm-Message-State: AOJu0YzAmmuPOV/q7OTWnWvPghJ2knanyzl5iroXcgyL44o5hKIO7JMg
	tMLY6rWeLXlFrizigVGazd3f5T2GG5XtXcr2+Tcw6tglDDhd565eQEI2HcFf2wjBmDbPtjSp0r0
	Y8RcONrf1K6g6SDXyKQsmL1aaUft0LZk/LvtMqS8=
X-Gm-Gg: ASbGncv9DK1fCuTnFPZ4O0uy2oX/QWyFV0o5VqeaJ1YnKT+VtzFRZ/fCoT6to9t+E8P
	+f6EKLpxjN1iOtkhnvl0rvi6HFpQmNH0NFjzI2qREdSnUGvLPoUitI5tALrTyAsegwZsi3+zjTd
	mGZ2khEIHIIigdu6FTFgDyPcnDoP3lGc8o3p3bPSnKyvTSA39loFJ8ZuymY6uYJLRMl8FzuGP/n
	Y+GCy3w9mtPj8FFXyc3vXXRUKOMJG9eLc394crR7x9bHx2cKLKspNVsd8cRYXbhwE0JU/IOk6Pk
	it2J2xXG5wXgwEy4+3J5oVojgyM=
X-Google-Smtp-Source: AGHT+IEy8HFbpOV7/zZrIxjeFEcacIir5ZuefrXAbRMLdfe3pgXMqpqFmHrPVX8CfbmWaX9yyah3z7SXZFextnQgCuo=
X-Received: by 2002:a05:620a:4694:b0:891:ef6d:5231 with SMTP id
 af79cd13be357-891ef6d5476mr108791185a.49.1760743366459; Fri, 17 Oct 2025
 16:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009225611.3744728-1-joannelkoong@gmail.com>
 <20251009225611.3744728-2-joannelkoong@gmail.com> <aOxrXWkq8iwU5ns_@infradead.org>
 <CAJnrk1YpsBjfkY0_Y+roc3LzPJw1mZKyH-=N6LO9T8qismVPyQ@mail.gmail.com>
 <a8c02942-69ca-45b1-ad51-ed3038f5d729@linux.alibaba.com> <CAJnrk1aEy-HUJiDVC4juacBAhtL3RxriL2KFE+q=JirOyiDgRw@mail.gmail.com>
 <c3fe48f4-9b2e-4e57-aed5-0ca2adc8572a@linux.alibaba.com> <CAJnrk1b82bJjzD1-eysaCY_rM0DBnMorYfiOaV2gFtD=d+L8zw@mail.gmail.com>
 <49a63e47-450e-4cda-b372-751946d743b8@linux.alibaba.com> <CAJnrk1bnJm9hCMFksn3xyEaekbxzxSfFXp3hiQxxBRWN5GQKUg@mail.gmail.com>
 <CAJnrk1b+nBmHc14-fx__NgaJzMLX7C2xm0m+hcgW_h9jbSjhFQ@mail.gmail.com>
 <01f687f6-9e6d-4fb0-9245-577a842b8290@linux.alibaba.com> <CAJnrk1aB4BwDNwex1NimiQ_9duUQ93HMp+ATsqo4QcGStMbzWQ@mail.gmail.com>
 <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com> <CAJnrk1Z-0YY35wR97uvTRaOuAzsq8NgUXRxa7h00OwYVpuVS8w@mail.gmail.com>
 <9f800c6d-1dc5-42eb-9764-ea7b6830f701@linux.alibaba.com>
In-Reply-To: <9f800c6d-1dc5-42eb-9764-ea7b6830f701@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Oct 2025 16:22:35 -0700
X-Gm-Features: AS18NWACoHaRqquRXFV_FEgakZEbV73zf-QCjso-cLVhOet-xWIumSZZ0c59Xy0
Message-ID: <CAJnrk1Ydr2uHvjLy6dMGwZj40vYet6h+f=d0WAotoj9ZMSMB=A@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 3:07=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
> On 2025/10/18 02:41, Joanne Koong wrote:
> > On Thu, Oct 16, 2025 at 5:03=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> >>
> >> On 2025/10/17 06:03, Joanne Koong wrote:
> >>> On Wed, Oct 15, 2025 at 6:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.al=
ibaba.com> wrote:
> >>
> >> ...
> >>
> >>>>
> >>>>>
> >>>>> So I don't think this patch should have a fixes: tag for that commi=
t.
> >>>>> It seems to me like no one was hitting this path before with a
> >>>>> non-block-aligned position and offset. Though now there will be a u=
se
> >>>>> case for it, which is fuse.
> >>>>
> >>>> To make it simplified, the issue is that:
> >>>>     - Previously, before your fuse iomap read patchset (assuming Chr=
istian
> >>>>       is already applied), there was no WARNING out of there;
> >>>>
> >>>>     - A new WARNING should be considered as a kernel regression.
> >>>
> >>> No, the warning was always there. As shown in the syzbot report [1],
> >>> the warning that triggers is this one in iomap_iter_advance()
> >>>
> >>> int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> >>> {
> >>>           if (WARN_ON_ONCE(*count > iomap_length(iter)))
> >>>                   return -EIO;
> >>>           ...
> >>> }
> >>>
> >>> which was there even prior to the fuse iomap read patchset.
> >>>
> >>> Erofs could still trigger this warning even without the fuse iomap
> >>> read patchset changes. So I don't think this qualifies as a new
> >>> warning that's caused by the fuse iomap read changes.
> >>
> >> No, I'm pretty sure the current Linus upstream doesn't have this
> >> issue, because:
> >>
> >>    - I've checked it against v6.17 with the C repro and related
> >>      Kconfig (with make olddefconfig revised);
> >>
> >>    - IOMAP_INLINE is pretty common for directories and regular
> >>      inodes, if it has such warning syzbot should be reported
> >>      much earlier (d9dc477ff6a2 was commited at Feb 26, 2025;
> >>      and b26816b4e320 was commited at Mar 19, 2025) in the dashboard
> >>      (https://syzkaller.appspot.com/upstream/s/erofs) rather
> >>      than triggered directly by your fuse read patchset.
> >>
> >> Could you also check with v6.17 codebase?
> >
> > I think we are talking about two different things. By "this issue"
> > what you're talking about is the syzbot read example program that
> > triggers the warning on erofs, but by "this issue", what I was talking
> > about is the iomap_iter_advance() warning being triggerable
> > generically without the fuse read patchset, not just by erofs.
>
> Ah, yes.  Sorry the subjects of those two patches are similar,
> I got them mixed up.  I thought you resent the previous patch
> in this patchset.
>
> >
> > If we're talking about the syzbot erofs warning being triggered, then
> > this patch is irrelevant to be talking about, because it is this other
> > patch [1] that fixes that issue. That patch got merged in before any
> > of the fuse iomap read changes. There is no regression to erofs.
>
> Can you confirm this since I can't open the link below:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.19.iomap
>
> [1/1] iomap: adjust read range correctly for non-block-aligned positions
>        https://git.kernel.org/vfs/vfs/c/94b11133d6f6
>

I don't think the vfs-6.19.iomap branch is publicly available yet,
which is why the link doesn't work.

From the merge timestamps in [1] and [2], the fix was applied to the
branch 3 minutes before the fuse iomap changes were applied.
Additionally, in the cover letter of the fuse iomap read patchset [3],
it calls out that the patchset is rebased on top of that fix.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250929-gefochten-bergwacht-b43b=
132a78d9@brauner/
[2] https://lore.kernel.org/linux-fsdevel/20250929-salzbergwerk-ungnade-8a1=
6d724415e@brauner/
[3] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joannelk=
oong@gmail.com/

> As you said, if this commit is prior to the iomap read patchset, that
> would be fine.  Otherwise it would be better to add a fixes tag to
> that commit to point out this patch should be ported together to avoid
> the new warning.
>
> Thanks,
> Gao Xiang
>
>
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joan=
nelkoong@gmail.com/
> >
> >>
> >> Thanks,
> >> Gao Xiang
> >>
>

