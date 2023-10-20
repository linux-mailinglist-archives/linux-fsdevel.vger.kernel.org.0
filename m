Return-Path: <linux-fsdevel+bounces-856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 847CB7D16DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C13BCB2154E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60376249EA;
	Fri, 20 Oct 2023 20:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hqc7ea0C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1357B1E530
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 20:21:41 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AB9D67
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso191111266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697833298; x=1698438098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=hqc7ea0COAmFv5MZPwSBclL6NfgTYs+tcpUPSzzToCUZ/TwOo0hu4g8a7FGMseXNsd
         NyABRTQUYO3pBlR8m58SHKKix/tS2Kbetb/DHV2SUb1E2yfgMlnbb6fsD4tQ6kvq4agG
         rYfEk8Cp6+fRvYnrlk4hLH6JfDTVzKAvswqRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833298; x=1698438098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XP/w2rcRgohzEDCbF3zAswI8lw4+mMJo52iF5/bT45w=;
        b=CcTgWzBsELpfRoR3zrxqtNSOsSpZr8Hf/I2JdDLtST+tsFiKl8gzwB76DbjRzDc+KM
         bDLa78xXKJXdzCwt80y7EMA3A6OTHH16TOU9JhBqXhk7QtIfr4qOiQP51qP9xCLznNDW
         0CSE5yN1VgoYx50OFxzsPE6o6InaIk29guK6TIzr3Jb8sJ/7io/XXMNdWz0mSAORbgeY
         TGa6oxWOkXax3xq9MMFKbs+SVXyhcuKf7jr7hb/Up9zog/ln6HnYJy/h0Z5qEQz4kAqa
         nPv1tL2iLA/fL2KwYT4rCGqtfbFvm7j6Bf/nAiK4oEJxepQgjearemrvZq26K3r4woWo
         FpVA==
X-Gm-Message-State: AOJu0YztpNivPUFImzKXMC/A3rD+A05Cw2X7zFwDnYfWnpyg1Jb1CgwW
	hzah51x5NLgBOLvZz9OqDVFWPgoEJxQjddNsuz/kcCrj
X-Google-Smtp-Source: AGHT+IEcTfjnRl5QfifEl5AknWJEzymdiYfCVwk8gOhoGf4r/t+aOV6oL73VTG7Yo5g9izPOvHiSEw==
X-Received: by 2002:a17:906:ee8a:b0:9b7:2a13:160c with SMTP id wt10-20020a170906ee8a00b009b72a13160cmr2093770ejb.69.1697833298495;
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id o24-20020a1709064f9800b0099cc3c7ace2sm2151902eju.140.2023.10.20.13.21.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1837597a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 13:21:38 -0700 (PDT)
X-Received: by 2002:a17:907:7e9e:b0:9ae:50e3:7e40 with SMTP id
 qb30-20020a1709077e9e00b009ae50e37e40mr2195962ejc.52.1697833276793; Fri, 20
 Oct 2023 13:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018-mgtime-v1-0-4a7a97b1f482@kernel.org> <20231018-mgtime-v1-2-4a7a97b1f482@kernel.org>
 <CAHk-=wixObEhBXM22JDopRdt7Z=tGGuizq66g4RnUmG9toA2DA@mail.gmail.com>
 <d6162230b83359d3ed1ee706cc1cb6eacfb12a4f.camel@kernel.org>
 <CAHk-=wiKJgOg_3z21Sy9bu+3i_34S86r8fd6ngvJpZDwa-ww8Q@mail.gmail.com>
 <5f96e69d438ab96099bb67d16b77583c99911caa.camel@kernel.org>
 <20231019-fluor-skifahren-ec74ceb6c63e@brauner> <0a1a847af4372e62000b259e992850527f587205.camel@kernel.org>
 <ZTGncMVw19QVJzI6@dread.disaster.area> <eb3b9e71ee9c6d8e228b0927dec3ac9177b06ec6.camel@kernel.org>
 <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
In-Reply-To: <CAHk-=wjma9_TSwXosG7GBXQaZ465VH1t4a4iQ8J=PFpE=4bhVA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 13:20:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
Message-ID: <CAHk-=whrB++OBZ9nO72QjLnWuSQxee69JQp7mo3cwDiaS6tTLw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] timekeeping: new interfaces for multigrain
 timestamp handing
To: Jeff Layton <jlayton@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Hugh Dickins <hughd@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.de>, 
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 13:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So on reboot, the inode would count as "changed" as far any remote
> user is concerned. [..]

Obviously, not just reboot would do that. Any kind of "it's no longer
cached on the server and gets read back from disk" would do the same
thing.

Again, that may not work for the intended purpose, but if the use-case
is a "same version number means no changes", it might be acceptable?
Even if you then could get spurious version changes when the file
hasn't been accessed in a long time?

Maybe all this together with with some ctime filtering ("old ctime
clealy means that the version number is irrelevant"). After all, the
whole point of fine-grained timestamps was to distinguish *frequent*
changes. An in-memory counter certainly does that even without any
on-disk representation..

               Linus

