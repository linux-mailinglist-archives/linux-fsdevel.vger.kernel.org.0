Return-Path: <linux-fsdevel+bounces-21057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 993938FD1BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3EE28801F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1C956477;
	Wed,  5 Jun 2024 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ypV8qNl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744201E4BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601757; cv=none; b=I1NrXlyggcuw9Zuk59ixbzoOm7F5iTQx4qWWhhxob3SbBXwE8spgk2Xc0K1p948pgbimD/LLyGejxgM+4XSrApjL4ggLPXqDal8FxT/NI+1mVria5wqBeG13bHLoa0JXwz/X27vDsTVrXOkDoasGFVg71MZD1CaIRsNU1NH9r3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601757; c=relaxed/simple;
	bh=+OZm5/y3/uFdNftvyg7ho7vFKppQZBuz2dYEwop/gSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ts0b309w4tTstk6II5XU1qZXrd7REUZlRGFncU1olzKNKqmkeqx2ivobnYtnj71OL2q8fIAe+8itpDxom3qud3G8637BeFo8H09JzaFsNhbtBcMANBk13nE+1bjgedjE/bPcxnEk67wzQdmC6Wrt9Eo1TTFSPxqvV5o/0E1ReKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ypV8qNl2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6559668e1so33050835ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 08:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1717601755; x=1718206555; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nAk75/rNTsxI/8Vj4jK+Zvdo2XN9iI9bePNHVmD2D10=;
        b=ypV8qNl24BWzflq56OYyGSsH/4P2yxkb18K91z3/fDdt+mY0Ie7ee2LgReVSsoBVZ4
         FKbHDnGvYPC0ZKNb99Rjnu6Mb5MnRhALqUvZ5XVymdRXWoi7IsOMsamqERT1nhoC8PyJ
         75KCy7WnGLPODVnLXKv7iT7g3Pc0H9RmK8XxSN9Ta9Xhdca4XzzQwvv3TLlOoPxr92fx
         KoWK5qxGjJ8FPrrUPcKReTHP6Do4zWiQ7uZg3T6Dm8jJOpp9wjekB7y4mBcY1NZCXqHo
         dv8FFIUWrv1xmKwXfL+YLq7vEMw+yC9lAgD/5NeDU8KF/QEBneZpwadwQYiHZI/eBpTs
         paMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717601755; x=1718206555;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nAk75/rNTsxI/8Vj4jK+Zvdo2XN9iI9bePNHVmD2D10=;
        b=h34aLIQ5r62vaUyLrwp/PJXyn0GVdT1WXhYCi8PbYeUDV1j+CTK9j2bJdfPr1Q6RUv
         lBYCU/qUTnirV5gMBMSpF5DhuVfc7F7F2IUbr3h9t4lolP5JcxWkiKSpEJ0Wmk19PAYg
         WNXok7ShQxS5kP1RguSFGEavlFLH1kBlvmUHoCozaD63S4QujTyxSZ1kb7AbC0uDfauc
         /uc8y81FrMcElB4EX/2l4E6N/yeOzUTb1I/q34q1X8mMnWomVZP2888g5SvGtEYjvHAp
         9rrEzJ0T2QU0W1lcL+aM0gT0Yt0d5x/5frUFZMly0peBd+Wm2M1Z6vZFD9djWxLREer6
         f/gw==
X-Forwarded-Encrypted: i=1; AJvYcCWg1gOpQMOz3Uk/jg1KHP+0FLBYeRTG/RypVA/Wk/9rAACrMWpG2uJMIliWLpQ3A3dWMqz78q+O32PLVeWnZ4H9c4IZSBA5+HZd0J+jow==
X-Gm-Message-State: AOJu0Yy8FEq7q2qXkIKcGQSYnnNlckDDG/gwXIPZfIxf3lJrzUIKQaOx
	+kjmKiytKftkGl9HrBA235CNtXbX0wAMZc+uVedXmI1miiTSNnIs8pYtifip6uM=
X-Google-Smtp-Source: AGHT+IGDBGJ8ZJCOCV4o7bc6YmUIzOf8ghMtygf47Fad9OJyRtHeX7zioK4Rcra76/1jvDQUwhrw+w==
X-Received: by 2002:a17:902:da8d:b0:1f3:4d2:7025 with SMTP id d9443c01a7336-1f6a5a6ab9cmr36668345ad.49.1717601754632;
        Wed, 05 Jun 2024 08:35:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:eaa0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323570f5sm103535245ad.75.2024.06.05.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 08:35:54 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:35:52 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	lege.wang@jaguarmicro.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [HELP] FUSE writeback performance bottleneck
Message-ID: <20240605153552.GB21567@localhost.localdomain>
References: <bd49fcba-3eb6-4e84-a0f0-e73bce31ddb2@linux.alibaba.com>
 <CAJfpegsfF77SV96wvaxn9VnRkNt5FKCnA4mJ0ieFsZtwFeRuYw@mail.gmail.com>
 <ffca9534-cb75-4dc6-9830-fe8e84db2413@linux.alibaba.com>
 <2f834b5c-d591-43c5-86ba-18509d77a865@fastmail.fm>
 <CAJfpegt_mEYOeeTo2bWS3iJfC38t5bf29mzrxK68dhMptrgamg@mail.gmail.com>
 <21741978-a604-4054-8af9-793085925c82@fastmail.fm>
 <20240604165319.GG3413@localhost.localdomain>
 <6853a389-031b-4bd6-a300-dea878979d8c@fastmail.fm>
 <20240604221654.GA17503@localhost.localdomain>
 <CAOQ4uxjTb=ja-fe6qqKjEo96m_AU6ikpERh1putSM9e_-6Y01g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjTb=ja-fe6qqKjEo96m_AU6ikpERh1putSM9e_-6Y01g@mail.gmail.com>

