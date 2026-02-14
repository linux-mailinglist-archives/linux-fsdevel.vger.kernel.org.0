Return-Path: <linux-fsdevel+bounces-77216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNfoJymgkGnkbgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:17:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0250213C720
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 17:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A638301F31B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FF8259C84;
	Sat, 14 Feb 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMVQMPrH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4018229B18
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771085818; cv=none; b=Nju7haoeZUK7DmUahpWDPdTzefcZ0hmcRA5xt4Gx//G2ijRA+RR6Nhu0KgOKK39aTDEeZRYpNTHfMFs4khhdthR5LkyiEwBFW5hmhdaOiNeuqONoLE+f416XPrn06Efme7pbDIRSMYQhwl8OA33e5KkvcuNOwvPm0/CoNXh2Aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771085818; c=relaxed/simple;
	bh=HVeVpgNfU31CuuYVV8aiIL2MWHkWQzQgRS1vbOVz6m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7mmChp3kbSXmkiValdYqV8hrV0idxe2+gIMwJbWtaDOM2svaC3FQ019IJwhAfgzHq8TlV+i/jlAiMmXMXlPJeuKjDUUTCV9ydgEzW+geUzov90LaNX8wrJzE5MUckcOFQF/qnTltRIUcMFlffezzABJXT+EZZHcFitSXlScFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMVQMPrH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-436e87589e8so2194158f8f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 08:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771085815; x=1771690615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8roLsp0cS1Mf01npFR0chpOY3annfZlR4V9+QIDoWl0=;
        b=CMVQMPrHon3LDu+0TaJTphurmQkXWvmbmivlSYfq+LaqHRwU+Tiud+Q5P5n/pmpS4s
         AU1y8Luv4eAyz25IVtgo2ia0o4s7/Z8PoK5oTrkcMV5hk/q2AnU3EMOhV04Q4YgQb/zl
         rVl4UNX0pH0+haQ86ZoX1vRnIrg4KuHIyrwZ4IY/C9PQBxXbSIhMALd4MM0FPmdUAatu
         cBVze7PyvOiKmFDTsolSB565eyZ9UG3E5REDHaxPWYv6UCRvD4ysLa419n9i6rO6NRBt
         81JT7dnNG4AvV2JarCnWgi1R8waAsvIRkn84Quk7IQuz2OXaw9s1v1QKTbTRAVnhfG9W
         O5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771085815; x=1771690615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8roLsp0cS1Mf01npFR0chpOY3annfZlR4V9+QIDoWl0=;
        b=RLCSxseXDWCopZmEvpDeiZ3R6cZwzDCDwRu1gjw1jg77y7M9bEmcJKu9J+xEpKKrTx
         RNlKQcor2onIHOH7pqpwmbptigwwG/oWmhQuKLbqO4D6XrnB5fIY7Lg6ISTL86enzxvN
         O4vdqFRWv3mOfs/fgbmp9rK0rWG6V5amU0PHuiL1gWJzI8rFYF5Mo95AeQPa6hEkYgj1
         /63YKoFgYkh87D3dIBXlK8dDUBaE6FS/RHVeKrAmLzuVL7hX8FYQYYuDjhF+4cUle+vO
         zfXEWqsrnCYcnn+eMO/dkB/A7q4phum51DGA8ijEq7me7G1WfbFGnFlr+AqMiTJS4rwA
         vM5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMpEJADqNlVC67det8wA3iyh7PlzPC2zp0BDFIxyqyYhlMpan9gMk8yNZhBebXZ26lgmeTcHrLKrth3uuq@vger.kernel.org
X-Gm-Message-State: AOJu0YyQn64ACzC3dxVKEsrk6Kj5gTmenQAzHXgIR53DN3CmBFoZrB8O
	Qp67M6k3aRMflzXsXlVke7PJHb2l4GfC4JsSAbWj9dQjZVDLqueCIkgX
X-Gm-Gg: AZuq6aLRHBitqdJqX7WzRR4U9hZpuRmZKkl1emtnZhlGGzxceoS6G5UeazoBh0MR8aV
	HtQTsJvMiHaK6gQ2vYCoSowcUEmjeT0HRDKc5h/oNd0mOf79Cl5kwYTpvPdJV6xIvxCvW6l2f92
	vDBIYNCR+zC/cTPzI7/flW1eSDX6zqOmns+mvgI9xkzZmOXIC3SFDObMW+ENdmIUHWENIM0vldv
	XoLLT5XtyQ2CTavmzbp3P51w4xTMc+Ey14H6/eBaUrlEcnZwD2+R0FpZAxgu+NF1N7FnL7rLd6y
	YNiCGL13TyjtPpS402Y9iqu+FniItpZ5y4GGfLb6rB3ZA6vVuYaoA+micdZB+swSRZ13eDfXzud
	vWGoBlFDj4GYg/oW/tF1ZaHASWjYiU0/P5/pTQVXJ9Gw3aVNMJxzzCNqSF0YYh6TQRXNhPjgfFz
	C8JqbypYJHOWUQ+2BU6Kk=
X-Received: by 2002:a05:6000:603:b0:432:84f9:8bea with SMTP id ffacd0b85a97d-4379791cfedmr9748855f8f.51.1771085814946;
        Sat, 14 Feb 2026 08:16:54 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43796a6c1b4sm12706912f8f.14.2026.02.14.08.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 08:16:54 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: christian@brauner.io,
	cyphar@cyphar.com,
	hpa@zytor.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	werner@almesberger.net
Subject: Re: [RFC] pivot_root(2) races
Date: Sat, 14 Feb 2026 19:16:50 +0300
Message-ID: <20260214161650.1383011-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260213222857.GR3183987@ZenIV>
References: <20260213222857.GR3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77216-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Queue-Id: 0250213C720
X-Rspamd-Action: no action

Al Viro <viro@zeniv.linux.org.uk>:
> knfsd does not.  There's an explicit "give me a separate fs_struct" since
> it want ->umask to be independent.

As well as I understand, knfsd is NFS server.
NFS server starts when the system is already up and running (as opposed to
NFS client), and all early rootfs transitions already done.

So this should not matter.

-- 
Askar Safin

