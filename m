Return-Path: <linux-fsdevel+bounces-78859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO25LyabpGnZmAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:01:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69D1D1702
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B164B3014504
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 20:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB35331220;
	Sun,  1 Mar 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DMrjPHMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33623054EF
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Mar 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772395291; cv=none; b=cXYlqDiUtsMLu027ZmyQI5fsHAI3pR2Hc44ceuX3VthexV+N6DsomGpHDlo2guYtAc3G5swZXE8cSdHc3ZsiwyE+kRD4AMtfFa9NxhfGt3gBua35mla/tHrOrR2ZZ+/7oXiWwRfVhWXB7LZ30lNyE1TehB2GxBDAFK9nLO/Dg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772395291; c=relaxed/simple;
	bh=Cx3qgkZ6V+eyMfb2glkDNNNfa4NrrGdL5+nlIhh5YNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGg5tM66tzFG6TJ5YhLIrQpssjx7j6NeZjMFwghohGvKN3PygrVSwK9+OwUY6yPIgIxqVGKmMP+XqECltPyVWEz4Te/J8zHpA2U6VslwtsP3AbPgwbmm/LjONNlIDN2oJCFW/ZqP2YWbypTZ67Mr2XTjHcTZINSOGcWqPS9/oXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DMrjPHMg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f992167dcso394274866b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 12:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772395288; x=1773000088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jB/XXPWSS4Vb7E8KI5vsQ0OyjX/VbHAJPkU3Kvm8KQ=;
        b=DMrjPHMgqgU9xr9Psd/yXRKnKcH46K0KSqoMgFJj8ZqFLaHNugylDAZhd5gUGjdoxk
         tiNI7JgbjozOLQk44MKF9XcqO6BdCukrCFmkRLYHDOvhpT1M090tt7sP43BzDBRmJUTe
         oA90tJcyhMsiLkbc4TDdyZ6kit2f9DaU199OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772395288; x=1773000088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jB/XXPWSS4Vb7E8KI5vsQ0OyjX/VbHAJPkU3Kvm8KQ=;
        b=UX/2/yEmBDhIs7vaoWhLKTeoJqxnHP2iNKT4+xKN530h/bH9FUzUVjUSJfb9WMhvcb
         eV5DPW+VnNoFjS3n+9yCnKD7cwAO6hVkmLC/wYmOv6f1QT1wIO9JfF4V/8lCvEDfQUiP
         daldsztEyhxutt2OO45Bxr0fM5aZywkrNrk++jctjrygDDHQ7xTYlZkqGEZWOqSjpGMy
         N9FuLAChYIwkQ+KXgwAqxsaLJfgI7g+Cn9X5tPAOxenYy5/87Lyb9h3USXddZ2709tvC
         t3ug0TvbtA6eETD+qiBXbvOFpd8sT8vohg6rF/paFokJtuObPB4y349b8qmpAxKz7m9e
         12gg==
X-Forwarded-Encrypted: i=1; AJvYcCVT8Ih1pLTWSCPs5waWqDuglANtbj1djAumUv7SHH+7rmR+qOBLEsxiBGVzQJX0TlCCtFUV18E7dOa6dcdB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TJUSZcxGytEWXMljK5w/LiRWX1Q3FgS10rkvuNkPD4MVdiyG
	TuojYTY5cf7hKdT0LD9d7MqT8CcuePdxafgzayTNudt4yoTpYOYD9jaiIJpRUgrw/lMTbDgVAYW
	qTlOf2dYZgA==
X-Gm-Gg: ATEYQzyaVu7ZYaUiUKZqNN7WeNej4G4y+uixp9e2wn8Enag3D+sMJacQ88kHVWt9J3H
	53Vym2HSOeC4sKYq9M74bnqZyeNkuK8579sSwRAgWaW98b/XGLeYuWrmZ8Za3nbMoBuzN8ngb0z
	NtJ5XOsmGgcZkdc22JFW+SM/D5EanSHRU4bVL0FLd0yf2/KSBJqQlfpR4M1DFvSaVsFZIFBfBhc
	9wgfdU0PqZPZaIkgzHTtvCXUpypNWlPBJ7I/6/UBerNNs35uqGvmJg8RoU4QqTNjiq51xk8nRIl
	mbI3ChISWmXT840q5DjhiiPl6+xIh+73pyyzXNDOghHr6Lpl7Z7pBsg/Xa6b7m8gQJdks77g+u5
	+LKwiU4UAfEJE7LtpLNOBG+u4/mgAmY9zjAKwO6IpjfPiRQ3xJ0toaqeuKqYHC6jsmrL8N9X6zj
	WzcsQlg5m76WKhMCGoLBI1f0BCAXZFsN5EfmaSRBO/OT+KVed8Tbum/6nw3H6ZuakPBuNyiES0
X-Received: by 2002:a17:907:3f82:b0:b83:32b7:21b0 with SMTP id a640c23a62f3a-b937639d513mr669838566b.17.1772395288029;
        Sun, 01 Mar 2026 12:01:28 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73d2asm386108966b.26.2026.03.01.12.01.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 12:01:25 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65f73225f45so6029480a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Mar 2026 12:01:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVg18y9NO2sA8gnmo28OHDcrTKue2ow9HT4FeHLMKmmYpa7mWxqSZa2THPg5dQYRtlmpcVMLVlKAUn8VGNV@vger.kernel.org
X-Received: by 2002:a17:907:3f1d:b0:b93:5405:9260 with SMTP id
 a640c23a62f3a-b937c64ef77mr572433266b.30.1772395284743; Sun, 01 Mar 2026
 12:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
In-Reply-To: <4e994e13b48420ef36be686458ce3512657ddb41.1772393211.git.chleroy@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Mar 2026 12:01:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
X-Gm-Features: AaiRm51s3eNxZj_25SK_rlwxCS0TV1EUyjNISFnudmurbAezRL6om8RwkB99_8Y
Message-ID: <CAHk-=wixyP1mzyVcpZqQZd_xbabZQ873KVph3L-EkrNZGv3Ygw@mail.gmail.com>
Subject: Re: [PATCH] uaccess: Fix build of scoped user access with const pointer
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel test robot <lkp@intel.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78859-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,csgroup.eu,efficios.com,citrix.com,gmail.com,intel.com,armlinux.org.uk,lists.infradead.org,kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,inria.fr,imag.fr,infradead.org,stgolabs.net,igalia.com,zeniv.linux.org.uk,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B69D1D1702
X-Rspamd-Action: no action

On Sun, 1 Mar 2026 at 11:34, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> -       for (void __user *_tmpptr = __scoped_user_access_begin(mode, uptr, size, elbl); \
> +       for (void __user *_tmpptr = (void __user *)                                     \
> +                                   __scoped_user_access_begin(mode, uptr, size, elbl); \

Why are you casting this return value? Wouldn't it be a lot better to
just make the types be the CORRECT ones?

I didn't test this, so maybe I'm missing something, but why isn't that
just doing

        for (auto _tmpptr = __scoped_user_access_begin(mode, uptr,
size, elbl);         \

instead? No cast, just a "use the right type automatically".

That macro actually does something similar just a few lines later, in
that the innermost loop uses

         for (const typeof(uptr) uptr = _tmpptr; !done; done = true)

which picks up the type automatically from the argument (and then it
uses the argument both for the type and name, which is horrendously
confusing, but that's a separate thing).

Does that simple "auto" approach break something else?

                   Linus

