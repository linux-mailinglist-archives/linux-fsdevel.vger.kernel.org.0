Return-Path: <linux-fsdevel+bounces-46625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EFEA91910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 12:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2A8188B516
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3503A226D09;
	Thu, 17 Apr 2025 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW9Y9RFY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AEC1D5CF9;
	Thu, 17 Apr 2025 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885086; cv=none; b=A7oHoTLQRttIKCdpSd8hrSGUumeM+R3xY2T19dY8meStiIQgDs/HDm7o0qzh1QbEtzFzc+tJGklQCTe/ENiG8bt9bcgpq7F/Qe7NJRYq7rbMGmkkRa1ebrMxjKcvnJ+Q+vn0rVpKZVVvn8T3CczHl/vWEsTQ5U4PSevJc5xNQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885086; c=relaxed/simple;
	bh=rF92U0urWt6p/1AbiPtAf80xk17/Dsl9xvRoza9f7OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksopEjWu7ZExGMgyYslu2aW2EjPboocAV6CGS7CEtR/UmzIBU33yuWfKbTP0NyfFEXLcWHpfxitJtGyt4v6zOtgRge8MxN5iJExG5Ut4dPik2/IXP3t4G/Xbspgp2n4XrWuKwa9ABKGBP3qYHke0xSF1NjT5Fe7gZgBK5Gy9Suw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW9Y9RFY; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-acb415dd8faso87506866b.2;
        Thu, 17 Apr 2025 03:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744885083; x=1745489883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l9skOushEggbMsJxKcF45wWS3+ATrrzyuUsGqv0t7ro=;
        b=KW9Y9RFYJ+JmFVoFfdNqPbmy8RtLoU2U6U83zeWveBRyowNCLr/C17aeEoj7xZYGFS
         cOGMw9YxwvQZ0ewVTq7PlRaviBe98pI4VXrRwipmETSlvA9u2P4u9Sz67xIQoyn3u2EK
         AN5jCMEwCdXaTLDCQJx1dsJLQnl0AixndtUG7lzheuQPS5TnWnYsgFXQFVJRy19lBke4
         UupHNkDGaB9IF9zUxROdw2lq5JA5fc6vbAIB2Mu9l05hOKVGZjNCZaJYAbCltF1gDXne
         G/ILcEKfrdxuBsOraRSeVP/Obh6H8uEWnnq0fACUHojkPAhEkfVmIj7aBfRIMkZlQUV0
         B6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744885083; x=1745489883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9skOushEggbMsJxKcF45wWS3+ATrrzyuUsGqv0t7ro=;
        b=sNLuHazBMbdKN8KFqMBnNtc9nEJ7jBR/VCsJBXjuY9SFwacSaJ5sYO+rtC5kBiPBtM
         wt0Lg5XVhrJ9viOSjUHNdZTw99Exxggqj/d7pVigfC8fb/a+4gqoJy9E468+NH5V2UCJ
         pu7ygfIUza+/e689HwzkA9hAZUnQm8q9wkTFdw2o/TZUx4nkULa0CBx8nFL1AUdxrtSN
         N+o2moRmSJ/4Rn1uPnPqTs1WzDmgAXCGR9b/BhzN/h9Z+SQ2Wx+2ztbvQzKNP+3FrTru
         N9aitKCjfhoKph/EFPpD8s5yDLCxOrkrtqODkUre2X1wewWwkbt8MWM2VVKRjUtaLwVY
         aXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9sNasO8KTQvNKB/+w7Lry8oiehCz9YAWtM83WP0tBD7WstJUZsD48c5tBTIPk+b6pZir9m+f1sTnQrBQZ@vger.kernel.org, AJvYcCWmetGlicj1SmIt2RjO2e2CQHL7wJfX6rxWVoQqrGbViaUrMuoCj8xrPEdNkpspatYxXLDend0Y2LNWI7u/@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJm2un5sE1jF3Q8qqCrSc24QT+yHAxSRpV9soWN3MUg93a6j9
	cg1c8hg5LOiyHOwW2o+TqNu/ASVHObG6cfGNVPrB/pBjswbqtx1o
