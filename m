Return-Path: <linux-fsdevel+bounces-46091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B822A826FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846A91B6878C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE135266B5D;
	Wed,  9 Apr 2025 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JY6X6USE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D726562C;
	Wed,  9 Apr 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744207364; cv=none; b=T0mDV59EQOChbTtaFZpyxJ//7K1Ucj88+yJoIhwoFLFsbecJ9h8wYZntYd+iHQKjzWyehrIlBzt6YWTdq8scvEdWcshXJ7f4oYl5E+tshmUhRRpYb3V0Kdp2ihnhOvwANMRLOIVcbeb1uNMgryzAt5Ap9XlEog66U//o0PGzgfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744207364; c=relaxed/simple;
	bh=JRIrYSvIxXTm+pb4gvvJehPRD2NURTieCgUGjektsv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+jUNuI66hdaVmikVwGG1fJTECL5p3w8x1PXbA8MtmLoqeJ8l0ejYEwrAhkFUMVDfiENAg+7Lgb8gWD4gmKLXG+y0qe9VzwgCeD4MJY46ec1x3zoJydsRxMF2L8z6lYjOp++3GoHM/Frf1s8BFGM0oNt6ZpzoQfwwO7dVGL7LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JY6X6USE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso529459f8f.1;
        Wed, 09 Apr 2025 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744207361; x=1744812161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eWkSRo+s8E+NVFcYoRe4I5C9QjyjskzPyPuoXhbSgfo=;
        b=JY6X6USEY0XKjx3OW4AfLZjBEOzCd/n+PEAKVFHap7tvSigMXhG6F9KmLg0+EFnLil
         WmoFlKwRg2r3PYGD3RzcOTkG5A3BqdOTMQLVvNcKS0sCewYnWviOQgMxFPv75wRnQiYj
         Fa4LDcUB4rzdUoPygfMBxrkHyRqVz5sOsluCgohI8wj0HXeWxBQXQyw7uuclXsbZK21D
         TjUVqeg1tJXem+lh39MyS0JBnoD/oktruzMOMxKIKu1bxu9QUbTBA6IJ8qYVbJAFJ4bz
         xLfHaQYWy9PUVXUDDh63Lrtk39NZas9LK+KGOEqaO6rztFcL6GL8o4rDSTuHeq40O2wl
         68Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744207361; x=1744812161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWkSRo+s8E+NVFcYoRe4I5C9QjyjskzPyPuoXhbSgfo=;
        b=SxJVflZ+8tRmkFa9SqAHuFIwRRJbzXFHTW0mMs2rIA2veginRNp9Fl60vifKPv3uhd
         6Q86eX/fxSPj4xgTaeESaD36qfeAtnvOxRbJoW3DtNe6jgAaLEOY4JwIIoddVjUaDJSy
         nPBPO810gk8ms8TPMkt2OXhXYKswcgM5d11lJaSZhpfVmh8HLV6rbYnhmUccOlKeYN6H
         50ShDp+64VcGBWm2IU6qNi1wWCLwsHOG19wXeDtDIkXrtgboC7HSKlRoElIvHFbSk5kk
         grl4RVNClR/Gqz0oC85d8sSUU/l210l34LIUsjw4HXFZIJXXO4VdvVAIoL/mVblRGfay
         6qeg==
X-Forwarded-Encrypted: i=1; AJvYcCUZmZeHoPb/0mqpeId4HLqds894BXRY+uN7KUX4nKCVqIg4dZw15NcaWn8h1Nw/uZvKOVgzrY+MKjdSiy81@vger.kernel.org, AJvYcCW56Y/Tp16em9LvIa7yUwvhTS+Uwl9CUle+88YsRBmUGNIe2uP19NHRviiHsam/r8/DQj77kq8SwLjTj1SK@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNYUE9MWzKmiD58eNKnTiw1xobeVbvKDUiMoxPbsUD43Ogh0Q
	xjGgBY+cJk5IYB8DyYfcBlJ7l2boep0CQMLIZJCgZXFiuvKHPI7h
X-Gm-Gg: ASbGncs2EXnNduJld0g9q+YHRxdgjiZg4wWNzI7qBIbOqs54NSJh5xIMRhRAz8BqIeN
	3vBal0pFk1eXE3xInDtZohi2n6uGurEfvAgbds44AUc46JTtFCjm8Dd3V0LiQpYji4wgFFBbqC1
	racQpjCvC9VV/Zfa9hRNLatCeenRZu33+vK+lZkeKbkMrfvgnO3beOymKF6GN0KZp0MZoy5ISaM
	Ys4td/R/gzCWsHZRtLkI9G4VuC0GzgVvEL8tKlkF5NdiqkTDmEI6cfAXo3vhUOYBsoGduTw+El3
	R7dU8fCHGXYe4X4/sGQcOqHPUfee3TzpiZ36Z+9e2IYIK++DL6t6LL6C
X-Google-Smtp-Source: AGHT+IF049ubS5HdXQTc8n0xRJ+vhzdOB+ReFA0a6AeS7aGfjHRQyQyoNcgumkbEH6FOJaXvkv0ctw==
X-Received: by 2002:a05:6000:22c7:b0:39b:fa24:9523 with SMTP id ffacd0b85a97d-39d820acaf4mr6568070f8f.7.1744207359981;
        Wed, 09 Apr 2025 07:02:39 -0700 (PDT)
Received: from f (cst-prg-17-207.cust.vodafone.cz. [46.135.17.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ecb8dsm21327535e9.7.2025.04.09.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:02:39 -0700 (PDT)
Date: Wed, 9 Apr 2025 16:02:29 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Eric Chanudet <echanude@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <4qyflnhrml2gvnvtguj5ee7ewrz3ejhgdb2lfihifzjscc5orh@6ah6qxppgk5n>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
 <20250409131444.9K2lwziT@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409131444.9K2lwziT@linutronix.de>

On Wed, Apr 09, 2025 at 03:14:44PM +0200, Sebastian Andrzej Siewior wrote:
> One question: Do we need this lazy/ MNT_DETACH case? Couldn't we handle
> them all via queue_rcu_work()?
> If so, couldn't we have make deferred_free_mounts global and have two
> release_list, say release_list and release_list_next_gp? The first one
> will be used if queue_rcu_work() returns true, otherwise the second.
> Then once defer_free_mounts() is done and release_list_next_gp not
> empty, it would move release_list_next_gp -> release_list and invoke
> queue_rcu_work().
> This would avoid the kmalloc, synchronize_rcu_expedited() and the
> special-sauce.
> 

To my understanding it was preferred for non-lazy unmount consumers to
wait until the mntput before returning.

That aside if I understood your approach it would de facto serialize all
of these?

As in with the posted patches you can have different worker threads
progress in parallel as they all get a private list to iterate.

With your proposal only one can do any work.

One has to assume with sufficient mount/unmount traffic this can
eventually get into trouble.

