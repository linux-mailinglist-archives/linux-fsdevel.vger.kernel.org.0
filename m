Return-Path: <linux-fsdevel+bounces-22676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2054A91AFD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D41F22BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 19:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A5C14EC64;
	Thu, 27 Jun 2024 19:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYBV3U46"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA21E1BF58;
	Thu, 27 Jun 2024 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719517577; cv=none; b=IlpoPC2m65/f64TVDma0XY29VVuY7iW4uwDoheupXFoaQ7Mr7mb5SU+PbEascGaz0D4Kj8cOLH41af7LE425uUirFsUR5ZP+C//aq4Yla7XvDfXHpLUXPiT1cSJYLebOafhz3QkEOFY/TIXir/EEMy8W+nnSZiePj5eewX2Tv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719517577; c=relaxed/simple;
	bh=G2IbdVFb0ONp8V3/dWUVbV9YYFmJvWuOfJKgyKnTb2Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc9dGd0dkmyo7zSaxMF6nSO5VIPmdwlnpKVWtQR/1/BPAJqWgue6J4Vo04/sPLblEWxoXDbhYHLkIcFcZ/ewYkzOY2QdoRFdWRD0kxfxcV6EnH6FTmeRIpDfwyTR/Gn9aXCkxAR1790zjokyQj8KLNJ//VGFZme1EGxD2Pp5KwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYBV3U46; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3674e1931b7so605795f8f.2;
        Thu, 27 Jun 2024 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719517573; x=1720122373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=age6AsIuh5Rf9q7SxRHdgGO4kPFxXF4+7BpK4Tl2/mc=;
        b=eYBV3U46J3szHOqLUMMwtpOUDL4QZ02C3gkvRZNrF/+na0SxI6Rvfi/PBe/YpNG8I2
         QnmXIlwaXjcOcD9zMXmugztSDvIGOlTAAHbIQv8ksDwImt+OZPUjP2XWBvc7avihO472
         15g82zLIencyuoqQ0ZUE6mJ1n/AaDoSBTiNrhKpzE2tU2HzZZYon0RdfktWO1O5b8HSA
         klonX/5G1kLMSRR5+YoPF04YeYlqKWFz3hEokpWEZJtgB8kt9QqvzJrZoJFB3yXjzNac
         S2uhIq7mh8sLxbhBBixS0hY9ulCj2NaQVupO9hGnvhcH5dL4cJvEif0Q+EZLuHo60wPY
         gOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719517573; x=1720122373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=age6AsIuh5Rf9q7SxRHdgGO4kPFxXF4+7BpK4Tl2/mc=;
        b=LtGmfMc+zEBDTPWUUUsZEC09Pa8uVfSVJ8KHWKJXaNO4TaTQvXDgFG6bh7+XJGzvC1
         SBBFrTnPOQyme2kfD+bkE0nXxIB02Ifony6Ne9FxzVoyccfZXJWPduwSmvS9JScoKtMd
         Nr1pI51NqG9r7CnGA05z/JFvLBcms7Oa6hvvM55SFsU+kzgk2CFHpZm46/omyini59HH
         i/T+c8edqwWPxNYUQLAnm5WRkGxNZbYJxTvH637qEptjBkS+7MUUApDnv5fl0H1aTF+H
         p2IHWQ5OQjS4VwqG3U20HY4om11sOd9aQNprq6wkvxnYMIJCDK5Em4FaMmo/6C5aI28+
         vysA==
X-Forwarded-Encrypted: i=1; AJvYcCXlZJPY8nReQjvqEQdvrnxI1W4tk+Bq2kbcRfYfowSFtWmtQAtv5ws583Sf6u/yBC003GaXP9GNn0LTWMlWcCbCzTfKTLcM575qI/LmHKUAt9VDoGIxUYoWIQb/3sc8M124sNe6ZRhDULSJuw==
X-Gm-Message-State: AOJu0YyIENW7ylmA3vnHCwKmLC+P7mMLBXaQDJ+VbrBfRUfr/RT+oyF+
	QkVDMnUUJM2T49pw4YGBO+vrNmSju+xWw1BSRvVNJbrQFxV074Iu
