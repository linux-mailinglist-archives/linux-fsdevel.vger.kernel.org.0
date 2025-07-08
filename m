Return-Path: <linux-fsdevel+bounces-54208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA0AFC0F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 04:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD8D1BC067D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 02:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8F3226520;
	Tue,  8 Jul 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RoJkTC6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2B625;
	Tue,  8 Jul 2025 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751942474; cv=none; b=GzF3YknlGy+eNrKsTVPAClBZhU1NqsJj+5pT4BRmM0dROYVoppnhBaOGxPuMc0eIHs6b7EPjwILVnjUTT89Kx0SujTfRf6xULXW/y3gsI7x0idS1dY+FfpqvL08hyTpmb2oHC6qnLNKVilzaCYyT7z6bn3fOaUy0/ajo+a8mePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751942474; c=relaxed/simple;
	bh=g/EPdX5krHKVrrNbX5NhYWOelptRAZuijXhxQDRNGho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=du15M+mJudi+zMt8Cax3nBZr5Ox02c/J2+SyDo1b1U7xwSX7m9rwu5g/CZt/N0WJF0UgsfqFIPkSUnKLutgsWVm3IJVAVumjacf2pYcJKHn2wSqbfd5M7tX4kPw/Mj7BRRbJOCE1C2Hp3YEKU6Zg6pyJ2CC4eQQVI2fuoJP0/Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RoJkTC6Z; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1751942456; bh=kvzF1+p5zL61FS2tiZH6CM11U4IQ8gp2XDypmzE3OA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RoJkTC6Zt/jiPjT7kGDo1mdPrG0IiVqc+b/ptrrbvnPUJ/WqoXBMKVjl728GvVsUg
	 qh9M2PqwAWiVB8VTLiWnFash9zw9SAInfjytQlETwrOu8VFPLDDyqDRdHPiIZylX3j
	 WITJHeV9SAzlHumuy2CIG3RL4QBaJ1D79YruDeUM=
Received: from [172.25.28.139] ([210.12.148.147])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id A34B4E63; Tue, 08 Jul 2025 10:40:52 +0800
X-QQ-mid: xmsmtpt1751942452tqb7p6kqb
Message-ID: <tencent_28C38B580EFE8219F5D7E850944CC55A2106@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrB8J1/3pY4XbUjodfVtvPJYY8MEIntC/Qk0T7VCsqouThYi3dUz
	 nBB+HWRWUrC/DjWaMIe3fDKXL+/1yL0ONPwSf6VzAi9s+e53grwuKj0NrQxQfDB/tvErjLQT6kN+
	 ku8eDgRQ2ZJks+cyE6nUh2pt+o3LhMMpdTbK4oHplFtkSFGZrcvGgOsZ8iRSuF3JWM+VTBJ6/zs8
	 ELuPCcaem7SCKvoIQ+LGmhscZdTrg+SX+8O+82yQWsfR3GzYefu6z/uqvB+9+MfattdYmOk319DS
	 i3L+xjwYpRyws77ucRGqvnAiZTclJvNdvW5Do35M3N/EIDqb55mbXU/mZyehhaKEjZOJ/CJCXtBV
	 I1yVo9hxMcnZji1oHD2QmHiurcR21qkFJ48nUrE5bgKQHEs0NtHEUk2OgOI8e3UHB98GapKPZEvq
	 J2H/qWdMeLiDnQOOikfFUpYXv0d5J5xBMhOh2S06+Wy1vvATxmpH7knEDr9Pk1rIhFOclUXQ4z2S
	 6Tm0+J3brxOwAa6HklGaUpXatvdWB77/jDpyae1VhaJFS144yMZXQi4xwZvd5MmOTSqDkf+Z6Byf
	 U67miPCw/wdH+aeKBdmaFlAFZ8TvAKPgrP9yB0GOMn+Sbq+fYXl5kyBMA/tuI0jGAYtqf9B7EUbl
	 5noJVRcbZQtSROy6bdSLFIW4bKRDmmpIcC1Ako6Wei97QHe5E16b5+Z16k3QUZ4FLEC45fwNHB8o
	 ACB8jBz9fsfYwsIHRrBtBPctVuDEoXwr8hkqUUd+9Pe+h6S0P8WDHc2zKDUEj1hrzy7yhqT2WOBM
	 0Gbj+Ajmjfj+YVEpDCWs5akjrfVRsOiXTi6mr9zJ2szYtAyWOjshuTybaVqNyzlqOoW+I8UVBng3
	 mQJyqxNfJsPJ0PQXKAgN09aGyzNEOOmpvp0Q5ZrgBz/bbuBIvnOpYZa15Fe0HNTZbF36qh61wzN2
	 JrQJ6uYekSONwhYqbUGREsMuMnQ6/KpP+y7u/MmU0FGWNV07kXgKgmjJ9G9dO3VXhNeqZGyag=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <321af03f-1f7d-4ea5-81f4-28938410a7fe@qq.com>
Date: Tue, 8 Jul 2025 10:40:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mm/filemap: add write_begin_get_folio() helper
 function
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?B?6ZmI5rab5rabIFRhb3RhbyBDaGVu?= <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>, "hch@infradead.org" <hch@infradead.org>,
 "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
 "brauner@kernel.org" <brauner@kernel.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "frank.li@vivo.com" <frank.li@vivo.com>
References: <20250707070023.206725-1-chentaotao@didiglobal.com>
 <20250707070023.206725-5-chentaotao@didiglobal.com>
 <aGvfr_rLUAHaUQkY@casper.infradead.org>
From: Taotao Chen <chentao325@qq.com>
In-Reply-To: <aGvfr_rLUAHaUQkY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/7/7 22:54, Matthew Wilcox 写道:
> On Mon, Jul 07, 2025 at 07:00:33AM +0000, 陈涛涛 Taotao Chen wrote:
>> +++ b/mm/filemap.c
> I think this should be a static inline function.  I don't think it's
> worth moving out of line.  Of course if you have measurements that show
> differently, you can change my mind.
>
>> +/**
>> + * write_begin_get_folio - Get folio for write_begin with flags
>> + * @iocb: kiocb passed from write_begin (may be NULL)
>> + * @mapping: the address space to search in
>> + * @index: page cache index
>> + * @len: length of data being written
>> + *
>> + * This is a helper for filesystem write_begin() implementations.
>> + * It wraps __filemap_get_folio(), setting appropriate flags in
>> + * the write begin context.
>> + *
>> + * Returns a folio or an ERR_PTR.
> We prefer:
>
>   * Return: A folio or an ERR_PTR
>
> as this gets its own section in the kernel-doc output.

Hi,

I’ll update both in the next version. Thanks for your review!

--Taotao




