Return-Path: <linux-fsdevel+bounces-52893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D727AE806C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D147B0E57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A0D2D5C81;
	Wed, 25 Jun 2025 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qhnEOBWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12529E103;
	Wed, 25 Jun 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848801; cv=none; b=YX4Revj3gxpa3VcDwRGtxsNWwoZKE71sEsV5DldOb0COQ/z3Txp5E3zc4TS6GxXrtK01LV9Pz1X144yvP+uF8WA4uAjVxfcQldEuNQHpL7CRaCEaFPx1+wX2O3F2gMnb0N1LWPqyjzIM9Qm9an1bDhLJqQ0G4e8nwRp92vh4qK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848801; c=relaxed/simple;
	bh=bVTQKiW4WJsF7lVIrAjNgK8DHJH4bRFEnocFDPoC7lw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W8c51B4lEmXjwUvgGp5S5YKZFG/8mtaOQ2pZo+1YrTshL8SXipGX9memul0hfl96XBf2D4GU5y+DMsM6+Zh42ThMWkUdQflC2Z7B9cPloJ+DMIE4Hh8QahqDV8QdVOoxsklMw5zXBd45t/eTxEOR2ptpHQQCt1N250rsL4/rDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qhnEOBWS; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750848487; bh=tgd2pHPm2RnMeqq7Vwih1WR3E04pB2uiTC5jxE+M+kQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=qhnEOBWSxtRyXSoZkn6l7HUS44VXx4qEHQPF8kInnWqiU7crYtLTU7BtTVBVBie+z
	 7H8ybhSTw7teK539iWcDYcaGtb3XIIAU6vvvR4KlnGdgKuzPh5R/U5gul6aSaJX9fe
	 dRGzvkqYIS1+ZB+YR5wvknIdp7LiSxcPxJ5SH5rU=
Received: from [172.25.20.158] ([111.202.154.66])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id A7A2CCF1; Wed, 25 Jun 2025 18:41:58 +0800
X-QQ-mid: xmsmtpt1750848118tykbxfohr
Message-ID: <tencent_E8315EB273FA16ECA8DD46FDA3FC2A320A09@qq.com>
X-QQ-XMAILINFO: N2/jAoEINgTTVmeFMsiQejiordXzU686AwuiVeg+WQ4hfHy1G68V9KJ6U8soDk
	 FjqFfgCWPLze8PgyLk7XU3TyBnoQfb/6XHBeUMmHQrBEmBgnDoi3RLdIL7DFy1Tbc73yQn54bT9d
	 e8FPcpQMT9NBuMMSNx8DJ/c2ds9Ja9LgEiomZK+KbGDaSgYXcZwkCDF6fI3zu0XkWRiU7oyPz1b4
	 s1+99sUHA4eDOQpG0p32kSjphMvpHz6fsEm17ecmsTkj5r2l5sIYZ5/GrJYVK6nlRRfGw1V4palu
	 BKxljpr2g3ZkATbXVN6Lsq92oxwdWEyRNI043fQtWEk0N9eXhdsRX1xz8T7c6IoWd1m06XwwIz3B
	 hzNhUAy/jwdqsIdYaVvkekGTlZRK/EEUWBL1Chvck7J8MPv2iQ92tNfRoC72L+0kkkbdo6Cn4NyO
	 jsA6SdPiD4STfr+cAUcUD6hDZSMkasYyQpGswLVN0Cpy3f3AlFWhlj+FEWWjmXAeULfxW3J+lpCQ
	 v9ssZMsa8xz+JaI46jlkFCYR/vwCC9b/fx/FcX3bSHOEdKqzxCSe8oZQ0hvXrPsa/bxxLsb9h/E5
	 ap+HjwZX3us+AfQIDtSNaps7EJLOXF/eOBJFsoVV58OX7Ay4Pj1UAtNaWefhruNwV8MJgqjKyQLv
	 fv0rst6CtxHchFxqL5yfSwW7bHY1W/B3jixOXQx0JTRjZHQjRIEXus7+pS5a1TB4qZOrDJe3Atzp
	 lK2qjRb0O27krp6uyzhBMCt71AHe0Y99+fT8jxrKe6aMgYUpSWgX4bCMJFbUZFqoUMA9NOPuDYgV
	 JNYVsqTtnrhHE5C7zy92bEFT9guuboAFnk2cldlPo2tVG/diO3McJd8V0dboAwpu+NpMbb0wiR/v
	 4lPYdscRlzPfyanf4I7w0nZ+gGbB0mxnWt0yOuTAr9auSf4qV1jB4EEsvxO/ym9FjO32VllWG2+t
	 KnTXNqOhT0D1Oj+2/IPYgB3xm/FKr2JjU/7Vyy3X+Lwlmvd0XTWw==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-OQ-MSGID: <dedbc70d-36f6-43bb-b6bf-a87103b6bb24@qq.com>
Date: Wed, 25 Jun 2025 18:41:58 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Chentaotao <chentao325@qq.com>
Subject: Re: [PATCH v2 1/5] drm/i915: Use kernel_write() in shmem object
 create
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-2-chentaotao@didiglobal.com>
 <aFqYq-tLtjZjU0Ko@casper.infradead.org>
In-Reply-To: <aFqYq-tLtjZjU0Ko@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/6/24 20:23, Matthew Wilcox 写道:
> On Tue, Jun 24, 2025 at 12:12:04PM +0000, 陈涛涛 Taotao Chen wrote:
>> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
>> @@ -637,8 +637,7 @@ i915_gem_object_create_shmem_from_data(struct drm_i915_private *i915,
>>   {
>>   	struct drm_i915_gem_object *obj;
>>   	struct file *file;
>> -	const struct address_space_operations *aops;
>> -	loff_t pos;
>> +	loff_t pos = 0;
>>   	int err;
> I think 'err' needs to become ssize_t to avoid writes larger than 2GB
> from being misinterpreted as errors.

Thanks for the great catch! I’ve changed int err; to ssize_t err; as you 
suggested.




