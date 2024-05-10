Return-Path: <linux-fsdevel+bounces-19243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5758C1CFB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7CA1C21FB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1415149C43;
	Fri, 10 May 2024 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UC37spjJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C682148FE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 May 2024 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311575; cv=none; b=pAnWD2pjwTLpf7Its5/ezT+mBRo14DelZq3qEvrm+rCszNwOCOrcxfwnU4l9o4zM27VsjuDra1vhPaajrN3O/14ci/hRXpfr5uV1z3V5cbC8lrMrFGlAsD4DcauKdlVJ5ZrTcELky+GgPEDu+PQem+BpeCCFzyAaxwdmZLpE71Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311575; c=relaxed/simple;
	bh=KR9+aZtQF0/pSAuWezxC9nZ37UK13y4iod1lyaoIAd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z41t7vIb3ktfwNak1hwyTnqIoOkbLPV9Aa+YhlwKRWpOD4aGxF2msE74TR4e+5BKiuQBj8qferob6Sol29OjM34CrVt16e2YH8Ph2m/0/9utBimBJQ80b4iwajB+QFy8kTpBfpA8VKvAkKgiqOyG2+zQ63Yd2HK9fM75R57KfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UC37spjJ; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7daa6bfe4c8so57705939f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2024 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715311573; x=1715916373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGxG2e2VKN3u+G1wPMCaUsbNuE8sBdNRV0fq8NAvdDA=;
        b=UC37spjJSrJeRTnQpVFya+6hKbRsXS/cfRfD/wpp6qOH24VVtVLgzP8dxiKXJc4nU+
         /3dU90BPG5soeMQKIhuIf+9zBX8VNMvBY54Vyoim+V9xlMKFoTrE2h1EopZrH5en+fgm
         R/ByOuHcudp2VoiOpIRiU4TKfywizobTDEj9Q2f5zbkRp+K9bTr10M4/jy3MwV//Wctr
         btQKqyTuV84+0a+QFXsfm5AG/N6dyfRZg9hS6fAhjb+KYdAgbosrY5CSFeHvXCz4mdKi
         CS+mNf5YVE7ysNj1KXTyO3Uhh+9YBT/YlVsz5xpfVAl56TDqdvE5MjsB1MgCI0GSTpdy
         /uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715311573; x=1715916373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGxG2e2VKN3u+G1wPMCaUsbNuE8sBdNRV0fq8NAvdDA=;
        b=BwLqtk5HQ87x5BXIITAvOS8DDF9ie7N4nXXioU3cXnlngsiwPDjHl4lDWxGhlR32F+
         7uliG+SeBY/JiT/YLviz79OCS1r9DZUrJ/LFUSp3oEyTtvCtajEUqXG5ZsF8w3gYHZ2s
         BtcAkc/vGtQaGF74lVMR5LmXHCOWKWi1pUXNXgpqMxVaQ1ffZmQY7B1+L/Ccn43TL2nX
         6PJIjPu1twEFEqNCeNfEhUZFBWEl/idI2uRCd/EmrxEC9lHCVUBeQAOizRbYOVVfuHWl
         +jYlDC6r0BlFLsENUEHtcSj+OChLeRgZy67quFbN3pzEaCyCITaIicxbbUEeTnX1ctwp
         5BHw==
X-Forwarded-Encrypted: i=1; AJvYcCVKEIO2/U2tUah3AuH6JVtPm6NHrU+QfmfYGTNV6IppmDRBHfdeAtnR4OVvEJfKHMKZb9m/X2Rj50Hjou7YkgfmAddr7YX223JvEY6AWA==
X-Gm-Message-State: AOJu0Yz8uElhaG20UYjTAx7BjLEhCuyOrdKFnMGgmht4SE4/bdFCodGn
	8RrEIYTr/GfJt6kEQfvnAOO1Mb/felRF7QRah+nGZ8Qy4klLW/dN2XHWqknhQw==
X-Google-Smtp-Source: AGHT+IFjs2Y7MUqk7i3aTHdpOsTi/0KqnFICd1YQCAkvu8AdXH/Iyxc228RpFccF4GUU9d3ijbo4fw==
X-Received: by 2002:a05:6e02:168c:b0:36a:2538:d70d with SMTP id e9e14a558f8ab-36cc14eca55mr17036045ab.28.1715311572814;
        Thu, 09 May 2024 20:26:12 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c13f9sm710317173.97.2024.05.09.20.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 20:26:12 -0700 (PDT)
Date: Fri, 10 May 2024 03:26:08 +0000
From: Justin Stitt <justinstitt@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <6oq7du4gkj3mvgzgnmqn7x44ccd3go2d22agay36chzvuv3zyt@4fktkazj4cvw>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
 <20240510004906.GU2118490@ZenIV>
 <20240510010451.GV2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510010451.GV2118490@ZenIV>

Hi,

On Fri, May 10, 2024 at 02:04:51AM +0100, Al Viro wrote:
> On Fri, May 10, 2024 at 01:49:06AM +0100, Al Viro wrote:
> > On Fri, May 10, 2024 at 12:35:51AM +0000, Justin Stitt wrote:
> > > @@ -147,7 +147,9 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
> > >  	struct dentry *dentry = file->f_path.dentry;
> > >  	switch (whence) {
> > >  		case 1:
> > > -			offset += file->f_pos;
> > > +			/* cannot represent offset with loff_t */
> > > +			if (check_add_overflow(offset, file->f_pos, &offset))
> > > +				return -EOVERFLOW;
> > 
> > Instead of -EINVAL it correctly returns in such cases?  Why?
> 
> We have file->f_pos in range 0..LLONG_MAX.  We are adding a value in
> range LLONG_MIN..LLONG_MAX.  The sum (in $\Bbb Z$) cannot be below
> LLONG_MIN or above 2 * LLONG_MAX, so if it can't be represented by loff_t,
> it must have been in range LLONG_MAX + 1 .. 2 * LLONG_MAX.  Result of
> wraparound would be equal to that sum - 2 * LLONG_MAX - 2, which is going
> to be in no greater than -2.  We will run
> 			fallthrough;
> 		case 0:
> 			if (offset >= 0)
> 				break;
> 			fallthrough;
> 		default:
> 			return -EINVAL;
> and fail with -EINVAL.

This feels like a case of accidental correctness. You demonstrated that
even with overflow we end up going down a control path that returns an
error code so all is good. However, I think finding the solution
shouldn't require as much mental gymnastics. We clearly don't want our
file offsets to wraparound and a plain-and-simple check for that lets
readers of the code understand this.

> 
> Could you explain why would -EOVERFLOW be preferable and why should we
> engage in that bit of cargo cult?

I noticed some patterns in fs/ regarding -EOVERFLOW and thought this was
a good application of this particular error code.

Some examples:

read_write.c::do_sendfile()
  ...
	if (unlikely(pos + count > max)) {
		retval = -EOVERFLOW;
		if (pos >= max)
			goto fput_out;
		count = max - pos;
	}

read_write.c::generic_copy_file_checks()
  ...
	/* Ensure offsets don't wrap. */
	if (pos_in + count < pos_in || pos_out + count < pos_out)
		return -EOVERFLOW;

... amongst others.

So to answer your question, I don't have strong feelings about what the
error code should be; I was just attempting to match patterns I had seen
within this section of the codebase when handling overflow/wraparound.

If -EOVERFLOW is technically incorrect or if it is just bad style, I'm
happy to send a new version swapping it over to -EINVAL

Thanks
Justin

