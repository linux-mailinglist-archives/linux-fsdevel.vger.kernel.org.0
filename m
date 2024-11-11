Return-Path: <linux-fsdevel+bounces-34335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8B39C4898
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96731F2172E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0F1BC07A;
	Mon, 11 Nov 2024 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TI/eJjQY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9541BB6B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362155; cv=none; b=ocXlDdgpnYpMhX0nIG4OLRTFxzKqzZ72DFQ1lmjh5H6iCrBbehwjS5Ae7jeCXsn2lJ0rdp4PhUtNMc/P+OU3fA2LH9Y8bBPsZJWM3wGzlKp8JWwaegdqM3V1wo1ClRSTGPuR9zdX7qxsOeNT8aVV48kgTYojT8hA9J8RZdyOcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362155; c=relaxed/simple;
	bh=SZIQDa8NLYM1ipFkY+LfWhNba2RshbH0DPtK6JH9h1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p94i63tYkz5Gsmt4MzO1nyeNu7s3LI6vdW1PjsOfbh/NxulwjaF0gdI/sOip++Y6OC7S/8YWeFCOPpXdmTnHCdBwIl5qD+r6XySutv3TI1TP38ehDq5Q6ayB8zShuobTpx8FZ7+aRiD3gb2oxxs0zmDNKkybB5wKDiOXQZMKP1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TI/eJjQY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so6923384a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731362151; x=1731966951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=TI/eJjQY5n2/fQZ+6DoN02J4woFPIMbfzepQLualFan0DIqJvbYUew91nP+OLv7o//
         wBR4vPUvB8vRcSBirxL+GfPWQ/5PKKWcYhxy1nVmcc4uo2pF4A+G9ogbN5S9WFwBaOaM
         7ubNNrv9DwD/ClPeLpLmbxuNw4brv9+owu34c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362151; x=1731966951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yUAbMKFGFD+r6n6bBm/WiyB3YmOPXFQ3bg8vJC1p2Q=;
        b=Ud7k18lGnU2GzLSUE4bgELBoqFtM6efxRyQyNnfV56+J5T4p+c43nHr7b5X2s3VDb7
         HAARsb+hWt+15ot7TzrWwibVR+Wq0zEljsR3lVRQpV+P3f0+wJF0fwybIJTGb4DiBWti
         T23b3EpCk7SXa8S+Aw/ZMvqjP958ROQyhJXVLUEIvU++CiHoEtslr3GI+oAGPrfexRrO
         3XNZiownG/GSNerV6yxngR/rgSIXVGji94fU3S6bQqisDoLmlQXp7ODN/ERknpEtVhQx
         j7iW2SWNe18nTK1RnzM5JEGR2O/4PkwB2MttZElaxqmfS2a/omOXEuIMSIKySzjq02Y4
         K6pA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlOBc3O1JzLIS2q+XRiH4M4ie6pf5S99SAfYd46PHftqZS9mpa2CchHnVXgVVeZ8KyPoR7dpSmsabCygF@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOtQosysPGO1b1/KsIdXztvOTNbsgUQf7rNl9dlu2N3e4m8NM
	pTkxYfZKUlg+h3phTkQmRB7YvQAF6KlqdTkS2rXi+D+ScTtx+QuqCjaBmFkMv+zhyxezMS/sQnQ
	vsfI=
X-Google-Smtp-Source: AGHT+IGTk0IT3bnDz4DvZTYSEcGl5wXYA3SEZfFTv9lLZtSVnqh/unra4yW8wZQ3C1zy3otcIOZEig==
X-Received: by 2002:a05:6402:35cd:b0:5cb:6729:feaf with SMTP id 4fb4d7f45d1cf-5cf0a3245ecmr11703386a12.16.1731362151503;
        Mon, 11 Nov 2024 13:55:51 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d787sm5322405a12.2.2024.11.11.13.55.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 13:55:49 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9ed7d8d4e0so768103366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 13:55:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjPPkSO5tf4S/ZTEnBXuqgj3g7wTTAucsTjjGIPMvKeYhU4DOAgRogEp+iaUOS7am9Kj4cHjjUTKDBkHUE@vger.kernel.org
X-Received: by 2002:a17:907:eac:b0:a99:379b:6b2c with SMTP id
 a640c23a62f3a-a9eeffeee33mr1449197766b.42.1731362149380; Mon, 11 Nov 2024
 13:55:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com>
In-Reply-To: <cover.1731355931.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 13:55:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Message-ID: <CAHk-=wjUDNooQeU36ybRnecT5mJm_RE_7wU4Cpuu7vea-Tgiag@mail.gmail.com>
Subject: Re: [PATCH v6 00/17] fanotify: add pre-content hooks
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
>
> - Linus had problems with this and rejected Jan's PR
>   (https://lore.kernel.org/linux-fsdevel/20240923110348.tbwihs42dxxltabc@quack3/),
>   so I'm respinning this series to address his concerns.  Hopefully this is more
>   acceptable.

I'm still rejecting this. I spent some time trying to avoid overhead
in the really basic permission code the last couple of weeks, and I
look at this and go "this is adding more overhead".

It all seems to be completely broken too. Doing some permission check
at open() time *aftert* the O_TRUNC has already truncated the file?
No. That's just beyond stupid. That's just terminally broken sh*t.

And that's just the stuff I noticed until I got so fed up that I
stopped reading the patches.

             Linus

