Return-Path: <linux-fsdevel+bounces-57391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49EBB210F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAAF568746A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC72E2DFB;
	Mon, 11 Aug 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mazr+Izh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56982E2DE4;
	Mon, 11 Aug 2025 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927312; cv=none; b=YOOcE31WFjsuZ5aCz+x5U9azqNJS7aIkiAbk1fYEPldovJzP6zv398ctpw90HhV3r147zLPTK7BUcFlYbVRKT7nnH21j4Xk438XYGrmZ41bGKYYEto/UnJsEvnMbu5dyBUMWAFfRSu2Y5yHWXiGmumtwyBeYBg1jehgeOd3LvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927312; c=relaxed/simple;
	bh=EBQ0QkaAv5cpHJjuhRc73J70XhiDX+eXJVtfJMjYzxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su3mqfTTE8/TA5t8is+g4Vh77UGtkw+fSX+a/IGDpbhoJYWO8JNO1xkEXkj+D1alakyuQxYZUTnQm7LwXPJgGzQLnPaw7+F/Zk8xf0+fxWDw2m+U7zhUvRZ+Sdg0vPARVKOTdib5iLPRpaRIKOxtLrvQ730lLwtrB48lW2Xxt4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mazr+Izh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b07275e0a4so56639081cf.3;
        Mon, 11 Aug 2025 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754927310; x=1755532110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBQ0QkaAv5cpHJjuhRc73J70XhiDX+eXJVtfJMjYzxs=;
        b=mazr+IzhE9mY3E6y1szjJ4hkvhroPZ/ZUF/H3mO2+5/7jfXD8ii1joVo5aD2U6V7fj
         jAhY5vSuGpVGaCumTIko7IXynKfYGllMbYy00dshKUu5gxeC1cY0NRPcipZX80Dh0ur4
         fZughJFRsVfJJJEMxLdVFNe7w2Fc0oAi0Ea2JyFP6Rhxwtn/zuLUfzLFpT0hiN9XHd3+
         rsazR6qeFfASxBHJj+zJb9I0wNVG6NhCkNnFuq5ZoDbNpYh7RBMjvGS5P6+R0XHP+SMR
         R/CU6ZBdlTWaN2+aBzlbeL7bbfzidZbuqSwI3lozEC9Hvev144N1lRrxp0ifiZ3mSPde
         dtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754927310; x=1755532110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBQ0QkaAv5cpHJjuhRc73J70XhiDX+eXJVtfJMjYzxs=;
        b=bLzoUK2d+5CxF+qMFUMAtgQ1mWfWH3sKqIVpZCIq7tlDsM49flm4zsg+5SjEt4a0S0
         v2NZ2s+iVn29o2fpuFT5G0/xOHaE3V/V+a3DNPw4ZdYc9IWEY5YjWBz6Gnz02AtN4CWD
         6d/LzqYN5um+b96dgqcDBPTSng5EYY87bIIyFJ1YpaqzeuLWvxYv6afHxK21es7nk6ur
         +nlk3Q0mSc8navFx93JOZyt2yR4ln3hEraHCLBIZsWs5q2R9uelp6GwRy6Y/5lt3jRQA
         M2ku94CIM6qXo3Ao8GX3nYu9aq1ngwMhDXf2mz2j3LiEl62YtePsjHZ0zBgX0zIbDYps
         Mtaw==
X-Forwarded-Encrypted: i=1; AJvYcCUCOiIdKoGc3/EOTf3uWa97LPASxJm5WvGP3Al/TYERwAy+cipTPJ4BLP+nSlHJHI/zBUhaNFMSA+qje6BBGQ==@vger.kernel.org, AJvYcCV09ddUDoKJOZIMd8gTZ5FvJAPp52EnZiAZAABM8dJJCPs5guifFuCS/mfaOpW/4Fsd2LUsjd5p78MvZrZS5Q==@vger.kernel.org, AJvYcCWIRVe33xGEJGbFCN3wWTtH9pIo7e0PbBAUYDh5O7zFRJNRIzs65np4XnX0pEfImhqX4eZ7gVfzyXDOgkfV@vger.kernel.org
X-Gm-Message-State: AOJu0YyRoSq9auXE/95Jt7UQbqx2QNlN5HDU3XIlBVSTtkiZIi0m9u5E
	M5bY4wmgVpc7jzSdbBYj2lSkDGdNaG7UDd1IMs5vZrMwH6kSepTSEVWK
