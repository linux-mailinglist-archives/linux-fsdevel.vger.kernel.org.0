Return-Path: <linux-fsdevel+bounces-79129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI74I6qppmmuSgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:28:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8711EBD99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 10:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 611D7305A2DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0D38C422;
	Tue,  3 Mar 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjmeYqGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9490F38C427
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530074; cv=none; b=gRI1M0Rtin2fMPwF5Gg/O07InsNoOvJWU49uKsAahEM7stUOo8WmILnyyqLctJfMkeSibfW1eWl0ejwWy2u9MyY3jeWD9pEbd7QstQIVHpqztlxhjgVFi9GBff9vNS0CT+zyQdzOJ6nw/re927SP0mnNz0RefHDqWKEYgTD+wNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530074; c=relaxed/simple;
	bh=8PYgFNKLrGjH5c3Ue1MbK1r79LbXFLv76gUz2pw7R9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq806VgMc8I3f4WRD1AOYwWg/V6NWX8P1T5GxpgpqeM/7pfsjwhFB0U5CrYAtY3RXDumcTSsEK9ZWj6XRNOzg4AaA4CUH+j1gBwd4x84QcJt2rhVQsxrjbVNzMVzDWYQtRHcSlNajClFa67/avufiLIgAUjFWWUDyU5b3alUSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjmeYqGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CF3C2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Mar 2026 09:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772530074;
	bh=8PYgFNKLrGjH5c3Ue1MbK1r79LbXFLv76gUz2pw7R9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bjmeYqGGmXUeaTzeO1zHKvgvzntTfqK7poymyxDvzZUs8H63Lb6t6nNvQyewKoM19
	 nqsoyAGzFnnE08FKH5AyWqXHWuOJxZwXEZ8MJoP+/wLR5lI4SwNCCWOd7dhrWAvafJ
	 ILVZ53q7IsM1vqxjUE14KPZXPHq2apv1r9qRXD7S0Vv6FWLCJbslrxueTOtvKZds1K
	 AXujTn3lU+c/Uw8v5YNtm1HT7YACCo7MsEiJVm1wuNyLEE1woCex3r7yrOUMbBnCzq
	 e4qKynz6z6ZFhrr+7QBWYijJ04OZ1vsYGCMKDHCvZ875lFrwRbH12K2kkVDPf02GjP
	 hmiDBjBn+CFMw==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b934f8ec6acso645660166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2026 01:27:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yza1nOni5NWiSxumAs+bWE02c72vMG7mhcdxkfhB5KwivK+Ly5P
	7JqgG2JkswIhxDTrGyX91mryjmokIgq8TRdRZudGdjznvIfD/jJgiUS5W3O9qGuAu8+FxHqsE40
	p2VqJ+o25PYRJbwZRvGezbABxyUkxNjk=
X-Received: by 2002:a17:907:2d2c:b0:b8f:bfc9:ae0c with SMTP id
 a640c23a62f3a-b937636cd5fmr1078682466b.1.1772530073000; Tue, 03 Mar 2026
 01:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228084610.487048-1-dxdt@dev.snart.me>
In-Reply-To: <20260228084610.487048-1-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 3 Mar 2026 18:27:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
X-Gm-Features: AaiRm53Xw5s9rhlrdLRiOiOCupUQUbqktqYKD2tb12lYOb5hk0XLrsVyn5z_Y3k
Message-ID: <CAKYAXd_8vG6V0NRT_kb76n_yo+d9vvcx6JZbMARC5+C1ovboqw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] exfat: Valid Data Length(VDL) ioctl
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0D8711EBD99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79129-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

>
> I understand VDL manipulation poses a risk so I decided to submit the
> code patch first before doing some documentation work. I'd happily
> accept the rejection to the idea of EXFAT_IOC_SET_VALID_DATA.
I am also concerned that this ioctl could expose security data. So,
could you please resubmit the patch excluding
EXFAT_IOC_SET_VALID_DATA ?
Thanks.

