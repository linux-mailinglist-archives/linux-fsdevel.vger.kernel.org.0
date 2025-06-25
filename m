Return-Path: <linux-fsdevel+bounces-52892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B31AE8046
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42EB54A521E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6A2D1319;
	Wed, 25 Jun 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hEJNCM6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FB1DB958;
	Wed, 25 Jun 2025 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848685; cv=none; b=R4Em3sLFSQ/zYSl86ScnOKhWFVEOQljP3eTHFFhS5Jr2VpSnKUSMhaiLg2TP48VYDlp1wQRPTLvZekhbozUakP8Wj8wLBNW+8IHJwqjVMKQpoGEAVvC8i1HbEQzltVApw76ae8LO0zSYaIB4K3EEkEWiCEnTIXcQa1Lua2vAuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848685; c=relaxed/simple;
	bh=fRZQe4nl0zKEUEJnNAJ903ZecOWgKWBEK13lijK2btU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YgZII/6CPaTqEcvHoo+fkrf08wTXK7hoK8bKaIBszWfT8n0uKTYWW1g8CM3o2tjeEf8I7QGi6mtjefhqRVVcCpaNaEg/uWzpTvMugIVOfGKxVEuFiFtOLlnyAcfI1/YrIttaHx7bDta3knsv6JCicUX6mrrll/jur1bNiZZGov8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hEJNCM6Z; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1750848367; bh=fRZQe4nl0zKEUEJnNAJ903ZecOWgKWBEK13lijK2btU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hEJNCM6ZEPHh6f84t10y6/by9x0fWak3Pg9UI1wSeVixF2e96t+9lZzISUpkB7/oW
	 ZOwPaYVVCY9jGWIszJiUsThrXfIqnwG2fLmdrEWiQFs+RlY6sH8/cL6BKv+1ob1qUm
	 i9wjf4H+1nts5RYGFmb/NO4yI/UR56vE5e70r0EM=
Received: from [172.25.20.158] ([111.202.154.66])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id B839CC3E; Wed, 25 Jun 2025 18:46:03 +0800
X-QQ-mid: xmsmtpt1750848363tmxew2sy5
Message-ID: <tencent_FB9C854A6AB8D1CF28C88A8642B297A59C07@qq.com>
X-QQ-XMAILINFO: MT46X0n0UCeM4y5W26Ag/ADFG1DHi9F9CHyqbj6DSfeO3dtcmIBOE1oh2UcVZP
	 ZMmQ68mcMehwhUbLUnc07Zn9RGz6F2suZwRJOeyiIzICBfgm0V2+5cregthy5C7I8MB6FhVvNcYM
	 /VYkFzpfdEChNh1ny0qa/KKLXtV+MtsrADzq4s7xqMxPy7INKe9X7UTI8B30l2IDWVuhCLBivAB/
	 KpDHHHEgbPHLOTlKPIWS+VeUSKe0p858cK9CT24Fk/cVWieuHQr8ktv6F80EJcbM+1S/A2ggowY6
	 fAb4V4CaUZGL0XfnXbcLYb6LQmmw+A5CVdgTwLZAnVSKd0mwEH7Z7pmaiJiOydAd+niM/H3cdnq1
	 rOkrq8lQR55XrWjPx6gZ/EFejSqH8DoRxc5WJMO4+TBv4qGCLjkGxCLhfzpfNWMA8RomFYbRvWrD
	 6xwkMLEpPnGJXjxpwo0483KUAhbHlVgxJPUoWax2HkTNHkIBqD2j7ccHzxxGpye4OildalBIIxay
	 J8znfIlVeLvpwBSMKx5L/dMMyldBbPzxX+CEr1l9/weUIrqiRVImt6MOFUDOlunpBV7QPxUklf6e
	 CQvXxLC5C5gBdKfW7Amei+h97GCDgKpfJBIpvH0s06O9iBzMr5JOBv8vnfdC9scfGJIYymZ3iHWM
	 8a+CKbZBw8NCA+65oAHoE15MX1UdBCdnXi39kjjEPdDJxqNl0vUWfCKAdnGACYxu7dc3IA8WzeYG
	 t83PPzmGaZZysMJnUHhsday1qRc0X4xe1rkKegzSK3hnBQgHu9LTEGpy19ILw0Uo5i+dLyw22WC+
	 o60brkozWdLySFo0VMzrZoSZxjebVnDOYd46LeGlXEI3ApHoWbtH5gX9qdOmXHpDuXY0YRuqAi1i
	 YyETv+GdRIAh7F7kT9T8xtYBssGRzq52KheHTFTcSRV6Y2jZHXfqJkiLRTtyNhFI5Jhet2ohBjyw
	 xJIvTnxoRcyK6Hsx4wo61Ymi6SJV4FfufqOKeFAABoMNiHKEgteeWdTwi/nC9lwdKRit1VdVs=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-OQ-MSGID: <a9c446ff-d51a-40bf-a243-350de1e6e613@qq.com>
Date: Wed, 25 Jun 2025 18:46:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] ext4: declare support for FOP_DONTCACHE
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
 <20250624121149.2927-6-chentaotao@didiglobal.com>
 <aFqfwHofm_eXb5zw@casper.infradead.org>
From: Chen Taotao <chentao325@qq.com>
In-Reply-To: <aFqfwHofm_eXb5zw@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2025/6/24 20:53, Matthew Wilcox 写道:
> On Tue, Jun 24, 2025 at 12:12:10PM +0000, 陈涛涛 Taotao Chen wrote:
>> From: Taotao Chen<chentaotao@didiglobal.com>
>>
>> Set the FOP_DONTCACHE flag in ext4_file_operations to indicate that
>> ext4 supports IOCB_DONTCACHE handling in buffered write paths.
> I think this patch should be combined with the previous patch so we
> see all the change needed to support DONTCACHE in one patch.

I’ll merge the patches to keep the DONTCACHE support self-contained. Thanks!




