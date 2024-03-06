Return-Path: <linux-fsdevel+bounces-13749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D828187361B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68504B22792
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13180025;
	Wed,  6 Mar 2024 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lPpeLpIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E332A7F7D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727204; cv=none; b=Ovwhmu1AaXf9pUYNan2da+CUW/63mp8dxpCGzgzrUE07LiaFBQodWSyhESxljoKxyBIFrxxk48ROY8eBJjNT5GSF5j9YqfdGnS20r/1eQ5sf8pWmNaw2l+fHmB6sY4XU+ZkHaXTOqGfVHXvlvcc5DW3eTA6On5dj7qcc93zg9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727204; c=relaxed/simple;
	bh=H+MzgpY+tAanIIlftqL+8bpbf0u2UMTrHzgUwzfiROU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1eRKHWIQtaKkO7x3LbY5FWLZxNZeDAW8U7bB9IidarvuITdE7iWi6SDz7w5mZ13dXwBPMqCu4ehWo2BRQTF+VekI4HPMlY+LNI+3dg6kl3ZDKFdQ9GzNItrNxuBijtDlgFDSg5AGSzKpY++OtklNCmsjAUu2pV8ZLJtL6M7xyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lPpeLpIP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso139654866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 04:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709727201; x=1710332001; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QQZacEgMgFomm//qLsSeT4RBcBNDsL2iqXN32j+XgH0=;
        b=lPpeLpIPYK9mTXjTQFCXfQt3IRIDsbLQ9khySk6OGEfapo7Dmtv2l7+34892QFHUn2
         j3eJs2FWYU2yNAPemwS1Kd9UHZPZpoNmEYA3/jV6oTv5QGrJILb3x8K3F1GKshUZOxqT
         i61GTtbGb+j33sFXTX46Z5ej8w9gRlMi8aMsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709727201; x=1710332001;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQZacEgMgFomm//qLsSeT4RBcBNDsL2iqXN32j+XgH0=;
        b=K/mKMEKtfZO7AjM20yipeJIC/I2eGF1ylgphxrB8nHxwkBS0Y+uT1nT23CEi/JG+gU
         2M6XehS5C9Mx+BTbUFy4uQyUJdyZRSyU6Z+dSecwVmXhReYeejlpVNCLatX1p+sPPKGl
         uARbtIUf6BPOMWIB1Fz8m2LNdFkj8iQK7lWAxm+QQQR2D/mzlm9NuFjgtxABZITCJLR4
         o61waP1dpHgEKDbnZanW/Xp/QsTs21V7+eNGy+EcUeV4Z/R9T6XCgZ+og0KAe5iFbt5E
         fVbmKe53tByjpzn0Aq5q6qb5rcpPVTk87/YEn3hKK0C9P/8qTf0J9QnKbbqna5Ctc5o0
         IpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXCsokYNM3xRFSYy9iAsLGIsznyP0d2iIWcdncCkLMfwe2s/P9RYF+q0TSATGpb462tBlQ/CHUs4VzJhqjFblhiy8wyGiOq2fhEEux9g==
X-Gm-Message-State: AOJu0YzfIMW3Gf5kXkiIi6f0ab8djhIUkTSEp4WS8zK0pOqeKXLw1Dju
	Iz4fBTd1/FJG75qYU/9y/jKOVoyqBHLNZrHNewmnO047Ip5brcuQsZYy3mSMdZFa1FopStjHm1G
	VxNEdLbTrN3l63wvg8JgOm/4ORvUUmedNWdZ7Rw==
X-Google-Smtp-Source: AGHT+IHKt6qdyF4tyL6RWpbtBogG4/XX5c1z8Cf67kGZBeeKjqsNrH/I6jx8H4WC7Wkc/PmTl57+d9qtGbJ+Q/Q8UEc=
X-Received: by 2002:a17:906:35ca:b0:a45:29f3:6cc8 with SMTP id
 p10-20020a17090635ca00b00a4529f36cc8mr6223622ejb.8.1709727201307; Wed, 06 Mar
 2024 04:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com> <20240306-beehrt-abweichen-a9124be7665a@brauner>
In-Reply-To: <20240306-beehrt-abweichen-a9124be7665a@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 13:13:05 +0100
Message-ID: <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Bill O'Donnell" <billodo@redhat.com>, 
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 11:57, Christian Brauner <brauner@kernel.org> wrote:

> There's a tiny wrinkle though. We currently have no way of letting
> userspace know whether a filesystem supports the new mount API or not
> (see that mount option probing systemd does we recently discussed). So
> if say mount(8) remounts debugfs with mount options that were ignored in
> the old mount api that are now rejected in the new mount api users now
> see failures they didn't see before.
>
> For the user it's completely intransparent why that failure happens. For
> them nothing changed from util-linux's perspective. So really, we should
> probably continue to ignore old mount options for backward compatibility.

The reject behavior could be made conditional on e.g. an fsopen() flag.

I.e. FSOPEN_REJECT_UNKNOWN would make unknown options be always
rejected.  Without this flag fsconfig(2) would behave identically
before/after the conversion.

Thanks,
Miklos

