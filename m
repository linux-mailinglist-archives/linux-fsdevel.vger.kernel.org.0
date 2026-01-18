Return-Path: <linux-fsdevel+bounces-74300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A601ED392D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 06:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F2CF3017647
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D130BBBA;
	Sun, 18 Jan 2026 05:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqoFnf4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5E1E3DF2
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712438; cv=none; b=r8JLmrrWHW+lgEce2Ok2l/XXnmz4dRg9MxQnORYn13B3XJw6GHPaqY1VfDaHVLwMqH2o3ASASryBlmwLEQAhEDDKM1vH9qPTVD4sskmNlU6oPACTjR8Kp3YEEPOINwZpm5NQS2AKq+Ym+RKV6an0ANBw4jRJIkQgJjXtAzIyaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712438; c=relaxed/simple;
	bh=XaLT14wN7KoiQP7XtGlWF8PUol7duNaG48iDl/N9krs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNOBxIs5JGT0LJjKojtkC5Wb9/RtLkyz8eVksZVCR9Xgi5WURrHQgtHKzuvCI0MJzd4QUjIAZ3+Z13wZw9KsGYOQskqs8FbAqvVBUAnW7q1LWbFEjlSv6kMrGQCx7nlhVYsJS88ercBvoWzFXyan20RmOuqk77O2Q1StjRyV5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqoFnf4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEDCC2BC9E
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 05:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712437;
	bh=XaLT14wN7KoiQP7XtGlWF8PUol7duNaG48iDl/N9krs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oqoFnf4eCfgA9UY9FZignaMmarmMY23MCveU9o4sTs4w2W2K8Iop4QbXfHIXWTqfp
	 UuCrbIaD53xdriFpIVKgLGzYHRH1fZJHjJkGFLqYzJvpuxs+FliUIfupP1Z6pq1uxI
	 rooVNd8Cg6G7LjOAmy1w6Qj6uC8n3WuUvkq6K3dPIegWLlC/ZBcNygnAmXizxB0acQ
	 dVVlcNvp7vBwkG/E54fcIV8Jsa+UCtib2Yctn1qMR93XGcL78/pNT4t3g4x1WPmS5a
	 lkz8nw/RB2dR9QhmVTFV2ehdOgjH8z/gAnqShDJvQXYXAUtuDf2cr8m83Slf0ckTRN
	 RwTrSLfMn7YFQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8010b8f078so549718666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 21:00:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUty96QZJQkeKwDHjt3RDIfkO7xrvjPoxCQPaGDX7ORmMEqrHzzoyggoGYSQ1Q8/bVnghENfy4ycR5jSxat@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4UQFv9yWQQXb8qgVBHOMrsGZsO8R2epWvJypKPvHQvqGHxp6S
	KihxQjfEH+jWvyUE7DX0lZi6TYpteRCZPrmM+hKTLlgudcbvRuC77XMBnKbdDKSPWSwBPA77lF5
	9I65Vn3opWPVDmauAFqmkBYtpCjkSUCY=
X-Received: by 2002:a17:907:86a7:b0:b86:ecfe:b3d with SMTP id
 a640c23a62f3a-b8796b31309mr661705166b.43.1768712436231; Sat, 17 Jan 2026
 21:00:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-9-linkinjeon@kernel.org>
 <20260116091831.GB20873@lst.de>
In-Reply-To: <20260116091831.GB20873@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 14:00:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8fDfrbtRODYcNPCtceqJt1EG0Vywdb=tYUtXhbh06_5Q@mail.gmail.com>
X-Gm-Features: AZwV_QgXutFXWUy5vSIeb172x3Dpr6QW9s7kuRTTH4FZOhicJQB-YdIDe3UileE
Message-ID: <CAKYAXd8fDfrbtRODYcNPCtceqJt1EG0Vywdb=tYUtXhbh06_5Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] ntfs: update attrib operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:18=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +/* log base 2 of the number of entries in the hash table for match-fin=
ding.  */
> > +#define HASH_SHIFT           14
> > +
> > +/* Constant for the multiplicative hash function.  */
> > +#define HASH_MULTIPLIER              0x1E35A7BD
>
> The hashing here doesn't seem very efficient.  Is that part of
> the on-disk format in some way?  If so it would be great to
> document that.  If not it might be worth to look into better
> hashing helpers from the library functions in the kernel (not needed
> for inclusion, but probably worth it).
I will check it and add the comment if needed.
>
> > +struct COMPRESS_CONTEXT {
>
> Other parts of the code got rid of the Window-Style all upper
> case names, why add a new one here?
Ah, Okay, I will change it.
Thanks!
>

