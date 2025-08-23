Return-Path: <linux-fsdevel+bounces-58883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F809B328C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306DB5E20A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D48255E23;
	Sat, 23 Aug 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6m1OgGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B71FF7DC
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955452; cv=none; b=A8e+re2bfQa9EJBFCrQuspov4olbTw3rlIueBVKKnJ87KCwopQn7psUcT/hYDkUCvB2ZSi7U+XUIin6bKCTe+gixRZIm9kDwBoCOSvzTKXGFADuOsD+Bhtqo+IvTBpHL7zO0+eo4Clqc/+1vHqMS2TYdJ/S/Rc9TN8jKGOQQcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955452; c=relaxed/simple;
	bh=L71BTpG33Qfm5HUN+Ggd6TFq9lgk2YUPNCV1opcBYR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2SYVVJc2jlAkSV+warp5aF3tVBR902NCdnvkQcRsKkBx41neMS6RNTrnoQ8nSnL2V7xWtHhUvzCAXw/GIYzci2ptsZurFrofk5okz2Rxj9kqdecvdMyJnns4k54kein/nHr51Hxg3UsUuY7scWyTl6yqzyPZMWEsG7Y/di8TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6m1OgGm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79db329so428424366b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755955449; x=1756560249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8derbSWCDefHjLCBOalX5Pb88h3zihakDU26sgkICEw=;
        b=F6m1OgGmyZ/J/O/5M9qLZQjpuStOKNpMTcdCKSLIr3GXO1vfTC/Y4p70NbzjEaoSO9
         ArlG7kdIfXNMoZ5/rorop8Bb2QrbgSi82rWbwNuaqxoD43oAh3qKsqWE6zo8LVOoFnAX
         mQuABNtxNmtyQn6ob+6Ms/hMFrsnvAU/0WZmQIE+CpeZVKSrSNvBk9JHZ4t/CBI5RRP1
         IheuzuaUYnnEPEXgeK9XXg+/PSxYQW/pW4P4Duhvw3hpKy5Nu7IdoLKWK4UjWf/ypxqs
         R2YZq09pgZLgIPGY0k8BN9/0EAvpjzThlQaaZlA/5QgY47u4g7flB1XFCQwgzRiF9K8h
         rBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755955449; x=1756560249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8derbSWCDefHjLCBOalX5Pb88h3zihakDU26sgkICEw=;
        b=CFnxL/T5uu0CMvxt0ZRcuH+p/twCcZI8kInoIn2FS8vSfk5PIohO/mbg2iiPo9SQ20
         L8z+blQcjemTlCSJ36kXvYTIYgXNQQgN36kdpWxyg+i4ER7sb++YQYIbjj/E0YOTEDzb
         lOYreHU4lVzLsTXOSB/EI/dI62shgm549RDR3NEki8RwHJuN/7j+E2HrXJpHVyJfuxcW
         4LRnmlNhLBKeUNwZfQFgVJfZuLgcGlm3JJVW08sIqZ8wbn5cLlqj22x6aFOpFS6mEY65
         jSvfkeBaR9iNHKQsZ0q+akdC1sqLznnda5XpKM+vFS0zYO4at3+XxORXN6oeptfnVm74
         WG+g==
X-Gm-Message-State: AOJu0YyIMIZsX2Jnwq3HbbsLG9tQ+2oNhQicUHK2sg++/H2iv9bpGWx4
	O/24VpKri2YK0YqpgMUfTlOuWL7YzLtgDOqWq/Te2hF/168cwnFlOTcYx8v3
X-Gm-Gg: ASbGncsq82L4eD3KuVJM8WljvmoNo+QKf75/M8VZoSd7474QASfyWufvr69jtTzyzqT
	IdlHEOR/cpwD3FH+w5YWbmUgvWZ+bvd00eUl9bSnBd+XUxFF0mCvW8DhiO7DY3A7S8jZfWAoQF2
	ylhsw135wcbygSV0qfU1PHTgQ3HoqAyqpc7BGfmAN3MsGJDPSlB2dYS4GG8thM0tNEqlDtBfz+F
	Y/HTYuOL9oHhV48y9PMr9pZQQSiZdvuu01PwTW7AWQD6M/sFxzBoF22yJguBKgnRb8aHgKI1eDb
	D/BMB9WDvB2mFgiHNhGmNVfan90eVhAQzG1lvVgaU3bRKNEmR0oFTL0XeKe8e++RQUTGn8u3uYe
	Ii+FCA9SsiTfkhZNIKu4=
X-Google-Smtp-Source: AGHT+IH232wq+4NoXpgdsKJIQjEgTmRn13AdY93oucQzrXK3TudmAZSn32p1ngtvdFCSD8Amp1K5uA==
X-Received: by 2002:a17:906:478f:b0:af9:e1f0:cd30 with SMTP id a640c23a62f3a-afe294d3e90mr543825566b.60.1755955448443;
        Sat, 23 Aug 2025 06:24:08 -0700 (PDT)
Received: from p183 ([46.53.248.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49313642sm171024766b.94.2025.08.23.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:24:07 -0700 (PDT)
Date: Sat, 23 Aug 2025 16:24:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: test lseek on /proc/net/dev
Message-ID: <1f1aa44d-42a1-4227-a788-f53826abac42@p183>
References: <aKTCfMuRXOpjBXxI@p183>
 <20250819140929.e408f2645f01e74e16c34796@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819140929.e408f2645f01e74e16c34796@linux-foundation.org>

On Tue, Aug 19, 2025 at 02:09:29PM -0700, Andrew Morton wrote:
> On Tue, 19 Aug 2025 21:29:16 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > This line in tools/testing/selftests/proc/read.c was added to catch
> > oopses, not to verify lseek correctness:
> > 
> >         (void)lseek(fd, 0, SEEK_SET);
> 
> Can you expand on this?  Was some issue discovered with /proc/net/dev? 
> If so, what was it?

Retroactively it would prevented the bug:

	assert(lseek(fd, 0, SEEK_SET) == 0);

But I didn't want to compile the list of exceptions and maintain it.

> > Oh, well. Prevent more embarassement with simple test.

