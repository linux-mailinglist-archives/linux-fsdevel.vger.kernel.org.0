Return-Path: <linux-fsdevel+bounces-72520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B57F7CF90D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 48013300E617
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8AB33CEBB;
	Tue,  6 Jan 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcE2+6Be"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1933CEAC
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712691; cv=none; b=Mmrv5mwc9xVh8bbkEf8GhMqWdCZNZrXMntGFYrhynXdudHPK7lpAE1DJVMlPjdnrcx01QWVVxMVhan9RSM7xaAFQoM/pkbO0Tu5x1iDWunGUtB1AhmWcXRazjkJ0wc9HrBgbeX4GE2e0axmF6+fjLoDuP9kxQDiyp90+03/qHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712691; c=relaxed/simple;
	bh=8JawXRopwJlEpFZ9oQL/+W/nJ1h5/p18VbKBvObzTwY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=efyfRLWlu7BrMEDysRK7Qn7Zm56AMnC1lyCq/3egF1c7TQOtTZknrNa/9WiQiR2hyEFohjYmjF06ctM1kg9ki3lEIn5EBVLLDiHbC1HCNS6mStuZO7O6YHGd8N4ujg91LLIXHL6BUo7gPib5uA2VB91eNb23ziSc71S62B+jbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcE2+6Be; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430f527f5easo1763788f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 07:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767712688; x=1768317488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8JawXRopwJlEpFZ9oQL/+W/nJ1h5/p18VbKBvObzTwY=;
        b=rcE2+6BeRuRUQhHYjsAk1CMje1n3zdxJws3VBcIO5kVK8cfWw7sF8J3SuUsJOxNRqc
         s+Bs645Dn03v80ouFM7rPUlSxNmqpRSbH6gtVEA+s/VS26bH+nrLc85rdWcooZKkT0fp
         p429MPUjnrU3g+H/Z6Cp5iBITtX1Ftp8ESIwPyIuGJ2GyRVZ0PjJCo9QO2xZ85GCmQ3C
         YJXxutSotlkQR8E1Mx0RhxPtpVOxdP8Q2RzFSBIYFtB8qad/hixIhKsRLpNgMvA41Y8V
         0i+PSgjlxtHP4KBBxvyzzmsTUnwKk9nkmmFlvBtMuVMqX5sp4yhODQQnyYscuAGcr2GB
         lsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712688; x=1768317488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JawXRopwJlEpFZ9oQL/+W/nJ1h5/p18VbKBvObzTwY=;
        b=KQn4OzwTMG6JJsQQ9QeruwgDQbfRTcIkw2YTknmz9Ei+BFG8fihcM+Q2haMGBZawBJ
         RC72qalzhJfUwce0ouHqtarlxc5lSxMmv7ePDJ7GFpETKQ1dN5g291ZlUOuALR7Kn6yr
         Oovy6HlfvcMuvrwU1jjQ4456O5YwPeKlMwRgALUG3S7KBrecZIjupUJGyNw6ZKG/IhDs
         +0TgQBkr6ChzeoGZ7y4IfzMgOIakD5K4uuoiQTKg9uDX3y/TqX61AgV9x5kAPwfC76Am
         J5hNDMYKpPdxx7JdfpioNxe632HxYk2hRBj4FCf81uaI8ETSVV10exwPe3o5rnVeNpCk
         wzpw==
X-Forwarded-Encrypted: i=1; AJvYcCV+IqWmbab2FNSQs5aDHbV59ERG1neg4sFYaoht/4I1Xg3rSaCeRISQpVAK3GI9arwcLIIAfJriYkm80rgh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5G2v8eZQPV1HNx6VY9Fm3IOi2d9mqFzyIptPv2Gxmlqqa2617
	5wBHvGmdoPJ2+doMvf/oA8XfOgzJtoiYSK3x5MqcM0T1JU39P0oxzlUb4tHeYMQmCajnVy1GR9W
	n5PQklgdhYCIjPg==
X-Google-Smtp-Source: AGHT+IE3OnpH6EUJ0wS9ZPc0y94lPf33yIm964IOLFO5/GRLNXrwj84XCaovj/fE9evwakz9iSg1q9P6wBH0Rw==
X-Received: from wrge10.prod.google.com ([2002:a05:6000:178a:b0:430:f7cb:cc85])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2601:b0:430:fbce:458a with SMTP id ffacd0b85a97d-432bcfd37f8mr4055583f8f.18.1767712687945;
 Tue, 06 Jan 2026 07:18:07 -0800 (PST)
Date: Tue, 06 Jan 2026 15:18:07 +0000
In-Reply-To: <20251224-ununterbrochen-gagen-ea949b83f8f2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251222214907.GA189632@quark> <20251224-ununterbrochen-gagen-ea949b83f8f2@brauner>
X-Mailer: aerc 0.21.0
Message-ID: <DFHLULRAP6CP.YQSIO9W6NHTC@google.com>
Subject: Re: [PATCH] pidfs: protect PIDFD_GET_* ioctls() via ifdef
From: Brendan Jackman <jackmanb@google.com>
To: Christian Brauner <brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed Dec 24, 2025 at 12:00 PM UTC, Christian Brauner wrote:
> We originally protected PIDFD_GET_<ns-type>_NAMESPACE ioctls() through
> ifdefs and recent rework made it possible to drop them. There was an
> oversight though. When the relevant namespace is turned off ns->ops will
> be NULL so even though opening a file descriptor is perfectly legitimate
> it would fail during inode eviction when the file was closed.
>
> The simple fix would be to check ns->ops for NULL and continue allow to
> retrieve namespace fds from pidfds but we don't allow retrieving them
> when the relevant namespace type is turned off. So keep the
> simplification but add the ifdefs back in.
>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/20251222214907.GA189632@quark
> Fixes: a71e4f103aed ("pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls")
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Thanks Christian, I was also getting a NULL deref from running
the x86:ldt_gdt_32 kselftest on QEMU under a minimal kconfig (via
task_active_pid_ns()), this fixes it.

Tested-by: Brendan Jackman <jackmanb@kernel.org>

