Return-Path: <linux-fsdevel+bounces-56314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB3B1575C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 04:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2AD18A6DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EEE1AA7BF;
	Wed, 30 Jul 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Zmm8Zsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A21153598
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840801; cv=none; b=XIsafP1dU4/XxULfYDES1CQAEsgDi2VAUcquoFpOCjBJUWAn35QqiMU3ccfvo1ViTPoq5+y0X9pfLhvaTIgDYt+a3rAemGbgTfHED1SPNPw78RKrcWFHiosvfbdl41Gl9OIfXg3ntaZHBfnUwbo/lyHHeVi4ldh3X0bbRbUIkWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840801; c=relaxed/simple;
	bh=HyB44ZZ6pk8w3wAojyfFHRz7MWKPiai1SP+6ZMkt1/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FGqx//t4h81pvrgc14b7cE9368EWuaQTFyln8dAwznuE3nnBD3MPC5AjR2/UPMk9N/Yneg/CuCT/aI8+Be61X8x9gCxsCLelBCzNVgIsk/xWcp7k06LO/6UbjVKKrWsgsbeZx23xX8mcvQaFAXNIRufkpOMYocdKqL3Axz91yoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Zmm8Zsa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-240718d5920so72785ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jul 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840799; x=1754445599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QcSJTaElVVvYYo9nNi0EOGtYaOjMylV8RmeZ1BcyB1k=;
        b=3Zmm8ZsaFw+q7/hudtGqMVJ3EHGaNNjx1r3tqyYMDGtazw7PAWqJw8Cvs1e9lkl85Y
         XuPjaPckxwepCb3GKNsuh5yjJnIXo3v06ZZVzIEIlfYyljzjNqC7f2GCiHMvW/z1+XiL
         xxpgmFJE0oRpiKFPjL4bNhopGJapmNEEtTatJwIC3z8Mvb9zvCUrOIpJLVBpgo+iq/5c
         B5MKFOle8rYqWy5hFb+/P9m6XCA63+LG4dA0qNBm8ZWgE4X5dG3TiUC4RTfM5YNHL+qy
         vTnNEf2r/x0KgsNgKCM3uaU85PB6bLLLmtuZuS2tsaDmiBsW7/0sX/wndYpAh8qu7twT
         IsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840799; x=1754445599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcSJTaElVVvYYo9nNi0EOGtYaOjMylV8RmeZ1BcyB1k=;
        b=urVgZfmBAjQN07JD6Ty85k8tCMoYxwI2WeM9ORtcmPpwHUmG9vqNciDpYbFxxi1PKO
         k3TQ2xeL7ns1UhMbt+Z2ouVWmOOkbwF/sIFrqRlMM9tTSB8Gy3CRo9l+YDSq95qppmqL
         sKxMmdZ0if00SIICWD8CDS1SRxD+wWt0XA7P67D/Qx48iQggMBmCxUDfGZjQOd32jhkW
         gcWkfkRJnO/qgfER40JB6edKlzWC29uNjGptjHbSZmDkLSxKSVgM80DYQBHUgKU0f1Hp
         vD8eMOly+Uxtd6kxCX8qsu7TGWrilvP+e6ewfBwvHliGyQ0LuoAJ8YsAPLzoSf5JeVlh
         HDDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCfSWiW3TAatIzH0S16HhDeM/3i3Y/CM3bRQoUTQiA8Tjei4a98Ti7mhH39gHP75yBwq6FdRjlaF6WH5I+@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLWF/VQ1AU7rEUIEvdA7KBeraulP6vBEObkFJ2AyZljcSbd7d
	fWCYUhnXADjnr8eyzyiUvSK2lNB2IBJQX+ZYHUWZL+9+6SYt4dTi5Yk5gRcttaM7kg==
X-Gm-Gg: ASbGnctfrwBMrBk/5eYwoDLX/kex0g93rWQyIoO0rscz/XHmiFOq4RbLz1YfFF44I+Z
	PtOkMJBla3zUv8ymMbtyQjkklSLJKSgqMmG0Bk/anTSvTZkviFb386/Jj/G/q16pZ0EmemkJdkW
	kWOK36XG9bgegNSS04aXFb+s8X5evxV1Z24isCqx1YwnCiYs08HB8Qv0p4GSeRFhDDUbmLGQVZH
	emX+EzNzdUig7Dbw3+JfPF54QtDVHS+o3aOYXo2B09WWkhteRo5QGE9U5u3HMZIg/MenXzYgejk
	0umJxaS4nmUQjZi/4Pg2opMU6Qio3/Ylw78o9/QxTR3wvUl1p8AlOLdl1b4q5u0dvS/mxOs+EbM
	aFSB68TUFuATUVwME3meTe3J++jWhyzkEaSfz2MD26YqmHTcdY5Qlw4SWi+F9WPo=
X-Google-Smtp-Source: AGHT+IGjlp72ezcaslBe/4Wam1DWdKTtFPAg2RfpZpa/ZWAp7fRLm64jv1x6op5wLdcpNXOdDDpIQg==
X-Received: by 2002:a17:902:cf42:b0:240:5c75:4d29 with SMTP id d9443c01a7336-24099e4ecc0mr2140635ad.0.1753840798874;
        Tue, 29 Jul 2025 18:59:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:9606:2f93:add0:9255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76408def71csm9185669b3a.56.2025.07.29.18.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 18:59:58 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:59:51 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, aliceryhl@google.com,
	stable@vger.kernel.org, kernel-team@android.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5.4.y 0/3] Backport series: "permit write-sealed memfd
 read-only shared mappings"
Message-ID: <aIl8lyrHJ4DAQkxg@google.com>
References: <20250730005818.2793577-1-isaacmanjarres@google.com>
 <aIl1AbmESlTruw7K@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIl1AbmESlTruw7K@casper.infradead.org>

On Wed, Jul 30, 2025 at 02:27:29AM +0100, Matthew Wilcox wrote:
> On Tue, Jul 29, 2025 at 05:58:05PM -0700, Isaac J. Manjarres wrote:
> > Lorenzo's series [2] fixed that issue and was merged in kernel version
> > 6.7, but was not backported to older kernels. So, this issue is still
> > present on kernels 5.4, 5.10, 5.15, 6.1, and 6.6.
> > 
> > This series backports Lorenzo's series to the 5.4 kernel.
> 
> That's not how this works.  First you do 6.6, then 6.1, then 5.15 ...

Hey Matthew,

Thanks for pointing that out. I'm sorry about the confusion. I did
prepare backports for the other kernel versions too, and the intent
was to send them together. However, my machine only sent the 5.4
version of the patches and not the rest.

I sent the patches for each kernel version and here are the relevant
links:

6.6: https://lore.kernel.org/all/20250730015152.29758-1-isaacmanjarres@google.com/
6.1: https://lore.kernel.org/all/20250730015247.30827-1-isaacmanjarres@google.com/
5.15: https://lore.kernel.org/all/20250730015337.31730-1-isaacmanjarres@google.com/
5.10: https://lore.kernel.org/all/20250730015406.32569-1-isaacmanjarres@google.com/

> Otherwise somebody might upgrade from 5.4 to 6.1 and see a regression.

Understood; sorry again for the confusion.

Thanks,
Isaac

