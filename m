Return-Path: <linux-fsdevel+bounces-64102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03699BD877B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 11:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45EDE4FAF50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF95D2EAB89;
	Tue, 14 Oct 2025 09:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNYjkkD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EB2EA723
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434619; cv=none; b=S6BVaPwp6z/t057YNkjRXTJ7yh56cbGQRXK1kez/SnYLNDiwdXJTU8Hcam3Hx71O6/K7+TFTXB+3uzZrDHVs23v6n/GN2d1LsCZQgLKaHQTof/RNV3JKrogaM0rxSPTlHAolgC32XMZy8S2NcBKrFy/fq5CxjqBz8ustJjMQBZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434619; c=relaxed/simple;
	bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQ2ZssIHYTUXygQGKa07OMqeNXMHNs++5bun/Cs0w1RgC1JVorYz/AOJ5BEBiTV5bbYYwgDpsRUJ3mUJyi2RcLSvnfiu7J7wATfVWv58OlIgS5xXXQJmJuVfSwd/fga8dXTSrytlIy6APM8MmNPYJ8ndRApNe1ZpjR9pCEvA6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNYjkkD8; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-780fd0da0e9so5485797b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 02:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760434617; x=1761039417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
        b=YNYjkkD89fE9uFrJj2npIIPp1FynS94tHd1kkWJHGG4nq5uQ0RPZcOOUbBPe2hSOjM
         4V3GWiQnej8DNhqNMLDlZHIFsOkknJKOYKHYS6Y+EaLcw+b93q+KzQL5ALo6Px2WKfrh
         RgNngJr350972IRkOBwWFD/qQlRI8/ZCLRkTsjP6EKHf1AQzSiC1xwJS10tHENsyI7Nn
         gVto4LKs8/TQbazx7ziOFLJeOljLPfi/rnH7wxgVsGwVxVzJuir047LukK0VUcNjQTzT
         LgGbUHIBzpxyjnQbEhlyCU8Xt6hW/qxuGSFJKMPb7IAcWKEQn+W3vTUXEPp6ZQA1FWhx
         L4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434617; x=1761039417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=glShDIg1aywHSoIVDslh1hsbrjXNgLMkJL1dNWhaR/g=;
        b=j9++W/apVCwNIJmMf4N0QapZbBKvmO6L7L2TGNGupPL2ssYN3xfGrWiCFXqdRiZSPn
         tsvRjncjBGYPilTEaihajXUxzOyuaCzvpQeEI5hFJepaVF9v3ufoJJNuV6rQdgZayma3
         AVsrKjxdenEeLnu2jZA3vjpK5p531cxH+rAVwW9eywJIXYNqaCJ12cdlOELzUIb5JqFG
         pEbglZPRHHDpqtq6lczoBjWn0hxzOlOPhbT3go5rnp+JV1qvXemVoz5eJ5FvLpr3iauG
         XTeRSxL0BVxqXm5vC025J+bh7L5e5jEkvfWFOW7dg1/dZwZwJH8oZu9qBSFvM3gAZQUv
         3+pA==
X-Forwarded-Encrypted: i=1; AJvYcCURkkqxyZh/7XvgSc0oYFz42dDJEodQRzvZgsC/LSmlKRQFIWEW1AEvVui83fHlk5l2Fgq1JSnnQqcfRZl1@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxI3DOE7ub+o+FL2EZDUy2YlpRUSt0Y56UZMjk4OWGbcC/W7F
	8V0Lou9bAN8mHT10iXpUuX/CVYJZLqBXluOEVKB/fG6VbUgL1/o+VGnhOHZPxmVot+2LThXQUsB
	xuvJTgCFmvVtV9toYMqn8QiFyldoiSZVJLhmtN6jeSQ==
X-Gm-Gg: ASbGncv6MpXGwLxZEu582qOqm5HnTGag0hpHT2DrDqiYlJAOVfp+BOshgrUWmxPWXb8
	a5DYz7pUcW7NOWM3jx6IPMWQzjPytqgCzRcoqoYdd3q2rcwklVxVqKirH+NddHxPTFIihaERx+4
	R/a4B5YkZ+cEAtCf12ZYuMwgVLcXuKUR51kg468yTBq9QDdUN2hw/phJGsQdL5yGSHOexaUpptW
	W3Gkh8PTnUYXRT4BIn0EUJ2
X-Google-Smtp-Source: AGHT+IGoAlQ2WFaEYeTOAIe9c4Elf37z78F9EHmjUwLc6pTpWC+0i0M7nVQiV8n3OzJB4gzdKZLAbVWmMRia7P3rC8s=
X-Received: by 2002:a53:c985:0:b0:636:d528:7e9 with SMTP id
 956f58d0204a3-63ccb8c3891mr9629921d50.5.1760434616695; Tue, 14 Oct 2025
 02:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com>
 <CAJnrk1YRNw5M2f1Nxt619SG+wUkF+y2JrMZZCyLqWVd59+-gjA@mail.gmail.com> <CAJfpegvt8Z4ftmQ37ptD8gQu4CHCUB1smxxTgngNpRaDm5=1dA@mail.gmail.com>
In-Reply-To: <CAJfpegvt8Z4ftmQ37ptD8gQu4CHCUB1smxxTgngNpRaDm5=1dA@mail.gmail.com>
From: lu gu <giveme.gulu@gmail.com>
Date: Tue, 14 Oct 2025 17:36:45 +0800
X-Gm-Features: AS18NWBKJYVvlubLST1J_RXyTAxEWJptrylpRY2GHtHNw4S87NtwN5lKcQFhZXc
Message-ID: <CAFS-8+XXdupsG7E3riggVEffSfaAw0YndfsbmcdbQqFaKt8PCQ@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

> > > Yes, reproducer has auto_inval_data turned on (libfuse turns it on by default).
> > >
> >
> > I was more wondering if the problem goes away if it were disabled..


Yes, I tried commenting out the invalidate_inode_pages2 function and
ran the LTP test cases in a loop more than ten times, and no data
inconsistency issues occurred.

