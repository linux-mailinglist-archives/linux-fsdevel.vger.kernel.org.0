Return-Path: <linux-fsdevel+bounces-54682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D13B0226E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE21C16EEEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7217B2EF643;
	Fri, 11 Jul 2025 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkBlRWob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440411547CC;
	Fri, 11 Jul 2025 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752254165; cv=none; b=h9T9UN1uJ6VLqboqne0sRxtgvCYKTIFRlSdfD1qFXKxff52rDOcCdidduwAqy9VwZAlXoTDiRgsWb2Pg2mBUrxV9L3dOB80De8UUXcuBEXDpT7CPreA+Wwi24es9GjbgjcTU0zeSi/W7YJ+eXG4lJasYe7z5QHaYpxWP1+e45DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752254165; c=relaxed/simple;
	bh=punT/qboQi6RwL4rhScmANJJEIkXEYqHxfa0D+uO4Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W15EhCpr2T1VsyJPEgANnVDZ6xNnILVV9r5kycK0sBCRW03KgU8GwieYgeLNugBhzwT9/9rudbTgbtK8m4t+1pyTR2RDou3So5WQKeMEmAzZyz5bSDvomfytF3r7kACyrxoRRqqmayPsjNhy57CPksnIrTY9BwZ4xcxJ7vn8HxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkBlRWob; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso13775145e9.1;
        Fri, 11 Jul 2025 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752254163; x=1752858963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgDIVlF1DvYfUM2yQqqKFY/jQV517y2whN5qoc38Vxc=;
        b=gkBlRWob7+1RCeHVZLecQ9Lde3df+2x301kewbb8FRdDZ6DLzkqUjj09TYlYKonWGT
         ayjwe5RWc2wJzf75IsEKzTZKNyXH0JTzyJo7DZKco7nLvWlJY6uY8hA0q9n7FSYbUTvh
         bOOnMn0qj5PrxgwXWu3NDGJdC1HHqAHx9FqgGHzknRyp53XTDCONdSJzHSbs6aE3xG2g
         i4J8AcHWlbpWZaHqpJ8rt6Jgdz1HVUAoulrtpbhYncf299TYqYKeFbRpJ0DCjhDNmMgc
         luTe14btUuwn4+j0j9C4XyhsakaKp3qQGNs39FC0Z2wVzKZHq3AU+MC/b9W7CVQuEAc2
         hY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752254163; x=1752858963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgDIVlF1DvYfUM2yQqqKFY/jQV517y2whN5qoc38Vxc=;
        b=EvmF7hpGxumDSLGr9mBv8OLJuW7Qsf/mypertDr5VoNb9k+9iMGkFbDp6XmUEwNMMn
         Na8kw0MxNXZ4jYpMu+sumsOfd/GEND198XT92R2Fv64k5B0iN64sv7rYmzNexLSprntR
         RIjVIrOB6Trg1VBWZ4nVx5ox4tf/tzbQ33c2eo1Imae09UuYm3yNc9HxyMPdw6RA0nvT
         rUhEn9UZv4pHu76nYjOw9AS+rWIvmaqDDFSgDPwyq2ruIsvSgHCLAylUmd0NpWWROzBE
         NtW1MhUWBVFTiOVt2O+d+Q1uTGIfsnWJSmAPjzerH5WMKyZjDXHBlAShHGV2gXIp63NN
         ExwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IzkWd0iE0qFHGfSBWZ3bzrYV5b8c/MrINNauGmZMt7AfzFPvXsGtyVszX19v5oN56nxSDpdNPMRcIMKU3w==@vger.kernel.org, AJvYcCW7PbMVUusxk088m0LygdZkHOvxIhAvq49ih6epvz7RDb9TB5R6OObQBaQcWU6UGVJmyaOhpp0KvVWer6TtIg==@vger.kernel.org, AJvYcCWP4tMlHiXKNPi+Yx7p84vJjgxi2xLJcKqNn0L4pKLdlGk19M9WawdRNM4X7TOXmpD0KIstW6JFfd0=@vger.kernel.org, AJvYcCXZhE8vH4SvRrGn9MvgQT3ATBqLpNMsehTjsnFpJ/qyaFezCZFZrPW4+Ku4/nEt0ootdHZx2pBMYQI1T1BH@vger.kernel.org, AJvYcCXj6Epwpp3aQiZlFyZt+nUZqicfmicXRIU4n88gNL4YTvWUa1xfwVU4HvilARd2UA6jP2fQYKj3nITRO4P0@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwyhAg7M8MXxLvwRri7gdZC/4N3MZ0G3zKXNE1ERsGksgBEj1
	PFbKtJn2jf/cJKgVEduScde4wLrptU9itRD31IvsextjKvc2FhsCp/EJ
