Return-Path: <linux-fsdevel+bounces-12348-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B6485E868
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 20:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C737A1C24D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885115AAAA;
	Wed, 21 Feb 2024 19:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DGuPJj79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943115A48E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708544537; cv=none; b=A5i3qTpSqd1uCi6uNZzt40/uxAdvbohZW3xBfbXwSFRJBYkRAioFbNAvK2qHyN8KOtlMGYtIDHBs90BVcm3uJa+h93lUHZHq4iOkOgMPZVfaax+Du2Owy5ewPfVMNLTYVMb7+VQLBo89i6k5FXRrTyuvgKzNAKHIlWtbXv7EG/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708544537; c=relaxed/simple;
	bh=YUaiBKk0yJaoPiPhkAmL3LiC+pv84RILoX6k94HC1UM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ibKAHH+GF6ylW75UepY7LW/S0LAS/8yB2MFJTwvbIITiXc5nuw2u2MbDd/VamcoCf0Ba1ZLfwpPTP06EeVhTqG7cZlPEduSl1+a4Qlg6mjtBeTu5BZuL6GF+kAV1djw/RIHECm+vZuoBYrqJrCwD506grWO4KUNItRgv2Nga9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DGuPJj79; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6088fa18619so9952917b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708544534; x=1709149334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ETkntKf5Z8TKkoIJeAz1krTkKQJvX5Zd0TKA8iBrrk=;
        b=DGuPJj79nDhG7o85WnbZuvhGUuXvpDC+MYPfNgnwKAgKJQtxCkTne3i4Q+/swHEavJ
         pT/79j47BaNqE12OWVzpMFidKDZBZjLtDE44Vugj9tp/ax0Zoz9fBNwDTQjV0eB3qFVu
         jUWsxlu4YFU4vwSoEAbKgO3OXy/UOijLrR9RJUmXhApMIFNo1vjpjIjDQGwhDJNDbV1A
         tMYltzFyk1F9S1SeAKjKLswG2SgXRj95QfLDmC5NRFVBqV2dj0C+VFecW8gPVRhRxfvT
         J1ccz7oYMx3KoI1oJ6DjBlxFknLGRAijMCwnQDDZMMV/bly32e0RPtW/CqLdu65GjuY/
         Z/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708544534; x=1709149334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ETkntKf5Z8TKkoIJeAz1krTkKQJvX5Zd0TKA8iBrrk=;
        b=KL0Vq6inF0tQhj8ThATG1ZLij/DfwKuzKfgY6tLJzLMKOEm+dtQMGOuS+ZvKR5MQdk
         6MwZ1W0nH4AIzvELTNPo2Zrcb509IZtzmebU8TXJuIYCqcBR8+HKSC8w+gyOSBxN7nDO
         VtNldqWlI0uPNBXoXTc6bYW2ssD2m0cxoyxBAcBT9dKlWKhNlBUsI+e9eZXB4aztFdKU
         X9lzKtzkW8qGIyq/+1GwxWPGI6EhiJQLvrZAbJ9pmacCmOP1XtF+9UdUUIrmI5E+87UV
         jFdqCOpDUtuxi56pNXwddoPIUkVoX4ZomlfUQKaWRYpjoS2GlhRiqDaa1WuftL7/wkfP
         8cmw==
X-Forwarded-Encrypted: i=1; AJvYcCUD3ESacs+1NGHxCKr9zqxo+85tKl4z2LpK9BW7HAM4FOo++CMYS8+fIUR0YA5fDQrhcoQBbGJHVtPAL3NBjDmf4pjwiHFvyXHu25PryQ==
X-Gm-Message-State: AOJu0YxuYeN/vmmgSAA6D7MAKBoet7isrne8MWWTf6zRlW6S5LPYbwJX
	zaEjBu/q0kvXLlMtRB6k65yD/1H66IuhCftj1Uwlm1UsqLvOhHwJ/hIyI+1PnBXuAhjzqr70l4s
	tMQ==
X-Google-Smtp-Source: AGHT+IGcBk16mzh5/xxbKr6yggh2Yyj7g5lycw9QHRAaELldFsCkqrypZfX0yKxpepdpGv4MQmcqVIlNfo0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:953b:9a4e:1e10:3f07])
 (user=surenb job=sendgmr) by 2002:a25:844b:0:b0:dc6:ebd4:cca2 with SMTP id
 r11-20020a25844b000000b00dc6ebd4cca2mr14813ybm.11.1708544533985; Wed, 21 Feb
 2024 11:42:13 -0800 (PST)
Date: Wed, 21 Feb 2024 11:40:48 -0800
In-Reply-To: <20240221194052.927623-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221194052.927623-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221194052.927623-36-surenb@google.com>
Subject: [PATCH v4 35/36] MAINTAINERS: Add entries for code tagging and memory
 allocation profiling
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org, muchun.song@linux.dev, 
	rppt@kernel.org, paulmck@kernel.org, pasha.tatashin@soleen.com, 
	yosryahmed@google.com, yuzhao@google.com, dhowells@redhat.com, 
	hughd@google.com, andreyknvl@gmail.com, keescook@chromium.org, 
	ndesaulniers@google.com, vvvvvv@google.com, gregkh@linuxfoundation.org, 
	ebiggers@google.com, ytcoode@gmail.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	bristot@redhat.com, vschneid@redhat.com, cl@linux.com, penberg@kernel.org, 
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com, 
	elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, surenb@google.com, 
	kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Kent Overstreet <kent.overstreet@linux.dev>

The new code & libraries added are being maintained - mark them as such.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ed4d3868539..4f131872da27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5210,6 +5210,13 @@ S:	Supported
 F:	Documentation/process/code-of-conduct-interpretation.rst
 F:	Documentation/process/code-of-conduct.rst
 
+CODE TAGGING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/codetag.h
+F:	lib/codetag.c
+
 COMEDI DRIVERS
 M:	Ian Abbott <abbotti@mev.co.uk>
 M:	H Hartley Sweeten <hsweeten@visionengravers.com>
@@ -14061,6 +14068,16 @@ F:	mm/memblock.c
 F:	mm/mm_init.c
 F:	tools/testing/memblock/
 
+MEMORY ALLOCATION PROFILING
+M:	Suren Baghdasaryan <surenb@google.com>
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	include/linux/alloc_tag.h
+F:	include/linux/codetag_ctx.h
+F:	lib/alloc_tag.c
+F:	lib/pgalloc_tag.c
+
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.44.0.rc0.258.g7320e95886-goog


