Return-Path: <linux-fsdevel+bounces-10703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12584D778
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 02:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67587282C66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 01:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C314F68;
	Thu,  8 Feb 2024 01:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/F1Xw2Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658871E892;
	Thu,  8 Feb 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707354861; cv=none; b=Jq34b/EjVyEuZl0YqoIJFTSMJyYtacsysfwIzGrvHY5sfnRuGDikx0ku9osT5HBm5JgioN0no3gJrcZ223wDr6DzZcM6gtlEUGRrVgL+fmuFmsfsy+nDwq0u1KOF09bymN57ObYG6gx935NsDhqlOuJt2FMm2WbRqRC5kIApQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707354861; c=relaxed/simple;
	bh=V8hu5tMPUddcH6YFCxePDhQZpJF/Hqq+culCda8DuO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+jiWtPOqMThKffKziead6YoBj4Cna/hCA/s8bc5Ft/bcSwvmNco5G2ZHdpZa/OeU+bTOS2OJ+0GVA9gspEcuk4EoM0aS0QMfINzgXsZbg6BvfTotCJD/Xf7vhIu/5d/qs03jShBwzs3n99p+Cu9+MA+UzBKTzrXfwL9C7vxRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/F1Xw2Q; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363afc38a1cso4384055ab.3;
        Wed, 07 Feb 2024 17:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707354859; x=1707959659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kFsX8xdUkzE0GD5ap+mQT8txMXBLmGUqgXm2bLd6w7w=;
        b=I/F1Xw2QmGvXWTjQsjdph6f3fDN4LO9xnPLcUjV9XN2y5IctYy53vQLKm1aEZ8DTzS
         HUtDitJ+8L7qeCXTRYIB+fWx3FO3q81A5WrL5CFpN8h/Il1fcGZZ1wm1R1VAqReRv/bJ
         QiRIHbb8LStOIzBmA0o091gftj31UkYI1H1FsdFhs4g/m9UKR+Tnd9C7YnBf610we+GK
         NsHVjyjbWZ6nLVg7HEtA/fbFh3YRuZX5CUdX8oQysY7tFpZP19iKGGP3aCtNUuU5yfq4
         9ZosnppGKxkQ3z2IgEMsoAtP3k8fzD7p3SjSs83lenFEBdKBkzuzJ0YErkKyKK1kq9v2
         48VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707354859; x=1707959659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFsX8xdUkzE0GD5ap+mQT8txMXBLmGUqgXm2bLd6w7w=;
        b=KbdRux4wVBzjyQmBfW360Ix5d53AQJ99igPI9wLE8DxXYA6kvsnL+R/s1Y7Fo9Q2EX
         P0hkstIxQzs3eaUXpYTIZDwlzWdNHKxNNhbj7GOH2eU6ybib8Xpn47HJ0sq28+pWcbV8
         yAU44ZYTpXwcAZ1ET858oneK1jM42rb8KDTPiU94KLOKx/Ofd86o9aDStQdwss0sffb5
         Bwg/Wukxf8RyEEDsw9nH9c0lm1KHNGQGAATU+nS0b4FB7vtraXBz/s+DNBGWFAYY5BIR
         6Ma41Ivm7u6ZbDFNc9//u9A5blEYoMufsaW7c0rE5fw7uFxvfuYHc2ynSlPDMyO1ZxmA
         qlfA==
X-Gm-Message-State: AOJu0Ywox2RJ6mxglFHF4GzV71xQBFV0Fsg/XAm3g750egR8KyMRpVaF
	Dz1jEVOOnP6vZdQOpDNqeuJAwD8AEj+BtxwsyiYxH5tZMp0RZpyg
