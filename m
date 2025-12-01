Return-Path: <linux-fsdevel+bounces-70325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4205AC96AF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E7F34341B3A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E333F303A06;
	Mon,  1 Dec 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exfusfN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0122E8B81
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764585413; cv=none; b=cEIG5bzWn/WJboUXd6BRR+MhaHrqiSl0fZdaKEMxipUvI5GGskEeuT+EUKgsng0ACEUAurwMrGnUaOIMIAznoRyugzt0we7fr2Wmh75jybMTRA99kGiEKWdUiCFfGOk82g/yL41vPTbpcdFttXRtfT99BCZodS4GkQ2Cd/5DPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764585413; c=relaxed/simple;
	bh=XYWQNg+vq2Qya/8SmqQOrQGyCoVBqwwRb9StzyxHKFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Idg92E6rvgQ2uWN/1S9bro6dfxjby+0l9PzAcrr/uZyYCfVktN0WWl1Fa+jbYocHp+02j9+vF6MY3HVnVJZlBYW0rl5ZKjchOdknyb3sBOcgXIufMdMHoe7IB1P1atw+CXBDuDTArGBA+E20rqvDtOzWMcS8bAutRL0MBlYaIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exfusfN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB63C4AF0B
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764585412;
	bh=XYWQNg+vq2Qya/8SmqQOrQGyCoVBqwwRb9StzyxHKFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=exfusfN2xdMadVZUtRGvILoChtEv7S+cQIksEXkm8dCigRLoQlORk8CUy9bGFOF8I
	 hdvVYfGsu9RD4Ospgphi09TjVtZzBq2ddRll4QW6K/ehLA07aXRjh4GPvaaZqMOmMn
	 hbZ9ApiujSLYpkdAOcSh3Ostvt5MhE99kxvYUX5PeGWODWBwa3w8CXCQZydPjr5Dud
	 eQGrSrjAhjCuSMRmO6ytBHlwmihRarqRXDoHmhsKuBV+/V9LVvbA9uyHZhwDB0IxlX
	 8OWca7UwlfQoUh+R1S8R9GJlWePE0xU2nXmezwemmw6VtxYFEeDw+4K4vbT9UGff3I
	 M9gZE8SkNsVVg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso1988053a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 02:36:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVR2oMWk6izCuzVOTnSt017qYMYaoAlQGFtG/Upxl3xLcZChYK5NS/HoxVQz8CEDMmFne9Z6OFnnBbUTtm3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf3G8hs8c9QyXmpcVDxfO6c3DSBcHeTgszHEqZJvFVv5vh21I
	iQzj0qR4QSm/aTSGSefLWgOqBe7YOzsNBcjdnj27FNa3CVpBYsouNsVLrUgoZ5Xi/rMA7eRWyhp
	Tq03moEElEEI+TlTeIKWMBK1qsYKwa6Q=
X-Google-Smtp-Source: AGHT+IHE4Ai0xSYbPCkAvD4Pk/K4oBqjxe2LD7IXScb/xPKXW2lgHjPJKRVOxyFr++DU7WNPK2Qxtf2pU8DhwsOV+gI=
X-Received: by 2002:a05:6402:1396:b0:643:eae:b1b6 with SMTP id
 4fb4d7f45d1cf-6453969fb83mr28904123a12.12.1764585411294; Mon, 01 Dec 2025
 02:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127045944.26009-1-linkinjeon@kernel.org> <20251127045944.26009-2-linkinjeon@kernel.org>
 <aS1AUP_KpsJsJJ1q@infradead.org>
In-Reply-To: <aS1AUP_KpsJsJJ1q@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 1 Dec 2025 19:36:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-vxzkCJf7D7OOXcVxZn-AbtLFOKAvVqpKEyKyOMsTVdw@mail.gmail.com>
X-Gm-Features: AWmQ_bk-0gW3HTKjZGL4imfqtr1UIxJ1l_fqnvdrtTsndUpX21SnELcXW_HaoNU
Message-ID: <CAKYAXd-vxzkCJf7D7OOXcVxZn-AbtLFOKAvVqpKEyKyOMsTVdw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] ntfsplus: in-memory, on-disk structures and headers
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@lst.de, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:14=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, Nov 27, 2025 at 01:59:34PM +0900, Namjae Jeon wrote:
> > This adds in-memory, on-disk structures, headers and documentation.
>
> So a lot of this looks very similar to the old prematurely removed
> ntfs driver.  I think reviewing would be a lot simpler if we'd
> find some way to bring that back, allowing to focus on the new
> code.  I'm not sure how easy that would be as the old version
> probably won't build, but a modified revert that doesn't wire it
> up to Kconfig would still significantly reduce the diff.  Especially
> with the rename back to ntfs as suggested.
>
> I can see that you don't want to do the rest as small incremental
> patches, but even a very small number of larger patches ontop of that
> base would help a lot.
Okay, I will try it.
>
> > +iocharset=3Dname               Deprecated option.  Still supported but=
 please use
> > +                     nls=3Dname in the future.  See description for nl=
s=3Dname.
>
> Is there much of a point in bringin this back?
I will update this on the next version.
>
> > + * ntfs_read_mapping_folio - map a folio into accessible memory, readi=
ng it if necessary
>
> The very long comment for something that is just a trivial wrapper
> around read_mapping_folio is odd.
These comments are from old ntfs. I will update the content or delete
them if they are unnecessary.
>  Also why does ntrfs need the special
> EINTR handling that other file systems don't?
As Matthew said, it is used to read metadata and need to be handled in
case it is interrupted.
>
> > +/* sizeof()=3D 40 (0x28) bytes */
>
> You might want to add static_assert() calls instead of the comments
> to enforce this.
Okay, I will add it.
Thanks!
>