X-Google-Smtp-Source: AGHT+IGJZFJUcoUIPSRfrEzTaFHGLZfdt34HEVKQhauu8tvQUZP9L+k1jNutgxqScms6dhGWFakNBA==
X-Received: by 2002:a05:6000:2a7:b0:366:eb61:b45 with SMTP id ffacd0b85a97d-366eb610bc7mr11798347f8f.1.1719517572808;
        Thu, 27 Jun 2024 12:46:12 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0e12d7sm164182f8f.51.2024.06.27.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 12:46:11 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:46:11 +0100
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
Subject: Re: [RFC PATCH 6/7] tools: separate out shared radix-tree components
Message-ID: <c2797b55-59cd-4731-899f-015631c1e553@lucifer.local>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <c23f1b80c62bc906267a8b144befe7ac96daa88c.1719481836.git.lstoakes@gmail.com>
 <3kswdhugo2jmlkejboymem4yhakird5fvmnbschicaldwjwu7x@6c6z5lk4ctvy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3kswdhugo2jmlkejboymem4yhakird5fvmnbschicaldwjwu7x@6c6z5lk4ctvy>

On Thu, Jun 27, 2024 at 01:59:18PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lstoakes@gmail.com> [240627 06:39]:
> > The core components contained within the radix-tree tests which provide
> > shims for kernel headers and access to the maple tree are useful for
> > testing other things, so separate them out and make the radix tree tests
> > dependent on the shared components.
> >
> > This lays the groundwork for us to add VMA tests of the newly introduced
> > vma.c file.
>
> This separation and subsequent patch requires building the
> xarray-hsared, radix-tree, idr, find_bit, and bitmap .o files which are
> unneeded for the target 'main'.  I'm not a build expert on how to fix
> this, but could that be reduced to the minimum set somehow?

I'm confused, the existing Makefile specified:

CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
			 slab.o maple.o

OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
	 iteration_check_2.o benchmark.o

main:	$(OFILES)

Making all of the files you mentioned dependencies of main no? (xarray-shared
being a subset of xarray.o which requires it anyway)

I'm not sure this is a huge big deal as these are all rather small :)

