Return-Path: <linux-fsdevel+bounces-20981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C728E8FBC0C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 21:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8308928178E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAED914AD19;
	Tue,  4 Jun 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Yp9kDAM+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40871494CA;
	Tue,  4 Jun 2024 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527946; cv=none; b=Ik1glt7KsIXTgldS5Ergz0Ofmd9PTJt/bX9wAND6UJhz6kGjLHdu71saObyOOXb7B2TZI7xRMUodSIFECg2zwvcyYBqUBNmgUu343jfKlxgSqFCrXDFJHaoFb/e5bWuCx7iJquBCiNSlKglVa4PeDUgmiFQkxR/1LUhvb0yuvv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527946; c=relaxed/simple;
	bh=7H1NlymcCUPLEYCBRoR+N/uLzpyO2oc7z52xOA7HhqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJji0lE/2imEkxQ2ONsh5uqcKz7iB/PPd1OU4g7acc1W3m1dIosTJZRFyTUz/lPqp72P9shCLJbp0MczHSBhJDR0vRSA8cg07JH+dev1yuImBkcVfLTfWYQVGkUGr/XlE5je7OHfLtNxf3E8Xcs7/GjQXY56gqJKUdWzAnuxpxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Yp9kDAM+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kBZjuDjeGfjdZptZZCrUbh8WS65dvQlWt6oSaNd1zeY=; b=Yp9kDAM+7pM3XD6NqBRYW0czB6
	tcLmBLZ2mKYtMDMEDiCqeWhEWSr39QEX+0GI+B63X7iLx1JTtz9KCQyaph9z5Ark45yINsqgVe3BX
	2wBDS3a4F/bmKCTdSTkT+e4TvHFM/swX3YjyF3A+G9yO1LKmeJRi9N2LBQ3chQGwvuc3KIPtCCHun
	XqFxjLUo3RujBVegeuGcSliW9PQnjIG4OUH+VoeTIDQskFmx9CTJe6WcCGkO/VRwinZp6U7EGXD1x
	8oI/8tUIhaIQWj679JqsEEhRMcRmA/WTXDBo6uIdJD2ET6qzsKNQAXUKlesJhkJ2pdsCmA3O7H8kU
	Ku9zqRAw==;
Received: from [189.79.117.74] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sEZTK-00Gufo-LY; Tue, 04 Jun 2024 21:05:26 +0200
Message-ID: <28a9290e-b8af-93bb-26d3-3b12864ada4e@igalia.com>
Date: Tue, 4 Jun 2024 16:05:18 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore
 backend name
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>
Cc: kernel-dev@igalia.com, kernel@gpiccoli.net,
 linux-fsdevel@vger.kernel.org, keescook@chromium.org, anton@enomsg.org,
 ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-8-gpiccoli@igalia.com>
 <CAE-0n50vo5xkUNK0-cF9HZRXShsxbikqmdVnmMzRsn+Z7MEJTg@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAE-0n50vo5xkUNK0-cF9HZRXShsxbikqmdVnmMzRsn+Z7MEJTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/06/2024 20:02, Stephen Boyd wrote:
> [...]
> This patch broke ChromeOS' crash reporter when running on EFI[1], which
> luckily isn't the typical mode of operation for Chromebooks. The problem
> was that we had hardcoded something like dmesg-efi-<number> into the
> regex logic that finds EFI pstore records. I didn't write the original
> code but I think the idea was to speed things up by parsing the
> filenames themselves to collect the files related to a crash record
> instead of opening and parsing the header from the files to figure out
> which file corresponds to which record.
> 
> I suspect the fix is pretty simple (make the driver name match either
> one via a regex) but I just wanted to drop a note here that this made
> some lives harder, not easier.

Oh, many apologies for that Stephen - of course if I was aware of the
hardcoding in the tool, I'd not mess it up or would fix the tooling
first, before changing the kernel code.

At least, as a bright side here you found the tool's limitation and
there's the obvious improvement/fix for that =)

Cheers,


Guilherme