X-Gm-Gg: ASbGncsROmfNYR7WIFkpiMX2OMBJSbrTeZ9escvR2M9Ua8SNTsAp9F4yfYZ3PY+B/Ki
	T9m2BHFbQZjh9btEGtf9EJEvBmi/JFwdvWNvNVWgpLYmLHXnbi0vpdV25064+gTtZ9Vzw7gRAFO
	TEv1AeYUMQ7p9ygcozIFBZ7EuUzj+mcaKfwcG0MCmY0BzJ9Jrenua2/pZ8HnJK8+oea2/V0BB94
	UXmwncKU9Z2d1Iba6xnc7a+6puFdOaIPUeR//hzM41XzdKFb3W+toJrcg0rA93807w72Iy57794
	YmQsAHCqmV/tjW0oLFg3hHMUbvjTQMGrcghaxKterxjaW8U0Op3hI6c4/bOWF8W7HLcS2ikTPPc
	nlMr8pkSOL7Q=
X-Google-Smtp-Source: AGHT+IFdnUv9qrJph7Hp7SIOe4NCYWKaM41QyCXBms9PdRcOtfMYS3QZKfUivI3rFW5GtngByCEfxQ==
X-Received: by 2002:a05:622a:4c10:b0:4b0:6205:d22b with SMTP id d75a77b69052e-4b0aee3af76mr176061101cf.52.1754927309493;
        Mon, 11 Aug 2025 08:48:29 -0700 (PDT)
Received: from mambli.lan ([2600:4040:523f:fb00::254c:3ef2])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4b07c80ddbbsm94537841cf.57.2025.08.11.08.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:48:28 -0700 (PDT)
From: James Lawrence <jalexanderlawrence@gmail.com>
X-Google-Original-From: James Lawrence <james@egdaemon.com>
To: tytso@mit.edu
Cc: admin@aquinas.su,
	gbcox@bzb.us,
	josef@toxicpanda.com,
	kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	list-bcachefs@carlthompson.net,
	malte.schroeder@tnxip.de,
	sashal@kernel.org,
	torvalds@linux-foundation.org
Subject: Peanut gallery 2c
Date: Mon, 11 Aug 2025 11:48:26 -0400
Message-ID: <20250811154826.509952-1-james@egdaemon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250810055955.GA984814@mit.edu>
References: <20250810055955.GA984814@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been a user of bcachefs for over 2 years now and I must say in that time watching the drama
play out in the lkml most of it isn't coming from kent. Interestingly like ext4 its one of the few filesystems
I have *not* had to think about while providing far more functionality all while marked as experimental.

What I've found most interesting in watching it play out is that the criticisms of kent are rarely on the technical issues.
its mostly 'how dare he point out the issues in other file systems', 'how dare he point out issues with the kernel's engineering processes'
as if that is somehow unthinkable. Are we not allowed to critize poorly performing systems and processes?

Isn't that *precisely* what engineering is all about *improving* poorly performing systems? Have we all forgotten this? How about instead of
complaining that kent is critiquing your processes, fix them. address the actual critiques. its pretty hard to critique something that has been resolved no?

linus if you dont like the timing of kent's pull requests just ignore it until the next cycle, no one is forcing you and kent certainly can't.
It'll be inconvenient for those of us downstream who absolutely adore the fast pace of the fixes kent has provided when we run into problems, but we'll survive we went in knowing
we'd run into issues and if they're serious we'll work around the delays caused by upstream in our own way.

If maintainers have actual technical issues with bcachefs, then they can bring those up with some ideas for solutions. they can bring hard evidence to the table and
not 'someone said something about code i work on, that i took offense to and then did nothing to address, as a reason for their code existing'.

I would very much like to see bcachefs remain because its been a breeze to setup, use, and maintain. Backups are a breeze, I can safely mess with my entire
system with a single command to produce a snapshot prior to starting that is basically instant. Something that previously required an entire esoteric distribution ecosystem dedicated to immutability to accomplish.

And since other FS maintainers are not stepping up to the plate and improving or implementing new filesystems to address their own featureset and branding short comings,
I'm not terribly interested in what they have tso say on the matter. And neither should you linus, let them be upset that *experimental* *opt in* systems can
(and should) operate under different development processes. I certainly give my engineers/researchers a ton of leeway long as their work is opt in.

And when kent is ready to take off the experimental label, then rake bcachefs over the coals as much as you want to make sure its actually ready.

Until then maybe consider not making your own life harder by trying to gate keep the development process for an actively developing entirely opt in/experimental system?

Apologies for bothering everyone with my 2c,
James Lawrence
Principal Engineer



