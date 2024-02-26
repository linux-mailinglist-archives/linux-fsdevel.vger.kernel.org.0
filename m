Return-Path: <linux-fsdevel+bounces-12759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A4866EDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 10:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A5282D06
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 09:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88A79DBE;
	Mon, 26 Feb 2024 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRvfrlqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9E79935
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938289; cv=none; b=om+qKh+tF8o2cEvQqwdHq7wuCim80rSYIwCNS1C1gSNZcIoUmjlwWicmgZLHhZuShXlQpsmq7murRaBk8SLa97HJxbwxzao8CNIA1qY6xUMR3Usdh4NrAfXR73+OWdFII86FLHFh/xxus1QwUqMBJ/+hINgsJjo0yuyyv+bvVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938289; c=relaxed/simple;
	bh=sDGpZYokx0A29EKHoXYwr8VjO0Ipv/KWzGpIWB44++M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwkcK06NYAtNBHjRGP+MnG40ntad1jCdxEvDCItW/5TDyI+wK8r/s6DqEFDtkQVNCWVWKpvtYjfo7zDizHR1uvTDtR+lftcsUTx+KwOn3pgEWS09Z3hK0TQ1IBs8cn8iN7vBOoBoSoFn7JGOiDOJHy9NXRyTc21B5PcwrXJTzwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRvfrlqu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708938286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYeXMHL5sQ4iFPgGMi+eS4YBYstnj2dK1B+2TzgueXQ=;
	b=FRvfrlqu8nOsYUm5GhPBWkLKwep7uFEX3D2KSlcowDKWR7zTQu6PM5CeJCexz8fGbeEneO
	PTZInM1wcsE/cigq0wOGeg1TTuO7vBIDG/iF5bPyU92JGoA0E4V11kLwoLGiAMM5o6hKRe
	0Olb8mJL986kGCphJplzTlu7TcikYlA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-IEHXKitZNhivKTSc1ukp3Q-1; Mon,
 26 Feb 2024 04:04:44 -0500
X-MC-Unique: IEHXKitZNhivKTSc1ukp3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C8361C0519C;
	Mon, 26 Feb 2024 09:04:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1837B8CE8;
	Mon, 26 Feb 2024 09:04:42 +0000 (UTC)
Date: Mon, 26 Feb 2024 10:04:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Alexander Viro <aviro@redhat.com>,
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240226090441.5od4ygg6y4pik4ec@ws.net.home>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Fri, Feb 23, 2024 at 04:06:29PM +0100, Christian Brauner wrote:
> On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> > As filesystems are converted to the new mount API, informational messages,
> > errors, and warnings are being routed through infof, errorf, and warnf
> > type functions provided by the mount API, which places these messages in
> > the log buffer associated with the filesystem context rather than
> > in the kernel log / dmesg.
> > 
> > However, userspace is not yet extracting these messages, so they are
> > essentially getting lost. mount(8) still refers the user to dmesg(1)
> > on failure.
> 
> I mean sure we can do this. But we should try without a Kconfig option
> for this.
> 
> But mount(8) and util-linux have been switched to the new mount api in
> v2.39 and libmount already has the code to read and print the error
> messages:
> 
> https://github.com/util-linux/util-linux/blob/7ca98ca6aab919f271a15e40276cbb411e62f0e4/libmount/src/hook_mount.c#L68
> 
> but it's hidden behind DEBUG. So to me it seems much easier to just make
> util-linux and log those extra messages than start putting them into
> dmesg. Can't we try that first?

While it's true that libmount should be more intelligent in this
regard, I still believe that having all the messages accessible via
dmesg(1) is a good idea.

dmesg(1) collects messages from multiple mount calls, making it easy
to access messages generated by mount(8) when invoked from scripts,
systemd, etc. Having a single point to check for errors is convenient.

And dmesg(8) is also the traditional location where users and
documentation expect to find errors.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


