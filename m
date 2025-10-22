Return-Path: <linux-fsdevel+bounces-65066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6F8BFABD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 10:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB11A03833
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C1C2EA;
	Wed, 22 Oct 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Nvca4rWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540CC2FF65B
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120035; cv=none; b=WSXEc9pgWzUujdXJBiizLhdHOjLX+BsT2H7ODBv2+PVSI2+M7ZzuxmxDBwazbDsq+aUw1Wsi4DkStSt4r3XltSA0LXEoUq1HnGlh7Np8Pa4XHSqj6RMzLYCpyTk6Hy19VHcct1tl7IV+ShFQHO8XQ4EUnRWBAteNRXwGPmE8LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120035; c=relaxed/simple;
	bh=MkLK0qPpYtKZpjcAyMQTkYlFiGwAm7/ThuH7elBveD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIl0fDSY/Pq5r+O2d4kKTjy5G3rJxDnOuje0He1A2CLAMZAOOxn4YbDf2VuEhYiTOhzuW7K6gs/HJmdd7gsogBbMzAl7dgdAAh3UhSczTOl4hNYWcRjDO8spPJoW3Qo8qgDLHzFTtAe9QCoa0C0RAe9hiqJ24eLZGs1yojsLhD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Nvca4rWi; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b6cdba26639so597556a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1761120032; x=1761724832; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vi75g88dnn+ezywzRSA2gvfzEVMFz+4qzKUpyRCo3Yc=;
        b=Nvca4rWi4l7T2gBXo6fdci7yl1kamaS2cn6EJU9UpDSiC2jCfOB74W5WVeFEC1UQY+
         BKiMNuJyaiSrt3gro1ZDbbfzzr0OdLhIGsQodBWv48FzoZzMuHIc4BTVEtBYILpCZiX9
         YTrJXjqXINFRdUm6Y+lkezHIxP724kuK2NvZ/HybqKxVEbiYd1hn59MtT0Zrw0h3CmZb
         piEdGtQIaewqiVFEaSfCY978HX/Ex+pILd5+nUBZURWllYCVA2Ry7O7+qIm6arwM2AdC
         s3ooRvX2bQo9K4C9pQQr4XHw/b9TuSs3/voaMq68aqC1K9M7uIKnoBiEf8sAgJmpsRRb
         tARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120032; x=1761724832;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi75g88dnn+ezywzRSA2gvfzEVMFz+4qzKUpyRCo3Yc=;
        b=cQSQ7jw/StFK+F+DzdwCpbODEth3RIRxQI6KeEnpH7ZN4+CalnJmt+M8WZe8M2ScXE
         Pj3mMk3KJuzbpK23vQs67Dwb72yfZ2h4snqPdR/WJkcej5tMwkcbRID07cKFPP270TN+
         Rda5UoczkuBzwGfhUyo01xUpjwtJKLIub7iUTOjIURJZpEtu/h0PRAzGpRXC7Z0ILL5N
         bVDFIZER4m0oNO2YfrDfgJtYmqLd9rZPEORalBaPUHlQMBnQTvxNQFyhmP8DvOxZnl74
         fNIxhPEgtn/eEXyqnfffQdpX87MAQBC8AQ9g7/N8ZCYGyd1PD5/VGd0c+qv2ZIM65iXj
         n15g==
X-Forwarded-Encrypted: i=1; AJvYcCWUTlw8Ey03C5oWXeXMwT7yJcu5qtKLNXi+dXT8duP6nee3ZBsmT0Z7F11GaDE9jr3mi3iXzD/786bsAAuA@vger.kernel.org
X-Gm-Message-State: AOJu0YxyRaP6f1ik6YApVA5wqgz0XhXbWjN+LMpvw/2S9DoDMTl0POUd
	MiyMHapvbZkzmoz1dptdYyuPeYZ4N1MxSVoWEW46gBH1+u8agmGSOqixSkJXLoRzlfE=
