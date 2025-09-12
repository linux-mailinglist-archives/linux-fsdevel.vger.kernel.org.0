Return-Path: <linux-fsdevel+bounces-61142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D4FB55919
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Sep 2025 00:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7831C28598
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405B227A92F;
	Fri, 12 Sep 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/3hZAKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D127587C
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757715805; cv=none; b=saARHmT7mJPZUTJwMDUafrz0DtiuyfzkJWpyAWBtrrCYhFQHxKJbjsCzz5zc4M2c29oou+BxH7ZhCef0N+gGQpg9hpNEnwWOj+W2oDDymxBN81/exhC2hng51gowFXNCGgjZ0eolgQ3GdP8Yyrji5nDKU6GEa7oV0CGcNiNHAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757715805; c=relaxed/simple;
	bh=0kUPfU3gnFzUJ266qseC7iskxpoANrCisNONdXR1tus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWcWXmNBTOKOAKdGcwGhS0mmiQMFZt/U0bb29eO4UdQWfOnFxXsR+h6tGV3VRKXHDcFyEDYCrx/qe6FraPAL/wiwZBz3C+FpJzZ+ZItE9IJnUe26BqgCAfJ8YtXx0+hx4K6heHEhPBAhqy2WKwKzy3Dwq3K4ZIrqU/4skZPZFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z/3hZAKR; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62ed68313b6so2271026a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757715802; x=1758320602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HqL3Aqo4UZlJvQQ6qmciqY17hKAcd9vgZMpZiI0PnTg=;
        b=Z/3hZAKRcB7sS47iLB2a1WNH41NU7OviSWzDj+pJN1RrZnC0b7oDQtM3DmXB572LBK
         46Tz42MYo/XUCCI5qsxfB2ov3p2MUPlVfGwmSZq9Ai8vJwl6Y3bZOYZS3tEgq2NgOmlU
         wXPNebNyJFhfJkfDYzSG+Pbo/Mi2R3psGQQJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757715802; x=1758320602;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqL3Aqo4UZlJvQQ6qmciqY17hKAcd9vgZMpZiI0PnTg=;
        b=j1RNP4QA6ZLun5iCAnot8r6Hs3bwjZNLnxFKz/R6EpfxLWOUWFsWCV4i4xykPBsKHm
         RiqYURRH6v6zhe01kVyeobs+7rZE4Syn4reXL2kAcCgzhu3A9/E37i5Ov/GzXb+tagqp
         qMWsPU3KJlnHWGeE2WvT+HSYtAlYwvbfHjIF4mvgg2W9FGU5PYY8HJEMUQDs3n3RLK8L
         0fFUfX682MbwCD5oeOsh1j5gW8sAi2DPRWmgXEFWW24mJ3b+bOymgfXLcolchkVofMhJ
         ARxedRNg2E97xxD5y1rE4BChNvAl1JPECnhqv6klbkB4NMoz28vfXfkE6fBymnQsS88Q
         QLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXceOSHV7flC6tBIUNwMLNCAAZyjGzBkwSQbDeyQilrBXWMCmFCeBew//sSQIQfPyKTt0UiQhSOBpXHDbka@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXAfu7P0rLgEc7FJ1XLD9mlHtUhAUQdWGXvGXB63Vk3OuQq0b
	ACCOM4kJnc9pB3LGenNTnyVTJP1mGoGOXzx+Hj7ZLE6/P23KV2AUHQMQ1uOj6lqCkT1vkbPPYaL
	9MCaMy9Q=
X-Gm-Gg: ASbGncsIjDIItWBbQRaWmgHF7BlzEOWlxLq9S9zzEzwiX/n/VzgpM41LVQiapaT6Zep
	VWLeTONolRfex0eAtPEXOgmwK2E41KclTpDtGkMFZj0/60L0j/KlHovfEA1DJ53/bjJ37tf0nO2
	JoIJgfmbwgPlb6n+aVO8TaU18xNaqwgDPTofE5iI6KSobtGtrBWnLV+favmSF4fPEPnm9ueqpx7
	dKMSrCbV1CL0nmxZChkN2iLsctcYJ3obmHcHrTFETTzoxG0AhUoY1WSs7pIXTficsbycQKubFPf
	cdMapUXpT8sk/S0AZcyl/lumnuiBjbKDygypn+O8aTudKUH5HrLQTK0f444RXjPO++jdBlJjQSG
	F5uG7TladDidUyP664mqLYLcQbNLS5WJdHokGsWOTaDlPBLDY/vhSGxhN5UR5KoarzkjCVgc9
X-Google-Smtp-Source: AGHT+IFb0/KB9GaGvozMox1mp65wkYOHsNC+rNF+z0cci6QmZ2dCj1wSAfjevf2qHCSu0ytdCPQryw==
X-Received: by 2002:a05:6402:51c6:b0:62e:d8a9:5c9 with SMTP id 4fb4d7f45d1cf-62ed8a90925mr4004157a12.31.1757715801765;
        Fri, 12 Sep 2025 15:23:21 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee1fd6c0fsm2257022a12.5.2025.09.12.15.23.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 15:23:20 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fc3008so343334166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 15:23:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZGVwl8Rfmnay/Ha6sKlFcFbYNLRlSBN9f0hUlZBxR6mXLu/SaBgEIE0VUj7uwOdoDoIg5gbkZponkKw9I@vger.kernel.org
X-Received: by 2002:a17:907:928a:b0:b04:25e6:2dbe with SMTP id
 a640c23a62f3a-b07c3a93abbmr411949866b.63.1757715799692; Fri, 12 Sep 2025
 15:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912185530.GZ39973@ZenIV> <20250912185916.400113-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250912185916.400113-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Sep 2025 15:23:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7YJ5M2W-_ZgFhrxJLjG9C_UC65Qhpt83jVWesoucoCA@mail.gmail.com>
X-Gm-Features: Ac12FXx1HKXXb-AaFSAXmBawDqnGImA_Inf2GzPGYKx6ttDquf84GeIaz71Bi_Y
Message-ID: <CAHk-=wg7YJ5M2W-_ZgFhrxJLjG9C_UC65Qhpt83jVWesoucoCA@mail.gmail.com>
Subject: Re: [PATCH 1/9] allow finish_no_open(file, ERR_PTR(-E...))
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: neil@brown.name, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	jack@suse.cz, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Sept 2025 at 11:59, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... allowing any ->lookup() return value to be passed to it.

Ack, the whole series looks like a nice cleanup.

           Linus

