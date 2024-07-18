Return-Path: <linux-fsdevel+bounces-23941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1779935070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F831C20E93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA406144D1F;
	Thu, 18 Jul 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBaJrx57"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5132E859;
	Thu, 18 Jul 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721319095; cv=none; b=YaFVjUwVi5MR1HtTJ4BzziXWLw/ZYIiI+uqfyWzUlo5n1U6i3hF9pYqTNCITILbNp34YX4GjTxIUehsdKiUrqH9ZBMMiMySXTZ2wXs/sU7C73ayrhg8QdqbuQuS4hTInqT31SWT3RN5kVekvnnK/pfO6Vz3p4QItyNWkI9CpvRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721319095; c=relaxed/simple;
	bh=ERw8AaqucXQ7roB1jdSUMbhAPPgKqkJzkJQHsW/J45I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioQYTcK3HlH+jnWvtehmMDYtRJnPS7C3KVxEGdR6Z78ZAR8oSKNdk8ZJRe3F4sVqN/tQhmcPj1673BPhpMh3/kV+9YkSylceAlmhwfT8kAGQN+8+6sBEU7aK2oMWHzhvZ12hYbC2/NIQdfFAuMe1q5Rx5zEhOIYqGgc9AFB2ibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBaJrx57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A72C4AF09;
	Thu, 18 Jul 2024 16:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721319094;
	bh=ERw8AaqucXQ7roB1jdSUMbhAPPgKqkJzkJQHsW/J45I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hBaJrx57ZM0rvuK83CpRgap8hn0axR45mBRUV2rbViQsOh5YNYL0qFveV3TKDzdhV
	 RGRX28a1qHPwev4MFthxaBYWvMuhKExzINkxv7b7fKoQc+c54pEDbhRCILmo7i2TZC
	 pPpvO8oN6uvN7UvcbDEtjAJ7L+yqQ0DpMmsYfD42z8ZM+bwgEADyEhIJZ/pS+bjJ1f
	 VQWoRvR8hT49ocjwqLlhHUFKM0AHdFygL/R1a5UB1TQlJ4LQ8G3SstMgnvqEkUNq7P
	 QuFQmpXTQm/zTeJS+6I3MXwNYDjQUI2a1XOb+cmKwodcaGQi/nfi796dE+XD+Ws9hW
	 tse5DoqBiyPGQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e98087e32so582814e87.2;
        Thu, 18 Jul 2024 09:11:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWj+kfnx8/I9Yv3w7xnYZgrJRYFvi25+/dsGsTM3jpL0Te6+CZkb/RDKBhckoEyTmn0u6S0o/qHgZ5Db3IJ4VA4ZPm6Vxku61dkpCgIelj49pLZA9GF4ChlnpZYInyJjPSqqgj
X-Gm-Message-State: AOJu0YzPKuIoq5XP/CruzqQkcPZFX+J3VH5ZBx09h0TvqbZ1h9Jh3cyo
	mBcwQwlhAH9iQS0lURQqRy9p5TAjJwj7PBsj1T+0WTLhn0ofRu7hitDA8d0FKw3+mRzUfFY0SI3
	HXRsCFUtrSI976aGdPVvGN5MPE2w=
X-Google-Smtp-Source: AGHT+IG+jfyuvmYKotuYHm4Ir0AOHbtapNW6a2hum+NEiwK61L7piKcGuETbAgNKGgwv3XSpoEoZ8A147yIij326Ur0=
X-Received: by 2002:a05:6512:3b20:b0:52e:9ebe:7318 with SMTP id
 2adb3069b0e04-52ee54270c4mr4081729e87.43.1721319093018; Thu, 18 Jul 2024
 09:11:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718155754.15499-1-dsterba@suse.com>
In-Reply-To: <20240718155754.15499-1-dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 18 Jul 2024 17:10:54 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4c8dMqE=Ms=T-kytXX6ZY+m2f7qM4OhLSkS1rfnOQn=w@mail.gmail.com>
Message-ID: <CAL3q7H4c8dMqE=Ms=T-kytXX6ZY+m2f7qM4OhLSkS1rfnOQn=w@mail.gmail.com>
Subject: Re: [PATCH] btrfs/220: remove integrity checker bits
To: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:00=E2=80=AFPM David Sterba <dsterba@suse.com> wro=
te:
>
> We've deleted the integrity checker code in 6.8, no point testing it.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

I think you wanted to CC the fstests list and not linux-fsdevel, so I
just CC'ed it.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  tests/btrfs/220 | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tests/btrfs/220 b/tests/btrfs/220
> index b98d4149dfd270..59d72a972fdd16 100755
> --- a/tests/btrfs/220
> +++ b/tests/btrfs/220
> @@ -192,11 +192,6 @@ test_subvol()
>  # These options are enable at kernel compile time, so no bother if they =
fail
>  test_optional_kernel_features()
>  {
> -       # Test options that are enabled by kernel config, and so can fail=
 safely
> -       test_optional_mount_opts "check_int" "check_int"
> -       test_optional_mount_opts "check_int_data" "check_int_data"
> -       test_optional_mount_opts "check_int_print_mask=3D123" "check_int_=
print_mask=3D123"
> -
>         test_should_fail "fragment=3Dinvalid"
>         test_optional_mount_opts "fragment=3Dall" "fragment=3Ddata,fragme=
nt=3Dmetadata"
>         test_optional_mount_opts "fragment=3Ddata" "fragment=3Ddata"
> --
> 2.45.0
>
>

