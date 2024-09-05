Return-Path: <linux-fsdevel+bounces-28671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E396D048
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130181C22223
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F722193068;
	Thu,  5 Sep 2024 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPeObIbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B272D1925BB;
	Thu,  5 Sep 2024 07:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520917; cv=none; b=gTSYUlO5LNupQwEcttqnhUqdIfS8v+L8fktKoIkwrnO70qXcVDfDZymkbWhJN0nQwqHB/2C1UfUzjb2YBaZR/46Pg7Xv1xG+1WXrqaGLP/ogyGE4Ntyz19/xHJ5nesazEbvZOWvTr/9aDQ64JGBQGnYAa+xtJxjsL2ooy0tNx9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520917; c=relaxed/simple;
	bh=RheOW5bp0YfdU85/WjszyWOJq5xnVk0vNk/uIoPthP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAYZifJflPXnQTDDSffMGyyYpJqkmlS5m/fkljsCfDKKAdUp5oVFYYwT5sYNyH59Xs5M/k7ZjK5Jy1NXncJiejP2VWOLCjhJKEeIgMPHiMaIQh7vicONBG/GPFQ80aHhlhzXX7SHPKynaJPwdxRyYUxMa40dr4OnJA3SjoKIf8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPeObIbE; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50108a42fa9so180639e0c.3;
        Thu, 05 Sep 2024 00:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725520914; x=1726125714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNFdaq9/1QFJM9n5NBuXb+y1sEZGaPPJ/M/whqgcWJE=;
        b=nPeObIbE/Hu8mZmzFN6KE/W0f5JndXvIwiXhmCPtum1pLhAu67kzBJ95ksNvS99xvb
         dKtif7l59pQf9QFdISTwOcpZ1dW1HyZc6+Gxbgn38/tiINYNc2617d49gIRMxVH+hKHM
         Ow4P2ba3gRWI6NHHV7hhXubE/x1ghiY5Ogt8r/yuDUx9WjjGULDBEMUFoXKbUKKzacbL
         fGVhYe0n2ZIDm0n6WlTWt9wwIgJS32kxxfErqeY8bEuw8bbjjGVoTg5HpoPRAk9Mebtd
         cgbvMsi8wtduSpCQIdAcK14YCNd01TIm1VbLf7J/1onU9YMAZI2amg1v3PLclwbhvXng
         nxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725520914; x=1726125714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNFdaq9/1QFJM9n5NBuXb+y1sEZGaPPJ/M/whqgcWJE=;
        b=Oq1mkm9838tVF8AVh0982G30JnVElMHn+AWynnHbau1k6xH90qXWZ8p1fSAW2Yh35W
         3KrYqdnICc2v1PeemGw4dzbDl9xDZqZbQEcV4hfMVlHMinxy8vd36yDTOCYlWQOKNY+G
         erQRJoc8T3X6OoDkvW7nV+gHGUAgGhhAvMYjn7+X4GcW2jvU5Pkyq6EE2HmhzURjhO1+
         LYmMaJAQQFsgvdiHBKYXIzBnDk+DeUIUvY17iAq7Z+qum9U9o7IpArp8QrlTmIAlxG91
         PeO9wrkTSFidLW87OXE5g27Zo5w5x7aE+F35iSFcatgX0Jq6FvowyH8LBw0QZ0FEInx9
         /vaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCbID+uoyKiRHaPtqkQQlbjqRbKY3DTCUa20YJeiuOpkQWz6nMFq1rrUe3Qxi8tQAZ1qQ0DqZh89OqcKBt@vger.kernel.org
X-Gm-Message-State: AOJu0Yws+u0WZ+R8mFHnOB0RL8tBvV2MMXnaHi0b3ypTZQwBORMFtV9/
	rb9coHnj+LVD47FCronKRqgKUkNrAXLfS5qYs5a4+4hCSCU0CCdItbH8ieepXfppEMFh2LXuLMG
	K+WE5tAIGA+21WwJyxrt7ODWE7crd+dYX
X-Google-Smtp-Source: AGHT+IEvSvGTteLC9qI41FT+CcdSNLdZApctIx8b4J4c2JhHVX2G60Yc5YfhPWxH1DCFQLcfbwpymLFvKWlhuflN3+Y=
X-Received: by 2002:a05:6122:1805:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-5009b12ef72mr19979469e0c.10.1725520914326; Thu, 05 Sep 2024
 00:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725481837.git.josef@toxicpanda.com> <01dd22e13ea532321b968a79f6b88d6b4dd23e4e.1725481837.git.josef@toxicpanda.com>
In-Reply-To: <01dd22e13ea532321b968a79f6b88d6b4dd23e4e.1725481837.git.josef@toxicpanda.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Sep 2024 09:21:43 +0200
Message-ID: <CAOQ4uxjp13F_auDv8-pJ6jGHwjpz30Oock5xQfVexv0PDnmJRg@mail.gmail.com>
Subject: Re: [PATCH 2/2] fstests: add a test for executing from a precontent
 watch directory
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:33=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> The main purpose of putting precontent hooks in the page fault path is
> to enable running an executable from a precontent watch.  Add a test to
> create a precontent watched directory with bash in it, and then execute
> that copy of bash to validate that we fill in the pages properly and are
> able to execute.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Nice!
Same comments as previous patch.

Thanks,
Amir.

> ---
>  tests/generic/801     | 64 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/801.out |  2 ++
>  2 files changed, 66 insertions(+)
>  create mode 100644 tests/generic/801
>  create mode 100644 tests/generic/801.out
>
> diff --git a/tests/generic/801 b/tests/generic/801
> new file mode 100644
> index 00000000..7a1cc653
> --- /dev/null
> +++ b/tests/generic/801
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 801
> +#
> +# Validate the pre-content hooks work properly with exec
> +#
> +# Copy bash into our source directory and then setup the HSM daemon to m=
irror
> +# into the destination directory, and execute bash from the destination
> +# directory to make sure it loads properly.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fsnotify
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -rf $TEST_DIR/dst-$seq
> +       rm -rf $TEST_DIR/src-$seq
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_test_program "precontent/populate"
> +_require_test_program "precontent/remote-fetch"
> +
> +dstdir=3D$TEST_DIR/dst-$seq
> +srcdir=3D$TEST_DIR/src-$seq
> +
> +POPULATE=3D$here/src/precontent/populate
> +REMOTE_FETCH=3D$here/src/precontent/remote-fetch
> +
> +mkdir $dstdir $srcdir
> +
> +# Copy bash into our source dir
> +cp $(which bash) $srcdir
> +
> +# Generate the stub file in the watch directory
> +$POPULATE $srcdir $dstdir
> +
> +# Start the remote watcher
> +$REMOTE_FETCH $srcdir $dstdir &
> +
> +FETCH_PID=3D$!
> +
> +# We may not support fanotify, give it a second to start and then make s=
ure the
> +# fetcher is running before we try to run our test
> +sleep 1
> +
> +if ! ps -p $FETCH_PID > /dev/null
> +then
> +       _notrun "precontent watches not supported"
> +fi
> +
> +$dstdir/bash -c "echo 'Hello!'"
> +
> +kill -9 $FETCH_PID &> /dev/null
> +wait $FETCH_PID &> /dev/null
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/801.out b/tests/generic/801.out
> new file mode 100644
> index 00000000..98e6a16c
> --- /dev/null
> +++ b/tests/generic/801.out
> @@ -0,0 +1,2 @@
> +QA output created by 801
> +Hello!
> --
> 2.43.0
>
>

