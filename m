Return-Path: <linux-fsdevel+bounces-53223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2169AAEC984
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 19:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3377A9BA9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jun 2025 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8F24C67A;
	Sat, 28 Jun 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y/gc0+Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF202110
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751132502; cv=none; b=TT1q06j1W7jBuX5rD11ICKfKBdcU2Shla10scCcqjej7kJofMO5jZamWkQgsUp3Ok/FaIbcTmSYB2b8L3sOGMn70d9i3LRme8tcl2syfyjLPozXALdLcibI5QdjLcYEk4KhRhD+ql06mV6+DuIzNhw2OreNICHrcKxvQX06cS6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751132502; c=relaxed/simple;
	bh=wEkfaZyV9FWsbhCaF70xqgYSIe7F5mVIwG6oQek1vGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olqgBDAUzlw5NUYzi4M2QLpkk2aJ4js7qC7A85nJHLPw17UppFYtL3DRhlAeOEybCabxZdCtcwmMNiFX0xyAesoJSoTVldOd08Vvvg5BIGDvAVvTsW3s0Out7Ukg9AmXIkdyzFrzsrHwEPnwG429vFSU5E6zOUkuFPXxF8gKVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y/gc0+Iy; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0d4451a3fso144838566b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 10:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751132498; x=1751737298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KYvbHb7C+lPFQgU43E4iycwVWbqZvOY8eq82U0mSsuU=;
        b=Y/gc0+IyjERkMtHO5/09qRkjDC+n/D73b8mWhmqQmtTu8xog2bgC10/75NiA7KRYjF
         OqI7eqv0DZU7QXXnhCsVTOC1OxmBV8HuWKCcK7jv42OxGWIIL2Ofh8g7J5X3lE8aNYaU
         EU4GysC+7DxuNVYS6VH2hQk2uExgiyh/FhkAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751132498; x=1751737298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYvbHb7C+lPFQgU43E4iycwVWbqZvOY8eq82U0mSsuU=;
        b=gEQR08in96KtP7aCbka0qDIPBNRnMx4A2PgpJjsy7J3UhaX6JPe0+pn14TRurCsmAz
         CiQurVL76e5jCDhsLS74tpIQnRzRUpKXtlLwKDwxHAPYHwpCTlMJ7JWsib/GisicLb/w
         3HUrkaSuaLfWHcC951/Mw5NMMqhnv/vUsg6dzsIrFVoktaJqMJ5MMZf6YPiagr3EeJXt
         ZqPkci+9Oz2FLZrZSvp7TgcacA8U3KohUjLVuYKXMxXo2O/w4M8pqpV745yqdu89NRS4
         1/4NWal+gzPgqp9iMRZ5VeGvH2YZxyAbnYpIBioRNJeBSqicDYMiIh3aG6sC9/KkfgM5
         WC2Q==
X-Gm-Message-State: AOJu0YzJDwUB/rXdisC1J/Y2pxh8cUCzoJFjmJjhSYXpopYIvjwcdgwM
	WePZMcaacP5CWSMeNOPft8PQo0wHwndnyr/s1VTPq00k7dzHCCbpv+PRk9uk1iXGEAhKAFRXi9s
	l0fuqkifiRA==
X-Gm-Gg: ASbGncvVDCOZZJD20ZeluHKbRxrstBYyUdB65+fth9KV686CxqOmfzjDUByWq9wxIRE
	NwUdPCHjcGxXwVv8juW5oIP4Qg0KMZxgBCMj54Qs5630Wr1q5Zzoui2EhCr11IKEan1Z+uc9Ipc
	m1kBsqyT2gUjXQs82JmW/jBKgF/Zw3swfWjaQsJV7VY6AqT6oGlzhYDPB89lC9XmMr+/I6mKpUl
	qNp+J9TNxyBh+6kt6xi0o+CBKPi8tx1Q0fUepvbvIEagR6ZqhogKvmlVBdVyW7HqQqRjvhZd6Nb
	RLUYxMb1irAHDmranzD6W0/7k1IAKo1NdBf+SU/DgPOGKKqMg40kMjcl4EY+ntegsR/UiVVfVXD
	4WUXp0G8IS1Y4kFLaMDvRKs1lPYUsjNd85xem
X-Google-Smtp-Source: AGHT+IEwgzc+Vuw7IAScnUH45Q4yBqAEFKbIRm3+MApdziOW4oB2cqW8DcjPksux68sMm5r3IfMhaA==
X-Received: by 2002:a17:906:6a14:b0:ae3:70cb:45d5 with SMTP id a640c23a62f3a-ae370cb46dfmr258073466b.48.1751132498197;
        Sat, 28 Jun 2025 10:41:38 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca20e8sm341532766b.165.2025.06.28.10.41.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jun 2025 10:41:37 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so1738557a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jun 2025 10:41:37 -0700 (PDT)
X-Received: by 2002:a05:6402:274e:b0:606:df70:7aa2 with SMTP id
 4fb4d7f45d1cf-60c88e46d49mr6751044a12.31.1751132496849; Sat, 28 Jun 2025
 10:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623044912.GA1248894@ZenIV> <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk> <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV> <20250628075849.GA1959766@ZenIV>
In-Reply-To: <20250628075849.GA1959766@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 28 Jun 2025 10:41:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYT6nF27OOkVXPiVuEYwoB66Sq-7jS=osmFKh7kNsL4Q@mail.gmail.com>
X-Gm-Features: Ac12FXwQZg-p4s4NIuAIibARece8Q_7vBxG9se_-5_3nmu1Z7MAPgGQ1KLVMykY
Message-ID: <CAHk-=whYT6nF27OOkVXPiVuEYwoB66Sq-7jS=osmFKh7kNsL4Q@mail.gmail.com>
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re:
 [PATCH v2 17/35] sanitize handling of long-term internal mounts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, ebiederm@xmission.com, 
	jack@suse.cz, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Jun 2025 at 00:58, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Frankly, looking at that stuff...  I wonder if we should add
> vfs_parse_fs_qstr() for "comes with length" variant and lose the length
> argument of vfs_parse_fs_string().

Yeah, I had had the same reaction that the whole "str,len" thing could
be a qstr.

So no objections.

> Yes, it's a flagday change.

Yes, not optimal, but there aren't that many call-sites, and as you
say, anything that gets messed up (due to stable backports or
whatever) will be caught by the compiler anyway.

            Linus

