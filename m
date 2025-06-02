Return-Path: <linux-fsdevel+bounces-50377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDFAACBA87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 19:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F02B177C74
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F53226883;
	Mon,  2 Jun 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVvMEUxG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A0717B421;
	Mon,  2 Jun 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748886932; cv=none; b=mfLUiSvdcyqaR4yFxvBHaS0zLcqxsib1n6LIfnHFGQKgmUdAQk91iM3XxfYAO5QMC/nlKXJW+JXhM4Ph8Eon39z5chrThgd1OX5VgWeiE7/zi4bDqWlXCJ/XGRPz+weeQnXGneDfX+dPP8WLhxh8uyZySMvcdHyTZInBdi38Xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748886932; c=relaxed/simple;
	bh=efU7DUaZ/KbQkPM28EMt+EvKuDwBm8eEnCcyM1seBWo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CxVoSryZB+W5HQmhf4JeIDN7V3BUHt2jjyI9BvmM3YxQzsrsqH23uX+IuYOvzKftsuY7be5yl7Qo8zVdhW6awqdziY+OlCEVDnIPYMmkOF7ECPQlZY/LSbYXvDnMRsjhzd/m76Gags7G8ox4uv7FS7StlN84LVHikYxlaezQUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hVvMEUxG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-235ae05d224so8774035ad.1;
        Mon, 02 Jun 2025 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748886930; x=1749491730; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hr2xdyscY6HcGaMsoRMfUPw/rC6lp9ZeRyZ4U1/28nQ=;
        b=hVvMEUxG+J1iCnRctRPHBrImnU38NeTthwA8gu/w3j13MT/IAIOrbK55dFAVnFP9Sk
         lcF/48FdecBVMNTnmY1wz9v6qMUueuXLVOFd2UZuJGl1XLqwvnNPSoJc5VdWL2LaXii1
         eAMwGUkrzhtQSQxAYSAxdPL2Hr57uvnovXZ+slV6nkK3NWKCv1uLg7wUJaQGf9YuL1if
         P4Edd3AM4NgbzLPWgIs9W6FJ53Sdw0Y93k+243R0lFfNe7lgJ5+g7dGzPZDwINj7sQ3k
         ROGMSCos+YO6jb0Czwap4YFCnHQBe8rbr5QkL2j7HKeZ0sNHMc5htktLbIaV4H9jCDlo
         dWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748886930; x=1749491730;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr2xdyscY6HcGaMsoRMfUPw/rC6lp9ZeRyZ4U1/28nQ=;
        b=f52lgtqS93LH+UmymydSuvH9082Pe3yW6zj4s7S3AUPENVoCow3/Gk82iw6scfPB1F
         D+FUeWZYU6cLRfpUqEdDvMzkusIepkUxE+3Fl9z49SyHvgRPgABfiHwkoRMEvsjcTewt
         CvYhgy70bREnyKIcRvwXrMemS6qdbdVE7JlG7EyBfRXM6WbMf8/E09cZ22aFwlLdcJOo
         pAmCO5xoVu4I6JDklPkRgHHZ3jSCJ6eMb5taCPzV7pf9v+diir3zHzVPJ9M45ThBctsn
         hYFjIFiW33MFIXO2PYM6/tofG1HuMwsbs9kaaCfUVXqI4zGZXuJJulVBsLijQKg+TZBa
         d/7g==
X-Forwarded-Encrypted: i=1; AJvYcCV+JGiNi4DtLGAywPV+fwKUy3rgby4x5bwxdNEOLnZwvGkHKxQ/7NJotNbxgVfvFYDKmV6dKc6WXTfvKV2I@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgqQ6Yi5G0OrYwNc4cthUQnDGMURPjb9yGPXKGkinWs9e7CXb
	evySBS352Fr56hz7v1qWBvE40iLXfHBo6Jfnx4yd5dOvBgxzB2229oKA
X-Gm-Gg: ASbGncur6UXjKQpGsUy/l9vKCVaxYIp4U+DgYAvRaqgvw/rVLmdKAGp/lcb0nKtKaL2
	Z1poWucEJFW1D097Hc19vfHI0sUbFYZCHtddsAG96ncsF2nEuHoHjRBzPJeCchF/50w2zJQn4I1
	w4JafZk8xBaNg3uvE4XJuakbwd2IljoSwVCWV0KcCWjDC+F+L1LmrWLy57EradBG1mKU2NWxmat
	L9PHoXjkrTEnZE+IwTSD1MiXVmN53eSlsy8uQDvne+saRO4/oE0b20pdy7mj8vu0qtnJPAbR3Fj
	/Xgp8FI9yb8Q1pRjhEfrhk+cR3UTmUqwDmlnb+lPRiQFRIaLBqsDMw==
X-Google-Smtp-Source: AGHT+IGbfz/xlDOc15Po8dTWh2db8w6pEAOpCDo4Od/jeGF0v//gjdGE1QS6hVmAOyOBQ/Y8QbxmkQ==
X-Received: by 2002:a17:902:f683:b0:235:1b50:7245 with SMTP id d9443c01a7336-235c797d750mr3811905ad.7.1748886929842;
        Mon, 02 Jun 2025 10:55:29 -0700 (PDT)
Received: from dw-tp ([171.76.87.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bc8669sm73696975ad.13.2025.06.02.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 10:55:29 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, 
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] iomap: don't lose folio dropbehind state for overwrites
In-Reply-To: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
Date: Mon, 02 Jun 2025 23:16:32 +0530
Message-ID: <878qma9guf.fsf@gmail.com>
References: <a61432ad-fa05-4547-ab82-8d2f74d84038@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Jens Axboe <axboe@kernel.dk> writes:

> DONTCACHE I/O must have the completion punted to a workqueue, just like
> what is done for unwritten extents, as the completion needs task context
> to perform the invalidation of the folio(s). However, if writeback is
> started off filemap_fdatawrite_range() off generic_sync() and it's an
> overwrite, then the DONTCACHE marking gets lost as iomap_add_to_ioend()
> don't look at the folio being added and no further state is passed down
> to help it know that this is a dropbehind/DONTCACHE write.
>
> Check if the folio being added is marked as dropbehind, and set
> IOMAP_IOEND_DONTCACHE if that is the case. Then XFS can factor this into
> the decision making of completion context in xfs_submit_ioend().
> Additionally include this ioend flag in the NOMERGE flags, to avoid
> mixing it with unrelated IO.
>
> This fixes extra page cache being instantiated when the write performed
> is an overwrite, rather than newly instantiated blocks.
>
> Fixes: b2cd5ae693a3 ("iomap: make buffered writes work with RWF_DONTCACHE")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>
> ---
>
> Found this one while testing the unrelated issue of invalidation being a
> bit broken before 6.15 release. We need this to ensure that overwrites
> also prune correctly, just like unwritten extents currently do.

I guess I did report this to you a while ago when I was adding support
for uncahed buffered-io to xfs_io. But I never heard back from you :( 

https://lore.kernel.org/all/87h649trof.fsf@gmail.com/

No worries, good that we finally have this fixed.

-ritesh

