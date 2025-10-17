Return-Path: <linux-fsdevel+bounces-64511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC5BBEB418
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B2984E81CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 18:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B359330317;
	Fri, 17 Oct 2025 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khif+f/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A4231842
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726507; cv=none; b=dJI2xtD9NpaGUIJGLAzGUJ48d1sQuDs+Pttfjf268/U6zHy36AAAW1iDw3b8Ia/ZK4QLRJ5z/qPyMi99Zn6y1/iLE+OJkvciuDoOLeFqJJKgSlMZFmJeSHCUEm9omXCZlhG5IU3MlCYXl6I+OP4cJbKjleHkFobciq5NrUftBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726507; c=relaxed/simple;
	bh=/sTEqwywlySWgAh0PknyIaNRMYPZ9Y+xqM3mNOHDPB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8ohz+WjNQ9FBPrmKSkQ4dpUqvbIvAiIBujVLOUug/sKAR60vwyKhPifdW7VdRmOGwLEWFVY99OQqgeg8iSWS383rXUJxhT90zqGoYJa+VVbnGw43Gm+Xy/dzKm3uXqzI2QbL4UBc3cMe7ocSIAk6rbWrIekprqZtPv9ahxDQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khif+f/d; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f75b0a058so29621056d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 11:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760726505; x=1761331305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4kHklE6y4XWM6CWnSt2rWAh3h9xOUqwhtdoHEPnaUs=;
        b=khif+f/dgFOvaX56tErPXvju/Qy1XuOvexjUSyn5oVObYzTz8qEe8X4VCoeq77XGs+
         DrCQXHiu3Egpiug4QIaUpVS+2a/GocjrTqfSMLR6L0uETm1tCvubFhTTADRqnK34r8rj
         uIuzjlvkSpwxEqFbnmGXsXz0gKENEClAEa7V9kON4zhaerigky7pmBJg0BBe1TDLHT0d
         vFmQZt3BZQ4aWw396OW8k236ZT7u5O9wBTDmj/qWCRHjzUstTdE0dV3HARag4oNo672W
         Bwl+IteQwIoG7MJSaEj085D74w/uON3lz2aMMnvsEYuj/TJnjeiaiPf4SJhu+XIHKzdT
         217g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726505; x=1761331305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4kHklE6y4XWM6CWnSt2rWAh3h9xOUqwhtdoHEPnaUs=;
        b=nglVx2dZabEeeQ8/8mEkhPEcXS7KSSyF4FM4cmltQmWtUx+tVBIJ6qR+Mr4pq/4jxb
         cK/cAJHPo1wfLcRwl0Pt5r68IhmrO/Peb89fJbwCuNPvDdOpFth8oFXZby0Ap3iS8fgf
         J72fUsSIwWtqDnc+H1kQMZDXNY8Tl/fIK9rUW+vytVQJPwWop/EYzx8H9zIEpilurn2s
         sOvOO5AYi4esn4AC2ZSIugoHOG3qCOwAJqktBdB+dK3NY+KIBC79cGeHaIffpWhtLjk6
         HcMjh5jh76qG7rhEVcl7Xb+Q7cAkv3zjvnbwsMTJSXe4AVvMNTqqyuyJ6MgF+Y0hEfmv
         5vJw==
X-Forwarded-Encrypted: i=1; AJvYcCWhl0hqd0mxW9/+iBe3nJIPNNsiEuCqwvNTo4SWO5Yt7C2GoW5mM5vswXPBhb18wzYGK2Eo+QBpxkbxELch@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7eO8QTEjh1my0Jh3OB2G/3v75s+XBT919nmwzs5sQxoNzL2N
	HGnSUwjKnUBmQoET3hkqJ8RTxeqCcWXTWqt3bFZ8K34wPl560thPGWCtU1iXteqfLH26UXafpIX
	la42lnasEVj/Ba8CmRnujOqgLmW5pmmk=
