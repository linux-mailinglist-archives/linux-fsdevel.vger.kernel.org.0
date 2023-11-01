Return-Path: <linux-fsdevel+bounces-1770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5A7DE814
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 23:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7054B210FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C565D1C29B;
	Wed,  1 Nov 2023 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b95d8tEQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D40018E06
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 22:24:30 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78720121
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 15:24:26 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so425188a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698877464; x=1699482264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mox8X1H7M1pwsHX7MvCw8LITDXcjbr+sDfYdWZtZU/s=;
        b=b95d8tEQOD8bf87oSpgkmtiY1QKtGzQy7y88A49X8h1yUXcnudbhU60Nnyq/FTrKb1
         i3toDKaQDc/kgmUqsTMm1aJPTu0lSYcXX+NKQmpxKmYAFMhO6oKUm3p9XeLOJDCR4RN6
         YX1BwRkcFoxYxV33fjqy8tD8wpPrmj1L20ShI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698877464; x=1699482264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mox8X1H7M1pwsHX7MvCw8LITDXcjbr+sDfYdWZtZU/s=;
        b=MXfrstvANRS+510XzhOsddEJiCXwaMwYSG953eIBHsoZVFj6DieIPGgzaoL8R79BRt
         0opF2KbVZ4my4JjX2MzPMilAs6NwysW5dPGUa2dY3Qx0MGXbYGaODYELmtIipcNd5esr
         MQWOuO6udoadL6br6oY9EF3NryX8/cO9KZlutouIzkHg7tH6OlmcSInmu8+LquFFdQeO
         N/V22JTiCBPtG4c1ug+zEaz9urcN7vZ5qp1rviStGIkw1EZY7/pJL3jIty4EGT7NUPDJ
         4mXJnA2w3HcLBc0HCk8TmS1kkUR33hUuHOn9g17gL/1vXxG+pKWGFJgrkOT5ilLmDK4l
         Luew==
X-Gm-Message-State: AOJu0YxyDQ+6Yl3PcdohNnQM+rPHmow6FFwCHgX1Rsjyl3pBd+S+b8wv
	unZsZpe3MXVq4b/IdFa39N5xO0ows9tDZaK3nJ6q5a06
X-Google-Smtp-Source: AGHT+IEm26miSF2g6gFJyMDd9hMePBsDKhO2Xix/COeGlruGnfRoQTLhXsnnBMN3tq+CfNOuNbM+MA==
X-Received: by 2002:a05:6402:70b:b0:53d:f072:7b0a with SMTP id w11-20020a056402070b00b0053df0727b0amr13044909edx.39.1698877464747;
        Wed, 01 Nov 2023 15:24:24 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402001100b0053e625da9absm1540419edu.41.2023.11.01.15.24.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 15:24:24 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-32ded3eb835so162553f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 15:24:23 -0700 (PDT)
X-Received: by 2002:a17:906:ee8b:b0:9be:263b:e31e with SMTP id
 wt11-20020a170906ee8b00b009be263be31emr2561024ejb.33.1698877442973; Wed, 01
 Nov 2023 15:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTjMRRqmlJ+fTys2@dread.disaster.area> <2ef9ac6180e47bc9cc8edef20648a000367c4ed2.camel@kernel.org>
 <ZTnNCytHLGoJY9ds@dread.disaster.area> <6df5ea54463526a3d898ed2bd8a005166caa9381.camel@kernel.org>
 <ZUAwFkAizH1PrIZp@dread.disaster.area> <CAHk-=wg4jyTxO8WWUc1quqSETGaVsPHh8UeFUROYNwU-fEbkJg@mail.gmail.com>
 <ZUBbj8XsA6uW8ZDK@dread.disaster.area> <CAOQ4uxgSRw26J+MPK-zhysZX9wBkXFRNx+n1bwnQwykCJ1=F4Q@mail.gmail.com>
 <3d6a4c21626e6bbb86761a6d39e0fafaf30a4a4d.camel@kernel.org>
 <ZUF4NTxQXpkJADxf@dread.disaster.area> <20231101101648.zjloqo5su6bbxzff@quack3>
 <CAHk-=wj6wy6tNUQm6EtgxfE_J229y1DthpCguqQfTej71yiJXw@mail.gmail.com> <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
In-Reply-To: <3ae88800184f03b152aba6e4a95ebf26e854dd63.camel@hammerspace.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Nov 2023 12:23:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
Message-ID: <CAHk-=wi+cVOE3VmJzN3C6TFepszCkrXeAFJY6b7bK=vV493rzQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	John Stultz <jstultz@google.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, 
	Hugh Dickins <hughd@google.com>, linux-xfs <linux-xfs@vger.kernel.org>, 
	Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, dsterba@suse.com, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Linux-MM <linux-mm@kvack.org>, 
	"open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ext4 Developers List <linux-ext4@vger.kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-btrfs <linux-btrfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 1, 2023, 11:35 Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> My client writes to the file and immediately reads the ctime. A 3rd
> party client then writes immediately after my ctime read.
> A reboot occurs (maybe minutes later), then I re-read the ctime, and
> get the same value as before the 3rd party write.
>
> Yes, most of the time that is better than the naked ctime, but not
> across a reboot.

Ahh, I knew I was missing something.

But I think it's fixable, with an additional rule:

 - when generating STATX_CHANGE_COOKIE, if the ctime matches the
current time and the ctime counter is zero, set the ctime counter to
1.

That means that you will have *spurious* cache invalidations of such
cached data after a reboot, but only for reads that happened right
after the file was written.

Now, it's obviously not unheard of to finish writing a file, and then
immediately reading the results again.

But at least those caches should be somewhat limited (and the problem
then only happens when the nfs server is rebooted).

I *assume* that the whole thundering herd issue with lots of clients
tends to be for stable files, not files that were just written and
then immediately cached?

I dunno. I'm sure there's still some thinko here.

             Linus

