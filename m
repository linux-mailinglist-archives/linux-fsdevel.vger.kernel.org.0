Return-Path: <linux-fsdevel+bounces-18977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 615CE8BF3C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 02:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 000DEB23512
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 00:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F781C27;
	Wed,  8 May 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ+H01xI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3375B387;
	Wed,  8 May 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715128578; cv=none; b=VWMe/2qy0XfljBL9d2n5YufX495cbhorKFGab3WxSSpymboUuk570BVtZ4FZJYrT/rWubUUKq4nDI6LUXqwVXa6hzWaXVlHXv2z3cCltrsyKabvilBIdgEWs4F3xGn0CL1rRJmvKSpMiCwtD8n2XVqK2MSsH5ynNLXehSV6FOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715128578; c=relaxed/simple;
	bh=yJK99pCXyuoTwOmUw90tjzeWFArr9+bCKIgZP+l1zPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJI6F6ffXlXzlSBgeWP5K6tY8OXmlgh0DkPRVWylYQumoI+zjOp2PJoPULSY3UFJ4fxyeUcqEhcf+HZHdjhHihqOm31JtR5xZkoeHDw7mhOAsMjCMmh0y9u8UD/cyQ/Vsb0EiSSbkdbceVcDQiKzgitzKise6cnRBxFUEKQ/4oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ+H01xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F708C2BBFC;
	Wed,  8 May 2024 00:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715128577;
	bh=yJK99pCXyuoTwOmUw90tjzeWFArr9+bCKIgZP+l1zPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OQ+H01xIYPmmknJAvbU3bmScXIpz3vpyzx6ir2u7dmO/Xgg7CKerL+vni4NEyPiTa
	 a8wiKTeyvMov2m0/C7+OGHAQaYNVL94XFGbCV3qMO/2+OypsUaEKmWahfa6OoMriHO
	 JOTZzdn6I0qktdd5tcgoxdInIANGoqnVRC4z0sYX3nzUtnjbUu0Tbc5hQWGZCZfQvs
	 wdi3Gt775bGtTmHcmn/2O3Jm8XyA3P3xzYbbkI0N0cEpl5vBNCEczBFRgUz1M+WrXE
	 J3ISBLiQ9ZAWlzE0ACJvCZfU5xMQhMYF1U03doKVRPCFuIiN/n15sIq1WRbLmmd7Bm
	 xWQOzJ05IHqSw==
Date: Tue, 7 May 2024 21:36:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org,
	"linux-perf-use." <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH 5/5] selftests/bpf: a simple benchmark tool for
 /proc/<pid>/maps APIs
Message-ID: <ZjrI_h7InWYdOBtD@x1>
References: <20240504003006.3303334-6-andrii@kernel.org>
 <2024050404-rectify-romp-4fdb@gregkh>
 <CAEf4BzaUgGJVqw_yWOXASHManHQWGQV905Bd-wiaHj-mRob9gw@mail.gmail.com>
 <CAP-5=fWPig8-CLLBJ_rb3D6eNAKVY7KX_n_HcpGqL7gfe-=XXg@mail.gmail.com>
 <CAEf4Bzab+sRQ8pzNYxh1BOgjhDF4yCkqcHxy5YZAyT-jef7Acw@mail.gmail.com>
 <CAP-5=fXv59EmyM7FNnwAp0JjAZjtYhCj3b3FTH7KsHL=k8C6oQ@mail.gmail.com>
 <CAEf4BzbdGJzMuRgGJE72VFquXL37rS9Ti__wx4f_+kt3yetkEg@mail.gmail.com>
 <CAEf4BzYykUsN_Z92cXAh_9+fmN-bzr7xOEBe2v_5xDoXRhijmg@mail.gmail.com>
 <CAM9d7cg4ErddXRXJWg7sAgSY=wzej8e4SO6NhsXJNDj69DyqCw@mail.gmail.com>
 <CAEf4BzZTRU9CGrcAysLKCCbjUvJZPFaLA122MVo_zKgk8pAUSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZTRU9CGrcAysLKCCbjUvJZPFaLA122MVo_zKgk8pAUSA@mail.gmail.com>

On Tue, May 07, 2024 at 03:56:40PM -0700, Andrii Nakryiko wrote:
> On Tue, May 7, 2024 at 3:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Tue, May 7, 2024 at 10:29 AM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> > > In another reply to Arnaldo on patch #2 I mentioned the idea of
> > > allowing to iterate only file-backed VMAs (as it seems like what
> > > symbolizers would only care about, but I might be wrong here). So I

> > Yep, I think it's enough to get file-backed VMAs only.
 
> Ok, I guess I'll keep this functionality for v2 then, it's a pretty
> trivial extension to existing logic.

Maps for JITed code, for isntance, aren't backed by files:

commit 578c03c86fadcc6fd7319ddf41dd4d1d88aab77a
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Thu Jan 16 10:49:31 2014 +0900

    perf symbols: Fix JIT symbol resolution on heap
    
    Gaurav reported that perf cannot profile JIT program if it executes the
    code on heap.  This was because current map__new() only handle JIT on
    anon mappings - extends it to handle no_dso (heap, stack) case too.
    
    This patch assumes JIT profiling only provides dynamic function symbols
    so check the mapping type to distinguish the case.  It'd provide no
    symbols for data mapping - if we need to support symbols on data
    mappings later it should be changed.
    
    Reported-by: Gaurav Jain <gjain@fb.com>
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>
    Tested-by: Gaurav Jain <gjain@fb.com>

⬢[acme@toolbox perf-tools-next]$ git show 89365e6c9ad4c0e090e4c6a4b67a3ce319381d89
commit 89365e6c9ad4c0e090e4c6a4b67a3ce319381d89
Author: Andi Kleen <ak@linux.intel.com>
Date:   Wed Apr 24 17:03:02 2013 -0700

    perf tools: Handle JITed code in shared memory
    
    Need to check for /dev/zero.
    
    Most likely more strings are missing too.
    
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Link: http://lkml.kernel.org/r/1366848182-30449-1-git-send-email-andi@firstfloor.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 6fcb9de623401b8a..8bcdf9e54089acaf 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -21,6 +21,7 @@ const char *map_type__name[MAP__NR_TYPES] = {
 static inline int is_anon_memory(const char *filename)
 {
        return !strcmp(filename, "//anon") ||
+              !strcmp(filename, "/dev/zero (deleted)") ||
               !strcmp(filename, "/anon_hugepage (deleted)");
 }

etc.

- Arnaldo

