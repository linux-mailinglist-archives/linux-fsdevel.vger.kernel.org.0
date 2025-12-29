Return-Path: <linux-fsdevel+bounces-72217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C274ECE84E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 23:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7346C30249D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 22:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6546E275B1A;
	Mon, 29 Dec 2025 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avIRA+c4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E1221B9C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767049107; cv=none; b=Nit6EE/qf8bMXMv+is1dYtoqlhjp8S7EdBlSjIXD8rdq9S9OjpXt8F8yU1Nz2XHS/vH9nsBFefeTZ/DUzryPPKJyv4fQzSC1XDoNEAiFUcrlZUQCf/o0dQxt6/1VWmKYnW86ATywaLWsVmJ8d970jiK3nBDvL4c+o2WjyMDERC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767049107; c=relaxed/simple;
	bh=YvejuZ5rkJHHfSRKsfGsxzG5R6RUfrN7Rs4zO7nTW+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTgsF1G9UMg3m2c9x8e3SbkLx/tfz/v/9BU8SutuWK9TdSahO59q3xAIais/dHMoWVTJQsBsXhrqbLmehb1Buq9wNAQa/DeHqHa/EtEv1E2LJyk9JroXpFA4A30HGyjZOHLTmUI2CnAiXqh+APIzR59fDCUjWDBxV9BzNuhENow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avIRA+c4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A415C4CEF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 22:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767049107;
	bh=YvejuZ5rkJHHfSRKsfGsxzG5R6RUfrN7Rs4zO7nTW+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=avIRA+c4VvXEaTocBoJePD887oOzLhfMAULw9tNCtMXDnd89bh2fcVK4p06pzNt5A
	 TBpqHUKb1kImZ1v42Mu9VJ3onUyCoDnRY7x96YddRTlZHk/uiEkDk7cRRTxxaKwtDv
	 LBDJGO+497kxqIB3BorSrVKJG0pFzLgVqBY0Ybh3RvFJe9LwAAFD+M24xOyDYaVRtZ
	 jnC4W9qxyKhPgnpFN08k+yFLwatDFvHXGbH51qk5O6R303bV+KvpXGIrC7loXv4pUX
	 OyqiVm2F+ZmDZtoo+lOClorCnzVb/t6PugCDmRhjY19QR2GVNVGC3avSsytpsQeMVb
	 sLXnQD15PweMg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7697e8b01aso1743578266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 14:58:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtigvVZT0nufakrEXXArN03NdVQuKKm5OTKrQq3lMFemZMfkpICrYjtj0x1VIgJiMPMOWvUAWqPRLRg1gx@vger.kernel.org
X-Gm-Message-State: AOJu0YyYyvYyR1aqo9ademouU9AQkRJzc+HfKUw5VOlWd741NtMxzUYp
	dz7cYMGZEHrNLCM/0VsCFLRY8Hc3b5cqq2QxOkVwi3VYBBFdTbGl7vcGTJk+W3zP3VZi3FwUmts
	hw80e4qUShEvb0P308rDJlQB1tXi0p24=
X-Google-Smtp-Source: AGHT+IEU+MPOMTQ76HJJegAAgAZPkZRGTPGxFpFBckK1yfHQ7NSDizpHCxQs6+QeCyS1AK9F3YRulL5NGHSjsp9NqQI=
X-Received: by 2002:a17:907:da17:b0:b83:3770:a0e4 with SMTP id
 a640c23a62f3a-b833770a15emr1218072166b.34.1767049105943; Mon, 29 Dec 2025
 14:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229105932.11360-1-linkinjeon@kernel.org> <20251229105932.11360-3-linkinjeon@kernel.org>
 <CAOQ4uxgNJT5+rGG5=yLwDhcSCBuFVr+jPZmYcM2q6OOpHDs67Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgNJT5+rGG5=yLwDhcSCBuFVr+jPZmYcM2q6OOpHDs67Q@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 30 Dec 2025 07:58:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-0d2mi+AEqRU-VWX8C3mqaCCTEJ_UCMy-f_UMML1EdBQ@mail.gmail.com>
X-Gm-Features: AQt7F2r0X4lgDznF0KqpRA28HCJpfD0sVOWFv6JckE3mOE1E9Ud4o_Qtddg1YkU
Message-ID: <CAKYAXd-0d2mi+AEqRU-VWX8C3mqaCCTEJ_UCMy-f_UMML1EdBQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] ntfs: update in-memory, on-disk structures and headers
To: Amir Goldstein <amir73il@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org, hch@lst.de, 
	tytso@mit.edu, willy@infradead.org, jack@suse.cz, djwong@kernel.org, 
	josef@toxicpanda.com, sandeen@sandeen.net, rgoldwyn@suse.com, 
	xiang@kernel.org, dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org, 
	neil@brown.name, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 12:38=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> On Mon, Dec 29, 2025 at 3:01=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > This updates in-memory, on-disk structures, headers and documentation.
> >
> > Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> > ---
> >  Documentation/filesystems/index.rst |    1 +
> >  Documentation/filesystems/ntfs.rst  |  203 +++
>
> This does not belong in this patch.
> Should have been part of the revert patch.
Okay, I will add it to the revert patch.
Thanks!
>
> Thanks
> Amir.

