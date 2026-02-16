Return-Path: <linux-fsdevel+bounces-77271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHZeBu0Ck2nF0wEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:43:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738714313B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 12:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13DB33015488
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 11:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226E30146C;
	Mon, 16 Feb 2026 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KEoJBEF0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A7B2D592F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242213; cv=pass; b=R4TFWubN/U+LxoUA/qTyH/xKw7HcyoUpZgBBBDC0ed3+KqtfsX8ZWsV94KbJ5FNoAIeHukiAglzfgUplhnonV4Z/4ETA/Elny0LV3cGAxp++59S9zAFTaNFugicsNO6z0AU5GBore/azwTu+A1LXTwXXKHIe7xo6JFfEzgW3x8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242213; c=relaxed/simple;
	bh=8l3Ph37exNxiCh0v/uD05ZKTjr3mGEGZk8B9DTJfhGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTH1ugFcxMV9Q41D1vT+j8inIR1wJZKYyjCeeAwaYuY9tsdtZ+eezMa1S7+Suerg6j4wt/sl60VBChxde7DQXQAtqw0MS3UTNPOLhrNyUxt9eVDP6nUvCPztfIP1zZ8Xb4hQB4Yoy1JO4nb+Juh9XUn8UiesjkgzgwIfAHwcGqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KEoJBEF0; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-506bad34f51so13308271cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 03:43:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771242210; cv=none;
        d=google.com; s=arc-20240605;
        b=NFr15Y4iNEPqG2v6OR9c7Cija7nHGpc3oU9wg9YMUKp4a25+VQHc/yNoyIp7T41c1x
         /VU5btIQxgoccPFWxo8CrB/FNanLEIzyevt2PVpLCi6KK5oqScMhLpyk5+rfjjqAKfrL
         w7b2hrmtlIaJqNKxXckuNlVQU165HQBTsQXnBNEjhFQa1AoXj+aBNa1OKrD7ARdBHBJ9
         p5RDnYbhkhyBAi2Bf3Ht81DyWXuXDgCpBIDTu6//zQBYPk8ooxFMX404N7ZGZK0efT01
         xu7S91d3sqZcWtc5uX9PJKDVxSsPcRlDZfTa238EcZePKlix7DcM1xsMo5BOKFG+LqHF
         q9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8l3Ph37exNxiCh0v/uD05ZKTjr3mGEGZk8B9DTJfhGU=;
        fh=/1P6ncu0ZCQmnbn2F/y5ZCZwLLJtM62SeqYGrAsruSo=;
        b=CvULadnTV130KrzFMg7551o6yb0oJaZsiOEw81KQXWSCJdQVrFc0aTVp7oWQ7R7hBq
         q+VYN01862hTtCh/0tY/OUr3MF4e7+Cmn4+9pvYeqAQumAwATqiVsM01yliiWAIn9AJn
         zc7R1Pra9ogXTxpaUTqfn5ti781V6Jsyiu2Wx7vcDlXx9ag4bFsuV1NlOJkOtfhbPvGa
         iIrhZKu5YNDAxPehLMfmSbTFzA/X5chnBK4f6l4B8tBBhqK9c/KL4hjcw/dOYzL0jJJR
         D5pmURDJYfU/fzc3qJZ75j+5leqfQRGPQbqHz80O0SjAoMSoa9FDT3sI1T/AZvy/W6Sq
         Z+Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1771242210; x=1771847010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8l3Ph37exNxiCh0v/uD05ZKTjr3mGEGZk8B9DTJfhGU=;
        b=KEoJBEF0gi48/zKsvstuVHnaxOvRsewnR7c1/9/IlxX/4DPIgI/xJmRkhGzqDf4yKR
         V+QA6mIHR8fBXoGuu2wpAVn8JZ8RQO6NXZXaypMm+Z8HY5vClMspzHy7FxUiFS+hQg1n
         XIPR1XzEX2M4RI2XJyQHtf/0SkHzeKJ1CHADQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771242210; x=1771847010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8l3Ph37exNxiCh0v/uD05ZKTjr3mGEGZk8B9DTJfhGU=;
        b=LRmiy9mlLR1dVocBxe3WBsko1qYj4m86UKmsc5QU1y6hMJ3P/bAjV/aILWrFbR/6S9
         BCKyO71KzV7e1udjBJ+bSd+Hw9dMPIG6RG2HM8RLBHekRngDNZsvaBoWFRpVLU/8L+DR
         I9glMeV6VabHAOesR+5KB8Rkg+ltCxUgX2JO/2pc0kqofh9W+WXcIxcFUIbeANjJx+Xy
         YJh8A59HKrFQISfaXXSSLIN3XZNaON65eaXvRKY6FH6PRsdg6KK56uVj2oHy4QSycHpn
         curj0QTEyaaCoVyieYIBORsWHl60a6SVgYzY7SjnJ4iTwSaIBGOPIAT2RDfNvcYxW5h8
         Z61A==
