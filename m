Return-Path: <linux-fsdevel+bounces-54362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA7AFEC6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704F7642DFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AD2E7637;
	Wed,  9 Jul 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UOqlHnpI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D32E610F
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072200; cv=none; b=Bsuk0nOqTs0lPJyQey3Kx/o8Ozi1jjArdRFevp7k9GOkWY9S69nODwPLcC72iPc4AbUgqD2+eA2D814epIJnCaK541AA62YJmydQ3iK6BaMfy0XYE81yqs/fvzPiBxuSZu7lbczFQv0kDHo8bcP/E3DpUZ2M5rzq8StJBzenhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072200; c=relaxed/simple;
	bh=DjbU8JDH58/uDReB1l8knKdQPSGXHxPC7udEjRM4Vq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmgAAI9AHa9uLPXq1JZzO49SkNgPVvyQcORJ7VzTWxE/CWLVZ8D2R5RxXaaVTcJZ9LiQ5wttkQO5P5XJ8TAxS4XM8LpgNSoRR3yFXBZ4eCSRfsVABlDK8VdA0ji139mpdEETFQbLfvl4g6UaZrmBzOSC9E63EH69MSDcsaQpNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UOqlHnpI; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a9e8459f28so41851cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752072198; x=1752676998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gftQ+qxJSS70rkMsu4DZpRzsUtd6k9644oflq0fw20w=;
        b=UOqlHnpIIM16dnhsFpzhoq4gywb6Rvb+xomye7Uuax12r2knTdxM0i/qKhUG20GkhF
         UPGzr19VD5lvn6VZYWKExsWNtuKOwHHjHsu09wtDL5IM/v4ZKL0t17HUxL+UnjQMAMoJ
         27BgsR4wx8Agj3YmIMGJHH29Jr3Ycd8X7OWFcY+yBawUwM1Xn//8yRYIAJ36JCdFQNj0
         fiTn2WwfBSKfbDNY6JS8ZZXrc9UF2IamLxkCZ/FLqvEUMK9UllFYtzA6domLJVU/cE2F
         HfcIk3iygh1Fy8oe5XfGtX4Zn8mbEPk3gEHfdtrKUXUR2apsXHu7wVYY2r6rvkcorm+n
         AL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072198; x=1752676998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gftQ+qxJSS70rkMsu4DZpRzsUtd6k9644oflq0fw20w=;
        b=glVi6+8meqPu1tdOOSvIyR0Mzu21GlwXZLoM6X9SoOOPgOOJtd5P7Y70HFP+6SJrLo
         MlaNBZQSsv7GxSxgqjZNCXl//0JRChxwm220oC9V1CBHi0Vdq91xgI9QymWJlQTSMyKb
         r6KwEZO/TOt3MrZBOTnQj5RyyWPiHnZb0YNPNLziZC3qlJ0F9kTPaW/nAy539Wy+rvco
         9ZEA0PQTUuHAOY5lj+2lUPSRMGioZwBBBaP4xtgNdW6Mu+n42lIzxiXKweOXyVhJR6ZT
         IzV+y6mAz4s/fL9KdnqxVm8rqMsRpyB5CS/GtouWoAV3+g11nRd1gN8nY10M1B48ji4F
         BFwg==
X-Forwarded-Encrypted: i=1; AJvYcCX/BX5pyDeSl8H14Szn/nJ2546XLLH7hYGCeLBey/0tqOqhio9uXotw7TGLupj+/pJINrszanYpLUYSPcaV@vger.kernel.org
X-Gm-Message-State: AOJu0YxWKbF8gyb/bARsiqTWkF8St14QmuG1YIk7FwLWsTJNWqfuf+yp
	bqce0kRDdDu7cPma71BzIUMCqpyMBappeHPC8SvG2JOIZT8WMx5cClT7Wr/dyxFGwFzuP++fIVZ
	1h2vd9fWR0ldPD3dS2i8F4lzcvO0YSVLmcjnkAymr
X-Gm-Gg: ASbGncvaEqQl2uoyMKKsyhx+i9k7YUkEtoassljAC0jXQ7lTgepRTJkUjeF9Ux+9PyW
	J5R/8Nd4LtZZ5hK9Fc5yuHN2SC4xSd5BFa2HKHJqb4mpMq5FiSii9zjpIKzPISdhra6bGGeZ6pq
	3dfnsDma0p/l+dWpSQ8aZZkJZ7u5ZYbR47Q9yS39eHWTiGGy1l5sgAMagPGjI/Z5PDiOMWYe4Bd
	w==
X-Google-Smtp-Source: AGHT+IG7zkg+Pkwxf0jmyxqG/AtRZpt/NoxzbpzI97QUnstYs7Yx7/T+z19dLrUpiVtN2qwc05XeZbLDBRjwgVj3A6I=
X-Received: by 2002:a05:622a:8d0c:b0:4a6:f525:e35a with SMTP id
 d75a77b69052e-4a9de110269mr3693611cf.9.1752072197446; Wed, 09 Jul 2025
 07:43:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704060727.724817-1-surenb@google.com> <20250704060727.724817-8-surenb@google.com>
 <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local> <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
In-Reply-To: <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 07:43:06 -0700
X-Gm-Features: Ac12FXxdfxMaIiBpg3e7XumgPrV_lZW5D9LQCLmL4Lhi4PbvyNa3fhCKX1bjdeI
Message-ID: <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under per-vma lock
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, david@redhat.com, peterx@redhat.com, 
	jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, 
	shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 1:57=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/8/25 01:10, Suren Baghdasaryan wrote:
> >>> +     rcu_read_unlock();
> >>> +     vma =3D lock_vma_under_mmap_lock(mm, iter, address);
> >>> +     rcu_read_lock();
> >> OK I guess we hold the RCU lock the whole time as we traverse except w=
hen
> >> we lock under mmap lock.
> > Correct.
>
> I wonder if it's really necessary? Can't it be done just inside
> lock_next_vma()? It would also avoid the unlock/lock dance quoted above.
>
> Even if we later manage to extend this approach to smaps and employ rcu
> locking to traverse the page tables, I'd think it's best to separate and
> fine-grain the rcu lock usage for vma iterator and page tables, if only t=
o
> avoid too long time under the lock.

I thought we would need to be in the same rcu read section while
traversing the maple tree using vma_next() but now looking at it,
maybe we can indeed enter only while finding and locking the next
vma...
Liam, would that work? I see struct ma_state containing a node field.
Can it be freed from under us if we find a vma, exit rcu read section
then re-enter rcu and use the same iterator to find the next vma?

