Return-Path: <linux-fsdevel+bounces-76904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOH2BzK1i2kGZAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:46:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2F11FCD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C06A3049975
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBA72C3256;
	Tue, 10 Feb 2026 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V28/LLyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D711E2614
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770763566; cv=pass; b=mxhYNnGQuMDt6qHS1ikTlNsY+2tiMePuRBV2ZOkuz8aANur/SmdvhNONKoDzDgOPRx3qlYUMnXEQp4j5DbbsMkAasPIaCbpwUa5WHlqoMaYg40ayJhlFZJuJnje5MRZ91oCjqLWbjk901x/ctKQJ1kyjuLFp5IDPL7fyzW7jGn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770763566; c=relaxed/simple;
	bh=12FJbWw4+xBxh+NpvJwBEEYrJ6Qv6Y3miaeedWMKtso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6XcslXhxCsyVEmWNgQe65e+DplZXNm66YlqJA+kAeuBN1OntAzKNCgQBR2t8njjxUPVQAZTrFfDL0hcWmGyMt8rdEyT68tekzfDUkckc0x4qzKnoYpdtKQbvfwLdf1qgYn4s737a7Wy2atumYqfoK9PTQAXphLLyEpTeWc+QY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V28/LLyf; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89549b2f538so28167466d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 14:46:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770763564; cv=none;
        d=google.com; s=arc-20240605;
        b=Zk8DSvSvEqQy23PkM1pZgTSqG2R8t9WZHfXqnnol1gEd72j1JAPqmZAL65JzrV5Lj6
         umbTfdaAkCeXFJNBg1VpdQiXPLxm2OAbHvG0CD+ThaIeHOgBSqk86yoXbKCnF048sW1j
         qtEorTpupNXNf/n/TdQQ8phGbscLbsmTs2VXXkS0HKARXzukYrPbV2FOKsDgJOB9qw1n
         Pcav58y5a0PEaIY6ysx5PYFLujA6eRRM0RYyz2dfqpa6HUEN5WfYhL6Y6yXuoPWXqDZh
         LE+XbS5beu5yY/Zp5S0KL+yO9pPnwj5KfNTWNki7qzeMYUuvquCYnwRlhqp8Iid4dgl0
         Ni4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12FJbWw4+xBxh+NpvJwBEEYrJ6Qv6Y3miaeedWMKtso=;
        fh=LMLcJXLFABem7KpX0x+3C4pXNeBIjUH25TChdXekXE0=;
        b=aqQqHR8RVyJd54rQB5iuQj8NXP3TwtN3H9T8rJ6Ll0xMlOF194pecDMzGFV0fwoj8Y
         ujbMEvQMOAke/84x42JKN6Xzj/h7vDNHJagTtuimqO1eWBSK2WYyulv3gdw6B0gEG0Dr
         ePO4ifrD16AqrfP0WqehuOTo2K/TQj23oFZZvdVSQJ6yxZr/rHicKu6XTd4m4o+Gasqp
         nF2xAOsUeSYTCdpzeg5FURM11TrpTIy3fGnbsIWNc0gHHhDTbgUrCRA/u6N2hY0qzFI3
         e7mcMBrRP2QOpzH4rUxW1RKshdi16u/uJByVnjwxG3ivMjWibpXSGNjl4q1gJN3P/CIA
         /2rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770763564; x=1771368364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12FJbWw4+xBxh+NpvJwBEEYrJ6Qv6Y3miaeedWMKtso=;
        b=V28/LLyfAdXDkp+MEr6u2AoWX+WIPn4RCkpNrNTK19iUovEdUwrQrEZ5Jff8g/E74k
         /2thXm+be0WF36zIWeWADGX4TCgmjmphDKmOoyDfg5vrCS6TfJKahpsmosKsd7b9D1pc
         /Odd88V7GNRhMNjMixmvUdAZ8WQxldMYTHgLiyPhCHtZKiJvRc0g+kz/6y60KttZT1Cm
         IPs1CBSWdPALDi0ctvM54L7MyqxPnOnIlkHnMgBlY+ctOci07ZgpFCwfZZFqLqIDYAH5
         xZaJsKSjKu/cyKL5gc1MDaeCY8nYWCSYyZRtL1Ez0q5GyVTNbmqR9gwz4HR4ytStB7su
         1y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770763564; x=1771368364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12FJbWw4+xBxh+NpvJwBEEYrJ6Qv6Y3miaeedWMKtso=;
        b=iCvx1/+CoMxw2MAOLWy8h9N4MmRiCJ6djPZ/YDCR2OQ4OhV8MZSPe635xMSsYSweN6
         w8Rl7KfQgRduwrwt7UsyGa+I+HbKumXgunY6oxb83oB2BlV6iEhizkLcKjUC+AWZZEBe
         GnK64x2NhqpM5uOsRRgVRWzJFoUCwqOkntG9XGR1yqr8WnT02gE31S82qyDrw8IQCO6F
         phLW76pZg690z20xbdvJTv/B9aVRku1iAOzkHqYRAjXYwwqAk+7kSt9AJy8wLuN0Flkv
         luMS2PWm80+vuUfN7K4VLmcwxfz8ySlqn505zK9zAvP6w+ATjDRqGsur55zJ5QXO6KmS
         fpqw==
