Return-Path: <linux-fsdevel+bounces-60460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040CB4789C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07444E02D1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Sep 2025 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9524518A6AD;
	Sun,  7 Sep 2025 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3Z5mY0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B92A1D1
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757209519; cv=none; b=UbeTGqAErKksqNhBc0dyqhDctqMNzm7XIYROOGH0zvUG3Eda8kLc9QKmLD4GlePJzVqsdG/v9Thc8vWK32pVD301gjJzL33C+HzaXXqTu8xAAvWnisVeEMgamzVcbT1+jgfbwFN3iqPLl+rZiWGYjUS5u/FO1+lG5gAo1/Q71NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757209519; c=relaxed/simple;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbqE+1DwEy2q7z8tx4iZdxVqWNxuc+PWPCpvWS2kfkpI748ZB51KRG8fUQ/v9jQzl0CoJ6Z1ZnjwbYSZpSBXmTcTBsSaR/9frt+E/ulOYe55+NDPcnC6w81J/N09I87RltAIWY0rYV1c3dPOGDJJ0Eud9XesOpoNoPy23diSMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3Z5mY0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093FC4CEE7
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Sep 2025 01:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757209518;
	bh=slsA3AoFQ8MJDsBCWbRmEEWJ1tU8e7v2VNnoFU+tPMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u3Z5mY0xpk2A/YVLSOjMP2MGKk0+oOcGOjYVVvvFPUgl85epRUoTf4nkQbOI2zK08
	 35QJqUnBp0X8aKjBiiSwJV4eYwjNATdgZ+7dlGk8gvSco+V7b7fNWHoRHd4qGY2OMa
	 veQBeB1umzgzFyEFgalMbswPtHukI/ZDOpesSQ/3f3Y4FWPbCzor10z52w2W6U7WsL
	 znZxKs4XgtjdJOBET9BHtsRlphIvuUflpwlF+C3E/Bqlx6z34KFG00vVXJfFOwKxRI
	 8JVIMQZGYrJYUr/enj33fr66rs5oJnWf95FpEdbllfCVPNtfQLzv7+DhTXgKedY81b
	 hZRML7Q/WPPsg==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so4665192a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 Sep 2025 18:45:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YxL2YGGbibe0CARKkPf1aL5QkeViKR13Ip3oOiQDlopQt2im4Wy
	OYwMuvVenwMn4Jo3pXqSesBhXimmTtUXuuKRVznOHrEcicGuPhA0a3gI4S7F3lcf/P11HEUMiiv
	KY6HZIldeozD8MxwunsATTIZNeFMJUFE=
X-Google-Smtp-Source: AGHT+IGGHw9nxpWsZb34HvOhotvSYmSsEHGkLgZ98Li7jSitgVS/9T+zL045Qf+1HaLdP3lEXEVbEBHmrnYoJBOlrRY=
X-Received: by 2002:a05:6402:5cd:b0:61e:1636:aeee with SMTP id
 4fb4d7f45d1cf-62380d6ff8amr2799047a12.38.1757209517112; Sat, 06 Sep 2025
 18:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906090738.GA31600@ZenIV> <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-10-viro@zeniv.linux.org.uk>
In-Reply-To: <20250906091137.95554-10-viro@zeniv.linux.org.uk>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 7 Sep 2025 10:45:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9_rSbAMk_i7K09YUuU_-N7k-z5Mb2cnopaT2sZLte14w@mail.gmail.com>
X-Gm-Features: AS18NWDd0p69y_q540nkyX_yH3RU4O1Fm0j3hdsOjeNCukjSq4WEjxVlPN2JXsk
Message-ID: <CAKYAXd9_rSbAMk_i7K09YUuU_-N7k-z5Mb2cnopaT2sZLte14w@mail.gmail.com>
Subject: Re: [PATCH 10/21] ksmbd_vfs_path_lookup_locked(): root_share_path can
 be const struct path *
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	john@apparmor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 6:11=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

