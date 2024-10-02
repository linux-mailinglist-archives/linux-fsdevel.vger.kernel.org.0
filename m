Return-Path: <linux-fsdevel+bounces-30810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC698E6AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A52B222E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D319C56B;
	Wed,  2 Oct 2024 23:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="rOxtE119"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F419E7EF
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 23:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911034; cv=none; b=rEhygsuPxCzX65kQnZQbZXfnuneUSEeBsRjYMPncL1Ri5aeq+vYhIYY1sCd8S2x8pn0ACG2GMTkErAx/ES6RstaLzMhoEEIFVc3jhMJqK0Kl2iDpkFUbJswxIpp1TRBuBvNxC9nbvjSrl4SK4/hiWXB98CjO63dDmCs5VCGoa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911034; c=relaxed/simple;
	bh=ueXZgqXcltWhHmOo5GuFmhl7XKfITk7ap1bdRDsapt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJFeS9uMAXdlhk8wtCs2P2sDoN1ZfwgLKHG8STiG2I4Ccuq7OmZ1cInKfOXzrQ4gO3DWmxhgccCQW0Bdym6lDGbDrhID/OMe7jjZBL6b4EkIIWlnyrD0AeZWEwnLxJc63llVLzC95hTk9svE4/S79LoRh+L/ccy3xsrjgb7XaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=rOxtE119; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20b64584fd4so2820975ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727911032; x=1728515832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z/Ic3M14z4k0N449edFTfEglK97UCAmXdYoocS2tZA=;
        b=rOxtE119WsUN9x8gVIsZSEGfe1JI2gyiLt9WzUp4SblsCtx8LVXZk8IExmXhU9w0mh
         MS1XCHKejXQ2K4npsNUAvDlCFqvgVJtgaK1guW8CEjVlTYlyU3ojvK9HDdy21BB0RzY3
         zU5XnEZpuKPnL8Pea73ULPf1MZMnZ1FJVJrA5pYIjrwBKOZpniCsrwqhdaPWN6vxfcp2
         p9J/DhYNhq/SM3mmQ+CHosI3XYuPblqVWdzoDvDYKEZ5jEFlFXEfJDP7bCK7uSttY0sm
         fXbql05+ivOoILbG2qlUAYJY6yLB0TnEBjujdvO1jc+0sTuWlSuNhnRv933GkAepQv1N
         Fujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727911032; x=1728515832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z/Ic3M14z4k0N449edFTfEglK97UCAmXdYoocS2tZA=;
        b=dvma5DoQW9oFL2RU96cEwq3jEO128RBUdzDicfokibbT4C1dI93OmST+0g8QBn1qf7
         IyMqxTRUbcJR94M8MqTS1TycG7KFk9+/SjLBhWgsldE/a21uNY0M44WQWVuAWQueaFlB
         a/6lR1rfV6kIoREY6atM6smTDOkm4f4q8wEVFHtP8YZA6Vd2FIh0KJO1Tn+ilTGARN3X
         C9PkGlENwsACKhg9wfJguy1XW+UMyTL/V2QllZ8XsKmA9DtALhZdKqMgFo7YegDURpe9
         n1FiFA71yzCyaRnd9q31FuDHkaztoc0bAN2A4YEqSLdGkxKSQ204DYzFNHYrU3v8tdpf
         Klrw==
X-Forwarded-Encrypted: i=1; AJvYcCUIk9+vqUj3UhzPuikffhuGk44mF9euZ6qO0cjmE1Y9uUyYhGD2BOJaywLcpiP9xIUV7MhiamXka3saOkbn@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvNg82/06xJeXItoGvX3s25rooatFHolC6Tqo4AbLMqQCTZu4
	FL97Mdp0A+dJn7W1+RAS0ZZxezOt+SBhIurDu4GeaBx4sqASXtIPsMtKQHZtlI0=
X-Google-Smtp-Source: AGHT+IH7WJ42XNgOeesZtbp7YL6BOo4tFeeppiLhsp/zWGFlXUghda8M1czU2W5a9Jr12wLI34XrbQ==
X-Received: by 2002:a17:902:f68d:b0:206:8acc:8871 with SMTP id d9443c01a7336-20bc5a13640mr53059595ad.31.1727911032538;
        Wed, 02 Oct 2024 16:17:12 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beabaa00esm220445ad.69.2024.10.02.16.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 16:17:12 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sw8ai-00D8sy-3C;
	Thu, 03 Oct 2024 09:17:09 +1000
