Return-Path: <linux-fsdevel+bounces-77180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJO2Mq+Rj2lwRgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:03:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F481398B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 22:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1688304046F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790F24677B;
	Fri, 13 Feb 2026 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuSvRB60";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mj9PSPmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DFE26ADC
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771016605; cv=pass; b=DDr4Qnpmvm+N9HS0aPK28wMevphQjMX2uAfuZz5cfPFSnaqGvmr42WUr7QjdP2FmxZFUNRoxwprDWYi1VYsmqPqBgIu4IIEnQspb0LhKF0UMpeUkHCjbI58gEXrFBXVCv+EL2d11ZC1QfBmnSSE6M+bv5YxAU4XySX4blqXXmIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771016605; c=relaxed/simple;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iAxaJIJEgBduHdKNrNoUs6f7/NxFnk3n19AMfKa4fPtYmqE+QHabzbyUAOE9UMA3pSMW1lS+48t+WWHHGxPnFbhDav8k5cjYg2rVgbf+VhNWnI4wRoQJlZbEtBKixKu7d2AVDSB2BIrcwfmStLoc39XOQAjECkQ24oaj2+gSEDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HuSvRB60; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mj9PSPmV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771016603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
	b=HuSvRB60DddThvCOJQnB9DA2U6hpx3kTWtT/D1VVwoFobJ67scD5VzHYgZbxtZfmC0UIuK
	L+ba28dj+0WjDDyH+yxlzMChzHIdcJn9YY/IEffCYYfrxzyHQ9RtDKYz7FzC2cPG/6tUcy
	G31AJ9LE//OeMedRrDeWc6G7LA4LqJc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-8zFUOHDyPcWFyqU8boe42w-1; Fri, 13 Feb 2026 16:03:22 -0500
X-MC-Unique: 8zFUOHDyPcWFyqU8boe42w-1
X-Mimecast-MFC-AGG-ID: 8zFUOHDyPcWFyqU8boe42w_1771016601
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59f6db39e3dso128117e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 13:03:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771016600; cv=none;
        d=google.com; s=arc-20240605;
        b=Yiv+4dyOknvaNLWyqTLNaqfmoWfIqfUdoLNyK4PufSA8gAsDP/vDJ1pIiJNe1BWho/
         lPPGW2bFpnadsT2YNcYGSfSK8vHpFmHizOno4SNkuCC7fcyH0PKcz+/6kEJ4MTdHulXm
         o09KkDgSvmGTNWx1ly8NRxrf3ZMGhBzanrv9ARkn+2RMe9HINMdbxNJ7eMsuwGfOHT+F
         S1vJqRBgIgeZbGNvKBK83Tzu7P0Fgg3Zwjv6QBnlt4t8bMPtbdWC+JspPTbdnK/gQjLd
         F1vdt62HeDrZ41pV9EP1ffGXulwCq49rsJY5XVvk+QERhkY6JZ1bcPlnTlggl20TKKMh
         oCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        fh=XTuJdODFTtIjKW6psHko7DLHl3zrELITgQ0Chz1WZIc=;
        b=aPm2QPJa8abHgRIqZfCuncokkeBEWHX6Uu1PcEGd11cbNs7HvJzr2Vf4/4W6m33hLG
         pTUoaa5LxpCrmkSoFtDpsCoU0IWHKYBc5+o52rbPx1g0Hw5BZVGkPiNiyYkQFX0zbaRc
         RBZAU20t4kZxUp4aHgR/NY2yrYTeKrlWC3h3Szzf6p2zRQ9ENnUbqDPJth+QH27/LWCP
         mH5aZPHvO8moznpnDa5OYsocuJxWdRKQjJ5I21IH1+OW1H3m9cW75Hc6pB55IIYQjx9E
         OYv2DSlDahDq7zRJpixeKge48zw8jSm76/2jAvJ6hDcN9Mvb/mgGe4JDi+mY2h2ePxcU
         ksAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771016600; x=1771621400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        b=mj9PSPmVvfhBhcWFsfykyZS6l3q2qWR+VR41Ta4u7QmZm78HGK3kloCAiXiP9S5NZj
         Sp7p2D3fei7M3Io6FVcG5XvjmkxuFfwQB4x4Isse2npz3rx1F5TUPdH4CaDNJCrI7DWe
         axMUobq9vjU58PYyaBiLnec8TY2FfYRIHOCourKSnjn+Bbbb50oYNuRzYCiHnIfbFWuY
         F9fBXf9ptck4o77LK692SD9+egDCAmn2FJlYEZhiH9OqCNtfQDyha5jYncEFRaEKUdPO
         gBthe657wiM3WvxOSCC+RHN+xJIc5MRNwORO2lgjMSi5F9dulsVj4U6hp+P5wBYlTqHo
         jsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771016600; x=1771621400;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r38H8eLl4lKmz96ayMJg0B2RxOcVqxUeAat+Bqym31U=;
        b=EmiGTcqRGuCjGUNToFVD8q1R6R44RFRFil5UkkHvkFLadKFx+GCtfePuDjgWAcANBl
         ZfKRk77XqZVclwyCTQ5JMXDnqZ88dC2e5vVdHpjsetp7+XSXQwy7wKz66PkG0CbLlzyM
         Uq8U1bu0kDkR+LTq2Gcz3F36nvAqjVX+Bd9csagrsbdZ9pUR4Rcq3fTXxeFXvZt43XE7
         R3o/0HHx8pmqqDonkCY57jFD4ofh/fIa8sfhotvW+DkHPvYtV4crkDYY4mHTRyDU+Z3Q
         8t5XU58vzecLSMDW0C1GRAyex5Shlldlr/vaMWOy3dEnEOX9WU14V8VFQdYYHvDFQ1l9
         tqFw==
