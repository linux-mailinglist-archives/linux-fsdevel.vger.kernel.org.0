Return-Path: <linux-fsdevel+bounces-75984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBf8CUJefWnKRgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:43:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785D6C011D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 02:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E409D3036D5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Jan 2026 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8E328635;
	Sat, 31 Jan 2026 01:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X1QwFprT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1969328B67
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 01:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823734; cv=none; b=Qe85L03d4FjFUJmItm0VlWLUbkMAwP1F4YmTHeDc5vx3EMVQo3BApjXkgRRkU8BxmxP/rlu7CCpsJB7IXnbHeDVPlMOt8WSGyNj8KwQN06y76KXkxdmLEOtk+qCrG0euP5JI3CbMZAimGTBikU4u/AIhh4RbO2WhXi0V2YM6PFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823734; c=relaxed/simple;
	bh=P/AkJ7VMQl7xg3h+SCs73opP330uFlSO7pps2YFNAtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGNc1XmY6M56ktkNoyLhXA46w16d/xa6fFibxE0BMuLftlVnKlZ5De0O1V2XkWiNxIA18l7RbMesDk3fuPHMV48uXc5xI1fnKLyCGT5t4MJR3wzP8UkDYNTqbR8/wjbNrjSSj7sf05QV4x8ynaUh7g/8iNcHDcZFzB8Gqxmgwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X1QwFprT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b76844f89so2506505e87.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769823731; x=1770428531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=X1QwFprTEUewGxYnOCbEn/hPSQq2oZfZ2bRrQwK1Pb7P/VnzIwZkLs7kFCmINknTSQ
         dET2ZM0viOr1WHKysqI1GYnZ1X+MwtiJDh5TxzMCs8chAyTDIes0rkdeYyNs66bTuCcn
         W0FejU7h45cJ/HSG3C2Pg2ZAkawsRT9gidNd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769823731; x=1770428531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EPpl6A64UKlYlKR2j1fRkib4LdNnz2WqgktVIjm2uzU=;
        b=X6eMMoIpqJSnFWMBfyYMNfKqxjW4xZTha9ueuB4DY8Yfmp/7gdkF+mZRA3Uzgcrpw4
         zQo9hkgweGJFrGl5HFlFwk+MOF3BSIE0rn70TPVZVdsKuovI+jEKx+PZR1hItHhyRPsF
         eWMva0D8/RzaEyAfuiQkVp7852m/apMJjtBX/5KIIS2aH58tBWo62NYj+NoITs4Y/Cmx
         d2rtanR8ZqpN8xbHgiI5TLtYt87cXGovVpyv0CNeei6Y5V8Mh6/SCkFK2UtIVD1KaNBA
         psdTyx7g1F+fhSzmswbcY22bjToWCkppUMquPASgfP+mXCl47mrJwCjfyVd4sgz7ZoNm
         GFxA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDmy9W4hIYlImzEKPk6gAuvjAlvbhw83oftXbpitlsMoWvLsJYSfjsP0hMnYaE1NQ8erDLIvbD9fNzVHB@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWeQo6qCUkI5wODJYk7rfezHgGeJoIUnxsE4c0DqIshR40ynT
	ynrpuaee2rAl4ga+v6kmnwJssKs00fmR7j6w924Jr/YLVLkkpGYcZsybl35dbOesdplHE3QjyUQ
	gEXxkakx9Iw==
X-Gm-Gg: AZuq6aKRys8CaCcXadydGDQbmUHf7Xe8AgDw1uNU6sZJav+Ri+DqUH0dKVXCbsbQ2X/
	v+95VmivJ4eV4nfhQ5XmyHtBdrZ9N56SY0Q15pb2WaqGxr/jT/L5c2wSGfG8V8nPonxjG2hz2p4
	oGFMIEVzFRrRjJCmgRUgUdkPmGG/W1OqSY8YsPMygCclS9SUv+BMJmLeVSDtNpDOtglGvoKidQC
	ovwqwm8bTY58TSaYRO5lJ/mJ4cD9kyQ4jgExrS0+A9KYuMfy0JoLOxJ6C41/IFgor3Z4VRSJfEZ
	6VuvR9ajgvYoqp93/GcNvIlTqg+Xfze6G7wqKeRFoJ4MqaVdZURVdQVqxc615T+Opei1W9er8Ke
	VhICrsFH2h/9OeBlseqF4VNLDzIHG6NhO6CFJ49Ap048CyCv8ZQ9/tL3Za0xnj+G+Giyt/83iEx
	rK9PO7ryadI5OJTdFsS8xOD9m8fQAV+keQw0LXsPedoO8XnwKa3W31jTMCqtThaagk53eT6c8=
X-Received: by 2002:a05:6512:3ba3:b0:59b:79d9:6cc with SMTP id 2adb3069b0e04-59e1641adecmr1834391e87.33.1769823730892;
        Fri, 30 Jan 2026 17:42:10 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e08cf8c2csm1922411e87.20.2026.01.30.17.42.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:42:10 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b9fee282dso2495778e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 17:42:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgNmfJgosbbkvZPp7fjqEew1BFKa8ap4VESnDWk/Ebg+pZ9pcAQn8DOsi9m4DhY5w/vEXx3Fx15fKMsOxe@vger.kernel.org
X-Received: by 2002:a05:6402:35c7:b0:658:ba49:96c2 with SMTP id
 4fb4d7f45d1cf-658de54e61dmr2863591a12.6.1769821915767; Fri, 30 Jan 2026
 17:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com>
 <20260130070424.GV3183987@ZenIV> <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
 <20260130235743.GW3183987@ZenIV> <CAHk-=wgk7MRBj4iwQLHocVCa94Jf0cMEz2HzUAS9+6rGtnp4JA@mail.gmail.com>
 <20260131010821.GY3183987@ZenIV>
In-Reply-To: <20260131010821.GY3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 17:11:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
X-Gm-Features: AZwV_QiG_nByRrd83VYAdhaCU5_carsYUlImGLyJR9w-28CTqo3phlyWLRwFL8I
Message-ID: <CAHk-=wiXq-bPyKywNOw7z6ehrVReyS-hSPuQkJvuhJWfXGFm=A@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Samuel Wu <wusamuel@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75984-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 785D6C011D
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'd rather go for a spinlock there, protecting these FFS_DEACTIVATED
> transitions;

Yes, that's the much better solution.  The locking in this thing is horrendous.

But judging by Samuel's recent email, there's something else than the
open locking thing going on.

          Linus

