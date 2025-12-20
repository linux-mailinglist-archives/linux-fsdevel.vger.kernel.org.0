Return-Path: <linux-fsdevel+bounces-71798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCBCD2EBE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 13:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE49B3015145
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF4128816;
	Sat, 20 Dec 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB6QeiVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0ED78C9C
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766234775; cv=none; b=NXoWFO6htQlcVlCoKSordmZb1n5i+ZIkX8SzgMk9NApjm3vsYr3pCZG5PKy5e1U4t3So1mpXBLqW7rfVAmebJTqpV/uKOrlP6Y5V233S7XQ4jCvUdrzr1nz5NBX53hsU3/u/S1TRYY1Ji1NeJT4E8afszLJpsnqlbyc+h8PB2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766234775; c=relaxed/simple;
	bh=lEAIC30CW3cfVpuFvw379cbXF/LzXBsk7PMbS5aqSnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB7itbxkdK+4/ktgazpWQs3mVL5/8mbbOxJbQ+ZbzW9LlNqpu7oWsOWf6UCKDIKjdys4jDXYs4dx4WaIZoQq1+F2e2Cmn/xZ4wQpxR+gPVEWyIU72jLw9PMUMKnAABjCCIT5BtKt8siZ2v7GhniVkppYN1ckR249DCzMWSheKRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB6QeiVB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b727f452fffso600189166b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766234772; x=1766839572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j+crc1XRxP1FaSuxaQUE7HQa1bVS4Xw36Ry1tL7qVSo=;
        b=IB6QeiVBW10MRAct3CqUvtEVCmat249StP5q/lPdqZFjg11ItESAg/jUOMNGBMOfcs
         JYlIZpkRuWrgh/FldU3/r6wM/X4y8kLk6946wkmudPx2o1chi/MGgNNNTsAYbfQ1dr0K
         v7+sNZXdP6LM1Jb9Kc28mOORCDALczF2xA0NjgHcQdSwxXhHpgDZtpp/AsX24S3zWcVu
         7Ff+Nq3QlK7V9S+ifYF4oPWX3V4Oe1Ww7XZShZHe/jsQy92vTMuU7pFHajBtmCwfG4NL
         FHqIHgpF0zml0oZv+NWvyparxZoykVtSLr96u+HqDDtgqP8y8BcEqGtGwWbude5NEaD7
         P9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766234772; x=1766839572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+crc1XRxP1FaSuxaQUE7HQa1bVS4Xw36Ry1tL7qVSo=;
        b=uQLzBZ+MJHxFhRTUyFHf35yCdvOjaJ0SY7nCng09IsmxakJxSrWCN7oo4j5IgmXjib
         TkXvUrxeGKG1jXbO5AwmWhx8PP2MAw3KGXHSjAA1eq8Jopn78YDIn1NkShzsFbKZbH9W
         S6dm4pwC2PcGuvBj2nZj5Pja5Z97Igsazt7Lgb4Jp/qtNWSN6xumTvaTfQo1/R3MoVjf
         7+JMsiAUkUvNJQUxZzCVV6dCsgHruTqW9fhOSI3f0O+zHg4upaMkem81HcDexmv/zW94
         zV0Fv/fKJshWE44MxJk9NPUrnqkVxvGh3zZCklQW/l36M/oEs+znToBsPu0lN+0bQIlS
         6q0g==
X-Gm-Message-State: AOJu0YxIryYXK7axPDdHIpxUBNOpIT9Rmlqvupsa7HxcXV18La1scyw3
	KmrvvmW8wEjc3nSmU+CnP/7OHKzuV3h/s3t1jeFrfqj3rJOnCDzJplnzmdC+gP7SBWrZS1+OJZU
	2M93ESdvsUfcY6/1p6g5NUodtMS1XcEoKmJrB+6Q=
X-Gm-Gg: AY/fxX6UB299fzT6muGysKdF7UkZLmWV3z/yJ/ynmAbk0XJi2FEl7P3L4PD8oTou/dt
	v6zEQq2s5NIFRMqklNQSsfY8JvF6Do+Epz6WiWz1KOc+u0fq6WNwgVWPaXUc9NVAQY8nH7JKEVT
	mSlsP7tDjijoXjrQnPZA6imnBU/7gA+KwPc7mXgx/ejjs8tSHGNe1ItdbYcG14zkupm5PnGFM/z
	OxryLhI72iZLvuPN0GUzpklcaul0HPUZtXHZV5SErTmNM2qGSkDV3xxoxQ+Kd1SmAxxLqfi7uLD
	t3NBxe8=
X-Google-Smtp-Source: AGHT+IE3f17E93ZJwKsL6suyOOBWzG0yJmuJmpY0yU3JkxbAvrGbICEUbsTXdCNQ1uEtjuTPpVmWgVD5YXux+cI1+es=
X-Received: by 2002:a17:906:aa05:b0:b73:37aa:87c0 with SMTP id
 a640c23a62f3a-b80205decbemr649543666b.23.1766234771899; Sat, 20 Dec 2025
 04:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219125250.65245-1-teknoraver@meta.com>
In-Reply-To: <20251219125250.65245-1-teknoraver@meta.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Sat, 20 Dec 2025 13:45:35 +0100
X-Gm-Features: AQt7F2qJPf7Uwxasg3-monuosrfnezJf9X-oOCQiC1E12Zqs3SN8jcvADupc6BY
Message-ID: <CAFnufp2YtYGioCtFyTpNufh2Kc3=8HRrpfTdsF9pZ6O0aCkSdA@mail.gmail.com>
Subject: Re: [PATCH] fs: fix overflow check in rw_verify_area()
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno ven 19 dic 2025 alle ore 13:53 Matteo Croce
<technoboy85@gmail.com> ha scritto:
>
> The overflow check in rw_verify_area() can itself overflow when
> pos + count > LLONG_MAX, causing the sum to wrap to a negative value
> and incorrectly return -EINVAL.
>
> This can be reproduced easily by creating a 20 MB file and reading it
> via splice() and a size of 0x7FFFFFFFFF000000. The syscall fails
> when the file pos reaches 16 MB.
>
> splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
> splice(3, NULL, 6, NULL, 9223372036837998592, 0) = 262144
> splice(3, NULL, 6, NULL, 9223372036837998592, 0) = -1 EINVAL (Invalid argument)
>
> This can probably be triggered in other ways given that coreutils often
> uses SSIZE_MAX as size argument[1][2]
>
> [1] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/cat.c?h=v9.9#n505
> [2] https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/src/copy-file-data.c?h=v9.9#n130
> ---

I've found a simple shell reproducer, it might be worth adding it to
the commit message if the patch is considered for apply:

$ truncate -s $((2**63 - 1)) hugefile
$ dd if=hugefile bs=1M skip=$((2**43 - 2))
dd: error reading 'hugefile': Invalid argument
1+0 records in
1+0 records out
1048576 bytes (1,0 MB, 1,0 MiB) copied, 0,103536 s, 10,1 MB/s

Thanks,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

