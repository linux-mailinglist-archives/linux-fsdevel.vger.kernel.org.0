Return-Path: <linux-fsdevel+bounces-30629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B2998CADD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64E7E1F2290A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC24431;
	Wed,  2 Oct 2024 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="id+FmlUM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AF48F54
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832858; cv=none; b=sWZK0JjiyfpSaC2BAA2Rp/nwRqmL3fjvIxKWXSUrY0xA+/a0fAlQphR6YMUTo4N+YAJSXMWnVA/anh1F8mpQXZZ8cY6kT+J97B3tlBBKHQdalIn6SxI2hTNgC66dk2X86z2BNL6EqqP2v1imi+oNaEe5n14mK8S0XWNzMfqlgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832858; c=relaxed/simple;
	bh=MxemTxylnepD6rz6xU1Ej6EsH9Q1U3ZO2JLGzcMcej8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WokaH05hs31+/cf4LcHJYH5SgURWy5zCv3GwlfRBZVkjXF32uZ7i7bXlZf3veOn3gUZEHesZ9rhJeuF3KINpE7odR0I0RPzfdMbKYDxGdjybHSG0X6rm7Fxk9XBBYD/Udqjkcd1khbHfGTzgoFg/vIBWJIULELSw40iVJjRSkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=id+FmlUM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b7a4336easo21824615ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727832855; x=1728437655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfarinC2Xn9KFl5pKSBmyVisUQmi+lpSng5euhDBafg=;
        b=id+FmlUMms3vPxbMt49t9qKGBpB6qFwYpKvgSWFxmbnZ2bVOkQfI/A1glaIcKkgKwO
         H54mm0MkOjMgg408NXgtAUfL8BfQ2OYY/f5mKGO4wf9WlzFwns1wxACXUqyXDt5BnlO1
         BbCGFmq2+8X3PLxT8Md2UwpQmNN5iJ0pSKv92jaXlccjN2GuFiXSBnEi0Ymz5jIBmzGm
         /vuHncvemw59zVs4cdmd/pRZ10fYCze5WwpBeAw71vgusWkxgKzrjKExi3M4ZralpCth
         1Tt0YBLjDjVEGqUrG3gCuI5y/004HM3z8/iHMapxpsZSH6gOOFP2r4+4tOL+5NXhtOqd
         d01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832855; x=1728437655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfarinC2Xn9KFl5pKSBmyVisUQmi+lpSng5euhDBafg=;
        b=TV7r+Z7jAUa3PaAzBytp5a70ENZPyscRg59/Kfz9QuOeWbZjWLxlRRDEjn4t9rMTLB
         8p1xTBTv2tY6ttznZm/YeMeEHwQf47eVRefT12ahYUdZPD6+NWEzxqGavGSBrmp14fvX
         TNfyuN/EBcu8J0k/Yko2aCwqgk9RfZqK8v58XI+PWlEsJuVWTmmxHxmGRnU56P9Q1DtZ
         69gs/7ulqkTFvHr0TzgMUJ9kw11KTwkt169nQ9eLg+iUNpvlW/LG3RjtpjvJJt82fonF
         uBWSUrapiauu0pmm+p4kO5nYDI3I03eU0s54v2hQcvpj+pEvz4/xkUQ+8OV3z53ydCGV
         SIwg==
X-Forwarded-Encrypted: i=1; AJvYcCUyJkygBiB4bxKke4FAmHaSGNKQk8drMZrXTeM0TI3X4g4Y2+xIeWr6V5Wrpd321fhiiZwq+89RE/UrBPZi@vger.kernel.org
X-Gm-Message-State: AOJu0YzI1eiUsn+REjwRsivTfDr68KyDfPcxW/GAICIqDlLPrO/Fl3Ic
	zBBuB5CXDxlLf9hzwtV/YWsg8Hb56SJhXew35i6zHMidDZzEfCWyh+AVUPH70ow=
X-Google-Smtp-Source: AGHT+IFAD4TRtJ1wgh7w8a/eAU8N7oA/g3Jc4BMTqQ0/oXU7OEwf1UyjvGIgqbBOF6ZPFSLFXsGcEA==
X-Received: by 2002:a17:903:2a8f:b0:20b:9034:fb4a with SMTP id d9443c01a7336-20bc5a76029mr19165015ad.49.1727832854665;
        Tue, 01 Oct 2024 18:34:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4d58csm76026745ad.231.2024.10.01.18.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 18:34:14 -0700 (PDT)
Message-ID: <12334e67-80a6-4509-9826-90d16483835e@kernel.dk>
Date: Tue, 1 Oct 2024 19:34:12 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] replace do_setxattr() with saner helpers.
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, io-uring@vger.kernel.org, cgzones@googlemail.com
References: <20241002011011.GB4017910@ZenIV>
 <20241002012230.4174585-1-viro@zeniv.linux.org.uk>
 <20241002012230.4174585-5-viro@zeniv.linux.org.uk>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002012230.4174585-5-viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/1/24 7:22 PM, Al Viro wrote:
> diff --git a/io_uring/xattr.c b/io_uring/xattr.c
> index 71d9e2569a2f..7f6bbfd846b9 100644
> --- a/io_uring/xattr.c
> +++ b/io_uring/xattr.c
>  int io_fsetxattr(struct io_kiocb *req, unsigned int issue_flags)
>  {
> +	struct io_xattr *ix = io_kiocb_to_cmd(req, struct io_xattr);
>  	int ret;
>  
>  	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>  
> -	ret = __io_setxattr(req, issue_flags, &req->file->f_path);
> +	ret = file_setxattr(req->file, &ix->ctx);
>  	io_xattr_finish(req, ret);
>  	return IOU_OK;

This and ... ->

> -retry:
> -	ret = filename_lookup(AT_FDCWD, ix->filename, lookup_flags, &path, NULL);
> -	if (!ret) {
> -		ret = __io_setxattr(req, issue_flags, &path);
> -		path_put(&path);
> -		if (retry_estale(ret, lookup_flags)) {
> -			lookup_flags |= LOOKUP_REVAL;
> -			goto retry;
> -		}
> -	}
> -
> +	ret = filename_setxattr(AT_FDCWD, ix->filename, LOOKUP_FOLLOW, &ix->ctx);
>  	io_xattr_finish(req, ret);
>  	return IOU_OK;

this looks like it needs an ix->filename = NULL, as
filename_{s,g}xattr() drops the reference. The previous internal helper
did not, and hence the cleanup always did it. But should work fine if
->filename is just zeroed.

Otherwise looks good. I've skimmed the other patches and didn't see
anything odd, I'll take a closer look tomorrow.

-- 
Jens Axboe

