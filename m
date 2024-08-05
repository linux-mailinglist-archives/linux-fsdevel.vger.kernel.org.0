Return-Path: <linux-fsdevel+bounces-25037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED29948214
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 21:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802351C21AAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 19:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAB716B389;
	Mon,  5 Aug 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FaWk2mmi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EC52AD13
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 19:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885033; cv=none; b=BDDtqCoPlJrozVE8N9nHu8+JshMeuaFyv/In3mUo0XXNHVANSYWhT18G+CS5BJEk9BeNvYPMiMGy8k6ASua5/ld5x+wOAUrW0QYa7bpd1tu6a4SLxq7C74IR5egeuQqzZrA/gre4AGuWFjZh+cSP6RKv07NqKvDffIbD5EdWqiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885033; c=relaxed/simple;
	bh=CoU8z7rPwlIktTSPXSLvGcHELQDE66WJAH2fIR5MIEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMk7F8yYmyBUgqYsAaamwPEeBBIKXA5osriABdt1MmXFAZeV48TIy4LthQEJp7wrsHkqAFWw9/Xcd+jMNmUMUlK+baPhC64gGM5jSgUw/nweQRh/EJ16hiWsOzOp3AgJKCvDVLkxjMwTasiNwhXEHNkBVxkRMNNzAmevwMd034I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FaWk2mmi; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab76558a9so10857066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 12:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722885029; x=1723489829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA5U+6t/BL3dNn6z4KME0ljFM05r+burKxZg1qrP5MU=;
        b=FaWk2mmid+GhVMgVcbUXOeiMxg66qgz9c1HBvm4/BzLNxb699nbnLXW65w8avWakMC
         8uUD55EC2hv9Fqb1jM/YPzwVk1tDAtgbsE5V4+MbsMihB0ZElqJUfnq/8znXxZevQPEx
         edewIQW+XqAcV2O8SMjfIFrZhr4pmhBFvIoKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885029; x=1723489829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA5U+6t/BL3dNn6z4KME0ljFM05r+burKxZg1qrP5MU=;
        b=N8kyx4AtTjDP3AIgkJnkJWF35WHxIgooNbw/pGET0yTWDr9plqF9dbvA29GWHFBZu/
         oIoyLX5eKvErs/LJCntgDbDwIBGCavwl6XZnuaXPK0M1HS4wlMzSlQ6AsCRnlJ6+oeK7
         VEAOS8MC4/Bl5RI3eYsOZUoj7UIlS+N9ZUuO5NaLbe6VQ6f5JicFeiZ+OYnnviCX7dnB
         MsdHGDxNkps3mEHk8hqP4CFwFO3lwv8oy93VCkNcXH+A+2BdTX2DiSUvKw1b6FsfGl8O
         MP7ENDUeTqZaRiESAoOtKidGWfKrn/C+lrd19wjxi6EwznUbhfXD0SSowlmk4hjIIch6
         BxSA==
X-Forwarded-Encrypted: i=1; AJvYcCX8w3Xssvk1EQZ259jIkjogD+S4gBiDJ97P9BwyXTEnUA6WCtSY/7H5NCc1xwUpYqjCV3lCO1JYWXqGUhpMepHnJVBnQOtuB/HZcACYRg==
X-Gm-Message-State: AOJu0YzvGs6rw0gYAkfQzH+paiN76Mw+GV1vLy97RiTgDAMEA4kSadMh
	EVA86m/0H/2fwvfLESpWCHdQjkFDuvprqStroHenn3viM71mBs7AG0d5XROuHnoggxXebI+sEeL
	Va7kRmw==
X-Google-Smtp-Source: AGHT+IHGEk/mNzDgEuQYP5/2xvBlPMo5RForW4RG2UUkjAE4tG+SMXUwZC/qZAZCOAr0zVDJtvkhtQ==
X-Received: by 2002:a17:907:9493:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7dc6245628mr922303966b.22.1722885029047;
        Mon, 05 Aug 2024 12:10:29 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80dedsm477562766b.163.2024.08.05.12.10.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:10:28 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aada2358fso976877366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2024 12:10:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjpDj/OqZ55FDfM3z+5w1FlpfLicU79/HnoHI+dq6B+uwLtVfAzdewcOt6ZHBrTlRAM/RgLR4DBM1lYfQC5sapB3qn1qUaZ3fUMNyMNg==
X-Received: by 2002:a17:906:cae5:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a7dbcbd4ecamr1191867766b.8.1722885027737; Mon, 05 Aug 2024
 12:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <C21B229F-D1E6-4E44-B506-A5ED4019A9DE@juniper.net>
 <20240804152327.GA27866@redhat.com> <CAHk-=whg0d5rxiEcPFApm+4FC2xq12sjynDkGHyTFNLr=tPmiw@mail.gmail.com>
 <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
In-Reply-To: <E3873B59-D80F-42E7-B571-DBE3A63A0C77@juniper.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:10:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
Message-ID: <CAHk-=whGBPFydX8au65jT=HHnjOCCN0Veqy5=yio6YuOiQmJdw@mail.gmail.com>
Subject: Re: [RFC PATCH] piped/ptraced coredump (was: Dump smaller VMAs first
 in ELF cores)
To: Brian Mak <makb@juniper.net>
Cc: Oleg Nesterov <oleg@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 10:56, Brian Mak <makb@juniper.net> wrote:
>
> Do you mean support truncating VMAs in addition to sorting or as a
> replacement to sorting? If you mean in addition, then I agree, there may
> be some VMAs that are known to not contain information critical to
> debugging, but may aid, and therefore have less priority.

I'd consider it a completely separate issue, so it would be
independent of the sorting.

We have "ulimit -c" to limit core sizes, but I think it might be
interesting to have a separate "limit individual mapping sizes" logic.

We already have that as a concept: vma_dump_size() could easily limit
the vma dump size, but currently only picks "all or nothing", except
for executable mappings that contain actual ELF headers (then it will
dump the first page only).

And honestly, *particularly* if you have a limit on the core size, I
suspect you'd be better off dumping some of all vma's rather than
dumping all of some vma's.

Now, your sorting approach obviously means that large vma's no longer
stop smaller ones from dumping, so it does take care of that part of
it. But I do wonder if we should just in general not dump crazy big
vmas if the dump size has been limited.

             Linus