X-Forwarded-Encrypted: i=1; AJvYcCUkbDD+FOGxyvQBcjAdWR6rUC+JNnMmc/U7eUA/hdYQ5XJKP7GtWdZ0fzMURBH2JY15PaPuWBa0KLeH8+qO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0I0OVb73IuDiYkY9gBLUFor+FBRUAbNqqk9/wqZ3VMlvpdkJf
	/ZDOvRPCHCXmxhEgeLHECjZ0Hee7g5BZnfxUV+kX1OTVWwWtKEKCkd17HWhnCbQ2hemz7b9ByvW
	pyREJD2ZiiXUJLYYNID0gkkwULgAtoL8Nr8GuadTiVQ==
X-Gm-Gg: AZuq6aKcK5zhWmCLF9ufFevuTNciqcqiWAtpONIR/jSaZGlDTAph4B1W6LelDJU3naX
	lgdDhXIV2U9T1ez47TMXXDG5wzFkH8xZeyjjo7P2/2UdoTtVoBwfb6dvTXBBn7NQ4BMvAfP4Je/
	H6Ncbzf9McF9ahVZIUzusY4RDnfsZDDvVMUorRBw92pDgGSnNNxNdi7JkPpYAICQN3SaKvWT2gX
	0PdgSeeJKfecwHyaWmG3YtGZ5teTVaW52Qv8Pi+0xy8IRWNlAj3GpbEELOcY405bV8JfwIrILkm
	3sNJQECpNzJSW9xgR14=
X-Received: by 2002:a05:622a:1a88:b0:4f4:e6b0:7120 with SMTP id
 d75a77b69052e-506a83a4677mr142516721cf.82.1771242210247; Mon, 16 Feb 2026
 03:43:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210-fuse-compounds-upstream-v5-0-ea0585f62daa@ddn.com>
 <20260210-fuse-compounds-upstream-v5-1-ea0585f62daa@ddn.com>
 <CAJfpegvt0HwHOmOTzkCoOqdmvU6pf-wM228QQSauDsbcL+mmUA@mail.gmail.com>
 <f38cf69e-57b9-494b-a90a-ede72aa12a54@bsbernd.com> <CAJfpegscqhGikqZsaAKiujWyAy6wusdVCCQ1jirnKiGX9bE5oQ@mail.gmail.com>
 <bb5bf6c8-22b2-4ca8-808b-4a3c00ec72fd@bsbernd.com> <CAJfpegv4OvANQ-ZemENASyy=m-eWedx=yz85TL+1EFwCx+C9CQ@mail.gmail.com>
 <d37cca3f-217d-4303-becd-c82a3300b199@bsbernd.com> <aY25uu56irqfFVxG@fedora-2.fritz.box>
 <CAJnrk1bg+GG8RkDtrunHW-P-7o=wtVUvjbiwQa_5Te4aPkbw1g@mail.gmail.com> <aZC0WdZKA7ohRuHN@fedora>
In-Reply-To: <aZC0WdZKA7ohRuHN@fedora>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 16 Feb 2026 12:43:18 +0100
X-Gm-Features: AaiRm51xH-opalgf1QBNCA9J5cyFtcH80WgWdj-83Gtqot6I2auplE06OfOolvs
Message-ID: <CAJfpegtWNjkxchD0A+k1YQt=1_B4akrU3pNeONRHunEY=LffZg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH v5 1/3] fuse: add compound command to combine
 multiple requests
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bschubert@ddn.com>, 
	Luis Henriques <luis@igalia.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77271-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bsbernd.com,birthelmer.com,ddn.com,igalia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szeredi.hu:dkim,birthelmer.de:email]
X-Rspamd-Queue-Id: 8738714313B
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 at 18:51, Horst Birthelmer <horst@birthelmer.de> wrote:

> Which part would process those interdependencies?
> We have multiple options and I'm not entirely sure,
> the kernel, libfuse, fuse server?

Kernel: mandatory
Libfuse: new versions should handle it, but older versions continue to
work (because the kernel will deal with it)
Fuse server: optional

> In the current version none would do any special interpretation and the
> fuse server will have a specialized handler for a compound type, which
> automatically 'knows' how to get the right args.

The API should allow the server to deal with generic compounds, not
just combinations it actually knows about.

What we need to define is the types of dependencies, e.g.:

- default: wait for previous and stop on error
- copy nodeid in fuse_entry_out from the previous lookup/mk*
- copy fh in fuse_open_out from previous open

Thanks,
Miklos

