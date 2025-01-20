Return-Path: <linux-fsdevel+bounces-39695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D94A17033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300A71886A86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 16:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D261E9B18;
	Mon, 20 Jan 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwyipF9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0BB36124;
	Mon, 20 Jan 2025 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737390714; cv=none; b=ChfodeEnRLcI6OXf4fpD/nIagLc+3XpdV1pzxRdgTJYt/bhwGhyutzDBBzJl+qRUZtlpuM4WnviSzQP1PWnjSGWdouiFaLMPJ0gnxkIsqcufx1NBQpDxT2lBXmV+lnFM7TzQr+kFUbKJYaDeltQUa/MVW48gIXY0Y/8ejIzckNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737390714; c=relaxed/simple;
	bh=+XWtE3i4aEw+fjG0QBy+V+sB5Y10HD2kDuWZjrt8LMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgVaqaqtyYFvZWjAcgRlMiyELI4TCBjx08H1gg6NkexNrc+FSDzt8B3G3KTTp9Chw5rH64qWnIncXIw3tuwK9LkQ7wwqKY67oujFAeUsy1WJPvKzLFZSQ4Blya857/AZYwKad+U5lg58jyfRKX6A5vcEKJ2yUwZ45SouK2J+PMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwyipF9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B77C4CEE2;
	Mon, 20 Jan 2025 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737390713;
	bh=+XWtE3i4aEw+fjG0QBy+V+sB5Y10HD2kDuWZjrt8LMs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dwyipF9f0aX/XPVNHhJBN1ceN+3HeHxsQerweuvU7s/Ktn7hvsfHIuuulWyFlqT10
	 /xKuct37Hi939R0c70OWFaTpy9AgDS0vfTYjkW6Pbfz8hJs6fxrP5l4w6FEugavzo2
	 w8XVt8YVtDIIRZAbqZeERlT+eS9Hz4+YBchGWNrJC790Wrwi+zrVF5HP7laA+d5SMm
	 JvfyXPYYtqnAXuz8SK2G63wF7XcbUFI/iryuaWs4H70GUHmnOME4ZSFKaTC9mEk+O3
	 C7vOp9o3zAcqjX2DeqggGSGJaNttIWHk4Gn6eS1Fk6a8dlJLnvexuvl+wwo3aR03np
	 LG16dJ0BcaGCA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6cdb7so4484963e87.2;
        Mon, 20 Jan 2025 08:31:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMrNtCo9bU4MX1K26k2KoaOTbr86/gXkiDtu3xSbS426q3WH9tsmyNZy5OHTbyAKJTjQAYwubSTPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1iDVwn0uZfqjvSsXo2/CIZ4eAGyYxMRBzKtyBcPItZuKw8lu
	/LZlHptXtwiJnpf62v79wcWhxgTLx7PZZ9M+EqxZ8KqN2tsDXDlY8mXprcWJvZORCcSRnzwF2n0
	NuMbyZXZEOqOtnmEJVgXI9hM2TwI=
X-Google-Smtp-Source: AGHT+IHGjVmwfU3SDRNViVe/C/BAke1oP2EtLom01VZ3KOSZKON0kx1V8rpz+Bx983TJABd8twEnbNXztk32iv4OW9g=
X-Received: by 2002:ac2:5197:0:b0:540:228d:b8d3 with SMTP id
 2adb3069b0e04-5439c218dd7mr3354161e87.1.1737390711845; Mon, 20 Jan 2025
 08:31:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119151214.23562-1-James.Bottomley@HansenPartnership.com> <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
In-Reply-To: <CAMj1kXEaWBaL2YtqFrEGD1i5tED8kjZGmc1G7bhTqwkHqTfHbg@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 20 Jan 2025 17:31:40 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
X-Gm-Features: AbW1kvZRfXXaOmmYM1JCVCwFdSyMn_7oNiaUoyl80PmwR7GWDM4qeYeVnazQ5nU
Message-ID: <CAMj1kXG1L_pYiXoy+OOFKko4r8NhsPX7qLXcwzMdTTHBS1Yibw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] convert efivarfs to manage object data correctly
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Jeremy Kerr <jk@ozlabs.org>, Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 17:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 19 Jan 2025 at 16:12, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
...
>
> Thanks James. I've queued up this version now, so we'll get some
> coverage from the robots. I'll redo my own testing tomorrow, but I'll
> omit these changes from my initial PR to Linus. If we're confident
> that things are sound, I'll send another PR during the second half of
> the merge window.

I'm hitting the failure cases below. The first one appears to hit the
same 'Operation not permitted' condition on the write, the error
message is just hidden by the /dev/null redirect.

I'm running the make command from a root shell. Using printf from the
command line works happily so I suspect there is some issue with the
concurrency and the subshells?



# --------------------
# running test_multiple_zero_size
# --------------------
#   [FAIL]
# --------------------
# running test_multiple_create
# --------------------
# ./efivarfs.sh: line 294:
/sys/firmware/efi/efivars/test_multiple-210be57c-9849-4fc7-a635-e6382d1aec27:
Operation not permitted
#   [FAIL]
# --------------------
# running test_multiple_delete_on_write
# --------------------
#   [PASS]
not ok 1 selftests: efivarfs: efivarfs.sh # exit=1