Date: Thu, 3 Oct 2024 09:17:08 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv3UdBPLutZkBeNg@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
 <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>

On Wed, Oct 02, 2024 at 04:28:35PM -0400, Kent Overstreet wrote:
> On Wed, Oct 02, 2024 at 12:49:13PM GMT, Linus Torvalds wrote:
> > On Wed, 2 Oct 2024 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > >
> > > > I don't have big conceptual issues with the series otherwise. The only
> > > > thing that makes me a bit uneasy is that we are now providing an api
> > > > that may encourage filesystems to do their own inode caching even if
> > > > they don't really have a need for it just because it's there.  So really
> > > > a way that would've solved this issue generically would have been my
> > > > preference.
> > >
> > > Well, that's the problem, isn't it? :/
> > >
> > > There really isn't a good generic solution for global list access
> > > and management.  The dlist stuff kinda works, but it still has
> > > significant overhead and doesn't get rid of spinlock contention
> > > completely because of the lack of locality between list add and
> > > remove operations.
> > 
> > I much prefer the approach taken in your patch series, to let the
> > filesystem own the inode list and keeping the old model as the
> > "default list".
> > 
> > In many ways, that is how *most* of the VFS layer works - it exposes
> > helper functions that the filesystems can use (and most do), but
> > doesn't force them.
> > 
> > Yes, the VFS layer does force some things - you can't avoid using
> > dentries, for example, because that's literally how the VFS layer
> > deals with filenames (and things like mounting etc). And honestly, the
> > VFS layer does a better job of filename caching than any filesystem
> > really can do, and with the whole UNIX mount model, filenames
> > fundamentally cross filesystem boundaries anyway.
> > 
> > But clearly the VFS layer inode list handling isn't the best it can
> > be, and unless we can fix that in some fundamental way (and I don't
> > love the "let's use crazy lists instead of a simple one" models) I do
> > think that just letting filesystems do their own thing if they have
> > something better is a good model.
> 
> Well, I don't love adding more indirection and callbacks.

It's way better than open coding inode cache traversals everywhere.

The callback model is simply "call this function on every object",
and it allows implementations the freedom to decide how they are
going to run those callbacks.

For example, this abstraction allows XFS to parallelise the
traversal. We currently run the traversal across all inodes in a
single thread, but now that XFS is walking the inode cache we can
push each shard off to a workqueue and run each shard concurrently.
IOWs, we can actually make the traversal of large caches much, much
faster without changing the semantics of the operation the traversal
is trying to acheive.

We simply cannot do things like that without a new iteration model.
Abstraction is necessary to facilitate a new iteration model, and a
model that provides independent object callbacks allows scope for
concurrent processing of individual objects.

> The underlying approach in this patchset of "just use the inode hash
> table if that's available" - that I _do_ like, but this seems like
> the wrong way to go about it, we're significantly adding to the amount
> of special purpose "things" filesystems have to do if they want to
> perform well.

I've already addressed this in my response to Christian. This is a
mechanism that allows filesystems to be moved one-by-one to a new
generic cache and iteration implementation without impacting
existing code. Once we have that, scalability of the inode cache and
traversals should not be a reason for filesystems "doing their own
thing" because the generic infrastructure will be sufficient for
most filesystem implementations.

> Converting the standard inode hash table to an rhashtable (or more
> likely, creating a new standard implementation and converting
> filesystems one at a time) still needs to happen, and then the "use the
> hash table for iteration" approach could use that without every
> filesystem having to specialize.

Yes, but this still doesn't help filesystems like XFS where the
structure of the inode cache is highly optimised for the specific
on-disk and in-memory locality of inodes. We aren't going to be
converting XFS to a rhashtable based inode cache anytime soon
because it simply doesn't provide the functionality we require.
e.g. efficient lockless sequential inode number ordered traversal in
-every- inode cluster writeback operation.

> Failing that, or even regardless, I think we do need either dlock-list
> or fast-list. "I need some sort of generic list, but fast" is something
> I've seen come up way too many times.

There's nothing stopping you from using the dlist patchset for your
own purposes. It's public code - just make sure you retain the
correct attributions. :)

-Dave.
-- 
Dave Chinner
david@fromorbit.com

