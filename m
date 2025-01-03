Return-Path: <linux-fsdevel+bounces-38366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C65A00B36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 16:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8C2164170
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DC91FA8F7;
	Fri,  3 Jan 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4hf1gyue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4151CCB4B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jan 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917249; cv=none; b=ZFZYb7ZhyJrLkUs4B4F6UURs8GM2ZVIbs5klTSHAsL82aW5Zm8gOY25aWhrxCSCHYbUNX1vM38cjcqqpg05mUQOs7fnWl8a7qDCGawXGLpbxZs6oso+rJUEgjO7HJ7oCA4SD/GFW2lkWs6fSRnuMJAELmXi8kQlptPRm9szgrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917249; c=relaxed/simple;
	bh=BOO6Mceb1cq9EWlEm8iseaAfO9VQLuFkjdeK2urpWwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt4bBrwE97kzRqQQIgoj9pQTKfSiFfJMceHuzNoKysy5+MYkPOgVBnNFQHPX5Kt8fJYXKlpZKv4m0zlUpMtADn8SLx7kdDAuEXau3iSt9G4dBHhXWDLHPpIiQ/EswsvfSj7IKrVk0P3WmhoUDAtb6dqaKCsEK8IthjcJQTqzUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4hf1gyue; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso8753a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2025 07:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735917246; x=1736522046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vlyvq3AxGGQPA6vuc5Dm8BwxgLPTSqsUU1yRCgwYOBo=;
        b=4hf1gyue7L5r7o8JEzmhaS8MYiurBwNAtFxtQhxVqGAGGLl1RZKFuGI+V/TvQT+tW7
         j7+Qy7CgN+fSAlO3UzKVaIU1Jml4voyhWjgb9Am30TZQk8yLUfrXP+IObwb3RCeWxRh6
         UTvE5P2ElK/IyKyT9byU0hNO1X16u6AuAei6flQleY+ZkxkJYts/ebiO+8QjwULqhRUC
         hLA40Hb0PxbRbaVDrXtklgzKcjS8aNlHZ1OSg1QkuL60+GWaOwiY2Yizd6UhA7u6ew2M
         ouZkoBRurP2+og9ppaWoEDg75KGWrvDJNWMUmoaZlhQqMBsdU20YAt1kHc9xsSuDHmoL
         KVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917246; x=1736522046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vlyvq3AxGGQPA6vuc5Dm8BwxgLPTSqsUU1yRCgwYOBo=;
        b=U90wFfMlPSVu6hOMtlETq12Cd+lRcoGMzQmshDZ79JWRd5nhq6zOk81Iuo/gHxWhG/
         4Pp8xBUoPSQ+rQzYVbW3zLtkNev5bz0oLMKrkaKDPA/zeTn0opjxr/06KlVUCXWmoAQt
         R2/2UK4xThFFMPfenQ53nkP21+OSSprjIDq4eIISjzNi8nbN1yT+SSRECGUT1agyOFbs
         gmjVrUfU5z+e2zsND5O2yAR2e27+9mT6+Uj3affv6lxP7UkQAdFWXjUuwD5++usoMDl7
         ISQC40unEsDVudEnoXX7HVU6lrsgjumVVyUuDr4UgtqNy628lr7BdPWwWfnYjhNTCkrX
         cAjA==
X-Forwarded-Encrypted: i=1; AJvYcCWD4bIlWKNVFD823WKIWO0mMx0wM/+H/FOHY8rieyEbysLS0DG+WyVU5JihYJmCY5oPpOTtZE6Jul/PB4+4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhpno/XQ58gZ8U2nNx1SWHSfgSgfonLS7cLV5c0yKq8E/zlG9U
	t7fa77g7Sp8aAgDR242+wUQQ3wRoUl0zW+KBl5oF5HmfjBGgkfafVdrzCNZns81fPgDijlGNd/n
	Y67MawbdMN9lvUbXoozIYCf8xDm7EchoJdKeD
X-Gm-Gg: ASbGncuqganX9BZ20eCOJcEHS9dGzDE9IOiId1YN6X+88RlobcaGF1xAV3vYvNBam9O
	Ymjom4JiWHyy1aQ4lbMHcIrZ0JTxvTwzgkR8wI2pFwVYD4qTI9Qx2+Jax8TgxnWe2DQ==
X-Google-Smtp-Source: AGHT+IEE6Z6Csv7Y7V9KFtLA++eWInL/BGHjLilU+NVh+pF3/5irTnuBYbk+Tu1ZwwcGEkuXZWEwDwgvaupqQBCYKic=
X-Received: by 2002:a05:6402:538b:b0:5d0:d7ca:7bf4 with SMTP id
 4fb4d7f45d1cf-5d9156e2c80mr71517a12.0.1735917245511; Fri, 03 Jan 2025
 07:14:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com> <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
In-Reply-To: <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jan 2025 16:13:28 +0100
X-Gm-Features: AbW1kvaGhgvt8h3xpCBpboR0oJNSmluhuHWn2o3nP9fdHRR9QmflBGC02PQRZsE
Message-ID: <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>, kernel-team@android.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 7:19=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > +             if (is_exec_sealed(seals)) {
>
> Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's executio=
n?
> I've not tested this scenario so don't know if we somehow disallow this i=
n
> another way but note on write checks we only care about shared mappings.
>
> I mean one could argue that a MAP_PRIVATE situation is the same as copyin=
g
> the data into an anon buffer and doing what you want with it, here you
> could argue the same...
>
> So probably we should only care about VM_SHARED?

FWIW I think it doesn't make sense to distinguish between
shared/private mappings here - in the scenario described in the cover
letter, it wouldn't matter that much to an attacker whether the
mapping is shared or private (as long as the VMA contents haven't been
CoWed already). But you're also right that in the scenario described,
an attacker might also be able to create a writable+executable anon
VMA and copy into that, or map another memfd that hasn't been sealed,
or stuff like that. We can block such things - but not by only
providing sealing operations on individual memfds. I think this
instead requires policy that applies at the process level, either
using system-wide SELinux policy or using process sandboxing APIs.

