Return-Path: <linux-fsdevel+bounces-22364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495D5916A15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B401F24418
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC4BE71;
	Tue, 25 Jun 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="D0BPU37/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574816C437
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325081; cv=none; b=VQ0lh3HX1fPyhA8Vb+t0UNa38yCsCHkGwgoPHnu1hnshY3OxWZTgtTf1f5nT2sVMtsdWZ/3PATBYaIrGsGRjMLXq1HzhFAEyGAZtLtv8dVnfreWo4ZKedZTyqMvFjUbjK9ArDWsTy5L42TPKtXlWOM8VR77ArnpFw6HXLLNA6S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325081; c=relaxed/simple;
	bh=flhR04wwLwq728Hwn32qhwRAtEfaDbaUqRqoiKFz64M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpXWSXZ4FjVd/UqIw4lLPc4XIv0hHCxkuuz8SeXC195J0vumI/jVhKtO+IlnpPva1OOVcz4zhvGQgy4xDNrCCI9TTpAlqoP2ESw6SOliKzvOxd4eJ59hOjotQgdnyt13USxXZjYYi48SLpgnuDJ3ARJmlhfdtZWcHmAdKVMFI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=D0BPU37/; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-700cd43564eso128897a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719325077; x=1719929877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlING8gjdiD01zYrCX7A/o6Z2iI5mQrjCPHaxdU6BxM=;
        b=D0BPU37/xmQRIdrxu8oIpzA/zTUAtvs59GByjmEgqhOibPJRW+Yjtov4Ti7t+IiXsp
         ABnMDmoWVQdCXd9sdjiXUiLoFuJHpZhA7L7rf1jlmtT7poM12yyJIq5vH4/f20RmsZj2
         oKTMmESkT9XhvjExgWXV2jOjqtVH+FTD7qB7JhHnyWhxrK1e97HehDThgbR54noxTwhR
         P1igfTaYMtX6z5zGD6IHghy1yxh1okLiiFlRCqeFruA6FKzSnLLhT2SGfoOdqyXTvswy
         AyBrGO3kMzmSkRCVioeK/fVDeiHLPejlgM9pXQkBjjfVBmhwJ8D0JgPBUqWDB/bZaMgh
         zALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719325077; x=1719929877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlING8gjdiD01zYrCX7A/o6Z2iI5mQrjCPHaxdU6BxM=;
        b=Ly4AglFKp9MkI3yL2xuObs4q4do39ay4YILrIe6xf3xB3eueH6mVHCS445IYU1C0UY
         9LVjUbE4zuFyIRkCw4MyMLEexDixy70AXKmCS6+SPBVwPRdzDxr5yC6u4oJxSPEnddOn
         1LHLO4W/oFlGjIurN6rxvmz5JUvVu7uNFzZ/LedxulFpyHRJRMQdxp2I1K9xYLGoJTGn
         +Q08utOX0Cz7koeTkz7BnbWBkh5cMrm9dCFDkIQdWyCGeq62CTKMDlFLrXODhqp7EM9J
         2SzXrDhoJDR3mUZXNLfkVG53zGiaOlD18KGKainA3Mr6KsWBwOzOedPFqlridIO8gqiR
         ussA==
X-Forwarded-Encrypted: i=1; AJvYcCVJGD7LoDDbnB8qTcOYkk6ZiFSEbdSZlbliGTRuAGUphIvPKyO050dC2dlv5mMwJxDiLzNX5Ml4YYDVkmiQI8A0lODWhABLJbfbpcXEeQ==
X-Gm-Message-State: AOJu0YwKlH/GAobJPSpntd7Cby3wp9pBOHyfwmR1sQoJryOcuJQ9Cgwl
	T58C4q/P3qSTcHIi66l8Jxq9Gn1FnJUzCII6tPZeZ8g51ETaZCpcUnz/QZ1aloM=
X-Google-Smtp-Source: AGHT+IHG3KmkQ6OtmMYfCfQ4Pp3WOFghAqpeGTHK4apDcZQ5JY2OwihJ/0IPT8gJF21r6LZ9jdNgsQ==
X-Received: by 2002:a9d:675a:0:b0:700:adba:6749 with SMTP id 46e09a7af769-700adba689dmr8741304a34.21.1719325077496;
        Tue, 25 Jun 2024 07:17:57 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79c10f8ce1asm3058485a.63.2024.06.25.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 07:17:57 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:17:56 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Karel Zak <kzak@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <20240625141756.GA2946846@perftesting>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
 <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>

On Tue, Jun 25, 2024 at 03:52:03PM +0200, Karel Zak wrote:
> On Tue, Jun 25, 2024 at 03:35:17PM GMT, Christian Brauner wrote:
> > On Tue, Jun 25, 2024 at 03:04:40PM GMT, Miklos Szeredi wrote:
> > > On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:
> > > 
> > > > We could go this way I suppose, but again this is a lot of work, and honestly I
> > > > just want to log mount options into some database so I can go looking for people
> > > > doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> > > > make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> > > > we just want all the options, and we can all strsep/strtok with a comma.
> > > 
> > > I think we can live with the monolithic option block.  However I'd
> > > prefer the separator to be a null character, thus the options could be
> > > sent unescaped.  That way the iterator will be a lot simpler to
> > > implement.
> > 
> > For libmount it means writing a new parser and Karel prefers the ","
> > format so I would like to keep the current format.
>  
> Sorry for the misunderstanding. I had a chat with Christian about it
> when I was out of my office (and phone chats are not ideal for this).
> 
> I thought Miklos had suggested using a space (" ") as the separator, but
> after reading the entire email thread, I now understand that Miklos'
> suggestion is to use \0 (zero) as the options separator.
> 
> I have no issue with using \0, as it will make things much simpler.

What I mean was "we can all strsep/strtok with a comma" I meant was in
userspace.  statmount() gives you the giant block, it's up to user space to
parse it.

I can change the kernel to do this for you, and then add a mnt_opts_len field so
you know how big of a block you get.

But that means getting the buffer, and going back through it and replacing every
',' with a '\0', because I'm sure as hell not going and changing all of our
->show_options() callbacks to not put in a ','.

Is this the direction we want to go?  Thanks,

Josef

