Return-Path: <linux-fsdevel+bounces-21380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531E2903160
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C2328A50E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 05:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B7217278D;
	Tue, 11 Jun 2024 05:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EexhBW7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E0170857;
	Tue, 11 Jun 2024 05:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718084222; cv=none; b=AHwqNoniZgZK2Qt5ewOh7bs2VwlnE4YlIDi2VXXFgc4i2MbpwdcwONa8W3QCpMligbKcNtPZF6Kgp7Ll2HMhyviBxVQ6Zda5AsBjkDvvJ1y9N4KL3PmyKDky0lHARxDKxyXdXIAAju6kK31WyxMPGv3C8eHHbmEDqcoO+nt2WKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718084222; c=relaxed/simple;
	bh=5cMcX/UuYbDyxBGYWfJjahCah4MRhV7l+4kJP5cSWa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7dlVyj/oe5pjpHsXfQ17GWPS1qiWLRQrrmtXRW9nld6cqrzDzYqWsW43kbWhs1cslcZQtGT1FRLPqqduv3VLL6JLkYevT4eIMk/YyQxPWisW1HBb+VSjkqfHOEooP8u7WY5G6lfsNIsOVSD5lI9Jt2gnTF35itIzhsDsk6mzmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EexhBW7u; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so335802966b.1;
        Mon, 10 Jun 2024 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718084219; x=1718689019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnNUGx74/cjH3X8zUv/i+3L5ocpDeuduqeGI85agJwg=;
        b=EexhBW7uoH10kvPuQ5eH92Th6Js8bsXSYfB65lARdf8xJx7mkl/WL6kiqCmkgG7xZ2
         bT9dmGseID6DGKwYKN0HHpDuOHZlqlvuhbc2miReiKtBU+UfsM1GMpxLmaq1UGiMM8/P
         CNVvbIKPeXJ/I7MsMIgWuzG2y8GYbWtSNTmwP6fUxqHGuPjXS5PU+nQtI6aCnxv3fxoQ
         7a+fGajJxuwpDGZR5M/pLGTBYwLuc4YT3dR64PR3iF8r1hpyR7/DgXEC3yi4GnPL1BAo
         DlNlP9jg+5OPsvQmjcK/8tZ6u+tJ7HocqebpZMprW0O8fmgl5648lSsDEoyuZ8Su3vk7
         cibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718084219; x=1718689019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnNUGx74/cjH3X8zUv/i+3L5ocpDeuduqeGI85agJwg=;
        b=kRA8EuULJ5Jul9gQrg03/8PqhOtbYk0NHIaRXZeuQ40Y1fxjWnkQhWo1DCQZv+Np1O
         OfdV6C8jGAZuGSSfmKzLJoP1rzu/e0vhQlDeEcHbUVuDsVhrgBtJIKSYI/OWllrrBBut
         G9r9M0xksXUfJ4okMer55iAdxknAYA5PKiwApmKeQAI0BmBDV4AybOgI2V+BP/xn64sq
         KDKZM74IBpY7ZcWSgoFoE8nMFybc/5VlQuYiQvQXLbFLzJUdQAOoX7lSULtKEHV8e46k
         IuSi+UMoNImdAaH4deHQcizCS7l6GXzjKBuCETzDCjW7InLE5hvLwwiBWE0bCHE3mluP
         AceA==
X-Forwarded-Encrypted: i=1; AJvYcCV/jUCZlBdFBc43gOOFxTOo3XVuxk+ghAveDqHNKAoNpi7l4GhJSlsJ1PiXjbFU7znvqJjLVqRkz7RYZ/gbIrA4HEAOUMV/4PfZG1pWXhQQf/uV7qyoCFCO6yo6P5GD4fcX1ig1oFsVA1FySSK/s7GHMJbn9ybGXBZzPkXf/kMQz4nUae7muAZo
X-Gm-Message-State: AOJu0Yzhk5qeDrk7KiR9Fj8s911Sp2yFbUmJZMQCWUrDQin6mlDqGuSD
	MLtSjtvTahZh3GI3FBh490WC7HdqxiVDG6gXF1Z9CcTpbL+epUiUSnqt64h93dBdFavBamXCCJp
	TnmiIVkaiSnsorVWhXjzVFW0M16I=
X-Google-Smtp-Source: AGHT+IGTnCL/Z9wEOthvVxD3wHy/9TNbKUKiUrW5SRnrbtv74rZJ1Oulp341mWgnK3+mrIT2q2wLNvR8q9E2ZvwvrJY=
X-Received: by 2002:a17:906:54f:b0:a6f:1b2b:4832 with SMTP id
 a640c23a62f3a-a6f1b2b48b1mr326905666b.52.1718084218991; Mon, 10 Jun 2024
 22:36:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610195828.474370-1-mjguzik@gmail.com> <20240610195828.474370-2-mjguzik@gmail.com>
 <ZmfZukP3a2atzQma@infradead.org> <CAGudoHE12-7c0kmVpKz8HyBeHt8jX8hOQ7zQxZNJ0Re7FF8r6g@mail.gmail.com>
 <ZmfemrY9ZPnvmocu@infradead.org>
In-Reply-To: <ZmfemrY9ZPnvmocu@infradead.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 11 Jun 2024 07:36:46 +0200
Message-ID: <CAGudoHH_Cx1F5Fdiv7EQaz_pWmZUyuieMdx+_XsUXa6AY829Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] vfs: add rcu-based find_inode variants for iget ops
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:20=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Jun 11, 2024 at 07:17:41AM +0200, Mateusz Guzik wrote:
> >
> > I agree, but this is me just copying and modifying an existing line.
> >
> > include/linux/fs.h is chock full of extern-prefixed func declarations,
> > on top of that some name the arguments while the rest does not.
> >
> > Someone(tm) should definitely clean it up, but I'm not interested in
> > bikeshedding about it.
>
> No one asked you to clean the mess up, but don't add any in changed
> or added lines.  Without that:
>
> Nacked-by: Christoph Hellwig <hch@lst.de>
>

I am not saying you told me to clean the file up.

I am explaining why the addition looks the way it does: I am keeping
it consistent with the surroundings, which I assumed is the preferred
way.

That said, whichever way this is spelled out is fine with me so if vfs
overlords want 'extern' removed I will make the change no problem. (or
based on what I had seen from Christian so far, he will the touch it
up himself, which is again fine with me)

--=20
Mateusz Guzik <mjguzik gmail.com>

