Return-Path: <linux-fsdevel+bounces-8753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F171983AAA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1657288B20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3839A77F20;
	Wed, 24 Jan 2024 13:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKXm5GBv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65577644;
	Wed, 24 Jan 2024 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101718; cv=none; b=X7be+80Q5cMg9l7D2sGQnHGJlOtbHB2DzBRrxSlB3JyYc2DBzHThMHy9KQsbKorEY1LQtE3665/76ioPRBaqSFwaKZ72p+EGwiNl0g9pcErqy6phz+XxegAnSMqD60PTKLPR5trUazb5tJKUr0uO3ddE9lxiH1jPa4amT4/Nams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101718; c=relaxed/simple;
	bh=aHkdkNoScrk1SN8G0CWq7jpLwpFto/N91v8whUSKvqQ=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=byIVT6GaxALexzwqSYPxhYefOCYlRsd958rsqwNty4ZFErpiA+xQ4RAHOPGFartEXOC747+HggwUgxlRdQ0Rghvjd3Lr2MxuIT5Jf+aeKZRAkQl8sR+0pEXp55yNScXrlpILMb73J5RPIus8e9TdXVaj61v+8QoEi5rdugzN76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKXm5GBv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d722740622so6727205ad.0;
        Wed, 24 Jan 2024 05:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706101716; x=1706706516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KUI/eFvmS+XloVvjaOrWB9BVgbO8O7S1IW93a0Yo70=;
        b=iKXm5GBv3FJ1C9edLLty84A+xgEEQNNtqHmWWKkmLGNllEbA74w+74595HkO3M9+a3
         2vmoUTqh8X81W2d3s5aze+wZlC9U5wFJri2108JkwHhL3iQ34tPWLop12xtusITJmj2x
         LtNOA/+OIaMFe8zkm60Sbru+qg5i343bh0wPD97nrV165/7c34/zjc2JehuwkQhunLEl
         yxEkhqAEI8DPDuNG09HtOi3raIx3hmRR/OsvJxxWzXvN/NQvlgkhT1GJn32A+Wr6LmFk
         EldPlja96UDYnW3Y8mi+JGSWcZ3H0jQSG0PdT/tk6SoT3JbG75/6ki1DfQnuwIvP83Az
         RWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706101716; x=1706706516;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KUI/eFvmS+XloVvjaOrWB9BVgbO8O7S1IW93a0Yo70=;
        b=JohYkQez1854wrI8aW1xWYHqCLFJtrgScvlX+Ett0vJ8VXbl+XsK1lpTSzPaCgnroV
         vHZp64XX6MLG6Xn7GB2pYMXrh7lEisrOAVTzrsWke2dIxw70pGHBszBnla5CF7PIOrER
         jIz5G0zP17bf3gW9+BOSDbBfKe5Mj+eMTsrQH/0dOH3eDKG6k+U4/GixmvnAw7XgfrI3
         Wi7INNr1Bb68OrRubmC5oBytZCiMBgtkgLy8kZPAiyZrr+/vKMqnktwKoVUUnpiNvmmo
         elyM8MXhYTUsqzgvqq8Jjs6LkgwlrOGmmXLBuIkcdYcyxZpu1dTHAnsNTI8sCp5YHQTP
         NyuA==
X-Gm-Message-State: AOJu0Yy24MaOhc1bRqn3QkJhsqFYgsPUlJVtnXlvCppHlrzxTVcAUkkF
	tNs1yIfpJpu6MsCLe5wLWxjc4uUZaPq8HMvWG8Kc8kGGGa/uZQOX6qyDVOpmdMk=
X-Google-Smtp-Source: AGHT+IGKs2U18paUHaNW9mzKIy+5JGwDXqWv/uc583nLBKMxL7U5283eG8t2WUCyX0hT/tU0JGMKwQ==
X-Received: by 2002:a17:902:ed44:b0:1d5:76b5:49a9 with SMTP id y4-20020a170902ed4400b001d576b549a9mr2265799plb.4.1706101716395;
        Wed, 24 Jan 2024 05:08:36 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id kl5-20020a170903074500b001d72d445778sm7127275plb.204.2024.01.24.05.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 05:08:35 -0800 (PST)
