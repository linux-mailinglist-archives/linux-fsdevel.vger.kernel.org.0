Return-Path: <linux-fsdevel+bounces-40171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62016A201BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 00:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC121884AEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A61DC1A7;
	Mon, 27 Jan 2025 23:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="yYWV9uue"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752D198845
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020851; cv=none; b=bW7vfVbutj/sJsGmPfTNzp5cizKYhhswkp0Bv6eTKGb/JF2D3muhpYMz2rjHOpSumEipANCuMPfKwxrDLo3QfG5hcR+W57bWuQ4szLjlkKirvVCzZnoQPdXXr527S2i9OP3/UDQWBrY4IEEaKDhKGtV/LNIV805HrBmH+dAmEpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020851; c=relaxed/simple;
	bh=7G7qlgzFvHEtrpje6f/jvcFPYcp8mJYIxFR1wOJyQsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU9RWPbf4mLRz1FDWwnrbKxj/H+F9Jc1C8ZWUnvssnkAzLMdj5a++6lJkQzfJWmRcxxusFQDetyDmxLosFeOlEhlgRNLxzYMQ3h13kjzDPcbyjlCophEaLN8FpgVKpencs5EsM0NFjn7wyriGTyGVIoIutAOQ+ppEMeEll5pS5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=yYWV9uue; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee50ffcf14so9441084a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2025 15:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1738020849; x=1738625649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=buFinmue/bA4T+nrarsz5dNdvHxtKEn0jadIk+SrTEE=;
        b=yYWV9uueUP0LT1ElxFiDJ4OhtsJToY0T8K08oIHrQ5ED7J284d3ectVwc4bEWcxysl
         q5/bTl6qnPj6/f3T8MukXDf9FGEG9NfincF6x3D4Os9cpqwO0IdKtsm2ojJjaBIlHN9U
         eyLYMx55T+jmQaDKSLMoetJ+7zgGzhwRSEQ3ZxwCLxlaOVFYTmwE+56sZ/oXeh9LDD9B
         j74mWrEDIFv3IrVAmdJFWYP18uNmGUDx1YiPI3r/wPekKjqZQuC+L2qzhaXuTFNFX6ze
         hQJM9cQypXRfOP2FCTyEWle1ZkVv2Cofh4oowX07u2FAmMb/7h3nhEtUJIOyPozufPN3
         srtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738020849; x=1738625649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=buFinmue/bA4T+nrarsz5dNdvHxtKEn0jadIk+SrTEE=;
        b=STqRAHef9msrmvP3y5Ug8TI5AHH3Reks9xDrRguv/IdX0hhERZRR0GF/is+UQgS2Ja
         QjcQhT050mG20xt82RjFI1sN8rC0Hzzm7iGZ1vLg04tgrKWhdF2W32c0qGPl6VRhxrjq
         0wj/cIVIWfmynHSRKTezQ6IBRVAnyN0TW5XTZ4Z1UHhOGJfiBG/N4r/9lEN3wX3lAiQx
         1cCtV2fEaC71EBZr324EVinyOTkyIu2Vk0rm//lKXGMPJZuQA27/XV/g3vD8sBEE/eky
         0K8ZcASMDD9bbYfQT0Qpha2NzeLcS+QsmXWLHbbyMLRKDuSCnlKNY0YBVMNe3G/SEPdu
         jUNQ==
X-Gm-Message-State: AOJu0Yx06cMy+SONaVAaiVHUSL2G2xeUBiV7xPQWwEN86QfIDK9v/oM6
	Aw9jV1b5vKNS68H0zuivLMiJET7gH3LqvAvdnaT/C/YbFK3bjuIOW/0d81hcnTc=
X-Gm-Gg: ASbGncsfBxDC5BEFeFwabMwnss+VHFfms1yAHcGRjjR8pwK5jeY1ljKlQ2IEYU7Cbsi
	l9U8qCjy5cGXXe7JKcI+gvklMrMNPKId7ffk2a4t3VLP0/1W4Dem1BHbb6W+cjjtScLFzyojs7V
	ojLh0vgdi5FEtq12VB7m1/gNRP58DHTAdADaisJsy3XNeeKcHQ/9vhl54jyxBolsFUyjEzsKRyg
	CiAxiUEbtj7o5lyXbx+kfPK9t3Fvszg6FcTPJeZ2ZiTdP77fMWLCGJsCvw6xcWM9UWU6xEbCkAh
	Hsq+DJ9MK5fszJOA/ceS3Oj9JfoRtrnq/SdZxXNtKR7z1bdcz4pTfmiy
