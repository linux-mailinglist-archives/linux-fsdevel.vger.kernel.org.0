Return-Path: <linux-fsdevel+bounces-27594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED471962AD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5E0C282BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690131A01CC;
	Wed, 28 Aug 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="XTDen7sQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311031898F6;
	Wed, 28 Aug 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856706; cv=none; b=I3yFZM5EbMNoWs8ZMImz8684HDXpqpj7bssApng3wStMNK++BqVGPd2oaME4fXyt95tvt+8xsPlYsHnZ3al477pt6KKlei6xPYpig78e4VL+GJQQ1DVuOk/a4s/KgAmzBYLM7Eq4pu+OXaZGeCWgg7cuA31dM8LXHlun7XCPWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856706; c=relaxed/simple;
	bh=8JtQ18OLVzFWX8geqNYZeN7Vh4PMTNF9RG2ZtCetbXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBPdy4sfpUo2ViQZPi7SLbhACMIk+9kXUlwBHC2vLToz3OVFwChEegj3S1S7kZvxql+ukclik8fGlDyxmv6uh3vdvWSD8Vn1idEt/HSar+lu0GB+OGHPFXVxpj5wsxth8oRuBlUe9tj1K1V3lPBbLQBxCgpwK8PMm7DtxI9l348=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=XTDen7sQ; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VP+hqOelGa5pKflE0DRQN+uFVvubKK/EENoZvYaD5BU=; b=XTDen7sQx9agssYn8MkhNRiZRd
	5VRTH1xLhBVR3UdCS72CEyCqNOtGTiAHghk2hU5yHITlgFLzXy0oDXuLYRBUF9iuGLMlRO/AGhH09
	FavBkDsi8fFccpamyxqphV0pT/iU1nZBwzjU/OIqkC6T1jzjzuFCexTGUpkAdu6GRfMejyLG22IVh
	qQUGstn6WeGqgXv/ciRNZO0TfcTouuViW9pJhJb2DjrWMOEY0PRi7mlRLIrfa7MNfV8Oz97o/iQZV
	vFieUPfTXP5Wd2rs44DBBlHfZP/LFZGUEVLF0qxG2h+AF7IafcomvXsw3H3L8458xX9WccBR1LrjX
	YNrpQDyg==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sjK1O-006N4P-G9; Wed, 28 Aug 2024 16:51:42 +0200
Message-ID: <fe4e1363-250a-f5ed-82fa-9996f6c9b67a@igalia.com>
Date: Wed, 28 Aug 2024 11:51:34 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4] Documentation: Document the kernel flag
 bdev_allow_write_mounted
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: linux-doc@vger.kernel.org, corbet@lwn.net, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net,
 Bart Van Assche <bvanassche@acm.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <20240826001624.188581-1-gpiccoli@igalia.com>
 <20240828132640.baglvrg3vkybjkys@quack3>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240828132640.baglvrg3vkybjkys@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/08/2024 10:26, Jan Kara wrote:
> [...]
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -517,6 +517,18 @@
>>  			Format: <io>,<irq>,<mode>
>>  			See header of drivers/net/hamradio/baycom_ser_hdx.c.
>>  
>> +	bdev_allow_write_mounted=
>> +			Format: <bool>
>> +			Control the ability to open a block device for
> 						    ^^ a mounted block device
> 
> Otherwise looks good so feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks! Just sent the v5.