Date: Wed, 24 Jan 2024 22:08:35 +0900 (JST)
Message-Id: <20240124.220835.478444598271791659.fujita.tomonori@gmail.com>
To: kent.overstreet@linux.dev
Cc: david@fromorbit.com, willy@infradead.org, wedsonaf@gmail.com,
 viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, brauner@kernel.org,
 kent.overstreet@gmail.com, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, walmeida@microsoft.com
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <zdc66q6svna4t5zwa5hkxc72evxqplqpra5j47wq33hidspnjb@r4k7dewzjm7e>
References: <ZZ2dsiK77Se65wFY@casper.infradead.org>
	<ZZ3GeehAw/78gZJk@dread.disaster.area>
	<zdc66q6svna4t5zwa5hkxc72evxqplqpra5j47wq33hidspnjb@r4k7dewzjm7e>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 14:19:41 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Jan 10, 2024 at 09:19:37AM +1100, Dave Chinner wrote:
>> On Tue, Jan 09, 2024 at 07:25:38PM +0000, Matthew Wilcox wrote:
>> > On Tue, Jan 09, 2024 at 04:13:15PM -0300, Wedson Almeida Filho wrote:
>> > > On Wed, 3 Jan 2024 at 17:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> > > > No.  This "cleaner version on the Rust side" is nothing of that sort;
>> > > > this "readdir doesn't need any state that might be different for different
>> > > > file instances beyond the current position, because none of our examples
>> > > > have needed that so far" is a good example of the garbage we really do
>> > > > not need to deal with.
>> > > 
>> > > What you're calling garbage is what Greg KH asked us to do, namely,
>> > > not introduce anything for which there are no users. See a couple of
>> > > quotes below.
>> > > 
>> > > https://lore.kernel.org/rust-for-linux/2023081411-apache-tubeless-7bb3@gregkh/
>> > > The best feedback is "who will use these new interfaces?"  Without that,
>> > > it's really hard to review a patchset as it's difficult to see how the
>> > > bindings will be used, right?
>> > > 
>> > > https://lore.kernel.org/rust-for-linux/2023071049-gigabyte-timing-0673@gregkh/
>> > > And I'd recommend that we not take any more bindings without real users,
>> > > as there seems to be just a collection of these and it's hard to
>> > > actually review them to see how they are used...
>> > 
>> > You've misunderstood Greg.  He's saying (effectively) "No fs bindings
>> > without a filesystem to use them".  And Al, myself and others are saying
>> > "Your filesystem interfaces are wrong because they're not usable for real
>> > filesystems".
>> 
>> And that's why I've been saying that the first Rust filesystem that
>> should be implemented is an ext2 clone. That's our "reference
>> filesystem" for people who want to learn how filesystems should be
>> implemented in Linux - it's relatively simple but fully featured and
>> uses much of the generic abstractions and infrastructure.
>> 
>> At minimum, we need a filesystem implementation that is fully
>> read-write, supports truncate and rename, and has a fully functional
>> userspace and test infrastructure so that we can actually verify
>> that the Rust code does what it says on the label. ext2 ticks all of
>> these boxes....
> 
> I think someone was working on that? But I'd prefer that not to be a
> condition of merging the VFS interfaces; we've got multiple new Rust
> filesystems being implemented and I'm also planning on merging Rust
> bcachefs code next merge window.

It's very far from a fully functional clone of ext2 but the following
can do simple read-write to/from files and directories:

https://github.com/fujita/linux/tree/ext2-rust/fs/ext2rust

For now, all of the code is unsafe Rust, using C structures directly
but I could update the code to see how well Rust VFS abstractions for
real file systems work.

