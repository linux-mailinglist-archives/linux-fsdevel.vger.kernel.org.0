Return-Path: <linux-fsdevel+bounces-53393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D792AEE539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 19:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C88817CEFE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5B8292906;
	Mon, 30 Jun 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bgkoFHpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC72571C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303088; cv=none; b=m49RGZaVqh7IBi/T3duo6yXFZXFbzYNBy6PdsXbXiwKwnYjgLXHfGuGgk6npS/UgzG3spFJdRHt2WpfIs6eKgglM8cw2IrA9UkFE+DozkX4kXfiIWGuCN18VY0JMNHtpinl5+vZjAMlevnSzQluISiXAHv8v0sc2252KzaL+RQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303088; c=relaxed/simple;
	bh=Z78nThPmdOHPPNEc9AsXIvP3YhtlCWcFADqAZX1UVhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScvEZnaNNhRKWpV4Z/ISANEbtm9XD491Epr/sqX3fBp5ascesdA04kzKoL5KezwRyc0YWjozOWsF9ZcQqGujwAPszGQAM/50ihv/ErJlfjMr5kOtqHBXCVuF8M8CN4fuZmgGgz7vUCgQh2n0aiVIFlwbGy86Eex8opS8myowk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bgkoFHpo; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae0e0271d82so812298166b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751303084; x=1751907884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1PglqBHRr0TsfqJi3pBpZbfbOwKj7UrldeIPd0TQsEc=;
        b=bgkoFHpojTvlIEIdNZXqzHLtaPe5XeQ9EpW+68g3AsQs10m9DUPVGbQu+tlWnwlhhH
         QbC/GlwTksoo2LcGVTOqbCNbvPPcIvOg18VrK45CJaNTmnKWNOjYKVUbl7f14F63RdeE
         /0tuGiVZX2jKiu2WyGy48sMTOqVtN/Jf+yXSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751303084; x=1751907884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PglqBHRr0TsfqJi3pBpZbfbOwKj7UrldeIPd0TQsEc=;
        b=gkuRN7FBVNkUEHnjRR7LgFcUMwUPBt09q9nECQsLgEIiChnIRrQpLBe0kqMl7fGR3w
         oDO4VZvPrANIEzrHctX14fzajlr4vRvaFeBQ4kHH1wrNFHpKtciNSNZ+t6cMAO/6K5SP
         r9mKL9C2FcXNOZDUJW/tQaX2iBUex+4BZoyeTyQRTLw3auwHZQguAGCAUHLBLBLjCGgs
         FJTfNpPEpL76QIDctgsXNofbjF+hYGPf5Wga98al06nfRsjelpUVXt+wcgYEU9KHbuo9
         N7BF2diV8w4zlD1cBHJnCzbWC54DahdoP7N4j6DjJI8a7tVF8iNHRMwWL7ZW5wn65PvP
         4kSg==
X-Forwarded-Encrypted: i=1; AJvYcCVGvXXR84hU90wI5vlvPh0lP8+WBVjc8Fd/qpkO4Hfggzq3G+EJ+mSPbzqAh9CnI8cBsHuzauZgar5Cd+7U@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj96bS/T8ixumFsRViYhNB/BymKS5NzHvIZEm9ZQIQuo0xdTTL
	Mtnd5bmQ3Jg68bW34/UHu0LzS0pKKRFxLsr8TQy4O7acifDsVnh4r/rNy20mN/bNLDlZTJnBbrl
	8SKCyIlI=
X-Gm-Gg: ASbGnctOVWTTPj8tqlv/3gh6jmItjny4mCMABuq1IIJSwRUGsjxXhIml1Jn9M1zWA37
	deqo7FJf2NnLcbvs2fYIE7A7t4S5CKjU6dmJBYKSzXfn0gutM/3Ud+lBM6D7GJkOslgM6My0PPZ
	o7PWwlvwG1A48trhy9WKoWCt7DsEzg6JZ4kHVxBV6e96wvroi2J9twext5PijGdHYz8AFGj+x1a
	gdMAt2d6oTc75QDjEJvM7WMk2eYnrBPPHOFzFTmZgBxXD6d+XnxPmXI65dWsCSuGQDCQroT2BKA
	cYZcy54IjhxBX4mdmnWmZiiFGAU46fAiCmx5ZUagWhm54ojzOdQuK84JGa2JEV83hAa/p9x5pZ+
	1m76lAD+TuqhDDUwpMbkt13gWGgmmm9bO5asBN/pC6pEqlK4=
X-Google-Smtp-Source: AGHT+IG+KAwzM7uttJbIQXWXFItvrxrEbrS09xGipKYkSc5+XCS+Ltqdv+UOlBJHdujrdohs6bdY1g==
X-Received: by 2002:a17:907:3d8c:b0:ae0:1fdf:ea65 with SMTP id a640c23a62f3a-ae34fd8821fmr1300494866b.17.1751303084255;
        Mon, 30 Jun 2025 10:04:44 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1feesm704281266b.159.2025.06.30.10.04.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 10:04:43 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso9569575a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 10:04:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSDIi5UwOIv0DDH5MyYbXElSsJwykOGoJuc6cCeuQKLkL9spFpJHiMVrQZmrU0MSY5Vs/miTANuBedyVWq@vger.kernel.org
X-Received: by 2002:a05:6402:5188:b0:5fb:c126:12c9 with SMTP id
 4fb4d7f45d1cf-60c88dca13bmr13097423a12.25.1751303083209; Mon, 30 Jun 2025
 10:04:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628075849.GA1959766@ZenIV> <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk> <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
 <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV> <2085736.1751296793@warthog.procyon.org.uk> <20250630165504.GZ1880847@ZenIV>
In-Reply-To: <20250630165504.GZ1880847@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Jun 2025 10:04:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUFkF1a1tWUcv5YsQnjFsHzwmvgO1uYPzve_WYgea9+w@mail.gmail.com>
X-Gm-Features: Ac12FXzsm6CW9YrQsrkmsmq9p11YYdLDnvS_ykyYaAhagYsofdr1DPa5sMDxzdc
Message-ID: <CAHk-=wiUFkF1a1tWUcv5YsQnjFsHzwmvgO1uYPzve_WYgea9+w@mail.gmail.com>
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re:
 [PATCH v2 17/35] sanitize handling of long-term internal mounts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	ebiederm@xmission.com, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Jun 2025 at 09:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > Is any arch other than i386 limited to fewer than four register arguments?
>
> amd64, for one

No, x86-64 has 6 argument registers.

Anyway, the use of 'qstr' doesn't actually change any of that, since
it will use exactly the same number of argument registers as having
separate 'char *, len' arguments.

But the thing that makes qstr nice is that it's not only a good
abstraction, we also have useful helper macros for exactly this use.

IOW, instead of passing in "name, strlen(name)", you can use
"QSTR(name)" which does exactly that.

             Linus

