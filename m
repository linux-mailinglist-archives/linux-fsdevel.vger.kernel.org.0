Return-Path: <linux-fsdevel+bounces-49272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C337AB9EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8221BC5885
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9CF1A255C;
	Fri, 16 May 2025 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUyFiL4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40BB17B425;
	Fri, 16 May 2025 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406922; cv=none; b=Uy5aA8HJu9BO0H2NIHoT3jp0y6lfgpQqDPIRp00Gv3rkxEHjIpCJy07IWBikZjIhdVm74IAE12phIHO57/2Q5frMXoXuv0ijdXYDBN3/GSYBJXcG6b4wi4F0wiznifQ3joTcmBot1jlEr3YKtiEQd6tWxEXlPjZ/jLDWx1CMFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406922; c=relaxed/simple;
	bh=mqs3vH8omkf/lFqlcNBLcijBHI7C4HsS+nSuaL+fiyM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=DbXDq8fzOqtOEWG0xeVZ7EZTD/6xETr3207jKdGFb3fk3tf74mhkV3vY+VL0OSVqmHjSJAzR0Ds4P/qH+blGyuAMfdZKjDnStwL8T/bP2apNlX1ZnVbVwfHwujinOFw1Jy13ah9MZFDRWlZUCFuRIxqE96o1IR2TR+Bz4WhVQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUyFiL4c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e09f57ed4so36312915ad.0;
        Fri, 16 May 2025 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747406919; x=1748011719; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=knLSICsJOojzEUrxMy84SDHLckjfFnqIlSz743nGI+A=;
        b=HUyFiL4cavlkgUr1d5lspQ5rOZlprR3BN7krY9mYUcuKB0VQALlo7ll2+qb2aeGmM0
         Rr1Jw0jocVItqfhmA6aVfr66EcWSgJtjJDPfGI+Y9uC6TXji7Pd9tApzWURwvEDcUMxY
         jz6NAC2EXKTurU1P+FHlYWjfVE9vNtz9+b0NZU58J6umXLuB6T23fVZsLERbwDhI1DCf
         kMWnGvxAZ6wfnfYnIku/DodE/8j0Ii/lxR1QZo2P0oda5EoyIaHPsjWbk1+MxczgqG8L
         bAIgvj1r4654bdMBhtmEy5zVefiHlCpqBXrUOljH+9Qp/cX+xfwauXI4gWG0Uveq0o6D
         a4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747406919; x=1748011719;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knLSICsJOojzEUrxMy84SDHLckjfFnqIlSz743nGI+A=;
        b=BUpT01QFdqHciVC7BueCjJOlJ9sh9ip1r+tK8IXDtfigwXNx3CZsrMWwCi5jWvDqAi
         GYfJ8eGCA/IcprBT8UCM2AUxydLnLFO/2E/y4w21D2fO8K8so35cZIu6pYHlikp+Tp1I
         Qvs39aJvQZs2s/2hmT/Mo/XqJiOdrAPe2QHteS8zf2uNz2zlb1K8tYLGh1JfeAuwVaYe
         O7LvZs9foXSOgzvXLWTz9FovfkQm/QNNPyx72SOLFVU8kv5cg3a/79O4KeIjoTeHPM3q
         v4DlgxOdjvXimBO21hh5o1xY9KbIzqSsF1x9ZKbQyf0KOlVtNCIi2SFGE4gvJCShrw58
         Zo0g==
X-Forwarded-Encrypted: i=1; AJvYcCXNt7BGqIQIyvVRF7NDGd/IWI0r2Qq6fCjwj/n8kjIwLegAV/CCR55OnMKYP2YwgdmirlMZOtkEYxvqAPV3@vger.kernel.org
X-Gm-Message-State: AOJu0YxgR5WpFMlb/5R9N4K1EKrxF4vO0qVnAROQdFWmndJr5+XBsN3M
	qr1UkzYZSwJVBvN9JCMXG4qqCcHA1h4vQF/ubsUKNaVGA/qy1LC3iDKZEb45Dw==
X-Gm-Gg: ASbGncv/FehUwRWqaZoU9ZQ0INdh53daFFvqurLryrbztVnGQZJcTnLDrarAt2SUXRx
	5wZijrjAgZ6LYTUF0fKTMamWTBaefZjNTcjNy93yI6ypozfxs/ArQxOy+Mjr9ixOUCb9Ooya/LS
	TTY4BpcqD4Ycqq1xoZLV0vTQga2tN4qbjnc9SFzgaO7t1iQ4TAx6rkFDHHI2wS71re9ISdOphA6
	t5vjwCJLUZEdTjDCUXr+IgAf6UiLLbhpi68G7pbEv2ha4/9Fi1JgrwGEPbfBxQmrnULT5ikBuPs
	7ExIc2rqntfvd7dbkaKtAWiDsLCsbsrUnqB4/MtWWp9U
X-Google-Smtp-Source: AGHT+IFxyyEuMbaQRaQPPG4vinthQ8415iSw/lh51IcvJj6esfaaVH7TulzMEAOEdeecAaJsVGwGIg==
X-Received: by 2002:a17:903:1b48:b0:22e:4b74:5f68 with SMTP id d9443c01a7336-231b39acfbcmr120153455ad.19.1747406919232;
        Fri, 16 May 2025 07:48:39 -0700 (PDT)
Received: from dw-tp ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebaef0sm15203785ad.203.2025.05.16.07.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:48:38 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>, djwong@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/7] ext4: Add atomic block write documentation
In-Reply-To: <20250516121938.GA7158@mit.edu>
Date: Fri, 16 May 2025 20:06:43 +0530
Message-ID: <87ldqwwrk4.fsf@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com> <d3893b9f5ad70317abae72046e81e4c180af91bf.1747337952.git.ritesh.list@gmail.com> <3b69be2c-51b7-4090-b267-0d213d0cecae@oracle.com> <20250516121938.GA7158@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Fri, May 16, 2025 at 09:55:09AM +0100, John Garry wrote:
>> 
>> Or move this file to a common location, and have separate sections for ext4
>> and xfs? This would save having scattered files for instructions.
>
> What is the current outook for the xfs changes landing in the next
> merge window?  I haven't been tracking the latest rounds of reviews
> for the xfs atomic writes patchset.
>
> If the xfs atomic writes patchset aren't going to land this window,
> then we can land them as ext4 specific documentation, and when the xfs
> patches land, we can reorganize the documentation at that point.  Does
> that make sense?
>

IMO, the current documentation is primarily intended to capture notes
from ext4's implementation perspective of single and multi-fsblock
atomic writes.

I guess adding a more general atomic write documentation require a lot
of other grounds to cover too e.g. 
- block device driver support (scsi & nvme, dm-... )
- block layer support (bio split & merge )
- Filesystem & iomap support (iomap, ext4, xfs)
- VFS layer support (statx, pwritev2...)

So, IMO, even with XFS atomic writes patches queued for v6.16, the
current documentation still stands correct. To cover more ground around
atomic writes detail, we can think of adding a common documentation
later which can refer to individual filesystem's documentation file for
implementation notes.

Thoughts?

-ritesh


