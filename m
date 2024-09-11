Return-Path: <linux-fsdevel+bounces-29089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A1974FF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6061C21623
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 10:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694E185954;
	Wed, 11 Sep 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjztIhMr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9559739AEB;
	Wed, 11 Sep 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051378; cv=none; b=BknYNJX3nrKddhyDvE3Xx2LTvs/S9IWaIgOlMLwmYjDdoH4sNkqropHa3ge4PFvxx8mYV28iGnAjIPlAP1dJF9En+GIxnxCHFwrtW1sQfz6tYc4W4uNnznIosdj4taFT6cfVAwX0X9x2i3/oEP4RX9FOKFuGBRs3u5Zn6ylZ8YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051378; c=relaxed/simple;
	bh=UjIF5kbrTpIkipAPLTaQ/D0JgJk9S2ZmSMnNGGdDz7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIKzm0vBZP29pnIIrgNuG8kanzwQOqGgPUzdaO/qEtsXltU5U+om7P05VMSGoc13XYr2n6ncjdYKhAaiOc4rn6IV9DG+beZaCP0fMEGnnwQE6rWqDjCATGtVx5vQNu8ERAai/bxevv+1KHUxEAy7axGRJJfUgvJQSDtM9WDXexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjztIhMr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d4093722bso131941666b.0;
        Wed, 11 Sep 2024 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726051375; x=1726656175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=owyJGSNE8ueeogLMpp+B8Z5kapnH06E8CRnXynJs/Yc=;
        b=gjztIhMrXyuBkV1MYbVrvHCO0Q8WP03vnaYAq2mulePowv40GPuxh4VW935BE8S922
         aDaEuhPT43qPpUmTRfq2Po4AlvOIaGbdaeBZOQWOw0mU3u6yvPYtU7JyOrpKxIvqpIxW
         MrbYTHgr5C+zZilToneYa1eVXYS+TIrMiAJ3oZJVWBmaoxIIVSnkLckUstOfR7rtGxRk
         Mrl2wh5qbwO9monGseT0wIb05ZOdWkdvqJe6rd8QM9J2Nr2vTNr5TAm0sZbrBoq7ap1x
         i4VwzakzSjZzr2dwejkVHoX0Vho35APSmNDBoH3+TLb+zB+DhTZPcGVhcfcTRQod08js
         DivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726051375; x=1726656175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owyJGSNE8ueeogLMpp+B8Z5kapnH06E8CRnXynJs/Yc=;
        b=mB0axKqw7rN1uWvytLDaAyGLBQ4ZozwajlBCpzQ9jGMg78bsHQzmw+Anm+sVN9eh/o
         U27U1KlTNUCgvbq7rM7xZEXg323FgfcB5aJh4RR40aLBij3TCZPXP9TQdauzWpZiyUv+
         rqMcr/g5k0KL0SrxikiF8MRFf/4qlHKxBThzGn+BWNtntY+QRH3zAB9LLx6ohjLmiTPx
         G/R4pMzBql8J7W+Hy5lR+5GSWtXiU/1KFr3KdKf6qCbY9S8IDEKOmCjyElFRmym++f0v
         JYDMVm8W29GydSwDCUaCoQ1A6EOhtcRL8TPrceF4fJAX88MnYs99MHcKaqxYegFGV1z8
         dBuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoenw0/kV3ZllkoLzCb7RZngIc9flfqpfOR/dXfdSAKRkyZvLylcQAwg4tjZjoYLaDCk0+5LYDApIBVvFd@vger.kernel.org, AJvYcCXzvRGCAYJ7rY5A9sSHJUhPaF6+JFy+09HlSh8dZtpzss0Bi5Ex1H7doq5Z1ET3WSGSKrYntFBDT2zUuSDr@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7Ak5OkXWGyDsRnmXldZieeFuO55SUmYUSGIzfXwNQwjmRXUX
	eXJ4xFLVyI2BANW/6WHpApCoHg7hSMI0Z3GtQk91PhcTlQxHUQo=
X-Google-Smtp-Source: AGHT+IElg5h78Cfh2aXkqKlFxKYtDSKoTr/OaJG21TxQTTN0EvJ+1m0kuWoFnuHqAHS+4026OuFbzQ==
X-Received: by 2002:a17:906:d554:b0:a86:7021:1368 with SMTP id a640c23a62f3a-a8ffab2941fmr361138466b.21.1726051374571;
        Wed, 11 Sep 2024 03:42:54 -0700 (PDT)
Received: from p183 ([46.53.252.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65742sm597215266b.216.2024.09.11.03.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:42:53 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:42:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Laight <David.Laight@aculab.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Message-ID: <f4e215c5-b4d5-4575-8ed5-886bfc8d2dcf@p183>
References: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
 <fd47776572944caf8f720e7d429b5e05@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd47776572944caf8f720e7d429b5e05@AcuMS.aculab.com>

On Mon, Sep 09, 2024 at 03:13:04PM +0000, David Laight wrote:
> From: Alexey Dobriyan
> > Sent: 08 September 2024 10:28
> > 
> > strcpy() will recalculate string length second time which is
> > unnecessary in this case.
> 
> There is also definitely scope for the string being changed.
> Maybe you can prove it doesn't happen?

No, no, no. It is caller's responsibility to make sure the symlink
target stays stable for the duration of the call.

Kernel does it for strncpy_from_user() because userspace, but not here.

> Which also means the code would be better explicitly writing
> the terminating '\0' rather than relying on the one from the
> input buffer.
> 
> 	David
> 
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> >  fs/proc/generic.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -464,9 +464,9 @@ struct proc_dir_entry *proc_symlink(const char *name,
> >  			  (S_IFLNK | S_IRUGO | S_IWUGO | S_IXUGO),1);
> > 
> >  	if (ent) {
> > -		ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
> > +		ent->size = strlen(dest);
> > +		ent->data = kmemdup(dest, ent->size + 1, GFP_KERNEL);
> >  		if (ent->data) {
> > -			strcpy((char*)ent->data,dest);
> >  			ent->proc_iops = &proc_link_inode_operations;
> >  			ent = proc_register(parent, ent);
> >  		} else {

