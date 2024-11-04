Return-Path: <linux-fsdevel+bounces-33625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA399BBA76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 17:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0B31C2131E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963D61C1ABC;
	Mon,  4 Nov 2024 16:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jGuEaHGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749001C2317
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738492; cv=none; b=eui7gfnBSbVFhkmXKReEGFqlom4q8Hz7orB6ggOrEf13tNyymnvRhjWMq6Qe6zZqEFPkOx6BM6fN2137N1u0b4OP7X5hfVhg400gpukIEquhl0GLK1soG0hOC0ptKBU+0wLfA3zncjsBulNUSLQah36/0PMh2X1fob0G6PjDReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738492; c=relaxed/simple;
	bh=lGjaQ5Xw+37UJO/G3qI7xX09rqXHYT2TaXgIa/JhJfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFarw1BOETua8uSpZKhIDdwQOI/gX05bqWn/m9zjCPf/c+6HANWvxWB2rbi+4p9uYgos9JiZE9MyRR5qXXmIJSzFwJItkQdvyVl9Vpp99W2WDJPDjXTiT2WkDGTiceA1la5cwuhH0Hoap4xicZlxJSB3uXJkiXd9Fx1cBl2Y57I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jGuEaHGx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460b16d4534so25839231cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 08:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1730738489; x=1731343289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WQXsgRgZL61fSdftXLtb0TZd60MgNOTbkKPoNO6zHDw=;
        b=jGuEaHGxUY/KHRhV7y335bbHgf4wNZNgIi4lMI+CubWCcgzK0MO8nkyH1A1inQkWYg
         e5E48gROEDXYbvI02NVzLcykOmt1sYqZTrx18I5n3Q1h4mBNB/XwEumg3mALgpGY10t0
         nItEqgvK2/k45lPArdC2KmXPjo/SEsImDnL3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730738489; x=1731343289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQXsgRgZL61fSdftXLtb0TZd60MgNOTbkKPoNO6zHDw=;
        b=hHBGr1KnBTwM7+eM+gwuSdKzhMsoa7NLxLZiNRmlKRlQnlENg/+qdOz639PZU/WtyF
         n4pJGKjif/ZI0ZhxBkbb57gPvQPOGQeIXc7Dj+L9iIC4eFLr8t4S9QmvprqfoouGy0P+
         SwQ7eEt+Zr4qe15tJQRXXfZ1LIfh3JME/1CV74iH3zukfpyCDLkapZzv4PlVQg64hIxu
         exzmxnU2XAhDzyhiaOTcx089cVEsf1mNN+gKL+IuoNZirhN2Ncb9b8rIzZwnNiT+h42L
         IsmYlU2U+74Pj3jYIVZeW3eeMORRxqZBiXc/hlRgX40UNIWpS37zPo5y8H95Gev2iC/Y
         lc1A==
X-Forwarded-Encrypted: i=1; AJvYcCVnMvspDYHFyZnRf6UGOuSsO2CafC66kVIyscOTw+u+FmL7Yi0Z50hwD6kPkEnP2BNpCPqHzApeLggHXaSY@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEDtT7SDqNcdhL/E+R2bNHh4ieJ+tFZdNyCNk9VPgRLVfAAd6
	k9KaVe0KQxPX7gj8pInTJn+TTxVJBpMVJnZPXPrq/hKq6LSj5d/+7lM+XYw30Mbs8RDNPjPddc7
	2DgLuVtjg7fz+b0Mp4uDPpuYsn2zKyldh9D7G8g==
X-Google-Smtp-Source: AGHT+IFVJyReK5bVXzWjO5h35VTka3io1/CmckTKc5iMxvvPQ0EFjpu6oaadbZ1FOjOHvg3W5HyH1GlG8XwoVgibKYo=
X-Received: by 2002:ac8:7dcf:0:b0:461:653a:ea8 with SMTP id
 d75a77b69052e-461653a1400mr332654781cf.12.1730738489030; Mon, 04 Nov 2024
 08:41:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241028-eigelb-quintessenz-2adca4670ee8@brauner> <9f489a85-a2b5-4bd0-98ea-38e1f35fed47@sandeen.net>
 <20241031-ausdehnen-zensur-c7978b7da9a6@brauner>
In-Reply-To: <20241031-ausdehnen-zensur-c7978b7da9a6@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 4 Nov 2024 17:41:18 +0100
Message-ID: <CAJfpegtyMVX0Rzgd6Mqg=9OxqJzrGufqOK4iBU2TSSDrt36-PQ@mail.gmail.com>
Subject: Re: lots of fstests cases fail on overlay with util-linux 2.40.2 (new
 mount APIs)
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Zorro Lang <zlang@redhat.com>, 
	Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 11:30, Christian Brauner <brauner@kernel.org> wrote:

> One option would be to add a fsconfig() flag that enforces strict
> remount behavior if the filesystem supports it. So it's would become an
> opt-in thing.

From what mount(8) does it seems the expected behavior of filesystems
is to reset the configuration state before parsing options in
reconfigure.   But it's not what mount(8) expects on the command line.
I.e. "mount -oremount,ro" will result in all previous options being
added to the list of options (except rw).  There's a big disconnect
between the two interfaces.

I guess your suggestion is to allow filesystem to process only the
options that are changed, right?

I think that makes perfect sense and would allow to slowly get rid of
the above disconnect.

Thanks,
Miklos

