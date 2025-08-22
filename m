Return-Path: <linux-fsdevel+bounces-58784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F4B3172F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E0EB0351A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541CE2FDC26;
	Fri, 22 Aug 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6+dkYrP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AC2FB607;
	Fri, 22 Aug 2025 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864449; cv=none; b=TzxyTKMtb+ADyZiCJYhuusE9477rs3UX4+OdfjHhcXUvEK/GW1BKeXUnXyARV1ycvz6QdUDuzD9l6xJeVJ4bzqOzmM2SKiPPqJvS9cP7zCd8X8psuNJ8TlX+vgxM4xwvpqHsHIJHFCmvLFZwPZBVN2coze3TwWN40b68pts5wIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864449; c=relaxed/simple;
	bh=w9LDDKbbCU32z8mFAmsc72r+haOmtzzbI1hp4FHEhZk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSAjNWQzBIUh5OPmNSXX/EGCBwBoAOlDuJ0xlKYDH0SLp1jBbhKCm88rLRwFZ5IJFLd6wjLuI1zaxHmGNJlFIqwFBqOA9e37q5HdZFc7YXgQZbr0GlJFyJm5z/RU6y3SJPzLeYsjqn9iBhy09IwtfztfaBEYNuRbAnzr5p325yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6+dkYrP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e7437908so1368383f8f.3;
        Fri, 22 Aug 2025 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755864446; x=1756469246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8l8c6RdN9SEwzhMIPJOr5f2j416dT55akZSctyPtco=;
        b=m6+dkYrPSdl4HDLTuMoH9qJhUVNvoMcYD+zpbuuF0vmKgglHm2rnboNewb0Sba6+QA
         ydD0+3jHfidGfTM/CRyhCqosrVj8R5G9DbvBFMiHuzhYMuc/igPx5rQea6j5hXSlscUf
         TzQPXFh35msrBxs1BUWmH8GLmeu/hDU246phHFfKq7jOByqvbmObZoorrBgPkuMO0PaC
         8ZlriJolMHzuXAeZXA/m2hiR3TyeYVu4RBGz/5OYQVMOduQ2/S37r5o3kquAhYIWrEyI
         6EheMNkw+dn4fg1kqigozjOY6eDl730J4aeu+l2i2yLrBZ5NrYvQEL68RO487BsnhxKW
         TIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864446; x=1756469246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8l8c6RdN9SEwzhMIPJOr5f2j416dT55akZSctyPtco=;
        b=FsZcDpIHoaCqiZPmaGaHa86PUndeoD82NXaBx8zvx8X4/t2xO+nndY+Y0W/p1PYFcg
         uMv/soajR/eBNbP38dybmWsCIAUIF2wgLcyIq0U1jhvRcGk816WiRc9dnuB+QHAEf+AI
         ighrxeWoHLAdfA8kbsICOSwTANItghaTh7uccPzFrAbcf+cVtfKHkAcdJHNURISeTx6N
         ZiJcRzVrHKw3FXpAJFQFHM/GN+mzwdF4VE4Cq820D3ncWCGjOvPpuzBSKI0FbYX+trGQ
         /lKT7bWHvlMa25dFVL+L2FU6NvT9PVvuQGwU730oTdw7izoR+isk6JhpAx0HHkPCo76g
         Ez/w==
X-Forwarded-Encrypted: i=1; AJvYcCUCxEGTT5XsQkOAeicpVsd+dEPfB7EDUao9xdV7Rm5jemmSuVfcayoBwtIiEnICR9AZclQBl3dCXK7ite+89w==@vger.kernel.org, AJvYcCWaLbaLuBHcGQoi5a/dsOPk8SDjodIv3E+833+cOmxYAKDD3fT80tMZQrPTRJbmRzwwhfJLARYwB5mHlQ==@vger.kernel.org, AJvYcCX/MgQIW0L71/4jl+8qV+Hfg+EMSWp69rcnQmQq4rl/ZIm/X+mLRoIxfY+j/MUFUjMGCK71m/Yyij8ZNLEn@vger.kernel.org
X-Gm-Message-State: AOJu0YxrvH4cw4eRHlNXlKs92s40R/1R6DvmK4zPIejTHd8N/wfxc/FN
	pKjbkdNvZJ1JYiX7M0/BthVqdw8k4fkpAoPht/t2RPMzultC+b+o7Nov
X-Gm-Gg: ASbGncuB2bEPKstd0LhF/R683NhYZQ49vOaYwehLPJl2Qpv9sjKQZgt+TE+6szEDaRb
	bey6GeCirIrAWvn72uJrl8Ucv8g5uqFgUg2q4y1wtAVOGzKD6iJCP3U9YXbjnlZiOXHdXLfDePo
	swx7LTKcq/B7gr3yeTwYT1gRJmC83JIMYJiASxzyIeIaR/1k+I2w7rAcmhhSKrL0z/uNgesw1r8
	lL9HDGpIzGtColioLby0HeOGU0sTla7eb4PV89Hn/Wn7/mVTKJDCIAQ7E6F/E1x9GTGMHoBEXfe
	181SFwHBHdyW+MJ6bTT1WD3xQIYox+O1ntiRMkDEvNl3TxjdbHQveodSvAqBRRhjtc/DsN8dz0f
	BuwGoOI9COigNj3L37lrmLY5tNCccRNL3Ll5hp/cxWxfPiJgpjus+zv2bPZTacbPe
X-Google-Smtp-Source: AGHT+IF32esv8LZscvwNHgYR6ljsLtgAqraMmy0VAs35rpd70926148m7dEBX/SFBT9exOpIVVtZSg==
X-Received: by 2002:a5d:5d0f:0:b0:3b8:d0bb:7541 with SMTP id ffacd0b85a97d-3c5dc5426ccmr2223990f8f.40.1755864446093;
        Fri, 22 Aug 2025 05:07:26 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5393b797csm5054822f8f.39.2025.08.22.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:07:25 -0700 (PDT)
Date: Fri, 22 Aug 2025 13:04:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart
 <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, "Andre
 Almeida" <andrealmeid@igalia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Daniel Borkmann
 <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 09/10] powerpc/32: Automatically adapt TASK_SIZE
 based on constraints
Message-ID: <20250822130420.6c6a3fce@pumpkin>
In-Reply-To: <db7f9b12d731d88ac612a27e2caf4d99d76472d2.1755854833.git.christophe.leroy@csgroup.eu>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
	<db7f9b12d731d88ac612a27e2caf4d99d76472d2.1755854833.git.christophe.leroy@csgroup.eu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 11:58:05 +0200
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> At the time being, TASK_SIZE can be customized by the user via Kconfig
> but it is not possible to check all constraints in Kconfig. Impossible
> setups are detected at compile time with BUILD_BUG() but that leads
> to build failure when setting crazy values. It is not a problem on its
> own because the user will usually either use the default value or set
> a well thought value. However build robots generate crazy random
> configs that lead to build failures, and build robots see it as a
> regression every time a patch adds such a constraint.
> 
> So instead of failing the build when the custom TASK_SIZE is too
> big, just adjust it to the maximum possible value matching the setup.
> 
> Several architectures already calculate TASK_SIZE based on other
> parameters and options.
> 
> In order to do so, move MODULES_VADDR calculation into task_size_32.h
> and ensure that:
> - On book3s/32, userspace and module area have their own segments (256M)
> - On 8xx, userspace has its own full PGDIR entries (4M)
> 
> Then TASK_SIZE is garantied to be correct so remove related
                    ^ guaranteed

> BUILD_BUG()s.