X-Gm-Message-State: AOJu0YxdtNthk2KwHHaP8MXmSbn5cZ69eS9mAx09vKWhHt3HWAU4xPx+
	E+PaYv5NoZ1zGEH1AHVhdAFale3fZ8p9d4VY9q0so8/XV9LUX4OdSyNYgiAxdynJFznw3IvHdIH
	Trk5xKWcicI27hPXpaLgNLrRSU4lgr7GDhApJN/kZtEbmSRsuGfikAyw0KUKZ2adAy6Wzqk8JW1
	Rsrvx71g9X685D9/tBNwf8EZOay4Tq3sg7naKdT/KOQ961pxJRKHHi
X-Gm-Gg: AZuq6aLhzN0/nRmk+chD4hc/Ex34Cf4KVCXNBeHtW0ABgnkwgcuFt2L/Q8fbJlEry2D
	9rE4+WyE4wxzf1SRSWR7FgPX50bKlHlrLquErMib9HGeDxgFkT/oUglyLqkBP2CkDEOq6d2xAyn
	FdvzpnEZ8awyE4mK+mucMnpt1UiFefwYaqmfN5dPIEZ+wbQLLlRm+bvQ/dIRgGENNoUEW3l+7Oz
	N0Nh7alf18F+5/zH30OIo8cGIPsAF1Y4bRS0oQq
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id 2adb3069b0e04-59f6d34c80dmr210938e87.2.1771016600011;
        Fri, 13 Feb 2026 13:03:20 -0800 (PST)
X-Received: by 2002:a05:6512:32c3:b0:59e:46c6:9081 with SMTP id
 2adb3069b0e04-59f6d34c80dmr210929e87.2.1771016599486; Fri, 13 Feb 2026
 13:03:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 13 Feb 2026 16:03:08 -0500
X-Gm-Features: AZwV_QgZDC4BMfr_62OBKQIGw1rPOpj8cinGnFyTwRxTcGMVGoVWq9ZzvvqAjuA
Message-ID: <CAK-6q+gVhsKKPPax52nju8HXPApPyO9zE_jUygDxvhF8BT8P9Q@mail.gmail.com>
Subject: [LSF/MM ATTEND] distributed file locking
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-nfs <linux-nfs@vger.kernel.org>, 
	gfs2 <gfs2@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aahringo@redhat.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77180-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 31F481398B6
X-Rspamd-Action: no action

Hi,

this proposal for LSF/MM aims to start an initial process to discuss
improving the distributed file locking API in file_operations.
Initially the file locking API, used from the user space via flock()
or fcntl(), was not designed for distributed locking. There are known
issues e.g. specifying a process id but missing additional information
about the distributed entity where the process is running.

There should be a way for users to opt into additional distributed
locking extensions that provide specific distributed locking info or
even introduce a new file ops distributed locking API. Designing such
new behaviour requires community effort to become aware of all
distributed locking use cases in the Linux kernel. Examples of those
users include DLM, NFS or CIFS.

A recent proposal [0] suggested offering the file locking API only to
the user through a virtual filesystem, using DLM as the distributed
lock manager backend for now. The filesystem's concept can be extended
to offer other backends and allow experiments with new "distributed"
file locking API extensions until the community agrees on and proposes
a stable API.

This proposal discusses an exotic and very specific topic: distributed
file locking, which tries to map to the existing file locking API.
Users working on distributed file systems are aware of the challenges
involved. Solving those long-standing challenges will be a lengthy
process. It might be time to start improving this situation.

Please feel free to share your thoughts on this topic.

- Alex

[0] https://lore.kernel.org/linux-fsdevel/20260213180014.614646-1-aahringo@redhat.com