X-Google-Smtp-Source: AGHT+IEeXxDsTYV4nuQUqnrtwwu7sZeXmBIc/+m645CbzT8RxgHWW4nTPDIn3pbYDfqQ1rppeQ+5Ww==
X-Received: by 2002:a92:b70b:0:b0:363:d9c7:a7e6 with SMTP id k11-20020a92b70b000000b00363d9c7a7e6mr4561249ili.4.1707354859402;
        Wed, 07 Feb 2024 17:14:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUK7DfxOkbAVat6x6wMIv1mx8Efi6Bh32GuM1x0seIJVrz7NH8MCWuF+5GSN961TwiPD/mPakBSgrHE2BUT6N/8zpXTpVgwFlppFm7ecOqEgziAdoDwFBnfUZqAdIBlgMJKu1RuTFbmXx6tfj5DZPdPykCJDnhqt3zoX2DIj/vQuDmPPQbsGGah5oBO4yim8Cgu22KBycbwPYBT1MTFpt3+96dE0wPd67EfZbYfnst/Ay/vKQ5mKJEihG/H2ZxipCwhtkz25Yg09TLtrEciLkLIux+/u7sLRF3WjKciyFrf80Hd1MwRWBMHcpDKRUCUczWDQkxmFI654P0bCbOTKciwn/JxEnPg2DAsxz6oaw==
Received: from fedora-laptop (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id v15-20020a92d24f000000b00363c584361esm702700ilg.80.2024.02.07.17.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 17:14:18 -0800 (PST)
Date: Wed, 7 Feb 2024 18:14:15 -0700
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	kent.overstreet@linux.dev, bfoster@redhat.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, masahiroy@kernel.org
Subject: Re: [PATCH RFC 0/3] bcachefs: add framework for internal Rust code
Message-ID: <20240208011415.GA574244@fedora-laptop>
References: <20240207055558.611606-1-tahbertschinger@gmail.com>
 <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=00+vZ+BqacSh+Xk8_VtNPVADH2Hcsyo-MPufojXvNFQ@mail.gmail.com>

On Wed, Feb 07, 2024 at 12:06:05PM +0100, Miguel Ojeda wrote:
> On Wed, Feb 7, 2024 at 6:57 AM Thomas Bertschinger
> <tahbertschinger@gmail.com> wrote:
> > I wasn't sure if this needed to be an RFC based on the current status
> > of accepting Rust code outside of the rust/ tree, so I designated it as
> > such to be safe. However, Kent plans to merge rust+bcachefs code in the
> > 6.9 merge window, so I hope at least the first 2 patches in this series,
> > the ones that actually enable Rust for bcachefs, can be accepted.
> 
> This is worrying -- there has been no discussion about mixing C and
> Rust like this, but you say it is targeted for 6.9. I feel there is a
> disconnect somewhere. Perhaps it would be a good idea to have a quick
> meeting about this.
> 
> Cheers,
> Miguel

That could be a good idea; what format do you suggest?

One question that I would like clarity on is if in general work to add
Rust into something like fs/bcachefs/ can be accepted at this point.
That is, is it realistic to expect that an upcoming kernel release could
include Rust code in fs/bcachefs/ at all (even if not in the form in
this patch series)?

Kent has been suggesting his plan to do this for a while, I think, but I
haven't yet seen many explicit statements about what would, and would
not be accepted into an upstream kernel for rust+bcachefs. (If I missed
any conversations where this was laid out, please let me know.)

Actually, the previous paragraphs in your email are helpful in terms
of laying out concrete expectations, so thank you.

You talk about using the broader kernel Rust APIs like the proposed VFS
layer. What about bindings for internal bcachefs APIs, like the btree
interface [1] that Kent mentioned in another response?

Would a v2 of this series, that removes the current 3rd patch and replaces
it with a patch to add in the bcachefs btree bindings, be more suitable
for acceptance upstream?

I think testing the VFS abstractions for bcachefs sounds like a very
worthwhile project--but it also sounds like a distinct project from
Kent's goals for integrating Rust into bcachefs in the near term.

[1] https://evilpiepirate.org/git/bcachefs-tools.git/tree/bch_bindgen/src/btree.rs

- Thomas Bertschinger

