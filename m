Return-Path: <linux-fsdevel+bounces-46571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CEA90784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 17:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA3E3A8C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A6207662;
	Wed, 16 Apr 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QMvzZYDU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF3189BB5
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744816712; cv=none; b=EVKNVHf0D/TcxcJiGD5PaHfxAqHqxtaBiOcyLJGJIAuc4Wl2ET+voZtjpn3I/1uf+R2q/o/8aUDtVCJj/CH2kSt6pky4r8hnjEINqDTBzeKOFgBb0LK1Jc5cbNV5waKwDXR5kOGIJSadCFt7n2ZmUlUh5nVAtEQtS/JELjF1OcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744816712; c=relaxed/simple;
	bh=hnYAbQJl7AeIsH9TFmn34UEt3j+l1Tlk7jmWCbi6Igk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeS4Y570KCZvFP9PTEFOWTa8lRc6eK1lQ/BQVISA7Y3PcdJAIruIn25f8nkVEOmDTY8v4x+IUH+mdU+DxH9YRaXwKQ+zv3Ad7/tHYc2T3Z5SGgF48jscrGwb9uBVmjqvwyogaIB+plJ3DMGox6Qedj/hY4dNmqo5D8CfRO8YP/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QMvzZYDU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47698757053so78213721cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Apr 2025 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1744816708; x=1745421508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RSnElck7j9Rb1JtCFr3gqGpxq94ZwI5eQbbLB3nHE8c=;
        b=QMvzZYDU5ZFb+nRCAe+x4Bxo4FZyfOiRbCSEcWCOVBiUAH2A3H47vNH4fMpE6///hp
         YJJrQzXWzPKcsJJq0rc0VYyIpZwT8RJKrS8MACcsxjzIE48SMwsbGPspVACoVQetVCSD
         wmKeEaIKcFYjZyWD07D8cj35dnrUi0FOfa+5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744816708; x=1745421508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RSnElck7j9Rb1JtCFr3gqGpxq94ZwI5eQbbLB3nHE8c=;
        b=QqeURnfugvHLqu4HccKP2sxT9GwWT51Ykg5bx7cwo66nB1ILPtnA+YxndalDctBnFi
         z/GhS4/xb4yDdiS83T8gMj1Kkaa+YT6DEbJSFOH524PhA+uDbaMx0lXe73hOgGwptPlh
         QCPgD3Ip34VFVluSrg1z8nrMtYmsFqxnLuFcpPZ2nYxG3FdHqcciuxD+PdMzk2CcWtcb
         VtPgaGRAvy7dy7W4dGtfIvesHwoMHI5yUU9RDkl/jrkDcqf4FDyPbTdkTYM6RrWMCio7
         qvC03lhurcd0ulwuum+iNxdDmHE9t/rcUXLwe4TzIEbNKzMu8+7C7xlbGqSFz+M0Dz8n
         ijTw==
X-Forwarded-Encrypted: i=1; AJvYcCVxwOMjfUdv+EJHo33RaCiD9gRySxd78UIIzRnE8bx9c/DH6vMmfuiUblyfWylwP1oKeQydndEPakUBkqOM@vger.kernel.org
X-Gm-Message-State: AOJu0YxOPNfTS1M2qjCqXH6m+GIjqNM5ah/V7mvOFK3LMa79cOaFLQNq
	wDj2uDRfJnLxD7RmZLAD9WQd2q2i5cwfaSrfpMBV3CtIC4Grj5bXdQgcM4V8X/ZEHdSV03nn60R
	AZOlAAkPmo/BicVAPl7IiK0e2WrXuLrUf19bgQZbu8WTSDaAWqOA=
X-Gm-Gg: ASbGnctn531TbCRf5nJO71lDDA2TPcT1sVSuzpARTO4tzHEbL8HwcPHch/JSaprB783
	lt1ACyB70ENTIu6Sq6tegWxB4dtK7QcPvf9xJ5lGBhKs6BxUE67qeD3tLlzhbyk5zFuoa8YS4PL
	0o/CdeOHa9NI98AhA+U9Q=
X-Google-Smtp-Source: AGHT+IEBbhcMgIyWEBNM3v0aoBprEPgkkstTL0/ARboxp2aA6bp7SbxNyD5mX68mo2XE3bSdCo1EMJyhRis6yAlUhk0=
X-Received: by 2002:ac8:7d15:0:b0:477:6c0e:d5b3 with SMTP id
 d75a77b69052e-47ad809877emr29187611cf.6.1744816708595; Wed, 16 Apr 2025
 08:18:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner> <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org> <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
 <Z_0cDYDi4unWYveL@casper.infradead.org> <f619119e8441ded9335b53a897b69a234f1f87b0.camel@HansenPartnership.com>
 <Z_00ahyvcMpbKXoj@casper.infradead.org> <e01314df537bced144509a8f5e5d4fa7b6b39057.camel@HansenPartnership.com>
 <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
In-Reply-To: <B95C0576-4215-48CF-A398-7B77552A7387@dilger.ca>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Apr 2025 17:18:17 +0200
X-Gm-Features: ATxdqUHM2qmBZUcuEFoacXsyLy_DNGaXM6AucRqQvSfPeq90Aq2CeG6FiA4WH8M
Message-ID: <CAJfpegtchAYvz8vLzrAkVy5WmV-Zc1PLbXUuwzxpiBCPOhK5Rg@mail.gmail.com>
Subject: Re: bad things when too many negative dentries in a directory
To: Andreas Dilger <adilger@dilger.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Apr 2025 at 19:22, Andreas Dilger <adilger@dilger.ca> wrote:

> If the negative dentry count exceeds the actual entry count, it would
> be more efficient to just cache all of the positive dentries and mark
> the directory with a "full dentry list" flag that indicates all of the
> names are already present in dcache and any miss is authoritative.
> In essence that gives an "infinite" negative lookup cache instead of
> explicitly storing all of the possible negative entries.

This sounds nice in theory, but there are quite a number of things to sort out:

 - The "full dir read" needs to be done in the background to avoid
large latencies, right?

 - Instantiate inodes during this, or have some dentry flag indicating
that it's to be done later?

 - When does the whole directory get reclaimed?

 - What about revalidation in netfs?  How often should a "full dir
read" get triggered?

I feel that it's just too complex.

What's wrong with just trying to get rid of the bad effects of
negative dentries, instead of getting rid of the dentries themselves ?

Lack of memory pressure should mean that nobody else needs that
memory, so it should make no difference if it's used up in negative
dentries instead of being free memory.  Maybe I'm missing something
fundamental?

Thanks,
Miklos

