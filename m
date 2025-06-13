Return-Path: <linux-fsdevel+bounces-51619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1FAD967D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657F7189615B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 20:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60F724E4AD;
	Fri, 13 Jun 2025 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLljrNwW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB21EEA47;
	Fri, 13 Jun 2025 20:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847002; cv=none; b=QHmGMBX8gJk2UHimLpKjm0Tlzu9tdtEajiJaAsztaT/+1LE6/cXdKpegO5Cs8UGissoiXu3AngOquJbqYDABar0d3CFFpzEX4/9x9eMe9RZQ6+qR9yVW1TDobmI8212G+l3Wczwdo6jRyXm6j8M5BE4CH5AqWuTvLH3N4PG1x3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847002; c=relaxed/simple;
	bh=NnH1RCLj13aA3sFjZVykyMDY+HQb1oGS1X8FV4CU9bE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/cip1KWdtfjiDzA8rmeSdx7V90yydoE7/ie6FiT30kebAfDwE80+QCjkF7oEiFuttPFvKH7Xahep0i/Eh5Cl1JcJQoAyvvGcZHMRqQE7d8RosjQjBAB9X49X8LwLaCyBeQ9JV64eIP8MegCEh+KYBcQlQrs9kRZQLrGtwL/Yrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLljrNwW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-afc857702d1so2218364a12.3;
        Fri, 13 Jun 2025 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846999; x=1750451799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y/A/honPhmFr4lSoVYSv+uKbj6HRcW5lWe22QcZ78E=;
        b=RLljrNwWVQvbkbBCrRFGN0BZSFzc+UUlGjKTsTJSxpSfJurh2duBM8fTuItDZLH0uf
         R6mJVd99BSiVUtpbKME4sPYt7SEQ93R4DMI0gPwejfjztCWHEGkLxfq61McF6IV7y1Zj
         DKaGljXDUoHYLp+m8GoAenmfzkPOTiTM+rd/VP02gZG5QKjIO0SWCWQynhiPmeAsgF+F
         iZ74KZ+WM7Y7L0CJNd7QnXWMbvRdd9wzyJtUyJFkU3EeCQXR+EmjpbSE8FfR3KK/p+JQ
         oUawnrwtBnftztlY2ePwOcb/YfGQ/yWqUQ6p1FN3e8HMUfgPzzReRtzv/XD7Qw0N6Kfs
         lssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846999; x=1750451799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y/A/honPhmFr4lSoVYSv+uKbj6HRcW5lWe22QcZ78E=;
        b=L6bR2pvO7FB2eqZjEq8ckaINI+C7FnNR1bl9UoJTFFr7tlE4qcVz/MJv3QdJ3eemFu
         ynYGDHhXFYyBZT23ULxStSCO/1SCViLM6+vAH3L3WNDibmjMgQ0EHQ9m9CKF6W4HmkSp
         YV8Gna5YJV3qfTfo/Bmrk89NcJhOeUjZk5FHnnT9pZNF91723Om9PK5MHu3tNpeiNdFu
         QqN0oEMJDosabO4wXs45lLO6XnGjE0CiOq1TarwqiLwFp1pkAiF+OJ1J1x+A/L0+X882
         +bGa3D1YLS4MTSVAtD/0icKFj3z1OBf2BVq8BScYnswngIEF4YTYHnIvxto/SBfjox9/
         SC0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA70oOjDQdhvNbLDtXgKLDCvExCGL/aMk1FzHe3WOFvTl2CZnXQ9tvvXt+L5rBoQtEP4np46CXu/v+JtzH@vger.kernel.org, AJvYcCViAiCMXXJKk5H+QwNJYH+Ew8bxJGFHAcSpj+3q2Q2vT2G7YQ/2aQng7ogdsjUtE1fwd4yxDaoEUMd3JGofDHQW@vger.kernel.org, AJvYcCVyluA8veVHObNi58xL6GYICHP/9LY5nQ23eTSol73moGh93tLD6mzowAt8JqD2p5PeoY7SrYbjUFDlY0It@vger.kernel.org
X-Gm-Message-State: AOJu0YziMo2SklnDTdylERci/zXI1XtIxuQ5/9UqmHZ6mJKf3ah+J7/0
	o2BsCDL8yygdu09mKgkKC8FJL58pF9wtSbJSED/VDY/yiO3eiZ0MqNtDBDZgF0Tv6DATvWAUBS2
	UBaZR1s2jD/Ww8cL8sLzjMZknbELzhMg=
X-Gm-Gg: ASbGncthj6AAr1rMtzDUa2mkR2ry/UkIs737G1SvMiXun0REjkuz4m4EraOjCdYarX2
	Qcnwk1ACdO2azWcIITxXEPxZaC+ec3flj8+7S5P0x/Kc13TpF7Co/uszNCdumvhJa2wwAwn/i9N
	/RzRnzx3/39J2zUIonvq4yDUSqVCM9/1l/pAKnITs/UNAMzGD7QrMadgCnQmQ=
X-Google-Smtp-Source: AGHT+IE+doNLPK7iQGfmHK2aMnyGWiCbAU7ZVE0TGsJ4ZiOD4WmzWHJdIsobeerDU3u3LIVga2Y0ZGSbz/IF/sJwSKQ=
X-Received: by 2002:a05:6a20:734d:b0:1ee:efa5:6573 with SMTP id
 adf61e73a8af0-21fbd475bc7mr1113173637.8.1749846999305; Fri, 13 Jun 2025
 13:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604231151.799834-1-surenb@google.com> <20250604231151.799834-8-surenb@google.com>
In-Reply-To: <20250604231151.799834-8-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Jun 2025 13:36:26 -0700
X-Gm-Features: AX0GCFvv2DgZg91WNc7kjHPmacufJlE4-r5R7dF4S5nPd7EiZImIO8808EQSIdY
Message-ID: <CAEf4BzYxOfk3_dTmQY4hkx-6f+OqpCOL0agY1x=9LM08py+s+A@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] mm/maps: execute PROCMAP_QUERY ioctl under per-vma locks
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 4:12=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. While we might take
> mmap_lock for reading during contention, we do that momentarily only
> to lock the vma.
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  fs/proc/task_mmu.c | 56 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)
>

The overall approach in this patch set looks good to me! PROCMAP_QUERY
changes specifically are pretty straightforward, nice. LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

And for the rest of the changes you seem to be in good hands, so I'll
just be waiting for the final thing to land, thanks for working on
this!

