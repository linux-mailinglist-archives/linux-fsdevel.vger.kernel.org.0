Return-Path: <linux-fsdevel+bounces-35394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113D49D4917
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 09:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D248B23C36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 08:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08F1CB531;
	Thu, 21 Nov 2024 08:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OUxGPnmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9E157E78
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178605; cv=none; b=cfVV2KUQ7CEScVqJf5ax/MiMThQF4tyBadKjwdgo7oDuCwex9JGVsb8t+ggjAeL9iJLDugHhWTi+BhB3NkQJEAZRvRWqGAr7n8VZ0xVxCuhQ1xDqRBAZK67tZLE6twzzhILSdqYJGkJkreyXFuKGZHKoEkz8Egse5r385vrCW10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178605; c=relaxed/simple;
	bh=8MYhJTbJ7F4usSFmd0mps/eCDIHG/TRkGxMTXjlpUuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZdfUf0bpn9H9CzpdIVHbh0cjwq5XRSANipydT3zYKXMbCL4wAvawnG+MF7RHDeQZyPm1NKJUkzU4WrJTJIJ/jyrG8MyE/0/BYdwO6AtVGmHWDvfucmCHTtVN7ZwlX8XkHqvDjp8xCT/nt/fxgOa4dWDcNtlUer4zo4lgCGNDp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OUxGPnmh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38231f84dccso411890f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 00:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732178602; x=1732783402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLSsZ5JOZPvpqG/LZBTATMNgJ0P8sq7dJjWcV7/MSNs=;
        b=OUxGPnmhszi9+s2zlkVFjOjItVjRFc8h7vJyW0x+6CIBllJ1LYAb+ncSzzUrv2qjS5
         uopUfpKJ9UsdjLz9rrqadaGLmadcgoiNqrxNaxrHhw0BlqHNzvXhijQsxIEpTlaxepXP
         Yn8G5nJJTWe3qqJ+bud3HkdZqtWzMEtCRqFdl7gnTqbMoW+dfirFLA3XJHopnm2DkV1V
         BfWAROzd2sZzhbX2hnzUo9Zpho7Z5Zjcfaq18UdTmGGGF15Q4CwLUVzNZiZAywmCOUoL
         cIDpX8L/sy3hMePe3uka15eAqtWQuZmYemtLxWpll2hHma/hkY3Y2eiFLFGZtiAV2Tly
         LtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178602; x=1732783402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLSsZ5JOZPvpqG/LZBTATMNgJ0P8sq7dJjWcV7/MSNs=;
        b=pbyqD6sqDXB5iXzcSw74o9uvsKzPBCEuM+PNJk5XXBxUQuf3Kk2T4Jfghe9j3TPwtW
         qMMv+15YMnVWCm5IR09fswSFknLsu6qGqOHET08Fg/iocSLzl8jGsjepNaCdvxzEL8rl
         fhqcvqdaFKe+cdXMGZr5sCwOTndc9V27F+9paSvaB0+sOIM4QbR3qMKOIr5FOOq54F6A
         Bt79HGOW0p3nU8w/JPgaObsB+pk43Kn5f3Gd9cU3jvC+EPJ5nmFIQJErqEaFFwFUIECf
         4Rg2BfiiCHABRCZyReTZI1L3zlZ8Woagwg5OxqaNZWznYNRj5Gb7lsYeNJ+VyJ9WeAY6
         MLYg==
X-Forwarded-Encrypted: i=1; AJvYcCXwhnXEk0SUHiWf0OE73AU6TBlaHs2AeMSy0rLFdrW7ixomDM8nfkuUNGEWfBZlzSVioUP2xWzPECbChaUt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0CHlvS4CfV05OaFYdTB5te9zcKneqt3YF21mRaN98trUKB1F4
	lj4jIWGpJ/eealCiXkU91etE96yQFJ1HFetRzBg90PEh5ZlsGQVdFG1kBrcXla4=
X-Gm-Gg: ASbGncs1WC54w3stjvXAu86PKATLt8nDNTLol4zjiqJiI12777if7s4UA61Y+cgOO/B
	OT9UZE4lM8FGhH+FIlqOdrK6sJWBXOFPXSKUQhjD/mioQqhZv9KN4AmlPfzvrCk9xtHhh46D41B
	6QRqLjTQ/MKQlcYGL9fhzrWWaY9vAfZKPcS2TJy5dRyj0BYqAwruKOl3589N9xbJRfn4tVkoMGH
	N91QBx/1h+JSatKACoHO2UE/KHgJNFdQNI6KCqf
