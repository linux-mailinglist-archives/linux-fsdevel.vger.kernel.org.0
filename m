Return-Path: <linux-fsdevel+bounces-29985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BAC984A0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E321C20B8D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2D31AC43B;
	Tue, 24 Sep 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KDGwPpTi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884B1ABECD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197057; cv=none; b=SyVrjDt6Y5pA1/Cn0j1S7wXvzunJhreTT+Y7Ocw3tVsLc71yQZP+RUEE7aiuz8bxc+dwB89hegsG1jQFk8Ld6ZwfrXhzMK0umOqkhagMkMVDH5yjf7WOQviyhSRwqal/biK2bVvYHfkVx/XXtjKTTNPS41jVWbCFcoCWVVX6XrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197057; c=relaxed/simple;
	bh=bItl/gYVHfFmT4Id2cNUR3ZjWbNemA/mNpGur3LI3no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOQnkRONCBsVDsLM6vVks7ceINNwS7XeqEodrftuYv3qIDORGAPMaYtNYQ/lFQG0KLSR1f1FxIWpFNgyBoWEk4+vOjFd01ye810Vg0kUo667iLcRFL0WP4bjSl/HmNiK/d/V368tQ6/ir9lJJo11XT4I6SKGqAv9N1W08h/3t2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KDGwPpTi; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f8ca33ef19so32037321fa.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727197053; x=1727801853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w+8VVnFC0UMbLhE2FStB9WxzHe1cGOTS795re4qbfvA=;
        b=KDGwPpTiC6BT4IofEZxshY3ZVXFTgDthOhcBJSJj7Twt3VpagzMbFjK5Bc6V0KJSpW
         lAbRNxft6Z/T9X8W4qQ+cA3nJl7AXukaK+3RE/laOLMk7+Th5KbneQyUE/WF4eKGDxbs
         R4StqH6gyvaaPrwXiPosPya5QPXoGTbMzE1XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727197053; x=1727801853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+8VVnFC0UMbLhE2FStB9WxzHe1cGOTS795re4qbfvA=;
        b=NULk24TCT/u3rKPqh/cdHigMoR5LRLLjbvPBi8T0HZmXC4N28M93uD6Rw92hs6R2yl
         DYakpeBE9NMpe+7vJv5XqMLIldtUYhJKeaP89G3wNmnCM5iY69TxGpOvh78Sb63ovFMm
         jEx8lD2HDYf9at8bklwGsM2J9s1j4/oxzEQ/vxYe3lA0TrRgEiVP267c9KruBKLa1yXg
         eRYQg1AL5i+mJELkfsXLZvr3KVIwc8AzjUANKom0Uq9PLQ/i8MZN41YYQXNBRFnaJJSy
         86YgT1H/YFJD+ttMef7slC/3S+Lsr89orfGgPdM0+BjnB+8HHGwVSVCNKru1WR2MoZEV
         ON2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXX9ZnXHXvSUBNnmzfRBLCx1hu7BqM4bqhf6eZPrIMZUYygH4C+5aZK2cJmbZ3z6cLJ0WwbkLLsKEzv8qdR@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6Naq2lZnl9LtkP8XZaBR0Mw+jQUwDZhNOSKsoUAfmdGllE6c
	NsxeY8UmxT48ecKNdAN7aAlqnFRJqX9XPdqVI4tZ9X55XG/Bt1/ItJ5MVOkIrtdOIofIvV/BGhX
	gpeH7gg==
X-Google-Smtp-Source: AGHT+IH2sZ2sj7tIZAh09WZGyIizEPAI3xG2H6auEsURQqXCtam5t7mm2T8GIphi3T2GApi5RJAt1g==
X-Received: by 2002:a2e:5152:0:b0:2f7:5049:160 with SMTP id 38308e7fff4ca-2f915fde784mr573791fa.13.1727197052959;
        Tue, 24 Sep 2024 09:57:32 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d289f17asm2810911fa.123.2024.09.24.09.57.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 09:57:31 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f74e613a10so88388091fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 09:57:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlunxQuumt84Ygga446fgheDtqzVmUHWM1G8Z8d/IRAfDVwWIL3dPr22rP1NETrOX4iYOJWZGr6Oj8ANoa@vger.kernel.org
X-Received: by 2002:a2e:d01:0:b0:2f7:712d:d08 with SMTP id 38308e7fff4ca-2f916002bf9mr453131fa.23.1727197050351;
 Tue, 24 Sep 2024 09:57:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com> <ZvI4N55fzO7kg0W/@dread.disaster.area>
In-Reply-To: <ZvI4N55fzO7kg0W/@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 09:57:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Message-ID: <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 20:55, Dave Chinner <david@fromorbit.com> wrote:
>
> That's effectively what the patch did - it added a spinlock per hash
> list.

Yeah, no, I like your patches, they all seem to be doing sane things
and improve the code.

The part I don't like is how the basic model that your patches improve
seems quite a bit broken.

For example, that whole superblock list lock contention just makes me
go "Christ, that's stupid". Not because your patches to fix it with
Waiman's fancy list would be wrong or bad, but because the whole pain
is self-inflicted garbage.

And it's all historically very very understandable. It wasn't broken
when it was written.

That singly linked list is 100% sane in the historical context of "we
really don't want anything fancy for this". The whole list of inodes
for a superblock is basically unimportant, and it's main use (only
use?) is for the final "check that we don't have busy inodes at umount
time, remove any pending stuff".

So using a stupid linked list was absolutely the right thing to do,
but now that just the *locking* for that list is a pain, it turns out
that we probably shouldn't use a list at all. Not because the list was
wrong, but because a flat list is such a pain for locking, since
there's no hierarchy to spread the locking out over.

(We used to have that kind of "flat lock" for the dcache too, but
"dcache_lock" went away many moons ago, and good riddance - but the
only reason it could go away is that the dcache has a hierarchy, so
that you can always lock just the local dentry (or the parent dentry)
if you are just careful).

> [ filesystems doing their own optimized thing ]
>
> IOWs, it's not clear to me that this is a caching model we really
> want to persue in general because of a) the code duplication and b)
> the issues such an inode life-cycle model has interacting with the
> VFS life-cycle expectations...

No, I'm sure you are right, and I'm just frustrated with this code
that probably _should_ look a lot more like the dcache code, but
doesn't.

I get the very strong feeling that we should have a per-superblock
hash table that we could also traverse the entries of. That way the
superblock inode list would get some structure (the hash buckets) that
would allow the locking to be distributed (and we'd only need one lock
and just share it between the "hash inode" and "add it to the
superblock list").

But that would require something much more involved than "improve the
current code".

               Linus

