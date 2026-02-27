Return-Path: <linux-fsdevel+bounces-78744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA/9GWq8oWlhwAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:46:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7751BA37A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 16:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D0E33191117
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2A943E48D;
	Fri, 27 Feb 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RleS3wJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7533E8C5A
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206949; cv=none; b=WRD26E2cGwWOi4xBfieALnMjBynTWeewDzQjAiiwCaZnMiq58SFVWfyeAu6RvO0tI4rQhoXR0SbcyI3bVnD4dA9QXu6MUxChWU8FEzjNDtBscUZ405JENd9b4WmITAVlXXnCl/zSQnl+lNBQYWSF5ATZ+0lIGRkbc/FHCUkxEyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206949; c=relaxed/simple;
	bh=nX/jHH44bl+AlT2PlBDE3dEu5Z+loqlx8IDa3H7UJKU=;
	h=Subject:To:Cc:In-Reply-To:References:From:MIME-Version:
	 Content-Type:Date:Message-ID; b=gFFoZGMViXK5CUDPsHcSIW7LuhU95qXwrYtcM5S2hjrI8MXRkszLWV28PrKqYGyZNc0QjCoN2Ud7LAzKtQvDfDfiM/gTa26N4SgsMbEzTG8dLMu9XFKcKr1ILbzCJe+tvpm7c8k2cLzJnEy6/+R6+P39Hd3V/EmZ7bfl8edNrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RleS3wJm; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2add623cb27so14683385ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 07:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206947; x=1772811747; darn=vger.kernel.org;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=s2jOgbxrjWDyh4FLNcSqpUzf8JY36cLv1UD8DXTlkg4=;
        b=RleS3wJmaD9ZQzVS53zU2KcNXi0pTlYt6KiPUgBNWW8bFF/Xqy0oJ1EmStllxpxBv8
         SZ5OtWkHPQCFt8A04ITi3CsCVIB822MO6W1n+gXIoClHpP/VaRjBE6j9iO3lg8Xqsbah
         Z2n1kwiNrKBWp8+gA/8juB3v5wnp23AvTrRSMk/b0skDotylPSGeyUhqqs70boPUSTUb
         A0TH9BYS/7la9rHTTnE45SXPRE8r9+R/mYNR9DZB7/weseoq65/Z9F6p0XCsC3NJ7OId
         9j7dAaBKajfwjAR3ZG957F7WdG8C0IyW38pm3LuJ/dgduFsiEahk2jV1/amzK3rbClHe
         IEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206947; x=1772811747;
        h=message-id:date:content-id:mime-version:from:references:in-reply-to
         :cc:to:subject:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2jOgbxrjWDyh4FLNcSqpUzf8JY36cLv1UD8DXTlkg4=;
        b=hIEXLoELaiMytebNkim03iYoJpG9kfKhUtjN0F2prCD6ly0nvhQbJss8yZjy4JoIZ4
         IvorIYVQGg+W6KdgxE2zLI7X6AIoGUj/Rn+hNte9YSryLiEbhVBT3SHo5e11i8ivZoSG
         Dfo72rGQxP99RyQ4jCWK7f7cShoKW3vEkny9JQyhkFnlfLCTOlNZIBAgyxY/WJKZbZOv
         xK25/Y6sDsTmlMig05JRNmnqKD6QJaQ9piakzsCmO5iU2sLRZ4lGiBi5RaIik8kRUNma
         zf9NkXjfNkEmQohC1aOMPZLT87hjP6jDjNWUFKDaJoYLmuAsS727bLWjtUzs7Eq1e7Xe
         kHuw==
X-Gm-Message-State: AOJu0Yw1Wr2wpvAr2+Otppa9aPTNBgSjm2k9xLwwfNYusdx4MaZMjFcT
	Ha5aMFVAf620CZyyY+qJ0MdMt4yeLXFPb+vxQl1EczWCE8atSFxpGg9VIyLJXg==
X-Gm-Gg: ATEYQzxy22qpwTSNM53cLtvaxko6prQ5ZEMTsHEHFoL+wYWxrbqAW7SwBn0N9A865aB
	pIdyEWFWOwPR2E/OCu/X5LAf8P52qDjBll8f66aHmIOEGDyShbaDI/VieJtrcioYwsxIvP8JMzz
	ihmfMA6Yz5vWHsvleuZeyBfHgnseEtp6fAjjdnQgNPiU3psGNKl2DcbGo3EOQUuBxQr6FFpe2PY
	e2XXpnA5OjxOqkq86KgySKXH95pglNfwmVMz/dm6SxZcdefz4jnMQUZRr27TvcylfuCX+6yBBzX
	sfZwo6yqwDNvGWXnm0WbAsX7jHwM8rakcteAc6hKWiWWzG5Rllh8yr4SSIvMx8wFbcQEIYqcqK3
	yUBHNy17TekDuMwmwDezkBj73V1ataB6y1rjrjL3CWcFJyIWMJcm6+KF38QZFOFlp/oRTrk+b90
	4fFaiHD7I0GZ4VujXOO3NpMP5KtNKbWc5/di1vMdUeYc4dwK5Z1dUgjshe4BQv6S9N
X-Received: by 2002:a17:903:41cb:b0:2a9:5c0b:e5dc with SMTP id d9443c01a7336-2ae2e41771emr31253665ad.54.1772206947234;
        Fri, 27 Feb 2026 07:42:27 -0800 (PST)
Received: from jromail.nowhere (h219-110-241-048.catv02.itscom.jp. [219.110.241.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5dbad2sm59167885ad.34.2026.02.27.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:42:26 -0800 (PST)
Received: from jro by jrotkm2 id 1vvzxg-0006qM-1j ;
	Sat, 28 Feb 2026 00:41:04 +0900
Subject: Re: v7.0-rc1, name_to_handle_at(..., AT_EMPTY_PATH)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
In-Reply-To: <20260227152211.GB3836593@ZenIV>
References: <14544.1772189098@jrotkm2> <20260227152211.GB3836593@ZenIV>
From: hooanon05g@gmail.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26308.1772206864.1@jrotkm2>
Date: Sat, 28 Feb 2026 00:41:04 +0900
Message-ID: <26309.1772206864@jrotkm2>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78744-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hooanon05g@gmail.com,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE7751BA37A
X-Rspamd-Action: no action

Al Viro:
> This
> struct filename *getname_uflags(const char __user *filename, int uflags)
> {
>         int flags = (uflags & AT_EMPTY_PATH) ? LOOKUP_EMPTY : 0;
>
> 	return getname_flags(filename, flags);
> }
> is where AT_EMPTY_PATH is handled; could you check the arguuments it's getting
> in your reproducer and argument passed to getname_flags()?

getname_flags() is not a problem.
For me, the problem looks that LOOKUP_EMPTY is NOT passed to
path_lookupat().


J. R. Okajima

