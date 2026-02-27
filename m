Return-Path: <linux-fsdevel+bounces-78705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PczGCF8oWkUtgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:12:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99BD1B665F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 12:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D61306B080
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 11:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EB93A0B28;
	Fri, 27 Feb 2026 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F82p14/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412F128CF6F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 11:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190748; cv=none; b=tH+p9iRGjLJnGZk55HbOpiHmCz405tv45h6cMgvSLeVHM6J9RHJZepRXAWu2Ia4XDXUEdeMjQyLMdJqor3S24GOlzmaACY6tWhdZBjjqcLQ7Dz7YuVUCQR/eFr/ActP/xbgHSiJyKSKbpWvBDdMG0yXDyI3CCcspdldooog2I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190748; c=relaxed/simple;
	bh=VG1u1tKzr6sjrT5rSGU1ABzEzxey1xBjG4v00a1QNmY=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=LTKAGlQfVHQdQCvq5RZuLVEe5pFMDhirLyNGJ9kxFK4+zyZ+HxDgORnzIHaXomxQKwUKQVrMt8GRfgoAM03Hg/7c/KMN4s09qOpnYardhTUunzSMymv/lQxt7Bv1oOVniiPOktkVK7nuJwounfU2eLJ32nB/DlqzRMueYy/9Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F82p14/0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6e248aa446so756167a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 03:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772190747; x=1772795547; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXKkuoClgu8LyDrSxmF4sWiob/0b5LO5w97pa2VenZs=;
        b=F82p14/0XGzu4mooyGWDJk/fvRVU/jR/pE/gUkopqHjlKtWknH4h0P7Fudj0S7VHe3
         HGZTnOsat85npFP9F5dbG2q5H5awhnb5fgzDRkMkbLMKB8BbJclnem5oNsdrXAltmL3O
         E837K//0jXgh87QVRr1A+iBsB2XGxnmV4eQuzDlW4u2CYFKG9NkFaXBrykyuMGcobrTn
         lzZ8c+nYvjj41yBKNWG/bn9NfvdFEceEdHA4qRjHzxWGljNxALHNdTquSVyzO3iH7mI+
         CLEJd+aEp/5YpDWh9A9S+hwNBsZklyIZNLcsNGRu1uhqy5SLemdNJiy9X1s+SuWwCarf
         5jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772190747; x=1772795547;
        h=message-id:date:content-id:mime-version:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXKkuoClgu8LyDrSxmF4sWiob/0b5LO5w97pa2VenZs=;
        b=rn8YwA2gLJJzCEOT2mGyVTcMXF8GEpP3eV7PliecLyNAFYBLNHUicVrR8znnIv9JNf
         R1nscXw2mZfW2FFRcPz5PrOmHgGrDsflAYdhkC3LPUrQgvUmoBpx50M3zAkWOTHuwc5i
         J2ffGCUANc1QJi3ewYFFtHtfm5d4guxy21+5ZrZvxgmQ1D0EqjlhYBJMb6+tScvFS8/d
         p5CiagsVoeA56oF+hjxTZ2s6jPRb71mRhVpClZ+lqdS2SGLz9bM0tVZ/95oUMJaJle0D
         nstqAaMd84m1yC0+A/gvHdzm2UYQjBM/H3IAxP0IHoLRCR2Wu9vKjdqps4Bi/wc2hETM
         ZpWg==
X-Gm-Message-State: AOJu0YzcpYqlo41N0gnrhFDA5qvqxH00x+b61fBTQ/SGdDglO17psSb/
	jZfvpoOEFoiDoHvevCMu5Bbh2a1fcKUXwFfKEIk7PkyVoyp6uUKF+RZoHhwXWQ==
X-Gm-Gg: ATEYQzzIEapP22IAaqJNYws0TOkLS8iEDJiEf1MrM5C12We3IJ0UbZSNmmTvdglNbIs
	44RjLE/oTRnJpMqomPbW5wVicQF269fB89H8+vpkr/E/L/vUnwKloXjsbP74v8LMzsOn2uAVONV
	pm+7kcbdO6EF60zMO4WQcIXspOU1+gc69cOdWUwZC5Y9vVVQkL8HUVwWzTeba74xGDQTZNFAfov
	RfRs3AfwTi1bqWyfVaeSZ++Ru539vI4VVNZLHR1eyLKP0MyWfTS8aNgvMTuhfhmgSjfm7WDwY7d
	p0WpptjzWqBap7pUMLP2rqdEzTKqhInPu0XF4mUaSFa588r1qwmIn9DWaLfGRJwtrM8qrOMWivr
	9xEu/r42fBgFfvGoUjSl4m+cgaTzDnbna+cPPOs06DWhEfZ63S42BrND/RO6Ove1wafpX5TkBAG
	6nErJL4laB3BxYf1RAVA9tEQeIXaqbu1mZd8YRzghht46xa1sHjFtLg8SVwlWOrY79
X-Received: by 2002:a17:90b:5383:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-35965cad95cmr2126624a91.18.1772190746481;
        Fri, 27 Feb 2026 03:12:26 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f6e0sm11757433a91.1.2026.02.27.03.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 03:12:26 -0800 (PST)
Received: from jro by jrotkm2 id 1vvvL8-0003mb-39 ;
	Fri, 27 Feb 2026 19:44:59 +0900
From: "J. R. Okajima" <hooanon05g@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Subject: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14543.1772189098.1@jrotkm2>
Date: Fri, 27 Feb 2026 19:44:58 +0900
Message-ID: <14544.1772189098@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78705-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hooanon05g@gmail.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B99BD1B665F
X-Rspamd-Action: no action

Hello Al Viro,

By the commit in v7.0-rc1,
	154ef7dce6a4d 2026-01-16 name_to_handle_at(): use CLASS(filename_uflags)
name_to_handle_at(2) stopped handling AT_EMPTY_PATH, and an application
which issues
	name_to_handle_at(fd, "", handle, &mnt_id, AT_EMPTY_PATH);
started failing.

It is due to the commit dropped setting LOOKUP_EMPTY to lookup_flags in
name_to_handle_at(2).
The commit log is empty and I'd ask you "Is it intentional or an
accident?"


J. R. Okajima

