Return-Path: <linux-fsdevel+bounces-53795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2FAF7440
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 14:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D48A4A7121
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 12:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15B2E03F4;
	Thu,  3 Jul 2025 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWOqURet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEE2D9EF4;
	Thu,  3 Jul 2025 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546067; cv=none; b=uzb4PWBdqjPl6TL8Ym/XWDx5PNVdtlzYPndvYDvB6WaQN/g5dbgwO6nJpJTPjXAmsLW9RBekaLYUg1tQtQ9bE20xj7yG4dibZ2kEkT8SfV5+I/5+7tuyx5ez+tWb5yRTk8YHSMOUNAW6DtOaSUTgB3IBr9U1CoZo+yCQkihydo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546067; c=relaxed/simple;
	bh=Pj8Cdq0sivdNx0WCtdyO0zBAKWGSVYHVKqj2V5LSI/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Idg5yaWUX7dMXjTVbJ5LMZ2tLyqv5/75Q+yaA8hGUNj2ndTjqmjLJBzhmGGAU9Nx8W9wtHM5FES0oYEgJtXIWv4HcF1Ra47dMREfa6GV40OgvSVT9mgunbexOeYT8fa+b+0jUIV+bg0KYgDKIKQg8mwuZwUM/uSZa1KpwrGaOzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWOqURet; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fa980d05a8so85429226d6.2;
        Thu, 03 Jul 2025 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751546065; x=1752150865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pj8Cdq0sivdNx0WCtdyO0zBAKWGSVYHVKqj2V5LSI/g=;
        b=OWOqURettas7NzT9zS5TM+zJi+2MVeCvCcJQyBr2PJV+w7cW/u86yV01GevhX4HbD3
         nx40pYmC5G36Rt5ra+Zjn5qAp+TyWfJ3S6DEKQbbeykOG7jmTtDpLwOzcoOr5MYSfZ9u
         7LEqwhNRA7aFc8J5g9xqkR/XSJg8AhFBufRKc1vRV9GvcCseVCgVnxVsu8yEgd2dmUKa
         8DoQGPfAsHT5hWbHDBZhnbIMG1KyonENU1tMh/B2s1d3Qm+EvTfVfyMrJphY7EY9nwjJ
         un4NgXOEbiZmee7IY+Hf3rm3D/29zX4uOqCHSb/eNlOhjBR6kqmHAul3K+3WzyqAmdCR
         zqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751546065; x=1752150865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj8Cdq0sivdNx0WCtdyO0zBAKWGSVYHVKqj2V5LSI/g=;
        b=Yksm+hkRXeqh9zvffqhP8pmI7J8/3Cq1zdL0meYYeEQ6t+KBeZ/kz45XrTz/3DsdJ7
         vbwOum10ENqGRScayh9+aDzvSqOUObAAHHHz7LwgT2lu54LQ/bF49m7JeJYHDDpNiblU
         C9dKZ1oOZVddezvOBHwZ6nNnKDa+FEPEtZC+jxU+yBW6qenWPe0fnvT+gAX7TULpZ8AP
         DoxzFTCoB+dzaDTPgzw1maXpvRJHjJuDVdElFC6AmQWhLYsis6CNASgTNUb1pXizFRKe
         9eDqJyhi3G5Ikk6oJz2GnwR5RlLDQ3RbQJ2wNLe9Q8UZx4yIFhwP3wsiDALdJ0HR0oRr
         OZng==
X-Forwarded-Encrypted: i=1; AJvYcCUJEtpwD5AAd9NF2zMLVqpESVrCVqnqtspMztxO2iInfuFRBBXeC5g/3gM75jGZaTfAlQEV9T1prj/lLtiv@vger.kernel.org, AJvYcCUQMEpa6YCQUawK1HQ2/B4Nyp1u5tQ7eTRjNcwmf8tWrEBPU4KKl2+vQF67v+5JexCJnykgqAaLM4xs1YlC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Y34ARJwqwJcJm35Y8w7Zc83vz4pvy2g8PRa2p2JIxgr9/+jM
	tGhnItAZ/5/grIhM9AgMHucDnDXk1q7BHC80zsAOe4Psp1sZNQmSR7w+Qv8klPWIqZg/BBQd26N
	CZRPbgBjNmCNSGo8mGA3nLlgwz8UYp1w=
