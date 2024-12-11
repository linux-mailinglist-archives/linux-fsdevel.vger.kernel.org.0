Return-Path: <linux-fsdevel+bounces-37104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE439ED891
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 22:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA46B282ECD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21571F0E3D;
	Wed, 11 Dec 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QW6JAAXd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2791D90DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 21:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952769; cv=none; b=P/c/HEqvLy/BT+fAH8R84qNgCpVU2d8MFGIl55xm742LRSZlappW8QnM00yUofg/GmmxHc9Z3JY7mPNItvNVwU88U00iLGqU+/Q/qZCTfNTAFwWdwN8QvJhGh0yn7lmzJiovjbw2KimNxFfjf1WvaerVaB3KeeKMnjHwHuZ+HO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952769; c=relaxed/simple;
	bh=iQHe9o0OFC8o625cYkLtRXrWxS/+TJviekTccK7gui8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gq7RrRiqL92ez7bVvhy6MjK54CXuT7NDdLsXVCvHHQtEPhFOhh++2x3hNOx2iW0U7VT6NUaLS0TpP9f7cD3+fCrjxvImU/P/DaFiB5biHjqGhNQakwVTq5V9xwupe5O5iLo9RMwZnDS5pDwzvfHU+Ig/OqD8orBS3tBhZFucFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QW6JAAXd; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9ec267b879so1420149666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 13:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733952765; x=1734557565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=QW6JAAXdm1z0ya66RP5CUyQjDw9sMV0nOR6SHHQ/0gul4l5u1rw7ih8RPSgOJ55g9c
         14debF230Fy3Zb8Zz+ZOyOMIXW27J46UWk1xEBbfQv3TJoxs167WLGhXdOCnswKR/oh2
         rb7ba7aJ1iUtXr+9R4ijrK95gSkouDxuJAXxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952765; x=1734557565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3OGAQ5vsTFqn13bOxJ7t9i7h4BntnMNyLupbofgMFg=;
        b=IHZtE3RcZ5yXpLjeXXNupSz3tHrQpKbm79N/DPmek8ECRotv914xXL3t/OKU2sogDt
         0frsMquUNZnCsl4QLxLjwq4mBIMro4CkhyfIYJfAn95N8zHMCmhDjWNHmA55Rcdyo2ao
         ftb6ImrGwW7JDlphPefyHc9tVPTFxXXVvgBIxdUtxFi2uXOW6DP6rnxhsudalbo7JSKM
         nYfNNi8D7GbSFyJLxdDGuv1TfXeiLqmSNRpWF6CgLnwb5zNc88IiZzbhiRJQZvkyEGZO
         kalBhwLL6uTvx3x0GC1bup+/W4mtIVx5z/IqdTqoKqR2ZxvGspgQWtbufWUDRxaRisW0
         OS3g==
X-Forwarded-Encrypted: i=1; AJvYcCUi9M8Bf7Qs5BbmTDIYcYAI4IGcESgo/ftRHGEMUy8mIgbtl7Fmxy8UmkgNh4Vj4VZOgqb5ARbySY6trsPI@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcvgKR2AQceji2/ImMzHZiFrOkBEGYB6++NV9xm208IPGw1hE
	rk+lq8rcNeMvaqwn9JQv4IPUS7OzhalcqrAdEenTN8vEm9uD+klY7B/5/AkfqMNaTBG3uk2j4/s
	Lhow=
X-Gm-Gg: ASbGnctJqoEu3OCSsemvpJ0blZlosrtSXDA1/SuxlqVK7Uf0rWfjmu23cacRK8I1swF
	MoY8Yny20aNJ1e2SY2KRbiPP8DyUWTkIoET1SdVJdnfiVMmYqD1wCcMRtHZlK5WoJwjwp+WzcWJ
	JtmiFTCsncMjxWrwyoM1tjN54WBZknHS6VKD9uStTfG1nNB/JjhZFOxyO50g2aNnqXPpjJ+LdOi
	M6YNuHc8QyHxio+/+0Ianj/d/+2iazK3z280IalQjLKEp8tei8bAvmxq2Ns8Tz1udVEG5Qoz5p8
	SIr0JIkaVAFr3X3puRVRv7Hq26P7
X-Google-Smtp-Source: AGHT+IF8BOZLOQpQfDCa51yNIYU9ZrigZtmL8s4ghSp6F3Nx1CgY+8j+X9225YGz6cHY/OcbXOnkUQ==
X-Received: by 2002:a17:907:cb02:b0:aa6:6d48:b90e with SMTP id a640c23a62f3a-aa6b13afc33mr325195166b.45.1733952765171;
        Wed, 11 Dec 2024 13:32:45 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68f4eb962sm468419766b.3.2024.12.11.13.32.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:32:44 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso1397716666b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 13:32:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXWLBSDNL9SCGQTSQ6UkNke7fwo11Eu++Q7qN3jidgMe5QnxPIy3KH+oFy063NUGRVikw7ChfkVwNH/DV7@vger.kernel.org
X-Received: by 2002:a17:907:7747:b0:aa6:8935:ae71 with SMTP id
 a640c23a62f3a-aa6b10f5d3amr449688366b.12.1733952762458; Wed, 11 Dec 2024
 13:32:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675963eb.050a0220.17f54a.0038.GAE@google.com> <20241211200240.103853-1-leocstone@gmail.com>
 <Z1n-Ue19Pa_AWVu0@codewreck.org>
In-Reply-To: <Z1n-Ue19Pa_AWVu0@codewreck.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 11 Dec 2024 13:32:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Message-ID: <CAHk-=wiH+FmLBGKk86ung9Qbrwd0S-7iAnEAbV9QDvX5vAjL7A@mail.gmail.com>
Subject: Re: Alloc cap limit for 9p xattrs (Was: WARNING in __alloc_frozen_pages_noprof)
To: asmadeus@codewreck.org
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com, ericvh@gmail.com, 
	ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs-developer@lists.sourceforge.net, 
	v9fs@lists.linux.dev, viro@zeniv.linux.org.uk, 
	Fedor Pchelkin <pchelkin@ispras.ru>, Seth Forshee <sforshee@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Dec 2024 at 13:04, <asmadeus@codewreck.org> wrote:
>
> Christian Schoenebeck's suggestion was something like this -- I guess
> that's good enough for now and won't break anything (e.g. ACLs bigger
> than XATTR_SIZE_MAX), so shall we go with that instead?

Please use XATTR_SIZE_MAX. The KMALLOC_MAX_SIZE limit seems to make no
sense in this context.

Afaik the VFS layer doesn't allow getting an xattr bigger than
XATTR_SIZE_MAX anyway, and would return E2BIG for them later
regardless, so returning anything bigger wouldn't work anyway, even if
p9 tried to return such a thing up to some bigger limit.

No?

           Linus

