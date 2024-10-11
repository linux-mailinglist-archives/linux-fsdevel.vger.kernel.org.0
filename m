Return-Path: <linux-fsdevel+bounces-31741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024F99A97E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 19:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F4B2204F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB1C1C174A;
	Fri, 11 Oct 2024 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="cpwoAR9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE521A00D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 17:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666533; cv=none; b=L4DqKiEnKLNKP2E0mq69aoBU6nAxdJCyuM/LgrC1buWv9Y/9etFqursbEnV1lUgRcoSrQiSCFzqKrF7ErWiOkTHtPQn/y7tFDDNaw1r8K/2C69HcEV//Dr4WKnHfq8YIsZz1m1b9KJbA1CY5s15hoesZ36KXiKXtptuijvDOcbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666533; c=relaxed/simple;
	bh=ncF6gYHPE8hGPaZtXbZXNrrpGh+MR6/nIzvYV+HXO9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULXFBJqShXWxoW3Zou08vFkszHZwQUkWh8fgkFhoV9LueQkjDfw10cDyteK0dybxkRuABuNIcWiRDn/y4kUcgkKK1zk+gY8q+gB3t9yc/TeAYMG8gn/aT7oc7ALJhviV5GTCFckD30IjK7TIIWaaQkN7cnx689CyybzEXJmLrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=cpwoAR9Q; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b64584fd4so22412315ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728666531; x=1729271331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncF6gYHPE8hGPaZtXbZXNrrpGh+MR6/nIzvYV+HXO9k=;
        b=cpwoAR9Q+GepwCG3WO9s1TznEjXQ2zG5qjnnsAiaDgeMf6Cb90GP7IPMKSjLA3FCIs
         WKpOmmkCJ6LjSpxVD040xB6Tcj1aYmsFQ5Hon/MoVSB9Ne7+VHsUXxX3PXPv2d2mOCBP
         047jx1Vc+02Hy2h/bD2GrZvouKLnstQabkQVLZ8QUWQPd7eibCzsZHiv5+ASBrX9grqe
         wMyW17Fsvr7LPNVKliHl+LCtUXMl3TJV7RnhMIbBcKkbqFWBL5GOrjdSaeiCkJn0xGaa
         aWSEz0NllfrdAGVeQSwjFrAZWzsjiy5fv+WoeyD63HgktLUIY5ipQwSIx9t6xLmxhZ6t
         jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666531; x=1729271331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncF6gYHPE8hGPaZtXbZXNrrpGh+MR6/nIzvYV+HXO9k=;
        b=RZU6xBA+1GeFu2/uifBRnC9cmcoIxpTua+RRk/I5pXmJIpHW1tgbocweXufIkfskQo
         QHzrEYm8qqb3BUdKrWdUGTcT/fhrRToTIk/g4WT/KN+79tKpmYgdKDclnWDL+S9j4w3P
         1xFXqOTasF/39JeS0DarLwhCMHEFthZsxGbBK5joLedyEHzwQo9ppJyAsEu+XZrhUzYe
         rxoFh+5PNzu6eYiYGT6EX2v1WFbwJJz3w2t/E9W5TWE/IftPwty2utODAloJwIw5rNDR
         dffo8sy9etuHSugTdjCX+YCC2V8QwXDmkmJ3Yeh47Cz28GtDFb106dzukw1klkCupNnz
         Yjlw==
X-Forwarded-Encrypted: i=1; AJvYcCUZY32nq8EU1wIGgwGbUL9VTQq9dAy9PAxsOtLueDNbWwVbcI7lW6dTFOwHmg3MuS44Q3cna9BTb6vmPzKn@vger.kernel.org
X-Gm-Message-State: AOJu0YwETF++yopLmmA15THOBub+s67/FrybHuc5AEmM2Fg78paVstxc
	o90Y8ACZUjRF4JNb128XZMXuyPRlXYSfgfCZyVcgKpTDJom2MEm7iAlZsj1m0cU=
X-Google-Smtp-Source: AGHT+IEtBNrWBuSpgwFuugAc2ZJBDhi6LopCWUrt6Pnl6e2xeIOTuojzMNY64aV7gsKF9NBQ4b+NJQ==
X-Received: by 2002:a17:903:1cf:b0:20b:4f95:932d with SMTP id d9443c01a7336-20ca144753emr36735675ad.3.1728666531268;
        Fri, 11 Oct 2024 10:08:51 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb470sm25410115ad.126.2024.10.11.10.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 10:08:50 -0700 (PDT)
Date: Fri, 11 Oct 2024 10:08:48 -0700
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
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH RFC/RFT 1/3] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Message-ID: <ZwlboA9JCgLJrOG2@debug.ba.rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
 <20241010-shstk_converge-v1-1-631beca676e7@rivosinc.com>
 <Zwj-9Dg3onEHnbDq@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Zwj-9Dg3onEHnbDq@finisterre.sirena.org.uk>

On Fri, Oct 11, 2024 at 11:33:24AM +0100, Mark Brown wrote:
>On Thu, Oct 10, 2024 at 05:32:03PM -0700, Deepak Gupta wrote:
>> From: Mark Brown <broonie@kernel.org>
>>
>> Since multiple architectures have support for shadow stacks and we need to
>> select support for this feature in several places in the generic code
>> provide a generic config option that the architectures can select.
>>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
>> Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
>> ---
>
>You need to add your own signoff when resending things (though I guess
>this is likely to get applied to a tree that already contains this
>patch so it likely doesn't matter in the end).

oops :(


