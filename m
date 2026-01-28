Return-Path: <linux-fsdevel+bounces-75690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dj7CC6EeWnNxQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:36:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B33429CC12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 04:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1266C3014104
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 03:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854A32E6BD;
	Wed, 28 Jan 2026 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Ak6oqYfm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF74261B8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 03:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571362; cv=pass; b=ebwNoJHkpEmYUXy1zO+gOorxp7H+m3WoNEZ+ArtyNe1DitSu+CfGrtfUY3Hosxj4c5RYgdU0wIbK+978KFmLSDQVmN96aUBYT6k5gvwZLQoyejaKfBsVjjkDLRnwDiITe7soQhKMXlD9gnpciAaGb3l6eVOU67T5CvXw1QnvCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571362; c=relaxed/simple;
	bh=ydvPR1ONfnJMbN+rrNWts7FKEvLAX4dNZ7vKkzTX/+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qXfuzjTWXsP6kIgHzAVo5vFeI54OFa30RHZ3N2ncrFGqJb9eqrInyGznW1qJxFrHX7etkZ3sXMZR22jZFVMgjg6s4bsF8pVDIxaZ7M2fLjZMwNGLlib/xom5inabsf5C4kw2eu9tZD6E7pGZPx8Ljdb3ZbRGUFzaggatemVWeK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Ak6oqYfm; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352e2c59264so4339119a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 19:36:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769571361; cv=none;
        d=google.com; s=arc-20240605;
        b=L1Nc20tYa4Hn75gZmta+ZzBgv1TE62TwnOfIejAkjoEVBP21WrT3rX029fqRG1WuBH
         IG2rDJAOpWgfXAv7jtXJLo25kjYuiK29eYrexdvreg0qyPm6mJi0QK2KTkIN8tskVm7+
         I/XvyKAryOdb6xVdwn1L/UpEj3C+R32aH9yleQmKN4RD8QajmHWIys9ArXIN6IFFRAAK
         tczRHBJEj9JjdMntE83py2AO9WOv6Ipti0LrO0dukDSA9BM/IGOoAlQG3mkbE9zBiSt0
         aB6C2M91tZsZNYlgn0CUaZj6jZbxBa+SvoLyhtICFhGxkoGP6QJLULtD1hgxMJIHe3GZ
         wf5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tmdB+V0BN0L3bIeZGZ59CvN/CPXbhEttREg8zt/2hEE=;
        fh=6hYt8buyM0kKiwODH4yXTjZRGrOHbViNAEqXrsE1a+8=;
        b=L8NCgPKVqeF0C9JAtsJ/hq7xaOUJlKw4OxCI2VglcS269fUB4Fdb+KPnDUDoXo5D1z
         hRMpXqvUf1MbYEsmOg7jht7O3Cl9Jh0+MDIOwBkpOwBBkjfTQDKeI1RLeStktdeS8anV
         bNjXkEeFADW2FXI1B5dQMk3v2/4pClqrbEgzdHMZNbLi3lbZetLEJD1DknJsXVieXJHe
         Aucakn6A64KWFAiJj+pkdNYD6gJSynUvlTKP1ztosGIPMb5GhS65/pvSQdB7hmnbhFDQ
         VRM0LnEXVHFuPh2jDt/1OB1kHyohThcTYWmtkWi42NjRcgk1gQRMynYqy9mMEtosuRFh
         EgIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769571361; x=1770176161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmdB+V0BN0L3bIeZGZ59CvN/CPXbhEttREg8zt/2hEE=;
        b=Ak6oqYfmRBCEVNILxAhHLqCiBxDVfx8AYl6Y/NfkymFldrec8LlcmY4WML0x933VyL
         uq0ngUvmHC01JS8Ec9cPdQgtH9jZMuF8ID+pc2rha0X4o937WOIVNmUqsYn6tk4cG7e0
         6w8espCOEbk0cXOVFQXrrk5sLcBp2Eccj7lkUt7b+/WyyT5+9YaoeWcJQHJ7Y6E9S8d3
         bi/PyZ1EHJwmQ1rmc2nGidaA//ntOcME/ktSVRu43q/Wfv9OGYBz1Ht+nZ+kXxCNXsSP
         05TXb2EUQ91zhQ2KHlCqU704FMp6lzF2mbogJqAzuE5iajFunsWfoQqdWcJMIhYCA+CC
         HDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769571361; x=1770176161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmdB+V0BN0L3bIeZGZ59CvN/CPXbhEttREg8zt/2hEE=;
        b=LL4urvGkdWIjI3YOBGdnj58n05Xs4TyVhGGHll4KA5iS9Jnv6oMbHvq1iz5qO8pssA
         Sz3qkvH5nnOWC6Fu/0NXMD57+pYATYYUHC8JkCeepE1MmIMQfXUhDI5Wm7mFbwwD1sx1
         68jZjdFJxCvEfNYEfdqJ9bsxzvkMUy6aneMZmnnnlYogt48YRRk0z/dduqktB1k/imKy
         mzCujg2lkT+R9sK8Scg/8yCe1wshiXVgVN5YsQWYyN++2mBc04uV4XHSxuSSy7NL6O+I
         K5JD/NUglPvwMCmVMg/uPzWbs3HtFRm4WgjHUrQDFisfKvhR+JswztYCORhkF2z7zrQM
         bAuw==
