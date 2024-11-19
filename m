Return-Path: <linux-fsdevel+bounces-35208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D89D2691
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 14:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B41B2DD3A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441401CC8A8;
	Tue, 19 Nov 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RvT4NPz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43671CC16E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 12:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732020761; cv=none; b=u541/WjnD+Omq0jmzPshGtgk4Yy139IFF0m31m32GPJNkK1vDYE8bzmr/8g4SlqU/kDrogMQ9XD24+tYJDY8Og6dtml9tdfnNsED/qluUEGhp1QKpcKv9KDg2oMg/2QPJeBezB02N73rj+qp0IRZhPhCvWUKq4YDRSZ8J29jPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732020761; c=relaxed/simple;
	bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPsaKfXCpLa96l/uIUhCiujnYm3n3ZYFQHb+gvjQ1V+gNl+hooC16JNeP94MEF6dwgznmHEJYJeyr3XTlq4TNisDtODycbARzUz0v/3OzAbSPBwkMQR3TfYQUR6FuxcU9qcQQzool9wWmkjw/9PeQdbb27dRC8h211vc2kkmozs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RvT4NPz5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so6707a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 04:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732020758; x=1732625558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
        b=RvT4NPz5IIaqR7prkmVJ8Sgp5VpdKTUwU47DZs+UBZzbbib344Z2g4YntUaZg9giCP
         rVb7hRmfuCXsw/y9rCsyQyTQGsLOqqcNmFDecylZsZnBGJipOpnnQvzj8fJ2JC8DqTEg
         l+Vfo/7gRDqNTSAoqeT3nEbvV7rlHynmMFt94jqjTHeqUN4xueoE8wdzAarJ/jVCJ4Oe
         klkyv/iIT0vaQKaNwKLFHLlW+Kwyx5McFHZm6uoJUieglyAgFdIhfJ89mEACBF9yWVHT
         e4Vyyme71D9eG8SQUXTlyt3YshjSS0TxFvFMXr9rgFTdOrAoCSnXodsCkaCtfkhyHQ5w
         eZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732020758; x=1732625558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRauzgQtwAabGE/huRKr8PjySPrqwLknQlRBGuzARcE=;
        b=Ky1/blwlEJ5/IuZ2liH6jYaDs6mXPSLCLvH8f3wEGzMvCYH9Zy2bsgplmav/ESz3vZ
         CYxmflBRPJi6bHSRChQZExqDFAjWawIQ9qTm7JiQBeBqT0QEW0Nuf6Pu9zxYnNBNVTWC
         tw9PogugwW6XjcmF+7GIEQB6CMI/ndbR8v0pTyGA370aq/7ohU0333GmFsbDXp0xLdDg
         EW6N2XbE+9hAY4RyHMtEaBWnQmkPHCbKIf3QnacOsAszVxPK3TYJ2xqO44becTjdt3zi
         O15HoVy324DxzDrqxCFwxnAiLV+to/FskazWjc71FsTy8ryuRtJSWCS7uu9tpEyjG1CP
         E78Q==
X-Forwarded-Encrypted: i=1; AJvYcCUArFxcaBNsIiitH0oxqRHVlgyF879+3R75R/Nv7x+cQRNKYZZ050Wg5cjrUGTiYEtuYvhNQ898S4xmUnTy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4wJq7WY+OyGowRd3P+9244SnYyQAucjOeVJk9+CMN5wlB6VK5
	zIWgzI61XW2iBWOVSFs7Zzl0WBegABiwKZIxG4jiuSqJm1i5SwBqqUwKGc7qBb8UqwxMudSZHwD
	OBhHdoKSseyCWSpp/tSjUEk0wBhfbWKGBokg/0f29Pa9W3Tzb+zdcklk=
X-Gm-Gg: ASbGncsgwaQB50YT0X+kmNFa342q8hQNzNOiyvd04fo7XzQ5Ilxvy+f1dBIxJkmA0nN
	rSYAXmTlCBvL6sCaFY9WACY7FyZrvwQtvpYSWGVTWfW9UPN6H/PSA/VnLuXU=
X-Google-Smtp-Source: AGHT+IHrO5qfRHSlmQCwNzrJObJ8F+5vL3isZu6sEndbtNy8+TOZx/SUWI/RHP6UiYngvZBnewRWzZBX4xLAvWC6WJw=
X-Received: by 2002:a05:6402:1351:b0:5cf:bd9a:41ec with SMTP id
 4fb4d7f45d1cf-5cfdec244d3mr70875a12.2.1732020757739; Tue, 19 Nov 2024
 04:52:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <a0372f7f-9a85-4d3e-ba20-b5911a8189e3@lucifer.local> <CAG48ez2vG0tr=H8csGes7HN_5HPQAh4WZU8U1G945K1GKfABPg@mail.gmail.com>
 <CA+CK2bB0w=i1z78AJbr2gZE9ybYki4Vz_s53=8URrxwyPvvB+A@mail.gmail.com>
 <CAG48ez1KFFXzy5qcYVZLnUEztaZxDGY2+4GvwYq7Hb=Y=3FBxQ@mail.gmail.com> <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
In-Reply-To: <CA+CK2bCBwZFomepG-Pp6oiAwHQiKdsTLe3rYtE3hFSQ5spEDww@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 13:52:00 +0100
Message-ID: <CAG48ez0NzMbwnbvMO7KbUROZq5ne7fhiau49v7oyxwPrYL=P6Q@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com, 
	linux-hardening@vger.kernel.org, 
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> > Can you point me to where a refcounted reference to the page comes
> > from when page_detective_metadata() calls dump_page_lvl()?
>
> I am sorry, I remembered incorrectly, we are getting reference right
> after dump_page_lvl() in page_detective_memcg() -> folio_try_get(); I
> will move the folio_try_get() to before dump_page_lvl().
>
> > > > So I think dump_page() in its current form is not something we shou=
ld
> > > > expose to a userspace-reachable API.
> > >
> > > We use dump_page() all over WARN_ONs in MM code where pages might not
> > > be locked, but this is a good point, that while even the existing
> > > usage might be racy, providing a user-reachable API potentially makes
> > > it worse. I will see if I could add some locking before dump_page(),
> > > or make a dump_page variant that does not do dump_mapping().
> >
> > To be clear, I am not that strongly opposed to racily reading data
> > such that the data may not be internally consistent or such; but this
> > is a case of racy use-after-free reads that might end up dumping
> > entirely unrelated memory contents into dmesg. I think we should
> > properly protect against that in an API that userspace can invoke.
> > Otherwise, if we race, we might end up writing random memory contents
> > into dmesg; and if we are particularly unlucky, those random memory
> > contents could be PII or authentication tokens or such.
> >
> > I'm not entirely sure what the right approach is here; I guess it
> > makes sense that when the kernel internally detects corruption,
> > dump_page doesn't take references on pages it accesses to avoid
> > corrupting things further. If you are looking at a page based on a
> > userspace request, I guess you could access the page with the
> > necessary locking to access its properties under the normal locking
> > rules?
>
> I will take reference, as we already do that for memcg purpose, but
> have not included dump_page().

Note that taking a reference on the page does not make all of
dump_page() fine; in particular, my understanding is that
folio_mapping() requires that the page is locked in order to return a
stable pointer, and some of the code in dump_mapping() would probably
also require some other locks - probably at least on the inode and
maybe also on the dentry, I think? Otherwise the inode's dentry list
can probably change concurrently, and the dentry's name pointer can
change too.

