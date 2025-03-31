Return-Path: <linux-fsdevel+bounces-45347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F04A7675E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAD23A6625
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F52135DE;
	Mon, 31 Mar 2025 14:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSMlZ/lD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717C3234;
	Mon, 31 Mar 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429957; cv=none; b=JZsQf/B5Iyr1vAuYYImdlLx0gkgiMMw0FD2rugoi+5IxeuEajVuXqS4V00fKvNPjQ06T0tEO3JnoF/hz8NPCpsQinM5bwfk0RrS7GqKkXoriNvH25efmgFWAyz6aYS61mxMYstbgYf8h6aCiyTrpJQBsA/M1WuXwlNYXBgcS/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429957; c=relaxed/simple;
	bh=07s9x4eJsDQGwWHwnNiYXCuzTiFzJ8lGECinUbcY524=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2nIfMNHQSKkc9ZkAaFBJDm39gvu3fe5LzfgGfv98eQNPcZa/XJFXGigYzaSTPDePvm30PMbhFFn7aSYD1kb2Cp7ldx/tHE1BS8h/j2LMPJMK82n8zwTBwA8naS3RClUw34UnDbWmYBZBIX90852o9BgAw01QfwQwAMyz37hA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSMlZ/lD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CE6C4CEE3;
	Mon, 31 Mar 2025 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743429957;
	bh=07s9x4eJsDQGwWHwnNiYXCuzTiFzJ8lGECinUbcY524=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mSMlZ/lDKwuLsSJkVpnzIJGMUUo5wqVkchlyh5V9b+B6LlA+HHVZPlI2xZp/Wu9o3
	 q39kpS82tYi7/m4L6D6mahFaIEYuhi1HB7ogXzE7MocX9rble3VYZCOO3ulX3URAWA
	 wfwIwVHMClX0X8Bx97n1HCApQkRQfUFvjsYFpKP6CVjAmbTvBuWT3plhOwPzq2tT6n
	 cy24U1E45nHhvj2QRWuEqTU+5raojXIIx3blJZC1UoqIoSpsuOBC0j1ayba4EFzMnb
	 eDjipQs/5G2m1/FFicpWdAEBIXclSrN2lvgGedjh39wgAx3yn2y71f/K4WFyEU9Rgj
	 E4xdR/YW6lYaw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30ddad694c1so26588441fa.2;
        Mon, 31 Mar 2025 07:05:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU76w792d378XPwn7+RhhSllLSf5mjdqY59db//FdYbIa4zgcjyH3SYp5sBKwtzwrmq2mmqUa47H3E=@vger.kernel.org, AJvYcCUrWtco7Q3MhdmONedj8rSDiQ2T4eHKc+nsIqI3E/RhleeeECEJ5STHqEAWLaj4D9VT0uMgp4VUSkg4+WWy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt15JoRsA1sVLgWs+YnnMBeTChiDtt0cKQAImRXyX9fKKQV8pN
	vonbLs7VzOuJNJT/zJ5BLfySJ87jhrJ0NKXK4sy9pi01aL3nqbHR9LtE7+OxHRw5Q6NVGLTJQO+
	Xqgq473/0KMUxTrSPZcoBQyOAmh4=
X-Google-Smtp-Source: AGHT+IEtihY+5usvfw+FYym2eJvCjOmjSHmTGWL7O1qP0zOGc31rxUa9w9eVwgOTd6hEaoJ1/jmPcK7oGmyMFJl5JyM=
X-Received: by 2002:a2e:a583:0:b0:30b:c6fe:4530 with SMTP id
 38308e7fff4ca-30de0231da0mr24343021fa.3.1743429955291; Mon, 31 Mar 2025
 07:05:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329-work-freeze-v2-0-a47af37ecc3d@kernel.org> <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
In-Reply-To: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 31 Mar 2025 16:05:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEXRtprufPX-BYxsuafcZTxxRz1kMb2+3KxjWg9Wg16SQ@mail.gmail.com>
X-Gm-Features: AQ5f1JqR2YXXihdPZaek2oYz-z9XmSddPjboETqnCG4vhzTMbOKA94SciqgD3Ho
Message-ID: <CAMj1kXEXRtprufPX-BYxsuafcZTxxRz1kMb2+3KxjWg9Wg16SQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] efivarfs: support freeze/thaw
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, 
	hch@infradead.org, david@fromorbit.com, rafael@kernel.org, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 14:42, Christian Brauner <brauner@kernel.org> wrote:
>
> Allow efivarfs to partake to resync variable state during system
> hibernation and suspend. Add freeze/thaw support.
>
> This is a pretty straightforward implementation. We simply add regular
> freeze/thaw support for both userspace and the kernel. This works
> without any big issues and congrats afaict efivars is the first
> pseudofilesystem that adds support for filesystem freezing and thawing.
>
> The simplicity comes from the fact that we simply always resync variable
> state after efivarfs has been frozen. It doesn't matter whether that's
> because of suspend, userspace initiated freeze or hibernation. Efivars
> is simple enough that it doesn't matter that we walk all dentries. There
> are no directories and there aren't insane amounts of entries and both
> freeze/thaw are already heavy-handed operations. If userspace initiated
> a freeze/thaw cycle they would need CAP_SYS_ADMIN in the initial user
> namespace (as that's where efivarfs is mounted) so it can't be triggered
> by random userspace. IOW, we really really don't care.
>
> @Ard, if you're fine with this (and agree with the patch) I'd carry this
> on a stable branch vfs-6.16.super that you can pull into efivarfs once
> -rc1 is out.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
> Christian Brauner (2):
>       libfs: export find_next_child()
>       efivarfs: support freeze/thaw
>

This looks fine to me: I'm a EFI expert not a VFS expert so I am quite
pleased that you have taken the time to implement this properly.

Acked-by: Ard Biesheuvel <ardb@kernel.org>

I don't anticipate a lot of parallel development going on in efivarfs
so taking this through the VFS tree is fine. I'll let you know if/when
I merge it into the EFI tree so feel free to rebase/tweak the branch
otherwise.