X-Gm-Gg: ASbGncsz7ubkQaAThjPs4+THWiVSgQED8lDa45CD+4drPSZ+U/jlV5gGNjcWrrT6l2r
	dhyfBWTcGuKB/+xXZxE2SPNIWGWVc04sgfzWsF0np1j6fU7eiRqwNc3thmVx7FZlxZ3mHjohaAK
	kSl4Wvq1X6tRCS38JQ0jRlG1UXqVyds5C8p2YdryU2KXuhHtMCOp1GllMNOhHXiow91kn+4dNJk
	UbQA+XY5Lunk18dHbvSlm/zhMI0jmUUkqQQpXQfK83plItxk5/k+rIFnrsjbOzZ0B+UrUbeIoyS
	sk0QCwhA3ZRLJvAgpXimFZW3Bj3cbkbtcnKm0ZTkQQIjPu6KsDGKrd2l
X-Google-Smtp-Source: AGHT+IFlFTz1i8hkW1ayUI43fP0HBbOeOnZrYXBdNwyKbNNyaLitmXK/BtM5DVGKI9LSAZcCdlpucw==
X-Received: by 2002:a17:907:7fa7:b0:ac7:95b3:fbe2 with SMTP id a640c23a62f3a-acb42c5a12fmr400036666b.56.1744885083009;
        Thu, 17 Apr 2025 03:18:03 -0700 (PDT)
Received: from f (cst-prg-69-142.cust.vodafone.cz. [46.135.69.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d32ecbesm269586266b.161.2025.04.17.03.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:18:02 -0700 (PDT)
Date: Thu, 17 Apr 2025 12:17:54 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs] a914bd93f3:
 stress-ng.close.close_calls_per_sec 52.2% regression
Message-ID: <hupjeobnfvo7y3jyvomjuqxtdl2df2myqxwr3bktmxabsrbid4@erg2ghyfkuj5>
References: <202504171513.6d6f8a16-lkp@intel.com>
 <CAGudoHGcQspttcaZ6nYfwBkXiJEC-XKuprxnmXRjjufz2vPRhw@mail.gmail.com>
 <CAGudoHHMvREPjWNvmAa_qQovK-9S1zvCAGh=K6U21oyr4pTtzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHMvREPjWNvmAa_qQovK-9S1zvCAGh=K6U21oyr4pTtzg@mail.gmail.com>

On Thu, Apr 17, 2025 at 12:02:55PM +0200, Mateusz Guzik wrote:
> bottom line though is there is a known tradeoff there and stress-ng
> manufactures a case where it is always the wrong one.
> 
> fd 2 at hand is inherited (it's the tty) and shared between *all*
> workers on all CPUs.
> 
> Ignoring some fluff, it's this in a loop:
> dup2(2, 1024)                           = 1024
> dup2(2, 1025)                           = 1025
> dup2(2, 1026)                           = 1026
> dup2(2, 1027)                           = 1027
> dup2(2, 1028)                           = 1028
> dup2(2, 1029)                           = 1029
> dup2(2, 1030)                           = 1030
> dup2(2, 1031)                           = 1031
> [..]
> close_range(1024, 1032, 0)              = 0
> 
> where fd 2 is the same file object in all 192 workers doing this.
> 

the following will still have *some* impact, but the drop should be much
lower

it also has a side effect of further helping the single-threaded case by
shortening the code when it works

diff --git a/include/linux/file_ref.h b/include/linux/file_ref.h
index 7db62fbc0500..c73865ed4251 100644
--- a/include/linux/file_ref.h
+++ b/include/linux/file_ref.h
@@ -181,17 +181,15 @@ static __always_inline __must_check bool file_ref_put_close(file_ref_t *ref)
 	long old, new;
 
 	old = atomic_long_read(&ref->refcnt);
-	do {
-		if (unlikely(old < 0))
-			return __file_ref_put_badval(ref, old);
-
-		if (old == FILE_REF_ONEREF)
-			new = FILE_REF_DEAD;
-		else
-			new = old - 1;
-	} while (!atomic_long_try_cmpxchg(&ref->refcnt, &old, new));
-
-	return new == FILE_REF_DEAD;
+	if (likely(old == FILE_REF_ONEREF)) {
+		new = FILE_REF_DEAD;
+		if (likely(atomic_long_try_cmpxchg(&ref->refcnt, &old, new)))
+			return true;
+		/*
+		 * The ref has changed from under us, don't play any games.
+		 */
+	}
+	return file_ref_put(ref);
 }
 
 /**

