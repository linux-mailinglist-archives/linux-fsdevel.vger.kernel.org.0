Return-Path: <linux-fsdevel+bounces-27860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131B196483C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC87C281C4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EBA1AE850;
	Thu, 29 Aug 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QMC9OYz5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8E18A923
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941636; cv=none; b=K1Lc2F60Ef9DgdjDHJx3JyONpn7CgYBvuQJzJZ5qBKp5fR/c9YXxJGHoZ0WsrXyCzBKGle8tlreNiCzalndl+yYNOH5JD752v4WVPPR2pipZDZDkrlsr+eBcCy23NwkXSCEJxwpFFYE3qrfsC1BGy79AdeRE7fhEW8mZGN8edAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941636; c=relaxed/simple;
	bh=Dzf6d2bdjoD0B5OMUYmUjZooF47c2Vi6q7JwFihNdf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS/3HVhJWmmuUcO8zN09iQRVrvawusu7h/ttYPuQUMbkx/Oq3WWSLaoIN+l6OEpOxL6mChCLIcLD16fA0LI5OUb6Ch9TyTeGLgex3iECzhnIv/sC3MGuN9tZ+F1LT0NHUEqiff/dHttRqLG01XPTyEYdZr5iPApN9yr60EC6MOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QMC9OYz5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6bce380eb96so388101a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 07:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724941634; x=1725546434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n2OOh+VCVK5/2MQz7ooKTOwltB8S/8ZEKBIDSHGLnlw=;
        b=QMC9OYz5hN9il5eClrXtjTvnvpLDVILkrsMYKQRFxYjmWRi4IyVuPAydr9n5Q2/8w2
         mWtjAthCw0NGApZ7StvJHmP9ADNN/Q/lw8l1zMEKxhkoOAqrpIar+Rq+LX2HEfsVMugS
         WCSlntNjjhi6oojStJPyVw62h7HXlIF9B1bzNFzYBRRrYtLxj5uOM9MJhv8bth3RnUcL
         grUoTwzAOQBvWLlxR+bwWWBugUFxE98zY6D26IXxw/Ff5afLHKYWMU7zEvi9WZKx+Hmh
         u7+NW9hQ9GsMRVwBiDqENYr0yd2d5Xuyn+cN/mU/tm+kfsec+dsFIvYp8dAGcuBwjukS
         QEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941634; x=1725546434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2OOh+VCVK5/2MQz7ooKTOwltB8S/8ZEKBIDSHGLnlw=;
        b=rMVwJHBl6iJ+ZReQYcbF1g4edcKSCdwFrJMP8K7MjivW0H1v073FRkoPKs/GHKjkcw
         WHRK4v2+PpgLbq7jdg1W9yDVvHMyoE9LzsvOZ8jugMbXXOH4ES0mroUFWAafJa1BQf60
         mHUVWISqwNQlJZ47iDPQQcn+1SCXqh6A2ahrfq0yktigoLEyYWiCRjp3HI1NBUxeXtPd
         IoCniPSh5hAL7+YtvcV8y1f5iqP+uSiKdf7uWD2q7BFhLEBG5K9aYLtsgUlDfUZaXz2z
         UeWTiOaaCVUGtSB483DerWfltor2T2c7gMhyIWCzWyYwA55wTYdQSbQTG948mX0FuSHu
         fdxw==
X-Forwarded-Encrypted: i=1; AJvYcCVmPQZIKb4K0a0dSVfJvmoRXjhCreffmxWdJlvLNYB+un/OjeYK3tOEaws6RKrATG5WEfIUmOKdNiO/b2dH@vger.kernel.org
X-Gm-Message-State: AOJu0YzhrkV5tUBpvR48iOHSz2ZcBvpufuH4k0UpVBi+EsNKgTD98UUm
	sfn+3S7IMhEtwB/W+AWSjUYLPzgcJ7G52FBeBF8oJ1Xs/O36TxGT5N/34S7dC64=
X-Google-Smtp-Source: AGHT+IHoOtZbO6aG3P1JZ9jG7nfRTKU3cDhAQsdkX112QyeI5JUZTX3EuDxdBLxMn0khFhYGynskaQ==
X-Received: by 2002:a05:6a20:e196:b0:1c4:c1cd:a29d with SMTP id adf61e73a8af0-1cce101c8fdmr2841575637.28.1724941634275;
        Thu, 29 Aug 2024 07:27:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm1270220a12.82.2024.08.29.07.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:27:13 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjg7D-00H16b-0t;
	Fri, 30 Aug 2024 00:27:11 +1000
Date: Fri, 30 Aug 2024 00:27:11 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtCFP5w6yv/aykui@dread.disaster.area>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>

On Thu, Aug 29, 2024 at 07:55:08AM -0400, Kent Overstreet wrote:
> Ergo, if you're not absolutely sure that a GFP_NOFAIL use is safe
> according to call path and allocation size, you still need to be
> checking for failure - in the same way that you shouldn't be using
> BUG_ON() if you cannot prove that the condition won't occur in real wold
> usage.

We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
now. This was the default Irix kernel allocator behaviour (it had a
forwards progress guarantee and would never fail allocation unless
told it could do so). We've been using the same "guaranteed not to
fail" semantics on Linux since the original port started 25 years
ago via open-coded loops.

IOWs, __GFP_NOFAIL semantics have been production tested for a
couple of decades on Linux via XFS, and nobody here can argue that
XFS is unreliable or crashes in low memory scenarios. __GFP_NOFAIL
as it is used by XFS is reliable and lives up to the "will not fail"
guarantee that it is supposed to have.

Fundamentally, __GFP_NOFAIL came about to replace the callers doing

	do {
		p = kmalloc(size);
	while (!p);

so that they blocked until memory allocation succeeded. The call
sites do not check for failure, because -failure never occurs-.

The MM devs want to have visibility of these allocations - they may
not like them, but having __GFP_NOFAIL means it's trivial to audit
all the allocations that use these semantics.  IOWs, __GFP_NOFAIL
was created with an explicit guarantee that it -will not fail- for
normal allocation contexts so it could replace all the open-coded
will-not-fail allocation loops..

Given this guarantee, we recently removed these historic allocation
wrapper loops from XFS, and replaced them with __GFP_NOFAIL at the
allocation call sites. There's nearly a hundred memory allocation
locations in XFS that are tagged with __GFP_NOFAIL.

If we're now going to have the "will not fail" guarantee taken away
from __GFP_NOFAIL, then we cannot use __GFP_NOFAIL in XFS. Nor can
it be used anywhere else that a "will not fail" guarantee it
required.

Put simply: __GFP_NOFAIL will be rendered completely useless if it
can fail due to external scoped memory allocation contexts.  This
will force us to revert all __GFP_NOFAIL allocations back to
open-coded will-not-fail loops.

This is not a step forwards for anyone.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

