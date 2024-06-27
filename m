Return-Path: <linux-fsdevel+bounces-22668-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C466091AF9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790AB286933
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BAF19ADA3;
	Thu, 27 Jun 2024 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1kopjcR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA67200DE;
	Thu, 27 Jun 2024 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516319; cv=none; b=PiYiwYRUBcIGAnYmzIfBJBZ05MBXboWw/KgA/m5ld1aDYpwmBKFfmbWxP8TbkkT+9aUfPZGqeY43JOLFR701ucpIgfAR9PpPVpGZ7Fd0dbNsGJ9rYt17TUObQ3PzjaeP4FSA6GMVlyz3Y7r+ee08iGryIbxSEXt8MPBiPJjb0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516319; c=relaxed/simple;
	bh=Lc8XAHrT0zmh/FUZUcKgQDJdwvpeW+kZKaYEPCwqoOo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPWZWyOLKz9rmtCzu10C4rKzWXTYSKDJKPX7DS4tYbHo9hkXPZIM+yvAqFCgfxHW366R1csqdGXOSADlTd38Fnp29od7lwgdJ7dgltjuAjDRfKnrg/583keWUM7KbIUHj8LgRa37d8NEQT9Ddbljp3cb0nrcE/iO09WjohWRlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1kopjcR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42567ddf099so5359425e9.3;
        Thu, 27 Jun 2024 12:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719516316; x=1720121116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COhz4tg2KtsEzBCamCfVgtcE+Zvi+N4NuLxIdJtDu0o=;
        b=K1kopjcRPO3vT63lGmo+cGr8wwyF66EJ1SzXsv2Tnp8SA4WqvCJvTeDRtySfrO5+Ij
         6LuuDTtJ+zHZ/h+S8bOPkYuc7uzPfYzcffQmy5AphwRy5iyORmg7tYDPoTUq8yrQlnxw
         q4fRhYPswrobZ0kyqIgWjgpUtKM0Lyazn1ivrX8ZvFH3uYt4Lix+M2dMTLqtPkrxGTeI
         CSCcRGQUu0zv4Skqq+KJD8gun/Uc6FJid4muSpBlJpwuOrk1s1PHvFX5yPwwwJawW1xh
         ntwo5tboUPPD/lRbFJb42mQ4lzn/oBfzx5jhAgsgS1W8gpN3VU8dqRKEyUVIbkNTWoMA
         c9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719516316; x=1720121116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COhz4tg2KtsEzBCamCfVgtcE+Zvi+N4NuLxIdJtDu0o=;
        b=oXl89PuHsvobYETnxdmxjs2UzEwal3AwcstrB3wHpTBLCK9xq9Je0rJbie6My8kN6e
         7ocm3iqPndTaAak5yFDv34y/m8eCtFhNGlkD3BiiP3+Bx4Q10F3CYBkMkVmT/wNVFzE8
         HaJk8+wjuqjZY8O5/KTsX+f/moCjx2dngPfuPNwzdfF1wmYjVbmZQgIVb+5s5xwVVL+5
         QXZGynSdATP51F10ev4xRB8dRDQgc7XWrXvzbpJtZoN4UJiNAyHKnmzNQYjQEzRgU9dp
         wth87QRdgPONsMwQWLtqtMpjKvcfYSRKrevOKTK2i0MLYQbQAmWdqAe6ZphdVOXjaPgv
         jHsw==
X-Forwarded-Encrypted: i=1; AJvYcCXdqluAULyCPpf0XfW5mTS4JNJB3EBpeofV28iKEXaLMikcIYz/aqFnQdaPp8geSzk7IsEslN3XPwkmRuGfR+59EcbR0PkKIXZPxki4nt/BZ+x0CSRE8eEdSB0Bb+rUulfyWsu3saxRWqm5JQ==
X-Gm-Message-State: AOJu0YyoWCkT+Ddu25Lx0q1DYKD9XnbCxLy5zVhKhkWsWac75Shfdga8
	ZrLDo0g/lNghnW5VxFH5phU6Js8GGQaNvonhCHVI+zvSIoG4vKBc
X-Google-Smtp-Source: AGHT+IFDXPm4ymu9TNEODvqhbtxriYnqeeKhMAoT3n1QEaPteD3l+1IFMmU6U/hKYHoC5Ei0o8joog==
X-Received: by 2002:a05:600c:888:b0:424:a779:b5c1 with SMTP id 5b1f17b1804b1-424a779b687mr51397195e9.20.1719516315712;
        Thu, 27 Jun 2024 12:25:15 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a828sm4889945e9.37.2024.06.27.12.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:25:14 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:25:13 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <6bd118dd-de4b-4ccd-bdbe-f8c45e8ea783@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
 <mefk223e65nkizav5yvz2djgyqprrw3uclyctvebdvr2crph34@cktxpmr6bdgq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mefk223e65nkizav5yvz2djgyqprrw3uclyctvebdvr2crph34@cktxpmr6bdgq>

