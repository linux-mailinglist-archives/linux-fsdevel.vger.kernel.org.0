Return-Path: <linux-fsdevel+bounces-59448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BBB38F51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 01:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9619F5E80A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 23:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBC030FF13;
	Wed, 27 Aug 2025 23:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TZgf53ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AAE2E0B5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756338081; cv=none; b=g5Ss2vFvu9qTpuMcmLXYa2N3Pne1E6o+3s8/AX9dG7nPkRi4yqa3HfPtXJS4IcY70gETYMKCFvuW0Ke7h3049ZFiy7qIcxZBS5nKx+lXr1l9DhEI9N2YrYi6ZV2TQ2twQOSOO01yt1mQA9sEphrJckBUSBdF/ArxPQ7jyhKjf74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756338081; c=relaxed/simple;
	bh=WeQLyqaNspxlSMXC13kkAKQD2QX9Qf7U6ktiE6qUPVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9q2It7RyZzyzGPOW4TfG50Y2001Z0akgVigb51HKTjH4SifoOOlvL+jSa7a99iXChIamQqI+NaGxIouqRtw1eK4ksJa8LX1yqnkrixwe/seKz2TZTlQ0yP87StwcvCbj9hQWWZ5maZ/oGYiigV21bepGItrHcezYIE5bZzSAPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TZgf53ap; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso604403a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 16:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756338077; x=1756942877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SFTZDmbc5XPAbNSRQYZudLQo/qzYSSPXUmE94EQdlh4=;
        b=TZgf53apQZIBKH+1qgRvT0dV0BurD379WfMfWMSdI2PNdN7Lt8rs8DrpfTUFiwJOQq
         SXZ13yAbEJK/XK1qAI7rQDOoMrBDExJeAwHqpfpifTmtAm9U+KV0tMThuyT9OGiVeX1P
         NonpX5dnpnUdwCeJR69yFpMxNMKH8adqplvNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756338077; x=1756942877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFTZDmbc5XPAbNSRQYZudLQo/qzYSSPXUmE94EQdlh4=;
        b=awjxTQN0SDGAuDn4gpmrIwsWG7AQxuumetb797F8AUyZdxsuwGYDoyhUG/81Yzk9YH
         l3edM6lkWh9NBoBZHYprLnvYSx4ztG33gaX4TUSb8nU2kMaahSI3RcqVDmwGbcm3uXNz
         V/+rtaW32ZWmL2f8iU+4PBxcAbF4owQ86dCoxmhlq57lwT3f+TtNURUxTOjTZp4gmNA3
         DQWYftxo9xI3xeX2MLMnwNQRQvNopKozAfmNBW7jAClaj/YDe3kGaWX/gA4VBtZ8ccS1
         9KS+b8UQrE2PF2rcHjlB7H+X14CGlO5GpmqKq8PD36HdIkPHOXvu/KeCi6/h4e1WoW9Z
         0c0A==
X-Forwarded-Encrypted: i=1; AJvYcCUBEbz3gTSTjw6yVS9WGZVikvM8OTQWRRdKPcUC1f2eOQCBvDosXj+NGdh4rYlU+78e71NS+5ieXtcGaOIW@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqhXaPcxz3BagAvg+oQzTMM01xczPmVWPzp+n2sK3as2FQRHe
	UO3dfJZjahjRanXsz4RlSehRSmvJWe8DYH/eQSEQ8Aj6uFC76SUrZbyH1V7SuINWLrgnNtToaR4
	+b36N6Cs=
X-Gm-Gg: ASbGncsIDqjUSQgslxyyRfyFiQdw5UyMS5y0X2oaRWgvbtiQT8qxiaKxptDuatQ+mmQ
	boGwzmyZrWFU0QPmGb4qVhhyBLyzOeYlLRB81+mkzSlcRSABN8LSHHuXz6EIjBfLmtALkHXK5HE
	qn2fz+d6AKjZUTDEyfvV4MO04/Ki3kfxQ5X+OjfnczVkp6ZJfzFKBB/tAgAFQfTNcmqfZp3hx+f
	QiE5Omcx8tO3GLJPcLbRWQUPGQ+fs2mmz01rpB1cV4tMJwmP4EpND48sWDdbnGodrra6IBzXGWG
	5btv7B7UcTalavjgl0kHHpR+DuIfqcEfSQ5IvH0AnTmAOBjj85zzSVLySDhLckT0dBtN0XgYiJa
	rW2/mc/fZgT6p3LqabMmqTHcptO+c7/34MBVGnBVR1Ffu74LS4AFuqMfXUZxRRkQy94n5rnJr
