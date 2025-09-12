Return-Path: <linux-fsdevel+bounces-61134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A230DB556DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 21:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60161CC85F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1437A311C20;
	Fri, 12 Sep 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g/kEvaEL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1A381749
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757704940; cv=none; b=Mpjov8aUKbVsAAAC4h65J74ByQgvA4Y4SuhK837g3VXgm5qo5MP2Q7+sw2z8CEyMhOE/R7slGqGiV/A/lGjGAXMB+3tRXPT4SoRr1wigtq4idhi/GincIedw5PUYs6eiWmrfs8BX3M30i6j/eelIXlbfyIgqFGiqu/n23MYdMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757704940; c=relaxed/simple;
	bh=5mz/fU5lr0X9jn0qyDDWC9iwG9+PxpArGruS0V/kp6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e6VtGP4C4g6AMfMIE8/vEmuLWg8+L2KfvoBXfsJXRAk+k2jW+3/yNOH7lrRjaFJMWDaG/44/p4J6jql3AOMN6aqIq7u0Bd5G3glD46XuUmtgvgI44kYr7RDmYOmrcfhWd4zoMKeyiZTdXdNqaaCH7V/DxLpXcwct/jOpg7IPjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=g/kEvaEL; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b34a3a6f64so21864701cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757704937; x=1758309737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gp5KSq2erxSvj5sGuv5sUG9ae7karVK5nVWhZkwyYI=;
        b=g/kEvaEL4g7pamos1jp6vmkzyYzPWJoik0fgXgQ+i8bu38HKRrUlbcjGLa/jhZoL0U
         McOvUJ8uSWAxuPjrwjPvMJAq62qU50Zq4i9a0yk2MZZUi9KS4Tk04sS9txBCUXu5RSE9
         +jIa4t7ukIVMI2ifrRUahtrQlWd2iJI6ntuJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757704937; x=1758309737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Gp5KSq2erxSvj5sGuv5sUG9ae7karVK5nVWhZkwyYI=;
        b=TjiOiQMLJaTezNNqGPuZZoR/g3oL/2gSGwP9u3IbN5HGsWfzXOlvDMU6wPASZPIH9A
         qj18QBxIHsuFeVR1y7+xDxxTSL/Sbj5sLX9OprWsEtiK7pPAXHzcdh9jAnO2GT/EsvhW
         Es2cp7fGufeYZbtKsRsIXyJ7iOeQ8xWZ5danYhoopISEvHdtu6EOjHiotoRng+7tBu6+
         7dwaCXf+yMVQYqYmuKjYKYtjiRbWJV/0ZAoxzQPOH4GHF/m+xJXshfuxpWC72uM8uztr
         pjr1dlt/GeKGI70X4BZQ5dm5wrgvGwAr9G/RA9CmgvbTTRNUtdudsjv0ZV9bYbbjk7Ww
         m3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCX7+RZbCq9+1ifM2Gf3P5ZdGwH2rj5dKSPUIePo7Y/uzwLI3tX8ND0FZCQGKmRv8BoSMhs27Udlt8wDgDgc@vger.kernel.org
X-Gm-Message-State: AOJu0YyiKX/P9Nnjie7L5SA5i6/ej02Q2uucVoHwbm2UsrszeVVLMIc7
	mp1iAurzCrDsPlr+W4BAy6ZTEA6AzyQBSi0gSF7yYQ5vB2DlraZMHVpVslam711BUYqeGFo02yV
	dL/AwYCxcUePSY/vaJI+Y9Tv1caNyvkS7vmyuvBHfqQ==
X-Gm-Gg: ASbGncuqVfkThdKlFfZtp+7nYsrCN3PppsvvTNR3+zgYOScRqiR7JBbm/fcjDhrmkBM
	+oH/fUTfwEzqQpthsF7omqyrKLxe/qJLiY/VVnxh5/Etdx+DN0HKHL/pUklbqXoR5okM0udsQKh
	CRjh1HMdzrTUIAUI9d+dS5jqTCEBCR1NLP+xUQOlKayXisSgRxC6umFohSzM+2PoDzUunzCdQUm
	azYAmgGU8spLfRa6RZCZ7WA7beUOryu96BFrWef1aLt51PMUxHP
X-Google-Smtp-Source: AGHT+IEEP+4Zykgq1KkH/odIOx1tb9avqPUUzvtOoN3AIcogsD5UOFseV+lwQiCVR/PZ+d9eBQKwAyS9L2lN5EJokog=
X-Received: by 2002:a05:622a:28d:b0:4b4:56a6:42b5 with SMTP id
 d75a77b69052e-4b77d12b5demr53054611cf.41.1757704936607; Fri, 12 Sep 2025
 12:22:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908090557.GJ31600@ZenIV> <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV> <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com> <20250912182936.GY39973@ZenIV>
In-Reply-To: <20250912182936.GY39973@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Sep 2025 21:22:05 +0200
X-Gm-Features: Ac12FXwLTRnJNNnkNdDvb7pR9lRaxQuiGpLDwEf4711m58FCxGGfEWWCcJrajt4
Message-ID: <CAJfpegtesk1G-hvcUvVqjH0_gN+YCRXvLHf=H7SORdrNUOnEsQ@mail.gmail.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 20:29, Al Viro <viro@zeniv.linux.org.uk> wrote:

> > Based on (flags & LOOKUP_OPEN) ->revalidate() needs to tell the caller
> > that it's expecting the subsequent ->atomic_open() call to do the
> > actual revalidation.  The proposed interface for that was to add a
> > D_REVALIDATE_ATOMIC =  2 constant to use as a return value in this
> > case.
>
>         Umm...  Unless I'm misunderstanding you, that *would* change the
> calling conventions - dentry could bloody well be positive, couldn't it?
> And that changes quite a bit - without O_CREAT in flags you could get
> parent locked only shared and pass a positive hashed dentry attached
> to a directory inode to ->atomic_open().  The thing is, in that case it
> can be moved by d_splice_alias()...

You are talking about the disconnected directory case?  That can't
happen in this call path, since it's following a normal component from
a parent directory, which by definition isn't disconnected.

Just realized, that open_last_lookups() will bypass lookup_open() on
cached positive anyway, so really no point in handing that  inside
lookup_open().

Should this be done via a new  i_op->reval_open() called without inode
lock, with a positive dentry and gets a name just like d_revalidate?

Thanks,
Miklos

