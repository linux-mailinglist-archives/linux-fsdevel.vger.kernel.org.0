Return-Path: <linux-fsdevel+bounces-70598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D8CA1B0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 084D23009FF0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 21:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144432D8396;
	Wed,  3 Dec 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JopjRNVf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57882BE7B4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Dec 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798018; cv=none; b=raZkmrxyWi+tFz1/oaRRjxj34FnAjnGuFRI7WFGocK8nr5bHLV3s78qyI5k25rMJzhpkkSCCngfZAu5tFbCdO1WptGTEO91E3IOA8NWVJn2v2/VIE7tzXYd0zj67fVKa92Q08nwPKVDaLFz1VblAUo/VH2lBDqP+LXYAOdV7zKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798018; c=relaxed/simple;
	bh=4mv07ydDIBDY+yYYyDcrBWUbY7+M8hTG8ElX+6UDZ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QpQ0sg3a8qRcwdjReOrm578pfgcX8KeOHAiaTBzBnduAA6REQ7UdViWR+A4AxA32E/xY9gj5JsYhB7x+F8JV7UOKONlpKUK5TdEfa2kxm/ViCZqXSXdSezJ6nonHSbZ4R9/1xT/MBRxff+3r4A+k1/3KHClSOsrrFkalfidCNqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JopjRNVf; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee05b2b1beso2379591cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764798016; x=1765402816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=JopjRNVfU98l9It7LMYoUhECOIZCRNVLf0qZlNdpSwpW5jgp0T66PjPIXbWyNoPj++
         3SRcvNaHbMhd9kwusY/dUlBn8TC9ba7eAsfXVOI3qceQQJHvbOCFy/gq913qo+/ewSb+
         RGaF66b1947U5FPdmNczKYBuMREq7O6Sqq+ja3EokwUNNVE1xQOcrehoouzmKMJhj5Gu
         T3z2VluD5UyRB7LdBzOwQlGFlZT0bivIkXWtnJ2s74Ik4tUlm+la5i4S+XN4FpKiylhK
         x70cgbsdtTJvSjd+jzS6OEU5bFS9B9ejKTcTBuzzG/V6T2fdyEFcrezEWyjd2eAfiq9g
         Ifcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798016; x=1765402816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4dm3yP8EhvjXM7HY/9hUsT4foK9V8lDuxE0CKRUWT0=;
        b=XfbLhQlU9zzVA4Y5Ovr5KbnRCDQaxgbXdVfhYqwfyfVv/DYOOR7foVbjR1w7LBOD6P
         +z2OFN2Ds7k03AIw6xptJVhHljxN9nVDDkqaydBZcsq50NA7fso9+rFAharHWX+D4htB
         lyfwFTSeu5CR8tZOb1gbN++VTlIEb8RUmA8LgKiG8tVVRsGMvusRETgvKZAv3bIzxa9g
         EkNfJtCwNhq5coh/tLtfm8cxgK7eongPUw7fxAGPHIeDazFAd0BDZi6eaCRU8wfUxfXy
         Nd16rZwTtfsjjdTWhEYNZ8CDE/KdIr3cCSkNKUqbNurwZdGcRbWdoxWsYq/HUl0QhJ1F
         Lauw==
X-Forwarded-Encrypted: i=1; AJvYcCUo5MZqX76maETCAAPlzR9FHEfmXkF2OBBXTRWWqOdqtmbwrsfvukK5C6bO8zTpjxMEpp0nsmsCRKgp0pXA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2csEbN0Vb+TaVdCZT7D9fJD2Lr1vkZaU+fbVc+VfEHR6GYncv
	/IMnx4ZMIiJ/6+U2C6q00ia+bmew1dt9NtLgnldSEFlWd2AP4OLyvx37GhP6qfWQxqov74w+6w3
	bQIXJMyJ+sL+IPMoC5GU5OoCaKCPEohw=
