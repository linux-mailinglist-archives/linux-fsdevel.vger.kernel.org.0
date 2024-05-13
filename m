Return-Path: <linux-fsdevel+bounces-19398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED68C497A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 00:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C391CB229A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 22:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E6484D0B;
	Mon, 13 May 2024 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coClhIsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1E84A37
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638028; cv=none; b=XStrDig1DXU6ULpJY6zpLxfuv2A5SS1YTj7gtht3Pxr++eUT3CCcrYwNiyGZjA5WVCBExiJ5stm2MG7q9REFPTHrmi3szOq/gb0PYfuSejp4DvKYimhiYMshKn4EbjJkYNJmxyBAAh5WttK/vjSVGwcuqOjlKdne4qi5PI0cg7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638028; c=relaxed/simple;
	bh=mZ4ms+V1KUqN4p5PXHq31cW+YVpnyNJ3X7Vbpk7ag2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsD6YjwT//kE0yYpShcZ0lGfXxqSMtWodFqIn7Kk7eeRRJUy1jCk91Gw7Ks7ABmwDzd//Cai1tVgGQclfCESPWLP7DLSrIsv2M0FO23/mu/VMrHntthM4ydJOEqpwwlRJMGv6h3zzqo3andGlruVOit6hwsjXhdru5b1lPwYWlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coClhIsM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36c809db200so21843085ab.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715638025; x=1716242825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUn2AW1w0vgCf/iafqE2auFhm5LkVxS+wThISH2ynMA=;
        b=coClhIsMi3gOAj37fxLCAghglBLg8muTfNNFxceItvLrGwCmSw/6qNsqyjrOoVe1I/
         YCu9nVv0Qo5KliyNvjllaYQ55D27Gl1No10qYvy84czgdgty0XkaZrUXbZscVbEtEPx4
         bskPfF4xWXxLvE/1P1/8IghEWhr4G97ndlMeF9rxr89sHzNG4xYxT87Nt6K/bj5QEWAp
         syVerurt2G/U4mz4r8r3czJ9WiK2QM3mNppx2813+PcXKJB4wN6Dgh9f1gQJiaMqRkT2
         zoAYkR5NQmsyHd+qe6Xldp4vMrd+XyLuL1wEOASyPBnaxWRpYQ/PPcq8QdPEVdCfGTd8
         lE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638025; x=1716242825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUn2AW1w0vgCf/iafqE2auFhm5LkVxS+wThISH2ynMA=;
        b=CEHKzp8/8iGjD+Vwf9zAuPHpTZOFyzWN5p2fi9HFXCccs9N9MLWZIpUtlQReCKmfVB
         Lf7rPx/9fdyALkHh75Sdi56W0STRYRQ3TrCSiA5P0TtwwN4ityV7aaZBW4v4lYQtmRhD
         CWKQ3+khxjc4PT1rQvi1/Zqg5w/BhE8y7sw+KwJ1k5scd54uv1NvH2EEM8hFpaTUX46K
         cDYAOjSLQs0fIdkcJxNJzdhHvWfeJSXb7fXrdMeZa6TKspRkerDo5vlKjI+yMko3HDiF
         9ftmGaTUS8y9aQ1W0l/xLQ5mvAwV4gBstSXTW8qpKNUmj3Z75ssqTi27ZA6PQJg2YHX2
         pjHg==
X-Forwarded-Encrypted: i=1; AJvYcCU1J+HkuVhCd3JDirGHb8qZMvpOP1GUz4NF47IFrbze98om2/v/zZzTYsS7X/wTOLphwHwKU1nUMlXLzgsVPP6sguR63+UyA1kMYc7jVw==
X-Gm-Message-State: AOJu0Yz8K3yQpfVCZJeX31pTZcL++dyv3UXetmvKTnVxeAkgti+u8Eyn
	sY5g8qCE1RpEK9EuAI0mYgQo7k2XERmarXvbXJKBnRS6A2DakgMOEcbHuXGHWg==
X-Google-Smtp-Source: AGHT+IFjekC3/wk3ILbUqc0s7IPtYONycCw5QWMFVQVvxrFuhoysFXKfr+BdK3bb3fwrb0JJhvIKEg==
X-Received: by 2002:a92:cda1:0:b0:36c:546c:ccf6 with SMTP id e9e14a558f8ab-36cc148e3cfmr143375475ab.16.1715638024588;
        Mon, 13 May 2024 15:07:04 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cb9d3f5f6sm24446685ab.4.2024.05.13.15.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:07:03 -0700 (PDT)
Date: Mon, 13 May 2024 22:06:59 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <q2qn5kgnfvfcnyfm7slx7tkmib5qftcgj2uufqd4o5vyctj6br@coauvkdhpjii>
References: <20240509-b4-sio-read_write-v2-1-018fc1e63392@google.com>
 <202405131251.6FD48B6A8@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405131251.6FD48B6A8@keescook>

