Return-Path: <linux-fsdevel+bounces-40940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968EA29667
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 17:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B377116A106
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23091DD874;
	Wed,  5 Feb 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0MN5YGY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E217F7;
	Wed,  5 Feb 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773072; cv=none; b=jRBsOIqqku1g7nqb+N8qM0+g6aTvuApVun1HB1ZGNKF4IV8HulHoTHvy8/SYWY1tPKg8eCptImNNH4rMYFWOke84AWRTdOupyma3s4b1JzeRGU/m48jNq94esFqNPil0ScuW3CARg6kaINerWa7Q1dsrGlJYU0EdVub7v124QFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773072; c=relaxed/simple;
	bh=o14HjDZwZTkbMjA1cDLGv53tXJJaET1yQGUKxvyX870=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bq3P0/TVqNs10fVd8MIsd7xZNg2wqnlZVlWjGqGULz1c8nNM+TPjZecnO3X10O/tVlbMjOk5nFy5hffeYvLgXaaQ6GAoih1+0033oqwC7sUp//pwNuwbkGw5OLOZcUzvGv+6iTDbX/jZ78++vqE8wCO2f+T5UESXla5ogYq7/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0MN5YGY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc7eba78e6so13499033a12.3;
        Wed, 05 Feb 2025 08:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738773068; x=1739377868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o14HjDZwZTkbMjA1cDLGv53tXJJaET1yQGUKxvyX870=;
        b=N0MN5YGYbYbpdaxvPtb8g2QTLhde5Xht7Nf8neLZLd+UJL2P3o/JaCrd3taaJgP8oG
         MpvRptsTgaqHDARFwI/wkSv87oWpDVqxO/uGb0u6WDJNej+wHaF+UXmeFlZ0kTjfJqtq
         Osyf+hnF9DpTFUPup1vOyTpGVNI6rT3EplJtR/u+BkKjwKipJoSzT5CiY4kpg2Nnuji7
         +tWUbQumcKTjbLb4NcGkRS607FwrIB6RzgzhLMt73HH/tF0Qgsj+U9Wwou1XpmADpA7O
         Ni3LZqZT/1xiExe/0988jpbkoNcFDVDnuZpSy039cQWV3FeuCKEhHq9Py8plSoIMHlqn
         d3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773068; x=1739377868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o14HjDZwZTkbMjA1cDLGv53tXJJaET1yQGUKxvyX870=;
        b=vXxxvhlj7m4NKxeFWu+HX+zs6TwatM/9FZljl66PEVGmYTYYQS7ydvF+A8Jtufy7qg
         8MN1mk8sIUu7vom8MWJjnHLms7xAdH0hfiqCi0tcxq+heegkEEqO/IKaj2bUA1+BgueS
         YsYhhcC360v+rLWY/aKHGX0vARx9LsMfbPlO9HsXwICW1qrETILwloB7sIoX6Nevo6yN
         UMWLu/BnrXkqAr8uFqbVjAvUOpjQvEzf7qJV3p923xEiOaAkJqz4c4PvtT+GqSewNGZ+
         GFI2TMACLsEuH40h26k5jhgO9XPCbnYkJ/Imu3KRMuG8CS7oyY7g16KWF1se/NWh1/Dz
         MGPg==
X-Forwarded-Encrypted: i=1; AJvYcCUWbqU2qi1EjBfrH30EELejhAOyV5OOcwh+tY5V7VM7fBMGJ7Ot80zYDRWtj0mI1l7O43N85hvRAbzph6X9@vger.kernel.org, AJvYcCWSeBLcyhWKHSrD17cwAJO0TeA6Gez29ynFm3XzbMFZQWRSc0BWZEN23sbgzZ48LKk26bJchidDKA62di8n@vger.kernel.org
X-Gm-Message-State: AOJu0YygIVjllMEWlvVJFKczeWAAJvtXtjrDvE1D4Fg23QIaW7BLn3Mz
	0rLlERaCpm6hKoUXPjzr850kna2rlUb7T9XqcLQFA8L87gU1rXtGBX3WwSNYW9eeAc+Xr+w8Msy
	dcoa0/xNnOFs1jTTED1PUuTarqGw=
X-Gm-Gg: ASbGncvtgsE89OtzF3Yn7l0c2UczgoiNhOPuJDWtGEYAGNy/X7Cu2jAHKtbgC8QcdFr
	hfCWmnR0W5rpLqE8Bh4vqL8A/hiKuOW18VUGhd3S4XozoDM9Y0BRfyT1txTg4B9ppmPOZa68=
X-Google-Smtp-Source: AGHT+IHxG6bhcPqfA38pVpk693fXgtu/9m7JhvLkUr9xyn7wEZOi1JQxTvXhTq8e3CZx6m4JhobUmZkA2/OGpPL4wzE=
X-Received: by 2002:a05:6402:239b:b0:5dc:ebb8:fe64 with SMTP id
 4fb4d7f45d1cf-5dcebb8feb1mr322780a12.14.1738773068259; Wed, 05 Feb 2025
 08:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205162819.380864-1-mjguzik@gmail.com>
In-Reply-To: <20250205162819.380864-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Feb 2025 17:30:56 +0100
X-Gm-Features: AWEUYZnQWZmm4yFeYCY7BSuRaqPgq8W_OxCuWdOiAIXhyvJ5BIW06XONAvnSf-0
Message-ID: <CAGudoHFTqtO+TN+LA+ga2t8-O_QwkOSNwnBEGr1mkj0YyPUARg@mail.gmail.com>
Subject: Re: [PATCH] ext4: pass strlen() of the symlink instead of i_size to inode_set_cached_link()
To: brauner@kernel.org, tytso@mit.edu
Cc: kees@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	syzbot+48a99e426f29859818c0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:28=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> The call to nd_terminate_link() clamps the size to min(i_size,
> sizeof(ei->i_data) - 1), while the subsequent call to
> inode_set_cached_link() fails the possible update.
>

oof.. that should be:
> inode_set_cached_link() fails to take it into account

--=20
Mateusz Guzik <mjguzik gmail.com>

