Return-Path: <linux-fsdevel+bounces-78804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0A3CHoMeomlMzgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:45:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CAF1BEC82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C915930BBE8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1043859DA;
	Fri, 27 Feb 2026 22:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="OudNO5oW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F8356A01;
	Fri, 27 Feb 2026 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772232310; cv=none; b=jAqNT00KYgXmfxaFqQn+ExC68dgYacPR5r6LYMEOTH78ujmkwxAcYJxNgFCDiimCMgH1yrClQxH0/7nfzypkYbFrq5y3w85lgl8BXA1KM22ovebWyquFlmqDpyO8qvwmIUNhNBSKHotdldOXa7Djlc9zHYdM8rwaMWk4tDB2Jjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772232310; c=relaxed/simple;
	bh=zOeExMo5qpkfpRUP0RRS2lxyPMLFBK45h5PirQeJq8A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qbopQ8tTDTHl+Ix13rSdmmI4MmGHsGJ/ZyUMjTrEn54cNddraa10D2jfNHistK21XbwCcNKJ9V3SHuusPDlwFIge+kiC7PrNu4Pc0RddAGXoh/Q1yhBzd0iPhzcUiekBs8PnABEYb83eitFIg+Lz1omMzA1tHI/v+F7+qlAHFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=OudNO5oW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fN3LQ2kzpzlgyGm;
	Fri, 27 Feb 2026 22:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:subject
	:subject:from:from:content-language:user-agent:mime-version:date
	:date:message-id:received:received; s=mr01; t=1772232298; x=
	1774824299; bh=83IEHxcW2cdLf3kX6MhETEp3FVII7seDD8aLdnjSLT8=; b=O
	udNO5oWsxGEY+wuBlr5l+t9UaBDC8G4LS3BoRNEHKrKXRYTvT190EKpYuXGgov7U
	dGT1lhxaI8zEQiFCGKj+D4TuEnJQ/xeVDDWzQh3OR5lURnXHL6opkSDJobbSfjxz
	aZpK+XklzjYDSgm7JdLUjwZR6uajUF3D8YlHwU7ZQ34iLnPKDw4655iu34AlwsUV
	baJAIPVRoICyZgiQFMuoSalEBFsSKCssSpKXHEIXYROzjaQE/ygyl+S9+6ngLpZK
	lasosa0ovPjZ15xyW2bPJQ2mTuld5gDpJBDcOxSdP22x6uzw5AjPvk0sVfZZA+cF
	uoSnnrleZR2oVSQIC2dAw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zYxGvvbNBMOn; Fri, 27 Feb 2026 22:44:58 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fN3LJ3rWMzlfc3v;
	Fri, 27 Feb 2026 22:44:56 +0000 (UTC)
Message-ID: <d132a95f-8a24-4cea-b09f-68db804c137b@acm.org>
Date: Fri, 27 Feb 2026 14:44:55 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Marco Elver <elver@google.com>
From: Bart Van Assche <bvanassche@acm.org>
Subject: [LSF/MM/BPF TOPIC] Compile-time thread-safety analysis for C code
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78804-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7CAF1BEC82
X-Rspamd-Action: no action


Although Rust is a first-class language in the Linux kernel, I'm not
aware of any large scale plans to convert existing C code into Rust.
Hence the importance of improving compile-time checking for C code.

During the Linux kernel 7.0 merge window the following patch series has
been merged into Linus' master branch: Marco Elver, [PATCH v5 00/36]
Compiler-Based Context- and Locking-Analysis
(https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/).
That patch series includes the following changes:
* Change the implementation of the __acquires(), __releases() and
   __must_hold() macros from something sparse understands into something
   Clang understands because Clang has better support for thread-safety
   checking.
* Introduction of __acquires_shared() and __releases_shared(). Sparse
   does not make a difference between reader locks and writer locks.
* Replacing the __cond_lock() macro with the __cond_acquires() macro.
   While __cond_lock() must be used to annotate all conditional locking
   calls, __cond_acquires() only has to be applied to declarations of
   conditional locking functions.
* Support for __guarded_by(). This attribute tells the compiler to
   verify whether a synchronization object is held when accessing a
   certain member variable.
* Making the guard() macro compatible with synchronization objects that
   support __acquires() and __releases().

Currently compile-time thread-safety analysis is only enabled for a
small subset of kernel code:
$ git grep -nH 'CONTEXT_ANALYSIS.*:= y'|grep -v Documentation
crypto/Makefile:6:CONTEXT_ANALYSIS := y
kernel/Makefile:47:CONTEXT_ANALYSIS_kcov.o := y
kernel/kcsan/Makefile:2:CONTEXT_ANALYSIS := y
kernel/sched/Makefile:3:CONTEXT_ANALYSIS_core.o := y
kernel/sched/Makefile:4:CONTEXT_ANALYSIS_fair.o := y
lib/Makefile:53:CONTEXT_ANALYSIS_rhashtable.o := y
lib/Makefile:252:CONTEXT_ANALYSIS_stackdepot.o := y
lib/Makefile:334:CONTEXT_ANALYSIS_test_context-analysis.o := y
mm/kfence/Makefile:3:CONTEXT_ANALYSIS := y
security/tomoyo/Makefile:2:CONTEXT_ANALYSIS := y

I propose to enable compile-time thread-safety analysis for the entire
kernel because this will enable verification at compile time of locking
functions in error paths. According to my analysis, there are a
significant number of bugs in error paths. The following is required to
enable thread-safety analysis for the entire kernel:
* Fix all locking bugs in error paths by submitting the fixes I came up
   with to the maintainers of the affected code.
* Annotate kernel code with __acquires(), __releases() etc, one
   subsystem at a time.
* Enable thread-safety analysis for all kernel code by enabling
   CONFIG_WARN_CONTEXT_ANALYSIS_ALL.

I propose to organize a session during the LSF/MM/BPF summit to share
what I learned so far, to discuss the open questions about this work and
also about how to get this work upstream. A work-in-progress patch
series that implements this proposal is available here:
https://github.com/bvanassche/linux/tree/thread-safety. One of the
topics I would like to discuss further is how to deal with semaphores.
Some kernel code calls down() and up() from the same function while
other kernel code calls these functions from different kernel threads. A
choice has to be made whether to enable or disable thread-safety
analysis for all semaphores. If thread-safety analysis is disabled for
all semaphores, some code that could be verified at compile time won't
be verified. If thread-safety analysis is enabled at compile time for
all semaphores, some code will have to be annotated.

In case why anyone would be wondering why this topic has not been
proposed earlier: I only wanted to announce this topic after Marco's
patch series was merged in Linus' master branch.

More information about the Clang thread-safety annotations is available 
here: https://clang.llvm.org/docs/ThreadSafetyAnalysis.html.

Bart.

