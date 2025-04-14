Return-Path: <linux-fsdevel+bounces-46377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F1A884A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99416190096D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3629116C;
	Mon, 14 Apr 2025 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="e/ZwtEiL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8FC27B4FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638601; cv=none; b=bAoFFJ4eBr3eJgwjnG0Y+uU5k3pry28Kkq7KopFTagYr16fF3zayGO5/ErseEia2rRSpncgLO32AbOTEq273kK49vybpq1h+E5PEynnXV3pYYF+Q8JOHKiL1gzvb+Ytyl6klukv+4l+BE9CKt1NgcPXGkGXGtQUCGa3e0WNn5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638601; c=relaxed/simple;
	bh=9bY19X6s1XcHU0Bp+zVhPyp51N++cEtOnYIuBK8fw2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIfLz58JPtt7+DHKFpKXJy4P+1/Qjy4qbjECOgZEiAKQOMxU7hmY/p72ISSqXFNK9PR3MsFOO05KuJiu1KveHQtumtSt9lOsc2c5FAFLKrNSANa5qCNj2PaailQFZpeAkANJ3vsMa/yBbiMSfU6ScPQjTI7EPYlr6USUrgfGWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=e/ZwtEiL; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4769bbc21b0so38388321cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744638597; x=1745243397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9bY19X6s1XcHU0Bp+zVhPyp51N++cEtOnYIuBK8fw2Y=;
        b=e/ZwtEiLPSuRgSFQlJwVQZDV+qAt41LrLjenc8rbwxaijIhqHcmaOe5xUg8whGjlb3
         7VKRtZxJtZSgC5s2VmZ9oZ8kPqXpDeI6K4LJ6PQup6pbN8sHVg1VdwwXLzlqxm4m8reV
         YkwxuQhOxu8YQl8+My2ysPba5f6S014DbRyd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638597; x=1745243397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9bY19X6s1XcHU0Bp+zVhPyp51N++cEtOnYIuBK8fw2Y=;
        b=WK2JH/ZvQTbsKCl4OPa3YbE7Gx6ar1CyLLL859L+h+Y4oMyGSpTa2v18+I9KZP/XT6
         /0Diq1kmxXMMoaxuS0IBe89MxC0gmL0diugIl6rLVf33KyzmnHY8M8ZkWetXWY/HcAEs
         Dvp0l51rJ4KFC/garEO/KAWdMCo3Ng4Pwq5E4WOdmlPZzAPvzhrVFlYA0PiscZ9FxOZG
         JzdGddhVtE2GA/cpqdSZ3uuqI5vh5uqkQoFotDHoH4b3JcL3kg+b+ObzYJkkuaAMLCxB
         MGJqmWnVFKwnRfyZjugYfuM1q2RYb9ygqu57GMVILzjcxQooKh7aqTT/BxXl++d6nssA
         3F6A==
X-Gm-Message-State: AOJu0YxqzxPrbONeX7StIhFOw8U0RyueavXemPgIx+T5jitFL8iF3/nA
	+qmgPYQ2A4M/x6Rsi/+qN5MPEHieESysGs8Czu3McorfnWrZoHvmBXxT3RXIUiQMuZioncPPAsD
	xo0jyT3IANgDMfu0evQ0CPy1QTjiu1w+DgNwZdnHVSbu+qWti
X-Gm-Gg: ASbGncu5JYgTiluv84EpSv3QVrk2lsOWUr92QSXEhjaEC+YPqPK4klY+l98BKZqVVma
	rIrBzzx33VemYAY1zRvaXG5p/NTZYSWsdgSpFPekBzVLnPy4AFkjDthZDv9syH06et/j0cUD5bQ
	ivlrO1/ucSYVxOxZqityg=
X-Google-Smtp-Source: AGHT+IEZnx2ua4BNTwwSY90xVl9/DsFfXFO/2jCY0FjwTjZbpcGwRMsGVneaA3gXMQIvMPRCpa5zRDyI3qKpKbF/JuQ=
X-Received: by 2002:a05:622a:652:b0:476:9b40:c2cf with SMTP id
 d75a77b69052e-479775eaa53mr209840541cf.50.1744638596951; Mon, 14 Apr 2025
 06:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_F1DBC4D1F22658222170020AC7DB0B4CF405@qq.com>
In-Reply-To: <tencent_F1DBC4D1F22658222170020AC7DB0B4CF405@qq.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 14 Apr 2025 15:49:46 +0200
X-Gm-Features: ATxdqUGVRx8qh1Vx9I4nLgse8lILHVF6-1K_zzvhAe6AotPhJh8_DJGed1KytJk
Message-ID: <CAJfpegv4eAj7OL0AZJhtyvGenet5iF7cp3yKA26BuWucRW+hNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/fuse: Change 'unsigned's to 'unsigned int's.
To: Jiale Yang <295107659@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 09:30, Jiale Yang <295107659@qq.com> wrote:
>
> Prefer 'unsigned int' to bare 'unsigned', as reported by checkpatch.pl:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'.
>
> Signed-off-by: Jiale Yang <295107659@qq.com>

Applied, thanks.

Miklos

