Return-Path: <linux-fsdevel+bounces-59322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2CDB37431
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 23:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CDF364BBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956E7289367;
	Tue, 26 Aug 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Fv2dTmwI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8CC1C84A1;
	Tue, 26 Aug 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756242356; cv=none; b=g7vbJV4epJhmAnvey5bOr8TlqPf5N9lIUmEKWNvO3Z+0fNMrET2C8g18A3LeYrWrTD+wZLpiqlAx1IF2Web7XcJf+BG5c7QtUqEqOhSTv57vnviJsbqU78WJHEyOh6cjVlpicqOW6uApwDKItjnVlDZDHW7XsJY2IGU8I8csw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756242356; c=relaxed/simple;
	bh=UdU4B9T6GkSF1tLLxjHdPM9VUOdYsIGCo1qR567p2II=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=P8Xo0ujixGJrWSMaLMwO2caz3MUIL4m3FuK46XGp+mred4TAbc5ShkLNvHJF9LtsY5kQmBu5PoLpQZ+SRoMxWkoe+HJvY3PFOobclH1MbFe006vLUozzMNXUDI6rHekBfsjic5Qwi1WpM5B3N2f7nIqOPk+EG3O6FPeKKqzlngM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Fv2dTmwI; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
	by mail.ispras.ru (Postfix) with ESMTPSA id AC00140A327B;
	Tue, 26 Aug 2025 21:05:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AC00140A327B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756242343;
	bh=pU4vLspP4lexqAlL5cknaKES8LqMLTR9DroZ0K07Djc=;
	h=Date:From:To:cc:Subject:From;
	b=Fv2dTmwIBNCGXNYEH1iNfCTOvdjZDwXl8UJRlqY3Tf14Vo7ECc/V8Hy6Z2Unm3oUG
	 VbDsJC9kvDgSKc4jYHdeyf1EuHywKVKPPZ7NVlzoMUoo9RZ6jm9dLQS17WnYBC9rN1
	 ugyLlo4ptPTKgRCBkfbp37kWsY8jbPDZTmBDLg6g=
Date: Wed, 27 Aug 2025 00:05:38 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: linux-fsdevel@vger.kernel.org
cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    linux-kernel@vger.kernel.org
Subject: ETXTBSY window in __fput
Message-ID: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1383465452-1756242343=:31630"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1383465452-1756242343=:31630
Content-Type: text/plain; charset=US-ASCII

Dear fs hackers,

I suspect there's an unfortunate race window in __fput where file locks are
dropped (locks_remove_file) prior to decreasing writer refcount
(put_file_access). If I'm not mistaken, this window is observable and it
breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
in more detail below.

The program demonstrating the problem is attached (a slightly modified version
of the demo given by Russ Cox on the Go issue tracker, see URL in first line).
It makes 20 threads, each executing an infinite loop doing the following:

1) open an fd for writing with O_CLOEXEC
2) write executable code into it
3) close it
4) fork
5) in the child, attempt to execve the just-written file

If you compile it with -DNOWAIT, you'll see that execve often fails with
ETXTBSY. This happens if another thread forked while we were holding an open fd
between steps 1 and 3, our fd "leaked" in that child, and then we reached our
step 5 before that child did execve (at which point the leaked fd would be
closed thanks to O_CLOEXEC).

I suggested on the Go bugreport that the problem can be solved without any
inter-thread cooperation by utilizing BSD locks. Replace step 3 by

3a) place an exlusive lock on the file identified by fd (flock(fd, LOCK_EX))
3b) close the fd
3c) open an fd on the same path again
3d) place a lock on it again
3e) close it again

Since BSD locks are placed via the open file description, the lock placed at
step 3a is not released until all descriptors duplicated via forks are closed.
Hence, at step 3d we wait until all forked children proceeded to execve.

Recently another person tried this solution and observed that they still see the
errors, albeit at a much lower rate, about three per 30 minutes (I've not been
able to replicate that). I suspect the race window from the first paragraph
makes that possible.

If so, would it be possible to close that window? Would be nice to have this
algorithm work reliably.

Thanks.
Alexander
--8323328-1383465452-1756242343=:31630
Content-Type: text/plain; name=etxtbusy.c
Content-Transfer-Encoding: BASE64
Content-ID: <f20e70db-8099-2aac-1411-2873fe125c60@ispras.ru>
Content-Description: 
Content-Disposition: attachment; filename=etxtbusy.c

