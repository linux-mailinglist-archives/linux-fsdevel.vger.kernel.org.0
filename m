Return-Path: <linux-fsdevel+bounces-32406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EA9A4AD4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 03:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65169283371
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 01:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0486719A2A2;
	Sat, 19 Oct 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ts/CdBRA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE8199FB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Oct 2024 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729301075; cv=none; b=UdlYTYJgUtzb2N94BdXCEPYGmjGfTmyojL7NOcdltfiay0mAbxAj5vNNd/idUi6v3GP5DCm5NaUkHYp+qQIhe1BfN3AEQ5b/TmRn3wupTCVViWhgy296Y+EfFzFIEMbWquQIHplL+z2O4KPmQp0N7C2HPaFD1JqeNOPwV2LSHjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729301075; c=relaxed/simple;
	bh=coGEllaJzw4cXYWmDPrkgvRbhOBKpa+Twkh3y5h95A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO3GqdktUcJFZO2E+toLfFih3PgdZxIfN535kdB3Ur1iTwpcINBFVfsqmwunTu9G4jJniRzoQNNn8D1cO8erho/0D0MUO+eVgyp+LX4AMBDaukrCugnx5zzSoUg+jMh+IAmNdjnyJ9SLdqrKUkNVvSrFt90mHLe28scveMUEuzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ts/CdBRA; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2091193a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 18:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729301072; x=1729905872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u9kwzs1TdtVADUdfMGhdcgPMuWpR4rjjZoB45wsX/po=;
        b=ts/CdBRAU3IEq3sPwNs73V7yDY/IbUOdLdt1sGlqrJOCasFWL+uz59Co9wAGjShrkA
         GhsUHMGrP8Hz7FbuirIzSJ14nEFZ7RHF2p+R3IWgWoCUy9aQ/JR6KK2MQF/nNngFhb12
         jOmbSJBNM42iHsoIiBm4MpmxC+xN4c4BN1pdMqYmnJ53FyRCXe37/mihlmLlrQ1qLDA3
         ToTAfOGk2qs5fSyrf1FvfdefRVPPViG0Zj/BVuqs0jt0oPsvtuSgGKE+GaOg2gpQXeAl
         AjBazHj9K72/U9Lh3rjr0YDHdGN8J3GrNn5nTlH1d8ZnrgF5Gi4OnJ5QOLP6fuwSMbMj
         g8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729301072; x=1729905872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9kwzs1TdtVADUdfMGhdcgPMuWpR4rjjZoB45wsX/po=;
        b=IKaNQ63THjF2nUJGddPM06OxSAcNorr2/EBqZecjB9tUBVkQA8Z474p3+XdX7sl0qP
         9yo3VKdwuu78E8yYlcJaOklzUnpy5WvZDob5mgmiGNjc+ditXlAKi5vuv+B52ttyadMT
         jKPBf8/BR4OUAuFJYkHxvYV9XeNVH9njJyhIGUN6AmLtZ8Cvyyg1rw5xr73TH4zWd5iN
         ySNM1fE3ya1jZTpuqEZdOdcMdkTuohEYYZdY2bzUdpkjprffpXll+VzIO95uPHFAAIIH
         prR4khgFEaY4qcSzDHA5QRtAkslQFlxpF3+7ZurRoGPIZ7pZf5eBn9fIr3nrjfD5vjc2
         pnHw==
X-Forwarded-Encrypted: i=1; AJvYcCXSm7szl3sqncLrDYdjmOLyT1xwELx70OUJTd3hr0BI63j6wRcQmKnj1XWWItqtlPINm55BgMNb8VDpj/gy@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2vAdi1Ge662QrCSzOaT3yKvPJPSfILqL/IJn4oYxcd1Mfb4w
	O1g7pb6e5ON5hj6yAC39rthb3pcdGuFy1Z16vZtuulDvURdSc5lTihLs+sN7o6k=
X-Google-Smtp-Source: AGHT+IF5gcz420u+38TzPNJB0kfsdtlqejiS2yRDhUESPcDHjj1maJyg98yMDT7zKslsLy/qQogdfQ==
X-Received: by 2002:a17:90a:ab0e:b0:2e0:74c9:ecf1 with SMTP id 98e67ed59e1d1-2e561718d7amr1522614a91.10.1729301071944;
        Fri, 18 Oct 2024 18:24:31 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55da7b34fsm2876468a91.54.2024.10.18.18.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 18:24:31 -0700 (PDT)
Date: Fri, 18 Oct 2024 18:24:29 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH RFC/RFT v2 1/2] mm: helper `is_shadow_stack_vma` to check
 shadow stack vma
Message-ID: <ZxMKTbqbE1coMGev@debug.ba.rivosinc.com>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <20241016-shstk_converge-v2-1-c41536eb5c3b@rivosinc.com>
 <2b24849e-3595-414a-b11e-eb03cd3c3b28@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2b24849e-3595-414a-b11e-eb03cd3c3b28@sirena.org.uk>

On Thu, Oct 17, 2024 at 12:22:02PM +0100, Mark Brown wrote:
>On Wed, Oct 16, 2024 at 02:57:33PM -0700, Deepak Gupta wrote:
>> VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
>> VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
>> stack). In case architecture doesn't implement shadow stack, it's VM_NONE
>> Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
>> or not.
>
>Reviewed-by: Mark Brown <broonie@kernel.org>
>
>though
>
>> @@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
>>  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
>>  }
>>
>> -
>>  static inline void vma_iter_config(struct vma_iterator *vmi,
>>  		unsigned long index, unsigned long last)
>>  {
>>
>
>Unrelated (but reasonable) whitespace change.

Yeah I'll put that in commit message indicating this clean up in next version.



