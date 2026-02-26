Return-Path: <linux-fsdevel+bounces-78522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHMYH9ZqoGmBjgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:46:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE991A90D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED2D7304DE71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47513413227;
	Thu, 26 Feb 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Hqe4xCB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D077413224
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772120699; cv=pass; b=KceiS78uYvraMKbg4fE+8QFmkULxMOeF/mSZI4eYwawmARnfLZUnYaHV6P+6e7Fwbcb8qUcp6RVKW82aILNIgxuh6o+38o1WyNKY1D9B+ktPF2Mz5ycbpSpncsiVrzquE00PiUMLfRoTX/1FhAOEP/53wtBDKDNcdNLAs6ukAsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772120699; c=relaxed/simple;
	bh=w5c4vkA+nYNBcCW2uZqV1HBWryaD0ubQphLihg0kfgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+F7Ea3jd/NzUi1koj35GbZ3Ccv3HlFzW53+IzsUxInv2CbKUrBCpDkB8vVynPWQJT+/EdDAcrge+zwB91ecfG1arF8XU3LIVYI1g9pJsQQ2X2R2HXHO6cX3K9P6+5URb8ePLZpYyyvazJ7cHtgHsgbnqd6Z9dQcNzlO75IO7qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Hqe4xCB3; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c7199e7f79so128783585a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 07:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772120697; cv=none;
        d=google.com; s=arc-20240605;
        b=L/hEZO65y0ztEO+oKt7kRXy4UtLuUdrCeilMviaSk5i9PjDUkx01bbPC5MExsbmAGY
         SIR3699QtMEgQThED06ce6s+khwueICX8V0yn5CyoOjiFojIBGyF2PAgT2MvYaI3Nirw
         DnzqQnM5LRmSAG+oPoMazO2gXXgtN2XE2e/nbhoyrA41DMCtP6w3UY3/6UW2bgxNS0XZ
         BlOnqQILHUwcal4CF0UVH8Ck7wcOhPhlHdRq7sMj5StmbDurbPQo3ezw6ezgPtTjwFpU
         y1nJLQu8nWSxbgRBbOrmmCBJX5CbEiXIObM9KWkHs7B1T2Q9ZOGz31/lZ32OJkqt9vnB
         dRRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w5c4vkA+nYNBcCW2uZqV1HBWryaD0ubQphLihg0kfgI=;
        fh=U/GFk73wasWFvxGuE/S/NdgygYLSH/3d9mqWgshgAIE=;
        b=d7T70QBMW32HbMT2XOgrWrTeft9tcZTZiyDgBXInKq5tYK9rCLZTYL5XMLYXOO/ct8
         cw7pFnZCr+Vx9xp1p7kkVi+47MhUTFX8CwRPajcf6TULz+8esN60Z6jSA45+/pvCrjhQ
         4AZrYfsS2uSoVDC6PCz7VzJenfX8FabgYaNJ5WDY9M5+ALQpq/swxJQayf7IWOksT84T
         8TbJs3B1OJOzds92qyZNqjjoumV+zLEPwshldJwZG+K8X8LT2oPtHB6Kl+vDbgnYXpKl
         guHXUrK6egEoy39/5wN7nixhyoDFJuIjNCydWCNlSCV5WzUuTe107Trt41nY1Ec9a/cZ
         l9Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772120697; x=1772725497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5c4vkA+nYNBcCW2uZqV1HBWryaD0ubQphLihg0kfgI=;
        b=Hqe4xCB3oa9KPWY39FolpoIRgY0alNoM5DEf17BHExldQTi6Bgu6D9AYQbwksTv7wh
         wGIYOuqBIrA98We6HbGIw/5c5FEVzX39CyVxisu/lNClU8+iDoEtISTzUu08mHjQuVaB
         CmN56eQrWE9zxLW+1SRstJGZMWjy5HO1SsrB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772120697; x=1772725497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5c4vkA+nYNBcCW2uZqV1HBWryaD0ubQphLihg0kfgI=;
        b=NXLuYnGSKdi59rf5SklTmjkzz2XcEIAGd3q/u589j1izq1mstR3aZGajAHRWJZlJir
         Fq4QrR+6H9kjebhslDvzX1LMWbmYkWCvKWuDwDy7S8EDKVqNHgeOQpQmH4mljZrt3wOh
         xR4zDo9dY42EzOPnZ3XzPYJcTgwd9ugdTvzPBO9tj4fn/elI7kHiERJ5DZ27PVAuz+M5
         BplUt8AiAc4KefZKU0zer4kcXS1nnFa5UbONwd05b3ORMdgOVlkd1l6Qp1oZ7aQhS9k7
         Q93nRLqM9mJul6lXHVuWIKdeJBCki1I8FvjrPScQlP1zpU2tcrOZ4fznTNzy3wN8sLkH
         ysWw==
