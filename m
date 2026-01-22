Return-Path: <linux-fsdevel+bounces-74965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMK3L4GTcWlZJgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:03:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E0B61259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 04:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BE0C485EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 03:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164723AA1BF;
	Thu, 22 Jan 2026 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIwX65XU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BE53939B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769050861; cv=none; b=jjiCP91mfiplq1ej/bHeXeaX3PODcNYSGhuQ/z8dusAMyaZNYuah2PGoRJuejN/UdznDnzBNYvUr2TFDCbZ++fWdh0xPWYn29oAr7Xg9g/3usEv6glzTGihuqyJLwWAoovs5lhBXmwYh89xppVcE2ep6E+ayy3ni4fHndspMVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769050861; c=relaxed/simple;
	bh=gls6KrMY9MoZr6IyIOp94QaEs8EmwWve6vYwp5J4ymk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8WcSjB6HX9tZyQI+tA1tmnug40ZaXzU/OtjPGb89qFvTxmUf/5RlUyRZNa2CNuI1x5kKqJf70LuRQBznoSF+26daEnnzRvyIclQ33TBQfrE6yz50k8ZoZpC2OKYRCiLp9R+MqN5ZMl6wV2SVkIuL74jIrjfCjuhpLCkYH0AMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIwX65XU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47D5C19421
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769050859;
	bh=gls6KrMY9MoZr6IyIOp94QaEs8EmwWve6vYwp5J4ymk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dIwX65XUDIP5f+ikHsYxx4MXWdxGzo9LepVeHKQvk9CAkpspgd+zk6/Mw3h9ld4Rn
	 zYH8pmjdhnwyCAHLMUDrDgSxd+09xx4KUALagcnu9iUQdlToe/ho/pzu7DcXwh6HnT
	 7iQWsdP1l4TvZhnXxfQwbW34ft3BU/2fm/glWkquy62r3XHcAh3JXwKZhRfbGF0KzL
	 K5IBM3faZF+5zis9qDQXOD0Bhw8sn54k/cQlkrJFyGuuF/B3v0wjwdgoQ3p3ykjU+f
	 z+t0QDtPONmcihkRbuFFRwM6w5vCYGKCAJavUwQcBvgKW/l0NNFrf+BJX09EVjTLs8
	 nNb5fSVcpHR6w==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8946e32e534so7007446d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 19:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCULcqLLSrJfxs3FMULHf32zrHJ6LohbvpvO3dYO8+48TkD67R1r1KII7T5Zj9exBGey3aW7z0xUEWwl1Y0i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuguh8b8u1Rv2zjkHdffibJ8L/ARHwqAMRE5YtEYAj+i1fD64z
	QQ6h/KnWc6tOAdnofJQwiNDyUBAgP7WxbRwS66pgxM7nsfx4MghBSa400vzAgWaxMy2sxOIWiv2
	mvhnIeifsX3vGHFphuNsF0D4MF+avjTI=
X-Received: by 2002:ad4:5fcc:0:b0:894:6d3c:224c with SMTP id
 6a1803df08f44-8946d3c38d9mr110250046d6.13.1769050858324; Wed, 21 Jan 2026
 19:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
In-Reply-To: <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Jan 2026 19:00:47 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
X-Gm-Features: AZwV_Qgo-qjEoC_t1HYBQPgad9dLpsaDnf8VZt7Ye_LR1Q6ggGfcYM7fpBfpXmU
Message-ID: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Paul Moore <paul@paul-moore.com>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74965-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[song@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 81E0B61259
X-Rspamd-Action: no action

Hi Paul,

On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> >
> > Current LSM hooks do not have good coverage for VFS mount operations.
> > Specifically, there are the following issues (and maybe more..):
>
> I don't recall LSM folks normally being invited to LSFMMBPF so it
> seems like this would be a poor forum to discuss LSM hooks.

Agreed this might not be the best forum to discuss LSM hooks.
However, I am not aware of a better forum for in person discussions.

AFAICT, in-tree LSMs have straightforward logics around mount
monitoring. As long as we get these logic translated properly, I
don't expect much controversy with in-tree LSMs.

> > PS: I am not sure whether other folks are already working on it. I will=
 prepare
> > some RFC patches before the conference if I don't see other proposals.
>
> FWIW, I'm not aware of anyone currently working on revising the mount
> hooks, but it's possible.  Posting a patchset, even an early RFC
> draft, is always a good way to find out who might be working in the
> same space :)
>
> Posting to the mailing list also has the advantage of reaching
> everyone who might be interested, whereas discussing this at a
> conference, especially one that is invite-only, is limiting.

I expect there will be RFCs posted to the mailing list before the
conference. We will incorporate feedbacks from the mailing list
to make the discussion more productive at the conference. It is
totally possible that some patches get accepted before the
conference, so that we can simply celebrate at the conference. :)

Thanks,
Song

