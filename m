Return-Path: <linux-fsdevel+bounces-33471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB29A9B929C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 14:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE1D2813DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 13:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D921A0BD8;
	Fri,  1 Nov 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo+gKCAO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9371158DD0;
	Fri,  1 Nov 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730469250; cv=none; b=LMztN6g7z7uck9+SmoNJzz+8ytCz/mDWhbEqZZVQZ5CPe7RhpMnsrelSvlCL+Z+RnTudXfISmIMUO+GA69/KOl57mV82KSi+DkjoaBuhfi6qXpQquPB8biYgedOihbvCJia7OJ/zaNkHfX50vbBD020Ps8XYxzsl9GNBMInm3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730469250; c=relaxed/simple;
	bh=PFEIdZZLo0k4FF6Z9NJj8Z8lgjgbTVyqdSErTcLlc00=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+SOUgAogjx7wgHP8Do+dCsEidfg7e+CXHHxO7V80n6vbE0GEBmJbZWvmnQSVzWQaEzpwZxfcr5LSynj4SeAq5LUUs9Q7aRAZhrOEkSRken6FjvtNtG+/aAPUlwqJIrj1yjgXucAgCbse4hK+4ycD+5b9UYY9MMQp7TYTPTgIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo+gKCAO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f72c913aso3314042e87.1;
        Fri, 01 Nov 2024 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730469246; x=1731074046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4pGgo/9SWmpICBmZTu9VKnqkzR9z4AL22vX7/lGLfvM=;
        b=fo+gKCAOzPiZxuY3neNkiQyxVH80tG3ybK4X4Z2sPzQ1jgwr/1emp/Jg7Bjwqe903I
         60I5J1iZF2qascMk878Dn/J5J3mxDrFA4HHAxdm9frA2PPZDctpbuNg8MFYVZmeGZIRB
         fzGV8k/p2jSm7V0HUZE46hOmPa6hgk0pQU3+WIWTpRgyLHh4uQTtVVX0Ms4bz76aSu9u
         QSWrZJBXO6cPTJbNtoyHHtnpeYpb30jmZ5B+4MDcfZ7r8UZ3O1xWIHoIgl/YR13AIE6D
         NtZJOFM/VBJQOFX2y839orvS1WKS/hvzYpYKQxhjvE1G2svwAD0EKvbaCSOtuVVIJ6NR
         aM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730469246; x=1731074046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pGgo/9SWmpICBmZTu9VKnqkzR9z4AL22vX7/lGLfvM=;
        b=cFYMZX7bnog1qqizTX89Uale8TfR5fLrkJoVOdBwY3hewPJKk4J3NRyxlCl4ewOIaR
         dsl4R+HTj9MivMpIvpn3xnxLHq0TQHhbERjXfrXoP/pEtOrRRrKF3NMVkRs6kJ8K5C9t
         Phx8sJOTMTpUDDG9eKHsKWQ/LT1wtQDTw5uE19u/HkjBVBRPolyr+vj9AoQXvXnLQrfk
         Jv37LDAHwxnev9qqgBjAZZxvOz5+/vRd768EWn1O617hffBFJzOdAg/+tuiXgJfcff1m
         +uKg2Hn+GDA4GjIkVThZpm2MQfcJeTy8UPpI5dxYwDB3ZPrE+tGLBCtgWtP93LqMEfW1
         u5rw==
X-Forwarded-Encrypted: i=1; AJvYcCUJixJY+ibE5+XPb4VZa3gmIT7sakLNZfGb+PdLonV0c1T3Evzm1Q7ufJKs2sps8M86eB7HgUygx0dxmoVp@vger.kernel.org, AJvYcCX7wRUXHSPAYIvkXjfAqNaMQ5CRDf4+TD+m6AgC7jq2/uko7pLX2Py+8nvCEX5i8l/go9EoPyD/@vger.kernel.org
X-Gm-Message-State: AOJu0YwoLBLOQAsAhKNupBmkfPf1rgPs1iNS4j+lYKL/yfj0AL31aPY+
	zooDnZFaswEZA8AfdcTXY0t5eoXO30Kerybitb4Is7uukTMHzqly
X-Google-Smtp-Source: AGHT+IGzjkJaelXORK7vXOahgcQjA06uA3RsLsk5cKEhjwvSmF1MIC806x8nvpjeQ2fhpQ9G8ffYog==
X-Received: by 2002:a05:6512:3d0c:b0:539:f8da:b466 with SMTP id 2adb3069b0e04-53b348c37cemr12134730e87.11.1730469245787;
        Fri, 01 Nov 2024 06:54:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b32sm5318083f8f.18.2024.11.01.06.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:54:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Nov 2024 14:54:03 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org,
	jannh@google.com, linux-fsdevel@vger.kernel.org,
	willy@infradead.org, stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v7 bpf-next 01/10] lib/buildid: harden build ID parsing
 logic
