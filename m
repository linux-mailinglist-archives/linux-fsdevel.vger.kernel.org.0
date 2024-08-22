Return-Path: <linux-fsdevel+bounces-26708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB4195B2CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E2C1F22C8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB417E8E2;
	Thu, 22 Aug 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZG528NqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112D364A4;
	Thu, 22 Aug 2024 10:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322110; cv=none; b=lxMXz1n6PGfkT5/r+sRleJaDw2vbQYrXHmaw6vdOCg/faApNVYSON/RbkInw3RdfmC7BOcHHdQ+YQwBjuL4rhyhrrm+f9ewWvO7eux+uWIwyPtN/ErZK9HvVRIeOv9e9YQjfeJA80XopRsWyew3oMFiG3Vf+pjG8PdKhCZQBOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322110; c=relaxed/simple;
	bh=UvnmyoORO8Qlvqn0VCeIiPZzTWkIxDwy8sX3YeOfxNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajW79nZ5fBlhn6LIMrDB9s1Mea7BHx/qCyAVc6ybd7nWJRdujuK7BHMsc82SUPCR/k90Ar9Z1J0CkTx1WuneCMiiesUNLwldiwDrMtkHx4/az78QNTbWwhp5OJnxmaQ+FrYn/XaSJjzG43ezA0Qaqgg1JNYvTu1w+p+3ja6Ghnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZG528NqD; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bed68129a7so942769a12.2;
        Thu, 22 Aug 2024 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724322107; x=1724926907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4HpUPm5maP5njGxqT2EPfesiPfuO4nNvXVn6FksK0GY=;
        b=ZG528NqDfL7JotubUSlkH2oR4mJ2IXf/ldBma/cpeIi+iklvhspNxb8GOxyG0PSW6V
         kCQTXTdzVyzaBQvyDa6Dyt0KZrWtVg6DoUgeQUJP11L/U3cjiRnJ4zfhCOw+yuBDkAk7
         FvNBomspLgbRGxvwYcEU4PVVBzjpgb3uinhbld6URaAKiyr6km5YgpmcDqKJ3pRlXVBD
         +efy6pCBHI73OvY1TKy9h/utXD1jnKoPM3QPO47VpUaErmhQyf+3KuHLLfzeqpXXU3xJ
         2ez5i9yNQ4FQfx6Or+QLJd3lrcssfquG/cxi6QGK8eSHsv5cxc0YuzfUjKKfozGAa/c9
         OosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724322107; x=1724926907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HpUPm5maP5njGxqT2EPfesiPfuO4nNvXVn6FksK0GY=;
        b=SMstXkZeCO8HzO9sfvxFEofXeL2zix0nXbJMhEJQVo8GhXGUMU215GV+ZvegqATct5
         0UBFDLd0c9q3OudAuyCsGSjdcH5GHSoQVfynrWeYmSRaoFhLJCPsbk86L0h3E/0Ltm7t
         +lF7Pah83J89586WJ1Gfb9UY9+EmkMP5DV0c83N9M5ptmwYtUmHGPuICQ1OeSPWrJ+6w
         eodvjy5CnaelN7MIX7bncpTQNlpUtdxJCrVOo2Or+176Eqk+9/BzkgmTnoql96w1h5gr
         hxLn6jwg6XLSPH6RTGUB3l96oEV6YBEdIGVNo7YBn2/mMKOTDKcf0RF+t1zvtHKMb2XB
         klxg==
X-Forwarded-Encrypted: i=1; AJvYcCUKEXbuPjO3ITeSyQoxzopG/zSUECPiMs9AVNQUKAyBe9JRbbN46ahryBTVVXxEOZ47b4MJI5qwr7AGzTEP@vger.kernel.org, AJvYcCW46gh0xmLP8xk6x/KYSQWM4S6697RHkzVQIahQByeBS1rAOLTyCLJaGDVRfaBgJqNSHA/3F38l49RwAv2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Ygb3BfchrnRt8QBNSzkQCtj1lEB5mMvaln5p3qdQmTTDnMvZ
	gS6W0DhyuCTtMrxVcYWapYfgif+A40vH94kmCkYM7AN/CEmr6D9CpwxHVw==
X-Google-Smtp-Source: AGHT+IH7cxLf7SLbT+duZmRQ8/OxZhpJzcy4IUnNX0FVEwpl6kAbYyUk2yogRoHtbNd15kJmyRa7YQ==
X-Received: by 2002:a05:6402:4308:b0:5be:fc2e:b7d4 with SMTP id 4fb4d7f45d1cf-5c0791ebb13mr928332a12.13.1724322107097;
        Thu, 22 Aug 2024 03:21:47 -0700 (PDT)
Received: from f (cst-prg-86-203.cust.vodafone.cz. [46.135.86.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddbee6sm773164a12.9.2024.08.22.03.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:21:46 -0700 (PDT)
Date: Thu, 22 Aug 2024 12:21:39 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] avoid extra path_get/path_put cycle in path_openat()
Message-ID: <o2uu6mzozjaruja5udzfnv2p5fwfoeud5movtve7gyuj57xlz3@aqy6sil3o2ze>
References: <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
 <20240807124348.GY5334@ZenIV>
 <20240807203814.GA5334@ZenIV>
 <CAGudoHHF-j5kLQpbkaFUUJYLKZiMcUUOFMW1sRtx9Y=O9WC4qw@mail.gmail.com>
 <20240822003359.GO504335@ZenIV>
 <20240822004149.GR504335@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822004149.GR504335@ZenIV>

On Thu, Aug 22, 2024 at 01:41:49AM +0100, Al Viro wrote:
> Once we'd opened the file, nd->path and file->f_path have the
> same contents.  Rather than having both pinned and nd->path
> dropped by terminate_walk(), let's have them share the
> references from the moment when FMODE_OPENED is set and
> clear nd->path just before the terminate_walk() in such case.
> 
> To do that, we
> 	* add a variant of vfs_open() that does *not* do conditional
> path_get() (vfs_open_borrow()); use it in do_open().
> 	* don't grab f->f_path.mnt in finish_open() - only
> f->f_path.dentry.  Have atomic_open() drop the child dentry
> in FMODE_OPENED case and return f->path.dentry without grabbing it.
> 	* adjust vfs_tmpfile() for finish_open() change (it
> is called from ->tmpfile() instances).
> 	* make do_o_path() use vfs_open_borrow(), collapse path_put()
> there with the conditional path_get() we would've get in vfs_open().
> 	* in FMODE_OPENED case clear nd->path before calling
> terminate_walk().
> 
> diff --git a/fs/open.c b/fs/open.c
> index 0ec2e9a33856..f9988427fb97 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1046,7 +1046,7 @@ int finish_open(struct file *file, struct dentry *dentry,
>  	file->f_path.dentry = dentry;
>  	err = do_dentry_open(file, open);
>  	if (file->f_mode & FMODE_OPENED)
> -		path_get(&file->f_path);
> +		dget(&file->f_path.dentry);
>  	return err;
>  }

There are numerous consumers of finish_open(), I don't see how they got
adjusted to cope with this (or why they would not need adjustment).

For example fuse_create_open().

If this is sorted out I would argue it needs to be explained in the
commit message.

fwiw I don't think patching up the convention of finish_open() is needed
for avoiding the extra ref cycle to work.