X-Google-Smtp-Source: AGHT+IEfevddtBnwKdTCuVgLfAMRZv/eJd0UamLXsv1pE/QmWUnsR26OSpNquwBSpg4jNcj6LGVq3g==
X-Received: by 2002:a05:6a00:4482:b0:728:15fd:dabb with SMTP id d2e1a72fcca58-72fc092989fmr1954255b3a.8.1738020849511;
        Mon, 27 Jan 2025 15:34:09 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69eb75sm7998564b3a.12.2025.01.27.15.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 15:34:08 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tcYcI-0000000BMJC-2P34;
	Tue, 28 Jan 2025 10:34:06 +1100
Date: Tue, 28 Jan 2025 10:34:06 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
Message-ID: <Z5gX7hTPhTtxam1g@dread.disaster.area>
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area>
 <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>

On Mon, Jan 20, 2025 at 12:41:33PM +0100, Amir Goldstein wrote:
> On Sun, Jan 19, 2025 at 10:15 PM Dave Chinner <david@fromorbit.com> wrote:
> > This proposed write barrier does not seem capable of providing any
> > sort of physical data or metadata/data write ordering guarantees, so
> > I'm a bit lost in how it can be used to provide reliable "crash
> > consistent change tracking" when there is no relationship between
> > the data/metadata in memory and data/metadata on disk...
> 
> That's a good question. A bit hard to explain but I will try.
> 
> The short answer is that the vfs write barrier does *not* by itself
> provide the guarantee for "crash consistent change tracking".
> 
> In the prototype, the "crash consistent change tracking" guarantee
> is provided by the fact that the change records are recorded as
> as metadata in the same filesystem, prior to the modification and
> those metadata records are strictly ordered by the filesystem before
> the actual change.

Uh, ok.

I've read the docco and I think I understand what the prototype
you've pointed me at is doing.

It is using a separate chunk of the filesystem as a database to
persist change records for data in the filesystem. It is doing this
by creating an empty(?) file per change record in a per time
period (T) directory instance.

i.e.

write()
 -> pre-modify
  -> fanotify
   -> userspace HSM
    -> create file in dir T named "<filehandle-other-stuff>"

And then you're relying on the filesystem to make that directory
entry T/<filehandle-other-stuff> stable before the data the
pre-modify record was generated for ever gets written.

IOWs, you've specifically relying on *all unrelated metadata changes
in the filesystem* having strict global ordering *and* being
persisted before any data written after the metadata was created
is persisted.

Sure, this might work right now on XFS because the journalling
implementation -currently- provides global metadata ordering and
data/metadata ordering based on IO completion to submission
ordering.

However, we do not guarantee that XFS will -always- have this
behaviour. This is an *implementation detail*, not a guaranteed
behaviour we will preserve for all time. i.e. we reserve the right
to change how we do unrelated metadata and data/metadata ordering
internally.

This reminds of how applications observed that ext3 ordered mode
didn't require fsync to guarantee the data got written before the
metadata, so they elided the fsync() because it was really expensive
on ext3. i.e. they started relying on a specific filesystem
implementation detail for "correct crash consistency behaviour",
without understanding that it -only worked on ext3- and broken crash
consistency behaviour on all other filesystems. That was *bad*, and
it took a long time to get the message across that applications
*must* use fsync() for correct crash consistency behaviour...

What you are describing for your prototype HSM to provide crash
consistent change tracking really seems to me like it is reliant
on the side effects of specific filesystem implementation choices,
not a behaviour that all filesysetms guarantee.

i.e. not all filesystems provide strict global metadata ordering
semantics, and some fs maintainers are on record explicitly stating
that they will not provide or guarantee them. e.g. ext4, especially
with fast commits enabled, will not provide global strictly ordered
metadata semantics. btrfs also doesn't provide such a guarantee,
either.

> I would love to discuss the merits and pitfalls of this method, but the
> main thing I wanted to get feedback on is whether anyone finds the
> described vfs API useful for anything other that the change tracking
> system that I described.

If my understanding is correct, then this HSM prototype change
tracking mechanism seems like a fragile, unsupportable architecture.
I don't think we should be trying to add new VFS infrastructure to
make it work, because I think the underlying behaviours it requires
from filesystems are simply not guaranteed to exist.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