X-Gm-Gg: ASbGnct+FDWXhwFZY5ciqZt4ngh/7ZRMOgJ9Y7kdbCRoLay88Te13bFujPJBcLeQcQE
	c8dsNgcVPwOU5luA/9osfRO1kqhBn4BUrML+B+QkC5otHCs4YBdreJiZZawK8+Hj0sZmwP/s8Al
	r5L8yJM+BmJ0kFSTg+6OnJsCnQ9G2VnlJb5I+bMLcN0g6KEUCTI397djKCuigjtNWmHQKXZNkwI
	Ag2cxAHKePm3tFCR7vpwKhWGhOcTJq7iv+mkX8pEO/jzIgue0wJ60cqnjSR36YjeWZSbPNUM3v2
	NYvYA/ZISUf4iog/FsEHP5qwt8hxOjSfc4k3au3aOxm74nlcHBMu+f8acjel38JWmrSzh457WZ+
	+WQuXG7/Y9YmF4CYx+ULPdl0W/RYEdAPdpYzo6xjJTIQ7zhFjtU+F/O6watiRlqnGkNS9Oy0F3B
	hz6k8mJ+fAoo+X5iUfEoUAVu0ecy9S2RO5Dq4g6j4VvXsgedlK2nFHWFKwp4nOyCiU0nwLeHAg
X-Google-Smtp-Source: AGHT+IGduvry/wYzrkfuxXUxa8wdplbLIidGYgQBi3n47WTXCWsmsGQK5w2XtRr8wN1GQkSurJM/mw==
X-Received: by 2002:a17:903:245:b0:279:373b:407f with SMTP id d9443c01a7336-2935b50852amr7825425ad.5.1761120032249;
        Wed, 22 Oct 2025 01:00:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm131384155ad.92.2025.10.22.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:00:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vBTlj-00000000Wcc-3XuP;
	Wed, 22 Oct 2025 19:00:27 +1100
Date: Wed, 22 Oct 2025 19:00:27 +1100
From: Dave Chinner <david@fromorbit.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
Message-ID: <aPiPG1-VDV7ZV2_F@dread.disaster.area>
References: <20251017141536.577466-1-kirill@shutemov.name>
 <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area>
 <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>

On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> On Tue, 21 Oct 2025 at 13:39, Dave Chinner <david@fromorbit.com> wrote:
> >
> > > > >   1. Locate a folio in XArray.
> > > > >   2. Obtain a reference on the folio using folio_try_get().
> > > > >   3. If successful, verify that the folio still belongs to
> > > > >      the mapping and has not been truncated or reclaimed.
> >
> > What about if it has been hole-punched?
> 
> The sequence number check should take care of anything like that. Do
> you have any reason to believe it doesn't?

Invalidation doing partial folio zeroing isn't covered by the page
cache delete sequence number.

> Yes, you can get the "before or after or between" behavior, but you
> can get that with perfectly regular reads that take the refcount on
> the page.

Yes, and it is the "in between" behaviour that is the problem here.

Hole punching (and all the other fallocate() operations) are
supposed to be atomic w.r.t. user IO. i.e. you should see either the
non-punched data or the punched data, never a mix of the two. A mix
of the two is a transient data corruption event....

This invalidation race does not exist on XFS, even on this
new fast path.  We protect all buffered reads with the
inode->i_rwsem, so we guarantee they can't race
with fallocate() operations performing invalidations because
fallocate() takes the i_rwsem exclusively. This IO exclusion model
was baked into the XFS locking architecture over 30 years ago.

The problem is the other filesystems don't use this sort of IO
exclusion model (ext4, btrfs, etc) but instead use the page cache
folio locking to only avoid concurrent modification to the same file
range.

Hence they are exposed to this transient state because they rely on
folio locks for arbitrating concurrent access to the page cache and
buffered reads run completely unlocked. i.e. because....

> Reads have never taken the page lock, and have never been serialized that way.

... they are exposed to transient data states in the page cache
during invalidation operations. The i_size checks avoid these
transient states for truncation, but there are no checks that can be
made to avoid them for other sources of invalidation operations.


The mapping->invalidate_lock only prevents page cache instantiation
from occurring, allowing filesystems to create a barrier that
prevents page cache repopulation after invalidation until the
invalidate lock is dropped. This allows them to complete the
fallocate() operation before exposing the result to users.

However, it does not prevent buffered read cache hits racing with
overlapping invalidation operations, and that's the problem I'm
pointing out that this new fast path will still hit, even though it
tries to bounce-buffer it's way around transient states.

So, yes, you are right when you say:

> So the fast case changes absolutely nothing in this respect that I can see.

But that does not make the existing page cache behaviour desirable.
Reading corrupt data faster is still reading corrupt data :/

Really, though, I'm only mentioning this stuff beacuse both the
author of the patch and the reviewer did not seem to know how i_size
is used in this code to avoid truncate races. truncate races are the
simple part of the problem, hole punching is a lot harder to get
right.  If the author hasn't thought about it, it is likely there
are subtle bugs lurking....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