X-Gm-Message-State: AOJu0YwLoQSBrXYG8oPt+M88VKIVpe53jBNfdiEeZtCdZsW1BLl8HOxC
	JHEwb+XsWh4XuQKSR5SHZwrJBOc+08nyFgOEo74TI+31Cjv29YLnVLY+fuUXCrdYA4/WEsKYEko
	A252uWRXERkCGbd/0Om6kExj1FqKLsi5roXvGE60rPA==
X-Gm-Gg: AZuq6aKF06yjZ2M0g1u0Deq7naXll2iOmbGuhFSdf8AQkFlSPDKLwtiqg3kdt1ZZlbm
	yyWVS+dAQ8ji0dVmjoSYv3shlyRfsqfPLn3X2OXZ7Ad0xzZXJ/Mjrf6p6ZQDRvL5v/DMAwjAdqA
	N+VWwgQ1IE1TaF7u2xeh29idMvDlIUws+wlAcjMIqt8UdP+fO37pSQgtXUGDo4RH9t1v0pQKMS0
	3ND6JsUlVnJ9+flcbDm8oPvxw3cQ1XBZuKqh6kKkhayipBQMkL3KqVDsdQtkWEibke6CQvCgSRF
	ZfYz+2ulffS5
X-Received: by 2002:a17:90b:1f8b:b0:349:9d63:8511 with SMTP id
 98e67ed59e1d1-353fed9b7d9mr3213615a91.25.1769571360712; Tue, 27 Jan 2026
 19:36:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225111156.47987-1-zhangtianci.1997@bytedance.com> <CAJfpegsnLAAnpxw+sJ9tcf5dLfcyK3mX0Jg7+XuM2Yk7Dfk8kw@mail.gmail.com>
In-Reply-To: <CAJfpegsnLAAnpxw+sJ9tcf5dLfcyK3mX0Jg7+XuM2Yk7Dfk8kw@mail.gmail.com>
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Wed, 28 Jan 2026 11:35:49 +0800
X-Gm-Features: AZwV_QiZHQSPgGzJ7dMwqsQN2lZfmK3p3Ntla8mM6f0C739aibsD0DZhupGEWp4
Message-ID: <CAP4dvsfQGAmoG_y1FUMFFVG0SeWZRCN6aseturcWLpEPZKjQ0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] fuse: set ff->flock only on success
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Li Yichao <liyichao.1@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75690-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangtianci.1997@bytedance.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B33429CC12
X-Rspamd-Action: no action

Hi Miklos,

On Tue, Jan 27, 2026 at 5:58=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Thu, 25 Dec 2025 at 12:12, Zhang Tianci
> <zhangtianci.1997@bytedance.com> wrote:
> >
> > If FUSE_SETLK fails (e.g., due to EWOULDBLOCK), we shall not set
> > FUSE_RELEASE_FLOCK_UNLOCK in fuse_file_release().
>
> It's not clear if this is an optimization, a correctness fix or neither?

I think it's an optimization, If FUSE_SETLK failed, FUSEdaemon  will
not record this lock, so in
FUSE_RELEASE operation, FUSEdaemon will perform an unnecessary lock
owner lookup.

Thanks,
Tianci

