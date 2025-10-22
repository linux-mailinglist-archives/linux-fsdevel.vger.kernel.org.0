Return-Path: <linux-fsdevel+bounces-65124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBE0BFCCFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C9D44F944F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C8534CFB9;
	Wed, 22 Oct 2025 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DvEHqalF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C7B34B686
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146226; cv=none; b=EjIDvVCt+LltrlDRCvZCmqOO/wBEL8Fp/fSGWRm/aC2J4kJCmdm3fdBWOkQ6qyAuCnCzh9wzGVHyrnNQQkOgwfc3tq1SIdWoQ9R67sKAT7s5lhoXfKmrI/9dREp3sO2FKLNIk9gttnABqzLpdlq2WjqDEj4sVKAntY4IyDsCHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146226; c=relaxed/simple;
	bh=OXIiWMPtiN+YU2NFW0i5Rjml45gOXITGkMIHm2eAIu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FypHzaRIE5P/vpLg1txL0eJtXqZtvvfweqkUkMtZ68LCOYSZDIQODBqn+BzSArtBi2yIYZQcOUnRsy9cibdlLW4BKidNj0c0tgDe/amWQmQB1AJXasnfFgVJNgP2veAQAmQ2XUj9WhvJAFZQAhw9Y87mVy771cvw11cq+LjrkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DvEHqalF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1364284166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761146219; x=1761751019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=DvEHqalFuWjszacmlT2Q6MUpyXAnxmHSK74vUHrFHNcaN6z7zNkQenAnKPmspX6mi+
         7u/D5SLiq+w16ZbdvZl/Nk8SZgvFHPLBvJeYFNpuS72Np+/5xNcasmdDFYDOuo0PC5gV
         na2TSkfsvP4gYb4cj4AKJDcsFxCeGyRZKiQe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146219; x=1761751019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8Ks3283lFKT/3or/kKLaFk/rSeUKOKq+L7qyJbrS/M=;
        b=oKQZeg6jbJ10QUVwTv7O4rKVxKCHtgkVbOv5NqfxxN1lLkOQETkX5cHNfwqP7TwP9d
         dNmF5+xjxHAiqBhTqnyyHCcnfv9cETXl5FO1AVRysy4/Vig8nyDQKgtA2zSZBToQ4cxW
         QaMbPgqi8MywxqXtEozr4kjxNO/pG3uYl+f10eLpP4DokpnFebZWKN1LmpvG+OW2EnC1
         7w9eCD7CYRJqidwGDf2vNzlvw3c6aXn05KaNgE7d/C3T3JtjmWcYsiuHGjud60bEy5Mv
         KKB4G6OMK4MrzMuUxKayMHp1hhqxJCkIEfnyD79uBIdZy8/ziB2TZvCpMxknuTNO+Fec
         wPVg==
X-Forwarded-Encrypted: i=1; AJvYcCWEPTJb2p8nAM+IG5PKX/BGUIU1bh0Ie/cVS5kdgzvouCMy5Z+FNbLT2+ttvjPBWWWCr1UVdamu1KuPXF8l@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hJYOYyUSCcwaIdk6oAgL1EsYX4ZmbSWdzynCN/+zt9cuXguC
	O205MigJvAH7AVbHFhDDpp60UA0+eHaEfeEPs+TzJUypLZip3/CJvlXM43b4k/RArh5OZgXvKXB
	SxnIcL4A=
X-Gm-Gg: ASbGncvFlNbAqe4EbuxUAzCysF37uqaJmL7V9b3j0ETSscauxTRDVM6jOt6bhDa6QwB
	cTSnFq/9s3n/VLunaojUfVB27c0/IWvu1A6rb8G1btJgJ6YQRaWw337m+MwKyAbUW8TgMfL+PR+
	CE1F0gXaFmZLyjcSOnJVpFhxA1GOBr2G9MmSwUZmZJQw7Ylqf7JwS9Nmw3GiTF7wFc7R0R8lb6r
	+4dAEUBFrOmEeFh6u4glMZLZEEcEEXBLlCsu9rydl97jdqPSm1oi8s4Gs9PRJNlA7k+sDocj2gQ
	PkfCuUZiZhudlrUhMYsmcqXD/opChf4UxbmdyQ7iattxz1BkETDiU9RmtWxyuCtU1VJwkJ68bhS
	SUfY6i4qaGrMe731VbijWblWooI6j4PyVVYSkswOpYl1Es/cs4z5n6a6gv5K4AV62Yzriml+l8d
	jJPEiCfqCf479DcC0E9dJUD5498KDX0oXBWufCh/yMCVI17/hnyA==
X-Google-Smtp-Source: AGHT+IEnTJ+XAKovqjkUQgF7OrKVgvW9kjUlhU06a1ThIV15HxhL532Ug75WU0DzVHtagtJa1AUolw==
X-Received: by 2002:a17:907:1b06:b0:b6d:2f3f:3f98 with SMTP id a640c23a62f3a-b6d2f3f4014mr372902166b.41.1761146219266;
        Wed, 22 Oct 2025 08:16:59 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da3412sm1359247166b.3.2025.10.22.08.16.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:16:57 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1364272766b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 08:16:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXePu0mLV4YuzZU+v85fwOArR+x7NcC9drPZny2uBSri3la9PXwi9+8zMzQyXAPlIqpXEKaYLOx+CVnHiwm@vger.kernel.org
X-Received: by 2002:a17:906:c144:b0:b04:48b5:6e8a with SMTP id
 a640c23a62f3a-b6472d5d715mr2448051866b.7.1761146216891; Wed, 22 Oct 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022102427.400699796@linutronix.de> <20251022103112.478876605@linutronix.de>
In-Reply-To: <20251022103112.478876605@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 05:16:40 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
X-Gm-Features: AS18NWAqLsXEY6bsEV3yJ0KWUZmBC6kMtZXzbsnMf3ubAyGEsrR55YgMKptZqjM
Message-ID: <CAHk-=wgLAJuJ8SP8NiSGbXJQMdxiPkBN32EvAy9R8kCnva4dfg@mail.gmail.com>
Subject: Re: [patch V4 10/12] futex: Convert to scoped user access
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	David Laight <david.laight.linux@gmail.com>, Julia Lawall <Julia.Lawall@inria.fr>, 
	Nicolas Palix <nicolas.palix@imag.fr>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 02:49, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Replace the open coded implementation with the new get/put_user_scoped()
> helpers.

Well, "scoped" here makes no sense in the name, since it isn't scoped
in any way, it just uses the scoped helpers.

I also wonder if we should just get rid of the futex_get/put_value()
macros entirely. I did those masked user access things them long ago
because that code used "__get_user()" and "__put_user()", and I was
removing those helpers and making it match the pattern elsewhere, but
I do wonder if there is any advantage left to them all.

On x86, just using "get_user()" and "put_user()" should work fine now.
Yes, they check the address, but these days *those* helpers use that
masked user address trick too, so there is no real cost to it.

The only cost would be the out-of-line function call, I think. Maybe
that is a sufficiently big cost here.

             Linus

