Return-Path: <linux-fsdevel+bounces-56247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28755B14EDE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6F3A17A094
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9E41C5F37;
	Tue, 29 Jul 2025 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Di0LzdG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0498B259C;
	Tue, 29 Jul 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753797381; cv=none; b=P8ZPNLJvp9f63goT/X1XxzA57n2d28MwFLgXctDX1mKqqbzphjkdqW6EcyjoGerwBuN7GFhVwr4FBf+ZrJgvNOAwK6Ek5sbt5XQ3Dr+rEtpckc0ermhxTTcXVXKG3I77caXqk2Mf8eij5uKjW/HxT508T0YVxbq6Mrch+SsfuQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753797381; c=relaxed/simple;
	bh=9QmQpMzi2udYxSpJ+ZckrOkKCazIM26p185CMFDgkMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LP9bj6kNo/6soJOQ54t2NKE15oiWmgz/F5LuCb/ZFb+1K5s6vj6fWkbeAm5O5TzLcSiGrxf/P+GdKtfMTe7bXPplQbIXzXY/1OOJYFFjpsuqurE1ep/dZTmUQthqnRzv6u97HeHhXYR025dyfAI1yAbjwQ3BSGgVbYVj90JriW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Di0LzdG1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=iG2QtJORdxhQU435LxyciN2mxDEHxnGfaCSb/Hh4W9c=; b=Di0LzdG1p+hqq9ScsQprpWF9Qk
	a9qnfEFtPL1udE9U+dz8xsCsrIQYOyXjSKJpGuK5vLbdElTHCFZOhbIVIo7pCiMtsNwsyXIZc5kFY
	qcVYNb+VPW7yoexRokEXdy+OQVShcvWvJBR2DNxZTv273nKGhXJYAbEQ88EaSInGr2bJRHQKlzGC7
	jyh5ziuQaY5Mdig9eUtDB8GF0w7W49aDyazT8IRIJMD02JLgGr3AdjQPx7n742Ynh0tCy145DHOkR
	F4h8MND51KHZ5wqk4AiqZhs36JW1HezRmlCDnyrhHTGOM+jfzvhaWEp6HbOQ9pFg+L5TxrE1La0ls
	JvTA+frw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1ugkoK-005SVm-HA; Tue, 29 Jul 2025 15:56:08 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] Another take at restarting FUSE servers
Date: Tue, 29 Jul 2025 14:56:02 +0100
Message-ID: <8734afp0ct.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi!

I know this has been discussed several times in several places, and the
recent(ish) addition of NOTIFY_RESEND is an important step towards being
able to restart a user-space FUSE server.

While looking at how to restart a server that uses the libfuse lowlevel
API, I've created an RFC pull request [1] to understand whether adding
support for this operation would be something acceptable in the project.
The PR doesn't do anything sophisticated, it simply hacks into the opaque
libfuse data structures so that a server could set some of the sessions'
fields.

So, a FUSE server simply has to save the /dev/fuse file descriptor and
pass it to libfuse while recovering, after a restart or a crash.  The
mentioned NOTIFY_RESEND should be used so that no requests are lost, of
course.  And there are probably other data structures that user-space file
systems will have to keep track as well, so that everything can be
restored.  (The parameters set in the INIT phase, for example.)

But, from the discussion with Bernd in the PR, one of the things that
would be good to have is for the kernel to send back to user-space the
information about the inodes it already knows about.

I have been playing with this idea with a patch that simply sends out
LOOKUPs for each of these inodes.  This could be done through a new
NOTIFY_RESEND_INODES, or maybe it could be an extra operation added to the
already existing NOTIFY_RESEND.

Anyway, before spending any more time with this, I wanted to ask whether
this is something that could be acceptable in the kernel, if people think
a different approach should be followed, or if I'm simply trying to solve
the wrong problem.

Thanks in advance for any feedback on this.

[1] https://github.com/libfuse/libfuse/pull/1219

Cheers,
--=20
Lu=C3=ADs

