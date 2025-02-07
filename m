Return-Path: <linux-fsdevel+bounces-41263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC50A2CF02
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5CD3A9B26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3FA1AF0AF;
	Fri,  7 Feb 2025 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2Zi69OuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB17194C6A
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963616; cv=none; b=K/+yEbyzIKGJi7UGSS+pNH1ZpT0VSxazRvNHCvuO0SKmziMGGzzxEyRhP89mYwubSmul2TmYhMVStvtEkxfzTbmZ7ifRx7+GYA5rK/Og4kTs1tKMp5LQC8wgaFp9l1kStEvEcoHJElneBLTQd+s6uch4go2kWXzMXzvKQXsiDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963616; c=relaxed/simple;
	bh=HVmE+Tt35mu4vWqHOKjrmfxx5g5d6DsZZLA0kmOgFzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5rvMYerzYYPl5DB3wV4eFEliZz/IAHVpQx08UYfiHRoJcxcOYMu7+UbF9dT0TCjB5SuYt15lSyW3GYSN/YAq+h9f/J0Ppoc4W7mSyiEY382S4ibWov9RWdlgr2T0ONO9UH9z6fjjHz2TQRBezKW94OS8xsuBUt+pMfLYswQlm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2Zi69OuW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f55fbb72bso19855415ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738963614; x=1739568414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HVmE+Tt35mu4vWqHOKjrmfxx5g5d6DsZZLA0kmOgFzY=;
        b=2Zi69OuWZX0UEjdLx5h7V2aS2lqQrckk3FDmNx05GHs46itAomz4crC74qdpyA1/aO
         EDpv/V+hCufPH6md+AJjX8dBvJpvI2nXq5QRAdC0FEAplwx4oA/mAL53314IdTNMLaiz
         Z3oEJ0QfQfYoKs4jRCcSc5rMyUaI6eIiATejMY+99z83i77qvglKsPeZwRBla726fYop
         PSTgQ5SiRqNy7P0s2LbWOPPnWkA7jU0SOOkIBgWbTQv/vWC8OPJTplulgmJsq2zsIs0u
         AQ+Zavzfd70CDCuvreBZ9eZ/w0CgBpcS/rskGViakv1aBnSUYnfnrZjwsuraqKhv0PFf
         3wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963614; x=1739568414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVmE+Tt35mu4vWqHOKjrmfxx5g5d6DsZZLA0kmOgFzY=;
        b=CY5wz/4NjB2ak+3x1HCCVz08BOM2dS0icK4vSH/uqoTBcxkhlgExw05w6y2q+0CSIn
         Gl+d+IqWcSB5yN83HnfynmllpBZL7QL8efFN6FHH0g+UiNOeP8cTc4vN6ecv8XlRv8d9
         mUJ9ozNi/AjxzXqLYVu4tRSU+PfNDU9ZPpsfgVpWGj3bxNJsMLHVwLPCmPMl7WbOyVL1
         fRljGEl7aWPyeM2RjOXlmrU+SyGslyfTDvZopRRJfjxQ5jAOVBkdZabyL/0he0lKtM2R
         bNlz6VTAuLjMiz1Nc84NcW8LWdn4x4/qxZUiTcWdpucJCNHH5ZQ3h7Zsw8xAJNFNBMI/
         xrBA==
X-Forwarded-Encrypted: i=1; AJvYcCXY+nbRhH4bna6sB/q6xP/sH2GAnwwLtEqTEX7I03YJiUYJqBtvy2LWg2kTn4uC5gb7uVSA5sLZcIPshD85@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKNaUxBzaRGJl8OZT139eJoaHg9khWSzrP6mEsYyzPZ7yNlw7
	31GaidM/z8lzphgGUimau6tMvrH5766HrSdq1QCSU2Bmn1N6+G2+XrFA4fnU4j0=
X-Gm-Gg: ASbGncuWOcos8nwY4+a7Ow0BBP6rZjcwCJ42wm8esEMX8z3tJjANWpEpxrU0lp8rgpb
	1wdiMuqcgu2w9Fjv6r1XXICA1L6C2PRfb8S2zgnuNPxHkpVShhyCSU6girU2UA2D8aLcleGPDz2
	ETDn4c1ucU9vr0pMW/jXzEzN/T3CyHTrV/jClcLbvQt+0Mj0Rux+pgY0p479EP1c4QmmYl2GTFB
	g5UKW9r+5AzMOQKNeVdfIGsF8+wDkcdWIThHHc4WRWgcmr1z8Tg6PBNXW6FR9x5J1qFJ4MRpW0p
	EyCQsUhr3nQQ9I7WKxy7ZlYbGw==
X-Google-Smtp-Source: AGHT+IE9Oev0Y7C5Xmqtwl/B+JiwmKuI48iGekPbKSdtVdA99oMBiZeUkT8jvrSGxyy3gXBYBBsXzA==
X-Received: by 2002:a17:902:d4cc:b0:21f:6a36:7bf3 with SMTP id d9443c01a7336-21f6a369009mr6855425ad.12.1738963614537;
        Fri, 07 Feb 2025 13:26:54 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683d551sm35131205ad.110.2025.02.07.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:26:54 -0800 (PST)
Date: Fri, 7 Feb 2025 13:26:50 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v9 14/26] riscv/traps: Introduce software check exception
Message-ID: <Z6Z6mhiQ3DmsNZe9@debug.ba.rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
 <20250204-v5_user_cfi_series-v9-14-b37a49c5205c@rivosinc.com>
 <fec3b7be-4259-4eef-87f9-b2cee5718cae@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fec3b7be-4259-4eef-87f9-b2cee5718cae@rivosinc.com>

Hi Clement,

Thanks for looking at it. Inline
On Thu, Feb 06, 2025 at 02:49:09PM +0100, Clément Léger wrote:
>
>
>On 05/02/2025 02:22, Deepak Gupta wrote:
>> zicfiss / zicfilp introduces a new exception to priv isa `software check
>> exception` with cause code = 18. This patch implements software check
>> exception.
>
>Hey Deepak,
>
>While not directly related to this patch, is the exception 18 delegation
>documented in the SBI doc ? I mean, should we specify that it is always
>delegated when implementing FWFT LANDING_PAD/SHADOW_STACK ?

I don't think it's document in SBI spec anywhere. Should it be ?


In code, opensbi delegates the exception (SW_CHECK)
https://github.com/riscv-software-src/opensbi/commit/110524441a827e026db3547ed03c5723b9c9e211

>
>Thanks,
>
>Clément
>
>>

