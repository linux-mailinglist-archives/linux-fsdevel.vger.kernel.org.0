Return-Path: <linux-fsdevel+bounces-45987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF7A80C09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C14F1BA429C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55B18DF6E;
	Tue,  8 Apr 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMdHR0Ku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463B16F858
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 13:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118122; cv=none; b=lsPWQ+crYL+50+51N9EQqHcEvB7FYwxkn96EU09f2IkVVxh0oYBh3O5RnZc2WEbPTaewKu/AHydkzv6+t1/nm6qsD2zQIvbBpIrvn5/lrn8Z/MWY1mdInaFgGEQt3UnVX6F3MyNjVSrQgWI6mitRhyCKOf1lCy78G7UTG83Qgeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118122; c=relaxed/simple;
	bh=fQl564sdX1Zq7qf8P/njzEEWjIjcEfPMr51NmTthVPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SxpXDGB9GFpDPmAMrNrhLffQQPSK8u1+RapKBfHNtMn/SuMMuT+FO4UaJcQE4evFnBVqlWPSCQlu+vhkI+lEf+N/RjbNBl9IK7AG2KbunbR+xEmg4xVcWEgmuna1PiexfT8Uhzio17Qem7lHGvWmJitAIzNeeGU1q4d8/XAzyx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMdHR0Ku; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af8c34d03a1so5547533a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 06:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744118120; x=1744722920; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cxLpLDM+FUDC2hLdYZi+8IO3v26+YR2oUAk1Ds34yFQ=;
        b=rMdHR0KuTVIrZOHf7jg3z51GBm6mkYnQeA8X67PW0wi9ieqrHfMhYzd5NYK8O63YUo
         QBawx2/MPdbbEz5JVGvuifNEayIwbmEAyWxvVo57AblFYYNprU7AlpUnc4kTXiNzFEon
         yReaH4atqDcZAELIui5gZuaP9B1I1HpmMRmdEcIcpuIY597uCqDxjaqDMlkJHEB3UnIp
         2/NHRPDv1itgrhIAyzG0i0QaryJECGfjpVFyRTximEWvK+y15AAxAeyVOyG47yc31oMO
         Nygeq5Ad0yV/Zi2Yiqbvr/9eTHSlMqSJ0pOByAD583lUJsWeA92EZgHMGuH8A07wtcNN
         K79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118120; x=1744722920;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxLpLDM+FUDC2hLdYZi+8IO3v26+YR2oUAk1Ds34yFQ=;
        b=TTbBHOHREdXJkxDcvVX9XxMyUSnWZpJRpnE1ecj2uzOvVcPbCdA0ls5V7BoMpXxoLO
         17jewbYZXZ1yBVY61AhOeMpHOhhaIQ8P1BQ/zIUmMijkguL7zD1smiutbLbQ6mGy7mjI
         51DHAn3AP8bHPHIt0KXUcqErK30dt1fEolRLvFrGXUEoc0VSca2GnEvMYUCr9I6Hn0Rr
         0hA6NuYRtPXl+3KOEP352M4liTgJ4QGLb+IpRdIWkGgyNqdrNPDhtbRJvjziu1pRjujG
         TvIrZwrhiip/NDwjywoeMXSfLZaB8qGZNh3q27ATiYCwG90fOvgzRqz6uTc5jj1MJuEg
         UrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYlITS0KVWNFmHOJ8dNVLDu7k00vAq81nBEEKjmibZId1kPuoDo1DmO1oeor3D5nojA5v9Ho+edr57+YTM@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/P9IColb3yrmhu+qeO3g2bLeLl4FASRXg2rfBVfB/soNEVgd
	1Pywajh3qLImWNcFLIaV9wPmi2kAJfkaxJVK+OvCJGXjdrH5Vk+xXHIRbi1HSZ1yyC7GXNUnT9l
	FZ7gwEIhvEPaIun8tSyyV9Q==
X-Google-Smtp-Source: AGHT+IHc2KZ6S3me8LAZPWuOPQtdwMC6ueKm8WjFNg1zLp+TVvJCgzOLJp2DH3B70CYmWq8BmZbUIxmhoP8HCKyyGQ==
X-Received: from pfbjc20.prod.google.com ([2002:a05:6a00:6c94:b0:736:451f:b9f4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:5085:b0:201:b65:81ab with SMTP id adf61e73a8af0-2010b658353mr18982327637.23.1744118120501;
 Tue, 08 Apr 2025 06:15:20 -0700 (PDT)
Date: Tue, 08 Apr 2025 06:15:18 -0700
In-Reply-To: <20250408-wegrand-eifrig-355127b5d3a3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404154352.23078-1-kalyazin@amazon.com> <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com> <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
 <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com> <2bohfxnbthvf3w4kz5u72wj5uxh5sb5s3mbhdk5eg2ingkpkqg@ylykphugpydy>
 <9326367c-977d-4d55-80bd-f1ad3673f375@redhat.com> <20250408-wegrand-eifrig-355127b5d3a3@brauner>
Message-ID: <diqzv7reu74p.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
From: Ackerley Tng <ackerleytng@google.com>
To: Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nikita Kalyazin <kalyazin@amazon.com>, 
	Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk, 
	muchun.song@linux.dev, hughd@google.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	lorenzo.stoakes@oracle.com, jannh@google.com, ryan.roberts@arm.com, 
	jthoughton@google.com, peterx@redhat.com, graf@amazon.de, jgowans@amazon.com, 
	roypat@amazon.co.uk, derekmn@amazon.com, nsaenz@amazon.es, 
	xmarcalx@amazon.com
Content-Type: text/plain; charset="UTF-8"

Christian Brauner <brauner@kernel.org> writes:

> On Mon, Apr 07, 2025 at 04:46:48PM +0200, David Hildenbrand wrote:
>
> <snip>
>
> Fwiw, b4 allows to specify dependencies so you can b4 shazam/am and it
> will pull in all prerequisite patches:
>
> b4 prep --edit-deps           Edit the series dependencies in your defined $EDITOR (or core.editor)

Thank you for this tip! On this note, what are some good CONFIGs people
always enable during development?

