Return-Path: <linux-fsdevel+bounces-43292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2808A50B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F744189317E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 19:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0551B253343;
	Wed,  5 Mar 2025 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfGy0pTv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165F24C07D
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 19:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202650; cv=none; b=shWwjuG09EO7c/0BF0KTHbiTkbheXog3Sl1aMNkKRw4pJvM+jWCQhfBG2ujHmTkPAroMyO8cpDHAgxyCuOjXibtV1gFLXAZFZX5r4SxTfMPIE+vh2pwsn9saZ9H+Ic/Mx2cX5IXF8EASdFSJBMNB+UQ/1NHQLkoAMFhrY+CiBTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202650; c=relaxed/simple;
	bh=PGeSuNkaCiXYiJReUmFpejDpVXCPlwD9a+jRtHlbTlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VZwKBzojpwFFX+qV0lg9yOdmXC/VgZRcBxfQmYQ/iKuXEYtBpFf803ccfZrA80S4TP9QdJsp9IEIyiRHBPn8gdHiyn/y5v3i5DFCmn+Uu+xFRpIzyPjjQK+6OPEmk186Bl17eOQF2ttaNhop9hIwdurZM+Y6IeFZHwF18eul4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfGy0pTv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741202648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=knZE1VX+LlwYD9k4fEVN4dVQ0t7bukShujkee3U3hi4=;
	b=NfGy0pTv4MGSbns0n4dkU7YTEwSiEx+YwNP703n1oWnVn7HwSS6r5NrPIc8ATQ5Bic8Tkj
	In4/FnVyb6pDrAGfgvjsmZaI8hb3FgrvGc7C5LNfM+cXUCU7EYawSo4HA4SCA8XyuLD1ay
	jvoY5QwWE8y9foVhLaZmbX0D+3SoyK4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-NkJ6CGfvNrOAE7cE8CaZmQ-1; Wed, 05 Mar 2025 14:24:06 -0500
X-MC-Unique: NkJ6CGfvNrOAE7cE8CaZmQ-1
X-Mimecast-MFC-AGG-ID: NkJ6CGfvNrOAE7cE8CaZmQ_1741202646
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5235e5b0ad7so1500342e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 11:24:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202646; x=1741807446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knZE1VX+LlwYD9k4fEVN4dVQ0t7bukShujkee3U3hi4=;
        b=qkSzliVUg4SoTJ9Px9ALV3ZRZhMQSKaKUDT48siKflXwxds+ByMcukOsk+nyFh+xr3
         9e/GP2Qe6OSr/69OuGrp8oKix4hT0gurDs/OrKzt6y3nxQvYTh8VFxdgMNjxKYW4rS9+
         rPVx0t1WLKYPAaYgVGokg0oHQEUUZAgC9COHqim+or/PHjMdYXnwK5Ik+ji+5ETQAoWT
         MLdNcLWA6GNmJhNLnHt0ZzWUutJQzX18wSh8IdzwUsMVto8KwAPb0Sy10BRRP8xkus9y
         Lt/H33Mtof76ndeb/L3mlpC13x5vjSpzT5aOEvPZjEIjtwTvNgRwGU5vA0fOA7wJy/C3
         aRsA==
X-Forwarded-Encrypted: i=1; AJvYcCVzmh0UTmXp8hWF1/UQcHjziDxIKkpbv0vUn1bDJyRPhpV8o1W++Fj/FjTruBzlhp2030bzwEtOE7WEtQ8d@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZvm/2rK7bl1heDSbh/bIWtcJk91iQ4u3niFo5FkalUVPYdt5
	ANhQotba0aToNuLnDDHYu2Q7t657lJrqqRmghu6QXHt10WpBgwRk5Qy8NDWTwfyzAxGAUz8Ci9l
	qMs84hek6StnYc0SwyZr/7vPelyn76b+StwwdMJAUHYUPcSlInHhLV7/OpUnuTLo/kQlhEykqCQ
	Z1bawp9CtbUw91aPjQ90XqYKHPRtLMoFtD1P88Xw==
X-Gm-Gg: ASbGncve/qhdwcxbL+bxHEeKlaz7GfkW+Vyrm71j5YqiVpHSZ875viw8ygJyLcWK/Zp
	sbEqDAx/OKa03LONttabWbDWk5O7mxKj8nCaK1KoMyJTLUicyYN2GjMnFKbA4r5LsLa4pgxMq
X-Received: by 2002:a05:6122:3a10:b0:523:8230:70db with SMTP id 71dfb90a1353d-523c62ef265mr2725084e0c.10.1741202646057;
        Wed, 05 Mar 2025 11:24:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3g32K+cbhNW7iVX+BsPrKqMNOPY4L66SSlI3W9yAkZWTctbmFOpxZr/0ZgMB7Kc1qnOuYLn53Bhz3Tc0DwAE=
X-Received: by 2002:a05:6122:3a10:b0:523:8230:70db with SMTP id
 71dfb90a1353d-523c62ef265mr2725075e0c.10.1741202645711; Wed, 05 Mar 2025
 11:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
In-Reply-To: <4170997.1741192445@warthog.procyon.org.uk>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 5 Mar 2025 21:23:55 +0200
X-Gm-Features: AQ5f1JrxIznBL-H4czil5nVa1bIf7k0sarUmH9VATGhIapwAUaeW1UBogidw-y4
Message-ID: <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: David Howells <dhowells@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Gregory Farnum <gfarnum@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's a good point, though there is no code on the client that can
generate this error, I'm not convinced that this error can't be
received from the OSD or the MDS. I would rather some MDS experts
chime in, before taking any drastic measures.

+ Greg, Venky, Patrik

On Wed, Mar 5, 2025 at 6:34=E2=80=AFPM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Alex, Slava,
>
> I'm looking at making a ceph_netfs_write_iter() to handle writing to ceph
> files through netfs.  One thing I'm wondering about is the way
> ceph_write_iter() handles EOLDSNAPC.  In this case, it goes back to
> retry_snap and renegotiates the caps (amongst other things).  Firstly, do=
es it
> actually need to do this?  And, secondly, I can't seem to find anything t=
hat
> actually generates EOLDSNAPC (or anything relevant that generates ERESTAR=
T).
>
> Is it possible that we could get rid of the code that handles EOLDSNAPC?
>
> David
>


