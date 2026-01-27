Return-Path: <linux-fsdevel+bounces-75665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKBtHgNKeWmXwQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:28:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772B9B64A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 00:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BBA301953A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 23:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FE2F0C7F;
	Tue, 27 Jan 2026 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILsp73sc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DFC2EDD7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 23:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769556447; cv=pass; b=fCa9QP6eWFAy75zJBuXZy8+tH6i6PM2G0W8rzkk6jPijEmzs/rgYxikuYhmkGDl/Q5XYEczaZRw/71yJX3zHsBVwpfzmY7v4yLQsHumZ8WP2hUmcQP1EANLUpT97b3I176sdE7CPSzm0/8sKO9eWrJJeO2vEQqH1y47ErBsnCaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769556447; c=relaxed/simple;
	bh=AYwc74eV9qggYhoV9i6/Mg1El1/ghyO+Qal4FOeXrW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYUY1tqK41EeKSDo2ouB200v+yCi/es1Jcu6sbAE+1snQWGirgSg56ThSxr7wNb4P3EKlpjrSDUl7ZxSvGAPBJZ3fE+XEoXLt7ulwESfgqrz/Ma4Zfy4Di6iCdv5As0SbLeRFoYMMrBwuQGD0n87MinTltn9ExJeYTEmPY3azTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILsp73sc; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-894774491deso97364406d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 15:27:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769556445; cv=none;
        d=google.com; s=arc-20240605;
        b=XCXRNW5nfyHlq9u47+P9CW5dsE8Bhv3qUvR06ZRVBNBrguoSA/fciZXd37bZkJRZug
         1kmpxgRwm6aSSXv8HRnf9NOdQHAPCFS1P4NwP3ay5g9s7wawcxOr7Ngv/uKj1+HARd1y
         Udj4kZyIL0BxIOvDHMPKb/5PRq+pHhdUzv+k8DE+c2fwcrX4I1ci4Bdlpxkgr7Fy83u1
         YSlZyKLMv4sHEnBD18d9jR8EVMMWS2ftjG7IJxAuLyot0RAlrkNnHuBHDfiesDxkf7iU
         8pJJsA3VUQDqKNVau5WDmlJxOcb9TN8vCeUcKHdwjqsv/d+3GjjZK3Gdddz3bULs5Vxp
         zsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYwc74eV9qggYhoV9i6/Mg1El1/ghyO+Qal4FOeXrW4=;
        fh=tQ0WasWtYsF0RjiGg+E9BnSmfLpFaAkanoh4zzcAQBI=;
        b=gPiBU3/JEWun6fX4VkE6nT0VAPOT+h1bfisboUesIWwn6FVfpbyuCZ7zi4eHXzSXPk
         6N/lRzwJRa05vltOkF6ls7NBwVyWNICjUurV8R4sgehX10gOwjAd7x3t+CLqI2e7Gygc
         RY+F1ybVdbCYpeBnoRw4KhV3UHJuu+iFGz60cVsdIpOxPPaFC4mplC7bZ/l6yazMCETr
         1KXCwUrUqA+aZa/Lf36YQE4BLG7qwb5tdY60wpaYhKZCXzbGeh0Jxeb7v0UUlwZMyxUP
         uEehSgxCZRtozlBJ3cfAxHDOy75tRb2aFvmQ5XlCIGEPNZmr7RLOuHwOWNR9S234ED9Y
         Kmvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769556445; x=1770161245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYwc74eV9qggYhoV9i6/Mg1El1/ghyO+Qal4FOeXrW4=;
        b=ILsp73sckJWIKLaB56qHS+caMM2i40L2uVCjvwMMgVkAqYXMtdrPqNiyY2QTYuJwom
         d3pyx75OtB7RJvNrciX2j43PKVqh71QJDB5JakLr+SKUPno7bM85XR2QEje7p0ZR2u7K
         ktF4yN1oj1/tFAm7//jZEo3cpzlni1/FikBVfzeLdv+PAetLELk/71xfkyvuUlmg6ZeS
         d3ijcjCFPBzZYD+C1gIiQKENtdZEgfFau4Vv0Wa/dQspuScdnAZ3U6utg7tLK2SRNBJh
         9rs6WeMbHZ4coHl1/OeqrkMEFLDSjD5zYQUIb0LfQXkrcbKqjEUhTPTvEfzB7JXH3x5F
         6+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769556445; x=1770161245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYwc74eV9qggYhoV9i6/Mg1El1/ghyO+Qal4FOeXrW4=;
        b=YiZiFYNn8LR4lV8NiKX2zwOOfgzyDMsaOP49XQhdnL2vTpstcW2kce6CSDxZkGvF0M
         ENRLeiB2iWWquEPbxKkKQ8k7rqnOYn2kMNNFALhKXFVaDnBWXZnk81zoKeaUiXbhM1IX
         AIo6mz1qADeXKf3rFCQzvSquR5i7/5Wfg4+LQXGYHt/zgeIdCv8qatZrnmqRT7Tk7jnt
         kbeXfZVzDMBg0zwbQdaZaTKjUehDSUk4jGVkFu3or0sBdK8Ct2tHi+XLawAo9Ih9OJTX
         sFkqZJts0OuHiVaRqOWL3wdyB/5c1IVoxDCMQvms8Lblmofo86w+ll3LT9R0zgEpgsV0
         JX9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVC9WcD+Ph7YrISXOGm1jp2jVKkqVy1Ah5jONgPlMF5LwXtEiyX2fZUlLgGNKuHLcBpu4UYD9Pl7NXubr6Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nn0XO2R5FOQrZMA1h04jR999OuPTd3O/WVZA9eyQTNcVIdFf
	fOkMB5iT6WcA2WS9Ri+5H3Eir56n1vmwwY4apxkx7HkPzHpaS1zu7fubUYrp1/riT4+4650aFHf
	P/23evSax83y5w5yZbPe0nD1EBknPax8kSuvR
