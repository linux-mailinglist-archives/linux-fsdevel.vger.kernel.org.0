Return-Path: <linux-fsdevel+bounces-12997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51F2869E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFCE1B272D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B1143C46;
	Tue, 27 Feb 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8bGr9P5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F9D54FAC
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056953; cv=none; b=Mxzyb0jXexVFSK2pnmCRc9ViFB84op5GVCnc/ePChN/L6z/3VauNF6ngBFfBwI5N9kNZrEy2se1t86z2nY0/89fx4r3dcTz8YyHrt0xYjFHEXPpU3nmHq4bL/1raFLoCpKcB7sIEZo4v+cQvucicD74heHP1rCYCcAbfeO6ii68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056953; c=relaxed/simple;
	bh=W6Yh85Kqh4QO+FplF/iwL97Q9fJTF8yG8r1u6GmFhA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+EBdUbmTtprqQCe9QcS5P7Uj0JeCCashV58V5HNfzdk/H691C0I85CmXokf8SUcfJsXqgS+83xDhB6/xo3SvrnWYKRB7BriR9DKY018CVusU58qfXG5n3ohUvkpC1aB8lfUZWdakrakuIPFxtMJr/0P25LSpdqd54PUFOnih/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N8bGr9P5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e706f50beso579149866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709056950; x=1709661750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IS9XnkEKGp//6JjTXav355pPYCtjFbiml+eyjIEah2s=;
        b=N8bGr9P55hcJhRLOwMMrbJ2PBwXKCJBQTIBrEQWZqq5yKp2WrfUPBn60ewBig6cZZj
         pl3mBPNP2r8jxoqh1LhnyHKS12vQ6UsLNvK1iBJyVDycS/44MKZGiWJfewTkDuGBstn9
         cnr+XOrzlLZPWMG2uNdV90g8fXuaCRcMEHoNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056950; x=1709661750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IS9XnkEKGp//6JjTXav355pPYCtjFbiml+eyjIEah2s=;
        b=ZqUGCzi3R+9RjF2TidoYw8eaaB12hxdan3Gsuva871vk/ThAvkZSn6EBiL58taiJ5s
         5jG/hfyFp7wDub4TL1q58nmtZ12ivWXYnFPmr/hGdl/jm1muE/Yi/CHQz+X/b4F+tXT6
         k48P0RcApwuITMlV27UrJq4iwK4cTiwlOZ9/y0oTrG2GX0vDDG0SkmnUV0ysuReSWG+E
         IFuZDv9XLfAXiozqsNXd6SBqZoeP1BTAhBfZHCDyyQh53SEbtsUmul+loIHdH5Rv7xh0
         kvkwq9lzR9dwmA/r7EyD6UQrMtVG0Od8EBKWBvxFcbs5yO8rSx5Xd9va9XMOOTd4BiZD
         kUzw==
X-Forwarded-Encrypted: i=1; AJvYcCXKBvO3GUkplbw938c/qxHC5mKZvLdRRgP4xg230XdAGhLV36hBjyLjHTe01iFyCFNsvUHHA6ceW0JpbXNdVut0xCanzgo33ragLZ890Q==
X-Gm-Message-State: AOJu0YyD+rB/JzEtPOODizZLfM+tQzztprt2eTANfbO2j2VWc6+wJfld
	bps7XoDxDVvELwdAtyMzIVePXVXCiBpMOq1lBdh932n6oPHcL+N777f75OqzAnvrsX0zaDu2uKh
	3hQZyLA==
X-Google-Smtp-Source: AGHT+IGUjVq8/smzHq8fzI3/6vK5dBMpNLtnKPnapBLXlGN3G3/NTCEeWyO0uO9db0xnEVCgzxAUMw==
X-Received: by 2002:a17:906:454e:b0:a42:fb31:7463 with SMTP id s14-20020a170906454e00b00a42fb317463mr5436700ejq.25.1709056949859;
        Tue, 27 Feb 2024 10:02:29 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id cu16-20020a170906ba9000b00a43aa6e3f4bsm858429ejd.44.2024.02.27.10.02.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:02:29 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so8139250a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 10:02:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUn+YgQtpG15nHbIZtTaWKCcs+L/+ARLoanoKkoYlVSGFSK9/bq8ncht+2k6uornKWttmUZIcvrZ004yJlc12618vrMxApjixNcQyMoGQ==
X-Received: by 2002:a17:906:d04c:b0:a3f:adcf:7f58 with SMTP id
 bo12-20020a170906d04c00b00a3fadcf7f58mr6925951ejb.21.1709056948649; Tue, 27
 Feb 2024 10:02:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home> <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
 <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
 <hnmf36wwh3yahmcyqlbgnhidcsgmfg4jnat2n6m2dxz655cxt7@gm7qddu2cshm>
 <CAHk-=wii2MLd3kE1jqoH1BcwBBiFURqzhAXCACgr+FBjT6kM6w@mail.gmail.com> <ti5zair3y4v66udgaqsvswl26t3wygdlwnfpyliuwgtdvpnjl2@f2f22qositjr>
In-Reply-To: <ti5zair3y4v66udgaqsvswl26t3wygdlwnfpyliuwgtdvpnjl2@f2f22qositjr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 10:02:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi+Vcn0jhXqiwfK8eMXUOUqyU-uc+d-ACpZRjBs4SxiQA@mail.gmail.com>
Message-ID: <CAHk-=wi+Vcn0jhXqiwfK8eMXUOUqyU-uc+d-ACpZRjBs4SxiQA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 09:20, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> fio                                     \
>         --group_reporting               \
[..]

Ok, I have to say that my kernel profile looks very nice with that
patch. It all looks almost perfect, and the main big spike in the
profile is the inevitable "clac/stac" pair around the user copy
because my old threadripper just ends up not doing that very well.

Of course, I disable all the mitigations for my profiling runs,
because not doing that is just too depressing and any real kernel
issues that we can do something about get hidden by the noise
introduced by the mitigations. So my profiles are entirely artificial
in that sense (I tell myself that it's what future CPU's will look
like and that it's ok. Then I cry myself to sleep).

I'm not going to push that patch of mine - I still suspect that doing
this all under RCU with page faults optimistically disabled would be a
much nicer model and work for bigger areas - but I don't hate the
patch either, and if somebody else wants to push it, I'm ok with it.

I can't actually think of any real load that does a lot of small
reads. Willy's odd customer not-withstanding.

                      Linus

