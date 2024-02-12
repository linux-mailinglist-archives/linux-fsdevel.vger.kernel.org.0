Return-Path: <linux-fsdevel+bounces-11232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D5852102
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5781C22FDA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DC4E1CF;
	Mon, 12 Feb 2024 22:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Uin792MN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C500B4D133
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775722; cv=none; b=AugQYMCsmoxQJSLfnJHBrrIi/3FZK+k/UvtAsJ/w1KztNGVysO2tQnT+/qk452y5Na3Yk+0Xl8e7pEQEAiZ2lY0RTf0xeyaK/y+ohKK1+A1eUQZnX6/S43oIm+r5Z6fVQ72//J5m2CFatuSKwQaCq+tPDi8tPFSGXtL8nG3scFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775722; c=relaxed/simple;
	bh=gAbe+DaZz7ho9Xs/O1+sZUd+Q7Ss16k+L7gT59qsNpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upOp+tUY4eV4eKn5hRVmTo38Zh1wb/rGRwrSWtg82mRSsmjv4MDtUc8FbUWRcRpZ6FccPkM9lfZBzeA9AOswD5EiDzuh62/jOIsfke4HVs8btus6C1Ntx8saWzGX5XAXsipfYH2nzexTO52+FoEZAYn/GPXmpZbp8CZybG0edHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Uin792MN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a3cb228b90bso132842466b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707775719; x=1708380519; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=Uin792MNjE0TRZnpj2U2D67WjrUmFSXtD3Q/ir6YODqIQtH0gzeSGrurZHjIjayIsi
         fUxkxJ5uK6DZs+M5lySFGq+r+U4gVbSN+3ER81p2+EVre0TRetvLAC2D1CdQw2jp1Vyy
         8e58BQPUuzuewQz9M2ykJ6QIvxcJoL4zRQ1Fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775719; x=1708380519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uavn2lIFtdjKttrhD59+foSMVfR1WVZExe9j9lqEZVs=;
        b=bZ94Bc5nsx32KLZ25dRMsd3jHsJ5CFnkax3wetUQdCTjkCZnMmRvqmG3tsKiuV4SqM
         mRN1eE/Wzzx7LT5f58hViVb4shi1H0UXBu80DLbYk9tOCrr4xkV+thNKllKh2O9clkRJ
         l3ftYfeiiqkRX0ye0/PrIBKTgQ3a4GbcC85INXHjQXf+J7fwjNRPTcdoe2ATNdm7fw5+
         82Q8DEd0JowjXA6xqUhFnFCY5Sh6YMK8AQiYF12aep7dO4Ywt5xDC314xDJ9Y4lv86Ad
         I0x7iOEmKBfL3h6bkUlADnBebo7fG1k0cYb6S4QMNluT0u5/7M56JhT3eUOvtX223nTL
         aYKg==
X-Forwarded-Encrypted: i=1; AJvYcCUy+myZrY5IFcDfQ2w7J3TuWYN4c/0S7LQEGd8hd1HDApgdqf0MdrtYmTf5SXtUbg1fB2VX6OwOLk04KndKnSch8PezWfU9wPLC0vpltw==
X-Gm-Message-State: AOJu0YyRMVLcKiaO0aQbkWlChCQ9zL4bE9uy9tQO8UD464GTLAdvqydi
	FFfgN0EWYgPM9Rd+K83/aO9D9lSnAMObmCF9/zbu/wbiMJhYQ6k0KhgBNKVVdAiAy8Hny1CO8Vz
	AvHU=
X-Google-Smtp-Source: AGHT+IF6WUxE85Re0XJlOpQOx1omYiDGq04lYUeqOUdJ+eRkgJb0BQ0YOFTRWDk5JlcODTMoCmnbgQ==
X-Received: by 2002:a17:906:2453:b0:a3c:b298:d2e8 with SMTP id a19-20020a170906245300b00a3cb298d2e8mr2396777ejb.26.1707775718982;
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeslAga7vA6bCg/+SWoy/Hs8qTwPxZZp3VmsMAp6KJ150iaDXInXwCS96KjDIQXvE5pTAw9awZPYAzw+iAp5ldcnfXfols3+gM61zqhg==
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vo9-20020a170907a80900b00a3ce268c015sm457620ejc.48.2024.02.12.14.08.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 14:08:38 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56001d49cc5so4590737a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUukIfl2z8z6oYD6k6QctgTp4eCQe5fMfu1/iwanz5qi6ljQu6bdhC49DbTptitvX/m9HdEtUUXNijhER5HVRMhuth8ZurFt48isWM2rg==
X-Received: by 2002:aa7:cd66:0:b0:561:f173:6611 with SMTP id
 ca6-20020aa7cd66000000b00561f1736611mr60172edb.35.1707775717604; Mon, 12 Feb
 2024 14:08:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com> <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <65ca95d086dfd_d2d429470@dwillia2-xfh.jf.intel.com.notmuch>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Feb 2024 14:08:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Message-ID: <CAHk-=wiqaENZFBiAihFxdLr2E+kSM4P64M3uPzwT4-K9NiVSmw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as non-fatal
To: Dan Williams <dan.j.williams@intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Feb 2024 at 14:04, Dan Williams <dan.j.williams@intel.com> wrote:
>
> This works because the internals of virtio_fs_cleanup_dax(), "kill_dax()
> and put_dax()", know how to handle a NULL @dax_dev. It is still early
> days with the "cleanup" helpers, but I wonder if anyone else cares that
> the DEFINE_FREE() above does not check for NULL?

Well, the main reason for DEFINE_FREE() to check for NULL is not
correctness, but code generation. See the comment about kfree() in
<linux/cleanup.h>:

 * NOTE: the DEFINE_FREE()'s @free expression includes a NULL test even though
 * kfree() is fine to be called with a NULL value. This is on purpose. This way
 * the compiler sees the end of our alloc_obj() function as [...]

with the full explanation there.

Now, whether the code wants to actually use the cleanup() helpers for
a single use-case is debatable.

But yes, if it does, I suspect it should use !IS_ERR_OR_NULL(ptr).

            Linus

