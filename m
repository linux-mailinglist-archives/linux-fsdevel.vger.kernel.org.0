Return-Path: <linux-fsdevel+bounces-31656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC8999914
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73CE285A18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CF7D529;
	Fri, 11 Oct 2024 01:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M/3NUOpU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91BD2FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 01:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609654; cv=none; b=IMdqbw923xb6fpvDL3reKqPPA1Gktp+Cdm6zJxprn4eAcb2bol5svb9SC32ymgbkiYzk0FotWsQX5gmsSQUIBg9dCqKnabpBW7edxVExqqMoXPxu6x7dywqsRhhgRhVfmuI2H4iW9Yczt75ZUULLlA0w/04vK4QZ8EaNxBhk+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609654; c=relaxed/simple;
	bh=yslYLZ3UmvXQ3tXwi9DG46llkHldFxew638wc6nmTfk=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=TLLrK4ladWRm/hZ5UkcevLHnBDV0NcLEteEJc8HwAvIBErHiz31KAUeZsPTVZZW917d6dTUEr+A9voJ5OqetjORV9gqkHRmpU8Nm0+ELwhkjPeJ55xWH7+bgAuAtUEWd/NRL40Tfx7NJkuS0/6FR/gkc8LDuuJGVMZZLdxJRbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M/3NUOpU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6cbf340fccaso6146d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728609651; x=1729214451; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=M/3NUOpUqIoQ77RRYcYI/jJyZ/Xtik7haqQnRIc03MpHO+vtxDG2so4zK5yXMlOE70
         esudG/z4yLG0d93IWpHOIDMhnwsPhvUSVQKzYI4U+RDv9nSGCIMc1aRQ8RgzC5/wTPO5
         HmOyi5mXt6Ny+XHkhUuDcMaqWDk917J9DPurXoUOLSIDv4k2rMy8mK5O6tsbdHqgbNAt
         qsWSihDuCmm2NYTlAhzp/Ysf1wkBA1JxdPenX97Qf67FGbBgF61TxwWWj1mK0F72B0OU
         daZDc9DYyhJMId9SRHG1EcNLVI9r4z3RXRwF37OnDmv8CRz2LjSmJpk7hPPeAueeZqPG
         M1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728609651; x=1729214451;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DSYc5T3VWRhsmruLA3gY07A0OlNZL+RmUFs8WfbL2kA=;
        b=BNJEMfD1EiWusRf7EVlkObTYnH6o92Q8MTrjUchSfWb8N0028WHbMyhjFvrOPUSewn
         qieQqNcHA/n+5bLKRTMNWplhMazQKl9T1a+hY4fKuBYhyX1fqmMrvIU3Cupxvwb0r8UJ
         LcIZgtKdlfIbXLKtgd4qtrf8lz1QGtTINSxTQFI2yqiUuj5MOHvb5Bi4/bId5AwUAIjw
         LEwoaysiLA+5iBa70E8vsrRfF9rtkLUdA9fPNsS/rRfEpK5eoEo06FFZ98UP+RSI3SHX
         8bf4zowzAzzUYoqJ1xUUihJn0+badzgM6ZHjrerpxeo8pBALmoYk26yeJ//Teh4qQDYJ
         Ku/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOjGHNIfFZTzR5LBOzLtruBmxLrOl+XzoeMdqjjLtH+ntb8TLIIZDZOFb05l0zkHVYh4rRTlc2ai+kIGZ6@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWFLKsqfZL2sG67m2f6mdkZ0hO6ydD+D/UglQIQrZ9qPADoP2
	h1qTK4UTYQ8qZ7OhLVgQ/uzbHiH8uwmD/S4s1Kcjeve+JvK8tc5B477ca65CwQ==
X-Google-Smtp-Source: AGHT+IEqJeWFt79nQGeuR3bq2NUHrSRVHy+WW2D2IxkX40eKx9WlSMBeeYzd4yPkBCBf4eMRVOJxdw==
X-Received: by 2002:a05:6214:498b:b0:6cb:d3e2:ea0d with SMTP id 6a1803df08f44-6cbefabae20mr21350876d6.12.1728609651103;
        Thu, 10 Oct 2024 18:20:51 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608ebasm10941006d6.80.2024.10.10.18.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 18:20:50 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:20:50 -0400
Message-ID: <c4260a81d3c0ebe54c191b432ca33140@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH RFC v1 2/7] audit: Fix inode numbers
References: <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>

On Oct 10, 2024 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net> wrote:
> 
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
> 
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

