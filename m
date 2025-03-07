Return-Path: <linux-fsdevel+bounces-43488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C327EA57501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0856E16FEC4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 22:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75422580C8;
	Fri,  7 Mar 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh53VptK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945211F94C;
	Fri,  7 Mar 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741387267; cv=none; b=UqhrlDGHChDB5hxhmYYV3El9ePodY3YzaORqIQTK8IpycTJTOZ0eGXZM4lsima8S+SKZei7CKG4VKLiK1iTVGUOibeTnACKWUFEFSgOZz8OLbLqWQ9DBqsGmaANPi8hAebu0d/M0QBjR3rDP5prmaDXUnV8M7TF0JB68uO8HnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741387267; c=relaxed/simple;
	bh=x3cT5OzrNNP4NxJGS4WJPfkluOsb0nETns4u0Ojzlpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKG11CFMzEmneAOylCctakWcEI/uinTyP0AGp93paQoRxZAIUts8uEW1GkDTy/WhtqGksUMSUImxjoa/X4NLB6EpqigNU8E2msi+ac9D3/aeaBc1z8eaKC4/eK4YjIlruddGycfynbjZrbwHne86F6yYpH1qE/JTzMsi8gNlyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh53VptK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so4313868a12.0;
        Fri, 07 Mar 2025 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741387264; x=1741992064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ggo5IorXSw5yWeu+zzKighXyQFobt6Vs+8/ESBuOkA=;
        b=eh53VptKVLTpj6ZMjrKy8V93Dfok2z+mDEDL27+eAhA9o11fmHQoufT8izE7JO3Jrg
         6CueZBfTGE6a48+yhwDF4YP5jI3cS16WfYfFam/bYZym29LxjC5ydTHvLE3h0LnCSW+2
         7n7by7fnulPdQWqp0LOtw21a2lfzUPQibNgzF2sFiFb/ITh8e732vjsPeXCa8Ohxya5q
         1nJB8GLvhpvbg9e+ww2C59zpCGwzL/qvpmUXGMsnUsH1TmbPMz14bR6DOvwi8b7mdMZW
         lJlhYpBFt5b2FHc5NrVFuFFwbVeWg9ky7pvi7rw5c+nKGD2Znb975Z4ZJFoh2IBLlvgB
         mi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741387264; x=1741992064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ggo5IorXSw5yWeu+zzKighXyQFobt6Vs+8/ESBuOkA=;
        b=OwWfTY8Twg/PD6AucKKY1DJPlXSlRZg90Y8zJh6pUwstlcRnl1cIRSPs0FFkvOeLzz
         UnHMOmCBEJrGEeOjK261WFYkMKFljXEMyKpbf+Z73vFsx+dqhjb1CuvD/NSEbhcLg9yU
         NiE1ILMFy3O1mMQMrZsyeu6SFnAbyImsBix4eP4HG75HEOqKMVI7KvuES+3BPxEODvlr
         E8GKLA29vAWqZxSpSINU8qKBlD84AkENjCrQd/GqtLPNpqIRNqlQwKMaMmt4U4UOV9i6
         r6TvKET+bMm1sRcCIlZ0UPFIPXaG52SIZbVqZACEqiA/8RQgvEXZkoyrTiY5iutbZbjQ
         SlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW4j6XFc3X70ha1TBU4dFk+xtZmFb4ZpSFnkWeER2soB5yJzZrugu/XTWE9Obhbz0rVsIhI3iS5cg6BslD@vger.kernel.org, AJvYcCV6oVj5y1k7SoEHwaH3b35jcqn4/PUQGpUQ8F2LJPxD4axwHNjnnZZlDpQc2QtSAc0u3th7heKrJNZW1czQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx56V65f8hCHmJPu1SEGK9KRTd6+nMGg5vdu37nU2ZrxQCVU0DG
	cOSjQo8/pgC4aFC5HflBOAGLuiPzzYLWMjEh4YbggCt1EbNtg5K4
X-Gm-Gg: ASbGncvCmIkqA58JazgTebIklkJ8hwyES8DUpBSgEK2x93xTu0nvqKZPUxvVSHMvPSn
	sKUd4RC+/ZAWnkrQskRcEl3JITsbME8xt3pTe0DoulWgFMO37We4aVYhAYjHdKQT2JntBGWG+q7
	M/ohlUVxd3xV90PqZOB7tuBi2+m9SRz2E6NZcWi+P/nEZCYSQDYWGRwxh6EwaFT1nINwWtobn7G
	OXSmRgGWRUEhWuOV54Hky0geubqUy2sJ8cDpF8E9IfQvTSHwJahkyjsvUWbJ1JXaIEM0rOD3K7f
	+DyytSz9pODtwVpo/FvoANA9sFmZH0aVwUUadZnE6KpUTBLgkFOkhjsx04Pf
X-Google-Smtp-Source: AGHT+IEgPt0sdGguIjjOKmjAkc8jdDmho2fuLjnhwj0zTjlQi24P8aCxYbBIrezeb7UjaRYxX6sSkg==
X-Received: by 2002:a17:907:9491:b0:abf:8f56:fe76 with SMTP id a640c23a62f3a-ac252b35ac0mr545698466b.25.1741387263600;
        Fri, 07 Mar 2025 14:41:03 -0800 (PST)
Received: from f (cst-prg-95-226.cust.vodafone.cz. [46.135.95.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239481685sm344141366b.58.2025.03.07.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 14:41:02 -0800 (PST)
Date: Fri, 7 Mar 2025 23:40:54 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	David Howells <dhowells@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/pipe.c: merge if statements with identical conditions
Message-ID: <wkdxihiolxnzelu57llc7vealuofie3l42clbsn7tqjbvstxqp@a6d74rhrvcla>
References: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307222500.1117662-1-linux@rasmusvillemoes.dk>

On Fri, Mar 07, 2025 at 11:25:00PM +0100, Rasmus Villemoes wrote:
> As 'head' is not updated after head+1 is assigned to pipe->head, the
> condition being tested here is exactly the same as in the big if
> statement just above. Merge the two bodies.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  fs/pipe.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 097400cce241..27385e3e5417 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -547,10 +547,8 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
>  
>  			if (!iov_iter_count(from))
>  				break;
> -		}
> -
> -		if (!pipe_full(head, pipe->tail, pipe->max_usage))
>  			continue;
> +		}
>  
>  		/* Wait for buffer space to become available. */
>  		if ((filp->f_flags & O_NONBLOCK) ||

I already posted this :)

It is hanging out in the vfs trees (and -next), see
https://lore.kernel.org/linux-fsdevel/20250303230409.452687-2-mjguzik@gmail.com/

