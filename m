Return-Path: <linux-fsdevel+bounces-39334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DFFA12D05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 21:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7A13A6C4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 20:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5320A1DA61B;
	Wed, 15 Jan 2025 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UDFgmcnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B01D9A78
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 20:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974395; cv=none; b=YiozRaO9juispQSLaEuSQfPexjOktrcakmsWAKlmF/SJ/wq/2OajHdS4VTHv3rUZFmicpY/npxAManZF1FBtqQW1nkAl4Fya8SWCkA4tH527PkF3da75POHqLos63CXADz6lLA/kkn38uq/MyymuwGSlFt1MppTxLLcCGbDnSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974395; c=relaxed/simple;
	bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCt0PkAdM/vWEg3/An2J/U23nj+o+3tNEpR2VVm+Q+FgsrrWqTFrdSUDzuKcU1X7xMT3b9Uvs8MRKfq8bAEhpl2TNiuWJGln1JtZoGKJ/diKMhjfH0Hts7VK4phgSQ0furoPNgQGfjj+T5UFptBOTehfnbl0wKqNEstL8MzYvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UDFgmcnJ; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85bafa89d73so25314241.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 12:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736974393; x=1737579193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
        b=UDFgmcnJ09TDFATDfWJzibjN4HOKnt7F0JjQCJligN2bGgmU4dyHkYtckWD/oh+qyH
         TKKrmH1QExYvFdZIAm9E36DTDj1HW3sY/3PYYN+Vu6oOrcWUEluabbWaJCTlgGyeSNke
         KFkUiGQRl1YN00CCg/ns/mkM4r9JgG5Q0yXZeDedJWdzfvcz8HB1Ke/FbE5AbGYV9dMf
         q2cx79dp3lmFlIbtiDRHs4ZQG9dE8AGlJGO4+tLLW5wE9t3hBSDibGIs/Rs5fbtMrRJZ
         QN7D7LGrqxA9uw+xcXfpJELOE2WBugB61rfjVQR5/GoDAbQBlkO/8mNdVHScHQFRDZts
         iFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974393; x=1737579193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdXo8lbXht5SZgkZQ04ipp/CMqgcMbj1MEn0xWqPJMs=;
        b=aXoGuJE9d90oyzd62CnYp2XHmdrsQ+f4/S/a/Y7LmyseytdS/JZnVajL0lwhP646AO
         1eDbIotpa9eDkA9qH4LOLAKjh1z/9x5tyABf84PnKALenE/gkBtPWD3qE3kVcT9l+SSA
         R+WELiljZ+Bbd40Cbqvot6+ffN+PV3oQykzt8eAsTYk/03/CnVgbrU+U3kePEIKBr7jG
         3ihqZA0TSuirb/eELkiNxVoetOmOcXYuN3752hMun8+T8tF9RrnDlbtdjkxKlAwFYRLI
         4iL5Y9LouSjDaGSigmUJQbx1JdkGVY+6NXfxcSWbDIs6LjEVrFHhcGKQaI7yulCx06U2
         SjYw==
X-Forwarded-Encrypted: i=1; AJvYcCVCKB6Sx7JiIk4LpNK9s4O1Alrz4gb1G80E9ih5LzqlF3+13V6qgtR8Z//OusOt77xTRhuvUGtMOhG9Rf7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YznzC0TF70LgvYpP9ZoGOdVgV76zbG8GDHJ0FfvaOp74eSRka8t
	tc5FCZqHBNYVpgsmtyFP5Nfd7KPCVkS1BHEQ2eSzLh2N2/MMVk5+7BCCv7LESpf+Ot18c+HptWB
	10TdawOjLPes9XFAFVsauwPFEPxkINI4DEg6X
X-Gm-Gg: ASbGncs57LrFXMzWiy+6dPQ0FJdMPzS8mEqbKGEm9RlZlRKBtR2PcQVnqoLBKho+XEf
	x/4YrFlSKdS2jiJiAqToOsHszDyMuV0lssEO6wLGrep9cwU8h5XRKSuICbtEG238EZNt3
X-Google-Smtp-Source: AGHT+IE7UsauDDLDB3PU6I85iW+57wTMyoC2RI6ZhjsNUrio1gBO9Rw8foY1mGOBbUURNkj3/A70Nc+YgN9e75p3kqQ=
X-Received: by 2002:a05:6102:ccb:b0:4b6:20a5:776 with SMTP id
 ada2fe7eead31-4b620a50949mr21061479137.17.1736974392789; Wed, 15 Jan 2025
 12:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115093135.3288234-1-kirill.shutemov@linux.intel.com> <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
In-Reply-To: <20250115093135.3288234-12-kirill.shutemov@linux.intel.com>
From: Yu Zhao <yuzhao@google.com>
Date: Wed, 15 Jan 2025 13:52:36 -0700
X-Gm-Features: AbW1kvZLvuakft1NqA0r5gmvnmIH6WfLrEQ0-PFFagHKXbdONcPPwciIY5N5R1w
Message-ID: <CAOUHufa8FZY0tQ8Camv7mHN9tWPYLxcpjt5rFTDLg+NwYULOQQ@mail.gmail.com>
Subject: Re: [PATCHv2 11/11] mm: Rename PG_dropbehind to PG_reclaim
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dan Carpenter <dan.carpenter@linaro.org>, 
	David Airlie <airlied@gmail.com>, David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, Yosry Ahmed <yosryahmed@google.com>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 2:32=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Now as PG_reclaim is gone, its name can be reclaimed for better
> use :)
>
> Rename PG_dropbehind to PG_reclaim and rename all helpers around it.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Yu Zhao <yuzhao@google.com>

