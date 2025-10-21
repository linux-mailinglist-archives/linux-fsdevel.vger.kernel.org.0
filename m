Return-Path: <linux-fsdevel+bounces-64961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC3BF777D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DAE11886163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282133FE35;
	Tue, 21 Oct 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AjBw7L0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64333033B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061645; cv=none; b=FcsQNGGKSc+9qrzXDwD+nyoad85i4fVuC5sn0qbZB1h5cDtspJ0ckEEzWW2ordsK2FUniIvBiW263PqeUJbk901F0WtNTn3H7dwLpdBFGTDK+0OE4SH2clcvhzdxoT6PDa6MQDgAsppQH+9blgQBZUsjqXl2lMP7HMMpKoPLlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061645; c=relaxed/simple;
	bh=v4DAAOopxPuDTS6b13jWhPwgY6rLi9/WRQVdYJEqclQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B16LokPFNKqVNupJd4c7lguytjodEgre1CA1LHYxo3EZ26Zq3F2/+iQX1bCtCPhrrsY5NGYg0dL2d3QpG5KVXsg8YkVqWgvDhFq+751LxNwuzHz2ZnGOhRIWBFUcj016IQe2j9SYSSSha4H29u3pZColY5a/YBpwBNKtS9QgyoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AjBw7L0j; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c3c7d3d53so6812182a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761061642; x=1761666442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r9YHz5AJsTnbPUUFUzOK0b5SHXphkm+yoYDBq4kn6CE=;
        b=AjBw7L0jp8FRGKTWa5UBsDpVayen0l8U5MV4rViSbQKBqsINy5GoXeWZDX/y1uCFLZ
         6cpl3+CGuj+he0LIZ7NGjt1FEsXc4Blwe+Yk1E1Kmk5QvvVZBAkG9K4o09dksqtOJQex
         VNV8ZG2pxNt56bgb85n6qFO9bOp3p3g5boZM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061642; x=1761666442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9YHz5AJsTnbPUUFUzOK0b5SHXphkm+yoYDBq4kn6CE=;
        b=cvxcHiO87cVgrY9R2IdP42IUAPRdbbSrSrBWt7Gx4aT+Pw5NkAcgF8iCKgmFIGMl8g
         usKkVsh2xsF+dvh3/gXGoBM7J+/bwWlsY5osfOX/HJX26L21L86ELGknaeyOhs7fqcXT
         GiMIirqiTcHAT954D0OxQcSLpK4efPOKf3KCzCLA7nxfHYAiOOQHHsT6CL3jCeVR33f3
         mw3dZHYJ/QSHTm3sC5//vrCgIhkyasYgi/hQ5u/bGKiSYMrAMoYp32Nwtk4xSRosS1We
         ACisbpQvYQyQadjFTuHxp8FncBfZM17XA8bk1fQ0wlmzC0KcC0J+NI9lAEiDYDUv5bRe
         9afA==
X-Forwarded-Encrypted: i=1; AJvYcCVKOaydtB/VDg3ACcWjK+WOfV7uwmElDYO5LcspXtKRQIYwfMegKwKyB2Jhmiu5Jktow/ggWn3gYSRkP6Ot@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4rflLJJO4g1mXg89DtkV60hSk4caGVOOF7x+VskCBGfjeQnm
	+3P2MbxnbYCnaGIVl8lH/a3w0ywfkkVMmNMpohEQPC7OLgOG1UAtE2gYQue8wv1WWOwPKm5mUAW
	JAUuRhJA=
