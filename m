Return-Path: <linux-fsdevel+bounces-13519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB1F870A08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459FB1F227D3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA4E78B6C;
	Mon,  4 Mar 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B54RymFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22256216C
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579084; cv=none; b=Ca0Dd0m5ptymbnVjacUY2Rq+Ob3fcA6lWG94Z9yW6YLlB+I1VU/LBf0Y9b2IUtCB8ZP/It36KoM0oQ8QosXGDtJwVasIcyqd788in/W4mxMPDy1j3yt/qZW56B4BaHNNk9bjirzhKLF7bbQNMm/jqIAlSrNvFtDQwlDsr4TLkpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579084; c=relaxed/simple;
	bh=Vj8/j+7bXWm6HZmcMP7c2x1PYtHcWlQtYl7LjST1ueU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGAfSHAxhmELMBT+LjjpVXkXsKzjF9qtChKmLVTld/FEk3vuIb1euCSFKY86DreQprDOros2/G4L1MCMrLvw99m18XZkoPgo0MNQShqAzhAMNi7gwdTOR8vyRZsqa1xRbg8Pj96q1tDhCJROHU+PHnWhhzXhtJ99muVzKIJRiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B54RymFJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sYZ+rpzAy+ACDIeGjoRE7FlQwI+n2j2KMY1MtI1oTE=;
	b=B54RymFJKCuN1PHkcIUkUm1V8Bj63Wv+REugfluYP9iB+Sk5FVnQaXRnUB+S5XSS0tK57t
	TfDPZ+KvONH2SK7Ui1/UhWyOaj84fjm2NGKAq3uRc+LX2scTX2uZ6fIBqszLVDtReQOKts
	tcQ2KKlenK6s53ZNbpMMyU3xw7E+/Dc=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-Gv_u0oRsMae54AgHhzAFgQ-1; Mon, 04 Mar 2024 14:04:40 -0500
X-MC-Unique: Gv_u0oRsMae54AgHhzAFgQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c49d118546so389877839f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579079; x=1710183879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sYZ+rpzAy+ACDIeGjoRE7FlQwI+n2j2KMY1MtI1oTE=;
        b=UOv6Qt5ArB8BUu773mci+w0OTGb5YEccCo0J/JniRtSXog+XAKsuKNFcHZTD1s1Am5
         yDBqrdznwSjDqcAAYeXPGC0DLDxqIEyFKD3BLuCNQJViGDa1MRAAsQcpruf1XPqDkazW
         MqODpj2qbGcXYnuJjiZCSg27XheCytOnPGL++k1B+cSVKUAmsq0EDgtwu0+Z3nqaU1qC
         HzT6dzarn9M4K5uq4WapeJ/dQCpg4LABhi7DpnFAAw8N4tPtwTTvIywVJ89DIvcQteHS
         FkKhh8P0ru1+ezmb7prT9hJjJH5/L4/87qsZXNZCMkCmTnivJcHG4FehWOFUdN2jWM/3
         MaHw==
X-Forwarded-Encrypted: i=1; AJvYcCWbSCAz7/Oj8kT8bkJL4SxEAIsZ8MLfFZKZhq10d6nwHbJEQoMYEQkP+zPfLvZNWrRIlQREvY67I2p4S1QhwMNxP+ZRuhCjhrV2YMCyow==
X-Gm-Message-State: AOJu0YzEi4Unje68yzYp33HRghjT9IHGh6JJL2Bysx4fowg3Nqpv4VR6
	LYBMIos/YNrXOw/Wt2PTbLW+LS5EAEDY8oxUZwauzrjg8GJM71TPwziKIj7KHTdiwe2hDCqzjq7
	OjLyELjNmRdXhoF/T7CFLhEv2/N1QqHSfnrIeqxq7F7CB5UsuofBNvHvfwX93SnBHO1s40rM=
X-Received: by 2002:a92:cd8f:0:b0:365:21f9:fb22 with SMTP id r15-20020a92cd8f000000b0036521f9fb22mr371484ilb.14.1709579079094;
        Mon, 04 Mar 2024 11:04:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3f1mQeiusGuDVabpbqgKYD9O71bdNEAbehbBCDoiX11rL6YtfXbTh5OJ80CYvoLPa/d3ZlA==
X-Received: by 2002:a92:cd8f:0:b0:365:21f9:fb22 with SMTP id r15-20020a92cd8f000000b0036521f9fb22mr371472ilb.14.1709579078849;
        Mon, 04 Mar 2024 11:04:38 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id p14-20020a0566380e8e00b00474d2a8e83fsm1827706jas.83.2024.03.04.11.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 11:04:38 -0800 (PST)
Message-ID: <7ca480f7-bea1-4ee8-aaf0-af8ad49f0e68@redhat.com>
Date: Mon, 4 Mar 2024 13:04:37 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] efs: convert efs to use the new mount api
Content-Language: en-US
To: Bill O'Donnell <bodonnel@redhat.com>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org
References: <20240304161526.909415-1-bodonnel@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20240304161526.909415-1-bodonnel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/24 10:03 AM, Bill O'Donnell wrote:
> Convert the efs filesystem to use the new mount API.
> 
> Signed-off-by: Bill O'Donnell <bodonnel@redhat.com>

This looks fine to me now.

Going forward, I might try to structure the changes so that
_reconfigure() stays in the same place as _remount_fs(), and
_get_tree stays in the same place as _mount(), when possible -
it makes the patch a little easier to review. But that's just a
minor suggestion.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>



