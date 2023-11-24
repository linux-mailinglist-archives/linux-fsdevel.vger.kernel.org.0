Return-Path: <linux-fsdevel+bounces-3783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12017F856C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 22:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE1CB228F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 21:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930EB3BB28;
	Fri, 24 Nov 2023 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SH51FT7E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411F19A6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:38 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-548d60a4d60so3117743a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700860957; x=1701465757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=apBows719Ql6+y2BcpLIbVUnN8kkKRkZuJ5YeukjHu4=;
        b=SH51FT7Ew+d98DyAlBHAA5qXQhUL6YaR5qhhTrR45XMN/ZzDLwzlz2jb94PanQ6S5s
         MYctfLQnjyVSWdSer2cjH8nUQLLWB+Ez4lWt+RygNRFf8zDN+fE/kN3bryaLq0OTz9e4
         p/+NZZhwRcvN3Iivq1MCNJ6OmSKRTL3iulN4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700860957; x=1701465757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apBows719Ql6+y2BcpLIbVUnN8kkKRkZuJ5YeukjHu4=;
        b=auK7kLD3ml6I/vKsv25j1kBZFbfE9adFiqnfgrKjN+vWrXPGj2K4dR4vL4hmSzN5cC
         cCYpv0FYArseavQVTXCtx/OuUnd4c9ELs6yq3+YQkPLchZ++fDzFoOlcAKATrbGtUF3Q
         qB9rndUvpISeJj7oVkirvnY/ZxB0QJsu6WhN8ClkSVQMvktl27oCY428qcwxKmd7KkXa
         8CSn9umepNHbwilvW8vMQN9IjrPFAjSeg4ZjI4yWYogwcXatjhYqxKjEjHXR/JHNrdaW
         IveoKdmJbfTXc3m/CEx4XlkpENXPgb1asQg7EqUQ9wDFYT7lCw9SSIlNdk5Ggj79JLdS
         Ek0w==
X-Gm-Message-State: AOJu0YwOdYmpp4tRLydQ2bmkFh+BoTPAGe0iW0vgxUNI7TB0+PB7Ekxu
	frNkKS2UW0gDn7nB/EBxB0iNFRCbws/ih81pUAq84KDP
X-Google-Smtp-Source: AGHT+IHNohbiX3aC4ZpddJrCHFPVuc/V9BwTKW+m9j4ewSBfB/asz3aqpbx0ESpE2OtrpCDDFl4zVw==
X-Received: by 2002:a17:906:7aca:b0:a02:885e:6065 with SMTP id k10-20020a1709067aca00b00a02885e6065mr3168541ejo.72.1700860957331;
        Fri, 24 Nov 2023 13:22:37 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id i22-20020a170906445600b009f9f5a6d3cdsm2534027ejp.101.2023.11.24.13.22.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 13:22:36 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-548d60a4d60so3117732a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 13:22:36 -0800 (PST)
X-Received: by 2002:a50:d715:0:b0:548:564d:959a with SMTP id
 t21-20020a50d715000000b00548564d959amr2756303edi.3.1700860956448; Fri, 24 Nov
 2023 13:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124060200.GR38156@ZenIV> <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20231124060422.576198-2-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Nov 2023 13:22:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
Message-ID: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/21] coda_flag_children(): cope with dentries turning negative
To: Al Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Nov 2023 at 22:04, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ->d_lock on parent does not stabilize ->d_inode of child.
> We don't do much with that inode in there, but we need
> at least to avoid struct inode getting freed under us...

Gaah. We've gone back and forth on this. Being non-preemptible is
already equivalent to rcu read locking.

From Documentation/RCU/rcu_dereference.rst:

                            With the new consolidated
        RCU flavors, an RCU read-side critical section is entered
        using rcu_read_lock(), anything that disables bottom halves,
        anything that disables interrupts, or anything that disables
        preemption.

so I actually think the coda code is already mostly fine, because that
parent spin_lock may not stabilize d_child per se, but it *does* imply
a RCU read lock.

So I think you should drop the rcu_read_lock/rcu_read_unlock from that patch.

But that

                struct inode *inode = d_inode_rcu(de);

conversion is required to get a stable inode pointer.

So half of this patch is unnecessary.

Adding Paul to the cc just to verify that the docs are up-to-date and
that we're still good here.

Because we've gone back-and-forth on the "spinlocks are an implied RCU
read-side critical section" a couple of times.

                  Linus

