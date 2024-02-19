Return-Path: <linux-fsdevel+bounces-12043-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D611D85AB0D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AB11F22CA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CBB1B942;
	Mon, 19 Feb 2024 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H4vUAKY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED9171D0
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367709; cv=none; b=UuXG7fYqjub2GJqyBG5UzVeqGS0EhdYxXekfmkroueNY1A/4i4PdBwhXZlkst7+cCBDLo1FF6G2kOJER0Ew+yeSMHmEwf3flP7cDnY0hk2DcJNZUL2Y/hhYQ8REXz2WjTZpfabMotMunEfnxhf+hs6Wzu7fDjjcunHT6xWdq5Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367709; c=relaxed/simple;
	bh=SkPDDHEuBozLXbOcP+i/CPt3aVlB/38thZCnhMhZeKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRlVNbvi0QRZP0/E2wTGul5iIh+ld8rEwKUgijYJlwZkf0cpC8lH2gavSfZf+tJNd9xRzLytBpvSSC6LaMB3OsF8stDZunyW5keF5iygjGf/M8zvAszvHvFZgBvuDM99qrhZr7VW1qCtsNMB9Evje2ql6X7t/VdkS/H8BTDQGR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H4vUAKY0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3566c0309fso543230266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 10:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708367706; x=1708972506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CDaLevjRVlvg0TNowXGJbIjjtuPr2igBNFxceVsg8x8=;
        b=H4vUAKY0gLtRO7cOVN7u1d8fAGvseB5t4IsvMNmun8ovuTaKbUR99GBgICApE1R0E3
         3jEWFFF2A8o8nWo8NBfP0SxVD1zPrjkxICD5qZ0KnCLVt3F6e51xAifCJpligRnuI9sf
         1jEEiWgeBPZYolVM5vCxCnG0y60IKWW9yT+Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708367706; x=1708972506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CDaLevjRVlvg0TNowXGJbIjjtuPr2igBNFxceVsg8x8=;
        b=bzuKKq8BIYboT+5/awtBpbG1r9rim8GOzmcMBMEafpUk5KslhjsGuv2kRqMcjU8r0D
         DsR8T4C0Qu8Wx/NzjtfVXp57iwUl9ScSzARO/cy0zldz/gsrjHJ87zqLSBxV4Ry9DR0t
         sds3iBti55fDtld4vmPzLL72BwXm9qB/l1kb+OW50aYP4JskKaKT2FjASrc3aFXRECTV
         Cra+NFT4qdWwsqEcl2GbzFjsh3X41lzTBRNl7HXrM+IlSUmWJmVj2MYBN3CQcxwGYL+q
         QhvhEvdzGZI/S8ZkjQ36iT2OqU6OhIMXE2Wmd8j9i8Nz9wwhhGhQv/3UE026dOrvnlnR
         8XNA==
X-Forwarded-Encrypted: i=1; AJvYcCVKEcXRP/uyflGFF1Wgy4T8XvOxitsLsSm3+Ok5a8/fyAJkgdV/jPsp1dM3uh6763gA/Q1JPygqf0TzIa23/wvn6qpA+iqxZZPo5Mua1w==
X-Gm-Message-State: AOJu0Yy3oq7xSOc3Ql4S9j+b5rb0eD9DYZMVSRmHzkyX8LaUi0UxmYI3
	8tU5DC83ItlNq6LZJvGs05Lqp0wyn7DMSOh38hnDCllOiLulp1UkQDeUlpo9Jzs668hSJawhhg1
	nwvnZJw==
X-Google-Smtp-Source: AGHT+IEhosGyLKl1Tx/DHQCXjfAPCrKybqTvdKWrPEegqB0nvdYuavUnilPkVBTDzKbJjlqLEyD64g==
X-Received: by 2002:a17:906:cec8:b0:a3e:c827:89b1 with SMTP id si8-20020a170906cec800b00a3ec82789b1mr1566268ejb.8.1708367705661;
        Mon, 19 Feb 2024 10:35:05 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id gs8-20020a1709072d0800b00a3dab486a19sm3168562ejc.118.2024.02.19.10.35.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 10:35:04 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso6369431a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 10:35:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7piCf+X7RHyMQtaHlczpdZzUl9N3Ty5n1NoWfQ2b7nUNkbBLQGUu2tst0OIln2YJVvYAgsO6wOVVRHoTsqiOiYzTdfNx7W3XFOlunHA==
X-Received: by 2002:a05:6402:1a4d:b0:564:3a16:aa15 with SMTP id
 bf13-20020a0564021a4d00b005643a16aa15mr1630776edb.7.1708367704571; Mon, 19
 Feb 2024 10:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner> <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com> <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner> <20240218-anomalie-hissen-295c5228d16b@brauner>
 <20240218-neufahrzeuge-brauhaus-fb0eb6459771@brauner> <CAHk-=wgSjKuYHXd56nJNmcW3ECQR4=a5_14jQiUswuZje+XF_Q@mail.gmail.com>
 <CAHk-=wgtLF5Z5=15-LKAczWm=-tUjHO+Bpf7WjBG+UU3s=fEQw@mail.gmail.com> <20240219-parolen-windrad-6208ffc1b40b@brauner>
In-Reply-To: <20240219-parolen-windrad-6208ffc1b40b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Feb 2024 10:34:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj81r7z9wVVV+=M57z9tcVY4M8dcy8fLj5rWHrf916vcQ@mail.gmail.com>
Message-ID: <CAHk-=wj81r7z9wVVV+=M57z9tcVY4M8dcy8fLj5rWHrf916vcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Feb 2024 at 10:05, Christian Brauner <brauner@kernel.org> wrote:
>
> @Linus, if you're up for it, please take a look at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.pidfd
>
> The topmost 6 commits contain everything we've had on here.

Looks ok. The commit message on that last one reads a bit oddly,
because the "Quoting Linus" part looks like it means just the first
quote, even if it's really everything.

I'd suggest you just not attribute that explanation to me at all, and
edit it down to just a neutral explanation of what is going on.

But the code itself looks fine, and I like how it just cleaned up the
callers a lot now that they don't have that odd EAGAIN loop thing.

I expected that to happen, of course, and it was the point of my
suggestion, but it's still nice to actually see it as a patch that
removes the nasty code rather than just my "I think that's ugly and
could be done differently".

             Linus