X-Forwarded-Encrypted: i=1; AJvYcCUATwKFXgfOj2aPYErcRpvFWiqTpITLJEcAfuRMpZUPd3CEAsGor3uTZKHXfQSqyB3c0vAZuAOmD3+4BpRS@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ89aL96Jzg9MVhRnmZJ1WCs25wJKF5XId2V/KCk2hatS4n8A
	SsqBXBTDsfy0WCirJJBIfKYWMNOTW7SWidpq4UGP/YMSPwbob+Jb7T6bVfw1y11UECB4ctr2dQ+
	njZJgym8gZYHu69dZr/WskBjT6SiwLgWmZ7AS7fJuUQ==
X-Gm-Gg: ATEYQzxxLJnw/gzUxdtGgkbuINPlcnF0NhoudWsTDqTCsKh2b2l+uwEYpngOiWoxew1
	kQiF/Ij5KaUbeu85+RPVP1L5w4+u8VNEPu7nJL4+wC7yVl0mkU+pcVk/AF7fkYNTTebME2S1tkL
	UNAMKjAq4FWnKENfvyWAHd8GL41rWar+vC4uUbTcOWSsdVz/dM4qrtY3vp4LZmbjWXvlfwTVWus
	O1GLETH2JlK3R2axFA8kjjIbPN09P/4T53c4xWKJe5NMS0TPJs0zjzlkYSxh1hZGnqbNijirXYE
	A7Jmtw==
X-Received: by 2002:ac8:59ca:0:b0:506:6dc6:74e4 with SMTP id
 d75a77b69052e-50741faca5amr60732901cf.63.1772120697118; Thu, 26 Feb 2026
 07:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225112439.27276-1-luis@igalia.com> <20260225112439.27276-7-luis@igalia.com>
 <CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
 <87zf4v7rte.fsf@wotan.olymp> <CAOQ4uxj-uVBvLQZxpsfNC+AR8+kFGUDEV6tOzH76AC0KU_g7Hg@mail.gmail.com>
 <CAJfpegspUg_e9W7k5W7+eJxJscvtiCq5Hvt6CTDVCbijqP0HyA@mail.gmail.com> <87fr6n7ddg.fsf@wotan.olymp>
In-Reply-To: <87fr6n7ddg.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Feb 2026 16:44:45 +0100
X-Gm-Features: AaiRm50VNJCUXV46dxhNd_0E_89D8Q_MgrwkrkBCeOzAKTDQqOWFdwRvOWx2VdY
Message-ID: <CAJfpegvb61zh6ErJ0Hs9wRdLVmeBMOLrJKUyBMiQcpQoxXGPOA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bschubert@ddn.com>, 
	Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matt Harvey <mharvey@jumptrading.com>, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78522-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ddn.com,bsbernd.com,kernel.org,vger.kernel.org,jumptrading.com,igalia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,igalia.com:email]
X-Rspamd-Queue-Id: 1EE991A90D2
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 at 16:07, Luis Henriques <luis@igalia.com> wrote:

> Are you saying that outargs should also use extensions for getting the
> file handle in a lookup_handle?

No.

I'm saying that extend_arg() thing is messy and a using vectored args
for extensions (same as we do for normal input arguments) might be
better.

Thanks,
Miklos

