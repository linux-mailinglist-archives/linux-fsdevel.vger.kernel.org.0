Return-Path: <linux-fsdevel+bounces-79664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMLvBVY4q2mkbAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:25:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5F92277A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32E163033260
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B80466B7C;
	Fri,  6 Mar 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iETagLyT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251454611D7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828745; cv=none; b=AQqBVolXYQOiC3F6WqCi468XLbOnJQUmjFZrwqOB0dgvpdVol3DCVlylPgDusS8x9ozGTySJOhVVQLh6ptaL+oGgv6yiNpQ1iCxyqX7mFT3jDPOt7DURDuSZFuaj2STr+IyoPheT1S7BtDQUr4h16L1OnkLolsyfBMW+Icjmgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828745; c=relaxed/simple;
	bh=fL2JgYqvFgG2jo1CEhVYJcdYaruh0cGQxMcZdwd8dvc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=MxLEqUD6xZsomfRmvUChkfGNUESnzR1tU9sRgPK+g2TeCfwp/aLoZInjQlepMWfWqk2QTDtvKB8AODL+o0tNH5VUwAzavBniBU/TycPJ/EkH/3OSYz8PJjNwZhfZbjhmtX08f8LhEbQ0TlR7iAgam2hG9ZlO7r/INLb0TYImjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iETagLyT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so1697585e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772828742; x=1773433542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL2JgYqvFgG2jo1CEhVYJcdYaruh0cGQxMcZdwd8dvc=;
        b=iETagLyTDF/1O3A0fnQZDjAnZjHGM1ayDTBpmrMqnPpq+ArqkI7zvJcpXDM3hV0mY4
         HqHJd3uiBoE4Ou2tdfPlaBKboprdsb1UMhGA5tJbpBKues+s6XvzQOKZhoxnOm9NLzj+
         x8hDLgr6jg4oFIWirfk17JglIC5RvfddjFh3VhHDOPCKQO70gf9Xg4i/IkEkX0oEgDsZ
         XcW0A7oxvhyCV9gGb52pyNfftUvMz/sjtUFT0goizkXeIKnje66iqiUZuzwmnleE5QLt
         oISxtOI/8o0h8rpuCrwsWH7IPdRn9IvoW1Oh+OGs2/rSBzOSL6Dy4g5FMkmy+MviGr4w
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772828742; x=1773433542;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fL2JgYqvFgG2jo1CEhVYJcdYaruh0cGQxMcZdwd8dvc=;
        b=oHogCdLe8oBkX4eMW7PdasREYs1cAsYo4b0bSa93AvvF1WqB1ZGuO2+9mI6W0s04TJ
         SyQRf/smMxdoCgJxcrmMLHKu4750a5BEIRFfJLh3w2hdS3kq5FpCfOfc31WjNIat8fpE
         V8g9WZaPWkZita6jPY2TqdNTS7hhMFEuY8ZpaNCmhnuuwfyJa+JboRw/X4T6UxDB2Bf2
         G0hUWQ6+FfkhiSPRZo3SuiLFNa62mt7Z3d9FEZ5n289x5ubo+6i09uWfliVZXEiXGGAe
         6vZ8iOTKDpk8tWjpOwHuOqCasHux8nqMA1vxR40Lx7A8uvHj8BO0i9Wef7KTsjsepisF
         73Uw==
X-Forwarded-Encrypted: i=1; AJvYcCU2QPdcQIflfBUCFhDX8EeX13AU+C00H9cwu0uyMT/Sfm0rsRkixOU+cbbjliCuLyjN4oMNOqJPsHfGHmB3@vger.kernel.org
X-Gm-Message-State: AOJu0YzG/2A22IyM/yG52JQ3/FQuifCLbt5MaIN0XiOTlfBvEL+dTpcA
	EdmeNIjkzHkZ1E8+EeZE7iPb1M2HyBDEzFtMHLAZpL6ThQPl+sxDKSC+
X-Gm-Gg: ATEYQzz1sznHPTSadCPsiOouOxLEYnG89MelPnRuRDhF72ej7UBBmfW4fgKLlO4RC75
	xX2hpBwpuFCzwU9Xua/jKVAs3aJaTXdrVe+pTZahjyd5uLM7JyoACUtwqkDoQJ51l0wEmkzbGdP
	RXrwmBglkf3qpE+wkc9SpJ0ObBd+gKaqWO0vn5chLCTwdUptlbSsKYm5SHNnNxLH4+BWTGeTy1j
	lF+seUcdUQZWvyf+KoGYlvR26FSFdMjD1RsN0nhFg/7sjG33oDKXUXY1zlJS+ba8j4qcJIc961t
	H/347ih99zDHqLLzSIBhGG/N3Z3ycAjia8PW4bcidFvadnuFW0D0b/PuMcDT68zjnuO25Ftk+w6
	9cQMgFMJfoW0vipT9HkydVVV8dlESdOvrV3MVsuntY8AiQTLLgjeipT3xXDeotgpDmNXgeoJrG8
	LKyZ2sT6YvYczqoVLZ
X-Received: by 2002:a05:600c:3d90:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48526930a4fmr58858405e9.12.1772828742211;
        Fri, 06 Mar 2026 12:25:42 -0800 (PST)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2bdf8sm6376995f8f.25.2026.03.06.12.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 12:25:41 -0800 (PST)
Date: Fri, 6 Mar 2026 20:25:42 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Josh Law <objecting@objecting.org>, Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Message-ID: <64ea7b4d-1d55-4d9e-8fef-396613e8bc10@gmail.com>
In-Reply-To: <aas14HsY7dj6jTDZ@casper.infradead.org>
References: <20260306200319.2819286-1-objecting@objecting.org> <aas14HsY7dj6jTDZ@casper.infradead.org>
Subject: Re: [PATCH] lib/idr: fix ida_find_first_range() missing IDs across
 chunk boundaries
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <64ea7b4d-1d55-4d9e-8fef-396613e8bc10@gmail.com>
X-Rspamd-Queue-Id: 1E5F92277A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79664-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.979];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

6 Mar 2026 20:15:29 Matthew Wilcox <willy@infradead.org>:

> On Fri, Mar 06, 2026 at 08:03:19PM +0000, Josh Law wrote:
>> ida_find_first_range() only examines the first XArray entry returned by
>> xa_find(). If that entry does not contain a set bit at or above the
>> requested offset, the function returns -ENOENT without searching
>> subsequent entries, even though later chunks may contain allocated IDs
>> within the requested range.
>
> Can I trouble you to add a test to lib/test_ida.c to demonstrate the
> problem (and that it's fixed, and that it doesn't come back)?
>
> Also this needs a Fixes: line.=C2=A0 I suggest 7fe6b987166b is the commit
> it's fixing.=C2=A0 Add Jason and Yi Liu as well as the author and committ=
er
> of that patch.

Okay, you mind if I put the modifications to test_ida.c on the same commit?=
 Or would you like it on another commit

V/R


Josh law

