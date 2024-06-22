Return-Path: <linux-fsdevel+bounces-22182-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C409134F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 18:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776931C2134C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D582492;
	Sat, 22 Jun 2024 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fzZWtfGf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320114B078
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719072293; cv=none; b=JA/K0NJYWWC/DFo1FUHOUj2yqglJ15zRjZLFXPg3r1TOjx0KvMKEPPqlSxqyQn+srymVYQXHaWZANp6kcBR5gDWMs+9/6ov9rdwx6SJz2ntsl5cZfPz9hebjaplhj9r+UFt8ctRsc9WanoTzSpJrw3z2ktyhNhv9i0+xORTYj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719072293; c=relaxed/simple;
	bh=3Lb+sNWPu4HFWDP4z1goC8OUUM/o8GRMbZm5+jw0fQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsgICLyvtgROkOZHO68LlFDE2E6VVtwoLnK5SjpU3a6MSlg1FVA3m8XFIVv5Fce4iSqXEZGtRaBRUV+s4ee9RECNV32AvQ+GYieJ2XyQ6FO1vPlI7cSot9XED64aWp/tI4EVezlHUMjaIXTyejE7hMkM9I7kUfRrII6+I1/O/2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fzZWtfGf; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so3237674a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719072289; x=1719677089; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WFzhLDArXIiKbzwErxgVnPt8QBdINKCk7LHSAqqpCVo=;
        b=fzZWtfGfH0/ymOZSt1+o27YyY/DBEMxv2Ls0ATAroRG1f4nlq8e+7vM/otAXepNCu1
         CNv+XZx0FBUDJ+iQkKyYIsDAJEmNUkBG5RkFENHZl6mbCgvRN1NGW8sluM/PedMxiG0K
         zX0/iEV+/L7ZypiDzrUqPPlGYxMzEDaKGalHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719072289; x=1719677089;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFzhLDArXIiKbzwErxgVnPt8QBdINKCk7LHSAqqpCVo=;
        b=pC+Wmjx5nNjEdN9uUmy9lN97HZP6fNITjOOO9koQN18dRXqgGzUkICEAjSYtasG5zA
         QXNKWxWYnfkjRF5WufC/NXc0P+Bj7HT8ecOc7l8CdDHtcEid0FFOcyM4FfKsZf2L24ig
         ixNc6X/+jqWZSltCmzZuXZGY6TpxvlG8HdRkuG6MOA2xVJpYZnE2eEMN57dRh/XH+E+l
         I52sJVwzyhaptTMofjTd9IKr86w6KVlNcS0THPvlrwtQnFKmmCkFIbWSbjk+xVjcEpc9
         dKWHR0JH0ZCiAj8W+JXhKOmDY+QkD5vrTcgSAA5xVJ+lL2IQPXO5QKiesRI43MSN0A+L
         u3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6t+snSWkz488Qj7PwlTXa7HRGiZMaq7Y0cflaFh/5vwPYiilWElGwz+oFmJJXQGK9z5SXxXUYfU2Y/5BA4BiEBZd9/H9648z4qVYPVA==
X-Gm-Message-State: AOJu0YydFiEYOOkrTB+j9YmG5PtMyV51UqMA5Ag7geBEl/ZG4/nRnu73
	Ewf40xjejBv9v8lxWbM1ilU/EtUHhAUGcj9NzGHs6K24XRZidlVO33uph7a4wt+HkdvrVcVtfxw
	cwyBgQQ==
X-Google-Smtp-Source: AGHT+IE6VE8V/ZQmTXUnad+kgbUnt1D8G8RvA94WRBcmAuNmvWdOjgx7wQFv1dYqmqZv4HuLWDT3FA==
X-Received: by 2002:a17:907:a809:b0:a6f:5c1a:c9a6 with SMTP id a640c23a62f3a-a7245dc9b29mr8032766b.62.1719072289182;
        Sat, 22 Jun 2024 09:04:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7246114f68sm4743866b.91.2024.06.22.09.04.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jun 2024 09:04:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so3237649a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 09:04:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi/Jf32S+ynZkJp3DTFfvh+9MzecoCFqoJBlb9rbqcT9xX1c6scddpls8P4NBGnpp7BNvQQBkLi4NCzPFjnqgv9lOuBURu1Oec9ubqOg==
X-Received: by 2002:a50:d653:0:b0:57c:74ea:8d24 with SMTP id
 4fb4d7f45d1cf-57d4bd71891mr210438a12.18.1719072288320; Sat, 22 Jun 2024
 09:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87r0cpw104.fsf@debian-BULLSEYE-live-builder-AMD64> <20240622160058.GZ3058325@frogsfrogsfrogs>
In-Reply-To: <20240622160058.GZ3058325@frogsfrogsfrogs>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Jun 2024 09:04:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJjJhfK_gFg=ZcQW837m0bfSLCxewLaAZPHa8gVJuiuA@mail.gmail.com>
Message-ID: <CAHk-=whJjJhfK_gFg=ZcQW837m0bfSLCxewLaAZPHa8gVJuiuA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: bug fix for 6.10
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Chandan Babu R <chandanbabu@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 09:01, Darrick J. Wong <djwong@kernel.org> wrote:
>
> On Sat, Jun 22, 2024 at 07:05:49PM +0530, Chandan Babu R wrote:
> > Hi Linus,
>
> Drat, I ran the wrong script, please ignore this email, Linus.
> I guess I now have weekend work to go figure out why this happened.
>
> > Please pull this branch which contains an XFS bug fix for 6.10-rc5. A brief
> > description of the bug fix is provided below.
>
> Chandan: Would _you_ mind pulling this branch with 6.10 fixes and
> sending them on to Linus?

Ok, I'm confused about what just happened, and I had pulled Chandan's
PR already.

However, I hadn't pushed out, so I reset things (and had to re-do the
bcachefs pull on top, no big deal), so it's gone from my tree again
until clarification...

             Linus

