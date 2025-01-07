Return-Path: <linux-fsdevel+bounces-38507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224C3A0347D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017BD1631D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 01:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A2C18641;
	Tue,  7 Jan 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aQf0AcQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564652F46
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736213061; cv=none; b=Wg6qfiXV660B2hnJN92PqLTJ5aESM2hsULZBlfc8gk4N0qLmFokceceIQes4oLkTkvv5vaAbB63H/Iw6Ol9OLaqxzuOxEMRcFQ0LprnKBj8KSj5p9AyBW6bFVALSzZAIvvjl+W988972BLfll/nmYrFPo/VHlOEQ1ev5bKpEKOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736213061; c=relaxed/simple;
	bh=oa7BLax2vVLwTKNZySRQlJ5gQj0CImWlqaBcE1PQDYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DjZZF0KFYZU1D4RPFisay2TUnjHWOxdWZ4tTz8uGa4Cq8rH2LwswB7ZNcxfoZgTTzkAoLYKraerhB9lEz4rlShTiovu+cBFqx18fVznNiVZHXvn94YDzob2DM+y+o3dhtPfse3Elw6pGiyWYucZVzeDxCSELSuN3z+3ib8Dbdtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=aQf0AcQA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso202176665ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 17:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1736213057; x=1736817857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZPecWCgpba7sHQq5CdN+bg6c+cUTB9glWE2EXzfT+o=;
        b=aQf0AcQAijCKSENokV67gGaUMY7uj1H5sx998H/AsgRe16NyLGoA9bs+u87drG2SVI
         qds73hI0xAr5co5daNE06RbMkhwqNm0K9mZQM86rcGdnonRWPvBNnDD87VBvzNDCvNvs
         xUulZgYTIjoyFS2tIxRzVX/Atf13J2HN0llZcNZ3LFu1h6Jp/mbOorgfqsAST5V+IXxj
         dRZYXM6cZZOI9Xv0JpVIlLxHW9uVoPxwwynHFJGMZs7FFDDF0pqf9FngcsuCgOVJYOR6
         SnoZhQlt611ZdjxvqkA9zYDgumHB26qkjd4rUEio/qcbV5fPTlVgPaW6Vpf6Am3iR8oB
         pPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736213058; x=1736817858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZPecWCgpba7sHQq5CdN+bg6c+cUTB9glWE2EXzfT+o=;
        b=BKZch7b2CbbggXYdNk1lHk2Pxxq3OPABM3Dwuzb7hN+79iMVVH2RuIvVVIKwL3j47h
         aTSqGR8o8+f4ttfDGuPXUkwseOfmvEkQ1+PfbPWe9dqd3ZLDJrGsRYnM7FyciWd/irZl
         kzc4zdcpdf0LV1wJaMSYE9+T65I0Qv5z1NLgNVSVUe/z3BN1J6oYvrCyXve4C2IRsJdx
         NzmwC40gNwFD56TrnypD5IBwzn3ax3pW6wNOxWoeCaV2OoDSmqD2CnrcBE9qNDylVBH9
         qKx3NZXjx0uAk3ZhrNIYZ8mdEC6mpCHwxilUG14c+/rllJ9/Jo2alYTb6qTWq4IwPWtP
         CmxA==
X-Forwarded-Encrypted: i=1; AJvYcCVOgH6UD/WbtGY9rez1jMNjivRReB7a+eXyG4Wgx9F3EAQTWHFs6ZtbYn4Hc/kwqnmsACKAg4L8r8Av58rF@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUCrPneTKyw31fw1MOQVHH8Ak4UzFKbf1y0LegePi5RbM2BZp
	ZUOdJrHN8/ctT0jX3UCi3JrCVm0zyKLuqZHVK1G3E02fpoJ4l4GCSyiLoY/YJWtkqL0encVZhO8
	69wmeqaZ0lygKubg/H7tDNl9NIgRRnDRsQs3wlRWyN6mW7jE=
X-Gm-Gg: ASbGncs0ParP3CPNViat/8h8vJYtfaYffvrl9caCydIZHza1koLbAWTxxWRI61L0E45
	xFW4K+p9sBibar2zkIapRzjVwCwwxQrVxvDvDQ1Q=
X-Google-Smtp-Source: AGHT+IGxfCbhDsiYzXZ10koahsLwALN0WibBZXuBUkv/+S+3vs2NQ0VIZ42W4wWqWcJdy87TM2gOAcNKVf56f3j3rIs=
X-Received: by 2002:a05:6a00:918a:b0:725:322a:922c with SMTP id
 d2e1a72fcca58-72abdd20f53mr79384328b3a.3.1736213057605; Mon, 06 Jan 2025
 17:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105162404.357058-1-amir73il@gmail.com> <20250105162404.357058-3-amir73il@gmail.com>
In-Reply-To: <20250105162404.357058-3-amir73il@gmail.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 7 Jan 2025 01:24:05 +0000
Message-ID: <CAGrbwDRVE8GdAaHmS78yVR3wqLtGwPiR=uHaygcG0moemovH1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: support encoding fid from inode with no alias
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Sun, Jan 5, 2025 at 4:24=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> Dmitry Safonov reported that a WARN_ON() assertion can be trigered by
> userspace when calling inotify_show_fdinfo() for an overlayfs watched
> inode, whose dentry aliases were discarded with drop_caches.
>
> The WARN_ON() assertion in inotify_show_fdinfo() was removed, because
> it is possible for encoding file handle to fail for other reason, but
> the impact of failing to encode an overlayfs file handle goes beyond
> this assertion.
>
> As shown in the LTP test case mentioned in the link below, failure to
> encode an overlayfs file handle from a non-aliased inode also leads to
> failure to report an fid with FAN_DELETE_SELF fanotify events.
>
> As Dmitry notes in his analyzis of the problem, ovl_encode_fh() fails
> if it cannot find an alias for the inode, but this failure can be fixed.
> ovl_encode_fh() seldom uses the alias and in the case of non-decodable
> file handles, as is often the case with fanotify fid info,
> ovl_encode_fh() never needs to use the alias to encode a file handle.
>
> Defer finding an alias until it is actually needed so ovl_encode_fh()
> will not fail in the common case of FAN_DELETE_SELF fanotify events.
>
> Fixes: 16aac5ad1fa9 ("ovl: support encoding non-decodable file handles")
> Reported-by: Dmitry Safonov <dima@arista.com>
> Closes: https://lore.kernel.org/linux-fsdevel/CAOQ4uxiie81voLZZi2zXS1BziX=
ZCM24nXqPAxbu8kxXCUWdwOg@mail.gmail.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Thank you for such a quick and proper fix, even though it was the
holiday season :-)

FWIW, I've pushed the patches locally. In two or three days I should
have some hundreds of test results from the duts where the issue was
hitting originally. Judging by code changes, I hardly doubt the
original issue would reproduce, but might be worth getting more
coverage of this code.

Thanks,
           Dmitry

