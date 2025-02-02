Return-Path: <linux-fsdevel+bounces-40552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0791A24FCD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 20:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE583A397C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Feb 2025 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E441FBE87;
	Sun,  2 Feb 2025 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VAAzSx0v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227718F6C
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Feb 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524775; cv=none; b=gQGkni3sBZhrmHv0E3mX1+ucp21WPx8ywox+sCxnjFR0824ns2Z39YhNcH/azuiigjxyWG1m5DgeWB787GxQ8QClRl7puK3glwc6+YvlM50qXw4lCODRVYP599DOWOG8jIoISoOM+zDrHX2pE/cGp9s/9BuLtaIT+GwCg8bY0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524775; c=relaxed/simple;
	bh=OuJscgP7uTlKq8bACIIdRehUIQi6SYlJGYpjhgB1/KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6E9fd3ryS6LNNBTaXOD2G85uTxYu2e088JR1TbVLLDXFFeU7tD82JNB7TmYlThPeqKO6rxLfhPDCMXWGHBNOIAVrQfbLoEwurdwusW7EMoJpOFEXdnDa3nOD0rHuazONG2Aq6Q6Yfbjxds6OIkSpWsZ0vl9r2URKIHoW4dYais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VAAzSx0v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738524771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OuJscgP7uTlKq8bACIIdRehUIQi6SYlJGYpjhgB1/KI=;
	b=VAAzSx0vU8JLuXAOkUj1r3pARwFOdzW0d4cb/p4yzTlhe1XuksLO/JumeqYCqXX6755ZKX
	3ThfDS0Fu5341sl0/1FFIYnj4eHodPM8j1lR6PbTjH7aALxmPAaT+dfBXElY1fs8mKEGlP
	K8eIcI6xF93a/wSAEBpii3drgsaDsZ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-kUuWkFkINhGftHSgnJXLPw-1; Sun,
 02 Feb 2025 14:32:48 -0500
X-MC-Unique: kUuWkFkINhGftHSgnJXLPw-1
X-Mimecast-MFC-AGG-ID: kUuWkFkINhGftHSgnJXLPw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E12751801F0E;
	Sun,  2 Feb 2025 19:32:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F3999180035E;
	Sun,  2 Feb 2025 19:32:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Feb 2025 20:32:20 +0100 (CET)
Date: Sun, 2 Feb 2025 20:32:15 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250202193214.GB6507@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
 <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
 <20250202170131.GA6507@redhat.com>
 <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgEj=1C08_PrqLLkBT28m5qYprf=k6MQt-m=dwuqYmKmQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 02/02, Linus Torvalds wrote:
>
> On Sun, 2 Feb 2025 at 09:02, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > And if we do care about performance... Could you look at the trivial patch
> > at the end? I don't think {a,c,m}time make any sense in the !fifo case, but
> > as you explained before they are visible to fstat() so we probably shouldn't
> > remove file_accessed/file_update_time unconditionally.
>
> I dislike that patch because if we actually want to do this, I don't
> think you are going far enough.

...

Oh yes, yes, I agree, and for the same reasons, including the unnecessary
sb_start_write_trylock() even if it is likely very cheap. Plus it doesn't
look consistent in that "f_flags & O_NOATIME" can be changed by fcntl()
but "i_flags & S_NOCMTIME" can't be changed. Not to mention that this
"feature" will probably be never used.

In case it was not clear, I just tried to measure how much
file_accessed/file_update_time hurt performance-wise. It turns out - a lot.
And the ugly O_NOATIME knob simplifies the before/after testing.

However, yes I was worried about fstat(). But,

> So I'd actually favor a "let's just remove time updates entirely for
> unnamed pipes", and see if anybody notices. Simpler and more
> straightforward.

OK, agreed. Will send the patch.

Oleg.