On Wed, Jun 05, 2024 at 08:49:48AM +0300, Amir Goldstein wrote:
> On Wed, Jun 5, 2024 at 1:17 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Jun 04, 2024 at 11:39:17PM +0200, Bernd Schubert wrote:
> > >
> > >
> > > On 6/4/24 18:53, Josef Bacik wrote:
> > > > On Tue, Jun 04, 2024 at 04:13:25PM +0200, Bernd Schubert wrote:
> > > >>
> > > >>
> > > >> On 6/4/24 12:02, Miklos Szeredi wrote:
> > > >>> On Tue, 4 Jun 2024 at 11:32, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
> > > >>>
> > > >>>> Back to the background for the copy, so it copies pages to avoid
> > > >>>> blocking on memory reclaim. With that allocation it in fact increases
> > > >>>> memory pressure even more. Isn't the right solution to mark those pages
> > > >>>> as not reclaimable and to avoid blocking on it? Which is what the tmp
> > > >>>> pages do, just not in beautiful way.
> > > >>>
> > > >>> Copying to the tmp page is the same as marking the pages as
> > > >>> non-reclaimable and non-syncable.
> > > >>>
> > > >>> Conceptually it would be nice to only copy when there's something
> > > >>> actually waiting for writeback on the page.
> > > >>>
> > > >>> Note: normally the WRITE request would be copied to userspace along
> > > >>> with the contents of the pages very soon after starting writeback.
> > > >>> After this the contents of the page no longer matter, and we can just
> > > >>> clear writeback without doing the copy.
> > > >>>
> > > >>> But if the request gets stuck in the input queue before being copied
> > > >>> to userspace, then deadlock can still happen if the server blocks on
> > > >>> direct reclaim and won't continue with processing the queue.   And
> > > >>> sync(2) will also block in that case.>
> > > >>> So we'd somehow need to handle stuck WRITE requests.   I don't see an
> > > >>> easy way to do this "on demand", when something actually starts
> > > >>> waiting on PG_writeback.  Alternatively the page copy could be done
> > > >>> after a timeout, which is ugly, but much easier to implement.
> > > >>
> > > >> I think the timeout method would only work if we have already allocated
> > > >> the pages, under memory pressure page allocation might not work well.
> > > >> But then this still seems to be a workaround, because we don't take any
> > > >> less memory with these copied pages.
> > > >> I'm going to look into mm/ if there isn't a better solution.
> > > >
> > > > I've thought a bit about this, and I still don't have a good solution, so I'm
> > > > going to throw out my random thoughts and see if it helps us get to a good spot.
> > > >
> > > > 1. Generally we are moving away from GFP_NOFS/GFP_NOIO to instead use
> > > >    memalloc_*_save/memalloc_*_restore, so instead the process is marked being in
> > > >    these contexts.  We could do something similar for FUSE, tho this gets hairy
> > > >    with things that async off request handling to other threads (which is all of
> > > >    the FUSE file systems we have internally).  We'd need to have some way to
> > > >    apply this to an entire process group, but this could be a workable solution.
> > > >
> > >
> > > I'm not sure how either of of both (GFP_ and memalloc_) would work for
> > > userspace allocations.
> > > Wouldn't we basically need to have a feature to disable memory
> > > allocations for fuse userspace tasks? Hmm, maybe through mem_cgroup.
> > > Although even then, the file system might depend on other kernel
> > > resources (backend file system or block device or even network) that
> > > might do allocations on their own without the knowledge of the fuse server.
> > >
> >
> > Basically that only in the case that we're handling a request from memory
> > pressure we would invoke this, and then any allocation would automatically have
> > gfp_nofs protection because it's flagged at the task level.
> >
> > Again there's a lot of problems with this, like how do we set it for the task,
> > how does it work for threads etc.
> >
> > > > 2. Per-request timeouts.  This is something we're planning on tackling for other
> > > >    reasons, but it could fit nicely here to say "if this fuse fs has a
> > > >    per-request timeout, skip the copy".  That way we at least know we're upper
> > > >    bound on how long we would be "deadlocked".  I don't love this approach
> > > >    because it's still a deadlock until the timeout elapsed, but it's an idea.
> > >
> > > Hmm, how do we know "this fuse fs has a per-request timeout"? I don't
> > > think we could trust initialization flags set by userspace.
> > >
> >
> > It would be controlled by the kernel.  So at init time the fuse file system says
> > "my command timeout is 30 minutes."  Then the kernel enforces this by having a
> > per-request timeout, and once that 30 minutes elapses we cancel the request and
> > EIO it.  User space doesn't do anything beyond telling the kernel what it's
> > timeout is, so this would be safe.
> >
> 
> Maybe that would be better to configure by mounter, similar to nfs -otimeo
> and maybe consider opt-in to returning ETIMEDOUT in this case.
> At least nfsd will pass that error to nfs client and nfs client will retry.
> 
> Different applications (or network protocols) handle timeouts differently,
> so the timeout and error seems like a decision for the admin/mounter not
> for the fuse server, although there may be a fuse fs that would want to
> set the default timeout, as if to request the kernel to be its watchdog
> (i.e. do not expect me to take more than 30 min to handle any request).

Oh yeah for sure, I'm just saying for the purposes of allowing the FUSE daemon
to be a little riskier with system resources we base it off of wether it opts in
to command timeouts.

My plans are to have it be able to be set by the fuse daemon, or externally by a
sysadmin via sysfs.  Thanks,

Josef