X-Gm-Gg: ASbGnctJt853RI2+wsFpYdeIy0Ffi2poUgQKYSDRDLDvr+OU5b6HVYSghSE2pw7dE6y
	GdOeXwXDqP7fuK6lw9lrrn8GQnSPB/d/CEQQiJdMIv8ulNEHyptwvazHixIRKL7aQEdMacKzkxI
	ftmIhm3B31y/LYJ5jT2VgUjFSh/eS4+A+G15zFx9PjkQ1woT/yEh2RQKbHe6XeCM6JCEDVXYoep
	lcpv3Tlz8SY61fW9PmsPq8oo7OBQtUhpmJGzNtbJE27RRrj/t/RTaXAgnN69OGXZ52XMhzieSVo
	NnohFCJzJBzsXI0lPqKtv8/mnkIm2qOPdSEpTVBTL2uKtoSLHD4Ktq+nSp+6zJGDjZEX6JM9bbS
	aaaPhWBqD3jjHcHL1yGUg6CvxH6xEHdUGOUO6NmrhDEWvzPSVtSbvGhHOZLcqWIzdbJrPRNsXQv
	/5ynbET+zr9IdZ8r4u/K85kfKRFVel59gA2OPNi8JwYLKioPZpcLJcbpnbA7+o3QX1/uG/PSo=
X-Google-Smtp-Source: AGHT+IFoR5Bjo7fpT4Ng5arvD8PV6to+pjbxwYGK90oZD7LvwumyHNSXfpkAZS0NnEYci2uQFG7iIQ==
X-Received: by 2002:a05:6402:5cd:b0:61c:8efa:9c24 with SMTP id 4fb4d7f45d1cf-63c1f6f62a6mr14710404a12.37.1761061640939;
        Tue, 21 Oct 2025 08:47:20 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48a928cesm9902666a12.7.2025.10.21.08.47.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:47:19 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so9304236a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxACz+/SiI7UNu7Vn8fkjJ00PvdTl02vZ2LwK2fabxt7YDJTONNifk55HFGz48lgqnoKi/wOeY8/HM5Qq9@vger.kernel.org
X-Received: by 2002:a05:6402:26cc:b0:63c:1514:67cd with SMTP id
 4fb4d7f45d1cf-63c1f6da983mr16912137a12.17.1761061639455; Tue, 21 Oct 2025
 08:47:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
In-Reply-To: <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:47:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh62OxWsL+msmks7=VdBJHz7HvRYoPDckkAEAwsgrmjew@mail.gmail.com>
X-Gm-Features: AS18NWAv_MfH5FLOB6ldL8Zj3hG-nJtcm__9IX9yFQBhtiHusUcNpFwx2FU0x0Q
Message-ID: <CAHk-=wh62OxWsL+msmks7=VdBJHz7HvRYoPDckkAEAwsgrmjew@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 18:53, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Is there really no way to copy the dang thing straight out to
> userspace, skip the bouncing?

Sadly, no.

It's trivial to copy to user space in a RCU-protected region: just
disable page faults and it all works fine.

In fact, it works so fine that everything boots and it all looks
beautiful in profiles etc - ask me how I know.

But it's still wrong. The problem is that *after* you've copies things
away from the page cache, you need to check that the page cache
contents are still valid.

And it's not a problem to do that and just say "don't count the bytes
I just copied, and we'll copy over them later".

But while 99.999% of the time we *will* copy over them later, it's not
actually guaranteed. What migth happen is that after we've filled in
user space with the optimistically copied data, we figure out that the
page cache is no longer valid, and we go to the slow case, and two
problems may have happened:

 (a) the file got truncated in the meantime, and we just filled in
stale data (possibly zeroes) in a user space buffer, and we're
returning a smaller length than what we filled out.

Will user space care? Not realistically, no. But it's wrong, and some
user space *might* be using the buffer as a ring-buffer or something,
and assume that if we return 5 bytes from "read()", the subsequent
bytes are still valid from (previous) ring buffer fills.

But if we decide to ignore that issue (possibly with some "open()"
time flag to say "give me optimistic short reads, and I won't care),
we still have

 (b) the folio we copied from migth have been released and re-used for
something else

and this is fatal. We might have optimistically copied things that are
now security-sensitive and even if we return a short read - or
overwrite it - layer, user space should never have seen that data.

This (b) thing is solvable too, but requires that page cache releases
always would be RCU-delayed, and they aren't.

So both are "solvable", but they are very big and very separate solutions.

               Linus