On Thu, Jun 27, 2024 at 01:20:30PM -0400, Liam R. Howlett wrote:
[snip]
> > +
> > +clean:
> > +	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
>
> This needs to clean out vma.c to avoid stale testing.
>
> But, none of this is needed.
>
> What we can do instead is add the correct header guards to the
> mm/vma_internal.h file, change the tools/testing/vma/vma_internal.h
> header guards to be the same (ie: remove TESTING_ from the existing
> ones), then we can include vma_internal.h into vma_stub.c prior to
> including "../../../mm/vma.c", and we don't need to copy the file.
>
> Essentially use the #ifdef guards to replace the header by ordering the
> local header for inclusion prior to the c file.

Ack this is a good idea, will do in v2.

>
>
> > diff --git a/tools/testing/vma/errors.txt b/tools/testing/vma/errors.txt
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/tools/testing/vma/generated/autoconf.h b/tools/testing/vma/generated/autoconf.h
> > new file mode 100644
> > index 000000000000..92dc474c349b
> > --- /dev/null
> > +++ b/tools/testing/vma/generated/autoconf.h
> > @@ -0,0 +1,2 @@
> > +#include "bit-length.h"
> > +#define CONFIG_XARRAY_MULTI 1
> > diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
> > new file mode 100644
> > index 000000000000..298b0fb7aab2
> > --- /dev/null
> > +++ b/tools/testing/vma/linux/atomic.h
>
> This should have header guards as well.

Yup, the reason I kept it like this is because existing linux/*.h headers
in shared/linux didn't have header guards and I wanted to keep things in
line with that... will change.

>
> > @@ -0,0 +1,19 @@
> > +#ifndef atomic_t
> > +#define atomic_t int32_t
> > +#endif
> > +
> > +#ifndef atomic_inc
> > +#define atomic_inc(x) uatomic_inc(x)
> > +#endif
> > +
> > +#ifndef atomic_read
> > +#define atomic_read(x) uatomic_read(x)
> > +#endif
> > +
> > +#ifndef atomic_set
> > +#define atomic_set(x, y) do {} while (0)
> > +#endif
> > +
> > +#ifndef U8_MAX
> > +#define U8_MAX UCHAR_MAX
> > +#endif
> > diff --git a/tools/testing/vma/linux/mmzone.h b/tools/testing/vma/linux/mmzone.h
> > new file mode 100644
> > index 000000000000..71546e15bdd3
> > --- /dev/null
> > +++ b/tools/testing/vma/linux/mmzone.h
> > @@ -0,0 +1,37 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TOOLS_MMZONE_H
> > +#define _TOOLS_MMZONE_H
>
> It might be best to use the same guards here to avoid mmzone.h from
> getting pulled in.

You mean the actual [root]/include/linux/mmzone.h ? Just deploying the same
header guard trick as mentioned above re: vma_internal.h?

[snip]

> > new file mode 100644
> > index 000000000000..b29eeb0daf31
> > --- /dev/null
> > +++ b/tools/testing/vma/main.c
>
> If you employ the use of header guards, we can rename main.c to vma.c
> and produce the executable "vma" instead of "main".

Sure, will do.

>
> > @@ -0,0 +1,161 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <assert.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include "maple-shared.h"
> > +#include "vma_internal.h"
> > +#include "vma.h"
>
> You can directly include "../../../mm/vma.h" here and remove the vma.h
> file you have in this directory.

This was, I think, to keep to a convention, but you're right I don't think
there's any reason to do this, will change.

[snip]

> > +int main(void)
> > +{
> > +	maple_tree_init();
> > +
> > +	test_simple_merge();
> > +	test_simple_modify();
> > +	test_simple_expand();
> > +	test_simple_shrink();
> > +
> > +	return EXIT_SUCCESS;
> > +}
>
> It would be nice to have some output stating the number of tests
> passed/failed.

Ack, will add.

>
> > diff --git a/tools/testing/vma/vma.h b/tools/testing/vma/vma.h
> > new file mode 100644
> > index 000000000000..87a6cb222b63
> > --- /dev/null
> > +++ b/tools/testing/vma/vma.h
> > @@ -0,0 +1,3 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#include "../../../mm/vma.h"
>
> I'd rather just drop this file and have this line in main.c (or vma.c if
> you decide to rename it).

Ack, will do.

[snip]