X-Gm-Gg: AZuq6aIrRgF39r+7pm88QNQ6XRdqEtINRzRaB3kexAPhMx1Q6jj+FVZXQh56S8KZ5L3
	ML+8vo1Y56TxRmtkogG9Oyh93pP9ND7SArHGOs+AcJ2HWvgbuUX0OqnuUs69gHOeUPakp914dKJ
	j5DkBCoyteetmmTST/8yJddrl/WGREAOzBC4CeK2HaU8YpAdplRu6m99KU3zCXC0tIY5f87NgTa
	/9x+USdS6YP2REYPepdzS8/yDGymwrqEvPaGFKCBnIV6YWPh1oo0QH9lmQ0iWqNA3uoKAANrTFd
	JJmb
X-Received: by 2002:ac8:5a82:0:b0:4e7:2dac:95b7 with SMTP id
 d75a77b69052e-5032f8bc132mr41676081cf.37.1769556444715; Tue, 27 Jan 2026
 15:27:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116233044.1532965-1-joannelkoong@gmail.com>
 <CAJnrk1Z-9rsP86Fc=57P9gy=vFjfjT8nuAgE2_snL3_vfbbBmg@mail.gmail.com> <d6eb86a9-c5b0-4660-8cf2-9c853b43b494@bsbernd.com>
In-Reply-To: <d6eb86a9-c5b0-4660-8cf2-9c853b43b494@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 15:27:13 -0800
X-Gm-Features: AZwV_Qi1is2emkh36NbqB_zTfNf86Up27ZSkGNzaTBu3cCTb0atNx0Jbg1JnqAQ
Message-ID: <CAJnrk1a_VE+9an2q_B=2=hPYjEQ_x3+zauekEqWoVD330qaM-Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/25] fuse/io-uring: add kernel-managed buffer rings
 and zero-copy
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, csander@purestorage.com, 
	krisman@suse.de, io-uring@vger.kernel.org, asml.silence@gmail.com, 
	xiaobing.li@samsung.com, safinaskar@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75665-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.dk,szeredi.hu,purestorage.com,suse.de,vger.kernel.org,gmail.com,samsung.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:email]
X-Rspamd-Queue-Id: 2772B9B64A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:44=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 1/27/26 21:12, Joanne Koong wrote:
> > On Fri, Jan 16, 2026 at 3:31=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >>
> >> This series adds buffer ring and zero-copy capabilities to fuse over i=
o-uring.
> >> This requires adding a new kernel-managed buf (kmbuf) ring type to io-=
uring
> >> where the buffers are provided and managed by the kernel instead of by
> >> userspace.
> >>
> >> On the io-uring side, the kmbuf interface is basically identical to pb=
ufs.
> >> They differ mostly in how the memory region is set up and whether it i=
s
> >> userspace or kernel that recycles back the buffer. Internally, the
> >> IOBL_KERNEL_MANAGED flag is used to mark the buffer ring as kernel-man=
aged.
> >>
> >> The zero-copy work builds on top of the infrastructure added for
> >> kernel-managed buffer rings (the bulk of which is in patch 19: "fuse: =
add
> >> io-uring kernel-managed buffer ring") and that informs some of the des=
ign
> >> choices for how fuse uses the kernel-managed buffer ring without zero-=
copy.
> >
> > Could anyone on the fuse side review the fuse changes in patches 19 and=
 24?
>
> I will really do this week, getting persistently other "urgent" work :/
>

No worries, thank you Bernd!
>
> Sorry for late reviews,
> Bernd