On Mon, May 13, 2024 at 01:01:57PM -0700, Kees Cook wrote:
> On Thu, May 09, 2024 at 11:42:07PM +0000, Justin Stitt wrote:
> >  fs/read_write.c  | 18 +++++++++++-------
> >  fs/remap_range.c | 12 ++++++------
> >  2 files changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index d4c036e82b6c..d116e6e3eb3d 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
> >  {
> >  	switch (whence) {
> >  	case SEEK_END:
> > -		offset += eof;
> > +		offset = min(offset, maxsize - eof) + eof;
> 
> This seems effectively unchanged compared to v1?
> 
> https://lore.kernel.org/all/CAFhGd8qbUYXmgiFuLGQ7dWXFUtZacvT82wD4jSS-xNTvtzXKGQ@mail.gmail.com/
> 

Right, please note the timestamps of Jan's review of v1 and when I sent
v2. Essentially, I sent v2 before Jan's review of v1 and as such v2 does
not fix the problem pointed out by Jan (the behavior of seek is
technically different for VERY LARGE offsets).

> >  		break;
> >  	case SEEK_CUR:
> >  		/*
> > @@ -105,7 +105,8 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
> >  		 * like SEEK_SET.
> >  		 */
> >  		spin_lock(&file->f_lock);
> > -		offset = vfs_setpos(file, file->f_pos + offset, maxsize);
> > +		offset = vfs_setpos(file, min(file->f_pos, maxsize - offset) +
> > +					      offset, maxsize);
> >  		spin_unlock(&file->f_lock);
> >  		return offset;
> >  	case SEEK_DATA:
> > @@ -1416,7 +1417,7 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> >  	struct inode *inode_in = file_inode(file_in);
> >  	struct inode *inode_out = file_inode(file_out);
> >  	uint64_t count = *req_count;
> > -	loff_t size_in;
> > +	loff_t size_in, in_sum, out_sum;
> >  	int ret;
> >  
> >  	ret = generic_file_rw_checks(file_in, file_out);
> > @@ -1450,8 +1451,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> >  	if (IS_SWAPFILE(inode_in) || IS_SWAPFILE(inode_out))
> >  		return -ETXTBSY;
> >  
> > -	/* Ensure offsets don't wrap. */
> > -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> > +	if (check_add_overflow(pos_in, count, &in_sum) ||
> > +	    check_add_overflow(pos_out, count, &out_sum))
> >  		return -EOVERFLOW;
> 
> I like these changes -- they make this much more readable.
> 
> >  
> >  	/* Shorten the copy to EOF */
> > @@ -1467,8 +1468,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
> >  
> >  	/* Don't allow overlapped copying within the same file. */
> >  	if (inode_in == inode_out &&
> > -	    pos_out + count > pos_in &&
> > -	    pos_out < pos_in + count)
> > +	    out_sum > pos_in &&
> > +	    pos_out < in_sum)
> >  		return -EINVAL;
> >  
> >  	*req_count = count;
> > @@ -1649,6 +1650,9 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
> >  	loff_t max_size = inode->i_sb->s_maxbytes;
> >  	loff_t limit = rlimit(RLIMIT_FSIZE);
> >  
> > +	if (pos < 0)
> > +		return -EINVAL;
> > +
> >  	if (limit != RLIM_INFINITY) {
> >  		if (pos >= limit) {
> >  			send_sig(SIGXFSZ, current, 0);
> > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > index de07f978ce3e..4570be4ef463 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -36,7 +36,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >  	struct inode *inode_out = file_out->f_mapping->host;
> >  	uint64_t count = *req_count;
> >  	uint64_t bcount;
> > -	loff_t size_in, size_out;
> > +	loff_t size_in, size_out, in_sum, out_sum;
> >  	loff_t bs = inode_out->i_sb->s_blocksize;
> >  	int ret;
> >  
> > @@ -44,17 +44,17 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >  	if (!IS_ALIGNED(pos_in, bs) || !IS_ALIGNED(pos_out, bs))
> >  		return -EINVAL;
> >  
> > -	/* Ensure offsets don't wrap. */
> > -	if (pos_in + count < pos_in || pos_out + count < pos_out)
> > -		return -EINVAL;
> > +	if (check_add_overflow(pos_in, count, &in_sum) ||
> > +	    check_add_overflow(pos_out, count, &out_sum))
> > +		return -EOVERFLOW;
> 
> Yeah, this is a good error code change. This is ultimately exposed via
> copy_file_range, where this error is documented as possible.
> 
> -Kees
> 
> -- 
> Kees Cook

