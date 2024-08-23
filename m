Return-Path: <linux-fsdevel+bounces-26919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5995D0F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0209F1C2148A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0D186E4A;
	Fri, 23 Aug 2024 15:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="1mgZQ+HJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD223BBC0
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425578; cv=none; b=lMSnW8yU+QdVu28bBpaHR4syYeeZAnEytV91cw05AXx+dq8jNt9tuAbruQLKIGLyCqUZw5COTLY3qwy+eTYPikiLJ/xR0STHtGuvU3RIknGv0I3LTh+UjnCr0MOpQF4xAVPqdOIInnKWgw7ySinxyRNG1jzSNlEj3mbVs2EsvC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425578; c=relaxed/simple;
	bh=xewB4Il9PG4v5juwhv+li4MaW6riL0Nm7TgdF2KQ8bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSz9NPT6uuBF3Sbndb6dJLiJyVxYCl8UUcJkjztFXcQnIvmdceHjKVjpAyR/CtgKI2kE7Byhj7TcHZ7MMe0AxZIrPkEk+dm6wqse3QKELz1sV8O8NwTiokx31amPKA68RI9pHW5XFRWlrpQTjNLRkgYi1lU7PNik6VgBAEDgIoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=1mgZQ+HJ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b59a67ba12so20251457b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724425576; x=1725030376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fncxDPY0X2Mz7UhsBS2PEyBoGGaNaNy89v0n1+JjUgg=;
        b=1mgZQ+HJ2dmbQBXFtFFJmXTB7AhWKWPalE07As5FmvjEXTySoWjlCelP1//psl+T2w
         kpxRXfdnUNuFCtoMoWinIyMbbP9MkBDBw9XntgjBwvd9AwV2AyWZoSprcxnkZQSVhCIG
         VRLhbpv2Y1b30bGNzFs9DVM6M2WZ0r27Jdn0sJSG4OfXwnCaKM1R/kuTkFN3gJadmLkU
         sJ0U42pQYW6BFvOLWuIJa5qBYso+8FuhMEjX3Zlx+MaVXKI/1+yPdm1xauYOnwZmz+w1
         wYHDsq9UaFQry2Px05YtLq5fY3Jiq9GKG5wPRS3vKb/nGiY73SqArRBnsJ+obn/TDa5B
         N71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425576; x=1725030376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fncxDPY0X2Mz7UhsBS2PEyBoGGaNaNy89v0n1+JjUgg=;
        b=CXY9uVQZyLir/M4rLCAT3uitQSM6dpQlfu6TlaUaQlqxizyOkShhnei3c9jNHXV5uK
         2s5Vm6iBioKBJc+vaBxdQZoYt+hvdW40/U+r6hz9W2T5TCQc1eKdDIkXTEugz8L50LCD
         KjXM0xMS+fqMGvraeh4gqasP0jEsVC8GSZoB836Ku/ZdF763CaSthAeCkUupY1lZQ9dJ
         ccCelvMGX3d3npP90hEvp3ehSev8b7vicGSDnFV3en2ZWYJPOox+RyymmehESq4HMqQb
         Yk4KxDbQnd0gLTS7QOteZd7z/ffYZ4mnDJ01ncpPsoGfsEJP7ipobBp01X7ykjnHGOwi
         FTow==
X-Forwarded-Encrypted: i=1; AJvYcCWTzm+avWxoVHomxC6b7+CvqUlgO3cLB5zXmhBh6EdBATsmqp0mrCDeDtLdtYc8Y3/9EWTtvj6DCD989Xp1@vger.kernel.org
X-Gm-Message-State: AOJu0YywPymVe9IQfZgD5vOeNQumN0RqZWknAh2m3+6HIIXaEfppt7ps
	Hmzcj7qM45ramawwzzanF1s4LAyWRKZErVqtUIcgMopTOILYX2hnIb0Y3GzzaJ0=
X-Google-Smtp-Source: AGHT+IGiJf2yg90kRKXAjvUMxNgt2UMX+DiAfRYvmGk2aDhlH+7eZ5pJV6mjIi7CKKRNjqgpcR6kFQ==
X-Received: by 2002:a05:690c:3309:b0:66a:b6d2:c184 with SMTP id 00721157ae682-6c625f1cf89mr24722207b3.16.1724425575519;
        Fri, 23 Aug 2024 08:06:15 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a75667asm5740437b3.54.2024.08.23.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 08:06:14 -0700 (PDT)
Date: Fri, 23 Aug 2024 11:06:13 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 0/6] inode: turn i_state into u32
Message-ID: <20240823150613.GA2234629@perftesting>
References: <CAHk-=wjTYN4tr9cjc2ROA1AJP5LzMh6OoNAz8pVSUMP0Kd7AFA@mail.gmail.com>
 <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823-work-i_state-v3-0-5cd5fd207a57@kernel.org>

On Fri, Aug 23, 2024 at 02:47:34PM +0200, Christian Brauner wrote:
> Hey,
> 
> This is v3. I changed to manual barriers as requested and commented
> them.
> 
> ---
> 
> I've recently looked for some free space in struct inode again because
> of some exec kerfuffle we recently had and while my idea didn't turn
> into anything I noticed that we often waste bytes when using wait bit
> operations. So I set out to switch that to another mechanism that would
> allow us to free up bytes. So this is an attempt to turn i_state from
> an unsigned long into an u32 using the individual bytes of i_state as
> addresses for the wait var event mechanism (Thanks to Linus for that idea.).
> 
> This survives LTP, xfstests on various filesystems, and will-it-scale.
> 
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

