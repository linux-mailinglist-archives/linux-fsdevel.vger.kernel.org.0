Return-Path: <linux-fsdevel+bounces-60282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4783B4406B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493581C8610B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA853262FCD;
	Thu,  4 Sep 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nFc3Q11P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6022F74F;
	Thu,  4 Sep 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999280; cv=none; b=gGLjPw2QXisDAZwnKD0h8pRqW0LmqR/dBapv8T8JmJvv7xz3ncoNgDX+2ZgMXNtzvB+4tzW7CwnOLbgnsTIY5355I5Sjto1kBjqcYJN6Llhn/GoyM8tPwq+cE9fUA/PB7O+vWeZOnFeKQXwewQVKRQTd75edQgHtDiOazEu0I0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999280; c=relaxed/simple;
	bh=+nqRE5xJaPUtYkEHEza2beIFZn2MAgw9vCj5xyZDLuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SgS7WELa07LTDHbd/N5XnEpC4veS+cw21QW4GUNZkoCrH7sICiNkcZbxOWtsD69jJwkx3elJRdM8bC+X9NrBjSUbdWvLEoLf2Qy7H9yxuMs+UznV1Nvxq8seDqUX3csAan++KjEy8Z3cA0YINThejoTD1A71G6bv5YpqrLk26VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nFc3Q11P; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ox4jiUPEwljLQCFn9y/feEfuda9+8j6uvR7QPbptcfw=; b=nFc3Q11PiFMDzAY/F5YaI9lIPG
	XS6jWpxjAsG74ZaVot21B3uQ9c66qbLA51U+8Jr8OzalY1N/65g/AXebTk6GVIxycLtRRxf1Tjw5Z
	XlI99gEgRFMa+aXnr2NB1rTkLmZnguy3Z2ERtFU3OzYmDgNRcNSRUISJXC2YAuyWs0olaGl90Rd35
	+cnpekRFMzN/NvJlCfaN46xIwysPbro+bU/yX9ZJHpmNWpIzoUhUHUGiitQt4AVc7+6O5rglflBLk
	1fB4zMXTA99rarloGTwtfZq98636d6rKIbAR2gLuBH5HX3ETzPkKQa8Dc2cMG0cQRDhdL6Tcyv/Hm
	5jVdqczw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuBls-006rF7-C4; Thu, 04 Sep 2025 17:21:08 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,  Laura Promberger
 <laura.promberger@cern.ch>,  Dave Chinner <david@fromorbit.com>,  Matt
 Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  kernel-dev@igalia.com,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
In-Reply-To: <CAJfpegsyrSPxLK=nVLDSPWq0dyvoMr+s0K-Lep1BvqX1wpZphA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 4 Sep 2025 16:38:32 +0200")
References: <20250828162951.60437-1-luis@igalia.com>
	<20250828162951.60437-3-luis@igalia.com>
	<CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com>
	<87tt1il334.fsf@wotan.olymp>
	<CAJfpegsyrSPxLK=nVLDSPWq0dyvoMr+s0K-Lep1BvqX1wpZphA@mail.gmail.com>
Date: Thu, 04 Sep 2025 16:21:02 +0100
Message-ID: <87plc6kzvl.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 04 2025, Miklos Szeredi wrote:

> On Thu, 4 Sept 2025 at 16:11, Luis Henriques <luis@igalia.com> wrote:
>>
>> On Thu, Sep 04 2025, Miklos Szeredi wrote:
>>
>> > On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>> >>
>> >> With the infrastructure introduced to periodically invalidate expired
>> >> dentries, it is now possible to add an extra work queue to invalidate
>> >> dentries when an epoch is incremented.  This work queue will only be
>> >> triggered when the 'inval_wq' parameter is set.
>> >>
>> >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> >> ---
>> >>  fs/fuse/dev.c    |  7 ++++---
>> >>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
>> >>  fs/fuse/fuse_i.h |  4 ++++
>> >>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
>> >>  4 files changed, 64 insertions(+), 22 deletions(-)
>> >>
>> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> >> index e80cd8f2c049..48c5c01c3e5b 100644
>> >> --- a/fs/fuse/dev.c
>> >> +++ b/fs/fuse/dev.c
>> >> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_con=
n *fc)
>> >>
>> >>  /*
>> >>   * Increments the fuse connection epoch.  This will result of dentri=
es from
>> >> - * previous epochs to be invalidated.
>> >> - *
>> >> - * XXX optimization: add call to shrink_dcache_sb()?
>> >
>> > I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.
>>
>> So, your suggesting to have the work queue simply calling this instead of
>> walking through the dentries?  (Or even *not* having a work queue at all=
?)
>
> I think doing in in a work queue is useful, since walking the tree
> might take a significant amount of time.
>
> Not having to do the walk manually is definitely a simplification.
> It might throw out dentries that got looked up since the last epoch,
> but it's probably not a big loss in terms of performance.

OK, so that definitely makes things simpler for v6.  Thanks!

Cheers,
--=20
Lu=C3=ADs

