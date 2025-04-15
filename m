Return-Path: <linux-fsdevel+bounces-46515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0A5A8A789
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 21:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9AC189EA7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 19:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363CF23F418;
	Tue, 15 Apr 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWttMT4T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104FB192D6B;
	Tue, 15 Apr 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744744295; cv=none; b=SltSX/DUT41Cgex+mrOR979XDFwUWMY5JsYBDOmrNDf8vWYL7jFIOcqYgrRanIUI1tb5AFTKgepcZ2RyEq7cJuOWvJUqooRbT9GhqOVAqs2MyCRmjQU2VTRk9QTu9ZLYID9E5Pd8i2sRQtAthNluX9WnkN+a/ZB7H78/4mfNung=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744744295; c=relaxed/simple;
	bh=n0o8aS3XH/mRkJO3jAxK7O0yOFg1iwJA/hvjR6P6bw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4VhVIuUrtL/fwjjRqWHH6wUo+mY1tpKej74if9ATuNv8OyDYTVaoSJ9bnNWRP82y/Jp4WUh2Jc4b0/ierjkx6k/GVQdsXSpp1Y3R2Sj1/Uqi8UeVLUPObVNDmRmsNXkMR2lsZUDZPXPKsWVa3a4X/k/mE6lvu2QMFO2uqW4yTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWttMT4T; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2aeada833so1154895766b.0;
        Tue, 15 Apr 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744744292; x=1745349092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zhFlUMtNiRCAq5DV9vIrNO9nfbesFvx4yBgb3QsDraI=;
        b=GWttMT4TISeQKrFYF6NaWf7sKKpnDhCAsepUGVNZ+Ccu/CxfCtiABIB/ZjwUbCRooJ
         JYuGzYZ2yepMM66DftyUnnxKP9x57guuStjCq/snkc7KHeci+ZU0d0WZVaHjrYTULmVI
         h4n0dsn+RHSSOCklOm9ClhyqUGrsU2Jq1U39AxxgguqDWix3DY7/DaBZCD5v6r/18pAM
         MSw2o8JLSK1VQbbfaGVcumNy3NZzCYpjyu8xTo+N+oyxzp5Zxde/AY7fkm+oRx+QTQLd
         htl9ORD6g5Zfg2GxAp6HKZ0qkrEqEo0E46DddnqZCCR8VzyggWsQ+zHV5AajmF3/URwP
         W6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744744292; x=1745349092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhFlUMtNiRCAq5DV9vIrNO9nfbesFvx4yBgb3QsDraI=;
        b=QWlDvTHCHBPhe9/Jl+Nudsgp0Y8LbiKOK3Rze3ellbkDEkTPYvQ2JbgshxeyZjnmq6
         g2CWx4V7eTq/Y6OhGwySWTRE3O1Uirne+ODiASoUBiiamMhTyeAZ+vbsVQlQkBRIktWK
         GTF2/zw2Ikhl4pKH8GC4XQhWHTqxKgTwl6JGOV0Pel5w3PTEm+GWUz3ouJuOzA7cjeqN
         IdYrdCuYdeFyDVsb641OzkbTl/YBff06rB39x3RxPm8JwdBTsBbamF8P0DjuQxvuPOpg
         TpImY6byHKMbJ5/fbITZL1GbvFwfMwtfFtbotRc4qPbI6/gcbU/FIiBEdLUN4D9YQHY1
         QSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUi61XqfKIp1/XD6Ra9Er7LaoBjtl/9LEPwCD02/VoHNgqpbxjw18nPU7BbZIVHtLggZWLThry6MBJAFQ==@vger.kernel.org, AJvYcCV2kLYzvFzJv15z0+OzJRc7ks4XZ01SxtvBN1L/dNGD9BWdlBRdrF6KHJ7qo/krjsoBc0DOLaI=@vger.kernel.org, AJvYcCW1peTYjTHhxueU537Df4DGQwWVPaD0N+2yaytzYmUaN67jAWR9gdqpiR/fmUN9o0rWbchTpoT+BoQCX/xT@vger.kernel.org
