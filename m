Return-Path: <linux-fsdevel+bounces-40447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD2BA236D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF8A1885D6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545B71F37D2;
	Thu, 30 Jan 2025 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="a0pwewO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EA1F2C56
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272997; cv=none; b=XLQh/3MQwB3hMDLyt9KYTGittDmXxYooT1vS0a+xZ/MY57aeFz7lUNXreF3dQDAj5o9yciymrq78y2aAOjQjkuCE8ZQUnhHtsdfnQsCqhWT/FbZcb6FElOcTLH64TnPElpBCgCCxNTKQnTjaeKMh2xdq61O3nNdNaMT1OMG6MZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272997; c=relaxed/simple;
	bh=3ZdxPvAfcmQNlIJmdWCIqX/gQrdKdUCtNB+7Kj0py+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ga53JSgGYfx7n/PLn97qScv1dCpwEqJ9kW6rDcooHyG0oZaIchvB/vOCI2pA1SuWfdMeTkz/XX8w5lLlqcsG/wgyH2BALqqkeO87rV84D1mNbFy/k5SZT1/gCGFwdMB+jq57E3r3hE+v0yQD/xRE/svvz+EYs/P+2J+P5YH60E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=a0pwewO4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2163dc5155fso23735725ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738272994; x=1738877794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9ijuiEZzKjbqvpEPNvRB635Y5i4hqTbnqe3HTPqnhM=;
        b=a0pwewO442LqYNdI0M0/AHEK+rM+WRAV5DM9N8vGOdL8A/whDNHeJP9h05BvnnXpw/
         TUVG0B2mrVxtyHgNujs6JM6QngBXsRjAFkCd/4w44HRjZS/Io7MPPvJJBLZzFVrVxFWc
         Q9Xx1V37rmqjImPzshcE5JMfdfUexRSCpw6GHG1lEEZojLBZyKG4YXvdEieKCpEeTfz+
         ZNJ4wyuW27brg5aUeFdcwbEBQu6ePm4SjPoMq4GxiwqWpliCnPwSnxk3r3/4cfYYR5jX
         +TSYuxNHHn0XdKbuGMHB44ZZx2IIj/Gg/5BRATzrAC6APNzHWXJwu6tv2ap/QRtM3UY9
         tcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738272994; x=1738877794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9ijuiEZzKjbqvpEPNvRB635Y5i4hqTbnqe3HTPqnhM=;
        b=WmSavz7qnE6+oQplGjmD/BiVd0/+5JeCVgVanhjSjgUOab6Lan8GO049IrMWXWnH/a
         qtBwJ4YoYOxAT3W61XjvrK06kFpfo3GEaDWTmVPKZo1oIw8VoRKIsXzzGKVeH7jw3mqq
         o1QYZ7XD+aeAGL/d5wYXoTzlb78TS0W7B2E9Omi2lK3gj9FuZBlCt/foqzrklPEA6PK2
         bC5Xob+l4FZNfYmsS9h3y5IkBQ0CX0E/kz1grS3i/fqze7/nFRTIEtFnSlOLYO4bJ/em
         vZCyqeWg7XSOS9yl1cXEojZz1V9XYs80jSvCy4RjxO9zXPrcHmTJx7rqhCCJMIczJIl8
         n+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjUG8ErCg/nGEhGH/1DjPmXHn4KOLsBcSckmzZ2/EH0ZB2+ELsYGmDq0w87L1BH1twXp+emNMNwNqZUw8O@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu93lB75Pwq4dAkl6f1k4FtPuoru3Q2bE85tsbAFhvhCSfznZn
	rg7QDDs9+OQb8HViHGjWXJscB+0RV043oLkaCqphuweFoFZOge/pTDIILeccpVY=
X-Gm-Gg: ASbGncvNa9XexGcKV1KR7Mc4JkEtpQg+xlGecOlaap1WsPYPAF698YJZulqLr1xR/RF
	biSDUgFfw5h5MYEayFsQL4xr5fhVhLBGqSaqsDFJ4CfBNTGzxfmjXWkuVExkzjAPqNx5WR93Q3R
	DMWKE//hOVnLo9td8et7QEOo9Qm2f+kLLKMDAokZleBhOx+uYNo6uOjROYvM3Vkpes80Tv+jZqf
	cyhQvmFJD9DFBxYsMVkpdrS6aln+1Z4NCRXt3DvLu/uQv/Sw66kDGm8KuslEjCMSP9BnpO+1TX+
	MTndpb+mL8zuGpuTlKNXBFzKBCjNJAEVLcTHz/L2oEs+B+huatKgGy8KZo4TU5qYLq8=
