Return-Path: <linux-fsdevel+bounces-43552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B0A58651
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620AF188D433
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Mar 2025 17:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFCB1E51F9;
	Sun,  9 Mar 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BI00M3Pb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E61DEFDA
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Mar 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541646; cv=none; b=G2Sp7HqzF5uQdcCcknbDPmroeF3dzELoEv9V8YgvYVJeWExyIvIXy9+L/9emUm380GHcVbaBIOs2toE2cfrYjyiQg15+M/2HNP4IeQcZy4L62WRTgaO7BLp5GMwZackiJDhOjqpZoKjmH20vK4/Ixw8y9X8J109cNPcKPubc9l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541646; c=relaxed/simple;
	bh=fMVKskE7Q8/lZwKf7tiT71cx60kbHkttSCWa1kajUqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8CFBZclQ8le/EY9gZuxwbDYos9krtOlKDlV8kBXfnISm2ksjYW+iSZnBsimDRykaFIJDbDbGy/NemPEZgPDgCofNjlZS4pu03rcUzu3OgyghG6j0C+8RIbYIBddZfioxn/jGIz2tCifU0nyN02HdWQvNW5TttEfYKPmw42KosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BI00M3Pb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741541643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DmLhabO1XEsdw99NpFOA+DWcEKy6BuEgBtPqezHn9J4=;
	b=BI00M3PbgGsQ/AiQ4pkn27UeAhTsy2EYujDxD6DzIX3la185nG0gML2xZ44EJxhh3Da+UU
	dxdHjhI16+ZMCsJH6sGvhn08mtDUtvch6ImWF7xyeYJnRLCahC3ZREmM+gapfZJuW1pJgq
	vFq+6DiHVmGrZVWVrKKDAkRtAI6Iqgc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-vG5AhU2ENrO6XOFXbZLFSw-1; Sun, 09 Mar 2025 13:34:02 -0400
X-MC-Unique: vG5AhU2ENrO6XOFXbZLFSw-1
X-Mimecast-MFC-AGG-ID: vG5AhU2ENrO6XOFXbZLFSw_1741541641
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254bdd4982so29992125ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Mar 2025 10:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541640; x=1742146440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmLhabO1XEsdw99NpFOA+DWcEKy6BuEgBtPqezHn9J4=;
        b=n3ZvBOg0IPMebVVcdgl0ISy6id4PzDu8zeFnyc7optuUjsS1XtKD83a9KkFmZxfyE9
         kRRsg+kQ6KlEhhyUaC1RwUniyQSiuIYLNrqXXFgj/zoTmb0gauKBD+M1e+fFo7v+igxw
         LFqt5JpMUqmSWVFtkX2RSK7fp05vp/v/W85gFra7XW1Z7EV07f5P109/yHcOgOVVVBdy
         as0uFXdUfM+ASVQyGeqxbocbjhKSuncpruMErYtsXLLXLMMPKA27N3dshykxOX6jt4JN
         +lCGWwo+GJT88F1/hxJdMFdDCr/tIJy4qprQdN7QGfVOeLrrMGeDq3atfh9SiZDSp4Vc
         PfYw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+LUWhJFH9jwn/+oos5GsHm7JM8mbHijakbZl16a29ppp7l5yxq26+wQkqDyBwKFYO4LuiXGjKvnd+uui@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxrJ5MooXSo7x9rRcrZ4H7BldHOZ2cjWPT2GnKUSwzN21DzZ9
	0g2q1QRm7Nc8DvZgwaIx2CVzBpIT06r9rL4B/ka/7YG7DzNWbmm253edd6mvOABJHzNtxopSs7Z
	qoGGF37a6vfJ8geA8RIbDve8V7+oOKMX4+JuHNvHDMLEz3NUtiYYN/QjsESxo0eIfreyKpWFRrO
	yKSAEDWpLcO9672KpVbz8COrXPAO+IgAUPqWbI/aqEapwxxw==
X-Gm-Gg: ASbGncsmE08h4luVW4HowYZibi77QN7umXQ+70f+kxO5zPmcKXSHJS703amThv4HpaM
	v3JgUn6m+IVZ2LsWXq35mL0Yb6os/pXBS/cWhhHW2RrRYwK+1dSmu2OOeGOCJJdeXu49LkpU=
X-Received: by 2002:a17:903:2f8a:b0:220:d078:eb33 with SMTP id d9443c01a7336-22428ab698dmr156278795ad.36.1741541640130;
        Sun, 09 Mar 2025 10:34:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFukraV1Q8JcqSsCUG1/QQFSk+SXDpOogbXDbjBF1ABHjsafIb8pNaLjfD84LDudRXS7nQ/UNEqZ0QXbcjg5IM=
X-Received: by 2002:a17:903:2f8a:b0:220:d078:eb33 with SMTP id
 d9443c01a7336-22428ab698dmr156278635ad.36.1741541639825; Sun, 09 Mar 2025
 10:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210133448.3796209-1-willy@infradead.org> <Z7czYNwTg7l0nu1i@casper.infradead.org>
In-Reply-To: <Z7czYNwTg7l0nu1i@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 9 Mar 2025 18:33:47 +0100
X-Gm-Features: AQ5f1JqH3j8Oyerl0NbKTVltYL6oMIII_j8bQWKKfIPw26Z02CddhD3WyX4TN6g
Message-ID: <CAHc6FU55LOT6xS9J2kV4hG7bbCx0Ojm+1t7QM85beFXSvJEa4w@mail.gmail.com>
Subject: Re: [PATCH 0/8] More GFS2 folio conversions
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Willy,

On Thu, Feb 20, 2025 at 2:51=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
> On Mon, Feb 10, 2025 at 01:34:38PM +0000, Matthew Wilcox (Oracle) wrote:
> > I think this may be the last batch of patches to gfs2 for folio
> > conversions.  The only remaining references to struct page that I see a=
re
> > for filesystem metadata that isn't stored in the page cache, so those a=
re
> > fine to continue using struct page.  The only mild improvement would be=
 if
> > we could have different bio completion handlers for gfs2_end_log_write(=
)
> > when it's using mempool pages vs folio pages, but that may not even be
> > feasible and I like the current solution well enough.
> >
> > This all seems fairly straightforward to me, but as usual only
> > compile-tested.  I don't anticipate the change to buffer_head.h to have
> > any conflicts; removing the last user of page_buffers() is not on the
> > cards for the next merge window.
>
> ping

thanks a lot for these patches; I'm adding them to for-next.

Andreas


