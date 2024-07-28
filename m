Return-Path: <linux-fsdevel+bounces-24381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA3293E91F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 21:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044872816E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 19:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866467407A;
	Sun, 28 Jul 2024 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lHUF8/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C245EE8D
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722196358; cv=none; b=D+uonBmmQ7Tct8gTMAyj8HlHwQkerl+LEJl3fzgjrMyvQ29jKsX/7i5IR+NC/27ygtz0Zmp2WDEo3FYAFXIgLAqArVK0JQqDC5jAEGg1juFdjGNEnEBXUmaOOpfZ26h13OLZrD1VgGIbLeyQ/FEaCtSK7FsEg6IqBVSGIrV7Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722196358; c=relaxed/simple;
	bh=RDq7aq/yN62xGSOTNCzz9f62E0LVxzKXJeUwXR+/coA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCSVui52hYwSxwU5wlG9YLdL0BWV2Y+wsEgpHUPpQXe162ozWt8pSp5kq0dpeZ5QmhRGSHzizq9C/vrCc0lLFAT9Cttdth9PZOKMMkBWhPAhCZrYI2vnWxy6ekhh9HQfmMc2EZlIO+rScNR00Jsu3OY6FZyp0L5PaaqnBFXdwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lHUF8/J; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7aa4ca9d72so380838366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 12:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722196355; x=1722801155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oAEQj/aSJYeFh2CDfTHMeCDoUPI8V0lBd3bYV9D6dkM=;
        b=4lHUF8/JgQvDxJQdFAmqAQHYNBtFk0i2bL92Mpft0oJIAjB0k7DLCyP2S8iD47iQth
         GRQckgIyyb6eLrQC37ccN1x8NrTNPa6itihtkOkZp6Wt2NVbYBhiTjhT8yw+Ya3EDLmT
         b306yA3b+5ABIr0D1TRqYcI+CkNissSbp9E39XCy4exIk8vIVkzg9jZhfnf5U2yOgM8T
         ZvTpJYmxAda9skKTibJZfmL28lPEXLekOKfREK4IzEPCkNx54XP5O2NMyK6hqgj16nUW
         ex4G4ZtGQxb9rsiw0rbSQvhic2wuKzYj2Ir3rg0KNCJkhVa1UJNtedY/pZEAh2fvgQKZ
         2gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722196355; x=1722801155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAEQj/aSJYeFh2CDfTHMeCDoUPI8V0lBd3bYV9D6dkM=;
        b=D/BJ3Hc80hDpQbFDk4HgwKYTCWu3fV5NKBuhRqzZZU/RTBBU7SEXf6nCefSWkjWyYu
         E1/VaJxEaSS1PuUAq6awV+DSsbiNcBJvpB0b+rIE5A3qQAM8AJKcq4FtvyuuV0HIb6t5
         Bn7ODVfFsEi0lUfPjXAP6v1Bv+kDcU4/KiUaEkPQf0R0m6TgJKm+5A9AdDfUNM75PH/D
         m5DE/Lv77SoENuJNBfslnbX1i/hQPPB/hMXIbTvvgRup86Qj2tLQyzjSGlgzELEfKEOL
         MYplZIIkv7c48fyt0iW/RHHx9FRpMGkLp2UDtRfIf4W7gO0W6RxduLtOfoyzAesu0MJa
         TZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXwoMtsM0aZTq4iVUaFHOjC5F5n8Eu1m2FwgVwL/BR1clzaHWUDMQTJ5e9IU20N4ZWBCe0o1k880Ja6g2k5T2vyCs71EK87T5qyzIQNCg==
X-Gm-Message-State: AOJu0YzXnl1peKg/StO43HuTKcFVzVRW9tGu+QTAYNxvLE9FP7bGrSII
	ySRPVOMixgUraToZce4wJP94x/QpaSl5D2ChEgDMQZq6bQiLl9NNM0Kaexk/Rg==
X-Google-Smtp-Source: AGHT+IFIpHiAM29lP8O5baSC8ozinYezk57uvb50qAjnbhFwISzkkE4Rr5s1/cdmbwnLN8Ybe/frQQ==
X-Received: by 2002:a17:907:7202:b0:a7a:9f0f:ab2b with SMTP id a640c23a62f3a-a7d400a1a4amr412743666b.32.1722196354119;
        Sun, 28 Jul 2024 12:52:34 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22bfdsm418782666b.34.2024.07.28.12.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 12:52:33 -0700 (PDT)
Date: Sun, 28 Jul 2024 19:52:29 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org,
	andrii@kernel.org, jannh@google.com, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, jolsa@kernel.org,
	daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <ZqahfTVzrs33tE95@google.com>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
 <CAPhsuW4WcksBrLkwr8zwTZttmbpQCw1=D95Qs+X7Kj5zkTMA6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4WcksBrLkwr8zwTZttmbpQCw1=D95Qs+X7Kj5zkTMA6g@mail.gmail.com>

On Fri, Jul 26, 2024 at 04:52:50PM -0700, Song Liu wrote:
> On Fri, Jul 26, 2024 at 1:56 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
> > the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
> > its arguments.
> >
> > This new d_path() based BPF kfunc variant is intended to address the
> > legacy bpf_d_path() BPF helper's susceptibility to memory corruption
> > issues [0, 1, 2] by ensuring to only operate on supplied arguments
> > which are deemed trusted by the BPF verifier. Typically, this means
> > that only pointers to a struct path which have been referenced counted
> > may be supplied.
> >
> > In addition to the new bpf_path_d_path() BPF kfunc, we also add a
> > KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
> > counterpart BPF kfunc bpf_put_file(). This is so that the new
> > bpf_path_d_path() BPF kfunc can be used more flexibility from within
> > the context of a BPF LSM program. It's rather common to ascertain the
> > backing executable file for the calling process by performing the
> > following walk current->mm->exe_file while instrumenting a given
> > operation from the context of the BPF LSM program. However, walking
> > current->mm->exe_file directly is never deemed to be OK, and doing so
> > from both inside and outside of BPF LSM program context should be
> > considered as a bug. Using bpf_get_task_exe_file() and in turn
> > bpf_put_file() will allow BPF LSM programs to reliably get and put
> > references to current->mm->exe_file.
> >
> > As of now, all the newly introduced BPF kfuncs within this patch are
> > limited to sleepable BPF LSM program types. Therefore, they may only
> > be called when a BPF LSM program is attached to one of the listed
> > attachment points defined within the sleepable_lsm_hooks BTF ID set.
> >
> > [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> > [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> > [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/
> >
> > Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> 
> checkpatch reported a few syntax issues on this one:
> 
> https://netdev.bots.linux.dev/static/nipa/874023/13742510/checkpatch/stdout

Thanks for making aware, all has been addressed.

/M

