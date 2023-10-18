Return-Path: <linux-fsdevel+bounces-710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7137CE9FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 23:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3716B281E31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EF1641E;
	Wed, 18 Oct 2023 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XtX7EGTl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B84291E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 21:31:37 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB599B
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:31:35 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso12372751a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697664694; x=1698269494; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ECKpgvAUzJR9x6tmoRvOJm7k5hgaq6eXpehPithmdco=;
        b=XtX7EGTlXzzx2MGJvjlcxeDwBNdOVWRmg5vU9mHbQiktFzfTtVT2L7DYRC3sZESkrl
         vVS+8/fCRyhLOAZV20v/UANQHo5bE40rPsH3+xiTm8hAxHWG40uZhZACpYKYh5+I5wn0
         qmKBA5FIRJMVNdWC0Sg/47IKjUusRIlM8qCbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697664694; x=1698269494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECKpgvAUzJR9x6tmoRvOJm7k5hgaq6eXpehPithmdco=;
        b=nZ7hML2SEsNtzi/N2SJVqt+41tT8nucimvHANvp6WHWJUmCIMIAZzfnhAbJNd7OxI4
         dSdqppi6LHDiCmZxv4igcWKVPkcIb9pRquNDof/+ATWvHRI5MrU91p+2MuafVjTT617r
         7Wlo7R8fV0xSxWLvjusVIQvlb5bNUYaPN/mBd1dxwxj8WBgJg+rOGxfwhOdnMDrxLwsQ
         fv8US0eEYcX8ILgho6lQHCS7T7+Os3Ir1tN4XEr7zmFz68SlUk0G16KDBvLq6fQrlwim
         ck7+EFRSzp3fcpaK2y8JxFvTYzrEW1kYp1Gh2uQmRQTGukItRsHe2Z/H7/dAjklNg1J8
         oSUg==
X-Gm-Message-State: AOJu0YzUF69lVGk9g5nzYzyV9BXfS89ved7r+qwqU4SefLoejB6Yh4IJ
	CdMt7a7kGR1JEeYhNIM6AHl4p0oIjYTzRoLg0CSjs12q
X-Google-Smtp-Source: AGHT+IGavJiXx+E6cGQy5elb9Y+/3j5KdEtJii6gT76Y6k/KYUA2QR6BkXo263KO+7GRWlKhcd0W7A==
X-Received: by 2002:a17:906:da89:b0:994:555a:e49f with SMTP id xh9-20020a170906da8900b00994555ae49fmr330849ejb.31.1697664694221;
        Wed, 18 Oct 2023 14:31:34 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id se8-20020a170906ce4800b009a5f1d15644sm2319244ejb.119.2023.10.18.14.31.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:31:33 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9a6190af24aso1208740066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 14:31:33 -0700 (PDT)
X-Received: by 2002:a17:907:c0d:b0:9be:7b67:1674 with SMTP id
 ga13-20020a1709070c0d00b009be7b671674mr409722ejc.3.1697664692747; Wed, 18 Oct
 2023 14:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com> <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
In-Reply-To: <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Oct 2023 14:31:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
Message-ID: <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct 2023 at 13:47, Jeff Layton <jlayton@kernel.org> wrote:
>
> >         old_ctime_nsec &= ~I_CTIME_QUERIED;
> >         if (ts64.tv_nsec > old_ctime_nsec + inode->i_sb->s_time_gran)
> >                 return ts64;
> >
>
> Does that really do what you expect here? current_time will return a
> value that has already been through timestamp_truncate.

Yeah, you're right.

I think you can actually remove the s_time_gran addition. Both the
old_ctime_nsec and the current ts64,tv_nsec are already rounded, so
just doing

        if (ts64.tv_nsec > old_ctime_nsec)
                return ts64;

would already guarantee that it's different enough.

> current_mgtime is calling ktime_get_real_ts64, which is an existing
> interface that does not take the global spinlock and won't advance the
> global offset. That call should be quite cheap.

Ahh, I did indeed mis-read that as the new one with the lock.

I did react to the fact that is_mgtime(inode) itself is horribly
expensive if it's not cached (following three quite possibly cold
pointers), which was part of that whole "look at I_CTIME_QUERIED
instead".

I see the pointer chasing as a huge VFS timesink in all my profiles,
although usually it's the disgusting security pointer (because selinux
creates separate security nodes for each inode, even when the contents
are often identical). So I'm a bit sensitive to "follow several
pointers from 'struct inode'" patterns from looking at too many
instruction profiles.

          Linus