X-Gm-Gg: ASbGncuky/Qd4HA8yzfpb0VJhxmkLdrSJpBK99djSUtAGggaZ9uB4GsGfv+E6dk57Cj
	2N3fJcBX2fwmhKC+2HQSkdH//YQ9ogEUBpCcQcRoin6uGl3ehCNaFRc3T58YtA6ng4b6s9dIpsy
	iwzJDmMC9QgAC80KlMHCoiPnev2vvoftzMtNZjtaupds6io4N1uXdgF3yQHg==
X-Google-Smtp-Source: AGHT+IGbPYrN54dYrzHXjzvtPMziKIP2dK+ZFdrAB9bFhOzkRz3Vofn+4fvXYD/kf1p6asLy/7oo4AMZVhDjgjTRKGE=
X-Received: by 2002:ad4:5cc9:0:b0:700:bc46:5355 with SMTP id
 6a1803df08f44-702bcc507bdmr58755466d6.28.1751546065169; Thu, 03 Jul 2025
 05:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617154345.2494405-1-david@redhat.com> <20250617154345.2494405-2-david@redhat.com>
 <aFVZCvOpIpBGAf9w@localhost.localdomain> <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
In-Reply-To: <c88c29d2-d887-4c5a-8b4e-0cf30e71d596@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 3 Jul 2025 20:34:11 +0800
X-Gm-Features: Ac12FXwlisPZPIPS0YTxEVYIGMNVB3un9rKexLCpMfXXShG5J5pRHWps4sQZYSw
Message-ID: <CABzRoyZtxBgJUZK4p0V1sPAqbNr=6S-aE1S68u8tKo=cZ2ELSw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] mm/memory: drop highest_memmap_pfn sanity check
 in vm_normal_page()
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Dan Williams <dan.j.williams@intel.com>, 
	Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 10:04=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 20.06.25 14:50, Oscar Salvador wrote:
> > On Tue, Jun 17, 2025 at 05:43:32PM +0200, David Hildenbrand wrote:
> >> In 2009, we converted a VM_BUG_ON(!pfn_valid(pfn)) to the current
> >> highest_memmap_pfn sanity check in commit 22b31eec63e5 ("badpage:
> >> vm_normal_page use print_bad_pte"), because highest_memmap_pfn was
> >> readily available.
> >>
> >> Nowadays, this is the last remaining highest_memmap_pfn user, and this
> >> sanity check is not really triggering ... frequently.
> >>
> >> Let's convert it to VM_WARN_ON_ONCE(!pfn_valid(pfn)), so we can
> >> simplify and get rid of highest_memmap_pfn. Checking for
> >> pfn_to_online_page() might be even better, but it would not handle
> >> ZONE_DEVICE properly.
> >>
> >> Do the same in vm_normal_page_pmd(), where we don't even report a
> >> problem at all ...
> >>
> >> What might be better in the future is having a runtime option like
> >> page-table-check to enable such checks dynamically on-demand. Somethin=
g
> >> for the future.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
>
> Hi Oscar,
>
> > I'm confused, I'm missing something here.
> > Before this change we would return NULL if e.g: pfn > highest_memmap_pf=
n, but
> > now we just print the warning and call pfn_to_page() anyway.
> > AFAIK, pfn_to_page() doesn't return NULL?
>
> You're missing that vm_normal_page_pmd() was created as a copy from
> vm_normal_page() [history of the sanity check above], but as we don't
> have (and shouldn't have ...) print_bad_pmd(), we made the code look
> like this would be something that can just happen.
>
> "
> Do the same in vm_normal_page_pmd(), where we don't even report a
> problem at all ...
> "
>
> So we made something that should never happen a runtime sanity check
> without ever reporting a problem ...

IIUC, the reasoning is that because this case should never happen, we can
change the behavior from returning NULL to a "warn and continue" model?

Thanks,
Lance

