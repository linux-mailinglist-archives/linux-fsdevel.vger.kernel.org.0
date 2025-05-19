Return-Path: <linux-fsdevel+bounces-49441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FCABC6EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA20818839CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394D27A47A;
	Mon, 19 May 2025 18:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c34BbLCW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43911EE032
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 18:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678292; cv=none; b=Ge/h0CzZTO1pRkrHc7ye8j0RN2k6fGsDP/fTnIL5Ntdv2uni+NxrgTaNpY4I4bMJvYcasxGwALR/fnodfIZwaX3E/jw5H9txSJkakCg8Wv3QcUij8g2mfVYSJLgcCwf/Y1YjyqhMkjfTT/MYvl+uBb0QFe0GqGL1kMc/nobHEjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678292; c=relaxed/simple;
	bh=j5WCWrFWngWyAIuqCoJetQqOEhdTQsm7vxnAXpenfF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFVBzDvmZ1cYqCxv6QT6h4fW3bqfvpYIfK+wYH7WnzlCSnNLo/1ZRhLWrcW5OgEXphHex5RUI1/VFQQukVCr8N6kpQVyEAaoRNUmIOgq2JAMspWmb3fFUcelXz5ZaXzoiAUiXDOUrXE7KnM4Yvf8Z0IeYv6g0F5KpexrJv/s0TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c34BbLCW; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-601aa0cb92eso2679039a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1747678288; x=1748283088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jtHY0MJhtWsV4fhLccOlTdGvmT1aawdSY6LTYxlMCAI=;
        b=c34BbLCWawVtPbfcNKN0my8Itq1tGcUMVXSC7fDXnyR7Dcs1Wp26WUtk6eomZN8tok
         Ft+VQ2B9cGC2ERn4ATEw3BcAgvOTb4aUsDkV3t74uB21En15RiiZEysherjZKRKiqh4Z
         WgvtU6/u4r1C0AE8wvzHFb9h7o8Sx3F0q7Oq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678288; x=1748283088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtHY0MJhtWsV4fhLccOlTdGvmT1aawdSY6LTYxlMCAI=;
        b=HARBQxXwTZBgO84nWqOokrxIuAMfsKs/nxrX1qT8MwgU5mkneqZWgligauZs1L6QOc
         7hiyF2+ZO3CYD4DpJtEAHYiyxf9A3Ed0FJZpRWEnmk7npziAfOvVkPsfuIAfKB6Y9aej
         Ev2Xy8Ks7tRks8MsD+Vdy3Dt3HmApmf2ifF7NNzi3dQ25RqD0pX6ERdCJqS/K2ZMFUSY
         Je3RH+UE8fJMo/Ag4z78Gkixm+uC+R3nwe1v45cNltc4L00HQK6QibTphnxku9BgQpUN
         CGg8ycbr6T5iQPasR84rVYcwUCW4/siMwFb7EuqtAyQjpUIxmdoQWS4nLer0Enr3GvqU
         7FSA==
X-Forwarded-Encrypted: i=1; AJvYcCW1pTsCCgmXbn2wnMA2n5PtcxY4dvt5nQaSWwUOI2CfySGPICpg/VSss2IZkM/B01Nt2RCHtolwNcU7bW4L@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGLV6Kw4jg0626bZO8WhabutTrr7cdufqlaX4QP6bQ6vlNj21
	QAVucju/K1nO1ZJp8trnBXBgyUoAOaewew31G0UbINjDuKHkDCm59d2PTgrqBpTNsysCfrDdmHK
	td755K6A=
X-Gm-Gg: ASbGnctmVtXhiMGUzskdhoAItWisdk8LkbI5Ipf1cjL/kSgfmBXLhEJgdBg+pm3lf18
	6+MRNGQfqJeLJLWgu97DMSCGYdoExxLtT1GonsFwdFyWJYEYVQOf3poTXBHcYBvii244qzSqe66
	SSxepJk7V/PpVGkVnYNYdOUv3xAvpJ8SFS5Fsozcvkb6xOaM0ErD86eSmRROa3XmP5PtOT5S4qj
	SK1UBdP9lH62XpAOg1pyge2XE61r1gGBdKMxvZG+AHYg88JuCQBSsUT/l57cgpuw/GrVJ2w+WTW
	WMGOsp2tJbjzPjSpKVlMlpZ76azP9fkbIfPWDVcq1RpENLQMXtSwBxgPZgeQ05SSMj1MmWnuXS+
	h9y1HCl2dAhPF6Vnm7SDkwZAPkQ==
