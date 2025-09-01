Return-Path: <linux-fsdevel+bounces-59766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9425FB3DF0F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29860189F222
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C7930DD0B;
	Mon,  1 Sep 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="dXnHmj2r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328B78F5D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720472; cv=none; b=HmTEyyaWRmZxUbavAtHeGh9b7ChlbWcjOZlSaFn3POe0Yt9mZ0P4pKNApFU8R3wBjqq937ykFdYIUIyHssdv+nElHPlkjQO+QM1OKlcnzKw7xzmdxd1jLZmcqdMXmu8i1CrK/2TiLnmcixh/K+41B76GrTI8ZSnYy9o26cZXdKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720472; c=relaxed/simple;
	bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FPpoq0h873KCuNosYyh3xhJhtB+GGPkTIe9TOSBZzlKH2zOQL8kdg4pe+zmR5YdakYFQjoFlRhKl31TLc1LAjbzg07Ib65YW4L+Bw5p1Uoa80r1gTirMRgmFqIYfhNv8pvOMkjOkkS1fvUEp7DTHjXtzP1Azu1O3Pnp+0kgL/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=dXnHmj2r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so606656666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756720470; x=1757325270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
        b=dXnHmj2ruQ/xkdIt6xvN8ZOFV5vn3KttOEy0Zai/O9gwODsr9qAFzB8bJoTIraTcka
         gNmKu6bPouzRNelDM8eHQ4oT/ud4RXXND05tImUIW+1JIFKM36WZooAYG9JA0LqNix99
         5v7R5bgOeQQmOnN+5jWxYqdPbY3rj4H4JfhHxpMMA+GPdrj8DMmoUGEaKVq36VQP7STE
         9727yO6DUgz/oxpQuzSPa0soOYfjFbBf6LzZ2MIu3x6W7cFujKtoW/4YV20pYabI6h4K
         u8f2P9sLbX02tkQDV2WUMay9z4Va6M8FFsQvRnQ/07hjQaHlDIY7OBxYlnsxFLEYAFzp
         GsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720470; x=1757325270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtiBYuO38BwZPKf5+lGKWitSMYCT01XKTDpZYzEyuXg=;
        b=j+2R7LJGTN/zZvMthHryyiFcF0e+wx1CHqYL49jLGqU9u60dFdnsSVaxUVI/1Wf0zx
         Wg9S3y27uovEQ0YAewb1H9PJ85Vr1QHwRrasZnpTits+Ioli/WLGr5jT6KIPaNCa30YH
         hEa/+yVPKmZqwcKYoEuRlw2J37vB/HPsBdAsTqFRp+OgcNedwV5h8d8co73kzWqi83x4
         UImpHUK9hwbR7R5h/bj6dhQfl5+pZHGc7p2NGEXqWcboHtp5WNu5rrux3GLtPVmFEcNb
         ttjU4E37/2R0s8oKoQjgoxycY+sgfpC0erJGIPDihiTuckqk+ls/8oEinllQ0pi248Lh
         ZzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUelW3ewdtc9epTiybwWUgvQkoMZgKnsX2s7hYo0tPwOjby9mMKqwKhvgdLBUdWfzG+sACrSQIa2AaiJ5Zw@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VulSJNohAiuG7TLJmMex2TTv9UeKvcZgDANTIILFCxNeczhn
	VEJnfOjqpU0DYxsFXrWEpq6J6JEUYKvhLhHW1g+FU3e3Gj4aH69FisLy6XNxksmI3Aoe39Jy0JL
	/j+abx6dWfX6hAvzIflEFGEFq9eAmEgJE9SMQYwQFJA==
X-Gm-Gg: ASbGnct256+2eCQGrepNhyDz+20M6hm84NmANsT8Q4Q5tICd4ZyVzaiBGyA8410GzxY
	qURWRfyDyTIFmUqyLVcRlmK9cqrvbTzoaM/CM/aPPsJhJ2JX7kpqosXHWdlOTdxowDOkBF63v15
	tgYJx7KNkyTv9papimXUDaMruLyAtmTCpy1n73Qe9X+/BCTsCOILGsYDBN5LoFOfL+8nkg2Otx+
	qc+cFTFMBnjWE2ZJX8+P4dfE0fVydaEy2E=
X-Google-Smtp-Source: AGHT+IG926akpOzWZcf5N3mV7elDZw28XggHb1wmpA4WdWitXiObkp2qNMaOn7Rtqs/aofUinFciyRkhDtIhzXPOX5o=
X-Received: by 2002:a17:906:c11:b0:b04:f8d:bd7f with SMTP id
 a640c23a62f3a-b040f8dbf99mr446115966b.65.1756720469662; Mon, 01 Sep 2025
 02:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901091916.3002082-1-max.kellermann@ionos.com> <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
In-Reply-To: <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 11:54:18 +0200
X-Gm-Features: Ac12FXw_rNjhcoFzQKi2bXoe_2WtlXZb2wNk3G9XO3JBfL8ul9lEEea3cb4eO1Y
Message-ID: <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer parameters
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com, 
	yuanchu@google.com, willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com, 
	linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net, 
	jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com, 
	shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org, 
	osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au, 
	nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:44=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> You are purposefully engaging in malicious compliance here, this isn't ho=
w
> things work.

This accusation of yours is NOT:
- Using welcoming and inclusive language
- Being respectful of differing viewpoints and experiences
- Showing empathy towards other community members

This is also not constructive criticism. It's just a personal attack.

(I'm also still waiting for your reply to
https://lore.kernel.org/lkml/CAKPOu+8esz_C=3D-m1+-Uip3ynbLm1geutJc7ip56mNJT=
Opm0BPA@mail.gmail.com/
)

