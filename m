Return-Path: <linux-fsdevel+bounces-2984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7EC7EE865
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 21:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44ABD1C20A27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 20:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF646433;
	Thu, 16 Nov 2023 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPvsoVCv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E3D4A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Nov 2023 12:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700167003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aM588nCLOMRy9nyQwkvqYwn6Kk0o6YyUQbITALEnpPc=;
	b=iPvsoVCvbo3eE9t51KgKE0O1jqatkWOIu8BBxRVSi8CmH1cQFoycMAr0z4fFHV7JZo0gcI
	x62QHlyRnVJ4uq7AApS8btGR5FhvliaETED3evT2xy1ktFvx++UTveigeZ5vtQcPBAUaIu
	m6HPSNcTHckAXlkWXFWs6oMkwKME9pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-oZKvOkczMViKr_5ETt-vCw-1; Thu, 16 Nov 2023 15:36:39 -0500
X-MC-Unique: oZKvOkczMViKr_5ETt-vCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3038101A590;
	Thu, 16 Nov 2023 20:36:38 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AD6431C060AE;
	Thu, 16 Nov 2023 20:36:36 +0000 (UTC)
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
Date: Thu, 16 Nov 2023 21:36:35 +0100
In-Reply-To: <CAJfpegsMahRZBk2d2vRLgO8ao9QUP28BwtfV1HXp5hoTOH6Rvw@mail.gmail.com>
	(Miklos Szeredi's message of "Wed, 15 Nov 2023 16:08:55 +0100")
Message-ID: <87fs15qvu4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

* Miklos Szeredi:

> Hi,
>
> Attaching the proposed man page for the new statmount() syscall.
>
> It describes a libc interface that is slightly different from the raw
> kernel API.   The differences from the two API's are also described in
> the man page.
>
> Raw:
>
>        long syscall(SYS_statmount, const struct mnt_id_req *req,
>                     struct statmount *buf, size_t bufsize, unsigned int flags);
>
> Libc:
>
>        struct statmount *statmount(uint64_t mnt_id, uint64_t request_mask,
>                                    struct statmount *buf, size_t bufsize,
>                                    unsigned int flags);
>
> I propose the libc one to allow automatically allocating the buffer if
> the buf argument is NULL, similar to getcwd(3).

In addition to Adhemerval's observation that we'd prefer to have some
hint regarding the buffer size, it's probably better to have entirely
separate interfaces because it makes static analysis easier.  With a
unified interface, we can still convey the information with an inline
wrapper function, but we can avoid that complexity.

Thanks,
Florian