X-Google-Smtp-Source: AGHT+IFi7KP/uFWpdWAegIG7HhkzsEsibzJqO2iNuwK1YAkhLz6wsiYT3eWBWRTxK1zOZlc8uBTEzg==
X-Received: by 2002:a05:6a21:4598:b0:1e1:e2d8:fd1d with SMTP id adf61e73a8af0-1ed7a6b1784mr14087254637.33.1738272994219;
        Thu, 30 Jan 2025 13:36:34 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a1cbc8sm1991253b3a.177.2025.01.30.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 13:36:33 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tdcD8-0000000CZwg-00Ha;
	Fri, 31 Jan 2025 08:36:30 +1100
Date: Fri, 31 Jan 2025 08:36:29 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ted Ts'o <tytso@mit.edu>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	almaz.alexandrovich@paragon-software.com, ntfs3@lists.linux.dev,
	miklos@szeredi.hu, linux-bcachefs@vger.kernel.org, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	dhowells@redhat.com, jlayton@kernel.org, netfs@lists.linux.dev
Subject: Re: [PATCH 0/7] Move prefaulting into write slow paths
Message-ID: <Z5vw3SBNkD-CTuVE@dread.disaster.area>
References: <20250129181749.C229F6F3@davehans-spike.ostc.intel.com>
 <qpeao3ezywdn5ojpcvchaza7gd6qeb57kvvgbxt2j4qsk4qoey@vrf4oy2icixd>
 <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f35aa9a2-edac-4ada-b10b-8a560460d358@intel.com>

On Thu, Jan 30, 2025 at 08:04:49AM -0800, Dave Hansen wrote:
> On 1/29/25 23:44, Kent Overstreet wrote:
> > On Wed, Jan 29, 2025 at 10:17:49AM -0800, Dave Hansen wrote:
> >> tl;dr: The VFS and several filesystems have some suspect prefaulting
> >> code. It is unnecessarily slow for the common case where a write's
> >> source buffer is resident and does not need to be faulted in.
> >>
> >> Move these "prefaulting" operations to slow paths where they ensure
> >> forward progress but they do not slow down the fast paths. This
> >> optimizes the fast path to touch userspace once instead of twice.
> >>
> >> Also update somewhat dubious comments about the need for prefaulting.
> >>
> >> This has been very lightly tested. I have not tested any of the fs/
> >> code explicitly.
> > 
> > Q: what is preventing us from posting code to the list that's been
> > properly tested?
> > 
> > I just got another bcachefs patch series that blew up immediately when I
> > threw it at my CI.
> > 
> > This is getting _utterly ridiculous_.

That's a bit of an over-reaction, Kent.

IMO, the developers and/or maintainers of each filesystem have some
responsibility to test changes like this themselves as part of their
review process.

That's what you have just done, Kent. Good work!

However, it is not OK to rant about how the proposed change failed
because it was not exhaustively tested on every filesytem before it
was posted.

I agree with Dave - it is difficult for someone to test widepsread
changes in code outside their specific expertise. In many cases, the
test infrastructure just doesn't exist or, if it does, requires
specialised knowledge and tools to run.

In such cases, we have to acknowledge that best effort testing is
about as good as we can do without overly burdening the author of
such a change. In these cases, it is best left to the maintainer of
that subsystem to exhaustively test the change to their
subsystem....

Indeed, this is the whole point of extensive post-merge integration
testing (e.g. the testing that gets run on linux-next -every day-).
It reduces the burden on individuals proposing changes created by
requiring exhaustive testing before review by amortising the cost of
that exhaustive testing over many peer reviewed changes....

> In this case, I started with a single patch for generic code that I knew
> I could test. In fact, I even had the 9-year-old binary sitting on my
> test box.
> 
> Dave Chinner suggested that I take the generic pattern go look a _bit_
> more widely in the tree for a similar pattern. That search paid off, I
> think. But I ended up touching corners of the tree I don't know well and
> don't have test cases for.

Many thanks for doing the search, identifying all the places
where this pattern existed and trying to address them, Dave. 

> For bcachefs specifically, how should we move forward? If you're happy
> with the concept, would you prefer that I do some manual bcachefs
> testing? Or leave a branch sitting there for a week and pray the robots
> test it?

The public automated test robots are horribly unreliable with their
coverage of proposed changes. Hence my comment above about the
subsystem maintainers bearing some responsibility to test the code
as part of their review process....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