X-Google-Smtp-Source: AGHT+IFQpC85I2Svol4zHAT5DRmT21PokZCE2kIj2RO26fmXMV57/pdRMm9TnYdaY+2lBTPrqGJHdQ==
X-Received: by 2002:a05:6402:348f:b0:61c:8742:21dc with SMTP id 4fb4d7f45d1cf-61c8742249dmr7811450a12.17.1756338077385;
        Wed, 27 Aug 2025 16:41:17 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3172e21dsm9624210a12.40.2025.08.27.16.41.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 16:41:16 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso604378a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 16:41:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfrg9Alr4u753jrwtf5pa39a11SjL/1kjqmq8Tcsh+IVjMK/AoRAWFDSxh3PTXPp8PTbZlxsSA+09njHpv@vger.kernel.org
X-Received: by 2002:a05:6402:50d3:b0:61c:7a9b:21e4 with SMTP id
 4fb4d7f45d1cf-61c7a9b24f4mr9475688a12.16.1756338075800; Wed, 27 Aug 2025
 16:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV> <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner> <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com> <20250827-military-grinning-orca-edb838@lemur>
In-Reply-To: <20250827-military-grinning-orca-edb838@lemur>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Aug 2025 16:40:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
X-Gm-Features: Ac12FXxu1R_yLUsVEbTfGuNpW3u5RkYIeuhsSvtXXUOMc0TNKS6VFIckDRRKPqI
Message-ID: <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 15:49, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> I have recommended that Link: trailers indicating the provenance of the series
> should use a dedicated domain name: patch.msgid.link. This should clearly
> indicate to you that following this link will take you to the original
> submission, not to any other discussion.

That doesn't fix anything. It only reinforces the basic stupidity of
marking the WRONG DIRECTION.

The fact is, YOU CANNOT SANELY MARK THE COMMIT. Dammit, why do people
ignore this *fundamental* issue? You literally cannot add information
to the commit that doesn't exist yet, and the threads that refer to
bugs etc quite fundamentally WILL NOT EXIST YET when the commit is
posted.

The actual *useful* information about a commit is the discussions it
resulted in, not the posting of the patch.

And those will almost invariably be unrelated to the patch submission,
since they either talked about the problems that the patch *fixed*, or
talk about the problems that the patch *caused* (ie the thread starts
with some random "My machine no longer boots", and then goes on from
there as people try to figure out what caused it.

So the *relevant* links are pretty much by definition not the link to
the posting of the patch.

Is it really so hard to understand and accept this fundamental issue?

It's the *message* that should be indexed and marked, not the commit.

What you want to find is messages on the mailing list that mention the
commit, not the other way around. The other way around is completely
pointless and CANNOT BE AUTOMATED. Any automation by definition will
only add noise, not "information".

Really. The only valid link is a link to *pre-existing* discussion,
not to some stupid "this is where I posted this patch", which is
entirely and utterly immaterial.

And dammit, lore could do this. Here's one suggested model that at
least gets the direction of indexing right (I'm not claiming it's the
only model, or the best model, but it sure as hell beats getting the
fundamentals completely wrong):

 (a) messages with patches can be indexed by the patch-id of said patch

This might well be useful in its own right ("search for this patch"),
and would be good for the series where the same patch ends up being
re-posted because the whole series was re-posted.

IOW, just that trivial thing would already allow the lore web
interface to link to "this patch has been posted before", which is
useful information on its own, totally aside from any future
archeology.

But it's not the end goal, it's only a small step to *get* to the end goal:

 (b) messages that mention a commit ID (or a subject line) could then
have referrals to the patch-id of said commit.

No, you don't want to do a whole-text search every time you look for a
commit. That's fine for manual stuff, but it's much too expensive for
any sane automation. But you *can* (and lore already does) scan
messages at message posting time, and find when people refer to a
commit, and then index that message *once* by the patch ID of the
commit.

Now, this *is* fundamentally useful in a very different way: if you
have somebody who bisected something and mentions a commit as a
result, you'd now *find* that kind of message, and the history leading
up to it.

So when people read threads on lore about bugs being bisected, think
how useful it would be if that thread would basically auto-populate
with "this message refers to this patch".

And the final step is

 (c) have some 'b4' infrastructure to look up emails pertaining to a
commit - by doing the patch ID and then looking up the indexing above

Look, now you have a "open web browser with the history of not just
where the patch was originally posted, but where that commit was
*mentioned*".

Notice how fundamentally more useful this is from some link to where
the patch was posted? And absolutely nothing in the above implies
tagging the commit with useless information.

I look at the "Link:" tags quite regularly, and I can tell you that
when it's a posting tag, it almost invariably is completely and
totally useless. We *have* people who add those, and they only add
noise and very little value.

Do not add more of those useless garbage links in the name of
"automation". It's not automating anything useful, it's only
automating garbage.

Because the *commit* already has all the information that is relevant
- it's not the commit that is missing a link. It's the other side.

Which is why those links to lore patch submission events are so
STUPID. They add nothing. Doing them in the name of "automation" is
crazy. It's entirely pointless. It's garbage and it's mis-designed,
because it's not understanding the problem.

                   Linus

