Return-Path: <linux-fsdevel+bounces-3197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26747F1300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 13:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F561C20A54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 12:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D821944C;
	Mon, 20 Nov 2023 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hBAr9WKI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE86D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 04:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700482593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8mngAluptPIi0IQFYw/fpJsKECf3xAvyMpz30vd2z4=;
	b=hBAr9WKIwBvvsujTcXIDfS/SuGZaOK8Fd/r6x4kHdviMhPOs82qEPsws05xSGu/cYflPVm
	7hH6r6HGHb6o4/pl1cHnNMX/1HYtvxNHyOWs7b/OhwtbwZm8TqKn+jbGGMIIYDHmHjefgw
	+WfIzt5EvPIak4FBSRbrUmGB3475ZAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-FqkTTnGcOMihL_JnqPOX8A-1; Mon, 20 Nov 2023 07:16:28 -0500
X-MC-Unique: FqkTTnGcOMihL_JnqPOX8A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EA90811E7D;
	Mon, 20 Nov 2023 12:16:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.29])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E704492BE0;
	Mon, 20 Nov 2023 12:16:25 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: libc-alpha@sourceware.org,  linux-man <linux-man@vger.kernel.org>,
  Alejandro Colomar <alx@kernel.org>,  Linux API
 <linux-api@vger.kernel.org>,  linux-fsdevel@vger.kernel.org,  Karel Zak
 <kzak@redhat.com>,  Ian Kent <raven@themaw.net>,  David Howells
 <dhowells@redhat.com>,  Christian Brauner <christian@brauner.io>,  Amir
 Goldstein <amir73il@gmail.com>,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: proposed libc interface and man page for statmount(2)
References: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
	<87fs15qvu4.fsf@oldenburg.str.redhat.com>
	<CAJfpegvqBtePer8HRuShe3PAHLbCg9YNUpOWzPg-+=gGwQJWpw@mail.gmail.com>
	<87leawphcj.fsf@oldenburg.str.redhat.com>
	<CAJfpegsCfuPuhtD+wfM3mUphqk9AxWrBZDa9-NxcdnsdAEizaw@mail.gmail.com>
	<CAJfpegsBqbx5+VMHVHbYx2CdxxhtKHYD4V-nN5J3YCtXTdv=TQ@mail.gmail.com>
	<ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu>
Date: Mon, 20 Nov 2023 13:16:24 +0100
In-Reply-To: <ZVtEkeTuqAGG8Yxy@maszat.piliscsaba.szeredi.hu> (Miklos Szeredi's
	message of "Mon, 20 Nov 2023 12:55:17 +0100")
Message-ID: <878r6soc13.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

* Miklos Szeredi:

> On Fri, Nov 17, 2023 at 04:50:25PM +0100, Miklos Szeredi wrote:
>> I wonder... Is there a reason this shouldn't be done statelessly by
>> adding an "continue after this ID" argument to listmount(2)?  The
>> caller will just need to pass the last mount ID received in the array
>> to the next listmount(2) call and iterate until a short count is
>> returned.
>
> No comments so far... maybe more explanation is needed.
>
> New signature of listmount() would be:
>
> ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
> 		  uint64_t *buf, size_t bufsize, unsigned int flags);
>
> And the usage would be:
>
> 	for (last = 0; nres == bufsize; last = buf[bufsize-1]) {
> 		nres = listmount(parent, last, buf, bufsize, flags);
> 		for (i = 0; i < nres; i++) {
> 			/* process buf[i] */
> 		}
> 	}

Is the ID something specific to the VFS layer itself, or does it come
from file systems?

POSIX has a seekdir/telldir interface like that, I don't think file
system authors like it.  Some have added dedicated data structures for
it to implement somewhat predictable behavior in the face of concurrent
directory modification.  Would this interface suffer from similar
issues?

Thanks,
Florian


