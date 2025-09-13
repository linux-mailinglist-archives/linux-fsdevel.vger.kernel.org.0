Return-Path: <linux-fsdevel+bounces-61192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAFEB55DCB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 03:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1652F1C842D7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 01:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE541BD9D0;
	Sat, 13 Sep 2025 01:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHPnfVNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA8829CE1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757728457; cv=none; b=T9E9finPfkWZnuzuysCpCbz3Pb+ROq2FjOgGXnEP7I+HIok1lz5ymLpSJI5pfus/q37bKEJmoljPeIhQI2C4yatwu7RcL+IUiwpVe3bczOcxzuoWssWAfXK3bm5QY8GC4wW9Ma+HXxu5FcdE5m6qOR0wRd61hFmu+sp13D64zRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757728457; c=relaxed/simple;
	bh=joD2i+2W+ZevGW/dlMspjt3cgHEbH2SiUA5udZgxJX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgaPLQ9YIMyAogK7ETJLgUi3inAmTMhmsYDLfQ8yjv7+NwB1fYo7KmOwsO36AYHVVM4RFxrEHyMNekYaRQQJ1V8HpfvoQQXX2RhiI7gOH9QWuaTtrYDljhyv9KIW6iyncKGFRm8k4Y8uqXtZCylc3knEZurEP6v0vvVCZBrlPhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHPnfVNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B812C4CEF1
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 01:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757728456;
	bh=joD2i+2W+ZevGW/dlMspjt3cgHEbH2SiUA5udZgxJX0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EHPnfVNNibdsmYKTHeRt4H9ljKWBHNKjUjy+cxJX60HvfaMPlet5/JRnNIZrrzcGf
	 LJTxUOdbdix+TRq5qgbx0ZBu+colrro7k6qGBZbQHmSsky6FhsNGvOVOtw9mQpZf3p
	 HTS2754Zuslw4XgxN35ZT6EmwhnYU8RHtuP+sa0krgU7J+qFbYDJXrJZzRYhAQ5GyE
	 ZykMuWO2g8A25YAiZtPkqELRiFbm32hqe6eyVAdlYbdKF3lKftOHIFbCHtUjQIZP48
	 V+3oQROltq+WmEhHUGBXTeRl7TBTugQUk5Yv+LlJKO6LT/11Q5MsgY8bwtXnthvMQ0
	 Cdx0+5HnyEJAQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f125e5303so53938a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 18:54:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgRmY/kix38C6Aebn0n1LymTpGQK/0Cf6yn7uG5UPbKBGvRFBpPD+DNCPMgdgk4jDCKwHtSDUx4s3GHIni@vger.kernel.org
X-Gm-Message-State: AOJu0YwT57bKchtg+qpnDpjUtUxEQHd+XQjgxVBJpGxmZBLSDSZIPM2X
	QytlcQrr9CziLwhKrkzYmbMvon6phUQHsbsPHguQHjBNWke5rYH4vNyQmcB2EwRZ6CmaWCsKNDx
	7CozwIUKK6XvVyg8Yi3U7kLkEBtI3S6c=
X-Google-Smtp-Source: AGHT+IGIcCg5hZvNzLXvbV5Z9NwEcxBMyAHokxIXHB75jGGvKEO6R2FmbhBXRrXtPEItrUrRJ2c2mjBhKpwoszRCiiY=
X-Received: by 2002:a05:6402:4556:b0:62c:f7ff:3f5 with SMTP id
 4fb4d7f45d1cf-62ed80d0f6dmr4554030a12.5.1757728455046; Fri, 12 Sep 2025
 18:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911085430.939450-2-Yuezhang.Mo@sony.com>
In-Reply-To: <20250911085430.939450-2-Yuezhang.Mo@sony.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 13 Sep 2025 10:54:03 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-REYRHurGkpv+wEFNGXey0yObzB=Us76wfN0mCO8RLmQ@mail.gmail.com>
X-Gm-Features: AS18NWDm_GvNuWfB9Oy_p9o4acCGQqO_0POgNWYjpRZ0os14u-TsZSTc_KgXv_Y
Message-ID: <CAKYAXd-REYRHurGkpv+wEFNGXey0yObzB=Us76wfN0mCO8RLmQ@mail.gmail.com>
Subject: Re: [PATCH v1] exfat: support modifying mount options via remount
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: sj1557.seo@samsung.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 6:05=E2=80=AFPM Yuezhang Mo <Yuezhang.Mo@sony.com> =
wrote:
>
> Before this commit, all exfat-defined mount options could not be
> modified dynamically via remount, and no error was returned.
>
> After this commit, these three exfat-defined mount options
> (discard, zero_size_dir, and errors) can be modified dynamically
> via remount. While other exfat-defined mount options cannot be
> modified dynamically via remount because their old settings are
> cached in inodes or dentries, modifying them will be rejected with
> an error.
>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Applied it to #dev.
Thanks!

