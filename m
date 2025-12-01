Return-Path: <linux-fsdevel+bounces-70382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545DC9943A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3FC3A1E96
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E29284883;
	Mon,  1 Dec 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bGi1s+Ir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD3521420B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 21:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626003; cv=none; b=hhNFDKohYrz/v1eZkxejjhMFwtu3REXKkKumfO84nU28ASqC0QmWhp43yw2/XRBlM2NRpULgDAEfJcldNZo8fJ+2cJNIz5qaq64HA/5maAl63iyFhNxbnT1ka/IIfkZn5cEVrPrVsqmdsfy/0CRkU6/v8VRz/Vt0YOruJs7U2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626003; c=relaxed/simple;
	bh=2AfiBR9IWeHz1t4/apLl2MSiUDV4ok+ylTvXxhPClp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=acUszjSEaQZlga64IJ7dON9wCNAqSZ25PzN6EdezcAX/Y45mBq+WlSiBtDNZ0G/XLHFnwAwCkef+7M6Vb5yLlWeZ5rt4Zfev5IDQfvpsIo9o8x7ZcMrldFXJiMacN9JlaqGmXqvnXHM7guwTm2oIz1cOpZUDLu7JWwNbY9toZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bGi1s+Ir; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b73161849e1so1178871066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764625999; x=1765230799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iWNtNLtw8z7Y8e4FnLIUWdk5TQFNz++toUFrR6atXP4=;
        b=bGi1s+Ir32MX8x00iI6g+qOBnCYGyVjBOyTZop5PXN+tz2svOUWACqyKiLKI0KFBvy
         ckpu+eudrSlMCfQ4bYoa1dckrDu5/VJhyYsXtTaqQEWttOgYllznnIIxrvuI/Sb3izN4
         6dUkzZB+hND4yp0ZooE4Nz8v1+EHwuBHNhnsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625999; x=1765230799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWNtNLtw8z7Y8e4FnLIUWdk5TQFNz++toUFrR6atXP4=;
        b=gazjHFAa0qh3ircUa2A+mSogc0w1dw41SA0oRq3UnBR2tOxsYFcKil+0ovQ5eyMqSc
         8H4OOVLmaCROtzULnLbS61Yrgs7LzMacFwgH7qhsD6EHIuWZe9ddKn3/CEsKGkAWK5qx
         k77bYWAxleR6CoAnOBx/CasZtPIIjSTKlyG8gIrjBoMRhoVhlxIWm3P1oZQbKako2wHP
         H8zQx/teVbRH6Z5XceitGf79rC5SVULj60o4tICmSyJeEG2Ue11eVm/bZ/sqEiAPGsy0
         aQgFkz0xObXuzFOPdoYbr8iVNvJGS+xMNJmGxqIV5sONzcm3hNPiRMQChPRJJDqxJPTP
         hQhw==
X-Gm-Message-State: AOJu0Yz0UuPiaXpmiSE8ymLElKEt3JM2hWqUP6qWcVNGPHaatKraXO/g
	I4znSUqzgp3GHSZgHE8AVXusQlqpClt+geZWvfgUmV3B3uWxtzo073GbDkFQklHEykDbbeEb7YI
	hMHBkhU4=
X-Gm-Gg: ASbGncvHJjSmxKXnMgNoUMOiusW3SoWoBr+CkJEQfNzkBK1zhwpDGp76dbCBsrvbo2s
	bqJWLzphAMYOBpaR/Kgjf/DmK+Avq7/HKaODyqgqnbsnhZn3gs5IfjNcSPs8HTz413MH7+nMJRQ
	CweGklSkXvOP8tooar4l9XDD5e08vIUWrmLxCroY0e7Y+1+QLxLPko6t+oaZv+4I1wO8LipJNIe
	7b0BrjOwDT3KmY5T64wMuNqh/oGmY/IP+IMWCsmEGNP5u+pVuAOyJ3VxHvjR+cgxxvQs2XEAM2h
	a58P8+zTzsHI6PRMczSV4okVmXXrR9bsWVI+uPk3abnswyoFVeiac7EVYWs3Y1UdB833HY0Z6+n
	fS4KbdjFTjUFZZSQDBMVVaorSbtWFGKSLFR0e77t/AFgEmWpqoSEiEjDAP7QWYDhYq05PvTZG6A
	H91h3LohewoQQ5Z+961STjO1HzAXPrYy6iLlFrvxf4Ks2pQL1RwZ0gE1UbIkl9
X-Google-Smtp-Source: AGHT+IHSMh2PTymRnB9mE63n6v7GeHE/3iSFoUCRF6z970crirKqF7l1tarqzCu8Wwk/imODYyJNNQ==
X-Received: by 2002:a17:907:961f:b0:b76:25fd:6c26 with SMTP id a640c23a62f3a-b767150bcb6mr4531486666b.6.1764625999274;
        Mon, 01 Dec 2025 13:53:19 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5a7b4bcsm1301459366b.71.2025.12.01.13.53.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 13:53:18 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-641977dc00fso7016656a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 13:53:18 -0800 (PST)
X-Received: by 2002:a05:6402:51ca:b0:647:56e6:5a3e with SMTP id
 4fb4d7f45d1cf-64756e65a88mr16115328a12.30.1764625998057; Mon, 01 Dec 2025
 13:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128-vfs-v619-77cd88166806@brauner> <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
In-Reply-To: <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 1 Dec 2025 13:53:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZsdKQVkVNZ3XP2UncbYdyF0BDZpM5dLgN6PksTcfAXQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnV7mxq4pU8UZsUi4lSRNVElxixzf1kreOUyXZrYdApZCogyMMpGEupFv8
Message-ID: <CAHk-=wjZsdKQVkVNZ3XP2UncbYdyF0BDZpM5dLgN6PksTcfAXQ@mail.gmail.com>
Subject: Re: [GIT PULL 08/17 for v6.19] cred guards
To: Christian Brauner <brauner@kernel.org>, Mike Snitzer <snitzer@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Nov 2025 at 08:51, Christian Brauner <brauner@kernel.org> wrote:
>
> Merge conflicts with mainline
>
> diff --cc fs/nfs/localio.c

So I ended up merging this very differently from  how you did it.

I just wrapped 'nfs_local_call_read()' for the cred guarding the same
way the 'nfs_local_call_write()' side had been done.

That made it much easier to see that the changes by Mike were carried
over, and seems cleaner anyway.

But it would be good if people double-checked my change. It looks
"ObviouslyCorrect(tm)" to me, but...

                  Linus

