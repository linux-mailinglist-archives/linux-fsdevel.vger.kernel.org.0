Return-Path: <linux-fsdevel+bounces-44258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A73AA66B0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29355176033
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EE61EF362;
	Tue, 18 Mar 2025 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjPtPCx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F71EB5E4;
	Tue, 18 Mar 2025 07:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742281513; cv=none; b=BsGAnaaZJi5s0SRcwvf7KPrEQ3n5Mij7IlHPzdG42o8hP6IEj3gqtiBbf5huQYMckk7CYBdTHLQiD6yl5P13eVfLHD70EGNzTVgVBBcTbFOKD5mgwtE0q07K3QkuMfRQX9kR6u7ENW/zhXP7pHE/3VwhVOyDNVIqd28hx5oe6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742281513; c=relaxed/simple;
	bh=pqyE2mcUwycqxxBCmftvhiDIGpcRNzfGegdT4Et+GHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tE048fc1r+pw4nI0JGxEapHc6Tq85eK2Z0+vudc8fQ9w5mmUDmjEN33N7QzFm7GkrVdRmYHXdpuMXV+jIsPabmb5Z/DLdBiatoACJObFcex6vzZgbISJRAhp2DhJhOCz+UJYgMlzquUPvWal3RzVrpByZkQpsGCeiIwzdboL/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjPtPCx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD859C4CEEE;
	Tue, 18 Mar 2025 07:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742281512;
	bh=pqyE2mcUwycqxxBCmftvhiDIGpcRNzfGegdT4Et+GHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sjPtPCx7jRJVkCb0JBBNT5eS9NGJ/eOj2A0b9eV5TAUVZlnV+zX0PuBiq34JkFL6g
	 TLjd5swvW7zKM6ZFvSJHFPobu5JzJ8nQTQ0bKqtfSMy0NgTY8OX9J4NPDSysQze7rK
	 JPZaZEHnHCKozsTTMM8t9OGJGk+vBxKwZQi83DegGS0PXXLI8urSByX3aXwLUHSo6Y
	 Zm6m5qf9W4dwM/LZkcWZUlFlTEC4SzdrPfqa5CuggFo9q+EddMLGOuJskDeA2ImI9M
	 fOQKOxLXLQ0ZnaoI4wdEIguxXQuP1ry6MlIUDyE1YRGa8EacP73RXyARAMhTR0B8wH
	 2QruVea+VlaFQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5439a6179a7so5770849e87.1;
        Tue, 18 Mar 2025 00:05:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2nkdsDm3BBtSk8Q9OxAFwl2A5vQq1jHIcZkW2gRFGG5dJ0kouJP4JUu0P2R5T9fmI946yRTRQ2TQ=@vger.kernel.org, AJvYcCXPin2cu9gcrxAbtgdJEYSbFK2ezC+9p7zHGSHxsXYo1IeSG/oXv0mdseuVtq01vS8WcK3tLdOQThvwdepucw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4puA1sTonyyiHUSZmVsIrPHbYGH1uqfIogocbHybgj6tHsdX9
	32XqrMJv7M7lj3hfAdBfUtS8cEOeSQetufwepLmY1gRGbqdDX8y4QeZ5MU7fx6qblnJACEF7MrJ
	OcvP2/HID6NRNhfTjl6nCubSrF3A=
X-Google-Smtp-Source: AGHT+IFCCy11dbnnfZDGX/YUPbHzaI/kkJP28eCiDF1flPn+bHfOYkYvKC7HTwYt5dCQ6MKCD4aij7oFdgAfqZPD4E0=
X-Received: by 2002:a05:6512:3ca2:b0:549:981b:169d with SMTP id
 2adb3069b0e04-54a30470b07mr2068803e87.3.1742281510969; Tue, 18 Mar 2025
 00:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3e998bf87638a442cbc6864cdcd3d8d9e08ce3e3.camel@HansenPartnership.com>
 <20250318033738.GV2023217@ZenIV>
In-Reply-To: <20250318033738.GV2023217@ZenIV>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Mar 2025 08:04:59 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHOqzvpUOMTpfQfny10B7M3WnwPYdm1jVX7saP4cy2F=A@mail.gmail.com>
X-Gm-Features: AQ5f1JqCd4LRanA9yEDwtlAdTJYIW53bxFcVs25aZMvA-N0wpX2k1nXI_6kTftY
Message-ID: <CAMj1kXHOqzvpUOMTpfQfny10B7M3WnwPYdm1jVX7saP4cy2F=A@mail.gmail.com>
Subject: Re: [PATCH] efivarfs: fix NULL dereference on resume
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Ryan Lee <ryan.lee@canonical.com>, 
	=?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 18 Mar 2025 at 04:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 17, 2025 at 11:06:01PM -0400, James Bottomley wrote:
>
> > +     /* ensure single superblock is alive and pin it */
> > +     if (!atomic_inc_not_zero(&s->s_active))
> > +             return NOTIFY_DONE;
> > +
> >       pr_info("efivarfs: resyncing variable state\n");
> >
> > -     /* O_NOATIME is required to prevent oops on NULL mnt */
> > +     path.dentry = sfi->sb->s_root;
> > +
> > +     /*
> > +      * do not add SB_KERNMOUNT which a single superblock could
> > +      * expose to userspace and which also causes MNT_INTERNAL, see
> > +      * below
> > +      */
> > +     path.mnt = vfs_kern_mount(&efivarfs_type, 0,
> > +                               efivarfs_type.name, NULL);
>
> Umm...  That's probably safe, but not as a long-term solution -
> it's too intimately dependent upon fs/super.c internals.
> The reasons why you can't run into ->s_umount deadlock here
> are non-trivial...

Thanks - I'll incorporate this observation in the commit log, if you don't mind.

To me, it seems rather counter-intuitive that we need a second mount
in order to be able to implement this. Synchronizing the efivarfs
contents with the backing store after an event that may have modified
the latter is only needed when it is mounted to begin with, and as a
VFS non-expert, I struggle to understand why it is a) ok and b)
preferred to create a new mount to pass to kernel_file_open(). Could
we add a paragraph to the commit log that explains this?

But if the VFS experts agree that this is a reasonable band-aid for
the time being, I will take the changes themselves as they are. I
intend to send this out asap as a fix for the v6.14 release.

