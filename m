Return-Path: <linux-fsdevel+bounces-21936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA4890F77C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90E21F23B50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DA15A860;
	Wed, 19 Jun 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L9KhGDI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7786159562
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718828723; cv=none; b=ko80MJfNpbgpwn3waBab2E/RFMBZ/AryzcofGcg7a2o2lnB7URqZr30FBnSLDezDPzO6tC+1Lish+kadLM8+IDs9X5VgNk/lyVD9Mi66Q4mrrTvPoWvDqJYrmUCi0GxjIu/0PMO7oMX8PMzhx4hxRdfEaqK6hZEt/aw1ZuTC8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718828723; c=relaxed/simple;
	bh=rG9ENg+9n76Cn4HGc5+anyg5WiKL5Mt6eTESlfVDI8s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fAL/1o0FnWWLeGjuflDNQHfViALmKNAiVGc37zBJ6jqcDS6theUCYrvofQrd4NW/s+v+LY3wetViGW++21VFSclbca+MjC/fuQcD0hui7Xhot5jjrDH5IPxevaxDdt9rR9WPgOq8SlUWwJ7nIyNlSQHndtTuUGBO0jeuPPj9Sbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L9KhGDI3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so119905a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718828720; x=1719433520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NB9pQz873Cy2BI/A69NB2hPivapi5DfhwFSffll5JTM=;
        b=L9KhGDI38mqoFcTGrQY5wbFSoZAOSeh8XowF3j72YNdHweUlxwUrdN7QZr0lQKlVmp
         zPyAVF696AIh8kF/+6Kfv44XoNLhjlDgIUEZ78XnncBcCnvApRf3Rq0mg7/sLtsYTJN1
         m7die/k0hgyVoOlhUlv1vBGgftRwv+aPg6mjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718828720; x=1719433520;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NB9pQz873Cy2BI/A69NB2hPivapi5DfhwFSffll5JTM=;
        b=tl1HqfQmQukhITZ4jwBAAE/A/ZCGOlwIdXN/V/epbTseZrQpwXBcff781boLSdcY0G
         DM7AOWB7x2B038Mc2SU9c5IjpWpD2WDZeSdlYbF2aj3vOHtTb6Qe569f0I9LvAa+EMmc
         QcFjPtlmGmqkzsFbV0Dn9Z+mjMCM1LpgLA/nauJJffxUSQd16h+2t6EVx7VwN0Ox3j6e
         9s5C+A6//bTR4SjoqGkbCweu8NQiaL7ZxiF4k0vgHFZrs+EK5jyuxE5YQZK1ZeDMm6nA
         39BPQ24i3GTg68A7S1AqAFkqPL3wcRZGwhCqOb+MRnvvfIbDWbNarzBnflsbRAX7RyKG
         QWpg==
X-Gm-Message-State: AOJu0YzeENpU1BkHgpiOMtCXPcIs/ntc92GUMVmB1hoNV6oM3AGGp9Bg
	z5GOlFF2Mpl8NwIs087zQF1ql840iBU/sgkZ78Zx+aTsAT3YjqeDQnUiZpMHYR70FsKTJ6qejXd
	ttV8x0w==
X-Google-Smtp-Source: AGHT+IGYfYsafY7QDB9CEtgwco4w9fdXFMVvz3urdf0lFXt+cO6WfRt1dqbyMiTVwRIRDvW8aBR+vg==
X-Received: by 2002:a50:9b4b:0:b0:578:6198:d6ff with SMTP id 4fb4d7f45d1cf-57d07eb5393mr2250861a12.33.1718828719939;
        Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b026sm8697525a12.97.2024.06.19.13.25.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a63359aaacaso19774366b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 13:25:19 -0700 (PDT)
X-Received: by 2002:a17:906:d98:b0:a68:86b9:52e8 with SMTP id
 a640c23a62f3a-a6fab7d0449mr192966866b.68.1718828718630; Wed, 19 Jun 2024
 13:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 13:25:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Message-ID: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Subject: FYI: path walking optimizations pending for 6.11
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	"the arch/x86 maintainers" <x86@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I already mentioned these to Al, so he has seen most of them, because
I wanted to make sure he was ok with the link_path_walk updates. But
since he was ok (with a few comments), I cleaned things up and
separated things into branches, and here's a heads-up for a wider
audience in case anybody cares.

This all started from me doing profiling on arm64, and just being
annoyed by the code generation and some - admittedly mostly pretty
darn minor - performance issues.

It started with the arm64 user access code, moved on to
__d_lookup_rcu(), and then extended into link_path_walk(), which
together end up being the most noticeable parts of path lookup.

The user access code is mostly for strncpy_from_user() - which is the
main way the vfs layer gets the pathnames. vfs people probably don't
really care - arm people cc'd, although they've seen most of this in
earlier iterations (the minor word-at-a-time tweak is new). Same goes
for x86 people for the minor changes on that side.

I've pushed out four branches based on 6.10-rc4, because I think it's
pretty ready. But I'll rebase them if people have commentary that
needs addressing, so don't treat them as some kind of stable base yet.
My plan is to merge them during the next merge window unless somebody
screams.

The branches are:

arm64-uaccess:
    arm64: access_ok() optimization
    arm64: start using 'asm goto' for put_user()
    arm64: start using 'asm goto' for get_user() when available

link_path_walk:
    vfs: link_path_walk: move more of the name hashing into hash_name()
    vfs: link_path_walk: improve may_lookup() code generation
    vfs: link_path_walk: do '.' and '..' detection while hashing
    vfs: link_path_walk: clarify and improve name hashing interface
    vfs: link_path_walk: simplify name hash flow

runtime-constants:
    arm64: add 'runtime constant' support
    runtime constants: add x86 architecture support
    runtime constants: add default dummy infrastructure
    vfs: dcache: move hashlen_hash() from callers into d_hash()

word-at-a-time:
    arm64: word-at-a-time: improve byte count calculations for LE
    x86-64: word-at-a-time: improve byte count calculations

The arm64-uaccess branch is just what it says, and makes a big
difference in strncpy_from_user(). The "access_ok()" change is
certainly debatable, but I think needs to be done for sanity. I think
it's one of those "let's do it, and if it causes problems we'll have
to fix things up" things.

The link_path_walk branch is the one that changes the vfs layer the
most, but it's really mostly just a series of "fix calling conventions
of 'hash_name()' to be better".

The runtime-constants thing most people have already seen, it just
makes d_hash() avoid all indirect memory accesses.

And word-at-a-time just fixes code generation for both arm64 and
x86-64 to use better sequences.

None of this should be a huge deal, but together they make the
profiles for __d_lookup_rcu(), link_path_walk() and
strncpy_from_user() look pretty much optimal.

And by "optimal" I mean "within the confines of what they do".

For example, making d_hash() avoid indirection just means that now
pretty much _all_ the cost of __d_lookup_rcu() is in the cache misses
on the hash table itself. Which was always the bulk of it. And on my
arm64 machine, it turns out that the best optimization for the load I
tested would be to make that hash table smaller to actually be a bit
denser in the cache, But that's such a load-dependent optimization
that I'm not doing this.

Tuning the hash table size or data structure cacheline layouts might
be worthwhile - and likely a bigger deal - but is _not_ what these
patches are about.

           Linus

