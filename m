Return-Path: <linux-fsdevel+bounces-51489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E7BAD72BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A6C172F84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7032472BD;
	Thu, 12 Jun 2025 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPOC7IHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82A2AEED;
	Thu, 12 Jun 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736551; cv=none; b=OziNnSi27cAiS1s08EgdgWak+qspwCDiCxPHyz7RfkjQyVOvaPC7IHCb5rhZ8XADMNJLFsPE2C9rLQsP1bRfOEbpOMG058d8XRZjy1/rQuPiuFHcZQIbOY9fJOMqGtRYWEYCKU6n5lHTCuqJYoEX3vG8uCKTjc6MPA+dQ558IQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736551; c=relaxed/simple;
	bh=E0Nxbb8Zhk8mfwiipHLBBckrZjv1zJdhcMMkqy7tMgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9GhRb3MFF3WUCOizMwD5CYBGJ7425S1oD24P/KMbr+bCzwN1amoEhCmQ2NgJCRnAWFAC2zmDP6g7Xaz5OGSxqO5Svh4oALPvZ4N5B1CjAzZ8vUHY9uuEuEzAKTy2HN84oZHn9T/GUVOXAcerSSiPwdF3DiQ5OqsN9GLBBEzrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPOC7IHB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade5b8aab41so215911466b.0;
        Thu, 12 Jun 2025 06:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736548; x=1750341348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xikeG81Glqm5M9v3u+UCgVKmnmOs9BH7r2u0CB2OILg=;
        b=kPOC7IHB7oaMcgBNiRPMVraJYWrDhrfoCH2nmJxQzMbOXLVsFH95ru6BuLDPXU5/TP
         XGyu35QBNLfQRRqcvLxc2Hfa+a4pqrJl0JMKKGI/F3cpJOI0A7DxHvriOVupVPMs+rAk
         xqP9CGCVEj7h4Wd6Pv6T2truLEv6TBLUob1jQL0EDLk8FAzP4u61yccZB99xBNRznMS2
         xdvYjRzg+OEsXyNHnFf3JDV97CRGmyziNLOyTcV104TTWBOtVNhyPc8dtyoCXi/tjv9G
         fQyDl6dK+iux8UEhhBPi+fLkvwqgIoqp+bEsFns5wpThlPx9x+7F5u6ZIVSOPoFjnM/V
         rP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736548; x=1750341348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xikeG81Glqm5M9v3u+UCgVKmnmOs9BH7r2u0CB2OILg=;
        b=JpZ0GozvaazjBibXzxVT8mVpVpD6p6qqtMqDe4XRWHKg4ZmWghcvaeVImOF/w+zsU+
         p0o30TDmrNwG61sHjnR4AYvTQOctyuBzZrgJzw4rL6cKpgCUrLXBEav2H4stgIXUOHeS
         /k1hQ7dtlH6gQI458CTu8F4fjkI26RvQ5HqxzAhoPOIIib3WSjq5JjhB5UKInrL7T5gb
         Xrzf/VCtKfP5nULIlC18zfRaEm7jNF+sPSaLHz0obMeTNKF+wwxijOF3Esn1LUa0Lf8A
         BguMbES6JNv0R1mpAnbF4nu6Ed3dPwEW+AiyLs61/6ZlOE7k3PzANg9u3pIxA5InGIIC
         IEpw==
X-Forwarded-Encrypted: i=1; AJvYcCWPxL3IloC0+xx7F6HU+65gaNwhrqiIX5nqeEIsqT508bqOJAaAeJojnsLmt6uPvJbszlpWMTRspEw2SBXJ@vger.kernel.org, AJvYcCXf5oWSMN5xhN1/RrRRvxI1evy1TJkk7ee3vMz2pZ2PQNRlZWEpg6TFfPzPwU3f7Dl0L6k0rdiI+J+4oNye@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8o2e1aPQ8ykSclda1Zrp7ZfcsO8JS8LojyCzdXO0p0xb8o2T
	FHT3epRL1CKizu12j3euSQxmeXPrNj2qfX2W73D1kFgnqCDMsdxO+J7M
X-Gm-Gg: ASbGncuPGSmVX/igEw/isXiky7r3FNbqkFHRZJei2FJg0Hj9pQla1gtH7SLyU6q2jfH
	sMhoFUMFUpmHGrdgnp+JHgQxpgb5j3VaS3sKVQuayeezGPxw+BNEVQIHVW8w20QWGw4u9Uf/LwE
	I4axKqkJQjReHXJ8Nnr2l87vHKIXDxy9ssNYZjwGHOEQN5rYAeUlhrUkayc8eTYPepNnQkvLN0a
	2Wd76E4QmvARVVNo2l1X1zUIsAuYldQNpJtB53GBqVlkU2Zs8cvMYQ6qpkkxatUQrIiJ20/bPB1
	Tf8oCgoPMw/sqG+6cA+RnuX262klhW6T+MXnit0xIQius4UWiSaLIAGYeOZkhWCY/K5CwsFJ2cU
	rxA==
X-Google-Smtp-Source: AGHT+IEt/gyCua3q4hkdwtZlk5m5IJpx57fEfd6rwWGyPrfaAiZW+b8ZSeyx9l/e9qKVOFzE3helXQ==
X-Received: by 2002:a17:907:7248:b0:ade:348f:88df with SMTP id a640c23a62f3a-adea92790f3mr328097866b.4.1749736547320;
        Thu, 12 Jun 2025 06:55:47 -0700 (PDT)
Received: from f (cst-prg-93-231.cust.vodafone.cz. [46.135.93.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adeadb8c3f8sm136320766b.129.2025.06.12.06.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 06:55:46 -0700 (PDT)
Date: Thu, 12 Jun 2025 15:55:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
Message-ID: <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
References: <87tt4u4p4h.fsf@igalia.com>
 <20250612094101.6003-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250612094101.6003-1-luis@igalia.com>

On Thu, Jun 12, 2025 at 10:41:01AM +0100, Luis Henriques wrote:
> The assert in function file_seek_cur_needs_f_lock() can be triggered very
> easily because, as Jan Kara suggested, the file reference may get
> incremented after checking it with fdget_pos().
> 
> Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
> Hi Christian,
> 
> It wasn't clear whether you'd be queueing this fix yourself.  Since I don't
> see it on vfs.git, I decided to explicitly send the patch so that it doesn't
> slip through the cracks.
> 
> Cheers,
> -- 
> Luis
> 
>  fs/file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 3a3146664cf3..075f07bdc977 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *file)
>  	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
>  		return false;
>  
> -	VFS_WARN_ON_ONCE((file_count(file) > 1) &&
> -			 !mutex_is_locked(&file->f_pos_lock));
>  	return true;
>  }
>  

There this justifies the change.

fdget_pos() can only legally skip locking if it determines to be in
position where nobody else can operate on the same file obj, meaning
file_count(file) == 1 and it can't go up. Otherwise the lock is taken.

Or to put it differently, fdget_pos() NOT taking the lock and new refs
showing up later is a bug.

I don't believe anything of the sort is happening here.

Instead, overlayfs is playing games and *NOT* going through fdget_pos():

	ovl_inode_lock(inode);
        realfile = ovl_real_file(file);
	[..]
        ret = vfs_llseek(realfile, offset, whence);

Given the custom inode locking around the call, it may be any other
locking is unnecessary and the code happens to be correct despite the
splat.

I think the safest way out with some future-proofing is to in fact *add*
the locking in ovl_llseek() to shut up the assert -- personally I find
it uneasy there is some underlying file obj flying around.

Even if ultimately the assert has to go, the proposed commit message
does not justify it.

