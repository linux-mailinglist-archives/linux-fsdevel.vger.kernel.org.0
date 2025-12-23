Return-Path: <linux-fsdevel+bounces-72004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43021CDADED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C617F30456A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 00:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB530F7FE;
	Wed, 24 Dec 2025 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmDV2L8C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD67303A12
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534408; cv=none; b=HTnwsPo6vG8nzAAskLu+a2FiznTCqWz/xF1+YcsQWPsmXHz81Vo11iRHHt9kL+NU9IGzuO2jBiZ3fiBjbN4/ExsdVuM6lN5BqAED/LIsuV88FHpgxKI5qovYJtp3OhirGqx/EOgk/cCG5+mzis0vy7IcRKfQ98sV3/vfH6lAfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534408; c=relaxed/simple;
	bh=B0nckleMWq7UsqEXq2mwjwFnjis1yLN+CnFFCYaxwpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W5BHKdWcNjuaG8H1JCrh6x5MyPDNjb/sQepDPkWg7XN9O5U6KqQnOZy1ZBijuUQyYiDLsWcPJ4PV3FrurC+g04mUdsjTUZNRqNX4LZw2b3XVhS2ZEr5LwKQCsbdnvSwHxfwlx4AQtlxzPAlR3B9rvJUkpHZ6rfqx9RkaXAtTUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmDV2L8C; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fba1a1b1eso57833997b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 16:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766534406; x=1767139206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0nckleMWq7UsqEXq2mwjwFnjis1yLN+CnFFCYaxwpY=;
        b=GmDV2L8C4DeOWW9pe5e1EheNzTyZnt8HZE3K50gEdlf1gCsfi3Jau89ilNLiA/mXpR
         vZd7RfZGeEa0GGfeDGinU6vLOwBajt+EeetmdWHcv8qUPaLKrGKz5Kl6o5yllcGSfNHS
         T+fGbgHzjcz+JkHbXhq/5DQ5c1GDv9PyS0eqoLT2Io2FCuYY4JUl/WWwM8rdw3xtGzUO
         DKg9FZJzGnULgqgujlTiZhowtHg7TR7iOr1p6KWwuvWvvGkOs3u0n4QrWUrbT+LVBpu0
         tYoKd0eU9rooAay4bGovRRicFD1dsD2PubREy4HMDR9RDkhbAFpO+QxHh5WLBYVVDB6B
         LgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766534406; x=1767139206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0nckleMWq7UsqEXq2mwjwFnjis1yLN+CnFFCYaxwpY=;
        b=bMHMqsJfITZzeg6h+MDt8QTl50806L8QoXv4J6rgnRaXtgJbElptNaqr/Jr12ynK4C
         QprAeiJOT5sFX3tMsXbXOF/+DfRMd9E1uWVy2h+nUbo3ycibnB5uCPSb/RJoVtnj10UV
         HJiu976Ta288bAmjQTE3s+jgQRQoqVeNDmlMrJHyLxdqcCGqwVla2afaePgJtAzQFKWd
         A3dqQw3Eo1GH1MWeyPInWQMMWWc1weMUXuObIb5EHZeVqpwC7a2MuWtEh6CKqE7wo9w9
         yCcp4K9l9rxOFtrFn8H0//NgYMyM3LAhMsfrXGOwUL4ZgGo7Mz7TsJc8nTx6vayh8hmL
         TFGA==
X-Forwarded-Encrypted: i=1; AJvYcCVMoOFtzqLeWg4fq5dWcDj5Oxfsn0eGe3ILcBle54qbby44SWgq94QPxo+MYilx2Ogt9HetnRuUPcNjLQ8x@vger.kernel.org
X-Gm-Message-State: AOJu0Yz01eh8ejWaUG8ORQ/UouTUaOgEo2GhjjyM/BMkgDEdi2v+BkC1
	1mv4P7+Q2eOI0qTi3og//wIzJ/4ivFSuEZ7KxJpsP0aLtTN5U+z6IiS7x9Yl7iXUZUIcbSpK28B
	DLH22+zWlG7h0w2Su5MTSRaqHPTf6iYA=
X-Gm-Gg: AY/fxX4kqLzlt9ZlO2FjXpSxr1758WC4FbzHqQBiGnbBdZtGrppFYtpxARbecXjwrW5
	DIC7lcEPxXiQhg69Ya3aLOXinkK/uxlIvLPe6n2WaqD4AR3ilWF4PQkBPzeOL9JRyAmBiaTxZ8S
	xVZlSOzDrqUr8dhzxUZexWkvrWvn6jAKCQPtBWsQJSRahBVtj0zjZWo9/wyJdWN3eURn15K7Cu3
	9Rq8R4/CA26Ee6ISVQvnRSCPvSBv9Kz+AYbMVTQrgc6kO3wIKEfkeDiPyh8xIq4GC+2+1w=
X-Google-Smtp-Source: AGHT+IGrhx+M5D1iPAq047L/VfbKJZxNg/dmAvrPfbeVw0cZG3kBS4xxyQdVxQF4ZbdvM2AlY4nj7j6vFcQmzKr5F44=
X-Received: by 2002:a53:c048:0:20b0:644:59ed:dba3 with SMTP id
 956f58d0204a3-6466329bed9mr11883498d50.30.1766534405824; Tue, 23 Dec 2025
 16:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223173803.1623903-1-topala.andrei@gmail.com>
 <20251223175128.GC1712166@ZenIV> <CAF8SvsB0yQC7Meni=UQEehaT5YBQx2uEas8irhg3vWstdM_JVA@mail.gmail.com>
 <20251223185926.GD1712166@ZenIV>
In-Reply-To: <20251223185926.GD1712166@ZenIV>
From: Andrei Topala <topala.andrei@gmail.com>
Date: Wed, 24 Dec 2025 01:59:29 +0200
X-Gm-Features: AQt7F2ok3FzMNEq8jfRGaScbOsqQPfYx1tvR-ZMTlcc4iCLVl-Vz9OfToP1ETA4
Message-ID: <CAF8SvsBriV4NFbDo-REyke1FSRUaiQ-SZ+gMYVKfzF4BaAthOA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow rename across bind mounts on same superblock
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Consider fun with moving a subdirectory of a mounted subtree to another
> mounted subtree, while some process has been chdired into it, for
> starters...

I see the same situation can occur when renaming through the
underlying mount. If process A does chdir("/bind1/subdir") and
process B does rename("/mnt/fs/dir1/subdir", "/mnt/fs/dir2/subdir"),
the rename succeeds while process A is inside.

I understand this patch would make it easier to trigger for
processes that only have access to bind mount paths. Is that the
main concern, or am I missing something more fundamental?