Message-ID: <ZyTde66MF0GUqbvB@krava>
References: <20240829174232.3133883-1-andrii@kernel.org>
 <20240829174232.3133883-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829174232.3133883-2-andrii@kernel.org>

On Thu, Aug 29, 2024 at 10:42:23AM -0700, Andrii Nakryiko wrote:
> Harden build ID parsing logic, adding explicit READ_ONCE() where it's
> important to have a consistent value read and validated just once.
> 
> Also, as pointed out by Andi Kleen, we need to make sure that entire ELF
> note is within a page bounds, so move the overflow check up and add an
> extra note_size boundaries validation.
> 
> Fixes tag below points to the code that moved this code into
> lib/buildid.c, and then subsequently was used in perf subsystem, making
> this code exposed to perf_event_open() users in v5.12+.
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Suggested-by: Andi Kleen <ak@linux.intel.com>
> Fixes: bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  lib/buildid.c | 76 +++++++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/lib/buildid.c b/lib/buildid.c
> index e02b5507418b..26007cc99a38 100644
> --- a/lib/buildid.c
> +++ b/lib/buildid.c
> @@ -18,31 +18,37 @@ static int parse_build_id_buf(unsigned char *build_id,
>  			      const void *note_start,
>  			      Elf32_Word note_size)
>  {
> -	Elf32_Word note_offs = 0, new_offs;
> -
> -	while (note_offs + sizeof(Elf32_Nhdr) < note_size) {
> -		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_offs);
> +	const char note_name[] = "GNU";
> +	const size_t note_name_sz = sizeof(note_name);
> +	u64 note_off = 0, new_off, name_sz, desc_sz;
> +	const char *data;
> +
> +	while (note_off + sizeof(Elf32_Nhdr) < note_size &&
> +	       note_off + sizeof(Elf32_Nhdr) > note_off /* overflow */) {
> +		Elf32_Nhdr *nhdr = (Elf32_Nhdr *)(note_start + note_off);
> +
> +		name_sz = READ_ONCE(nhdr->n_namesz);
> +		desc_sz = READ_ONCE(nhdr->n_descsz);
> +
> +		new_off = note_off + sizeof(Elf32_Nhdr);
> +		if (check_add_overflow(new_off, ALIGN(name_sz, 4), &new_off) ||
> +		    check_add_overflow(new_off, ALIGN(desc_sz, 4), &new_off) ||
> +		    new_off > note_size)
> +			break;
>  
>  		if (nhdr->n_type == BUILD_ID &&
> -		    nhdr->n_namesz == sizeof("GNU") &&
> -		    !strcmp((char *)(nhdr + 1), "GNU") &&
> -		    nhdr->n_descsz > 0 &&
> -		    nhdr->n_descsz <= BUILD_ID_SIZE_MAX) {
> -			memcpy(build_id,
> -			       note_start + note_offs +
> -			       ALIGN(sizeof("GNU"), 4) + sizeof(Elf32_Nhdr),
> -			       nhdr->n_descsz);
> -			memset(build_id + nhdr->n_descsz, 0,
> -			       BUILD_ID_SIZE_MAX - nhdr->n_descsz);
> +		    name_sz == note_name_sz &&
> +		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
> +		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
> +			data = note_start + note_off + ALIGN(note_name_sz, 4);
> +			memcpy(build_id, data, desc_sz);
> +			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
>  			if (size)
> -				*size = nhdr->n_descsz;
> +				*size = desc_sz;
>  			return 0;
>  		}

hi,
this fix is causing stable kernels to return wrong build id,
the change below seems to fix that (based on 6.6 stable)

if we agree on the fix I'll send it to all affected stable trees

jirka


---
The parse_build_id_buf does not account Elf32_Nhdr header size
when getting the build id data pointer and returns wrong build
id data as result.

This is problem only stable trees that merged c83a80d8b84f fix,
the upstream build id code was refactored and returns proper
build id.

Fixes: c83a80d8b84f ("lib/buildid: harden build ID parsing logic")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 lib/buildid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/buildid.c b/lib/buildid.c
index d3bc3d0528d5..9fc46366597e 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -40,7 +40,7 @@ static int parse_build_id_buf(unsigned char *build_id,
 		    name_sz == note_name_sz &&
 		    memcmp(nhdr + 1, note_name, note_name_sz) == 0 &&
 		    desc_sz > 0 && desc_sz <= BUILD_ID_SIZE_MAX) {
-			data = note_start + note_off + ALIGN(note_name_sz, 4);
+			data = note_start + note_off + sizeof(Elf32_Nhdr) + ALIGN(note_name_sz, 4);
 			memcpy(build_id, data, desc_sz);
 			memset(build_id + desc_sz, 0, BUILD_ID_SIZE_MAX - desc_sz);
 			if (size)
-- 
2.47.0