X-Gm-Gg: ASbGncuVHlVrvU+OJ4q01RLqhMbiSPAMvG3Gl5SA2wD7dI2LSeohY7Wf/BQRgFLX9Lm
	aDQ+hC5AuzYkRCTFRrszFDVl561gaK6tSGE3/wY/LoRAgq2kexS5PX74UBQrMK0CHvGXngrhxc0
	0hYPU/kNu6oMEC/RpZ/NeHeLzBsUe+QNPV0X5JOW5/amF2ek77ZycoQX4Yy9JO67p4Pa2IgXZcC
	/GwlIY1YqbuJhdlbtNuHLmFqvHvV0i8beLL7zWlG7tnQj7TynU9Hc1kf2k5QNlO916pUQ/4NN4X
	VITWDID6ktEri08vn7Sy098dS38=
X-Google-Smtp-Source: AGHT+IGs60xgoG57xjbyEcEegkk01j6Og6IwcHBjm2aCxYBec3UADnNPLMAlUsFYEuf8mKiSznViTMvS9gbDBgUkr2U=
X-Received: by 2002:a05:6214:2423:b0:87c:29c4:4bec with SMTP id
 6a1803df08f44-87c29c46f93mr37988476d6.54.1760726504684; Fri, 17 Oct 2025
 11:41:44 -0700 (PDT)
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
 <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com>
In-Reply-To: <b494b498-e32d-4e2c-aba5-11dee196bd6f@linux.alibaba.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Oct 2025 11:41:33 -0700
X-Gm-Features: AS18NWDbvnD01zWG4zQjfyq9_PnkgwYxYlR7yGBqAu7FpnEgrB6ZiUMsm9KXy-o
Message-ID: <CAJnrk1Z-0YY35wR97uvTRaOuAzsq8NgUXRxa7h00OwYVpuVS8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] iomap: account for unaligned end offsets when
 truncating read range
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:03=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> On 2025/10/17 06:03, Joanne Koong wrote:
> > On Wed, Oct 15, 2025 at 6:58=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
>
> ...
>
> >>
> >>>
> >>> So I don't think this patch should have a fixes: tag for that commit.
> >>> It seems to me like no one was hitting this path before with a
> >>> non-block-aligned position and offset. Though now there will be a use
> >>> case for it, which is fuse.
> >>
> >> To make it simplified, the issue is that:
> >>    - Previously, before your fuse iomap read patchset (assuming Christ=
ian
> >>      is already applied), there was no WARNING out of there;
> >>
> >>    - A new WARNING should be considered as a kernel regression.
> >
> > No, the warning was always there. As shown in the syzbot report [1],
> > the warning that triggers is this one in iomap_iter_advance()
> >
> > int iomap_iter_advance(struct iomap_iter *iter, u64 *count)
> > {
> >          if (WARN_ON_ONCE(*count > iomap_length(iter)))
> >                  return -EIO;
> >          ...
> > }
> >
> > which was there even prior to the fuse iomap read patchset.
> >
> > Erofs could still trigger this warning even without the fuse iomap
> > read patchset changes. So I don't think this qualifies as a new
> > warning that's caused by the fuse iomap read changes.
>
> No, I'm pretty sure the current Linus upstream doesn't have this
> issue, because:
>
>   - I've checked it against v6.17 with the C repro and related
>     Kconfig (with make olddefconfig revised);
>
>   - IOMAP_INLINE is pretty common for directories and regular
>     inodes, if it has such warning syzbot should be reported
>     much earlier (d9dc477ff6a2 was commited at Feb 26, 2025;
>     and b26816b4e320 was commited at Mar 19, 2025) in the dashboard
>     (https://syzkaller.appspot.com/upstream/s/erofs) rather
>     than triggered directly by your fuse read patchset.
>
> Could you also check with v6.17 codebase?

I think we are talking about two different things. By "this issue"
what you're talking about is the syzbot read example program that
triggers the warning on erofs, but by "this issue", what I was talking
about is the iomap_iter_advance() warning being triggerable
generically without the fuse read patchset, not just by erofs.

If we're talking about the syzbot erofs warning being triggered, then
this patch is irrelevant to be talking about, because it is this other
patch [1] that fixes that issue. That patch got merged in before any
of the fuse iomap read changes. There is no regression to erofs.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250922180042.1775241-1-joannelk=
oong@gmail.com/

>
> Thanks,
> Gao Xiang
>

