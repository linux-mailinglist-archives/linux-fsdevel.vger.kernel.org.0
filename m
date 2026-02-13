Return-Path: <linux-fsdevel+bounces-77164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJctGBlwj2m3QwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:40:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAB0138FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 19:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A96F3034DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Feb 2026 18:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AC5280309;
	Fri, 13 Feb 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JI38AYIo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AD1F9ECB
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771008020; cv=none; b=dqW8EVeo7tiPZJffErvwC+Vrq1a0DVL3ymtQg+RBDUzu9FKUDxY6SvnrKOA4JuuWR/UWJB6R+plkeKzXeuZo5j4LyJVw78KYIN8GHQ89qqmAad+YclJt8i/Gkd5uHj/Bu6VHBdaleQJLlRAEv8RopCH+7BhFHsgFmRPTW0hDb8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771008020; c=relaxed/simple;
	bh=7owsVhzLgLVjm4lpjaVWcqsLz9QQ4wChtLG2RKsf3bM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YVNc/BGmUQlg6LuWnBG6ZrF9iemZbO2pYRZI5BBYWXD/8w6WoCP3R0kLzpa2UNElQvXeK5qucB4uTZHTmKSCSVRGU2HIhhqPAIjqbM8qwApK/dxaevfLSPOM3M/Z7m42pwKI/g4lIynwIk+1tPpEpDPxWqHQP12LPa3EFZjpb+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JI38AYIo; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8fbb24a9a9so97629666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771008017; x=1771612817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TRuN54rPZKbd24m14YB/cY0GmGvj7i5Lf5+QyZOJi+E=;
        b=JI38AYIoeXa/XksiRg5TWi2GmOFoh5z9XiGjwiPFJn25kq1Za375bhFEqi8J4l3gGg
         kAgO7ERF6+nFOD9xuE2ecZkY/z6rTILvgg2vzy3Z//riEeSCD3sOPaI//qFYVFR4Ksf9
         whLWEccZ6UxX2U6/Xs/VKjyOE+6Hsv+jv10EI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771008017; x=1771612817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRuN54rPZKbd24m14YB/cY0GmGvj7i5Lf5+QyZOJi+E=;
        b=aSp7jVSr5Jso0dbuD4amNjWlbmKIB9VCXyX6KjqGT5Q4EVYwyYpENf24MpYgaJVYJh
         uLpaqhG1fudnBbbpjkQT+ZQ6dfkGC3d9MUNLIIPU7q3+E1z+Tjo9LALXmqPgS/NmdItV
         UO4UZx4ymf8WTbsYp0KbXoWf+z6bZLGlBZRNHqjHtEpCBluKTIMll47yKjmml4xsLglX
         VmvbcVS1Mq29yo0iFGHXj0UFnzGrIKevOR45sqebguf0EoCv5wlCrm54zXLQHIlNb8/V
         IrMDtJKqJZ1uzK6wHupNVB1KQzhXc0xE0ix3jThrCUNgzrI/nP/ZF0xOkV40PSTBP2Ck
         42Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVvbY1HrM2kE1uinalZjYb1cIfF8gyzraAzfk7OmjbR8ClBMXJVX6g+PO8FoppfrBnpItGD0c/rMF0UynrE@vger.kernel.org
X-Gm-Message-State: AOJu0YwEn82/2AuugLWH4im7dDTIXNLtuINJOqCAQfVZRDPpvoQ7ecVs
	4mLyH+KTsn5TsLHrJ/pgsnBejdjyc7rL8PVpbaO4plyBqTh5yTV/2Sbg+ICoWoOIy7CLm/yR0e+
	01ypw1hw=
X-Gm-Gg: AZuq6aIaQoXwQ/Lg5Te9SDzwrCahlwiA3rAcOhTpBar9b+ZMjB/C/+sX+/wrPf3ZOEp
	Ywp9KYSDCP4x6bkefHldUPZ5W2Z4liPLYxmyKp7i74OTlgwP0hS/WdIgu47/Zt2gOvqKtwasA8D
	dMpXm+D76c0xLa4KN1TvzUkZmZn1MoyAKgc4S8TrUtIqBJfJo7K1v+p9kFQyJ2rxl+KqqgXHkmc
	csevabl3pdAL1m5iz9YedgwSX07nCQ+CubTb+IuBPS6mtO0m03VYCKDXNONVYG3wtCYBTZkVgQU
	lqyGBcZQcso4M9Dwcv+DyU0qxuU/Ry2IWo5EBkhhl7ybFbYA6LAam8BPvclMMmR0EmAp82aI1K/
	prhD7rTrhPzQhBEZapRPcaT91yGaDXlm3mjWS2nSSoj4OUHPnAXfbUPFCjfa/s4wW2b5cW5e8cq
	iLZ8STg+BN7HUdzWKDFbkjg2bp6fm3rg7qoUAEJL6sw1iWtKJlmZuQJfDfxuVnlmnsTsBT0VVe
X-Received: by 2002:a17:907:86a2:b0:b8e:d4ed:5ed8 with SMTP id a640c23a62f3a-b8fc0661f4dmr70186066b.19.1771008016613;
        Fri, 13 Feb 2026 10:40:16 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f6ec34f14sm284168966b.50.2026.02.13.10.40.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 10:40:15 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso2490520a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Feb 2026 10:40:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXn1mrk0pE5LS8KU4Z7aJlLXvdGkhp5DRPRPzUYg+mwXZ2a4fJ4gwVI3lkXArsNIJAJ3juSiJmlZcnklBeJ@vger.kernel.org
X-Received: by 2002:aa7:c3cc:0:b0:659:a288:d7bf with SMTP id
 4fb4d7f45d1cf-65bc428e625mr458842a12.11.1771008015762; Fri, 13 Feb 2026
 10:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgQDOUff_F28xaTB-BvSHs9YC3bxXJa0HjpSTAUyPF-Ew@mail.gmail.com>
 <20260213182732.196792-1-safinaskar@gmail.com>
In-Reply-To: <20260213182732.196792-1-safinaskar@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Feb 2026 10:39:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
X-Gm-Features: AZwV_Qjp5GEycDQnbK-birQ397-RWVB6LmaBOivn9dS1H3xtwmaISg5szSy-J3g
Message-ID: <CAHk-=wiB7BN2BnBjk5y2Zim_vveYg7GAZA_N+XjrptY59Qnzzw@mail.gmail.com>
Subject: Re: [RFC] pivot_root(2) races
To: Askar Safin <safinaskar@gmail.com>
Cc: christian@brauner.io, cyphar@cyphar.com, hpa@zytor.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	werner@almesberger.net
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77164-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BEAB0138FCF
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 at 10:27, Askar Safin <safinaskar@gmail.com> wrote:
>
> pivot_root was actively used by inits in classic initrd epoch, but
> initrd is not used anymore.

Well, debian code search does find it being used in systemd, although
I didn't then chase down how it is used.

Of course, Dbian code search also pointed out to me that we have a
"pivot_root" thing in util-linux, so apparently some older things used
an external program and that "&init_task" check wouldn't work anyway.

             Linus