X-Gm-Message-State: AOJu0YzXDLT5mSj2uBXuJP7PdMZRm4k/YTyio0TN0iPD7qJr5j4Ch7+7
	1BijgaOPY/s2/h1wJgQP7hBRL0IUgjFDdGoEXJhQFbshyl4MrXqC
X-Gm-Gg: ASbGnctc3jJb70SdIIa3ZflvUYq2hum1oDgmG3SzfYe55gTMp9NapK3MB/SiSOQ6Bkj
	baUYOUUiCF884fEABKZhY8kHNQY3iGVuPouUv7KmSRYJzSOGIQkUX6Rguk2m+m5zCM/LFZtcyiP
	+AQ7AbOlPtPehaZ7S3riBfI2Iez/Vl+ng3Lr8D9pSt8DkiI1TEg1u4Dp53LY3R0OdnX01yHL3kc
	+QVFKHn59sbiXW/u+GvhX6HP779SFf4UFmK0IFmN+83KTQYMvwXy5X2N+kbvUZzEd81GSR9lFfV
	IlePET488DE9kiLXXkCRRBE/gOpYPTzS7bQEmrhx6wsG5GXitnj2FG2GyIaAaUd2hA==
X-Google-Smtp-Source: AGHT+IGEFSrt2ZpOon+C2jav9XU7evOc0hH3tvZ42nnDp049L00AJY/eMoY7ecXbtHbFbFdCi8bRGg==
X-Received: by 2002:a17:907:7211:b0:aca:d276:fa5 with SMTP id a640c23a62f3a-acb3558fc6bmr63346966b.0.1744744292063;
        Tue, 15 Apr 2025 12:11:32 -0700 (PDT)
Received: from [192.168.2.22] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccc2b7sm1132351666b.155.2025.04.15.12.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:11:31 -0700 (PDT)
Message-ID: <b872cb3a-f91d-4169-a244-fbefbca5680a@gmail.com>
Date: Tue, 15 Apr 2025 21:11:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression 6.1.y] Regression from 476c1dfefab8 ("mm: Don't pin
 ZERO_PAGE in pin_user_pages()") with pci-passthrough for both KVM VMs and
 booting in xen DomU
To: Salvatore Bonaccorso <carnil@debian.org>,
 David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lstoakes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Al Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Logan Gunthorpe <logang@deltatee.com>,
 Hillf Danton <hdanton@sina.com>, Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 regressions@lists.linux.dev, table@vger.kernel.org, Bernd Rinn <bb@rinn.ch>,
 =?UTF-8?B?S2FycmkgSMOkbcOkbMOkaW5lbg==?= <kh.bugreport@outlook.com>,
 Cameron Davidson <bugs@davidsoncj.id.au>, Markus <markus@fritz.box>
References: <Z_6sh7Byddqdk1Z-@eldamar.lan>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <Z_6sh7Byddqdk1Z-@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/25 8:59 PM, Salvatore Bonaccorso wrote:
> Milan verified that the issue persists in 6.1.134 so far and the patch
> itself cannot be just reverted.

Just an update:

With 6.1.134 stable as a base, I reverted that commit (upstream c8070b78751955e59b42457b974bea4a4fe00187)
+ applied upstream commit 873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4 (vfio/type1: Unpin zero pages)
+ reverted upstream bddf10d26e6e5114e7415a0e442ec6f51a559468 (uprobes: Reject the shared zeropage in uprobe_write_opcode())
to be able compile code without errors.

With these changes, kernel works with my NVMe passthrough test again. This confirms the issue.

Milan

> 
> The failures all have a similar pattern, when pci-passthrough is used
> for a pci devide, for instance under qemu the bootup will fail with:
> 
> qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: VFIO_MAP_DMA failed: Cannot allocate memory
> qemu-system-x86_64: -device {"driver":"vfio-pci","host":"0000:03:00.0","id":"hostdev0","bus":"pci.3","addr":"0x0"}: vfio 0000:03:00.0: failed to setup container
> 
> (in the case as reported by Milan).
> 
> Any ideas here?
> 
> Regards,
> Salvatore


