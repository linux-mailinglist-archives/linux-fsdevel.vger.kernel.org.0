Return-Path: <linux-fsdevel+bounces-14362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBAC87B351
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 22:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD53F1C22B72
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 21:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8B4535C4;
	Wed, 13 Mar 2024 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UwDz6jw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AA4E1CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710364542; cv=none; b=NLTqgOMQj7d9wdZLsPRN5MiOw0t1kni4+skr9m2/hecBjHPv/L+jeL1GeqXx15Z9jum2MvxxVAdjI9wr7Q9aReV1h4FQ5KwonzWQs+zW2RJgzBD26T3OyGGsjYer8xWre1rYSZQOIfz2QyyA+o7VOKJDNWYj2hHjDRACs44GsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710364542; c=relaxed/simple;
	bh=ugrjwLUhJosYkEtgIGhX/p/DQALok5E+Ftx7SV2UNOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YaND8jL80CPIA5lFpW8GS1ZHYv3mM7rC+B6jZUK78Sb9ANtQbJKSVnbcSn7xw6gt3LhHCBTXxKAtnNDNzjpOUjN52+x1hkKjqhBzeFXmoGemBXmrYkUll7DCRiDnTYnL9AGDOk9llLr4oxVfmBaXBY4CUC5uu3dWeai8QJLnkek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UwDz6jw7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45ecef71deso33474666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 14:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710364539; x=1710969339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMHYHzIzTJ3BOt9w5/3bQTbxdRDqrqqEs+aJX8SVdWU=;
        b=UwDz6jw7tx+SfQK5O9TRElRVr8xUwxRGn3uZDwwqZTrBkRjaqUmSJIdo6cGJGJA++5
         sZTMnvwI98Adx6wuiKlPP/T2qMB8bv4/KtsYdS8X5kCIcRJY2JQDzhHR+FzmUz1H77fq
         yxmFlruM4E5Ca8HldNAlAA1h7u5Gcayn83/vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710364539; x=1710969339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMHYHzIzTJ3BOt9w5/3bQTbxdRDqrqqEs+aJX8SVdWU=;
        b=LyibGz1G7sTL4yT1nN0HK9tT9gbT58s4qfgNxE+eKX32GelSQDvX1zGUBnEqM7CRAT
         yK0MvlpaMXI4dDZ7+hCTHvvNskrmphVlqgUiJ7ce2dc3lusZ2PvqKmeEgwE69u9dMyMd
         3AMdzSPtc48sHgNNm72iTfjTr3BFPH9jP5MJQaPFHvKATdWrPJZn/0UBi/PnGMH9R5TF
         LPvxIz1Pd4t6D8kYKBZyEGCz8LRqpPVZFN02m65xru+Vt8tmkuKTNwspu4muCoM1e0sV
         4jnw0Y8+62s1iTJDbbeoDRm+mr8TyojlhEFzR9XAMdeNYUwFWFm2loUgy9nftLSfwx/j
         EgSg==
X-Forwarded-Encrypted: i=1; AJvYcCXjUvhdUS4rP4bLcLCfjLO05lxINkgWXNCS+5vd08dkZBO39SWKI5SDGYf+N96JRBf7yh4nvM7Gw4apzYpY8Dm1fTpO+ssywhFXDj2uUA==
X-Gm-Message-State: AOJu0YzSi4MwIE6Buhl2lZhLsb8DJxIxfgKPxveFSWRhaYlxtI7xNq9x
	y3h2UFgNvglfE7cIKQQeUUiwJovQPBhUSjFftMnValyUZd4eL6Z9SEK5nDLsXNj4ATR1q9aJkzO
	QI9UuQA==
X-Google-Smtp-Source: AGHT+IHumlnQcUoZiV+Ucuwr8y1lHYsGUk1QT4bApl7ob1Z4qz4O/sOXwzCbSTyoVdDgICpwI6nVYQ==
X-Received: by 2002:a17:907:a642:b0:a44:4c7e:fc07 with SMTP id vu2-20020a170907a64200b00a444c7efc07mr4980694ejc.0.1710364539198;
        Wed, 13 Mar 2024 14:15:39 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id sa37-20020a1709076d2500b00a4635a21ff0sm24090ejc.38.2024.03.13.14.15.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:15:38 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568967ff66cso375703a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Mar 2024 14:15:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8QztDZXlBhuYlBKMMYI31fSP5MN+JmySRFHZHf5isp8CB483vmlwfWMWcMMfp++qa67eF4tywnQ+WIkCeOIEOSiVT/23ZeSRwQJRlqA==
X-Received: by 2002:a17:907:6b88:b0:a46:6f89:5585 with SMTP id
 rg8-20020a1709076b8800b00a466f895585mr52537ejc.23.1710364537834; Wed, 13 Mar
 2024 14:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <87sf0uhdh2.fsf@debian-BULLSEYE-live-builder-AMD64>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Mar 2024 14:15:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtRUwd+9aAJ1GGq3sri+drsfArbtsrTuk9YxJU+ZGO5w@mail.gmail.com>
Message-ID: <CAHk-=wgtRUwd+9aAJ1GGq3sri+drsfArbtsrTuk9YxJU+ZGO5w@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 6.9
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: akiyks@gmail.com, cmaiolino@redhat.com, corbet@lwn.net, 
	dan.carpenter@linaro.org, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	hsiangkao@linux.alibaba.com, hughd@google.com, kch@nvidia.com, 
	kent.overstreet@linux.dev, leo.lilong@huawei.com, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, longman@redhat.com, 
	mchehab@kernel.org, peterz@infradead.org, sfr@canb.auug.org.au, 
	sshegde@linux.ibm.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 23:07, Chandan Babu R <chandanbabu@kernel.org> wrote:
>
> Matthew Wilcox (Oracle) (3):
>       locking: Add rwsem_assert_held() and rwsem_assert_held_write()

I have pulled this, but just wanted to note that this makes me wonder...

I think the "add basic minimal asserts even when lockdep is disabled"
is fine, and we should have done so long ago.

At the same time, historically our "assert()" has had a free "no
debugging" version.

IOW, it's often very nice to enable asserts for development and
testing (but lockdep may be overkill and psosibly even entirely
unacceptable if you also want to check lock contention etc).

But we've had a lot of cases where we add lockdep annotations as both
a documentation aid and a debugging aid, knowing that they go away if
you don't enable the debug code.

And it looks like there's no way to do that for the rwsem_assert_held*() macros.

I looked around, and the same is true of assert_spin_locked(), so this
isn't a new issue. But I find it sad, because it does actually
generate code, and these asserts tend to be things that people never
remove.

              Linus

