Return-Path: <linux-fsdevel+bounces-54440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED105AFFB42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE6A87BD3BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D6028B507;
	Thu, 10 Jul 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDW4cerU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A428AAFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 07:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133485; cv=none; b=iTeC+wP6u9GvtCe/R+4QfkamCnqb7QDjXIaz5mVFpErYLQTg5nDHE4RDFB40WPgLUPV5DdqAqlh7+9WuNX/ZDdjjZqyPE8+oLjk91KzNwnOeTFHW6YuwcNMzxAKNr2k2MnwqF9gffYBSb2lkm0qMEd3djYhnYF4xHjLAgpoKBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133485; c=relaxed/simple;
	bh=dLKZ6xonMBfo+rMYb7Iz9etepCUYXNOz/tpBsHWnvL4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtJRVvaRl0Kk0anAhMLJ+O1/oKkOC31776HNPhmq3+0AzoNP6fFyAgHf6XBeld3cV3IWOtKj6jI8rBKfhQvTj8cp3Sl+zFipXGC8ci6mIquT290xLu97pY6N8rKfcnORoSXGcNJzBcDh5n/7vv9S5WotPdLv3gy9+4pJLomy4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDW4cerU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso952799a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752133482; x=1752738282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLKZ6xonMBfo+rMYb7Iz9etepCUYXNOz/tpBsHWnvL4=;
        b=lDW4cerUoFTnmtG1A0lVsvdoFy+ekrhu7ubcuW2rv7bBZLnAevEtfZ+RtPLQBWfZb5
         VG0I0+CFnx5CRCZpMC6iZq9SOGwzQ/09vV7Q6UIfi0nDZJjekj0H+J6GoWZwRuglmJBJ
         +hXWkXfzFvYQxhZDrFLQ8VDnd0cXhsHIedjBqxrf3LefJUMmcfpHG0qjfx2FKl06W1Wk
         hlVrCq7/fcbgWNDXnIdjJ6M0XbkdNqNIGyhZMtzy4YuyU6XWtuVTpotzOnOCYgLVZ05t
         nn+6umlQnlZ0WHBR5PUFNC7K6DEwvXJlkyIcA82sUA8ehp4+iDLlgr01/VSd55jpQNN1
         dJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752133482; x=1752738282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLKZ6xonMBfo+rMYb7Iz9etepCUYXNOz/tpBsHWnvL4=;
        b=ux+paOxk4G2enIpBhDgjznZER1S/D0pR+ar71mmi9/SyBRn5dtlWKeLQ5mLRto1Ala
         25+9n92Cqo0Uk6sxAmw1x+0LbclNvFZtqU0Moi5NQJuS97QO5fYEihBnjQ1ABYscmQxy
         e8nbB8EPSNmgEb8c1lH6041CuUr24ob3vJmxoLAAtYWuksES7c+oirXyY7XJRuTnS6cx
         J9SbhDPX21Ozpk+Uvhm/ZUu5b4lUUfcf0YtB4a/UPquaHZGt04CcKChdSuhI0TLRhzej
         qK8LEhfTnrQT4HWu44qxxIboAyZgglDZuWO7YBoG17Q1vsGCnPRxh9UY/sriTNfzJtFz
         ACOw==
X-Forwarded-Encrypted: i=1; AJvYcCU90QPX9ERHm2cgVp7b2gUNw5Ns1MWcJVEG9dYt31uYTAYAu45EvEBnI/MA+xU3u4MSlUsOwSubXAeSYoED@vger.kernel.org
X-Gm-Message-State: AOJu0YwaPEYaxL021gBaNpQd00KdUPIQX0Lbnzxrs6W89+a3qLuSJa+K
	2ip62k0Yh3uCLLy8Gyh6VRqCLi+6LxNQQhRf8IQOln3gvuacMfQ0XJvkrgCuMOGjPJaBfZgLWbq
	zhD64BxoINf91kohaOIPdFQy6rHxJZC8=
X-Gm-Gg: ASbGnctEkL9rL0UezGyhDhh1SuXgJLJJmrDrcNIpxN+Fs8S8AVaQktF1pO9UIJyjc1d
	rwsCfwUCUE26T0DJqQrbcF7bF54pUnc8JSiRcKqB4s+g0A+ksshuzziUoLI8KlwrrbDYmqTWYWO
	J8mbsVVynU/KUjRgLJWgfUgjCYdaz7zG7r8WUmSUxPqEI=
X-Google-Smtp-Source: AGHT+IFOiTbAwmOYiNVMY6L4DE97HfZx4iYkfHQS1J4lko+pMVXDeF1Dc5Y17LH/pHUNEdInNxCsgmIh2RCQAqJ4dgI=
X-Received: by 2002:a17:907:d2e3:b0:ae0:c8f9:4529 with SMTP id
 a640c23a62f3a-ae6e712a442mr172135666b.49.1752133481660; Thu, 10 Jul 2025
 00:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
In-Reply-To: <20250710042049.3705747-1-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 10 Jul 2025 09:44:29 +0200
X-Gm-Features: Ac12FXymLHdalJTARaI66Ghbqic7RjvlrfWDdl6oTVc7QDTFs-w3iUA5Afu6QRI
Message-ID: <CAOQ4uxj-StNaqySGOpQ0JC9wXMkYpvdzxETX8iqW2p9qxKWGDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify: introduce response identifier
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 6:21=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> These patches are in order to add an identifier other than fd which
> can be used to respond to fanotify permission events. This is useful
> for HSM use cases which are backed by a daemon to respond reliably
> [1] and also for reporting pre-dir-content events without an event->fd [2=
]
>
> The first few patches in the series are pulled in from Amir's work to
> add support for pre-dir-content events.
>
> In terms of testing, there are some additional LTP test cases to go with
> these patches which exercise responding to events via response identifier
> [3]
>

> [3] https://github.com/ibrahim-jirdeh/ltp/commit/4cdb1ac3b22be7b332cc18ff=
193686f2be7ea69d
>

Nice test. See some comments in github.

Thanks,
Amir.