>
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  tools/testing/radix-tree/Makefile             | 68 +++----------------
> >  tools/testing/radix-tree/maple.c              | 14 +---
> >  tools/testing/radix-tree/xarray.c             |  9 +--
> >  tools/testing/shared/autoconf.h               |  2 +
> >  tools/testing/{radix-tree => shared}/bitmap.c |  0
> >  tools/testing/{radix-tree => shared}/linux.c  |  0
> >  .../{radix-tree => shared}/linux/bug.h        |  0
> >  .../{radix-tree => shared}/linux/cpu.h        |  0
> >  .../{radix-tree => shared}/linux/idr.h        |  0
> >  .../{radix-tree => shared}/linux/init.h       |  0
> >  .../{radix-tree => shared}/linux/kconfig.h    |  0
> >  .../{radix-tree => shared}/linux/kernel.h     |  0
> >  .../{radix-tree => shared}/linux/kmemleak.h   |  0
> >  .../{radix-tree => shared}/linux/local_lock.h |  0
> >  .../{radix-tree => shared}/linux/lockdep.h    |  0
> >  .../{radix-tree => shared}/linux/maple_tree.h |  0
> >  .../{radix-tree => shared}/linux/percpu.h     |  0
> >  .../{radix-tree => shared}/linux/preempt.h    |  0
> >  .../{radix-tree => shared}/linux/radix-tree.h |  0
> >  .../{radix-tree => shared}/linux/rcupdate.h   |  0
> >  .../{radix-tree => shared}/linux/xarray.h     |  0
> >  tools/testing/shared/maple-shared.h           |  9 +++
> >  tools/testing/shared/maple-shim.c             |  7 ++
> >  tools/testing/shared/shared.h                 | 34 ++++++++++
> >  tools/testing/shared/shared.mk                | 68 +++++++++++++++++++
> >  .../testing/shared/trace/events/maple_tree.h  |  5 ++
> >  tools/testing/shared/xarray-shared.c          |  5 ++
> >  tools/testing/shared/xarray-shared.h          |  4 ++
> >  28 files changed, 147 insertions(+), 78 deletions(-)
> >  create mode 100644 tools/testing/shared/autoconf.h
> >  rename tools/testing/{radix-tree => shared}/bitmap.c (100%)
> >  rename tools/testing/{radix-tree => shared}/linux.c (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/bug.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/cpu.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/idr.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/init.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/kconfig.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/kernel.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/kmemleak.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/local_lock.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/lockdep.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/maple_tree.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/percpu.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/preempt.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/radix-tree.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/rcupdate.h (100%)
> >  rename tools/testing/{radix-tree => shared}/linux/xarray.h (100%)
> >  create mode 100644 tools/testing/shared/maple-shared.h
> >  create mode 100644 tools/testing/shared/maple-shim.c
> >  create mode 100644 tools/testing/shared/shared.h
> >  create mode 100644 tools/testing/shared/shared.mk
> >  create mode 100644 tools/testing/shared/trace/events/maple_tree.h
> >  create mode 100644 tools/testing/shared/xarray-shared.c
> >  create mode 100644 tools/testing/shared/xarray-shared.h
> >
> > diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
> > index 7527f738b4a1..29d607063749 100644
> > --- a/tools/testing/radix-tree/Makefile
> > +++ b/tools/testing/radix-tree/Makefile
> > @@ -1,29 +1,16 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
> > -	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> > -LDFLAGS += -fsanitize=address -fsanitize=undefined
> > -LDLIBS+= -lpthread -lurcu
> > -TARGETS = main idr-test multiorder xarray maple
> > -CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
> > -			 slab.o maple.o
> > -OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
> > -	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
> > -	 iteration_check_2.o benchmark.o
> > +.PHONY: default
> >
> > -ifndef SHIFT
> > -	SHIFT=3
> > -endif
> > +default: main
> >
> > -ifeq ($(BUILD), 32)
> > -	CFLAGS += -m32
> > -	LDFLAGS += -m32
> > -LONG_BIT := 32
> > -endif
> > +include ../shared/shared.mk
> >
> > -ifndef LONG_BIT
> > -LONG_BIT := $(shell getconf LONG_BIT)
> > -endif
> > +TARGETS = main idr-test multiorder xarray maple
> > +CORE_OFILES = $(SHARED_OFILES) xarray.o maple.o test.o
> > +OFILES = main.o $(CORE_OFILES) regression1.o regression2.o \
> > +	 regression3.o regression4.o tag_check.o multiorder.o idr-test.o \
> > +	iteration_check.o iteration_check_2.o benchmark.o
> >
> >  targets: generated/map-shift.h generated/bit-length.h $(TARGETS)
> >
> > @@ -32,46 +19,13 @@ main:	$(OFILES)
> >  idr-test.o: ../../../lib/test_ida.c
> >  idr-test: idr-test.o $(CORE_OFILES)
> >
> > -xarray: $(CORE_OFILES)
> > +xarray: $(CORE_OFILES) xarray.o
> >
> > -maple: $(CORE_OFILES)
> > +maple: $(CORE_OFILES) maple.o
> >
> >  multiorder: multiorder.o $(CORE_OFILES)
> >
> >  clean:
> >  	$(RM) $(TARGETS) *.o radix-tree.c idr.c generated/map-shift.h generated/bit-length.h
> >
> > -vpath %.c ../../lib
> > -
> > -$(OFILES): Makefile *.h */*.h generated/map-shift.h generated/bit-length.h \
> > -	../../include/linux/*.h \
> > -	../../include/asm/*.h \
> > -	../../../include/linux/xarray.h \
> > -	../../../include/linux/maple_tree.h \
> > -	../../../include/linux/radix-tree.h \
> > -	../../../lib/radix-tree.h \
> > -	../../../include/linux/idr.h
> > -
> > -radix-tree.c: ../../../lib/radix-tree.c
> > -	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> > -
> > -idr.c: ../../../lib/idr.c
> > -	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> > -
> > -xarray.o: ../../../lib/xarray.c ../../../lib/test_xarray.c
> > -
> > -maple.o: ../../../lib/maple_tree.c ../../../lib/test_maple_tree.c
> > -
> > -generated/map-shift.h:
> > -	@if ! grep -qws $(SHIFT) generated/map-shift.h; then		\
> > -		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >		\
> > -				generated/map-shift.h;			\
> > -	fi
> > -
> > -generated/bit-length.h: FORCE
> > -	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
> > -		echo "Generating $@";                                        \
> > -		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> > -	fi
> > -
> > -FORCE: ;
> > +$(OFILES): $(SHARED_DEPS) *.h */*.h
> > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> > index f1caf4bcf937..5b53ecf22fc4 100644
> > --- a/tools/testing/radix-tree/maple.c
> > +++ b/tools/testing/radix-tree/maple.c
> > @@ -8,20 +8,8 @@
> >   * difficult to handle in kernel tests.
> >   */
> >
> > -#define CONFIG_DEBUG_MAPLE_TREE
> > -#define CONFIG_MAPLE_SEARCH
> > -#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> > +#include "maple-shared.h"
> >  #include "test.h"
> > -#include <stdlib.h>
> > -#include <time.h>
> > -#include "linux/init.h"
> > -
> > -#define module_init(x)
> > -#define module_exit(x)
> > -#define MODULE_AUTHOR(x)
> > -#define MODULE_LICENSE(x)
> > -#define dump_stack()	assert(0)
> > -
> >  #include "../../../lib/maple_tree.c"
> >  #include "../../../lib/test_maple_tree.c"
> >
> > diff --git a/tools/testing/radix-tree/xarray.c b/tools/testing/radix-tree/xarray.c
> > index f20e12cbbfd4..253208a8541b 100644
> > --- a/tools/testing/radix-tree/xarray.c
> > +++ b/tools/testing/radix-tree/xarray.c
> > @@ -4,16 +4,9 @@
> >   * Copyright (c) 2018 Matthew Wilcox <willy@infradead.org>
> >   */
> >
> > -#define XA_DEBUG
> > +#include "xarray-shared.h"
> >  #include "test.h"
> >
> > -#define module_init(x)
> > -#define module_exit(x)
> > -#define MODULE_AUTHOR(x)
> > -#define MODULE_LICENSE(x)
> > -#define dump_stack()	assert(0)
> > -
> > -#include "../../../lib/xarray.c"
> >  #undef XA_DEBUG
> >  #include "../../../lib/test_xarray.c"
> >
> > diff --git a/tools/testing/shared/autoconf.h b/tools/testing/shared/autoconf.h
> > new file mode 100644
> > index 000000000000..92dc474c349b
> > --- /dev/null
> > +++ b/tools/testing/shared/autoconf.h
> > @@ -0,0 +1,2 @@
> > +#include "bit-length.h"
> > +#define CONFIG_XARRAY_MULTI 1
> > diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/shared/bitmap.c
> > similarity index 100%
> > rename from tools/testing/radix-tree/bitmap.c
> > rename to tools/testing/shared/bitmap.c
> > diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/shared/linux.c
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux.c
> > rename to tools/testing/shared/linux.c
> > diff --git a/tools/testing/radix-tree/linux/bug.h b/tools/testing/shared/linux/bug.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/bug.h
> > rename to tools/testing/shared/linux/bug.h
> > diff --git a/tools/testing/radix-tree/linux/cpu.h b/tools/testing/shared/linux/cpu.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/cpu.h
> > rename to tools/testing/shared/linux/cpu.h
> > diff --git a/tools/testing/radix-tree/linux/idr.h b/tools/testing/shared/linux/idr.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/idr.h
> > rename to tools/testing/shared/linux/idr.h
> > diff --git a/tools/testing/radix-tree/linux/init.h b/tools/testing/shared/linux/init.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/init.h
> > rename to tools/testing/shared/linux/init.h
> > diff --git a/tools/testing/radix-tree/linux/kconfig.h b/tools/testing/shared/linux/kconfig.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/kconfig.h
> > rename to tools/testing/shared/linux/kconfig.h
> > diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/shared/linux/kernel.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/kernel.h
> > rename to tools/testing/shared/linux/kernel.h
> > diff --git a/tools/testing/radix-tree/linux/kmemleak.h b/tools/testing/shared/linux/kmemleak.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/kmemleak.h
> > rename to tools/testing/shared/linux/kmemleak.h
> > diff --git a/tools/testing/radix-tree/linux/local_lock.h b/tools/testing/shared/linux/local_lock.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/local_lock.h
> > rename to tools/testing/shared/linux/local_lock.h
> > diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/shared/linux/lockdep.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/lockdep.h
> > rename to tools/testing/shared/linux/lockdep.h
> > diff --git a/tools/testing/radix-tree/linux/maple_tree.h b/tools/testing/shared/linux/maple_tree.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/maple_tree.h
> > rename to tools/testing/shared/linux/maple_tree.h
> > diff --git a/tools/testing/radix-tree/linux/percpu.h b/tools/testing/shared/linux/percpu.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/percpu.h
> > rename to tools/testing/shared/linux/percpu.h
> > diff --git a/tools/testing/radix-tree/linux/preempt.h b/tools/testing/shared/linux/preempt.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/preempt.h
> > rename to tools/testing/shared/linux/preempt.h
> > diff --git a/tools/testing/radix-tree/linux/radix-tree.h b/tools/testing/shared/linux/radix-tree.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/radix-tree.h
> > rename to tools/testing/shared/linux/radix-tree.h
> > diff --git a/tools/testing/radix-tree/linux/rcupdate.h b/tools/testing/shared/linux/rcupdate.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/rcupdate.h
> > rename to tools/testing/shared/linux/rcupdate.h
> > diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/shared/linux/xarray.h
> > similarity index 100%
> > rename from tools/testing/radix-tree/linux/xarray.h
> > rename to tools/testing/shared/linux/xarray.h
> > diff --git a/tools/testing/shared/maple-shared.h b/tools/testing/shared/maple-shared.h
> > new file mode 100644
> > index 000000000000..3d847edd149d
> > --- /dev/null
> > +++ b/tools/testing/shared/maple-shared.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#define CONFIG_DEBUG_MAPLE_TREE
> > +#define CONFIG_MAPLE_SEARCH
> > +#define MAPLE_32BIT (MAPLE_NODE_SLOTS > 31)
> > +#include "shared.h"
> > +#include <stdlib.h>
> > +#include <time.h>
> > +#include "linux/init.h"
> > diff --git a/tools/testing/shared/maple-shim.c b/tools/testing/shared/maple-shim.c
> > new file mode 100644
> > index 000000000000..640df76f483e
> > --- /dev/null
> > +++ b/tools/testing/shared/maple-shim.c
> > @@ -0,0 +1,7 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +/* Very simple shim around the maple tree. */
> > +
> > +#include "maple-shared.h"
> > +
> > +#include "../../../lib/maple_tree.c"
> > diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
> > new file mode 100644
> > index 000000000000..495602e60b65
> > --- /dev/null
> > +++ b/tools/testing/shared/shared.h
> > @@ -0,0 +1,34 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#include <linux/types.h>
> > +#include <linux/bug.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bitops.h>
> > +
> > +#include <linux/gfp.h>
> > +#include <linux/types.h>
> > +#include <linux/rcupdate.h>
> > +
> > +#ifndef module_init
> > +#define module_init(x)
> > +#endif
> > +
> > +#ifndef module_exit
> > +#define module_exit(x)
> > +#endif
> > +
> > +#ifndef MODULE_AUTHOR
> > +#define MODULE_AUTHOR(x)
> > +#endif
> > +
> > +#ifndef MODULE_LICENSE
> > +#define MODULE_LICENSE(x)
> > +#endif
> > +
> > +#ifndef MODULE_DESCRIPTION
> > +#define MODULE_DESCRIPTION(x)
> > +#endif
> > +
> > +#ifndef dump_stack
> > +#define dump_stack()	assert(0)
> > +#endif
> > diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> > new file mode 100644
> > index 000000000000..69a6a528eaed
> > --- /dev/null
> > +++ b/tools/testing/shared/shared.mk
> > @@ -0,0 +1,68 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +CFLAGS += -I../shared -I. -I../../include -I../../../lib -g -Og -Wall \
> > +	  -D_LGPL_SOURCE -fsanitize=address -fsanitize=undefined
> > +LDFLAGS += -fsanitize=address -fsanitize=undefined
> > +LDLIBS += -lpthread -lurcu
> > +SHARED_OFILES = xarray-shared.o radix-tree.o idr.o linux.o find_bit.o bitmap.o \
> > +	slab.o
> > +SHARED_DEPS = Makefile ../shared/shared.mk ../shared/*.h generated/map-shift.h \
> > +	generated/bit-length.h generated/autoconf.h \
> > +	../../include/linux/*.h \
> > +	../../include/asm/*.h \
> > +	../../../include/linux/xarray.h \
> > +	../../../include/linux/maple_tree.h \
> > +	../../../include/linux/radix-tree.h \
> > +	../../../lib/radix-tree.h \
> > +	../../../include/linux/idr.h
> > +
> > +ifndef SHIFT
> > +	SHIFT=3
> > +endif
> > +
> > +ifeq ($(BUILD), 32)
> > +	CFLAGS += -m32
> > +	LDFLAGS += -m32
> > +LONG_BIT := 32
> > +endif
> > +
> > +ifndef LONG_BIT
> > +LONG_BIT := $(shell getconf LONG_BIT)
> > +endif
> > +
> > +%.o: ../shared/%.c
> > +	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
> > +
> > +vpath %.c ../../lib
> > +
> > +$(SHARED_OFILES): $(SHARED_DEPS)
> > +
> > +radix-tree.c: ../../../lib/radix-tree.c
> > +	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> > +
> > +idr.c: ../../../lib/idr.c
> > +	sed -e 's/^static //' -e 's/__always_inline //' -e 's/inline //' < $< > $@
> > +
> > +xarray-shared.o: ../shared/xarray-shared.c ../../../lib/xarray.c \
> > +	../../../lib/test_xarray.c
> > +
> > +maple-shared.o: ../shared/maple-shared.c ../../../lib/maple_tree.c \
> > +	../../../lib/test_maple_tree.c
> > +
> > +generated/autoconf.h:
> > +	cp ../shared/autoconf.h generated/autoconf.h
> > +
> > +generated/map-shift.h:
> > +	@if ! grep -qws $(SHIFT) generated/map-shift.h; then            \
> > +		echo "Generating $@";                                   \
> > +		echo "#define XA_CHUNK_SHIFT $(SHIFT)" >                \
> > +				generated/map-shift.h;                  \
> > +	fi
> > +
> > +generated/bit-length.h: FORCE
> > +	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
> > +		echo "Generating $@";                                        \
> > +		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> > +	fi
> > +
> > +FORCE: ;
> > diff --git a/tools/testing/shared/trace/events/maple_tree.h b/tools/testing/shared/trace/events/maple_tree.h
> > new file mode 100644
> > index 000000000000..97d0e1ddcf08
> > --- /dev/null
> > +++ b/tools/testing/shared/trace/events/maple_tree.h
> > @@ -0,0 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#define trace_ma_op(a, b) do {} while (0)
> > +#define trace_ma_read(a, b) do {} while (0)
> > +#define trace_ma_write(a, b, c, d) do {} while (0)
> > diff --git a/tools/testing/shared/xarray-shared.c b/tools/testing/shared/xarray-shared.c
> > new file mode 100644
> > index 000000000000..e90901958dcd
> > --- /dev/null
> > +++ b/tools/testing/shared/xarray-shared.c
> > @@ -0,0 +1,5 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +#include "xarray-shared.h"
> > +
> > +#include "../../../lib/xarray.c"
> > diff --git a/tools/testing/shared/xarray-shared.h b/tools/testing/shared/xarray-shared.h
> > new file mode 100644
> > index 000000000000..ac2d16ff53ae
> > --- /dev/null
> > +++ b/tools/testing/shared/xarray-shared.h
> > @@ -0,0 +1,4 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ */
> > +
> > +#define XA_DEBUG
> > +#include "shared.h"
> > --
> > 2.45.1
> >

