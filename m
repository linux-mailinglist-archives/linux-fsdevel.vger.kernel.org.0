Return-Path: <linux-fsdevel+bounces-43491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD5EA57543
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70C118994FF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF57C256C80;
	Fri,  7 Mar 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="e7cuHqKk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004DE18BC36
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387906; cv=none; b=FzvwKWgN3KcLnchrgdTyQCtND0GqxjJYGCCvGqLG+hRtIMXOCkF9UH2nfxMR23Ceu9If5NUHBjZJ6vEaYizWs6S2d943vORQPNNONbCNSplfl6E1Y5p/bGUNKFTA1Hzm7D3JbwcmV2Sur2B+BRbNT7RR9b/mE7M5Nwxke4dcLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387906; c=relaxed/simple;
	bh=h+yH4nMqnONyPvR4b5+ysIpFa/g+49z4eyeWl8EfT1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hcXGj1JqCPVQPbBeaKWtEfRQwDG2AbKEpTMNAS9pkrcqMfIXkjUuyOwvm+qauBw8mDnNtwlMI1C/+EbSJBFbdV4IDhj6Xj+oc68mMtTYrdI4OntNS/jvoQ1462mVfKlOTbFSEnhF7q/aH8sIDpYeLxR9mFZP/drZJKePB7sPOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=e7cuHqKk; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso3921213a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 14:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1741387902; x=1741992702; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJgB/M7aLDGShp5uE5Ckn92GHYjwSxnasPCMDhgEbVs=;
        b=e7cuHqKkbG3Gtz2KK7meopf5VHHY1flytAH/7eduNHVfgD7eG7k61KTbdSY9SjdciK
         YX2lSsVHIsPluSLGDjTlFS8X7LGEgZSK3Tb47aZJwv7BQFLwR0GRKkjFwkOsqcoH7NYO
         ijETuTF0Ku7kNhDBOwEAHY+nmTn+H+Rg+IeQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387902; x=1741992702;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJgB/M7aLDGShp5uE5Ckn92GHYjwSxnasPCMDhgEbVs=;
        b=K3BgzGahkU9+147zgVp0EkIP/o7eFtct7Xt0xFAEHMzLoP+rRdzjcrE4Lm52aTIywT
         grjawrO1Ss02jYd8f9XgHMFi+rRnjbTrFzaNVtOOZXmNnVkv8JlydLNDFUd2ZCGJFy/k
         r+8QaIKkvaw/0g5hMNCSdrdHa5Q0EI+FrzmKSuhNhG+8KNDNOi4wuS1lKAmEcNextmoW
         XWTXB+hmM/6jfsL8ljRAVtNmPhF+6WNhi5g9hZjs1J7P3pRUWfa9Cl0BCmrJz35mHglT
         6gtx71IQcPVrCe8x0VSmheDEzuzy63fcfIOCmYOg0t2qfhbcoEmc15TQmCg1x8HJ7yjz
         xFRA==
X-Forwarded-Encrypted: i=1; AJvYcCX4PBrtLxVN2VOu3ilcNCfz1Q05f0LmNICoyHUX23sL6MH35r07i3yL3r57PU/XsIf21KQ0qIxhpfM7CwE9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7MHIb305HUWmJ5IfJORr2ecqG7Isuw7n7p7pIbVnRwyo1pILa
	waaivSiOooxuyKj6MQNM6TEfdl/UdHKY+y5XtwD8GAr2/vxKV8yGRcA+SCFN6nY=
X-Gm-Gg: ASbGnct77Gmu3bP/t6WkViMGQqkkNgr5AHn0x2qw41nawhYyjdZaQIfYUTCLAN8JXoM
	XX2ljVARZeq7CWb7lHhCRw0O7mWU9Q0kMyVweKJnecEur3aX4tHlvP5Af+DHhSuf3PbINvOT6m8
	TMsFg4O3MRlnW2zAcyv6DJZg8WiGKsVyuQsvvAi3wFKO/QDhDZf3LHFB8HQf5jdCf1D0jkeDZg9
	lE2A8yBKPswYI2CWyMFSXqkBICxM5IRvIL066MzT7DMLwizoe06kkYArNxJ1fr1qGGUKzrYgIxi
	pJWfksC30EgbMp467Z47ekwKzCMjIeWt4uUiUPGZh1+wEzlXXVebjyVHBgVJim+BHgjc1U74+KA
	X5fI=
X-Google-Smtp-Source: AGHT+IEfRYJcajOnqEBzT6wuJUDmUfI4G47zNSYjcP9pqXZw2dbdllJoQnhD61zML8NDpVTavFbSWA==
X-Received: by 2002:a17:906:c03:b0:ac2:b73:db4b with SMTP id a640c23a62f3a-ac2525ba768mr585756866b.4.1741387902286;
        Fri, 07 Mar 2025 14:51:42 -0800 (PST)
Received: from localhost (77.33.185.121.dhcp.fibianet.dk. [77.33.185.121])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac239482f0bsm334109966b.41.2025.03.07.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:51:41 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,  David Howells
 <dhowells@redhat.com>,  Oleg Nesterov <oleg@redhat.com>,  Jan Kara
 <jack@suse.cz>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: merge if statements with identical conditions
In-Reply-To: <wkdxihiolxnzelu57llc7vealuofie3l42clbsn7tqjbvstxqp@a6d74rhrvcla>
	(Mateusz Guzik's message of "Fri, 7 Mar 2025 23:40:54 +0100")
References: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
	<wkdxihiolxnzelu57llc7vealuofie3l42clbsn7tqjbvstxqp@a6d74rhrvcla>
Date: Fri, 07 Mar 2025 23:51:41 +0100
Message-ID: <87frjo4fpe.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 07 2025, Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Fri, Mar 07, 2025 at 11:25:00PM +0100, Rasmus Villemoes wrote:
>> As 'head' is not updated after head+1 is assigned to pipe->head, the
>> condition being tested here is exactly the same as in the big if
>> statement just above. Merge the two bodies.
>> 
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>  fs/pipe.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> 
>> diff --git a/fs/pipe.c b/fs/pipe.c
>> index 097400cce241..27385e3e5417 100644
>> --- a/fs/pipe.c
>> +++ b/fs/pipe.c
>> @@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>>  
>>  			if (!iov_iter_count(from))
>>  				break;
>> -		}
>> -
>> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>>  			continue;
>> +		}
>>  
>>  		/* Wait for buffer space to become available. */
>>  		if ((filp->f_flags & O_NONBLOCK) ||
>
> I already posted this :)
>

Ah, never mind then, also for that other patch I just sent. Just
stumbled on those while trying to proof-read the pipe code.

Rasmus