X-Google-Smtp-Source: AGHT+IGmAMZv9D7BUUJBkKfEsJBu5mJqUHkPs2Cp5bxumrnUraPzTMzPBKkTrHsXwtQ52RonDg50NA==
X-Received: by 2002:a05:6402:40cc:b0:5fe:a303:6bf1 with SMTP id 4fb4d7f45d1cf-6011411acbemr10533357a12.21.1747678287804;
        Mon, 19 May 2025 11:11:27 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ac35e33sm6074501a12.60.2025.05.19.11.11.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 11:11:26 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-601d10de7e1so2569673a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 11:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWj1v5onj4UMLzdamnSpjGF6uwOjSzUNwajevtZeA6r3ivuPasL1iUgMuJVefj2HsbNAqsMQMCQUBeW5xvx@vger.kernel.org
X-Received: by 2002:a05:6402:2810:b0:5fd:ef5d:cfc4 with SMTP id
 4fb4d7f45d1cf-60119ce9672mr10846713a12.32.1747678286454; Mon, 19 May 2025
 11:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511232732.GC2023217@ZenIV> <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV> <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV> <20250516052139.GA4080802@ZenIV>
In-Reply-To: <20250516052139.GA4080802@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 May 2025 11:11:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
X-Gm-Features: AX0GCFtQ4Farx5BhfEGq5b4dtgchVMQjoxs-1V-J29naDb7jsTUg1zAylcl6_Y8
Message-ID: <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

;


On Thu, 15 May 2025 at 22:21, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> With some cleaning the notes up, see
>
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git propagate_umount

Delayed response because this isn't really my area, and it all
somewhat confuses me. Eric - mind taking a look?

But the new code certainly looks sensible, even if I can't really
claim I understand it.

The one reaction I had was almost entirely syntactic - I wish it
didn't use those global lists.

Yes, yes, they are protected by global locks, and that part is
unavoidable, but I'm looking at that code that gathers up the umount
lists, and I actually find the data flow a bit confusing just because
it ends up hiding the state "elsewhere" (that being the global lists).

It just makes the state propagation from gather_candidates() -> users a bit odd.

Not _new_ odd, mind you, but when I was looking at your patch with

    git show --new FETCH_HEAD fs/

I had to go back and forth in the patch just to see where the source
of some the lists came from.

So I think it would make things a bit more explicit if you did something like

    struct umount_state {
        struct list_head umount,candidates;
    };

and made that a local variable in propagate_umount() with

    struct umount_state state = {
            .umount = LIST_HEAD_INIT(state.umount),
            .candidates = LIST_HEAD_INIT(state.candidates),
    };

and then passed that state pointer along an argument.

Although now that I write out that initializer from hell, I am
certainly not impressed by the clarity of that.

So maybe my reaction is bogus. It's certainly not the important part
of the patch.

Also, I realize that I'm only listing your new state globals. The
above is equally true of the existing state that is also done that
way, and your two new lists are actually less confusing than some of
the old things that I think should *also* be part of that umount
propagation state.

(The one I look at in particular is the imaginatively named "list" variable:

    static struct hlist_head *list;

which really is the least descriptive name ever).

Another thing that is either purely syntactic, or shows that I
*really* don't understand your patch. Why do you do this odd thing:

        // reduce the set until it's non-shifting
        for (m = first_candidate(); m; m = trim_one(m))
                ;

which seems to just walk the candidates list in a very non-obvious
manner (this is one of those "I had to go back and forth to see what
first_candidate() did and what lists it used" cases).

It *seems* to be the same as

        list_for_each_entry_safe(m, tmp, &candidates, mnt_umounting)
                trim_one(m);

because if I read that code right, 'trim_one()' will just always
return the next entry in that candidate list.

But again - I might be missing something important and maybe that list
gets modified in other ways while trimming (again, with those globals
it's kind of hard to see the data flow).

So I may have just misread this *completely*.

                   Linus

