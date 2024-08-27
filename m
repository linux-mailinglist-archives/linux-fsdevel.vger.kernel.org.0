Return-Path: <linux-fsdevel+bounces-27416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C76961520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 19:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8661F23873
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 17:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A131D1F52;
	Tue, 27 Aug 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vy1D+oMT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2211D0DFC
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 17:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778303; cv=none; b=Xhh1m0ZsFdJ8IbemaX4VRzVQkDr9Dcjby4lpbpvsokbcCGSoyObqpk58TfaIGT1/rv3TNPRw41uEuDzU99ACt6PDVJ4c+QGI8md1HmrY4OLjDMydFRt7qSoVnWX6FuKZRW5++h4v/7jyv3TIPmjI//YpsVbAfF+wrqCR/9nh61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778303; c=relaxed/simple;
	bh=N2Gx4J4DwSvO8WkEQ//ZahHGG9IF7Bs6dQk75TDuC8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgqAEwuIrZRV8XqOscR61qbAtznDEjjKhYj+sDqtvG0843aa8keOMku/MbeE62kPIDkKODtY9ZzBz94Iq5kOa8FzVmSqQkkcyNLSNkbiqYGJx8TYC9gdamPGWOOeSFwIZ27Qj58qOqQY+ZuLVl9qTrcyTb5Ee/7ffp/f6nnfRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vy1D+oMT; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1dac7f0b7so368851885a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724778301; x=1725383101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5Kn1ZNTjSAKhoEGVSVxLRfLE7O6HbYoZzzxk2p7vV8=;
        b=vy1D+oMTCBKm+UtUEUU0LMC2plw/CgGEChmeXwTKn2561xAb0NY4WqMtk6e1JJjV55
         THgt7kptmCer5i9YsMNTrufE3/hUWz/pKWVRAYGUr1ptZnBYIjKy7UdbFwJSWRASgUGn
         QwE1j7qpgIYz2Ev4oPyTr6HRhVrgRnmiKNuWQ4C2LkKTwlDzHawe5znBr7m5bWBu+9Sl
         9PP20SC3mA+9j2GN70s+79X/FbaaScoPYCKBKEYupxTEzB0Uh0mCWamSorHEnjAak/Ds
         28p20IAD0zrd+4u9vYHCrNT6BNkyPylIyoNh44NlZ8vugObpJQGXgRVA5YnN1yBMHrbz
         jp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724778301; x=1725383101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5Kn1ZNTjSAKhoEGVSVxLRfLE7O6HbYoZzzxk2p7vV8=;
        b=uhdWM+7S6D3aac35qo06NTEom69wrn9XLjzLTMEVTB8PXwW9N2Bdh5qCOkVeSxRUTX
         oXi3iUMWqG/p4xjyXpRSL9MWchl5rhSqL9bTwmcMCOH1r1K7jjAAKc79+SQxaIAzeCMS
         ZWcCEllgwmEb/yGVYB2tgEaKNdOeqDvtRuYzkprtmiZEk9WxbLVoHSuOOvWF6wqhh0By
         VjHi4iyfTK7uKIE0VWc8g+W7bmT7VXUuyP0O2FjHE8Ti072iqQvcGlKAoib+WjGiSlJ9
         T62CjadH1TJ3EmF+3SaAK/O7hMgq3aQne2VZEhedv+3t4hqIuI3YgCLFto5uAwIjR3+D
         rYMA==
X-Gm-Message-State: AOJu0YyPlg0S1oBklk2DvotZ9nYQbJhIKVzu+lC0w6OJj3XmeTOjw7+W
	EIEqCvg2wqgaD91ExPbN+9lr1CWDoubbKMmlm/hB0aQQAiOPLsbpMv6AKSF3d0c=
X-Google-Smtp-Source: AGHT+IEz3CRBJqPaIciNWfH7HtPt8bNbglDhgkKrPgYSkOEJgiY564qT56gXi5ncdtWUwuTti77C6w==
X-Received: by 2002:a05:620a:4710:b0:79f:b3d:bed1 with SMTP id af79cd13be357-7a6897ba741mr1840950885a.49.1724778300675;
        Tue, 27 Aug 2024 10:05:00 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a7efabb7a5sm34579585a.55.2024.08.27.10.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 10:04:59 -0700 (PDT)
Date: Tue, 27 Aug 2024 13:04:58 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: FUSE passthrough: fd lifetime?
Message-ID: <20240827170458.GD2466167@perftesting>
References: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 11:41:04AM +0200, Han-Wen Nienhuys wrote:
> Hi folks,
> 
> I am implementing passthrough support for go-fuse. It seems to be
> working now (code:
> https://review.gerrithub.io/c/hanwen/go-fuse/+/1199984 and
> predecessors), but I am unsure of the correct lifetimes for the file
> descriptors.
> 
> The passthrough_hp example seems to do:
> 
> Open:
>   backing_fd = ..
>   backing_id = ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_OPEN, backing_fd)
> 
> Release:
>   ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
>   close(backing_fd)
> 
> Is it necessary to keep backing_fd open while the backing file is
> used? In the case of go-fuse, the backing_fd is managed by client
> code, so I can't ensure it is kept open long enough. I can work around
> this by doing
> 
> Open:
>    new_backing_fd = ioctl(backing_fd, DUP_FD, 0)
>    backing_id = ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_OPEN, new_backing_fd)
> 
> Release:
>   ioctl(fuse_device_fd,
>      FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
>   close(new_backing_fd)
> 
> but it would double the number of FDs the process uses.
> 
> I tried simply closing the backing FD right after obtaining the
> backing ID, and it seems to work. Is this permitted?

Yes that's permitted, we're holding a reference to the file in the kernel.  The
dup thing works too, but as you say that's a lot more fd's.  Thanks,

Josef

