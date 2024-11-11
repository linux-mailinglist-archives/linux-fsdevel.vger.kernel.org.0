Return-Path: <linux-fsdevel+bounces-34341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B039C49CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 00:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1CA1F22B31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F361BD9EB;
	Mon, 11 Nov 2024 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LajbJBzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9A1A76B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368407; cv=none; b=RB36hOKINEr/QrBLFy5bmwZgMP6gmQ2nzofBCRX3CSS5OTVDhecLf+eOERk6lvmfeeFrjFxkdCJ0KFVjRVdH/zMn6V1aqqoXjseYpI8YBBpJjOVdwGkgk5xHTKDngVkT6H8rchy3WiXYrVVpOLuBwICTVrHHF2lscR1qpNGEOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368407; c=relaxed/simple;
	bh=5iMzA2h0qeiCLS/UE7L1mkZIgcrO/N5kJ3Okms4mkXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOWZeOpv+etq11oao19HqIq58DeCVnWsZOToK41kIf80uT5u20otSn82DeOsdIUnk+bKrGqUPm21XXOp5wW8KDE/22i6wtOLI5UONEKaehKEvTvIlQNrHi6hUxyDPfkyKE95E8Ds/CVYI3KceKY5STATbP4bk/IBEwE0cJgOXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LajbJBzi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99e3b3a411so1046840266b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731368404; x=1731973204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfrZKwA8Q666Z7hBV0+zRbjc85gr+W93j+HNejLY+JI=;
        b=LajbJBziZbjhdyFhHv2zEie5HlJQnOlKZUqHm7NDR9PuRFQYcPSl1gsrWlrDM54lHL
         bKkV54j/2yyGA5oioGiUe2gP9ONZdN97OzKI9JhXl2OBjH3VtLFu33v2Eszo3XyEAn4R
         Yw/BuZILJrq7ot9i6g+9CG9gea4tdG9+Dc0hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368404; x=1731973204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfrZKwA8Q666Z7hBV0+zRbjc85gr+W93j+HNejLY+JI=;
        b=NQBeE02PHWTxYN27esWrHy0v8z+X2lQWiKKI3P98A4YSggzY0zgqJI3Qs1f+SM4aiR
         8Dh0DXq/8YenPrc57nQgioNXyJdBwE92Wc9nbDCeNp4JOpzuSmxyXDQwEam4+0W9xu6f
         USJ1qikYtT/ZmERCW9F+tasKh7JDNapeLDNcBGoub1548tb8aaf1XXSGPYkgaLoaPLo/
         KS0emFy+xwekP0/jco0TxEWlyR5hX6XHKpP/K0o/LaVVaf20l5mjL49aCrIrLnQWlZwu
         8TVOBZVHaamutygDtr6PBINmSMtL7ZmYQk6mJdfEIAeIu0HBU0pDrszdBknWY/mLLq6Q
         NJPA==
X-Forwarded-Encrypted: i=1; AJvYcCXp6CJdS5aVXNEtghQMGSSUjk9EzRJXrFt11ywMwK5YBL37kOXBcW0N/GZNcVABjYqJ2mYnkQqCw3YTUBE7@vger.kernel.org
X-Gm-Message-State: AOJu0YxosoY+Ke91zG8LE2Y1SQTb8Y6bAJxeGNvZUQlzHEivVlK87Kqe
	XklXIu66obPXtdh/dsC1ctFxN2/2ewB4wwCH7u/3vUwBpaULX8flpCOawpqnmCuUVYeFk7p8Abl
	vxzY=
X-Google-Smtp-Source: AGHT+IFWowQ9Og7get93NiKnwF1Tvhw5DHw8tnmCmRB6eUTCSMCnyNdsvDFfpfalK2zn9EZ6kpkCvg==
X-Received: by 2002:a17:907:7e83:b0:a9a:170d:67b2 with SMTP id a640c23a62f3a-a9eeffe72a4mr1315585966b.29.1731368403893;
        Mon, 11 Nov 2024 15:40:03 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0def535sm648269066b.140.2024.11.11.15.40.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:40:02 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1119109866b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:40:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVt/2Bl6PPRRmTPuNXwe2RKGX1k67EjIWXG74IBdN7LGSEb/c7Oy267ovSlWN3pZFZvocgehoLa5LZG9jNp@vger.kernel.org
X-Received: by 2002:a17:906:ee8c:b0:a93:a664:a23f with SMTP id
 a640c23a62f3a-a9eefe3f3famr1355377966b.5.1731368401330; Mon, 11 Nov 2024
 15:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
 <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com> <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
In-Reply-To: <CAHk-=wj8L=mtcRTi=NECHMGfZQgXOp_uix1YVh04fEmrKaMnXA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 15:39:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9hc8sSNYwurp5cm2ub52yHYGfXC8=BfhuR3XgFr0vEA@mail.gmail.com>
Message-ID: <CAHk-=wh9hc8sSNYwurp5cm2ub52yHYGfXC8=BfhuR3XgFr0vEA@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 15:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See why I'm shouting? You're doing insane things, and you're doing
> them for all the cases that DO NOT MATTER. You're doing all of this
> for the common case that doesn't want to see that kind of mindless
> overhead.

Side note: I think as filesystem people, you guys are taught to think
"IO is expensive, as long as you can avoid IO, things go fast".

And that's largely true at a filesystem level.

But on the VFS level, the common case is actually "everything is
cached in memory, we're never calling down to the filesystem at all".

And then IO isn't the issue.

So on a VFS level, to a very close approximation, the only thing that
matters is cache misses and mispredicted branches.

(Indirect calls have always had some overhead, and Spectre made it
much worse, so arguably indirect calls have become the third thing
that matters).

So in the VFS layer, we have ridiculous tricks like

        if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
                if (likely(inode->i_op->permission))
                        return inode->i_op->permission(idmap, inode, mask);

                /* This gets set once for the inode lifetime */
                spin_lock(&inode->i_lock);
                inode->i_opflags |= IOP_FASTPERM;
                spin_unlock(&inode->i_lock);
        }
        return generic_permission(idmap, inode, mask);

in do_inode_permission, because it turns out that the IOP_FASTPERM
flag means that we literally don't even need to dereference
inode->i_op->permission (nasty chain of D$ accesses), and we can
*only* look at accesses off the 'inode' pointer.

Is this an extreme example? Yes. But the whole i_opflags kind of thing
does end up mattering, exactly because it keeps the D$ footprint
smaller.

                  Linus