X-Gm-Gg: ASbGnctw+wbHFPL5/Ei6g4WeH3RiUNAwAH3uYjfexNP/VJmlLJ44I1kCLhFlV2maJcZ
	OuatrvbsqnVDzpP/2ByWHLJXlhyqcd9vOasr+NWYXzRqG2APSosTL/eqfndQjHwco5S222wOku3
	vmNCEulL7QpNtSy1LGePuvw6WB5DHQKOqRwZKYHIkYVIzTjpH2J9EnqflgM9ffoObamv8UTMMdm
	eEOUE6HUIodm/WP2n39TpIPFyRjGaD99PXbL1VlZ6MIG+0GhZyABeSskswBee6p4Tk8U98Gu0YY
	cW1m9YRirRWo76G0fsD59zwuN7AukC7qwsTZGfM9yox1xwvGxFygcE0zbWpktLRb+2+RPWJpWjv
	2QX/YoRUsLRB0cmfNHT/e7Ddnd/ChmD/sjSQQ1xgwGuFI6mrfTRirIg==
X-Google-Smtp-Source: AGHT+IELepidXrimYt+aX1iyNVRfD3WkoM6qJxSS6lwzOVMRvsBDCdDvOitxBrAgoPpT5TSjelS97g==
X-Received: by 2002:a05:600c:540f:b0:453:9bf:6f7c with SMTP id 5b1f17b1804b1-454ec1274demr41997825e9.9.1752254162453;
        Fri, 11 Jul 2025 10:16:02 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e14e82sm5003521f8f.71.2025.07.11.10.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 10:16:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:16:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Matthias Maennich
 <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig
 <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, David
 Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, "Jiri
 Slaby (SUSE)" <jirislaby@kernel.org>, Stephen Rothwell
 <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] Restrict module namespace to in-tree modules and
 rename macro
Message-ID: <20250711181600.36fac178@pumpkin>
In-Reply-To: <20250708-merkmal-erhitzen-23e7e9daa150@brauner>
References: <20250708-export_modules-v1-0-fbf7a282d23f@suse.cz>
	<20250708-merkmal-erhitzen-23e7e9daa150@brauner>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 09:40:37 +0200
Christian Brauner <brauner@kernel.org> wrote:

> On Tue, Jul 08, 2025 at 09:28:56AM +0200, Vlastimil Babka wrote:
> > Christian asked [1] for EXPORT_SYMBOL_FOR_MODULES() without the _GPL_
> > part to avoid controversy converting selected existing EXPORT_SYMBOL().
> > Christoph argued [2] that the _FOR_MODULES() export is intended for
> > in-tree modules and thus GPL is implied anyway and can be simply dropped
> > from the export macro name. Peter agreed [3] about the intention for
> > in-tree modules only, although nothing currently enforces it.
> > 
> > It seems straightforward to add this enforcement, so patch 1 does that.
> > Patch 2 then drops the _GPL_ from the name and so we're left with
> > EXPORT_SYMBOL_FOR_MODULES() restricted to in-tree modules only.

Bikeshedding somewhat, isn't that a silly name.
All EXPORT_SYMBOL are 'for modules'.
Wouldn't something like EXPORT_SYMBOL_IN_TREE be more descriptive.

	David

> > 
> > Current -next has some new instances of EXPORT_SYMBOL_GPL_FOR_MODULES()
> > in drivers/tty/serial/8250/8250_rsa.c by commit b20d6576cdb3 ("serial:
> > 8250: export RSA functions"). Hopefully it's resolvable by a merge
> > commit fixup and we don't need to provide a temporary alias.
> > 
> > [1] https://lore.kernel.org/all/20250623-warmwasser-giftig-ff656fce89ad@brauner/
> > [2] https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/
> > [3] https://lore.kernel.org/all/20250623142836.GT1613200@noisy.programming.kicks-ass.net/
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---  
> 
> Love this. It'd be great to get this in as a bugfix,
> Acked-by: Christian Brauner <brauner@kernel.org>
> 


