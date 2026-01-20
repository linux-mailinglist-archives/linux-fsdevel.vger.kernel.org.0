Return-Path: <linux-fsdevel+bounces-74577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3693BD3C02A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004D4502D4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AE33803F2;
	Tue, 20 Jan 2026 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjaWyeAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC04C38B7D8
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768892575; cv=none; b=tlfxDxX9D+M4Z9ufMCSieBaJqrvTLVMfEIeRsYbcDEsR4/WeFoYlsWTgqGQj01EERlCoOO/9Xm7rFGlcEwmmHIU4/48lo7nzYPAkgq1NLZkBPV38Z1uRaUJ4RT/QuYt7knAT876wNiksfxGKH47A9zDJXLG/NUP8Bmhq6TDoDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768892575; c=relaxed/simple;
	bh=qCYvSzbUA+0jSMknTFb8Ipcyq4EfW2W6PKurQaRuwhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tznsN0L/dpdZx6jwnvTX97vIiVXjXiachuljzEYNDTH6WH/YpHD/axjvn7H7eQushq1YsMx15+sSWLDlSG5SRwVlIC3v7OcIjDbJRcJW/L2zKQesFb+tm82/h2Ui9cKi7JBNMJSqIjkdiwbIbW7u0acM/J1UJISC7joDX4Q0HZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjaWyeAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69011C19424
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768892575;
	bh=qCYvSzbUA+0jSMknTFb8Ipcyq4EfW2W6PKurQaRuwhQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cjaWyeAVzrx8/G5cx8wMWCY1Ks1b8mrr63QZo+0dl6pcq5n83eUX8FgID1LB66TT6
	 IJ17fKzWLAyQ7OaZ//1w8UAclHklvAto5ujmvVnDg76QtloagxvhW4znD+GcubpQrE
	 Z04Fm1AUf1v+q9YOqQSp4CBJlhXnJbFsbtD8Q5Ex2ikWIYG99du9pTabJPksC4dyZo
	 jr5G0L02DyhiWeAVlJpR2lPz+mHxn8IYOplRteT68Nlko5LoSB0DEu20IbgYLy3gAH
	 K9ib9a084LoqStOEMu+VijeljNgb2tleztrFjXJ8NKbJc5ANKctnNIwYX9wkPnK/Df
	 5//mTJLX2N9/w==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b87cc82fd85so321778266b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 23:02:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU41tPpSnZvgSdE/MTmo0JO1zEBlO5Lmw6CPK6HG0JH+MjFqldOGwJxEzhCWfFTwa2o4YGu48vVINNXJIlW@vger.kernel.org
X-Gm-Message-State: AOJu0YylGkrxMWjQsFjwzfOXhzdspGs5IedIqLvNGqImHD8j2BF0IRqH
	VoA7jii/1C8HmWGXZAqOqDOCUi19aFIbed7840qokCtQ9wd0rviUldmdTzfFCHyRK1hm0WlFkDb
	DMx9TPX1hiJHfTS+D/VQp/9HMtsVvzlo=
X-Received: by 2002:a17:907:7f8e:b0:b87:2e44:a2cf with SMTP id
 a640c23a62f3a-b879691c762mr1147715866b.23.1768892573970; Mon, 19 Jan 2026
 23:02:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org>
 <20260116085359.GD15119@lst.de> <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
 <20260119071038.GC1480@lst.de> <CAKYAXd8R=mPVR_ezDHRZqiKL9n-i5QRuDZnaK+poipBtCJtE=g@mail.gmail.com>
 <20260120064207.GB3350@lst.de>
In-Reply-To: <20260120064207.GB3350@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 16:02:41 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-g_pq4biLmm+_-7DhZaR1EdGPx=kDxjxcYS1w3nthLSQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh1ZGtqUQDjcjiEmllL6tmare48e2DZnUsWIXh_wT-vZ3c8eG7ONAiypCI
Message-ID: <CAKYAXd-g_pq4biLmm+_-7DhZaR1EdGPx=kDxjxcYS1w3nthLSQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
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

On Tue, Jan 20, 2026 at 3:42=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Jan 20, 2026 at 02:11:24PM +0900, Namjae Jeon wrote:
> > By modifying iomap_begin, it seems possible to implement it using
> > iomap_seek_hole/data without introducing a new IOMAP_xxx type.
>
> Note that you can also use different iomap ops for different operations
> if needed.
Okay.
>
> > Since NTFS does not support multiple unwritten extents, all
> > pre-allocated regions must, in principle, be treated as DATA, not
> > HOLE. However, in the current implementation, region #2 is mapped as
> > IOMAP_UNWRITTEN, so iomap_seek_data incorrectly interprets this region
> > as a hole. It would be better to map region #2 as IOMAP_MAPPED for the
> > seek operation.
>
> So basically it optimizes for the case of appending on the end.
>
> Can you add the above to a code comment where you set IOMAP_UNWRITTEN?
I will do that. Thank you for the review!
>

