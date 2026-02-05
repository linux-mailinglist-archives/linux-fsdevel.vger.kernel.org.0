Return-Path: <linux-fsdevel+bounces-76444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ObNJeWThGk43gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:58:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7399F2E19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1DD303F7D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B23D522E;
	Thu,  5 Feb 2026 12:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps2eMCj3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294C513AA2F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296160; cv=none; b=Inps5bXE58eACG71FeqxWgLJvUfI5/vyf9LhSC/Red5UTPNnOET4bAx12MTh9IFnfh4OTrJL6XtWejG+XrJya/fW0YnnvM+YuSkLWw0Ac4gMgQpm0g6Gy7t4EofHKhhrRszzjhSXytt1mBsK+swmz9J/H7N2VYbf8fNcyFWYdlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296160; c=relaxed/simple;
	bh=GSF3GMzynwkCshZ7kizNQpLPGCKsO3X5EUXhE/ESrIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkbQgSPaFTm9NVmNSQNOU6O5lMc3qnBJpwCoP7R2/RPbELb9hl4cNtkxUXO9yfBfQUq9eaK2AdDHW65ckzehzw2s90cTSMTyODK/2kAbq9Y6uUmwhMMEBJ3VmjlKPazxyX99wrwXxhf8CunV2Fc4lfdAw2dpAU5FcpwFCnrvhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps2eMCj3; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a76f90872cso5393745ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 04:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770296159; x=1770900959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSF3GMzynwkCshZ7kizNQpLPGCKsO3X5EUXhE/ESrIY=;
        b=Ps2eMCj3FFKPY1nqOrQRxUoLXsl0jd7OA45BOy1NmbpXp5ZaW137McRJV2gKcnNk0f
         rbRX/7qWXftxSiaC0X9cy6BecS9ltdTWTzVErporSYYoZhwngiHkVzIBZP63vWnRGzzX
         fDUOl8MFJbl7aGuu0ZSEDjVSd0QFwDltUd63h/3VmhjRwwJ3LsSYQCDgJ8lyTCZklWte
         PpBaQftFV2qYIiNSiqFwMTj0QBqwsoHSO+T3ElD0VRaUMlQNnvnJlRLBtQJRqyYiDWhf
         cgW7ustzy8p1+gUlewqZEfdO4kNXMHKumVJ3CuCa+ZgH6OSXyPdJ1R3IeXfuWAPSdFbW
         VI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296159; x=1770900959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSF3GMzynwkCshZ7kizNQpLPGCKsO3X5EUXhE/ESrIY=;
        b=wT4soedvtKdc2u0FsktF7qARWhOoXXh0bBMoRhzB8b2hVWLVB3hrk54DaDXaR7Mo3R
         xL1PlfrKEwj2JuTBVyaejtrwpyTrUmuMAuPtqVNweONqNR3RsXyfBMchgzA+Y0Ul6azk
         fjkvhJbqTbj2uOf/pGvWukrWTHbg4AvrNKgRTRvxxavudFxarnFVTVCJvag3Fae/cswK
         ltnYSAcMaJvQ93a2e+Q6MtT09fAPjnxvy5cdv/jJ5QxQRHVgNJeMwZ/4PzpwTxb79uoa
         vRKVsf/fjZ98uW+hncujvb0xvqK97K6kVO72Nnm38+Hgo5W9PGUmRsE6xIZJ1FC9dfe9
         iqSw==
X-Gm-Message-State: AOJu0YwaR6f//G7X/6Ew2oOcHnK7T0WlGoxIIT08iydQOPpMx+MDjie4
	QRNPGwVgeQOR+ifi6xZWcxBtc9T6WUenX9Ysp3tQflFqDS6VNgfEctU=
X-Gm-Gg: AZuq6aINDs0dzzfShYmOsP/POuN22KstpbD+xz32axR+OhCYnWH6/oBQYQmJGJ0uWcD
	eu0xLTUWhZ9IwEPHKVP9pqV6qjwS/sFgmKdwFiwuzdQS5qpK20sddhToYgQ6fz4kH+KLtaegQ72
	ezwQDOCEmOd27RB0X4R4yXHFbxcZECz3f6T+oWKMUG4CShkoKCgy6pkSizhOn6A+YvmXgEsrAsz
	DCNHUn/orebk8ESGOU+4WDA80bhjNkAofOLF9okgr45ONc5iYcW6v1sDAkvUct2P6js6UDWBV5a
	ShC+5LS0OzoIVX9UWgnVtHBCmQsIrufXsrLicZthm/4MAdI7Wk3P0ioF8QLxgAPPWvYCHBp74dt
	COCq3SfbitIVIPc3P3uAilZ5KDlqqh7kpU8eNWHc60RPH7loElD3OOscU7eq4ytwmzd4IzGGHlw
	ellXRs2IBsBJcpmhb3TypJF5bO843OMA==
X-Received: by 2002:a17:903:350b:b0:2a7:6aa5:68f3 with SMTP id d9443c01a7336-2a933fb0cf5mr63521385ad.34.1770296159482;
        Thu, 05 Feb 2026 04:55:59 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93386b5d2sm54006755ad.24.2026.02.05.04.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:55:59 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: amir73il@gmail.com,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	repnop@google.com,
	shuah@kernel.org
Subject: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete event
Date: Thu,  5 Feb 2026 21:55:09 +0900
Message-ID: <20260205125534.3286-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOQ4uxiax3v03XeSP-MRHUqx5WTa67qOjtusSw=M-Tk0zARv6w@mail.gmail.com>
References: <CAOQ4uxiax3v03XeSP-MRHUqx5WTa67qOjtusSw=M-Tk0zARv6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76444-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,suse.cz];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alwaysstarving0@gmail.com,linux-fsdevel@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7399F2E19
X-Rspamd-Action: no action

Thanks again for the detailed feedback and explanations!

I completely understand your concerns about maintenance burden and
overlap with LTP's comprehensive coverage.

I agree that improving LTP's fanotify tests would be a better use of
time rather than adding to selftests.

I'll shift my focus to LTP contributions instead.

Thanks for the guidance — really appreciate your time!

Jinseok

