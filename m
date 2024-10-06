Return-Path: <linux-fsdevel+bounces-31138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCE99220D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 00:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4531F21516
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 22:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7183618BC05;
	Sun,  6 Oct 2024 22:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1U/fJkiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68C152165
	for <linux-fsdevel@vger.kernel.org>; Sun,  6 Oct 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252252; cv=none; b=NiY/HUPzufusR7o1NwTs85wvsQSAIH9FCzqB+7mXLaFxf6ALjPwcgRNG4Zqwg/7e4sXqTs0iAfGoG8EhaLdzWP817gEdLGfob763NiFHFFcmWUxzOr0qmX40tte09QP97NEx5LJkQN9utsIwyCWarMxVZnPO7B0vIy9uIsHi44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252252; c=relaxed/simple;
	bh=AVMT2ksBxbHoyLr2X5OlhSzaVPcgiqa8Ios/l6Z3o9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSH6zGfaMSlJM6KjcWP8phbAgTfdQN2HRVNypeGUISt2HPT1dsxtC5e2P3yyHcwOL52odNA61FdM836plbyKVapV8kVDowM8zpInW6LjChrK06fjh2mRndAcMLzmClnMh18vFx6qIj51avy6qMqLIpVAv93aqsPUejZYOZ645q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1U/fJkiQ; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a3c6bc4cecso1046259137.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Oct 2024 15:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728252250; x=1728857050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AVMT2ksBxbHoyLr2X5OlhSzaVPcgiqa8Ios/l6Z3o9s=;
        b=1U/fJkiQtyYQpl1JHMV9qgmtZKiv22IgBQ4zxwXm7/a6bAXLMBhFd5P2A61maPFXAk
         JcZVpJiOsRRxTfwMmqxlbkNZ3GBo6BPmcSOcKbtWQ/yLG9WzvJlok643IhYzMaQ2mpPP
         P5qqLf6tZCIW5owzY9GPCY3AW4qZMr8sH806jqMfkg8tWUzihhREK5URqt4j3I3ymz70
         yc7gOKaCXEK5Di+MTORjH4/0Xi79oPykhNx4Jwt357HBiugU9DRKVF5DvS50lKZIG5Eg
         QTcPq4WPpHix13XBPfXQJr5hj0INFaVNdDolHzt6MjBgcSAhcazlHkQ469qhseJEmAzg
         DckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728252250; x=1728857050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVMT2ksBxbHoyLr2X5OlhSzaVPcgiqa8Ios/l6Z3o9s=;
        b=tXcVU1f/m9cWYU8a8W8HUjJI7NUARF5WRcp4BMsoVftpw56KKMlUgKNncvo3w2JCy4
         o1cSOGd98UlL4SmUQrLlSs7g+k1l23T5YFH2jDKR/1M/GodHyUzSw7ryQOnz4aDeasMg
         YcX149ODpCieudItOj1ZWupYVsHNIqfba3lpO1aCdKsiSZ9FYNrcIaKmKE7JEi51j7pY
         BA6c+rWNL8lf4a1q8h2N/bxz/Pgwb7twJJyto82nN93YHtsDDdTBOsQVnJMVMk5xZ9Dh
         XM3dN3NRQ0V5BZImdXb+U7Wsbmua8ozcm6Y/f0/upAPrmVBRGSSMVEOFeOk1ptkVwMB6
         LGhg==
X-Forwarded-Encrypted: i=1; AJvYcCWWHi1+gylCgcPXLgAi1FTAWBvp3ZBNvITmV+V9BN0X932kPVgnunBQNacKowZ53ml5rzc8C6U4OzKZaDWt@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjZM8xDM9mvNASsE4VX/pFn1Ci9BmUZD4Y2EVlbBHIKKVqqf5
	X6j7sHXaxgYOUl8C1QkTsibX+2hEvdnGjjHF5DiIkYn/v8HdN3e+wk2PBM9Y9/rnIoHpw4Uv8Ll
	NQ7CCBVMKSWlqc8DNbBCm+9C4t8siTmJjEKB/
X-Google-Smtp-Source: AGHT+IEhMp2OSt7XqbP4MYcacFLWXYXdwh/F2Py4xZcA4lLz/qCIm0hnmkgR5mRLKSopgCYsEWGoXbueD1YCbwt71o0=
X-Received: by 2002:a05:6102:290e:b0:4a3:cb2b:9748 with SMTP id
 ada2fe7eead31-4a4058ee453mr5315729137.24.1728252250091; Sun, 06 Oct 2024
 15:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002225150.2334504-1-shakeel.butt@linux.dev>
In-Reply-To: <20241002225150.2334504-1-shakeel.butt@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Sun, 6 Oct 2024 16:03:31 -0600
Message-ID: <CAOUHufbsHKDWidQwEUViPRw-snCUnn6JVvd1DnNefK6xhmPD5Q@mail.gmail.com>
Subject: Re: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
> traverses the xarray in batches and then for each batch, maintains and
> set the flag named xa_has_values if the batch has a shadow entry to
> clear the entries at the end of the iteration. However they forgot to
> reset the flag at the end of the iteration which cause them to always
> try to clear the shadow entries in the subsequent iterations where
> there might not be any shadow entries. Fixing it.
>
> Fixes: 61c663e020d2 ("mm/truncate: batch-clear shadow entries")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Yu Zhao <yuzhao@google.com>

