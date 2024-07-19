Return-Path: <linux-fsdevel+bounces-24023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0125937A1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A741F2241F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D16146017;
	Fri, 19 Jul 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZRj3qP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC94C69;
	Fri, 19 Jul 2024 15:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403948; cv=none; b=ajQLDz6HVtbIF616P3OPa65JgqP/9vjAFIsLGu2+m/FC4r86iKH+OZxfOM6CXAVxqUMRIBQCAxqxJdOG3WaCF15dZqv7eyImo3TicE8p8BJrXtRYT+oPthph98Iz7EqWZhH4AoLTEXH6mfEosjDXGk0nyY+5xPrXmHIJqoetxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403948; c=relaxed/simple;
	bh=yNCcm/QYc7w8zheT+OuyppYaZxLGgvlu6TA/NU2U62k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=adhzXI17BAgP76o/H8Zi1EXOqjqwsbwb7fjaULa+7KnRCF0qJUVQ0Q5RfCsS0UGSn6os3ao4uKsNYktHgA2BmrmxawgGA5VSOEcBwg51H2pZpt/O+a7Sxg5WKTgGVWbFcyqoDEFs47z/X0Y0sVbiio4L58QiJP6V0Edbb7iDekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZRj3qP4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so2010172e87.3;
        Fri, 19 Jul 2024 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721403944; x=1722008744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uqJQihDeCDyfNsoSGpofXtXaBSCbc6LKisKLTktfKE=;
        b=QZRj3qP4LMTPkUkK2FbUR4OjyjxXT1IK+AmHzYgiXjAAWyglnBc+bjysdoU9nznp5G
         qC4Xk3EZz/5JsvxFKjLDLJ+1Eb+lF8XOrU5+UMGm95IWw3t37YCWdvZPKa2GTaa8JhCP
         nLOEeW0zX/1T4lMeER3VWHpcVjljkGivjSS9zEQrvWPiL/L1L9VBvnIUrJ8IQDNGU5SA
         oBR0RonjQc0uSJAzPOY9P8XB/DVHph4mjRVZJ8lorXl8ExVZlSKDk9KW3rr+Dm5kCA92
         JQMCPDmxziwWVTuMyYau/7qCy4SVHGD3m1Bsj4YCsUgLxW+OMQ6RuZotF3pK3Gfd+VEj
         QAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721403944; x=1722008744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uqJQihDeCDyfNsoSGpofXtXaBSCbc6LKisKLTktfKE=;
        b=fmVFIXCQnFN8A0SjvTK4SsKXnZC3Hz8b/jM1T5rB5Vj0dmIlNYGXR1p2QOs6J8i08L
         z2kRpPoHNcTNSEKj/TOEo74+DdGN4i80angkeqrm9Yf5xrKVrME8Ikzp9/t1+4AW9S2u
         IoVHkfK/iVfaN+U3CHufK6NrpmaUy+tr4OLFFjEBDx1zfSCKVgT+Oh4fk8o1KqI9VzDu
         kISO23Ac71Tj9Zpvk2MShvna30ievJycruBnI0xdZvjkIApA8XTiFJrI1dialg3XFM0g
         0bYpioZGeRQzpyearuEsCtH02+iYIG98jwoC+sNeQPJOkukHhLacDff8KD3tt8KhRrqH
         hz2g==
X-Forwarded-Encrypted: i=1; AJvYcCU+nve8Sf6BUQCuHc6E31ZRocJqNyHhxLKX56Lg+EqiP6NCrAuOlfQuqAt2Mt8wxP1tVEQ4/MJ0a0wYGtfPM3kiQVm9DNUtASmXCrWy10miXS/vaHMFhc023BVd7ZrRfEStyGI9DRXHioQ=
X-Gm-Message-State: AOJu0YyIC2EoonAxSQAOoccekafeuZXNYZXn2eMzwVa+oFSs5LtmRHsN
	KM8jVQERqKLfCuB4PRlHeON0XrTfxjtkHFPi3Vno7X5QuWS4BE9/WKD6zGmGv3o87qBrIjWYGZ2
	sW7+UCyjcDN3pdV02PS226rQK8q4=
X-Google-Smtp-Source: AGHT+IGWJkrS4HFCJzPyLLEzo6V7TY8hiw3Xb58MJv0SEN+IdGIQK8bacLLac1hTJTn1eVenvx9WKkM6NPZuwTmXUzo=
X-Received: by 2002:a05:6512:a92:b0:52c:d7c9:fb14 with SMTP id
 2adb3069b0e04-52ee53c975amr6090204e87.34.1721403944119; Fri, 19 Jul 2024
 08:45:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719140907.1598372-1-dhowells@redhat.com> <20240719140907.1598372-2-dhowells@redhat.com>
 <129ce5e2-2dc3-4185-9057-4c88bc02c103@talpey.com>
In-Reply-To: <129ce5e2-2dc3-4185-9057-4c88bc02c103@talpey.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 19 Jul 2024 10:45:32 -0500
Message-ID: <CAH2r5mvnQzhrY1vwmK0iNoq7g73t702s9-9DPyRuxHum6HbxjA@mail.gmail.com>
Subject: Re: [PATCH 1/4] cifs: Fix server re-repick on subrequest retry
To: Tom Talpey <tom@talpey.com>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Aurelien Aptel <aaptel@suse.com>, netfs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 9:27=E2=80=AFAM Tom Talpey <tom@talpey.com> wrote:
>
> On 7/19/2024 10:09 AM, David Howells wrote:
> > When a subrequest is marked for needing retry, netfs will call
> > cifs_prepare_write() which will make cifs repick the server for the op
> > before renegotiating credits; it then calls cifs_issue_write() which
> > invokes smb2_async_writev() - which re-repicks the server.
> >
> > If a different server is then selected, this causes the increment of
> > server->in_flight to happen against one record and the decrement to hap=
pen
> > against another, leading to misaccounting.
> >
> > Fix this by just removing the repick code in smb2_async_writev().  As t=
his
> > is only called from netfslib-driven code, cifs_prepare_write() should
> > always have been called first, and so server should never be NULL and t=
he
> > preparatory step is repeated in the event that we do a retry.
> >
> > The problem manifests as a warning looking something like:
> >
> >   WARNING: CPU: 4 PID: 72896 at fs/smb/client/smb2ops.c:97 smb2_add_cre=
dits+0x3f0/0x9e0 [cifs]
> >   ...
> >   RIP: 0010:smb2_add_credits+0x3f0/0x9e0 [cifs]
> >   ...
> >    smb2_writev_callback+0x334/0x560 [cifs]
> >    cifs_demultiplex_thread+0x77a/0x11b0 [cifs]
> >    kthread+0x187/0x1d0
> >    ret_from_fork+0x34/0x60
> >    ret_from_fork_asm+0x1a/0x30
> >
> > Which may be triggered by a number of different xfstests running agains=
t an
> > Azure server in multichannel mode.  generic/249 seems the most repeatab=
le,
> > but generic/215, generic/249 and generic/308 may also show it.
>
> Nice fix, and good explanation. So, is this the negative-credits issue
> we've been looking to fix? Or just one instance?

Yes it fixes the only recent crediting issues that I had been seeing.

> Feel free to add...
>
> Acked-by: Tom Talpey <tom@talpey.com>

Done