LyogRVRYVEJTWSByYWNlIGV4YW1wbGUgZnJvbSBodHRwczovL2dpdGh1Yi5j
b20vZ29sYW5nL2dvL2lzc3Vlcy8yMjMxNSAqLw0KI2luY2x1ZGUgPHN0ZGlu
dC5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RyaW5nLmg+
DQojaW5jbHVkZSA8c3RkbGliLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNp
bmNsdWRlIDxwdGhyZWFkLmg+DQojaW5jbHVkZSA8dW5pc3RkLmg+DQojaW5j
bHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzeXMvd2FpdC5oPg0KI2luY2x1
ZGUgPHN5cy9maWxlLmg+DQoNCnN0YXRpYyB2b2lkICpydW5uZXIodm9pZCAq
KTsNCg0KaW50DQptYWluKHZvaWQpDQp7DQoJcHRocmVhZF90IHRoclsyMF07
DQoNCglmb3IgKGludCBpPTE7IGk8MjA7IGkrKykNCgkJcHRocmVhZF9jcmVh
dGUoJnRocltpXSwgMCwgcnVubmVyLCAodm9pZCopKHVpbnRwdHJfdClpKTsN
CglydW5uZXIoMCk7DQp9DQoNCnN0YXRpYyBjb25zdCBjaGFyICpzY3JpcHQg
PSAiIyEvYmluL3NoXG5leGl0IDBcbiI7DQoNCnN0YXRpYyB2b2lkICoNCnJ1
bm5lcih2b2lkICp2KQ0Kew0KCWludCBpLCBmZCwgcGlkLCBzdGF0dXM7DQoJ
Y2hhciBidWZbMTAwXSwgKmFyZ3ZbMl07DQoNCglpID0gKGludCkodWludHB0
cl90KXY7DQoJc25wcmludGYoYnVmLCBzaXplb2YgYnVmLCAidHh0YnVzeS0l
ZCIsIGkpOw0KCWFyZ3ZbMF0gPSBidWY7DQoJYXJndlsxXSA9IDA7DQoJZm9y
KDs7KSB7DQoJCWZkID0gb3BlbihidWYsIE9fV1JPTkxZfE9fQ1JFQVR8T19U
UlVOQ3xPX0NMT0VYRUMsIDA3NzcpOw0KCQlpZihmZCA8IDApIHsNCgkJCXBl
cnJvcigib3BlbiIpOw0KCQkJZXhpdCgyKTsNCgkJfQ0KCQl3cml0ZShmZCwg
c2NyaXB0LCBzdHJsZW4oc2NyaXB0KSk7DQojaWZuZGVmIE5PV0FJVA0KCQlm
bG9jayhmZCwgTE9DS19FWCk7DQoJCWNsb3NlKGZkKTsNCgkJZmQgPSBvcGVu
KGJ1ZiwgT19SRE9OTFl8T19DTE9FWEVDKTsNCgkJZmxvY2soZmQsIExPQ0tf
U0gpOw0KI2VuZGlmDQoJCWNsb3NlKGZkKTsNCgkJcGlkID0gZm9yaygpOw0K
CQlpZihwaWQgPCAwKSB7DQoJCQlwZXJyb3IoImZvcmsiKTsNCgkJCWV4aXQo
Mik7DQoJCX0NCgkJaWYocGlkID09IDApIHsNCgkJCWV4ZWN2ZShidWYsIGFy
Z3YsIDApOw0KCQkJZXhpdChlcnJubyk7DQoJCX0NCgkJaWYod2FpdHBpZChw
aWQsICZzdGF0dXMsIDApIDwgMCkgew0KCQkJcGVycm9yKCJ3YWl0cGlkIik7
DQoJCQlleGl0KDIpOw0KCQl9DQoJCWlmKCFXSUZFWElURUQoc3RhdHVzKSkg
ew0KCQkJcGVycm9yKCJ3YWl0cGlkIG5vdCBleGl0ZWQiKTsNCgkJCWV4aXQo
Mik7DQoJCX0NCgkJc3RhdHVzID0gV0VYSVRTVEFUVVMoc3RhdHVzKTsNCgkJ
aWYoc3RhdHVzICE9IDApDQoJCQlmcHJpbnRmKHN0ZGVyciwgImV4ZWM6ICVk
ICVzXG4iLCBzdGF0dXMsIHN0cmVycm9yKHN0YXR1cykpOw0KCX0NCglyZXR1
cm4gMDsNCn0NCg==

--8323328-1383465452-1756242343=:31630--