X-Forwarded-Encrypted: i=1; AJvYcCUJbBLZYsJg+JdQrgAvY7IedEzBHZLaMUNe9DHLHMZ7wMNtevIua/MeThCCDAEKC/t5QUyQUtvO7XfqiMzT@vger.kernel.org
X-Gm-Message-State: AOJu0YyC/Lx96BoYzKrTjA619gq1VePatDPylcqYWGwoz02hUbiY7NoK
	QaBc+r6D81OHZ2ftwoxawb0STY78y+yDCLlaTF2YDljU1E87qJIVeAqMWia46XcaeEKGiOgBd6/
	cu4LH8W1Hwgl/bw2NFFJAkPzmDrLhG/7+uB6uY3Y=
X-Gm-Gg: AZuq6aI/Jmk2BCAIuK/XgmaDdmWAoIMwtzbarpyF4L65QXbdqzTYYV+gPIYpn7tZGkj
	sdTupTMirM68y/Cb80O7x+u2FzMcdtkT01QvPaB0jAvD8DNvD/4GoKdc7PkZCP1RCQbk5A6m3dm
	gQWDZb+6QK7yfrpcwBYbAqNnQXcXF1NEgB4a2bug+ZoPCPyLuuZPHJVhTUD4/7YSJ6YFL5Y352I
	7W1E1mDuGlX+gPOPW1FjIq5zCe4q+kMAMzn5a/dVzTnDwdC6DcaTJjmYwbNxuc0vI0DQ/96U/lJ
	RW2wmw==
X-Received: by 2002:ad4:5fc8:0:b0:894:6d0b:502 with SMTP id
 6a1803df08f44-8971b1557d1mr9636906d6.59.1770763563791; Tue, 10 Feb 2026
 14:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com> <27cebab8-fb11-4199-a668-25aa259ef3b1@kernel.dk>
In-Reply-To: <27cebab8-fb11-4199-a668-25aa259ef3b1@kernel.dk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 10 Feb 2026 14:45:53 -0800
X-Gm-Features: AZwV_QjbtlzlBXXRS01qYJcEXXAvXsYwL1evZF8Yasl_STJCiCpqtLwPBpaLCgc
Message-ID: <CAJnrk1ZmZ_EtQXc5BYqzNxV=Mx3q+K_WnbNTNKpOVugHz0q_1g@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] io_uring: add kernel-managed buffer rings
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, csander@purestorage.com, krisman@suse.de, 
	bernd@bsbernd.com, hch@infradead.org, asml.silence@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76904-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,purestorage.com,suse.de,bsbernd.com,infradead.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,kernel.dk:email]
X-Rspamd-Queue-Id: 75C2F11FCD9
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 4:55=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/9/26 5:28 PM, Joanne Koong wrote:
> > Currently, io_uring buffer rings require the application to allocate an=
d
> > manage the backing buffers. This series introduces kernel-managed buffe=
r
> > rings, where the kernel allocates and manages the buffers on behalf of
> > the application.
> >
> > This is split out from the fuse over io_uring series in [1], which need=
s the
> > kernel to own and manage buffers shared between the fuse server and the
> > kernel.
> >
> > This series is on top of the for-next branch in Jens' io-uring tree. Th=
e
> > corresponding liburing changes are in [2] and will be submitted after t=
he
> > changes in this patchset are accepted.
>
> Generally looks pretty good - for context, do you have a branch with
> these patches and the users on top too? Makes it a bit easier for cross
> referencing, as some of these really do need an exposed user to make a
> good judgement on the helpers.

Thanks for reviewing the patches. The branch containing the userside
changes on top of these patches is in [1]. I'll make the changes you
pointed out in your other comments as part of v2. Once the discussion
with Pavel is resolved / figured out with the changes he wants for v2,
I'll submit v2.

Thanks,
Joanne

[1] https://github.com/joannekoong/linux/commits/fuse_zero_copy/

>
> I know there's the older series, but I'm assuming the latter patches
> changed somewhat too, and it'd be nicer to look at a current set rather
> than go back to the older ones.
>
> --
> Jens Axboe

