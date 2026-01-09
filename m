Return-Path: <linux-fsdevel+bounces-73086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5DD0BFD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB7D1301AAA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662742E54CC;
	Fri,  9 Jan 2026 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CVEY5viq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C32D7DF3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jan 2026 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985302; cv=none; b=kDAL2VNBkqgn+cqWlb/SnYcKh+o1+yiZtBcYRXoo402ZJKqRFMBqCCtEJpb217HrIMKKUn7f83WTM9uXZk7E4qVyNdwMjXlPqJovEVJMHlul5SViXvJxBNb3IXSEsJr93q7/Vt+Bi4cwvGgwWWerx012kQVosIm0R1opmzMArQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985302; c=relaxed/simple;
	bh=RXAfWazsfNpfxnumBTzfrjBsn+6Mk/B8hbEQH1slqB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KmEZ6uNXrMcFxWqOhOkASB6t/IyAMgr0csN3pMrg3q9PuMYhyzNOgP8PEfWqtZhsbbESlJqst3my6BaQ7R52EdeiEKFPu+PvC4um0g/xyrAEMWcrKJxMm+8x7WMidZT7W4YtuIpddrcb8PfABNJzKrW2WovW2Ui22qkKuiwaeoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CVEY5viq; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4f4cd02f915so34040951cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jan 2026 11:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767985300; x=1768590100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtmpCK7gCswkz81mBtENwSc3S5fxYBweAqv18WlYRHw=;
        b=CVEY5viqo9dU8Mf2vpRHQCMj3EThEphd0Bcu1qNQaijZxzUo4zLEPiUvUZTam6BgU/
         wh3I037okGL9+AaZfOpR2MhOEdX3Ucvgce9A/9c4avMVuXciElxeiLSVQUJOgPZnb39l
         rELxJhw0kJNlsWgZDmPUKwXtHArRZAW3T3+jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985300; x=1768590100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtmpCK7gCswkz81mBtENwSc3S5fxYBweAqv18WlYRHw=;
        b=u685MS+h3xEg/qAZgT82GCe9FfiDgzo364fwYHw1I9ro31Ts6llTBuBf97fhK2LOqg
         WP9LgTIRwUwaF1vMbF45jUX7ZDUw31qNNepAAktFZuknfFqviKuoQw1Yim7H3MaA3oVj
         xAtFVSYIFAXy1M3/CumS8axONhoyyo5nwUfWqU1kbqIZeTlvEl8EHGM7W7tJzRpQhl3J
         fZo5EyL6n9f+Uy0NMQXRP/F6LBTwyxM4Cwk5QVJ25JFG66/S+/r0CMMjiRzaFCss8iGD
         OEtZpQZkU74nuAlBBB6uqeNOyTxMfE9X7jSahoVMj78zcI0BkeipRtUsVXm1pRRi0WoQ
         FWog==
X-Forwarded-Encrypted: i=1; AJvYcCWP1/ux0/EAOPh5bTUgvh98WvfzMpc03D4KKtMNzJvKDgUp+AS06hRMNA1EkF4kQqApITnJ/ic3356wAoyc@vger.kernel.org
X-Gm-Message-State: AOJu0YxfLpbWXTXunMuwxzvlFE/y8v+oSWfzHvLCijRGCiIcSeGOwtu7
	FGOvCG4bfSPbkenL3F3I6jJoJmX4sfYgoPPMSnrzS4+e1+hFrX/VidkTQBfHhy2rchgRsjT81qV
	SQA88kWLPxgrnghHs2+pJregptmSg6+Zw+w0FBaZDgw==
X-Gm-Gg: AY/fxX49bp5YPMvgHSwoR37jYcj26VjKy1/m+2V9jfS8eE5IHJwsImEk23HcBRdtT0e
	sXNAIohSDP8kV15VQe3aBfybCYNUXbUoan5Ke9iynXPw0qDTB0B6q1ugCSJIJv0LKGaTpSEQP27
	+JE3oDg47icjuTMzN4+w+DGhOKyDbfnjXlXAa70IRMtWzN4nZd82P0rGeEy2+cxqXjTbsx0q7yz
	zz1Ak1WFMHDd2/1tS6VtGaP78GTJk4SjFsfddzkfNDmWNGyVb59vaMkQi6CEwdN+NXa1VSWavfW
	2Fo=
X-Google-Smtp-Source: AGHT+IGqqRPBH/YiskRmbrhwXn3WpUK+1KWTJEe6VxCngwcsJg9baSxoreyzoYoQ1d4HoEa+8XU3737wui2cHZe739Q=
X-Received: by 2002:a05:622a:858b:b0:4f4:d92a:7be9 with SMTP id
 d75a77b69052e-4ffc7155af9mr78548031cf.16.1767985300153; Fri, 09 Jan 2026
 11:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
 <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
 <87zf6nov6c.fsf@wotan.olymp> <CAJfpegst6oha7-M+8v9cYpk7MR-9k_PZofJ3uzG39DnVoVXMkA@mail.gmail.com>
 <CAOQ4uxjXN0BNZaFmgs3U7g5jPmBOVV4HenJYgdfO_-6oV94ACw@mail.gmail.com>
 <CAJfpegsS1gijE=hoaQCiR+i7vmHHxxhkguGJvMf6aJ2Ez9r1dw@mail.gmail.com>
 <b2582658-c5e9-4cf8-b673-5ccc78fe0d75@ddn.com> <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhMtz6WqLKPegRy+Do2UU6uJvDOqb8YU6=-jAy98E5Vfw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Jan 2026 20:01:28 +0100
X-Gm-Features: AQt7F2rUvgHAvXnp-PJXpiqlEU3Kn_pbqhJnZH4nyKhaknWWeUywVYkKpDO0pW4
Message-ID: <CAJfpegsLPJ5B_A34qP-3nXrXc7v2d-QpL3rkGS5rMfGq0g+FCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Jan 2026 at 19:29, Amir Goldstein <amir73il@gmail.com> wrote:

> I thought that the idea of FUSE_CREATE is that it is atomic_open()
> is it not?
> If we decompose that to FUSE_MKOBJ_H + FUSE_STATX + FUSE_OPEN
> it won't be atomic on the server, would it?

This won't change anything wrt atomicity, since the request and the
reply are still a single blob.  The reason to do this is that the
interface itself is cleaner and we can swap out one part (like we want
now with the file handle stuff) and reuse the other parts.

So I mostly look on this as a trick to make the interface more
modular, not something that the servers will care about.

> I admit that the guesswork with readdirplus auto is not always
> what serves users the best, but why change to push?
> If the server had actually written the dirents with some header
> it could just as well decide per dirent if it wants to return
> dirent or direntplus or direntplus_handle.
>
> What is the expected benefit of using push in this scenario?

I was thinking of detaching the lookup + getattr from the directory data.

Now I realize that doing it with a FUSE_NOTIFY is not really useful,
we can just attach the array of entries at the end of the readdir
reply as a separate blob.

> My own take on READDIRPLUS is that it cries for a user API
> so that "ls" could opt-out and "ls -l" could opt-in to readdirplus.

Yeah, that would be nice.  What about fadvise flag?

Thanks,
Miklos