X-Google-Smtp-Source: AGHT+IFpzheFe8Pg8r0thIYlyEIejMxQZNthE+3ERMHDXChvRhZ7QOfLnjgXRaCi9TO530mI1wAQ6Q==
X-Received: by 2002:a05:6000:154c:b0:382:359f:5333 with SMTP id ffacd0b85a97d-38254af5268mr4115907f8f.22.1732178601810;
        Thu, 21 Nov 2024 00:43:21 -0800 (PST)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825490ca19sm4207193f8f.39.2024.11.21.00.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 00:43:21 -0800 (PST)
Date: Thu, 21 Nov 2024 09:43:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	"conduct@kernel.org" <conduct@kernel.org>
Subject: review process (was: underalated stuff)
Message-ID: <Zz7yqeI0RatH4ao5@tiehlicka>
References: <v664cj6evwv7zu3b77gf2lx6dv5sp4qp2rm7jjysddi2wc2uzl@qvnj4kmc6xhq>
 <ZtWH3SkiIEed4NDc@tiehlicka>
 <citv2v6f33hoidq75xd2spaqxf7nl5wbmmzma4wgmrwpoqidhj@k453tmq7vdrk>
 <22a3da3d-6bca-48c6-a36f-382feb999374@linuxfoundation.org>
 <vvulqfvftctokjzy3ookgmx2ja73uuekvby3xcc2quvptudw7e@7qj4gyaw2zfo>
 <71b51954-15ba-4e73-baea-584463d43a5c@linuxfoundation.org>
 <cl6nyxgqccx7xfmrohy56h3k5gnvtdin5azgscrsclkp6c3ko7@hg6wt2zdqkd3>
 <9efc2edf-c6d6-494d-b1bf-64883298150a@linuxfoundation.org>
 <be7f4c32-413e-4154-abe3-8b87047b5faa@linuxfoundation.org>
 <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nu6cezr5ilc6vm65l33hrsz5tyjg5yu6n22tteqvx6fewjxqgq@biklf3aqlook>

On Wed 20-11-24 17:39:09, Kent Overstreet wrote:
> Michal's (as well as Steve's) behaviour in the memory allocation
> profiling review process was, in my view, unacceptable (this included
> such things as crashing our LSF presentation with ideas they'd come up
> with that morning, and persistent dismissive axegrinding on the list).
> The project was nearly killed because of his inability to listen to the
> reasons for a design and being stubbornly stuck on his right to be heard
> as the maintainer.

Couple of entry points that might be helful for that.
https://lore.kernel.org/all/YxBc1xuGbB36f8zC@dhcp22.suse.cz/
I have expressed my concerns and set expectations to move the
work forward. I've had couple of back and forth with Suren about
specifics of overhead assumptions from the stack unwinding IIRC. 

For the first non-RFC version my feedback was
https://lore.kernel.org/all/ZFIMaflxeHS3uR%2FA@dhcp22.suse.cz/#t
not really "maintenance burden only" but a request to show that alternative
approaches have been explored. It was not particularly helpful that you
had expected tracing people would implement the feature for you.
https://lore.kernel.org/all/20230503092128.1a120845@gandalf.local.home/
Other people have also expressed that this is not completely impossible
https://lore.kernel.org/all/ZFKNZZwC8EUbOLMv@slm.duckdns.org/
The rest of the email thread is mostly a combat zone that I have avoided
participating as much as possible.

I didn't have any reaction to v2 at all.

v3 was aiming to be merged and I've stepped up as there was no single
review at the time https://lore.kernel.org/all/Zctfa2DvmlTYSfe8@tiehlicka/

I admit that I was really open that I do not like the solution and I've
said reasons for that. Allocator APIs have always been a large mess of
macros, static inlines that makes it really far from free to maintain
and alternative ways should be considered before going that route.

I was also clear that support by MM people was necessary to get this
merged. I have explicitly _not_ NAKed the series and backed off for you
guys to gain that support. 

So essentially there was a clear outline for you and Sure how to achieve
that.

I would really like to hear from other maintainers. Is tnis really
unacceptable maintainer behavior? I am OK to apologize but the above is
in line of my understanding of how to ack properly.

[...]

> Next up, PF_MEMALLOC_NORECLAIM over Michal's nack - I was wrong there, I
> only did it because it really seemed to me that Michal was axe grinding
> against _anything_ I was posting, but I still shouldn't have and that
> was more serious infraction in my view; that sort of thing causes a real
> loss of trust, and no I will not do it again.

Yes, this is simply unacceptable! Just to put full context. We are
talking about eab0af905bfc ("mm: introduce PF_MEMALLOC_NORECLAIM,
PF_MEMALLOC_NOWARN"). I have pushed back on that https://lore.kernel.org/all/Zbu_yyChbCO6b2Lj@tiehlicka/
Rather than searching for support elsewhere you have completely bypassed
the whole MM community including Andrew and pushed that hidden in
bcachefs PR. This is breaking trust model we are all relying on.

I am cutting the rest of as something that is not really material to
maintainership discussion.
-- 
Michal Hocko
SUSE Labs