X-Gm-Gg: ASbGncvUY9BFADZRk9ECZApwVAy4Xj999OAhC+efYnPDEWHW5yV0wh59DZgBRFf4ywt
	7dM/Wi7NbtCSQl9fXwHoE5xELh4DH3Iy6uYRzVs6+veX8EzmcHsaIYNzZlYQ4iXSmioDk9a2K16
	zzs0K0YlmPtkmzvkH0AcVuidF6ybbYuugTUJByysXuTep4wBvGED/ln0qDYa+0/rTh/TTtnKt5p
	JfFOUY12yAAx20NfvH8tFsG+y/OxVIrSXBECaZzxPwWFZWYKQbisMMVcPzV5kDpZ0ugO4l7QfO5
	hPu36tePhJXBSuMDPUepxIj9DvtN07jb5XPtZh0NSY2nggzRzQY5Qc+3zg3Z+g071WL2XdOt7qH
	A19NkpXsf68XpGxCVtq89O8JgRGF9YbEwR4ZpgQ0qpdIy3/wOGtt8g2uIP7ay0YAQai6RVcIt9K
	mS9VJr4l4fKQ==
X-Google-Smtp-Source: AGHT+IG1RqtM4CjFZIoV9HQ/AGJf69t++XxRfMRR9/KEWXX168CW0sh0DFIGvs6Sts+Nzs+IjWJ+CH1r+PDY8raGX3I=
X-Received: by 2002:a05:622a:188e:b0:4ee:4a3a:bd10 with SMTP id
 d75a77b69052e-4f017691727mr61297771cf.60.1764798015667; Wed, 03 Dec 2025
 13:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1597479.1764697506@warthog.procyon.org.uk> <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
In-Reply-To: <0cf36b63a8f7c807a785f3cbee41beb2@manguebit.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 3 Dec 2025 15:40:04 -0600
X-Gm-Features: AWmQ_bmPZtnFFmlM888CIxDrVHAGDo88ZyE8SdWbeAXL99pNPNJhCXfBTmmIgG4
Message-ID: <CAH2r5msAgsWfnCt171TcmhvCw39GtQ8nU8SwzrVpP=xw2vGypg@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix handling of a beyond-EOF DIO/unbuffered read
 over SMB1
To: Paulo Alcantara <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 12:03=E2=80=AFPM Paulo Alcantara <pc@manguebit.org> =
wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> >
> > If a DIO read or an unbuffered read request extends beyond the EOF, the
> > server will return a short read and a status code indicating that EOF w=
as
> > hit, which gets translated to -ENODATA.  Note that the client does not =
cap
> > the request at i_size, but asks for the amount requested in case there'=
s a
> > race on the server with a third party.
> >
> > Now, on the client side, the request will get split into multiple
> > subrequests if rsize is smaller than the full request size.  A subreque=
st
> > that starts before or at the EOF and returns short data up to the EOF w=
ill
> > be correctly handled, with the NETFS_SREQ_HIT_EOF flag being set,
> > indicating to netfslib that we can't read more.
> >
> > If a subrequest, however, starts after the EOF and not at it, HIT_EOF w=
ill
> > not be flagged, its error will be set to -ENODATA and it will be abando=
ned.
> > This will cause the request as a whole to fail with -ENODATA.
> >
> > Fix this by setting NETFS_SREQ_HIT_EOF on any subrequest that lies beyo=
nd
> > the EOF marker.
> >
> > This can be reproduced by mounting with "cache=3Dnone,sign,vers=3D1.0" =
and
> > doing a read of a file that's significantly bigger than the size of the
> > file (e.g. attempting to read 64KiB from a 16KiB file).
> >
> > Fixes: a68c74865f51 ("cifs: Fix SMB1 readv/writev callback in the same =
way as SMB2/3")
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <sfrench@samba.org>
> > cc: Paulo Alcantara <pc@manguebit.org>
> > cc: Shyam Prasad N <sprasad@microsoft.com>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
>
> Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
>
> Dave, looks like we're missing a similar fix for smb2_readv_callback()
> as well.
>
> Can you handle it?

Any luck reproducing it for smb2/smb3/smb3.1.1?

--=20
Thanks,

Steve

