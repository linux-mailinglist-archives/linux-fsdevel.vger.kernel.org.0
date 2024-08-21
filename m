Return-Path: <linux-fsdevel+bounces-26519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0B95A485
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 20:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428081F22EAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ED21B3B1C;
	Wed, 21 Aug 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="TRAyrW9M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53591494D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 18:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263894; cv=none; b=CRY92kUsTBk1xBJCbQrUE6EYJt6COLdpl4BKetU0qRvL6VDGa93NE7tcd2wvgTeFefilSU8thBnYdtMK1s5xv4IiJfFUcr/K5ZjJvnUb8XSyqazAMkxRNEKVHcepPCZ0pRqp9+LuIiHBStdWkAecl8WyRjhCVwHOrRhi79wg7ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263894; c=relaxed/simple;
	bh=yJEteDsMM+voKrwUxMqU2AE9Ubj4LBVFVPCvRQ7sgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKg1z81WJmlQkJ2KaCfZIuW6OtZ1VU7xNAe57F5d76k6XqSjaFOaUEamnijSznxzEwfFfKLzWExOQozuRyhGFilGyjcEbcWCk4CzDlqpO+s9juQyVvnaGdsnICLsS+eF+X9ezxzadT7JhKec/XiZ4Bpw5IHQv3IR7sa/G7Jvp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=TRAyrW9M; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e13d5cbc067so8044276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724263892; x=1724868692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RiqrmtfuIaOxdt56FCG41tiSebEuMmIEKQ9ySgCCVLw=;
        b=TRAyrW9MjqXTxA0oqUIH8bpLujPduM/HVdvrqVZWlWQ7VrT9QkfGVNk9AWRJ9yy2NQ
         EhBljNOkum/M0aQJCc1JhgNC5ppBE1Skm6o46WRFY+2kWtfDvQ0ialaR8WM7bvAhTjp7
         Py8dSlPZk/j/49UidwEnc4In61HUOFn69lhpcrsYErUbX14kyy32SnO6SP1lLDqTpR3N
         zhM3/fpuOMQ9YPAbyellgXYXZwZq6y/Obluvm2Lk4N5r4NQnbx27CqAk2ZTxMW35B5BG
         ESDjR34SbstAoombp0YtXBnUbq6joizSTMN6/GcZ3hiE19rek1C0BsoQT2qtBgwwfU7T
         Y19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724263892; x=1724868692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiqrmtfuIaOxdt56FCG41tiSebEuMmIEKQ9ySgCCVLw=;
        b=eEXZQ1ZBS4PygJJOJ3DZ38rXxKFz9Xs4vDWyTP89NMtw2Ui6kcfDD84Qn9rTtVR444
         TxrVp3k3MR181yZDwmyYtSC+BhQ+If9jn1YB2/VWjZJwul+lmSL/PpOFOlAw2olYAsMk
         KB543CtPkETyCBESkSGSJhU6vyOnEPTkHezdjySJ6Y/y/ULyRMEcU+8Q/ZwwVzEIZbNu
         hsf+CzwfaV74LTlzP5TS1dxnJPofZma5mqSCTSndzircVWuG2JonbjKAfzX0TNGTGye3
         D5M07qK8oEglzE9CtkgETUqTvWbIn90JHLT9Fy4WF13VoyLWHqfgNMLsEi62ookm06Uf
         JvQw==
X-Forwarded-Encrypted: i=1; AJvYcCVywRTSG/tcNB4IND0+2udYInaQHr7pD0oLTr80vQrQsiu8cCrTNxvf1AFK+C3cIv2TraHrg6Bt5mxmh4VH@vger.kernel.org
X-Gm-Message-State: AOJu0YymjSE3m2QrTVrYxpNWcvixLSyVuFy6nrfdv+59DnGY5Ffqwk5i
	rAupQ/lyjNHy3JhjBbv8+c4Wz8nDSV9QzBtxa4wCwOfjN87zqG1Xbd9BRQFbUbA=
X-Google-Smtp-Source: AGHT+IF+/4jjLp7bPSpFd1CSmXzo+LD3YDQu6pc8jlWUGc+jtNeRehZ+1Mams7Xkcu4mVqW8snpuVA==
X-Received: by 2002:a05:6902:2b09:b0:e03:5bca:aee6 with SMTP id 3f1490d57ef6-e166555539emr3947110276.54.1724263891886;
        Wed, 21 Aug 2024 11:11:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e165200058bsm789189276.61.2024.08.21.11.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 11:11:31 -0700 (PDT)
Date: Wed, 21 Aug 2024 14:11:30 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH v4 0/2] fuse: add timeout option for requests
Message-ID: <20240821181130.GG1998418@perftesting>
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvPMEsHFUCzV6rZ9C3hE7zyhMmCnhO6bUZk7BtG8Jt70w@mail.gmail.com>

On Wed, Aug 21, 2024 at 03:47:53PM +0200, Miklos Szeredi wrote:
> On Wed, 14 Aug 2024 at 01:23, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > There are situations where fuse servers can become unresponsive or take
> > too long to reply to a request. Currently there is no upper bound on
> > how long a request may take, which may be frustrating to users who get
> > stuck waiting for a request to complete.
> >
> > This patchset adds a timeout option for requests and two dynamically
> > configurable fuse sysctls "default_request_timeout" and "max_request_timeout"
> > for controlling/enforcing timeout behavior system-wide.
> >
> > Existing fuse servers will not be affected unless they explicitly opt into the
> > timeout.
> 
> I sort of understand the motivation, but do not clearly see why this
> is required.
> 
> A well written server will be able to do request timeouts properly,
> without the kernel having to cut off requests mid flight without the
> knowledge of the server.  The latter could even be dangerous because
> locking guarantees previously provided by the kernel do not apply
> anymore.
> 
> Can you please explain why this needs to be done by the client
> (kernel) instead of the server (userspace)?
> 

"A well written server" is the key part here ;).  In our case we had a "well
written server" that ended up having a deadlock and we had to run around with a
drgn script to find those hung mounts and kill them manually.  The usecase here
is specifically for bugs in the FUSE server to allow us to cleanup automatically
with EIO's rather than a drgn script to figure out if the mount is hung.

It also gives us the opportunity to do the things that Bernd points out,
specifically remove the double buffering downside as we can trust that
eventually writeback will either succeed or timeout.  Thanks,

Josef

