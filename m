Return-Path: <linux-fsdevel+bounces-49827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C221CAC36D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 22:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D051894268
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 May 2025 20:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA71C2437;
	Sun, 25 May 2025 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S6MNoHjq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1261B4153
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748206497; cv=none; b=j6ClNREF5NpzFeLMZ6S7jkCEkehmI4P+H5SWhcdr6by1LjvwTtEgaFG1A0cEoT5dhEy2CpF810Dq9eso7S5FpKTWC/T+8HfPk6A3TjZgyadlk7yuwlzKNohFjI07mjvW6dK6v7juBv5IJIaAZyQ3KTcZmTwEgNmgURq5ZPLCw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748206497; c=relaxed/simple;
	bh=84E68MsXaFkr74J3EcYu6/829NuQf8Ks2NJLDHpaS2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMRcAgTdckuhigvJa6uksLGyZyoOB3FnxpQQwCQic3jrw71X+fsVaJHIoi4HMfTwgXPGAKLaOa6cJQ+LCR5+oD43qCHY9XShRCZxSD83y30Xx0UnEEBb7Sx+O38cK4UnqYvKKCllRWoIkE5vuJXBTEFURNBCbe6cFbL+wmNKMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S6MNoHjq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acbb85ce788so332406866b.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1748206492; x=1748811292; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CdRdAZXSSh1/jEt6dZFpuG7gJX5yYWKD/wEyCLUi620=;
        b=S6MNoHjqFKY50NRjR389B5A1qxokynca6gtXR/E+o8xcZSLR0r0MuhazHDF+MyuvrI
         IQ2IcvZnU0hNkkZ5WxQuqEeJU6Dm058T506x8PYA1zxj3CtslT3fzntOSnCrDmgMi2K9
         LDaV25ncA8GuiKYI7vJGlSIlP4jZx0RHFhoxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748206492; x=1748811292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CdRdAZXSSh1/jEt6dZFpuG7gJX5yYWKD/wEyCLUi620=;
        b=noya6SPyMpSSu7CmzkXJfzCcszHEK8a4DvMzrvB0AnM7St3JbxawhOHv2ht4zRoTxK
         Ol6CToT9v1PskbkD6xe627OeEDzydxYQyPFNdHawN7/hTLjeIfBmxxS+7MD4dMvA7G+3
         BYHm45R1Cx6hW9whnbQcr8YOyHfPqLXUrlFQlcZ4NAqutMmxyUeuc5TBepqcZj6hFoOa
         l4BArAPAjwAA4F8GG795ZyjHd6AKpnRnGMesTT/iMtX99D74nfAWnTh289t/h3IEqhJQ
         oZ7X/ZsmVQU/Q45lj/lfSrAEK1V8kPB5vN155deGoCnC4vdf3Cs/f8sqpIrnhaGVlGcR
         C8NQ==
X-Forwarded-Encrypted: i=1; AJvYcCULWotKBwyowsip4vcOSTHXQ1wENbSVL/mbu/KPhcP3+YrQoK+GrDuoyCtFJoAcl3FCcZocUwA9xxzfipGB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+8Vtro7u0AQFQYi4NWGk36zTWgOnlD/SrI0LVRgVgf2V8JkE
	xQaRQWj05n3380MjW6fpTWDWeR0iEBuLynUkIKxVYyF++vlrmIKvFELq1+MKw0Ve56YmIOL9SHl
	ySeOV3ck=
X-Gm-Gg: ASbGncsV9t5XuZPQO8yEKxVVlwjTGl2CA9vbmm6kqPEd+r2yUa8abQY75KcTyjBmeus
	sEOPwY6z5ZBnxmOjQXMqttvcVHA8hSquAHLT08I3X4AgS7wgkFcPDPxvWRgM1zvGQPlQXts3DtC
	VZ1fiLthHkFMEuNHaMOzZpaFGSiWG71DlfMCMbnGGQ4S4/W46fKGEVsdjTmEtinaOm21ieYrbX0
	OK+ukwpYTjnf0a8vZdTj5f0qYJVHX035MkuZh1LUezYgeAlSkOzA20048PATfnmcnFQaK/UM341
	EPAl4WgzhheIHVYF6QS/+sYaylfCSSHKXeZC9+iOfzvdIEHJU9qnmh5DFfWZ2u23GQUcmJjQiKx
	9OGLjDefjTHYfZwmqNVST5yZbHQ==
X-Google-Smtp-Source: AGHT+IEqfqPjDLCwvP9kYHZgKzuhqzzYSu3tYwPv7UpgNRZsbkC+4VTCzMaSRmqykWrcoTsIRWN3KA==
X-Received: by 2002:a17:907:d19:b0:ad2:50ef:492e with SMTP id a640c23a62f3a-ad85b185b6amr606565866b.32.1748206491692;
        Sun, 25 May 2025 13:54:51 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4cbe90sm1565220666b.165.2025.05.25.13.54.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 13:54:50 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-604bde84d0fso48041a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 May 2025 13:54:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHF3hmzY/6aED4ADS75aJp9W6iKKoInrkIXL8qGpDiYKNumYmQhVUHp9vcYoKmLvuXVv8cG3Uq57ioDv0R@vger.kernel.org
X-Received: by 2002:aa7:c316:0:b0:601:9531:68b8 with SMTP id
 4fb4d7f45d1cf-602da3014e8mr4212379a12.18.1748206490237; Sun, 25 May 2025
 13:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250525083209.GS2023217@ZenIV> <20250525180632.GU2023217@ZenIV>
 <40eeba97-a298-4ae1-9691-b5911ad00095@suse.cz> <CAHk-=wjh0XVmJWEF-F8tjyz6ebdy=9COnp6sDBCXtQNAaJ0TQA@mail.gmail.com>
 <aDOCLQTaYqYIvtxb@casper.infradead.org>
In-Reply-To: <aDOCLQTaYqYIvtxb@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 May 2025 13:54:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7B_Kf3b5cBKWmNDz7MrP6bj34adQyJRckOaWDdhB9Qg@mail.gmail.com>
X-Gm-Features: AX0GCFtxS47hLbav5g1bF-L0f2bd455QNqcHh_7xl43sQbSzBNMtDCDN0bfTol4
Message-ID: <CAHk-=wg7B_Kf3b5cBKWmNDz7MrP6bj34adQyJRckOaWDdhB9Qg@mail.gmail.com>
Subject: Re: [BUG] regression from 974c5e6139db "xfs: flag as supporting
 FOP_DONTCACHE" (double free on page?)
To: Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 25 May 2025 at 13:48, Matthew Wilcox <willy@infradead.org> wrote:
>
> I wonder if we shouldn't do ...
>
> +++ b/include/linux/fs.h
> @@ -3725,6 +3725,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
>                         return -EOPNOTSUPP;
>         }
>         if (flags & RWF_DONTCACHE) {
> +               /* Houston, we have a problem */
> +               return -EOPNOTSUPP;

Hmm. Your point about other filesystems is well taken.

I'd have preferred a revert as a "don't do anything new at this
point", but I guess disabling it at this point is probably the safer
option considering that this isn't a xfs issue.

> Oh, and we're only just seeing it, I think, because you need to recompile
> xfstests to test this functionality ...

Ahh, good. Well, not "good" exactly, but it certainly at least
explains the unlucky timing.

Thanks,

             Linus

