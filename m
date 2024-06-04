Return-Path: <linux-fsdevel+bounces-20877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E598FA713
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 02:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F001F23DE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092156FD5;
	Tue,  4 Jun 2024 00:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Of5MZH2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CCBA5F;
	Tue,  4 Jun 2024 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717461331; cv=none; b=r1uDA2YKure6zDJ8BSU2G8lVqAQL5NjXGam+9RuQu5QibeTtFd1IeA1lDLN49WGnwLebHl8XMWjTaEbemKgRptly4xHtj7yICMS2JyrHIOr8ZgKYwunFD4mVo+HryuGJsLcMxlYHE231hvoYrVLTioHsh/LFjOWK4XqNJkFABzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717461331; c=relaxed/simple;
	bh=0/BmyU0aNVlKQYkbJNKMsRqVuSbr5yVewq+9OZMeWXA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=E8+vI65apJgT3QH8NOgm0tJp2JoMDcMqWz88VFqVg8S1sUH8p3Hj9xNgOKiYASS8veaDRsFIyCzqhCr8oPcTp3QpQcitKxU2BgH9VKIdKtTH4jn31W0d3jKM04HeaV3uVoysq5z4Ka6Sizi6hUDg/9AQwVxfwHPleyhzAbdC0so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Of5MZH2D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-702621d8725so2211496b3a.0;
        Mon, 03 Jun 2024 17:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717461329; x=1718066129; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=55wy5hMiqIM/D1rd3GDpvg/HtGbO7BZblZ9Ox2jpi2s=;
        b=Of5MZH2DG1X1ZYegeTWHcO10u1yrgJvwdPTB1csnH8xX4WCblUzY4GG4Dl3P2Gbi2L
         3maTLQGFay3aYMNfWoYL1AiGgB0Guu8Pkc/Wb3Wlgbq20ELY0hAshrAXmBaWnMwiwzRq
         tOcwATmz+vIUGoNTOFkWc18pN4v5tCUGTrxc/0af9k80jJ7s8si5YVEDzOGgvLjup3/a
         Rn3iHY9E5TrwTEXjj7HTLD7e+0HGmN8tcSBxeBY6CsZKMINbchq1uq7YysMHfLhuV2Iz
         sFk43biDoL/IqRf/zftDtEmroHNxJCPvzwzfL9pYO3MasQZ+sOhu7tgFckoOPkShq7/I
         UmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717461329; x=1718066129;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=55wy5hMiqIM/D1rd3GDpvg/HtGbO7BZblZ9Ox2jpi2s=;
        b=kSnvqiiwu6rS+Udxk3mbpPzDfJSuiSTYxWljRTw6JOe8BH1iEI2QMveoHQpXzPkSXB
         P/EpAMdJOuLrmeZviAS4tFP2z0RZp8K/0rVF+2mLIPyLfUWP7LlW/cf0B29h70snKhWU
         OtG3jFlaCB0+vq0UpOhdI0Wgmf/S4iDJHyogVV/Q5zIK4V7Ka0cFrQC4g0sc0Jxd3dST
         bnRF6qZ+T9dMDuN0qKPF3/rPwJcf/DCCVO12K9Sbmyb8kujqs8pQWizOSiv+Hkv+1CPT
         w/7muJqyNVdQ/OfpLHo1oSX2DagXghbNQ4J/8qak6UYsBNXWAuJOfF0oL421y0Mwfj8q
         dBBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIeF1eF1XxYKe7nVnqxFLl9JQ1wtfCgjHyxqJ3aSN9Y5SsXKtBskvJt417cWAeEaIGHz7W3TuD/Ge0Te7Hguph7YtcUfKP1HHUpxi+DA==
X-Gm-Message-State: AOJu0YxJZhvrA6KPersp/ijVNn6LWQCPsh5HGbPJFbUK73noR3HZWYBh
	k04foui64jBkRP/PKd/hS7cwMLRZMRh1Rb4ipOn2PxceRV/xZ3hXrkf0tGcQ
X-Google-Smtp-Source: AGHT+IH7GN4LutNeCgU+vVd8qrFyJypGY+ZwmC+mPwah8yLDnqb0U3qua1Mz6iBSz4sNgm5S5mFfuQ==
X-Received: by 2002:a05:6a20:729a:b0:1af:8fa8:3126 with SMTP id adf61e73a8af0-1b26f0f1acemr12407204637.6.1717461329316;
        Mon, 03 Jun 2024 17:35:29 -0700 (PDT)
Received: from dw-tp ([171.76.82.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241f3e4sm70873845ad.306.2024.06.03.17.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 17:35:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: linux-xfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, "Darrick J . Wong" <djwong@kernel.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 0/2] iomap: Optimize read_folio
In-Reply-To: <cover.1715067055.git.ritesh.list@gmail.com>
Date: Tue, 04 Jun 2024 06:02:41 +0530
Message-ID: <878qzlmtsm.fsf@gmail.com>
References: <cover.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


+Christian

"Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:

> Hello,
>
> Please find these two patches which were identified while working on ext2
> buffered-io conversion to iomap. One of them is a bug fix and the other one
> optimizes the read_folio path. More details can be found in individual
> commit messages.
>
> [v1]: https://lore.kernel.org/all/cover.1714046808.git.ritesh.list@gmail.com/
>
> Ritesh Harjani (IBM) (2):
>   iomap: Fix iomap_adjust_read_range for plen calculation
>   iomap: Optimize iomap_read_folio

Hi Christian, 

I guess these 2 patches are not picked yet into the tree? In case if
these are missed could you please pick them up for inclusion?

-ritesh


>
>  fs/iomap/buffered-io.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> --
> 2.44.0

