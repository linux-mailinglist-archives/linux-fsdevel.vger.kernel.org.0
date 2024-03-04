Return-Path: <linux-fsdevel+bounces-13512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B60178709CC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0E21C20C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B337869A;
	Mon,  4 Mar 2024 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uer3rmGn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0B278688
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577825; cv=none; b=W3+WgWyM3KMnIJ+uwvurTBuPmzWLTC4fNxKn4i6JMuIXi1mcjH0ueoVN2EbA6xDpBm7oJw0Ls+xbmxhK+oo2OMeCXtEQUcDtC8ei03O5Nbty5UAn4c0LeaBnB9Kh75MQi58GH3haJKZ8YNAn+hm+bu+xfrIh0MYgJKkq2mOULhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577825; c=relaxed/simple;
	bh=JRGZ3lt6N2mZlvwFqVi3nfsAmLGUOemAfWiohmEdr7Q=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=Y/joeMUAgF+zsYubSO6TUU443e4oOPN73CJT0tt7lN5/R8BVyr6Uj9iIEweViBvQAcy7p5qR7AW7SebJQEbOaAkpcYuP25qXGmy3KxxTrDOYuVxOsTOyrY7Wu53pwSVFsHeFeLhbGFcgVvQqnpnfIYmdk6nIAdFfB/eIb0BOjoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uer3rmGn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709577822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MtJlbkAWPtVbhfrIYDSafRst9EM9xqeg0DIYV7pfTmg=;
	b=Uer3rmGnxUQtnwKNu+4UDC4Ua/AQyz5yUhuqQ8NN7HDC1SfgPGQHV2bcK8i513ftG+eYEd
	JfsjD2DFBTeOo7/K0RtDcZMQvtfaDlAIGlNK1iJu2/V2deDrlRXi1cdd370oH2f9KBnJc0
	klHP8QfEaMOj5t2aM5WRRPBgVli080w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-G1Lb31IbNXaUc3xipMHnNg-1; Mon, 04 Mar 2024 13:43:40 -0500
X-MC-Unique: G1Lb31IbNXaUc3xipMHnNg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C65C8185A782;
	Mon,  4 Mar 2024 18:43:39 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A687AC185C1;
	Mon,  4 Mar 2024 18:43:39 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 8E5DF30C1B8F; Mon,  4 Mar 2024 18:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 8C7CD3FB4E;
	Mon,  4 Mar 2024 19:43:39 +0100 (CET)
Date: Mon, 4 Mar 2024 19:43:39 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="185210117-1794909013-1709577819=:2453120"
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--185210117-1794909013-1709577819=:2453120
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

Hi

I have a program that sets up a periodic timer with 10ms interval. When
the program attempts to call fallocate on tmpfs, it goes into an infinite
loop. fallocate takes longer than 10ms, so it gets interrupted by a
signal and it returns EINTR. On EINTR, the fallocate call is restarted,
going into the same loop again.

fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Pøeru¹ené volání systému)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
sigreturn({mask=[]})                    = -1 EINTR (Pøeru¹ené volání systému)
fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Pøeru¹ené volání systému)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
sigreturn({mask=[]})                    = -1 EINTR (Pøeru¹ené volání systému)
fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Pøeru¹ené volání systému)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
sigreturn({mask=[]})                    = -1 EINTR (Pøeru¹ené volání systému)
fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Pøeru¹ené volání systému)
--- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
sigreturn({mask=[]})                    = -1 EINTR (Pøeru¹ené volání systému)

Should there be fatal_signal_pending instead of signal_pending in the
shmem_fallocate loop?

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 mm/shmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
+++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
@@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
 		 * Good, the fallocate(2) manpage permits EINTR: we may have
 		 * been interrupted because we are using up too much memory.
 		 */
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			error = -EINTR;
 		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
 			error = -ENOMEM;
--185210117-1794909013-1709577819=:2453120--


